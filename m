Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45149659
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886224; cv=none; b=pjKDwiP1FinLMPC8bzD8VSmKsi5OA1uZEddxjRlIa3jrYm/NyAre9jOWt9XTDUpq+qUvdkC+A1cWNPTAj9Xerj1IwTBl/NC/IuZDKnvZwHwOdiTjnnPutKZnFF8MGnyCE1ThNoe+M8SFbvBYZ5Ns/p73hZj+lHf63Q21M0+2gU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886224; c=relaxed/simple;
	bh=/5ntm12UBsNEn1uqQ17yyFb8FWJxtbSa9O5h5/dpkP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TO5AofJHXC/oEE4lvIBu/qvPvWo0VZxqIw6ggXM46cvKryCpmULckCkJLQrtdRfYvlhGHXyg7ernLtoGNCoDHns9+/iIuxCknOWODsKG/vIGW+NNvcIN2KrrLbabMUexTHsu8eDC3IMMbz5NQVJxhtCpyRATKvFKrw7+LxFkyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaPeus44; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaPeus44"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36974217d4eso7665243a91.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886223; x=1780491023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yVGhyRSYo0EGvj1O2Xj5DkH81nOVKSw16RhmJnLg/M=;
        b=WaPeus44Uqwq2fcQ+1uVWJaFTHVuUyjhfBIHYQMmV58mHYiXRE5SsGFL1nH6ew4j7k
         SWtI4DIH6kxBgjM7oIHZJFsjc2qmMvtUABXxBb6dEYJYaeN90Oa6oZ2hgWX5ijrjTDum
         WUeEEDNfajj/0gqETOeYu5rc5N3kHAvFcEn8G/cweS7F0Cpqv1CKisyJi9yfcGK2cTV5
         rdHtAGEUw/WEfcHTVdApxPx35jbIXbSv9BiYUen4rzNRg9wvVjhleU6QT2G+ubD8AEbB
         ottCid7hbV3OHlA2h6lNJw4EPc1HvfcrMeWGKdgbgr5o+HLeZtRcwU2pW8jIEdYnkuSq
         mo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886223; x=1780491023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5yVGhyRSYo0EGvj1O2Xj5DkH81nOVKSw16RhmJnLg/M=;
        b=lm3l7hlf2P9rF0NvEHIgl2e29u7ZqxXEUBdhg5JsUGR5SuFzD8BaiO4h4CaTj39nEX
         gRn9HKLxhYB/Is/Il8iHLHVh30dphgxeoOVbt11WnOwgMkH9hw1VVE95h4c10G8VUQw0
         o1faoXUhg72TAEYBAyQG1BRinJA1wmky3mp/kTPrrB/1hNN4a7pocAZQE6WTUUggnhJ9
         159RS6LmU0PUV1NyEhML3n7ZYLh32/3RyxSoJjLTVgoS2V/Y9HeS2TWAapOeIibDgFv5
         tPdoeou02gstFNtIVbw+AYq1pCtsLxsywJTs+n6pCsWUkQgOECsqemsKW8is3YIiRZFC
         nNiA==
X-Gm-Message-State: AOJu0Yx3CJj+S3CvLhYRuO6D3kZ+D69WkEEcO3P48BRKfKzB0ADNBZD1
	ZWByTx2Te8zDQ4yooGSezYev9nDTHLzl84Q99ZN67hTjGNOYAcDw8pD2bUSA2A==
X-Gm-Gg: Acq92OHAxFYWva4rV/gkTELOPcI2kWr6xZFOdz+5fSxg6zKBr1ohxSwgspoOE9+uhyA
	0ypFz1AgTsi03dJJclvP7RINwU7UJWazH6kJ6sVR9ZlSmRLfLJieczCueCT3OONdJUxhr11qklt
	jJrwTlhzbIw/FVR4Elaszz+hpm1wbIuml6q9KyZcqdsKdzNIGLX8O7yJexrEGMq2WGmT9US+UnW
	8f2yIaHBedzl7Wk8m+20mSTg7XrJA02Pb3CncnEi7AkKgi6HMtUY7SyPKBnvuPUzbKUreFOL8jh
	JTJZ04eVW1n8sC5hcdmHwZsSrr/iY7p6xUu8CZ0FwHLpQ95ibVHoMqdeshE1gTFWsCjiowhlr3S
	8S2nzIvElb8VUVm/PXDvKVlQ7rtzq/fZwdh6Si3Ul1mT+ll1O7OIzI7vot/zLra5wp67G9vJn7/
	40NDjfIYNoTsc4yJ0Ix+qTZAYCposSLlbzpgBFAEipRg6vV2MXnQ==
