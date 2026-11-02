Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641526;
	b=Pfawkk6eeuL9KCt4VktLffsXWX5CkHNGdJcWj3fgzKCOX3JJQJumo4ypbGKngWYIOwak
	 rEwv7JccswBgGoU+hHAviJnyogwACoVRrOEWtcr2FD5mAKCM1KtlQmHYD1nPk1F+ohzp4
	 oSJwXuZ+uNv0Nqz5R1y4RvprIMGsK7HM03qEfkRttOeboG3wazCl1gNY9TMHmuNteeZTf
	 mAzV+M2AScDdW9qiKrets2O0WTIDUwDFB1Gi7u+tNcBofm2l05Lgusy0DrVOLJ/EYXGE0
	 urT5Fa6pFF11ZWMy0iDndD8tdX1BFp7yHtS19mTeJ10GOsSdRcm1qkSJHcgUh2H5IAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641526;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=Okv7ZwNqESBFQ7vrFPa3g+kc81ghom6FZwMYJy4Kv4k=;
	b=V9ggzOYVCoLm+V+VMTLqD2BxlSZYw9GuuBCK54xwYfnzG49hPJkjXFhM/EJ3F3U3XqiM
	 jd/p1HXXazIue3u9KKPMvhpRQ91+6YA4mBrsdftRRTBq+WvLVMSMo+cu8+Ud85daTnvGW
	 UZwiIW7GelioDCx20Dc/Q5ExDwQyWVOAqIDnQAfEhiCz3usUnfoCOZgHUwBcNOmEnwTeo
	 AINP3hedIuzUvNR1tAh69ncT3V47Oz6nQ+7mVk9uBYBOeQMdrbAWZYBaSDuMx5fBXRX7z
	 gEK3/d8Zs03dXBwpyeHLe/p6bR9m7cdZ34cm0YcDsgEHCQiyWyvesHgmxeRrnPuwCNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AC+8R59A;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B860A380A
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D2B860A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AC+8R59A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Okv7ZwNqESBFQ7vrFPa3g+kc81ghom6FZwMYJy4Kv4k=;
	b=AC+8R59AgbXxzfpqKwfpB0gti7IcZg5bpptR8+5AcCPiVPKtZAQV11qLxhyCEMHclw477f
	LYNzRLD268oKh0eUT0W+8OLplZpMDfBRuLc1bYF4WddJMXs+6Ti/c1ojm1+7WJivA/kOfy
	wuEbbM5nKdwAgthgog4hJe9kd91lwTQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-0YuiUjGCM6GcqSO0S8R9dg-1; Mon,
 02 Nov 2026 12:45:22 -0500
X-MC-Unique: 0YuiUjGCM6GcqSO0S8R9dg-1
X-Mimecast-MFC-AGG-ID: 0YuiUjGCM6GcqSO0S8R9dg_1793641521
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4154F1955F1B;
	Mon,  2 Nov 2026 17:45:21 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3974433;
	Mon,  2 Nov 2026 17:45:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 28/45] KVM: x86/mmu: Take memory protection attributes into account during faults
Date: Mon,  2 Nov 2026 12:44:55 -0500
Message-ID: <20261102174512.8903-12-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

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
Link: https://patch.msgid.link/20260918135030.171564-26-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c          | 49 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/mmu/mmu_internal.h | 19 +++++++++++++
 arch/x86/kvm/mmu/mmutrace.h     | 36 ++++++++++++++++++++++++
 arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
 arch/x86/kvm/mmu/spte.h         | 11 ++------
 5 files changed, 107 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f689e4890e42..787bc31acda3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4701,6 +4701,50 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 	return RET_PF_CONTINUE;
 }
 
+static inline unsigned kvm_get_gfn_protections(struct kvm_vcpu *vcpu, gfn_t gfn)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned int access = vcpu->arch.mmu->root_role.access;
+	unsigned long attrs = kvm_get_vm_memory_attributes(kvm, gfn);
+	if (!attrs)
+		return access;
+
+	WARN_ON_ONCE(!kvm_vm_mem_attributes_valid(kvm, attrs));
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
@@ -4781,6 +4825,11 @@ static int kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
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
index 533ad280accc..a1212104882c 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -995,7 +995,7 @@ static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp, int
 
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


