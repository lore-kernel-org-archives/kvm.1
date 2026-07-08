Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C2637998B
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481786; cv=none; b=tC2INIpFFTp2lJAHxVbxH27+05+sNsDNvQN4zXnCf9qVIFbSYwSUtJt8Sm76low6zdEE3F7P9SXnacwdKMTnpAtk4za3le14O1qnKEH76VEoRUvvADWS/jtbQ0QNr1FqqgSD0fBlnKth+f8ZE53oVFOnRkcM7X067ebhgO5nt7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481786; c=relaxed/simple;
	bh=/mGMT1v7H7ryJQYOPUJnYKV/ZslC9IYBB4cPOktM6Oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XUFL2Fuu/7Dquuh/j58x3AKgjdynh23iGYQrtd6Snk1rCu9r5lOEngkTmMQECmiH6ReX1W5Ivbfmudcex/Ob0xY4CE2TBC0pJXk3A3WAytVyg/spY0Pk7oEKpHo0PiYuOZh08pDBtDkx8uBOdQ/xBNV0HIVRe6cyrzP3q9EHGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmOZMveQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmOZMveQ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c7c61b5292so4961665ad.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 20:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783481783; x=1784086583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rhDw/6L+TZLtvHPPBhD5FTnHIpFKKZXbKXqoSYpJYxA=;
        b=DmOZMveQDMf1R8UMcwcEQu+q+f2ZWOwrv+o0YLcwEmepaRiqq603ObhYH6mWerVf8U
         Upcno0zAj2gA5lrfErJDATDSpxIGviWjT9AGEdqCCD6F4H3pclrhWBK4x+y4YlKBjgPC
         IO1JaT0GP2n71uIE0cOMeqUsPtaxNHHGRpGUml56uDS+lO6kcJ3EXLpyU4XTx8fPboFO
         kG23X2PwzcymKds3JgZGD4YlsdmJLGVLqi4IvUAHN2CZUnRbVlQ8vgcKHpOTqC3EFq4v
         K3jrePLn9EdRofx/BXWKdkRC0JdBL0FPRAC6ksK7xE6VjXMw/ewJvWzf93WOYwQ7cby2
         PaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481783; x=1784086583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhDw/6L+TZLtvHPPBhD5FTnHIpFKKZXbKXqoSYpJYxA=;
        b=UD3JpDfl8GetMgq8XVN7yikdQVmZUIhfxfaIm629jiNtiGOcdgh35nFIlyDOq0tp7b
         xyAe/Dkqi6QC5L/zHNrc5cT+VNckkhEaEVRlrW5u4Z0tE1W6byFbc2h4WUlE0yFrP11r
         ZOi71J5aGSbSEHP2qC9X4blqd1soCs2D9lPFrpnlM1371t9z/64hjtQ9epoWqKu9nDid
         H1mK587hJSs0Sibu8BR4LtmVOVes3bEL/ssbses5Kr5JeoSRRHlKVC0Sx9IdkkKNNrgn
         TMr4S2anFVMcRxseL1HzXDVI2b8eNgvNsMn06y8+XuyOSGb+D+tu+Pck+ewRXQiwhzvX
         mIvw==
X-Forwarded-Encrypted: i=1; AHgh+RrOttbBqnbc4/e4NyGP3k9YAqDlbd/pyYHh1jhzZwGqrE6WE7PKABMUqSmUtKguKuVJDtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk/lfH624yPoKdi1nyLAhNWvbkweWI+Y2Bw73sZalT4Uv1W/S7
	r08zyz24CyCIQWLUJX/1MdK6pigGERmXMBNMQnYwQ8ug1XbuSCafEOat
X-Gm-Gg: AfdE7cl8OVwHnj01TtP1qyC93RlyuTuaB+JWxnhKRy11o6/O2Iae82UxUcxY1NRuKwo
	E4qx9fFl0fKkf/GlZ+B9p/zU9SNO6qWMOe+S7c+sQz9fT3UIU4zvfbcZyEevPfQ6HfXMig1N0Eu
	RMLim/hGUNYStT+0QDksEI/F6WKFZY5OWePMiOmMGbr+pwJkltDdHfgwPPSJeR5ltwg+975MmCW
	jAZJGbzHkWIbdUzygZw85aVUB6RlZS28wNXpXhBS59TqUQKqWJbj0qgj+N8QsHvau7CPsB5mBNx
	ptEKIakFkI1lBMTcRluPX0pZgEBumQAdSoGAgtUDAgt3s2lOfxNgJSSWOGiLT9sVLzPlhJT7bnC
	z28P2Rucct2reUFaGDfuI5Vbyl/ZCvHLuXrH9dsd4GvAQga0Gvq3OqfDjD1tuLqVkWv/y8Q/G4i
	EaIBVKXnnp5RNqQVydcO3mFrltpVQ8R4jVfR6eX6o=
