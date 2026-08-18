Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F2443E2D
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044574; cv=none; b=SNELqkbJDHopOzuYwkiBX6z9TxqU7xoUrt5DQCT9Ztpf5ch3la2BJgfFoqstXbQW/gI0bFkMPr8G366Vo+HurelsfPZp2/NJ/HY0GZ8N7vw7T5FYn4LeXYqig33ewX4bB+/qqWt49AMOaXt00BM0sIFi+SKmAsoAEQOOd5vztvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044574; c=relaxed/simple;
	bh=fpN4UcSZe0YggI4I7TSlJ6d/zlBNR8mXe8ni99KJcYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fKfGgaoRMcqv+3mhO+60MswAi2ZoIaF7X3l9B6DF5PXIaTx0B7c6d+nT1Snzb/SlJUZiWz6bveKfYBsUilxqz4r91BWP2Utao1wlObXmbONTOWFui83Hyet0VUg3PYFF0qTJaRbleEZZ0TxzBVMgZHzgmL4ooLnbCAVihZwNiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htwJa9QZ; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htwJa9QZ"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e024d2129so7555690b3a.2
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 02:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787044566; x=1787649366; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k8WNGrZX+hjlSdnhW34q1ZcSrRlLRd8OoKfIun9uixY=;
        b=htwJa9QZljtsCRRQsfpyn0EwDG2KeKAMurT4+M7bYLXA9PyL8RddC58uS0S75cWdxG
         ZgEMApRqk6mubehFxX0l3tn60O9JiD7NRgR8JfY0xxADo6Hs42qUcYQU7CelvBNrGhrg
         c8P8KAhvS3S4XeSEtCD9hzcARyXBn7juQV9Szvdk5YA6omLRewuOrXlBARS32RpPdr+B
         a5xQ7e4R4JkBpH4TdQLELLNuEyWiKPP1HAqMaKtj/+2SF36VISeqCrj6pWbVGrxkXk0p
         xuUrbJzKYw4NIcBi6r3gORAlqdEUpJQcbyLdR0LQky+/+dwxkuODfBxSSjSJ6UkDxjAP
         y8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787044566; x=1787649366;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k8WNGrZX+hjlSdnhW34q1ZcSrRlLRd8OoKfIun9uixY=;
        b=LrxOaaRp5qcT69rq2R/MQOU0kaGaP/GwuTnWGNTboEzpYM/QHIsqlLdmGIYMrxXWDb
         V1RGcjeWPnMKQBLNJ9IkTdEKPqYYL9QCQeOtX5qZmtLS00VUsDBKH4FNINB0Hxa5KLxJ
         gjtOcPtV1gv4NNbPAFUDgpT/kscHZay76iADfnh4nLd74Mku/obYXEVODNTZKn2fknqF
         oxnV0tP9o4QUeCM5NKoa0bi7jlZT3uSNSXh8cNNRU16Opu91pTn2wMstb0laU7fX5Sbc
         JqZUqSR8CuvfBuCLGleN/5kchktJKjJD6BFqIvL/Xa2vWz2TioieFvnSSWADQCr5GSbA
         7Vaw==
X-Gm-Message-State: AOJu0YzBwRHJvQNea1vXK4mwx2VcUx3gO9PNreIf1FV1pmWdJPjVCGMQ
	rQho+KKKFofR5K/N1q9zqzRb9QOn8UVhlnaKr8V9uPRs4YQSAsRmFf3kvhuhH1oYlv9IqQkk9m6
	+N1Zn0FRS2f7qxOtygMW4Quf/nw==
X-Received: from pgar27.prod.google.com ([2002:a05:6a02:2e9b:b0:c9e:2db2:a2cf])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9d84:b0:3c3:bbe6:95c7 with SMTP id adf61e73a8af0-3cc71c57b6cmr42337079637.17.1787044565764;
 Tue, 18 Aug 2026 02:16:05 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:15:55 +0000
In-Reply-To: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787044557; l=7550;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=RNStHwu6ieacAYEnMn7/3gq/7NJJQ1KRNJugMUE32xM=; b=SRWVS1YnkzbusdD23laTjDq6lw3cgThTG7x/5lRPjxg2aZnzn3huhMER8r42Tv3YVr+kuGE3U
 mZ9CzNyj2NFCq5w150/6XXA4e4tzMt53i6D8Q/4vh6tli54166j/Rqe
X-Mailer: b4 0.16.0
Message-ID: <20260818-gmem-no-return-page-v2-4-5298f42d49bb@google.com>
Subject: [PATCH v2 4/4] KVM: guest_memfd: Stop returning struct page from PFN lookup
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, David Hildenbrand <david@kernel.org>, Fuad Tabba <tabba@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

KVM currently expects guest_memfd PFN lookups to return a refcounted
struct page, which callers hold across fault handling.

Holding a page reference across fault handling is problematic for
guest_memfd. In-place memory conversions between confidential
computing shared and private states inspect folio refcounts to ensure
exclusive ownership by guest_memfd. A concurrent guest page fault
taking a reference on the folio causes conversions to fail due to an
elevated refcount.

guest_memfd already notifies KVM of page invalidations, so callers
within KVM only need to respect the MMU invalidation protocol to safely
rely on guest_memfd for page presence.

