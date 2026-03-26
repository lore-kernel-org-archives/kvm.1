Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81A42DFFA
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549109; cv=none; b=hs+xgUO+186qSFRWTL1MJAX6p6/CddCkagdFyvlKSP7bK8fmOd/UG86djhU1M8el6ckn8LDceV6zlyppcUktCD9JY6RzdxiPeu8xmZ7u0kEYjukeZVNe8EN69suCFhmrzFH9i2Mm0gJZDl1VGl7PLwBBklF7pFflhZ8KlvzLlmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549109; c=relaxed/simple;
	bh=qRhFsWjjq1QHV4ESmJrlgg2iUUx+Ynq+/rCxF1atDMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guZbQ+RQW0Yn00mSJTQ30NFFIEeRXDnJJ3YcIfjhFEsdccPbiHChOGk8N2RUxS4p6I7j8TlBaw5Jtx77+BDhzTCmM0bvCVIO7jiROpGxjFDTkc5TudW7IANMqUEOXS6NFZpQBwWJYL2nTErr3UG2TshtfiZfIvu1+0gUPrqEH90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/Yrsuco; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p5HrN07O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/Yrsuco";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p5HrN07O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsBEtpThqUJXE21zAYs9X1eFe9CQW/ThT95VzOz+wKU=;
	b=D/YrsucouS6OBac6ktDNQP5QOC/8kNfoz4MAjKO0+jcSQsGEokHT71UddM1hymkRyxwP/W
	nnD+rqx/SdIPFwfAs+iNHul4JJtTE5kZTDAQ1F4V/ResSDKkosoFPfsIXMR1LKAkwZ/ecV
	A/CwQ8nV5ovZ1c2YGi6g2pOFVgFV00o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-d5nz74nNMaObCFrx5m5lbA-1; Thu, 26 Mar 2026 14:18:26 -0400
X-MC-Unique: d5nz74nNMaObCFrx5m5lbA-1
X-Mimecast-MFC-AGG-ID: d5nz74nNMaObCFrx5m5lbA_1774549105
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4852ccff333so11526715e9.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549105; x=1775153905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsBEtpThqUJXE21zAYs9X1eFe9CQW/ThT95VzOz+wKU=;
        b=p5HrN07O0RWfOWRCHl0quHrLxOzOv/5IyG2h4HLVQiziCWRmgCYbaN8ny/ylb7UYA3
         Zg5dZ+m5i7etH9WOoUDQ3a/1P+kLCziKRHAHop9KeyKsW7p2ZkcZXouFqcC0zDDatLcS
         oN81ktMZZfYC08HeVNwRIVD9erD3mMQDo/g7oE03PrhbDKpDZYd0Ad5isiBsEMTOXAeX
         DlGHTPsZV7n46Ys8+sPXgn1XzgQp6b1EMgfjbL6yEH3o6PYeogQWUDmV7oinCXarPEKV
         +2sC2+It0t/m1GplNRpxjI0gy701meGwPiFE2IvS9KeAuPreUW+aJivbQ7+4P8broWvD
         9GQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549105; x=1775153905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NsBEtpThqUJXE21zAYs9X1eFe9CQW/ThT95VzOz+wKU=;
        b=mD2sFUrizUEd3WyKcnPqw0BYk+yt6Y1gOQeE7zjzSPcn8HUuJ8vNxen1wLRROH/F+l
         QW2BChrDtqlCTz9SN6QL5ui/EonW81l0Qvdn428kAbqPO3U4JFIBGyEmjif+layKGAPJ
         rQV1YjlfhF7MoOkivSRdD4xliiq9j0Szy8BYS2SBNc8y84+RU6HKPPQ/LAHRx0ZoG+lc
         hYiRNl61cTWBCdboxpA3dzzGr72VTTM2d+F4YMSGSOjOM3UacZhk8QVPec0rRvgAle07
         Ph9+zlDBgDQkNd588LzNlTajHkvVjTWdsUbjl5jttZcx3+rLAevSlewnxDR6v+vCG770
         7O/A==
X-Forwarded-Encrypted: i=1; AJvYcCW/p6W6Lu7wUVnSCRFHANmwRNxVncXkDTiPipd6f8NuJnPETMqTmOS2D/oUGSAvh0i/zkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPdo5BDZ4eBsrGXnRzoaoFGq60JlUTa0bMgwjRunTKfMglA5Ot
	xRxL5LFr0c7f2ym1bzQCgcQH/NbTnS7mHcCCe/+6Ya2Jn4vqz9ElIJemxgBzAtup/xKUkXpJoFX
	9eau6M6m3isCsL/UYKGPEHewqJ0VNFpK03QgYeCi3EWoxzXB8UGl4uQ==
X-Gm-Gg: ATEYQzwtVGb1XLLNsEbs+xOgaOG4NBpFDoXjPq+6WTusqoWRslWJM1lQAeHr4qSbSPg
	hB0cCtjz7UHev1bG140h5zig9R3ruPqf/Z0uC+nzk0PMyEbf1Pi3Z9kEF8jMOaCl3pMdaAMekI/
	GTqHqLW0bZdtRpoucRRmB66e8QWxbUQt8XP6ANkTCX+Yde6F4hMDR3xw/SgLXye4qBoXBy5M9To
	TqdxRqtl+cDoc+JMyRjevzufMzqYT8Aakj1WlF8KJyrXw6Y2TfFwHfezhy0K29viEmF2bB4KTms
	nn4cYcb6y0c6JDhQWm/q3DGofF0JnPia7fnGW7Z0FwtxjLJMzCL7rXSEc9kiwFdc7xUvyweJSnv
	wHXKjPGwizmCuhZQTJNMcYt++WabJ9NXopyV9puVWFSsbfVYref7SRiPFAvvadTVqTXuk5aCEMe
	fZxQaKm2tuwIqeFNRsAhBj4MLf
X-Received: by 2002:a05:600c:37cc:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-48715ffc221mr140191815e9.14.1774549104857;
        Thu, 26 Mar 2026 11:18:24 -0700 (PDT)
X-Received: by 2002:a05:600c:37cc:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-48715ffc221mr140191135e9.14.1774549104332;
        Thu, 26 Mar 2026 11:18:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722be608bsm58243545e9.0.2026.03.26.11.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:18:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 22/24] KVM: SVM: enable GMET and set it in MMU role
Date: Thu, 26 Mar 2026 19:17:20 +0100
Message-ID: <20260326181723.218115-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index d9eb059d24de..51eb3e69f3a8 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5836,7 +5836,6 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role = {0};
 
-	role.access = ACC_ALL;
 	role.cr0_wp = true;
 	role.cr4_smep = kvm_x86_call(tdp_has_smep)(vcpu->kvm);
 	role.efer_nx = true;
@@ -5847,6 +5846,11 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
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
index 99edcca7ee64..4c7bc0e7f908 100644
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
2.53.0

