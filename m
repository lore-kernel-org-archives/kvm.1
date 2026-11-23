Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457889;
	b=2CtoRuXZ+U71tglKrsIfxggF58wwyeNEBi+/dxSKkC3WYcOmnGjTd4j003tPKR3dZY4q
	 8rKPXQ7pMkXGp25pi3hKEqfqlG+RgrDCtYmCM0jYmPA5Zeki3uUNLil3VocW/V98Ot9iR
	 UktcSzGS6HtGfaUjuckGznk0iwW/R4IYjE340Nvht82O/Fc4V9Jru//6kjFeNKwY/wqFF
	 QW1fvnc7ONBif3GHEtaepgVxpwLpMEsSTVJ846JCHq/zF2M2Kjw5Ytt30bZijfmiVtTE1
	 eYgBioc1UIuVVJ2W+567kgmyShKVRX/UuyR3kE48kP3q33GlfQ1hEyf5OnVJvCUqQwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457889;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KlfoNulDp0vnPiAsE9NdfHxD5Zil42wBpLVJurSF69M=;
	b=JsyjASQgzKRvsboM6K8N+3q9WHw0Q4/bxgghVf3fC2nUM38Pu3bnK5dukTYHMQ54JPw7
	 z7U8SZhoKUaLRGxIXZbq4Fj3PSwEoUyURxYWdFh7CPq6934nq9Q6gTHYUVWcSKelWrDzQ
	 jBwK6dkepCmigx2lD2JOQz65IFle7k+nt2zEkVky2ajMQBHNInP5t3Jx3K+GlAJipfrfP
	 cxZr0NwwL3S1xJoyULFjeJkgrD06Ymnb6pZPTpXgNemJ4rItMvlSmlgy+IS6MuhHixcjU
	 SQeXuUztHSF/pVC7yCCBp0JcfTpM1DTXnC6jg7ZVGq8+n7MQg59V9teZxMxpWqsiElA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="S/arSJwM";
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02B660A5BE6;
	Mon, 23 Nov 2026 18:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A02B660A5BE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S/arSJwM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457889; x=1826993889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FIFyXdG9oYJ/sk5epO5KhLgyA/HZq1Yr0x1CqeVk6pc=;
  b=S/arSJwMEtSIBVFCD1VTT7dt1GLvWH9QAvKl5GDde5eM+AI/aRHsUhB/
   emegwsH7WjIP/5fXxKNTu7DUwthKcayc/1eYtOo97pDuTuvEJbyNjotAY
   48HHBdWU8kZJYd08YOH8ddOFlOZxSKb0HKbG4o3cXVtxx0YcvOLIpG32P
   KkrjZLyaZtMf4U/Ph0rmLtNuCmxw7vusKlTxVEvV9h/na1C9U95pNxBMv
   5lDmd537QxVTpTV+ssQDhzB+je5+tY9YpiasyHJZ16g6LduCEu5CTO8W9
   GCZ+qr7JcT/JwcRFBwMuYkTklXnJjtZ9WAUQJFDn9z45aL+LsEL3VrVk8
   w==;
X-CSE-ConnectionGUID: 1gKR/L+4RVG6f8/TrWVixQ==
X-CSE-MsgGUID: m98cidwjT+26EK82agKQPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288847"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288847"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:25 -0800
X-CSE-ConnectionGUID: HUQrjm4URFKAkzbwzrUrug==
X-CSE-MsgGUID: ueuIM8dAQfSHMImX3FmWVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241143"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:25 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 12/20] KVM: x86: Handle EGPR index and REX2-incompatible opcodes
Date: Mon, 23 Nov 2026 17:37:24 +0000
Message-ID: <20261123173732.1072124-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123173732.1072124-1-chang.seok.bae@intel.com>
References: <20261123173732.1072124-1-chang.seok.bae@intel.com>
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
registers (XMM and YMM) or segment registers.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/1ebf3a23-5671-41c1-8daa-c83f2f105936@redhat.com
---
V9 -> V10: Mask higher bits for segment registers (Jim Mattson)
---
 arch/x86/kvm/emulate.c     | 97 ++++++++++++++++++++++++++------------
 arch/x86/kvm/kvm_emulate.h |  1 +
 2 files changed, 67 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c1b21282187f..2b649d15d5f5 100644
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
@@ -3342,6 +3359,9 @@ static int em_store_sreg(struct x86_emulate_ctxt *ctxt, int segment)
 
 static int em_mov_rm_sreg(struct x86_emulate_ctxt *ctxt)
 {
+	/* Ignore higher register index bits from REX/REX2: */
+	ctxt->modrm_reg &= 7;
+
 	if (ctxt->modrm_reg > VCPU_SREG_GS)
 		return emulate_ud(ctxt);
 
@@ -3352,6 +3372,9 @@ static int em_mov_sreg_rm(struct x86_emulate_ctxt *ctxt)
 {
 	u16 sel = ctxt->src.val;
 
+	/* Ignore higher register index bits from REX/REX2: */
+	ctxt->modrm_reg &= 7;
+
 	if (ctxt->modrm_reg == VCPU_SREG_CS || ctxt->modrm_reg > VCPU_SREG_GS)
 		return emulate_ud(ctxt);
 
@@ -4255,7 +4278,7 @@ static const struct opcode opcode_table[256] = {
 	/* 0x38 - 0x3F */
 	I6ALU(NoWrite, em_cmp), N, N,
 	/* 0x40 - 0x4F */
-	X8(I(DstReg, em_inc)), X8(I(DstReg, em_dec)),
+	X8(I(DstReg | NoRex2, em_inc)), X8(I(DstReg | NoRex2, em_dec)),
 	/* 0x50 - 0x57 */
 	X8(I(SrcReg | Stack, em_push)),
 	/* 0x58 - 0x5F */
@@ -4273,7 +4296,7 @@ static const struct opcode opcode_table[256] = {
 	I2bvIP(DstDI | SrcDX | Mov | String | Unaligned, em_in, ins, check_perm_in), /* insb, insw/insd */
 	I2bvIP(SrcSI | DstDX | String, em_out, outs, check_perm_out), /* outsb, outsw/outsd */
 	/* 0x70 - 0x7F */
-	X16(D(SrcImmByte | NearBranch | IsBranch)),
+	X16(D(SrcImmByte | NearBranch | IsBranch | NoRex2)),
 	/* 0x80 - 0x87 */
 	G(ByteOp | DstMem | SrcImm, group1),
 	G(DstMem | SrcImm, group1),
@@ -4297,15 +4320,15 @@ static const struct opcode opcode_table[256] = {
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
@@ -4335,17 +4358,17 @@ static const struct opcode opcode_table[256] = {
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
@@ -4385,12 +4408,12 @@ static const struct opcode twobyte_table[256] = {
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
@@ -4408,7 +4431,7 @@ static const struct opcode twobyte_table[256] = {
 	N, N, N, N,
 	N, N, N, GP(SrcReg | DstMem | ModRM | Mov, &pfx_0f_6f_0f_7f),
 	/* 0x80 - 0x8F */
-	X16(D(SrcImm | NearBranch | IsBranch)),
+	X16(D(SrcImm | NearBranch | IsBranch | NoRex2)),
 	/* 0x90 - 0x9F */
 	X16(D(ByteOp | DstMem | SrcNone | ModRM| Mov)),
 	/* 0xA0 - 0xA7 */
@@ -5065,6 +5088,18 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
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

