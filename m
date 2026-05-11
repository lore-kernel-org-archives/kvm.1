Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D95F350A05
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512025; cv=none; b=ee89+Tt3Yd32vk/o5+TYEaMpUCZFl55JxwfPj+3g6M/68Isgq+6FZBb1PvfY0f37OXjGQ4mo2TntnpeA81yg9cOh6CBtf1iwXQ7QuedNEXPKA3XRwgsFgAtlMK5j69F4OP9VNzLP6DLFGE1t7UOB9S0D7TgYaSvnPyjoUJRsAbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512025; c=relaxed/simple;
	bh=reCaf/dcoCXXXtlEbyPvhBFsDeqkvAVTi+FhZU2XzqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Os8MAyMp7fHDiTVqXaTZrcl5+knKcfd4Nku3IEVjVDN8zERkKHkjWdoJlpZT7PzE1EXSiBil97eA1ulvYNuhkPRIyPctZ1BwOMSWZzlu9zsT3qwctwO/HYgiLZaN4FMmOUBPqHVwM8RWpitYNEJzRl26frf6TVwrRvcVEUd2vbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJ13lC6T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJ13lC6T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwnHmrhpR72Js8lruABK3e2TbNjmwNcC6Bwn+uy1TWI=;
	b=FJ13lC6TH5c/ashcUG5HIw48wCvV7yDRsoPJ8kjp4px71xpMaPon4wbI5G36wBrkyKuKB0
	IAVWWVHHD47LafT+5oHOp1SJik2r85gDiLmGVJjvYY4i4aXX14cGHdRxA/Rk4E/iBH8MyW
	KdG6hGnRwYgrXXTEmIuNajjbDryoECs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-bwM-nxPAM7ak9khLWcjctw-1; Mon,
 11 May 2026 11:06:56 -0400
X-MC-Unique: bwM-nxPAM7ak9khLWcjctw-1
X-Mimecast-MFC-AGG-ID: bwM-nxPAM7ak9khLWcjctw_1778512015
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C90F01800597;
	Mon, 11 May 2026 15:06:55 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43B5F1800264;
	Mon, 11 May 2026 15:06:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	mtosatti@redhat.com
Subject: [PATCH 08/22] KVM: x86/mmu: move get_pdptr to struct kvm_pagewalk
Date: Mon, 11 May 2026 11:06:34 -0400
Message-ID: <20260511150648.685374-9-pbonzini@redhat.com>
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
index 631ef6397e4e..948d31ae8598 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -478,6 +478,7 @@ struct kvm_page_fault;
  */
 struct kvm_pagewalk {
 	unsigned long (*get_guest_pgd)(struct kvm_vcpu *vcpu);
+	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
 	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			    gpa_t gva_or_gpa, u64 access,
 			    struct x86_exception *exception);
@@ -486,7 +487,6 @@ struct kvm_pagewalk {
 struct kvm_mmu {
 	struct kvm_pagewalk w;
 
-	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
 	int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
 				  struct x86_exception *fault);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 552a104e9496..a51705f53957 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4085,7 +4085,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 */
 	if (mmu->cpu_role.base.level == PT32E_ROOT_LEVEL) {
 		for (i = 0; i < 4; ++i) {
-			pdptrs[i] = mmu->get_pdptr(vcpu, i);
+			pdptrs[i] = mmu->w.get_pdptr(vcpu, i);
 			if (!(pdptrs[i] & PT_PRESENT_MASK))
 				continue;
 
@@ -5880,9 +5880,9 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	context->root_role.word = root_role.word;
 	context->page_fault = kvm_tdp_page_fault;
 	context->sync_spte = NULL;
-	context->get_pdptr = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
 
+	context->w.get_pdptr = kvm_pdptr_read;
 	context->w.get_guest_pgd = get_guest_cr3;
 
 	if (!is_cr0_pg(context))
@@ -6032,9 +6032,9 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
 
 	kvm_init_shadow_mmu(vcpu, cpu_role);
 
+	context->w.get_pdptr         = kvm_pdptr_read;
 	context->w.get_guest_pgd     = get_guest_cr3;
 
-	context->get_pdptr         = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
 }
 
@@ -6047,9 +6047,9 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
 		return;
 
 	g_context->cpu_role.as_u64   = new_mode.as_u64;
-	g_context->get_pdptr         = kvm_pdptr_read;
 	g_context->inject_page_fault = kvm_inject_page_fault;
 
+	g_context->w.get_pdptr         = kvm_pdptr_read;
 	g_context->w.get_guest_pgd     = get_guest_cr3;
 
 	/*
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 6fcce1d9b787..ef112ca1e405 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -348,7 +348,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 #if PTTYPE == 64
 	walk_nx_mask = 1ULL << PT64_NX_SHIFT;
 	if (walker->level == PT32E_ROOT_LEVEL) {
-		pte = mmu->get_pdptr(vcpu, (addr >> 30) & 3);
+		pte = w->get_pdptr(vcpu, (addr >> 30) & 3);
 		trace_kvm_mmu_paging_element(pte, walker->level);
 		if (!FNAME(is_present_gpte)(mmu, pte))
 			goto error;
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b09972424392..db1800cdf38f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -99,8 +99,8 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 				svm->nested.ctl.misc_ctl);
 
 	vcpu->arch.mmu->w.get_guest_pgd     = nested_svm_get_tdp_cr3;
+	vcpu->arch.mmu->w.get_pdptr       = nested_svm_get_tdp_pdptr;
 
-	vcpu->arch.mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
 	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 }
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f4ee7f3d3fed..08c595bd3314 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -495,9 +495,9 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
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


