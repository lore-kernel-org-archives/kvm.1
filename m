Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC64779A7;
	Mon, 20 Jul 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569604; cv=none; b=AWziX5jUt/QP8bj5NHag8ysljeRMHxojGuuzyYERNrJmY5NmPW8+nvkuePdC5yeCW6rEPvXNWFbDQi0EY7dQbmSbGTUkiq3fjo6++qliEz1qFuRHwUGCzw4x4guMAwb16tE0V5ZuhiZJiN/ExmHX7Wok34+1O+qfbGeMUfmlZs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569604; c=relaxed/simple;
	bh=K0a43zC/CH1JRV9XZ9iaXKo0MS6XUMZZHsZPAiQ70Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQafnn/o+AVGLn3NugWzzEHzCaQeac8H4hwOFV9CtUb8Y4sqXiV3VTW2T9F/TuXv5CjxgyKNlLD+AmtlHg9tQRM7PpJ9frA9FwNzoHfm0gSqKwn+Ybs2PeZUuwjLnY4kasKupB6uPOfnYf03dim5aWP1uaLOY1VODkzafV3S7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxFMMS92; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxFMMS92"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569593; x=1816105593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K0a43zC/CH1JRV9XZ9iaXKo0MS6XUMZZHsZPAiQ70Pc=;
  b=QxFMMS92OzfaTeesmu4TgAVNeBmGgJXf5AHr3HZ1j8gxosg2oEJlG9Mu
   F7wOqRIHxdKCXrVybiJjEJv5DAksjS3VU9ZzMaQeY//5wpcPUT3l89ZOT
   41QpdSX6Sxu8hcnOpAFphePmvn9zzS8QNZDE8I4R9vJgWdANaV83s/Z1A
   bRqlJ7wEJZrx+bGF6gMC7T4ZVeLNjVJjiZuAfoAtR4tVMY1Yr0ivLlzY0
   gQIbZhO+Q8cOjkUpRkUTh9emrJLdIaBQhdZAQBLUbq4X8CDkuUwgXZLD2
   GFotP260sBMNRBNc3Sl5JGIEslSCll0Pukapjpk6IonoPqDOWh3A1XhAB
   A==;
X-CSE-ConnectionGUID: 2lEmtkh3TM2u1hqDKGDK2Q==
X-CSE-MsgGUID: nT7e92vbQ+iEASTJ+hODmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72691692"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72691692"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:46:08 -0700
X-CSE-ConnectionGUID: ma1vnY4ZTpOHzj8lxS7X4A==
X-CSE-MsgGUID: BHpi7cttTm+BMXpM8movJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257575383"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2026 10:46:08 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v5 13/20] KVM: x86: Reject EVEX-prefixed instructions
Date: Mon, 20 Jul 2026 17:19:42 +0000
Message-ID: <20260720171949.498680-14-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260720171949.498680-1-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
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
index cb075bd74f76..fc7f9f17c1da 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5045,6 +5045,11 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
 	if (opcode.flags & ModRM)
 		ctxt->modrm = insn_fetch(u8, ctxt);
 
+	/* EVEX-prefixed instructions are not implemented */
+	if (ctxt->opcode_len == 1 && ctxt->b == 0x62 &&
+	    (mode == X86EMUL_MODE_PROT64 || (ctxt->modrm & 0xc0) == 0xc0))
+		opcode.flags = NotImpl;
+
 done_modrm:
 	ctxt->d = opcode.flags;
 	while (ctxt->d & GroupMask) {
-- 
2.53.0

