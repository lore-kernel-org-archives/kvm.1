Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1D408251
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963066; cv=none; b=BLLwRplWtyStIAM+X8h1YMoKexkBtsNeUCBT65iPQZDz6RQdy0J1BnkZvbKb5RTg5uUwr9HbyJsmqMRnmgj5WcF1vrsz8wEhhNarq2V1L1NkQDfkjz5AZB+1MvbwnxF5h6iP3mOZtuJNhvXDrn8NY8kyj8+QdgM6ajgCgmlYUtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963066; c=relaxed/simple;
	bh=/IV7lWhsJHF0x5A2Fq993vbJ4R9Cdskri5oidvrL+zU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lVFsHUgnERoQAII9GpeZSTBdMPxWonfyIS3oFeumLWhrP6AsfrpLHkIjKtwaExUkGrCXx87KCGxvdUQBfii4okvA5prpycMEzLAgHmm0eujEoET3Blw1Lbz9hyxXRAzDH3PbKQ00LDA3xIMj1v30oQm8ic90lvZBzN/rPprCUDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TmIHOONQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmIHOONQ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2adc527eaf5so14307305ad.0
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 16:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773963064; x=1774567864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0XVkZljvWyJMdTaa7/apTU+xEzctUK1Me6jsTW57n1c=;
        b=TmIHOONQUNy44x1sTWBFqlkHdqTEomJZoN54pDRZUl4sUg2AqTTs3IGuqUzO8W3yX3
         mnMGPYgiumbNW4d54rWedlct2YDB4us9EXWUKxH5598Cq82FWPUlp3402ohIUmNvYYwW
         6NpEF0KHJFK1JT77BM8CmqSJWxLwx+oeFM49cVDAgE9oqlOyZRRJOCg2DCs5gIobVSNi
         7Rd9r2jTGRKMd/NjOozSWUpfFEM0n/sZayMMn8tTH4/gfSzKTmgWESnAnnbO3uW+1Axy
         Gsgon+oEnEHVTptkmzuAqxmsPSNHHpd8pILjNXIW5DOTJhYKzJ7OuFAUWm1l9QQ/yGAQ
         Qzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773963064; x=1774567864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XVkZljvWyJMdTaa7/apTU+xEzctUK1Me6jsTW57n1c=;
        b=kJG27Qc/xjPqEMDBnZlzsPSYaE9Q6KEU0+Bn5USOlhi5FzzpqgraQkTKKAYM8rkv+L
         3Y2JhHhtjTAwJSxPa6kxVeRv2FoqwfyfiN6rOdpzLnrqF/8ffJB6lmYba2x2Oxmbu47Z
         L88aKZR0vPW3hvARik1kkpAEvMafZA4jc00HunUuBcv6aQNOZ2OVOpGJsl66zOVO198s
         +gZ22k5O8oOqW1v0Kst4EFyCo86vUki0EmSIWeLEl9RN7H58rAweS68KY9giN/QARY1M
         uvyWHMbsLJu5AcpfAP8lBCUGle7cdOcYowWUP4z8JGng2vV+k6QyQ8FDIbtREhLPI82b
         iQkw==
X-Forwarded-Encrypted: i=1; AJvYcCUv2HSgQbYiGCpFx1BUkWjeFRTtY7dA/3o3lT8Upv7SEVmO8oA/rflvZ0Tm7friLSY8ktM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy63H0KYI8Aj77tJ49Rf88Ic5wwCTeXqLBjURCDDyZX9HX6pZ2p
	oFwWhFifHypgg5whdCy+l92gaDf0qSayLJG2Rgegaro/8EtU7B7d3PQxNmNKXkQnD8W5PKr+Ru+
	LXXO18g==
X-Received: from plgc17.prod.google.com ([2002:a17:902:d491:b0:2b0:6147:a0ee])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8c7:b0:2b0:5d60:7f43
 with SMTP id d9443c01a7336-2b0826b89fbmr7160295ad.8.1773963064231; Thu, 19
 Mar 2026 16:31:04 -0700 (PDT)
