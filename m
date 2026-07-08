Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F33B7742
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481791; cv=none; b=U9JWqHNfBVOin/090bF0qMPHd4bIQPt49xDoeqU4+qIInYh3gyBfqL8Mtzs6DLgOZDLPD7m5q4+7QA78VUvh5IXzaaiYub4R6GuGBUUWUTciyL2dy6NYM2ZRiC5D7wPjQ3f/DIzQVMUsRbHO2W9eM/h3P7V02/iAg4WF7MHipW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481791; c=relaxed/simple;
	bh=8KuAhqHJ+loe5ic+SpLTi4XPQp+lYq26PI6AVYC/DGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EeNXnbg5upBbdm5JyO01DVNHXDIp/8ivHknTpLQ5U+w9lsN1DVArbq2hrbAI3qzgOAXpRfh/+LJINj0pB/AA6EqGorxdnfh+6h9YIJhJsWHVwFe1RZMp1GOSSnCQm/gwATXqOA1cMOWMgyxA4/y74xSFdgqWew4DQio4W3sTqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiJwTuq4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiJwTuq4"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so250472a91.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 20:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783481788; x=1784086588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SR8mR9it1OWQyEL0DY1LWyUyFS77FRgGacSc2ZvQ24g=;
        b=fiJwTuq4im+nEFn9p7zprc5Z0sc/IB1UtTGcFOBQzxzSuvuwviQJyqapdPI3eXXTsM
         Wj8+93LzKynYeq2IdjI69xP6DA+PDGGWADpk8CKgrav2bmi6nt5WONxGbnIwCkhqaUmX
         +SUslvFYMKglXdIinrmjJQ5grCBEs6hbUQDpju+rHpeDW84MpBkmx8/5iZqYKJEguJz3
         bkyrGmfZRXYRga0YH2e/T8P317tziL1zp7q+gLVtfklpx6/RS/awIY6p80CbjwPi3AZX
         gn+ApuK9cMVrExEEStrKfuAu71PeBZpNxMGNwk7oS6iRdefFqPhGuj+/gPGzZ8Ai1R4i
         O0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481788; x=1784086588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SR8mR9it1OWQyEL0DY1LWyUyFS77FRgGacSc2ZvQ24g=;
        b=cMHEk8Zk4+7ZZTcCCaZUpVRzzIiRz4+TaGIZNuOnikqBkunz9IoUCMIN4yv7+lA++u
         mjYrppo2H3c/l9Zym0f3Lj9M1S08eEPSgHOm0luhQOgGwEVddfBAQoGDFyllLED/l/Ih
         C3TKH7DXbbFMRpIrJNtNhxFbFU/Z4OdcA5wDz1MNw+wqXmXdkzi8bU+OBdlAN9xggr1S
         GEdf/qR9+E4MHGg+hEiNNSgIK+u5AeCqliK4xbYSTHF1R3fjXvMuT4R+gWhSculj7sys
         uL0LHtbyoVcQpNKikAM69To+tDkDdRNVE/bOnVn60w+LB8/wb3hTrFnTbTDvIIcMM4vH
         ScJA==
X-Forwarded-Encrypted: i=1; AHgh+Rq716WMb8OX5LEHGelyEGzxwzJM2vMug48uKuDqhpYZsxT2zeKL0oWtTVXQ5WD4+5hofws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/GPPZN5uZTzeb3uK8AZPpl/h/KPpMjsEFoW4sJQ/lK0VJkby
	lLcO8/+rO4k4RXQe4MuwaCqRGfwuzbD7pWVZC62OqJRbJexdb7NRpOut
