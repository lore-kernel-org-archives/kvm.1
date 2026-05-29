Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA2D3A75A7
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036129; cv=none; b=CdZx2oc7F6cxaqq4o1WFQgDcCN1FcvlyoprEpVPwrRMa0d4naXSza+JZgxQTZ2xVlyTWSEVNp7nRqhh5NvUZ8fXCYB4pkBt//VzhBIfG9Qs+3JGkZdyoh57PuTgk1HXXMNYozuPOCYhahVrJ0Zo8sDiuGALihIhKlfkeNVaEuYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036129; c=relaxed/simple;
	bh=FNI4e0Y9g5FK2/4DBzvxjuh05HswRPQCPmugp/FnJwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bwy7I2Y4sNZ8TnpEifz1EEQuS0Yhw8JmATaS+fGz6vStNUHeheLsZuzkf+RolDKADZub+nl4b338JmC353nLjX1KUPj+Z1hnajTrU+F0ByWZTyjAR2UmL/Yi3kvl+/2Xa9Pc9TRoc54Mla22s+74IdKQFZw4ZjR0uCuM1lb6H5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bbyHOMGm; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bbyHOMGm"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304d8362a58so1000352eec.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1780036125; x=1780640925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v45EvKOKpiUmWI/368ayn/Qc0smHoYJt4UbJf2J9agE=;
        b=bbyHOMGmafaOJ54uzljC0W/8L9aiQPYLSkosZ5dYrdthnzRSOKjzefqz7n99cr0FdJ
         gdxP6EJV6ejCYo7WgEUMGUokLyRR1976Wg+cA4UGwpqL2mTdl1PoS6K+Mj8Nx1mBDN5T
         47aKlf0BosO5SZVlNy8xbQnUHnfLcgm1NoWMwel6chH3rJ95VsuGEi53h1bFkBryeEu/
         1fHv6K3HSHczDUcMxP9L9Qev0OBi0pAJkMcKz3TJZX5vSvMSMzHtT/wZQN7S0OvJ9ryY
         WdGtAxC0Y9kza/+W1Z7ZGkjrp1WdR6GPVBFRY+9VYIGB9wX3aRLmbuUOzIIdmXYlOyDl
         gfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780036125; x=1780640925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v45EvKOKpiUmWI/368ayn/Qc0smHoYJt4UbJf2J9agE=;
        b=nBaEPZ9cOpC/lI57RaoNDn5t8Mth3nRTv/1+yBQ2pyMFOQPG/mv/5LQeJJvSLtXmAB
         tIIafxoToo+xKq5WW2e116/IWaOWRjdxEu30SS6sR2bp9a6SpycfuFEKqsDVuObznLNn
         8v9714QPTaZ3iTizsH8mkb3btbEjiJKSpQM8q0fXq4BYwFQGuzFHHuC0iMGV3FtpyXvs
         dY9fiO4H8WFk7y27QF4gC11i5rTuw/wJs6r8jvHHeqc6kL1RTDe+/zGUfhePref5uy+l
         a/I/HJ0iEN2RGq2Q+NWjcIkwDWc+AUFJf8UfpCXMWfhMzBeqHm/mbl1Vn6yv+BnnqaTU
         hGdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9GPwjr4s+AGoDb1foIWCi2toeFEFdDbKwjFrmCSsxCGy6r6qmDBgeFv727QZ7JoxiayeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7qf3DwRM8oKgfv/+tJtEgQ2ULq2q3N1AgpHh7Mv9gycYV+w/C
	7W80L7MtIfNpHiixtP9T+JaxnJsvvcAQpdSKjshY5fnpneVDQI/rO4kzKAaUIq7CLtI=
X-Gm-Gg: Acq92OGVkqNXVDD5ikFOUH0zQTE9JabcZ1htibPPmyrRJxPzxe8Di9L/kUE3hOc7uw4
	DgDau7gyOiv913CcnbSI1+IO7weVTyZtdCqijVF/ouj3NXrRRnOsGQvmAf1YhLp9ne8WOPg8jLN
	d/Bm/aR+65vcWYSPQqEb70yq9MAQ8ftbxYASN3i67WR2DbJYlpDbxAmmDV3QzpkaMFshyEbuyRh
	YIXQCR+6Ip/lG78x3TKGQDvXEjcRP/eIMXzPYyrjmcBX/XxOQ5aAIHIar4a56JWeIll6CiytKs6
	KnqhP0TAu9sRVTRncvNmD2iBCg2SzKfeHdCD7wydYZ/V5pH0Vh4b9y4EqX5ZFzdUrGPdrYagEA5
	A+6J7dv7NJ87vEK87yWoYChCL4lJpetw5Xjgk6N8WZV69aqbGUHCG1Lrg2CWv5IqRnQuGzAyyMI
	gD7d6z+MYJPSiRQWdTULxSLIq79UJQYJWdfXQZq/J2Nj+kBf0YwEfydLROVyGYP89a
X-Received: by 2002:a05:7300:5b9e:b0:2c6:67b6:3acc with SMTP id 5a478bee46e88-304eb1e9955mr723799eec.15.1780036125527;
        Thu, 28 May 2026 23:28:45 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed3358b1sm694607eec.13.2026.05.28.23.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 23:28:44 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Thu, 28 May 2026 23:28:28 -0700
Subject: [PATCH v3 2/3] KVM: riscv: selftests: Refactor ISA and SBI
 extension sublist macros
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-kvm-get_reg_list-v2-v3-2-170969a8599f@sifive.com>
References: <20260528-kvm-get_reg_list-v2-v3-0-170969a8599f@sifive.com>
In-Reply-To: <20260528-kvm-get_reg_list-v2-v3-0-170969a8599f@sifive.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780036122; l=6365;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=FNI4e0Y9g5FK2/4DBzvxjuh05HswRPQCPmugp/FnJwg=;
 b=NKxY/K/jSMMPh4VOKPxki0ZAqPzHMvzBwMys9X+hufCVuPO2SlBYQdwbdx51iAE7NCNc4BsvI
 erwQW5palAMAEvy5VzcG592+Krbg/C9IfU8jixjzXN+8FcTyaehY+ut
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

