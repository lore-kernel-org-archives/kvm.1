Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B45A3E5ED8
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337353; cv=none; b=exh8f1MJ8O2SWYNogGiHLhorCaVsx92aZBZEdR4B63fGvzOb58oDuexI8UDhXFXkoc4E7Q2YNxedCr1SI8KNXfesPpEBsvvGQ7OWuPBlxLT8SbR7qklcgVwacplvckPxfoTdtXwczVuu0yA/uLaNjRPaJGWZh8MsIX0Yqzd5jsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337353; c=relaxed/simple;
	bh=LRx6TG8kYOkDZ99aAL5LVCzV2JZqpzIIrUsJkbfmf6A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgRxKnoiodzrdqdQ3XaUKn+SjGjTrpTZsCIOnaMQz/RzAjiAtPD8IqGKiL9WXCiXsSwzLmSaPlt312tGahEQZNjkPR0v5qkBxqMSZPNWxdsu4pUgZvdGgaTW3yOBPYbvyNTnmestiDAlWQRi1mXTN0wFlpU6cJpeIcODSImp5i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SukPqfEj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SukPqfEj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782337347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cb59Gbs6BpXrP1qDI97N/av43+dnmqF9xUHvOKhLVos=;
	b=SukPqfEjWV7lKbgbFEePggYWk7hdXWGsK3JQD6/R5XJRec2mTOeBCgXwizyRmtcvVOYa3F
	1wpGPL+aIrQy4L71Y4xcEOAMFe0elbfMSwpsUt4Vik6VEQnz7n/aYrmnje4KsPfyzlL9HY
	KtcuqdgiqvL6Ts3lrUAIJ2ARbrI28Ak=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-WQrTjZ5jOeSzB2N9-JnBMw-1; Wed,
 24 Jun 2026 17:42:24 -0400
X-MC-Unique: WQrTjZ5jOeSzB2N9-JnBMw-1
X-Mimecast-MFC-AGG-ID: WQrTjZ5jOeSzB2N9-JnBMw_1782337343
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01E321955D97;
	Wed, 24 Jun 2026 21:42:23 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 911E91686;
	Wed, 24 Jun 2026 21:42:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 7.2-based 06/19] KVM: x86/mmu: move inject_page_fault to struct kvm_pagewalk
Date: Wed, 24 Jun 2026 17:42:05 -0400
Message-ID: <20260624214218.73796-7-pbonzini@redhat.com>
In-Reply-To: <20260624214218.73796-1-pbonzini@redhat.com>
References: <20260624214218.73796-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Injection of page faults is also part of accesses to guest
page tables.  In particular, kvm_inject_emulated_page_fault
calls it on walk_mmu.  Move it to struct kvm_pagewalk as
part of converting walk_mmu to a struct kvm_pagewalk.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 6 +++---
 arch/x86/kvm/mmu/mmu.c          | 8 +++-----
 arch/x86/kvm/svm/nested.c       | 2 +-
 arch/x86/kvm/vmx/nested.c       | 2 +-
 arch/x86/kvm/x86.c              | 4 ++--
 5 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8759ea1e8b96..8a3c13636100 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -484,6 +484,9 @@ struct kvm_page_fault;
 struct kvm_pagewalk {
 	unsigned long (*get_guest_pgd)(struct kvm_vcpu *vcpu);
 	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
+	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
+				  struct x86_exception *fault,
+				  bool from_hardware);
 	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			    gpa_t gva_or_gpa, u64 access,
 			    struct x86_exception *exception);
@@ -493,9 +496,6 @@ struct kvm_mmu {
 	struct kvm_pagewalk w;
 
 	int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
-	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
-				  struct x86_exception *fault,
-				  bool from_hardware);
 	int (*sync_spte)(struct kvm_vcpu *vcpu,
 			 struct kvm_mmu_page *sp, int i);
 	struct kvm_mmu_root_info root;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 16dc317c54b1..9f571258852c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5901,8 +5901,8 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	context->root_role.word = root_role.word;
 	context->page_fault = kvm_tdp_page_fault;
 	context->sync_spte = NULL;
-	context->inject_page_fault = kvm_inject_page_fault;
 
+	context->w.inject_page_fault = kvm_inject_page_fault;
 	context->w.get_pdptr = kvm_pdptr_read;
 	context->w.get_guest_pgd = get_guest_cr3;
 
@@ -6053,10 +6053,9 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
 
 	kvm_init_shadow_mmu(vcpu, cpu_role);
 
+	context->w.inject_page_fault = kvm_inject_page_fault;
 	context->w.get_pdptr         = kvm_pdptr_read;
 	context->w.get_guest_pgd     = get_guest_cr3;
-
-	context->inject_page_fault = kvm_inject_page_fault;
 }
 
 static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
@@ -6068,8 +6067,7 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
 		return;
 
 	g_context->cpu_role.as_u64   = new_mode.as_u64;
-	g_context->inject_page_fault = kvm_inject_page_fault;
-
+	g_context->w.inject_page_fault = kvm_inject_page_fault;
 	g_context->w.get_pdptr         = kvm_pdptr_read;
 	g_context->w.get_guest_pgd     = get_guest_cr3;
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 998c609770c6..3c19efd9b347 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -116,7 +116,7 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->w.get_guest_pgd     = nested_svm_get_tdp_cr3;
 	vcpu->arch.mmu->w.get_pdptr       = nested_svm_get_tdp_pdptr;
 
-	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
+	vcpu->arch.mmu->w.inject_page_fault = nested_svm_inject_npf_exit;
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 }
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 766aabc751d9..a0f13adea8d8 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -514,7 +514,7 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->w.get_guest_pgd     = nested_ept_get_eptp;
 	vcpu->arch.mmu->w.get_pdptr       = kvm_pdptr_read;
 
-	vcpu->arch.mmu->inject_page_fault = nested_ept_inject_page_fault;
+	vcpu->arch.mmu->w.inject_page_fault = nested_ept_inject_page_fault;
 
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 432532aff5c6..36ceb556a3c2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -991,7 +991,7 @@ void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 		kvm_mmu_invalidate_addr(vcpu, fault_mmu, fault->address,
 					KVM_MMU_ROOT_CURRENT);
 
-	fault_mmu->inject_page_fault(vcpu, fault, from_hardware);
+	fault_mmu->w.inject_page_fault(vcpu, fault, from_hardware);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_inject_emulated_page_fault);
 
@@ -14186,7 +14186,7 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 		fault.address = gva;
 		fault.async_page_fault = false;
 	}
-	vcpu->arch.walk_mmu->inject_page_fault(vcpu, &fault, true);
+	vcpu->arch.walk_mmu->w.inject_page_fault(vcpu, &fault, true);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_fixup_and_inject_pf_error);
 
-- 
2.52.0