X-Gm-Gg: AfdE7clyXIotxtxfLfRmlqQ5xvPHaRJu0S6We44aRAk5duykEgeVkf28lEbLsVlb2kp
	mo21bhPy1ROtzGx/PcYvTjl9jMBuH0FSauiMOIdn8+bUo3YPNoNkNyjwLA6Bno/dK/TOhVEsBCi
	2vtKYr9UHvGAVFiiEx5DzUC9cvqTOQmoyH0e+JnKZ9FpMAx7lw27FHvMAERRxxknPskt0XKBf5+
	6jWw4X/ac1iTRLCKW7GUwDsVt2fhwJjAiqlCxnr1gpCkZ+Fi+90B0AjBu4CQZxF1t6iKAFjSzvb
	3Gq9rWdIJHpxFnMKaNassovxTuIyBPpniLCfY/HSukAYh9YUlM325g2NFzQiQ8HcE5/jMI4SpMG
	8N0EPIdSvx8rukEelrfFMwGXd+ScVwhaK01KBZNIwBbvFcSzqhnE3HXIpitNEY4dB+jTF8zEZvM
	ybVJk3XebjYI/JjsaD0JwK7QN7HFohOtjhtYeL2+OtW+MGN/Mo6Q==
X-Received: by 2002:a17:90b:2f06:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-38941101dfemr667261a91.7.1783481787632;
        Tue, 07 Jul 2026 20:36:27 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm21092850eec.29.2026.07.07.20.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:36:27 -0700 (PDT)
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Date: Tue, 07 Jul 2026 20:34:28 -0700
Subject: [PATCH v3 05/17] riscv: kprobes: Use generated instruction headers
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-riscv_insn_table-v3-5-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
In-Reply-To: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alex@ghiti.fr>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 Jesse Taube <jtaubepe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783481777; l=14214;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=8KuAhqHJ+loe5ic+SpLTi4XPQp+lYq26PI6AVYC/DGE=;
 b=OWaixftSe318CoggWAbQQHISpWk0GZ3RolHMCVtUBmD8FQGMyWUFBaSitMWpLj/M1NXKAQrZh
 jAZBI6BUIEzB/rs2uQL09KhfTsdTdYWYAm09UYefvzp59wWD7OgN6q1
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

Migrate the code that is decoding instruction for the use of kprobes to
use the generated instruction headers instead of the hand-written
instruction functions.

With the more granular instruction support, split the decoding of branches into
their own functions.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

---

Tested using CONFIG_RISCV_KPROBES_KUNIT
---
 arch/riscv/include/asm/insn.h            |   7 +
 arch/riscv/kernel/probes/decode-insn.c   |   7 +-
 arch/riscv/kernel/probes/simulate-insn.c | 253 ++++++++++++-------------------
 arch/riscv/kernel/probes/simulate-insn.h |   7 +-
 4 files changed, 114 insertions(+), 160 deletions(-)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index b92c71896c00..bf6f5d530491 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -520,6 +520,13 @@ static inline unsigned long riscv_insn_reg_get_val(unsigned long *regs, u32 inde
 	return index ? *(regs + index) : 0;
 }
 
