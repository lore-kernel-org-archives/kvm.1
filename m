Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA26F39D3C0
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785523; cv=none; b=ndxepKUsZD8Kbbq9HWklDIH9BuEE16ayoFaK/m42wKrhQWeXEUmFFL0ApR3PfNNU6ZwUCTdZ7MIgUuQak7qpZS/pB+pgYeejw+lR8X62LbOtdRY6aATAOAG2UIwQ4f2/QBRoouNKlj57AiD0YeJS19L3GLM2Dv7cNFCOL26DNT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785523; c=relaxed/simple;
	bh=qL5Msc494NJuKcmWE24vsAAjb+vMIGOu61VoiZ5Vfps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qUjdHDwS/45rfodywwcUVC+wlKfOHCehAc8t6HSvlVJKo6UyiLPcujXO/XJbd0BhgHVsnCuDAp13x7vQgBC4S/s3QGM/HmNth99cEBIY4wojKd2Rbo3OtdgZ9/qamfodO6Klty/oZEijZpIpqoHQ9+yjjEOnX9htvkiU/1HPXqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LeJLFcIG; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LeJLFcIG"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc6dd43737so21489395ad.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787785521; x=1788390321; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WTM/WcY6qCCrKYMU/D/LJJQp2BSUWxg1SxXMol0XzNo=;
        b=LeJLFcIG6SWg7rWGc3zC2ZZcIAXJ3Bepq7l0111sJ9JoGDHD/TtAo0qgEXMvYeasEL
         lfKqYjR3AOck0RicgN/9ltF3w5zKWUhDIZ595CI1op+VyJUK6SCjBooxpv8STnf6AzHo
         mI/k/NG6CvXm4120ba9CVaH/YaoSCiYlnOo2GCQXcDlzJA3hxDn4+UvSUPAe/CGkS/EY
         EEx2gy9qyB7lZCXkORw6gBsixkHT4DVRil/1ZP0e9cbF4Vu4GB9vxJfTW3D/r9F50QoK
         hdB6nEsls7hfdHxmzUq20RNvuX/jz5mgDuIZS89RhzdMe0VkEf1/5h669B/msZdTrzfY
         CFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785521; x=1788390321;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WTM/WcY6qCCrKYMU/D/LJJQp2BSUWxg1SxXMol0XzNo=;
        b=qoAtLyIHy4pgNVqF/mTij6NInTVZ5OEEIkruSktTQ9N+b1IeHb3Ucki2Pu3hoP8q8f
         hGvLFfvQdoHeTkctRjFMSDuQLg9a7cAb8jbPuxxkGhPtRBIBkoRD99XPJr/Ud/2gYXzD
         DeoVoPDKERdLbNvWXFxC0UGgOSwUjwDTj87mP6WFHdDsRwR7CRNglOc9nl1Uhj8BkRgu
         sHRdpsj8Vg+3pPzDSTdsMktHDiQ2vXDvlHJJJQ68BjdaNZ4ZrHkdA0tWErKNP00hLATf
         tRrnsNYEwzrmZLmaHxq1tlcdiHSH4NWUyZWzEZl8JdTXnkR6wPyesrX5I7HboA5/acuK
         tp+A==
X-Forwarded-Encrypted: i=1; AHgh+RrNUtD2rnFdK5zNDMyMf1GCOkM2p8W1LQrcFUGUu0uyvTuzMbpVA/dM2AC5GINwTtukzeQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mOxdDk7G5dv/ymqkQNlUiI6QRucv01+DJrt1AtGX0eYQYKWflm
	zS2iImOa0MzZu2fG/mKjZMvRs0HU/3y6qJ3lZyswTNd1kkluMxFljydXIJPd9PNpCZN/dL45ukP
	w15cslw==
