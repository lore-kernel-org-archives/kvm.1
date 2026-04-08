Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA73DEACC
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662973; cv=none; b=YYrKFnlaRmwFiyutmmHb4n/rgiCNLjm3t8cb0fJMF5iCZKsYKiIc0PmeCuDcVlfzbBP4jI4TwUQ1e125jXTlOQSB+M6vf4GsHtweNek95eas4vOKg3WY4Sei+ObRC9zL8IEfZyDmYCjFmqCHopIhc5U31i/wVtvnd0gzh1qVFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662973; c=relaxed/simple;
	bh=KwfssTU0csEG8EFIv0YNsoktwPl9amvk7G4CBUf0tMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJbAUxTmLgH8aV3J/mIMprwfQRIrGLGXsvWtBbF5RxRfpZGbmNU4iYUfBA5kvI9xQDVqrBYv3kd+JCOIfvYcONFtRXvI8H8CG0LQd1rlsePyBl3KhVElL19krRThIp/aSymXhlIE2iziuVI5xczM2evUxDeYlZUN1sNk8tkSwYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bhhc78EZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bhhc78EZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmv4vG8EdF+XHXSjT5PLH1s8XlJsY5LnBC8HBPikyXc=;
	b=Bhhc78EZXdpUDCjG6WBAh93Djv1vHB/VmfvQCivnz0iSueI3asUPKEWY3mAo+kXwZ0NzB0
	O6Gc2LIH36HBZIKvuUGtI9kCng5Ms9Lb4ne+B9rp+C692QVeDiZPU683ir08uBbqQZBee0
	N73k4rY6rLY5U6AzhTa5EHU0lPpljhA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-9PubGUhHO-WN7ZbRXJQg_Q-1; Wed,
 08 Apr 2026 11:42:47 -0400
X-MC-Unique: 9PubGUhHO-WN7ZbRXJQg_Q-1
X-Mimecast-MFC-AGG-ID: 9PubGUhHO-WN7ZbRXJQg_Q_1775662966
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA85C1956068;
	Wed,  8 Apr 2026 15:42:45 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11CBB300019F;
	Wed,  8 Apr 2026 15:42:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 25/27] KVM: SVM: enable GMET and set it in MMU role
Date: Wed,  8 Apr 2026 11:42:15 -0400
Message-ID: <20260408154217.458420-26-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-1-pbonzini@redhat.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Set the GMET bit in the nested control field.  This has effectively
no impact as long as NPT page tables are changed to have U=0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c    |  6 +++++-
 arch/x86/kvm/svm/nested.c |  7 +++++--
 arch/x86/kvm/svm/svm.c    | 16 ++++++++++++++++
 arch/x86/kvm/svm/svm.h    |  1 +
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 354f8af5d90a..14c0c2da75bb 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5840,7 +5840,6 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role = {0};
 
-	role.access = ACC_ALL;
 	role.cr0_wp = true;
 	role.cr4_smep = kvm_x86_call(tdp_has_smep)(vcpu->kvm);
 	role.efer_nx = true;
@@ -5851,6 +5850,11 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 	role.direct = true;
 	role.has_4_byte_gpte = false;
 
+	/* All TDP pages are supervisor-executable */
+	role.access = ACC_ALL;
+	if (role.cr4_smep && shadow_user_mask)
+		role.access &= ~ACC_USER_MASK;
+
 	return role;
 }
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a76f2b8cbef9..863040ecec0e 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -829,9 +829,12 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	/* Also overwritten later if necessary.  */
 	vmcb02->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
 
-	/* nested_cr3.  */
-	if (nested_npt_enabled(svm))
+	/* Use vmcb01 MMU and format if guest does not use nNPT */
+	if (nested_npt_enabled(svm)) {
+		vmcb02->control.nested_ctl &= ~SVM_NESTED_CTL_GMET_ENABLE;
+
 		nested_svm_init_mmu_context(vcpu);
+	}
 
 	vcpu->arch.tsc_offset = kvm_calc_nested_tsc_offset(
 			vcpu->arch.l1_tsc_offset,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e6477affac9a..1705e3cafcb0 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -135,6 +135,9 @@ module_param(pause_filter_count_max, ushort, 0444);
 bool npt_enabled = true;
 module_param_named(npt, npt_enabled, bool, 0444);
 
+bool gmet_enabled = true;
+module_param_named(gmet, gmet_enabled, bool, 0444);
+
 /* allow nested virtualization in KVM/SVM */
 static int nested = true;
 module_param(nested, int, 0444);
@@ -1170,6 +1173,10 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 		save->g_pat = vcpu->arch.pat;
 		save->cr3 = 0;
 	}
+
+	if (gmet_enabled)
+		control->nested_ctl |= SVM_NESTED_CTL_GMET_ENABLE;
+
 	svm->current_vmcb->asid_generation = 0;
 	svm->asid = 0;
 
@@ -4475,6 +4482,11 @@ svm_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
 	hypercall[2] = 0xd9;
 }
 
+static bool svm_tdp_has_smep(struct kvm *kvm)
+{
+	return gmet_enabled;
+}
+
 /*
  * The kvm parameter can be NULL (module initialization, or invocation before
  * VM creation). Be sure to check the kvm parameter before using it.
@@ -5224,6 +5236,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.write_tsc_multiplier = svm_write_tsc_multiplier,
 
 	.load_mmu_pgd = svm_load_mmu_pgd,
+	.tdp_has_smep = svm_tdp_has_smep,
 
 	.check_intercept = svm_check_intercept,
 	.handle_exit_irqoff = svm_handle_exit_irqoff,
@@ -5464,6 +5477,9 @@ static __init int svm_hardware_setup(void)
 	if (!boot_cpu_has(X86_FEATURE_NPT))
 		npt_enabled = false;
 
+	if (!npt_enabled || !boot_cpu_has(X86_FEATURE_GMET))
+		gmet_enabled = false;
+
 	/* Force VM NPT level equal to the host's paging level */
 	kvm_configure_mmu(npt_enabled, get_npt_level(),
 			  get_npt_level(), PG_LEVEL_1G);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 6942e6b0eda6..41042379aa48 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -44,6 +44,7 @@ static inline struct page *__sme_pa_to_page(unsigned long pa)
 #define	IOPM_SIZE PAGE_SIZE * 3
 #define	MSRPM_SIZE PAGE_SIZE * 2
 
+extern bool gmet_enabled;
 extern bool npt_enabled;
 extern int nrips;
 extern int vgif;
-- 
2.52.0


