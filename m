Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAD3A875C
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712394; cv=none; b=NmdI3A981qm1UN5kvEUD3KZohx9ASVnrGvBFLzfnahywat+1uc5T7zkiOzPS0Tukx0NERBGCyBBdiDManRSDfzP8lcO1gKS9d8d4i/AdyO+CaN8ASm4U0RdIW+I+/f5qK0NmzjePmInAEs4pR73POyJ8kEBocfBofGZpAxEW5RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712394; c=relaxed/simple;
	bh=cvUAsTrFkIrj7sOOtQTapU5bbueY2qQc6jX68sBmZmM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X5TPnNAA3is+i1X01vdX1THwVgRJOBluHqR4fO0pzvJRU2pZ1ZpeqX3CuL7wUskwTIDt0Udt/IevsZCLuMGj9sZ9VAxyN7QtaIj+LwuR8EW5PMg5O0JvIeLrRcqbnaLf1hdLWPgqoLWliVJFknbCPtzPz/SGo6V0oWfpPGj+34Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFs4R5uw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFs4R5uw"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828f0f5c23so2213999a12.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778712392; x=1779317192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YELOQZPcTBBErB1UYxWNKDZARfZD2Y8w3VhbBgSoudg=;
        b=BFs4R5uwPD264OC4NTnw7o70ppqV7KE5czMXhcGm4pC0+5sjr/zR4Z4JuwPSilmzU9
         qahsFg1BnDQKyz6SyQNAqnfn+KnHWj0nIPKy8+5Oj49VMMeIqSxTG9RWm2Exbwmga9K4
         /iCRGNkC02mpig4VCU4Tid8cPxrx9OCSQRZW3KlGiyV8Mfr3U93m72PbwIfI/OwmJ0eg
         j0WZACraUGgBzRG5rSQweLmaL8jApDbGXhhV4FQ/EKDyDaxatAKyUZWhckWCig3reSHQ
         rYkA4+gISxdqkg5Qs4JkC6tt9nPTx4PVQz66+e0F3wPuZ4aczR9ggvtfWN3x9mjiP4Bo
         XsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778712392; x=1779317192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YELOQZPcTBBErB1UYxWNKDZARfZD2Y8w3VhbBgSoudg=;
        b=n3RDgPmprcWPoNBo6/Pyktj6KHg9SEoTBL1mQiYe8At4qWEOhETXgAsRXJSE+lDeYn
         nDBJTO37bGvk6wmy1Kk/tljwz9R/H1suIbyZtbu4dzRlG7kmWAuCYNzc65JwArkUG4ah
         Z7PnJa0KUgFHjActVV3CLCKq2sfHGIaoEDYRwLH7F/DcItgzc0NOylHOmC1+6RNi2LRI
         8svY4OP0jA3JdsDpihN82Oz/U2SjyqzdPclmBVNfEu0R5Rr8F2Z9pclKVNOziuL0sl8x
         TqjiSp5sV6sLB2bcSQv+XIYm7T02x6BKP9RWP4ov27e6zMKPutME+BHjddgvoGyISoqZ
         i2nA==
X-Forwarded-Encrypted: i=1; AFNElJ/JRNT+zL8E0s1hVB9sBY/x6qAVIgkOzL+JPWrXeolcNjlH/FPm9UmemCvHWMdpkK92lfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPK2ylhCItzSQmCmdNjQWSVrRsCdD+h5GAf8kvEiYgSYuRnraY
	dgyCHDte8G0rtvA1VIl+SRd79Pu9uDKg5N2lgEBfi0zev9b5v7Jk6kjFC5rFKKAztdxT8oiayej
	H9ISJAS+u2Zct5A==
X-Received: from pgww9-n2.prod.google.com ([2002:a05:6a02:2c89:20b0:c0e:3543:bdb0])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2453:b0:39b:8dcb:f36d with SMTP id adf61e73a8af0-3af8218fa5amr5845569637.35.1778712392446;
 Wed, 13 May 2026 15:46:32 -0700 (PDT)
Date: Wed, 13 May 2026 15:46:06 -0700
In-Reply-To: <20260513224608.1859737-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513224608.1859737-1-jmattson@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260513224608.1859737-4-jmattson@google.com>
Subject: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

On AMD CPUs, CPUID faulting support is advertised via
CPUID.80000021H:EAX.CpuidUserDis[bit 17] and enabled by setting
HWCR.CpuidUserDis[bit 35].

Advertise the feature to userspace regardless of host CPU support. Allow
writes to HWCR to set bit 35 when the guest CPUID advertises
CpuidUserDis. Update cpuid_fault_enabled() to check HWCR.CpuidUserDis
as well as MSR_FEATURE_ENABLES.CPUID_GP_ON_CPL_GT_0.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kvm/cpuid.c             |  2 +-
 arch/x86/kvm/cpuid.h             |  5 +++--
 arch/x86/kvm/x86.c               | 18 ++++++++++++------
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6673601246b3..0eeae121b0a6 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -888,6 +888,7 @@
 #define MSR_K7_HWCR_IRPERF_EN_BIT	30
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_HWCR_CPUID_USER_DIS_BIT	35
+#define MSR_K7_HWCR_CPUID_USER_DIS	BIT_ULL(MSR_K7_HWCR_CPUID_USER_DIS_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
 #define MSR_K7_HWCR_CPB_DIS_BIT		25
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 1c95d1fa3ead..8e5340dd2621 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1248,7 +1248,7 @@ void kvm_initialize_cpu_caps(void)
 		F(AUTOIBRS),
 		EMULATED_F(NO_SMM_CTL_MSR),
 		/* PrefetchCtlMsr */
-		/* GpOnUserCpuid */
+		EMULATED_F(GP_ON_USER_CPUID),
 		/* EPSF */
 		F(PREFETCHI),
 		F(AVX512_BMM),
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 95d09ccbf951..fc96ba86c644 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -185,8 +185,9 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
 
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
index c60773349f35..6581018db16b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3990,22 +3990,28 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
2.54.0.631.ge1b05301d1-goog

