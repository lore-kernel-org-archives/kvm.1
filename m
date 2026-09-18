Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23474B2CC1
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719375; cv=none; b=pzAHyxfC/9W/2mvUC19xFTuI1HPaKq6GIzzquETLudSkoS7TjWmdvfmxIq1Y9Dy/RERhq2qiRepQtNRmUCqaBTq1H8OFMTejtWK+Dfi7C902sn8XnYxU9EhMX1RkOg/mFvIivRaCxV5vqyKPaMis+Wo+2yRCNgM0Opm9fPs2qDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719375; c=relaxed/simple;
	bh=I5ibwMtY9EbomTpjerkx/2uNla7H7oHQYY11dx8+HWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spWu6ro0btntt4XVZmAg0oefogse1pHZLHUv6P1jeXB3JM2ytUuGhjuRKi445qfSOPmnoRDUWampEHkbg3DExYOMWbEsrpC00CHgTiSD1phwYx2SYsog/jmf6DXi/HS5gJib8eB5vL958KUvNvH8bzAIzvvqaPZFZtojvWKKYcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHyF429c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHyF429c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jP3CCCr3me+qhU/3Ko3iK48MQgZC82F2uaDjJuPoHc4=;
	b=WHyF429cfGmjSRJEiopdUU78XSkBn08LvgP3TDsI0fsfn21jU8cKRo6l/IviltiEAE9xAL
	BjKGmdehvkbZBED75AJC/S4Cey9Zq0ViuatEYGCmc77E3CIMu4xVvNNOwcgTItcuitUogV
	K8NQtd+hFeD9U3S0zRxzy3U/LYBFMCU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-CqLKpG1ENVCLudAaimEyZg-1; Fri,
 18 Sep 2026 04:16:04 -0400
X-MC-Unique: CqLKpG1ENVCLudAaimEyZg-1
X-Mimecast-MFC-AGG-ID: CqLKpG1ENVCLudAaimEyZg_1789719363
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 146521977514;
	Fri, 18 Sep 2026 08:16:03 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A5F830001A2;
	Fri, 18 Sep 2026 08:16:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 21/28] KVM: x86/mmu: Take memory protection attributes into account during faults
Date: Fri, 18 Sep 2026 04:15:36 -0400
Message-ID: <20260918081543.139871-22-pbonzini@redhat.com>
In-Reply-To: <20260918081543.139871-1-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Take memory protection attributes when faulting guest memory.  Prohibited
memory accesses will cause a user-space -EFAULT exit just like private
memory accesses.  Userspace will either enable the access or bump it to
the guest as some kind of exception (e.g. a VTL return).

Since the struct kvm_page_fault already has the access type in PFERR_*
format, the check is done via the kvm_page_format permissions table.
This means that it supports naturally all page table format variants,
and it can even handle mode-based memory protection when the host
uses MBEC/GMET.  The only thing that needs some care is to build the
restricted ACC_* mask with the root page's own access mask as a base
(and not ACC_ALL).  Otherwise, supervisor mode execution would be
handled incorrectly on AMD processors with GMET.

To avoid spamming the trace buffer too much, the new trace event only
kicks in if memory protection attributes are present for the faulted gfn.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c          | 49 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/mmu/mmu_internal.h | 19 +++++++++++++
 arch/x86/kvm/mmu/mmutrace.h     | 36 ++++++++++++++++++++++++
 arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
 arch/x86/kvm/mmu/spte.h         | 11 ++------
 5 files changed, 107 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 797b18201d98..3fd4cc3c57a5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4642,6 +4642,50 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 	return RET_PF_CONTINUE;
 }
 