X-Received: by 2002:a17:903:11c6:b0:2bd:3bfd:7512 with SMTP id d9443c01a7336-2beb065b6edmr251222955ad.29.1779886222267;
        Wed, 27 May 2026 05:50:22 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:21 -0700 (PDT)
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
Subject: [RFC v3 02/10] KVM: selftests: Add aligned guest physical page allocator
Date: Wed, 27 May 2026 18:19:51 +0530
Message-ID: <e9fdbd834a05cbf1113080bb73b36cc1d9766f4a.1779885589.git.ritesh.list@gmail.com>
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

powerpc will require this to allocate MMU tables in guest memory that
are larger than guest base page size.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 20 +++++++++--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 33 +++++++++----------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 3666a8530f31..c515c918c2c9 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -991,8 +991,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 const char *exit_reason_str(unsigned int exit_reason);
 
 gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
-gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
-			   u32 memslot, bool protected);
+gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
+			   gpa_t min_gpa, u32 memslot, bool protected);
 gpa_t vm_alloc_page_table(struct kvm_vm *vm);
 
 static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
@@ -1003,10 +1003,24 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	 * protected memory, as the majority of memory for such VMs is
 	 * protected, i.e. using shared memory is effectively opt-in.
 	 */
-	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
+	return __vm_phy_pages_alloc(vm, num, 1, min_gpa, memslot,
 				    vm_arch_has_protected_memory(vm));
 }
 
+static inline gpa_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num,
+					     size_t align, gpa_t min_gpa,
+					     u32 memslot)
+{
+	/*
+	 * By default, allocate memory as protected for VMs that support
+	 * protected memory, as the majority of memory for such VMs is
+	 * protected, i.e. using shared memory is effectively opt-in.
+	 */
+	return __vm_phy_pages_alloc(vm, num, align, min_gpa, memslot,
+				    vm_arch_has_protected_memory(vm));
+}
+
+
 /*
  * ____vm_create() does KVM_CREATE_VM and little else.  __vm_create() also
  * loads the test binary into guest memory and creates an IRQ chip (x86 only).
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e08967ef7b7b..ac7215824203 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1442,7 +1442,7 @@ static gva_t ____vm_alloc(struct kvm_vm *vm, size_t sz, gva_t min_gva,
 	u64 pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
 	virt_pgd_alloc(vm);
-	gpa_t gpa = __vm_phy_pages_alloc(vm, pages,
+	gpa_t gpa = __vm_phy_pages_alloc(vm, pages, 1,
 					   KVM_UTIL_MIN_PFN * vm->page_size,
 					   vm->memslots[type], protected);
 
@@ -2021,7 +2021,7 @@ const char *exit_reason_str(unsigned int exit_reason)
  * and their base address is returned. A TEST_ASSERT failure occurs if
  * not enough pages are available at or above min_gpa.
  */
-gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
+gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
 			   gpa_t min_gpa, u32 memslot,
 			   bool protected)
 {
@@ -2039,23 +2039,22 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	TEST_ASSERT(!protected || region->protected_phy_pages,
 		    "Region doesn't support protected memory");
 
-	base = pg = min_gpa >> vm->page_shift;
-	do {
-		for (; pg < base + num; ++pg) {
-			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
-				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
-				break;
+	base = min_gpa >> vm->page_shift;
+again:
+	base = (base + align - 1) & ~(align - 1);
+	for (pg = base; pg < base + num; ++pg) {
+		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
+			base = sparsebit_next_set(region->unused_phy_pages, pg);
+			if (!base) {
+				fprintf(stderr, "No guest physical page available, "
+					"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
+					min_gpa, vm->page_size, memslot);
+				fputs("---- vm dump ----\n", stderr);
+				vm_dump(stderr, vm, 2);
+				abort();
 			}
+			goto again;
 		}
-	} while (pg && pg != base + num);
-
-	if (pg == 0) {
-		fprintf(stderr, "No guest physical page available, "
-			"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
-			min_gpa, vm->page_size, memslot);
-		fputs("---- vm dump ----\n", stderr);
-		vm_dump(stderr, vm, 2);
-		abort();
 	}
 
 	for (pg = base; pg < base + num; ++pg) {
-- 
2.39.5

