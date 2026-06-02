Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF2A3BE16E
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437375; cv=none; b=UtL96ZkJgpW3dxpZ6yj7rm8qa3H72c8spem4Dmm+cDUY1dJWYHaBMrQzb5mbkmH4t7JIhDreKVtWtVthlDM+Oqc/PQNMeP0jtERE9OJN+XFDwHQBH/KpInnszqduwWnUF2CiwFBnJ+fZ8ZYyB4ELru3IgjwRbfRQL1Auy+h6M/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437375; c=relaxed/simple;
	bh=WaZ1Bk+9kgTkd/esD3bnBTyyH1p1bTgRbaMwG3iAxos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b7h12AOto1AYydDMjsoiXZ9e+EM+EsdCOTAsPDOtzMxHHWyqWr3DYVsySh8TCf7xtas/R/YCldFRJarwHp0IBq06fdwwtpnZxnLVhhVrvDobUoGgm2HeoClbZF/jTXZ3HCmTxVcDFcMAfYI+kEAHrepqBK1+qMn47j2l2zZYOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bKr+Rc3V; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKr+Rc3V"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b9106b0fbso27048a91.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 14:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780437371; x=1781042171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6mFy3Z3SyWCwRgM9+haQtSvrdq+maoP5fqUQtJx+eo=;
        b=bKr+Rc3Vj7sBG6I/yXpUMIJ18+iKSp6Kv7/4kUsR/M6TJJHMfOVxl9IscjJ2PGpKCS
         dZlOlCWYOJuArDzV3LIiDk3pgZvkjYt5OahbROdJQlYO7mm4t+xzCS6eWnip10QcDqQ+
         vkanlhi7PHy6K4YORKtPNvfzrrLc0DGUlJK1636j1iwYCQpK8o8uL0b/QxxZylnHNuZx
         RiWXSeaUYhe1+rYW4/RHOLYN17fo307b4iT/QdgbQdCXZM8ojSFEB8b0eQq/VYT5oPE4
         fFGlG98K2aDduGZtHjTqaOzQdxmFFn4y5JRtmW+k1aExYPxwSSxsmxrzb/Etn+FoENm6
         JdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437371; x=1781042171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6mFy3Z3SyWCwRgM9+haQtSvrdq+maoP5fqUQtJx+eo=;
        b=Ms41VZenXeOKwtwVurQITR3TxMLwTYlXPWIijv4gp1KCXgrZEyECvCfj60Zjd7YQD9
         HNUdJ5Zot7r3X+7tiiz3SoQoclyKNHHt94IRdcDxsBTN8HpBTXPBSpLUyF6SaD4R0u3L
         6MPUYE7APcQ1VmKG11L6WrzVpB4BoSH8w8xUbxaNdrKgiZ+K0u2mD7cmVgknmwGWP9e1
         BORdD1lxGo2U+3JFoDYRkUBTPhqOGKGxZscnXOkf98tkLmmhNcpwjNnRlYNVhv54kfOq
         uTM5sAMT+5BMUf2zhiD8EZqyTJkDRSq8Vn0xSP8V2afVcOhb9YLjxc9MPVBy7vAnH1JX
         Am9w==
X-Forwarded-Encrypted: i=1; AFNElJ+qyNfCdojZYrWiOZr9tIrhFdvaIR71+AtBN01QB5qH6iZVpIFGsBIGHBJRYojmLjac7Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt8nKsbGvfaPElrmEOyi0fvvZXhAckJtoFnxicrGdTkwq8Rq6N
	1mQZ2zFfhX3SUVSQfWRBz4uy4GYHq6qio7qxTJ8j8wZsbTafwyIQTEWg0lUcEbL3edldWNEGvKi
	KD8Oymg==
X-Received: from pjpo18.prod.google.com ([2002:a17:90a:9f92:b0:36b:8abb:86c4])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1649:b0:36b:769c:c037
 with SMTP id 98e67ed59e1d1-36e38a5ad7dmr345225a91.5.1780437371243; Tue, 02
 Jun 2026 14:56:11 -0700 (PDT)
Date: Tue, 02 Jun 2026 21:55:46 +0000
In-Reply-To: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780437363; l=11908;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=WaZ1Bk+9kgTkd/esD3bnBTyyH1p1bTgRbaMwG3iAxos=; b=SqAeAWv52UAEPcGkYpzMv8o5FzSIWZT3SZsD5NXiIh5u8IVpFEgGcT6WhIU7Nbk8K5YYCl77a
 5qnW7u/sLqaBTavQ2v5y2TwTStw+KcVVyLhpWWs2BMC6Z/Ltn+6hZu5
X-Mailer: b4 0.14.3
Message-ID: <20260602-memory-failure-mf-delayed-fix-v4-6-a5bc7db5a9b2@google.com>
Subject: [PATCH v4 6/7] KVM: selftests: Add the guest_memfd memory failure test
From: Lisa Wang <wyihan@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com, 
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com, 
	tabba@google.com, dave.hansen@linux.intel.com, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

