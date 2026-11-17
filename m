Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940335;
	b=trCz5p1CzV2OI5RB+mCGASxD/Fa3kfA01gLBSldNhcJ0E/VZbBAVXU4JMrJw2qINn0AF
	 f725d2fa0wJJA2f+ihSDhnAxnIpYlaE7fyK1mxFwjRSheD9BZv1iXbw8ywFU648JBmNrM
	 yoPNcR43c3iGqSBn+BwrS53StNyfSBThSWL3b6Hr4tJqG58INFJVDpExwB3MaDGcxMzAF
	 tgaC20vmLCgp5yooUz6+h+Z8zutl/NJVnvf54+I7L6zNeJ5YRQMDwwpQYdRVyikz7kca9
	 /PwA6AwDWzLwFUXKZ1Iz+MRH1npxZsGbVIrHev2CC5pn12yzFBujLj2V4qoX0+lV4Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940335;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U61PNHS6PRF6i+2iKEhIhj01RnS256bWEcBktz6Ocj8=;
	b=ZgyzpAtVmFRBViteEkqW/AMDDgUhf1wAJXCn1BEH/Ia2GkK0BOqBJK3AL9F07iB6Whj8
	 H0IpNMlo3rSab6gHsoh0Fq5vS7abxYUNq2rIA2wOBIE6XicViACtWx2vBxTTayIJuaZtF
	 TL3LWkjhHVf+kkhHg3ZPFvDaepeBdYQrCVGb3MX85dcSl3E2Ed/vd4+/vbPTpyKduytsT
	 j3yBXCmRTnhrKrtqMgQCdT0yI+84NeET449eTMmx/1vuTuZsdY7v//BRZCeg0babIueoz
	 1/vkDEE5Oy2CB9+3jq+N1NWsjzSZ5a/JBeq7ql724Wksaqz/ML1uvPggBr/6p1KSJ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AhaY9C6T;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766960A6F72;
	Tue, 17 Nov 2026 18:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6766960A6F72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AhaY9C6T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940334; x=1826476334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o3NnsKFBochltIHnoYNqoA81j1f5qOVhess2U4n5yHs=;
  b=AhaY9C6T6wbWDGLX5rciwEKTt8RkZaVBUBAcf26nx6f8MYcRkutj2b5/
   rKQRuWOIRUDExYuMVDEwK98u9E4X/OYpdWDnBpZufxoUXW0kKTsdVluzB
   iLBBjzTc3PzixxxXOZNDAJSuiY6q73Onf86jkTNbr7EVPYsqp8HHH7awi
   jKzZ9KwQ/NOAuMK9uJk8nYX6ARMszrMtcJYiRD274BGLSshHQdQruJzBu
   BMZzEcgDGp6UvxqvwsC0++e1qitu1rKukQk4TOcIyVPsEQqbLTQMPZR6A
   +C2KUwm7vl8vScluUxuvX63isxwrumaD0XvPZLEnxBchE4IOwqAv9ExDm
   Q==;
X-CSE-ConnectionGUID: EzjHge/1TOC/XkdjcMhHdA==
X-CSE-MsgGUID: zPCaZj/IRPWw5OaDsJ/Ndw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607324"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607324"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:30:57 -0800
X-CSE-ConnectionGUID: Sb5z007cSvyljoO5sYGxoQ==
X-CSE-MsgGUID: hp9V7GTDQkeNQZhia92dtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775066"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:30:57 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 12/20] KVM: x86: Handle EGPR index and REX2-incompatible opcodes
Date: Tue, 17 Nov 2026 18:03:02 +0000
Message-ID: <20261117180310.921701-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117180310.921701-1-chang.seok.bae@intel.com>
References: <20261117180310.921701-1-chang.seok.bae@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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

JMPABS (0xA1) is an exception: it is defined for REX2 but mark it as not
implemented, since emulating non-memory operation isn't practically
that useful here.

Also, ignore the high-order register index bits when accessing vector
registers (XMM and YMM).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/1ebf3a23-5671-41c1-8daa-c83f2f105936@redhat.com
---
V8 -> V9:
 * Fix the vector register ID (Jim Mattson)
 * Clarify that JMPABS is not implemented (Jim Mattson)
 * Move the NoRex2 check below group flag handling (Jim Mattson)
---
 arch/x86/kvm/emulate.c     | 91 +++++++++++++++++++++++++-------------
 arch/x86/kvm/kvm_emulate.h |  1 +
 2 files changed, 61 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c1b21282187f..c6e11f551438 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -176,6 +176,7 @@
 #define TwoMemOp    ((u64)1 << 55)  /* Instruction has two memory operand */
 #define IsBranch    ((u64)1 << 56)  /* Instruction is considered a branch. */
 #define ShadowStack ((u64)1 << 57)  /* Instruction affects Shadow Stacks. */
