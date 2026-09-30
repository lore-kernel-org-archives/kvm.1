Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5991852ED4D;
	Wed, 30 Sep 2026 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804109; cv=none; b=XhslGbVs/39H5ELqj5BsP1t6BdX+57H0vJJcZOmQ2QGPdl9UqAh2Efb/906YzUUNI0edlKReOQYE44/0vwwrI6+8Wg0CBkGnAp72RTb+k7ERNs2+HHsaqRpB0kCWQAg2IO9EUu8DTbQKQA57OYsl+msOXS2XfB9SB+oAFBMJV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804109; c=relaxed/simple;
	bh=hHLVS08TKTeA4zx/cCBa9EYk4VdY8n4hwuOWAyM4Nzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcvcTrqnJcAmK/7pga6S+Euw4P4gvAe38WmJh4BOf++bX/I84YqoVBb341egLoqko5a66aCZol1wpIMAhf12gXRD68/oQk2Jzcl+MHVDtiR0gXK7zavrDN9kDo77aR9ypFTy09F69SI6qvYJ86hgAP/z49XtsHRr26860HxtqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHbCS/VA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHbCS/VA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804107; x=1822340107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hHLVS08TKTeA4zx/cCBa9EYk4VdY8n4hwuOWAyM4Nzs=;
  b=UHbCS/VAyuGUawnOlWSHe+jxzQN9jhIl/lRtJG3oGBTgh0B4v6NgeFM3
   NLeAWiZ6NfIprzeLEA0sAoZVadmAWrUuK3pf9Tn0hjbAxXfEoiEqeKDEr
   pUD4Zxv83S7MJo4RYoBVKwTVDcE6z/JRz9cg2AmwRkITsknw8FCeEhPAi
   v0xNUy6Tu88luyL0dxDs7wLEQdTGUbgZrlvYbi+Ul7kWQz7ueCLsoks/l
   p1Kl1+IGsaaZiUQbsM8Yc3sHIZdHs/psYSRDSX7+JsAokXirW2JSt+uTF
   3BDRIStkv62GTqm9O9m0v8H7roh2eBsXrCgUbaBXy61FJZ+h+b75wYWgg
   A==;
X-CSE-ConnectionGUID: imc4rcltRQGEYTn6Rh5nvA==
X-CSE-MsgGUID: UffFcSCTRLK+8cgXwEHA+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432698"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432698"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:35:06 -0700
X-CSE-ConnectionGUID: ygPZtw/aRrKCM743LusZmg==
X-CSE-MsgGUID: dN+Gq+G6SXiwf+19VKcRUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867303"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:35:06 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v8 10/20] KVM: x86: Support EGPR accessing and tracking for emulator
Date: Wed, 30 Sep 2026 21:07:40 +0000
Message-ID: <20260930210750.1487547-11-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930210750.1487547-1-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
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

Also replace `1 << reg` with `BIT(reg)` in reg_read()/reg_write(). The
former performs a signed 32-bit shift, which becomes undefined for R31.
BIT() instead shifts an unsigned value that is suitable for all indices.

Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kvm/kvm_emulate.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 3e375af15c03..b1498f618c81 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -109,13 +109,13 @@ struct x86_instruction_info {
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
@@ -321,7 +321,9 @@ typedef void (*fastop_t)(struct fastop *);
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
@@ -381,9 +383,9 @@ struct x86_emulate_ctxt {
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
@@ -547,8 +549,8 @@ static inline ulong reg_read(struct x86_emulate_ctxt *ctxt, unsigned nr)
 	if (KVM_EMULATOR_BUG_ON(nr >= NR_EMULATOR_GPRS, ctxt))
 		nr &= NR_EMULATOR_GPRS - 1;
 
-	if (!(ctxt->regs_valid & (1 << nr))) {
-		ctxt->regs_valid |= 1 << nr;
+	if (!(ctxt->regs_valid & BIT(nr))) {
+		ctxt->regs_valid |= BIT(nr);
 		ctxt->_regs[nr] = ctxt->ops->read_gpr(ctxt, nr);
 	}
 	return ctxt->_regs[nr];
@@ -562,8 +564,8 @@ static inline ulong *reg_write(struct x86_emulate_ctxt *ctxt, unsigned nr)
 	BUILD_BUG_ON(sizeof(ctxt->regs_dirty) * BITS_PER_BYTE < NR_EMULATOR_GPRS);
 	BUILD_BUG_ON(sizeof(ctxt->regs_valid) * BITS_PER_BYTE < NR_EMULATOR_GPRS);
 
-	ctxt->regs_valid |= 1 << nr;
-	ctxt->regs_dirty |= 1 << nr;
+	ctxt->regs_valid |= BIT(nr);
+	ctxt->regs_dirty |= BIT(nr);
 	return &ctxt->_regs[nr];
 }
 
-- 
2.53.0

