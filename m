Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8852F9DA1;
	Wed,  2 Sep 2026 02:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317095; cv=none; b=E4lfHYyNgEx33bqzgHk7gwI2SI0LxYKZv6UzsY5B3CfZuJX+CkAv8MU7ens0QMxrsfxfwaR/5KSW1wi7D/1SJIdT/fCRN5OYaAg3Zt4e8787BJzWvGgyvC6KFmKoDy5+PegKjqjBi7jFG42bvMEB49XsckcazsMf0uQifYA+vdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317095; c=relaxed/simple;
	bh=pVeu832sqgfTjwo6V7z7hibAKKbfYVE5v4hT1m8gBRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtwOJ1l9irpRIiLWaaCplKlXayn7T5prcTnoAAWc0tqSMZ00ySeqHUijwiFRbLGu2ZJeN/rFR6bsLZdqNI8XXS0fqSJYMoGtrqiFtknMOtIiJpgxZ7ycfHBF6i7ofnmu0GuRizWFiO2F1kM2AZWxtYf/Vgu2b5Rk3GoC/812ATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clOWLwus; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clOWLwus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788317094; x=1819853094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pVeu832sqgfTjwo6V7z7hibAKKbfYVE5v4hT1m8gBRA=;
  b=clOWLwusc7MyrItjcayVPkvoj5kBnBQyAvZy6sxFT+TuwWs3z/8kdl1B
   yCGf2Q1jh5ncoQ7Nljuf9z7AKmW/UqUWOrjCtkX+MCG1gII3IBDR9Yry5
   Ep6CKWWMea6+xXRwpUWNLfmprQ1UBceFtHLir79krR0Zyeo14aPSLjXgs
   ybsrjQKweOhM7DZaTeA/ySdAZQUuUrAA9ugydH2MrfGBVPETP8hpkglUK
   bRYj8ik+Rtfk22j4dpcoV5xV+7qAf/E7WJ+1the1DkKOL+gWtW9de8XEc
   gV66n4of+RmjHuibpe5mV23WVAon30ZEpYnOJmIpr5A4FqtnJxr2JF288
   A==;
X-CSE-ConnectionGUID: rj2mov2rQy2NqamL0Va9PA==
X-CSE-MsgGUID: 8lZ9bV4fSP+FsnzDP8uEmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106282934"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106282934"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:44:54 -0700
X-CSE-ConnectionGUID: zUwGVL4NQx+OCj+qRkcyTw==
X-CSE-MsgGUID: rUJozKeKRR+YBe2XCBxMjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272775516"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2026 19:44:54 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v7 10/20] KVM: x86: Support EGPR accessing and tracking for emulator
Date: Wed,  2 Sep 2026 02:17:54 +0000
Message-ID: <20260902021804.718676-11-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902021804.718676-1-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
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

