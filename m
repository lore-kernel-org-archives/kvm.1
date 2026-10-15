Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62334E323C
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080267; cv=none; b=VRhPonVu/xZFYIR1hebAKV+v9HnNwPXz7bY9PTjJj4fWkh4ODoTYb4ag6tYrqozG+YTSNFgDMM8ERyRXsfxe/gOtwuyYif/Ox5exo1yp6XyGK68+gdww45tqZ1cnS5w/s+655BaI+LKmahlmpUoYIFO7/PJ+DtJrwj15k+XU8FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080267; c=relaxed/simple;
	bh=gWK8Y6FBWvhqz0btGx1LmwUcE/dTxHRwTzZ3bPzjbFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SOlb2rfjsOwPlcA/++UB4Ip6WP1xWcX8WMnudXVTUQrQzi5HkGelzHu5tfK1lhAUT4eWHolLoTMvgZdr91m3Yy9Vr/hZYVNd+hu8eSo3EtFGWkJ+IvFAgaD4xBLLMOVwdKhw6Jy3xW4i7HVwbmWtMgT6/toKUcjd0wYN+4Lk6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUAr8BjE; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUAr8BjE"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35a04491c56so102466eec.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792080251; x=1792685051; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/HTMhf4d9uTe7pfHFO8gXnRLSbjR8N6Nyp6yU1jUvI=;
        b=mUAr8BjE5fNicjN8+S3vRnlKU6NU6s83FcjskDyaaNzHsTjIvKeuQpAgkclg2NHiR8
         zw95LUYbq8amWraFjo5p5xQnQgYgsGX9fIqE8JafaHH0PC9LCdaqMsMhqKSzA+T0OcH3
         H6+eg073V1KGzhhuuwljcsYNCVuBidYNvOGjUYLJIT0tsp6KLQHPKlPk3bEUt/qb2qXE
         z3Pz7s+IZKuU+UCIUOrKPG8d9QNGLkWHf3hWMIGnWGeTD2eOv2otlgLP7vEuaQLiBI/a
         XN2jL+XcQQLyOcKYTu9OiFvZlrHFTPJmlJBcNqwefPh9NXdo+tw28aM8CDLTVQt1iQ/c
         8IMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792080251; x=1792685051;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1/HTMhf4d9uTe7pfHFO8gXnRLSbjR8N6Nyp6yU1jUvI=;
        b=Okckh9rsRe6r03uJqrHAjOntJRNhRJNq9Fk5vwjnPeQ6NFAoW60LikvTUlQGXyMe9P
         9dmiclXEMq5Lej4OtB9rxjMoVPTG+XPn1jjL9NSVrHw+FUhWvOLGreRQdpA+vQo4+hph
         tTcB6tVEJioXfK+MGJn+YOtWIMVKlkwF4hyj375tfTK/gAo/KEgnvRExZqVuTM0O5zSx
         vUnDRDXGe1l+O0ixbmIOEJvkWD3FslwZRl5ia0rlW2WMhTfHFHFGrH035L7Ylhb/h90l
         YWxFbRQEva70tP2BRGOdXDfjiY2pB7zryMtO70m3AtbVymDkYyrNwIpsalhA1coDxGn9
         HixQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcj9f59A/36Pi/lc41kKl82/MwpoGc+6+9SJ5xX4+CW2GVHTR/WZzLqIQqEBU7xTOFWZY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZtzFRjYgobACIjOmELPhTZ8EHyjeIa9P1dXB/p4H4rcVX4FMf
	XyxDNIExVk6C755X37zZSWJm7KjKGLbhN7YDorricsgtcHIt8eYOLk5wJ0uOpWpqgoLHPCUM0bi
	AI6+hZmLDerhuEw==
X-Received: from dlam5-n1.prod.google.com ([2002:a05:701b:2085:10b0:15f:abb4:cfc6])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:20c2:10b0:353:804a:5e83 with SMTP id 5a478bee46e88-3602d6e5a11mr455669eec.8.1792080233613;
 Thu, 15 Oct 2026 09:03:53 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:03:45 +0000
In-Reply-To: <20261015160346.181835-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015160346.181835-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015160346.181835-6-aaltinay@google.com>
Subject: [PATCH 6.18.y v2 5/6] KVM: x86: Virtualize AMD CPUID faulting
From: Anil Altinay <aaltinay@google.com>
To: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Anil Altinay <aaltinay@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

