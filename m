Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F83F44D5
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861083; cv=none; b=nqDekcLvMv4wbmFs0Uig7zqmJuNdOHbeG+aYdtREUjOhWvvSCWMDk1ZnXYcIepEF/y+5baEu/l4TfI0DwR1T2+fpqp+lRbpkNAL1mZa4h5OJCnUwfz9hLPjoChhWXadqA7zUd3sRe72T1sLjV47g7wnUhTjCeMsTKrFPENgWh7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861083; c=relaxed/simple;
	bh=QGrJLUpisUTTqdsMw2pU1CxH7bvU3JfOjYaQtOBJWYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/nXH0GFYSVEIr7YGqzDf+RbhvqF93hSQgjqx3Zpy3OMm5QmQ7usMzOZqKxXKdTBWEIUQvtF/0QrLKaCJLidsvMjIChzL88w1YF0iVmYM451ugSMpL8LzhbYuosu6jPBoa9fWBxmt1/IjetswYBHHqYCFSE7M1TX114aNGkUEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeY4dypM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeY4dypM"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-83537a80ab6so5753760b3a.1
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 09:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861081; x=1779465881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHtM3hln5E0LtkuEKr9m/vG1aJYWfiEmMpXBjaFCM6o=;
        b=BeY4dypMd8T0Xp+MWXDl2u8spJrzHJFF0B0cb+YnsbnAkmsj6NahyqiGH46AIW7JAL
         cQlJNm1on6Db5E3gxBQGf5BaviIPdB2f9gMC5hBHCRtphq9gw7A8gZ8oYEnJPjGpscHU
         OZOvBBWLGbCTTC+pFPFndM7dj8MvrCuN7v9GNbdjtNqkfnEOzMOV7mP5IDVPWinzIXEa
         b1WL45A0vM8tcHy1gdbVV7nPhTUUaeDvaEWp9qd0pqoahxgAjEAdikur0h20ZB4BJGu/
         cDkFbdxKV3hM3vl16neAptGTFrMyM4KwdOo0Wu7RpHLQ/PIvCvdUhIscfc3OPiJ3iHYW
         +5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861081; x=1779465881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tHtM3hln5E0LtkuEKr9m/vG1aJYWfiEmMpXBjaFCM6o=;
        b=nodPdUQWw2TOiHlbukZFHqBzyS8doPx9MBDve4LcQiAe16SKrLUEobleTvu4rI5WhM
         +C3lg898qii3d3xbLAXP0rfD/jDtO5wzBqKrHK2rc7rvO32Xsq67AivDn1ptB0s4XpO7
         5JGiSVYxH1CtqaESOIk4u7yNFN0TV75Dk23tDbttTn+jlC8Q+58FDWvliJbmD8Oj14ct
         p6/b7ug2PM138CmykUiHykyEwR0F7hT9GmkV5jSQTv12z1Mq6UJ/eZAtZ1PN4ewzg80s
         smf9xLYuxObO9dOhQ0euopdV0liuUK0K3F1HhCHPhSBHhnJ8k6fJr0KjVmT+WVnU+kZz
         Tp7Q==
X-Gm-Message-State: AOJu0YzBR840mjnzvqM9bowMO5yB9pA4RNxt8sAczrESfsqg4mwXEBys
	KZX+nnTSSGirPgzbjlCpyw7GTqnWzcWY6ft513VaGKO4F+WTFQdoOUkg550ebvFz
X-Gm-Gg: Acq92OEPn6XzJUjZXZAAfQwQUGLqgua7RI9FsX1JGDkaeBpzDfgXjcsh+0rjpYxJsvj
	dsilVtiXVZbihN1i4ZQgYQjunPY1XFIdsveov69sRrir5vNbvqGnhmABanq8Xpcoc3Voq77ZOgG
	86SQfXQKxAM3sAoN9qcCwOtB7d1cZaFXZNg+riLNkiRecXra/Vjzd3VOyp+IUsXNInoF6MEeIMm
	nKVVKFGdmrnVle48wBd6Lv37NWR6Ubg6uEfyekeZkTPq4XGk8r2v4fBRDPBUGqJMn/ihxiCWQOK
	K9H0mpfa5rrMvbcLbUDmeguj3HU+mif5rGERVf5GVNKv+n36iLdpC5Mr1SFsLvI1owcySI0FmLI
	IOsTF43uSTU/vJ/e8324lcIl3YCU9OmbcVrkZuGaZYhUDzRkqKVFyzgxutzjrfiy7OJKQKo21rE
	QHyppXObmWVecUOm+N7CXaFc46I9n9Pin9owTK5nTtDTFpC7Omnx1THvg5rO80qGN0WRXq69PHR
	A==
X-Received: by 2002:a05:6a00:391e:b0:82f:623f:e5b3 with SMTP id d2e1a72fcca58-83f33de9717mr5676947b3a.34.1778861080622;
        Fri, 15 May 2026 09:04:40 -0700 (PDT)
Received: from localhost.localdomain ([171.76.86.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7c74fsm7920262b3a.49.2026.05.15.09.04.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 May 2026 09:04:39 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 1/4] KVM: selftests: Move pgd_created check into virt_pgd_alloc
Date: Fri, 15 May 2026 21:34:20 +0530
Message-ID: <6e6aea750fb80d4d28dbba97c45f498f2ec06a68.1778857539.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1778857539.git.ritesh.list@gmail.com>
References: <cover.1778857539.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicholas Piggin <npiggin@gmail.com>

virt_arch_pgd_alloc all do the same test and set of pgd_created. Move
this into common code.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h        | 5 +++++
 tools/testing/selftests/kvm/lib/arm64/processor.c     | 4 ----
 tools/testing/selftests/kvm/lib/loongarch/processor.c | 4 ----
 tools/testing/selftests/kvm/lib/riscv/processor.c     | 4 ----
 tools/testing/selftests/kvm/lib/s390/processor.c      | 4 ----
 tools/testing/selftests/kvm/lib/x86/processor.c       | 9 +++------
 6 files changed, 8 insertions(+), 22 deletions(-)

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
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index b51467d70f6e..e420afdfbcfb 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -164,12 +164,9 @@ bool kvm_is_tdp_enabled(void)
 static void virt_mmu_init(struct kvm_vm *vm, struct kvm_mmu *mmu,
 			  struct pte_masks *pte_masks)
 {
-	/* If needed, create the top-level page table. */
-	if (!mmu->pgd_created) {
-		mmu->pgd = vm_alloc_page_table(vm);
-		mmu->pgd_created = true;
-		mmu->arch.pte_masks = *pte_masks;
-	}
+	/* Create the top-level page table. */
+	mmu->pgd = vm_alloc_page_table(vm);
+	mmu->arch.pte_masks = *pte_masks;
 
 	TEST_ASSERT(mmu->pgtable_levels == 4 || mmu->pgtable_levels == 5,
 		    "Selftests MMU only supports 4-level and 5-level paging, not %u-level paging",
-- 
2.39.5

