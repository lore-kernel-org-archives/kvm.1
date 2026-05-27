Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234BE2F5491
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779861189; cv=none; b=Klk8oZPNZVNwaizl5oJsBpDFVv4SQ2fKzpXemNHKrrrYsjFeHF/u9Z77i+v3o2zznymMdjkSC187sMInGxX6UPqHMVJ99ccRWIrG8GHaUXBaldMUcpkTxOHidcDBnd4W9tR0zEs2I0Q2PBFyA8T8Zd3OXeZGx/ccs82YyzhGCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779861189; c=relaxed/simple;
	bh=4DPizMp5c9ZYd5J6eYtnzgZrFa5iDZWYGDJjDrKQguI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tnvT4CBg4xU7WEAOzYcdB0mG0hJ60ODRiwRCmX7nd7JQWRZ+mVl6B+aU8ckYNLseVmrgiJReAMAlaFx3TIcKd8G1ann1SK3adD0FsRM7blQpr3D1/Yx2fL0g0T75lx53w0jD6JoG0GwOcGHf1gDn6LWDJYzWEo8N2NM6t0PCzFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QDU4CIuO; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QDU4CIuO"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-134ac81c445so19079722c88.1
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 22:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1779861183; x=1780465983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXN4gEKCKsU7orTDwjAmupylz86Cq+DRK2X72vksDBs=;
        b=QDU4CIuO7gvMZMqW6+S+tcanAAobhkTZoWgUc1iP0QtiqtCkf0yzez4EBNq0eDA5vb
         v8iN8Puaqmdu36vQXQ302yb9yim4aFj9TIsW3Q4QDIJ+IVrNcBRUjmgxEUXWHrd8kZKG
         kNyXyyeRcWQLkYXoVG7rn76wL9y8c/Hvg2T0iRbvMhMIvbIJ17O2QARXtolyf0XNcoJz
         p1U78LB+bhtOTudyzKdd/BTuTSicv1GLQYwTRc0Iv0V291CQi+thA1734W79ph3wF6oa
         n9jiTLGCeoqWPXPwtB6wZlQI83bRDdfcDwjCmpH6Bmi4NMtxLNVVIGg+yXftPgcxEvvs
         6IyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779861183; x=1780465983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xXN4gEKCKsU7orTDwjAmupylz86Cq+DRK2X72vksDBs=;
        b=q0z7hO+wWWNkKNSTMeWLbzQ0AsMvCwt/BjqLGO6WAPudmk802ZCNW9oBQTKWpjnpEN
         uaGsR+7ORysmSSY+5zvweRW+loHs3Wap8xStiPx4N/pL4o/9Z87TBmppX49uqPB78lyA
         8YmhjGaZWZNuAkJ4KFRCgs/arBUb95n0PXzRjNKxDL1i3vy5Omzv5WqbqvK/UmhZ+WJA
         ExraKatDqT9D8FyLheVAw1DjhuybeRaOSTbLHIeSTo75rftK41jqMm2JRCZxYQVP5m0x
         uVRncGoeEvo84oMd7obBJk2lbrU+5dTPdSJUpezTjX23BF/u+DV9uZESWcBjycLYyE7O
         eNtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/alUQQI8LWkRS0SXUJkQJ4nvN3OwvZB/zBRiTIn1l0YyE6hwXd2CTQBF5wPYDgd31byzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHqs3QNIBfsWDl+UoYQm6p7tg58oImWvreNeJylneLcIyGTsAE
	QEIoqnR84JH2bbEDEwjrKnzFS33iU9ekP2cYYsFWlrDgyQ2MG/R27j9BnOziKfwGbH4=
X-Gm-Gg: Acq92OGWHOzZkebjL1n4UsW4p3VVAIr7T/oiiJiNeSzccktdnzn9oGPce8Iar4NpeQJ
	eIkTeBxBxG+TZW7V3R51St/plXcscOXDKvaCysgmLA4GgyFBpYzPWfLYp3pOBbN/t7UUxPzANzL
	TWo9tZ4ZqNQQ2gYqKflaMiYFG1FRJKwIRYVH6MyXUaiAhT1dA8Pp41qb0JKr8+gVc20hoGj0m7a
	lgKsj1/uFFkw9+D35ugEMCzXmWXQRDWauFqGRkydOSwr665Y5A7ZG0zXUXqPUkrOpSgB/awPgDU
	BzaNRh2CWZyc6lMelEODRvbzxydTt/09cnuPIWGzL0l73wTpfMukqs39Aw3Z3SmG+/qwdKu3NEe
	ogJYiqpO65LtqvxzD2Wcv1kYaSwLKf+GIJDa5QMIDvHl1Aqi3/baEuAq6Q087lp2/mktnrReKS1
	2sBs4eCLnjkbk1Z/YaXuNVaemHEquicOXEiKbLVEtQL/UhkXRkLOMk9g==