Date: Thu, 19 Mar 2026 23:30:33 +0000
In-Reply-To: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773963053; l=7959;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=/IV7lWhsJHF0x5A2Fq993vbJ4R9Cdskri5oidvrL+zU=; b=qXdjX2Q9/G5HKD4xyXrWxsOPx0Rn2uqxCML7evRdxyatc8uCc0KSmI17m7e+7pLSD0ksRHo+C
 w8h0S2a/h+KAmDqsho3FoLLL9CKZl1BZ7RTrb4jtLnaSxH9mgAItGtl
X-Mailer: b4 0.14.3
Message-ID: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-6-92c596402a7a@google.com>
Subject: [PATCH RFC v2 6/7] KVM: selftests: Add memory failure tests in guest_memfd_test
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
return 0 instead of MF_FAILED. Also, we want to make sure memory_failure()
signaling function is same.

Test that memory_failure() returns 0 for guest_memfd, where
.error_remove_folio() is handled by not actually truncating, and returning
MF_DELAYED.

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
 tools/testing/selftests/kvm/guest_memfd_test.c | 168 +++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 618c937f3c90..445e8155ee1e 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -10,6 +10,8 @@
 #include <errno.h>
 #include <stdio.h>
 #include <fcntl.h>
+#include <linux/prctl.h>
+#include <sys/prctl.h>
 
 #include <linux/bitmap.h>
 #include <linux/falloc.h>
@@ -193,6 +195,171 @@ static void test_fault_overflow(int fd, size_t total_size)
 	test_fault_sigbus(fd, total_size, total_size * 4);
 }
 
