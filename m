Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A388E3537F8
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303249; cv=none; b=NZVRRU3jM+tB1J9U1r+LgMNKxcIFyP+y98QG4NaQz5LzRi9wXQcSGQW8DurvCNHBZbIg+xdF+Wyregz6UYXJqBVCVdgtrYDQ3W22XfX9o5Wh87nseTezmULWrNXaIM95USuBtrrSwMt1S028s9VegZoW2/dtjY4085ErMqyJZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303249; c=relaxed/simple;
	bh=dvopGRgDaRky18g/xnQDE1UFxOqmLWbk1vHTjPzPMBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QXp7AfUcad+tZ9ryMCTCwaw06qlCJvXH7/axlPkH7vo3OHtZXZQrzJdjbT9aZuIkGdISPw5+10KLhGjVnzdDCDhKmq4My+0bM91MLzs2kIPergC6QghnHi937Ij3vIfvSf2B70OdQoMqj1o8pYMMh4U1u2LZaGQStjQdW/VzSdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ABBvk80x; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ABBvk80x"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso4849048eec.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1780303242; x=1780908042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpUjEIn4ZuMPGVsNdGCP5Htku1Dpr8xmIsStUVmQFFI=;
        b=ABBvk80xwBxEyqbYca1SqP6g/NLlKno7sXvkGt2i/lMEfOtGEceC3sAZN/A0wYUH2E
         4cGfjS9iexdNeqp3dcHvMyth/8NPdLxymT9X4Nl9aaRhGAz3bz0M5NtKlubkNNqOMSAz
         p31Xdubn6Mmcr+jiE7U2U0DWhdajKS+Q8bOLaym2V2/nmyu3D3moGKXt9chxFbhel8JI
         Ok/eSeprXePexZ7QLei+KnGG3yvlczY0jqyOSQxETravyrJvT0u7ZOOiCtPn2tkMCoZC
         QkaUSSpWR0ZEIZ0EV7RCPogzMW7TNL3InelqQoRp26RkVwn2ELCNuzxezWlW8Ea/UxhQ
         XJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303242; x=1780908042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZpUjEIn4ZuMPGVsNdGCP5Htku1Dpr8xmIsStUVmQFFI=;
        b=FKW7caIRlfjjdKqOYTHXp6NehFmeGAuSgVfW/CaU6j1hjYatNMIgi36wI31z0Th9Fr
         CGzCgZxqM+l2fulykWhASwtTD8zDa06oe+zdMukVk/ze9rSZtsY4PIKZ4s02swue/tWP
         ncYuu2N/4GoPEgtYHGSiewoljFD1Mu7w97RL2u5N/joac++jrf+0JFxmsJ2lkoBLV6Wn
         ETO4nXyEafEOhC3GrX3OHpv4Skw2XNVDKty57S0/U9Gkj2oWzvn1StU3IqbMCqhctkyu
         WZoMcWckje7zpegun7TOwdDNqKcShC7EHRXJn91I+2DBk0XJSbjtGcg0xbH9Apx54v7W
         T99g==
X-Forwarded-Encrypted: i=1; AFNElJ/vnXTUP5YS2Tp6Us3g5/+UL6oAYmZLKT/iNetZtF941WJ8OBoO9QDHsn6KxOPjbw39kyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHscStnQQ2LWYyEIjql77WgH7GKnlFPq7e55Pu56J3JFab4d7
	82qH1WKWU/2ugYHVhTRKcDkpeC+hHe/1WXoqWgzlL7qOOP2OVybWHqfrwxhF5Ag0FdLyxNDIt5u
	B7dMV716DDj/BF5zrg7FQG4fp0rr5e1X7sCNwHMwAdPdvyOGVIu8ZJr5kt+yr4cXm/y7V9eaUEV
	RE6WdN5rQkxzxT8sEZa63+KFfylEOj0X3QZ0MXeeGoBFphNQ==
