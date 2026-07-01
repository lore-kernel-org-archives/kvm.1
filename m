Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDCA3E7BA8
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895865; cv=none; b=ZHisiiBnNQm4uQb6gF7FUC94e7XPDfwx1iqup+N4v/a54i2Y/ZYh1TGZFNJOl7PBZdDH1MlhqJBJ+GWk3iqs2ztNLOXO7U97TLVlkTgZkVZ36INwLhzXD6sGJ2AzhsNNYj6rizlAOUnO8dv9DEtToQSjF+545qX54Sn7nhG/p2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895865; c=relaxed/simple;
	bh=/2SJjZqE51JN2M00q+SX/3jCRs0vKPRJcfqb3uQ2GEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTrJI/iIKMAEQym50uWc0565HzQdszqCLmM5Njfu9wm8utPoxpcc6IIdYqF/DaCiRg1oOqvPGe6YMe3jdkptX+PUgo5aaDgzi8fue0CqcSycOfsKi29iWeezoCTupm3HYYVkIOzddkUrpZKq/8C8qMnqZJZFto3VcVoecje+BzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pds5Wy/z; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pds5Wy/z"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-37d77008a28so172063a91.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782895863; x=1783500663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHr0PdDJXi6QKtc3/lV/35MnBQo9rJrsZa0CT7ri5ow=;
        b=pds5Wy/zvtLHN4d6u/k5CtA9d6ezwzk/K5b98+lYK0z61VB4hZJTEIqn16XcK2gQKD
         necp9r4ALhxGtdyeX0Qg7lrVvdm9Xdyah7nkQlMa6ZRdZTg6b5iJqRgMT3+JfZbzYt1J
         J43uJRvqbxLNZ/U6eSGl6pOmftQRgw1r8xx2IDZxoKrBG57Ya4y7dbl2dYRoklanYEpN
         VT0pk7saICSKiqcWH1ZU6e34aLpSdMNL04DiC/oH0umyvP9m/D+lFKJbslabaIKZYg1L
         xEqYzF6FauP2WLBpLHVDE7XSxtGQd+N02g5UhLYsuMFnH+cuibw5tcm8Sl25Pocpl8jI
         jpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782895863; x=1783500663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHr0PdDJXi6QKtc3/lV/35MnBQo9rJrsZa0CT7ri5ow=;
        b=ZKJ8/utHRKJi33gUF57VPNQSWjCKoXyOPtrRsP3uswDpdFFEKtHQXGtlhUb8pOy3Sr
         zvfvS7f8/4ELA77Fp6kV9i42PHsPjaN9t00fWWs/HJauZsIG0le0OyYcVzLVfwDeOV35
         pyR0+yimnbGsarp1hLIkq+itQ3oSbKoqa5l9QL81Cr2JDZxTA+0ArvZQMAsS8z6yMW0O
         Pv83p7q4KW3JIVO8kCbydBK0oW9MfoK4knqiYJ84QF8LdDXMUWvUYtHU8GJyTO7jZa7m
         w4+lxCzumt9uJhiCovhSCoVVvY5eOzl/SiZFpOCy9jNcy6XgDjIfIS73e5x6ZksswPu6
         mjZw==
X-Forwarded-Encrypted: i=1; AHgh+RruSsZC8R6VKF/8KdXGglqIbpoI/PRTuFqGBq0y91cXes3PABOl5MKVdlHJlvK+5Kqr2Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaxgzCGUXawUOCN0bt6TCBmRCKAcqA78gK6UfNwJVQI3b3wwhG
	CfxCXlDtdzMpQ5TQAL8qXwlyKSRG9V2/xO4I1Lwn2Aq6c2tZPppM5QsL
