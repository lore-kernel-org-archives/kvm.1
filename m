Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442303DA7C0
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662958; cv=none; b=E8pXscX1HPkiKWpKjJTcYV/hf3DHHzwjAvFsTPHQZyzGooM3AEKg07KCpY0F9qWaW39zONN5rwzgS4s5jzG3OeWUNGEJ83yMn4MDlNGW20XqEsyD4LpnI6+rbxmFqlU+rbOYTm8qCjvX9rd8i+rYBH4ZzHZY1Eddk/uJx+sM1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662958; c=relaxed/simple;
	bh=NiRZK1nPPOCZT4FFid68MW2Wp17mhjcEsXxPGHuPx4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4t/U+XJkzoytXgHvdh2vwfmLpBJZZLSawxPjuWc62nHDvm9wdIi6oD7Uksn1CRoAQ07PZmY+CW1R5c/0La/cf9SYWIoiVZ/dOp0XGZAVSSvuKsD8sZMjmdI+6wJNScUJIoStLQtfW6NSXJnnbza4pKaPnY0dBcDR5DHCJXLbYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDwbUQN6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDwbUQN6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhhfEg8cV5pxvhe06bPCmyR/4KDcczdkiCXxWkqEfHA=;
	b=aDwbUQN6ajPs0lN2g5A5+oF6LY7gvihYkSF3G+VTmSjbmGceo+ATNV6xgQGcxax7Q163Kk
	5VlSTg8i6xtPf7YqTl9HW5NZbiIbiGCCDRyTf4S3J9J1Ez+clyuSKdHN/0oVb6fviP7Bav
	tpnGvlppnqZMXLcJXjJj7RPmsByobq4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-ppbdECukNtypJLFtDtn3Pg-1; Wed,
 08 Apr 2026 11:42:31 -0400
X-MC-Unique: ppbdECukNtypJLFtDtn3Pg-1
X-Mimecast-MFC-AGG-ID: ppbdECukNtypJLFtDtn3Pg_1775662950
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83B4318002FC;
	Wed,  8 Apr 2026 15:42:30 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF6841955F2B;
	Wed,  8 Apr 2026 15:42:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 11/27] KVM: x86/mmu: pass pte_access for final nGPA->GPA walk
Date: Wed,  8 Apr 2026 11:42:01 -0400
Message-ID: <20260408154217.458420-12-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-1-pbonzini@redhat.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The XS/XU bit for EPT are only applied to final accesses, and use the
U bit from the page walk itself.  This is available in the page walker
as pte_access & ACC_USER_MASK but not available to translate_nested_gpa,
so pass it down.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/hyperv.c          |  2 +-
 arch/x86/kvm/mmu.h             | 15 ++++++++++++---
 arch/x86/kvm/mmu/mmu.c         |  2 +-
 arch/x86/kvm/mmu/paging_tmpl.h |  4 ++--
 arch/x86/kvm/mmu/spte.h        |  6 ------
 arch/x86/kvm/x86.c             |  5 +++--
 6 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index cf9dd565b894..53688f7b76eb 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2042,7 +2042,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 */
 	if (!hc->fast && is_guest_mode(vcpu)) {
 		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa,
-					PFERR_GUEST_FINAL_MASK, NULL);
+					PFERR_GUEST_FINAL_MASK, NULL, 0);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 23f37535c0ce..635c2e5d8513 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -37,6 +37,12 @@ extern bool __read_mostly enable_mmio_caching;
 #define PT32_ROOT_LEVEL 2
 #define PT32E_ROOT_LEVEL 3
 
+#define ACC_READ_MASK    PT_PRESENT_MASK
+#define ACC_WRITE_MASK   PT_WRITABLE_MASK
+#define ACC_USER_MASK    PT_USER_MASK
+#define ACC_EXEC_MASK    8
+#define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK | ACC_READ_MASK)
+
 #define KVM_MMU_CR4_ROLE_BITS (X86_CR4_PSE | X86_CR4_PAE | X86_CR4_LA57 | \
 			       X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE)
 
@@ -289,16 +295,19 @@ static inline void kvm_update_page_stats(struct kvm *kvm, int level, int count)
 }
 
 gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
-			   struct x86_exception *exception);
+			   struct x86_exception *exception,
+			   u64 pte_access);
 
 static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 				      struct kvm_mmu *mmu,
 				      gpa_t gpa, u64 access,
-				      struct x86_exception *exception)
+				      struct x86_exception *exception,
+				      u64 pte_access)
 {
 	if (mmu != &vcpu->arch.nested_mmu)
 		return gpa;
-	return translate_nested_gpa(vcpu, gpa, access, exception);
+	return translate_nested_gpa(vcpu, gpa, access, exception,
+				    pte_access);
 }
 
 static inline bool kvm_has_mirrored_tdp(const struct kvm *kvm)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a459177c0480..f911f7578613 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4340,7 +4340,7 @@ static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	if (exception)
 		exception->error_code = 0;
 	return kvm_translate_gpa(vcpu, mmu, vaddr, access | PFERR_GUEST_FINAL_MASK,
-				 exception);
+				 exception, ACC_ALL);
 }
 
 static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 567f8b77ffe0..de8770d2fcfc 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -377,7 +377,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 		real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(table_gfn),
 					     nested_access | PFERR_GUEST_PAGE_MASK,
-					     &walker->fault);
+					     &walker->fault, 0);
 
 		/*
 		 * FIXME: This can happen if emulation (for of an INS/OUTS
@@ -447,7 +447,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn),
 				     access | PFERR_GUEST_FINAL_MASK,
-				     &walker->fault);
+				     &walker->fault, pte_access);
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 121bfb2217e8..8a4c09c5cdbf 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -52,12 +52,6 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
 #define SPTE_BASE_ADDR_MASK (((1ULL << 52) - 1) & ~(u64)(PAGE_SIZE-1))
 #endif
 
-#define ACC_READ_MASK    PT_PRESENT_MASK
-#define ACC_WRITE_MASK   PT_WRITABLE_MASK
-#define ACC_USER_MASK    PT_USER_MASK
-#define ACC_EXEC_MASK    8
-#define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK | ACC_READ_MASK)
-
 #define SPTE_LEVEL_BITS			9
 #define SPTE_LEVEL_SHIFT(level)		__PT_LEVEL_SHIFT(level, SPTE_LEVEL_BITS)
 #define SPTE_INDEX(address, level)	__PT_INDEX(address, level, SPTE_LEVEL_BITS)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bbafd10fd72c..15c1b2de3d93 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1071,7 +1071,7 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 */
 	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(pdpt_gfn),
 				     PFERR_USER_MASK | PFERR_WRITE_MASK |
-				     PFERR_GUEST_PAGE_MASK, NULL);
+				     PFERR_GUEST_PAGE_MASK, NULL, 0);
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
@@ -7824,7 +7824,8 @@ void kvm_get_segment(struct kvm_vcpu *vcpu,
 }
 
 gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
-			   struct x86_exception *exception)
+			   struct x86_exception *exception,
+			   u64 pte_access)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	gpa_t t_gpa;
-- 
2.52.0