+#define NoRex2      ((u64)1 << 58)  /* Instruction not present in REX2 maps */
 
 #define DstXacc     (DstAccLo | SrcAccHi | SrcWrite)
 
@@ -245,6 +246,7 @@ enum rex_bits {
 	REX_X = 2,
 	REX_R = 4,
 	REX_W = 8,
+	REX_M = 0x80,
 };
 
 static void writeback_registers(struct x86_emulate_ctxt *ctxt)
@@ -1061,10 +1063,24 @@ static int em_fnstsw(struct x86_emulate_ctxt *ctxt)
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
+/*
+ * With EGPR support, @reg may exceed the number of available vector
+ * registers. Mask off the higher bits accordingly.
+ */
 static void __decode_register_operand(struct x86_emulate_ctxt *ctxt,
 				      struct operand *op, int reg)
 {
 	if ((ctxt->d & Avx) && ctxt->op_bytes == 32) {
+		reg &= 0xf;
 		op->type = OP_YMM;
 		op->bytes = 32;
 		op->addr.xmm = reg;
@@ -1072,6 +1088,7 @@ static void __decode_register_operand(struct x86_emulate_ctxt *ctxt,
 		return;
 	}
 	if (ctxt->d & (Avx|Sse)) {
+		reg &= 0xf;
 		op->type = OP_XMM;
 		op->bytes = 16;
 		op->addr.xmm = reg;
@@ -1100,7 +1117,7 @@ static void decode_register_operand(struct x86_emulate_ctxt *ctxt,
 	if (ctxt->d & ModRM)
 		reg = ctxt->modrm_reg;
 	else
-		reg = (ctxt->b & 7) | (ctxt->rex_bits & REX_B ? 8 : 0);
+		reg = (ctxt->b & 7) | rex_get_rxb(ctxt->rex_bits, REX_B);
 
 	__decode_register_operand(ctxt, op, reg);
 }
@@ -1119,9 +1136,9 @@ static int decode_modrm(struct x86_emulate_ctxt *ctxt,
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
@@ -4255,7 +4272,7 @@ static const struct opcode opcode_table[256] = {
 	/* 0x38 - 0x3F */
 	I6ALU(NoWrite, em_cmp), N, N,
 	/* 0x40 - 0x4F */
-	X8(I(DstReg, em_inc)), X8(I(DstReg, em_dec)),
+	X8(I(DstReg | NoRex2, em_inc)), X8(I(DstReg | NoRex2, em_dec)),
 	/* 0x50 - 0x57 */
 	X8(I(SrcReg | Stack, em_push)),
 	/* 0x58 - 0x5F */
@@ -4273,7 +4290,7 @@ static const struct opcode opcode_table[256] = {
 	I2bvIP(DstDI | SrcDX | Mov | String | Unaligned, em_in, ins, check_perm_in), /* insb, insw/insd */
 	I2bvIP(SrcSI | DstDX | String, em_out, outs, check_perm_out), /* outsb, outsw/outsd */
 	/* 0x70 - 0x7F */
-	X16(D(SrcImmByte | NearBranch | IsBranch)),
+	X16(D(SrcImmByte | NearBranch | IsBranch | NoRex2)),
 	/* 0x80 - 0x87 */
 	G(ByteOp | DstMem | SrcImm, group1),
 	G(DstMem | SrcImm, group1),
@@ -4297,15 +4314,15 @@ static const struct opcode opcode_table[256] = {
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
@@ -4335,17 +4352,17 @@ static const struct opcode opcode_table[256] = {
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
@@ -4385,12 +4402,12 @@ static const struct opcode twobyte_table[256] = {
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
@@ -4408,7 +4425,7 @@ static const struct opcode twobyte_table[256] = {
 	N, N, N, N,
 	N, N, N, GP(SrcReg | DstMem | ModRM | Mov, &pfx_0f_6f_0f_7f),
 	/* 0x80 - 0x8F */
-	X16(D(SrcImm | NearBranch | IsBranch)),
+	X16(D(SrcImm | NearBranch | IsBranch | NoRex2)),
 	/* 0x90 - 0x9F */
 	X16(D(ByteOp | DstMem | SrcNone | ModRM| Mov)),
 	/* 0xA0 - 0xA7 */
@@ -5065,6 +5082,18 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
 		ctxt->d |= opcode.flags;
 	}
 
+	/*
+	 * Instructions marked with NoRex2 ignore a legacy REX prefix, but #UD
+	 * should be raised when prefixed with REX2.
+	 */
+	if (ctxt->d & NoRex2 && ctxt->rex_prefix == REX2_PREFIX) {
+		ctxt->d = Undefined;
+
+		/* JMPABS is not a memory operation so not implemented. */
+		if (ctxt->b == 0xa1)
+			ctxt->d = NotImpl;
+	}
+
 	ctxt->is_branch = opcode.flags & IsBranch;
 
 	/* Unrecognised? */
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 52f0aaa38c4c..7d2312d1a1a6 100644
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