+static unsigned long addr_to_pfn(void *addr)
+{
+	const uint64_t pagemap_pfn_mask = BIT(54) - 1;
+	const uint64_t pagemap_page_present = BIT(63);
+	uint64_t page_info;
+	ssize_t n_bytes;
+	int pagemap_fd;
+
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+	TEST_ASSERT(pagemap_fd > 0, "Opening pagemap should succeed.");
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
+static void write_memory_failure(unsigned long pfn, bool mark, int return_code)
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
+	TEST_ASSERT(fd > 0, "Failed to open %s.", path);
+
+	len = snprintf(buf, sizeof(buf), "0x%lx\n", pfn);
+	if (len < 0 || (unsigned int)len > sizeof(buf))
+		TEST_ASSERT(0, "snprintf failed or truncated.");
+
+	ret = write(fd, buf, len);
+	if (return_code == 0) {
+		/*
+		 * If the memory_failure() returns 0, write() should be successful,
+		 * which returns how many bytes it writes.
+		 */
+		TEST_ASSERT(ret > 0, "Writing memory failure (path: %s) failed: %s", path,
+			    strerror(errno));
+	} else {
+		TEST_ASSERT_EQ(ret, -1);
+		/* errno is memory_failure() return code. */
+		TEST_ASSERT_EQ(errno, return_code);
+	}
+
+	close(fd);
+}
+
+static void mark_memory_failure(unsigned long pfn, int return_code)
+{
+	write_memory_failure(pfn, true, return_code);
+}
+
+static void unmark_memory_failure(unsigned long pfn, int return_code)
+{
+	write_memory_failure(pfn, false, return_code);
+}
+
+enum memory_failure_injection_method {
+	MF_INJECT_DEBUGFS,
+	MF_INJECT_MADVISE,
+};
+
+static void do_test_memory_failure(int fd, size_t total_size,
+				   enum memory_failure_injection_method method, int kill_config,
+				   bool map_page, bool dirty_page, bool sigbus_expected,
+				   int return_code)
+{
+	unsigned long memory_failure_pfn;
+	char *memory_failure_addr;
+	char *mem;
+	int ret;
+
+	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap() for guest_memfd should succeed.");
+	memory_failure_addr = mem + page_size;
+	if (dirty_page)
+		*memory_failure_addr = 'A';
+	else
+		READ_ONCE(*memory_failure_addr);
+
+	/* Fault in page to read pfn, then unmap page for testing if needed. */
+	memory_failure_pfn = addr_to_pfn(memory_failure_addr);
+	if (!map_page)
+		madvise(memory_failure_addr, page_size, MADV_DONTNEED);
+
+	ret = prctl(PR_MCE_KILL, PR_MCE_KILL_SET, kill_config, 0, 0);
+	TEST_ASSERT_EQ(ret, 0);
+
+	ret = 0;
+	switch (method) {
+	case MF_INJECT_DEBUGFS: {
+		/* DEBUGFS injection handles return_code test inside the mark_memory_failure(). */
+		if (sigbus_expected)
+			TEST_EXPECT_SIGBUS(mark_memory_failure(memory_failure_pfn, return_code));
+		else
+			mark_memory_failure(memory_failure_pfn, return_code);
+		break;
+	}
+	case MF_INJECT_MADVISE: {
+		/*
+		 * MADV_HWPOISON uses get_user_pages() so the page will always
+		 * be faulted in at the point of memory_failure()
+		 */
+		if (sigbus_expected)
+			TEST_EXPECT_SIGBUS(ret = madvise(memory_failure_addr,
+							 page_size, MADV_HWPOISON));
+		else
+			ret = madvise(memory_failure_addr, page_size, MADV_HWPOISON);
+
+		if (return_code == 0)
+			TEST_ASSERT(ret == return_code, "Memory failure failed. Errno: %s",
+							strerror(errno));
+		else {
+			/* errno is memory_failure() return code. */
+			TEST_ASSERT_EQ(errno, return_code);
+		}
+		break;
+	}
+	default:
+		TEST_FAIL("Unhandled memory failure injection method %d.", method);
+	}
+
+	TEST_EXPECT_SIGBUS(READ_ONCE(*memory_failure_addr));
+	TEST_EXPECT_SIGBUS(*memory_failure_addr = 'A');
+
+	ret = munmap(mem, total_size);
+	TEST_ASSERT(!ret, "munmap() should succeed.");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0,
+			total_size);
+	TEST_ASSERT(!ret, "Truncate the entire file (cleanup) should succeed.");
+
+	ret = prctl(PR_MCE_KILL, PR_MCE_KILL_SET, PR_MCE_KILL_DEFAULT, 0, 0);
+	TEST_ASSERT_EQ(ret, 0);
+
+	unmark_memory_failure(memory_failure_pfn, 0);
+}
+
+static void test_memory_failure(int fd, size_t total_size)
+{
+	do_test_memory_failure(fd, total_size, MF_INJECT_DEBUGFS, PR_MCE_KILL_EARLY, true, true, true, 0);
+	do_test_memory_failure(fd, total_size, MF_INJECT_DEBUGFS, PR_MCE_KILL_EARLY, true, false, false, 0);
+	do_test_memory_failure(fd, total_size, MF_INJECT_DEBUGFS, PR_MCE_KILL_EARLY, false, true, false, 0);
+	do_test_memory_failure(fd, total_size, MF_INJECT_DEBUGFS, PR_MCE_KILL_LATE, true, true, false, 0);
+	do_test_memory_failure(fd, total_size, MF_INJECT_DEBUGFS, PR_MCE_KILL_LATE, true, false, false, 0);
+	do_test_memory_failure(fd, total_size, MF_INJECT_DEBUGFS, PR_MCE_KILL_LATE, false, true, false, 0);
+	/*
+	 * If madvise() is used to inject errors, memory_failure() handling is invoked with the
+	 * MF_ACTION_REQUIRED flag set, aligned with memory failure handling for a consumed memory
+	 * error, where the machine check memory corruption kill policy is ignored. Hence, testing with
+	 * PR_MCE_KILL_DEFAULT covers all cases.
+	 */
+	do_test_memory_failure(fd, total_size, MF_INJECT_MADVISE, PR_MCE_KILL_DEFAULT, true, true, true, 0);
+	do_test_memory_failure(fd, total_size, MF_INJECT_MADVISE, PR_MCE_KILL_DEFAULT, true, false, false, 0);
+}
+
 static void test_fault_private(int fd, size_t total_size)
 {
 	test_fault_sigbus(fd, 0, total_size);
@@ -370,6 +537,7 @@ static void __test_guest_memfd(struct kvm_vm *vm, uint64_t flags)
 			gmem_test(mmap_supported, vm, flags);
 			gmem_test(fault_overflow, vm, flags);
 			gmem_test(numa_allocation, vm, flags);
+			gmem_test(memory_failure, vm, flags);
 		} else {
 			gmem_test(fault_private, vm, flags);
 		}

-- 
2.53.0.959.g497ff81fa9-goog