X-Received: by 2002:a05:6a20:3d0c:b0:3b4:93b9:2b91 with SMTP id adf61e73a8af0-3c0bcf16364mr637734637.12.1783481782784;
        Tue, 07 Jul 2026 20:36:22 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm21092850eec.29.2026.07.07.20.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:36:22 -0700 (PDT)
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Date: Tue, 07 Jul 2026 20:34:25 -0700
Subject: [PATCH v3 02/17] riscv: alternatives: Use generated instruction
 headers for patching code
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-riscv_insn_table-v3-2-3f8e5f75ba97@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783481777; l=7624;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=/mGMT1v7H7ryJQYOPUJnYKV/ZslC9IYBB4cPOktM6Oo=;
 b=e8bI9wklaU/9ul8UJWwZF5PYDwtXiPtCzuAV+L08M3Fv25bkjIl7li3QDgxaI6e2+O7fJNUMy
 yum6AxIuRxJBWVmIFA1eRmXPQaB1gU8b1e2MPbL6fWUFncPwZkWvAdl
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

Migrate the alternatives patching code to use the generated instruction
headers instead of the hand-written instruction composition functions.

Reviewed-by: Jesse Taube <jtaubepe@redhat.com>
Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

---

These function expansions are very simple and almost expand to the same
thing in the new and old version. The main difference is
riscv_insn_auipc_extract_imm() in the new version expands to:

((_insn >> 12 & GENMASK(19, 0)) << 12)

while it expands to the following in the old version:

((_insn >> 0) & GENMASK(31, 12))

These are the same thing, but GCC is unable to properly optimize the
second one so the first one ends up using almost half as many
instructions. With this finding and other similar examples, I made
the generated headers construct in the first way to help GCC optimize
all of these functions.

Brute force can also be checked with this code:

void check_auipc_jalr() {
	for (unsigned int auipc = 0; auipc < ((1ULL << 12) - 1); auipc++) {
		for (unsigned int jalr = 0; jalr < ((1ULL << 20) - 1); jalr++) {
			unsigned int auipc_t=riscv_insn_auipc(auipc, 0), jalr_t=riscv_insn_jalr(jalr, 0, 0), auipc_t2=riscv_insn_auipc(auipc, 0), jalr_t2=riscv_insn_jalr(jalr, 0, 0);
			riscv_alternative_fix_auipc_jalr(&auipc_t, &jalr_t, 0);
			riscv_alternative_fix_auipc_jalr2(&auipc_t2, &jalr_t2, 0);

			if (auipc_t != auipc_t2) {
				printf("auipcs don't match %u, %u: %u != %u\n", auipc, jalr, auipc_t, auipc_t2);
				return;
			}

			if (jalr_t != jalr_t2) {
				printf("jalrs don't match %u: %u != %u\n", i, jalr_t, jalr_t2);
			}
		}
	}
}
---
 arch/riscv/include/asm/insn.h   | 74 -----------------------------------------
 arch/riscv/kernel/alternative.c | 23 +++++++++----
 2 files changed, 17 insertions(+), 80 deletions(-)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index d562b2b40ba1..d0e137f9bcd7 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -514,78 +514,4 @@ static __always_inline bool riscv_insn_is_branch(u32 code)
 
 #define RVV_EXTRACT_VL_VS_WIDTH(x) RVFDQ_EXTRACT_FL_FS_WIDTH(x)
 