X-Received: from plbkh8.prod.google.com ([2002:a17:903:648:b0:2cc:ed0e:f302])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64f:b0:2c9:fb11:1bf4
 with SMTP id d9443c01a7336-2d707aca8dcmr198971375ad.7.1787785520801; Wed, 26
 Aug 2026 16:05:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:04:55 -0700
In-Reply-To: <20260826230511.972824-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826230511.972824-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826230511.972824-5-seanjc@google.com>
Subject: [PATCH 04/20] KVM: selftests: Rename "num" param to "nr_pages" for
 physical page allocators
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Rename the "num" param in the physical page allocator APIs to "nr_pages" to
make the unit and role of the param more obvious.

Opportunistically rework the function comment to drop the superfluous
kerneldoc style, and to very explicitly call out that success is guaranteed.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  6 ++--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 35 ++++++-------------
 2 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 70906a0d1003..b1c5597b1def 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -991,11 +991,11 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 const char *exit_reason_str(unsigned int exit_reason);
 
 gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
-gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
+gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
 			   u32 memslot, bool protected);
 gpa_t vm_alloc_page_table(struct kvm_vm *vm);
 
-static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
+static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
 				       gpa_t min_gpa, u32 memslot)
 {
 	/*
@@ -1003,7 +1003,7 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	 * protected memory, as the majority of memory for such VMs is
 	 * protected, i.e. using shared memory is effectively opt-in.
 	 */
-	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
+	return __vm_phy_pages_alloc(vm, nr_pages, min_gpa, memslot,
 				    vm_arch_has_protected_memory(vm));
 }
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9ddc047d5c27..b071d77dd301 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2025,33 +2025,20 @@ const char *exit_reason_str(unsigned int exit_reason)
 }
 
 /*
- * Physical Contiguous Page Allocator
+ * Allocate contiguous (guest) physical pages in a given memory region, at or
+ * the minimum specific GPA.  If the memory is protected/private, also add the
+ * allocate pages to the region's set of protected pages, e.g. so that arch
+ * code knows which pages need to be encrypted when launching the VM.
  *
- * Input Args:
- *   vm - Virtual Machine
- *   num - number of pages
- *   min_gpa - Physical address minimum
- *   memslot - Memory region to allocate page from
- *   protected - True if the pages will be used as protected/private memory
- *
- * Output Args: None
- *
- * Return:
- *   Starting physical address
- *
- * Within the VM specified by vm, locates a range of available physical
- * pages at or above min_gpa. If found, the pages are marked as in use
- * and their base address is returned. A TEST_ASSERT failure occurs if
- * not enough pages are available at or above min_gpa.
+ * Note, success is guaranteed!
  */
-gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
-			   gpa_t min_gpa, u32 memslot,
-			   bool protected)
+gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
+			   u32 memslot, bool protected)
 {
 	struct userspace_mem_region *region;
 	sparsebit_idx_t pg, base;
 
-	TEST_ASSERT(num > 0, "Must allocate at least one page");
+	TEST_ASSERT(nr_pages, "Must allocate at least one page");
 
 	TEST_ASSERT((min_gpa % vm->page_size) == 0, "Min physical address "
 		"not divisible by page size.\n"
@@ -2064,13 +2051,13 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 
 	base = pg = min_gpa >> vm->page_shift;
 	do {
-		for (; pg < base + num; ++pg) {
+		for (; pg < base + nr_pages; ++pg) {
 			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
 				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
 				break;
 			}
 		}
-	} while (pg && pg != base + num);
+	} while (pg && pg != base + nr_pages);
 
 	if (pg == 0) {
 		fprintf(stderr, "No guest physical page available, "
@@ -2081,7 +2068,7 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 		abort();
 	}
 
-	for (pg = base; pg < base + num; ++pg) {
+	for (pg = base; pg < base + nr_pages; ++pg) {
 		sparsebit_clear(region->unused_phy_pages, pg);
 		if (protected)
 			sparsebit_set(region->protected_phy_pages, pg);
-- 
2.55.0.887.g758fc8c411-goog

