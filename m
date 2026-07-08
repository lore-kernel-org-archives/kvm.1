Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2BD3BD225
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481796; cv=none; b=usdSJi9fXICRCuJYr5MmPTksRYjWPcSn+EYhWWFBjOabgTKBLPkOEAYfXO+JM3dDoxeHL378PVeLg/IxF+LEMe93l8y/4jNVXA90IeXp6wOJwW4PTHKhZGBPbP1/JPPMwLxIIhahRikpNDFerX8iryv3Xu/J3NmL45HufOwx3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481796; c=relaxed/simple;
	bh=sxLtVDSOFNa/G4iQ6MMmQTH9uBA/e/XtcS9fjLnlddk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaKDSQEOq5Yw83JB+yMzn680abLQYAvP9KT70s/1T4BQcmfkKRFzP++Uhr7E+mtfv5fIs/oMUZvDiwR4lkpHpwyjTwWrHg6AxQN1lZTaxi9YV2tnTRdMyNGwNnMZUNsw4oEueztLVbD0AORT8s1+/Yd5QIGQVFCriluKWWAXZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrBwH/Ou; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrBwH/Ou"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-384c94c9414so199462a91.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 20:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783481793; x=1784086593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XuL5cndtDjBcVPpgbJ+RzvkeL6t9sknxgo0zZEVVPzo=;
        b=LrBwH/OuUR9deODoxxhR3TdJzHxRnO4i7aW15RgMv35KBSFzSp6dGfjowyg6K/KHRN
         8BKfTnoW9C/5ZD2tGORJwtf3voOirn6eDxFQ/J2DQx2fa18EgA8cxCz4F5D5Z7R2fUPL
         espzRftKH8g7KcR2TslvAtuWz6OTYQihyopjONZUpvcqz3jelx68D2+XLlOK6PLQXCZb
         mQcveOlZu0a3ElfLEwAq7U4A0gm85lnlTea0D6t5r6vN30kXnECMDsWTQpxswzxNKEk8
         i9tnbbnfN7UTjMEOJD4N8qRqQ1qwbIuIBPdXt19Qu0Fhyk4H1a4ZNOKcRVLoQHAA2oCC
         iW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481793; x=1784086593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XuL5cndtDjBcVPpgbJ+RzvkeL6t9sknxgo0zZEVVPzo=;
        b=kEdRn9XMf54ebDajSNmGjIEvBoiZUCOIufK37xHMCyYCwX4aCC4H2fDE6c4jJX28iI
         atk3TtP9yFRQ+upoWJKq6hQUN0suEegueHnEtHSbWm3WyrkLrjqEzNTdLCxh6DlZeMkH
         Y7tGdVBuEkeGTBkqq/+62pUlHv6U/yWhW+D/7IAObUlBKJtqWTUnjHAC7H8AxJ+ETY6Q
         ln0V2h62i/vWD/gXHB4M4zGCH4vQrfMliKalau3jYV0XB4hnkiCgVofblwXu3RIJn78S
         NZg1YuFHUejN0bdqUTCib9M2R3zhXvM6DWsdzB0ywSlux9at1ZP7i/Tz6rl8YL5AG0YS
         tZNw==
X-Forwarded-Encrypted: i=1; AHgh+RoghXK8/hRBO/n3GTs42kkM+iMql3A9HgFUPDdrW5lt7iMF7EvC9r3tWp4bV/53FKjD3X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweOUTF93jRG9mRI0s+znx23rCnpD662ezWuzBHtVfXZQXh27aa
	0q4rHB5pVWTiBALHHqiNcijD2r0Rq1z4YLUk6Ro9XF1OiEX9/QronCJg