+static inline void riscv_insn_reg_set_val(unsigned long *regs, u32 index, unsigned long val)
+{
+	/* register 0 is always 0 and not stored in the register struct */
+	if (index != 0)
+		*(regs + index) = val;
+}
+
 #define riscv_insn_branch(_insn, regs_ptr, _opcode, _pc, _comparison, type)     \
 	({                                                                      \
 		unsigned long _ret;                                             \
diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
index 65d9590bfb9f..0d70c8301a45 100644
--- a/arch/riscv/kernel/probes/decode-insn.c
+++ b/arch/riscv/kernel/probes/decode-insn.c
@@ -42,7 +42,12 @@ riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
 	RISCV_INSN_SET_SIMULATE(jal,		insn);
 	RISCV_INSN_SET_SIMULATE(jalr,		insn);
 	RISCV_INSN_SET_SIMULATE(auipc,		insn);
-	RISCV_INSN_SET_SIMULATE(branch,		insn);
+	RISCV_INSN_SET_SIMULATE(beq,		insn);
+	RISCV_INSN_SET_SIMULATE(bne,		insn);
+	RISCV_INSN_SET_SIMULATE(blt,		insn);
+	RISCV_INSN_SET_SIMULATE(bge,		insn);
+	RISCV_INSN_SET_SIMULATE(bltu,		insn);
+	RISCV_INSN_SET_SIMULATE(bgeu,		insn);
 
 	return INSN_GOOD;
 }
diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
index fa581590c1f8..a443883c3237 100644
--- a/arch/riscv/kernel/probes/simulate-insn.c
+++ b/arch/riscv/kernel/probes/simulate-insn.c
@@ -4,222 +4,152 @@
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
 
-#include "decode-insn.h"
+#include <asm/insn.h>
 #include "simulate-insn.h"
 
-static inline bool rv_insn_reg_get_val(struct pt_regs *regs, u32 index,
-				       unsigned long *ptr)
+bool __kprobes simulate_jal(u32 opcode, unsigned long addr, struct pt_regs *regs)
 {
-	if (index == 0)
-		*ptr = 0;
-	else if (index <= 31)
-		*ptr = *((unsigned long *)regs + index);
-	else
-		return false;
+	s32 imm = riscv_insn_jal_extract_imm(opcode);
+	u32 index = riscv_insn_jal_extract_xd(opcode);
 
-	return true;
-}
+	riscv_insn_reg_set_val((unsigned long *)regs, index, addr + 4);
 
-static inline bool rv_insn_reg_set_val(struct pt_regs *regs, u32 index,
-				       unsigned long val)
-{
-	if (index == 0)
-		return true;
-	else if (index <= 31)
-		*((unsigned long *)regs + index) = val;
-	else
-		return false;
+	instruction_pointer_set(regs, addr + imm);
 
 	return true;
 }
 
-bool __kprobes simulate_jal(u32 opcode, unsigned long addr, struct pt_regs *regs)
+bool __kprobes simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs)
 {
-	/*
-	 *     31    30       21    20     19        12 11 7 6      0
-	 * imm [20] | imm[10:1] | imm[11] | imm[19:12] | rd | opcode
-	 *     1         10          1           8       5    JAL/J
-	 */
-	bool ret;
-	s32 imm;
-	u32 index = RV_EXTRACT_RD_REG(opcode);
+	unsigned long base_addr;
+	s32 imm = riscv_insn_jalr_extract_imm(opcode);
+	u32 rd_index = riscv_insn_jalr_extract_xd(opcode);
+	u32 rs1_index = riscv_insn_jalr_extract_xs1(opcode);
 
-	ret = rv_insn_reg_set_val(regs, index, addr + 4);
-	if (!ret)
-		return ret;
+	base_addr = riscv_insn_reg_get_val((unsigned long *)regs, rs1_index);
 
-	imm = RV_EXTRACT_JTYPE_IMM(opcode);
+	riscv_insn_reg_set_val((unsigned long *)regs, rd_index, addr  + 4);
 
-	instruction_pointer_set(regs, addr + imm);
+	instruction_pointer_set(regs, (base_addr + imm) & ~1);
 
-	return ret;
+	return true;
 }
 
-bool __kprobes simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs)
+bool __kprobes simulate_auipc(u32 opcode, unsigned long addr, struct pt_regs *regs)
 {
-	/*
-	 * 31          20 19 15 14 12 11 7 6      0
-	 *  offset[11:0] | rs1 | 010 | rd | opcode
-	 *      12         5      3    5    JALR/JR
-	 */
-	bool ret;
-	unsigned long base_addr;
-	u32 imm = RV_EXTRACT_ITYPE_IMM(opcode);
-	u32 rd_index = RV_EXTRACT_RD_REG(opcode);
-	u32 rs1_index = RV_EXTRACT_RS1_REG(opcode);
+	u32 rd_index = riscv_insn_auipc_extract_xd(opcode);
+	unsigned long rd_val = addr + (s32)riscv_insn_auipc_extract_imm(opcode);
 
-	ret = rv_insn_reg_get_val(regs, rs1_index, &base_addr);
-	if (!ret)
-		return ret;
+	riscv_insn_reg_set_val((unsigned long *)regs, rd_index, rd_val);
 
-	ret = rv_insn_reg_set_val(regs, rd_index, addr + 4);
-	if (!ret)
-		return ret;
-
-	instruction_pointer_set(regs, (base_addr + sign_extend32((imm), 11))&~1);
+	instruction_pointer_set(regs, addr + 4);
 
-	return ret;
+	return true;
 }
 
