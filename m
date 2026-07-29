Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE93CE49E;
	Wed, 29 Jul 2026 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354233; cv=none; b=r5mNQlzp2bYEc6EPNdF9/S4cTyukb/zcgHMF5DOpdaIw7b0VJ58fN2MgyTZu5wtpAg9Wcw5tWvimsX5dDksB/7dp2m75d19El0nDd7O4fKI1yvlpb/SCc1FwrXQEYASwd1+NM/fxFzNB6XluzJpBPTA4LzTSSos5H3HPjn05GJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354233; c=relaxed/simple;
	bh=hJrxV2vh1Ac+o1soV5h5EKzDyGNXsx1NRnZwGnyHvMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMH9MoP24WrEDAGHdK4NyWxHt+bmskpg+nu3E88XUPaRpmPtZjnUs5ije9SB6/APehzxj1OwC7dSUrZKbTXXxUmIo3H23IAaDuk9SJnBV69OXBz8cAVUI9CcbsJ2T5+URc9dgsRkPCk/XkSBYvKHWUckt7PFx2ra1+XaEuML6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRSsshZS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRSsshZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354227; x=1816890227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hJrxV2vh1Ac+o1soV5h5EKzDyGNXsx1NRnZwGnyHvMs=;
  b=dRSsshZS0bU5BcVFfdVUnWyCq7q0aa/7FtBTxRXqNMAQ89JsEuQhXZIt
   cqasjtOKBrnYbsUv3ICLJuBqxBOr7kcp7P9YMD77kLXqM6nWhZJDu+hPa
   FD2Tr95Ai2dpGjeA/pQ4T2FGHVSVVw6VkSd+AhQbIV+tjEK6PlYx0rp5z
   T7MlrCQky6i3HNQyjVR3ph+pJ7THcRVTx5SS+RHPQgHrVQwvatZ7q3BTz
   3x3IZOBjy57tiHm7nWRiYD+4eEiz02eUgZPUHtjVp2FM20mkVYYG4vBZ5
   R1Wk8A31jYrZJ5KCFF4mWpAWmjYL4VEC3veIA1efxYa4iQ82av9Ytg2ZZ
   w==;
X-CSE-ConnectionGUID: EU7Bge8XSOalNvTmixpC/g==
X-CSE-MsgGUID: nULSFZrwSQuT1UNrNrxPdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508284"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508284"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:27 -0700
X-CSE-ConnectionGUID: 66S6XGLOQNm0hdDFySJtgQ==
X-CSE-MsgGUID: LNJ5XVNaSROtai1W8Ekg6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769254"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:27 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v6 11/20] KVM: x86: Handle EGPR index and REX2-incompatible opcodes
Date: Wed, 29 Jul 2026 19:16:47 +0000
Message-ID: <20260729191656.598771-12-chang.seok.bae@intel.com>
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

Prepare the emulator for REX2 handling by introducing the NoRex2 opcode
flag and supporting extended register indices. For the latter, factor out
common logic for calculating register IDs.

REX2 does not support three-byte opcodes. Instead, the REX2.M bit selects
between one- and two-byte opcode tables, which were previously
distinguished by the 0x0F escape byte.

Some legacy instructions in those tables never reference extended
registers. When prefixed with REX, such instructions are treated as if
the prefix were absent. In contrast, a REX2 prefix causes a #UD, which
should be handled explicitly.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/1ebf3a23-5671-41c1-8daa-c83f2f105936@redhat.com
---
 arch/x86/kvm/emulate.c     | 80 +++++++++++++++++++++++---------------
 arch/x86/kvm/kvm_emulate.h |  1 +
 2 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index b566ab5c7515..12a822870d08 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -175,6 +175,7 @@
 #define TwoMemOp    ((u64)1 << 55)  /* Instruction has two memory operand */
 #define IsBranch    ((u64)1 << 56)  /* Instruction is considered a branch. */
 #define ShadowStack ((u64)1 << 57)  /* Instruction affects Shadow Stacks. */