X-Gm-Gg: AfdE7cni6mnHdrpKgD/D7G50o/7+L0wYlvQ4jHSlLpHRhLOU7jIaooOB0XH48LiXrHQ
	WR047j728wtYSSZgpjpTtqLsjXIpBLrt8c7Ph3D5nJ3GUzUr9wP4ZNpHjVtdheVpACv7avCTGzd
	QUKD5PooEr8JjN+RY7bQa4UpWtUXB7infN/pWdPpmKf7jRNuhPVXKsrzyi9hxc63DFNz4ClcM/a
	Jt/KTDsTd0hlLlItccORc+4GQZ5d22WwHtzRRtLqiel/VsXamt3xWPdflZffaefsAkCqosEtcch
	H3srsL7w1LSMTbuFWedcGblVwJhRWDtWj2GQymKZBAFQWp0lpxF2UPKNG9D+orYK2MH/UWwk844
	J37Gz5OmtWfFr9pLAoPw/h04+yNKkacOuactWv8i+GkVzM7+Ys9bVTEzDQBhjnBfCPbYa1XARyp
	rylxnSeSPaT8ai92K3IWov
X-Received: by 2002:a17:90b:4acb:b0:37f:d6f3:450d with SMTP id 98e67ed59e1d1-380aa1313ecmr827599a91.14.1782895863350;
        Wed, 01 Jul 2026 01:51:03 -0700 (PDT)
Received: from wud.bbrouter ([2409:8a1e:9473:9f10:5de9:783b:c249:18c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38097ba48d0sm550782a91.1.2026.07.01.01.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:51:03 -0700 (PDT)
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
Subject: [PATCH 1/2] riscv: ptdump: Move pagetable definitions to common header
Date: Wed,  1 Jul 2026 04:50:29 -0400
Message-Id: <20260701085030.124579-2-fredwudi0305@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701085030.124579-1-fredwudi0305@gmail.com>
References: <20260701085030.124579-1-fredwudi0305@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the pagetable walking state and level definitions to a new
arch/riscv/include/asm/ptdump.h header. This allows other parts
of the kernel (like KVM) to reuse the ptdump attribute parsing
logic.

To support different pagetable types (like G-stage), the attribute
parsing logic in dump_prot() is updated to use attribute bits
defined within the pg_level structure rather than a global array.

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dylan.Wu <fredwudi0305@gmail.com>
---
 arch/riscv/include/asm/ptdump.h |  42 +++++++++++++
 arch/riscv/mm/ptdump.c          | 102 +++++++++++---------------------
 2 files changed, 77 insertions(+), 67 deletions(-)
 create mode 100644 arch/riscv/include/asm/ptdump.h

diff --git a/arch/riscv/include/asm/ptdump.h b/arch/riscv/include/asm/ptdump.h
new file mode 100644
index 000000000..9173910fa
--- /dev/null
+++ b/arch/riscv/include/asm/ptdump.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_PTDUMP_H
+#define _ASM_RISCV_PTDUMP_H
+
+#include <linux/ptdump.h>
+#include <linux/seq_file.h>
+
+struct addr_marker {
+	unsigned long start_address;
+	const char *name;
+};
+
+struct ptdump_prot_bits {
+	u64 mask;
+	const char *set;
+	const char *clear;
+};
+
+struct ptdump_pg_level {
+	const struct ptdump_prot_bits *bits;
+	const char *name;
+	u64 mask;
+	int num;
+};
+
+struct ptdump_pg_state {
+	struct ptdump_state ptdump;
+	struct seq_file *seq;
+	const struct addr_marker *marker;
+	const struct ptdump_pg_level *pg_level;
+	unsigned long start_address;
+	unsigned long start_pa;
+	unsigned long last_pa;
+	int level;
+	u64 current_prot;
+	bool check_wx;
+	unsigned long wx_pages;
+};
+
+void note_page(struct ptdump_state *pt_st, unsigned long addr, int level, u64 val);
+
+#endif /* _ASM_RISCV_PTDUMP_H */
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index f4b4a9fcb..7e55656cb 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -11,6 +11,7 @@
 #include <linux/ptdump.h>
 
 #include <linux/pgtable.h>
+#include <asm/ptdump.h>
 #include <asm/kasan.h>
 
 #define pt_dump_seq_printf(m, fmt, args...)	\
@@ -25,31 +26,6 @@
 		seq_puts(m, fmt);	\
 })
 
