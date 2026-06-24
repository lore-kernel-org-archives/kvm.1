Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AEF3E6DC8
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336674; cv=none; b=pl7rVkd1WZkUbq0JA8UjiClHTLsGDZtGzBYh/VSDOvNikxgjDV3IjIrxXnZ0qhNT7QJaaX16qikvTlEmSac1qAKzlkhvmeofsM0jDZJ+lpassnM1CC8+3T3g6a4Lcfrzqsy4IclDUiyEJq1zN3p49wiiX9QUQtbsofPgoYImE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336674; c=relaxed/simple;
	bh=Y6ewnr+uisAjSwWy/jn3Yo5byRkmP7qq6CkKV2VNJJs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLf/nb372xHAtQbZ8d+1HldqxrnvhherM8gvJ6/9pmsXsHtw+xnC6BX0KkeaXJjl+YsK4ax0wQrkF6Ea5BLVTVJD83BSKeclHFdRvChBvOyeF5L1J6bwRO6HNWOqoxYKI80RdeFBzkl//dymztKLxlQpjlNa8XgFGncdd2Ddl4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGDiIrUF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGDiIrUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782336671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bI98e1gZhVWu1c+oBr4qtHNFt/+w7T9EToFzuG3skA4=;
	b=UGDiIrUFskahOcgjET2s3ONmO+K0SL7PTUJ/3o8fzakRyRB9stpCqhH+OB4dekjAKUZvVb
	WRjB0N8wbxSzmlWPaXonKWk5JfLmvWfH2zsWAyGDQX+6h69aMa1a7UzoHz+8NCcMNzvuz2
	VGGV9dJYnK2JJ9iVQ2YxI5zTxb0lklc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-W3hXKLFlPHqDGewYIw4R4w-1; Wed,
 24 Jun 2026 17:31:08 -0400
X-MC-Unique: W3hXKLFlPHqDGewYIw4R4w-1
X-Mimecast-MFC-AGG-ID: W3hXKLFlPHqDGewYIw4R4w_1782336667
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C086B1800663;
	Wed, 24 Jun 2026 21:31:07 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B99A1956041;
	Wed, 24 Jun 2026 21:31:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 06/19] KVM: x86/mmu: move inject_page_fault to struct kvm_pagewalk
Date: Wed, 24 Jun 2026 17:30:49 -0400
Message-ID: <20260624213102.71082-7-pbonzini@redhat.com>
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
index 4ddfe9debf18..7e397b5d93ce 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -519,6 +519,9 @@ struct kvm_page_fault;
 struct kvm_pagewalk {
 	unsigned long (*get_guest_pgd)(struct kvm_vcpu *vcpu);
 	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
+	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
+				  struct x86_exception *fault,
+				  bool from_hardware);
 	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			    gpa_t gva_or_gpa, u64 access,
 			    struct x86_exception *exception);
@@ -528,9 +531,6 @@ struct kvm_mmu {
 	struct kvm_pagewalk w;
 
 	int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
-	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
-				  struct x86_exception *fault,
-				  bool from_hardware);
 	int (*sync_spte)(struct kvm_vcpu *vcpu,
 			 struct kvm_mmu_page *sp, int i);
 	struct kvm_mmu_root_info root;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ac9e1e95335a..ffc8acefd5c9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5969,8 +5969,8 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	context->root_role.word = root_role.word;
 	context->page_fault = kvm_tdp_page_fault;
 	context->sync_spte = NULL;
-	context->inject_page_fault = kvm_inject_page_fault;
 
+	context->w.inject_page_fault = kvm_inject_page_fault;
 	context->w.get_pdptr = kvm_pdptr_read;
 	context->w.get_guest_pgd = get_guest_cr3;
 
@@ -6121,10 +6121,9 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
 
 	kvm_init_shadow_mmu(vcpu, cpu_role);
 
+	context->w.inject_page_fault = kvm_inject_page_fault;
 	context->w.get_pdptr         = kvm_pdptr_read;
 	context->w.get_guest_pgd     = get_guest_cr3;
-
-	context->inject_page_fault = kvm_inject_page_fault;
 }
 
 static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
@@ -6136,8 +6135,7 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
 		return;
 
 	g_context->cpu_role.as_u64   = new_mode.as_u64;
-	g_context->inject_page_fault = kvm_inject_page_fault;
-
+	g_context->w.inject_page_fault = kvm_inject_page_fault;
 	g_context->w.get_pdptr         = kvm_pdptr_read;
 	g_context->w.get_guest_pgd     = get_guest_cr3;
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 6634d6390f77..55eace8aa2c8 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -117,7 +117,7 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->w.get_guest_pgd     = nested_svm_get_tdp_cr3;
 	vcpu->arch.mmu->w.get_pdptr       = nested_svm_get_tdp_pdptr;
 
-	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
+	vcpu->arch.mmu->w.inject_page_fault = nested_svm_inject_npf_exit;
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 }
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ef54c444413e..466f838a05bc 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -515,7 +515,7 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->w.get_guest_pgd     = nested_ept_get_eptp;
 	vcpu->arch.mmu->w.get_pdptr       = kvm_pdptr_read;
 
-	vcpu->arch.mmu->inject_page_fault = nested_ept_inject_page_fault;
+	vcpu->arch.mmu->w.inject_page_fault = nested_ept_inject_page_fault;
 
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bf0a65c76f71..484ed409e420 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -597,7 +597,7 @@ void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 		kvm_mmu_invalidate_addr(vcpu, fault_mmu, fault->address,
 					KVM_MMU_ROOT_CURRENT);
 
-	fault_mmu->inject_page_fault(vcpu, fault, from_hardware);
+	fault_mmu->w.inject_page_fault(vcpu, fault, from_hardware);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_inject_emulated_page_fault);
 
@@ -10619,7 +10619,7 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 		fault.address = gva;
 		fault.async_page_fault = false;
 	}
-	vcpu->arch.walk_mmu->inject_page_fault(vcpu, &fault, true);
+	vcpu->arch.walk_mmu->w.inject_page_fault(vcpu, &fault, true);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_fixup_and_inject_pf_error);
 
-- 
2.52.0


