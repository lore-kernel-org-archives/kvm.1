Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E75361658;
	Tue, 12 May 2026 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550039; cv=none; b=sAfwxDkjs9wSH5BHDGYArLlrcOGhvuU4dpXui6f3RS1DOcX72CxOXcPIpc8HKzxPTnL6NELkr0jOvCgalu4ZxrxdjXXLEtWZrERg1BJvQlpU4LpwVm1Xe2Er+WA1DSxuAQAYTkao/0lcmcyfRHuGcZSw641loTH2BUfiOQlV0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550039; c=relaxed/simple;
	bh=bq3gC4SDa9NJv2wNWIJJzCLv/ofuVSA47dA3c9nxxxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNDIMP5cO13hNc+iusv4VJaG2U1w4xPbgYZ9Rg+yrYoAizRICYD907UEZc9ZS9cBBWcQCnYa7Dmi4Zh4q461SQO1UejabW9tncPIKPHXMxM3xP1Od6jTOkIK127up0ICr4+ptCq4QUsPv1+eA5LBwVWsYvXAzE7ityZ6l3vrmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATLaedC5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATLaedC5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550035; x=1810086035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bq3gC4SDa9NJv2wNWIJJzCLv/ofuVSA47dA3c9nxxxE=;
  b=ATLaedC5L7uwBl3Begyx44DFh4fhCa2PDBVlbP6gjb/nEW90a40Nt/1Q
   6tfJpyC7LdnuWyPI/5NnWUrQJ546yVeAkn7S8uENU/DQEqL8mMnPIHrIM
   FtPdCmKNku0WXNxTdiNqxESadDDkTgvV2ZPYRuW6zLeN1v97dK0BCQkoU
   dBx+phU3wyjPgIB+j0EiBn776r3el6U31WyD7OF27WWkfB3xubGgtEccp
   eL1+CrVTOsIsrd0E52hIGar3kE+cASB8QKrznuNaDHw0sCtTpKO9otMej
   JAGAmgpcp3AeIQb4oG5SBxZ9jY4+EGm0eHLxsz1zEBMmD0btYHcB+uBnl
   g==;
X-CSE-ConnectionGUID: KQwLk3xxRjW/LIgU1Cdy0Q==
X-CSE-MsgGUID: k/ioZpV+QyWkwloRpLQezA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322177"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322177"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:30 -0700
X-CSE-ConnectionGUID: nzERAiUeQnSQUJz5NMZWoQ==
X-CSE-MsgGUID: 5Oj/urJ0QBicOaIreLNrsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572821"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:30 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 16/21] KVM: x86: Reject EVEX-prefixed instructions
Date: Tue, 12 May 2026 01:14:57 +0000
Message-ID: <20260512011502.53072-17-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512011502.53072-1-chang.seok.bae@intel.com>
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
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

