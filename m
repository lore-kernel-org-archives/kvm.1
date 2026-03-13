Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A91A9F82;
	Fri, 13 Mar 2026 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360645; cv=none; b=gjTm3etdWFZBwlpuw3JSsSpj/RwXNjGKLed4XJPBU2NnbT6tGI6MH3w4mzYZ3rMvxqVie9ZgPm6t1gc1ELlE+40uFZZfTZ+0ZPD8GNrrfFD0Cjcqa2WT3gfHtlWBQ6C3mX+J7CLeYGIc0ycNTxotOjPRi+YwronVbJ87icItZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360645; c=relaxed/simple;
	bh=tlh7ifo/n8LjV6/9uJFZgNWsW1oJxUUzEZm2c7dRu7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgpBO+0wMNV4Q0bkTfDTYxHNooMxwmpvRY4EMCrNU8gJlukWv7JiUlsYog4E0f2M1JPm1ZpbZFhq+SOJsPUS0jRxrganJjpmJVbjAz4zHPm/oV0Luro1dNDIwTvd3rIroj4eCMLAF04vO5hOQOcoOfhCyugeHsAz7PGrB87IqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSbb7SaG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSbb7SaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA7BC2BCAF;
	Fri, 13 Mar 2026 00:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773360645;
	bh=tlh7ifo/n8LjV6/9uJFZgNWsW1oJxUUzEZm2c7dRu7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSbb7SaG0qB/zHNm9oP/a7pk+nbWo1OZV3GrwquWAz5EcqGA6AQ68xKz6hqIe86xI
	 Jic3UmHg+ru/IoAnqQKiyp/9o77u/+VTUSbO7rq1fgPdLpH+MCiCvzrzstepMOJ8Xf
	 y8WzTMhphzJArODK4e7TrWm498yccIJfnbDROUMcml9YFjcBH5l/5YQuLi/SvjKLJC
	 Y77RsdFADgkY6rHo+8nWtF6y4XpCoWqAYg3+9vtEr0w3meqZVJxeDRvRyli+0xCCEM
	 ABGeQS+I9NQk0Hz4c0SQ6oxjhF+yQSBuAT39EJjL7a3ciKwfBXzXfKKyolYRTu5At2
	 w6B4LpYHm4bzQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 6/7] KVM: selftests: Rework svm_nested_invalid_vmcb12_gpa
Date: Fri, 13 Mar 2026 00:10:23 +0000
Message-ID: <20260313001024.136619-7-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260313001024.136619-1-yosry@kernel.org>
References: <20260313001024.136619-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test currently allegedly makes sure that VMRUN causes a #GP in
vmcb12 GPA is valid but unmappable. However, it calls run_guest() with
an the test vmcb12 GPA, and the #GP is produced from VMLOAD, not VMRUN.

Additionally, the underlying just changed to match architectural
behavior, and all of VMRUN/VMLOAD/VMSAVE fail emulation if vmcb12 cannot
be mapped. The CPU still injects a #GP if the vmcb12 GPA exceeds
maxphyaddr.

Rework the test such to use the KVM_ONE_VCPU_TEST[_SUITE] harness, and
test all of VMRUN/VMLOAD/VMSAVE with both an invalid GPA (-1ULL) causing
a #GP, and a valid but unmappable GPA causing emulation failure. Execute
the instructions directly from L1 instead of run_guest() to make sure
the #GP or emulation failure is produced by the right instruction.

Leave the #VMEXIT with unmappable GPA test case as-is, but wrap it with
a test harness as well.

Opportunisitically drop gp_triggered, as the test already checks that
a #GP was injected through a SYNC, and add an assertion that the max
legal GPA is in fact not mapped by userspace (i.e. KVM cannot map it).

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../kvm/x86/svm_nested_invalid_vmcb12_gpa.c   | 152 +++++++++++++-----
 1 file changed, 115 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/svm_nested_invalid_vmcb12_gpa.c b/tools/testing/selftests/kvm/x86/svm_nested_invalid_vmcb12_gpa.c
