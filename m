Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402892BEC3F
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779861192; cv=none; b=mhxMgKx9BVIR5FUmXMTgTUCQKNYzhxBrFwyzqHznFBQGRhDhik4vHd3lhdHYkhV+b7AI5QjXrbD47acssaGLfOCq68C0nFoU4fhLmfRADgJhcjwdNgqe1spIoASCjSSDrjAm4UbKFpejn6gz7KbpsXxazrnJofSa9Se1wSW18nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779861192; c=relaxed/simple;
	bh=PU3MvdV8tam4q1KMdiajihMJ3i8qhlgrfETzPE8HD/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VP3FSgCERlofpkReRMOS2Jt0Tiy9cTf8SUHKL+vPMSb7S+dGo3TYS7Dgs+uf1ZvS9DWlzZqDr0l6HvD9NXrGL7DWrCdQ9WXQe38/xf8So6ojoXgL0fXPR5L/SBmFW0BRDTRaV1TO+gO7pIQuQpWGUtMCBN993+dnWpICgLn1Ne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=eWKjppRq; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eWKjppRq"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304997cdb21so3331275eec.0
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 22:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1779861184; x=1780465984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wp1oswXj3dj/ue+2mbG75NTENINWm5S4spwl9AqmaA8=;
        b=eWKjppRqnDjef9kU0LFoDBClyA9DBq2K3AlJPnUFfxtxbTlQH6bmTsfp1Y93cMRiNY
         TY6SdvpNsau9gqFWXZqVS/+L4k0u9zVs+6kkKKKzyvQ8rKmzO+hL235IjfvO0UY3mJ1G
         bup40OubANgeFFZddcWyAs9G1QgW/qP6oFtISJ4YWr5x1CjS0UnEnCDZe5jmikII375S
         XZoYflHfV/uUx0UBxsbc20aeqMbnRlV7OFvYQ6H3/J+EtWz9sdgLrjKaA6adnhCnP1pP
         XTf7FoJ7a8d1cB0q5EOJoP22bnOzkfvGRrAAyvWO2mIhoe+ZxJujOPUlnFiuw/rXhfdR
         vqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779861184; x=1780465984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wp1oswXj3dj/ue+2mbG75NTENINWm5S4spwl9AqmaA8=;
        b=JVqusOFKqF9Yl+0CFuY+clWGoN/uaoY6u3FPhM66XGFIfxWDjatzCCs6qxv5AV2NJG
         buvKf9WlRX1uTl/BeLIobplOAIu732yzlok0Ql5Nh7pd6Xt1ZnRPFwSAz6vB7ps9GqTE
         IpPIOAiHKOONBb2vGDZ7MoVjWkBSqR2vpprl5jmhCqIHCEcD0o4trh2HPCIJtfpYqPDY
         EO2RiSRs4QHbcTl+iKtXGlf0l6cAFxRSirvUjae0vkY4B4o/qLMXRpFb9qLXa0sp/7te
         uAAWsMru0PKA+DyT67bVJUrRyJjfLvj4rd8Umw8f2CkfELlnIpACdWFsONN19FoXXXx5
         hvlA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZAV+WKINnnPgftVHQxtl9AHtpDmNy+mjZB+c1jPEm+yctynnwDWkca3oKQZoJz5Qyuaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0BTjh3L5IdafBg2UqqXZk5Bw749rofVKGFFQIDvqzsegtaLUj
	ja92rcGuYZDG5Ld7Hh/Bb23fkBFPMB8FbDUtsBTj6sm3hQ+u+JDa1ABtX/AlEbquVck=
