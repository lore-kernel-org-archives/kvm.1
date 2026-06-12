Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC13E1205
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281461; cv=none; b=Hkvblt3/Ac9qnTdDBj9mckpMPAuc17Ksilet6oL1kDFN41D+2w6a29gwFN80nMyRJit+Hi6zAlTwAL7as/01oDZ/ZDz8Z1XWl9Rmjtfn3E0On2pMVnHUXngcdCCqvT3AMyjAgirv7kEHw3z+Hdjyfwr+uU9sQKLNJpqoWUhRcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281461; c=relaxed/simple;
	bh=H2Kd07qElqnot6gVepkdwLKpMe9/R/K8xbz744caVbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fetwh9W6VXe5BrGO03keECPpaGobIq7TkpnrGTxrM+sphWoMwE37dns94/Okh/RBmLGoz94Q7ydVqH6cjAw2++LqQs2tK1D31aM14MM7dRfq7E4nul3q3l6AlZB108Py7NPPinwS7R7c4TjLmSNndEyDxeqr4jabu+UF/+uvu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+ornFK4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+ornFK4"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so9579345e9.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781281457; x=1781886257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tydmeyYrLPvT4qet9l6Pm8OKfFhD4dz0649Lu1ejs0k=;
        b=V+ornFK40pMnEL6osF/kpsRP7kftKkRR63KmY1fDtEtdEOoetHZAGyxb1o4GnysgeI
         Ee8owvBrO8/x/LpcFl9PkhkGbtC0JbeljkyubOaSDwYzppWW7G9IqPJJgRND+r6CcsrW
         QzX1oCVEMCkvk7dSKC1kjdkL1HtxCAMGjzU1u57aUynFdumMcefgoU+30Ve3PFR0v9Zw
         RBeYpNlibmbd4iuO9f5AcPau8waqIVJdNv7HTls7xKaStoO6+S+pOagnlWedR4HfBw9f
         Svdcj6rQn2pyk4YGLKx1zJiVpRESMrMdugi6aaZfzwBmZSMNlaWP/PzVekM6jRd/cD9M
         +Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781281457; x=1781886257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tydmeyYrLPvT4qet9l6Pm8OKfFhD4dz0649Lu1ejs0k=;
        b=kbmHEXUv9QT72H1e2r5eOXSDDj4cCr7OMJfYyKge4fXetO2Xurjy2w8YE2xv8e00Su
         QegDQnK8V35qCkXiFRN2K+aKdl0MxKqEZqqMlyDfluNGN+ydPk0Ac5wUO7CvrPy/OpeE
         NPejjAssw2FkN6iunAnjMYUyaTL8lmVI/CO8jBo6SZLYxbMduYwV0g+ceowm17sY3Yzz
         Uxl0rJfNlGdGQMuZdR/D0uJORm2zfKXAGwlqhyTFyNP7R1WGvNrM9EpWgU+sxDRHaeGu
         XjuIcAqsgD45AM6yUK4c9+BtKEJb3SNuGXp5T9CQu7wP0kWcTFGS9d+c08AM+l99yvyE
         +LKw==
X-Forwarded-Encrypted: i=1; AFNElJ8zc5pjWcy+9RJpe0NzYGmo3Is4hZOvmgWkahhG1RF+QQFW2oOL61IiSAjjB1gvBgdxf9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwopvD4VWD9qeQyzqlwWTCkMgd8oEkKv2gOle6UhHV8ePigHmX3
	WqzTntHElZas2EOaxYp7pjiLptNn+1cKKLkCwQCIV7sfFKLbYR7RAun/
X-Gm-Gg: Acq92OEGPeI8pUKI0vnCBISxsIUkULMZBzeB76Tc0Nl45rbGmkZUxkrl0XFWTj6FtXO
	lqw/Q/DtFUDaUnVM8HbB5HmYgWO5C52nUWDG27HeX1UP+qqUMnpgIDisAEV0P8+IYAroumMpo8m
	HBVtdFij2XIV8OFus/4RGlzBwdFsTc9fWR6TonfbNfJUl/swQ2yl2u422++ByyADu7rptkJoAkj
	OUn5L0BTgJdVhKzpc1h52R4rI34+ERCIvvnQOTE8t0GR48m14ysk4+y1GHbn/F5ZE48QspWIHc9
	AkGTeZHkUrLClyYiQuSniaeQKynJYoxVw0wA0CBafcb6iPl+rLVTlJuWk2EXg96fDHgiFHBaTwJ
	HtufIXNQ7lYL0tJPeBw+X2VHzg7DhCawz4/y0GaYHaIuEpCrmpTcp+NFin4mqf+zu5Zu+/3+xDX
	hH39TUwho7EUvpA/910YY4BTIFb4ghjEG0DArVWwpX47fmzbKFYbzLYK6NYnsX0Q==
