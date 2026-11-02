Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641540;
	b=GJ6qTEwBVrwG2jDeEYu19MyHLF3vxyRAzBhU1r+edBVmexFjOok7QMVEL2AzfHGg5Qbs
	 vYiehR23xRz2q+18fHNI1Uxv5I2LAKtZMBwCalgsTV3srRTm4Rm80uIfSzPiOjgEnF7BS
	 bP5RJ091LqeKYyT3sk9M1iZSRkmzhTdL1szhwwp3phzYFyd8QBHlgXy3HLS5kNE6+lFYr
	 qNESsa4EMEa6gh3Z6n0eMznGPr7wVhbQ2iRZYdvzCye8mLRT1OBlv1jD7wGuWinlZ2epF
	 qFhPrZOVan9+b3U5l0yD35Fy0bx2Ei5e/IHplwCU7QuNi/NOv067KjreLzkGdqIajmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641540;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=ablAo5YIIqHuiUUC3hode5eZZ+Mpi40SR0IQ+7UmtLk=;
	b=T96zM6icA5qswm4a6Zhjq6ntm3RnQNfZL0RkuP7RhzBXArNrsaZoKwWJdIIgOkFV/lE0
	 vCPvQfxosb1epifVrH5QeOYvJIWH52omVU4OAEcEIsXXjLU2wVePt07uuWBLfeJnzIJHP
	 11oKBOmUU6A7jJXYXtSwjNfq3Q6S0cHPzrVpdrIIZsw/WEElFmLPJjvaTUdj+8f6Jp3ZA
	 lEGbdijPeGSYHco/P+BVptgzluyqMRxlNu3H0ZjSuu7LuVQEbvoeg0WcLOOIzwWtL/FpU
	 UeYFni96rff+E3Ol9aHXrnPejHLRda1Hefya2Gag50IQxvszFNtObpu1bPUr1+8iimA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g1jrYat1;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C554607E528
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C554607E528
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g1jrYat1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ablAo5YIIqHuiUUC3hode5eZZ+Mpi40SR0IQ+7UmtLk=;
	b=g1jrYat1j5AIiddw3WOF4rImE5c5LEe0RhKs+Ws30QQaqIg2V427VbzFF0/p940xef22na
	379Vn27W4mCcbyuPzkxE2s3D6v4//abK8/1gkJl3xsSJHioxnrtZR8sTMolvhmnvZsbKgB
	pIjtqoqenjQ2RpkToex3ayHobRBwD9s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-qy_Vmfo4NzedVa1KjRcFxA-1; Mon,
 02 Nov 2026 12:45:28 -0500
X-MC-Unique: qy_Vmfo4NzedVa1KjRcFxA-1
X-Mimecast-MFC-AGG-ID: qy_Vmfo4NzedVa1KjRcFxA_1793641527
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5976A1800147;
	Mon,  2 Nov 2026 17:45:27 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB6D2180057F;
	Mon,  2 Nov 2026 17:45:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 37/45] KVM: x86/mmu: Issue memory fault exit if walk failed due to memory attribute
Date: Mon,  2 Nov 2026 12:45:04 -0500
Message-ID: <20261102174512.8903-21-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

During execution, page table entries are subject to memory protection
simply because their GPA is obtained with an EPT walk.  During emulation,
the checks need to be done by hand and result in an -EFAULT userspace
exit.

