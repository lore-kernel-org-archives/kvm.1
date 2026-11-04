Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753618;
	b=uCQaX1I/U7cIK3D+nNr4jTKiiLi0aPOPnglY2pkM/OrZMli2LZ0P5gdsW5CEwvOzKxU/
	 9fbpfHq6sbPpo3tONNcH7RRq2Yysgo12adY0OeaYEAzo++TmQpI/OBL4tY/McTR91VVeU
	 TIKxfppL/FnkKTqn/eOT6vEFcR4EIPd3xONUpWvs9NEEECqgUXmETAaYLdQARm5yTOg8I
	 cBY0gvWq96UanlD+AMySYQWx6UP/AHpTobhIqNtjx8+8Q5GLVWwhx9iCdAIWoS4NC/sT4
	 oCD4v57abaReJs4cTfdWepOzQeR9t+9yRw+Cbiu3fGicXyKDPm6Q+JwnMs8yqAkuOkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=P7WtagMvaiL9HNvynOHizX5PbSeh3ncD9qTxcE6rdI8=;
	b=rx4LevKuKKvD/Wa2c0w2SPX1SQK5raHMGC+bnuiZUBg1qInVkIE+h9zCk8MaHiQdR8yB
	 ybzJ362o7M/eRn9+rELQrGxhhTHX+1ivb7lHhgy/XVaGB8Bbc+kRKhfWDi9LCpTFvF5qY
	 DNcF+no0zFvtQnm22BNnyV03QsV6NMIEYup3dykkMMkLqPzRMZOhliy4mT+ZK74FK6ejI
	 GPUGFlkIQMzJK2syeOBL4h9kkF8LRGFBw5HPUHPUyecem3Jh9o17Ta0vGFrFFl8K73qmP
	 sMqIKrbzO9wDDpAuSXLUyHs/kXCKAc3u2y6myz5a5XtplbsqcYJoHEB4/jDJlSZxgZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ajxqoFDG;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC4606D803
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 00:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09CC4606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ajxqoFDG
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso623375e9.0
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 16:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753616; x=1794358416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7WtagMvaiL9HNvynOHizX5PbSeh3ncD9qTxcE6rdI8=;
        b=ajxqoFDGPNtSYcC9lgd7uYHtbRItvd7M+WnlGumvYFR5I79YEpNWqIwuoX3QDVgd0M
         RBQHmLPhiQKBRjSbTPNYZNpl0QFRhNEZ7N1xeuwzw2GtbV26KnVbW85m4HAtRB0MpPjG
         uXVaarlgf/Mxpx7/nFCzfmM2DBasooJRgslUZlW7TTf4M7VUxvFre6oORD3x3nS76eC7
         hmUPHl9Hq9ydi3g21XkpuUG1eEcCyEfZdQoE0aDj/bmr97EDTJqJRXdA5b3YxpiovRwX
         uWNVwluw6DorMKDvVHDTaRf79R4VSg3LlVYBby2q92/BstpX8CLP21tvYlhx5zKZntTT
         tiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753616; x=1794358416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P7WtagMvaiL9HNvynOHizX5PbSeh3ncD9qTxcE6rdI8=;
        b=rZsxC6q9fO1OxuRB5ZVP1vuzb4fBLaD+J+eRx0SYkTfkeuF/W+cf5ItrUAu56xzxrs
         A9OMpztVCZGtvzZpZDX9dLbn2YKIiw9nwtnSNnwfN7IuK2QApY95yi2Ds4Dmhk0AswOp
         vh1R0KjiEccq1OURXwJu+r4jm2XJkUbNmdi1tiKyRUVtRKAfzXF+5juGv5IRYKm1KuXm
         NZxpHuMAabG2sdEOh2E5+Ql2L0CGOqgm4vXhZN0uUK6GQJj5weml9Vo83AhJIuqn8Ig7
         AIiQP7ZYOT4iVnZWi33zqNtAYzSm9qYA7hJyTPyJSskMhz44vzoKeit3ehnsHvItVyT/
         dC/w==
X-Forwarded-Encrypted: i=1; AKwUvBy7W+qNsmZXVNEXlUvzya5Moh/SGqXE4tkzacJN3E6dzn2huCjlFUH+SSBf+UdqXDAMB+c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ftP7n/oU+aD20q9FYV3UEejdjLIMqn9lJcgZdCI8rrVzCulaY
	ALvSGl1k4IqZHAC5oyTu/ibfWn0meWhNi0hcyEbtje9BqV2RlkVa5Mu5
