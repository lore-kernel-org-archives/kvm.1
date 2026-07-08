Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED43D6664;
	Wed,  8 Jul 2026 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492529; cv=none; b=jFWSda+BvvYwBerQzZjy35tDOqUMk2lDb2iD3g4PMRWgC4Gjuzl+fTr2MhWUref87eQQvtRPy+Nd84KRf3PbyVYFLWYslS+7dGCMNrA25sgp09EYZiOXzNAnoYPPeK4pv843ufI+pb06G/+pEfD0rBXJXExuZUkYc/A/sbFixhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492529; c=relaxed/simple;
	bh=9Ak46BUL03HYpefxJDBYO1Gyhv7RxzpX6apTFTbdZYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azTazUsuGu2cMEdEOKo0sNqnbN2kOVMASIYLUNJCTo96OX+AisPrzQG7JdxGNvY+7nz7cov6JZiYKTwdQ3NO85UZ1gmtThrJ5U5T7L97bhcG+vR3lXdNXUQx5x0UN2iNUBathDRsBFMvlVxs8Ws7N2CKH82Y4aM+Lf7a8feolug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3jLsABS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3jLsABS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143FB1F00A3A;
	Wed,  8 Jul 2026 06:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492528;
	bh=mFkTuYODvt1gnB2t0NKHNnhuia45P1LpIuzT0pd6mt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V3jLsABSbd36We8kI9EhwP5QzUD3cnyraU6WfZK0IZ5LXtATbtffuIrUyxOPiJMP5
	 Cj5kN06RlMfK0P1liXX8dGqq3WzUM8NInTv4OoFcNuvKuoX4zJopqdscT/buvDX6Vi
	 F+EyWU4LSWeQ4J7lQLNTARth6wrGLTsE6u/XmwBhSjqCvVHrsLfTttZY+HpC3EG9UH
	 edbrdVN1GKofJ4IBCyyMd0KvnjIWRaAt34ETSZVyDT3be+6NN2culWgyOrXrWEXg0Y
	 Trwvi0wJ1nHH6dXPF/IS5c8Aos+uU2LQKIy3sO5qgIZzh/4FrUhYEpxChD4pBG5Gow
	 UBwkWi0DEJZAQ==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 09/27] KVM: SVM: Disable IRQ bypass for Secure AVIC
Date: Wed,  8 Jul 2026 12:02:07 +0530
Message-ID: <2436c49ec9a5000cf621d6578d819c427526085b.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Secure AVIC does not support accelerating device interrupts, so have
kvm_arch_has_irq_bypass() return false for a Secure AVIC enabled SEV-SNP
guest. Since we now have to consult kvm_arch, move the function to x86.c
and export it for use by KVM submodules.

Due to this, avic_pi_update_irte() should never be called for a Secure
AVIC guest. Add a WARN_ON() so that it is clear something is broken.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/include/asm/kvm_host.h | 8 ++------
 arch/x86/kvm/svm/avic.c         | 7 +++++++
 arch/x86/kvm/svm/sev.c          | 3 +++
 arch/x86/kvm/x86.c              | 7 +++++++
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d81179b43199..cabb368b7908 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1380,6 +1380,8 @@ struct kvm_arch {
 	bool apic_access_memslot_enabled;
 	bool apic_access_memslot_inhibited;
 
+	bool apicv_has_irq_bypass;
+
 	/*
 	 * Force apicv_update_lock and apicv_nr_irq_window_req to reside in a
 	 * dedicated cacheline.  They are write-mostly, whereas most everything
@@ -2063,10 +2065,4 @@ static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
 	kvm_x86_call(vcpu_unblocking)(vcpu);
 }
-
-static inline bool kvm_arch_has_irq_bypass(struct kvm *kvm)
-{
-	return enable_device_posted_irqs;
-}
-
 #endif /* _ASM_X86_KVM_HOST_H */
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 7340c9e251e0..9b4d3a10198b 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -919,6 +919,13 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			unsigned int host_irq, uint32_t guest_irq,
 			struct kvm_vcpu *vcpu, u32 vector)
 {
+	/*
+	 * Complain loudly as we should never reach here for Secure AVIC.
+	 * See kvm_arch_has_irq_bypass()
+	 */
+	if (WARN_ON_ONCE(snp_is_secure_avic_enabled(kvm)))
+		return -EINVAL;
+
 	/*
 	 * If the IRQ was affined to a different vCPU, remove the IRTE metadata
 	 * from the *previous* vCPU's list.
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 686227a15328..a47bb417bd98 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -566,6 +566,9 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 	INIT_LIST_HEAD(&sev->mirror_vms);
 	sev->need_init = false;
 
+	if (snp_is_secure_avic_enabled(kvm))
+		kvm->arch.apicv_has_irq_bypass = false;
+
 	kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV);
 
 	return 0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8dbc0fa302a8..ed94aa8ebc0d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7233,6 +7233,7 @@ static void kvm_apicv_init(struct kvm *kvm)
 						       APICV_INHIBIT_REASON_DISABLED;
 
 	set_or_clear_apicv_inhibit(&kvm->arch.apicv_inhibit_reasons, reason, true);
+	kvm->arch.apicv_has_irq_bypass = true;
 
 	init_rwsem(&kvm->arch.apicv_update_lock);
 }
@@ -10572,6 +10573,12 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 	return (vcpu->arch.msr_kvm_poll_control & 1) == 0;
 }
 
+bool kvm_arch_has_irq_bypass(struct kvm *kvm)
+{
+	return enable_device_posted_irqs && kvm->arch.apicv_has_irq_bypass;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_arch_has_irq_bypass);
+
 #ifdef CONFIG_KVM_GUEST_MEMFD
 /*
  * KVM doesn't yet support initializing guest_memfd memory as shared for VMs
-- 
2.54.0

