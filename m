Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509FE357D0B
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779534895; cv=none; b=BovLAmnXS1Ixx93RFo5ec3WpuiytmHV8U//MwH16gR7wiyJN3gmKsQMnb/jFcoZFAEWty1mnm0ZxuE2PY/Ad4m3NZIB7M6DBX0zEH/2qYG+O09ypf3oh//YOYWtwRqZpN6h/3WYBLA7vSx0y33G6n0z7r4o3Nec3d9oaVz/Ljwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779534895; c=relaxed/simple;
	bh=O0Dzr9y6cFVg8qYMI2oqsWYDxzwPFiV1IZwYIsniE4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsZVz7dQaYAiXRlLzNljp8rqunihfBbywmkOJ9+HyvG/pF/qYfi2YlBTtEEiDgX99ALYuFWKjgCsoWsHrhR5VXwIYEvy1T7eSoGwKWCzKksN6VngP6XGvn8tlgkkenx0kCI+F+SOB/Ts5PAgEix4/7X/NNg1eEdziICYdGzTj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCKVdMSk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCKVdMSk"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-83537a80ab6so5600662b3a.1
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 04:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534893; x=1780139693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMG8EtROF9Cg3C7hjmtqqGx+u6sXMBdHtk9UvMaumUw=;
        b=dCKVdMSk7dxwUeBz7HstIJ86CerA0/tX+YyCNWN415jO0+kD3XKVUcbLkd8mOEWP7B
         +z0EdDzT4RgrflHlKjyIGAW6mcMEyHc6N0iTIVvhCgqrgpzzCGsNkX2tmvXv22qivhuA
         NyEYM0tZb+AOENToTXwBDWQ/pDsYM+pNoolWf3Fg2N9P6LWjWNc1sn/BzP2P3O5K1PiQ
         SHbZMpklXXHvP/k5C/jhoulFQzgJx/WPSxxpVC59inLgrzrTi2wEkAkmgcNpxLgaD+lN
         0Z/agdnKx3E4Ylzuh1SzUKEz1ELsK7sYNSA2CUwlMahzW1pPwXHC5souhNyDWSKgmsdJ
         ed4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534893; x=1780139693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oMG8EtROF9Cg3C7hjmtqqGx+u6sXMBdHtk9UvMaumUw=;
        b=LVumQ5yqd1J1gZdO4zsMAIK8RRfdPbyf2w3Ota2NWq3DNPw2LC0AM+HFCuE8OrJbsI
         zORplnEPWWVuQxz++Ml2036jQGnZejlglktiMPkybD5todGJZPL6uS/fHe+ZTmB1NzDf
         7Af+uYlPWuqSZNnfR0f6gYUGDtQNTNUYiNR8aq20u6iuWet21JDdJCOurE1dUYDFvRt0
         Dp6qGnsW+5BzF/ij5eVYjRz1RvgJ/5Fuvgsbyoc8ClsorSYOM8PaFZEi9C7sTtWWJE6r
         w+nqb+865CErOQFqFCqbS2O95dhsK27wkfRVu2tDDEBkilSDmAbEL8OYS6rRd4biolhs
         uKaQ==
X-Gm-Message-State: AOJu0Yz/MGZQrvdN5mI6d00luAH1jd5Aujo13vmaETpVqcOwudznL2xM
	BbeXrd9/vkPajSwPAH9IaIJquV6OvXInx80KEo9c7SAXi69IZLtYQXO3FCfKKw==
X-Gm-Gg: Acq92OEplLnmYQmLM2TjqJ/qwoMzK92YfuDnZ6WKATZfxR8TY7IqfCD8/GJN30L9hI+
	lmSAK7ugeM95PIZ1qpAZJU6E2/dFVuQPkehLvB5VQDwZtSBR0U8Qw1e5VbHS3n51AqauACl2LR2
	PECnqIb2/S55+rsdjO0Zl3R7W5iifjnhuaJ97iim8QoxFh6tQIv0/ysqMwjsO4Xg8rLmM0FZ4Kb
	znvYh7hmBLIZIVHLoFh1jIpJboSEfwE6GogGs6fPpGC22o2GiGfSlvrfoT+ha/wHOVnuxTx/c2g
	L+epldioHdd2tEcpQ6bWLeQoczKBe7yRNDDwiFAu3HpWHDZOX2XMCq9MtnJKjfTk2x3YeEqbwwo
	GQLBMI+smW/1+bIyFFG162Zz+9mOU7IDOwhWl/891BOZu58N8N49gtCqVTEzWQ/+QLfv3IrgkxI
	Rdh2pGQTZuOardy4NCDm0fSh9mAk063C9Pz2SpUe8=
