Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641542;
	b=BgPkBnNq8uo+qym5UseLtisKfRgsSofypSTi7tN4Nqw724fnevDmL0RcBw2pc0o9x3ZV
	 l9+FqwOzKw06xC1TZFjtiYhqZcLs+I974YUA5c/1XhkrfJ0QYu1dSOSq1WDt18liF2K/V
	 0ezRfrAsKR0S5d34cClj140vQQ99cxmdAs0HN7446C+oLzLGvtfWe1On7JfD0RTyDhCZs
	 vErI5Rsb65sEVT/kWrJ49H6a/IF1ljvFLQnhAbunFAOts2k/NMIYx9WNxE/ChheY3nILI
	 QhXMlh3Wh0k4Fs5sLjVnyRXmakmO/SSpH3tlxs77I0+HvcqSyDWji1JQlltdh3jaoQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641542;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=EObE7eW9KH/uCQxAP/YMOsGWZXgYZftJdfOH1/znc9s=;
	b=M/0BAvPBvYEW6kVwgPnm09hg3PI2AZyccY0vJBrCWvmFZShGyjwPM/+8iEzdo4V2GWz9
	 50G7U2Tl3aY55RGpYKK36HFQpiGDS3NJvpWzGteuyHay/boZORsF/NsS9OwNbwQX19xCS
	 8hW9Rjpq3WE8hcZLaOHsfkmXklWMtVQFWX0Mi1jCLn7wxwxSiYSc/+6fE0jlLoQhjAs6Q
	 6UE1FKTo5JwHxQ1F7Cha/2RvBgJNfZqBv8uw17QbJW0Z0pX6wK712sduYnJYFvCD941NR
	 hqTtc73Q+NgTRQ9U46AwCP7YhK8X9xaAg/YdXuoA0ayTlnsEG11DvAD4qZbEpGqAv6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ehS69q6V;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F5B607F414
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69F5B607F414
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ehS69q6V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EObE7eW9KH/uCQxAP/YMOsGWZXgYZftJdfOH1/znc9s=;
	b=ehS69q6V2JpeD59KGMfioIOdivg87Nvsb/denTbTc9dUS6lQYsrIXKxkzfAPOPckU8yF0e
	2Dj1Fjlr3ajwRg7VsxaiyVq52j08pnDb7mFq79hSYyrXOkVAMzT93aAyn6O/CK2A9jWX5W
	XwdPGCh+JH15wrSl+Q+L2RweV9lxsO0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-03HxfCLmOlWJXB9f7OOAjg-1; Mon,
 02 Nov 2026 12:45:35 -0500
X-MC-Unique: 03HxfCLmOlWJXB9f7OOAjg-1
X-Mimecast-MFC-AGG-ID: 03HxfCLmOlWJXB9f7OOAjg_1793641531
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4AA319560A2;
	Mon,  2 Nov 2026 17:45:31 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 527F1180057F;
	Mon,  2 Nov 2026 17:45:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 44/45] KVM: x86: selftests: Introduce memory attributes side-channel tests
Date: Mon,  2 Nov 2026 12:45:11 -0500
Message-ID: <20261102174512.8903-28-pbonzini@redhat.com>
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

Introduce memory attributes selftests to catch any vulnerable
side-channels.

Memory attributes access restrictions are vulnerable to side-channel
attacks. This means that any KVM operation initiated by the guest that
requires guest memory access (which is the case for most
para-virtualised interfaces) needs to consider memory attributes.

The tests confirm this requirement is upheld for a variety of
use-cases, exercising various kinds of guest memory access such as
kvm_read/write_guest(), gfn_to_hva_cache and gfn_to_pfn_cache.

Co-developed-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-32-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |   9 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../testing/selftests/kvm/lib/x86/processor.c |   5 +
 .../testing/selftests/kvm/memory_attributes.c |  51 +++-
 .../selftests/kvm/x86/memory_attributes.c     | 232 ++++++++++++++++++
 5 files changed, 297 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 51b173105d3c..e887d3022855 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1058,6 +1058,15 @@ static inline int vcpu_get_stats_fd(struct kvm_vcpu *vcpu)
 	return fd;
 }
 
