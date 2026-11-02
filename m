Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641302;
	b=z9xOwFcFuCf1ON+JqU5cXDrs4wNbSQDMH2E8+ihob5GuYlZqxkcxkvbt7uQDs7CrGwLM
	 QtZjOhY9OPNDySYhUt7WoaDS9rYgFrHjM25UEO2ZBqgGrKSizm1sSxUTThi9EdQdK3JoX
	 mFXSQy/QjySqQ3Jpr6LR9XNes8m51gq1tKzK+et63TaV29lLHEdm2iPEP5rUspV5gWOFV
	 U59s6txaDbhkLzWUq1IiC3ZE28rAb2D884CwdjiG2C1FtmCLb0QeMY4FJwXwPV52Tc1oc
	 URrBiBVa9KssF/BYHqWSdk5WD6FRQENnjg7TJUWa6VYCbFwgVrJqfo+eqYbqJxKXxaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641302;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=s+NlsL2Gb1GNQwiHFIrjaI9A06E3mE950NZsKTDhcfY=;
	b=nn7q9aacLLjEivO8tgTfDiGQHusk8XGaH0BfrHIcNri8jazXm0Gcqr2ns6Y3LSrlf772
	 ok1DqXTk1nqozcLvar7S91nz8bvWh/93OsHh9BBs5bBPMbBK2P4H7XfEg7ThS2QfbqUrg
	 e+f1C8cYQ0ORKYzUe8jcfw2yqv2ysAsdYpwILDXW1J4JcSUwvsoaQGvG5LuROsm2zViZv
	 bq2TQzF2zrFULNlaH6al45tWhnY/MDfWVPYMl87TStQauE1cAvKFjvBiwDVbqu/NJxWVE
	 4Nq5ZCx2JXwHW5XbXOsI2ljED4T8Gf+V/7GUFYTA+Pdtpz9Mek6adztbbXhYlR3lXVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HcjrrmJd;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950346072210
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 950346072210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HcjrrmJd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+NlsL2Gb1GNQwiHFIrjaI9A06E3mE950NZsKTDhcfY=;
	b=HcjrrmJd3QHXgWCVdmtmuMLgXWOctd5qRRAqiC7mt9vfNNMsZGSFyZ417gxGmBdnMEnpEN
	63UvepcgiXJADZ88q7gk9EpNbfrd4iEw/561MfcsoYYzIZSLuZ2MwOpkSaqm4RsHCEQVT3
	gJ/w0lJipjw56i8VXuDzJH8vEAidlkk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-VBSyKnvaN6aO9v4k7urHAQ-1; Mon,
 02 Nov 2026 12:41:39 -0500
X-MC-Unique: VBSyKnvaN6aO9v4k7urHAQ-1
X-Mimecast-MFC-AGG-ID: VBSyKnvaN6aO9v4k7urHAQ_1793641298
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2730A19560AB;
	Mon,  2 Nov 2026 17:41:38 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEB811800347;
	Mon,  2 Nov 2026 17:41:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 11/45] KVM: selftests: test hypercall memory fault exits
Date: Mon,  2 Nov 2026 12:40:55 -0500
Message-ID: <20261102174130.8779-12-pbonzini@redhat.com>
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

Cover various scenarios where hypercalls are invoked with invalid or
read-only GPAs, and check that they exit to userspace.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-8-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/x86/hcall_fault.c | 246 ++++++++++++++++++
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  |   4 +
 .../selftests/kvm/x86/hyperv_svm_test.c       |   2 +
 4 files changed, 253 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/hcall_fault.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 3cb35a6963d5..478b85ceb7fb 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -83,6 +83,7 @@ TEST_GEN_PROGS_x86 += x86/evmcs_smm_controls_test
 TEST_GEN_PROGS_x86 += x86/exit_on_emulation_failure_test
 TEST_GEN_PROGS_x86 += x86/fastops_test
 TEST_GEN_PROGS_x86 += x86/fix_hypercall_test
+TEST_GEN_PROGS_x86 += x86/hcall_fault
 TEST_GEN_PROGS_x86 += x86/hwcr_msr_test
 TEST_GEN_PROGS_x86 += x86/hyperv_clock
 TEST_GEN_PROGS_x86 += x86/hyperv_cpuid
