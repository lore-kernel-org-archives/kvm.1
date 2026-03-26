Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6D6428830
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549101; cv=none; b=MrgAaEWUmrI0HCfJfEggKkZenl+uBjXZqgi7XCoqfCf1d5KR3pfNIp8l6B68XNp11wRae+JF07G260qNATtTcc6imT1fER9qSr7MvQe61+8GB89PD3oz8OCaiHT3c+MYBftQFiZ18uF7xXro7YRG3HzNJF8bfmKNX30j2gPEMaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549101; c=relaxed/simple;
	bh=6k32YUNUSwEOl5Wx728jUQLxcFj6v2Ju0u6Kg3rAbFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbfNPPkyaoGkdR6LHZOeF70arRKwbekGuNKrF9MSH4s68qYUH+ifr0hL9ckIgkUseGz5hOh8X/n46waabGVU9idnp4EbARl6b0Y/NsR0ral86b8Osi/lZvlrMV/JbDp9DaU3kmhD9gDqphSSfsSEXWLltLcjutEyZPFCnOhnPlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PaoMqwCJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWFB3qOQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaoMqwCJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWFB3qOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuJVFKLmxdWFj1feiyagFVXOI8YBNvyO4c8mQRfVXAg=;
	b=PaoMqwCJmnMWp18dITSr5WPwB8FLcOJfFJniHsVmCQ1No34Yi/nJQXWA+qJ458nhRPj2Wr
	i5UKUjA2DN+PpMfjVQ+LVvnW+lVojyEGWySVXFeo8NWHKJY3mi+tOGw78tKCIp9hWOIVET
	GIAeTr9DNB+6Y/6QN7KGI41EELCYv1A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-1W9Yn5_yMUKseYlYV0cLFA-1; Thu, 26 Mar 2026 14:18:16 -0400
X-MC-Unique: 1W9Yn5_yMUKseYlYV0cLFA-1
X-Mimecast-MFC-AGG-ID: 1W9Yn5_yMUKseYlYV0cLFA_1774549095
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48542d5aa9eso10158975e9.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549094; x=1775153894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuJVFKLmxdWFj1feiyagFVXOI8YBNvyO4c8mQRfVXAg=;
        b=gWFB3qOQdlD3XPErqU0Hzg4XlEe+WfmG9bcD5GgYZgdPVwYEFJN2Q2I+OsD1KUBbuk
         JXui+Ez535OCd4/oge69N0bkcq//SDszPf2xtoFXqPtkFC1QYvKjZjWE2IUyYJrqtag2
         f8/Q13pXBZrc5gbZiPuBdFabBSVNR620l6GP3iRViGQBOoppY6D3F7EallxaSI3y5BMz
         jUTD3i3QWSUn8qQPvFJwDVwWQa2kihwGApCr8hz4OBpO/+6y/PIPJljC7IphJ2RhzsTZ
         xktdIG4faw6fnxjPsBafuVm+fPEoTZz5Y+y5aQiuUZopV1JL2q3W+TMwT6nfH80ukHnj
         YadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549094; x=1775153894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TuJVFKLmxdWFj1feiyagFVXOI8YBNvyO4c8mQRfVXAg=;
        b=PKqw1mXIPpoUfyOYsNuiaMcMxpG4NzYyxDS6FLcmVHlpXg5gPXnKsMB9wraahiwjJm
         2QOrmi1mtrb5UQrUIGRf0uBNRhIgIY1SxTXdPkH7iuC/jS21nCFJ39cRGVSLOfHy0LHY
         3aFB5qv6XNnj45yCq7LPW2mlERgTynbCiUROYRAmHVm/Br7eh7E16AHeIeWbxXuTdook
         GPMN5nWBYdYZOBjYDWtjC3QNHU2byj7NZgqW84o4Y9h0Qoknz0L4GtQlnu4+FYUPwnwT
         p3b+Oyav8MkmDavPG88KEKTUyIfAP8Qpr5en8XTdxE6YbeyIH9Y9n+8VbrPz1u/6USRH
         n+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgwNP0LEKvsfLF8jIQf3MdX7wS9MsoXjC/BPJ78zE5++XnXcwrWmYkp1HDBDq8txuVAEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiYNMfb7cIjjhlmFYiR+saR7e1JHqDmlETgzBxUDKw3gU2mXWS
	aVYEp8YiuB3q4Lf8y/LbjfD/P5pZPJ5/kHBMLUpLRQuUq5x/jh7jsUAHT7SVZXNvIUqKAwVqy04
	x9DEJ+51+IO7jgdL7JeV70Cg4+yX1O1O57q54x04I10r+6eFl41ldMgk+KJx6IQ==
X-Gm-Gg: ATEYQzwpRxFuE3xT2uCGVPNAX5VyfaweobWjM1h66WeFiihA/VwyL1E9eFpXfnJwvzm
	698voppwOrKbK8c2A0ANjTMt5mKkTCO4JVVo2+X7ScbTRVrTyZy08Y5FYjmXQ0dIoAi+m41NHAU
	dYJIfFOigfUMvrGvrAGaWsK99qL09uc3FiGlBVOGG5DvuJsoUT6Nx06UCSbRu5FaNfP0EUR40hE
	Fe3vxG7KDchoSGDQC7Hj/Sha30uxzEm1RpdOid0Dt5hPCyhjlqg5hDATR9H9SutpMieEcCy5R2X
	8Qe0Zz5p0wefgtLR6ypWPvWyqQpFdhnalHQFqHhSwS6JA5D8jXodzGb+/Cez4TgC/Y+2fUZTG7t
	aqTAPuPYk3Z3D4zPU5+R30uJy2AZixVmNmZc1G8Aq5sC5Q1wWlWZ+17wJ7jzjy/DXD+V7VAthGN
	7WSOEwwpoCHsGJLvjuZvOyK8dq
X-Received: by 2002:a05:600c:4705:b0:486:fc4a:2951 with SMTP id 5b1f17b1804b1-48716083231mr135600765e9.28.1774549094280;
        Thu, 26 Mar 2026 11:18:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4705:b0:486:fc4a:2951 with SMTP id 5b1f17b1804b1-48716083231mr135600185e9.28.1774549093815;
        Thu, 26 Mar 2026 11:18:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c6b495sm102046575e9.2.2026.03.26.11.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:18:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 18/24] KVM: x86/mmu: propagate access mask from root pages down
Date: Thu, 26 Mar 2026 19:17:16 +0100
Message-ID: <20260326181723.218115-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c         |  9 +++++----
 arch/x86/kvm/mmu/mmutrace.h    | 10 ++++++----
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c     |  6 +++---
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 442cbaeaf547..834ba9c0c809 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3434,12 +3434,13 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
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
@@ -3452,7 +3453,7 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		if (it.level == fault->goal_level)
 			break;
 
-		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, ACC_ALL);
+		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, access);
 		if (sp == ERR_PTR(-EEXIST))
 			continue;
 
@@ -3465,7 +3466,7 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
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
index 95aa1b4fc327..31331fe10723 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -731,7 +731,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
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
2.53.0