+static inline struct kvm_translation vcpu_translate(struct kvm_vcpu *vcpu,
+						    u64 gva)
+{
+	struct kvm_translation tr = { .linear_address = gva };
+
+	vcpu_ioctl(vcpu, KVM_TRANSLATE, &tr);
+	return tr;
+}
+
 int __kvm_has_device_attr(int dev_fd, u32 group, u64 attr);
 
 static inline void kvm_has_device_attr(int dev_fd, u32 group, u64 attr)
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 5898a277a2e0..e9a997aa7290 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1493,6 +1493,7 @@ static inline bool kvm_is_nested_virtualization_enabled(void)
 	return get_kvm_amd_param_integer("nested");
 }
 
+u64 *vm_get_pte_level(struct kvm_vm *vm, gva_t gva, int *level);
 u64 *vm_get_pte(struct kvm_vm *vm, gva_t gva);
 
 u64 kvm_hypercall(u64 nr, u64 a0, u64 a1, u64 a2, u64 a3);
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 8374afd08baf..d4d0b7b472c8 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -402,6 +402,11 @@ u64 *tdp_get_pte(struct kvm_vm *vm, u64 l2_gpa)
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
index c5305b4f3dbe..2883f6c772be 100644
--- a/tools/testing/selftests/kvm/memory_attributes.c
+++ b/tools/testing/selftests/kvm/memory_attributes.c
@@ -22,6 +22,8 @@
 #define TEST_MEM_SLOT	1
 #define TEST_MEM_GPA	0x80000000
 
+#define HV_STATUS_INVALID_HYPERCALL_INPUT	3
+
 #define MMIO_GPA	0x700000000
 #define MMIO_GVA	MMIO_GPA
 
@@ -29,12 +31,35 @@
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
 
@@ -44,6 +69,8 @@ const char *test_op_names[] =
 	[TEST_OP_WRITE] = "Write",
 	[TEST_OP_EXEC] = "Exec",
 	[TEST_OP_INVPLG] = "Invplg",
+	[TEST_OP_HYPERV_HYPERCALL_INPUT] = "HvHcall input",
+	[TEST_OP_MONITOR_ADDRESS] = "Monitor address",
 	[TEST_OP_EXIT] = "Exit",
 };
 
