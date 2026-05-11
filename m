Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7075337110
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512020; cv=none; b=Ep4Kpk3lWhepxL2tuxe0yDqdWXo2KElHlx3w0DLFL596Nsle3vLcBh0CGxP7Zjqv4kx3HFwg30R9HGdZVoNfO5YLgBYsc2h3+ZycfU6HohOl2wFey25E6EslxWeG/ye5+feRyLown57vwEHt0JUKWbeIzKJgSS3Ppg8JILGFN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512020; c=relaxed/simple;
	bh=hdAAVubKPJRwlu6Itk2vhqphhoueBVRr7lzYj/AXaqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+RycnhzOLhQ6WVEziNqbTJ1PSTAZ50Rq4N48qUiL4jWHtJxXVe67frWjixAaHjm5zxrPz9DNT2It9PQTowQNNfSrBWem6/DvRkqnwS2sMlgClQZidJM4F298QHT4Gpbjfzzj+3bipOcFcunW6yYu9CMVS0JFDrQbzAttamPEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXMGn+cI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXMGn+cI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JytRQrMO0LIc8U0tyfb7uJWfv7fE3w0b5ncCSOvJiQ=;
	b=JXMGn+cIlGLoumrDq48z9akPosipWgkvfDieaoD4xKWCE43XQZqQ8BUwz6+H3fe+99/NTg
	//e0XE3BXA1qtF4MNfVQ9W6w0KjV0M3XAuPmEoYAxltT5vXAj6UNewt+z+BGJHHH/8xzPy
	OwGq+dtnSMWVQHpHXBr2Zg8IStsNp7k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-LRtertT_NTqpHqYV3f-pDw-1; Mon,
 11 May 2026 11:06:56 -0400
X-MC-Unique: LRtertT_NTqpHqYV3f-pDw-1
X-Mimecast-MFC-AGG-ID: LRtertT_NTqpHqYV3f-pDw_1778512014
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6293318005BF;
	Mon, 11 May 2026 15:06:54 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C85F5180034E;
	Mon, 11 May 2026 15:06:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	mtosatti@redhat.com
Subject: [PATCH 06/22] KVM: x86/mmu: move get_guest_pgd to struct kvm_pagewalk
Date: Mon, 11 May 2026 11:06:32 -0400
Message-ID: <20260511150648.685374-7-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Start moving page walking functionality out of kvm_mmu.  The easiest
target is the callbacks; change the kvm_mmu_get_guest_pgd() wrapper
to take a struct kvm_pagewalk too, and avoid the MMU indirection
whenever the caller has one.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/mmu/mmu.c          | 21 ++++++++++++---------
 arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
 arch/x86/kvm/svm/nested.c       |  4 +++-
 arch/x86/kvm/vmx/nested.c       |  3 ++-
 5 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a7f89e832a52..22e681d351b4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -477,12 +477,12 @@ struct kvm_page_fault;
  * current mmu mode.
  */
 struct kvm_pagewalk {
+	unsigned long (*get_guest_pgd)(struct kvm_vcpu *vcpu);
 };
 
 struct kvm_mmu {
 	struct kvm_pagewalk w;
 
-	unsigned long (*get_guest_pgd)(struct kvm_vcpu *vcpu);
 	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
 	int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 42b7397a1845..8981e5526ba1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -269,12 +269,12 @@ static unsigned long get_guest_cr3(struct kvm_vcpu *vcpu)
 }
 
 static inline unsigned long kvm_mmu_get_guest_pgd(struct kvm_vcpu *vcpu,
-						  struct kvm_mmu *mmu)
+						  struct kvm_pagewalk *w)
 {
-	if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) && mmu->get_guest_pgd == get_guest_cr3)
+	if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) && w->get_guest_pgd == get_guest_cr3)
 		return kvm_read_cr3(vcpu);
 
-	return mmu->get_guest_pgd(vcpu);
+	return w->get_guest_pgd(vcpu);
 }
 
 static inline bool kvm_available_flush_remote_tlbs_range(void)
