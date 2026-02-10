Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E341337BBD
	for <kvm@vger.kernel.org>; Tue, 10 Feb 2026 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757756; cv=none; b=kd7slWLva095VBFm5vct1WndN1MgEXEKP2W7WEIeh35Dw8H6YPB47+gzLYu2qIsBRUkziQ5wXCP3Fh4dTZOyXoSI+Rya+qwEIMf9svtxTD4Dq1BD1mGsoNd081h3saALcfnMRUxLutb/roTJQEVnmtkOo6LANQh0zOaz2Krhqlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757756; c=relaxed/simple;
	bh=juew5tK8cMCmxjWp51apnX3Q8woQwkite/TcOCpcoh0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UkoaVs6Lk1XaX/Xq1iTw38yrPTPJo2JGN7ZdujOHtzEUem44Un/JaiNn2oBNlmAE+Uwx9yH0YTCXW2H3zj4GcOi/vFxjoq5V4TE73+c5OHhhk7SrWfvnlcK9WkVsaFqKdo82j1Sg7MFg96MK1M7If/mestFJVoj63thOdfcEehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jamieliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+okEVaN; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jamieliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+okEVaN"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba7e98178fso1401315eec.0
        for <kvm@vger.kernel.org>; Tue, 10 Feb 2026 13:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770757754; x=1771362554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E75Sz0tRvZGbYQEnUjjHiNpLtegGLtqyRDd4+wv2HhI=;
        b=O+okEVaNTe100JouZdFELVZPkBngepU/4v1B8se6hNzMX3d6TBC3aj+9Cd+GZ+ZRTN
         T3oIOvGcjtalmBXJwKB2Tb5vVxMBidqIw5ChiW9k7OK0DUGWEvEvylxOeaiVriLnu6mu
         VF7+c9fyoo6M09dYk7+HhS1IUCEq7iVpjFp6frLz5rLApSG1fQ7qRuI39/EnnBJnurAc
         hwL68QRQV+2FVxipsC7sOSsf6Lxdp1zxWhYcyog89Q0gEYlmaoYNHZrrl9dqu2TJRfiL
         /Neu0JYdBtVBVFaKg7/mPGa32zEwDKHXheNCGFvWdXO0r937/SVrBHw4cARGcS2vr3Bl
         uRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770757754; x=1771362554;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E75Sz0tRvZGbYQEnUjjHiNpLtegGLtqyRDd4+wv2HhI=;
        b=gnAlbHzvZLfLS5meVWzTK6ikLYY+dAHUX78Yf4ULGUHeDhGxDBoeHo5OmVw5fMPKrZ
         LlqyE4whA7rkbQME7Zv2hdbbBzJdNqNLa2Xad/Jgs/APSQf+qipWZM7R5Bt7bdQ43VXA
         DY4AbYVLFpXXdy7lOixuGihgBXSeIkWRoJS7f92PxZhFh73JQz31swaUh22ekJVyBVQd
         pye7/Ni7ZfoZR+FDOTG0D+YgHO5U5YBOO6PwSkVDHXXeCfKkMtNje8YM/ud5MQygMNm/
         hyW8UKn3IyRLuupH4T4g4b7PE/clklYiw8Dj1rugvpi9czZzBpklBn96GEkG9EbqVTSv
         rFfA==
X-Forwarded-Encrypted: i=1; AJvYcCUyFy65f38QYrwIjL+itL6U520FX8Z1wvPocT13cV10SVhl6dOS8G2HKpMGqzN6bGL7uQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbyyXFZHuJ6IPqW/HbhiSq0mmR7SwmRnhu126cAyB2AlFJrxXt
	kOj1IMIdXY8QUK4HVnWgMrkPz4chNjf1nspIFpuySegHapFwopa19dqfj8GnCaT8RQAd9D43hHv
	EZEQQMAXCNDTGHg==
