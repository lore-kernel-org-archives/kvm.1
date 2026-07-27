Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD140911B
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155449; cv=none; b=StcRROoMeHJWZAdJ0Dq5+mUEjJv+xkg9NpNX142kHYd3hAcb7SxLGvJN2SOC1mZtNyLzDQUHqllfB/ttJ/BybkDvGggEuwdpxigXiUSey0mS3pqVewEIh0BtpdCw4WsOAz6vubSHQMNITvsi2d48BIZIp/lITY9eX+j6CBUWUiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155449; c=relaxed/simple;
	bh=YDei/BK0ALoj1ZjXXkbJtn2RX0gFBgCu8VTA53Qpxag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BDiO3S1ubWOCEC2jzokb87feQ5jyZ8uLagYUmv5TIs1MQCTGguk6RKu52Sfaipeb5YJnPnkgPesgLlyxVG0MTKkhQ2dX2h8xCNdN8UYc0X5XE7JtSbcLr1E4VqqaiBsz+nTcwM81iUYbxsRMZf69ip6TSpJIy9l31Z5jKtreZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5QftTDv; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5QftTDv"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc7a345f51so22141875ad.0
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785155447; x=1785760247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y8pTPbeEWjqJ3+0nUuuuXn5xR6k5GcUeJgsv7M+Os0c=;
        b=g5QftTDvQEccLRvL3QsuGlnWgS+vYcXO5CAr+ji6YKoJ0Ty1feD8qUjiW2TzD7awPZ
         3AXPQBZM+H2lh7yejU3uank7dRcgzbUu0b0LokpuxdvyvFtEzsC/U4IbV9bAZcqDfuLi
         tQU22CDgk71cp7f5FoGvIN7zVkBdUslyxpOxxJbk++ofEJ7XvNyIIe0moUIQML11a77U
         Ziwxy4baud38dhcf2o2k/9mIGkdO5SCtFO854axXyiJXm2hQ+5Qhr61tGRd2HgZ5k2OG
         0ZmK5YGIQcsCeJWWiMmRH59RKg3/5dgwdiGAjPSwCe+RCC7hl+s+IhBHRtZMBfRqjNg9
         qm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785155447; x=1785760247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y8pTPbeEWjqJ3+0nUuuuXn5xR6k5GcUeJgsv7M+Os0c=;
        b=JDJOp+KbHK+6/pG6bMql4P+9R3S1xMfgIxjhJ1McErOmEebO6ViHUK97GXRFsxTIdN
         mJxRyBROFaw02XSawePgxz7vnRl7Zanwgb6juXY+lLYbT33o5yt6QSbgSGvlqXQ3bbV5
         +fQDROCFsDnji+20jdrvYhPC5SjIoG86aMfO3H9R+Cpd0Z4GDm9+dnWWv7J6GWTRSete
         dAQjCMp07oA5Bet+qhzSolbtue1BDs3zn98ZEbotTx0Q4yj9raTwRaiQLiw3pFouTCom
         mhJC6mp323lB2Fg7ZKnNz0ZOUxWhEg/OqL6dqhiUXuNdJ53gmL1Z1m36dMY33I7Bqvj9
         xDhQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXPuJ5nOsD64O/YOq4Jxcqbyk00kJ0Rasc3mK2SB94/XHEK+1rwe6cLLG4ktHzBzniyig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLadqog6GiZR3hyaFNPw79u6cRDjVQ0qzvxRkd0Bq83MVUPTuG
	mlk9Z6/cHgNjebNcX71zoRQ2x99Wj5lSO6t3LeHYZ8out+h2TPyvzryx
