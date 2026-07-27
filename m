Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBEA42FCAE;
	Mon, 27 Jul 2026 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196371; cv=none; b=skJ/6aSUD4DLUha4iQ2RNhWIOkKKezms2rjYRLiKkCoKfwXJBvl1g5X0m1zD1grX3AGvmx8eVimSzaStBF5/iUmVos2Vsu62uKSTFHtWG/jVfpgbC26+ocQI/JwKDgoZco9GtcRJ1fTlaKbM03wipIibk8Gcy4H4F+9pja8cH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196371; c=relaxed/simple;
	bh=BxTT8/sGX4lu6DyAWbbjqjC3S5GTLtMiayH7OexKD90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxhuBSlOrhixWxveVciW/knowJ7y2MoVQv6h3/BFk4kaZ3GCpxmWfj6Ab04adSBafP3x0UVMUJYPRY4PPZQ0zAbLswjpvpm3wXUBoVtsrbT0IJWYEFD00TcEr+OTNIZyWRLs8ZBWZbfKBU08ebg8zU0UtjtGdgikuxclJWqDigo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQhkS0r0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQhkS0r0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6901F00A3E;
	Mon, 27 Jul 2026 23:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196369;
	bh=4yCpN/3f1op1owLiDi4TMtF50LYT9U5nq3PuNCPxCc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cQhkS0r0oT3v8vlYzej9cuIA7YAZx/nl8kWI2VqtnA4IrSG5URpXcaUwxjmjGHOeS
	 xE6EcwqLlJ2Vh8UwVmV1HFMJTty2cEz4BAAIWeBZSjSwFctm6tuEBlE0ksU6nL4BoI
	 hhflAOPiB1T3TmiAwD0zTEbpYLw6nUURcMH2zYW8KCjNMV2ij1vsF/Lna4ZrrShNGi
	 uRbn8Ad5xFlAUQgKJkfI5RmSaEkUHG8RSjhJ/yBGUszoxQMtd5AdpR13ZGKZ0hQaUw
	 kmIE8NA95QbeP+RKlY/NJjJvW3/dlu77+Y6j3KcIdxEDEl8kCh1gcwdVnIC/Iw/raD
	 vFKdkfQLfe1Bg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 12/12] KVM: selftests: Trigger L2->L1 exits stress save+restore and #PF test
Date: Mon, 27 Jul 2026 23:52:28 +0000
Message-ID: <20260727235228.1007324-13-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260727235228.1007324-1-yosry@kernel.org>
References: <20260727235228.1007324-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the testing coverage in L2 by forcing a nested VM-Exit from L2 to
L1 right after restore on every other iteration. Forcing a nested
VM-Exit while L0 has control (e.g. without explicitly running L2 and
making a hypercall) is valuable, as it often happens during live
migration (e.g. L1 timer interrupt fires by the time the VM lands on the
destination).

To force the nested VM-Exit inject a #UD in to the saved vCPU state, and
intercept #UD from L1.

With this change, the test reliably reproduces the CR2 bug fixed by
commit 5c247d08bc81 ("KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12
on nested #VMEXIT") -- at least on Milan, Genoa, and Turin CPUs.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../selftests/kvm/include/x86/processor.h     |  5 +++
 .../kvm/x86/save_restore_pf_stress_test.c     | 45 ++++++++++++++++---
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 2889782b0016b..461c8aef7d37b 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -959,6 +959,11 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vcpu *vcpu);
 void vcpu_load_state(struct kvm_vcpu *vcpu, struct kvm_x86_state *state);
 void kvm_x86_state_cleanup(struct kvm_x86_state *state);
 
+static inline bool kvm_x86_state_is_guest_mode(struct kvm_x86_state *state)
+{
+	return state->nested.size && (state->nested.flags & KVM_STATE_NESTED_GUEST_MODE);
+}
+
 const struct kvm_msr_list *kvm_get_msr_index_list(void);
 const struct kvm_msr_list *kvm_get_feature_msr_index_list(void);
 bool kvm_msr_is_in_save_restore_list(u32 msr_index);