index c6d5f712120d1..569869bed20b5 100644
--- a/tools/testing/selftests/kvm/x86/svm_nested_invalid_vmcb12_gpa.c
+++ b/tools/testing/selftests/kvm/x86/svm_nested_invalid_vmcb12_gpa.c
@@ -6,6 +6,8 @@
 #include "vmx.h"
 #include "svm_util.h"
 #include "kselftest.h"
+#include "kvm_test_harness.h"
+#include "test_util.h"
 
 
 #define L2_GUEST_STACK_SIZE 64
@@ -13,86 +15,162 @@
 #define SYNC_GP 101
 #define SYNC_L2_STARTED 102
 
-u64 valid_vmcb12_gpa;
-int gp_triggered;
+static unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 
 static void guest_gp_handler(struct ex_regs *regs)
 {
-	GUEST_ASSERT(!gp_triggered);
 	GUEST_SYNC(SYNC_GP);
-	gp_triggered = 1;
-	regs->rax = valid_vmcb12_gpa;
 }
 
-static void l2_guest_code(void)
+static void l2_code(void)
 {
 	GUEST_SYNC(SYNC_L2_STARTED);
 	vmcall();
 }
 
-static void l1_guest_code(struct svm_test_data *svm, u64 invalid_vmcb12_gpa)
+static void l1_vmrun(struct svm_test_data *svm, u64 gpa)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	generic_svm_setup(svm, l2_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 
-	generic_svm_setup(svm, l2_guest_code,
-			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	asm volatile ("vmrun %[gpa]" : : [gpa] "a" (gpa) : "memory");
+}
 
-	valid_vmcb12_gpa = svm->vmcb_gpa;
+static void l1_vmload(struct svm_test_data *svm, u64 gpa)
+{
+	generic_svm_setup(svm, l2_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 
-	run_guest(svm->vmcb, invalid_vmcb12_gpa); /* #GP */
+	asm volatile ("vmload %[gpa]" : : [gpa] "a" (gpa) : "memory");
+}
+
+static void l1_vmsave(struct svm_test_data *svm, u64 gpa)
+{
+	generic_svm_setup(svm, l2_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	asm volatile ("vmsave %[gpa]" : : [gpa] "a" (gpa) : "memory");
+}
+
+static void l1_vmexit(struct svm_test_data *svm, u64 gpa)
+{
+	generic_svm_setup(svm, l2_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 
-	/* GP handler should jump here */
+	run_guest(svm->vmcb, svm->vmcb_gpa);
 	GUEST_ASSERT(svm->vmcb->control.exit_code == SVM_EXIT_VMMCALL);
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+static u64 unmappable_gpa(struct kvm_vcpu *vcpu)
+{
+	struct userspace_mem_region *region;
+	u64 region_gpa_end, vm_gpa_end = 0;
+	int i;
+
+	hash_for_each(vcpu->vm->regions.slot_hash, i, region, slot_node) {
+		region_gpa_end = region->region.guest_phys_addr + region->region.memory_size;
+		vm_gpa_end = max(vm_gpa_end, region_gpa_end);
+	}
+
+	return vm_gpa_end;
+}
+
+static void test_invalid_vmcb12(struct kvm_vcpu *vcpu)
 {
-	struct kvm_x86_state *state;
 	vm_vaddr_t nested_gva = 0;
-	struct kvm_vcpu *vcpu;
-	uint32_t maxphyaddr;
-	u64 max_legal_gpa;
-	struct kvm_vm *vm;
 	struct ucall uc;
 
-	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
 
-	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 	vm_install_exception_handler(vcpu->vm, GP_VECTOR, guest_gp_handler);
-
-	/*
-	 * Find the max legal GPA that is not backed by a memslot (i.e. cannot
-	 * be mapped by KVM).
-	 */
-	maxphyaddr = kvm_cpuid_property(vcpu->cpuid, X86_PROPERTY_MAX_PHY_ADDR);
-	max_legal_gpa = BIT_ULL(maxphyaddr) - PAGE_SIZE;
-	vcpu_alloc_svm(vm, &nested_gva);
-	vcpu_args_set(vcpu, 2, nested_gva, max_legal_gpa);
-
-	/* VMRUN with max_legal_gpa, KVM injects a #GP */
+	vcpu_alloc_svm(vcpu->vm, &nested_gva);
+	vcpu_args_set(vcpu, 2, nested_gva, -1ULL);
 	vcpu_run(vcpu);
+
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
 	TEST_ASSERT_EQ(uc.args[1], SYNC_GP);
+}
+
+static void test_unmappable_vmcb12(struct kvm_vcpu *vcpu)
+{
+	vm_vaddr_t nested_gva = 0;
+
+	vcpu_alloc_svm(vcpu->vm, &nested_gva);
+	vcpu_args_set(vcpu, 2, nested_gva, unmappable_gpa(vcpu));
+	vcpu_run(vcpu);
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_INTERNAL_ERROR);
+	TEST_ASSERT_EQ(vcpu->run->emulation_failure.suberror, KVM_INTERNAL_ERROR_EMULATION);
+}
+
+static void test_unmappable_vmcb12_vmexit(struct kvm_vcpu *vcpu)
+{
+	struct kvm_x86_state *state;
+	vm_vaddr_t nested_gva = 0;
+	struct ucall uc;
 
 	/*
-	 * Enter L2 (with a legit vmcb12 GPA), then overwrite vmcb12 GPA with
-	 * max_legal_gpa. KVM will fail to map vmcb12 on nested VM-Exit and
+	 * Enter L2 (with a legit vmcb12 GPA), then overwrite vmcb12 GPA with an
+	 * unmappable GPA. KVM will fail to map vmcb12 on nested VM-Exit and
 	 * cause a shutdown.
 	 */
+	vcpu_alloc_svm(vcpu->vm, &nested_gva);
+	vcpu_args_set(vcpu, 2, nested_gva, unmappable_gpa(vcpu));
 	vcpu_run(vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
 	TEST_ASSERT_EQ(uc.args[1], SYNC_L2_STARTED);
 
 	state = vcpu_save_state(vcpu);
-	state->nested.hdr.svm.vmcb_pa = max_legal_gpa;
+	state->nested.hdr.svm.vmcb_pa = unmappable_gpa(vcpu);
 	vcpu_load_state(vcpu, state);
 	vcpu_run(vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_SHUTDOWN);
 
 	kvm_x86_state_cleanup(state);
-	kvm_vm_free(vm);
-	return 0;
+}
+
+KVM_ONE_VCPU_TEST_SUITE(vmcb12_gpa);
+
+KVM_ONE_VCPU_TEST(vmcb12_gpa, vmrun_invalid, l1_vmrun)
+{
+	test_invalid_vmcb12(vcpu);
+}
+
+KVM_ONE_VCPU_TEST(vmcb12_gpa, vmload_invalid, l1_vmload)
+{
+	test_invalid_vmcb12(vcpu);
+}
+
+KVM_ONE_VCPU_TEST(vmcb12_gpa, vmsave_invalid, l1_vmsave)
+{
+	test_invalid_vmcb12(vcpu);
+}
+
+KVM_ONE_VCPU_TEST(vmcb12_gpa, vmrun_unmappable, l1_vmrun)
+{
+	test_unmappable_vmcb12(vcpu);
+}
+
+KVM_ONE_VCPU_TEST(vmcb12_gpa, vmload_unmappable, l1_vmload)
+{
+	test_unmappable_vmcb12(vcpu);
+}
+
+KVM_ONE_VCPU_TEST(vmcb12_gpa, vmsave_unmappable, l1_vmsave)
+{
+	test_unmappable_vmcb12(vcpu);
+}
+
+/*
+ * Invalid vmcb12_gpa cannot be test for #VMEXIT as KVM_SET_NESTED_STATE will
+ * reject it.
+ */
+KVM_ONE_VCPU_TEST(vmcb12_gpa, vmexit_unmappable, l1_vmexit)
+{
+	test_unmappable_vmcb12_vmexit(vcpu);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+
+	return test_harness_run(argc, argv);
 }
-- 
2.53.0.851.ga537e3e6e9-goog

