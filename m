Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B986366DB9
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255335; cv=none; b=sdDrK7AAYD/nNhyBS/RxB36HESzRQkVE35+M6fquamOARIHGB3kSBjQVbc6Jem/kRXumo0TDcUCxEC4aIBfS/AsihxwxBsgz4CIhzqi0TtBba7kL8fuC2qFlPCG8WaRTqm07BL1zUB2WUg7FpKtzvKptNpEJc1AMTDxrlUEkDp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255335; c=relaxed/simple;
	bh=7bjGKRDBzMEh4FFXMSzRHQnDqMclVodYA999z7PFg/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cugbXkVsSrMBtFuLuul0WA/ESslWm8F7n2Ocj6+Tzg1QeVn1aqyUH3/marOMX+vNWNoHq/g0h7W2rZa0um/sYQyf0F/ZWTVmbN8nRTuVM+fjXOR0T5sIblY26dyL1FgidYeYEavmg+Af+9oKWZ7X948Zrq5s1E3VDzfuFrsVxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0SARL09; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0SARL09"
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-38eca9b7114so4855a91.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785255331; x=1785860131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UCN+I3ADpULzhqYd4a+6tuF3R3sYs3PcoHDBOdaVaI=;
        b=B0SARL09nbMfFR5+ll+v5xgh/GLOGCCibeF4wNZNaFO0e6SKp38Uxvczd6Kds5OHal
         6jJ3mxlK15PU05eTIK+6DYmfbS4skQSo9XuJa1szI3lR1bawv6L5TDVtPaiLJXFRjWBU
         Z8gMGI1do0fxN0uyRpF/8YIcMIhpD0qPCwFN1YEJjrQJxses4rVIcPVjYfwW2o9qkZFK
         BFtkmFr5Xb50LWSolea9zNoNbfNObQM/pkF5eUkLVdCznljGnqrCoGyfZLqADo7yOXDf
         RukdO6+qMbNkgRp4XlZkmxw/brGjnNl2Uhu//U9zrxi51JR+hf9HJcqH0CzwZOoe+Zag
         ZvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785255331; x=1785860131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2UCN+I3ADpULzhqYd4a+6tuF3R3sYs3PcoHDBOdaVaI=;
        b=UgLnCT+8cY8+TdAx/+vqKQIImHdh+aXYuSaZhySRygvzFeyPmJELTo0mB8NibyqMAJ
         9GGZ/xBQ+Ll90AjRv5MZDUcrevoWDYL8Qpp3ymTMD9fcFJsu46qnZ/FM2flsuS676QIs
         nFS62tBP8gKoeVsBrxh0G2DpkgunwtmA5x+DPcQ9MZpcL4x6EanS9ZUhkAQTEalHyPD/
         ifHOK3gq2Ak1/C1ULEm7Fol5ibL57iX0z0uvyN1HJ0DvxqVKGrb1iaUwlAYsXUvwhlkQ
         MxwQIbCFosIdN9Q21+bQTslmP82gXaGa0tbyWoNIdUqiLQ0Y9b80mu89dQZdlFklAoVd
         OF/g==
X-Forwarded-Encrypted: i=1; AHgh+RqbOP0ysqweqIAXejVY8XVN5wvkvcIfqAzy8WRQDA3gUK9w6yhKJqOl9nJV8UStmzcTz9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYc23t7TB55NxhwNsg6Vnfgu+qNWIT2lnx+sOm+B3cBdS7VyM
	rOcc69aeELJfAUhFM3h5UKhvek2tDZYc/pw4wbSVGb0ALmfTcjgJ/poe
