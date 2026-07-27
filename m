Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95AB3FD121
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155444; cv=none; b=aQIZaYeefcmbwXDOJzvcpTwYQtQErx/jC8cljKJfZNnNbKeZne7gZ/by9os5CoDOLVSXN2wvUsJvz3FG+Ia0X2qj0pJmEjLW7Ng1BuXx+pGU3BMeNmvut/OBL7P6gfOE8elkJaS3QpWpa4dIPSwSGthH3Ob7kysWBA/zjgbg+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155444; c=relaxed/simple;
	bh=Nne+/fwlH3lW6RBsCeh98OEkWpvIZ1CFhSig+a15WMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TdJjYZCRfO0C0aQfDk6/8fYI6mbpRZdrLFiwZWB3F4x3vp+fuOBSUMZCRunPv/OAij2qeKmMtjQzutHOMKzN05pvYs8nBcaqAxpv3kyl8Gaj3oiBhyJ7+gVrgi7E/7IN/Ofq2ENX8iH5SCpRSj5YBHTR6BaqjVkEl3Ma3H8SCqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2lEvG32; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2lEvG32"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc7ef596c6so25221855ad.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785155442; x=1785760242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTdBdaepYR3Npq5LgKxtOuDeDw6yKDcmDYCQg+CRMR4=;
        b=M2lEvG32AOM5C+7fLKPKFbk8j3wWayolbDvLRtNoWEp2XOiJuvijr9XIiyw4finaLl
         vdPrC6q3nfALSQ42p7dje9UiFQQDxriVzICNikC0AHPKknJnA8VAnqJ6yvtnZcgc6sh+
         6yjFvSqnKCUq6+Fsyrk+McBKtgDH8oEt6lj0mmVfVIma/QUfWCUSfNriEx/hiBdslqoc
         UR3qqHh2r23EmXuVdeEFjo6Fi6hq8ev6J2vTzvy+o7JHCBnOdTwkkDTP0Q13LkWkTMl0
         +ZVXVXGLZCSKD325o/oD5C/vRREx4VCyhZ2WCgIFc2Z18Q5GV6fv74l0w6KKmDW+ao1X
         mP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785155442; x=1785760242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VTdBdaepYR3Npq5LgKxtOuDeDw6yKDcmDYCQg+CRMR4=;
        b=gEudHslmXBV3/FOdVOiFCLDN7+RDzjnVuh4Rmgm3LH+vifeivXwDnAunVKWqy4+noQ
         j79p6kqnIng1Ko8wVsCqViEFDebx24OD577QTdb+hkVxC20+Daa3uN46/ry34iO1KHfh
         9MAwX75Kvr96jX4tnpSzBWJ/TpLxZzwAif1FrI//uV7C35IsNhr8VDKOch24xNlbfyOR
         FhdGXX8qsvdMjrBnr/H/XPfTN5R2fLdv0FJO17aU0LVaYcfr9GQ8eJrCIkAYjmpzN8nb
         /GZ+bIj5sVGlEe26oKK6L/t7mygG/vF8Hh6qllFZe/zG1dmer3HXKK1BsmOfdKwdyHZD
         5jfw==
X-Forwarded-Encrypted: i=1; AHgh+RqWKeu6FITuyHqDFJ+wW0EWINX29vvHjqzSIjCYrMb79XMJrwkKkXEUtk8L9u7KxZ+nHEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfmMansinC2U/GBY8eXEb0pIPn9+FkAnRZewoVaCXqWcWgJpzP
	wG8updE+H0bMVCRDw/0QhhP6cdGfAHXW4zefAXnr/D+E+u9qLx/MljYy
X-Gm-Gg: AR+sD12G26wLmUCfIaj0DsbrBLUxQK/v+ErU8yfOPu2vBkA0KBO2aWhCjEe6+JAQFs3
	x90hj0eZUCPEiAJZUMpLxsBVu7+nqMNTAoqxrfzHZIeDbhcMcyEaJcy+s5THlswxMMt2APFGf3c
	wco4opRvxkbOw0Q62hEui/wNb0X/SfR9Yti5SjePMA6vJRwgRehD9HxyU0r/rzYNL+lsasSYkc8
	nxGZHXBTLvdL9EpJ/7R82yBwbQFvJxBET+A2SoITPRSdPKvAcxBMjWpGcQh41t7vzj/kKfVtPFf
	WXblS0EIyhOKcCOciq6iPsa78LzEwXRGCw6of/gqSeBoNzRuMgwbXqvR30/8n40VM1z6brP+Ey3
	zRCMD1hmUk1uJxY3NSNbZ3WPExWZ04xGpMy5VO48zhoFCO1PZY2WS1Q4fP6m1agLHhkm/5oI=