X-Gm-Gg: Acq92OEGenhwUmSftOiJGc4/eUgcvprKg8yjbcuMyY14JuQbrTkHepOu5LY4nbZzo/P
	HZ4+WzF0Z7F6GxkV2AZdiTk1rqCeOZgTK1JkA5FK4aXRSN6irQ+Oafhx5uCdeGm0ZP4Y9hTpQiw
	1SHjbPX4DRCTR0KzdxCU7DIdXKxnriQiMgDcBlhy2MEGHTUvV7PyWliNDXGpsBolqTSI0KAzkXE
	tR8yrU2DQVlJ2itTiVcJ8nHgbVvzT9uq8IeywU3LttP3VLM2hmE4kopzK+HA4USmD3qfmdXx97B
	+vrukHL4w4Z4rR/qmp2LAn+MY5HY9ZhCuEhxfwRi5S/MosDorNWcOE8u0v2dNXf934tGQhp+Fwa
	n1vAawbH7lN/F9jr1iLpQ/b5aBoKjdliULpETAICWV90ID79UrCZv7brsBC6E/Ui+ABlSxGt8E2
	dGmakMsrGUix06ROctMdVxCitOg8dba4aT91kiMMIDrYwQyz9HmgXx3w==
X-Received: by 2002:a05:7300:e826:b0:304:8881:b82 with SMTP id 5a478bee46e88-30488810bd7mr4633718eec.1.1779861184313;
        Tue, 26 May 2026 22:53:04 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304be0851c9sm613202eec.23.2026.05.26.22.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:53:03 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Tue, 26 May 2026 22:52:40 -0700
Subject: [PATCH v2 3/3] KVM: riscv: selftests: Split SBI FWFT into separate
 feature-specific sublists
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-kvm-get_reg_list-v2-v2-3-7940a401454a@sifive.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779861178; l=7898;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=PU3MvdV8tam4q1KMdiajihMJ3i8qhlgrfETzPE8HD/Y=;
 b=Rf/Bxb/Y6dVq19o6khyGvrIhnmWe6YPFVdkxBIChoeXeDEbJ5eD7cToZTzm/Vs3esy/8MC97k
 1y2/g4v/RwICUXDg73dHFNGlE0YaXfV2hGe0iNJyWyk9lFzoRaXUW+j
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

Divide the monolithic SBI FWFT (Firmware Features) register list into
separate sublists, each testing a specific FWFT feature independently
with proper dependency checking.

Previously, all FWFT features were tested together in a single sublist.
This caused issues because:
1. Not all FWFT features are available on all platforms
2. Some features depend on specific ISA extensions (e.g., pointer_masking
requires Smnpm)
3. Tests would fail if any single feature was unavailable

Add the feature-specific SBI FWFT sublists with the following
improvements:
- Add check_supported_reg() function to validate register availability
  based on required ISA extensions
- Add check_fwft_feature() helper to verify FWFT feature availability
  at runtime
- Update filter_reg() to handle per-feature FWFT register filtering

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 92 +++++++++++++++++++++---
 1 file changed, 82 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index cb16c638ce1a..6a34320be78c 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -26,7 +26,21 @@ enum {
 	KVM_RISC_V_REG_OFFSET_MAX,
 };
 
-static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
+static bool isa_ext_enabled[KVM_RISCV_ISA_EXT_MAX];
+
+bool check_supported_reg(struct kvm_vcpu *vcpu, __u64 reg)
+{
+	switch (reg & ~REG_MASK) {
+	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.enable):
+	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.flags):
+	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.value):
+		return isa_ext_enabled[KVM_RISCV_ISA_EXT_SMNPM];
+	default:
+		break;
+	}
+
+	return true;
+}
 
 bool filter_reg(__u64 reg)
 {
@@ -148,7 +162,12 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siph):
 	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1h):
 	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2h):
-		return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA];
+		return isa_ext_enabled[KVM_RISCV_ISA_EXT_SSAIA];
+	/* KVM misaligned delegation registers are always visible when the host supports it */
+	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.enable):
+	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.flags):
+	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.value):
+		return true;
 	default:
 		break;
 	}
@@ -193,15 +212,39 @@ static int override_vector_reg_size(struct kvm_vcpu *vcpu, struct vcpu_reg_subli
 	return 0;
 }
 
