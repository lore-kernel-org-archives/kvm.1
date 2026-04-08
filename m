Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2867E3DB653
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662962; cv=none; b=cQa/+uMGbge+7TagssBcLXjHWgmAGCMJ7HdBTOd1n9iUk6iiSQ2RM5qGcyX6dpNQYSmpCHJlEfyYgFS/nEqkIH2W0PUr/FpyDxCY76IF8VdhNjzCmuEZUSFeDITj1IP8HXz+Nkwa6kZ2ETc93ninHqT/0zmlRGwR+bUfDp6P9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662962; c=relaxed/simple;
	bh=yTDdJDZAMyBIkLlDwYHDFovUdVITcy3kZiOQsrzOfBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGa2xHmgAub55NHF+sQ5tXOFTaGxrbQqFKSrFIBnJoaIjOtp+V2zlWyomPHxg/WZJplkGenZjYqwVK+6ZOyo46TrbEMSFOw1KLLPzqB/zUwxE0VkIOVlAu56Aml7OB4ICrEcq8sx64R0NmAj1eiA07CWWQ40uuizvqZQ1dV46qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftCHgkia; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftCHgkia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEenS+pNViV5lCL0oy3TCnEINNWFZs/HabjzYitjLRU=;
	b=ftCHgkiaW7DHQkGtzrXKnB+fmQVs5ZZ3vYNmtkR/rhIIQus+KCA9uOm/RtEApTMyUUylqo
	OblTMcgFT6ocsI2HQcIBYk+KxPfALPqMhkmDdJgpFeKtRGWGIr4RQ8yLZh9PXiaS5105eg
	kTFMtFWWpdhK5h9tIJKe8HvMNj2Yd/M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-Rf6UlWlsP6G6jtZQJcQuJQ-1; Wed,
 08 Apr 2026 11:42:33 -0400
X-MC-Unique: Rf6UlWlsP6G6jtZQJcQuJQ-1
X-Mimecast-MFC-AGG-ID: Rf6UlWlsP6G6jtZQJcQuJQ_1775662952
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A227180057B;
	Wed,  8 Apr 2026 15:42:32 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4B9919560A6;
	Wed,  8 Apr 2026 15:42:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 13/27] KVM: x86/mmu: split XS/XU bits for EPT
Date: Wed,  8 Apr 2026 11:42:03 -0400
Message-ID: <20260408154217.458420-14-pbonzini@redhat.com>
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

When EPT is in use, replace ACC_USER_MASK with ACC_USER_EXEC_MASK,
so that supervisor and user-mode execution can be controlled
independently (ACC_USER_MASK would not allow a setting similar to
XU=0 XS=1 W=1 R=1).

Replace shadow_x_mask with shadow_xs_mask/shadow_xu_mask, to allow
setting XS and XU bits separately in EPT entries.

Note that ACC_USER_EXEC_MASK is already set through ACC_ALL in
the kvm_mmu_page roles, but it does not propagate to the XU bit
because (for now) shadow_xs_mask == shadow_xu_mask.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h          |  3 ++-
 arch/x86/kvm/mmu/mmu.c      |  2 +-
 arch/x86/kvm/mmu/mmutrace.h |  6 ++---
 arch/x86/kvm/mmu/spte.c     | 44 +++++++++++++++++++++++--------------
 arch/x86/kvm/mmu/spte.h     | 11 ++++++++--
 5 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 63be5c5efed9..d8c13e43c2d7 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -39,7 +39,8 @@ extern bool __read_mostly enable_mmio_caching;
 
 #define ACC_READ_MASK    PT_PRESENT_MASK
 #define ACC_WRITE_MASK   PT_WRITABLE_MASK
