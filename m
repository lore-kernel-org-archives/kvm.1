Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994739B495
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309601; cv=none; b=RWCNruGtsaBsG0QYAhj2L0g2mmqWuyiRP/AoYqPEL1tMMGjVOAwKTtc4OZ2dGjWrGo7jOEXKSP4xb8ZM2McCVGDv2RVJvv3gHGV5Ib8Y+HXSbxE5U0tzceSsZ+hUoYLcgDvjScSAdLgpuWWe+ccGXG7B0daNzT9k/rIqhFB4O6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309601; c=relaxed/simple;
	bh=FNI4e0Y9g5FK2/4DBzvxjuh05HswRPQCPmugp/FnJwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlOcIEmvK6n7lfzuA96x9ui4E6V/psVT9e73TJv4kYQgiIVwYESQyezUbXOJt56142CbTMJGXQlt/qH//VLApZlsM2ejifp8UAs9yCScN7eTmtE9IvFXzrY5bA8xXKW87RKsuszxIf+o9F8xTDNTwtkh/DTpGazBMd6XLUkCqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=HU86y9DL; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HU86y9DL"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-136b46c3540so9939894c88.1
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1780309599; x=1780914399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v45EvKOKpiUmWI/368ayn/Qc0smHoYJt4UbJf2J9agE=;
        b=HU86y9DLDU4UjoifPnn6c5XbFusjV6Jmra8TcBf7aMiY6NCp+orYetZIR+hsoyMniT
         WNI8mleEK00wy0zbMtv9xYq4joUmi9n/dCMYeEyIYaoDrKpa0fXjqktINmbAu+ltM9Dd
         xZ53WMWErQv+sLEJWuxj+PlS+Zh4Oehahfsjxsbs2MzOTCgps4jTdEYVcQ5595ZYHCp+
         ZPDEKM/HMife4RczVEKJ7d8a4uO0mm0BEgRY84Hu+nZhiX/lhE181ajNQDGijIVUryQa
         96OgGH8Sin1jhGakE2um0eE2isdhah0STBqGbuUskLZnC7xybEKJwrlG1vHiekipTd8s
         T97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309599; x=1780914399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v45EvKOKpiUmWI/368ayn/Qc0smHoYJt4UbJf2J9agE=;
        b=Th1p4Lp/AFVy2+Lhi2qbVYufGrn/jsmRRhgUbrSoP/J0yHspFaiG1M4emn1sOK+ger
         YF9XUfmYPo0SIhVRxf9NaPu/+2oO5SUrxpSqYVfVQBOejRPlxn3GT+EbWptaO25hMep+
         FsFtc+FDUCdIGQ0un2kLtTT4zUmd8OtDevf0GUJts81t8ePsD6eWDUu91GLKS4PIuFgE
         zEtLzNe0mM/Zu/tawvtwUkui9H9Ku6luoqrrcCzWMQwvOTGvkAQA7CKYQ+lp3HoAWdJI
         hVqQt42M9ZiFsk1njDWDIZq1KzWAySQRKJWM3peG4hdFK/omNuPFDuw8cRBP0Gc4QAnQ
         t3IQ==
X-Forwarded-Encrypted: i=1; AFNElJ8l2ZC7ywSW/62YxnNysRl1eyvo7jBckznW87+a9Xl+eT6Q8+u+Tl7l6uzwhKmhcrh0Uo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxglIN+gS8lA5rQRz0RUjVMGr27qA7zpQAsoD2lb4SIpps54mSj
	zCVQHlo0/5mEDYGYt4rsWwNzy23wvmYKSRcvfoNMghM16rTt6w8aqfPZ3yuv21MYnPM=
X-Gm-Gg: Acq92OFDWIvu1RSXxD39T1h5ZVXV7TvCitlMsrc8XI4jszRR1UF/zmwtSstwuJotYt3
	HiIs3rN3wRm0MdBoN1ZOWDqLcA4fShU588hboxXUfxJKb+BX+28UU24QMyaF96a3z9AENM6sI19
	7WGZXZSecvm/JXKe1uZ0as0vZzkLRVHCPVX4M3g/X2J1dXAYYxBY0G6IK0GvV1Rapy4tbCIVMQU
	wM/G6vKQQ0HZEvr3+MAfshTLrf0Nz9TI7D3sEJ8ps8P+BG83OechbRfSzmt5DHdsWulw28tMWXp
	ojLuXNvS8YBFcYAOL1U1MGDOvRHlrpAemLHPgbWXsvRvxk5GsUUEN5ekXNynyh3nyOViTPCQiEI
	+jrmaW53UzqmAl7t4p2dmTRTjVVxpNZOBJpxwtjqju7PBy9n8GC2fUEDsgRDvPyPW6ylvcs9zbv
	7gBYPXvwhRPPBS81S/c7sLebdJ6K+vz5rgDEmcpwRokVCWoKfcbxcqGA==
X-Received: by 2002:a05:7300:ef83:b0:2de:2f38:a7cb with SMTP id 5a478bee46e88-304fa64c547mr4222242eec.18.1780309599215;
        Mon, 01 Jun 2026 03:26:39 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5b9be7sm8176001eec.27.2026.06.01.03.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:26:38 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 01 Jun 2026 03:26:25 -0700
Subject: [PATCH v5 4/5] KVM: riscv: selftests: Refactor ISA and SBI
 extension sublist macros
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-kvm-get_reg_list-v2-v5-4-415d08a2813b@sifive.com>
References: <20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com>
In-Reply-To: <20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, inochiama@gmail.com, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780309592; l=6365;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=FNI4e0Y9g5FK2/4DBzvxjuh05HswRPQCPmugp/FnJwg=;
 b=9IbSqErsPynCglrgkwjMA+Pn1UvkzsbZQo8VRzxpAFxO8XIbhoiVwTbVc3LpOqgcnBdJpW6yM
 vbRg2ZdmJawDzqD0fAyIWeBXDsk5lPW5Koi53Bg5UxxEJo3heBn0AMo
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
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 78 +++++++++---------------
 1 file changed, 28 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 8d6fdb5d38b8..5033c09201ef 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -1013,7 +1013,7 @@ static __u64 fp_d_regs[] = {
 };
 
 /* Define a default vector registers with length. This will be overwritten at runtime */
-static __u64 vector_regs[] = {
+static __u64 v_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_CSR_REG(vstart),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_CSR_REG(vl),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_CSR_REG(vtype),
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
@@ -1153,9 +1131,9 @@ KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
 KVM_SBI_EXT_SIMPLE_CONFIG(mpxy, MPXY);
 KVM_SBI_EXT_SUBLIST_CONFIG(fwft, FWFT);
 
-KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
-KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
-KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
+KVM_ISA_EXT_SUBLIST_CONFIG(aia, SSAIA);
+KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, F);
+KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, D);
 KVM_ISA_EXT_SUBLIST_CONFIG(v, V);
 KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
 KVM_ISA_EXT_SIMPLE_CONFIG(smnpm, SMNPM);

-- 
2.43.7

