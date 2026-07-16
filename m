Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C142445AF3
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225728; cv=none; b=fjJ814A+t5lpS0w6FNDclxxCVKOkHN+7MpjpDGW5JChg/4AgFtsESVCN6+5kZc172PMIB3LFiId4NdWM+dp0Sr5bF2I1tl5SWSn/aEX17FVCha6v/kP7bvpFZSbPrwpGw92clGenOiuOXm4tLTyW1AdKECu3jAIOSqK4jjZMXMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225728; c=relaxed/simple;
	bh=eP2HFC3tD3/Odtv7gB+vAzMwhRUmOmY+r+l4Pc96sS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSZhEgjvBwapVaAnsQpEi9BY+K98aoTBYQCL313rWD47wlos0UM0nPJVo9ylvzdyEFPfiRIPg3GBC+xS/tsLg77d+ThPXT7QsGPf5MnXfQOqKcrBWyIhNRguoUy2LMr/LhWvBbD3wLB+QrrE9NTFp1emeAjnMWY2hZJ1y7EYToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fA+i3lV1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fA+i3lV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMR1jZbfx2MG/9n6DX7JRLieA7qEPCzB1A94SEYRI2Y=;
	b=fA+i3lV1jYoro+7dviLKgVAlYUQefpX1+eOyDO7wwFEjPuaNU8+90jC+MS1CQQlF8ZqEfn
	/51cGuJ5XvaGHrv8weJBg6i+pmqX6/p0N2wIxVgG2qtgKhvV3wMjhjHNVDnUIeSMZIs2WV
	zMwFTaYgVNLnYwbQh9PereIJqjUEhCc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-tlhDSg_pOsm1wyj0LIgNCg-1; Thu,
 16 Jul 2026 14:15:14 -0400
X-MC-Unique: tlhDSg_pOsm1wyj0LIgNCg-1
X-Mimecast-MFC-AGG-ID: tlhDSg_pOsm1wyj0LIgNCg_1784225714
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF5441800671;
	Thu, 16 Jul 2026 18:15:13 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E569195604E;
	Thu, 16 Jul 2026 18:15:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 24/24] KVM: x86: selftests: Introduce memory attributes side-channel tests
Date: Thu, 16 Jul 2026 14:14:56 -0400
Message-ID: <20260716181456.402786-25-pbonzini@redhat.com>
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

Introduce memory attributes selftests to catch any vulnerable
side-channels.

Memory attributes access restrictions are vulnerable to side-channel
attacks. This means that any KVM operation initiated by the guest that
requires guest memory access (which is the case for most
para-virtualised interfaces) needs to consider memory attributes.

The tests confirm this requirement is upheld for a variety of use-cases,
and were selected to exercise specific approaches to guest memory
access, including:
 - kvm_read/write_guest()
 - gfn_to_hva_cache
 - gfn_to_pfn_cache
 - Guest page walker (which uses __try_cmpxchg_user())

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  10 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../testing/selftests/kvm/lib/x86/processor.c |   5 +
 .../testing/selftests/kvm/memory_attributes.c |  63 ++++-
 .../selftests/kvm/x86/memory_attributes.c     | 216 ++++++++++++++++++
 5 files changed, 294 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 54d73ea46e11..3160a25966a1 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -883,6 +883,16 @@ static inline int vcpu_get_stats_fd(struct kvm_vcpu *vcpu)
 	return fd;
 }
 
+static inline struct kvm_translation vcpu_translate(struct kvm_vcpu *vcpu,
+						    u64 gva)
+{
+	struct kvm_translation tr;
+
+	tr.linear_address = gva;
+	vcpu_ioctl(vcpu, KVM_TRANSLATE, &tr);
+	return tr;
+}
+
 int __kvm_has_device_attr(int dev_fd, u32 group, u64 attr);
 
 static inline void kvm_has_device_attr(int dev_fd, u32 group, u64 attr)
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 7d3a27bc0d84..d9876377968f 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1422,6 +1422,7 @@ static inline bool kvm_is_lbrv_enabled(void)
 	return !!get_kvm_amd_param_integer("lbrv");
 }
 