After modifying truncate_error_folio(), we expect memory_failure() will
return 0 instead of MF_FAILED. Also, we want to make sure
memory_failure() signaling function is same.

Test that memory_failure() returns 0 for guest_memfd, where
.error_remove_folio() is handled by not actually truncating, and
returning MF_DELAYED.

In addition, test that SIGBUS signaling behavior is not changed before
and after this modification.

There are two kinds of guest memory failure injections - madvise or
debugfs. When memory failure is injected using madvise, the
MF_ACTION_REQUIRED flag is set, and the page is mapped and dirty, the
process should get a SIGBUS. When memory is failure is injected using
debugfs, the KILL_EARLY machine check memory corruption kill policy is
set, and the page is mapped and dirty, the process should get a SIGBUS.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm           |   2 +
 .../kvm/guest_memfd_memory_failure_test.c          | 336 +++++++++++++++++++++
 2 files changed, 338 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index fdec90e85467..9409ded6cbce 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -146,6 +146,7 @@ TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
 TEST_GEN_PROGS_x86 += guest_memfd_test
+TEST_GEN_PROGS_x86 += guest_memfd_memory_failure_test
 TEST_GEN_PROGS_x86 += hardware_disable_test
 TEST_GEN_PROGS_x86 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86 += memslot_perf_test
@@ -186,6 +187,7 @@ TEST_GEN_PROGS_arm64 += coalesced_io_test
 TEST_GEN_PROGS_arm64 += dirty_log_perf_test
 TEST_GEN_PROGS_arm64 += get-reg-list
 TEST_GEN_PROGS_arm64 += guest_memfd_test
+TEST_GEN_PROGS_arm64 += guest_memfd_memory_failure_test
 TEST_GEN_PROGS_arm64 += memslot_modification_stress_test
 TEST_GEN_PROGS_arm64 += memslot_perf_test
 TEST_GEN_PROGS_arm64 += mmu_stress_test
