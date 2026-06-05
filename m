Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6712E3BB13A
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679336; cv=none; b=dYBiPGc3lRiLAtO30xBxDPm+oWaiB2uq5dUGFONjQHVzZkSPTei5AQMnNiIH8f2dsgl7PUPcq8rLikuhmXnUO7gSVBOMAXun3I+8sgvS93872XxYeoGfMsT2ZWT0ClLW8LNjkeHjJVco22+9JB/wkAgTppUe1T8JuHLmVgaxM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679336; c=relaxed/simple;
	bh=+QH+QNmKgHDD81xzbujEaIBf+UM6fBIXF56UKH7h/+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cpfrRX34qztBaMfJMqte9U9jAELoADRGvoleZ7UFQErfOeswjIdBGDLAUIJ0EhOQwpBhzngufPC87Q3g/WrsOx/5Pgjl2Ej65IIC/+xoWgnQ+QzC1Aw+F10kpbotI6YJAkGOHC/s4CtiZciQ7IPWoHOxUhvNJVhC70Zf/NQgxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZCM9nVfp; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCM9nVfp"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-bf473656dcdso31295566b.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780679333; x=1781284133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JKOif6j4jVPzr5ukiPmavhItUicYy0w0O5SDkKy/EaQ=;
        b=ZCM9nVfp4+PwkQ7t6Yj9n0StGoJxXVZp2E5N3dEvPbH0nPUdxYCvMzt+g61K8SDooj
         E23NpDDovypGt8R3HOBb3lHmDxixqdjRgVCcaqU3Qs0FqX/eoFZfBExC+l6F0ej7uCjY
         0Td4CpS2tmFKTqvPNWH4WjGTpQ9/80fjno9kb58Z6PvAnwvwTrzh+Ijfijr7uHVseIW9
         fMjIWedOmruIB2zXx4xijmoDEiqXP7HqgrcHa8p72Gmu+x2QlCR5gXD9fVxZSqYQkFL8
         uBkUQilTFptR45SgkeGH2HOJ5/lEFi+9IkkLubR9KzCFMrTO6naLlX+/PmWEp26QBkbX
         cA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679333; x=1781284133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKOif6j4jVPzr5ukiPmavhItUicYy0w0O5SDkKy/EaQ=;
        b=NIDLbs8pjGYAHCor1KB8Zu9pWvOJRR13OnLoxxpJ24WZz5ikPVqiEKk1XqxylkB8x3
         pMaSq6iWWlz1RFJH8epcrwwP0r+TWdY8iXRbasNeBbcabj4A3lOygpqKyV4g5EluuhZN
         7wGrBPLB4kJRcIzdSWkB+rTws+EhJQUCiIkj1Ewr4EwiObPjNRw7whErsK4Ukqa2IaXV
         BDc/HFBT7t/SDvpPf/2nadP5r3xV5d2RXdxHQhoZATYfNbHZ2PibCHSPOhEFp5r0L2jC
         AmzUL4KZIXtvAduPQBfUQOmSXbUfjBQoAb0tArw+yBDqL6ki8daxwRL+Q2qEbo0658vw
         3WZA==
X-Forwarded-Encrypted: i=1; AFNElJ8sf3gOdnPWc9txXjziqAaBD1ASIHH81+01Yp9+8iZ31+L5i+mr8Fmetkl5BlSCch0Xc/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7t610pjNz3UdqdeKFxn0pSoJR+SfE5xDfhr25h3SZGqRDIuHr
	y7ZGkKZd5haPHeg9V8nTbWMp2PjyQ6BUZb5S74CdfhIvFGWKBPhY5FvkaSMrOSVTqyHkrKPRgK9
	c+tpczC1wUmdXrTsd0A==
X-Received: from ejgi16.prod.google.com ([2002:a17:906:3c50:b0:bee:1279:f6c5])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7a8f:b0:bee:31b0:b53c with SMTP id a640c23a62f3a-bf3748d76f8mr236059566b.47.1780679332631;
 Fri, 05 Jun 2026 10:08:52 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:08:35 +0000