commit e93a93f11490992a477546d38d3a37b9b8dc6a5f upstream.

On AMD CPUs, CPUID faulting support is advertised via
CPUID.80000021H:EAX.CpuidUserDis[bit 17] and enabled by setting
HWCR.CpuidUserDis[bit 35].

Advertise the feature to userspace regardless of host CPU support. Allow
writes to HWCR to set bit 35 when the guest CPUID advertises
CpuidUserDis. Update cpuid_fault_enabled() to check HWCR.CpuidUserDis as
well as MSR_FEATURE_ENABLES.CPUID_GP_ON_CPL_GT_0.

Unlike VMX, SVM prioritizes the CPUID intercept over the #GP induced by
CPUID faulting.[1] This behavior has been confirmed on a Turin CPU (F/M/S
1AH/2/1).

Link: https://lore.kernel.org/r/DS7PR12MB82011943131DF5415365E19E940B2@DS7PR12MB8201.namprd12.prod.outlook.com [1]
Signed-off-by: Jim Mattson <jmattson@google.com>
Link: https://patch.msgid.link/20260527174347.2356165-5-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Anil Altinay <aaltinay@google.com>
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kvm/cpuid.c             |  2 +-
 arch/x86/kvm/cpuid.h             |  5 +++--
 arch/x86/kvm/x86.c               | 18 ++++++++++++------
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index d0a0cc8e8bd9..71bbdd920ac3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -863,6 +863,7 @@
 #define MSR_K7_HWCR_IRPERF_EN_BIT	30
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_HWCR_CPUID_USER_DIS_BIT	35
+#define MSR_K7_HWCR_CPUID_USER_DIS	BIT_ULL(MSR_K7_HWCR_CPUID_USER_DIS_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
 #define MSR_K7_HWCR_CPB_DIS_BIT		25
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3f2689fdc304..5edd00ac7fa0 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1220,7 +1220,7 @@ void kvm_set_cpu_caps(void)
 		F(PREFETCHI),
 		EMULATED_F(NO_SMM_CTL_MSR),
 		/* PrefetchCtlMsr */
-		/* GpOnUserCpuid */
+		EMULATED_F(GP_ON_USER_CPUID),
 		/* EPSF */
 		SYNTHESIZED_F(SBPB),
 		SYNTHESIZED_F(IBPB_BRTYPE),
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 872bc99c55ed..0d757852a1e5 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -177,8 +177,9 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
 
 static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.msr_misc_features_enables &
-		  MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
+	return (vcpu->arch.msr_misc_features_enables &
+		MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) ||
+		(vcpu->arch.msr_hwcr & MSR_K7_HWCR_CPUID_USER_DIS);
 }
 
 static inline bool kvm_is_cpuid_allowed(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a91599e5d8db..8e2ef1e45bc7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3656,22 +3656,28 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_EFER:
 		return set_efer(vcpu, msr_info);
-	case MSR_K7_HWCR:
-		data &= ~(u64)0x40;	/* ignore flush filter disable */
-		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
-		data &= ~(u64)0x8;	/* ignore TLB cache disable */
-
+	case MSR_K7_HWCR: {
 		/*
 		 * Allow McStatusWrEn and TscFreqSel. (Linux guests from v3.2
 		 * through at least v6.6 whine if TscFreqSel is clear,
 		 * depending on F/M/S.
 		 */
-		if (data & ~(BIT_ULL(18) | BIT_ULL(24))) {
+		u64 valid = BIT_ULL(18) | BIT_ULL(24);
+
+		data &= ~(u64)0x40;	/* ignore flush filter disable */
+		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
+		data &= ~(u64)0x8;	/* ignore TLB cache disable */
+
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_GP_ON_USER_CPUID))
+			valid |= MSR_K7_HWCR_CPUID_USER_DIS;
+
+		if (data & ~valid) {
 			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 			return 1;
 		}
 		vcpu->arch.msr_hwcr = data;
 		break;
+	}
 	case MSR_FAM10H_MMIO_CONF_BASE:
 		if (data != 0) {
 			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
-- 
2.56.0.385.gd3acb90ef8-goog

