Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95206257824
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964345; cv=none; b=Gi0MyzrAmUmapHoHI9ITR4QM1WUzXNmcKBX9Yp4l/tqIuGIsL/ikJ/yx2XXKoRvUfKKHNtLuqav5lLjyNN0W2BywWXQ/p+a/UWlFemR9CIs7g//VH0RfAASTxXWVgL/O+zC1uE4nmNbpg3wO9fnuK131g1B5ce9LqR18Or66jFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964345; c=relaxed/simple;
	bh=XWPfFYfLhTLa5UB2Be1O7e4jiG88hQHB1AvjGlRbkLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bjy8uQXJqFvyGh/taSwDcUpNNKdyhufBxPYBqq7MlIk97r78YBK6e7v3evP8FSfMP41EugPPaIl71lsJrM7y1vudUHSLtkoFU7GboCMZIj7w8ed3CxvobqoMlA45KlemxYXjIqKfjb7now9D8fIeQB9k3kxDhNOVigXYhLTabb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acmq5Rfy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbB8mqiQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acmq5Rfy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbB8mqiQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777964342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dzf0pfUjAeoFIT+o1UyKLxzb+hMySmis8LYkbCCF47M=;
	b=acmq5RfyK92IzIjDoNiI/rxjxi5TKeFMgJzFrUIR3mS/V4CEKFCpfeHCOr/fAAkgrXPHgx
	zy2HhUp6YYLMflX5CQTHhEuyVFHhxnPTxzdXcPwFCBBVDrGMYQnzQDUNOzwlCzUemQHifV
	kKHQcqNLM1m63PwnUyqQerss9VkuEWg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-7Gf8XRyJOTOoaSLaUFzx4w-1; Tue, 05 May 2026 02:59:01 -0400
X-MC-Unique: 7Gf8XRyJOTOoaSLaUFzx4w-1
X-Mimecast-MFC-AGG-ID: 7Gf8XRyJOTOoaSLaUFzx4w_1777964340
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a548b585cso30566035e9.2
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 23:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777964340; x=1778569140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dzf0pfUjAeoFIT+o1UyKLxzb+hMySmis8LYkbCCF47M=;
        b=ZbB8mqiQ8iJxv6fkf8ZQZj0dljC1X5iYZeWVjFN1FqjPsEZEucprUyh3YV1eq9D8H3
         7c/PesDVkgmvYCJDAdcM1qmpQeTKuiOqXvHL8cewOK8UZLazXCfZzUP0RtVKWOzg98zZ
         WCJ+SKI8/9y/XuehL4nqi72mAen0cm6WmYe3Jw8+pjfPfe94+K8pjXKU9T5d/pubGuaI
         lMA4PQkedgR4Qb65Fip5Pb7QHblsBZ2LRRcdg/XC4hTdiiD1PtbX+47D54YTVEXmKbil
         TXMX/dcAWhVlL0wLRiBYli8ne1+4w5UTpcKjNDOqRm7U54BHOKtA5r6tY05hqfQmaDpk
         ZCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964340; x=1778569140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dzf0pfUjAeoFIT+o1UyKLxzb+hMySmis8LYkbCCF47M=;
        b=SfDUFG7F7mTWSGI+nQXRIDdIkz/346Zvg53tpz69jPxAxpmFTrXQ9Q/9BqSuCjlwiF
         CKrxF269CuTUjE9f6ruU6O8XgzjGWILrZ9Wu9uWI1amxKYgCf5+Rtyiq2w9qnEFoz8r7
         s4pVPbZiEdegx1dVqIQsS7vpxlDpXWvtftERa1AR/Ix3nmH6kDUXRuLJ/zkHdQL74NmD
         IonmLQH5nTiRC0aPbf7kiZy7WJmiiegFna7Gfo8XJm+wfIMCzRCW/2YnKArUbWrWB4sg
         /+SPJJrh9OBRr64a73UTZyYE9bCTh94p07qQfhqbaUhD4SFDjov+q6p70jCCoWa4mPld
         xdgg==