X-Gm-Gg: AR+sD104mMkl5oKLND/iavUTz/sG5gtwBPNMwF9zhWvxLbypZrqnz9SgrfzUGrAKAZg
	dg/XjmuyZO+VGU6Kf7AB1YhOWtxSuTjAMsr/5meK4ZrYPsQd0f5Ix/u3gMitPeXCFTLJifTEUDo
	lQ+vPiA9paSk825Uf7jdMwJYKNccy5I4BnrGUyHvGDcL/xb8RmC20KAuCPgdRgiKEzjAL2cr41y
	4qkK/8UYZ38VcuTknftwyygep88gN2lwapNpkCq/r0GKMrg6irLqSJVkB18i0PLDkS5zA2xrWeA
	b0kChHGeBqWw9NaYV6UPx0kiDIxW3kEuVbeWzi7kk03ZKmFSFpXbeyI8otwAlDawIH1nSKcHcMK
	rn87oofMJxwOiQcg0D+ExIHkbqdrnH1aS03i0WptHLHmMoVzuav2L5XDOpxkgjNTBaWFdAVI=
X-Received: by 2002:a17:903:468c:b0:2c9:aae1:a61a with SMTP id d9443c01a7336-2cfde7b3a14mr78013425ad.14.1785155445847;
        Mon, 27 Jul 2026 05:30:45 -0700 (PDT)
Received: from wud.. ([218.194.32.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfe1ab9c71sm30679775ad.73.2026.07.27.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:30:45 -0700 (PDT)
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
Subject: [PATCH v2 2/3] riscv: ptdump: Use per-level attribute bits for parsing
Date: Mon, 27 Jul 2026 08:30:12 -0400
Message-Id: <20260727123013.118984-3-fredwudi0305@gmail.com>
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

Instead of using the global pte_bits array in dump_prot(), use the
per-level bits and num from the associated pg_level entry passed via
ptdump_pg_state. This makes the attribute parsing logic fully driven by
the per-level configuration, which allows KVM (and other future users)
to plug in their own set of protection bits for their pagetable levels.

Rename the local pg_level[] array to kernel_pg_levels[] to avoid
shadowing the pg_level pointer in struct ptdump_pg_state.

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dylan.Wu <fredwudi0305@gmail.com>
---
 arch/riscv/include/asm/ptdump.h |  1 +
 arch/riscv/mm/ptdump.c          | 48 +++++++++++++++++++++------------
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/include/asm/ptdump.h b/arch/riscv/include/asm/ptdump.h
index eb9d11dab..14a262bd0 100644
--- a/arch/riscv/include/asm/ptdump.h
+++ b/arch/riscv/include/asm/ptdump.h
@@ -28,6 +28,7 @@ struct ptdump_pg_state {
 	struct seq_file *seq;
 	const struct addr_marker *marker;
 	unsigned long start_address;
+	const struct ptdump_pg_level *pg_level;
 	unsigned long start_pa;
 	unsigned long last_pa;
 	int level;
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 63655a9c8..06c0217f0 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -152,46 +152,58 @@ static const struct ptdump_prot_bits pte_bits[] = {
 	}
 };
 
-static struct ptdump_pg_level pg_level[] = {
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
 
 static void dump_prot(struct ptdump_pg_state *st)
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
@@ -221,7 +233,7 @@ static void dump_addr(struct ptdump_pg_state *st, unsigned long addr)
 	}
 
 	pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
-			   pg_level[st->level].name);
+			   kernel_pg_levels[st->level].name);
 }
 
 static void note_prot_wx(struct ptdump_pg_state *st, unsigned long addr)
@@ -247,7 +259,7 @@ void note_page(struct ptdump_state *pt_st, unsigned long addr,
 	u64 prot = 0;
 
 	if (level >= 0)
-		prot = val & pg_level[level].mask;
+		prot = val & kernel_pg_levels[level].mask;
 
 	if (st->level == -1) {
 		st->level = level;
@@ -320,6 +332,7 @@ static void ptdump_walk(struct seq_file *s, struct ptd_mm_info *pinfo)
 		.seq = s,
 		.marker = pinfo->markers,
 		.level = -1,
+		.pg_level = kernel_pg_levels,
 		.ptdump = {
 			.note_page_pte = note_page_pte,
 			.note_page_pmd = note_page_pmd,
@@ -346,6 +359,7 @@ bool ptdump_check_wx(void)
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

