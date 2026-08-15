Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A7D3254B3;
	Sat, 15 Aug 2026 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786803751; cv=none; b=t3bE0H0Lr3Sn9ZjRrSSYyeEsTM3clx/SsTgRP4QEOZYXzA2oqS/CniL996m5koD0CASDAnfdxDt4D+QbtI2s7Ampzky5DpTet80RH36Hi1yPsuflExbyewWKT0IfR9s7lFif7aFwKi/tzHx141B+AGO6VymwNw8goZqL3jbsjcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786803751; c=relaxed/simple;
	bh=sxdz2aFG9J4U/2xnHVxLhroUe7tWlgXmJ3ow6Cd7zfA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XXR2b2nAp8jmeOXWQteev1Ttj9R5ImWW7YClVfRBs6atlzNnX55EK45XttMRboBul+vsa4LsuGqnn1gFNNfXRo1hx3ANl1kE0INM55MDTMO9mzOzUxOkUd+wcIyhXNP4cLphyenCYgXasPqcy+lq0ewrTnCKNdhk08MAyQtGiRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=od8L/9YR; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="od8L/9YR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1786803750; x=1818339750;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NdBptVRUbrEPzCnVSs+90uqGlpz+dVntovi5IRUnckc=;
  b=od8L/9YR/jT/sJruxrVtT5j4R+QsWWB6oJaAzPquhA0VfDLhuHp+WF/2
   GNgjLoVnlyrwiVPCg0Ep/AXAPKhChKVFvZ+67nuMFpRlu88/sTHjZx77S
   1p6+0LDIsYgWnLHyBYaxEr0hxq86BH2tB/XCwfKCXEWvtN/KFzxa2aUkK
   bd8q8sSjeavdERB2frdIzLZwBiuamGyVfEtVWr7OI4KWlgqiMj71GfSqF
   zYY1/Q+AtmM86GVrAjLF4FjcvMSHKQGSbubq1OHRuII8VOx+IHpdaQpbi
   HN7lX9oYu2KevIhLryGdkM/vJgQxYtkyMNY/Cu4sAvxLk1gcMQMGSQM1B
   g==;
X-CSE-ConnectionGUID: 847i5wysRVeNdNBa2XizzA==
X-CSE-MsgGUID: CHdlhCr5TcKT5e6jzyp68A==
X-IronPort-AV: E=Sophos;i="6.25,225,1779148800"; 
   d="scan'208";a="25945341"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 14:22:27 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:13129]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.183:2525] with esmtp (Farcaster)
 id f84a4b6a-1fd5-42fc-94ba-9b09a0a0b400; Sat, 15 Aug 2026 14:22:27 +0000 (UTC)
X-Farcaster-Flow-ID: f84a4b6a-1fd5-42fc-94ba-9b09a0a0b400
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sat, 15 Aug 2026 14:22:26 +0000
Received: from dev-dsk-hmushi-1a-0c348132.eu-west-1.amazon.com
 (172.19.124.218) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sat, 15 Aug 2026
 14:22:25 +0000
