Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45483CD8A9
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010811; cv=none; b=jOPg2qgNh3ZMiPsuEZeLjsVGYj+xLPOgocsvBmZe/bqm/GAXmP6bwbw32LFkwKUV8w6iOWiK+xva6ejLsgVRK4NB38VLGe/xRlt81sxD41I3zVTp1MnVc9xertFhLljfVHoJOpdaWqRxTS9gWYJvC0f9rJxCIv45xf5MRxsYGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010811; c=relaxed/simple;
	bh=goXS6LqFT86tybjMW2WTopAsBe3SyCMMxopPmd2bwEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHSZpIS/BKiB5tLhdabcrRTPFGtIcDVINW6XZ6OzXL0tRXjtcNLZvPVFa8AAJ4i+qPj7APkUXri68yxq5mHLet+9zS84//8xJSuBcXqpLr8S0mJ3pG7m0uezXTJHMOeQbAvTOExr+koRbUCQMirZ+PWgvGSEFNmb0BEeRZNBmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJZ+7duN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ablJdjP2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJZ+7duN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ablJdjP2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDgVuOXO9SAgnm24T7PYI2oi9mr0H/9A0ybYZDCgDms=;
	b=dJZ+7duNa7RhZzNEj4QbounJaY7xUCBqyRe1spIacF6nufCuBy5/GSMy2WzXi+hQSq8qvf
	4wj3dS86PfLt4ze84uZVQDSOn6Ui4BFWZqeS5IS9vmlK3LFyBIkQ3zBg5q3ZP4T31Pz3if
	zqKG8e0UoqviWDvddHMrn5L4262U16Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-p8DY3HQmPqGWuEa04Hr7pQ-1; Tue, 05 May 2026 15:53:27 -0400
X-MC-Unique: p8DY3HQmPqGWuEa04Hr7pQ-1
X-Mimecast-MFC-AGG-ID: p8DY3HQmPqGWuEa04Hr7pQ_1778010806
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d2cd2674so44580505e9.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010806; x=1778615606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDgVuOXO9SAgnm24T7PYI2oi9mr0H/9A0ybYZDCgDms=;
        b=ablJdjP2SpIPb5dQqsjuvvzZalkn/RlJcfrQ7qjedsggi7oHDJYnyDb/UsPMnsSzXq
         REZ3+pVGWQJLx/Y+i8iJZxhsxbYOLOesrMg6jv5xLUdvwFXtSRsoPScZdBcTuEZqHSwe
         0WZZrho9rczxezX2Ks1IfjxQPL7/9E17s/aa2+Ivtqmm6LI6M9iYpWhpvjd/fAvi631X
         P30zjxXC6b+BNFSx9c8Cnpaaf/tBWHq+9NkCcXtCaQCmO3YXwjJdSwO8pUOkwksE6xea
         +H615ztU5OYc6IIC1FceZuW7Lg/QzPR/Di2WgYqSQaY0cPeUZkB6LPDtpEajJCdt2xt4
         Cd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010806; x=1778615606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDgVuOXO9SAgnm24T7PYI2oi9mr0H/9A0ybYZDCgDms=;
        b=rajQMqsqxJkLC2BIu+Yui3suEaeXYxxAfsuXZH6Cq4HskufOpe/opdfieW271Zlreh
         IjXskLMR5nwV0BzcbX56d92Q5t33pRTGARjbVBSM2Hn0GcJ2R7LP7wS7tNs/yPSy7FC1
         fe2klvNmx8oadbdfkh2qRLj8fZOQwiB+tVg9/zT1As1XETv9f5xlzRAhRWgiWJ08pr3f
         Y7WRlTBUYnNx+aMURuecoLcg6G5Rp0e8Xlv6fx8lQj2QFV+riD075c+fdHcmgrxcriQf
         CEYdDkxGILq17lc34/bMF8Yeh1hDB2MxoM9MYhlKuinW3Gzq0wxE6F0RVrfvIr62XWVE
         1F3g==
X-Forwarded-Encrypted: i=1; AFNElJ/Vw5tWgbVCf6cF8hOh6z1iv90ZIjP1d0PmqccOAzBAvrZF6Q3BL3r9M16p6493nK/icCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOs0hWN996HYBrYcYHeMLqSs8HRH6EL1Qj/LviJoD0jjD5rqB
	jwMM4DGMZFUizdN/DTey8caiErAXVH3/eEBFVjw9/fRAHaGKFJNRIAzu5K1SoJ5QbYSBNdFexVa
	AdIHemHeluVQR+3q0PCgsO2ScgiKVAJqmm17YhPTJcSG/OKeTbjGpBhcEWxNNcQ==