+u64 *vm_get_pte_level(struct kvm_vm *vm, gva_t gva, int *level);
 u64 *vm_get_pte(struct kvm_vm *vm, gva_t gva);
 
 u64 kvm_hypercall(u64 nr, u64 a0, u64 a1, u64 a2, u64 a3);
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index ef56dcefe011..8b990016e764 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -397,6 +397,11 @@ u64 *tdp_get_pte(struct kvm_vm *vm, u64 l2_gpa)
 	return __vm_get_page_table_entry(vm, &vm->stage2_mmu, l2_gpa, &level);
 }
 
+u64 *vm_get_pte_level(struct kvm_vm *vm, gva_t gva, int *level)
+{
+	return __vm_get_page_table_entry(vm, &vm->mmu, gva, level);
+}
+
 u64 *vm_get_pte(struct kvm_vm *vm, gva_t gva)
 {
 	int level = PG_LEVEL_4K;
diff --git a/tools/testing/selftests/kvm/memory_attributes.c b/tools/testing/selftests/kvm/memory_attributes.c
index c66d5d085a9c..843fafcf4d96 100644
--- a/tools/testing/selftests/kvm/memory_attributes.c
+++ b/tools/testing/selftests/kvm/memory_attributes.c
@@ -19,6 +19,8 @@
 	(KVM_MEMORY_ATTRIBUTE_NR | KVM_MEMORY_ATTRIBUTE_NW | \
 	 KVM_MEMORY_ATTRIBUTE_NX)
 
+#define HV_STATUS_INVALID_HYPERCALL_INPUT	3
+
 #define MMIO_GPA	0x700000000
 #define MMIO_GVA	MMIO_GPA
 
@@ -26,12 +28,35 @@
 #define PT_ACCESSED_MASK	BIT_ULL(5)
 #define PTE_VADDR		0x1000000000
 
+static volatile uint64_t ipis_rcvd;
+
+static pthread_t vcpu_thread;
+
+struct hv_vpset {
+	u64 format;
+	u64 valid_bank_mask;
+	u64 bank_contents[2];
+};
+
+enum HV_GENERIC_SET_FORMAT {
+	HV_GENERIC_SET_SPARSE_4K,
+	HV_GENERIC_SET_ALL,
+};
+
+struct hv_send_ipi_ex {
+	u32 vector;
+	u32 reserved;
+	struct hv_vpset vp_set;
+};
+
 enum {
 	TEST_OP_NOP,
 	TEST_OP_READ,
 	TEST_OP_WRITE,
 	TEST_OP_EXEC,
 	TEST_OP_INVPLG,
+	TEST_OP_HYPERV_HYPERCALL_INPUT,
+	TEST_OP_MONITOR_ADDRESS,
 	TEST_OP_EXIT,
 };
 
@@ -41,6 +66,8 @@ const char *test_op_names[] =
 	[TEST_OP_WRITE] = "Write",
 	[TEST_OP_EXEC] = "Exec",
 	[TEST_OP_INVPLG] = "Invplg",
+	[TEST_OP_HYPERV_HYPERCALL_INPUT] = "HvHcall input",
+	[TEST_OP_MONITOR_ADDRESS] = "Monitor address",
 	[TEST_OP_EXIT] = "Exit",
 };
 