+#define NoRex2      ((u64)1 << 58)  /* Instruction not present in REX2 maps */
 
 #define DstXacc     (DstAccLo | SrcAccHi | SrcWrite)
 
@@ -244,6 +245,7 @@ enum rex_bits {
 	REX_X = 2,
 	REX_R = 4,
 	REX_W = 8,
+	REX_M = 0x80,
 };
 
 static void writeback_registers(struct x86_emulate_ctxt *ctxt)
@@ -1079,6 +1081,15 @@ static int em_fnstsw(struct x86_emulate_ctxt *ctxt)
 	return X86EMUL_CONTINUE;
 }
 
+static __always_inline int rex_get_rxb(u8 rex, u8 fld)
+{
+	BUILD_BUG_ON(!__builtin_constant_p(fld));
+	BUILD_BUG_ON(fld != REX_B && fld != REX_X && fld != REX_R);
+
+	rex >>= ffs(fld) - 1;
+	return (rex & 1 ? 8 : 0) + (rex & 0x10 ? 16 : 0);
+}
+
 static void __decode_register_operand(struct x86_emulate_ctxt *ctxt,
 				      struct operand *op, int reg)
 {
@@ -1118,7 +1129,7 @@ static void decode_register_operand(struct x86_emulate_ctxt *ctxt,
 	if (ctxt->d & ModRM)
 		reg = ctxt->modrm_reg;
 	else
-		reg = (ctxt->b & 7) | (ctxt->rex_bits & REX_B ? 8 : 0);
+		reg = (ctxt->b & 7) | rex_get_rxb(ctxt->rex_bits, REX_B);
 
 	__decode_register_operand(ctxt, op, reg);
 }
@@ -1137,9 +1148,9 @@ static int decode_modrm(struct x86_emulate_ctxt *ctxt,
 	int rc = X86EMUL_CONTINUE;
 	ulong modrm_ea = 0;
 
-	ctxt->modrm_reg = (ctxt->rex_bits & REX_R ? 8 : 0);
-	index_reg = (ctxt->rex_bits & REX_X ? 8 : 0);
-	base_reg = (ctxt->rex_bits & REX_B ? 8 : 0);
+	ctxt->modrm_reg = rex_get_rxb(ctxt->rex_bits, REX_R);
+	index_reg       = rex_get_rxb(ctxt->rex_bits, REX_X);
+	base_reg        = rex_get_rxb(ctxt->rex_bits, REX_B);
 
 	ctxt->modrm_mod = (ctxt->modrm & 0xc0) >> 6;
 	ctxt->modrm_reg |= (ctxt->modrm & 0x38) >> 3;
@@ -4247,7 +4258,7 @@ static const struct opcode opcode_table[256] = {
 	/* 0x38 - 0x3F */
 	I6ALU(NoWrite, em_cmp), N, N,
 	/* 0x40 - 0x4F */
-	X8(I(DstReg, em_inc)), X8(I(DstReg, em_dec)),
+	X8(I(DstReg | NoRex2, em_inc)), X8(I(DstReg | NoRex2, em_dec)),
 	/* 0x50 - 0x57 */
 	X8(I(SrcReg | Stack, em_push)),
 	/* 0x58 - 0x5F */
@@ -4265,7 +4276,7 @@ static const struct opcode opcode_table[256] = {
 	I2bvIP(DstDI | SrcDX | Mov | String | Unaligned, em_in, ins, check_perm_in), /* insb, insw/insd */
 	I2bvIP(SrcSI | DstDX | String, em_out, outs, check_perm_out), /* outsb, outsw/outsd */
 	/* 0x70 - 0x7F */
-	X16(D(SrcImmByte | NearBranch | IsBranch)),
+	X16(D(SrcImmByte | NearBranch | IsBranch | NoRex2)),
 	/* 0x80 - 0x87 */
 	G(ByteOp | DstMem | SrcImm, group1),
 	G(DstMem | SrcImm, group1),
@@ -4289,15 +4300,15 @@ static const struct opcode opcode_table[256] = {
 	II(ImplicitOps | Stack, em_popf, popf),
 	I(ImplicitOps, em_sahf), I(ImplicitOps, em_lahf),
 	/* 0xA0 - 0xA7 */
-	I2bv(DstAcc | SrcMem | Mov | MemAbs, em_mov),
-	I2bv(DstMem | SrcAcc | Mov | MemAbs | PageTable, em_mov),
-	I2bv(SrcSI | DstDI | Mov | String | TwoMemOp, em_mov),
-	I2bv(SrcSI | DstDI | String | NoWrite | TwoMemOp, em_cmp_r),
+	I2bv(DstAcc | SrcMem | Mov | MemAbs | NoRex2, em_mov),
+	I2bv(DstMem | SrcAcc | Mov | MemAbs | PageTable | NoRex2, em_mov),
+	I2bv(SrcSI | DstDI | Mov | String | TwoMemOp | NoRex2, em_mov),
+	I2bv(SrcSI | DstDI | String | NoWrite | TwoMemOp | NoRex2, em_cmp_r),
 	/* 0xA8 - 0xAF */
-	I2bv(DstAcc | SrcImm | NoWrite, em_test),
-	I2bv(SrcAcc | DstDI | Mov | String, em_mov),
-	I2bv(SrcSI | DstAcc | Mov | String, em_mov),
-	I2bv(SrcAcc | DstDI | String | NoWrite, em_cmp_r),
+	I2bv(DstAcc | SrcImm | NoWrite | NoRex2, em_test),
+	I2bv(SrcAcc | DstDI | Mov | String | NoRex2, em_mov),
+	I2bv(SrcSI | DstAcc | Mov | String | NoRex2, em_mov),
+	I2bv(SrcAcc | DstDI | String | NoWrite | NoRex2, em_cmp_r),
 	/* 0xB0 - 0xB7 */
 	X8(I(ByteOp | DstReg | SrcImm | Mov, em_mov)),
 	/* 0xB8 - 0xBF */
@@ -4327,17 +4338,17 @@ static const struct opcode opcode_table[256] = {
 	/* 0xD8 - 0xDF */
 	N, E(0, &escape_d9), N, E(0, &escape_db), N, E(0, &escape_dd), N, N,
 	/* 0xE0 - 0xE7 */
-	X3(I(SrcImmByte | NearBranch | IsBranch, em_loop)),
-	I(SrcImmByte | NearBranch | IsBranch, em_jcxz),
-	I2bvIP(SrcImmUByte | DstAcc, em_in,  in,  check_perm_in),
-	I2bvIP(SrcAcc | DstImmUByte, em_out, out, check_perm_out),
+	X3(I(SrcImmByte | NearBranch | IsBranch | NoRex2, em_loop)),
+	I(SrcImmByte | NearBranch | IsBranch | NoRex2, em_jcxz),
+	I2bvIP(SrcImmUByte | DstAcc | NoRex2, em_in,  in,  check_perm_in),
+	I2bvIP(SrcAcc | DstImmUByte | NoRex2, em_out, out, check_perm_out),
 	/* 0xE8 - 0xEF */
-	I(SrcImm | NearBranch | IsBranch | ShadowStack, em_call),
-	D(SrcImm | ImplicitOps | NearBranch | IsBranch),
-	I(SrcImmFAddr | No64 | IsBranch, em_jmp_far),
-	D(SrcImmByte | ImplicitOps | NearBranch | IsBranch),
-	I2bvIP(SrcDX | DstAcc, em_in,  in,  check_perm_in),
-	I2bvIP(SrcAcc | DstDX, em_out, out, check_perm_out),
+	I(SrcImm | NearBranch | IsBranch | ShadowStack | NoRex2, em_call),
+	D(SrcImm | ImplicitOps | NearBranch | IsBranch | NoRex2),
+	I(SrcImmFAddr | No64 | IsBranch | NoRex2, em_jmp_far),
+	D(SrcImmByte | ImplicitOps | NearBranch | IsBranch | NoRex2),
+	I2bvIP(SrcDX | DstAcc | NoRex2, em_in,  in,  check_perm_in),
+	I2bvIP(SrcAcc | DstDX | NoRex2, em_out, out, check_perm_out),
 	/* 0xF0 - 0xF7 */
 	N, DI(ImplicitOps, icebp), N, N,
 	DI(ImplicitOps | Priv, hlt), D(ImplicitOps),
@@ -4378,12 +4389,12 @@ static const struct opcode twobyte_table[256] = {
 	N, GP(ModRM | DstMem | SrcReg | Mov | Sse | Avx, &pfx_0f_2b),
 	N, N, N, N,
 	/* 0x30 - 0x3F */
-	II(ImplicitOps | Priv, em_wrmsr, wrmsr),
-	IIP(ImplicitOps, em_rdtsc, rdtsc, check_rdtsc),
-	II(ImplicitOps | Priv, em_rdmsr, rdmsr),
-	IIP(ImplicitOps, em_rdpmc, rdpmc, check_rdpmc),
-	I(ImplicitOps | EmulateOnUD | IsBranch | ShadowStack, em_sysenter),
-	I(ImplicitOps | Priv | EmulateOnUD | IsBranch | ShadowStack, em_sysexit),
+	II(ImplicitOps | Priv | NoRex2, em_wrmsr, wrmsr),
+	IIP(ImplicitOps | NoRex2, em_rdtsc, rdtsc, check_rdtsc),
+	II(ImplicitOps | Priv | NoRex2, em_rdmsr, rdmsr),
+	IIP(ImplicitOps | NoRex2, em_rdpmc, rdpmc, check_rdpmc),
+	I(ImplicitOps | EmulateOnUD | IsBranch | ShadowStack | NoRex2, em_sysenter),
+	I(ImplicitOps | Priv | EmulateOnUD | IsBranch | ShadowStack | NoRex2, em_sysexit),
 	N, N,
 	N, N, N, N, N, N, N, N,
 	/* 0x40 - 0x4F */
@@ -4401,7 +4412,7 @@ static const struct opcode twobyte_table[256] = {
 	N, N, N, N,
 	N, N, N, GP(SrcReg | DstMem | ModRM | Mov, &pfx_0f_6f_0f_7f),
 	/* 0x80 - 0x8F */
-	X16(D(SrcImm | NearBranch | IsBranch)),
+	X16(D(SrcImm | NearBranch | IsBranch | NoRex2)),
 	/* 0x90 - 0x9F */
 	X16(D(ByteOp | DstMem | SrcNone | ModRM| Mov)),
 	/* 0xA0 - 0xA7 */
@@ -4994,6 +5005,13 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
 		opcode = opcode_table[ctxt->b];
 	}
 
+	/*
+	 * Instructions marked with NoRex2 ignore a legacy REX prefix, but #UD
+	 * should be raised when prefixed with REX2.
+	 */
+	if (opcode.flags & NoRex2 && ctxt->rex_prefix == REX2_PREFIX)
+		opcode.flags = Undefined;
+
 	if (opcode.flags & ModRM)
 		ctxt->modrm = insn_fetch(u8, ctxt);
 
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index b1498f618c81..f1ca1938af71 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -335,6 +335,7 @@ typedef void (*fastop_t)(struct fastop *);
 enum rex_type {
 	REX_NONE,
 	REX_PREFIX,
+	REX2_PREFIX,
 };
 
 struct x86_emulate_ctxt {
-- 
2.53.0