X-Gm-Gg: AeBDietmvmgXpHAQAB4DJrqCumqh33NkOKNJ+dPIqY0Y1XJYHSF7dUuSMW+RwNrz/0T
	1NqN/vsfO26TPX8CEMs/bH8iZULfKtTT6a1e823TgXkiwmgvsSG3D6aO65Bn0QCxp6FX9VeTIEu
	g3uqax+i7vm/tls87CTcXNCNgMAX3jDp76FLhHHg5Fj2rTwDnqeC0KMQA3EUwGqxugNU8gShfjW
	pcwBe7u/rKmlLbhn5KkNQju8chlyKeV7xc0Gu6T6xTs2TNhRfDJNhGa59ppNHxL/UTV55dTWYMl
	82WKwxeJIxzAs6aIqVWpiwfD4qo/rtIVKvgW0fcv0s2t3eSu+pyxSIxr6dpSA7UK2B7KW0A9NKU
	1niFLWUv3YIEaptal0qpyIgnK4ONsdQ0J2YhWoo+IbVkGtIvI3/Edc9vbyqaC12iCq73lA5OBlK
	4n93uAHtCcVlqjcrYQZ36JITzyV1hYfYGBezfxMeo=
X-Received: by 2002:a05:600c:8b06:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48e51e223ccmr10973285e9.11.1778010805987;
        Tue, 05 May 2026 12:53:25 -0700 (PDT)
X-Received: by 2002:a05:600c:8b06:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48e51e223ccmr10973045e9.11.1778010805621;
        Tue, 05 May 2026 12:53:25 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5288fa13sm586955e9.14.2026.05.05.12.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 24/28] KVM: x86/mmu: hard code more bits in kvm_init_shadow_npt_mmu
Date: Tue,  5 May 2026 21:52:22 +0200
Message-ID: <20260505195226.563317-25-pbonzini@redhat.com>
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

The host CR0 does not really reflect onto the NPT format because
hCR0.PG=1 must be set and hCR0.WP is ignored.  Carve that in stone
by removing the cr0 argument from kvm_init_shadow_npt_mmu.

Pass in WP=1 as well; it does not matter for GMET disabled because
PFERR_USER_MASK is always set, but a cleared W bit in the nested page
tables cannot be overridden in supervisor mode when GMET is enabled,
either.  In fact, since CR0.WP=0 is the weird "extra accesses allowed"
mode, it is acutally easier think about it being always set.

Likewise, clear X86_CR4_SMAP to avoid that KVM erroneously faults on
supervisor accesses to an U=1 page.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h        | 4 ++--
 arch/x86/kvm/mmu/mmu.c    | 8 ++++----
 arch/x86/kvm/svm/nested.c | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index e1e3869f568b..1b354e1f2d81 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -96,8 +96,8 @@ void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask);
 void kvm_mmu_set_ept_masks(bool has_ad_bits);
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu);
-void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
-			     unsigned long cr4, u64 efer, gpa_t nested_cr3);
+void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
+			     u64 efer, gpa_t nested_cr3);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
 			     bool mbec, gpa_t new_eptp);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 912c8e97ef61..5a796ae8c396 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5939,13 +5939,13 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
 	shadow_mmu_init_context(vcpu, context, cpu_role, root_role);
 }
 
-void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
-			     unsigned long cr4, u64 efer, gpa_t nested_cr3)
+void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
+			     u64 efer, gpa_t nested_cr3)
 {
 	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
 	struct kvm_mmu_role_regs regs = {
-		.cr0 = cr0,
-		.cr4 = cr4 & ~X86_CR4_PKE,
+		.cr0 = X86_CR0_PG | X86_CR0_WP,
+		.cr4 = cr4 & ~(X86_CR4_PKE | X86_CR4_SMAP),
 		.efer = efer,
 	};
 	union kvm_cpu_role cpu_role = kvm_calc_cpu_role(vcpu, &regs);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index df232153eb24..a1cffd274000 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -93,7 +93,7 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	 * when called via KVM_SET_NESTED_STATE, that state may _not_ match current
 	 * vCPU state.  CR0.WP is explicitly ignored, while CR0.PG is required.
 	 */
-	kvm_init_shadow_npt_mmu(vcpu, X86_CR0_PG, svm->vmcb01.ptr->save.cr4,
+	kvm_init_shadow_npt_mmu(vcpu, svm->vmcb01.ptr->save.cr4,
 				svm->vmcb01.ptr->save.efer,
 				svm->nested.ctl.nested_cr3);
 	vcpu->arch.mmu->get_guest_pgd     = nested_svm_get_tdp_cr3;
-- 
2.54.0