X-Gm-Gg: Acq92OGcR1/wUtGYxY0CY7MmeW2P4AofsHyZMEqvOqRP98j9SWT/kpCRpPVfPbBlOhE
	mMAo58mGG9iDZc1MAaurWp4Gwj3nowlrbwkaSafnXdNZbTC+P4UYCRpOANdnyjdjxd8SHhM+S15
	36H72KIqvq1uX1mmijOU7NcNY7e2fCB3cXhNlGZ8i0NVN60MBkZ7BSyaHnaOlAV6+PB/TPWcSGq
	Lkg7ulA5OYgs5HuQi0JXRgufGtbuWm5gqQz3ecfjqAveFw+4qruieafX78MKvZo76wHQLO2RUqZ
	Wbzyx+yGyaa3oYjlGijY8wQtH4081JNJF8e5tnheWiKkVlXpz9OhgUfleJnG7BL2wBBmWdc20Op
	MEP5JF+Rd1Hru4ABX7xVEKX8SzZui82Lbljw49zTi1ZNsB3O1ivno3Q2u934Ei5FI7L2OO2Lb+O
	QsIoNpDEdsiBUKjoA1d0D2rLSuQfidJnF5z1+8+13pQKG2vV3RPDeik9+Cmz975yPD
X-Received: by 2002:a05:7300:cd94:b0:2e0:4edd:64e4 with SMTP id 5a478bee46e88-304fa75091emr4500790eec.26.1780303242427;
        Mon, 01 Jun 2026 01:40:42 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5b9be7sm8011818eec.27.2026.06.01.01.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:40:41 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 01 Jun 2026 01:40:36 -0700
Subject: [PATCH v4 3/3] KVM: riscv: selftests: Split SBI FWFT into separate
 feature-specific sublists
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-kvm-get_reg_list-v2-v4-3-c88abc81ebda@sifive.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780303237; l=6157;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=dvopGRgDaRky18g/xnQDE1UFxOqmLWbk1vHTjPzPMBI=;
 b=2HV2PtEehribkyjlVJiSDoKw01n9W76kDsd12gE0hfFft+547TXue2yYjgqmdzHfFWA9qYpdt
 qYXVGjh7cLfCjbRbfzHbu38BJLB5UyEVKjvAT3Mu+cfea8alvWtTAM9
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
- Add check_fwft_feature() helper to verify FWFT feature availability
  at runtime
- Update filter_reg() to handle per-feature FWFT register filtering

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 60 ++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 5033c09201ef..cb86cb6b3635 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -27,6 +27,7 @@ enum {
 };
 
 static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
+static bool sbi_ext_enabled[KVM_RISCV_SBI_EXT_MAX];
 
 bool filter_reg(__u64 reg)
 {
@@ -149,6 +150,14 @@ bool filter_reg(__u64 reg)
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
@@ -193,6 +202,27 @@ static int override_vector_reg_size(struct kvm_vcpu *vcpu, struct vcpu_reg_subli
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
 	unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] = { 0 };
@@ -235,6 +265,9 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 			break;
 		case VCPU_FEATURE_SBI_EXT:
 			feature = RISCV_SBI_EXT_REG(s->feature);
+			if (s->feature == KVM_RISCV_SBI_EXT_FWFT)
+				check_fwft_feature(vcpu, s, feature);
+			sbi_ext_enabled[s->feature] = true;
 			break;
 		default:
 			TEST_FAIL("Unknown feature type");
@@ -897,11 +930,15 @@ static __u64 sbi_sta_regs[] = {
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
@@ -1129,7 +1166,6 @@ KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
 KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
 KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
 KVM_SBI_EXT_SIMPLE_CONFIG(mpxy, MPXY);
-KVM_SBI_EXT_SUBLIST_CONFIG(fwft, FWFT);
 
 KVM_ISA_EXT_SUBLIST_CONFIG(aia, SSAIA);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, F);
@@ -1206,6 +1242,23 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zvksed, ZVKSED);
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
@@ -1213,7 +1266,8 @@ struct vcpu_reg_list *vcpu_configs[] = {
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

