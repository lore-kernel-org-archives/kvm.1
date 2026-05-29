Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9933A718D
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036129; cv=none; b=OI4hxiQQoZtJZIz224kAHxPQKy1TPP+Y+MSqchNdTzhTMx7n6pSJsRRy0GN06hQ806K0KvvW9vkkar7mSE3K/DNzg2IpBkoHZOz9l4NDprqVon1ifDzdynPEhgjmwliXXbsdVOpZ9rTw5bU6dK29OPwZnF3SvJQIfZ8CYedzaEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036129; c=relaxed/simple;
	bh=3uThBhNaY+zRvOn064pZTF8raJgmTDzDgSiNvxgnqt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9Mh4Q1vJ7/afeTAs41VIz1lvLWyhDnMsGRXTDQuLCeeQGaVHyLfgUmrC6RYLth9gGc9GuTwlYa6BQxx/oE1tcOCFSlK6nmoYzobsR7LM/t2ftQ8hfzbwo2pe49PZJQ9uxLWK+K9QVu5Yuq6xf9gAvKEb/qLVR2PzmJhIvBnPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=khpmOwDL; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="khpmOwDL"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304545f5206so10268650eec.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1780036127; x=1780640927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxMETX/1hxmLpjZh8E8SUrLwKpabU2lfgKz/6O/A+s8=;
        b=khpmOwDLwZtr949TB3tK4ktuSXLgtGcA2o0bRifRIsmWjSt45ncgs3L76RduBod8/i
         p6qmfcZyzFoMrmGuAnxyxp5p5hf1E2E6IFaBDiAHI2g3uG+camZLC3nTC3+aacE9fUdy
         1aFxCNHG9o5fD5yHSpMXDkKC2Mn8NeU3WDW07JQES4CdA9BpzoCMVm4r9n5FEfPNIHaL
         TUAyC5rD8uI6DnV9lSFj2VutKx9D/J2nv7LJEeI89dhlNr3iJ3p7xpgemCNOTovvbuNg
         BUry9W2IctKW7FnuqGWuawv3yf1Fowrj2LuE/BTx1wLHf3LTGtQWNHhBEH8KvL16SQwm
         3oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780036127; x=1780640927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gxMETX/1hxmLpjZh8E8SUrLwKpabU2lfgKz/6O/A+s8=;
        b=nefGs/YCpFt9uFKF4rDAITN9gzYEID6+o8eDW5P5Mayq0LVsvyPKCAytCVcRhRBHi3
         kk8uR0lnd+yQcNd+rQMX7BBRLdY1PkztDSpau8WZS6gF8ymSzZOaVldK4NbvWGv1ADUK
         8ed4rEaPA6uQODXtJ5SnO1NNDvrpQB+l+nr/sSV6IEq/zfkKRjLLjZPYCljWEfOF3R2C
         fEJTouYj2E/1qYC/11T2pfrrdnFP6yLQmJqt0hQtByLEyhxRw12p4UdecsdqOi6BVd3V
         M1D/TJvia9R3Px+ZRPzclnOWGmCE89WyrH6enptHj5ZjgR3zHlgI0iKpzMhr7wA00GD4
         lfCA==
X-Forwarded-Encrypted: i=1; AFNElJ+KZVhY8F0UxM97pnpxmKhMv9O4H4BRorgaWmuUfPBBSNJaQpNGt+W5eOCrvZYkgaUSq9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZqWBXBkZgZNCDMdXA6RLOLQg7Yy+iIXDcJeDoNW1oB8br8ncL
	NFsQERECvLTaTGFNvkViJr1W1XFv7HB82y4wCVXGh+e4N+xWwdYbj5sNIUHaQZLBShk=
X-Gm-Gg: Acq92OH9nVb7KWLR2xG8vp5dZtm6xQER+KTqhRDBWUHL5qC8FxxWq5wH5llAqB2AA8L
	cSIeQclwcjNwQaCBGABYXIQcyf+AlToOGpxYfloH40yN8ICY0OZ7wl/eo4pfoxkbVOQByRIf4QA
	2YD1f5uti1hpFePZljO4uHxaL4DXffx0r+UyOBzMh4mCnCCgOZFMzyHBgOIyd4V2l6hDp0Wgir0
	TPn0/Q+Sx+g61Jvifn6+jtjFjGuJZ4mE4LQvqh1JqCuOEMd+bmEx/gbTSU+oedpPY/8XXOH4Sfz
	MumoT1iu8D4LFcZlWBZlVEmElgZYkZdFl/s2SBBQ4HR/NT7p8oG/QoJL8L+E9QpM5fzjJ0VzbOY
	QbUcFd55WH0pFP8b6goQGnYhVGiibIz0zWhEzHZoUkjk+yDWAnw1o9nCKuFLpVFIAPnSMKzBztL
	5NO13kwpQsOBqm+6XClRwlVsNj3ybrdRTjQ7n710+e6zp1yeAD2Yx75g==