X-Received: by 2002:a05:600c:c0d1:10b0:490:b9c3:6c69 with SMTP id 5b1f17b1804b1-490ec50f80cmr36665975e9.30.1781281456986;
        Fri, 12 Jun 2026 09:24:16 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c51dsm57620935e9.1.2026.06.12.09.24.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 09:24:16 -0700 (PDT)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: maz@kernel.org,
	oupton@kernel.org,
	pbonzini@redhat.com
Cc: joey.gouly@arm.com,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	corbet@lwn.net,
	vladimir.murzin@arm.com,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	isaku.yamahata@intel.com,
	Jack Thomson <jackabt@amazon.com>
Subject: [PATCH v5 3/5] KVM: selftests: Enable pre_fault_memory_test for arm64
Date: Fri, 12 Jun 2026 17:23:51 +0100
Message-ID: <20260612162354.73378-4-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260612162354.73378-1-jackabt.amazon@gmail.com>
References: <20260612162354.73378-1-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

Enable the pre_fault_memory_test to run on arm64 by making it work with
different guest page sizes and testing multiple guest configurations.

Update the test_assert to compare against the UCALL_EXIT_REASON, for
portability, as arm64 exits with KVM_EXIT_MMIO while x86 uses
KVM_EXIT_IO.

Signed-off-by: Jack Thomson <jackabt@amazon.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/pre_fault_memory_test.c     | 115 ++++++++++++++----
 2 files changed, 92 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89..4609d8f23e38 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -194,6 +194,7 @@ TEST_GEN_PROGS_arm64 += guest_memfd_test
 TEST_GEN_PROGS_arm64 += mmu_stress_test
 TEST_GEN_PROGS_arm64 += rseq_test
 TEST_GEN_PROGS_arm64 += steal_time
+TEST_GEN_PROGS_arm64 += pre_fault_memory_test
 
 TEST_GEN_PROGS_s390 = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_s390 += s390/memop
diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index fcb57fd034e6..9f5f0d1a5db1 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -11,19 +11,29 @@
 #include <kvm_util.h>
 #include <processor.h>
 #include <pthread.h>
+#include <guest_modes.h>
 
 /* Arbitrarily chosen values */
-#define TEST_SIZE		(SZ_2M + PAGE_SIZE)
-#define TEST_NPAGES		(TEST_SIZE / PAGE_SIZE)
+#define TEST_BASE_SIZE		SZ_2M
 #define TEST_SLOT		10
 
+/* Storage of test info to share with guest code */
+struct test_config {
+	u64 page_size;
+	u64 test_size;
+	u64 test_num_pages;
+};
+
+static struct test_config test_config;
+
 static void guest_code(u64 base_gva)
 {
 	volatile u64 val __used;
+	struct test_config *config = &test_config;
 	int i;
 
-	for (i = 0; i < TEST_NPAGES; i++) {
-		u64 *src = (u64 *)(base_gva + i * PAGE_SIZE);
+	for (i = 0; i < config->test_num_pages; i++) {
+		u64 *src = (u64 *)(base_gva + i * config->page_size);
 
 		val = *src;
 	}
@@ -56,7 +66,7 @@ static void *delete_slot_worker(void *__data)
 		cpu_relax();
 
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, data->gpa,
-				    TEST_SLOT, TEST_NPAGES, data->flags);
+				    TEST_SLOT, test_config.test_num_pages, data->flags);
 
 	return NULL;
 }
@@ -149,8 +159,8 @@ static void pre_fault_memory(struct kvm_vcpu *vcpu, u64 base_gpa, u64 offset,
 	/*
 	 * Assert success if prefaulting the entire range should succeed, i.e.
 	 * complete with no bytes remaining.  Otherwise prefaulting should have
-	 * failed due to ENOENT (due to RET_PF_EMULATE for emulated MMIO when
-	 * no memslot exists).
+	 * failed due to ENOENT (no memslot exists for the GPA; on x86 this
+	 * surfaces via RET_PF_EMULATE).
 	 */
 	if (!expected_left)
 		TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_PRE_FAULT_MEMORY, ret, vcpu->vm);
@@ -159,43 +169,70 @@ static void pre_fault_memory(struct kvm_vcpu *vcpu, u64 base_gpa, u64 offset,
 					  KVM_PRE_FAULT_MEMORY, ret, vcpu->vm);
 }
 
