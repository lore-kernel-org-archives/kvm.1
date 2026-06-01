Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F506388E66
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303246; cv=none; b=adAyMsq+u+0GLr4vcqMQOR5hUTq2QrnTNzrvz58AyO23ADi28vQ/aFBtD5BDyOdgiYMKvs+rsiLPvndATYKXizzIF8fObN2VzPE/AY8aeG/DhDSEchewsdnGMqKq7ZxsVVbhzkGFvcygQAuyxOqvspjZXE+1ti2Pk3Gt8E/DfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303246; c=relaxed/simple;
	bh=FNI4e0Y9g5FK2/4DBzvxjuh05HswRPQCPmugp/FnJwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XKk2niq7rtHBap/DzH0NGXnwMZ7cGUec66TQU6UNsXq0eO25zthvgx1ZTxrjbmmp/BJmQuokNfEQbQglE8nfcjwIHmU65vbnTrRmXYsahplRhBLAyDJfYFBc6scsKYSJdoHMu85L+mFAVxFmlwpQZ2R4ZX2rrOdNZk0oKCuBVa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lntYhilL; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lntYhilL"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso4849017eec.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1780303241; x=1780908041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v45EvKOKpiUmWI/368ayn/Qc0smHoYJt4UbJf2J9agE=;
        b=lntYhilLFc2bJaDc2BZnsz3EpjmwB1VhT0njjq6zL5zylODZL2zjiKSaZd9Qw6mx8K
         bmHwhfpM7dAL4Z/aCJYgp9sIs4xRHOojsFE+LCsPlO2pem7oVg18VzbhebvjxasHRcp7
         0f0pqpDvyRuYXV25s+9zkphLpp3aFHaafrak1aWxw7WCvvOYk3wMYZU845Zlk5qco+pd
         mWk2JJ+99RApXdyKH1v8FeTAdfGMI1C/S18zRJQ2ilGU0mwoDEJ1jjWrHE+JzHhZkzB7
         KkItLGvP1YUNvQcAC36kFnhUcR96M9OZnRWShhQD4/Y92dFWvbI3VkfDEnNudeVlolHY
         PqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303241; x=1780908041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v45EvKOKpiUmWI/368ayn/Qc0smHoYJt4UbJf2J9agE=;
        b=lXOYxvUTThbQuY/wtaNrjO/4leP89LCUBWrk4x3k1XNc5/6g0FIxQFuxm3NK93h9ey
         dXcGMAQWZbqNZwgrRDEcY8XZbN9G6+m93dByqlIq9/MlNHkGApScZUYsEPAsQy1nHxLJ
         nZxksDvxCFgexkjVavWVITr3PmUeEfEZrh6Tnff120jFqpn6NavPLRkdgRy59ImbiqOq
         0v5OhElRB2HHrGSAWwsBKV7iKTNZTsgRwZzPO2FkqX1NSQGxMEk4b/JajoPihqezdjc/
         5x7cOsW3uc0nZMwbI/mErK7G0Uv1VGqnAl2vjo7yyqK0CQvNXlqy4jQrI0mg9/I/n7at
         VEYg==
X-Forwarded-Encrypted: i=1; AFNElJ+nTpjTUUFgSGYaINF+GrT2wWZNt2ynKRKnYjGm5U69LyKpBQNnXpGfwJ9EmtlPVk5/hBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2o2CFSVV3mrjihyoxmUomQWItoipMsaoNPjMI0q/I54FVsPbI
	4Q28OIOxV3pO5XE8niwe65Ci+DGJkqzrKvdUZwrF5/Xo+SjnQdIzvyRaQNujWoEg83FkXI5GosH
	43Ta0mpL5TG0t17gQTzP0XdQcE8cX6XesspBla/U53o+vYyr2f+H/usRZ+Tl9zOp65CifB+FAuc
	X96UbtanEYFaDDicMTs5X2mDCeb17J/Y9ZMmKHBeb3xgwGgw==
X-Gm-Gg: Acq92OGFLVJiie7wMCvi+MEsmcxTxFpFxb8DShZWYRBxrRIQozY/HxP7hP1PFBJvfIG
	m35m+qXIAM+SsbkNvXRlsw4BucaZNmhj5SaKn3E/0y9QPGwZGxU140cvLJJNTlVXzXQryPuvBQv
	DhJuwvej31sFQ3EEG3kaQUYC0LUSED7EjT9DubDQlM+pswPgPs+cqPt4OuISrBbtNBmUbHd0cQO
	U8hZ7UDKcvdmiIZtiRh8gBc51VtxrqkZCYKaQuD/lsEN9+W3PSth9tRc+D+OK//KsW/09AdDY8K
	YyI0hlEgDgBP/pOe/KV2cCBW2ei8eUKTlPco8y/rxnakXoU6Culm4jgALR0FScVWqbl8BjZde2Y
	W6Fdky7rdDzDvm9xd6iM1Bsjay2NELs0SKfSiAD5C/oIV8QprBeEhYBI53sAdogO8e1/SKudl19
	FYRho/U4duQCx/BXvb+U4oheIU2neZltmvzUcPqQRCJW5gMduAZ20uhTWz7c0Ch75W
X-Received: by 2002:a05:7300:4312:b0:2c8:6361:ab2e with SMTP id 5a478bee46e88-304fa55b483mr5275232eec.8.1780303240985;
        Mon, 01 Jun 2026 01:40:40 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5b9be7sm8011818eec.27.2026.06.01.01.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:40:39 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 01 Jun 2026 01:40:35 -0700
Subject: [PATCH v4 2/3] KVM: riscv: selftests: Refactor ISA and SBI
 extension sublist macros
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-kvm-get_reg_list-v2-v4-2-c88abc81ebda@sifive.com>
References: <20260601-kvm-get_reg_list-v2-v4-0-c88abc81ebda@sifive.com>
In-Reply-To: <20260601-kvm-get_reg_list-v2-v4-0-c88abc81ebda@sifive.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780303237; l=6365;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=FNI4e0Y9g5FK2/4DBzvxjuh05HswRPQCPmugp/FnJwg=;
 b=MQ06NJgix/Zxl//w8IbQdbNn3SaNFFRcNUH/9n8W6PwJ3yigUdSvO65zzH5h0c70kLUSFb42g
 WWXCEEyYLvPBhgoZmCwFNxwuGPzDUGE1fWhfU0HH7POi72XUxNt0sJ+
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