X-Received: by 2002:a17:903:2284:b0:2c9:ff83:41fa with SMTP id d9443c01a7336-2cfde85fb71mr79666365ad.24.1785155441655;
        Mon, 27 Jul 2026 05:30:41 -0700 (PDT)
Received: from wud.. ([218.194.32.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfe1ab9c71sm30679775ad.73.2026.07.27.05.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:30:41 -0700 (PDT)
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
Subject: [PATCH v2 1/3] riscv: ptdump: Create ptdump.h and move declarations
Date: Mon, 27 Jul 2026 08:30:11 -0400
Message-Id: <20260727123013.118984-2-fredwudi0305@gmail.com>
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

Create a new arch/riscv/include/asm/ptdump.h header file and move the
pagetable walking state structures and level definitions there. This
allows other parts of the kernel (like KVM) to reuse the ptdump data
structures.

Also export the note_page() symbol so it can be used by other kernel
components.

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dylan.Wu <fredwudi0305@gmail.com>
---
 arch/riscv/include/asm/ptdump.h | 41 ++++++++++++++++++++++
 arch/riscv/mm/ptdump.c          | 60 +++++++--------------------------
 2 files changed, 53 insertions(+), 48 deletions(-)
 create mode 100644 arch/riscv/include/asm/ptdump.h

diff --git a/arch/riscv/include/asm/ptdump.h b/arch/riscv/include/asm/ptdump.h
new file mode 100644
index 000000000..eb9d11dab
--- /dev/null
+++ b/arch/riscv/include/asm/ptdump.h
@@ -0,0 +1,41 @@
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
index f4b4a9fcb..63655a9c8 100644
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
@@ -183,13 +152,7 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
-/* Page Level */
-struct pg_level {
-	const char *name;
-	u64 mask;
-};
-
-static struct pg_level pg_level[] = {
+static struct ptdump_pg_level pg_level[] = {
 	{ /* pgd */
 		.name = "PGD",
 	}, { /* p4d */
@@ -203,7 +166,7 @@ static struct pg_level pg_level[] = {
 	},
 };
 
-static void dump_prot(struct pg_state *st)
+static void dump_prot(struct ptdump_pg_state *st)
 {
 	unsigned int i;
 
@@ -240,7 +203,7 @@ static void dump_prot(struct pg_state *st)
 #else
 #define ADDR_FORMAT	"0x%08lx"
 #endif
-static void dump_addr(struct pg_state *st, unsigned long addr)
+static void dump_addr(struct ptdump_pg_state *st, unsigned long addr)
 {
 	static const char units[] = "KMGTPE";
 	const char *unit = units;
@@ -261,7 +224,7 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 			   pg_level[st->level].name);
 }
 
-static void note_prot_wx(struct pg_state *st, unsigned long addr)
+static void note_prot_wx(struct ptdump_pg_state *st, unsigned long addr)
 {
 	if (!st->check_wx)
 		return;
@@ -276,10 +239,10 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
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
 
@@ -317,6 +280,7 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr,
 		st->last_pa = pa;
 	}
 }
+EXPORT_SYMBOL_GPL(note_page);
 
 static void note_page_pte(struct ptdump_state *pt_st, unsigned long addr, pte_t pte)
 {
@@ -352,7 +316,7 @@ static void note_page_flush(struct ptdump_state *pt_st)
 
 static void ptdump_walk(struct seq_file *s, struct ptd_mm_info *pinfo)
 {
-	struct pg_state st = {
+	struct ptdump_pg_state st = {
 		.seq = s,
 		.marker = pinfo->markers,
 		.level = -1,
@@ -375,7 +339,7 @@ static void ptdump_walk(struct seq_file *s, struct ptd_mm_info *pinfo)
 
 bool ptdump_check_wx(void)
 {
-	struct pg_state st = {
+	struct ptdump_pg_state st = {
 		.seq = NULL,
 		.marker = (struct addr_marker[]) {
 			{0, NULL},
-- 
2.34.1