-#define ACC_USER_MASK    PT_USER_MASK
+#define ACC_USER_MASK    PT_USER_MASK   /* non EPT */
+#define ACC_USER_EXEC_MASK ACC_USER_MASK /* EPT only */
 #define ACC_EXEC_MASK    8
 #define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK | ACC_READ_MASK)
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f911f7578613..ff87dca46cc6 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5476,7 +5476,7 @@ static void reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
 static inline bool boot_cpu_is_amd(void)
 {
 	WARN_ON_ONCE(!tdp_enabled);
-	return shadow_x_mask == 0;
+	return shadow_xs_mask == 0;
 }
 
 /*
diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index dcfdfedfc4e9..3429c1413f42 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -357,8 +357,8 @@ TRACE_EVENT(
 		__entry->sptep = virt_to_phys(sptep);
 		__entry->level = level;
 		__entry->r = shadow_present_mask || (__entry->spte & PT_PRESENT_MASK);
-		__entry->x = is_executable_pte(__entry->spte);
-		__entry->u = shadow_user_mask ? !!(__entry->spte & shadow_user_mask) : -1;
+		__entry->x = (__entry->spte & (shadow_xs_mask | shadow_nx_mask)) == shadow_xs_mask;
+		__entry->u = !!(__entry->spte & (shadow_xu_mask | shadow_user_mask));
 	),
 
 	TP_printk("gfn %llx spte %llx (%s%s%s%s) level %d at %llx",
@@ -366,7 +366,7 @@ TRACE_EVENT(
 		  __entry->r ? "r" : "-",
 		  __entry->spte & PT_WRITABLE_MASK ? "w" : "-",
 		  __entry->x ? "x" : "-",
-		  __entry->u == -1 ? "" : (__entry->u ? "u" : "-"),
+		  __entry->u ? "u" : "-",
 		  __entry->level, __entry->sptep
 	)
 );
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 7b5f118ae211..779ee44893b0 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -29,8 +29,9 @@ bool __read_mostly kvm_ad_enabled;
 u64 __read_mostly shadow_host_writable_mask;
 u64 __read_mostly shadow_mmu_writable_mask;
 u64 __read_mostly shadow_nx_mask;
-u64 __read_mostly shadow_x_mask; /* mutual exclusive with nx_mask */
 u64 __read_mostly shadow_user_mask;
+u64 __read_mostly shadow_xs_mask; /* mutual exclusive with nx_mask and user_mask */
+u64 __read_mostly shadow_xu_mask; /* mutual exclusive with nx_mask and user_mask */
 u64 __read_mostly shadow_accessed_mask;
 u64 __read_mostly shadow_dirty_mask;
 u64 __read_mostly shadow_mmio_value;
@@ -217,21 +218,26 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	 * would tie make_spte() further to vCPU/MMU state, and add complexity
 	 * just to optimize a mode that is anything but performance critical.
 	 */
-	if (level > PG_LEVEL_4K && (pte_access & ACC_EXEC_MASK) &&
-	    is_nx_huge_page_enabled(vcpu->kvm)) {
+	if (level > PG_LEVEL_4K && is_nx_huge_page_enabled(vcpu->kvm)) {
 		pte_access &= ~ACC_EXEC_MASK;
+		if (shadow_xu_mask)
+			pte_access &= ~ACC_USER_EXEC_MASK;
 	}
 
 	if (pte_access & ACC_READ_MASK)
 		spte |= PT_PRESENT_MASK; /* or VMX_EPT_READABLE_MASK */
 
-	if (pte_access & ACC_EXEC_MASK)
-		spte |= shadow_x_mask;
-	else
-		spte |= shadow_nx_mask;
-
-	if (pte_access & ACC_USER_MASK)
-		spte |= shadow_user_mask;
+	if (shadow_nx_mask) {
+		if (!(pte_access & ACC_EXEC_MASK))
+			spte |= shadow_nx_mask;
+		if (pte_access & ACC_USER_MASK)
+			spte |= shadow_user_mask;
+	} else {
+		if (pte_access & ACC_EXEC_MASK)
+			spte |= shadow_xs_mask;
+		if (pte_access & ACC_USER_EXEC_MASK)
+			spte |= shadow_xu_mask;
+	}
 
 	if (level > PG_LEVEL_4K)
 		spte |= PT_PAGE_SIZE_MASK;
@@ -318,11 +324,13 @@ static u64 make_spte_executable(u64 spte, u8 access)
 {
 	u64 set, clear;
 
-	if (access & ACC_EXEC_MASK)
-		set = shadow_x_mask;
+	if (shadow_nx_mask)
+		set = (access & ACC_EXEC_MASK) ? 0 : shadow_nx_mask;
 	else
-		set = shadow_nx_mask;
-	clear = set ^ (shadow_nx_mask | shadow_x_mask);
+		set =
+			(access & ACC_EXEC_MASK ? shadow_xs_mask : 0) |
+			(access & ACC_USER_EXEC_MASK ? shadow_xu_mask : 0);
+	clear = set ^ (shadow_nx_mask | shadow_xs_mask | shadow_xu_mask);
 	return modify_spte_protections(spte, set, clear);
 }
 
@@ -389,7 +397,7 @@ u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled)
 
 	spte |= __pa(child_pt) | shadow_present_mask | PT_WRITABLE_MASK |
 		PT_PRESENT_MASK /* or VMX_EPT_READABLE_MASK */ |
