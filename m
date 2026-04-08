Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D03D8136
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662971; cv=none; b=TYbN1gP/K+dJnKR5A5pTlx9JYn39gv0d/Ial+Vyq4An1aC/36/jxI4Xv5ovlglBoHc+wMIM+Ng1gk52xSFBwa3QdmAJMXnYm+UIKveKjSynTjxeO0mY6my1cLtF1r+m8vHr2q3mHWAPqsBXwAA8kdbcvyDwWxcmc4KxfKMtu1U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662971; c=relaxed/simple;
	bh=JVCAcwJQQN4bQ6fP3Y2WluN95G+sotLsTGjHahOAE7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpU/2X/ld7Bp/ZheIz7u8wCSG0/HqakNeyltsPR2UJysjXKk1UkpmmOead6T/C7EDmDl81Xfcv/bEgAluaV+gwIBlvIVrozEesQCKxRrlFJK081qNssWk9b6ow+DxsHI4VdoFzTHG/nAi0QrS6v23GAQz3hPyIl6fjlC5nE9KVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TswygY72; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TswygY72"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HfZFcQZChj41h3Tp2pq4sA5RxV8tgAmfI8S3vj9zYk=;
	b=TswygY72QUqJce5/YoOwk3xBWFHRr3beCOgGMudQczLbDdO/7zNn0uXJFHlN7mAv93Dilv
	aIQ//l0xgXvOJBdFg7AOqR0ZsBS4m1i4+uDoEHWtcXRUmpU3ZmMQ2KvhqaIhDSynUfKGjm
	Ee8OAHIDaXszb4FG+FO3nkmvoPQ1qp0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-d7F4wT2wN3OFgiPZ0sKNfQ-1; Wed,
 08 Apr 2026 11:42:43 -0400
X-MC-Unique: d7F4wT2wN3OFgiPZ0sKNfQ-1
X-Mimecast-MFC-AGG-ID: d7F4wT2wN3OFgiPZ0sKNfQ_1775662960
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C078D18002D7;
	Wed,  8 Apr 2026 15:42:40 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA74A300019F;
	Wed,  8 Apr 2026 15:42:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 21/27] KVM: x86/mmu: propagate access mask from root pages down
Date: Wed,  8 Apr 2026 11:42:11 -0400
Message-ID: <20260408154217.458420-22-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Until now, all SPTEs have had all kinds of access allowed; however,
for GMET to be enabled all the pages have to have ACC_USER_MASK
disabled.  By marking them as supervisor pages, the processor
allows execution from either user or supervisor mode (unlike
for normal paging, NPT ignores the U bit for reads and writes).
That will mean that the root page's role has ACC_USER_MASK
cleared and that has to be propagated down through the kvm_mmu_page
tree.

Do that, and pass the required access to the
kvm_mmu_spte_requested tracepoint since it's not ACC_ALL
anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c         |  9 +++++----
 arch/x86/kvm/mmu/mmutrace.h    | 10 ++++++----
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c     |  6 +++---
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3ecc571a1de0..4374784f1154 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3437,12 +3437,13 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_shadow_walk_iterator it;
 	struct kvm_mmu_page *sp;
-	int ret;
+	int ret, access;
 	gfn_t base_gfn = fault->gfn;
 
 	kvm_mmu_hugepage_adjust(vcpu, fault);
 
-	trace_kvm_mmu_spte_requested(fault);
+	access = vcpu->arch.mmu->root_role.access;
+	trace_kvm_mmu_spte_requested(fault, access);
 	for_each_shadow_entry(vcpu, fault->addr, it) {
 		/*
 		 * We cannot overwrite existing page tables with an NX
@@ -3455,7 +3456,7 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		if (it.level == fault->goal_level)
 			break;
 
-		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, ACC_ALL);
+		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, access);
 		if (sp == ERR_PTR(-EEXIST))
 			continue;
 
@@ -3468,7 +3469,7 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	if (WARN_ON_ONCE(it.level != fault->goal_level))
 		return -EFAULT;
 
-	ret = mmu_set_spte(vcpu, fault->slot, it.sptep, ACC_ALL,
+	ret = mmu_set_spte(vcpu, fault->slot, it.sptep, access,
 			   base_gfn, fault->pfn, fault);
 	if (ret == RET_PF_SPURIOUS)
 		return ret;
diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index 3429c1413f42..fa01719baf8d 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -373,23 +373,25 @@ TRACE_EVENT(
 
 TRACE_EVENT(
 	kvm_mmu_spte_requested,
-	TP_PROTO(struct kvm_page_fault *fault),
-	TP_ARGS(fault),
+	TP_PROTO(struct kvm_page_fault *fault, u8 access),
+	TP_ARGS(fault, access),
 
 	TP_STRUCT__entry(
 		__field(u64, gfn)
 		__field(u64, pfn)
 		__field(u8, level)
+		__field(u8, access)
 	),
 
 	TP_fast_assign(
 		__entry->gfn = fault->gfn;
 		__entry->pfn = fault->pfn | (fault->gfn & (KVM_PAGES_PER_HPAGE(fault->goal_level) - 1));
 		__entry->level = fault->goal_level;
+		__entry->access = access;
 	),
 
-	TP_printk("gfn %llx pfn %llx level %d",
-		  __entry->gfn, __entry->pfn, __entry->level
+	TP_printk("gfn %llx pfn %llx level %d access %x",
+		  __entry->gfn, __entry->pfn, __entry->level, __entry->access
 	)
 );
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 7d7c617885fa..9ad2b05a0f44 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -734,7 +734,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	 */
 	kvm_mmu_hugepage_adjust(vcpu, fault);
 
-	trace_kvm_mmu_spte_requested(fault);
+	trace_kvm_mmu_spte_requested(fault, gw->pte_access);
 
 	for (; shadow_walk_okay(&it); shadow_walk_next(&it)) {
 		/*
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 9c26038f6b77..25e557de99d6 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1185,9 +1185,9 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 	}
 
 	if (unlikely(!fault->slot))
-		new_spte = make_mmio_spte(vcpu, iter->gfn, ACC_ALL);
+		new_spte = make_mmio_spte(vcpu, iter->gfn, sp->role.access);
 	else
-		wrprot = make_spte(vcpu, sp, fault->slot, ACC_ALL, iter->gfn,
+		wrprot = make_spte(vcpu, sp, fault->slot, sp->role.access, iter->gfn,
 				   fault->pfn, iter->old_spte, fault->prefetch,
 				   false, fault->map_writable, &new_spte);
 
@@ -1272,7 +1272,7 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 
 	kvm_mmu_hugepage_adjust(vcpu, fault);
 
-	trace_kvm_mmu_spte_requested(fault);
+	trace_kvm_mmu_spte_requested(fault, root->role.access);
 
 	rcu_read_lock();
 
-- 
2.52.0


