Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE01D3CAA47;
	Wed,  8 Jul 2026 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492448; cv=none; b=czvE10U1SRgfewY8H+NawGsWXpiMIMB8I2p8CesRvFJV1zpqiNRT2J7U9fx2OH/3wRdudxEXVXgW4fIBmmHVX1R5VsHxM/CfXrEPPq/rzC2nuleRNnJ414Nf8TjJ7jLevtOLoA4KqoJNkgKX9LIg6GC7koge8lYVBz7RbRwo/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492448; c=relaxed/simple;
	bh=Y5YkAHbPMQQ1Gu91uPhEfQ6DTP56gYvu07YYUu+70b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8CBXgzOjuRrKF0cHjmkJlQr5+szjBkOu7qj+7qtj9IhJDISMRp2cr0vAGs5p0CatXRueIU/aR3e9RBWVDKeflHYeP0lph93AOaKReQ3QlSShrDKKH/SyPpKdr8ZwoSW8NAj5DWbyAJsEdeEVHVYX1MOsTrDXf98TaM2A6z53G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh+nLTPB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh+nLTPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42431F000E9;
	Wed,  8 Jul 2026 06:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492446;
	bh=Nco4zVrQXlTy02zgToAU6MrMQS9ixFjxktSZ71JJljY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uh+nLTPB40Cf33aSwjOmcR7cnVceLztbA8/NOry2wAiCNBLKuekfLBs8E4btLm79u
	 0QkgsY7KLL7tv4F6iIP2oeChgJlFp7xO3Fy4Nf8NVaKrVdYWfnUyJcesq4+jrXbNfM
	 yVCbin0omJdPDxTlU2Qt6P+J9SM7Hc37V24YMPpiYlt0wE+PP8T5sB7IkZHT8Rxd08
	 fpd0Wxj24cz79yjTfDgDXB8BZgKRUSxcJhz79rogqe+BFPX26F+GQE/3X7jF7+eHTu
	 cO5j+8iPMnBsxFlDE2jU0b9uumZr6Cq/9ehTMoygyOrc/5VdIYblO8iEQNthhFhYh0
	 4YA2u66TTW+dQ==
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
Subject: [RFC PATCH v3 12/27] KVM: SVM: Short-circuit a few AVIC flows for Secure AVIC
Date: Wed,  8 Jul 2026 12:02:10 +0530
Message-ID: <644fe860a5f5889745f197e89af88d199541bedf.1783490022.git.naveen@kernel.org>
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

Short-circuit (and return early from) a few functions in AVIC that are
not relevant for Secure AVIC:
1. In Secure AVIC mode, hardware ignores the MSR permissions bitmap
   w.r.t the APIC MSRs, so do not change MSR intercepts. We still want
   to intercept those MSRs since the guest is free to request emulation
   of those MSRs through GHCB calls and checks require that the
   intercepts be set.
2. In avic_[activate|init]_vmcb(), skip setting up AVIC-related VMCB
   fields since those are not used by Secure AVIC. AVIC/x2AVIC in
   particular should *not* be enabled in the VMCB int_ctl for Secure
   AVIC.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/avic.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 0a4e91e15e74..bfd758369b5a 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -141,6 +141,17 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 	u64 rd_regs;
 	int i;
 
+	/*
+	 * For Secure AVIC, treat all APIC MSRs as intercepted always. Secure AVIC
+	 * hardware controls MSR interception and the MSR permission bitmap is not
+	 * consulted by hardware. However, the guest is free to use GHCB to request
+	 * emulation of APIC MSR reads and writes. In that scenario, we need these
+	 * MSRs to be seen as being intercepted so that sev_es_prevent_msr_access()
+	 * does not reject those MSR accesses.
+	 */
+	if (snp_is_secure_avic_enabled(svm->vcpu.kvm))
+		return;
+
 	if (intercept == svm->x2avic_msrs_intercepted)
 		return;
 
@@ -192,9 +203,6 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
 	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
-	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
-	vmcb->control.avic_physical_id |= avic_get_max_physical_id(vcpu);
-	vmcb->control.int_ctl |= AVIC_ENABLE_MASK;
 
 	svm_clr_intercept(svm, INTERCEPT_CR8_WRITE);
 
@@ -227,6 +235,13 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 	 */
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
 
+	if (snp_is_secure_avic_enabled(vcpu->kvm))
+		return;
+
+	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
+	vmcb->control.avic_physical_id |= avic_get_max_physical_id(vcpu);
+	vmcb->control.int_ctl |= AVIC_ENABLE_MASK;
+
 	/*
 	 * Note: KVM supports hybrid-AVIC mode, where KVM emulates x2APIC MSR
 	 * accesses, while interrupt injection to a running vCPU can be
@@ -422,10 +437,12 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(svm->vcpu.kvm);
 
-	vmcb->control.avic_backing_page = avic_get_backing_page_address(svm);
-	vmcb->control.avic_logical_id = __sme_set(__pa(kvm_svm->avic_logical_id_table));
-	vmcb->control.avic_physical_id = __sme_set(__pa(kvm_svm->avic_physical_id_table));
-	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE;
+	if (!snp_is_secure_avic_enabled(svm->vcpu.kvm)) {
+		vmcb->control.avic_backing_page = avic_get_backing_page_address(svm);
+		vmcb->control.avic_logical_id = __sme_set(__pa(kvm_svm->avic_logical_id_table));
+		vmcb->control.avic_physical_id = __sme_set(__pa(kvm_svm->avic_physical_id_table));
+		vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE;
+	}
 
 	if (kvm_vcpu_apicv_active(&svm->vcpu))
 		avic_activate_vmcb(svm);
-- 
2.54.0