+static inline unsigned kvm_get_gfn_protections(struct kvm_vcpu *vcpu, gfn_t gfn)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned int access = vcpu->arch.mmu->root_role.access;
+	unsigned long attrs = kvm_get_memory_attributes(kvm, gfn);
+	if (!attrs)
+		return access;
+
+	WARN_ON_ONCE(!kvm_mem_attributes_valid(kvm, attrs));
+
+	if (!kvm_mem_attributes_may_read(attrs))
+		access &= ~ACC_READ_MASK;
+	if (!kvm_mem_attributes_may_write(attrs))
+		access &= ~ACC_WRITE_MASK;
+	if (!kvm_mem_attributes_may_exec(attrs)) {
+		access &= ~ACC_EXEC_MASK;
+		if (shadow_xu_mask)
+			access &= ~ACC_USER_EXEC_MASK;
+	}
+
+	return access;
+}
+
+static int kvm_faultin_memory_protections(struct kvm_vcpu *vcpu,
+					  struct kvm_page_fault *fault)
+{
+	unsigned access;
+
+	/* Memory attributes don't apply to MMIO regions */
+	if (unlikely(!fault->slot))
+		return RET_PF_CONTINUE;
+
+	access = kvm_get_gfn_protections(vcpu, fault->gfn);
+	if (access == ACC_ALL)
+		return RET_PF_CONTINUE;
+
+	trace_kvm_faultin_memory_protections(vcpu, fault, access);
+	if (__permission_fault(vcpu->arch.mmu, access, fault))
+		return -EFAULT;
+
+	fault->host_access &= access;
+	return RET_PF_CONTINUE;
+}
+
 static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 				 struct kvm_page_fault *fault)
 {
@@ -4722,6 +4766,11 @@ static int kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 	if (unlikely(!slot))
 		return kvm_handle_noslot_fault(vcpu, fault, access);
 
+	if (kvm_faultin_memory_protections(vcpu, fault)) {
+		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
+		return -EFAULT;
+	}
+
 	/*
 	 * Retry the page fault if the gfn hit a memslot that is being deleted
 	 * or moved.  This ensures any existing SPTEs for the old memslot will
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 00215b9f309f..0bad60c5aab6 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -290,6 +290,25 @@ struct kvm_page_fault {
 	bool write_fault_to_shadow_pgtable;
 };
 
+/*
+ * Returns true if the access indicated by @fault is forbidden by the existing
+ * SPTE protections.
+ */
+static inline bool __permission_fault(struct kvm_mmu *mmu, unsigned access,
+				      struct kvm_page_fault *fault)
+{
+	unsigned pfec;
+
+	/*
+	 * RSVD is handled elsewhere, and is used for SMAP in the context
+	 * of accessing fmt.permissions[].  SPTEs never use PK or SS, as
+	 * they are not supported for shadow paging and irrelevant for TDP.
+	 */
+	pfec = fault->error_code & (
+		PFERR_WRITE_MASK | PFERR_USER_MASK | PFERR_FETCH_MASK);
+	return (mmu->fmt.permissions[pfec >> 1] >> access) & 1;
+}
+
 /*
  * Return values of handle_mmio_page_fault(), mmu.page_fault(), fast_page_fault(),
  * and of course kvm_mmu_do_page_fault().
diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index 8354d9f39777..744f111644cb 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -8,6 +8,13 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvmmmu
 
+#ifdef CREATE_TRACE_POINTS
+#define tracing_kvm_rip_read(vcpu) ({					\
+	typeof(vcpu) __vcpu = vcpu;					\
+	__vcpu->arch.guest_state_protected ? 0 : kvm_rip_read(__vcpu);	\
+	})
+#endif
+
 #define KVM_MMU_PAGE_FIELDS		\
 	__field(__u8, mmu_valid_gen)	\
 	__field(__u64, gfn)		\
@@ -447,6 +454,35 @@ TRACE_EVENT(
 		  __entry->gfn, __entry->spte, __entry->level, __entry->errno)
 );
 
+TRACE_EVENT(kvm_faultin_memory_protections,
+	TP_PROTO(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
+		 unsigned access),
+	TP_ARGS(vcpu, fault, access),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, vcpu_id)
+		__field(unsigned long, guest_rip)
+		__field(u64, fault_address)
+		__field(bool, write)
+		__field(bool, exec)
+		__field(unsigned, access)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id = vcpu->vcpu_id;
+		__entry->guest_rip = tracing_kvm_rip_read(vcpu);
+		__entry->fault_address = fault->gfn;
+		__entry->write = fault->write;
+		__entry->exec = fault->exec;
+		__entry->access = access;
+	),
+
+	TP_printk("vcpu %d rip 0x%lx gfn 0x%016llx access %s protections 0x%x",
+		  __entry->vcpu_id, __entry->guest_rip, __entry->fault_address,
+		  __entry->exec ? "X" : (__entry->write ? "W" : "R"),
+		  __entry->access)
+);
+
 #endif /* _TRACE_KVMMMU_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index e6ec14165f40..b031123fcb36 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -992,7 +992,7 @@ static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp, int
 
 	sptep = &sp->spt[i];
 	spte = *sptep;
-	host_access = ACC_ALL;
+	host_access = kvm_get_gfn_protections(vcpu, gfn);
 	if (!(spte & shadow_host_writable_mask))
 		host_access &= ~ACC_WRITE_MASK;
 	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 589f3954633e..14f322944671 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -491,7 +491,7 @@ static inline bool is_mmu_writable_spte(u64 spte)
 static inline bool spte_permission_fault(struct kvm_mmu *mmu, u64 spte,
 					 struct kvm_page_fault *fault)
 {
-	unsigned pfec, pte_access;
+	unsigned pte_access;
 
 	if (!is_shadow_present_pte(spte))
 		return true;
@@ -511,14 +511,7 @@ static inline bool spte_permission_fault(struct kvm_mmu *mmu, u64 spte,
 		pte_access |= spte & shadow_xu_mask ? ACC_USER_EXEC_MASK : 0;
 	}
 
-	/*
-	 * RSVD is handled elsewhere, and is used for SMAP in the context
-	 * of accessing fmt.permissions[].  SPTEs never use PK or SS, as
-	 * they are not supported for shadow paging and irrelevant for TDP.
-	 */
-	pfec = fault->error_code & (
-		PFERR_WRITE_MASK | PFERR_USER_MASK | PFERR_FETCH_MASK);
-	return (mmu->fmt.permissions[pfec >> 1] >> pte_access) & 1;
+	return __permission_fault(mmu, pte_access, fault);
 }
 
 /*
-- 
2.52.0