X-Forwarded-Encrypted: i=1; AFNElJ/2By44dtMYq+ox4BpsQ7RhT+prXhus2iEN1Jnd8TT+1jaGCQsAxKOMuuZOZjAs3qCffQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSvJYcktfvvRyAle67zDCId/DZyqsGbtuE9FknjvfLcLcaOM0x
	/NrPbDxAHcwjmPqhE8L0udxRSlEdXmh/kW8hr/ODLjgsdMP/fCEpoVnqCCgZE2G58n5+WvJMs+E
	51H1FsMJumlSRTzvHj/lA9W5PbO2grn3ki6Wr/Ri09cyWD+tk9AKesA==
X-Gm-Gg: AeBDiesc4pAks4o2ouJNrkvSvjmIAtjYtniCZQFg+F/1+uHeYEnpGUQNDn0cQ2PfZBn
	Ny2shcwIcRSX42/azO2fXjQEpRhQNrp6iMMuiYVQd0uFYo17ttYKB/M4Vr+WelMTRZBe/fNWD2Z
	4gt/wQ8/tVGwkSPaukBaGstyvnKaBlf+aADQfubRDvkI0jcIG1gRFsC0u2zEwgUk/9HXEmzkpHp
	d10SMnSEqVMny+9pfoO87G/QTdGklSXWMEc52axs8AkNhKZDn0PBulsAOKW/w2Dh4WNADAd97mO
	Ly02Kx8Wco5W2qO9H7FTews962JLfYc4O0HbITCY7w9WMoZEbVHA/VNXK+wtA8MZAvuU5Dt4jJo
	qaYSvEpplwajp98vW5xW1KtjW6fWD79HpK7K+0t7AT7Nnswsx4cm7F8jHcWLG140E0glbFHejJM
	zDcMRErVRgouC1NwzjB0F612rncpea7FqAbqjz2TQ=
X-Received: by 2002:a05:600c:1386:b0:488:9439:881a with SMTP id 5b1f17b1804b1-48a9852f471mr202492675e9.2.1777964340149;
        Mon, 04 May 2026 23:59:00 -0700 (PDT)
X-Received: by 2002:a05:600c:1386:b0:488:9439:881a with SMTP id 5b1f17b1804b1-48a9852f471mr202492365e9.2.1777964339720;
        Mon, 04 May 2026 23:58:59 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48af0d5a613sm130595745e9.2.2026.05.04.23.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 23:58:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH 6.18.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Tue,  5 May 2026 08:58:57 +0200
Message-ID: <20260505065857.190809-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit 0cb2af2ea66ad8ff195c156ea690f11216285bdf upstream.