diff --git a/tools/testing/selftests/kvm/guest_memfd_memory_failure_test.c b/tools/testing/selftests/kvm/guest_memfd_memory_failure_test.c
new file mode 100644
index 000000000000..6c8032d390ae
--- /dev/null
+++ b/tools/testing/selftests/kvm/guest_memfd_memory_failure_test.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright Intel Corporation, 2026
+ *
+ * Author: Ackerley Tng <ackerleytng@google.com>
+ * Author: Lisa Wang <wyihan@google.com>
+ */
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <linux/prctl.h>
+#include <sys/prctl.h>
+
+#include <linux/bitmap.h>
+#include <linux/falloc.h>
+#include <linux/sizes.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include "kvm_util.h"
+#include "test_util.h"
+#include "kselftest_harness.h"
+
+static size_t page_size, total_size;
+
+enum memory_failure_injection_method {
+	MF_INJECT_DEBUGFS,
+	MF_INJECT_MADVISE,
+};
+
+FIXTURE(guest_memfd_failure) {
+	struct kvm_vm *vm;
+	int fd;
+	unsigned long poisoned_pfn;
+};
+
+FIXTURE_VARIANT(guest_memfd_failure) {
+	enum memory_failure_injection_method method;
+	int kill_config;
+	bool map_page;
+	bool dirty_page;
+	bool sigbus_expected;
+	int return_code;
+};
+
+FIXTURE_VARIANT_ADD(guest_memfd_failure, debugfs_early_dirty) {
+	.method = MF_INJECT_DEBUGFS,
+	.kill_config = PR_MCE_KILL_EARLY,
+	.map_page = true,
+	.dirty_page = true,
+	.sigbus_expected = true,
+	.return_code = 0,
+};
+
+FIXTURE_VARIANT_ADD(guest_memfd_failure, debugfs_early_clean) {
+	.method = MF_INJECT_DEBUGFS,
+	.kill_config = PR_MCE_KILL_EARLY,
+	.map_page = true,
+	.dirty_page = false,
+	.sigbus_expected = false,
+	.return_code = 0,
+};
+
+FIXTURE_VARIANT_ADD(guest_memfd_failure, debugfs_early_unmapped) {
+	.method = MF_INJECT_DEBUGFS,
+	.kill_config = PR_MCE_KILL_EARLY,
+	.map_page = false,
+	.dirty_page = true,
+	.sigbus_expected = false,
+	.return_code = 0,
+};
+
+FIXTURE_VARIANT_ADD(guest_memfd_failure, debugfs_late_dirty) {
+	.method = MF_INJECT_DEBUGFS,
+	.kill_config = PR_MCE_KILL_LATE,
+	.map_page = true,
+	.dirty_page = true,
+	.sigbus_expected = false,
+	.return_code = 0,
+};
+
+FIXTURE_VARIANT_ADD(guest_memfd_failure, debugfs_late_clean) {
+	.method = MF_INJECT_DEBUGFS,
+	.kill_config = PR_MCE_KILL_LATE,
+	.map_page = true,
+	.dirty_page = false,
+	.sigbus_expected = false,
+	.return_code = 0,
+};
+
+FIXTURE_VARIANT_ADD(guest_memfd_failure, debugfs_late_unmapped) {
+	.method = MF_INJECT_DEBUGFS,
+	.kill_config = PR_MCE_KILL_LATE,
+	.map_page = false,
+	.dirty_page = true,
+	.sigbus_expected = false,
+	.return_code = 0,
+};
+
+FIXTURE_VARIANT_ADD(guest_memfd_failure, madvise_dirty) {
+	.method = MF_INJECT_MADVISE,
+	.kill_config = PR_MCE_KILL_DEFAULT,
+	.map_page = true,
+	.dirty_page = true,
+	.sigbus_expected = true,
+	.return_code = 0,
+};
+
+FIXTURE_VARIANT_ADD(guest_memfd_failure, madvise_clean) {
+	.method = MF_INJECT_MADVISE,
+	.kill_config = PR_MCE_KILL_DEFAULT,
+	.map_page = true,
+	.dirty_page = false,
+	.sigbus_expected = false,
+	.return_code = 0,
+};
+
+FIXTURE_SETUP(guest_memfd_failure)
+{
+	self->vm = NULL;
+	self->fd = -1;
+	self->poisoned_pfn = 0;
+}
+
+static void write_memory_failure(unsigned long pfn, bool mark, int expected_return_code)
+{
+	char path[PATH_MAX];
+	char *filename;
+	char buf[20];
+	int ret;
+	int len;
+	int fd;
+
+	filename = mark ? "corrupt-pfn" : "unpoison-pfn";
+	snprintf(path, PATH_MAX, "/sys/kernel/debug/hwpoison/%s", filename);
+
+	fd = open(path, O_WRONLY);
+	TEST_ASSERT(fd >= 0, "Failed to open %s.", path);
+
+	len = snprintf(buf, sizeof(buf), "0x%lx\n", pfn);
+	if (len < 0 || (unsigned int)len >= sizeof(buf))
+		TEST_ASSERT(0, "snprintf failed or truncated.");
+
+	ret = write(fd, buf, len);
+	if (expected_return_code == 0) {
+		/*
+		 * If the memory_failure() returns 0, write() should be successful,
+		 * which returns how many bytes it writes.
+		 */
+		TEST_ASSERT(ret > 0, "Writing memory failure (path: %s) failed: %s", path,
+			    strerror(errno));
+	} else {
+		TEST_ASSERT_EQ(ret, -1);
+		/* errno is memory_failure() return code. */
+		TEST_ASSERT_EQ(errno, expected_return_code);
+	}
+
+	close(fd);
+}
+
+static void mark_memory_failure(unsigned long pfn, int expected_return_code)
+{
+	write_memory_failure(pfn, true, expected_return_code);
+}
+
+static void unmark_memory_failure(unsigned long pfn, int expected_return_code)
+{
+	write_memory_failure(pfn, false, expected_return_code);
+}
+
+FIXTURE_TEARDOWN(guest_memfd_failure)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+	if (self->vm)
+		kvm_vm_free(self->vm);
+	if (self->poisoned_pfn)
+		unmark_memory_failure(self->poisoned_pfn, 0);
+}
+
+static unsigned long addr_to_pfn(void *addr)
+{
+	const uint64_t pagemap_pfn_mask = BIT(54) - 1;
+	const uint64_t pagemap_page_present = BIT(63);
+	uint64_t page_info;
+	ssize_t n_bytes;
+	int pagemap_fd;
+
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+	TEST_ASSERT(pagemap_fd >= 0, "Opening pagemap should succeed.");
+
+	n_bytes = pread(pagemap_fd, &page_info, 8, (uint64_t)addr / page_size * 8);
+	TEST_ASSERT(n_bytes == 8, "pread of pagemap failed. n_bytes=%ld", n_bytes);
+
+	close(pagemap_fd);
+
+	TEST_ASSERT(page_info & pagemap_page_present, "The page for addr should be present");
+	return page_info & pagemap_pfn_mask;
+}
+
+static void do_test_memory_failure(FIXTURE_DATA(guest_memfd_failure) * self,
+				   const FIXTURE_VARIANT(guest_memfd_failure) * variant)
+{
+	unsigned long memory_failure_pfn;
+	char *memory_failure_addr;
+	char *mem;
+	int ret;
+
+	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, self->fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap() for guest_memfd should succeed.");
+	memory_failure_addr = mem + page_size;
+	if (variant->dirty_page)
+		*memory_failure_addr = 'A';
+	else
+		READ_ONCE(*memory_failure_addr);
+
+	/* Fault in page to read pfn, then unmap page for testing if needed. */
+	memory_failure_pfn = addr_to_pfn(memory_failure_addr);
+	if (!variant->map_page)
+		madvise(memory_failure_addr, page_size, MADV_DONTNEED);
+
+	ret = prctl(PR_MCE_KILL, PR_MCE_KILL_SET, variant->kill_config, 0, 0);
+	TEST_ASSERT_EQ(ret, 0);
+
+	self->poisoned_pfn = memory_failure_pfn;
+
+	ret = 0;
+	switch (variant->method) {
+	case MF_INJECT_DEBUGFS: {
+		/* DEBUGFS injection handles return_code test inside the mark_memory_failure(). */
+		if (variant->sigbus_expected)
+			TEST_EXPECT_SIGBUS(mark_memory_failure(memory_failure_pfn,
+							       variant->return_code));
+		else
+			mark_memory_failure(memory_failure_pfn, variant->return_code);
+		break;
+	}
+	case MF_INJECT_MADVISE: {
+		/*
+		 * MADV_HWPOISON uses get_user_pages() so the page will always
+		 * be faulted in at the point of memory_failure()
+		 */
+		if (variant->sigbus_expected)
+			TEST_EXPECT_SIGBUS(ret = madvise(memory_failure_addr,
+							 page_size, MADV_HWPOISON));
+		else
+			ret = madvise(memory_failure_addr, page_size, MADV_HWPOISON);
+
+		if (variant->return_code == 0)
+			TEST_ASSERT(ret == variant->return_code, "Memory failure failed. Errno: %s",
+							strerror(errno));
+		else {
+			/* errno is memory_failure() return code. */
+			TEST_ASSERT_EQ(errno, variant->return_code);
+		}
+		break;
+	}
+	default:
+		TEST_FAIL("Unhandled memory failure injection method %d.", variant->method);
+	}
+
+	TEST_EXPECT_SIGBUS(READ_ONCE(*memory_failure_addr));
+	TEST_EXPECT_SIGBUS(*memory_failure_addr = 'A');
+
+	ret = munmap(mem, total_size);
+	TEST_ASSERT(!ret, "munmap() should succeed.");
+
+	ret = fallocate(self->fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, total_size);
+	TEST_ASSERT(!ret, "Truncate the entire file (cleanup) should succeed.");
+
+	ret = prctl(PR_MCE_KILL, PR_MCE_KILL_SET, PR_MCE_KILL_DEFAULT, 0, 0);
+	TEST_ASSERT_EQ(ret, 0);
+
+	unmark_memory_failure(memory_failure_pfn, 0);
+	self->poisoned_pfn = 0;
+}
+
+TEST_F(guest_memfd_failure, test_memory_failure)
+{
+	unsigned long vm_types, vm_type;
+
+	total_size = page_size * 4;
+
+	vm_types = kvm_check_cap(KVM_CAP_VM_TYPES);
+	if (!vm_types)
+		vm_types = BIT(VM_TYPE_DEFAULT);
+
+	for_each_set_bit(vm_type, &vm_types, BITS_PER_TYPE(vm_types)) {
+		uint64_t flags;
+
+		self->vm = vm_create_barebones_type(vm_type);
+		flags = vm_check_cap(self->vm, KVM_CAP_GUEST_MEMFD_FLAGS);
+		if (!(flags & GUEST_MEMFD_FLAG_INIT_SHARED)) {
+			kvm_vm_free(self->vm);
+			self->vm = NULL;
+			continue;
+		}
+
+		self->fd = vm_create_guest_memfd(self->vm, total_size,
+						 GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED);
+		ASSERT_GE(self->fd, 0) TH_LOG("vm_create_guest_memfd failed");
+
+		do_test_memory_failure(self, variant);
+
+		close(self->fd);
+		self->fd = -1;
+		kvm_vm_free(self->vm);
+		self->vm = NULL;
+	}
+}
+
+static bool can_inject_memory_failure(void)
+{
+	int fd;
+
+	fd = open("/sys/kernel/debug/hwpoison/corrupt-pfn", O_WRONLY);
+	if (fd < 0)
+		return false;
+
+	close(fd);
+	return true;
+}
+
+int main(int argc, char **argv)
+{
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_GUEST_MEMFD_FLAGS) & GUEST_MEMFD_FLAG_INIT_SHARED);
+	__TEST_REQUIRE(can_inject_memory_failure(),
+		       "Insufficient permissions to access hwpoison debugfs (requires CAP_SYS_ADMIN / root))");
+	page_size = getpagesize();
+
+	return test_harness_run(argc, argv);
+}

-- 
2.54.0.1013.g208068f2d8-goog