X-Received: by 2002:a05:7300:e805:b0:304:ba84:a0cc with SMTP id 5a478bee46e88-304ba84ac6cmr546957eec.33.1779861183142;
        Tue, 26 May 2026 22:53:03 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304be0851c9sm613202eec.23.2026.05.26.22.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:53:02 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Tue, 26 May 2026 22:52:39 -0700
Subject: [PATCH v2 2/3] KVM: riscv: selftests: Refactor ISA and SBI
 extension sublist macros
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-kvm-get_reg_list-v2-v2-2-7940a401454a@sifive.com>
References: <20260526-kvm-get_reg_list-v2-v2-0-7940a401454a@sifive.com>
In-Reply-To: <20260526-kvm-get_reg_list-v2-v2-0-7940a401454a@sifive.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779861178; l=6156;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=4DPizMp5c9ZYd5J6eYtnzgZrFa5iDZWYGDJjDrKQguI=;
 b=S7fRaOZsRn89YBqQxmsVvW+ybsBc4X5m6GfdOSpXsQoaqsaJjtbEtjGTpoBsIwuapMZzGmgK0
 kWhQZBuxDB7CX0+PG8/0CblcxP79ieiSW4fKv7xcyp6H4A2PQSrsCTB
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

Refactor the get-reg-list test to use unified sublist macros for ISA
and SBI extensions, eliminating code duplication and improving
maintainability.

