Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA93932C0
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113202; cv=none; b=XJrQ+dQY3JAJVXaEqkMBY+YA0dgFrS7TnQGzHB721ort45xCFm/TyHLNEGTBCjXXMtFa6uABeC1Zm0cZWpBMqcxWLYoy3oRVntMP8Q4Q3WfQOlLkdNlfMbgKJPkGzn0ieZLbqsX1Sw9MGpXb10mHZp6ETadzwtW8PCHnsx4dIMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113202; c=relaxed/simple;
	bh=ppikUFG9Hzais7xMS4QlMyIbHD6ZlLauMGYb8fV0ft0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KLwE/n8DIBNAPokYT0ICa8kpDJsFJWRcViwR6TPKSVgQVuLaytR2GTHb4i45/ebGgRZwtoU+Vj5pf9/bQ6iPIqqila8e7cflw8h1lYqXfpv6VsPIviY4PwrDttEFfqllugZKupNFTuCDQjpRRqlPcRN0rl33IUmU+ijLqWq3mj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KI8PBOor; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KI8PBOor"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35e56ed5d5bso2057761a91.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776113199; x=1776717999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nB+HzEvk9VbVCSV5Ggd1re8A1eYiv0Tpte2WUmC2NiM=;
        b=KI8PBOorLUhPoPXgCG4kdO1LZzUpHXi1uktU7a0jPN1vllzZTjow1wdYJ/7zSe6T2O
         SB0HxdSwmzolhv2/tB4h7UWTEQHIYFOvrW9uKiwEeeIQR5IOR4V2mb4EGjNl9zpue62s
         /OBp/4wNTr9i8sNok0YsT0Q59YvjhJJ8HS0KHzQRmn7v/Lyoi0kRgJ2wio1r7/LoRGn1
         k3Xpk1r4LZpHuJCYNJlZ3nhDHcPCb5FNxADnP661EWJMxoCis+vl9jXiwYjBQXocmMAQ
         VrCmn9RE6cNwZWoCziVpZIA+7dhiXijP4eE+vZCmc40H11GjOxXPy0JM1ohOe+R77Bsz
         wk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776113199; x=1776717999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nB+HzEvk9VbVCSV5Ggd1re8A1eYiv0Tpte2WUmC2NiM=;
        b=RcQpof2xby7h3HjLgN0KdEwrFz13yuOWNzn4MUbDls3SQhKmFLammtD/PNoLlcyxA1
         PkpzbgarE902q1G76lA5k2yIFATfdVex6XOXHyKEyg50qIh4frbV1SVqtU8MZvqJc8BT
         3t53tjcdmUQsPxfx8nxXVSqSLo0iXunz84SwivlelUGaMc6aaps/M4QUPo/5mbraOjum
         ETh03h2FsM5+IM3EMCBM7IuLuPj4cpG1k9Dl9IOTrNDqL3DwNtFV0iiE28f3Q+TwS0Hz
         ZLbaiZOTd5S142nDhpuGw+90+1yS4I3g/FdrUNsF/WIItJd0xr6KWxWtixTzZDGZ4mBz
         aKeg==
X-Gm-Message-State: AOJu0YyHJT71sAv8d4So+Hxe5M4QnC9Sp4UjtlvYEh4EenHcJP7hrdYo
	vdPJ1zDUKR0hkat1alnzoew1b5qXF8qLWxuf+pn8YRwhWg0BPIHWWK4aG1WtM+Kvy0Wg4vcP6hM
	iJYeZl/b/hgs3j3FjgZ3VIt0jUn5Oq15XUcNG3EU0elLqpqfTwFY5F95wu3QVuwusj2EvDcDGQB
	kX2u06MkHc+AfZ4yVsqFWzaeQsXXnxpiQY5kMXn5mxlusmDvsviV+NcHlFcGY=
X-Received: from pjhk63.prod.google.com ([2002:a17:90a:4cc5:b0:35f:c1cc:fee9])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2692:b0:35f:b4c1:91ea with SMTP id 98e67ed59e1d1-35fb4c19506mr4083596a91.13.1776113198802;
 Mon, 13 Apr 2026 13:46:38 -0700 (PDT)