-bool __kprobes simulate_auipc(u32 opcode, unsigned long addr, struct pt_regs *regs)
+bool __kprobes simulate_beq(u32 opcode, unsigned long addr, struct pt_regs *regs)
 {
-	/*
-	 * auipc instruction:
-	 *  31        12 11 7 6      0
-	 * | imm[31:12] | rd | opcode |
-	 *        20       5     7
-	 */
+	unsigned long next_addr;
 
-	u32 rd_idx = RV_EXTRACT_RD_REG(opcode);
-	unsigned long rd_val = addr + (s32)RV_EXTRACT_UTYPE_IMM(opcode);
+	next_addr = riscv_insn_branch(beq, (unsigned long *)regs, opcode, addr, ==, unsigned long);
+	instruction_pointer_set(regs, next_addr);
 
-	if (!rv_insn_reg_set_val(regs, rd_idx, rd_val))
-		return false;
+	return true;
+}
 
-	instruction_pointer_set(regs, addr + 4);
+bool __kprobes simulate_bne(u32 opcode, unsigned long addr, struct pt_regs *regs)
+{
+	unsigned long next_addr;
+
+	next_addr = riscv_insn_branch(bne, (unsigned long *)regs, opcode, addr, !=, unsigned long);
+	instruction_pointer_set(regs, next_addr);
 
 	return true;
 }
 
-bool __kprobes simulate_branch(u32 opcode, unsigned long addr, struct pt_regs *regs)
+bool __kprobes simulate_blt(u32 opcode, unsigned long addr, struct pt_regs *regs)
 {
-	/*
-	 * branch instructions:
-	 *      31    30       25 24 20 19 15 14    12 11       8    7      6      0
-	 * | imm[12] | imm[10:5] | rs2 | rs1 | funct3 | imm[4:1] | imm[11] | opcode |
-	 *     1           6        5     5      3         4         1         7
-	 *     imm[12|10:5]        rs2   rs1    000       imm[4:1|11]       1100011  BEQ
-	 *     imm[12|10:5]        rs2   rs1    001       imm[4:1|11]       1100011  BNE
-	 *     imm[12|10:5]        rs2   rs1    100       imm[4:1|11]       1100011  BLT
-	 *     imm[12|10:5]        rs2   rs1    101       imm[4:1|11]       1100011  BGE
-	 *     imm[12|10:5]        rs2   rs1    110       imm[4:1|11]       1100011  BLTU
-	 *     imm[12|10:5]        rs2   rs1    111       imm[4:1|11]       1100011  BGEU
-	 */
-
-	s32 offset;
-	s32 offset_tmp;
-	unsigned long rs1_val;
-	unsigned long rs2_val;
-
-	if (!rv_insn_reg_get_val(regs, RV_EXTRACT_RS1_REG(opcode), &rs1_val) ||
-	    !rv_insn_reg_get_val(regs, RV_EXTRACT_RS2_REG(opcode), &rs2_val))
-		return false;
-
-	offset_tmp = RV_EXTRACT_BTYPE_IMM(opcode);
-	switch (RV_EXTRACT_FUNCT3(opcode)) {
-	case RVG_FUNCT3_BEQ:
-		offset = (rs1_val == rs2_val) ? offset_tmp : 4;
-		break;
-	case RVG_FUNCT3_BNE:
-		offset = (rs1_val != rs2_val) ? offset_tmp : 4;
-		break;
-	case RVG_FUNCT3_BLT:
-		offset = ((long)rs1_val < (long)rs2_val) ? offset_tmp : 4;
-		break;
-	case RVG_FUNCT3_BGE:
-		offset = ((long)rs1_val >= (long)rs2_val) ? offset_tmp : 4;
-		break;
-	case RVG_FUNCT3_BLTU:
-		offset = (rs1_val < rs2_val) ? offset_tmp : 4;
-		break;
-	case RVG_FUNCT3_BGEU:
-		offset = (rs1_val >= rs2_val) ? offset_tmp : 4;
-		break;
-	default:
-		return false;
-	}
+	unsigned long next_addr;
 
-	instruction_pointer_set(regs, addr + offset);
+	next_addr = riscv_insn_branch(blt, (unsigned long *)regs, opcode, addr, <, long);
+	instruction_pointer_set(regs, next_addr);
 
 	return true;
 }
 
