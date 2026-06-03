Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234B646AF0E
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484311; cv=none; b=rEkLvF7AqeSJnfZ3m4HxPYqzqPz9K4a7kwdI3EaIKkGywgCLdoKItdpbKWgnBKiA33YyD1BZUOdumxBV/vFmthIwJR2Q2YOb6H8lxq4P1gtMoXs+2O9Kv2zPdyLvDcEGNwKVvy5B3at0nmxcKqqukvqfk9GysY5E5esnDqlMf/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484311; c=relaxed/simple;
	bh=6KzD1s4MXx7i7ATCK/mmaRClf/nKrarqTyy8zgMunKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRftvACW0ogtpytC+JXDOd7ngL5GXAytk4SXRWaJSGdMOlkb0nHKOQXBgM1FPhlpckBDIf5vjNT2ihdceX+JWT3rioxtMZ5coYN/H0F1Q+nX8TdSCzmYmHz9gWl7Q1FaIelwu7dqdd5IHlZPjWttAHlCUkasMroCdjgWiaIv+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3biOZ51; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3biOZ51"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1qhO5F4sdJ0xvuAPWtbQAoUDGS95StnP6VP55mBpOeU=;
	b=D3biOZ518MwlYJ3bKY/sAa5pmmZcuYQcTlAGei4qFMD9Lzhz/Kd0owApjYiarblpnNyu2r
	yNHhMODHt1pbL1VRe0YOCgBRRshBUgx8+02z6hCgudpYCCeMbV5zR/E9XggyUAenq++xMJ
	VofxdHvyf32LXZov6uBAwe3pv+7gYsE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-sNLHG8m0Mva66OGe8rrgSg-1; Wed,
 03 Jun 2026 06:58:26 -0400
X-MC-Unique: sNLHG8m0Mva66OGe8rrgSg-1
X-Mimecast-MFC-AGG-ID: sNLHG8m0Mva66OGe8rrgSg_1780484305
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3854119560A2;
	Wed,  3 Jun 2026 10:58:25 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D1A2C30001A1;
	Wed,  3 Jun 2026 10:58:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 17/24] KVM: x86/mmu: change nested_mmu.w to ngva_walk
Date: Wed,  3 Jun 2026 06:58:07 -0400
Message-ID: <20260603105814.10236-18-pbonzini@redhat.com>
In-Reply-To: <20260603105814.10236-1-pbonzini@redhat.com>
References: <20260603105814.10236-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
index 368386aac3c3..1bebd98ce846 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -877,11 +877,10 @@ struct kvm_vcpu_arch {
 	 * walking and not for faulting since we never handle l2 page faults on
 	 * the host.
 	 */
-	struct kvm_mmu nested_mmu;
+	struct kvm_pagewalk ngva_walk;
 
 	/*
-	 * Pointer to the mmu context currently used for
-	 * gva_to_gpa translations.
+	 * Pagewalk context used for gva_to_gpa translations.
 	 */
 	struct kvm_pagewalk *gva_walk;
 
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index d1b5d9b0c6ad..debdaff7f710 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -177,8 +177,8 @@ static inline void kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
 	 * be stale.  Refresh CR0.WP and the metadata on-demand when checking
 	 * for permission faults.  Exempt nested MMUs, i.e. MMUs for shadowing
 	 * nEPT and nNPT, as CR0.WP is ignored in both cases.  Note, KVM does
-	 * need to refresh nested_mmu, a.k.a. the walker used to translate L2
-	 * GVAs to GPAs, as that "MMU" needs to honor L2's CR0.WP.
+	 * need to refresh ngva_walk, a.k.a. the walker used to translate L2
+	 * GVAs to GPAs, so as to honor L2's CR0.WP.
 	 */
 	if (!tdp_enabled || w == &vcpu->arch.guest_mmu.w)
 		return;
@@ -306,7 +306,7 @@ static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 				      struct x86_exception *exception,
 				      u64 pte_access)
 {
-	if (w != &vcpu->arch.nested_mmu.w)
+	if (w != &vcpu->arch.ngva_walk)
 		return gpa;
 	return kvm_x86_ops.nested_ops->translate_nested_gpa(vcpu, gpa, access,
 							    exception,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e6952409c78a..386fdbc34b02 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6037,43 +6037,37 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
 	context->w.get_guest_pgd     = get_guest_cr3;
 }
 
-static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
+static void init_kvm_ngva_walk(struct kvm_vcpu *vcpu,
 				union kvm_cpu_role new_mode)
 {
-	struct kvm_mmu *g_context = &vcpu->arch.nested_mmu;
+	struct kvm_pagewalk *g_context = &vcpu->arch.ngva_walk;
 
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
+	 * of l2_gva to l1_gpa is done by arch.ngva_walk.gva_to_gpa using
 	 * L2's page tables as the first level of translation and L1's
 	 * nested page tables as the second level of translation. Basically
-	 * the gva_to_gpa functions between mmu and nested_mmu are swapped.
+	 * the gva_to_gpa functions between mmu and ngva_walk are swapped.
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
+		init_kvm_ngva_walk(vcpu, cpu_role);
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
+	vcpu->arch.ngva_walk.cpu_role.ext.valid = 0;
 	kvm_mmu_reset_context(vcpu);
 
 	KVM_BUG_ON(!kvm_can_set_cpuid_and_feature_msrs(vcpu), vcpu->kvm);
@@ -6611,7 +6604,7 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			return;
 
 		kvm_x86_call(flush_tlb_gva)(vcpu, addr);
-		if (w == &vcpu->arch.nested_mmu.w)
+		if (w == &vcpu->arch.ngva_walk)
 			return;
 	}
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 7d89285b0677..20469fd83e8b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -102,7 +102,7 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->w.get_pdptr       = nested_svm_get_tdp_pdptr;
 
 	vcpu->arch.mmu->w.inject_page_fault = nested_svm_inject_npf_exit;
-	vcpu->arch.gva_walk              = &vcpu->arch.nested_mmu.w;
+	vcpu->arch.gva_walk              = &vcpu->arch.ngva_walk;
 }
 
 static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 5a89d5dcfb9a..477c0e8a6e43 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -499,7 +499,7 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.mmu->w.inject_page_fault = nested_ept_inject_page_fault;
 
-	vcpu->arch.gva_walk              = &vcpu->arch.nested_mmu.w;
+	vcpu->arch.gva_walk              = &vcpu->arch.ngva_walk;
 }
 
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
-- 
2.52.0


