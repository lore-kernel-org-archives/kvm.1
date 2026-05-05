Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C674C9578
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010816; cv=none; b=ercJnILUwVIHFMNdOcILFWhcAgY4H3+iAg5jGJ/RyaG8/HZ35Whb2DKIoRGp8RZcQbNenNJtk/rQdqs7Y4zWeNJzzXDXTkdaI/s0RNN4thGA1JX6/yId5WequvpaQEHvYwG8PqVdtBHt06zk8QNS0qa31UIyVVe7KGHL5t3GA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010816; c=relaxed/simple;
	bh=LFkeX9qsGdttSQXmLMcCpdPJR2OgzjTQkeYJe9lIpmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0jjlW0/eaCpwmCpD1ahQ5DvygPR5uudbBdCG5FwGpIc/FK0alUTVV+DuUbOSPXMGa8Pf6NrCHSFvTcKwjV54JRQSCrHcF3A8EbbaOTCM/B8NIZSzz9KCgTxZYWfib5D92Wg+0rIVuv1Z8bSSFw4Tg7iZ/DeiGw64gAfRwsbXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QiNaa/82; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pkjK0lHu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiNaa/82";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pkjK0lHu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuYYO7ikI5CeDPzBpsYpeVKkw0Ln2WHMEnJ0q9e0zU0=;
	b=QiNaa/82syQwfGsw57AJm318Hlf2zlO/1SSfPHgXuuTa1WUGCU23wg79z2zrGDO/1RFmbo
	gYdcKjswSuksRLy7K/IQxx51svkxGPzq+ja5KO/4O3esu3sxanSkPRqu63AKdNmfH4mqT0
	AxpV4iXJ5KQOckC22064kho9QXPeWMk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-xpO5Aw3RNY-hL0mTHyvdFQ-1; Tue, 05 May 2026 15:53:32 -0400
X-MC-Unique: xpO5Aw3RNY-hL0mTHyvdFQ-1
X-Mimecast-MFC-AGG-ID: xpO5Aw3RNY-hL0mTHyvdFQ_1778010811
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d1b294dfeso8581385e9.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010811; x=1778615611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuYYO7ikI5CeDPzBpsYpeVKkw0Ln2WHMEnJ0q9e0zU0=;
        b=pkjK0lHuFfDDLvRPvRA9Rbs1qH/L+S2H8laoj26W1/FA8Xi33d0ItqouMdSqIV0Z4u
         YKExaepbs0xmsCnfHWEdB56L+oDqtrs4XvyPB+Fg4cftfu7hczcTeHzu9rRmlwoq0nxP
         XFRmo1JP2M2ser9dgF1vcjoZt85Evaaq1+fch1uiJpj+Wd/XtFbimUhf5KNmiPYPoQYb
         64Y4L63valxNJ5lwq/KaDwre6GCLBcMBBIYHEAAmVYRDipo8V3hs4ruAuLNwoU7qsK/3
         C7YxMXEPPzbl/so9jqzI0v7cOQdDfIoNmMjAJR5aNTgY9n0fC2AMzNc4u/Smas1fSciI
         e+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010811; x=1778615611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GuYYO7ikI5CeDPzBpsYpeVKkw0Ln2WHMEnJ0q9e0zU0=;
        b=csObLQoaPyKQheyRU0HsXWz+/fnJVIj0UXD0zvM4jCJSFn/hVJH4v3rBGrtNZrCYa8
         Z4bn5gU+7CqHaG/8FAdXLzUCKMX8QRYmQN7qWSxdbGU42Ys2Fne3Fqa3XcSRbeybWYn0
         yMz8W2c67kL2cLYUe3AVa40v738nExenbJ9EMpxya6WFDxLCJWKHaU/kymjDKt4U1Hp8
         Jl4z5k5GJZ5FXpSBjJZfGDx3u0lkw2DefuNThi9ullG/hPo74V70Py4Ahbu27teKk3sp
         1rfzqb89d/JXDvvQjeyCeYC/mj9mgxemSkB1eHZoOUJcgG5ah/MHlfxaiAMSXRoHyXav
         WIrA==
X-Forwarded-Encrypted: i=1; AFNElJ/EAttzxrJky+cgUH5ZglPE5KsnMrWy6MwHCr8SBExSiAd2gXQsgCxnsc4dzARUqsSL1is=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTWMZ7TlcoBzG6XQ7r8bb8BlhNypQ3FlYFZYRIDTQCaEevvG+D
	8/aEeuQshYAHXKnhJVk2xOSNTZTaD8LcOxDc6AfDE9byVXI2mZXW4Hsy+CgkFGscySzkexKCosE
	FLopn5Tah1dG+cLGIGEyZJgsPs1pZlReekPBkEV3FdD4b2g1DEA5Wng==