X-Received: from dybb25.prod.google.com ([2002:a05:693c:6099:b0:2ba:766d:5f00])
 (user=jamieliu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1004:b0:2ba:14a6:c96f with SMTP id 5a478bee46e88-2ba9b509528mr104318eec.36.1770757754282;
 Tue, 10 Feb 2026 13:09:14 -0800 (PST)
Date: Tue, 10 Feb 2026 13:09:11 -0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260210210911.1118316-1-jamieliu@google.com>
Subject: [PATCH] KVM: x86: Virtualize AMD CPUID faulting
From: Jamie Liu <jamieliu@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jamie Liu <jamieliu@google.com>
Content-Type: text/plain; charset="UTF-8"

CPUID faulting via MSR_MISC_FEATURES_ENABLES_CPUID_FAULT is only used on
Intel CPUs. The mechanism virtualized by this change is used on AMD
CPUs. See arch/x86/kernel/cpu/amd.c:bsp_init_amd(),
arch/x86/kernel/process.c:set_cpuid_faulting().

Signed-off-by: Jamie Liu <jamieliu@google.com>
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kvm/cpuid.c             |  2 +-
 arch/x86/kvm/cpuid.h             | 28 +++++++++++++++++-----------
 arch/x86/kvm/x86.c               | 14 +++++++++-----
 4 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3d0a0950d20a..79600fb551cf 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -880,6 +880,7 @@
 #define MSR_K7_HWCR_IRPERF_EN_BIT	30
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_HWCR_CPUID_USER_DIS_BIT	35
+#define MSR_K7_HWCR_CPUID_USER_DIS	BIT_ULL(MSR_K7_HWCR_CPUID_USER_DIS_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
 #define MSR_K7_HWCR_CPB_DIS_BIT		25
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 88a5426674a1..1dba0982e543 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1221,7 +1221,7 @@ void kvm_set_cpu_caps(void)
 		F(PREFETCHI),
 		EMULATED_F(NO_SMM_CTL_MSR),
 		/* PrefetchCtlMsr */
-		/* GpOnUserCpuid */
+		EMULATED_F(GP_ON_USER_CPUID),
 		/* EPSF */
 		SYNTHESIZED_F(SBPB),
 		SYNTHESIZED_F(IBPB_BRTYPE),
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index d3f5ae15a7ca..9ca8321762fb 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -173,17 +173,6 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
 	return x86_stepping(best->eax);
 }
 
-static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT;
-}
-
-static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.msr_misc_features_enables &
-		  MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
-}
-
 static __always_inline void kvm_cpu_cap_clear(unsigned int x86_feature)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
@@ -267,6 +256,23 @@ static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
 	return vcpu->arch.cpu_caps[x86_leaf] & __feature_bit(x86_feature);
 }
 
+static inline bool supports_cpuid_fault_intel(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT;
+}
+
+static inline bool supports_cpuid_fault_amd(struct kvm_vcpu *vcpu)
+{
+	return guest_cpu_cap_has(vcpu, X86_FEATURE_GP_ON_USER_CPUID);
+}
+
+static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
+{
+	return (vcpu->arch.msr_misc_features_enables &
+		MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) ||
+	       (vcpu->arch.msr_hwcr & MSR_K7_HWCR_CPUID_USER_DIS);
+}
+
 static inline bool kvm_vcpu_is_legal_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_LAM))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 72d37c8930ad..9140f66b21c6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3992,14 +3992,18 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		data &= ~(u64)0x8;	/* ignore TLB cache disable */
 
 		/*
-		 * Allow McStatusWrEn and TscFreqSel. (Linux guests from v3.2
-		 * through at least v6.6 whine if TscFreqSel is clear,
-		 * depending on F/M/S.
+		 * Allow McStatusWrEn, TscFreqSel, and CpuidUserDis. (Linux
+		 * guests from v3.2 through at least v6.6 whine if TscFreqSel
+		 * is clear, depending on F/M/S.)
 		 */
-		if (data & ~(BIT_ULL(18) | BIT_ULL(24))) {
+		if (data & ~(BIT_ULL(18) | BIT_ULL(24) |
+			     MSR_K7_HWCR_CPUID_USER_DIS)) {
 			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 			return 1;
 		}
+		if (data & MSR_K7_HWCR_CPUID_USER_DIS &&
+		    !supports_cpuid_fault_amd(vcpu))
+			return 1;
 		vcpu->arch.msr_hwcr = data;
 		break;
 	case MSR_FAM10H_MMIO_CONF_BASE:
@@ -4248,7 +4252,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_MISC_FEATURES_ENABLES:
 		if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
 		    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
-		     !supports_cpuid_fault(vcpu)))
+		     !supports_cpuid_fault_intel(vcpu)))
 			return 1;
 		vcpu->arch.msr_misc_features_enables = data;
 		break;
-- 
2.53.0.239.g8d8fc8a987-goog

