Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E0374E45
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225726; cv=none; b=mYDSdXbON5McW3fd5uB6d/7YbsCPHoazGH1vvMDYMS5yC2Qe+0+4a0GgpMw+nnieCMACiosj/QuuaBcqPZPP9ZSLTvQbjLjWuf6g9Tx7W40PL3sAlSACwRfaLQNhOSQzjnsGVvccaoBYVZiGVypc2c6pAEFQC6f8esIdc9QniO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225726; c=relaxed/simple;
	bh=zSf5J4TagZlI2eYRClP6nKX6VceYrLsbJd1z4PhFFN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WP4PbPKli1pd8DI4ap+HDkOcvvZiUGviv+AvZODncEw2I7EcaWCCfAjIwyuSnoPvzOHtLbrw9P+zqmnLEf0TKBgxGYCxmCkA2cbgKAgpLK05stzHCgSbzclvnq4Va7YFGbcgZ+bPQuLOaYEvNuEuvpfXsLEn0itUDOhYcz2AmIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nac+nBEl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nac+nBEl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9BuHBT5zfcEzvmuoZO/X3B0wpsVcYOl+5SVDoPWrFo=;
	b=Nac+nBElyyKa5vCVihApNJrfw8i9TPz9OMY7EO/2dtDCV01HOipTuyDtn+Y80FT3wIy16p
	9Pd6SUlEB74SNdA/QdjDjO5Y1obp7KcUccGpMbP4bAlIixPFSFMH1QvYkc2GOQyYTm3cR+
	GssTBinlokCcXJlkQKUb7jJekeswSTM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-gTLeAb-SNWyD-IjGpOpOGA-1; Thu,
 16 Jul 2026 14:15:13 -0400
X-MC-Unique: gTLeAb-SNWyD-IjGpOpOGA-1
X-Mimecast-MFC-AGG-ID: gTLeAb-SNWyD-IjGpOpOGA_1784225712
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6A041955F26;
	Thu, 16 Jul 2026 18:15:12 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 447B3195604E;
	Thu, 16 Jul 2026 18:15:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 22/24] KVM: x86: selftests: Introduce memory attributes test
Date: Thu, 16 Jul 2026 14:14:54 -0400
Message-ID: <20260716181456.402786-23-pbonzini@redhat.com>
In-Reply-To: <20260716181456.402786-1-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/include/uapi/linux/kvm.h                |   3 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |  23 +-
 .../testing/selftests/kvm/memory_attributes.c | 362 ++++++++++++++++++
 .../selftests/kvm/x86/memory_attributes.c     |  43 +++
 5 files changed, 422 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/memory_attributes.c
 create mode 100644 tools/testing/selftests/kvm/x86/memory_attributes.c

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index d0c0c8605976..fe2f500c932d 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1639,6 +1639,9 @@ struct kvm_memory_attributes {
 	__u64 flags;
 };
 
+#define KVM_MEMORY_ATTRIBUTE_NR		       (1ULL << 0)
+#define KVM_MEMORY_ATTRIBUTE_NW		       (1ULL << 1)
+#define KVM_MEMORY_ATTRIBUTE_NX		       (1ULL << 2)
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 4ace12606e93..3e2a6e4398eb 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -162,6 +162,7 @@ TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
+TEST_GEN_PROGS_x86 += memory_attributes
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 04a910164a29..54d73ea46e11 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -418,24 +418,27 @@ static inline void vm_enable_cap(struct kvm_vm *vm, u32 cap, u64 arg0)
 	vm_ioctl(vm, KVM_ENABLE_CAP, &enable_cap);
 }
 
-static inline void vm_set_memory_attributes(struct kvm_vm *vm, gpa_t gpa,
-					    u64 size, u64 attributes)
+static inline int __vm_set_memory_attributes(struct kvm_vm *vm, u64 gpa,
+					     u64 size, u64 attributes,
+					     u64 flags)
 {
 	struct kvm_memory_attributes attr = {
 		.attributes = attributes,
 		.address = gpa,
 		.size = size,
-		.flags = 0,
+		.flags = flags,
 	};
 
-	/*
-	 * KVM_SET_MEMORY_ATTRIBUTES overwrites _all_ attributes.  These flows
-	 * need significant enhancements to support multiple attributes.
-	 */
-	TEST_ASSERT(!attributes || attributes == KVM_MEMORY_ATTRIBUTE_PRIVATE,
-		    "Update me to support multiple attributes!");
+	return __vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
+}
 
