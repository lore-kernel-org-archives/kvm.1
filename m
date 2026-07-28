Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E032B10A
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255333; cv=none; b=sjQxnWyYMk+v5d9Oy6HGlmIlpdS4AHVVBVHGzlCl0dbxgdODivrT+C5HT4Gue3wPHxzSLb9QAS2nIKXblxhn783A33vZmwibi9OhAB3wmJakM9S9uQma0NbdrrcsULnp6upguDW2aeRg55XjO9vIyS4jrxA5eA/023cfylv6rC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255333; c=relaxed/simple;
	bh=MkKYknDgYQ0zaQMSJaaYhTfdC1sPMi5skpuVqi03tKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IYPTKrzFXWAjROtpqmtdhxK2cMd8Nb8NzfES4nRcRAyy2gPsGanvHN0bB+BJkuIRU/UM3TPuhYu78K8aMTWPMz8sr8KWrOaTKti2RdlUE17NevRFlP8wLvCd0cq10jHE60M0LGfr/vBefBpGltzdnxW0eFJa61gRFo1Ea66n2Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEdtIow7; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEdtIow7"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-38111ea8a88so3947a91.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785255326; x=1785860126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BkJkYRNg1Asp/uUQCyBlmPwY9ZA7xtmbDXiizQLJHeA=;
        b=WEdtIow7/DOp0fOHxmJ+uDIvBGsg+rzED6ZniBBBF1iyrBt8pZn16IY7jjiXSM8r74
         Flofa6wC2egXB6pArE3UPPQZ8obDUqb07a9ZljdMu0EUiebZiiDMkDhXAYBAva7w7nBN
         lrT9Ox4/4vKgMOeGm8PLK+PvbF0b5JNKQMjcPCNWrNhd5gSgK/PKw7MMnlpuDn1EB0gi
         /1cLypeCo6ZPk5nYUvISsjg/rbLgJe0mQlzFgGq25dCjtAwS+utsixCvAYIsTy1QwTPK
         mXNSKOOEZT7jzdnBLAnT3b3KWdgm3Za6kKELTRgWjQkzfTfRtBKMFnwosyUCSAw7Ga/j
         K1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785255326; x=1785860126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BkJkYRNg1Asp/uUQCyBlmPwY9ZA7xtmbDXiizQLJHeA=;
        b=pQJ1KVv1iQs9nR/tNYDHnR3NgZvOipkjprCSNYBt1K2ewUVTtI5bjoJ+MNJhEXIiCs
         D10JE2DDp6zD+NrVL8NrdQqFnCkaOiptSDxTv/kEG4XdwBC7r5xB1bMhcwMvFvwItyip
         qzOq6CPGG4xAOOnCTis4jce39kB2gIUV9KXUkLdi/b+V6ogJTtmocu7My129Sahobaqk
         vQ/M82gZ2qzJs+WrloxVw1TonO1BY1PZZf2SH/WNnrh5znEJhjq6oFK4ybIJIZ8EZBKh
         /+2axOcPRJanYqapH9/3g/t/9FSXOYLfpuMo1SiJTTUOf7tH/VEaa0jnFZGdJm+I+PBA
         Zwwg==
X-Forwarded-Encrypted: i=1; AHgh+Roos8VOnBHxYayMdBoMyLGc39p/gHuvnzAumBWU/REAtNo3BpPwHgHb51sCBDW5L6xDaZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxefivU1d/frVk5Us6Y60Fk56jPchXM/K6eovs6IOcZP78juFCB
	/fb0rXgqI58ksNGbQ0VCtkFqxvHynXf9VrZItd0/mJbHwU+nQpgdZNBT