X-Gm-Gg: AYBFou2csPTrCRllCYYHdvAg9GjbpRMSnjD+XdrlLKCXseMzQxn9LP0OSulyLGBHT6w
	v5acsRmqJ4Cw/1CN7gUxqGsFOMfsWUJ5p77czvuhWHD4skT6Uzsv3PHrvzOmXvy5sG8KEQVmJdy
	3LS2nxIGq5E88opl9zKaf9RgSdueNCiKjt3jFqrW+Lkl/HGYqhOURMp7FuUhfb8aH9gZ60sDt96
	RExULI0MR9dG8/QcDAkPj3pOwLxQ2dV79dczT/rJe+dKhAM5U+6xqaizN/Qzrdl9wzicBdm/5vP
	MA+7OfHOFuDJOacCse6niwS8Y9e3BsG62kBNwwijJi4ZiqVDwaupaTUAyPK7Oz/FoYnSZJzT4CK
	9J+I+QmwK/5mayQi7z0Ps9fWtJdPYfMVZjRMW8HOmBVItpHmirlEBbiYtSZLspm7WnwLoSstemA
	O6p5g2ETZGkpnzg6ATDtw4cOl1lh61YqnU6uH0+BJg/VnJeHQufhamglPzaN/2yevRMVKnQsIr9
	rGlS8ZFgt4BEgy93ppWH4vURGXyNtFUSHG9seVkHVFYTifqomhk/v5flaeAMmwL2n8qhGBIncKQ
	zgP7PQwjFSV5ZDz8GONJVfYHvrgcolarag9gLCWAsjrzLSbpj3IS6fAV75MOjC/FmFr7xvyXj3+
	nH3EZGu1aggHrJi8EnK5BqFAGJaLr2EMRfBmdOCRzhw1q2M3Ipvn1EjGcRfJfMxBIrCA=
X-Received: by 2002:a05:600c:4e48:b0:4a2:150f:1610 with SMTP id 5b1f17b1804b1-4ac183d16eemr320131225e9.23.1793753616358;
        Tue, 03 Nov 2026 16:53:36 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43c17ed95sm11899275e9.4.2026.11.03.16.53.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:53:35 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Mushahid Hussain <hmushi@amazon.co.uk>,
	James Houghton <jthoughton@google.com>,
	nh-open-source@amazon.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] KVM: selftests: Test dirty logging of sparse nested mappings
Date: Wed,  4 Nov 2026 00:53:31 +0000
Message-ID: <20261104005331.50600-6-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104005331.50600-1-griffoul@gmail.com>
References: <20261104005331.50600-1-griffoul@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

With memslot rmaps allocated in chunks, slot walks skip unallocated
chunks. A walk that skips too far leaves a mapped page writable after
dirty logging write-protects the memslot, and L2's next write to that
page is missing from the dirty log.

Add a test in which L2 writes pages at chunk boundaries and in a chunk
surrounded by unallocated ones, and checks that exactly the pages it
writes after dirty logging is enabled are reported dirty. A second
pass maps L2 with 2 MiB pages and checks that eager page splitting
splits them and logs the resulting 4 KiB SPTEs. It needs four free
2 MiB hugepages and eager page splitting, and is skipped otherwise.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/nested_dirty_log_sparse_test.c    | 275 ++++++++++++++++++
 2 files changed, 276 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_dirty_log_sparse_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 17a4256e9081..61d88e0dd0ca 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -99,6 +99,7 @@ TEST_GEN_PROGS_x86 += x86/monitor_mwait_test
 TEST_GEN_PROGS_x86 += x86/msrs_test
 TEST_GEN_PROGS_x86 += x86/nested_close_kvm_test
 TEST_GEN_PROGS_x86 += x86/nested_dirty_log_test
+TEST_GEN_PROGS_x86 += x86/nested_dirty_log_sparse_test
 TEST_GEN_PROGS_x86 += x86/nested_emulation_test
 TEST_GEN_PROGS_x86 += x86/nested_exceptions_test
 TEST_GEN_PROGS_x86 += x86/nested_invalid_cr3_test