-/*
- * Get the immediate from a J-type instruction.
- *
- * @insn: instruction to process
- * Return: immediate
- */
-static inline s32 riscv_insn_extract_jtype_imm(u32 insn)
-{
-	return RV_EXTRACT_JTYPE_IMM(insn);
-}
-
-/*
- * Update a J-type instruction with an immediate value.
- *
- * @insn: pointer to the jtype instruction
- * @imm: the immediate to insert into the instruction
- */
-static inline void riscv_insn_insert_jtype_imm(u32 *insn, s32 imm)
-{
-	/* drop the old IMMs, all jal IMM bits sit at 31:12 */
-	*insn &= ~GENMASK(31, 12);
-	*insn |= (RV_X_MASK(imm, RV_J_IMM_10_1_OFF, RV_J_IMM_10_1_MASK) << RV_J_IMM_10_1_OPOFF) |
-		 (RV_X_MASK(imm, RV_J_IMM_11_OFF, RV_J_IMM_11_MASK) << RV_J_IMM_11_OPOFF) |
-		 (RV_X_MASK(imm, RV_J_IMM_19_12_OFF, RV_J_IMM_19_12_MASK) << RV_J_IMM_19_12_OPOFF) |
-		 (RV_X_MASK(imm, RV_J_IMM_SIGN_OFF, 1) << RV_J_IMM_SIGN_OPOFF);
-}
-
-/*
- * Put together one immediate from a U-type and I-type instruction pair.
- *
- * The U-type contains an upper immediate, meaning bits[31:12] with [11:0]
- * being zero, while the I-type contains a 12bit immediate.
- * Combined these can encode larger 32bit values and are used for example
- * in auipc + jalr pairs to allow larger jumps.
- *
- * @utype_insn: instruction containing the upper immediate
- * @itype_insn: instruction
- * Return: combined immediate
- */
-static inline s32 riscv_insn_extract_utype_itype_imm(u32 utype_insn, u32 itype_insn)
-{
-	s32 imm;
-
-	imm = RV_EXTRACT_UTYPE_IMM(utype_insn);
-	imm += RV_EXTRACT_ITYPE_IMM(itype_insn);
-
-	return imm;
-}
-
-/*
- * Update a set of two instructions (U-type + I-type) with an immediate value.
- *
- * Used for example in auipc+jalrs pairs the U-type instructions contains
- * a 20bit upper immediate representing bits[31:12], while the I-type
- * instruction contains a 12bit immediate representing bits[11:0].
- *
- * This also takes into account that both separate immediates are
- * considered as signed values, so if the I-type immediate becomes
- * negative (BIT(11) set) the U-type part gets adjusted.
- *
- * @utype_insn: pointer to the utype instruction of the pair
- * @itype_insn: pointer to the itype instruction of the pair
- * @imm: the immediate to insert into the two instructions
- */
-static inline void riscv_insn_insert_utype_itype_imm(u32 *utype_insn, u32 *itype_insn, s32 imm)
-{
-	/* drop possible old IMM values */
-	*utype_insn &= ~(RV_U_IMM_31_12_MASK);
-	*itype_insn &= ~(RV_I_IMM_11_0_MASK << RV_I_IMM_11_0_OPOFF);
-
-	/* add the adapted IMMs */
-	*utype_insn |= (imm & RV_U_IMM_31_12_MASK) + ((imm & BIT(11)) << 1);
-	*itype_insn |= ((imm & RV_I_IMM_11_0_MASK) << RV_I_IMM_11_0_OPOFF);
-}
 #endif /* _ASM_RISCV_INSN_H */
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 7642704c7f18..5e9a74ed97e9 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -11,6 +11,7 @@
 #include <linux/cpu.h>
 #include <linux/uaccess.h>
 #include <asm/alternative.h>
+#include <asm/insn.h>
 #include <asm/module.h>
 #include <asm/sections.h>
 #include <asm/vdso.h>
@@ -78,14 +79,24 @@ static void riscv_alternative_fix_auipc_jalr(void *ptr, u32 auipc_insn,
 					     u32 jalr_insn, int patch_offset)
 {
 	u32 call[2] = { auipc_insn, jalr_insn };
+	u32 auipc_imm;
 	s32 imm;
 
 	/* get and adjust new target address */
-	imm = riscv_insn_extract_utype_itype_imm(auipc_insn, jalr_insn);
+	imm = riscv_insn_auipc_extract_imm(auipc_insn) + riscv_insn_jalr_extract_imm(jalr_insn);
 	imm -= patch_offset;
 
+	/*
+	 * When the 32-bit immediate is split across auipc and jalr, the
+	 * constructed immediates need to be treated as individually sign
+	 * extended numbers. Add the sign bit of the lower 12 bits to the upper
+	 * 20 bits to undo the bleeding of the sign.
+	 */
+	auipc_imm = (imm & BIT(11)) << 1;
+
 	/* update instructions */
-	riscv_insn_insert_utype_itype_imm(&call[0], &call[1], imm);
+	riscv_insn_auipc_insert_imm(&call[0], auipc_imm);
+	riscv_insn_jalr_insert_imm(&call[1], imm);
 
 	/* patch the call place again */
 	patch_text_nosync(ptr, call, sizeof(u32) * 2);
@@ -96,11 +107,11 @@ static void riscv_alternative_fix_jal(void *ptr, u32 jal_insn, int patch_offset)
 	s32 imm;
 
 	/* get and adjust new target address */
-	imm = riscv_insn_extract_jtype_imm(jal_insn);
+	imm = riscv_insn_jal_extract_imm(jal_insn);
 	imm -= patch_offset;
 
 	/* update instruction */
-	riscv_insn_insert_jtype_imm(&jal_insn, imm);
+	riscv_insn_jal_insert_imm(&jal_insn, imm);
 
 	/* patch the call place again */
 	patch_text_nosync(ptr, &jal_insn, sizeof(u32));
@@ -127,7 +138,7 @@ void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
 				continue;
 
 			/* if instruction pair is a call, it will use the ra register */
-			if (RV_EXTRACT_RD_REG(insn) != 1)
+			if (riscv_insn_jalr_extract_xd(insn) != 1)
 				continue;
 
 			riscv_alternative_fix_auipc_jalr(alt_ptr + i * sizeof(u32),
@@ -136,7 +147,7 @@ void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
 		}
 
 		if (riscv_insn_is_jal(insn)) {
-			s32 imm = riscv_insn_extract_jtype_imm(insn);
+			s32 imm = riscv_insn_jal_extract_imm(insn);
 
 			/* Don't modify jumps inside the alternative block */
 			if ((alt_ptr + i * sizeof(u32) + imm) >= alt_ptr &&

-- 
2.54.0