-bool __kprobes simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs)
+bool __kprobes simulate_bge(u32 opcode, unsigned long addr, struct pt_regs *regs)
 {
-	s32 offset = RVC_EXTRACT_JTYPE_IMM(opcode);
+	unsigned long next_addr;
 
-	instruction_pointer_set(regs, addr + offset);
+	next_addr = riscv_insn_branch(bge, (unsigned long *)regs, opcode, addr, >=, long);
+	instruction_pointer_set(regs, next_addr);
 
 	return true;
 }
 
-static bool __kprobes simulate_c_jr_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs,
-					 bool is_jalr)
+bool __kprobes simulate_bltu(u32 opcode, unsigned long addr, struct pt_regs *regs)
 {
-	/*
-	 *  15    12 11  7 6   2 1  0
-	 * | funct4 | rs1 | rs2 | op |
-	 *     4       5     5    2
-	 */
+	unsigned long next_addr;
+
+	next_addr = riscv_insn_branch(bltu, (unsigned long *)regs, opcode, addr, <, unsigned long);
+	instruction_pointer_set(regs, next_addr);
 
-	unsigned long jump_addr;
+	return true;
+}
 
-	u32 rs1 = RVC_EXTRACT_C2_RS1_REG(opcode);
+bool __kprobes simulate_bgeu(u32 opcode, unsigned long addr, struct pt_regs *regs)
+{
+	unsigned long next_addr;
 
-	if (rs1 == 0) /* C.JR is only valid when rs1 != x0 */
-		return false;
+	next_addr = riscv_insn_branch(bgeu, (unsigned long *)regs, opcode, addr, >=, unsigned long);
+	instruction_pointer_set(regs, next_addr);
 
-	if (!rv_insn_reg_get_val(regs, rs1, &jump_addr))
-		return false;
+	return true;
+}
 
-	if (is_jalr && !rv_insn_reg_set_val(regs, 1, addr + 2))
-		return false;
+bool __kprobes simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs)
+{
+	s32 offset = riscv_insn_c_j_extract_imm(opcode);
 
-	instruction_pointer_set(regs, jump_addr);
+	instruction_pointer_set(regs, addr + offset);
 
 	return true;
 }
 
 bool __kprobes simulate_c_jr(u32 opcode, unsigned long addr, struct pt_regs *regs)
 {
-	return simulate_c_jr_jalr(opcode, addr, regs, false);
+	unsigned long next_addr;
+	unsigned long *regs_ptr = (unsigned long *)regs;
+
+	/* xs1 == 0 is invalid so riscv_insn_reg_get_val() isn't needed */
+	next_addr = regs_ptr[riscv_insn_c_jr_extract_xs1(opcode)];
+	instruction_pointer_set(regs, next_addr);
+
+	return true;
 }
 
 bool __kprobes simulate_c_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs)
 {
-	return simulate_c_jr_jalr(opcode, addr, regs, true);
+	unsigned long next_addr;
+	unsigned long *regs_ptr = (unsigned long *)regs;
+
+	/* xs1 == 0 is invalid so riscv_insn_reg_get_val() isn't needed */
+	next_addr = regs_ptr[riscv_insn_c_jalr_extract_xs1(opcode)];
+	instruction_pointer_set(regs, next_addr);
+
+	regs->ra = addr + 2;
+	return true;
 }
 