The shadow MMU computes GFNs for direct shadow pages using sp->gfn plus
the SPTE index. This assumption breaks for shadow paging if the guest
page tables are modified between VM entries (similar to commit
aad885e77496, "KVM: x86/mmu: Drop/zap existing present SPTE even
when creating an MMIO SPTE", 2026-03-27).  The flow is as follows:

- a PDE is installed for a 2MB mapping, and a page in that area is
  accessed.  KVM creates a kvm_mmu_page consisting of 512 4KB pages;
  the kvm_mmu_page is marked by FNAME(fetch) as direct-mapped because
  the guest's mapping is a huge page (and thus contiguous).

- the PDE mapping is changed from outside the guest.

- the guest accesses another page in the same 2MB area.  KVM installs
  a new leaf SPTE and rmap entry; the SPTE uses the "correct" GFN
  (i.e. based on the new mapping, as changed in the previous step) but
  that GFN is outside of the [sp->gfn, sp->gfn + 511] range; therefore
  the rmap entry cannot be found and removed when the kvm_mmu_page
  is zapped.

- the memslot that covers the first 2MB mapping is deleted, and the
  kvm_mmu_page for the now-invalid GPA is zapped.  However, rmap_remove()
  only looks at the [sp->gfn, sp->gfn + 511] range established in step 1,
  and fails to find the rmap entry that was recorded by step 3.

- any operation that causes an rmap walk for the same page accessed
  by step 3 then walks a stale rmap and dereferences a freed kvm_mmu_page.
  This includes dirty logging or MMU notifier invalidations (e.g., from
  MADV_DONTNEED).

The underlying issue is that KVM's walking of shadow PTEs assumes that
if a SPTE is present when KVM wants to install a non-leaf SPTE, then the
existing kvm_mmu_page must be for the correct gfn.  Because the only way
for the gfn to be wrong is if KVM messed up and failed to zap a SPTE...
which shouldn't happen, but *actually* only happens in response to a
guest write.

That bug dates back literally forever, as even the first version of KVM
assumes that the GFN matches and walks into the "wrong" shadow page.
However, that was only an imprecision until 2032a93d66fa ("KVM: MMU:
Don't allocate gfns page for direct mmu pages") came along.

Fix it by checking for a target gfn mismatch and zapping the existing
SPTE.  That way the old SP and rmap entries are gone, KVM installs
the rmap in the right location, and everyone is happy.

Fixes: 2032a93d66fa ("KVM: MMU: Don't allocate gfns page for direct mmu pages")
Fixes: 6aa8b732ca01 ("kvm: userspace interface")
Reported-by: Alexander Bulekov <bkov@amazon.com>
Reported-by: Fred Griffoul <fgriffo@amazon.co.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Link: https://patch.msgid.link/20260503201029.106481-1-pbonzini@redhat.com/
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index dad7abb1112b..0bd0cb8992c9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -182,6 +182,8 @@ static struct kmem_cache *pte_list_desc_cache;
 struct kmem_cache *mmu_page_header_cache;
 
 static void mmu_spte_set(u64 *sptep, u64 spte);
+static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
+			    u64 *spte, struct list_head *invalid_list);
 
 struct kvm_mmu_role_regs {
 	const unsigned long cr0;
@@ -1287,19 +1289,6 @@ static void drop_spte(struct kvm *kvm, u64 *sptep)
 		rmap_remove(kvm, sptep);
 }
 
-static void drop_large_spte(struct kvm *kvm, u64 *sptep, bool flush)
-{
-	struct kvm_mmu_page *sp;
-
-	sp = sptep_to_sp(sptep);
-	WARN_ON_ONCE(sp->role.level == PG_LEVEL_4K);
-
-	drop_spte(kvm, sptep);
-
-	if (flush)
-		kvm_flush_remote_tlbs_sptep(kvm, sptep);
-}
-
 /*
  * Write-protect on the specified @sptep, @pt_protect indicates whether
  * spte write-protection is caused by protecting shadow page table.
@@ -2466,7 +2455,8 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role;
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
+	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
 		return ERR_PTR(-EEXIST);
 
 	role = kvm_mmu_child_role(sptep, direct, access);
@@ -2544,13 +2534,16 @@ static void __link_shadow_page(struct kvm *kvm,
 
 	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK != PT_WRITABLE_MASK);
 
-	/*
-	 * If an SPTE is present already, it must be a leaf and therefore
-	 * a large one.  Drop it, and flush the TLB if needed, before
-	 * installing sp.
-	 */
-	if (is_shadow_present_pte(*sptep))
-		drop_large_spte(kvm, sptep, flush);
+	if (is_shadow_present_pte(*sptep)) {
+		struct kvm_mmu_page *parent_sp;
+		LIST_HEAD(invalid_list);
+
+		parent_sp = sptep_to_sp(sptep);
+		WARN_ON_ONCE(parent_sp->role.level == PG_LEVEL_4K);
+
+		mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list);
+		kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, true);
+	}
 
 	spte = make_nonleaf_spte(sp->spt, sp_ad_disabled(sp));
 
-- 
2.54.0