X-Received: by 2002:a05:7300:2154:b0:304:b93a:511a with SMTP id 5a478bee46e88-304eb204f20mr625767eec.28.1780036126724;
        Thu, 28 May 2026 23:28:46 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed3358b1sm694607eec.13.2026.05.28.23.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 23:28:46 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Thu, 28 May 2026 23:28:29 -0700
Subject: [PATCH v3 3/3] KVM: riscv: selftests: Split SBI FWFT into separate
 feature-specific sublists
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-kvm-get_reg_list-v2-v3-3-170969a8599f@sifive.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780036122; l=7950;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=3uThBhNaY+zRvOn064pZTF8raJgmTDzDgSiNvxgnqt0=;
 b=UJt9lgaaEV/6X0Wm2ZL+TKZkFJtdMJtIVecgcG006PE6wBq8pql2yEe41adYrKAvTbyBu6A4f
 Cqk7TgKtm+kAvoqekaex5imWd74p16LOhGAiiZ36mjnuiU3bTwdENQ9
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
  based on required ISA extensions and SBI extensions
- Add check_fwft_feature() helper to verify FWFT feature availability
  at runtime
- Update filter_reg() to handle per-feature FWFT register filtering

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 90 ++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 5033c09201ef..7ae55fbad29a 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -27,6 +27,23 @@ enum {
 };
 
 static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
+static bool isa_ext_enabled[KVM_RISCV_ISA_EXT_MAX];
+static bool sbi_ext_enabled[KVM_RISCV_SBI_EXT_MAX];
+
+bool check_supported_reg(struct kvm_vcpu *vcpu, __u64 reg)
+{
+	switch (reg & ~REG_MASK) {
+	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.enable):
+	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.flags):
+	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.value):
+		return sbi_ext_enabled[KVM_RISCV_SBI_EXT_FWFT] &&
+		       isa_ext_enabled[KVM_RISCV_ISA_EXT_SMNPM];
+	default:
+		break;
+	}
+
+	return true;
+}
 
 bool filter_reg(__u64 reg)
 {
@@ -149,6 +166,14 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1h):
 	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2h):
 		return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA];
+	/*
+	 * FWFT misaligned delegation registers are always visible when the SBI FWFT
+	 * extension is enable and the host supports the misaligned delegation.
+	 */
+	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.enable):
+	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.flags):
+	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.value):
+		return sbi_ext_enabled[KVM_RISCV_SBI_EXT_FWFT];
 	default:
 		break;
 	}
@@ -193,15 +218,39 @@ static int override_vector_reg_size(struct kvm_vcpu *vcpu, struct vcpu_reg_subli
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
@@ -209,8 +258,10 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 	 */
 	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
 		rc = __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
-		if (rc && isa_ext_state[i])
+		if (rc && isa_ext_enabled[i])
 			isa_ext_cant_disable[i] = true;
+		else
+			isa_ext_enabled[i] = false;
 	}
 
 	for (int i = 0; i < KVM_RISCV_SBI_EXT_MAX; i++) {
@@ -232,9 +283,13 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 		switch (s->feature_type) {
 		case VCPU_FEATURE_ISA_EXT:
 			feature = RISCV_ISA_EXT_REG(s->feature);
+			isa_ext_enabled[s->feature] = true;
 			break;
 		case VCPU_FEATURE_SBI_EXT:
 			feature = RISCV_SBI_EXT_REG(s->feature);
+			if (s->feature == KVM_RISCV_SBI_EXT_FWFT)
+				check_fwft_feature(vcpu, s, feature);
+			sbi_ext_enabled[s->feature] = true;
 			break;
 		default:
 			TEST_FAIL("Unknown feature type");
@@ -897,11 +952,15 @@ static __u64 sbi_sta_regs[] = {
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
@@ -1129,7 +1188,6 @@ KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
 KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
 KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
 KVM_SBI_EXT_SIMPLE_CONFIG(mpxy, MPXY);
-KVM_SBI_EXT_SUBLIST_CONFIG(fwft, FWFT);
 
 KVM_ISA_EXT_SUBLIST_CONFIG(aia, SSAIA);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, F);
@@ -1206,6 +1264,23 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zvksed, ZVKSED);
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
@@ -1213,7 +1288,8 @@ struct vcpu_reg_list *vcpu_configs[] = {
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