X-Gm-Gg: AeBDiesZ5iJWKyioe8RByjG0D0Ofn91dweqsKvfE0w9n6nzeEut8C7hkCp4SIYiA1E1
	1ZhEfCtxmXxYC6SPeICV1luHB1XGo285V528Zf436u0Esp6Ed8EG9hJPhxJhWMXLTPbJrQntlvD
	7MDW3lhxvV0BYMl0PEIorPogC5o8a8NTAY6stdX/ujkdW6Q5NLZIKc03AtLa1/tiJe3gAb94FVV
	Lkr/wsGUWtotKM2r+Lna2IUsgyjsFlCK+41EcPPf49fLQNulIaotUhH8t7hhoYOul/2P8TKbAdi
	yFlr+IiZQY9KBr61dwd/ISuDrfjqP0b/DhNCI+zdj4+abSLFUzXSdCTxebpNHnxD/muowguPVhB
	DOmwfStQVSmffB8ouZkVaUgWhAh/FKAbQLfz8Y8hCAisUuEUkqiIznW4fSchFZyeax4skcr0is+
	zW9j422///xZJm3wixd5LVMBh76RT6bPNNCgJmVMI=
X-Received: by 2002:a05:600c:3548:b0:489:1b0c:8b43 with SMTP id 5b1f17b1804b1-48e51e0969fmr11029215e9.1.1778010811424;
        Tue, 05 May 2026 12:53:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3548:b0:489:1b0c:8b43 with SMTP id 5b1f17b1804b1-48e51e0969fmr11028905e9.1.1778010810966;
        Tue, 05 May 2026 12:53:30 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm382391065e9.7.2026.05.05.12.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 26/28] KVM: SVM: enable GMET and set it in MMU role
Date: Tue,  5 May 2026 21:52:24 +0200
Message-ID: <20260505195226.563317-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the GMET bit in the nested control field.  This has effectively
no impact as long as NPT page tables are changed to have U=0.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c    |  6 +++++-
 arch/x86/kvm/svm/nested.c |  9 ++++++---
 arch/x86/kvm/svm/svm.c    | 16 ++++++++++++++++
 arch/x86/kvm/svm/svm.h    |  1 +
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a283b5078c61..8b6122b66f06 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5855,7 +5855,6 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role = {0};
 
-	role.access = ACC_ALL;
 	role.cr0_wp = true;
 	role.cr4_smep = kvm_x86_call(tdp_has_smep)(vcpu->kvm);
 	role.efer_nx = true;
@@ -5866,6 +5865,11 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
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
index 7adfa7da210d..74a1df1cb84f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -858,7 +858,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	 * the latter, L1 runs L2 with shadow page tables that translate L2 GVAs
 	 * to L1 GPAs, so the same NPTs can be used for L1 and L2.
 	 */
-	vmcb02->control.misc_ctl = vmcb01->control.misc_ctl & SVM_MISC_ENABLE_NP;
+	vmcb02->control.misc_ctl = vmcb01->control.misc_ctl & (SVM_MISC_ENABLE_NP | SVM_MISC_ENABLE_GMET);
 	vmcb02->control.iopm_base_pa = vmcb01->control.iopm_base_pa;
 	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
 	vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
@@ -895,9 +895,12 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	/* Also overwritten later if necessary.  */
 	vmcb02->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
 
-	/* nested_cr3.  */
-	if (nested_npt_enabled(svm))
+	/* Use vmcb01 MMU and format if guest does not use nNPT */
+	if (nested_npt_enabled(svm)) {
+		vmcb02->control.misc_ctl &= ~SVM_MISC_ENABLE_GMET;
+
 		nested_svm_init_mmu_context(vcpu);
+	}
 
 	vcpu->arch.tsc_offset = kvm_calc_nested_tsc_offset(vcpu->arch.l1_tsc_offset,
 							   vmcb12_ctrl->tsc_offset,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..3895d8794366 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -138,6 +138,9 @@ module_param(pause_filter_count_max, ushort, 0444);
 bool __ro_after_init npt_enabled = true;
 module_param_named(npt, npt_enabled, bool, 0444);
 
+bool gmet_enabled = true;
+module_param_named(gmet, gmet_enabled, bool, 0444);
+
 /* allow nested virtualization in KVM/SVM */
 static int __ro_after_init nested = true;
 module_param(nested, int, 0444);
@@ -1209,6 +1212,10 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 		save->g_pat = vcpu->arch.pat;
 		save->cr3 = 0;
 	}
+
+	if (gmet_enabled)
+		control->misc_ctl |= SVM_MISC_ENABLE_GMET;
+
 	svm->current_vmcb->asid_generation = 0;
 	svm->asid = 0;
 
@@ -4612,6 +4619,11 @@ svm_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
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
@@ -5355,6 +5367,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.write_tsc_multiplier = svm_write_tsc_multiplier,
 
 	.load_mmu_pgd = svm_load_mmu_pgd,
+	.tdp_has_smep = svm_tdp_has_smep,
 
 	.check_intercept = svm_check_intercept,
 	.handle_exit_irqoff = svm_handle_exit_irqoff,
@@ -5588,6 +5601,9 @@ static __init int svm_hardware_setup(void)
 	if (!boot_cpu_has(X86_FEATURE_NPT))
 		npt_enabled = false;
 
+	if (!npt_enabled || !boot_cpu_has(X86_FEATURE_GMET))
+		gmet_enabled = false;
+
 	/* Force VM NPT level equal to the host's paging level */
 	kvm_configure_mmu(npt_enabled, get_npt_level(),
 			  get_npt_level(), PG_LEVEL_1G);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index a10668d17a16..dd93b3daefa9 100644
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
2.54.0

