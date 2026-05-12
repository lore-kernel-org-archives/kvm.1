Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1382D595B;
	Tue, 12 May 2026 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550034; cv=none; b=jk6bdcVpXORe5UdFrvYHZIGBjtLEVIG4RbtnX62YS+Gx/cz4pW6rt50xwmO9uBhYQRdi0AcHUXFvukehgCwLAKcxU2PlR8RhGNjhRo8qvO4X1FtLA9VolVkpfaHqM9xRJTcnIxPMqMC07VB6HsAdT24a0zYx0pe65lkVRxHIN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550034; c=relaxed/simple;
	bh=nm3CPZ3S4tjIC9q2AAnqfmAqyR/AvkuVysL1Odtxquw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfMM0UxysZK/bFB0O8fqMsaO7VVTez9CIbnQdQPKYf3RC69le/mk5zL0ja7nyZF9ZvRQyeKetcnZEVSS9VOV0cUWipquvrrRj08XGTeQjbMw6r8vt69xoqb1/y5SKu2zljoGu+XDiXZ+OzNWIi3SNcdKxq/zAG7abqUBDFwDTU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvkKILQI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvkKILQI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550030; x=1810086030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nm3CPZ3S4tjIC9q2AAnqfmAqyR/AvkuVysL1Odtxquw=;
  b=jvkKILQImPGtHdWWRfJh15yx48TnEIg7sVlre7vxaLkpLTYmy6B0AfwD
   nhrKhzvca60VzFOoWaS9H9AfY4Sygm7W57zkrA5D6A09Ybazm+tAvNAKN
   fYstpoErapJS2IEkgOF8vBKt5zjYjwR89aqfaWCA3lvLGFUGtm/Kod+ic
   IoI1exs7xh39pOv/vIux69BQQUvnY5ex//vJkdVeLVD951tqnf595Up0D
   7EhKAH3vGGtFGT3ut01Emz07akRj0hC8qkaG3Nb00la7D8GoWitOLEtEF
   ymBOpZgmPSRRipySRgleFlyDDnyGhQ8fMCEu05hgVmcqkKcf5Lk0yjdpz
   g==;
X-CSE-ConnectionGUID: ejQ8/7hfT5yeQBjJZRJRWg==
X-CSE-MsgGUID: M5inW0H0R2yoFF0mGM57Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322160"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322160"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:28 -0700
X-CSE-ConnectionGUID: LI4ATmyjQ0+5xZxmv0y+lA==
X-CSE-MsgGUID: xPz2Cx7BRHajcNj9XXG3hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572804"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:27 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 13/21] KVM: x86: Support EGPR accessing and tracking for emulator
Date: Tue, 12 May 2026 01:14:54 +0000
Message-ID: <20260512011502.53072-14-chang.seok.bae@intel.com>
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

Extend the emulator context and GPR accessors to handle EGPRs before
adding support for REX2-prefixed instructions. Like VCPU cache, the
emulator can uniformly cache and track all GPRs.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kvm/kvm_emulate.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 0abff36d0994..b722bf20a59b 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -105,13 +105,13 @@ struct x86_instruction_info {
 struct x86_emulate_ops {
 	void (*vm_bugged)(struct x86_emulate_ctxt *ctxt);
 	/*
-	 * read_gpr: read a general purpose register (rax - r15)
+	 * read_gpr: read a general purpose register (rax - r31)
 	 *
 	 * @reg: gpr number.
 	 */
 	ulong (*read_gpr)(struct x86_emulate_ctxt *ctxt, unsigned reg);
 	/*
-	 * write_gpr: write a general purpose register (rax - r15)
+	 * write_gpr: write a general purpose register (rax - r31)
 	 *
 	 * @reg: gpr number.
 	 * @val: value to write.
@@ -315,7 +315,9 @@ typedef void (*fastop_t)(struct fastop *);
  * also uses _eip, RIP cannot be a register operand nor can it be an operand in
  * a ModRM or SIB byte.
  */
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_KVM_APX)
+#define NR_EMULATOR_GPRS	32
+#elif defined(CONFIG_X86_64)
 #define NR_EMULATOR_GPRS	16
 #else
 #define NR_EMULATOR_GPRS	8
@@ -375,9 +377,9 @@ struct x86_emulate_ctxt {
 	u8 lock_prefix;
 	u8 rep_prefix;
 	/* bitmaps of registers in _regs[] that can be read */
-	u16 regs_valid;
+	u32 regs_valid;
 	/* bitmaps of registers in _regs[] that have been written */
-	u16 regs_dirty;
+	u32 regs_dirty;
 	/* modrm */
 	u8 modrm;
 	u8 modrm_mod;
-- 
2.51.0

