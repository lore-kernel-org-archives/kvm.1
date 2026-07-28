Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D17F35A38C
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255332; cv=none; b=r07FCwUrDZfuLbomQ+qhZDsIJSOiFRpLSLqzaybsPmD8/QuX+YGI7wtGwdnd9a0hfkGFOs4xMswhZx+82Ro6JDmdP2qHhgKTPnVSYw4VNu867zWV7jqwB2bduR+sLGm9n4DVBkLF5Nd/67A1Kni5E3PzVaAarGr3dx/4tgS9wcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255332; c=relaxed/simple;
	bh=lMPhclar841uMJ0GBnwOF3+QTLkWoYZXkBqtzRZw4Wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OOCHit6mb2w3VEEv0DxHEceKzR2wIS89JxbLcT7DGTT4qISGITRJv6tDDaJet/o+rFxuVApooPRCRqVNlRkG5ACMZiKOq+Z+VWZaFsOszhVUs16b6kmXtXx8Uc8PPrhfwi1OCzf0df0qghEKsCcgBB5V6XRnV6YxNfXV55GlPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kH1wYvzX; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH1wYvzX"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-383390e7584so1956a91.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785255322; x=1785860122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=upXRv+tWWPrMoVucIXngMrJVs24x1WlX2PUogXgOPbc=;
        b=kH1wYvzXylrLaXoi/oXiDd7HiSeGC+NaG+OsXGfbWZqdpWYYi5/AMhEFUQS+JCOkYI
         sUnAc+8of1+BpJle4IZZM/99rvck+9ivLQO2DIDleztHEMmnU4oBS1x9gm2rT0cjNYdF
         NorrtUYBeAG8BDKoKzcUCD54xdyeie0lRfw8ihmzV27yb2NEXPE5Th1bFK1rA0grdJhJ
         YQ6Eip2owxF1sMOCTZDPoshurfCUuRgkgQWN2LXARha7fgyKG7IGykwlp7weiii97OpW
         voRV9vmqlsVHXR0RCTjc0Ls9H81bkxvZJbMUCU5p18scF0eQarMLESD0Yd1JLVFejKjc
         cHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785255322; x=1785860122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=upXRv+tWWPrMoVucIXngMrJVs24x1WlX2PUogXgOPbc=;
        b=LYBteAg1h78Hz+HwJpXE3tf6IvYtCpEFeoiRs0J0eXNF89DKHV9+a/4Zb/y17HWKRU
         MHjl98L6sW45jVb+BuPJ4M1aZIoVHkXFZO58CQxlpn0tUs6xqHaNwASERMW2P/kbBUgI
         COVNOOL6+xDfMAYJGw+Lx07B9kGsas9mHi15R3G4zG0SNSh9qdSEkGKGxsa0mUSBpmFG
         YRNdRF+Z1fkznBiJ6vGx2PLahvqg6PGQc8l5dI9AzFbfiemUdB5crofxlkc4tjkODERI
         vQSKXMNLK5McJNtSK/M/Du177mx4J1q2LN3Ra7c1YmewDgdy6NsuD488xUvALR4PPxHC
         zAmw==
X-Forwarded-Encrypted: i=1; AHgh+RrgYTtcimAad/mJ29FwEZceuibwednoL59H5zjHKbJiSV8ivMwHJhwc/s4NUi0Jn3B7rPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbueiQ1uBegxqj12gUTzfAgl/iyGDdxo1FirKSxqF33ix4pmN8
	Nt4n158xvH/qFLJIMW/Y7y6WMcFnoZ014unp02Zfa6Al9ZCpIXY1uMbFp6m7GYsHfOP3Mw==