X-Gm-Gg: AfdE7ckmrIcXbCiVlDSLO3u+mwor4cRMM1PDukHCIESaZFjr/wQ1DZeUh4DUaPGAaif
	4XVsYRe8myDmn07mDNQK83CPxcOMF8ANxa2EeBqN9TvFchC+vpqQPSzYhJhcWtqjaTjMtXXxdOj
	92LN8983cSUW6idAMAHFCPrm2hRU6cVwfrncJvt+TG238RIuTDYMesd1ibtoVEkBpRnPz6H03xc
	AWJfIssD4N5kiaBL1qo34Jf34yp/pCuTZJd2imqUNN5I7h0srz4+NFOUdborKPOACIhAiJyP8xV
	8cvSjGzmy6qVmnXWX+3vGwMtN1zzuE0XFjtFWj9hg+4TXANYq5inMPnQCIej7fVwe9JQeNz/DYc
	xbKGgVrQ+WN8u3cb471bgwHRWROCZCl/GQ2QrT9H2ySxlLVJANRbMFx84Da65UOvk9l0NwZFwI+
	9ZnHVlyvKlS1z+PTHe75ttRipK4XkrrcNIAFe/YyGRpjyHI2NQUA==
X-Received: by 2002:a05:6a21:4516:b0:39c:235:c5ec with SMTP id adf61e73a8af0-3c0bc9d0fbcmr684699637.34.1783481792993;
        Tue, 07 Jul 2026 20:36:32 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm21092850eec.29.2026.07.07.20.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:36:32 -0700 (PDT)
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Date: Tue, 07 Jul 2026 20:34:31 -0700
Subject: [PATCH v3 08/17] riscv: Use generated instruction headers for
 misaligned loads/stores
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-riscv_insn_table-v3-8-3f8e5f75ba97@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783481777; l=13216;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=sxLtVDSOFNa/G4iQ6MMmQTH9uBA/e/XtcS9fjLnlddk=;
 b=bUmzwV+6NqMTkJe5SGVTjMDWe5ErNckgKrdmp3FdCB4yh2hC9ITsfAVF4B59OY1guEPytgE49
 JJWPOcpJqqPDg1DvdfmL/Ul+zJ3lBpKe8O4k1S1QhltHT0tPvUC5zQ3
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

Migrate the misaligned loads/store code to use the generated instruction
headers instead of the hand-written instruction composition functions.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

---

Similar to the other patches of this series, I extracted out the logic
of this function and brute forced all possible inputs to validate that
the outputs are the same. To verify this change in the kernel, I booted
on Spike and used the misaligned access checker which does some
misaligned accesses.
---
 arch/riscv/kernel/traps_misaligned.c | 205 +++++++++++++++++------------------
 1 file changed, 97 insertions(+), 108 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 524215a186e0..ca9a3da3d24f 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -22,15 +22,11 @@
 
 #ifdef CONFIG_FPU
 
-#define FP_GET_RD(insn)		(insn >> 7 & 0x1F)
-
 extern void put_f32_reg(unsigned long fp_reg, unsigned long value);
 