-static void __test_pre_fault_memory(unsigned long vm_type, bool private)
+struct test_params {
+	unsigned long vm_type;
+	bool private;
+};
+
+static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
 {
-	gpa_t gpa, gva, alignment, guest_page_size;
+	gpa_t gpa, gva, alignment, guest_page_size, host_page_size;
+	struct test_params *p = arg;
 	const struct vm_shape shape = {
-		.mode = VM_MODE_DEFAULT,
-		.type = vm_type,
+		.mode = guest_mode,
+		.type = p->vm_type,
 	};
 	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
 	struct kvm_vm *vm;
 	struct ucall uc;
 
+	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(guest_mode));
+
 	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_code);
 
-	alignment = guest_page_size = vm_guest_mode_params[VM_MODE_DEFAULT].page_size;
-	gpa = (vm->max_gfn - TEST_NPAGES) * guest_page_size;
+	guest_page_size = vm_guest_mode_params[guest_mode].page_size;
+	host_page_size = getpagesize();
+
+	test_config.page_size = guest_page_size;
+	test_config.test_size = align_up(TEST_BASE_SIZE + test_config.page_size,
+					 host_page_size);
+	test_config.test_num_pages = vm_calc_num_guest_pages(vm->mode, test_config.test_size);
+
+	gpa = (vm->max_gfn - test_config.test_num_pages) * test_config.page_size;
 	alignment = SZ_2M;
+	alignment = max(alignment, host_page_size);
 	gpa = align_down(gpa, alignment);
 	gva = gpa & ((1ULL << (vm->va_bits - 1)) - 1);
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, gpa, TEST_SLOT,
-				    TEST_NPAGES, private ? KVM_MEM_GUEST_MEMFD : 0);
-	virt_map(vm, gva, gpa, TEST_NPAGES);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    gpa, TEST_SLOT, test_config.test_num_pages,
+				    p->private ? KVM_MEM_GUEST_MEMFD : 0);
+	virt_map(vm, gva, gpa, test_config.test_num_pages);
 
-	if (private)
-		vm_mem_set_private(vm, gpa, TEST_SIZE);
+	if (p->private)
+		vm_mem_set_private(vm, gpa, test_config.test_size);
 
-	pre_fault_memory(vcpu, gpa, 0, SZ_2M, 0, private);
-	pre_fault_memory(vcpu, gpa, SZ_2M, PAGE_SIZE * 2, PAGE_SIZE, private);
-	pre_fault_memory(vcpu, gpa, TEST_SIZE, PAGE_SIZE, PAGE_SIZE, private);
+	pre_fault_memory(vcpu, gpa, 0, test_config.test_size, 0, p->private);
+	/* Retry the same range after the first prefault attempt. */
+	pre_fault_memory(vcpu, gpa, 0, test_config.test_size, 0, p->private);
+	pre_fault_memory(vcpu, gpa,
+			 test_config.test_size - host_page_size,
+			 host_page_size * 2, host_page_size, p->private);
+	pre_fault_memory(vcpu, gpa, test_config.test_size,
+			 host_page_size, host_page_size, p->private);
 
 	vcpu_args_set(vcpu, 1, gva);
+
+	/* Export the shared variables to the guest. */
+	sync_global_to_guest(vm, test_config);
+
 	vcpu_run(vcpu);
 
 	run = vcpu->run;
-	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
-		    "Wanted KVM_EXIT_IO, got exit reason: %u (%s)",
+	TEST_ASSERT(run->exit_reason == UCALL_EXIT_REASON,
+		    "Wanted %s, got exit reason: %u (%s)",
+		    exit_reason_str(UCALL_EXIT_REASON),
 		    run->exit_reason, exit_reason_str(run->exit_reason));
 
 	switch (get_ucall(vcpu, &uc)) {
@@ -214,16 +251,46 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
 
 static void test_pre_fault_memory(unsigned long vm_type, bool private)
 {
+	struct test_params p = {
+		.vm_type = vm_type,
+		.private = private,
+	};
+
 	if (vm_type && !(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type))) {
 		pr_info("Skipping tests for vm_type 0x%lx\n", vm_type);
 		return;
 	}
 
-	__test_pre_fault_memory(vm_type, private);
+	for_each_guest_mode(__test_pre_fault_memory, &p);
+}
+
+static void help(char *name)
+{
+	puts("");
+	printf("usage: %s [-h] [-m mode]\n", name);
+	puts("");
+	guest_modes_help();
+	puts("");
 }
 
 int main(int argc, char *argv[])
 {
+	int opt;
+
+	guest_modes_append_default();
+
+	while ((opt = getopt(argc, argv, "hm:")) != -1) {
+		switch (opt) {
+		case 'm':
+			guest_modes_cmdline(optarg);
+			break;
+		case 'h':
+		default:
+			help(argv[0]);
+			exit(0);
+		}
+	}
+
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_PRE_FAULT_MEMORY));
 
 	test_pre_fault_memory(0, false);
-- 
2.43.0