diff --git a/tools/testing/selftests/kvm/x86/nested_dirty_log_sparse_test.c b/tools/testing/selftests/kvm/x86/nested_dirty_log_sparse_test.c
new file mode 100644
index 000000000000..bc1c6b8760c9
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/nested_dirty_log_sparse_test.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Dirty logging of memory that L2 maps sparsely.
+ *
+ * KVM allocates shadow MMU rmaps in chunks that cover 2 MiB of guest memory
+ * at the 4 KiB level, and only for chunks that hold a mapped gfn.  L2 writes
+ * pages at both ends of a chunk, in the next chunk, and in chunks separated
+ * by unallocated ones.  Enabling dirty logging write-protects the memslot by
+ * walking its rmaps, so a mapped page that the walk misses stays writable,
+ * and L2's next write to it is missing from the dirty log.
+ *
+ * A second test maps the memory with 2 MiB pages in L1's TDP page tables and
+ * verifies that eager page splitting splits the nested huge pages when
+ * dirty logging is enabled, and that the 4 KiB SPTEs it creates are logged.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/sizes.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "vmx.h"
+
+#define TEST_MEM_SLOT		1
+#define TEST_MEM_BASE		0xc0000000ULL
+
+/* 64 MiB, i.e. 32 rmap chunks at the 4 KiB level. */
+#define SPARSE_MEM_PAGES	(SZ_64M / PAGE_SIZE)
+
+/* 4 huge pages for the eager page splitting test. */
+#define HUGE_MEM_PAGES		(4 * SZ_2M / PAGE_SIZE)
+#define HUGE_PAGES_PER_2M	(SZ_2M / PAGE_SIZE)
+
+/*
+ * Page indices L2 writes in the sparse test: both ends of the first two
+ * chunks, both ends of a chunk surrounded by unallocated chunks, and the
+ * last page of the memslot.
+ */
+static const u64 sparse_pages[] = { 0, 511, 512, 1023, 8192, 8703,
+				     SPARSE_MEM_PAGES - 1 };
+
+#define NR_SPARSE_PAGES		ARRAY_SIZE(sparse_pages)
+
+enum test_stage {
+	STAGE_POPULATE = 1,	/* L2 maps the pages, dirty logging is off */
+	STAGE_ALL,		/* L2 rewrites every page */
+	STAGE_SUBSET,		/* L2 rewrites every other page */
+};
+
+static bool huge_test;
+
+static void l2_write(u64 page, u64 val)
+{
+	WRITE_ONCE(*(u64 *)(TEST_MEM_BASE + page * PAGE_SIZE), val);
+}
+
+static u64 nr_test_pages(void)
+{
+	return huge_test ? HUGE_MEM_PAGES / HUGE_PAGES_PER_2M : NR_SPARSE_PAGES;
+}
+
+/* One page in each huge page in the huge test, the sparse pages otherwise. */
+static u64 test_page(u64 i)
+{
+	return huge_test ? i * HUGE_PAGES_PER_2M + 1 : sparse_pages[i];
+}
+
+static void l2_guest_code(void)
+{
+	u64 i;
+
+	for (i = 0; i < nr_test_pages(); i++)
+		l2_write(test_page(i), STAGE_POPULATE);
+	GUEST_SYNC(STAGE_POPULATE);
+
+	for (i = 0; i < nr_test_pages(); i++)
+		l2_write(test_page(i), STAGE_ALL);
+	GUEST_SYNC(STAGE_ALL);
+
+	for (i = 0; i < nr_test_pages(); i += 2)
+		l2_write(test_page(i), STAGE_SUBSET);
+	GUEST_SYNC(STAGE_SUBSET);
+
+	vmcall();
+}
+
+static void l1_vmx_code(struct vmx_pages *vmx)
+{
+	prepare_for_vmx_operation(vmx);
+	load_vmcs(vmx);
+	prepare_vmcs(vmx, l2_guest_code);
+
+	vmlaunch();
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+	GUEST_DONE();
+}
+
+static void l1_svm_code(struct svm_test_data *svm)
+{
+	generic_svm_setup(svm, l2_guest_code);
+
+	run_guest(svm->vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(svm->vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	GUEST_DONE();
+}
+
+static void l1_guest_code(void *data)
+{
+	if (this_cpu_has(X86_FEATURE_VMX))
+		l1_vmx_code(data);
+	else
+		l1_svm_code(data);
+}
+
+/* Returns true if L2 wrote @page in @stage. */
+static bool page_written(u64 page, enum test_stage stage)
+{
+	u64 i;
+
+	for (i = 0; i < nr_test_pages(); i++)
+		if (test_page(i) == page)
+			return stage != STAGE_SUBSET || !(i % 2);
+
+	return false;
+}
+
+static void check_dirty_log(struct kvm_vm *vm, u64 npages,
+			    enum test_stage stage, unsigned long *bmap)
+{
+	u64 page;
+
+	kvm_vm_get_dirty_log(vm, TEST_MEM_SLOT, bmap);
+
+	for (page = 0; page < npages; page++) {
+		bool written = page_written(page, stage);
+
+		TEST_ASSERT(test_bit(page, bmap) == written,
+			    "Stage %d: page %lu incorrectly reported %s",
+			    stage, page, written ? "clean" : "dirty");
+		if (written)
+			TEST_ASSERT_EQ(*(u64 *)addr_gpa2hva(vm, TEST_MEM_BASE + page * PAGE_SIZE),
+				       stage);
+	}
+}
+
+static void test_dirty_log(bool nested_tdp, bool huge)
+{
+	u64 npages = huge ? HUGE_MEM_PAGES : SPARSE_MEM_PAGES;
+	enum vm_mem_backing_src_type src;
+	u64 pages_2m = 0, pages_4k = 0;
+	gva_t nested_gva = 0;
+	struct kvm_vcpu *vcpu;
+	unsigned long *bmap;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	pr_info("Nested TDP: %s, L1 TDP page size: %s\n",
+		nested_tdp ? "enabled" : "disabled", huge ? "2M" : "4K");
+
+	/* Room for L1's page tables and TDP page tables of the test memory. */
+	vm = __vm_create_with_one_vcpu(&vcpu, 2 * (npages / 512 + 16),
+				       l1_guest_code);
+	if (nested_tdp)
+		vm_enable_tdp(vm);
+
+	if (kvm_cpu_has(X86_FEATURE_VMX))
+		vcpu_alloc_vmx(vm, &nested_gva);
+	else
+		vcpu_alloc_svm(vm, &nested_gva);
+	vcpu_args_set(vcpu, 1, nested_gva);
+
+	src = huge ? VM_MEM_SRC_ANONYMOUS_HUGETLB : VM_MEM_SRC_ANONYMOUS;
+	vm_userspace_mem_region_add(vm, src, TEST_MEM_BASE, TEST_MEM_SLOT,
+				    npages, 0);
+	virt_map(vm, TEST_MEM_BASE, TEST_MEM_BASE, npages);
+
+	if (nested_tdp) {
+		tdp_identity_map_default_memslots(vm);
+		__tdp_map(vm, TEST_MEM_BASE, TEST_MEM_BASE, npages * PAGE_SIZE,
+			  huge ? PG_LEVEL_2M : PG_LEVEL_4K);
+	}
+
+	huge_test = huge;
+	sync_global_to_guest(vm, huge_test);
+
+	bmap = bitmap_zalloc(npages);
+
+	for (;;) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			/* NOT REACHED */
+		case UCALL_SYNC:
+			break;
+		case UCALL_DONE:
+			goto done;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+
+		if (uc.args[1] != STAGE_POPULATE) {
+			check_dirty_log(vm, npages, uc.args[1], bmap);
+			continue;
+		}
+
+		if (huge) {
+			pages_2m = vm_get_stat(vm, pages_2m);
+			pages_4k = vm_get_stat(vm, pages_4k);
+		}
+
+		/* Write-protect the memslot by walking its rmaps. */
+		vm_mem_region_set_flags(vm, TEST_MEM_SLOT, KVM_MEM_LOG_DIRTY_PAGES);
+
+		/*
+		 * Only L2 maps the test memslot, so eager page splitting must
+		 * have split exactly the nested huge pages L2 populated.
+		 */
+		if (huge) {
+			u64 nr_huge = npages / HUGE_PAGES_PER_2M;
+			u64 split = pages_2m - vm_get_stat(vm, pages_2m);
+
+			TEST_ASSERT(split == nr_huge,
+				    "Split %lu nested 2M pages, expected %lu",
+				    split, nr_huge);
+			TEST_ASSERT_EQ(vm_get_stat(vm, pages_4k),
+				       pages_4k + nr_huge * HUGE_PAGES_PER_2M);
+		}
+	}
+
+done:
+	free(bmap);
+	kvm_vm_free(vm);
+}
+
+static u64 free_2m_hugepages(void)
+{
+	u64 nr = 0;
+	FILE *f;
+
+	f = fopen("/sys/kernel/mm/hugepages/hugepages-2048kB/free_hugepages", "r");
+	if (!f)
+		return 0;
+	if (fscanf(f, "%lu", &nr) != 1)
+		nr = 0;
+	fclose(f);
+
+	return nr;
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX) || kvm_cpu_has(X86_FEATURE_SVM));
+
+	test_dirty_log(/*nested_tdp=*/false, /*huge=*/false);
+
+	if (!kvm_cpu_has_tdp())
+		return 0;
+
+	test_dirty_log(/*nested_tdp=*/true, /*huge=*/false);
+
+	if (free_2m_hugepages() >= HUGE_MEM_PAGES / HUGE_PAGES_PER_2M &&
+	    get_kvm_param_bool("tdp_mmu") && get_kvm_param_bool("eager_page_split"))
+		test_dirty_log(/*nested_tdp=*/true, /*huge=*/true);
+	else
+		pr_info("Skipping eager page splitting test, needs 4 free 2M hugepages, tdp_mmu and eager_page_split\n");
+
+	return 0;
+}
-- 
2.47.3