However, if a guest PTE is read-only, do not go all the way out to
userspace and just stomp out the write.  This is consistent with the way
KVM handles read-only memory slots during emulation, though admittedly
inconsistent with everything else: NPT for example always wants nested
page table entries for the guest page tables to be writable, and will
fault.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-27-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/mmu/mmu.c          |  6 +++--
 arch/x86/kvm/mmu/paging_tmpl.h  | 40 ++++++++++++++++++++++++++-------
 arch/x86/kvm/regs.h             |  6 +++++
 arch/x86/kvm/svm/nested.c       | 16 ++++++-------
 arch/x86/kvm/vmx/nested.c       |  2 +-
 6 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7fbcf60e56cf..e33ca5ea59bd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -486,7 +486,7 @@ struct kvm_page_fault;
  */
 struct kvm_pagewalk {
 	unsigned long (*get_guest_pgd)(struct kvm_vcpu *vcpu);
-	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
+	int (*get_pdptr)(struct kvm_vcpu *vcpu, int index, u64 *pdptr);
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
 				  struct x86_exception *fault,
 				  bool from_hardware);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9567c109306b..c08168595732 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4204,7 +4204,9 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 */
 	if (w->cpu_role.base.level == PT32E_ROOT_LEVEL) {
 		for (i = 0; i < 4; ++i) {
-			pdptrs[i] = w->get_pdptr(vcpu, i);
+			r = w->get_pdptr(vcpu, i, &pdptrs[i]);
+			if (r)
+				return r;
 			if (!(pdptrs[i] & PT_PRESENT_MASK))
 				continue;
 
@@ -6211,7 +6213,7 @@ static void init_kvm_page_walk(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 
 	w->cpu_role.as_u64   = cpu_role.as_u64;
 	w->inject_page_fault = kvm_inject_page_fault;
-	w->get_pdptr         = kvm_pdptr_read;
+	w->get_pdptr         = kvm_pdptr_get;
 	w->get_guest_pgd     = get_guest_cr3;
 
 	if (!is_cr0_pg(w))
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index a76ec22ce3f2..ddab65e5689d 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -89,6 +89,7 @@ struct guest_walker {
 	unsigned int pt_access[PT_MAX_FULL_LEVELS];
 	unsigned int pte_access;
 	gfn_t gfn;
+	int error;
 	struct x86_exception fault;
 };
 
@@ -342,6 +343,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 	trace_kvm_mmu_pagetable_walk(addr, access);
 retry_walk:
+	walker->error = 0;
 	walker->level = w->cpu_role.base.level;
 	pte           = kvm_mmu_get_guest_pgd(vcpu, w);
 	have_ad       = PT_HAVE_ACCESSED_DIRTY(w);
@@ -349,7 +351,9 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 #if PTTYPE == 64
 	walk_nx_mask = 1ULL << PT64_NX_SHIFT;
 	if (walker->level == PT32E_ROOT_LEVEL) {
-		pte = w->get_pdptr(vcpu, (addr >> 30) & 3);
+		walker->error = w->get_pdptr(vcpu, (addr >> 30) & 3, &pte);
+		if (walker->error)
+			goto error;
 		trace_kvm_mmu_paging_element(pte, walker->level);
 		if (!FNAME(is_present_gpte)(w, pte))
 			goto error;
@@ -398,9 +402,11 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		walker->table_gfn[walker->level - 1] = table_gfn;
 		walker->pte_gpa[walker->level - 1] = pte_gpa;
 
-		kvm_translate_gpa(vcpu, w, gfn_to_gpa(table_gfn),
-				  nested_access | PFERR_GUEST_PAGE_MASK,
-				  &real_gpa, &walker->fault, 0);
+		walker->error = kvm_translate_gpa(vcpu, w, gfn_to_gpa(table_gfn),
+						  nested_access | PFERR_GUEST_PAGE_MASK,
+						  &real_gpa, &walker->fault, 0);
+		if (walker->error)
+			return 0;
 
 		if (unlikely(real_gpa == INVALID_GPA))
 			return 0;
@@ -414,6 +420,16 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		if (unlikely(kvm_is_error_hva(host_addr)))
 			goto error;
 
+		if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gpa_to_gfn(real_gpa))) {
+			walker->error = -EFAULT;
+			kvm_prepare_memory_fault_exit(vcpu, real_gpa & PAGE_MASK,
+						      PAGE_SIZE, false, false, false);
+			goto error;
+		}
+
+		if (!kvm_mem_attributes_may_write_gfn(vcpu->kvm, gpa_to_gfn(real_gpa)))
+			walker->pte_writable[walker->level - 1] = false;
+
 		ptep_user = (pt_element_t __user *)((void *)host_addr + offset);
 		if (unlikely(get_user(pte, ptep_user)))
 			goto error;
@@ -458,9 +474,11 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		gfn += pse36_gfn_delta(pte);
 #endif
 
-	kvm_translate_gpa(vcpu, w, gfn_to_gpa(gfn),
-			  access | PFERR_GUEST_FINAL_MASK, &real_gpa,
-			  &walker->fault, walker->pte_access);
+	walker->error = kvm_translate_gpa(vcpu, w, gfn_to_gpa(gfn),
+					  access | PFERR_GUEST_FINAL_MASK, &real_gpa,
+					  &walker->fault, walker->pte_access);
+	if (walker->error)
+		return 0;
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
@@ -823,6 +841,9 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * The page is not mapped by the guest.  Let the guest handle it.
 	 */
 	if (!r) {
+		if (walker.error)
+			return walker.error;
+
 		if (!fault->prefetch)
 			__kvm_inject_emulated_page_fault(vcpu, &walker.fault, true);
 
@@ -920,8 +941,11 @@ static int FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 	if (r) {
 		*gpa = gfn_to_gpa(walker.gfn);
 		*gpa |= addr & ~PAGE_MASK;
-	} else if (exception)
+	} else if (walker.error) {
+		return walker.error;
+	} else if (exception) {
 		*exception = walker.fault;
+	}
 
 	return 0;
 }
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 97c17b120a57..31f4d3f6ea42 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -319,6 +319,12 @@ static inline u64 kvm_pdptr_read(struct kvm_vcpu *vcpu, int index)
 	return vcpu->arch.pdptrs[index];
 }
 
