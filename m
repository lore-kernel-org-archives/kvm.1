Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1508744CF2E
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484307; cv=none; b=TYuRx8Ag7N7vi5H+9d0DT4py//RN5s8WfLmMi18FsjKPoBc5pGIdDlWR2vF75JwA7uZT6jDhUeLfZH9M75G6FY/t8uEK4hYLQyH+gVejJh+jHZrEqBlDXtnCtteH0KSG0lmZcBSS+bAULV5KZcuC1nagrkgZU9s2AxIsSWDusvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484307; c=relaxed/simple;
	bh=n2BTAxV0etAR5ciyhPJhNssK3/0XhBg6HgaSgtQQNNI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIkc1Q9tvYCPMPa/XFHcfvpeXgNdLKnCPPGYasbdJiWm5EnaPO64ezBobuMcB42iyoq0n3+jd9REqJFgOoH3nGOQVeDVmPCHgaY6qg+TPdJtE3MLjE6eqwMcWUKyTuWHvAe04RdIddDip25mmvUkQaGIAc8g5qr+NJCLP69MaCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atWIVQXv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atWIVQXv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3CZHC1EjrAKZddVUrY3fvmuHSR7btoMrhPBGfuDvl00=;
	b=atWIVQXvt+VpmkOaBbiKj/Uy4nTJgx6nZ8PbnV53GG8O/Me+pw0GwqpBfMrTvCOQ6KODvM
	30hb6ETXcNGyXy2frI4/Z9dOnPRJmGCx4CEAOXZ9MvvpkzupMnvNbeYwDNE3SjnPUcz6aY
	YQmDly0SBr4/x/nKuEpxD+8t94gseBI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-waTGkUzuM6CRn2a3tZxhvQ-1; Wed,
 03 Jun 2026 06:58:22 -0400
X-MC-Unique: waTGkUzuM6CRn2a3tZxhvQ-1
X-Mimecast-MFC-AGG-ID: waTGkUzuM6CRn2a3tZxhvQ_1780484302
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D8421956094;
	Wed,  3 Jun 2026 10:58:22 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A517D30001A1;
	Wed,  3 Jun 2026 10:58:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 11/24] KVM: x86/mmu: move inject_page_fault to struct kvm_pagewalk
Date: Wed,  3 Jun 2026 06:58:01 -0400
Message-ID: <20260603105814.10236-12-pbonzini@redhat.com>
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

Injection of page faults is also part of accesses to guest
page tables.  In particular, kvm_inject_emulated_page_fault
calls it on walk_mmu.  Move it to struct kvm_pagewalk as
part of converting walk_mmu to a struct kvm_pagewalk.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 4 ++--
 arch/x86/kvm/mmu/mmu.c          | 8 +++-----
 arch/x86/kvm/svm/nested.c       | 2 +-
 arch/x86/kvm/vmx/nested.c       | 2 +-
 arch/x86/kvm/x86.c              | 4 ++--
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 81cb9c03cf88..fb468e234b37 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -482,6 +482,8 @@ struct kvm_page_fault;
 struct kvm_pagewalk {
 	unsigned long (*get_guest_pgd)(struct kvm_vcpu *vcpu);
 	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
+	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
+				  struct x86_exception *fault);
 	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			    gpa_t gva_or_gpa, u64 access,
 			    struct x86_exception *exception);
@@ -491,8 +493,6 @@ struct kvm_mmu {
 	struct kvm_pagewalk w;
 
 	int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
-	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
-				  struct x86_exception *fault);
 	int (*sync_spte)(struct kvm_vcpu *vcpu,
 			 struct kvm_mmu_page *sp, int i);
 	struct kvm_mmu_root_info root;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a51705f53957..4fbb7508e241 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5880,8 +5880,8 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	context->root_role.word = root_role.word;
 	context->page_fault = kvm_tdp_page_fault;
 	context->sync_spte = NULL;
-	context->inject_page_fault = kvm_inject_page_fault;
 
+	context->w.inject_page_fault = kvm_inject_page_fault;
 	context->w.get_pdptr = kvm_pdptr_read;
 	context->w.get_guest_pgd = get_guest_cr3;
 
@@ -6032,10 +6032,9 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
 
 	kvm_init_shadow_mmu(vcpu, cpu_role);
 
+	context->w.inject_page_fault = kvm_inject_page_fault;
 	context->w.get_pdptr         = kvm_pdptr_read;
 	context->w.get_guest_pgd     = get_guest_cr3;
-
-	context->inject_page_fault = kvm_inject_page_fault;
 }
 
 static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
@@ -6047,8 +6046,7 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
 		return;
 
 	g_context->cpu_role.as_u64   = new_mode.as_u64;
-	g_context->inject_page_fault = kvm_inject_page_fault;
-
+	g_context->w.inject_page_fault = kvm_inject_page_fault;
 	g_context->w.get_pdptr         = kvm_pdptr_read;
 	g_context->w.get_guest_pgd     = get_guest_cr3;
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 3eb701454a56..79ef81b878d7 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -101,7 +101,7 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->w.get_guest_pgd     = nested_svm_get_tdp_cr3;
 	vcpu->arch.mmu->w.get_pdptr       = nested_svm_get_tdp_pdptr;
 
-	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
+	vcpu->arch.mmu->w.inject_page_fault = nested_svm_inject_npf_exit;
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 }
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4af8a25926da..e9e6714ccd83 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -497,7 +497,7 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->w.get_guest_pgd     = nested_ept_get_eptp;
 	vcpu->arch.mmu->w.get_pdptr       = kvm_pdptr_read;
 
-	vcpu->arch.mmu->inject_page_fault = nested_ept_inject_page_fault;
+	vcpu->arch.mmu->w.inject_page_fault = nested_ept_inject_page_fault;
 
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 00566655ad05..e514096f960c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1005,7 +1005,7 @@ void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 		kvm_mmu_invalidate_addr(vcpu, fault_mmu, fault->address,
 					KVM_MMU_ROOT_CURRENT);
 
-	fault_mmu->inject_page_fault(vcpu, fault);
+	fault_mmu->w.inject_page_fault(vcpu, fault);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_inject_emulated_page_fault);
 
@@ -14230,7 +14230,7 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 		fault.address = gva;
 		fault.async_page_fault = false;
 	}
-	vcpu->arch.walk_mmu->inject_page_fault(vcpu, &fault);
+	vcpu->arch.walk_mmu->w.inject_page_fault(vcpu, &fault);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_fixup_and_inject_pf_error);
 
-- 
2.52.0