-/*
- * The page dumper groups page table entries of the same type into a single
- * description. It uses pg_state to track the range information while
- * iterating over the pte entries. When the continuity is broken it then
- * dumps out a description of the range.
- */
-struct pg_state {
-	struct ptdump_state ptdump;
-	struct seq_file *seq;
-	const struct addr_marker *marker;
-	unsigned long start_address;
-	unsigned long start_pa;
-	unsigned long last_pa;
-	int level;
-	u64 current_prot;
-	bool check_wx;
-	unsigned long wx_pages;
-};
-
-/* Address marker */
-struct addr_marker {
-	unsigned long start_address;
-	const char *name;
-};
-
 /* Private information for debugfs */
 struct ptd_mm_info {
 	struct mm_struct		*mm;
@@ -126,14 +102,7 @@ static struct ptd_mm_info efi_ptd_info = {
 };
 #endif
 
-/* Page Table Entry */
-struct prot_bits {
-	u64 mask;
-	const char *set;
-	const char *clear;
-};
-
-static const struct prot_bits pte_bits[] = {
+static const struct ptdump_prot_bits pte_bits[] = {
 	{
 #ifdef CONFIG_64BIT
 		.mask = _PAGE_NAPOT,
@@ -183,52 +152,48 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
-/* Page Level */
-struct pg_level {
-	const char *name;
-	u64 mask;
-};
-
-static struct pg_level pg_level[] = {
+static struct ptdump_pg_level kernel_pg_levels[] = {
 	{ /* pgd */
 		.name = "PGD",
 	}, { /* p4d */
-		.name = (CONFIG_PGTABLE_LEVELS > 4) ? "P4D" : "PGD",
+		.name = "P4D",
 	}, { /* pud */
-		.name = (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
+		.name = "PUD",
 	}, { /* pmd */
-		.name = (CONFIG_PGTABLE_LEVELS > 2) ? "PMD" : "PGD",
+		.name = "PMD",
 	}, { /* pte */
 		.name = "PTE",
 	},
 };
 
-static void dump_prot(struct pg_state *st)
+static void dump_prot(struct ptdump_pg_state *st)
 {
 	unsigned int i;
+	const struct ptdump_pg_level *lvl = &st->pg_level[st->level];
+	const struct ptdump_prot_bits *bits = lvl->bits;
 
-	for (i = 0; i < ARRAY_SIZE(pte_bits); i++) {
+	for (i = 0; i < lvl->num; i++) {
 		char s[7];
 		unsigned long val;
 
-		val = st->current_prot & pte_bits[i].mask;
+		val = st->current_prot & bits[i].mask;
 		if (val) {
-			if (pte_bits[i].mask == _PAGE_SOFT)
-				snprintf(s, sizeof(s), pte_bits[i].set, val >> 8);
+			if (bits[i].mask == _PAGE_SOFT)
+				snprintf(s, sizeof(s), bits[i].set, val >> 8);
 #ifdef CONFIG_64BIT
-			else if (pte_bits[i].mask == _PAGE_MTMASK_SVPBMT) {
+			else if (bits[i].mask == _PAGE_MTMASK_SVPBMT) {
 				if (val == _PAGE_NOCACHE_SVPBMT)
-					snprintf(s, sizeof(s), pte_bits[i].set, "NC");
+					snprintf(s, sizeof(s), bits[i].set, "NC");
 				else if (val == _PAGE_IO_SVPBMT)
-					snprintf(s, sizeof(s), pte_bits[i].set, "IO");
+					snprintf(s, sizeof(s), bits[i].set, "IO");
 				else
-					snprintf(s, sizeof(s), pte_bits[i].set, "??");
+					snprintf(s, sizeof(s), bits[i].set, "??");
 			}
 #endif
 			else
-				strscpy(s, pte_bits[i].set);
+				strscpy(s, bits[i].set);
 		} else {
-			strscpy(s, pte_bits[i].clear);
+			strscpy(s, bits[i].clear);
 		}
 
 		pt_dump_seq_printf(st->seq, " %s", s);
@@ -240,7 +205,7 @@ static void dump_prot(struct pg_state *st)
 #else
 #define ADDR_FORMAT	"0x%08lx"
 #endif
-static void dump_addr(struct pg_state *st, unsigned long addr)
+static void dump_addr(struct ptdump_pg_state *st, unsigned long addr)
 {
 	static const char units[] = "KMGTPE";
 	const char *unit = units;
@@ -258,10 +223,10 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 	}
 
 	pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
-			   pg_level[st->level].name);
+			   st->pg_level[st->level].name);
 }
 
-static void note_prot_wx(struct pg_state *st, unsigned long addr)
+static void note_prot_wx(struct ptdump_pg_state *st, unsigned long addr)
 {
 	if (!st->check_wx)
 		return;
@@ -276,15 +241,15 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
 }
 
-static void note_page(struct ptdump_state *pt_st, unsigned long addr,
-		      int level, u64 val)
+void note_page(struct ptdump_state *pt_st, unsigned long addr,
+	       int level, u64 val)
 {
-	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
+	struct ptdump_pg_state *st = container_of(pt_st, struct ptdump_pg_state, ptdump);
 	u64 pa = PFN_PHYS(pte_pfn(__pte(val)));
 	u64 prot = 0;
 
 	if (level >= 0)
-		prot = val & pg_level[level].mask;
+		prot = val & st->pg_level[level].mask;
 
 	if (st->level == -1) {
 		st->level = level;
@@ -317,6 +282,7 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr,
 		st->last_pa = pa;
 	}
 }
+EXPORT_SYMBOL_GPL(note_page);
 
 static void note_page_pte(struct ptdump_state *pt_st, unsigned long addr, pte_t pte)
 {
@@ -352,9 +318,10 @@ static void note_page_flush(struct ptdump_state *pt_st)
 
 static void ptdump_walk(struct seq_file *s, struct ptd_mm_info *pinfo)
 {
-	struct pg_state st = {
+	struct ptdump_pg_state st = {
 		.seq = s,
 		.marker = pinfo->markers,
+		.pg_level = kernel_pg_levels,
 		.level = -1,
 		.ptdump = {
 			.note_page_pte = note_page_pte,
@@ -375,12 +342,13 @@ static void ptdump_walk(struct seq_file *s, struct ptd_mm_info *pinfo)
 
 bool ptdump_check_wx(void)
 {
-	struct pg_state st = {
+	struct ptdump_pg_state st = {
 		.seq = NULL,
 		.marker = (struct addr_marker[]) {
 			{0, NULL},
 			{-1, NULL},
 		},
+		.pg_level = kernel_pg_levels,
 		.level = -1,
 		.check_wx = true,
 		.ptdump = {
@@ -446,12 +414,12 @@ static int __init ptdump_init(void)
 
 	kernel_ptd_info.base_addr = KERN_VIRT_START;
 
-	pg_level[1].name = pgtable_l5_enabled ? "P4D" : "PGD";
-	pg_level[2].name = pgtable_l4_enabled ? "PUD" : "PGD";
+	kernel_pg_levels[1].name = pgtable_l5_enabled ? "P4D" : "PGD";
+	kernel_pg_levels[2].name = pgtable_l4_enabled ? "PUD" : "PGD";
 
-	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
+	for (i = 0; i < ARRAY_SIZE(kernel_pg_levels); i++)
 		for (j = 0; j < ARRAY_SIZE(pte_bits); j++)
-			pg_level[i].mask |= pte_bits[j].mask;
+			kernel_pg_levels[i].mask |= pte_bits[j].mask;
 
 	debugfs_create_file("kernel_page_tables", 0400, NULL, &kernel_ptd_info,
 			    &ptdump_fops);
-- 
2.34.1

