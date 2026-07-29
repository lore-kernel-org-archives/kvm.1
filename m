Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB13C9429;
	Wed, 29 Jul 2026 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354228; cv=none; b=OCGLw/TAe7BsrAvrej855dtJ/A9xutUoiJ0P6YKbQG6VMLM4XDob6S+cb0fK5If/a2SJ9gg4I9J1xKk8hReT7rEFkLoePFa8apCvs/MbIxjTPRWyvj3K2BtNYiLHf3lSv0/U+QdC6SSkXr/6+xd1KHKjWIPMT+bTPZOCSCmJN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354228; c=relaxed/simple;
	bh=0GUmgwR1+KzxXTJz6iffTPJCSR7dd2qwxnZp+au4HrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jt4i063OolbHXZZmWGJsdMGztZy3aZz4hxr5kDRvY7a9Pr97uh8ia6tSDs/SVLZtzuriWZh/FrMbQQFrToTvL2+R3ddIg+P0T3GWXgHmo1mWUBh83WUmeMnI4Y6fut4dB8HC7fnLab+89it2r5qNfhWbON2BxQji7pQNefnqsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1bz2oSP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1bz2oSP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354223; x=1816890223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0GUmgwR1+KzxXTJz6iffTPJCSR7dd2qwxnZp+au4HrE=;
  b=h1bz2oSPUxHIaKPj2ECnpeyTcUWVflJBLCFhORgSxOsu/69gV8IkQoBn
   CqrjyMQMOj/XrOyFLR72hm7VIzcyP6CnpCMYvqIQx+U4KT1dCZqaQiDAJ
   6mAft2y+RYlZLr+J2aO+Y1vP1is5Ymgz1yC2juFbLrYNG/dkDjBKn4qIT
   IGq5irvtVYPsc93BGwhFYWuxzIwnd1coPa/OGZt8dXq9him5b1L4+tS13
   NTeY0m0KQ9NqcSnhhLt4XMcr2K1klom1uhCjrj3MlipC+dZSHpv0DmWE9
   VDsRrZnyjnQJtZx6lQcm5cW2B2pHCmvYxJ/mO9rbzuD5VfM/FnAjnjNyp
   w==;
X-CSE-ConnectionGUID: b0BpSGfyTqm71oiXzAkD6A==
X-CSE-MsgGUID: 1ASIhTldQFSazTgPyO2f5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508280"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508280"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:26 -0700
X-CSE-ConnectionGUID: xqJtT46YRyiWPZS9aDEmtg==
X-CSE-MsgGUID: UI0Q0zJlSxmelKjYJnhpZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769251"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:26 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v6 10/20] KVM: x86: Support EGPR accessing and tracking for emulator
Date: Wed, 29 Jul 2026 19:16:46 +0000
Message-ID: <20260729191656.598771-11-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260729191656.598771-1-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
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

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V4 -> V5: Fix possible shift-out-of-bounds (review bot [*])

[*]: locally running Sashiko with gemini-3.1-pro-preview
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