@@ -48,6 +75,8 @@ struct test_data {
 	uint8_t op;
 	int stage;
 	gva_t vaddr;
+	gpa_t paddr;
+	uint8_t confirm_read;
 	uint64_t expected_val;
 
 	struct kvm_vcpu *vcpu;
@@ -59,19 +88,27 @@ static uint64_t arch_controlled_read(gva_t addr);
 static void arch_controlled_write(gva_t addr, uint64_t val);
 static void arch_controlled_exec(gva_t addr);
 static void arch_write_return_insn(struct kvm_vm *vm, gpa_t vaddr);
+static void arch_guest_init(void);
 
 static void guest_code(void *data)
 {
 	struct test_data *test_data = data;
 	int stage = 1;
 
+	arch_guest_init();
+
 	while (true) {
 		uint64_t expected_val = READ_ONCE(test_data->expected_val);
+		bool confirm_read = READ_ONCE(test_data->confirm_read);
 		gva_t vaddr = READ_ONCE(test_data->vaddr);
+		gpa_t paddr = READ_ONCE(test_data->paddr);
+		u64 val;
 
 		switch(READ_ONCE(test_data->op)) {
 		case TEST_OP_READ:
-			(void) arch_controlled_read(vaddr);
+			val = arch_controlled_read(vaddr);
+			if (confirm_read)
+				GUEST_ASSERT_EQ(expected_val, val);
 			GUEST_SYNC(stage++);
 			break;
 		case TEST_OP_WRITE:
@@ -88,6 +125,25 @@ static void guest_code(void *data)
 				     :: "b" (vaddr): "memory");
 			GUEST_SYNC(stage++);
 			break;
+		case TEST_OP_HYPERV_HYPERCALL_INPUT: {
+			hyperv_hypercall(HVCALL_SEND_IPI_EX, paddr, 0);
+			asm volatile ("sti; hlt; cli;");
+			GUEST_ASSERT_EQ(ipis_rcvd, 1);
+			GUEST_SYNC(stage++);
+			break;
+		}
+		case TEST_OP_MONITOR_ADDRESS: {
+			uint64_t *pval = (uint64_t *)vaddr;
+			uint64_t val = READ_ONCE(*pval);
+
+			while (READ_ONCE(*pval) == val &&
+			       /* So host can force the op out of the loop */
+			       READ_ONCE(test_data->op) == TEST_OP_MONITOR_ADDRESS)
+				asm volatile("nop");
+
+			GUEST_SYNC(stage++);
+			break;
+		}
 #endif
 		default:
 			goto exit;
@@ -145,6 +201,7 @@ static void test_page_restricted(struct kvm_vcpu *vcpu, int op,
 
 	test_data->op = op;
 	test_data->vaddr = vaddr;
+	test_data->paddr = fault_paddr;
 
 	rc = _vcpu_run(vcpu);
 	TEST_ASSERT(rc == -1 && errno == EFAULT,
@@ -382,12 +439,16 @@ int main(int argc, char *argv[])
 	test_mem = vm_alloc(vm, size, KVM_UTIL_MIN_VADDR);
 	virt_map(vcpu->vm, MMIO_GVA, MMIO_GPA, 1);
 	test_data = init_test_data(vcpu);
+#ifdef __x86_64__
+	vcpu_set_hv_cpuid(vcpu);
+#endif
 
 	test_input_validation(vm);
 	test_memory_access(vcpu, test_mem, size);
 	test_memattrs_ignore_mmio(vcpu);
 #ifdef __x86_64__
 	arch_test_memory_access_pte(vcpu, test_mem);
+	arch_test_side_channels(vcpu, test_mem, size);
 #endif
 	test_finalize(vcpu);
 
diff --git a/tools/testing/selftests/kvm/x86/memory_attributes.c b/tools/testing/selftests/kvm/x86/memory_attributes.c
index 3d2bcfe71884..5203d284d2d3 100644
--- a/tools/testing/selftests/kvm/x86/memory_attributes.c
+++ b/tools/testing/selftests/kvm/x86/memory_attributes.c
@@ -42,6 +42,11 @@ void arch_write_return_insn(struct kvm_vm *vm, gpa_t vaddr)
 	memset(addr_gpa2hva(vm, vaddr), 0xc3, 1);
 }
 
+void arch_guest_init(void)
+{
+	x2apic_enable();
+}
+
 /*
  * This test validates that, during a page walk, if the page a PTE is placed in
  * is read-only the accesss and dirty bits will not be written. Note There's a
@@ -167,3 +172,214 @@ static void arch_test_memory_access_pte(struct kvm_vcpu *vcpu, gva_t vaddr)
 	test_memory_access_pte_ro(vcpu, vaddr);
 	test_memory_access_sync_spte(vcpu, vaddr);
 }
+
+#define IPI_VECTOR	 0xfe
+
+static void guest_ipi_handler_hv(struct ex_regs *regs)
+{
+	ipis_rcvd++;
+	wrmsr(HV_X64_MSR_EOI, 1);
+}
+
+/*
+ * This test verifies that the Hyper-V hypercall exit handler takes memory
+ * attributes into account before accessing input data. It coordinates with the
+ * guest through the 'TEST_OP_HYPERV_HYPERCALL_INPUT' operation and instructs
+ * the guest to issue two PV IPIs. The first PV IPI fails because the input
+ * data is held in read-protected memory. Subsequently, the memory protection
+ * is lifted, and the second PV IPI succeeds.
+ */
+static void test_side_channel_hyperv_hypercall_inputs(struct kvm_vcpu *vcpu,
+						      gva_t vaddr,
+						      size_t size)
+{
+	struct kvm_vm *vm = vcpu->vm;
+	struct hv_send_ipi_ex *ipi_ex = addr_gva2hva(vm, vaddr);
+	gpa_t paddr = addr_gva2gpa(vm, test_data->vaddr);
+
+	if (!kvm_has_cap(KVM_CAP_HYPERV_SEND_IPI) ||
+	    !kvm_has_cap(KVM_CAP_HYPERV_HCALL_FAULT_EXIT))
+		return;
+
+	vm_enable_cap(vcpu->vm, KVM_CAP_HYPERV_HCALL_FAULT_EXIT, 1);
+
+	ipis_rcvd = 0;
+	vm_install_exception_handler(vm, IPI_VECTOR, guest_ipi_handler_hv);
+	vcpu_set_msr(vcpu, HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
+
+	ipi_ex->vector = IPI_VECTOR;
+	ipi_ex->vp_set.format = HV_GENERIC_SET_ALL;
+	vm_set_memory_attributes(vm, paddr, vm->page_size, KVM_MEMORY_ATTRIBUTE_NO_ACCESS);
+	test_page_restricted(vcpu, TEST_OP_HYPERV_HYPERCALL_INPUT, vaddr, paddr,
+			     KVM_MEMORY_EXIT_FLAG_READ);
+	vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
+	vcpu_run_and_inc_stage(vcpu);
+}
+
+/*
+ * Verifies that the guest page table walker fails the walk if it encounters a
+ * page table entry address read-protected by a memory attribute.
+ */
+static void test_side_channel_emul_page_walks(struct kvm_vcpu *vcpu,
+					      gva_t test_vm_addr,
+					      size_t size)
+{
+	const uint64_t pte_addr_mask = GENMASK(51, 12);
+	struct kvm_vm *vm = vcpu->vm;
+	struct kvm_translation tr;
+	int level = PG_LEVEL_1G;
+	gpa_t paddr;
+	uint64_t *pte;
+
+	pte = vm_get_pte_level(vm, test_vm_addr, &level);
+	TEST_ASSERT_EQ(level, PG_LEVEL_1G);
+	paddr = *pte & pte_addr_mask;
+
+	tr = vcpu_translate(vcpu, test_vm_addr);
+	TEST_ASSERT_EQ(tr.valid, true);
+	TEST_ASSERT_EQ(tr.physical_address, addr_gva2gpa(vm, test_vm_addr));
+
+	vm_set_memory_attributes(vm, paddr, vm->page_size, KVM_MEMORY_ATTRIBUTE_NO_ACCESS);
+	tr = vcpu_translate(vcpu, test_vm_addr);
+	TEST_ASSERT_EQ(tr.valid, false);
+
+	vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
+}
+
+static void vm_set_vapic_addr(struct kvm_vcpu *vcpu, uint64_t addr)
+{
+	struct kvm_vapic_addr va;
+
+	va.vapic_addr = addr;
+	vcpu_ioctl(vcpu, KVM_SET_VAPIC_ADDR, &va);
+}
+
+/*
+ * Perform a dummy regs update to issue a KVM_REQ_EVENT. This forces
+ * vapic to be synced before entering the guest.
+ */
+static void vcpu_force_vapic_update(struct kvm_vcpu *vcpu)
+{
+	struct kvm_regs regs;
+
+	vcpu_regs_get(vcpu, &regs);
+	vcpu_regs_set(vcpu, &regs);
+}
+
+/*
+ * Setup the vapic address on a GPA that is write-protected. Force an vapic
+ * update and validate its contents were not changes. Then, lift the write
+ * restriction and validate the page's contents are updated.
+ */
+static void test_side_channel_vapic_addr(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vm *vm = vcpu->vm;
+	gva_t vaddr = vm_alloc_page(vm);
+	gpa_t paddr = addr_gva2gpa(vm, vaddr);
+
+	vm_set_vapic_addr(vcpu, paddr);
+	test_data->op = TEST_OP_READ;
+	test_data->vaddr = vaddr;
+	test_data->confirm_read = 1;
+	test_data->expected_val = ~0ULL >> 32;
+	memset(addr_gva2hva(vm, vaddr), 0xff, sizeof(uint32_t));
+	vm_set_memory_attributes(vm, paddr, vm->page_size, KVM_MEMORY_ATTRIBUTE_NW);
+	vcpu_run_and_inc_stage(vcpu);
+
+	vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
+	vcpu_force_vapic_update(vcpu);
+	test_data->expected_val = 0ULL;
+	vcpu_run_and_inc_stage(vcpu);
+
+	vm_set_vapic_addr(vcpu, 0);
+	test_data->confirm_read = 0;
+}
+
+static void *vcpu_worker(void *data)
+{
+	struct test_data *test_data = data;
+	struct kvm_vcpu *vcpu = test_data->vcpu;
+
+	vcpu_run_and_inc_stage(vcpu);
+
+	return NULL;
+}
+
+/*
+ * Set up the pvclock page and validate that KVM periodically updates the
+ * 'tsc_timestamp' field. Subsequently, make the pvclock page non-writable and
+ * verify that the 'tsc_timestamp' field is no longer updated.
+ */
+static void test_side_channel_pvclock(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vm *vm = vcpu->vm;
+	gva_t vaddr = vm_alloc_page(vm);
+	gpa_t paddr = addr_gva2gpa(vm, vaddr);
+	vcpu_set_msr(vcpu, MSR_KVM_SYSTEM_TIME_NEW, paddr | 0x1);
+
+	test_data->op = TEST_OP_MONITOR_ADDRESS;
+	test_data->vaddr = vaddr + offsetof(struct pvclock_vcpu_time_info, tsc_timestamp);
+
+	pthread_create(&vcpu_thread, NULL, vcpu_worker, test_data);
+	usleep(msecs_to_usecs(1000));
+	TEST_ASSERT_EQ(pthread_tryjoin_np(vcpu_thread, NULL), 0);
+
+	vm_set_memory_attributes(vm, paddr, vm->page_size, KVM_MEMORY_ATTRIBUTE_NW);
+	pthread_create(&vcpu_thread, NULL, vcpu_worker, test_data);
+	usleep(msecs_to_usecs(1000));
+	TEST_ASSERT_EQ(pthread_tryjoin_np(vcpu_thread, NULL), EBUSY);
+
+	/* Force the 'monitor_address' guest operation to finish */
+	test_data->op = TEST_OP_NOP;
+	TEST_ASSERT_EQ(pthread_join(vcpu_thread, NULL), 0);
+	vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
+	vcpu_set_msr(vcpu, MSR_KVM_SYSTEM_TIME_NEW, 0);
+}
+
+/*
+ * Write to MSR_KVM_WALL_CLOCK_NEW and verify that the struct's 'version' field
+ * is updated. Subsequently, make the target guest physical address
+ * non-writable, and verify the 'version' field isn't updated anymore.
+ */
+static void test_side_channel_wallclock(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vm *vm = vcpu->vm;
+	gva_t vaddr = vm_alloc_page(vm);
+	gpa_t paddr = addr_gva2gpa(vm, vaddr);
+	struct pvclock_wall_clock *wc = addr_gva2hva(vm, vaddr);
+
+	wc->version = 0x0;
+	vcpu_set_msr(vcpu, MSR_KVM_WALL_CLOCK_NEW, paddr);
+	TEST_ASSERT_EQ(wc->version, 2);
+
+	vm_set_memory_attributes(vm, paddr, vm->page_size, KVM_MEMORY_ATTRIBUTE_NW);
+	vcpu_set_msr(vcpu, MSR_KVM_WALL_CLOCK_NEW, paddr);
+	TEST_ASSERT_EQ(wc->version, 2);
+
+	vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
+}
+
+/*
+ * Memory attributes are vulnerable to side-channel attacks. This means that
+ * any KVM operation initiated by the guest that requires guest memory access
+ * (which is the case for most pv-interfaces) needs to consider memory
+ * attributes.
+ *
+ * The following tests validate that this requirement is upheld for a variety
+ * of use-cases. These test cases were selected to exercise specific approaches
+ * to accessing guest memory, including:
+ *
+ *  - kvm_read/write_guest()
+ *  - gfn_to_hva_cache
+ *  - gfn_to_pfn_cache
+ *  - Guest page walker
+ */
+static void arch_test_side_channels(struct kvm_vcpu *vcpu, gva_t test_vm_addr,
+			            size_t size)
+{
+	test_side_channel_hyperv_hypercall_inputs(vcpu, test_vm_addr, size);
+	test_side_channel_emul_page_walks(vcpu, test_vm_addr, size);
+	test_side_channel_vapic_addr(vcpu);
+	test_side_channel_wallclock(vcpu);
+	test_side_channel_pvclock(vcpu);
+}
-- 
2.52.0