Previously, each extension had its own hand-coded sublist definition
(e.g., SUBLIST_ZICBOM, SUBLIST_AIA, etc.) and the config structures
repeated the same pattern. This made the code verbose and error-prone.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 80 +++++++++---------------
 1 file changed, 29 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 8d6fdb5d38b8..cb16c638ce1a 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -1057,37 +1057,17 @@ static __u64 vector_regs[] = {
 #define SUBLIST_BASE \
 	{"base", .regs = base_regs, .regs_n = ARRAY_SIZE(base_regs), \
 	 .skips_set = base_skips_set, .skips_set_n = ARRAY_SIZE(base_skips_set),}
-#define SUBLIST_SBI_BASE \
-	{"sbi-base", .feature_type = VCPU_FEATURE_SBI_EXT, .feature = KVM_RISCV_SBI_EXT_V01, \
-	 .regs = sbi_base_regs, .regs_n = ARRAY_SIZE(sbi_base_regs),}
-#define SUBLIST_SBI_STA \
-	{"sbi-sta", .feature_type = VCPU_FEATURE_SBI_EXT, .feature = KVM_RISCV_SBI_EXT_STA, \
-	 .regs = sbi_sta_regs, .regs_n = ARRAY_SIZE(sbi_sta_regs),}
-#define SUBLIST_SBI_FWFT \
-	{"sbi-fwft", .feature_type = VCPU_FEATURE_SBI_EXT, .feature = KVM_RISCV_SBI_EXT_FWFT, \
-	 .regs = sbi_fwft_regs, .regs_n = ARRAY_SIZE(sbi_fwft_regs),}
-#define SUBLIST_ZICBOM \
-	{"zicbom", .feature = KVM_RISCV_ISA_EXT_ZICBOM, .regs = zicbom_regs, .regs_n = ARRAY_SIZE(zicbom_regs),}
-#define SUBLIST_ZICBOP \
-	{"zicbop", .feature = KVM_RISCV_ISA_EXT_ZICBOP, .regs = zicbop_regs, .regs_n = ARRAY_SIZE(zicbop_regs),}
-#define SUBLIST_ZICBOZ \
-	{"zicboz", .feature = KVM_RISCV_ISA_EXT_ZICBOZ, .regs = zicboz_regs, .regs_n = ARRAY_SIZE(zicboz_regs),}
-#define SUBLIST_AIA \
-	{"aia", .feature = KVM_RISCV_ISA_EXT_SSAIA, .regs = aia_regs, .regs_n = ARRAY_SIZE(aia_regs),}
-#define SUBLIST_SMSTATEEN \
-	{"smstateen", .feature = KVM_RISCV_ISA_EXT_SMSTATEEN, .regs = smstateen_regs, .regs_n = ARRAY_SIZE(smstateen_regs),}
-#define SUBLIST_FP_F \
-	{"fp_f", .feature = KVM_RISCV_ISA_EXT_F, .regs = fp_f_regs, \
-		.regs_n = ARRAY_SIZE(fp_f_regs),}
-#define SUBLIST_FP_D \
-	{"fp_d", .feature = KVM_RISCV_ISA_EXT_D, .regs = fp_d_regs, \
-		.regs_n = ARRAY_SIZE(fp_d_regs),}
-
-#define SUBLIST_V \
-	{"v", .feature = KVM_RISCV_ISA_EXT_V, .regs = vector_regs, .regs_n = ARRAY_SIZE(vector_regs),}
+
+#define SUBLIST_ISA(ext, extu)				\
+	{						\
+		.name = #ext,				\
+		.feature = KVM_RISCV_ISA_EXT_##extu,	\
+		.regs = ext##_regs,			\
+		.regs_n = ARRAY_SIZE(ext##_regs),	\
+	}
 
 #define KVM_ISA_EXT_SIMPLE_CONFIG(ext, extu)			\
-static __u64 regs_##ext[] = {					\
+static __u64 ext##_regs[] = {					\
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG |			\
 	KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE |	\
 	KVM_RISCV_ISA_EXT_##extu,				\
@@ -1095,18 +1075,22 @@ static __u64 regs_##ext[] = {					\
 static struct vcpu_reg_list config_##ext = {			\
 	.sublists = {						\
 		SUBLIST_BASE,					\
-		{						\
-			.name = #ext,				\
-			.feature = KVM_RISCV_ISA_EXT_##extu,	\
-			.regs = regs_##ext,			\
-			.regs_n = ARRAY_SIZE(regs_##ext),	\
-		},						\
+		SUBLIST_ISA(ext, extu),				\
 		{0},						\
 	},							\
 }								\
 
+#define SUBLIST_SBI(ext, extu)					\
+	{							\
+		.name = "sbi-"#ext,				\
+		.feature_type = VCPU_FEATURE_SBI_EXT,		\
+		.feature = KVM_RISCV_SBI_EXT_##extu,		\
+		.regs = sbi_##ext##_regs,			\
+		.regs_n = ARRAY_SIZE(sbi_##ext##_regs),		\
+	}
+
 #define KVM_SBI_EXT_SIMPLE_CONFIG(ext, extu)			\
-static __u64 regs_sbi_##ext[] = {				\
+static __u64 sbi_##ext##_regs[] = {				\
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG |			\
 	KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE |	\
 	KVM_RISCV_SBI_EXT_##extu,				\
@@ -1114,13 +1098,7 @@ static __u64 regs_sbi_##ext[] = {				\
 static struct vcpu_reg_list config_sbi_##ext = {		\
 	.sublists = {						\
 		SUBLIST_BASE,					\
-		{						\
-			.name = "sbi-"#ext,			\
-			.feature_type = VCPU_FEATURE_SBI_EXT,	\
-			.feature = KVM_RISCV_SBI_EXT_##extu,	\
-			.regs = regs_sbi_##ext,			\
-			.regs_n = ARRAY_SIZE(regs_sbi_##ext),	\
-		},						\
+		SUBLIST_SBI(ext, extu),				\
 		{0},						\
 	},							\
 }								\
@@ -1129,7 +1107,7 @@ static struct vcpu_reg_list config_sbi_##ext = {		\
 static struct vcpu_reg_list config_##ext = {			\
 	.sublists = {						\
 		SUBLIST_BASE,					\
-		SUBLIST_##extu,					\
+		SUBLIST_ISA(ext, extu),				\
 		{0},						\
 	},							\
 }								\
@@ -1138,14 +1116,14 @@ static struct vcpu_reg_list config_##ext = {			\
 static struct vcpu_reg_list config_sbi_##ext = {		\
 	.sublists = {						\
 		SUBLIST_BASE,					\
-		SUBLIST_SBI_##extu,				\
+		SUBLIST_SBI(ext, extu),				\
 		{0},						\
 	},							\
 }								\
 
 /* Note: The below list is alphabetically sorted. */
 
-KVM_SBI_EXT_SUBLIST_CONFIG(base, BASE);
+KVM_SBI_EXT_SUBLIST_CONFIG(base, V01);
 KVM_SBI_EXT_SUBLIST_CONFIG(sta, STA);
 KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
 KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
@@ -1153,10 +1131,10 @@ KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
 KVM_SBI_EXT_SIMPLE_CONFIG(mpxy, MPXY);
 KVM_SBI_EXT_SUBLIST_CONFIG(fwft, FWFT);
 
-KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
-KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
-KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
-KVM_ISA_EXT_SUBLIST_CONFIG(v, V);
+KVM_ISA_EXT_SUBLIST_CONFIG(aia, SSAIA);
+KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, F);
+KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, D);
+KVM_ISA_EXT_SUBLIST_CONFIG(vector, V);
 KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
 KVM_ISA_EXT_SIMPLE_CONFIG(smnpm, SMNPM);
 KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
@@ -1240,7 +1218,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_fp_f,
 	&config_fp_d,
 	&config_h,
-	&config_v,
+	&config_vector,
 	&config_smnpm,
 	&config_smstateen,
 	&config_sscofpmf,

-- 
2.43.7