+static inline int kvm_pdptr_get(struct kvm_vcpu *vcpu, int index, u64 *pdptr)
+{
+	*pdptr = kvm_pdptr_read(vcpu, index);
+	return 0;
+}
+
 static inline void kvm_pdptr_write(struct kvm_vcpu *vcpu, int index, u64 value)
 {
 	vcpu->arch.pdptrs[index] = value;
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a512e0e8dd93..4d76e8880d99 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -71,22 +71,22 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 	nested_svm_vmexit(svm);
 }
 
-static u64 nested_svm_get_tdp_pdptr(struct kvm_vcpu *vcpu, int index)
+static int nested_svm_get_tdp_pdptr(struct kvm_vcpu *vcpu, int index, u64 *pdptr)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u64 cr3 = svm->nested.ctl.nested_cr3;
-	u64 pdpte;
-	int ret;
+	int r;
 
 	/*
 	 * Note, nCR3 is "assumed" to be 32-byte aligned, i.e. the CPU ignores
 	 * nCR3[4:0] when loading PDPTEs from memory.
 	 */
-	ret = kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(cr3), &pdpte,
-				       (cr3 & GENMASK(11, 5)) + index * 8, 8);
-	if (ret)
-		return 0;
-	return pdpte;
+	r = kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(cr3), pdptr,
+				     (cr3 & GENMASK(11, 5)) + index * 8, 8);
+	if (r == -EFAULT)
+		kvm_prepare_memory_fault_exit(vcpu, cr3 & PAGE_MASK, PAGE_SIZE,
+					      false, false, false);
+	return r;
 }
 
 static unsigned long nested_svm_get_tdp_cr3(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8c110f3d9cc3..2ac4a366ace4 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -520,7 +520,7 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
 	nested_ept_new_eptp(vcpu);
 	vcpu->arch.ngpa_walk.get_guest_pgd     = nested_ept_get_eptp;
-	vcpu->arch.ngpa_walk.get_pdptr       = kvm_pdptr_read;
+	vcpu->arch.ngpa_walk.get_pdptr       = kvm_pdptr_get;
 
 	vcpu->arch.ngpa_walk.inject_page_fault = nested_ept_inject_page_fault;
 }
-- 
2.52.0


