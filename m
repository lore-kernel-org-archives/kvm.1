Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F4D3EFD2D
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895874; cv=none; b=lAhKGTPBJb/iX3iRgJN5jWFA5i/80+c2ZiN+Opxva9HsaH+BIvH/ON58sY+otJ59pQP6iOlLOjxbPDg6fFkm2WBgkYqofUu1V+o0ZAhsJT6IUN6X3ZLqzd8lVt2kJ4xSe+ffBretzqsftjBvcD8et+mGoqb2MtlF9JRe74ti4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895874; c=relaxed/simple;
	bh=n6gpHQMj9dBBVpsbX2EspPGNL9nPcpIZ0awTcHfew8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpuuYk9czncqTQ2sKdJ37r1RessmeQD/gASFGGasqF4uV3uIEslDxnO5qPbs+U0VBqGrxcfiFQgCDq1CUwvX4PBFxyvl1gdHMSr6vxVK2/mxdglzFv3FtTsko5OPKPvLAykOmk/tHfd6ZunG+ws0zZfJHx8dgnLPiXJiazbEkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoRgl7wX; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoRgl7wX"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-37fc115ad56so59862a91.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782895872; x=1783500672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4ItoJsKPCJ+weEid+hr/8Hcxyk96+mNUaKglmg0mf4=;
        b=hoRgl7wXIzEL5m5sniWkYz9o/rgTq9uDOliZJb5mkGEmM7ApIBM7/AJsu3i+BXEOpJ
         Zg4uWOuYvXQLjKgMV7pKv42HJgCO17mpMBAatu+DzUSmiJu+ZKFG/NbA87CvyW6wqmVS
         Vklh61hFj7okd2USTzTSeKLYk5CLHENPIBlHgpvTeQKPZVGmVdoPHk6FYewb++e8ZWMN
         7n+Yq/XoZ+F0kIUWgZNnRV6HRiW4dc3a9AmzT8zy6tyNRfsjDOHgCB9EzBwkWWwhWoiy
         m9YEoANnE2K6GUaCFOks6FAeZIT6qcSo0yjaGuuxnLcV/gAFtQU8xUGcFJPdTl8jZlN7
         gqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782895872; x=1783500672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G4ItoJsKPCJ+weEid+hr/8Hcxyk96+mNUaKglmg0mf4=;
        b=acxMNb1p66GpqukXfblGK+SEZrYsaroDolz+EaaxAWg36WqxH3CR1yRtZgPm1c7ZH2
         sOJVnTFrvNY5hHq8gopVwEjxGaA6i2ysGw7FG5QPTHsU/wpe/LHs5XEF6we33osZTgNs
         5AlYUEKh7l1eRYB1Fq7Ydr1KJZpDVlp1AV3255LfZejCrF6nezQ2B9pM+CBTipw3HL6l
         UL4CrNRec6dm6XcaWt9XjKBybVvXOBpXzSSxidSZY8dJVGivo+h7X+7K+jjiqzYlHCDB
         ye6HQySmVo/W3RsABJ8FORBrj5ZmK5XrBiua+NdT1p4XskY6TPtO+65yhGZQNmKF+Oex
         DkSg==
X-Forwarded-Encrypted: i=1; AHgh+RrZqifPyja80iioe2VnUD7wGuKs/iOyLUcPQWRqxNEN8UiKFzVFcULq0IrAK7/BVB+o6SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYyplUbx6b0QzCQTMD4TImuZQjvFp27zpAzDX1QJTERjaBCvbw
	FUUmzzIDLqEAuFpWyFZeOY5Ut+OBgEXA7Lb16SEPY+V5lfNp1mTWrTGA
X-Gm-Gg: AfdE7cl/IB5PeHkLyhntmlVuZzXwMm1FCkeZZsu3y8R3FLq9AM3lnzsDJmk9HVn/Ui1
	bmDoswHf4lok10B4UVmpBgoM6r7KZ4uxQu7qDiXMm3QZOwXftcxZnQB9urkU6XW/7Uv/TBmSxe9
	o1emVZ+S455q3+lNfXtd4pVyWPF2aPvH6biP4LAh3Lrlhh7CvjuvpXS6uVn1xDDlfbfWHuDi6zE
	hb1+myArvu/BIQ1hmRpS4/qKyRe/j8xVuJpayDsG6pJAGAVdCIliiyefKQIEbZQ582ycvkxc7oA
	cA5nxIKmAhVhDlVDIZJF4Ji19PmN3j3D/yPA9cz0aeWwErKQ60E6+/ksx6+zrmuBwr5NxJ2gj5B
	iVwpfhW/rZ6UfTfAaz7BzEz4g9VnGg3lT3fMCp7qEp2sVa6ljcRNZh7vde2V/LB9MztiksaVkhQ
	UWQWPGXwcqkSUmoiFGw8by