X-Gm-Gg: AR+sD11ZI501vsNRIUQ7hpYbVDMbDpcfWCGNUmrs0U4TjfGjuVHlssxmwJ4Igoye8tz
	2WdOkndS01c3a3hWmbnLYhDautfFz+BeK/EUWYArkccvKAQBnTZuErVLYpBkQjZhKc1G6Rozz4p
	KK8/wwfRNGi0mEd3rXk0VURf5XJxY6N2QlAxdskK3W3+3TkptMAM2WPsA+iX0Y3uPn87nm1IFIg
	VE1nllXhpLoQtoIvWoZXD6LjqCuaKZueESsjsiJz7EjTO5ObJ+v0zjtFRtWbhBR9K0A9WTbW+Rp
	Y0b/PA9vtIqGvrXXJiLnvTATldujOBO/QTH1a9TDuQfRpg6OtiYoQQBTNdLKSqDx110RiTOI7UT
	+elljqgIhRxV1puschVvBLnOlCs1rXWSsyU8/UPTsQUjQcZ5SzVL3x2Ga5kr0exiDqDwPZGg=
X-Received: by 2002:a17:90b:1645:b0:381:dc88:7c09 with SMTP id 98e67ed59e1d1-38f6a45bf01mr3132385a91.33.1785255326080;
        Tue, 28 Jul 2026 09:15:26 -0700 (PDT)