diff --git a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
index 0e5ddeb5af444..ba1d723001e94 100644
--- a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
+++ b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
@@ -87,8 +87,13 @@ static void guest_access_memory(void *arg)
 static void l1_svm_code(struct svm_test_data *svm)
 {
 	generic_svm_setup(svm, guest_access_memory);
-	run_guest(svm->vmcb, svm->vmcb_gpa);
-	GUEST_ASSERT(false);
+	svm->vmcb->control.intercept_exceptions |= BIT(UD_VECTOR);
+
+	while (1) {
+		run_guest(svm->vmcb, svm->vmcb_gpa);
+		GUEST_ASSERT_EQ(svm->vmcb->control.exit_code,
+				(SVM_EXIT_EXCP_BASE + UD_VECTOR));
+	}
 }
 
 static void l1_vmx_code(struct vmx_pages *vmx)
@@ -97,13 +102,17 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	GUEST_ASSERT(load_vmcs(vmx));
 	prepare_vmcs(vmx, guest_access_memory);
 
-	/* Ignore any #PF */
-	GUEST_ASSERT(!vmwrite(EXCEPTION_BITMAP, BIT(PF_VECTOR)));
+	/* Intercept UD, ignore any #PF */
+	GUEST_ASSERT(!vmwrite(EXCEPTION_BITMAP, BIT(UD_VECTOR) | BIT(PF_VECTOR)));
 	GUEST_ASSERT(!vmwrite(PAGE_FAULT_ERROR_CODE_MASK, 0));
 	GUEST_ASSERT(!vmwrite(PAGE_FAULT_ERROR_CODE_MATCH, -1));
 
 	GUEST_ASSERT(!vmlaunch());
-	GUEST_ASSERT(false);
+	while (1) {
+		GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
+		GUEST_ASSERT_EQ(vmreadz(VM_EXIT_INTR_INFO) & 0xff, UD_VECTOR);
+		GUEST_ASSERT(!vmresume());
+	}
 }
 
 static void l1_guest_code(void *test_data)
@@ -141,6 +150,19 @@ static void vcpu_sigusr_ignore(void)
 	sigaction(SIGUSR1, &sa, NULL);
 }
 
+static void kvm_x86_state_queue_ud(struct kvm_x86_state *state)
+{
+	if (state->events.exception.pending || state->events.exception.injected)
+		return;
+
+	state->events.flags |= KVM_VCPUEVENT_VALID_PAYLOAD;
+	state->events.exception.pending = true;
+	state->events.exception.injected = false;
+	state->events.exception.nr = UD_VECTOR;
+	state->events.exception.has_error_code = false;
+	state->events.exception_has_payload = false;
+}
+
 static void run_test(bool nested)
 {
 	struct kvm_x86_state *state;
@@ -156,6 +178,7 @@ static void run_test(bool nested)
 
 	vm = vm_create_with_one_vcpu(&vcpu, nested ? l1_guest_code : guest_access_memory);
 	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
+	vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
 
 	if (nested) {
 		if (kvm_cpu_has(X86_FEATURE_SVM))
@@ -224,8 +247,16 @@ static void run_test(bool nested)
 
 		state = vcpu_save_state(vcpu);
 
+		/*
+		 * If the vCPU is in guest mode, inject a #UD to trigger an
+		 * L2->L1 VM-Exit every other iteration.
+		 */
+		if (kvm_x86_state_is_guest_mode(state) && i % 2 == 0)
+			kvm_x86_state_queue_ud(state);
+
 		kvm_vm_release(vm);
 		vcpu = vm_recreate_with_one_vcpu(vm);
+		vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
 		vcpu_load_state(vcpu, state);
 		kvm_x86_state_cleanup(state);
 
@@ -247,7 +278,9 @@ int main(int argc, char *argv[])
 	pr_info("Running save+restore stress test...\n");
 	run_test(/*nested=*/false);
 
-	if (!kvm_cpu_has(X86_FEATURE_SVM) && !kvm_cpu_has(X86_FEATURE_VMX)) {
+	if (!kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD) ||
+	    !kvm_has_cap(KVM_CAP_NESTED_STATE) ||
+	    (!kvm_cpu_has(X86_FEATURE_SVM) && !kvm_cpu_has(X86_FEATURE_VMX))) {
 		pr_info("Nested virtualization not supported, skipping nested test\n");
 		return 0;
 	}
-- 
2.55.0.229.g6434b31f56-goog