@@ -4071,7 +4071,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	int quadrant, i, r;
 	hpa_t root;
 
-	root_pgd = kvm_mmu_get_guest_pgd(vcpu, mmu);
+	root_pgd = kvm_mmu_get_guest_pgd(vcpu, &mmu->w);
 	root_gfn = (root_pgd & __PT_BASE_ADDR_MASK) >> PAGE_SHIFT;
 
 	if (!kvm_vcpu_is_visible_gfn(vcpu, root_gfn)) {
@@ -4543,7 +4543,7 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu,
 	if (arch.direct_map)
 		arch.cr3 = (unsigned long)INVALID_GPA;
 	else
-		arch.cr3 = kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu);
+		arch.cr3 = kvm_mmu_get_guest_pgd(vcpu, &vcpu->arch.mmu->w);
 
 	return kvm_setup_async_pf(vcpu, fault->addr,
 				  kvm_vcpu_gfn_to_hva(vcpu, fault->gfn), &arch);
@@ -4565,7 +4565,7 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 		return;
 
 	if (!vcpu->arch.mmu->root_role.direct &&
-	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
+	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, &vcpu->arch.mmu->w))
 		return;
 
 	r = kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
@@ -5880,10 +5880,11 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	context->root_role.word = root_role.word;
 	context->page_fault = kvm_tdp_page_fault;
 	context->sync_spte = NULL;
-	context->get_guest_pgd = get_guest_cr3;
 	context->get_pdptr = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
 
+	context->w.get_guest_pgd = get_guest_cr3;
+
 	if (!is_cr0_pg(context))
 		context->gva_to_gpa = nonpaging_gva_to_gpa;
 	else if (is_cr4_pae(context))
@@ -6031,7 +6032,8 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
 
 	kvm_init_shadow_mmu(vcpu, cpu_role);
 
-	context->get_guest_pgd     = get_guest_cr3;
+	context->w.get_guest_pgd     = get_guest_cr3;
+
 	context->get_pdptr         = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
 }
@@ -6045,10 +6047,11 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
 		return;
 
 	g_context->cpu_role.as_u64   = new_mode.as_u64;
-	g_context->get_guest_pgd     = get_guest_cr3;
 	g_context->get_pdptr         = kvm_pdptr_read;
 	g_context->inject_page_fault = kvm_inject_page_fault;
 
+	g_context->w.get_guest_pgd     = get_guest_cr3;
+
 	/*
 	 * L2 page tables are never shadowed, so there is no need to sync
 	 * SPTEs.
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index ab1aebf2f73c..9c3ccea6cd6b 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -342,7 +342,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	trace_kvm_mmu_pagetable_walk(addr, access);
 retry_walk:
 	walker->level = mmu->cpu_role.base.level;
-	pte           = kvm_mmu_get_guest_pgd(vcpu, mmu);
+	pte           = kvm_mmu_get_guest_pgd(vcpu, w);
 	have_ad       = PT_HAVE_ACCESSED_DIRTY(mmu);
 
 #if PTTYPE == 64
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 593f5856c530..b29cc7863646 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -97,7 +97,9 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 				svm->vmcb01.ptr->save.efer,
 				svm->nested.ctl.nested_cr3,
 				svm->nested.ctl.misc_ctl);
-	vcpu->arch.mmu->get_guest_pgd     = nested_svm_get_tdp_cr3;
+
+	vcpu->arch.mmu->w.get_guest_pgd     = nested_svm_get_tdp_cr3;
+
 	vcpu->arch.mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
 	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 679fe0c2894a..a16f37094071 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -494,7 +494,8 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
 	nested_ept_new_eptp(vcpu);
-	vcpu->arch.mmu->get_guest_pgd     = nested_ept_get_eptp;
+	vcpu->arch.mmu->w.get_guest_pgd     = nested_ept_get_eptp;
+
 	vcpu->arch.mmu->inject_page_fault = nested_ept_inject_page_fault;
 	vcpu->arch.mmu->get_pdptr         = kvm_pdptr_read;
 
-- 
2.52.0


