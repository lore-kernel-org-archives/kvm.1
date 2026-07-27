Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3465400987
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155453; cv=none; b=czwjro1dge71v5e3KGnXAMDK1mBwm936nSjvTZ5CQjVZfmHIjLXGH1DnMVXCa+mLOLgu41pqL/A91/ZV08ZBu4DbPZEJxD3f7rkZGjFw1EqOPPxYNaPOClL2Hr1F8mQC9rNvl6O5uTBWb3y8+SmRaBTbNJ3FZoYxWFz+LCfyAX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155453; c=relaxed/simple;
	bh=a9cseGEKNS2RwIeo6vbnbVI9Lsvkl+oXufZTT/0Pkr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OCvp7i54kjaNOwRIysgAW1BP6tdSbLaomGXyXqNDoz3rkPGvvil622MMTzVcIyW3UQv/juNPMkbgAjl0iEvZnOUcN+xP0j4TCfVM9PmbxfJ0IlxqBG1ZQlBAIsvEGaX1rjw3hKWUWT1NwO5/K17OkcRg660mrcCq4SySINt6Jug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUJwLu3t; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUJwLu3t"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2ccc2e84048so17879275ad.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 05:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785155451; x=1785760251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bB1CbnQvotvW8WSzD+zLHrkVmBxMDG/JqdR4Kr/X/Y8=;
        b=iUJwLu3tOf2BD+Usq2qs6Js8QzBJNawBvzfez1nzZOEcn56+FqPBkZ6Ur4xvGIYMVv
         JjJxUfDV6XgpzO+7SWEc8+yeQQNGw5PFXGn38cYhZqpVJEIRHLhr8FTzJ4XLMlqcWEgh
         xX7Oe36Ps0gp6Skv+j55HNOayT/6+qcM0U5LMufH6i0q5GOHYqSKMb3zjZ7UJUKRDHYZ
         s9EmHPziIuoNoV1sJc0W77lUCW0XQMdaJ1LwnmRdkMHEwb3ZjpXgees8X1C6A5RKft5J
         Jmu4RLn/Uthr8WHJDHJIo8rcAvCDgCWn/IswACTPCB/2+LZQyuxLqZ/KkTmiXDnQJNND
         sDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785155451; x=1785760251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bB1CbnQvotvW8WSzD+zLHrkVmBxMDG/JqdR4Kr/X/Y8=;
        b=n8LpYSQT99d/emf/PwwS6WxWlRFl1RMT2oKg8447d8DYJM1/eoIOjioFX7TYwOxsXo
         CMN7XPxXAVeyk9X7npR2oQf7Ql0mCMTzpSIArVa9MXlGG9wx8BbKjIjQ6ylO5ciqZKAQ
         bvoaYVDXjnSi6a6qPF8J7c4oGYPjjWcI9kOnK1B8Dk++EstR7uSp2r9IkcVKuXZybdDz
         9tp5k95gnD0+ml1+AWWysgZdEsL1xt5ZluWHCl10kR+2xLLvFJqHy8D/TG09mRpy4fMh
         amredJ4OoPVCjsLvWww0JRkquYMgh2zshmquoQ8SnEcRbcjj7m6pagj2/efbqfci6SXP
         vY9g==
X-Forwarded-Encrypted: i=1; AHgh+Rpxumds9HKTf135bYKJcfxy0ypPkEnRMQeUTu/TR4alMaaSAudeepdS3T7uoCAIco7sJ8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YytFgRsj8kiHm/M3zza8x3Xw+/e6efa0dWBz39HvNvNGhusmlur
	R7li4dSFEjbGyKwMaRzLRMB6B8YexGLgdAAsxd4kJbCx3BY4r3CKnxbO
X-Gm-Gg: AR+sD10O7nythcKq6iiZHyMihKM3ZkzN3VuxQmOo6zwvGor+fWvYpDPGH/Fn6HsgLOu
	mwcQbfZbj49CZ0C/Y6c28ZI9LTM1rvrdKtBtc4Mb9w2YNqexc2JWoQbtZqmCmIZVp4uP6IoL7DI
	RXAMMhhami0462u+blkqkSrXqeKwod1witUNT8YqBb2+afihUYkRmL3kLVkPVIG314DY+Aq+KkI
	7P26NmU41jQojC+/U7zqeQJiFKGai9xbSOkZ8/TzAPFYVH+63nonV98rtIcXjk2sHLpFxHqKLw4
	PUyWYTb6UmVq8s2Dneqv929n0UondwkSlXMvc/IATPrvvM0+RGWxY8P2YPYqLvF/GiOvF9dZ1zB
	SCibIB6wS+BGCg1dNYdrPJlw653Ua9/my+TXxgXwILcJzpayngC4jk/NNlGRZfzd0CnWhZ3yXbP
	XqYbOKKg==
