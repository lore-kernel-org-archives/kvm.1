Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E333C0624
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716418; cv=none; b=Upf4nls5Jt8A560Y8HQ+U8NOoGlcPOA6f6d4zE/ftiCWom8GL/6h8JTgPr3LeEOrnX1go1NvvlSTp+H5P8bZAyIFuXEe1SbpFbbtDkRNFy6T/PViol4VTqBOjNf2ldlGoR994aijQgU9m39MhdLC/qQ/dL3NHo/9Bf3ZYAhYiDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716418; c=relaxed/simple;
	bh=j0Re39X5EzptSkn+keySa8RUS2nsQvmKZ/5s6481OKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BzatP4cyUln4f28UE1FrHP0DxkLVTj+4nsk3hFM+UnjMcxM+QeTVF96IDzWHGeclcjjEsgzo4qx/UBeKYl8RjJitUeGN+W9ZSJNubbR743dskUQX2o712lCC1LrqnvviuWV4ASYpqwem771k223mlk5aJUV985VhNAZ3UD7I+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qCnf5Fld; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCnf5Fld"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2ddb44ad1c1so3275675ad.3
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 00:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789716408; x=1790321208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r0TiBnW0QZCej4PmxwEbVRI0oUSu1J4v1QwXVJOCioo=;
        b=qCnf5Fld7IE/GDBfrMQFkuINinH2umGDB20GkF5e5JJf7lEw8yAF2ztNLWnpxHBNIU
         LvLc1O47HWhFJg59rx5b+frRO89VL6zUYnygWYRKcVyvdyUTxZJRmyO+ishx5Nuwlmbz
         cKGpjvjGtD0HkIvA0LZU80e9aqI1NSTy/2swptrfXnkWi5+Q3PBCHVYY0aJ57egFotjV
         zlJiObUJ1hDfnZKpp9HLDRyWOr/nM4BWnLW0xIRfWx83U/idT0BAfTXlXgLqyDEPX93/
         BuPUStMCSu9lnXmGGmgYmwqWPf/qr4p1AMutDIC51dz+Xw8yrPY9TE0njVXRxcq84EXH
         Gn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789716408; x=1790321208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r0TiBnW0QZCej4PmxwEbVRI0oUSu1J4v1QwXVJOCioo=;
        b=UO7yB03fR7kZraIMAQP3PCATj8zfcI/JQ/+ohAl9PMb1y3zUoE9vkDly93R+K/Im1R
         bxgYs28ozkhyMkI6ErckOJMrYVnt7qk+PsDhjN/4+wkVVuczTvc/efXjFnnI6Bt4zpoK
         Q8FIE7BlcsLxQfqRo6OeYx2D0h7zwsiZes+M/wMxONPEcOGaITha7qPLJL1XQiZGhUsl
         lSECDhKRUu6WK9BKrPvuABhp/yTr9A2gRNox2GS3Y02c4AdMe8gFc6z0I+w9XSF0XRim
         GX2UFeTK6/0dZa3RlhCF3whHWQ6DGsq4FXObVjjeehRcBRXzUWKRmiZ/u1gecq0MZuWc
         kfoQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8o79qw2wRlqRxcuODghCCNOzHyp1K95PL4Me9YZGyHCHeu6CszotrBFITozffMJhoOck=@vger.kernel.org
X-Gm-Message-State: AFuF++nowt4tovIIB72KE8yvuQB161b46Ub8NAhMIGV9JzFc9Oqyw+lx
	bNMO+ls2thqZVB/ZJZ9nuTYOGyOT2Fjvgf2MQ+QkG+j4eBDu6OB8VZWB
X-Gm-Gg: AYBFou0XYo8jXg7DG1gAbJLSjGMdYH8jEwTn1i/4D0foqHZdR3yGXO3ugt2+tlniSCy
	zc2a07hQsbAXT1UiHWUsTMlw960mC6KF63oBlNSfmaEafQmHmAzjCr5UiGVc0GJMw5cnUxBKXDu
	Rj2nUh1fADj25sCzcyBVkDZqFFbRZEHmJztVehODHkJ57n2wryCelUqZjsdHcc6Mleb6hOjaK8c
	2ON8SC0UyrJZI+EVd0cfngoGJcfJsTU+3G9PANgRxqzUZyVUhUn0U2Q/ffAQhrQGWm0fQTqYIgT
	u9JC7uAfJ0gE/2HxjeTU6eVtq9Fx/U17F6CZ4aXOj9gtFmowCoP+3WW3JXBwSl3HSTueT4zYw+a
	w0hsoYCNnZwfhiGeIxaUNv6UOMMWRCzjZrYODQN7jhedxS34E2RsamJzkpxPKYJ4jkdj5leisC2
	QuuN4bcEsHhHy2bx9yM1sphz6Tp5EtwccXhGdYPU7a0+fyvGUcKnThjXHoQchRvIrpMUWfvPAsV
	EszwuD9XHn2tmNCNgrYl8w=
X-Received: by 2002:a17:902:da85:b0:2d9:3083:a3ac with SMTP id d9443c01a7336-2ddb7420950mr15441415ad.15.1789716407615;
        Fri, 18 Sep 2026 00:26:47 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb73dae10sm3772535ad.1.2026.09.18.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 00:26:45 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jinyu Tang <tjytimi@163.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH] KVM: riscv: Age all G-stage PTEs in a GFN range