-static bool __kprobes simulate_c_bnez_beqz(u32 opcode, unsigned long addr, struct pt_regs *regs,
-					   bool is_bnez)
+bool __kprobes simulate_c_bnez(u32 opcode, unsigned long addr, struct pt_regs *regs)
 {
-	/*
-	 *  15    13 12           10 9    7 6                 2 1  0
-	 * | funct3 | offset[8|4:3] | rs1' | offset[7:6|2:1|5] | op |
-	 *     3            3          3             5           2
-	 */
-
-	s32 offset;
 	u32 rs1;
-	unsigned long rs1_val;
+	unsigned long offset;
+	unsigned long *regs_ptr = (unsigned long *)regs;
 
-	rs1 = 0x8 | ((opcode >> 7) & 0x7);
-
-	if (!rv_insn_reg_get_val(regs, rs1, &rs1_val))
-		return false;
-
-	if ((rs1_val != 0 && is_bnez) || (rs1_val == 0 && !is_bnez))
-		offset = RVC_EXTRACT_BTYPE_IMM(opcode);
+	rs1 = riscv_insn_c_bnez_extract_xs1(opcode);
+	if (regs_ptr[8 + rs1] != 0)
+		offset = riscv_insn_c_bnez_extract_imm(opcode);
 	else
 		offset = 2;
 
@@ -228,12 +158,19 @@ static bool __kprobes simulate_c_bnez_beqz(u32 opcode, unsigned long addr, struc
 	return true;
 }
 
-bool __kprobes simulate_c_bnez(u32 opcode, unsigned long addr, struct pt_regs *regs)
-{
-	return simulate_c_bnez_beqz(opcode, addr, regs, true);
-}
-
 bool __kprobes simulate_c_beqz(u32 opcode, unsigned long addr, struct pt_regs *regs)
 {
-	return simulate_c_bnez_beqz(opcode, addr, regs, false);
+	u32 rs1;
+	unsigned long offset;
+	unsigned long *regs_ptr = (unsigned long *)regs;
+
+	rs1 = riscv_insn_c_beqz_extract_xs1(opcode);
+	if (regs_ptr[8 + rs1] == 0)
+		offset = riscv_insn_c_beqz_extract_imm(opcode);
+	else
+		offset = 2;
+
+	instruction_pointer_set(regs, addr + offset);
+
+	return true;
 }
diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
index 44ebbc444db9..f2f707e92dee 100644
--- a/arch/riscv/kernel/probes/simulate-insn.h
+++ b/arch/riscv/kernel/probes/simulate-insn.h
@@ -21,7 +21,12 @@
 	} while (0)
 
 bool simulate_auipc(u32 opcode, unsigned long addr, struct pt_regs *regs);
-bool simulate_branch(u32 opcode, unsigned long addr, struct pt_regs *regs);
+bool simulate_beq(u32 opcode, unsigned long addr, struct pt_regs *regs);
+bool simulate_bne(u32 opcode, unsigned long addr, struct pt_regs *regs);
+bool simulate_blt(u32 opcode, unsigned long addr, struct pt_regs *regs);
+bool simulate_bge(u32 opcode, unsigned long addr, struct pt_regs *regs);
+bool simulate_bltu(u32 opcode, unsigned long addr, struct pt_regs *regs);
+bool simulate_bgeu(u32 opcode, unsigned long addr, struct pt_regs *regs);
 bool simulate_jal(u32 opcode, unsigned long addr, struct pt_regs *regs);
 bool simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs);
 bool simulate_c_j(u32 opcode, unsigned long addr, struct pt_regs *regs);

-- 
2.54.0

