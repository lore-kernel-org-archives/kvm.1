Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A3C3EAC87;
	Wed,  8 Jul 2026 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492563; cv=none; b=ASHTDDEZjqCKrVKL9CqBVm0nF4x3E+inK6ljVfWfAcArY8bS+2xkg8BanrvS4xkUYGwjTRrpoarKUr4kKkbwEJho0sPT+RYnLsX2a87KkhoNY+3NMaElsLUc0AV/Dd+bOdE6vWAQzrs8/oZGaNW0no1G6e98yjUhNJ3Zj5EJWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492563; c=relaxed/simple;
	bh=GKqNyuOeS23WcI2G27kVDV8c+hQetP6UAM3z4xGI4PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIz0fhgGvIn9KOySN/PP7VWkfM4E7c9fNCCukaseaim4YRHnR9fq+rhPXB1e3qfoLGqcxB4JofA/YpW2MuuBbrRs1xm76iR/QiQ33TK6D+ljpssMRyQPR/hg0GC1CKHKdMjp9THSz1hNesN6bDqYZKtBooT4Q2UIkXtOig3m3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejvBccmQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejvBccmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8ED1F00A3A;
	Wed,  8 Jul 2026 06:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492561;
	bh=VWGDb4zqhkfv51fdBwzO/qVGsznVRzNu1bLx6NOg9ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ejvBccmQg5ow5GtDqwdkWbgxr5u6m/oYKSL9W/xNXws+IDDpqY8XvRvN/D4krhbs5
	 O+OzX4dmFBH83VmeCGFMyUZEj8Z9hpxyP3za0kF4MIGzOIvnefzITfI4TZL3J6uj6b
	 ktVMn507eQyEeXMCZEQ6oKCIxCxgGHPfd7ltWi3ONulUXBnRrzLYXsG3PfNWdFqZq9
	 p9YgVvRaiO9jMSsmXicTGU6quNXvjvBkFn8ElptIcO+NXlHRwxDh/eejuvHAIA+sFe
	 5mZ2hmK82J3rbezv2d1sKei6UtvghjNPTTsfVwf66FivYZ4o6sIdwheL0tYonLJbUE
	 6JBmupmuhZ0dA==
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
Subject: [RFC PATCH v3 27/27] KVM: SVM: Advertise Secure AVIC support for SEV-SNP guests
Date: Wed,  8 Jul 2026 12:02:25 +0530
Message-ID: <1cafbb15b8cb4a52c31393bb07fc8e2178dd1991.1783490022.git.naveen@kernel.org>
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

Add Secure AVIC to sev_supported_vmsa_features allowing VMM to enable
Secure AVIC for SEV-SNP guests. Gate the same on all dependencies for
Secure AVIC being satisfied:
- X86_FEATURE_SNP_SECURE_AVIC itself signaling platform support
- X86_FEATURE_IDLE_HLT, more on this below
- 'enable_apicv' for dependency on AVIC being enabled
- 'vnmi' so that NMIs can be injected. And the implied dependency of
  vnmi on vgif so that VGIF is enabled for a Secure AVIC guest to unmask
  interrupts.

Secure AVIC has a hard dependency on idle hlt intercept since KVM has no
visibility into pending interrupts within the guest. If the guest took a
'#VMEXIT' just before 'sti; hlt' with interrupts disabled, and KVM
injected into the guest IRR (Requested_IRR --> guest vIRR), those won't
be deliverable before 'hlt' due to the interrupt shadow. On hlt
intercept, KVM won't be able to observe interrupts pending in the guest
APIC_IRR, KVM's APIC shadow backing page has nothing pending and so will
block the vCPU. Idle hlt intercept addresses this by preventing the
intercept from firing so that the vCPU proceeds to take those
interrupts.

Because 'enable_apicv' and 'vnmi' are new dependencies, move the call to
sev_hardware_setup() after they have been setup in svm_hardware_setup().

Co-developed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 13 ++++++++++---
 arch/x86/kvm/svm/svm.c | 17 +++++++++--------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 7c9c25135df8..b67cf1399cbf 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -512,7 +512,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 		return -EINVAL;
 
 	if (!snp_active)
-		valid_vmsa_features &= ~SVM_SEV_FEAT_SECURE_TSC;
+		valid_vmsa_features &= ~(SVM_SEV_FEAT_SECURE_TSC | SVM_SEV_FEAT_SECURE_AVIC);
 
 	if (data->vmsa_features & ~valid_vmsa_features)
 		return -EINVAL;
@@ -3234,8 +3234,15 @@ void __init sev_hardware_setup(void)
 	    cpu_feature_enabled(X86_FEATURE_NO_NESTED_DATA_BP))
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
 
-	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
-		sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+	if (sev_snp_enabled) {
+		if (tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
+			sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+
+		if (cpu_feature_enabled(X86_FEATURE_SNP_SECURE_AVIC) &&
+		    cpu_feature_enabled(X86_FEATURE_IDLE_HLT) &&
+		    enable_apicv && vnmi)
+			sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_AVIC;
+	}
 }
 
 void sev_hardware_unsetup(void)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2e32670ff957..a20f0abe138b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5731,14 +5731,6 @@ static __init int svm_hardware_setup(void)
 
 	iopm_base = __sme_set(__pa(iopm_va));
 
-	/*
-	 * Note, SEV setup consumes npt_enabled and enable_mmio_caching (which
-	 * may be modified by svm_adjust_mmio_mask()), as well as nrips.
-	 */
-	sev_hardware_setup();
-
-	svm_hv_hardware_setup();
-
 	enable_apicv = avic_hardware_setup();
 	if (!enable_apicv) {
 		enable_ipiv = false;
@@ -5781,6 +5773,15 @@ static __init int svm_hardware_setup(void)
 	if (!enable_pmu)
 		pr_info("PMU virtualization is disabled\n");
 
+	/*
+	 * Note, SEV setup consumes npt_enabled and enable_mmio_caching (which
+	 * may be modified by svm_adjust_mmio_mask()), as well as nrips, vnmi
+	 * and enable_apicv.
+	 */
+	sev_hardware_setup();
+
+	svm_hv_hardware_setup();
+
 	svm_set_cpu_caps();
 
 	kvm_caps.inapplicable_quirks &= ~KVM_X86_QUIRK_CD_NW_CLEARED;
-- 
2.54.0