From: Mushahid Hussain <hmushi@amazon.co.uk>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: David Hildenbrand <david@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [PATCH] KVM: Use kvcalloc() to allocate lpage_info arrays and dirty bitmaps
Date: Sat, 15 Aug 2026 14:22:18 +0000
Message-ID: <20260815142218.85067-1-hmushi@amazon.co.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Use kvcalloc() instead of __vcalloc() for the lpage_info arrays and
memslot dirty bitmaps, and switch their frees from vfree() back to
kvfree(). kvcalloc() serves sub-page requests from the slab and
falls back to vmalloc for anything larger; kvfree() handles either
allocator. The vfree() pairing came from commit a952d608f0be ("KVM:
Use vfree for memory allocated by vcalloc()/__vcalloc()").

Commit 37b2a6510a48 ("KVM: use __vcalloc for very large allocations")
moved these sites onto __vcalloc() to escape kvmalloc()'s INT_MAX
size cap, since memslot metadata sizes scale with the memslot size
and can exceed 2 GiB. Neither site can reach the cap: lpage_info
holds one 4 byte entry per hugepage granule (per 2 MiB at level 2,
per 1 GiB at level 3), so reaching INT_MAX would take a 1 PiB
memslot, while userspace slots are capped at 8 TiB by
KVM_MEM_MAX_NR_PAGES and x86's internal slots at 4 GiB by
__x86_set_memory_region()'s u32 size. The dirty bitmap is two
bitmaps at one bit per page, npages/4 bytes, at most 512 MiB, and
internal slots never have one because kvm_set_internal_memslot()
rejects any flags.

__vcalloc() makes every allocation at least a page, so a single page
memslot consumes 8 KiB of vmalloc for 8 bytes of lpage_info and
another 4 KiB for a 16 byte dirty bitmap when dirty logging is
enabled. This overhead scales with the number of slots and VMs on a
host, adding up to memory pressure when guest address spaces are
fragmented into small slots.

The rmap and gfn_write_track arrays keep __vcalloc() and vfree():
the 4K rmap and gfn_write_track are per-page arrays, 8 and 2 bytes
per 4 KiB page, which legitimately cross INT_MAX below the 8 TiB
slot ceiling; the smaller higher-level rmaps share the 4K rmap's
allocation loop; and none of them allocate under the TDP MMU, where
the waste above was observed.

Fixes: 37b2a6510a48 ("KVM: use __vcalloc for very large allocations")
Assisted-by: Kiro:claude-fable-5
Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
---
 arch/x86/kvm/x86.c  | 6 +++---
 virt/kvm/kvm_main.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afcac1042947..77567aa20d83 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13488,7 +13488,7 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 	memslot_rmap_free(slot);
 
 	for (i = 1; i < KVM_NR_PAGE_SIZES; ++i) {
-		vfree(slot->arch.lpage_info[i - 1]);
+		kvfree(slot->arch.lpage_info[i - 1]);
 		slot->arch.lpage_info[i - 1] = NULL;
 	}
 
@@ -13544,7 +13544,7 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 
 		lpages = __kvm_mmu_slot_lpages(slot, npages, level);
 
-		linfo = __vcalloc(lpages, sizeof(*linfo), GFP_KERNEL_ACCOUNT);
+		linfo = kvcalloc(lpages, sizeof(*linfo), GFP_KERNEL_ACCOUNT);
 		if (!linfo)
 			goto out_free;
 
@@ -13580,7 +13580,7 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 	memslot_rmap_free(slot);
 
 	for (i = 1; i < KVM_NR_PAGE_SIZES; ++i) {
-		vfree(slot->arch.lpage_info[i - 1]);
+		kvfree(slot->arch.lpage_info[i - 1]);
 		slot->arch.lpage_info[i - 1] = NULL;
 	}
 	return -ENOMEM;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e44c20c04961..52af1ebdd14c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -927,7 +927,7 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
 	if (!memslot->dirty_bitmap)
 		return;
 
-	vfree(memslot->dirty_bitmap);
+	kvfree(memslot->dirty_bitmap);
 	memslot->dirty_bitmap = NULL;
 }
 
@@ -1422,7 +1422,7 @@ static int kvm_alloc_dirty_bitmap(struct kvm_memory_slot *memslot)
 {
 	unsigned long dirty_bytes = kvm_dirty_bitmap_bytes(memslot);
 
-	memslot->dirty_bitmap = __vcalloc(2, dirty_bytes, GFP_KERNEL_ACCOUNT);
+	memslot->dirty_bitmap = kvcalloc(2, dirty_bytes, GFP_KERNEL_ACCOUNT);
 	if (!memslot->dirty_bitmap)
 		return -ENOMEM;
 

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.47.3

