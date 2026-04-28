Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D328345738;
	Tue, 28 Apr 2026 05:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353997; cv=none; b=aLV6ACHELPnPBL9bkRAXrwL8IU3BsWfq5RjGA7jA3PboiKV/b2jOKUj6+H8KQ3cfJKLpfoMWImODWmp9yanveVVZjXYJl10DViNDqZVwlPkEPsxDkZ1p+w8OZvY7SJPJ4aH2COY9bpUxLQCHl3pK2KH9PIm/HCpQhKdVoMU6niI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353997; c=relaxed/simple;
	bh=bq3gC4SDa9NJv2wNWIJJzCLv/ofuVSA47dA3c9nxxxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpC2FVUaHUhE0ykhxdViEspdZBuJ+N3XjuqpHh3ji8KYlZicCMpLRu/RrR/BVNNEhIxGANeakkeCu8SVgjjztktdH9dP71sZctGo6O7/fLhihNSgAqkM3msDMNcdggqFd9eFzJIbf8Qeo9SfUBJLsjEQ51t9HuAj0a9uXyxU31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nq9zVjBL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nq9zVjBL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353996; x=1808889996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bq3gC4SDa9NJv2wNWIJJzCLv/ofuVSA47dA3c9nxxxE=;
  b=Nq9zVjBLjxQrUGGpizscExphOzWZcSkLN0nz5bJk3OP8r2/vFf2MaSQa
   zsyK+gRaSwc5h07vqHcwSswSUiOHZuUpm7DwzzbRhPIPbDV1Ct8Yii30u
   6cAXnyLciuzMunXCl6dzT9zZ/w5/2KS8FFbax6WjIK/KDV3GkEBXE9Dzv
   X05U3jid+Pdfj7YrIUOblbytRLbpP5kHKKgWhti9Ha+kcUr34RWXuoMNP
   wrGNthgxkdpBRBrOtIwUmZ05BXYju7GLethMN1nPcH3NWLHJnSo0lub7z
   MaTee41hXTZG1bCl47OHcYm7GJWW8NtmEqTmsIiP4mTDc8cUE5+cRUzwe
   w==;
X-CSE-ConnectionGUID: dWHxYEzxTbq20yIqiazoPw==
X-CSE-MsgGUID: 0s5KZu/gQomKv41/5DK3Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131736"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131736"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:32 -0700
X-CSE-ConnectionGUID: yLDY/Bk8SPW1eggc7IbohA==
X-CSE-MsgGUID: ZFnbx9NSSJiyLMT91I7u6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130221"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:31 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 15/20] KVM: x86: Reject EVEX-prefixed instructions
Date: Tue, 28 Apr 2026 05:01:06 +0000
Message-ID: <20260428050111.39323-16-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428050111.39323-1-chang.seok.bae@intel.com>
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly mark EVEX-prefixed opcodes (0x62) as unsupported.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kvm/emulate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index efe8adca1317..31118ae3b6a1 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5052,6 +5052,11 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
 	if (ctxt->d & NoRex2 && ctxt->rex_prefix == REX2_PREFIX)
 		opcode.flags = Undefined;
 
+	/* EVEX-prefixed instructions are not implemented */
+	if (ctxt->opcode_len == 1 && ctxt->b == 0x62 &&
+	    (mode == X86EMUL_MODE_PROT64 || (ctxt->modrm & 0xc0) == 0xc0))
+		opcode.flags = NotImpl;
+
 	if (opcode.flags & ModRM)
 		ctxt->modrm = insn_fetch(u8, ctxt);
 
-- 
2.51.0