X-Received: by 2002:a05:6a00:94fc:b0:82c:6683:b866 with SMTP id d2e1a72fcca58-8415f121b9bmr7424451b3a.4.1779534893432;
        Sat, 23 May 2026 04:14:53 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9c77sm5249140b3a.2.2026.05.23.04.14.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 04:14:52 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 1/5] KVM: selftests: Move pgd_created check into virt_pgd_alloc
Date: Sat, 23 May 2026 16:44:20 +0530
Message-ID: <d5256bfe85fbb8c7f37ab6090bb08ccfa6a47e7b.1779524962.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779524962.git.ritesh.list@gmail.com>
References: <cover.1779524962.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicholas Piggin <npiggin@gmail.com>

virt_arch_pgd_alloc all do the same test and set pgd_created. Move
this into common code -
except for x86's virt_arch_pgd_alloc() -> virt_mmu_init() - because this
can also be called from it's tdp_mmu_init() call for setting up it's
stage-2 mmu.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree and removed x86 case]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h        | 5 +++++
 tools/testing/selftests/kvm/lib/arm64/processor.c     | 4 ----
 tools/testing/selftests/kvm/lib/loongarch/processor.c | 4 ----
 tools/testing/selftests/kvm/lib/riscv/processor.c     | 4 ----
 tools/testing/selftests/kvm/lib/s390/processor.c      | 4 ----
 5 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 2ecaaa0e9965..3666a8530f31 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1197,7 +1197,12 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm);
 
 static inline void virt_pgd_alloc(struct kvm_vm *vm)
 {
+	if (vm->mmu.pgd_created)
+		return;
+
 	virt_arch_pgd_alloc(vm);
+
+	vm->mmu.pgd_created = true;
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/arm64/processor.c b/tools/testing/selftests/kvm/lib/arm64/processor.c
index 01325bf4d36f..498fbcb0ea16 100644
--- a/tools/testing/selftests/kvm/lib/arm64/processor.c
+++ b/tools/testing/selftests/kvm/lib/arm64/processor.c
@@ -112,13 +112,9 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 {
 	size_t nr_pages = vm_page_align(vm, ptrs_per_pgd(vm) * 8) / vm->page_size;
 
-	if (vm->mmu.pgd_created)
-		return;
-
 	vm->mmu.pgd = vm_phy_pages_alloc(vm, nr_pages,
 					 KVM_GUEST_PAGE_TABLE_MIN_PADDR,
 					 vm->memslots[MEM_REGION_PT]);
-	vm->mmu.pgd_created = true;
 }
 
 static void _virt_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa,
diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index 64d91fb76522..207055db5f5d 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -51,9 +51,6 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 	int i;
 	gpa_t child, table;
 
-	if (vm->mmu.pgd_created)
-		return;
-
 	child = table = 0;
 	for (i = 0; i < vm->mmu.pgtable_levels; i++) {
 		invalid_pgtable[i] = child;
@@ -64,7 +61,6 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 		child = table;
 	}
 	vm->mmu.pgd = table;
-	vm->mmu.pgd_created = true;
 }
 
 static int virt_pte_none(u64 *ptep, int level)
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index ded5429f3448..75a5d4c46001 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -66,13 +66,9 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 {
 	size_t nr_pages = vm_page_align(vm, ptrs_per_pte(vm) * 8) / vm->page_size;
 
-	if (vm->mmu.pgd_created)
-		return;
-
 	vm->mmu.pgd = vm_phy_pages_alloc(vm, nr_pages,
 					 KVM_GUEST_PAGE_TABLE_MIN_PADDR,
 					 vm->memslots[MEM_REGION_PT]);
-	vm->mmu.pgd_created = true;
 }
 
 void virt_arch_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa)
diff --git a/tools/testing/selftests/kvm/lib/s390/processor.c b/tools/testing/selftests/kvm/lib/s390/processor.c
index a9adb3782b35..342b7c92463e 100644
--- a/tools/testing/selftests/kvm/lib/s390/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390/processor.c
@@ -17,16 +17,12 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 	TEST_ASSERT(vm->page_size == PAGE_SIZE, "Unsupported page size: 0x%x",
 		    vm->page_size);
 
-	if (vm->mmu.pgd_created)
-		return;
-
 	gpa = vm_phy_pages_alloc(vm, PAGES_PER_REGION,
 				   KVM_GUEST_PAGE_TABLE_MIN_PADDR,
 				   vm->memslots[MEM_REGION_PT]);
 	memset(addr_gpa2hva(vm, gpa), 0xff, PAGES_PER_REGION * vm->page_size);
 
 	vm->mmu.pgd = gpa;
-	vm->mmu.pgd_created = true;
 }
 
 /*
-- 
2.39.5