X-Received: by 2002:a17:902:e945:b0:2cf:a5da:705e with SMTP id d9443c01a7336-2cfde883084mr76620255ad.41.1785155450006;
        Mon, 27 Jul 2026 05:30:50 -0700 (PDT)
Received: from wud.. ([218.194.32.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfe1ab9c71sm30679775ad.73.2026.07.27.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:30:49 -0700 (PDT)
From: "Dylan.Wu" <fredwudi0305@gmail.com>
To: palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	anup@brainfault.org
Cc: alex@ghiti.fr,
	atish.patra@linux.dev,
	zhouquan@iscas.ac.cn,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dylan.Wu" <fredwudi0305@gmail.com>
Subject: [PATCH v2 3/3] KVM: riscv: Register ptdump with debugfs on guest creation
Date: Mon, 27 Jul 2026 08:30:13 -0400
Message-Id: <20260727123013.118984-4-fredwudi0305@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727123013.118984-1-fredwudi0305@gmail.com>
References: <20260727123013.118984-1-fredwudi0305@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new RISC-V KVM specific ptdump implementation that dumps the
guest stage-2 (gstage) pagetables via debugfs. The code reuses the
common ptdump data structures and helpers from asm/ptdump.h, and
exposes a "gstage_page_tables" file in each guest VM's debugfs
directory (kvm->debugfs_dentry).

The gstage uses its own set of pg_level and prot_bits arrays (a
simplified set of V/R/W/X/D/A/G/U bits), and plugs these into the
generic ptdump_walk_pgd() walker just like the host kernel ptdump.

The kvm_arch_create_vm_debugfs() hook (overriding the weak default)
is used to register the debugfs file automatically on each VM
creation.

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dylan.Wu <fredwudi0305@gmail.com>
---
 arch/riscv/kvm/Kconfig  |  15 +++
 arch/riscv/kvm/Makefile |   1 +
 arch/riscv/kvm/ptdump.c | 276 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 292 insertions(+)
 create mode 100644 arch/riscv/kvm/ptdump.c

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index ec2cee0a3..9413110a4 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -37,4 +37,19 @@ config KVM
 
 	  If unsure, say N.
 
+config PTDUMP_GSTAGE_DEBUGFS
+	bool "Present the gstage pagetables to debugfs"
+	depends on KVM
+	depends on DEBUG_KERNEL
+	depends on DEBUG_FS
+	depends on PTDUMP_DEBUGFS
+	default n
+	help
+	  Say Y here if you want to show the RISC-V KVM gstage guest page tables
+	  layout in a debugfs file. This information is primarily useful for
+	  architecture-specific kernel developers and KVM maintainers to
+	  investigate memory mapping and permission issues. It is probably
+	  not a good idea to enable this feature in a production kernel.
+	  If in doubt, say N.
+
 endif # VIRTUALIZATION
diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index 296c2ba05..905593d6f 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -19,6 +19,7 @@ kvm-y += isa.o
 kvm-y += main.o
 kvm-y += mmu.o
 kvm-y += nacl.o
+kvm-$(CONFIG_PTDUMP_GSTAGE_DEBUGFS) += ptdump.o
 kvm-y += tlb.o
 kvm-y += vcpu.o
 kvm-y += vcpu_config.o
diff --git a/arch/riscv/kvm/ptdump.c b/arch/riscv/kvm/ptdump.c
new file mode 100644
index 000000000..83a92969b
--- /dev/null
+++ b/arch/riscv/kvm/ptdump.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 SiFive
+ * Debug helper to dump the KVM gstage page tables.
+ */
+
+#include <linux/init.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/string.h>
+#include <linux/ptdump.h>
+#include <linux/kvm_host.h>
+
+#include <linux/pgtable.h>
+#include <asm/ptdump.h>
+#include <asm/kvm_gstage.h>
+#include <asm/kvm_mmu.h>
+
+#define pt_dump_seq_printf(m, fmt, args...)	\
+({						\
+	if (m)					\
+		seq_printf(m, fmt, ##args);	\
+})
+
+#define pt_dump_seq_puts(m, fmt)	\
+({					\
+	if (m)				\
+		seq_puts(m, fmt);	\
+})
+
+/* Guest physical address markers (simplified for gstage) */
+enum gstage_address_markers_idx {
+	GSTAGE_GPA_START_NR,
+	GSTAGE_GPA_END_NR,
+	END_OF_GSTAGE_SPACE_NR
+};
+
+/* G-stage PTE bits */
+static const struct ptdump_prot_bits gstage_pte_bits[] = {
+	{
+		.mask = _PAGE_DIRTY,
+		.set = "D",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_ACCESSED,
+		.set = "A",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_GLOBAL,
+		.set = "G",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_USER,
+		.set = "U",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_EXEC,
+		.set = "X",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_WRITE,
+		.set = "W",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_READ,
+		.set = "R",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_PRESENT,
+		.set = "V",
+		.clear = ".",
+	}
+};
+
+static struct ptdump_pg_level gstage_pg_levels[] = {
+	{ /* pgd */
+		.bits = gstage_pte_bits,
+		.num = ARRAY_SIZE(gstage_pte_bits),
+		.name = "PGD",
+	}, { /* p4d */
+		.bits = gstage_pte_bits,
+		.num = ARRAY_SIZE(gstage_pte_bits),
+		.name = (CONFIG_PGTABLE_LEVELS > 4) ? "P4D" : "PGD",
+	}, { /* pud */
+		.bits = gstage_pte_bits,
+		.num = ARRAY_SIZE(gstage_pte_bits),
+		.name = (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
+	}, { /* pmd */
+		.bits = gstage_pte_bits,
+		.num = ARRAY_SIZE(gstage_pte_bits),
+		.name = (CONFIG_PGTABLE_LEVELS > 2) ? "PMD" : "PGD",
+	}, { /* pte */
+		.bits = gstage_pte_bits,
+		.num = ARRAY_SIZE(gstage_pte_bits),
+		.name = "PTE",
+	},
+};
+
+static void gstage_dump_prot(struct ptdump_pg_state *st)
+{
+	const struct ptdump_pg_level *lvl = &st->pg_level[st->level];
+	const struct ptdump_prot_bits *bits = lvl->bits;
+	unsigned int i;
+
+	for (i = 0; i < lvl->num; i++) {
+		char s[7];
+		unsigned long val;
+
+		val = st->current_prot & bits[i].mask;
+		if (val)
+			strscpy(s, bits[i].set);
+		else
+			strscpy(s, bits[i].clear);
+
+		pt_dump_seq_printf(st->seq, " %s", s);
+	}
+}
+
+#ifdef CONFIG_64BIT
+#define GSTAGE_ADDR_FORMAT	"0x%016lx"
+#else
+#define GSTAGE_ADDR_FORMAT	"0x%08lx"
+#endif
+static void gstage_dump_addr(struct ptdump_pg_state *st, unsigned long addr)
+{
+	static const char units[] = "KMGTPE";
+	const char *unit = units;
+	unsigned long delta;
+
+	pt_dump_seq_printf(st->seq, GSTAGE_ADDR_FORMAT "-" GSTAGE_ADDR_FORMAT "   ",
+			   st->start_address, addr);
+
+	pt_dump_seq_printf(st->seq, " " GSTAGE_ADDR_FORMAT " ", st->start_pa);
+	delta = (addr - st->start_address) >> 10;
+
+	while (!(delta & 1023) && unit[1]) {
+		delta >>= 10;
+		unit++;
+	}
+
+	pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
+			   st->pg_level[st->level].name);
+}
+
+static void gstage_note_page_gpa_prot(struct ptdump_pg_state *st, unsigned long addr)
+{
+	if (st->current_prot) {
+		gstage_dump_addr(st, addr);
+		gstage_dump_prot(st);
+		pt_dump_seq_puts(st->seq, "\n");
+	}
+}
+
+static void gstage_note_page(struct ptdump_state *pt_st, unsigned long addr,
+			     int level, u64 val)
+{
+	struct ptdump_pg_state *st = container_of(pt_st, struct ptdump_pg_state, ptdump);
+	u64 pa = PFN_PHYS(pte_pfn(__pte(val)));
+	u64 prot = 0;
+
+	if (level >= 0)
+		prot = val & st->pg_level[level].mask;
+
+	if (st->level == -1) {
+		st->level = level;
+		st->current_prot = prot;
+		st->start_address = addr;
+		st->start_pa = pa;
+		st->last_pa = pa;
+		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
+	} else if (prot != st->current_prot ||
+		   level != st->level || addr >= st->marker[1].start_address) {
+		gstage_note_page_gpa_prot(st, addr);
+
+		while (addr >= st->marker[1].start_address) {
+			st->marker++;
+			pt_dump_seq_printf(st->seq, "---[ %s ]---\n",
+					   st->marker->name);
+		}
+
+		st->start_address = addr;
+		st->start_pa = pa;
+		st->last_pa = pa;
+		st->current_prot = prot;
+		st->level = level;
+	} else {
+		st->last_pa = pa;
+	}
+}
+
+static void gstage_note_page_pte(struct ptdump_state *pt_st, unsigned long addr, pte_t pte)
+{
+	gstage_note_page(pt_st, addr, 4, pte_val(pte));
+}
+
+static void gstage_note_page_pmd(struct ptdump_state *pt_st, unsigned long addr, pmd_t pmd)
+{
+	gstage_note_page(pt_st, addr, 3, pmd_val(pmd));
+}
+
+static void gstage_note_page_pud(struct ptdump_state *pt_st, unsigned long addr, pud_t pud)
+{
+	gstage_note_page(pt_st, addr, 2, pud_val(pud));
+}
+
+static void gstage_note_page_p4d(struct ptdump_state *pt_st, unsigned long addr, p4d_t p4d)
+{
+	gstage_note_page(pt_st, addr, 1, p4d_val(p4d));
+}
+
+static void gstage_note_page_pgd(struct ptdump_state *pt_st, unsigned long addr, pgd_t pgd)
+{
+	gstage_note_page(pt_st, addr, 0, pgd_val(pgd));
+}
+
+static void gstage_note_page_flush(struct ptdump_state *pt_st)
+{
+	pte_t pte_zero = {0};
+
+	gstage_note_page(pt_st, 0, -1, pte_val(pte_zero));
+}
+
+static int gstage_ptdump_show(struct seq_file *m, void *v)
+{
+	struct kvm *kvm = m->private;
+	gpa_t gpa_size = kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels);
+	struct addr_marker gpa_markers[] = {
+		[GSTAGE_GPA_START_NR] = { 0, "Guest Physical Address Start" },
+		[GSTAGE_GPA_END_NR]   = { gpa_size - 1, "Guest Physical Address End" },
+		[END_OF_GSTAGE_SPACE_NR] = { -1, NULL },
+	};
+	struct ptdump_pg_state st = {
+		.seq = m,
+		.marker = gpa_markers,
+		.level = -1,
+		.pg_level = gstage_pg_levels,
+		.ptdump = {
+			.note_page_pte = gstage_note_page_pte,
+			.note_page_pmd = gstage_note_page_pmd,
+			.note_page_pud = gstage_note_page_pud,
+			.note_page_p4d = gstage_note_page_p4d,
+			.note_page_pgd = gstage_note_page_pgd,
+			.note_page_flush = gstage_note_page_flush,
+			.range = (struct ptdump_range[]) {
+				{0, gpa_size - 1},
+				{0, 0}
+			}
+		}
+	};
+	unsigned int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(gstage_pg_levels); i++) {
+		gstage_pg_levels[i].mask = 0;
+		for (j = 0; j < ARRAY_SIZE(gstage_pte_bits); j++)
+			gstage_pg_levels[i].mask |= gstage_pte_bits[j].mask;
+	}
+
+	if (kvm->arch.pgd_levels < 5)
+		gstage_pg_levels[1].name = "PGD";
+	if (kvm->arch.pgd_levels < 4)
+		gstage_pg_levels[2].name = "PGD";
+	if (kvm->arch.pgd_levels < 3)
+		gstage_pg_levels[3].name = "PGD";
+
+	ptdump_walk_pgd(&st.ptdump, kvm->mm, kvm->arch.pgd);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(gstage_ptdump);
+
+void kvm_arch_create_vm_debugfs(struct kvm *kvm)
+{
+	debugfs_create_file("gstage_page_tables", 0400,
+			    kvm->debugfs_dentry, kvm, &gstage_ptdump_fops);
+}
-- 
2.34.1

