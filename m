Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641536;
	b=4lh6vJNXHiARraaErsdAYzb7OD1jTTlnjWvhPzvjzjMPLSIrNrkHEwN1fT46px/1ivrj
	 6PFZeLzYTFRu2OS67QJUCResf+bgkTZBXMoyy0tcsUDYlx0tch3JZeulp2oHxMaGQcxU+
	 /mEV88VR6SaK/R3HbTj90WtmbadoPKchDCamR0lqpTf4hJQrxSDv5M0sFSeW72nzkG5I8
	 d95EWOLTNaXcWAgFmkZQtPnRTMKu6rRed4/yyBTUj0voFOOUb2zD4vMZckQHvPYMW9HRk
	 PEtsg/O5ZfrDgVUlZRMo8gAmsEHlY66b6+E+N6xVMVVvKuFjmG3ujlObHdkTBCytxvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641536;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=wA8wUaWAFPAox7mKuyieWvEtSAEW/O4tY0glDMVj8GA=;
	b=KpENuUcduRNkeljE+t20FOvPrcGvEfl3aqusS8gjgxlZznL+sqAygsVUFJHO9xjasjND
	 ESAHsB4sdcBIpOa885/Zyd6fDAIaHw/hRFeQbXi80M9jrS1teZMhP58A1lR1EXOFQOR8A
	 3BqPymEmhNbnMgBFhrLs9Ah/4q7qDytYz1ed2zarXK/KXEyr0NqsyNCzD/RHE0PpgP0gJ
	 xTBEEOIjXEd1VtYLqJaWyTXpYc31w4qnv8Xx+pVjoSXT+hLYVwb3ujcrto8HHcnXuxGFU
	 k0I8ejrb3qVR4tKMMpIJWhRHzIVrOtKrHw5xoOzoZn3T6kJ54+/K1FN9qzSZcA9dSkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YlM257qV;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCEF6074878
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DCEF6074878
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YlM257qV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wA8wUaWAFPAox7mKuyieWvEtSAEW/O4tY0glDMVj8GA=;
	b=YlM257qVldRzVsXeJCdzv/qXCMGg6kYrhbmQ6fuBukTbhOFMDhWhRZdnmensiothBD9q13
	9Si/TVEQOwjoKYpP14AI5altmbXXkjuqlgoBpGYQ7W3VKnSsionI8HutXrRFSgYTTsVeMM
	GhZec2l6wqYsoggFX4yxc9kCkUQhr/Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-oX-V8-crNk65A6Em6BusPw-1; Mon,
 02 Nov 2026 12:45:31 -0500
X-MC-Unique: oX-V8-crNk65A6Em6BusPw-1
X-Mimecast-MFC-AGG-ID: oX-V8-crNk65A6Em6BusPw_1793641530
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 865ED195604C;
	Mon,  2 Nov 2026 17:45:30 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13FE21800347;
	Mon,  2 Nov 2026 17:45:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 42/45] KVM: x86: selftests: Introduce memory protection attributes test
Date: Mon,  2 Nov 2026 12:45:09 -0500
Message-ID: <20261102174512.8903-26-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Introduce architecture-independent tests for memory attributes, using
small architecture-specific snippets to handle the execution tests.

Co-developed-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-30-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/include/uapi/linux/kvm.h                |   3 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |  18 +-
 .../testing/selftests/kvm/memory_attributes.c | 344 ++++++++++++++++++
 .../selftests/kvm/x86/memory_attributes.c     |  43 +++
 5 files changed, 405 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/memory_attributes.c
 create mode 100644 tools/testing/selftests/kvm/x86/memory_attributes.c

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 419011097fa8..9bd6488adc62 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1649,6 +1649,9 @@ struct kvm_memory_attributes {
 	__u64 flags;
 };
 
+#define KVM_MEMORY_ATTRIBUTE_NR		       (1ULL << 0)
+#define KVM_MEMORY_ATTRIBUTE_NW		       (1ULL << 1)
+#define KVM_MEMORY_ATTRIBUTE_NX		       (1ULL << 2)
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 478b85ceb7fb..6e123f690b43 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -173,6 +173,7 @@ TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
+TEST_GEN_PROGS_x86 += memory_attributes
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 7e480c034a87..51b173105d3c 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -473,17 +473,27 @@ static inline void vm_enable_cap(struct kvm_vm *vm, u32 cap, u64 arg0)
 int kvm_gpa_to_guest_memfd(struct kvm_vm *vm, gpa_t gpa, off_t *fd_offset,
 			   size_t *nr_bytes);
 
-static inline void vm_set_memory_attributes(struct kvm_vm *vm, gpa_t gpa,
-					    size_t size, u64 attributes)
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
 
-	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
+	return __vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
+}
+
+static inline void vm_set_memory_attributes(struct kvm_vm *vm, gpa_t gpa,
+					    u64 size, u64 attributes)
+{
+	int rc;
+
+	rc = __vm_set_memory_attributes(vm, gpa, size, attributes, 0);
+	TEST_ASSERT_VM_VCPU_IOCTL(!rc, KVM_SET_MEMORY_ATTRIBUTES, rc, vm);
 }
 
 static inline int __gmem_set_memory_attributes(int fd, u64 offset,
diff --git a/tools/testing/selftests/kvm/memory_attributes.c b/tools/testing/selftests/kvm/memory_attributes.c
new file mode 100644
index 000000000000..81ec59382f55
--- /dev/null
+++ b/tools/testing/selftests/kvm/memory_attributes.c
@@ -0,0 +1,344 @@
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
+#define TEST_MEM_SLOT	1
+#define TEST_MEM_GPA	0x80000000
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
+	size_t pages = ptes_per_page * 2; /* 2 huge-pages */
+	size_t size = guest_page_size * pages;
+	struct kvm_vcpu *vcpu;
+	gva_t test_mem;
+	struct kvm_vm *vm;
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) &
+		     KVM_MEMORY_ATTRIBUTE_NO_ACCESS);
+
+	vm = __vm_create_with_one_vcpu(&vcpu, pages, guest_code);
+
+	/* add a few extra pages for use by tests */
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    TEST_MEM_GPA, TEST_MEM_SLOT,
+				    pages + 100, 0);
+	vm->memslots[MEM_REGION_TEST_DATA] = TEST_MEM_SLOT;
+
+	test_mem = vm_alloc_pages(vm, pages);
+	virt_map(vcpu->vm, MMIO_GVA, MMIO_GPA, 1);
+	test_data = init_test_data(vcpu);
+
+	test_input_validation(vm);
+	test_memory_access(vcpu, test_mem, size);
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