@@ -51,6 +78,8 @@ struct test_data {
 	uint8_t op;
 	int stage;
 	gva_t vaddr;
+	gpa_t paddr;
+	uint8_t confirm_read;
 	uint64_t expected_val;
 
 	struct kvm_vcpu *vcpu;
@@ -63,19 +92,26 @@ static void arch_controlled_write(gva_t addr, uint64_t val);
 static void arch_controlled_exec(gva_t addr);
 static void arch_write_return_insn(struct kvm_vm *vm, gpa_t paddr);
 static bool arch_test_op(struct test_data *test_data);
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
@@ -86,6 +122,14 @@ static void guest_code(void *data)
 			arch_controlled_exec(vaddr);
 			GUEST_SYNC(stage++);
 			break;
+		case TEST_OP_MONITOR_ADDRESS: {
+			if (arch_controlled_read(vaddr) != expected_val)
+				GUEST_SYNC(stage++);
+			break;
+		}
+		case TEST_OP_NOP:
+			GUEST_SYNC(stage++);
+			break;
 		default:
 			if (!arch_test_op(test_data))
 				goto exit;
@@ -145,6 +189,7 @@ static void test_page_restricted(struct kvm_vcpu *vcpu, int op,
 
 	test_data->op = op;
 	test_data->vaddr = vaddr;
+	test_data->paddr = fault_paddr;
 
 	rc = _vcpu_run(vcpu);
 	TEST_ASSERT(rc == -1 && errno == EFAULT,
@@ -362,11 +407,15 @@ int main(int argc, char *argv[])
 	test_mem = vm_alloc_pages(vm, pages);
 	virt_map(vcpu->vm, MMIO_GVA, MMIO_GPA, 1);
 	test_data = init_test_data(vcpu);
+#ifdef __x86_64__
+	vcpu_set_hv_cpuid(vcpu);
+#endif
 
 	test_input_validation(vm);
 	test_memory_access(vcpu, test_mem, size);
 #ifdef __x86_64__
 	arch_test_memory_access_pte(vcpu, test_mem);
+	arch_test_side_channels(vcpu, test_mem, size);
 #endif
 	test_finalize(vcpu);
 
diff --git a/tools/testing/selftests/kvm/x86/memory_attributes.c b/tools/testing/selftests/kvm/x86/memory_attributes.c
index 12395feb6ac7..36e788be0e05 100644
--- a/tools/testing/selftests/kvm/x86/memory_attributes.c
+++ b/tools/testing/selftests/kvm/x86/memory_attributes.c
@@ -45,17 +45,28 @@ void arch_write_return_insn(struct kvm_vm *vm, gpa_t paddr)
 bool arch_test_op(struct test_data *test_data)
 {
 	gva_t vaddr = READ_ONCE(test_data->vaddr);
+	gpa_t paddr = READ_ONCE(test_data->paddr);
 
 	switch(READ_ONCE(test_data->op)) {
 	case TEST_OP_INVPLG:
 		asm volatile("invlpg (%0)"
 			     :: "b" (vaddr): "memory");
 		return true;
+	case TEST_OP_HYPERV_HYPERCALL_INPUT:
+		hyperv_hypercall(HVCALL_SEND_IPI_EX, paddr, 0);
+		asm volatile ("sti; hlt; cli;");
+		GUEST_ASSERT_EQ(ipis_rcvd, 1);
+		return true;
 	default:
 		return false;
 	}
 }
 
+void arch_guest_init(void)
+{
+	x2apic_enable();
+}
+
 /*
  * This test validates that, during a page walk, if the page a PTE is placed in
  * is read-only the accesss and dirty bits will not be written. Note There's a
@@ -181,3 +192,224 @@ static void arch_test_memory_access_pte(struct kvm_vcpu *vcpu, gva_t vaddr)
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
+	gpa_t paddr = addr_gva2gpa(vm, vaddr);
+
+	if (!kvm_has_cap(KVM_CAP_HYPERV_SEND_IPI) ||
+	    !kvm_has_cap(KVM_CAP_HCALL_FAULT_EXIT))
+		return;
+
+	vm_enable_cap(vcpu->vm, KVM_CAP_HCALL_FAULT_EXIT, 1);
+
+	ipis_rcvd = 0;
+	vm_install_exception_handler(vm, IPI_VECTOR, guest_ipi_handler_hv);
+	vcpu_set_msr(vcpu, HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
+
+	*ipi_ex = (struct hv_send_ipi_ex){
+		.vector = IPI_VECTOR,
+		.vp_set.format = HV_GENERIC_SET_ALL,
+	};
+
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
+ * 'version' field. Subsequently, make the pvclock page non-writable and
+ * verify that the 'version' field is no longer updated.
+ */
+static void test_side_channel_pvclock(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vm *vm = vcpu->vm;
+	gva_t vaddr = vm_alloc_page(vm);
+	gpa_t paddr = addr_gva2gpa(vm, vaddr);
+	struct pvclock_vcpu_time_info *pvclock = addr_gpa2hva(vm, paddr);
+
+	pvclock->version = 0;
+
+	test_data->op = TEST_OP_MONITOR_ADDRESS;
+	test_data->vaddr = vaddr + offsetof(struct pvclock_vcpu_time_info, version);
+	test_data->expected_val = pvclock->version;
+
+	vcpu_set_msr(vcpu, MSR_KVM_SYSTEM_TIME_NEW, paddr | 0x1);
+	pthread_create(&vcpu_thread, NULL, vcpu_worker, test_data);
+	usleep(msecs_to_usecs(1000));
+	TEST_ASSERT_EQ(pthread_tryjoin_np(vcpu_thread, NULL), 0);
+	vcpu_set_msr(vcpu, MSR_KVM_SYSTEM_TIME_NEW, 0);
+
+	test_data->expected_val = pvclock->version;
+	vm_set_memory_attributes(vm, paddr, vm->page_size, KVM_MEMORY_ATTRIBUTE_NW);
+	vcpu_set_msr(vcpu, MSR_KVM_SYSTEM_TIME_NEW, paddr | 0x1);
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
+	TEST_ASSERT_EQ(READ_ONCE(wc->version), 2);
+
+	vm_set_memory_attributes(vm, paddr, vm->page_size, KVM_MEMORY_ATTRIBUTE_NW);
+	vcpu_set_msr(vcpu, MSR_KVM_WALL_CLOCK_NEW, paddr);
+	TEST_ASSERT_EQ(READ_ONCE(wc->version), 2);
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