Date: Mon, 13 Apr 2026 13:46:25 -0700
In-Reply-To: <20260413204630.1149038-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413204630.1149038-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260413204630.1149038-3-jingzhangos@google.com>
Subject: [kvm-unit-tests PATCH v2 2/7] lib: arm64: Add stage2 page table
 management library
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, Yao Yuan <yaoyuan@linux.alibaba.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Andrew Jones <andrew.jones@linux.dev>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Colton Lewis <coltonlewis@google.com>, 
	Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"

Tests running at EL2 (hypervisor level) often require the ability to
manage Stage 2 translation tables to control Guest Physical Address (IPA)
to Host Physical Address (PA) translation.

Add a generic Stage 2 MMU library that provides software management of
ARM64 Stage 2 translation tables.

The library features include:
- Support for 4K, 16K, and 64K translation granules.
- Dynamic page table allocation using the allocator.
- Support for 2M block mappings where applicable.
- APIs for mapping, unmapping, enabling, and disabling the Stage 2 MMU.
- Basic fault info reporting (ESR, FAR, HPFAR).

This infrastructure is necessary for upcoming virtualization and
hypervisor-mode tests.

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 arm/Makefile.arm64         |   1 +
 lib/arm64/asm/stage2_mmu.h |  70 +++++++
 lib/arm64/stage2_mmu.c     | 403 +++++++++++++++++++++++++++++++++++++
 3 files changed, 474 insertions(+)
 create mode 100644 lib/arm64/asm/stage2_mmu.h
 create mode 100644 lib/arm64/stage2_mmu.c

diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
index a40c830d..5e50f5ba 100644
--- a/arm/Makefile.arm64
+++ b/arm/Makefile.arm64
@@ -40,6 +40,7 @@ cflatobjs += lib/arm64/stack.o
 cflatobjs += lib/arm64/processor.o
 cflatobjs += lib/arm64/spinlock.o
 cflatobjs += lib/arm64/gic-v3-its.o lib/arm64/gic-v3-its-cmd.o
+cflatobjs += lib/arm64/stage2_mmu.o
 
 ifeq ($(CONFIG_EFI),y)
 cflatobjs += lib/acpi.o
