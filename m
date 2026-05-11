Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F499402B81
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512030; cv=none; b=eVtON9OPFmmb0H4luunOmoSn/Swtqa7GsaYP1LDfgwcmW/KhEBAVsIt9JDcFN81MzjFfR8+PvvaONMDXydnpm/VjCVzwpkYR0Y7pQyFOEq97thYPV8VJRiPZMNAYTfEDvVKYTMITeSfTeGTamUwJueZMFpj33LllcGiO0JleIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512030; c=relaxed/simple;
	bh=TTuYXGKhqm1dbKuejGAnhVeLQtrkO0WCXVrzw6gFFc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlE+oPX0XWqe3sDrG2LF2GM7K/Rnh9oE17cLBalQNhfTzMODLsHvoBWoHKxCPxyKi1pml5lHm7doLLTFzCZ3W+n/y0EydMTAjATQinapNXARWsShILIhshZz5xOazkZZrlE7wO7p0yn+IW5uDTFXFn4JD8Lq9hRAF9wZC/pFzME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zu3wgech; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zu3wgech"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfvcGW4kLqFnQidb2KP8uQLSfwImgmSQiFX9ySV4EyY=;
	b=Zu3wgechftIfigPgEUOywGuImNP/xGuSRYrAJ1iT6WItOEJCz4Vf7DYDcsAA7ZLTpJr8gu
	qPtaA3qwAlNbl6yAFQRd/1U54zgWJSHxhGZH6gb6RBX/5l4N7/iwR3l3GXqZ6UD6TyF2ON
	eHb51eFq1dGQr3a+5+P1pOUx11AIsDY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-pnsDdFbSOm-OteJ-vo5CkQ-1; Mon,
 11 May 2026 11:07:02 -0400
X-MC-Unique: pnsDdFbSOm-OteJ-vo5CkQ-1
X-Mimecast-MFC-AGG-ID: pnsDdFbSOm-OteJ-vo5CkQ_1778512021
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 971FE19560B6;
	Mon, 11 May 2026 15:07:01 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 108721800673;
	Mon, 11 May 2026 15:07:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	mtosatti@redhat.com
Subject: [PATCH 15/22] KVM: x86/mmu: change nested_mmu.w to nested_cpu_walk
Date: Mon, 11 May 2026 11:06:41 -0400
Message-ID: <20260511150648.685374-16-pbonzini@redhat.com>
In-Reply-To: <20260511150648.685374-1-pbonzini@redhat.com>
References: <20260511150648.685374-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