diff --git a/tools/testing/selftests/kvm/x86/hcall_fault.c b/tools/testing/selftests/kvm/x86/hcall_fault.c
new file mode 100644
index 000000000000..725c59ff750c
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/hcall_fault.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <errno.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "hyperv.h"
+
+#define TEST_MEM_GPA		0x100000000ull
+#define READONLY_GPA		(TEST_MEM_GPA + PAGE_SIZE)
+#define UNMAPPED_IN_GPA		(TEST_MEM_GPA + 2 * PAGE_SIZE)
+#define UNMAPPED_OUT_GPA	(TEST_MEM_GPA + 3 * PAGE_SIZE)
+
+struct hcall_test {
+	/* TEST_MEM_GPA in the guest */
+	u64 control;
+	u64 ingpa;
+	u64 outgpa;
+	u64 expected_status;
+	u8 unused[PAGE_SIZE - 32];
+
+	/* READONLY_GPA in the guest */
+	u8 readonly_data[];
+};
+
+#define HV_FLUSH_ALL_PROCESSORS                 BIT(0)
+#define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES     BIT(1)
+
+/* HvFlushVirtualAddressSpace, HvFlushVirtualAddressList hypercalls */
+struct hv_tlb_flush {
+        u64 address_space;
+        u64 flags;
+        u64 processor_mask;
+        u64 gva_list[];
+} __packed;
+
+static void guest_code(gpa_t hcall_page, struct hcall_test *test)
+{
+	u64 result;
+	u8 vector;
+
+	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
+	wrmsr(HV_X64_MSR_HYPERCALL, hcall_page);
+
+	vector = __hyperv_hypercall(test->control, test->ingpa, test->outgpa, &result);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(result & 0xffff, test->expected_status);
+	GUEST_DONE();
+}
+
+static void clock_pairing_guest(gpa_t gpa)
+{
+	kvm_hypercall(KVM_HC_CLOCK_PAIRING, gpa, KVM_CLOCK_PAIRING_WALLCLOCK, 0, 0);
+	GUEST_DONE();
+}
+
+static gva_t create_test_regions(struct kvm_vm *vm)
+{
+	gva_t test_gva;
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, TEST_MEM_GPA,
+				    10, 1, 0);
+	memset(addr_gpa2hva(vm, TEST_MEM_GPA), 0, PAGE_SIZE);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, READONLY_GPA,
+				    11, 1, KVM_MEM_READONLY);
+	memset(addr_gpa2hva(vm, READONLY_GPA), 0, PAGE_SIZE);
+
+	test_gva = vm_unused_gva_gap(vm, PAGE_SIZE * 2, 1 << 24);
+	for (int i = 0; i < 2; i++)
+		virt_pg_map(vm, test_gva + PAGE_SIZE * i, TEST_MEM_GPA + PAGE_SIZE * i);
+
+	return test_gva;
+}
+
+static struct kvm_vm *create_vm(struct kvm_vcpu **vcpu, struct hcall_test **test,
+				gpa_t *hcall_page_gpa)
+{
+	gva_t hcall_page, test_gva;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(vcpu, guest_code);
+	vcpu_set_hv_cpuid(*vcpu);
+	vm_enable_cap(vm, KVM_CAP_HCALL_FAULT_EXIT, 1);
+
+	hcall_page = vm_alloc_page(vm);
+	memset(addr_gva2hva(vm, hcall_page), 0, PAGE_SIZE);
+	*hcall_page_gpa = addr_gva2gpa(vm, hcall_page);
+
+	test_gva = create_test_regions(vm);
+	*test = addr_gva2hva(vm, test_gva);
+
+	vcpu_args_set(*vcpu, 2, *hcall_page_gpa, test_gva);
+	return vm;
+}
+
+static void run_vm(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	case UCALL_DONE:
+		break;
+	default:
+		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
+	}
+}
+
+static void test_unused_gpas(void)
+{
+	struct hcall_test *test;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	gpa_t hcall_page;
+
+	vm = create_vm(&vcpu, &test, &hcall_page);
+	test->control = HVCALL_NOTIFY_LONG_SPIN_WAIT;
+	test->ingpa = UNMAPPED_IN_GPA;
+	test->outgpa = UNMAPPED_OUT_GPA;
+	test->expected_status = HV_STATUS_SUCCESS;
+	run_vm(vcpu);
+	kvm_vm_free(vm);
+
+	vm = create_vm(&vcpu, &test, &hcall_page);
+	test->control = 0xbeef;
+	test->ingpa = UNMAPPED_IN_GPA;
+	test->outgpa = UNMAPPED_OUT_GPA;
+	test->expected_status = HV_STATUS_INVALID_HYPERCALL_CODE;
+	run_vm(vcpu);
+	kvm_vm_free(vm);
+}
+
+static void assert_memory_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 flags)
+{
+	int r;
+
+	r = _vcpu_run(vcpu);
+	TEST_ASSERT(r == -1 && errno == EFAULT, KVM_IOCTL_ERROR(KVM_RUN, r));
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_MEMORY_FAULT);
+	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, flags);
+	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, gpa & PAGE_MASK);
+	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, PAGE_SIZE);
+}
+
+/* Read-only hypercalls, read-only inputs, valid/invalid argument */
+static void test_readonly_input(void)
+{
+	struct hv_tlb_flush *flush;
+	struct hcall_test *test;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	gpa_t hcall_page;
+
+	vm = create_vm(&vcpu, &test, &hcall_page);
+	flush = (struct hv_tlb_flush *)addr_gpa2hva(vm, READONLY_GPA);
+	flush->flags = HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES | HV_FLUSH_ALL_PROCESSORS;
+	flush->processor_mask = 0;
+	test->control = HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE;
+	test->ingpa = READONLY_GPA;
+	test->outgpa = UNMAPPED_OUT_GPA;
+	test->expected_status = HV_STATUS_SUCCESS;
+	run_vm(vcpu);
+	kvm_vm_free(vm);
+
+	/* fails immediately because it requires SynIC */
+	vm = create_vm(&vcpu, &test, &hcall_page);
+	test->control = HVCALL_POST_MESSAGE;
+	test->ingpa = UNMAPPED_IN_GPA;
+	test->outgpa = UNMAPPED_OUT_GPA;
+	test->expected_status = HV_STATUS_INVALID_HYPERCALL_INPUT;
+	run_vm(vcpu);
+	kvm_vm_free(vm);
+}
+
+/* Read-only hypercall, unmapped input */
+static void test_input_fault(void)
+{
+	struct hcall_test *test;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	gpa_t hcall_page;
+
+	vm = create_vm(&vcpu, &test, &hcall_page);
+	test->control = HVCALL_SIGNAL_EVENT;
+	test->ingpa = UNMAPPED_IN_GPA;
+	test->outgpa = UNMAPPED_OUT_GPA;
+	assert_memory_fault(vcpu, test->ingpa, KVM_MEMORY_EXIT_FLAG_READ);
+	kvm_vm_free(vm);
+}
+
+/* Read-write hypercall, unmapped or readonly input and output */
+static void test_output_fault(bool readonly_in, bool readonly_out)
+{
+	struct hcall_test *test;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	gpa_t hcall_page;
+
+	vm = create_vm(&vcpu, &test, &hcall_page);
+	test->control = HV_EXT_CALL_QUERY_CAPABILITIES;
+	test->ingpa = readonly_in ? READONLY_GPA : UNMAPPED_IN_GPA;
+	test->outgpa = readonly_out ? READONLY_GPA : UNMAPPED_OUT_GPA;
+
+	assert_memory_fault(vcpu, test->outgpa, KVM_MEMORY_EXIT_FLAG_WRITE);
+	kvm_vm_free(vm);
+}
+
+static void test_clock_pairing_fault(bool readonly)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	gpa_t gpa;
+
+	/* Unlike create_vm do not enable Hyper-V hypercalls. */
+	vm = vm_create_with_one_vcpu(&vcpu, clock_pairing_guest);
+	create_test_regions(vm);
+	vm_enable_cap(vm, KVM_CAP_HCALL_FAULT_EXIT, 1);
+	gpa = readonly ? READONLY_GPA : UNMAPPED_OUT_GPA;
+	vcpu_args_set(vcpu, 1, gpa);
+
+	assert_memory_fault(vcpu, gpa, KVM_MEMORY_EXIT_FLAG_WRITE);
+	kvm_vm_free(vm);
+}
+
+int main(void)
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_CPUID));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HCALL_FAULT_EXIT));
+	TEST_REQUIRE(kvm_cpuid_has(kvm_get_supported_hv_cpuid(),
+				   HV_ENABLE_EXTENDED_HYPERCALLS));
+
+	test_unused_gpas();
+	test_readonly_input();
+	test_input_fault();
+	test_output_fault(false, false);
+	test_output_fault(true, false);
+	test_output_fault(false, true);
+	test_clock_pairing_fault(false);
+	test_clock_pairing_fault(true);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index 2e1150c4bbbf..6b2fb3fbccd9 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -227,6 +227,8 @@ static struct kvm_vcpu *save_restore_vm(struct kvm_vm *vm,
 
 	/* Restore state in a new VM.  */
 	vcpu = vm_recreate_with_one_vcpu(vm);
+	if (kvm_has_cap(KVM_CAP_HCALL_FAULT_EXIT))
+		vm_enable_cap(vm, KVM_CAP_HCALL_FAULT_EXIT, 1);
 	vcpu_set_hv_cpuid(vcpu);
 	vcpu_enable_evmcs(vcpu);
 	vcpu_load_state(vcpu, state);
@@ -257,6 +259,8 @@ int main(int argc, char *argv[])
 	TEST_REQUIRE(kvm_cpu_has_ept());
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	if (kvm_has_cap(KVM_CAP_HCALL_FAULT_EXIT))
+		vm_enable_cap(vm, KVM_CAP_HCALL_FAULT_EXIT, 1);
 	vm_enable_ept(vm);
 
 	hcall_page = vm_alloc_pages(vm, 1);
diff --git a/tools/testing/selftests/kvm/x86/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
index 1c95b86ce2a5..ccd45a233b9b 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
@@ -162,6 +162,8 @@ int main(int argc, char *argv[])
 
 	/* Create VM */
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	if (kvm_has_cap(KVM_CAP_HCALL_FAULT_EXIT))
+		vm_enable_cap(vm, KVM_CAP_HCALL_FAULT_EXIT, 1);
 	vm_enable_npt(vm);
 	vcpu_set_hv_cpuid(vcpu);
 	vcpu_alloc_svm(vm, &nested_gva);
-- 
2.52.0


