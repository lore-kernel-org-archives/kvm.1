Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EEF3C277C
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010807; cv=none; b=X0V1PaemkoPerXfVv7Rvd3efDWCGdjSnBnTTfCMEUZ+VgpabGk/+ivwaxVIYLjqjK7bxytrKJyCAucNSlZMIZCaGqRV20puYmCZvWyoDXCEaTrOFwFGmVxPE9bt+lJ2RmPs1IEFEkE+JPtM3k2ZNxLj8yREmo1AzPblscb9ROsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010807; c=relaxed/simple;
	bh=1jWMGgRTEg1opvUDIp59sjNL13y+VIFP0obokyBO4ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFL1JsxkPPtuzE//K/aiTjIR7cBeikczlJ22Bt9xT+UO5yeviSNMYQfAKkK6VoiqjMeG4eszTgrBWe/mC2PfhBy514EVSSI06LUqsgxUUuRpASw/4j/WnY8CnRUaTAzKZvuLiemkcYuE0uARuSCcMopFeYRPPrg5/46JpmJArs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjQDpHUG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgpmqMbh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjQDpHUG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgpmqMbh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sjE0LXmhZZh2Pd32lUWWa6wdiPpKzGMu4qpIIcv7ig=;
	b=AjQDpHUGaVt2MiPC2aR4b3WsR5CsWBWiJal0cRMEJx8Z9U+WzcB/QqTvuLbznCN3x3jWbI
	meAcGgFaJBFq9qwMnYu0FwcWSRDmuLqc01Uzc9yCwPqmj8TQoJeRqyzjzqRKGMkl6BZV17
	udBpUZoPTqfhghyMTON3bZVJJKRhe28=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-Csfan9OIOyWcDuG5AdRI3Q-1; Tue, 05 May 2026 15:53:22 -0400
X-MC-Unique: Csfan9OIOyWcDuG5AdRI3Q-1
X-Mimecast-MFC-AGG-ID: Csfan9OIOyWcDuG5AdRI3Q_1778010800
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-449b2a183d3so125055f8f.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010800; x=1778615600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sjE0LXmhZZh2Pd32lUWWa6wdiPpKzGMu4qpIIcv7ig=;
        b=LgpmqMbhkFuUomuaiOIvHBP5e1BMLSb2fWFj67EaCV9+S5kmG8jTadt7nKgi7gPUOa
         JZ0vYCWTsxfVLALXbsfRH5BZrnWgS4wnwJXbNT9yAhrSRp5aXrY3/tJ3VpzTEAlB4dkY
         4fYb9eF+wu5dHqJzH8Y4aFwRPZ0H5rzvpvUyvvoI6H7MSIJz7urVIDFmlQ3yY1AHwCL8
         v3ykQHGmYlDN3WhxzfJnuFQZw1LvXv9s/1MsyD17i+eJLJSwxDDPFFmMPrUT4ZFGS3Ti
         m0tY8YPCWv/ELZYBRzyVr7JCwa3vyy9e3WIDnaZacFixs9YEnOrrzkm2JziCo5MVHfKP
         yt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010800; x=1778615600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1sjE0LXmhZZh2Pd32lUWWa6wdiPpKzGMu4qpIIcv7ig=;
        b=rosenq4RHaNWeiXQOb5xOHxS3NA5s1os6dc+QHGTpX9D+Ty7/Uhas1jlwpHvI+NrY4
         lXZncjIW4pJ1e4McQnGgxtevtxIifuxQD6pEbZvIoc4Zy9Ovd9e5e5OB49nGsup1ypgv
         /KTFe76WvSTPvx5Cy2POlX7rf9fgd0UcEZS5L4OsOelsRiojdeQlNobH0apc8Ksa6anj
         Mo/bT9d9cTUqT+KwPMU69E3b7WvK9GM413A3JQnlYOK7CTdtS4mSssf4Q5bmWvXsmA0t
         nEBcvi6eqLcRWprAvk3Hj+1/HXuH92t/9rxeto27hhWcxiRvLUrhHQlN2SIn7VCyG33t
         HMXA==
X-Forwarded-Encrypted: i=1; AFNElJ98wXX4YDoHIZxbOFBolkiG0jGwX8Va9HspivWtIu8L7+iybQKQAs/voT5BxCZQevRHums=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvLNsE+LeWD1xfh0wqZ4s6Fdwmd7hRTqAfUU1u53uetRLQ40nX
	EHwHra/X4/Wm97OmcVU1KcqSfg2iw/Oto+z4/87zdYiHZSwoquCJx8rzwrA5R+To6ZRSl67lLzV
	/7XAtlsjiQ2VRb/ki/JuDPSNSddT+/tFraKCT+AuF3lvABNttKyuVyUozHxIqXw==
X-Gm-Gg: AeBDiesqSHUGFXrwgcFaZI7dTAEpF8klyWD1+WizMA8pbgI6ERZ255tdMZSL3/gyqs9
	81dIun/k48+8+H8a8pfF8t5/6MvfcEq48dP6uj4TY2lIGIYbtQMlafrcv9lSba+k6MOOndPAHiR
	KnIsQ0S/MikwGGq1TNy3Qmg7sLSY5mr7r9XJe1i9YivS3i3hcgcKVBN75TmAjnCHWbXfnZ+9kVN
	T79oPXKSGE3OcdwDMCy0xM8VIaoJYZG52QF8qaSNEy6UGZe0IDsNM5M2upjTPAhbIvUR4co2ev8
	4oFdDqwfIBGKGtw3XTsAZFW7RM0MJBu9HMpgvmsKZKnT/C/xG4sFIDrorZxXbDawdKDh9yuMP+N
	JHUsEa3xhtAhJMHqO1CZN1sY3iJbiI6NHFnYTYh/kVtvQLH2xt4g5riSb1+mdISGcIpRHSVCycS
	L82fSHIWqglIi0tS55AqmEhXCpgk7g+e3qYerKY68=
X-Received: by 2002:a5d:648d:0:b0:43f:e571:184d with SMTP id ffacd0b85a97d-44fdfca6e24mr5879566f8f.28.1778010800128;
        Tue, 05 May 2026 12:53:20 -0700 (PDT)
X-Received: by 2002:a5d:648d:0:b0:43f:e571:184d with SMTP id ffacd0b85a97d-44fdfca6e24mr5879548f8f.28.1778010799712;
        Tue, 05 May 2026 12:53:19 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960811sm7094001f8f.27.2026.05.05.12.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 21/28] KVM: x86/mmu: propagate access mask from root pages down
Date: Tue,  5 May 2026 21:52:19 +0200
Message-ID: <20260505195226.563317-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index ededc26c6675..156bab8afbc6 100644
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
2.54.0