In-Reply-To: <cover.1780676742.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <deb20fbe3584a8c6bfda276447fe464c6553737d.1780676742.git.tarunsahu@google.com>
Subject: [RFC PATCH v2 10/10] selftests: kvm: Add guest_memfd_preservation_test
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	Tarun Sahu <tarunsahu@google.com>, fvdl@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, 
	aneesh.kumar@kernel.org, skhawaja@google.com, vipinsh@google.com, 
	ackerleytng@google.com, Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, 
	dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Add a new KVM selftest `guest_memfd_preservation_test` to verify that
guest memory backed by guest_memfd is preserved properly.

The test leverages the Live Update Orchestrator (LUO) infrastructure
to validate that memory folios and configuration layouts are
successfully saved and then restored during kernel live updates,
preventing any memory loss for the guest.

Here, I have used the kvm selftests framework by creating a new
vm and mapping two memory slots to it. One is the code that is executed
inside the vm and other is the guest_memfd whose memory is being
written by the guest code.

In Phase 1: Once data is written the vm exits and wait for the user
to trigger the kexec.

In Phase 2: A new vm is created with retrieved kvm and again two
memory slots are assigned. Once for guest code, and another is for
retrieved guest_memfd where guest_memfd memory is verified by the
executed guest code. If verification succeeds, The test passes.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   6 +-
 .../kvm/guest_memfd_preservation_test.c       | 230 ++++++++++++++++++
 3 files changed, 236 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_preservation_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ca459d032712..76e59620d2f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14419,6 +14419,7 @@ L:	kvm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	Documentation/liveupdate/vmm.rst
+F:	tools/testing/selftests/kvm/guest_memfd_preservation_test.c
 F:	virt/kvm/guest_memfd_luo.c
 F:	virt/kvm/kvm_luo.c
 
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89..68584d4ee1b0 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -161,6 +161,8 @@ TEST_GEN_PROGS_x86 += pre_fault_memory_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
+# Manual test that forks a persistent background daemon; skip auto CI run
+TEST_GEN_PROGS_EXTENDED_x86 += guest_memfd_preservation_test
 
 TEST_GEN_PROGS_arm64 = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_arm64 += arm64/aarch32_id_regs
@@ -254,6 +256,7 @@ OVERRIDE_TARGETS = 1
 # which causes the environment variable to override the makefile).
 include ../lib.mk
 include ../cgroup/lib/libcgroup.mk
+include ../liveupdate/lib/libliveupdate.mk
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
@@ -308,7 +311,8 @@ LIBKVM_S := $(filter %.S,$(LIBKVM))
 LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
-LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) $(LIBCGROUP_O)
+LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) \
+						$(LIBCGROUP_O) $(LIBLIVEUPDATE_O)
 SPLIT_TEST_GEN_PROGS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
 SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(ARCH)/%.o, $(SPLIT_TESTS))
 