Date: Fri, 18 Sep 2026 16:26:22 +0900
Message-ID: <20260918072622.284188-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_age_gfn() and kvm_test_age_gfn() only operate on the G-stage
leaf covering range->start. They also warn unless the range size is
exactly 4K, 2M, or 1G.

The MM can pass larger ranges when batching the PTEs of a large folio.
For example, a 64K mTHP range triggers the warning and only the first
4K leaf is aged, leaving the Accessed bits of the remaining leaves
unchanged.

This can be reproduced on an rv64 host with Svadu by disabling 2M THP,
enabling 64K mTHP, and running:

access_tracking_perf_test -s anonymous_thp

This results in:

WARNING: arch/riscv/kvm/mmu.c:362 at kvm_age_gfn+0x210/0x370
...
[<ffffffff800c8fc8>] kvm_age_gfn+0x210/0x370
[<ffffffff80095c90>] kvm_mmu_notifier_clear_young+0x250/0x478
[<ffffffff80ae532e>] __mmu_notifier_clear_young+0xde/0x1a0
[<ffffffff80932f76>] walk_pud_range+0x86e/0x1688
[<ffffffff80a18720>] walk_pgd_range+0x518/0x17b0
[<ffffffff80a19aa2>] __walk_page_range+0xea/0x580
[<ffffffff80a1a422>] walk_page_range+0x3a/0x80
[<ffffffff80931dc0>] try_to_inc_max_seq+0x520/0xe68
[<ffffffff80939dc0>] lru_gen_seq_write+0xd08/0x1310

Walk all G-stage leaves in the requested range. Advance by the leaf
size when a mapping is found, or by the size of the non-present region
at the level where the walk stopped. When testing the age, return as
soon as a young leaf is found.

Remove the range-size warning since arbitrary GFN ranges are valid.

Fixes: 9955371cc014 ("RISC-V: KVM: Implement MMU notifiers")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 arch/riscv/include/asm/kvm_gstage.h |  2 ++
 arch/riscv/kvm/gstage.c             | 34 +++++++++++++++++++++++++++++
 arch/riscv/kvm/mmu.c                | 22 ++++---------------
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index aaf080ba1b77..a03db1a10095 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -81,6 +81,8 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
 				  gpa_t start, gpa_t size, bool may_block);
 
 bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end);
+bool kvm_riscv_gstage_age_range(struct kvm_gstage *gstage, gpa_t start,
+				gpa_t end, bool test_only);
 
 bool kvm_riscv_gstage_wp_pt_masked(struct kvm_gstage *gstage, gfn_t base_gfn,
 				   unsigned long mask);
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index e5002cb9cbef..f61ba434093c 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -485,6 +485,40 @@ bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
 	return flush;
 }
 
+bool kvm_riscv_gstage_age_range(struct kvm_gstage *gstage, gpa_t start,
+				gpa_t end, bool test_only)
+{
+	unsigned long page_size;
+	bool young = false;
+	gpa_t addr = start;
+	pte_t *ptep;
+	u32 level;
+	bool found;
+
+	while (addr < end) {
+		found = kvm_riscv_gstage_get_leaf(gstage, addr, &ptep, &level);
+		if (gstage_level_to_page_size(gstage, level, &page_size))
+			break;
+
+		if (found) {
+			if (test_only) {
+				if (pte_young(ptep_get(ptep)))
+					return true;
+			} else {
+				young |= ptep_test_and_clear_young(NULL, 0, ptep);
+			}
+		}
+
+		/*
+		 * Advance past this leaf, or past the non-present region at
+		 * the level where the walk stopped.
+		 */
+		addr = ALIGN_DOWN(addr, page_size) + page_size;
+	}
+
+	return young;
+}
+
 static inline void clear_huge_mask(unsigned long *mask, unsigned long page_size,
 				   gfn_t base_gfn, gpa_t addr)
 {
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 3e955d808743..342f606399e5 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -351,42 +351,28 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 
 bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	pte_t *ptep;
-	u32 ptep_level = 0;
-	u64 size = (range->end - range->start) << PAGE_SHIFT;
 	struct kvm_gstage gstage;
 
 	if (!kvm->arch.pgd)
 		return false;
 
-	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
-
 	kvm_riscv_gstage_init(&gstage, kvm);
-	if (!kvm_riscv_gstage_get_leaf(&gstage, range->start << PAGE_SHIFT,
-				       &ptep, &ptep_level))
-		return false;
 
-	return ptep_test_and_clear_young(NULL, 0, ptep);
+	return kvm_riscv_gstage_age_range(&gstage, range->start << PAGE_SHIFT,
+					  range->end << PAGE_SHIFT, false);
 }
 
 bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	pte_t *ptep;
-	u32 ptep_level = 0;
-	u64 size = (range->end - range->start) << PAGE_SHIFT;
 	struct kvm_gstage gstage;
 
 	if (!kvm->arch.pgd)
 		return false;
 
-	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
-
 	kvm_riscv_gstage_init(&gstage, kvm);
-	if (!kvm_riscv_gstage_get_leaf(&gstage, range->start << PAGE_SHIFT,
-				       &ptep, &ptep_level))
-		return false;
 
-	return pte_young(ptep_get(ptep));
+	return kvm_riscv_gstage_age_range(&gstage, range->start << PAGE_SHIFT,
+					  range->end << PAGE_SHIFT, true);
 }
 
 static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,

base-commit: 41e81f7e3ef96594fb840445343c0ee7723aa550
-- 
2.52.0

