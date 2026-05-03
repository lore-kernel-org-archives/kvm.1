Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396003822A9
	for <kvm@vger.kernel.org>; Sun,  3 May 2026 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777839036; cv=none; b=f4DyB03JTV58IZUONxWX/zbLLJGSxryS0KBY8cogFnnC2QmVqAbkTuD1APlshf1CEloqsP+7V2zj5jEvhRxplO73ae0WU0FNTsEU3+1oztF9CYnEVF1F0G59zlcyLl+QpwZB5iGU1Doots4mMUosMlBpqCPr/s4QdEpLLBy2/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777839036; c=relaxed/simple;
	bh=FJJu0Q8b2ueh6dZR5A0YmhAFs1n+6AjOWyzmtKhTK3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcDQl7fie8L/UWvU2BfWi+mtrKgti1/ldeTHbHOWiqpxFOv55GWEQNOpoKWJcxf8GfolN5vfoEAhyw9uT/ByeZg0t3UT4G/zRmLKrvDOtpQV/l+XeICrMpBhBZZ8Wl+XuPmf9tQfPGT2+wm3QWyVDHsN7xqffM1DsVX81OlpzkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSTYUUM0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIij9EJS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSTYUUM0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIij9EJS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777839034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3wj86k5SwQWzT11yN3H7FC66hHNrBnlKpIWYcQSBC50=;
	b=QSTYUUM0GAHvsW1k+aPe5JAWaCX0Xb7tfvN0dRJJL7DpJ3/fwnIpp+lUPKLS7L15W0ciXY
	7dh0fV0hC2bJUcnpgOV1SzzBuhXp2E1fqiAblBsEcjpC+8g8yZDzqH0Fs9qMQDbhGruUBm
	CbDFqTfAotuh9FJMcnjhRaZ6IHfHmG0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-Of4x7W0DMZu4iE-MVQr1BQ-1; Sun, 03 May 2026 16:10:33 -0400
X-MC-Unique: Of4x7W0DMZu4iE-MVQr1BQ-1
X-Mimecast-MFC-AGG-ID: Of4x7W0DMZu4iE-MVQr1BQ_1777839032
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44a71109b94so1737471f8f.3
        for <kvm@vger.kernel.org>; Sun, 03 May 2026 13:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777839031; x=1778443831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3wj86k5SwQWzT11yN3H7FC66hHNrBnlKpIWYcQSBC50=;
        b=bIij9EJSsxKLFtd80mQtAY3FI2Bl72ODb3p7mMK+PcVGUjP3/kyccBJLLkgyzEcjNp
         B2pXUhzcqN5pUzefSrRjj58GM9PuFXTvBHzKUbrq6U32XfAM2KEMBRJkDbuNLsAICOCH
         ZhruRyZf9v804im8FXSCLnlvkwwjvi2fsXR617rZQf2Hy1bQnKQrom4WoKBXRS8pMbXg
         kgXNRUwWyBU4T1XWJXKYx75Djwn3fBbaCStEDghpfg2NOnCwcfi2ZKhyRV2JhHkXj1bX
         UDfnEK7VxCk+2mp9Rn793TAinvt9ktCvYqXnLA5t9UkPg9Y6J80IuRXbXnd8TyOrLR9o
         C7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777839031; x=1778443831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wj86k5SwQWzT11yN3H7FC66hHNrBnlKpIWYcQSBC50=;
        b=sgHgfJlgG88PTnPr/hZvX/4LuvnOI0IqaiscqdsaBB+D2ILucKfUChXX7EJeLMaN3L
         Ha1wCxuyOYo9k2dAjrtjhZFzCVAfq2+8TdBeB3l6NLR0gYx/1SGF8GA40mvHV2xLmuNO
         48eUl661FpYwPbAOf2OtrzlRnkVDO0T0c0SAvGgSgeeWzSBRzKIngNhN59byQVYOI4R9
         AanTi00GtPCDIsGpMOQRHufPH2CRSUgfMuxDco7BQxktjp22ivAKV75sdUJaWIrYYiMB
         NglCmRWkkW9RWj912XkzVT9d7mMsfHr8YcWuOmi24iDMkaiv3R0+dmGSteKgJlJOg/ej
         lBAw==
X-Forwarded-Encrypted: i=1; AFNElJ8u0XTupXVn8R+G6KJ9gwayPCeDOsso2jcZKIlPukwou4mdrbbRsC+z2SnkyvR3m7Yo6jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW86IVGwbW+T8ySNj61Zvwevprc2fm1LBuSL9Q2vTB1JkyHrUV
	OMJXyLIvwei/nd8O8edp7jHKSeL+pnlHmyMSa/WHwhoUsgJVRndkXjrjElPrTLStelD8quJ6Y9a
	zHF4qYLofOC0oHlPI412R6H5ptUVEW9XQ6+4gnF0cqyHim9SsR5qINOWM1noaIA==
X-Gm-Gg: AeBDiet0e01PQ9XO6KttU0rMnVkhNG65KJ6Ufm+v0UWg6C9WgEuB/AH+QLvNHq9TOrm
	PlwhFZBsAwyshBOUPtRINME6eu/eLzL1IMUBRNgz0beLABqp/tmnEonq7q8RJcgTPNJRySgRsff
	QeZvo00GjrdBrNd0FYWknd6l6CsUJ76WtiAAExXEZ8kCVCrSw7GoVPqW6FNOb5/VnHGacyU/B3o
	WAcIKDUq5LOzhOOARjUlKXldYNrX1auqWNaOoFGgx+R9kx4Y9w38boaWvdFj1E9ykyfyN6o0JRx
	59f5n/fuPXLnJt12E5VrEIZUl4kj0EO9hEdbzqaDMwjJeND7NNbqI2SL1oSxnj3aMXYHpXDzAVt
	PYU1v/01R4jGCMwL39J8o3/3XDpPJDA19x9JiUGI50LEGaznedCrUueZheHl6I3k0xn9IHu4Evi
	kuUYMk5pUiREPWS62YeblrKq/sdg5clqdbZNc=
X-Received: by 2002:a05:600c:468f:b0:48a:9540:1a3a with SMTP id 5b1f17b1804b1-48a98635f9emr114898865e9.8.1777839031568;
        Sun, 03 May 2026 13:10:31 -0700 (PDT)
X-Received: by 2002:a05:600c:468f:b0:48a:9540:1a3a with SMTP id 5b1f17b1804b1-48a98635f9emr114898535e9.8.1777839031135;
        Sun, 03 May 2026 13:10:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c8556sm271007775e9.4.2026.05.03.13.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 13:10:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Sun,  3 May 2026 22:10:29 +0200
Message-ID: <20260503201029.106481-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

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
  by step 3 then walks a stale rmap and dereferences a freed kvm_mmu_age.
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 24fbc9ea502a..892246204435 100644
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