+void check_fwft_feature(struct kvm_vcpu *vcpu, struct vcpu_reg_sublist *s, u64 feature)
+{
+	unsigned long value;
+	int rc;
+
+	/* Enable SBI FWFT extension so that we can check the supported register */
+	rc = __vcpu_set_reg(vcpu, feature, 1);
+	if (rc)
+		return;
+
+	for (int i = 0; i < s->regs_n; i++) {
+		if ((s->regs[i] & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_SBI_STATE) {
+			rc = __vcpu_get_reg(vcpu, s->regs[i], &value);
+			__TEST_REQUIRE(!rc, "%s not available, skipping tests", s->name);
+		}
+	}
+
+	/* We should assert if disabling failed here while enabling succeeded before */
+	vcpu_set_reg(vcpu, feature, 0);
+}
+
 void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 {
-	unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] = { 0 };
+	unsigned long isa_ext_state;
 	struct vcpu_reg_sublist *s;
 	u64 feature;
 	int rc;
 
-	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
-		__vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(i), &isa_ext_state[i]);
+	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
+		rc = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(i), &isa_ext_state);
+		if (!rc)
+			isa_ext_enabled[i] = !!isa_ext_state;
+	}
 
 	/*
 	 * Disable all extensions which were enabled by default
@@ -209,8 +252,10 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 	 */
 	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
 		rc = __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
-		if (rc && isa_ext_state[i])
-			isa_ext_cant_disable[i] = true;
+		if (rc && isa_ext_enabled[i])
+			isa_ext_enabled[i] = true;
+		else
+			isa_ext_enabled[i] = false;
 	}
 
 	for (int i = 0; i < KVM_RISCV_SBI_EXT_MAX; i++) {
@@ -229,9 +274,15 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 				goto skip;
 		}
 
+		if (s->feature == KVM_RISCV_SBI_EXT_FWFT) {
+			feature = RISCV_SBI_EXT_REG(KVM_RISCV_SBI_EXT_FWFT);
+			check_fwft_feature(vcpu, s, feature);
+		}
+
 		switch (s->feature_type) {
 		case VCPU_FEATURE_ISA_EXT:
 			feature = RISCV_ISA_EXT_REG(s->feature);
+			isa_ext_enabled[s->feature] = true;
 			break;
 		case VCPU_FEATURE_SBI_EXT:
 			feature = RISCV_SBI_EXT_REG(s->feature);
@@ -897,11 +948,15 @@ static __u64 sbi_sta_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG(shmem_hi),
 };
 
-static __u64 sbi_fwft_regs[] = {
+static __u64 sbi_fwft_misaligned_deleg_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT,
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.enable),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.flags),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.value),
+};
+
+static __u64 sbi_fwft_pointer_masking_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT,
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.enable),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.flags),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.value),
@@ -1129,7 +1184,6 @@ KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
 KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
 KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
 KVM_SBI_EXT_SIMPLE_CONFIG(mpxy, MPXY);
-KVM_SBI_EXT_SUBLIST_CONFIG(fwft, FWFT);
 
 KVM_ISA_EXT_SUBLIST_CONFIG(aia, SSAIA);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, F);
@@ -1206,6 +1260,23 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zvksed, ZVKSED);
 KVM_ISA_EXT_SIMPLE_CONFIG(zvksh, ZVKSH);
 KVM_ISA_EXT_SIMPLE_CONFIG(zvkt, ZVKT);
 
+static struct vcpu_reg_list config_sbi_fwft_misaligned_deleg = {
+	.sublists = {
+		SUBLIST_BASE,
+		SUBLIST_SBI(fwft_misaligned_deleg, FWFT),
+		{0},
+	},
+};
+
+static struct vcpu_reg_list config_sbi_fwft_pointer_masking = {
+	.sublists = {
+		SUBLIST_BASE,
+		SUBLIST_ISA(smnpm, SMNPM),
+		SUBLIST_SBI(fwft_pointer_masking, FWFT),
+		{0},
+	},
+};
+
 struct vcpu_reg_list *vcpu_configs[] = {
 	&config_sbi_base,
 	&config_sbi_sta,
@@ -1213,7 +1284,8 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_sbi_dbcn,
 	&config_sbi_susp,
 	&config_sbi_mpxy,
-	&config_sbi_fwft,
+	&config_sbi_fwft_misaligned_deleg,
+	&config_sbi_fwft_pointer_masking,
 	&config_aia,
 	&config_fp_f,
 	&config_fp_d,

-- 
2.43.7

