Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E3942EED6
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561694; cv=none; b=uM/Jnk+M079lnGYxdV4q8orQPidUyd2nGWl0OhcMiku4eU00YGNR/NuxccWoH8G7K8GdHeZLp0Pd7LHJ9X2SQ94Aet8wufMYbBckb51SnkhI3hpAm1rb7Tg864K0xFNiMVaiX0TJ/fHRNfYhl/FCHHevn9ooqgXRnPtE3Xe9G4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561694; c=relaxed/simple;
	bh=POoeonNKM+9smTwZUSI9eZc9XummIWOu9dGydt9Q9Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAjlvtSxKfibEmpF8RX/NHq8CPqa/u0rFiL2Uo+sXCmOexi/wYqMJqNMoJ/UtJPhvCK6CIfYpudHp7L0nuIXoUQdu5C0D5oXsHUU9KYTT1GYn6gBTiHJZzavb1Dj4pN44WL9TgyEvnmGP4Z0TrVqV2nUvyULX28vufsSn1rt2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ep7Omx7e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ep7Omx7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pi6Mxveh+nSgltzKstw/k+E1UcHUk+4daKGVjEoWrG8=;
	b=ep7Omx7efqEhojiQa6qbJhtDTl5RLTm8E/dI77555WbuwOoMUJeu1ho+RvU87FZyBzkewQ
	YRUEXTS8zT6J0FX54CzaXqv0hUmiJlUfw5HphSglaNOQI8sSmviSCgY8A84kd7AhujngUn
	aKdNTMhjBwEolpM6OZVVwq5fO4hqywU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-hbhtxzKANxG1R2RDN2UWow-1; Thu,
 30 Apr 2026 11:08:07 -0400
X-MC-Unique: hbhtxzKANxG1R2RDN2UWow-1
X-Mimecast-MFC-AGG-ID: hbhtxzKANxG1R2RDN2UWow_1777561686
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4856719560BD;
	Thu, 30 Apr 2026 15:08:06 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B53AB180045E;
	Thu, 30 Apr 2026 15:08:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 21/28] KVM: x86/mmu: propagate access mask from root pages down
Date: Thu, 30 Apr 2026 11:07:40 -0400
Message-ID: <20260430150747.76749-22-pbonzini@redhat.com>
In-Reply-To: <20260430150747.76749-1-pbonzini@redhat.com>
References: <20260430150747.76749-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c         |  9 +++++----
 arch/x86/kvm/mmu/mmutrace.h    | 10 ++++++----
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c     |  6 +++---
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 27776d0b2ad9..5836ff595e32 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3446,12 +3446,13 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
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
@@ -3464,7 +3465,7 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		if (it.level == fault->goal_level)
 			break;
 
-		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, ACC_ALL);
+		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, access);
 		if (sp == ERR_PTR(-EEXIST))
 			continue;
 
@@ -3477,7 +3478,7 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
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
index f741f7d4cc2d..047400af924d 100644
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
index 7b1102d26f9c..5a2f8ce9a32b 100644
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


