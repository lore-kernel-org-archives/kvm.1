Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1F3D2FE0
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964467; cv=none; b=Z64dkisyRP2zpqhXdlBfdJwQxpoqHzfdKstp8M4sLFY5BUh5bAAoAGqj7/xYvA9yaGZbTWgu3yJFdImHf40PInQAhKQonZO9jy8mP9qmBgvElthQhWW6oW9dAy7cLQo2uXyScC4cthViBHJFIazcA/47a+MFJ95SAHVmLe7O7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964467; c=relaxed/simple;
	bh=3LvJ5/xV1RQZaGHxF6pNpvvDu+FnGFMU5F1qw0qXnjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DsQUx5XVoGBorhJHUk4Hgw+bTRkxTL1JjmmCBihHceO5F3VbKphX69Y4DGHiUGFFQVt2ke0iDntmralN5C3bx3NIVpUQ8czl0tilTVZJdGMgW15OgdBLc5AzOcukgGiM7NRifaBISdeLxjMmYkhlfbYQhYZkzpvz0Uzbo8OGhS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YrhYUhP3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNXAjP/Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrhYUhP3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNXAjP/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777964465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nmU0xMG7ra+orDcAl7Q5QIsymSvh/y1zuyvrvlpHwIA=;
	b=YrhYUhP305Osv1ukn8NPEH3wxEqXHr3x5VNOWBxaY+poDZv0sW1vPm7BlC8t4B3+E7fk4A
	Whvk535GZ22KpbKTmnisMN7TlsqrF9/h5rn9ZSWvQU0VKkn7C4QfzJXFRurwJFIThL8Qfk
	UAOO78e9x9NM7DUUamL5b7LV1Y6DwCQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-lLDhv4apOdC60Ebwi5y7yg-1; Tue, 05 May 2026 03:01:01 -0400
X-MC-Unique: lLDhv4apOdC60Ebwi5y7yg-1
X-Mimecast-MFC-AGG-ID: lLDhv4apOdC60Ebwi5y7yg_1777964460
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d7d0947aeso2318596f8f.3
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 00:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777964460; x=1778569260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmU0xMG7ra+orDcAl7Q5QIsymSvh/y1zuyvrvlpHwIA=;
        b=gNXAjP/YCH+BJXEFZoPi3y5k7IyJTd7W9tOKKYEna/lRAJ55aGll9DNfER2xmL5JaR
         T2EqxiBnbFikIUbYCfclTRidRPMEtCto4Dk24YEX8pcI2+OKYDwgRdURN+X8H+ghZa1m
         lql8TUgJZtA7MJr1AxHGYz1N05zB/iRBBwBBGrGqm3anDCj6Cjz9cCBPZ59wXBxQsHxv
         Woyz/gORjpRKbRoyCAupeh0G2rZNaiS5e/1PZ2blfoLLX8qiNRjB3nwY104DVrhYwLIK
         lAJuF6quI5LPEUjsZxSoZCOYnjBiy/D7zl7w7vi/kssthzdTdKv1R9jkY+mmOieh+M78
         Yajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964460; x=1778569260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmU0xMG7ra+orDcAl7Q5QIsymSvh/y1zuyvrvlpHwIA=;
        b=ryBd+Cp3ynmb7CjYcHnLEdrPPQZPLzl6IMNyJK66rQYOSNxfXkXpmZaS+BNFh2RZ7+
         cniIuON0h7IIUnhiC7F7mDlHuj//FQDa/j93gsnIRhez8NUtG4OPMvd23nNUD21lgByM
         CmjlTKIQnMJw50LdQ5FUbotB6MiiqAn2K+J+cUtx85l/FGjPl8QKLkX4JbTkEWYf5PQf
         QFl+qu3OropRXGwkZhCRvdgmleYYCn3F2j1kwYsTNBPU0Pam0C+uGaSRnZ3CUZuGtM+m
         8gL3sr8jLsAnb+4A7D3D2Xtz2mHH1DwX1yWUvaM0XWE0zyuiptv9ljEqU/1i6tc4wpQM
         NuPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DVkHUI4CkyO/6Nv4Y0/9yQqGjASS3WTe9D+rEKUHRZq5SAnENDSYn73Y8GcZWARGqFi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zEk2gPyyBqkR6WLP7PlGEzwARv3+PB1GHtS9aH2Rr05yIpLe
	spAkbCcpF0IkZfNh3PHxI6vsOf63gatL7cxg52e50F2kbIp1GTPP2IRBMzg6/5O07KN85AnMhxZ
	fgPMMd1eC7OZvUkcANyd4mgyxgAH4J2apyM090+jL9GorE5mH9nGJng==
X-Gm-Gg: AeBDieu5sAqgFwHyRwrRtCkFXizLm2uTS/RzSGUf/kdaOtLe0YF8QdkdCxdXmkPUP2a
	s4uEvsiKIpChbtvEdz4Lor9H7IAgmphU7GoxKiHcyeRJ8mgxED6Mg/gSKFJKg/t7+WBBrRQjesz
	3BUxlbpUEP0tmzHfrY/scF1HEIzDptgKxaHSZcgEOUvz5DPihRW7UMBRi9izsSi9hyC3aLamvhN
	aHitJ0PA2EQkFa1KDMow+AR77Aa91ET7b9/6qgHZ7QvWAKGwARkzlN31wR8H7cDwq+SGrMrSaGc
	YetfmW2zm+8i8u+fJfNSArFvwS1O5KZ+nOXCIchFX4IZVkkq21Wkd5YSGfwfFGVpFx0+hH4peRz
	tj8ZjjDvGsuNJ4J0J4RyeHV8sqlfQNLAQ73VYqjYAP6nbA7tpSDbvEE1YoOjKZOW6bztmfvaisc
	iVbqHWShFkGJv3oV826xzrkMhPSmwxImU0eCzCf/g=
X-Received: by 2002:a05:6000:24ca:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-45005c81614mr3326430f8f.27.1777964460045;
        Tue, 05 May 2026 00:01:00 -0700 (PDT)
X-Received: by 2002:a05:6000:24ca:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-45005c81614mr3326348f8f.27.1777964459369;
        Tue, 05 May 2026 00:00:59 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524833e1sm2243371f8f.2.2026.05.05.00.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:00:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Tue,  5 May 2026 09:00:57 +0200
Message-ID: <20260505070057.198705-1-pbonzini@redhat.com>
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
index 0dc804149b0f..774bc26b8235 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -182,6 +182,8 @@ struct kmem_cache *mmu_page_header_cache;
 static struct percpu_counter kvm_total_used_mmu_pages;
 
 static void mmu_spte_set(u64 *sptep, u64 spte);
+static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
+			    u64 *spte, struct list_head *invalid_list);
 
 struct kvm_mmu_role_regs {
 	const unsigned long cr0;
@@ -1194,19 +1196,6 @@ static void drop_spte(struct kvm *kvm, u64 *sptep)
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
@@ -2350,7 +2339,8 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role;
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
+	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
 		return ERR_PTR(-EEXIST);
 
 	role = kvm_mmu_child_role(sptep, direct, access);
@@ -2428,13 +2418,16 @@ static void __link_shadow_page(struct kvm *kvm,
 
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