Received: from wud.. ([218.194.32.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f292b06sm161141a91.10.2026.07.28.09.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:15:25 -0700 (PDT)
From: "Dylan.Wu" <fredwudi0305@gmail.com>
To: paul.walmsley@sifive.com,
	pjw@kernel.org
Cc: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	anup@brainfault.org,
	atish.patra@linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	"Dylan.Wu" <fredwudi0305@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v3 2/3] riscv: ptdump: Use per-level attribute bits for parsing
Date: Tue, 28 Jul 2026 12:14:48 -0400
Message-Id: <20260728161449.190058-3-fredwudi0305@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728161449.190058-1-fredwudi0305@gmail.com>
References: <3bb2f519-c70b-6c35-c404-6fbfe8adbeb1@kernel.org>
 <20260728161449.190058-1-fredwudi0305@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the ptdump data structures with a ptdump_ prefix for clarity
and to avoid namespace collisions when other modules (like KVM) define
their own instances:
  - struct prot_bits   -> struct ptdump_prot_bits
  - struct pg_level    -> struct ptdump_pg_level
  - struct pg_state    -> struct ptdump_pg_state

Add bits/num fields to struct ptdump_pg_level so each page table level
can have its own set of attribute bits, and add a pg_level pointer to
struct ptdump_pg_state so the attribute parsing logic can use per-level
bits instead of a global array.

Update dump_prot() to use the per-level bits from the pg_level pointer
rather than the global pte_bits array. Rename the pg_level[] instance
to kernel_pg_levels[] to distinguish it from future gstage instances.

No functional changes in the output.

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dylan.Wu <fredwudi0305@gmail.com>
---
 arch/riscv/include/asm/ptdump.h |  9 +++--
 arch/riscv/mm/ptdump.c          | 62 ++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/arch/riscv/include/asm/ptdump.h b/arch/riscv/include/asm/ptdump.h
index 90dce9f64..53b0e52f0 100644
--- a/arch/riscv/include/asm/ptdump.h
+++ b/arch/riscv/include/asm/ptdump.h
@@ -10,18 +10,20 @@ struct addr_marker {
 	const char *name;
 };
 
-struct prot_bits {
+struct ptdump_prot_bits {
 	u64 mask;
 	const char *set;
 	const char *clear;
 };
 
-struct pg_level {
+struct ptdump_pg_level {
+	const struct ptdump_prot_bits *bits;
+	size_t num;
 	const char *name;
 	u64 mask;
 };
 
-struct pg_state {
+struct ptdump_pg_state {
 	struct ptdump_state ptdump;
 	struct seq_file *seq;
 	const struct addr_marker *marker;
@@ -32,6 +34,7 @@ struct pg_state {
 	u64 current_prot;
 	bool check_wx;
 	unsigned long wx_pages;
+	const struct ptdump_pg_level *pg_level;
 };
 
 void note_page(struct ptdump_state *pt_st, unsigned long addr,
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index d9a955b8a..c67fbbf5f 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -102,7 +102,7 @@ static struct ptd_mm_info efi_ptd_info = {
 };
 #endif
 
-static const struct prot_bits pte_bits[] = {
+static const struct ptdump_prot_bits pte_bits[] = {
 	{
 #ifdef CONFIG_64BIT
 		.mask = _PAGE_NAPOT,
@@ -152,46 +152,58 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
-static struct pg_level pg_level[] = {
+static struct ptdump_pg_level kernel_pg_levels[] = {
 	{ /* pgd */
+		.bits = pte_bits,
+		.num = ARRAY_SIZE(pte_bits),
 		.name = "PGD",
 	}, { /* p4d */
+		.bits = pte_bits,
+		.num = ARRAY_SIZE(pte_bits),
 		.name = (CONFIG_PGTABLE_LEVELS > 4) ? "P4D" : "PGD",
 	}, { /* pud */
+		.bits = pte_bits,
+		.num = ARRAY_SIZE(pte_bits),
 		.name = (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
 	}, { /* pmd */
+		.bits = pte_bits,
+		.num = ARRAY_SIZE(pte_bits),
 		.name = (CONFIG_PGTABLE_LEVELS > 2) ? "PMD" : "PGD",
 	}, { /* pte */
+		.bits = pte_bits,
+		.num = ARRAY_SIZE(pte_bits),
 		.name = "PTE",
 	},
 };
 
-static void dump_prot(struct pg_state *st)
+static void dump_prot(struct ptdump_pg_state *st)
 {
+	const struct ptdump_pg_level *lvl = &st->pg_level[st->level];
+	const struct ptdump_prot_bits *bits = lvl->bits;
 	unsigned int i;
 
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
@@ -203,7 +215,7 @@ static void dump_prot(struct pg_state *st)
 #else
 #define ADDR_FORMAT	"0x%08lx"
 #endif
-static void dump_addr(struct pg_state *st, unsigned long addr)
+static void dump_addr(struct ptdump_pg_state *st, unsigned long addr)
 {
 	static const char units[] = "KMGTPE";
 	const char *unit = units;
@@ -221,10 +233,10 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 	}
 
 	pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
-			   pg_level[st->level].name);
+			   kernel_pg_levels[st->level].name);
 }
 
-static void note_prot_wx(struct pg_state *st, unsigned long addr)
+static void note_prot_wx(struct ptdump_pg_state *st, unsigned long addr)
 {
 	if (!st->check_wx)
 		return;
@@ -242,12 +254,12 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 void note_page(struct ptdump_state *pt_st, unsigned long addr,
 	      int level, u64 val)
 {
-	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
+	struct ptdump_pg_state *st = container_of(pt_st, struct ptdump_pg_state, ptdump);
 	u64 pa = PFN_PHYS(pte_pfn(__pte(val)));
 	u64 prot = 0;
 
 	if (level >= 0)
-		prot = val & pg_level[level].mask;
+		prot = val & kernel_pg_levels[level].mask;
 
 	if (st->level == -1) {
 		st->level = level;
@@ -316,10 +328,11 @@ static void note_page_flush(struct ptdump_state *pt_st)
 
 static void ptdump_walk(struct seq_file *s, struct ptd_mm_info *pinfo)
 {
-	struct pg_state st = {
+	struct ptdump_pg_state st = {
 		.seq = s,
 		.marker = pinfo->markers,
 		.level = -1,
+		.pg_level = kernel_pg_levels,
 		.ptdump = {
 			.note_page_pte = note_page_pte,
 			.note_page_pmd = note_page_pmd,
@@ -339,13 +352,14 @@ static void ptdump_walk(struct seq_file *s, struct ptd_mm_info *pinfo)
 
 bool ptdump_check_wx(void)
 {
-	struct pg_state st = {
+	struct ptdump_pg_state st = {
 		.seq = NULL,
 		.marker = (struct addr_marker[]) {
 			{0, NULL},
 			{-1, NULL},
 		},
 		.level = -1,
+		.pg_level = kernel_pg_levels,
 		.check_wx = true,
 		.ptdump = {
 			.note_page_pte = note_page_pte,
@@ -410,12 +424,12 @@ static int __init ptdump_init(void)
 
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

