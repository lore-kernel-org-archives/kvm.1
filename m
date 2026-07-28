Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50FD4570F6;
	Tue, 28 Jul 2026 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260566; cv=none; b=cxDOBYWM9V07aqMkYqaBzsEnN+UseC6ounGV7R5U9APE13jwI6B8RCcdaXsrspT5ZgbE1aIW5IXZAJiZ3kSZknogTqRjMfZ2WEbU9sMM3pANyxj64tU0mTfuOWIghNkWqdCSTJIGHXyjsECnIOZvS0zpsM38re89bEmEYoHSHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260566; c=relaxed/simple;
	bh=TCVtc+y8mZgVIksOsSKZCfwY4Ea4Udh6tknuNhD2DjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeFebYrvOD23KonqQQubdp6ijfdB++d64xduzOlty0M4cZMabMlJwr3/QgYaTFfY+QQdenJlOT88PQnz1lhVTLrR7bUB2wyCcQdfArXwMsWJo/y82OBWjq2dxZemSVdFO/rcLXr9g6LFcLJQhXAV2cG+UKm0iW6UmWkrFIRRVds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb6dQ4xO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb6dQ4xO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6411F00AC4;
	Tue, 28 Jul 2026 17:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260563;
	bh=DS8pM1J1sXjxcKO8FVSnbacBETSN1ko6dMNBzc9JTd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qb6dQ4xOVpxxQGaf3lr6sq0yAHSDsfp/FP5bAb04epmIKInEgyh3FA+2kP4wpwv3O
	 vpbsyn4yRf/HP4LZ4otcDga0GhbAs8zY0sz4vdTYjTEeHyUZ3ZwWPsqLN/7avUL7LM
	 7PxJTlj1ugLUXzZfctThbgtAxrZUgk18I0HsaHrPA7ptEUVp1wH0NzHtCl2JOxu0E9
	 Qiaa9ryCGESMGIBVz2Ok5WyENPKGB5+TSVSBH+A5jWrZfHyfhEVyV2taydtodPblNU
	 KBPQNogS4Ey59s37AmAnOlBOnXT/4vZTqj6mZl8nUfV8hL7recjgxqiceRqh6OhaaB
	 lcQiTUzdDIHOA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 13/13] KVM: selftests: Trigger L2->L1 exits stress save+restore and #PF test
Date: Tue, 28 Jul 2026 17:42:32 +0000
Message-ID: <20260728174232.2423257-14-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
In-Reply-To: <20260728174232.2423257-1-yosry@kernel.org>
References: <20260728174232.2423257-1-yosry@kernel.org>
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
 .../kvm/x86/save_restore_pf_stress_test.c     | 44 +++++++++++++++++--
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 5979d70f49147..6e6f70035508a 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -958,6 +958,11 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vcpu *vcpu);
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
index 7418e5fb879bd..507391ab2c930 100644
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
@@ -97,8 +102,14 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	GUEST_ASSERT(load_vmcs(vmx));
 	prepare_vmcs(vmx, guest_access_memory);
 
+	GUEST_ASSERT(!vmwrite(EXCEPTION_BITMAP, BIT(UD_VECTOR)));
+
 	GUEST_ASSERT(!vmlaunch());
-	GUEST_ASSERT(false);
+	while (1) {
+		GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
+		GUEST_ASSERT_EQ(vmreadz(VM_EXIT_INTR_INFO) & 0xff, UD_VECTOR);
+		GUEST_ASSERT(!vmresume());
+	}
 }
 
 static void l1_guest_code(void *test_data)
@@ -136,6 +147,19 @@ static void vcpu_sigusr_ignore(void)
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
@@ -153,6 +177,7 @@ static void run_test(bool nested)
 	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
 
 	if (nested) {
+		vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
 		if (kvm_cpu_has(X86_FEATURE_SVM))
 			vcpu_alloc_svm(vm, &gva);
 		else
@@ -218,8 +243,17 @@ static void run_test(bool nested)
 
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
+		if (nested)
+			vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
 		vcpu_load_state(vcpu, state);
 		kvm_x86_state_cleanup(state);
 
@@ -241,7 +275,9 @@ int main(int argc, char *argv[])
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
2.55.0.487.gaf234c4eb3-goog