Furthermore, removing struct page from the guest_memfd PFN lookup moves
KVM closer toward supporting memory backends that are not backed by
struct page.

Drop the folio reference immediately before returning from the
guest_memfd PFN lookup, and stop returning the struct page pointer.

For ARM, initialize the local page pointer to NULL so that the shared
cleanup path that releases fault-in pages safely no-ops for guest_memfd.

For x86, no additional changes are required in the MMU fault path
because the page fault tracking structure is zero-initialized at the
start of page fault handling, ensuring the refcounted page pointer is
already NULL.

Reported-by: Yan Zhao <yan.y.zhao@intel.com>
Closes: https://lore.kernel.org/all/anZ4W9o5pTWIEgMY@yzhao56-desk.sh.intel.com/
Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/arm64/kvm/mmu.c     | 4 ++--
 arch/arm64/kvm/nested.c  | 4 ++--
 arch/x86/kvm/mmu/mmu.c   | 2 +-
 arch/x86/kvm/svm/sev.c   | 8 ++------
 include/linux/kvm_host.h | 6 ++----
 virt/kvm/guest_memfd.c   | 9 ++-------
 6 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 6c941aaa10c63..e5d637a5ec558 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1613,7 +1613,7 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
 	struct kvm_pgtable *pgt = s2fd->vcpu->arch.hw_mmu->pgt;
 	unsigned long mmu_seq;
-	struct page *page;
+	struct page *page = NULL;
 	struct kvm *kvm = s2fd->vcpu->kvm;
 	void *memcache = NULL;
 	kvm_pfn_t pfn;
@@ -1641,7 +1641,7 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
 	smp_rmb();
 
-	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, &page, NULL);
+	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, NULL);
 	if (ret) {
 		kvm_prepare_memory_fault_exit(s2fd->vcpu, s2fd->fault_ipa, PAGE_SIZE,
 					      write_fault, exec_fault, false);
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index fb54f6dad995c..43523bb17621a 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1360,7 +1360,7 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 	bool write_fault, writable;
 	unsigned long mmu_seq;
 	struct vncr_tlb *vt;
-	struct page *page;
+	struct page *page = NULL;
 	u64 va, pfn, gfn;
 	int ret;
 
@@ -1411,7 +1411,7 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 		if (is_error_noslot_pfn(pfn) || (write_fault && !writable))
 			return -EFAULT;
 	} else {
-		ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, &page, NULL);
+		ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, NULL);
 		if (ret) {
 			kvm_prepare_memory_fault_exit(vcpu, vt->wr.pa, PAGE_SIZE,
 					      write_fault, false, false);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c519e8e8d646f..129d403308051 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4604,7 +4604,7 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 	}
 
 	r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn,
-			     &fault->refcounted_page, &max_order);
+			     &max_order);
 	if (r) {
 		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
 		return r;
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d3d620bc04dce..32db979daaaf0 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4016,7 +4016,6 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	struct kvm *kvm = vcpu->kvm;
 	gfn_t gfn = gpa_to_gfn(gpa);
 	unsigned long mmu_seq;
-	struct page *page;
 	kvm_pfn_t pfn;
 
 	lockdep_assert_held(&svm->sev_es.snp_vmsa_mutex);
@@ -4060,9 +4059,8 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	 * The new VMSA will be private memory guest memory, so retrieve the
 	 * PFN from the gmem backend.
 	 */
-	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
+	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, NULL))
 		return;
-	kvm_release_page_clean(page);
 
 	read_lock(&kvm->mmu_lock);
 	/*
@@ -5003,7 +5001,6 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 	struct kvm *kvm = vcpu->kvm;
 	int order, rmp_level, ret;
 	unsigned long mmu_seq;
-	struct page *page;
 	bool assigned;
 	kvm_pfn_t pfn;
 	gfn_t gfn;
@@ -5033,13 +5030,12 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 	mmu_seq = kvm->mmu_invalidate_seq;
 	smp_rmb();
 
-	ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &page, &order);
+	ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &order);
 	if (ret) {
 		pr_warn_ratelimited("SEV: Unexpected RMP fault, no backing page for private GPA 0x%llx\n",
 				    gpa);
 		return;
 	}
-	kvm_release_page_unused(page);
 
 	ret = snp_lookup_rmpentry(pfn, &assigned, &rmp_level);
 	if (ret || !assigned) {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6e..502465119ca0c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2586,13 +2586,11 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
-		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
-		     int *max_order);
+		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order);
 #else
 static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 				   struct kvm_memory_slot *slot, gfn_t gfn,
-				   kvm_pfn_t *pfn, struct page **page,
-				   int *max_order)
+				   kvm_pfn_t *pfn, int *max_order)
 {
 	KVM_BUG_ON(1, kvm);
 	return -EIO;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b596486d184ca..589762140c3ef 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -751,8 +751,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 }
 
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
-		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
-		     int *max_order)
+		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
 {
 	pgoff_t index = kvm_gmem_get_index(slot, gfn);
 	struct folio *folio;
@@ -780,11 +779,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 #endif
 
 	folio_unlock(folio);
-
-	if (!r)
-		*page = folio_file_page(folio, index);
-	else
-		folio_put(folio);
+	folio_put(folio);
 
 	return r;
 }

-- 
2.55.0.699.gb54405d56f-goog