X-Gm-Gg: AR+sD13ZR3EsBTnokYLI5K155XRTq5sCtmc0SYO8c2sx79LfvVxxsElKY+nCktqHI6f
	Hh58DnGEqiM7teJVE8BIwGRXqM4XqRk1MQI+mhlaoZXIg3cHorK96Becaf1XRVwrdGWo1KxZhgm
	MUulWwBca9a35/dDQ6VA0yG7DwBzetkGqhRTnxXlYOb4mulCyKhTvWDsWFlXtYVidTfev00uAJT
	vkvn+rdj85cM+fR4lrBKMHmMsxIdYYyInxcoDpGmjCNd16YwRdM/p3OYoydjlS3QmDKoBE/8ydH
	g3TvockwSPtES3ilOKXvX9r8LFB0cEOXqjDLn44cIKk0xF6I8FI0d6d9oTcPuPB6n5vd5oVE1/m
	Fpi+MzgJLdF0jk8PNoxxYMMXlC5luZqHLipt6SW5s45j/Y8ztXEeRs7OECzLFnnFJ/mrnB++aNw
	s0b9av3A==
X-Received: by 2002:a17:90b:55c5:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-38f6a1b8aa0mr3205402a91.0.1785255330655;
        Tue, 28 Jul 2026 09:15:30 -0700 (PDT)
Received: from wud.. ([218.194.32.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f292b06sm161141a91.10.2026.07.28.09.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:15:30 -0700 (PDT)
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
Subject: [PATCH v3 3/3] KVM: riscv: Register ptdump with debugfs on guest creation
Date: Tue, 28 Jul 2026 12:14:49 -0400
Message-Id: <20260728161449.190058-4-fredwudi0305@gmail.com>
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

Implement the gstage page table dumper for RISC-V KVM, which exposes
the guest's gstage page tables via debugfs. When
CONFIG_PTDUMP_GSTAGE_DEBUGFS is enabled, a "gstage_page_tables" file
will be created under each VM's debugfs directory.

This reuses the ptdump framework from the kernel page table dumper,
with gstage-specific attribute bits and level definitions.

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dylan.Wu <fredwudi0305@gmail.com>
---
 arch/riscv/kvm/Kconfig  |  12 +++
 arch/riscv/kvm/Makefile |   1 +
 arch/riscv/kvm/ptdump.c | 177 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 arch/riscv/kvm/ptdump.c

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index ec2cee0a3..6d62b967f 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -37,4 +37,16 @@ config KVM
 
 	  If unsure, say N.
 
+config PTDUMP_GSTAGE_DEBUGFS
+	bool "Present the gstage pagetables to debugfs"
+	depends on KVM && DEBUG_KERNEL && DEBUG_FS && PTDUMP_DEBUGFS
+	default n
+	help
+	  Say Y here if you want to show the RISC-V KVM gstage guest
+	  page tables in debugfs under each VM's debugfs directory as
+	  a file named "gstage_page_tables". This allows inspection of
+	  the second-stage address translation setup for each guest.
+
+	  If unsure, say N.
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
index 000000000..f436ad48c
--- /dev/null
+++ b/arch/riscv/kvm/ptdump.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 SiFive
+ */
+
+#include <linux/debugfs.h>
+#include <linux/ptdump.h>
+#include <linux/seq_file.h>
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_gstage.h>
+#include <asm/pgtable.h>
+#include <asm/ptdump.h>
+
+enum gstage_address_markers_idx {
+	GSTAGE_GPA_START_NR,
+	GSTAGE_GPA_END_NR,
+	END_OF_GSTAGE_SPACE_NR
+};
+
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
+		.name = "P4D",
+	}, { /* pud */
+		.bits = gstage_pte_bits,
+		.num = ARRAY_SIZE(gstage_pte_bits),
+		.name = "PUD",
+	}, { /* pmd */
+		.bits = gstage_pte_bits,
+		.num = ARRAY_SIZE(gstage_pte_bits),
+		.name = "PMD",
+	}, { /* pte */
+		.bits = gstage_pte_bits,
+		.num = ARRAY_SIZE(gstage_pte_bits),
+		.name = "PTE",
+	},
+};
+
+static void gstage_note_page(struct ptdump_state *pt_st, unsigned long addr,
+			     int level, u64 val)
+{
+	struct ptdump_pg_state *st = container_of(pt_st, struct ptdump_pg_state, ptdump);
+
+	note_page(pt_st, addr, level, val);
+
+	if (level >= 0)
+		st->current_prot = val & gstage_pg_levels[level].mask;
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