X-Received: by 2002:a17:90a:d44b:b0:37c:7090:821b with SMTP id 98e67ed59e1d1-380aa0f436amr685084a91.10.1782895872388;
        Wed, 01 Jul 2026 01:51:12 -0700 (PDT)
Received: from wud.bbrouter ([2409:8a1e:9473:9f10:5de9:783b:c249:18c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38097ba48d0sm550782a91.1.2026.07.01.01.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:51:12 -0700 (PDT)
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
Subject: [PATCH 2/2] KVM: riscv: Register ptdump with debugfs on guest creation
Date: Wed,  1 Jul 2026 04:50:30 -0400
Message-Id: <20260701085030.124579-3-fredwudi0305@gmail.com>
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

Introduce KVM ptdump to show the guest gstage pagetables. This registers
a 'gstage_page_tables' file under the guest debugfs directory.
Userspace can now inspect the gstage layout and permissions, which
is useful for architectural debugging and memory management audits.

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dylan.Wu <fredwudi0305@gmail.com>
---
 arch/riscv/include/asm/kvm_host.h |   6 +
 arch/riscv/kvm/Kconfig            |  15 +++
 arch/riscv/kvm/Makefile           |   1 +
 arch/riscv/kvm/ptdump.c           | 178 ++++++++++++++++++++++++++++++
 arch/riscv/kvm/vm.c               |   5 +
 5 files changed, 205 insertions(+)
 create mode 100644 arch/riscv/kvm/ptdump.c

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 60017ceec..04129c5f8 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -322,4 +322,10 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
 /* Flags representing implementation specific details */
 DECLARE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
 
+#ifdef CONFIG_PTDUMP_GSTAGE_DEBUGFS
+void kvm_s2_ptdump_create_debugfs(struct kvm *kvm);
+#else
+static inline void kvm_s2_ptdump_create_debugfs(struct kvm *kvm) {}
+#endif
+
 #endif /* __RISCV_KVM_HOST_H__ */
diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index ec2cee0a3..0ceb4a452 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -38,3 +38,18 @@ config KVM
 	  If unsure, say N.
 
 endif # VIRTUALIZATION
+
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
diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index 296c2ba05..0170c8c3b 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -42,3 +42,4 @@ kvm-y += vcpu_timer.o
 kvm-y += vcpu_vector.o
 kvm-y += vm.o
 kvm-y += vmid.o
+kvm-$(CONFIG_PTDUMP_GSTAGE_DEBUGFS) += ptdump.o
diff --git a/arch/riscv/kvm/ptdump.c b/arch/riscv/kvm/ptdump.c
new file mode 100644
index 000000000..972d45d69
--- /dev/null
+++ b/arch/riscv/kvm/ptdump.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Debug helper used to dump the gstage pagetables of the system.
+ */
+#include <linux/debugfs.h>
+#include <linux/kvm_host.h>
+#include <linux/seq_file.h>
+#include <linux/mm.h>
+#include <asm/ptdump.h>
+#include <asm/pgtable.h>
+
+static const struct ptdump_prot_bits gstage_pte_bits[] = {
+	{
+		.mask = _PAGE_SOFT,
+		.set = "RSW(%d)",
+		.clear = "  ..  ",
+	}, {
+		.mask = _PAGE_DIRTY,
+		.set = "D",
+		.clear = ".",
+	}, {
+		.mask = _PAGE_ACCESSED,
+		.set = "A",
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
+	{ .name = "PGD" },
+	{ .name = "P4D" },
+	{ .name = "PUD" },
+	{ .name = "PMD" },
+	{ .name = "PTE" },
+};
+
+struct kvm_ptdump_state {
+	struct kvm *kvm;
+	struct ptdump_pg_state parser_state;
+	struct addr_marker marker[2];
+	struct ptdump_range range[2];
+};
+
+static void kvm_ptdump_walk_level(struct ptdump_state *pt_st,
+				  unsigned long *tbl, int level,
+				  unsigned long start_addr)
+{
+	unsigned long addr = start_addr;
+	unsigned long next, virt_addr;
+	int i;
+	unsigned long step = 1UL << (PAGE_SHIFT + (4 - level) * 9);
+
+	for (i = 0; i < PTRS_PER_PTE; i++, addr += step) {
+		unsigned long val = tbl[i];
+
+		next = addr + step;
+
+		if (level == 4 || (val & _PAGE_LEAF) || !(val & _PAGE_PRESENT)) {
+			note_page(pt_st, addr, level, val);
+		} else {
+			unsigned long pa = (val >> _PAGE_PFN_SHIFT) << PAGE_SHIFT;
+
+			virt_addr = (unsigned long)phys_to_virt(pa);
+
+			kvm_ptdump_walk_level(pt_st, (unsigned long *)virt_addr,
+					      level + 1, addr);
+		}
+	}
+}
+
+static int kvm_ptdump_visitor(struct seq_file *m, void *v)
+{
+	struct kvm_ptdump_state *st = m->private;
+	struct kvm *kvm = st->kvm;
+	unsigned long *pgd = (unsigned long *)kvm->arch.pgd;
+	int start_level = 5 - kvm->arch.pgd_levels;
+	int i, j;
+
+	st->parser_state.level = -1;
+	st->parser_state.start_address = 0;
+	st->parser_state.seq = m;
+
+	for (i = 0; i < ARRAY_SIZE(gstage_pg_levels); i++) {
+		gstage_pg_levels[i].bits = gstage_pte_bits;
+		gstage_pg_levels[i].num = ARRAY_SIZE(gstage_pte_bits);
+		gstage_pg_levels[i].mask = 0;
+		for (j = 0; j < ARRAY_SIZE(gstage_pte_bits); j++)
+			gstage_pg_levels[i].mask |= gstage_pte_bits[j].mask;
+	}
+
+	read_lock(&kvm->mmu_lock);
+	if (pgd) {
+		kvm_ptdump_walk_level(&st->parser_state.ptdump, pgd,
+			start_level, 0);
+	}
+	read_unlock(&kvm->mmu_lock);
+
+	note_page(&st->parser_state.ptdump, 0, -1, 0);
+	return 0;
+}
+
+static int kvm_ptdump_open(struct inode *inode, struct file *file)
+{
+	struct kvm *kvm = inode->i_private;
+	struct kvm_ptdump_state *st;
+	int ret;
+
+	if (!kvm_get_kvm_safe(kvm))
+		return -ENOENT;
+
+	st = kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st) {
+		kvm_put_kvm(kvm);
+		return -ENOMEM;
+	}
+
+	st->kvm = kvm;
+	st->marker[0].name = "Guest IPA";
+	st->marker[0].start_address = 0;
+	st->marker[1].start_address = -1UL;
+	st->range[0].start = 0;
+	st->range[0].end = -1UL;
+
+	st->parser_state.marker = st->marker;
+	st->parser_state.pg_level = gstage_pg_levels;
+	st->parser_state.ptdump.range = st->range;
+
+	ret = single_open(file, kvm_ptdump_visitor, st);
+	if (ret) {
+		kfree(st);
+		kvm_put_kvm(kvm);
+	}
+	return ret;
+}
+
+static int kvm_ptdump_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+	struct kvm_ptdump_state *st = seq->private;
+	struct kvm *kvm = st->kvm;
+
+	kfree(st);
+	kvm_put_kvm(kvm);
+	return single_release(inode, file);
+}
+
+static const struct file_operations kvm_gstage_fops = {
+	.owner		= THIS_MODULE,
+	.open		= kvm_ptdump_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= kvm_ptdump_release,
+};
+
+void kvm_s2_ptdump_create_debugfs(struct kvm *kvm)
+{
+	debugfs_create_file("gstage_page_tables", 0400, kvm->debugfs_dentry, kvm,
+			    &kvm_gstage_fops);
+}
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index a9f083fee..464ad2eaf 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -269,3 +269,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
 	return -EINVAL;
 }
+
+void kvm_arch_create_vm_debugfs(struct kvm *kvm)
+{
+	kvm_s2_ptdump_create_debugfs(kvm);
+}
-- 
2.34.1