X-Gm-Gg: AR+sD10Y4+HdTZsZZE4TcAz/YVcx1zmd5Gftye8BKPxK8G/DU083taDZ+5VNlSHvxuV
	qwRu6KSe8+gRfpWXSayRa3TBuuzc/eKASNczOkkd/SUoUvLxAyyqyLp2mREssri2nZnD2XnOjR0
	P86aY3r6xgpUnfAFr75ZsYt6AXQmbDY7tQ29Hx7tgwSX1Z7rUnubZMo06oDf5QnywMwsTnLSPU9
	7Qlbct7tTbfxgMlH1uzXgedsMiwUWekXIz0gvW3Q/N+l1P7iYbZvEmC2UINPSaLcjZ/2pN8xvH/
	JdFD1T/QljvIBHvXKtbBJURTqokHTasPQACr3hlc7TZIUSdIvlvyk8SxIibe4phFBWpc9Qv8tsH
	oebTgkvS0gcoCMMNeJdpiVHtmwP7U1yfnWozgw5Hx+smmIUHzczILEGG4dUnVx3OsJRoYKmI+iu
	aPxeS/SA==
X-Received: by 2002:a17:90b:3ccf:b0:38e:7f22:f674 with SMTP id 98e67ed59e1d1-38f6a30cf0bmr3139540a91.11.1785255321550;
        Tue, 28 Jul 2026 09:15:21 -0700 (PDT)
Received: from wud.. ([218.194.32.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f292b06sm161141a91.10.2026.07.28.09.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:15:21 -0700 (PDT)
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
Subject: [PATCH v3 1/3] riscv: ptdump: Create ptdump.h and move declarations
Date: Tue, 28 Jul 2026 12:14:47 -0400
Message-Id: <20260728161449.190058-2-fredwudi0305@gmail.com>
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

Create a new arch/riscv/include/asm/ptdump.h header file and move the
pagetable walking state structures and level definitions there. This
allows other parts of the kernel (like KVM) to reuse the ptdump data
structures.

Also export the note_page() symbol so it can be used by other kernel
components.

No functional changes - structures are moved verbatim.

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dylan.Wu <fredwudi0305@gmail.com>
---
 arch/riscv/include/asm/ptdump.h | 40 ++++++++++++++++++++++++++++++
 arch/riscv/mm/ptdump.c          | 44 +++------------------------------
 2 files changed, 44 insertions(+), 40 deletions(-)
 create mode 100644 arch/riscv/include/asm/ptdump.h

diff --git a/arch/riscv/include/asm/ptdump.h b/arch/riscv/include/asm/ptdump.h
new file mode 100644
index 000000000..90dce9f64
--- /dev/null
+++ b/arch/riscv/include/asm/ptdump.h
@@ -0,0 +1,40 @@
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
+struct prot_bits {
+	u64 mask;
+	const char *set;
+	const char *clear;
+};
+
+struct pg_level {
+	const char *name;
+	u64 mask;
+};
+
+struct pg_state {
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
+void note_page(struct ptdump_state *pt_st, unsigned long addr,
+	       int level, u64 val);
+
+#endif /* _ASM_RISCV_PTDUMP_H */
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index f4b4a9fcb..d9a955b8a 100644
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
@@ -126,13 +102,6 @@ static struct ptd_mm_info efi_ptd_info = {
 };
 #endif
 
-/* Page Table Entry */
-struct prot_bits {
-	u64 mask;
-	const char *set;
-	const char *clear;
-};
-
 static const struct prot_bits pte_bits[] = {
 	{
 #ifdef CONFIG_64BIT
@@ -183,12 +152,6 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
-/* Page Level */
-struct pg_level {
-	const char *name;
-	u64 mask;
-};
-
 static struct pg_level pg_level[] = {
 	{ /* pgd */
 		.name = "PGD",
@@ -276,8 +239,8 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
 }
 
-static void note_page(struct ptdump_state *pt_st, unsigned long addr,
-		      int level, u64 val)
+void note_page(struct ptdump_state *pt_st, unsigned long addr,
+	      int level, u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
 	u64 pa = PFN_PHYS(pte_pfn(__pte(val)));
@@ -317,6 +280,7 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr,
 		st->last_pa = pa;
 	}
 }
+EXPORT_SYMBOL_GPL(note_page);
 
 static void note_page_pte(struct ptdump_state *pt_st, unsigned long addr, pte_t pte)
 {
-- 
2.34.1