diff --git a/lib/arm64/asm/stage2_mmu.h b/lib/arm64/asm/stage2_mmu.h
new file mode 100644
index 00000000..a5324108
--- /dev/null
+++ b/lib/arm64/asm/stage2_mmu.h
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) 2026, Google LLC.
+ * Author: Jing Zhang <jingzhangos@google.com>
+ *
+ * SPDX-License-Identifier: LGPL-2.0-or-later
+ */
+#ifndef _ASMARM64_STAGE2_MMU_H_
+#define _ASMARM64_STAGE2_MMU_H_
+
+#include <libcflat.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+#define pte_is_table(pte)	(pte_val(pte) & PTE_TABLE_BIT)
+
+/* Stage-2 Memory Attributes (MemAttr[3:0]) */
+#define S2_MEMATTR_NORMAL	(0xFUL << 2) /* Normal Memory, Outer/Inner Write-Back */
+#define S2_MEMATTR_DEVICE	(0x0UL << 2) /* Device-nGnRnE */
+
+/* Stage-2 Access Permissions (S2AP[1:0]) */
+#define S2AP_NONE	(0UL << 6)
+#define S2AP_RO		(1UL << 6) /* Read-only */
+#define S2AP_WO		(2UL << 6) /* Write-only */
+#define S2AP_RW		(3UL << 6) /* Read-Write */
+
+/* Flags for mapping */
+#define S2_MAP_RW	(S2AP_RW | S2_MEMATTR_NORMAL | PTE_AF | PTE_SHARED)
+#define S2_MAP_DEVICE	(S2AP_RW | S2_MEMATTR_DEVICE | PTE_AF)
+
+enum s2_granule {
+	S2_PAGE_4K,
+	S2_PAGE_16K,
+	S2_PAGE_64K,
+};
+
+/* Main Stage-2 MMU Structure */
+struct s2_mmu {
+	pgd_t *pgd;
+	int vmid;
+
+	/* Configuration */
+	enum s2_granule granule;
+	bool allow_block_mappings;
+
+	/* Internal helpers calculated from granule & VA_BITS */
+	unsigned int page_shift;
+	unsigned int level_shift;
+	int root_level; /* 0, 1, or 2 */
+	unsigned long page_size;
+	unsigned long block_size;
+};
+
+/* API */
+/* Initialize an s2_mmu struct with specific settings */
+struct s2_mmu *s2mmu_init(int vmid, enum s2_granule granule, bool allow_block_mappings);
+
+/* Management */
+void s2mmu_destroy(struct s2_mmu *mmu);
+void s2mmu_map(struct s2_mmu *mmu, unsigned long ipa, unsigned long pa,
+	       unsigned long size, unsigned long flags);
+void s2mmu_unmap(struct s2_mmu *mmu, unsigned long ipa, unsigned long size);
+
+/* Activation */
+void s2mmu_enable(struct s2_mmu *mmu);
+void s2mmu_disable(struct s2_mmu *mmu);
+
+/* Debug */
+void s2mmu_print_fault_info(void);
+
+#endif /* _ASMARM64_STAGE2_MMU_H_ */
diff --git a/lib/arm64/stage2_mmu.c b/lib/arm64/stage2_mmu.c
new file mode 100644
index 00000000..cf419e28
--- /dev/null
+++ b/lib/arm64/stage2_mmu.c
@@ -0,0 +1,403 @@
+/*
+ * Copyright (C) 2026, Google LLC.
+ * Author: Jing Zhang <jingzhangos@google.com>
+ *
+ * SPDX-License-Identifier: LGPL-2.0-or-later
+ */
+#include <libcflat.h>
+#include <alloc.h>
+#include <asm/stage2_mmu.h>
+#include <asm/sysreg.h>
+#include <asm/io.h>
+#include <asm/barrier.h>
+#include <alloc_page.h>
+
+/* VTCR_EL2 Definitions */
+#define VTCR_SH0_INNER		(3UL << 12)
+#define VTCR_ORGN0_WBWA		(1UL << 10)
+#define VTCR_IRGN0_WBWA		(1UL << 8)
+
+/* TG0 Encodings */
+#define VTCR_TG0_SHIFT		14
+#define VTCR_TG0_4K		(0UL << VTCR_TG0_SHIFT)
+#define VTCR_TG0_64K		(1UL << VTCR_TG0_SHIFT)
+#define VTCR_TG0_16K		(2UL << VTCR_TG0_SHIFT)
+
+/* Physical Address Size (PS) - Derive from VA_BITS for simplicity or max */
+#define VTCR_PS_SHIFT		16
+#if VA_BITS > 40
+#define VTCR_PS_VAL		(5UL << VTCR_PS_SHIFT) /* 48-bit PA */
+#else
+#define VTCR_PS_VAL		(2UL << VTCR_PS_SHIFT) /* 40-bit PA */
+#endif
+
+struct s2_mmu *s2mmu_init(int vmid, enum s2_granule granule, bool allow_block_mappings)
+{
+	struct s2_mmu *mmu = calloc(1, sizeof(struct s2_mmu));
+	int order = 0;
+
+	mmu->vmid = vmid;
+	mmu->granule = granule;
+	mmu->allow_block_mappings = allow_block_mappings;
+
+	/* Configure shifts based on granule */
+	switch (granule) {
+	case S2_PAGE_4K:
+		mmu->page_shift = 12;
+		mmu->level_shift = 9;
+		/*
+		 * Determine Root Level for 4K:
+		 * VA_BITS > 39 (e.g. 48) -> Start L0
+		 * VA_BITS <= 39 (e.g. 32, 36) -> Start L1
+		 */
+		mmu->root_level = (VA_BITS > 39) ? 0 : 1;
+		break;
+	case S2_PAGE_16K:
+		mmu->page_shift = 14;
+		mmu->level_shift = 11;
+		/*
+		 * 16K: L1 covers 47 bits. L0 not valid for 16K
+		 * Start L1 for 47 bits. Start L2 for 36 bits.
+		 */
+		mmu->root_level = (VA_BITS > 36) ? 1 : 2;
+		break;
+	case S2_PAGE_64K:
+		mmu->page_shift = 16;
+		mmu->level_shift = 13;
+		/* 64K: L1 covers 52 bits. L2 covers 42 bits. */
+		mmu->root_level = (VA_BITS > 42) ? 1 : 2;
+		break;
+	}
+
+	mmu->page_size = 1UL << mmu->page_shift;
+	mmu->block_size = 1UL << (mmu->page_shift + mmu->level_shift);
+
+	/* Alloc PGD. Use order for allocation size */
+	if (mmu->page_size > PAGE_SIZE) {
+		order = __builtin_ctz(mmu->page_size / PAGE_SIZE);
+	}
+	mmu->pgd = (pgd_t *)alloc_pages(order);
+	if (mmu->pgd) {
+		memset(mmu->pgd, 0, mmu->page_size);
+	} else {
+		free(mmu);
+		return NULL;
+	}
+
+	return mmu;
+}
+
+static unsigned long s2mmu_get_addr_mask(struct s2_mmu *mmu)
+{
+	switch (mmu->granule) {
+	case S2_PAGE_16K:
+		return GENMASK_ULL(47, 14);
+	case S2_PAGE_64K:
+		return GENMASK_ULL(47, 16);
+	default:
+		return GENMASK_ULL(47, 12); /* 4K */
+	}
+}
+
+static void s2mmu_free_tables(struct s2_mmu *mmu, pte_t *table, int level)
+{
+	unsigned long entries = 1UL << mmu->level_shift;
+	unsigned long mask = s2mmu_get_addr_mask(mmu);
+	unsigned long i;
+
+	/*
+	 * Recurse if not leaf level
+	 * Level 3 is always leaf page. Levels 0-2 can be Table or Block.
+	 */
+	if (level < 3) {
+		for (i = 0; i < entries; i++) {
+			pte_t entry = table[i];
+			if ((pte_valid(entry) && pte_is_table(entry))) {
+				pte_t *next = (pte_t *)phys_to_virt(pte_val(entry) & mask);
+				s2mmu_free_tables(mmu, next, level + 1);
+			}
+		}
+	}
+
+	free_pages(table);
+}
+
+void s2mmu_destroy(struct s2_mmu *mmu)
+{
+	if (mmu->pgd)
+		s2mmu_free_tables(mmu, (pte_t *)mmu->pgd, mmu->root_level);
+	free(mmu);
+}
+
+void s2mmu_enable(struct s2_mmu *mmu)
+{
+	unsigned long vtcr = VTCR_PS_VAL | VTCR_SH0_INNER |
+			     VTCR_ORGN0_WBWA | VTCR_IRGN0_WBWA;
+	unsigned long t0sz = 64 - VA_BITS;
+	unsigned long vttbr;
+
+	switch (mmu->granule) {
+	case S2_PAGE_4K:
+		vtcr |= VTCR_TG0_4K;
+		/* SL0 Encodings for 4K: 0=L2, 1=L1, 2=L0 */
+		if (mmu->root_level == 0)
+			vtcr |= (2UL << 6); /* Start L0 */
+		else if (mmu->root_level == 1)
+			vtcr |= (1UL << 6); /* Start L1 */
+		else
+			vtcr |= (0UL << 6); /* Start L2 */
+		break;
+	case S2_PAGE_16K:
+		vtcr |= VTCR_TG0_16K;
+		/* SL0 Encodings for 16K: 0=L3(Res), 1=L2, 2=L1, 3=L0(Res) */
+		if (mmu->root_level == 1)
+			vtcr |= (2UL << 6); /* Start L1 */
+		else
+			vtcr |= (1UL << 6); /* Start L2 */
+		break;
+	case S2_PAGE_64K:
+		vtcr |= VTCR_TG0_64K;
+		/* SL0 Encodings for 64K: 0=L3(Res), 1=L2, 2=L1, 3=L0(Res) */
+		if (mmu->root_level == 1)
+			vtcr |= (2UL << 6); /* Start L1 */
+		else
+			vtcr |= (1UL << 6); /* Start L2 */
+		break;
+	}
+
+	vtcr |= t0sz;
+
+	write_sysreg(vtcr, vtcr_el2);
+
+	/* Setup VTTBR */
+	vttbr = virt_to_phys(mmu->pgd);
+	vttbr |= ((unsigned long)mmu->vmid << 48);
+	write_sysreg(vttbr, vttbr_el2);
+
+	asm volatile("tlbi vmalls12e1is");
+
+	dsb(ish);
+	isb();
+}
+
+void s2mmu_disable(struct s2_mmu *mmu)
+{
+	write_sysreg(0, vttbr_el2);
+	isb();
+}
+
+static pte_t *get_pte(struct s2_mmu *mmu, pte_t *table, unsigned long idx, bool alloc)
+{
+	unsigned long mask = s2mmu_get_addr_mask(mmu);
+	pte_t entry = table[idx];
+	pte_t *next_table;
+	int order = 0;
+
+	if (pte_valid(entry)) {
+		if (pte_is_table(entry))
+			return (pte_t *)phys_to_virt(pte_val(entry) & mask);
+		/* Block Entry */
+		return NULL;
+	}
+
+	if (!alloc)
+		return NULL;
+
+	/* Allocate table memory covering the Stage-2 Granule size */
+	if (mmu->page_size > PAGE_SIZE)
+		order = __builtin_ctz(mmu->page_size / PAGE_SIZE);
+
+	next_table = (pte_t *)alloc_pages(order);
+	if (next_table)
+		memset(next_table, 0, mmu->page_size);
+
+	pte_val(entry) = virt_to_phys(next_table) | PTE_TABLE_BIT | PTE_VALID;
+	WRITE_ONCE(table[idx], entry);
+
+	return next_table;
+}
+
+void s2mmu_map(struct s2_mmu *mmu, unsigned long ipa, unsigned long pa,
+	       unsigned long size, unsigned long flags)
+{
+	unsigned long level_mask, level_shift, level_size, level;
+	unsigned long start_ipa, end_ipa, idx;
+	pte_t entry, *table, *next_table;
+	bool is_block_level;
+
+	start_ipa = ipa;
+	end_ipa = ipa + size;
+	level_mask = (1UL << mmu->level_shift) - 1;
+
+	while (start_ipa < end_ipa) {
+		table = (pte_t *)mmu->pgd;
+
+		/* Walk from Root to Leaf */
+		for (level = mmu->root_level; level < 3; level++) {
+			level_shift = mmu->page_shift + (3 - level) * mmu->level_shift;
+			idx = (start_ipa >> level_shift) & level_mask;
+			level_size = 1UL << level_shift;
+
+			/*
+			 * Check for Block Mapping
+			 * Valid Block Levels:
+			 * 4K:  L1 (1G), L2 (2MB)
+			 * 16K: L2 (32MB)
+			 * 64K: L2 (512MB)
+			 */
+			is_block_level = (level == 2) ||
+				(mmu->granule == S2_PAGE_4K && level == 1);
+
+			if (mmu->allow_block_mappings && is_block_level) {
+				if ((start_ipa & (level_size - 1)) == 0 &&
+				    (pa & (level_size - 1)) == 0 &&
+				    (start_ipa + level_size) <= end_ipa) {
+					/* Map Block */
+					pte_val(entry) = (pa & ~(level_size - 1)) |
+							 flags | PTE_VALID;
+					WRITE_ONCE(table[idx], entry);
+					start_ipa += level_size;
+					pa += level_size;
+					goto next_chunk; /* Continue outer loop */
+				}
+			}
+
+			/* Move to next level */
+			next_table = get_pte(mmu, table, idx, true);
+			if (!next_table) {
+				printf("Error allocating or existing block conflict.\n");
+				return;
+			}
+			table = next_table;
+		}
+
+		/* Leaf Level (Level 3 PTE) */
+		if (level == 3) {
+			idx = (start_ipa >> mmu->page_shift) & level_mask;
+			pte_val(entry) = (pa & ~(mmu->page_size - 1)) | flags | PTE_TYPE_PAGE;
+			WRITE_ONCE(table[idx], entry);
+			start_ipa += mmu->page_size;
+			pa += mmu->page_size;
+		}
+
+next_chunk:
+		continue;
+	}
+
+	asm volatile("tlbi vmalls12e1is");
+	dsb(ish);
+	isb();
+}
+
+/*
+ * Recursive helper to unmap a range within a specific table.
+ * Returns true if the table at this level is now completely empty
+ * and should be freed by the caller.
+ */
+static bool s2mmu_unmap_level(struct s2_mmu *mmu, pte_t *table,
+			      unsigned long current_ipa, int level,
+			      unsigned long start_ipa, unsigned long end_ipa,
+			      unsigned long mask)
+{
+	unsigned long level_size, entry_ipa, entry_end;
+	bool child_empty, table_empty = true;
+	pte_t entry, *next_table;
+	unsigned int level_shift;
+	unsigned long i;
+
+	/* Calculate shift and size for this level */
+	if (level == 3) {
+		level_shift = mmu->page_shift;
+	} else {
+		level_shift = mmu->page_shift + (3 - level) * mmu->level_shift;
+	}
+	level_size = 1UL << level_shift;
+
+	/* Iterate over all entries in this table */
+	for (i = 0; i < (1UL << mmu->level_shift); i++) {
+		entry = table[i];
+		entry_ipa = current_ipa + (i * level_size);
+		entry_end = entry_ipa + level_size;
+
+		/* Skip entries completely outside our target range */
+		if (entry_end <= start_ipa || entry_ipa >= end_ipa) {
+			if (pte_valid(entry))
+				table_empty = false;
+			continue;
+		}
+
+		/*
+		 * If the entry is fully covered by the unmap range,
+		 * we can clear it (leaf) or recurse and free (table).
+		 */
+		if (entry_ipa >= start_ipa && entry_end <= end_ipa) {
+			if (pte_valid(entry)) {
+				if (pte_is_table(entry) && level < 3) {
+					/* Recurse to free children first */
+					next_table = (pte_t *)phys_to_virt(pte_val(entry) & mask);
+					s2mmu_free_tables(mmu, next_table, level + 1);
+				}
+				/* Invalidate the entry */
+				WRITE_ONCE(table[i], __pte(0));
+			}
+			continue;
+		}
+
+		/*
+		 * Partial overlap: This must be a table (split required).
+		 * If it's a Block, we can't split easily in this context
+		 * without complex logic, so we generally skip or fail.
+		 * Assuming standard breakdown: recurse into the table.
+		 */
+		if (pte_valid(entry) && pte_is_table(entry) && level < 3) {
+			next_table = (pte_t *)phys_to_virt(pte_val(entry) & mask);
+			child_empty = s2mmu_unmap_level(mmu, next_table, entry_ipa, level + 1,
+							start_ipa, end_ipa, mask);
+
+			if (child_empty) {
+				free_pages(next_table);
+				WRITE_ONCE(table[i], __pte(0));
+			} else {
+				table_empty = false;
+			}
+		} else if (pte_valid(entry)) {
+			/*
+			 * Overlap on a leaf/block entry that extends
+			 * beyond the unmap range. We cannot simply clear it.
+			 */
+			table_empty = false;
+		}
+	}
+
+	return table_empty;
+}
+
+void s2mmu_unmap(struct s2_mmu *mmu, unsigned long ipa, unsigned long size)
+{
+	unsigned long end_ipa = ipa + size;
+	unsigned long mask = s2mmu_get_addr_mask(mmu);
+
+	if (!mmu->pgd)
+		return;
+
+	/*
+	 * Start recursion from the root level.
+	 * We rarely free the PGD itself unless destroying the MMU,
+	 * so we ignore the return value here.
+	 */
+	s2mmu_unmap_level(mmu, (pte_t *)mmu->pgd, 0, mmu->root_level,
+			  ipa, end_ipa, mask);
+
+	/* Ensure TLB invalidation occurs after page table updates */
+	asm volatile("tlbi vmalls12e1is");
+	dsb(ish);
+	isb();
+}
+
+void s2mmu_print_fault_info(void)
+{
+	unsigned long esr = read_sysreg(esr_el2);
+	unsigned long far = read_sysreg(far_el2);
+	unsigned long hpfar = read_sysreg(hpfar_el2);
+	printf("Stage-2 Fault Info: ESR=0x%lx FAR=0x%lx HPFAR=0x%lx\n", esr, far, hpfar);
+}
-- 
2.53.0.1213.gd9a14994de-goog

