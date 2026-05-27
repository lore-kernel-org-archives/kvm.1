Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D083F5BE5
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886219; cv=none; b=YpDKitgwFyQlaXILCJtoeTgow2eTJ7HljlSIrJXjwszjTlDaLRsGBXrAc0FHt3w4l1nBpdZ0zNyRhc0mE695fAmsnqQquKOns2k6SU64QTFec0rbQJkKlX5ab4MB4yrz14jBGeucq8s5GN/8xjn8LFHYYZQCtbFk9P3ENQ47fS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886219; c=relaxed/simple;
	bh=O0Dzr9y6cFVg8qYMI2oqsWYDxzwPFiV1IZwYIsniE4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2/s29WVexz2zma6zsks1tCVvRpopBFGgXzcm30qwNDACkWRyVMhZUevse9huFALKWlsjLKREwP12ZEfOym4Kdc/bprvnNS9LoPH5YKFDz0xY6Q7ultyrmg8mhAOh7CkJky23yIRhiFOHze8bowptdVqbFPZwVIEKlPb1NKwkfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJG9FpLe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJG9FpLe"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bc85eda6b6so59215385ad.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886217; x=1780491017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMG8EtROF9Cg3C7hjmtqqGx+u6sXMBdHtk9UvMaumUw=;
        b=IJG9FpLekx29W6HxC+rSYHFo/CwLadCu8zJEgBDEGmIr+x6ECFYcFASBXQBad8HLyN
         HU+fnC6e2GcHe9mzLUFj9pDl+g/7a+mfxgJulouN2keEFf9YIOqIf9hvRwhossPPas7C
         f2BmdXsZ51BLa37ZDjk78JiVdyqCrszMh/mtk4hGXxgt4PMokmZp/hGtpTWc35c4+7e+
         vZGsXr7OtIKCEbxYMrlSkno1xtOmU/4s4GClFEkEzTO99FdSmFJTvjuESF4EiSYFJyk5
         QPkwdJ6OL48oT4fc5hTofP6K1J5lpgObnjn4lt43MvOoT7vbV+WYMtu7OyVHJL4Qr2Ta
         Fplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886217; x=1780491017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oMG8EtROF9Cg3C7hjmtqqGx+u6sXMBdHtk9UvMaumUw=;
        b=maq6AcDvUdFCeGrBFu1CQesiqb5NEzV6vNuPUATgwIG1zbk5mKpzq6Ew/WFnipU8kl
         uNlZBwGR1jaADJQf5cz7WuO/FLPl74lsfLEZJ2oqAtp22Ehf/nOIK/N4I1HIyMJM9xTR
         LUP/6qM2IhApXKDByqg7mpo9GXd36/jHlPdsL8IcbOO8FVHDHsQjmDzIpbXyJnFuiJPK
         U8Nrvbo4wmeSOwFwgoyUXmSSUFwbkG0eJPMva1w6F0xLRx1OPmEVJ484WRKGjLDNwT6P
         6MbBdzG1Y9rOibfuJo/Pos01Du4S40jAH53+NhKFLRtEh+Mr11L7PianSxMkRgvG8ySw
         H+1Q==
X-Gm-Message-State: AOJu0YxTYrEnqrLa2PhkP+vzWH2PsDjc25CfBuCYSKahB+2F4tWNlXbl
	OxIZajOaxpe/WN7dAzvFI9ZTXLfCTegbVJwRvYPkx//JdR+DiLhUOH4yWbNkCA==
X-Gm-Gg: Acq92OGY9+sWddi8nC6oarOLkNn8J/OqChoWe9RvwzlLQ08wEs7P/5rJUE56HlUdNWs
	hxiYV0EZdHgBGcWCZvXrvBIYWE4o/E23mmG/vr5Ckug9jJU6MzY2bLs9d0uj7izyzOLgVXXIsNX
	Le50Jaao0HjuMSAQxxX66xYj8bGWFAs6L6LFkHb0Le7rvxMeqzii0v9HItoZGi2sBYVKjjriyVt
	sUQ3gM7jiTUOkMR9BAQ1lPOrXH4FhQUjF23HKU2nAKAueyAJhKa4Lz8j7xamb5TaV0cTDPrYmAs
	8JvrOWjSHO5e1o3cMeQpr6HzOzhpBXoRzh3ayjShFm1OYmqalLERIKfRqrDvVbQQLuGseTO/QwK
	hKlvKdnCuODlWzWubGsdOho6+dzbK0ejAw0cL5KYkj0Ae7AOHRznotYDv7a1/0oEfScyaz6ykjb
	TU0QmJKFpf5szKlV5dVV6R+kwmF9nAEiU9BytlOn0=
X-Received: by 2002:a17:903:390d:b0:2b4:5e0f:c239 with SMTP id d9443c01a7336-2beb03776bcmr229042615ad.10.1779886217442;
        Wed, 27 May 2026 05:50:17 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:16 -0700 (PDT)
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
Subject: [RFC v3 01/10] KVM: selftests: Move pgd_created check into virt_pgd_alloc
Date: Wed, 27 May 2026 18:19:50 +0530
Message-ID: <ce1d35a37541702914e4a89052b6f1dd049045ba.1779885589.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779885589.git.ritesh.list@gmail.com>
References: <cover.1779885589.git.ritesh.list@gmail.com>
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