nested_mmu is now only used for its w member.  Rename it,
and change its type.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  5 ++--
 arch/x86/kvm/mmu.h              |  6 ++---
 arch/x86/kvm/mmu/mmu.c          | 41 ++++++++++++++-------------------
 arch/x86/kvm/svm/nested.c       |  2 +-
 arch/x86/kvm/vmx/nested.c       |  2 +-
 5 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6c5c59b9cfe3..8af8016e9364 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -873,11 +873,10 @@ struct kvm_vcpu_arch {
 	 * walking and not for faulting since we never handle l2 page faults on
 	 * the host.
 	 */
-	struct kvm_mmu nested_mmu;
+	struct kvm_pagewalk nested_cpu_walk;
 
 	/*
-	 * Pointer to the mmu context currently used for
-	 * gva_to_gpa translations.
+	 * Pagewalk context used for gva_to_gpa translations.
 	 */
 	struct kvm_pagewalk *cpu_walk;
 
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index d1b5d9b0c6ad..652803cb36c8 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -177,8 +177,8 @@ static inline void kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
 	 * be stale.  Refresh CR0.WP and the metadata on-demand when checking
 	 * for permission faults.  Exempt nested MMUs, i.e. MMUs for shadowing
 	 * nEPT and nNPT, as CR0.WP is ignored in both cases.  Note, KVM does
-	 * need to refresh nested_mmu, a.k.a. the walker used to translate L2
-	 * GVAs to GPAs, as that "MMU" needs to honor L2's CR0.WP.
+	 * need to refresh nested_cpu_walk, a.k.a. the walker used to translate L2
+	 * GVAs to GPAs, so as to honor L2's CR0.WP.
 	 */
 	if (!tdp_enabled || w == &vcpu->arch.guest_mmu.w)
 		return;
@@ -306,7 +306,7 @@ static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 				      struct x86_exception *exception,
 				      u64 pte_access)
 {
-	if (w != &vcpu->arch.nested_mmu.w)
+	if (w != &vcpu->arch.nested_cpu_walk)
 		return gpa;
 	return kvm_x86_ops.nested_ops->translate_nested_gpa(vcpu, gpa, access,
 							    exception,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d6a011b2d36e..bb76835a2e06 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6037,43 +6037,37 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
 	context->w.get_guest_pgd     = get_guest_cr3;
 }
 
-static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
+static void init_kvm_nested_cpu_walk(struct kvm_vcpu *vcpu,
 				union kvm_cpu_role new_mode)
 {
-	struct kvm_mmu *g_context = &vcpu->arch.nested_mmu;
+	struct kvm_pagewalk *g_context = &vcpu->arch.nested_cpu_walk;
 
-	if (new_mode.as_u64 == g_context->w.cpu_role.as_u64)
+	if (new_mode.as_u64 == g_context->cpu_role.as_u64)
 		return;
 
-	g_context->w.cpu_role.as_u64   = new_mode.as_u64;
-	g_context->w.inject_page_fault = kvm_inject_page_fault;
-	g_context->w.get_pdptr         = kvm_pdptr_read;
-	g_context->w.get_guest_pgd     = get_guest_cr3;
-
-	/*
-	 * L2 page tables are never shadowed, so there is no need to sync
-	 * SPTEs.
-	 */
-	g_context->sync_spte         = NULL;
+	g_context->cpu_role.as_u64   = new_mode.as_u64;
+	g_context->inject_page_fault = kvm_inject_page_fault;
+	g_context->get_pdptr         = kvm_pdptr_read;
+	g_context->get_guest_pgd     = get_guest_cr3;
 
 	/*
 	 * Note that arch.mmu->gva_to_gpa translates l2_gpa to l1_gpa using
 	 * L1's nested page tables (e.g. EPT12). The nested translation
-	 * of l2_gva to l1_gpa is done by arch.nested_mmu.gva_to_gpa using
+	 * of l2_gva to l1_gpa is done by arch.nested_cpu_walk.gva_to_gpa using
 	 * L2's page tables as the first level of translation and L1's
 	 * nested page tables as the second level of translation. Basically
-	 * the gva_to_gpa functions between mmu and nested_mmu are swapped.
+	 * the gva_to_gpa functions between mmu and nested_cpu_walk are swapped.
 	 */
 	if (!is_paging(vcpu))
-		g_context->w.gva_to_gpa = nonpaging_gva_to_gpa;
+		g_context->gva_to_gpa = nonpaging_gva_to_gpa;
 	else if (is_long_mode(vcpu))
-		g_context->w.gva_to_gpa = paging64_gva_to_gpa;
+		g_context->gva_to_gpa = paging64_gva_to_gpa;
 	else if (is_pae(vcpu))
-		g_context->w.gva_to_gpa = paging64_gva_to_gpa;
+		g_context->gva_to_gpa = paging64_gva_to_gpa;
 	else
-		g_context->w.gva_to_gpa = paging32_gva_to_gpa;
+		g_context->gva_to_gpa = paging32_gva_to_gpa;
 
-	reset_guest_paging_metadata(vcpu, &g_context->w);
+	reset_guest_paging_metadata(vcpu, g_context);
 }
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu)
@@ -6082,7 +6076,7 @@ void kvm_init_mmu(struct kvm_vcpu *vcpu)
 	union kvm_cpu_role cpu_role = kvm_calc_cpu_role(vcpu, &regs);
 
 	if (mmu_is_nested(vcpu))
-		init_kvm_nested_mmu(vcpu, cpu_role);
+		init_kvm_nested_cpu_walk(vcpu, cpu_role);
 	else if (tdp_enabled)
 		init_kvm_tdp_mmu(vcpu, cpu_role);
 	else
@@ -6106,10 +6100,9 @@ void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 */
 	vcpu->arch.root_mmu.root_role.invalid = 1;
 	vcpu->arch.guest_mmu.root_role.invalid = 1;
-	vcpu->arch.nested_mmu.root_role.invalid = 1;
 	vcpu->arch.root_mmu.w.cpu_role.ext.valid = 0;
 	vcpu->arch.guest_mmu.w.cpu_role.ext.valid = 0;
-	vcpu->arch.nested_mmu.w.cpu_role.ext.valid = 0;
+	vcpu->arch.nested_cpu_walk.cpu_role.ext.valid = 0;
 	kvm_mmu_reset_context(vcpu);
 
 	KVM_BUG_ON(!kvm_can_set_cpuid_and_feature_msrs(vcpu), vcpu->kvm);
@@ -6611,7 +6604,7 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			return;
 
 		kvm_x86_call(flush_tlb_gva)(vcpu, addr);
-		if (w == &vcpu->arch.nested_mmu.w)
+		if (w == &vcpu->arch.nested_cpu_walk)
 			return;
 	}
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 4781145faa14..676a49c55f8d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -102,7 +102,7 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->w.get_pdptr       = nested_svm_get_tdp_pdptr;
 
 	vcpu->arch.mmu->w.inject_page_fault = nested_svm_inject_npf_exit;
-	vcpu->arch.cpu_walk              = &vcpu->arch.nested_mmu.w;
+	vcpu->arch.cpu_walk              = &vcpu->arch.nested_cpu_walk;
 }
 
 static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ed72625005fc..b23900f2f6b4 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -499,7 +499,7 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.mmu->w.inject_page_fault = nested_ept_inject_page_fault;
 
-	vcpu->arch.cpu_walk              = &vcpu->arch.nested_mmu.w;
+	vcpu->arch.cpu_walk              = &vcpu->arch.nested_cpu_walk;
 }
 
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
-- 
2.52.0