-	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
+static inline void vm_set_memory_attributes(struct kvm_vm *vm, gpa_t gpa,
+					    u64 size, u64 attributes)
+{
+	int rc;
+
+	rc = __vm_set_memory_attributes(vm, gpa, size, attributes, 0);
+	TEST_ASSERT_VM_VCPU_IOCTL(!rc, KVM_SET_MEMORY_ATTRIBUTES, rc, vm);
 }
 
 
diff --git a/tools/testing/selftests/kvm/memory_attributes.c b/tools/testing/selftests/kvm/memory_attributes.c
new file mode 100644
index 000000000000..7066ae791b99
--- /dev/null
+++ b/tools/testing/selftests/kvm/memory_attributes.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024, Amazon.com, Inc. or its affiliates. All Rights Reserved
+ *
+ * Test for KVM_MEMORY_ATTRIBUTES
+ */
+#include <pthread.h>
+#include <signal.h>
+
+#include "test_util.h"
+#include "ucall_common.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "hyperv.h"
+#include "apic.h"
+#include "asm/pvclock-abi.h"
+
+#define KVM_MEMORY_ATTRIBUTE_NO_ACCESS                       \
+	(KVM_MEMORY_ATTRIBUTE_NR | KVM_MEMORY_ATTRIBUTE_NW | \
+	 KVM_MEMORY_ATTRIBUTE_NX)
+
+#define MMIO_GPA	0x700000000
+#define MMIO_GVA	MMIO_GPA
+
+enum {
+	TEST_OP_NOP,
+	TEST_OP_READ,
+	TEST_OP_WRITE,
+	TEST_OP_EXEC,
+	TEST_OP_EXIT,
+};
+
+const char *test_op_names[] =
+{
+	[TEST_OP_READ] = "Read",
+	[TEST_OP_WRITE] = "Write",
+	[TEST_OP_EXEC] = "Exec",
+	[TEST_OP_EXIT] = "Exit",
+};
+
+struct test_data {
+	uint8_t op;
+	int stage;
+	gva_t vaddr;
+
+	struct kvm_vcpu *vcpu;
+};
+
+static struct test_data *test_data;
+
+static uint64_t arch_controlled_read(gva_t addr);
+static void arch_controlled_write(gva_t addr, uint64_t val);
+static void arch_controlled_exec(gva_t addr);
+static void arch_write_return_insn(struct kvm_vm *vm, gpa_t vaddr);
+
+static void guest_code(void *data)
+{
+	struct test_data *test_data = data;
+	int stage = 1;
+
+	while (true) {
+		gva_t vaddr = READ_ONCE(test_data->vaddr);
+
+		switch(READ_ONCE(test_data->op)) {
+		case TEST_OP_READ:
+			(void) arch_controlled_read(vaddr);
+			GUEST_SYNC(stage++);
+			break;
+		case TEST_OP_WRITE:
+			arch_controlled_write(vaddr, 1);
+			GUEST_SYNC(stage++);
+			break;
+		case TEST_OP_EXEC:
+			arch_controlled_exec(vaddr);
+			GUEST_SYNC(stage++);
+			break;
+		default:
+			goto exit;
+		};
+	}
+
+exit:
+	GUEST_DONE();
+}
+
+static void vcpu_run_and_inc_stage(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_SYNC:
+		TEST_ASSERT(uc.args[1] == test_data->stage,
+			    "Unexpected stage: %ld (%d expected)",
+			    uc.args[1], test_data->stage);
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		/* NOT REACHED */
+	default:
+		TEST_FAIL("Unknown ucall %lu", uc.cmd);
+	}
+
+	test_data->stage++;
+}
+
+static void test_page_restricted(struct kvm_vcpu *vcpu, int op,
+				 gva_t vaddr, gpa_t fault_paddr,
+				 uint64_t fault_reason)
+{
+	struct kvm_vm *vm = vcpu->vm;
+	int rc;
+
+	test_data->op = op;
+	test_data->vaddr = vaddr;
+
+	rc = _vcpu_run(vcpu);
+	TEST_ASSERT(rc == -1 && errno == EFAULT,
+		    "KVM_RUN IOCTL didn't return EFAULT on %s, rc %d, errno %d",
+		    test_op_names[op], rc, errno);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_MEMORY_FAULT);
+	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, fault_paddr);
+	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, fault_reason);
+	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, vm->page_size);
+}
+
+static void test_page_accessible(struct kvm_vcpu *vcpu, int op, gva_t vaddr)
+{
+	test_data->op = op;
+	test_data->vaddr = vaddr;
+	vcpu_run_and_inc_stage(vcpu);
+}
+
+#include "x86/memory_attributes.c"
+
+/*
+ * We want to test the following cases:
+ * - Sucessful access to GPAs backed by memory attributes (for ex. read access
+ *   on an read-only page).
+ * - First fault after setting memory attributes, with unpopulated SPTEs/EPTS.
+ * - Fault caused by an SPTE/EPT reflecting the memory attributes.
+ *
+ * The list of ops below tests the 3 situations for each memory attribute
+ * combination.
+ */
+const struct memory_access {
+	const char *name;
+	uint64_t attrs;
+	int ops[5];
+} access_array[] = {
+	{ "all allowed", 0, { TEST_OP_READ, TEST_OP_WRITE, TEST_OP_EXEC } },
+	{ "no write (unmapped)", KVM_MEMORY_ATTRIBUTE_NW,
+	  { TEST_OP_WRITE, TEST_OP_READ, TEST_OP_EXEC, TEST_OP_WRITE } },
+	{ "no write (mapped)", KVM_MEMORY_ATTRIBUTE_NW,
+	  { TEST_OP_READ, TEST_OP_WRITE, TEST_OP_READ, TEST_OP_EXEC, TEST_OP_WRITE } },
+	{ "no exec (unmapped)", KVM_MEMORY_ATTRIBUTE_NX,
+	  { TEST_OP_EXEC, TEST_OP_READ, TEST_OP_WRITE, TEST_OP_EXEC } },
+	{ "no exec (mapped)", KVM_MEMORY_ATTRIBUTE_NX,
+	  { TEST_OP_READ, TEST_OP_EXEC, TEST_OP_READ, TEST_OP_WRITE, TEST_OP_EXEC } },
+	{ "read only", KVM_MEMORY_ATTRIBUTE_NW | KVM_MEMORY_ATTRIBUTE_NX,
+	  { TEST_OP_EXEC, TEST_OP_WRITE, TEST_OP_READ, TEST_OP_WRITE,
+	    TEST_OP_EXEC } },
+	{ "no access (map on read)", KVM_MEMORY_ATTRIBUTE_NO_ACCESS,
+	  { TEST_OP_READ, TEST_OP_WRITE, TEST_OP_EXEC } },
+	{ "no access (map on write)", KVM_MEMORY_ATTRIBUTE_NO_ACCESS,
+	  { TEST_OP_WRITE, TEST_OP_READ, TEST_OP_EXEC } },
+	{ "no access (map on exec)", KVM_MEMORY_ATTRIBUTE_NO_ACCESS,
+	  { TEST_OP_EXEC, TEST_OP_READ, TEST_OP_WRITE } },
+	/* Verify everything is back to normal */
+	{ "all allowed (2)", 0, { TEST_OP_READ, TEST_OP_WRITE, TEST_OP_EXEC } },
+};
+
+static void test_page_access(struct kvm_vcpu *vcpu, gva_t vaddr,
+			     uint64_t attrs, const int ops[])
+{
+	struct kvm_vm *vm = vcpu->vm;
+	gpa_t paddr = addr_gva2gpa(vm, vaddr);
+
+	for (int i = 0; i < ARRAY_SIZE(access_array[0].ops); i++) {
+		int op = ops[i];
+
+		if (op == TEST_OP_NOP)
+			continue;
+
+		/*
+		 * We're about to have the guest jump into 'vaddr', make it a
+		 * 'ret' instruction so it returns right away.
+		 */
+		if (op == TEST_OP_EXEC)
+			arch_write_return_insn(vm, paddr);
+
+		vm_set_memory_attributes(vm, paddr, vm->page_size, attrs);
+
+		/*
+		 * Attributes are negated, a match means the operation should
+		 * fail.
+		 */
+		if (attrs & BIT_ULL(op - 1)) {
+			test_page_restricted(vcpu, op, vaddr, paddr, BIT(op - 1));
+			vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
+		}
+
+		test_page_accessible(vcpu, op, vaddr);
+	}
+
+}
+
+static void test_memory_access(struct kvm_vcpu *vcpu, gva_t test_vm_vaddr,
+			       size_t size)
+{
+	struct kvm_vm *vm = vcpu->vm;
+	gpa_t test_vm_paddr = addr_gva2gpa(vm, test_vm_vaddr);
+
+	printf("gva %lx gpa %lx\n", test_vm_vaddr, test_vm_paddr);
+	for (size_t i = 0; i < ARRAY_SIZE(access_array); i++) {
+		uint64_t attrs = access_array[i].attrs;
+
+		printf("starting %s test...\n", access_array[i].name);
+		vm_set_memory_attributes(vm, test_vm_paddr, size, attrs);
+
+		for (gva_t vaddr = test_vm_vaddr;
+		     vaddr < test_vm_vaddr + size; vaddr += PAGE_SIZE) {
+			test_page_access(vcpu, vaddr, attrs, access_array[i].ops);
+		}
+	}
+}
+
+static void test_memattrs_ignore_mmio(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vm *vm = vcpu->vm;
+
+	vm_set_memory_attributes(vm, MMIO_GPA, vm->page_size,
+				 KVM_MEMORY_ATTRIBUTE_NO_ACCESS);
+
+	test_data->op = TEST_OP_READ;
+	test_data->vaddr = MMIO_GVA;
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_MMIO);
+	TEST_ASSERT_EQ(vcpu->run->mmio.phys_addr, MMIO_GPA);
+	TEST_ASSERT_EQ(vcpu->run->mmio.is_write, 0);
+	TEST_ASSERT_EQ(vcpu->run->mmio.len, 8);
+	vcpu_run_and_inc_stage(vcpu);
+
+	test_data->op = TEST_OP_WRITE;
+	test_data->vaddr = MMIO_GVA;
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_MMIO);
+	TEST_ASSERT_EQ(vcpu->run->mmio.phys_addr, MMIO_GPA);
+	TEST_ASSERT_EQ(vcpu->run->mmio.is_write, 1);
+	TEST_ASSERT_EQ(vcpu->run->mmio.len, 8);
+	vcpu_run_and_inc_stage(vcpu);
+
+	vm_set_memory_attributes(vm, MMIO_GPA, vm->page_size, 0);
+}
+
+static void test_input_validation(struct kvm_vm *vm)
+{
+	uint64_t flags, gpa = 0, size = 0, attrs = 0;
+	int rc;
+
+	/* 'flags' is unsupported */
+	flags = BIT(0);
+	rc = __vm_set_memory_attributes(vm, gpa, size, attrs, flags);
+	TEST_ASSERT_VM_VCPU_IOCTL(rc == -1 && errno == EINVAL,
+				  KVM_SET_MEMORY_ATTRIBUTES, rc, vm);
+
+	/* 'size' can't be 0 */
+	flags = 0;
+	rc = __vm_set_memory_attributes(vm, gpa, size, attrs, flags);
+	TEST_ASSERT_VM_VCPU_IOCTL(rc == -1 && errno == EINVAL,
+				  KVM_SET_MEMORY_ATTRIBUTES, rc, vm);
+
+	/* 'gpa' shouldn't overflow */
+	gpa = 0ULL - vm->page_size;
+	size = vm->page_size;
+	rc = __vm_set_memory_attributes(vm, gpa, size, attrs, flags);
+	TEST_ASSERT_VM_VCPU_IOCTL(rc == -1 && errno == EINVAL,
+				  KVM_SET_MEMORY_ATTRIBUTES, rc, vm);
+
+	/* 'gpa' should be page aligned */
+	gpa = 1;
+	rc = __vm_set_memory_attributes(vm, gpa, size, attrs, flags);
+	TEST_ASSERT_VM_VCPU_IOCTL(rc == -1 && errno == EINVAL,
+				  KVM_SET_MEMORY_ATTRIBUTES, rc, vm);
+
+	/* 'size' should be page aligned */
+	gpa = 0;
+	size = 1;
+	rc = __vm_set_memory_attributes(vm, gpa, size, attrs, flags);
+	TEST_ASSERT_VM_VCPU_IOCTL(rc == -1 && errno == EINVAL,
+				  KVM_SET_MEMORY_ATTRIBUTES, rc, vm);
+
+	/* exec mappings require read access */
+	size = vm->page_size;
+	attrs = KVM_MEMORY_ATTRIBUTE_NR | KVM_MEMORY_ATTRIBUTE_NW;
+	rc = __vm_set_memory_attributes(vm, gpa, size, attrs, flags);
+	TEST_ASSERT_VM_VCPU_IOCTL(rc == -1 && errno == EINVAL,
+				  KVM_SET_MEMORY_ATTRIBUTES, rc, vm);
+
+	/* write mappings require read access */
+	size = vm->page_size;
+	attrs = KVM_MEMORY_ATTRIBUTE_NR | KVM_MEMORY_ATTRIBUTE_NX;
+	rc = __vm_set_memory_attributes(vm, gpa, size, attrs, flags);
+	TEST_ASSERT_VM_VCPU_IOCTL(rc == -1 && errno == EINVAL,
+				  KVM_SET_MEMORY_ATTRIBUTES, rc, vm);
+
+	/* private mappings are incompatible with access restrictions */
+	attrs = KVM_MEMORY_ATTRIBUTE_NW | KVM_MEMORY_ATTRIBUTE_PRIVATE;
+	rc = __vm_set_memory_attributes(vm, gpa, size, attrs, flags);
+	TEST_ASSERT_VM_VCPU_IOCTL(rc == -1 && errno == EINVAL,
+				  KVM_SET_MEMORY_ATTRIBUTES, rc, vm);
+}
+
+static void test_finalize(struct kvm_vcpu *vcpu)
+{
+	test_data->op = TEST_OP_EXIT;
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+}
+
+static struct test_data *init_test_data(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vm *vm = vcpu->vm;
+	gva_t test_data_vm_vaddr;
+
+	test_data_vm_vaddr = vm_alloc_page(vm);
+	vcpu_args_set(vcpu, 1, test_data_vm_vaddr);
+
+	test_data = addr_gva2hva(vm, test_data_vm_vaddr);
+	test_data->stage = 1;
+	test_data->vcpu = vcpu;
+
+	return test_data;
+}
+
+int main(int argc, char *argv[])
+{
+	uint32_t guest_page_size = vm_guest_mode_params[VM_MODE_DEFAULT].page_size;
+	unsigned int ptes_per_page = guest_page_size / 8;
+	size_t size = guest_page_size * ptes_per_page * 2; /* 2 huge-pages */
+	struct kvm_vcpu *vcpu;
+	gva_t test_mem;
+	struct kvm_vm *vm;
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) &
+		     KVM_MEMORY_ATTRIBUTE_NO_ACCESS);
+
+	vm = __vm_create_with_one_vcpu(&vcpu, size, guest_code);
+	test_mem = vm_alloc(vm, size, KVM_UTIL_MIN_VADDR);
+	virt_map(vcpu->vm, MMIO_GVA, MMIO_GPA, 1);
+	test_data = init_test_data(vcpu);
+
+	test_input_validation(vm);
+	test_memory_access(vcpu, test_mem, size);
+	test_memattrs_ignore_mmio(vcpu);
+	test_finalize(vcpu);
+
+	kvm_vm_free(vm);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86/memory_attributes.c b/tools/testing/selftests/kvm/x86/memory_attributes.c
new file mode 100644
index 000000000000..2e1148f5146d
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/memory_attributes.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024, Amazon.com, Inc. or its affiliates. All Rights Reserved
+ *
+ * Test for KVM_MEMORY_ATTRIBUTES
+ */
+#include "kvm_util.h"
+#include "apic.h"
+
+uint64_t arch_controlled_read(gva_t addr)
+{
+	uint64_t val;
+
+	asm volatile("mov %[addr], %%rax \n\r"
+		     "mov (%%rax), %[val] \n\r"
+		     : [val] "=r" (val)
+		     : [addr] "m"(addr)
+		     : "memory", "rax");
+
+	return val;
+}
+
+void arch_controlled_write(gva_t addr, uint64_t val)
+{
+	asm volatile("mov %[addr], %%rax \n\r"
+		     "mov %[val], %%rbx \n\r"
+		     "mov %%rbx, (%%rax) \n\r"
+		     :: [addr] "m" (addr), [val] "m" (val)
+		     : "memory", "rax", "rbx");
+}
+
+void arch_controlled_exec(gva_t addr)
+{
+	asm volatile("mov %[addr], %%rax \n\r"
+		     "call *%%rax \n\t"
+		     :: [addr] "m"(addr)
+		     : "memory", "rax");
+}
+
+void arch_write_return_insn(struct kvm_vm *vm, gpa_t vaddr)
+{
+	memset(addr_gpa2hva(vm, vaddr), 0xc3, 1);
+}
-- 
2.52.0


