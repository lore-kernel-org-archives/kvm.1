Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9EC39D6D6
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336671; cv=none; b=gWwqdJ9oCdTVxGu3ocupmkh/euiObDfl6HdeQ67l0HZ2hdgxm6vrwhWpxD6pyWcWUU85ihq5/5JmFyKdlJPM7jq0psnBr565yPJqVb8dgCs61YUBJz1w2XkJiLdXtPQp4w/VsYS5jtILia0n3JNNDzfaRImMeoenIo6s1sGD0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336671; c=relaxed/simple;
	bh=33dYPUKbJLZ39ttqLJz3aFdxhcA4t3Tkww5v5E1e3xA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FiCafFOXtPDPutFf7rGu24SVJ/r1rfx07DDBS5mXiNZ1BLRyl1yKgeyTQg6zn0dHHQ/dDqac/ZFtaP8ru2qBjn/8vVV1l3rneAtrkLmXwd83R+MnptIcevnX3NGtiQETuixwRlB06vBJsmiRFbhXSQ4B7DJK3lW+fpb7EiEvgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZ9qFUR9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZ9qFUR9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782336669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y60xmRhnfAffgruUI/2dqwGfiBlgc6aHODSw4/KxQa0=;
	b=hZ9qFUR9RjD00ygyiJvGfpBPWeFM7XzudHC7Jqgcll5SohrS6ZvfJrDVcvqJr5vb5+nVWR
	+eICwzS+tuQa/WbVokSlwLAspHpbOJ4hYJ8O2l58QvqnnKVPI6LbHjSJ4KElqyo3q+U1wC
	8lBUoNFywjQfLacrxUJEAWa0jlqoP6Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-NsxCw_a_NSCWTeeR4iM6bQ-1; Wed,
 24 Jun 2026 17:31:08 -0400
X-MC-Unique: NsxCw_a_NSCWTeeR4iM6bQ-1
X-Mimecast-MFC-AGG-ID: NsxCw_a_NSCWTeeR4iM6bQ_1782336667
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3157019560AD;
	Wed, 24 Jun 2026 21:31:07 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD5B81956041;
	Wed, 24 Jun 2026 21:31:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 05/19] KVM: x86/mmu: move get_pdptr to struct kvm_pagewalk
Date: Wed, 24 Jun 2026 17:30:48 -0400
Message-ID: <20260624213102.71082-6-pbonzini@redhat.com>
In-Reply-To: <20260624213102.71082-1-pbonzini@redhat.com>
References: <20260624213102.71082-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Continue with yet another callback used in FNAME(walk_addr_generic),
as another step towards removing container_of() from there.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/mmu/mmu.c          | 8 ++++----
 arch/x86/kvm/mmu/paging_tmpl.h  | 2 +-
 arch/x86/kvm/svm/nested.c       | 2 +-
 arch/x86/kvm/vmx/nested.c       | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 95c2caf18bee..4ddfe9debf18 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -518,6 +518,7 @@ struct kvm_page_fault;
  */
 struct kvm_pagewalk {
 	unsigned long (*get_guest_pgd)(struct kvm_vcpu *vcpu);
+	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
 	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			    gpa_t gva_or_gpa, u64 access,
 			    struct x86_exception *exception);
@@ -526,7 +527,6 @@ struct kvm_pagewalk {
 struct kvm_mmu {
 	struct kvm_pagewalk w;
 
-	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
 	int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
 				  struct x86_exception *fault,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 11efca459509..ac9e1e95335a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4109,7 +4109,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 */
 	if (mmu->cpu_role.base.level == PT32E_ROOT_LEVEL) {
 		for (i = 0; i < 4; ++i) {
-			pdptrs[i] = mmu->get_pdptr(vcpu, i);
+			pdptrs[i] = mmu->w.get_pdptr(vcpu, i);
 			if (!(pdptrs[i] & PT_PRESENT_MASK))
 				continue;
 
@@ -5969,9 +5969,9 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	context->root_role.word = root_role.word;
 	context->page_fault = kvm_tdp_page_fault;
 	context->sync_spte = NULL;
-	context->get_pdptr = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
 
+	context->w.get_pdptr = kvm_pdptr_read;
 	context->w.get_guest_pgd = get_guest_cr3;
 
 	if (!is_cr0_pg(context))
@@ -6121,9 +6121,9 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
 
 	kvm_init_shadow_mmu(vcpu, cpu_role);
 
+	context->w.get_pdptr         = kvm_pdptr_read;
 	context->w.get_guest_pgd     = get_guest_cr3;
 
-	context->get_pdptr         = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
 }
 
@@ -6136,9 +6136,9 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
 		return;
 
 	g_context->cpu_role.as_u64   = new_mode.as_u64;
-	g_context->get_pdptr         = kvm_pdptr_read;
 	g_context->inject_page_fault = kvm_inject_page_fault;
 
+	g_context->w.get_pdptr         = kvm_pdptr_read;
 	g_context->w.get_guest_pgd     = get_guest_cr3;
 
 	/*
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 49c4feed7cd2..cf13a8b608dc 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -354,7 +354,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 #if PTTYPE == 64
 	walk_nx_mask = 1ULL << PT64_NX_SHIFT;
 	if (walker->level == PT32E_ROOT_LEVEL) {
-		pte = mmu->get_pdptr(vcpu, (addr >> 30) & 3);
+		pte = w->get_pdptr(vcpu, (addr >> 30) & 3);
 		trace_kvm_mmu_paging_element(pte, walker->level);
 		if (!FNAME(is_present_gpte)(mmu, pte))
 			goto error;
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index be92c1a5144c..6634d6390f77 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -115,8 +115,8 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 				svm->nested.ctl.misc_ctl);
 
 	vcpu->arch.mmu->w.get_guest_pgd     = nested_svm_get_tdp_cr3;
+	vcpu->arch.mmu->w.get_pdptr       = nested_svm_get_tdp_pdptr;
 
-	vcpu->arch.mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
 	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 }
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0e2d7714c6d2..ef54c444413e 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -513,9 +513,9 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
 	nested_ept_new_eptp(vcpu);
 	vcpu->arch.mmu->w.get_guest_pgd     = nested_ept_get_eptp;
+	vcpu->arch.mmu->w.get_pdptr       = kvm_pdptr_read;
 
 	vcpu->arch.mmu->inject_page_fault = nested_ept_inject_page_fault;
-	vcpu->arch.mmu->get_pdptr         = kvm_pdptr_read;
 
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 }
-- 
2.52.0