-static int set_f32_rd(unsigned long insn, struct pt_regs *regs,
+static int set_f32_rd(unsigned long fp_reg, struct pt_regs *regs,
 		      unsigned long val)
 {
-	unsigned long fp_reg = FP_GET_RD(insn);
-
 	put_f32_reg(fp_reg, val);
 	regs->status |= SR_FS_DIRTY;
 
@@ -39,9 +35,8 @@ static int set_f32_rd(unsigned long insn, struct pt_regs *regs,
 
 extern void put_f64_reg(unsigned long fp_reg, unsigned long value);
 
-static int set_f64_rd(unsigned long insn, struct pt_regs *regs, u64 val)
+static int set_f64_rd(unsigned long fp_reg, struct pt_regs *regs, u64 val)
 {
-	unsigned long fp_reg = FP_GET_RD(insn);
 	unsigned long value;
 
 #if __riscv_xlen == 32
@@ -58,10 +53,8 @@ static int set_f64_rd(unsigned long insn, struct pt_regs *regs, u64 val)
 #if __riscv_xlen == 32
 extern void get_f64_reg(unsigned long fp_reg, u64 *value);
 
-static u64 get_f64_rs(unsigned long insn, u8 fp_reg_offset,
-		      struct pt_regs *regs)
+static u64 get_f64_rs(unsigned long fp_reg, struct pt_regs *regs)
 {
-	unsigned long fp_reg = (insn >> fp_reg_offset) & 0x1F;
 	u64 val;
 
 	get_f64_reg(fp_reg, &val);
@@ -73,10 +66,8 @@ static u64 get_f64_rs(unsigned long insn, u8 fp_reg_offset,
 
 extern unsigned long get_f64_reg(unsigned long fp_reg);
 
-static unsigned long get_f64_rs(unsigned long insn, u8 fp_reg_offset,
-				struct pt_regs *regs)
+static unsigned long get_f64_rs(unsigned long fp_reg, struct pt_regs *regs)
 {
-	unsigned long fp_reg = (insn >> fp_reg_offset) & 0x1F;
 	unsigned long val;
 
 	val = get_f64_reg(fp_reg);
@@ -89,10 +80,8 @@ static unsigned long get_f64_rs(unsigned long insn, u8 fp_reg_offset,
 
 extern unsigned long get_f32_reg(unsigned long fp_reg);
 
-static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
-				struct pt_regs *regs)
+static unsigned long get_f32_rs(unsigned long fp_reg, struct pt_regs *regs)
 {
-	unsigned long fp_reg = (insn >> fp_reg_offset) & 0x1F;
 	unsigned long val;
 
 	val = get_f32_reg(fp_reg);
@@ -107,28 +96,18 @@ static void set_f32_rd(unsigned long insn, struct pt_regs *regs,
 
 static void set_f64_rd(unsigned long insn, struct pt_regs *regs, u64 val) {}
 
-static unsigned long get_f64_rs(unsigned long insn, u8 fp_reg_offset,
-				struct pt_regs *regs)
+static unsigned long get_f64_rs(unsigned long fp_reg, struct pt_regs *regs)
 {
 	return 0;
 }
 
-static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
-				struct pt_regs *regs)
+static unsigned long get_f32_rs(unsigned long fp_reg, struct pt_regs *regs)
 {
 	return 0;
 }
 
 #endif
 
-#define GET_F64_RS2(insn, regs) (get_f64_rs(insn, 20, regs))
-#define GET_F64_RS2C(insn, regs) (get_f64_rs(insn, 2, regs))
-#define GET_F64_RS2S(insn, regs) (get_f64_rs(RVC_RS2S(insn), 0, regs))
-
-#define GET_F32_RS2(insn, regs) (get_f32_rs(insn, 20, regs))
-#define GET_F32_RS2C(insn, regs) (get_f32_rs(insn, 2, regs))
-#define GET_F32_RS2S(insn, regs) (get_f32_rs(RVC_RS2S(insn), 0, regs))
-
 #define __read_insn(regs, insn, insn_addr, type)	\
 ({							\
 	int __ret;					\
@@ -217,13 +196,13 @@ static int handle_vector_misaligned_load(struct pt_regs *regs)
 }
 #endif
 
-static int handle_scalar_misaligned_load(struct pt_regs *regs)
+static noinline int handle_scalar_misaligned_load(struct pt_regs *regs)
 {
 	union reg_data val;
 	unsigned long epc = regs->epc;
 	unsigned long insn;
 	unsigned long addr = regs->badaddr;
-	int fp = 0, shift = 0, len = 0;
+	int fp = 0, shift = 0, len = 0, rd = 0;
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
@@ -238,68 +217,71 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
-	if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
+	if (riscv_insn_is_lw(insn)) {
 		len = 4;
 		shift = 8 * (sizeof(unsigned long) - len);
-#if defined(CONFIG_64BIT)
-	} else if ((insn & INSN_MASK_LD) == INSN_MATCH_LD) {
+		rd = riscv_insn_lw_extract_xd(insn);
+	} else if (riscv_insn_is_ld(insn)) {
 		len = 8;
 		shift = 8 * (sizeof(unsigned long) - len);
-	} else if ((insn & INSN_MASK_LWU) == INSN_MATCH_LWU) {
+		rd = riscv_insn_ld_extract_xd(insn);
+	} else if (riscv_insn_is_lwu(insn)) {
 		len = 4;
-#endif
-	} else if ((insn & INSN_MASK_FLD) == INSN_MATCH_FLD) {
+		rd = riscv_insn_lwu_extract_xd(insn);
+	} else if (riscv_insn_is_fld(insn)) {
 		fp = 1;
 		len = 8;
-	} else if ((insn & INSN_MASK_FLW) == INSN_MATCH_FLW) {
+		rd = riscv_insn_fld_extract_fd(insn);
+	} else if (riscv_insn_is_flw(insn)) {
 		fp = 1;
 		len = 4;
-	} else if ((insn & INSN_MASK_LH) == INSN_MATCH_LH) {
+		rd = riscv_insn_flw_extract_fd(insn);
+	} else if (riscv_insn_is_lh(insn)) {
 		len = 2;
 		shift = 8 * (sizeof(unsigned long) - len);
-	} else if ((insn & INSN_MASK_LHU) == INSN_MATCH_LHU) {
+		rd = riscv_insn_lh_extract_xd(insn);
+	} else if (riscv_insn_is_lhu(insn)) {
 		len = 2;
-#if defined(CONFIG_64BIT)
-	} else if ((insn & INSN_MASK_C_LD) == INSN_MATCH_C_LD) {
+		rd = riscv_insn_lhu_extract_xd(insn);
+	} else if (riscv_insn_is_c_ld(insn)) {
 		len = 8;
 		shift = 8 * (sizeof(unsigned long) - len);
-		insn = RVC_RS2S(insn) << SH_RD;
-	} else if ((insn & INSN_MASK_C_LDSP) == INSN_MATCH_C_LDSP &&
-		   ((insn >> SH_RD) & 0x1f)) {
+		rd = (8 + riscv_insn_c_ld_extract_xd(insn));
+	} else if (riscv_insn_is_c_ldsp(insn)) {
 		len = 8;
 		shift = 8 * (sizeof(unsigned long) - len);
-#endif
-	} else if ((insn & INSN_MASK_C_LW) == INSN_MATCH_C_LW) {
+		rd = riscv_insn_c_ldsp_extract_xd(insn);
+	} else if (riscv_insn_is_c_lw(insn)) {
 		len = 4;
 		shift = 8 * (sizeof(unsigned long) - len);
-		insn = RVC_RS2S(insn) << SH_RD;
-	} else if ((insn & INSN_MASK_C_LWSP) == INSN_MATCH_C_LWSP &&
-		   ((insn >> SH_RD) & 0x1f)) {
+		rd = (8 + riscv_insn_c_lw_extract_xd(insn));
+	} else if (riscv_insn_is_c_lwsp(insn)) {
 		len = 4;
 		shift = 8 * (sizeof(unsigned long) - len);
-	} else if ((insn & INSN_MASK_C_FLD) == INSN_MATCH_C_FLD) {
+		rd = riscv_insn_c_lwsp_extract_xd(insn);
+	} else if (riscv_insn_is_c_fld(insn)) {
 		fp = 1;
 		len = 8;
-		insn = RVC_RS2S(insn) << SH_RD;
-	} else if ((insn & INSN_MASK_C_FLDSP) == INSN_MATCH_C_FLDSP) {
+		rd = (8 + riscv_insn_c_fld_extract_fd(insn));
+	} else if (riscv_insn_is_c_fldsp(insn)) {
 		fp = 1;
 		len = 8;
-#if defined(CONFIG_32BIT)
-	} else if ((insn & INSN_MASK_C_FLW) == INSN_MATCH_C_FLW) {
+		rd = riscv_insn_c_fldsp_extract_fd(insn);
+	} else if (riscv_insn_is_c_flw(insn)) {
 		fp = 1;
 		len = 4;
-		insn = RVC_RS2S(insn) << SH_RD;
-	} else if ((insn & INSN_MASK_C_FLWSP) == INSN_MATCH_C_FLWSP) {
+		rd = (8 + riscv_insn_c_flw_extract_fd(insn));
+	} else if (riscv_insn_is_c_flwsp(insn)) {
 		fp = 1;
 		len = 4;
-#endif
-	} else if ((insn & INSN_MASK_C_LHU) == INSN_MATCH_C_LHU) {
+		rd = riscv_insn_c_flwsp_extract_fd(insn);
+	} else if (riscv_insn_is_c_lhu(insn)) {
 		len = 2;
-		insn = RVC_RS2S(insn) << SH_RD;
-	} else if ((insn & INSN_MASK_C_LH) == INSN_MATCH_C_LH) {
+		rd = (8 + riscv_insn_c_lhu_extract_xd(insn));
+	} else if (riscv_insn_is_c_lh(insn)) {
 		len = 2;
-		shift = 8 * (sizeof(ulong) - len);
-		insn = RVC_RS2S(insn) << SH_RD;
+		shift = 8 * (sizeof(unsigned long) - len);
+		rd = (8 + riscv_insn_c_lh_extract_xd(insn));
 	} else {
 		return -1;
 	}
@@ -315,14 +297,16 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
 		memcpy(&val, (u8 *)addr, len);
 	}
 
-	if (!fp)
-		SET_RD(insn, regs, (long)(val.data_ulong << shift) >> shift);
-	else if (len == 8)
-		set_f64_rd(insn, regs, val.data_u64);
-	else
-		set_f32_rd(insn, regs, val.data_ulong);
+	if (rd) {
+		if (!fp)
+			*(unsigned long *)((unsigned long *)regs + rd) = (val.data_ulong << shift) >> shift;
+		else if (len == 8)
+			set_f64_rd(rd, regs, val.data_u64);
+		else
+			set_f32_rd(rd, regs, val.data_ulong);
 
-	regs->epc = epc + INSN_LEN(insn);
+		regs->epc = epc + INSN_LEN(insn);
+	}
 
 	return 0;
 }
@@ -333,7 +317,7 @@ static int handle_scalar_misaligned_store(struct pt_regs *regs)
 	unsigned long epc = regs->epc;
 	unsigned long insn;
 	unsigned long addr = regs->badaddr;
-	int len = 0, fp = 0;
+	int fp = 0, len = 0, rd = 0;
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
@@ -346,71 +330,76 @@ static int handle_scalar_misaligned_store(struct pt_regs *regs)
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
-	val.data_ulong = GET_RS2(insn, regs);
-
-	if ((insn & INSN_MASK_SW) == INSN_MATCH_SW) {
+	if (riscv_insn_is_sw(insn)) {
 		len = 4;
-#if defined(CONFIG_64BIT)
-	} else if ((insn & INSN_MASK_SD) == INSN_MATCH_SD) {
+		rd = riscv_insn_sw_extract_xs2(insn);
+	} else if (riscv_insn_is_sd(insn)) {
 		len = 8;
-#endif
-	} else if ((insn & INSN_MASK_FSD) == INSN_MATCH_FSD) {
+		rd = riscv_insn_sd_extract_xs2(insn);
+	} else if (riscv_insn_is_fsd(insn)) {
 		fp = 1;
 		len = 8;
-		val.data_u64 = GET_F64_RS2(insn, regs);
-	} else if ((insn & INSN_MASK_FSW) == INSN_MATCH_FSW) {
+		rd = riscv_insn_fsd_extract_fs2(insn);
+	} else if (riscv_insn_is_fsw(insn)) {
 		fp = 1;
 		len = 4;
-		val.data_ulong = GET_F32_RS2(insn, regs);
-	} else if ((insn & INSN_MASK_SH) == INSN_MATCH_SH) {
+		rd = riscv_insn_fsw_extract_fs2(insn);
+	} else if (riscv_insn_is_sh(insn)) {
 		len = 2;
-#if defined(CONFIG_64BIT)
-	} else if ((insn & INSN_MASK_C_SD) == INSN_MATCH_C_SD) {
+		rd = riscv_insn_sh_extract_xs2(insn);
+	} else if (riscv_insn_is_c_sd(insn)) {
 		len = 8;
-		val.data_ulong = GET_RS2S(insn, regs);
-	} else if ((insn & INSN_MASK_C_SDSP) == INSN_MATCH_C_SDSP) {
+		rd = (8 + riscv_insn_c_sd_extract_xs2(insn));
+	} else if (riscv_insn_is_c_sdsp(insn)) {
 		len = 8;
-		val.data_ulong = GET_RS2C(insn, regs);
-#endif
-	} else if ((insn & INSN_MASK_C_SW) == INSN_MATCH_C_SW) {
+		rd = riscv_insn_c_sdsp_extract_xs2(insn);
+	} else if (riscv_insn_is_c_sw(insn)) {
 		len = 4;
-		val.data_ulong = GET_RS2S(insn, regs);
-	} else if ((insn & INSN_MASK_C_SWSP) == INSN_MATCH_C_SWSP) {
+		rd = (8 + riscv_insn_c_sw_extract_xs2(insn));
+	} else if (riscv_insn_is_c_swsp(insn)) {
 		len = 4;
-		val.data_ulong = GET_RS2C(insn, regs);
-	} else if ((insn & INSN_MASK_C_FSD) == INSN_MATCH_C_FSD) {
+		rd = riscv_insn_c_swsp_extract_xs2(insn);
+	} else if (riscv_insn_is_c_fsd(insn)) {
 		fp = 1;
 		len = 8;
-		val.data_u64 = GET_F64_RS2S(insn, regs);
-	} else if ((insn & INSN_MASK_C_FSDSP) == INSN_MATCH_C_FSDSP) {
+		rd = (8 + riscv_insn_c_fsd_extract_fs2(insn));
+	} else if (riscv_insn_is_c_fsdsp(insn)) {
 		fp = 1;
 		len = 8;
-		val.data_u64 = GET_F64_RS2C(insn, regs);
-#if !defined(CONFIG_64BIT)
-	} else if ((insn & INSN_MASK_C_FSW) == INSN_MATCH_C_FSW) {
+		rd = riscv_insn_c_fsdsp_extract_fs2(insn);
+	} else if (riscv_insn_is_c_fsw(insn)) {
 		fp = 1;
 		len = 4;
-		val.data_ulong = GET_F32_RS2S(insn, regs);
-	} else if ((insn & INSN_MASK_C_FSWSP) == INSN_MATCH_C_FSWSP) {
+		rd = (8 + riscv_insn_c_fsw_extract_fs2(insn));
+	} else if (riscv_insn_is_c_fswsp(insn)) {
 		fp = 1;
 		len = 4;
-		val.data_ulong = GET_F32_RS2C(insn, regs);
-#endif
-	} else if ((insn & INSN_MASK_C_SH) == INSN_MATCH_C_SH) {
+		rd = riscv_insn_c_fswsp_extract_fs2(insn);
+	} else if (riscv_insn_is_c_sh(insn)) {
 		len = 2;
-		val.data_ulong = GET_RS2S(insn, regs);
+		rd = (8 + riscv_insn_c_sh_extract_xs2(insn));
 	} else {
+		regs->epc = epc;
 		return -1;
 	}
 
 	if (!IS_ENABLED(CONFIG_FPU) && fp)
 		return -EOPNOTSUPP;
 
-	if (user_mode(regs)) {
-		if (copy_to_user((u8 __user *)addr, &val, len))
-			return -1;
-	} else {
-		memcpy((u8 *)addr, &val, len);
+	if (rd) {
+		if (!fp)
+			val.data_ulong = *(unsigned long *)((unsigned long *)regs + rd);
+		else if (len == 8)
+			val.data_u64 = get_f64_rs(rd, regs);
+		else
+			val.data_ulong = get_f32_rs(rd, regs);
+
+		if (user_mode(regs)) {
+			if (copy_to_user((u8 __user *)addr, &val, len))
+				return -1;
+		} else {
+			memcpy((u8 *)addr, &val, len);
+		}
 	}
 
 	regs->epc = epc + INSN_LEN(insn);

-- 
2.54.0