diff --git a/tools/testing/selftests/kvm/guest_memfd_preservation_test.c b/tools/testing/selftests/kvm/guest_memfd_preservation_test.c
new file mode 100644
index 000000000000..74f90c5c4bf5
--- /dev/null
+++ b/tools/testing/selftests/kvm/guest_memfd_preservation_test.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026, Google LLC.
+ *
+ * Author: Tarun Sahu <tarunsahu@google.com>
+ *
+ * Test for VM and guest_memfd preservation across kexec (Live Update) via LUO.
+ *
+ * NOTE: This is a MANUAL test and is excluded from automated CI/testing
+ * frameworks because Phase 1 daemonizes into the background to pin resources
+ * and requires a human operator to manually trigger kexec before Phase 2
+ * is executed. Running Phase 1 automatically would leak the background daemon
+ * and cause CI runners to falsely interpret it as a passed test.
+ *
+ * Usage:
+ * Phase 1: ./guest_memfd_preservation_test
+ * Phase 2: ./guest_memfd_preservation_test --phase2
+ */
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <linux/sizes.h>
+#include <linux/falloc.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+#include "ucall_common.h"
+#include "../kselftest.h"
+#include "../kselftest_harness.h"
+
+#include <libliveupdate.h>
+
+#define SESSION_NAME "gmem_vm_preservation_session"
+#define VM_TOKEN 0x1001
+#define GMEM_TOKEN 0x1002
+
+#define GMEM_SIZE (16ULL * 1024 * 1024)
+#define DATA_SIZE (5ULL * 1024 * 1024)
+
+static size_t page_size;
+
+/* Deterministic byte pattern generation based on offset */
+static inline uint8_t get_pattern_byte(size_t offset)
+{
+	return (uint8_t)(offset ^ 0x5A);
+}
+
+static void guest_code_phase1(uint64_t gpa, uint64_t size, uint64_t data_size)
+{
+	uint8_t *mem = (uint8_t *)gpa;
+	size_t i;
+
+	for (i = 0; i < data_size; i++)
+		mem[i] = get_pattern_byte(i);
+
+	GUEST_DONE();
+}
+
+static void guest_code_phase2(uint64_t gpa, uint64_t size, uint64_t data_size)
+{
+	uint8_t *mem = (uint8_t *)gpa;
+	size_t i;
+
+	for (i = 0; i < data_size; i++) {
+		uint8_t val = get_pattern_byte(i);
+
+		__GUEST_ASSERT(mem[i] == val,
+			       "Data mismatch at offset %lu! Expected 0x%x, got 0x%x",
+			       i, val, mem[i]);
+	}
+
+	GUEST_DONE();
+}
+
+static void do_phase1(void)
+{
+	uint64_t flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED;
+	int gmem_fd, dev_luo_fd, session_fd, ret;
+	const uint64_t gpa = SZ_4G;
+	struct kvm_vcpu *vcpu;
+	const int slot = 1;
+	struct kvm_vm *vm;
+
+	vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1,
+					guest_code_phase1);
+	gmem_fd = vm_create_guest_memfd(vm, GMEM_SIZE, flags);
+	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, GMEM_SIZE, NULL,
+				 gmem_fd, 0);
+
+	for (size_t i = 0; i < GMEM_SIZE; i += page_size)
+		virt_pg_map(vm, gpa + i, gpa + i);
+
+	vcpu_args_set(vcpu, 3, gpa, GMEM_SIZE, DATA_SIZE);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+
+	dev_luo_fd = luo_open_device();
+	TEST_ASSERT(dev_luo_fd >= 0, "Failed to open /dev/liveupdate");
+
+	session_fd = luo_create_session(dev_luo_fd, SESSION_NAME);
+	TEST_ASSERT(session_fd >= 0, "Failed to create LUO session");
+
+	ret = luo_session_preserve_fd(session_fd, vm->fd, VM_TOKEN);
+	TEST_ASSERT(ret == 0, "Failed to preserve VM file descriptor");
+
+	ret = luo_session_preserve_fd(session_fd, gmem_fd, GMEM_TOKEN);
+	TEST_ASSERT(ret == 0, "Failed to preserve guest_memfd file descriptor");
+
+	printf("\n============================================================\n");
+	printf("Phase 1 Complete Successfully!\n");
+	printf("VM file and guest_memfd file have been preserved via LUO.\n");
+	printf("Tokens: VM_TOKEN=0x%x, GMEM_TOKEN=0x%x\n", VM_TOKEN, GMEM_TOKEN);
+	printf("Machine Size: %llu MB, Data Size: %llu MB\n", GMEM_SIZE / SZ_1M,
+				 DATA_SIZE / SZ_1M);
+	printf("------------------------------------------------------------\n");
+
+	daemonize_and_wait();
+}
+
+static struct kvm_vm *vm_create_from_fd(int resurrected_vm_fd,
+					struct vm_shape shape)
+{
+	struct kvm_vm *vm;
+
+	vm = calloc(1, sizeof(*vm));
+	TEST_ASSERT(vm != NULL, "Insufficient Memory");
+
+	vm_init_fields(vm, shape);
+
+	vm->kvm_fd = open_path_or_exit(KVM_DEV_PATH, O_RDWR);
+	vm->fd = resurrected_vm_fd;
+
+	if (kvm_has_cap(KVM_CAP_BINARY_STATS_FD))
+		vm->stats.fd = vm_get_stats_fd(vm);
+	else
+		vm->stats.fd = -1;
+
+	vm_init_memory_properties(vm);
+
+	return vm;
+}
+
+static void do_phase2(void)
+{
+	int retrieved_vm_fd, retrieved_gmem_fd, dev_luo_fd, session_fd;
+	struct vm_shape shape = VM_SHAPE_DEFAULT;
+	const uint64_t gpa = SZ_4G;
+	struct kvm_vcpu *vcpu;
+	const int slot = 1;
+	struct kvm_vm *vm;
+
+	dev_luo_fd = luo_open_device();
+	TEST_ASSERT(dev_luo_fd >= 0, "Failed to open /dev/liveupdate");
+
+	session_fd = luo_retrieve_session(dev_luo_fd, SESSION_NAME);
+	TEST_ASSERT(session_fd >= 0, "Failed to retrieve LUO session");
+
+	retrieved_vm_fd = luo_session_retrieve_fd(session_fd, VM_TOKEN);
+	TEST_ASSERT(retrieved_vm_fd >= 0, "Failed to retrieve VM file descriptor");
+
+	retrieved_gmem_fd = luo_session_retrieve_fd(session_fd, GMEM_TOKEN);
+	TEST_ASSERT(retrieved_gmem_fd >= 0, "Failed to retrieve guest_memfd file descriptor");
+
+	vm = vm_create_from_fd(retrieved_vm_fd, shape);
+
+	u64 nr_pages = 2048; /* 8MB is plenty for slot0 pages */
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, 0);
+	kvm_vm_elf_load(vm, program_invocation_name);
+
+	for (int i = 0; i < NR_MEM_REGIONS; i++)
+		vm->memslots[i] = 0;
+
+	struct userspace_mem_region *slot0 = memslot2region(vm, 0);
+
+	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_size);
+
+	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, GMEM_SIZE, NULL,
+				   retrieved_gmem_fd, 0);
+
+	for (size_t i = 0; i < GMEM_SIZE; i += page_size)
+		virt_pg_map(vm, gpa + i, gpa + i);
+
+	vcpu = vm_vcpu_add(vm, 0, guest_code_phase2);
+	kvm_arch_vm_finalize_vcpus(vm);
+
+	vcpu_args_set(vcpu, 3, gpa, GMEM_SIZE, DATA_SIZE);
+
+	printf("Resuming / Running VM in Phase 2...\n");
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+
+	printf("\nSUCCESS: Phase 2 Complete! All 5MB complex data verified intact!\n");
+
+	luo_session_finish(session_fd);
+	close(session_fd);
+	close(dev_luo_fd);
+	/* This will also close the vm_fd */
+	kvm_vm_free(vm);
+	close(retrieved_gmem_fd);
+}
+
+int main(int argc, char *argv[])
+{
+	bool phase2 = false;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
+	page_size = getpagesize();
+
+	for (int i = 1; i < argc; i++) {
+		if (strcmp(argv[i], "--phase2") == 0)
+			phase2 = true;
+	}
+
+	if (phase2)
+		do_phase2();
+	else
+		do_phase1();
+
+	return 0;
+}
-- 
2.54.0.1032.g2f8565e1d1-goog