-		shadow_user_mask | shadow_x_mask | shadow_me_value;
+		shadow_user_mask | shadow_xs_mask | shadow_xu_mask | shadow_me_value;
 
 	if (ad_disabled)
 		spte |= SPTE_TDP_AD_DISABLED;
@@ -497,7 +505,8 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits)
 	shadow_accessed_mask	= VMX_EPT_ACCESS_BIT;
 	shadow_dirty_mask	= VMX_EPT_DIRTY_BIT;
 	shadow_nx_mask		= 0ull;
-	shadow_x_mask		= VMX_EPT_EXECUTABLE_MASK;
+	shadow_xs_mask		= VMX_EPT_EXECUTABLE_MASK;
+	shadow_xu_mask		= VMX_EPT_EXECUTABLE_MASK;
 	shadow_present_mask	= VMX_EPT_SUPPRESS_VE_BIT;
 
 	shadow_acc_track_mask	= VMX_EPT_RWX_MASK;
@@ -548,7 +557,8 @@ void kvm_mmu_reset_all_pte_masks(void)
 	shadow_accessed_mask	= PT_ACCESSED_MASK;
 	shadow_dirty_mask	= PT_DIRTY_MASK;
 	shadow_nx_mask		= PT64_NX_MASK;
-	shadow_x_mask		= 0;
+	shadow_xs_mask		= 0;
+	shadow_xu_mask		= 0;
 	shadow_present_mask	= PT_PRESENT_MASK;
 
 	shadow_acc_track_mask	= 0;
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 8a4c09c5cdbf..0ed690f78e17 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -178,8 +178,9 @@ extern bool __read_mostly kvm_ad_enabled;
 extern u64 __read_mostly shadow_host_writable_mask;
 extern u64 __read_mostly shadow_mmu_writable_mask;
 extern u64 __read_mostly shadow_nx_mask;
-extern u64 __read_mostly shadow_x_mask; /* mutual exclusive with nx_mask */
 extern u64 __read_mostly shadow_user_mask;
+extern u64 __read_mostly shadow_xs_mask; /* mutual exclusive with nx_mask and user_mask */
+extern u64 __read_mostly shadow_xu_mask; /* mutual exclusive with nx_mask and user_mask */
 extern u64 __read_mostly shadow_accessed_mask;
 extern u64 __read_mostly shadow_dirty_mask;
 extern u64 __read_mostly shadow_mmio_value;
@@ -357,7 +358,13 @@ static inline bool is_last_spte(u64 pte, int level)
 
 static inline bool is_executable_pte(u64 spte)
 {
-	return (spte & (shadow_x_mask | shadow_nx_mask)) == shadow_x_mask;
+	/*
+	 * For now, return true if either the XS or XU bit is set
+	 * This function is only used for fast_page_fault,
+	 * which never processes shadow EPT, and regular page
+	 * tables always have XS==XU.
+	 */
+	return (spte & (shadow_xs_mask | shadow_xu_mask | shadow_nx_mask)) != shadow_nx_mask;
 }
 
 static inline kvm_pfn_t spte_to_pfn(u64 pte)
-- 
2.52.0


