Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D74D2EC5;
	Thu,  4 Jun 2026 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605364; cv=none; b=D/dQfP3eggnhtGUsMjZD0prIJftq/OmJCoqVBcg+2v5+C3qnlNxVP7ZcBBW/dVJnm+SUE9gpdrgyYOKpgudiOESl94vnsW1jTCVPbbfHGa5T7M0p1p2Ny00wzUNC3LI4hMGZNai/hQGrtWLmwcoUxZn/1NXuVp7yRE3CvKt/4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605364; c=relaxed/simple;
	bh=+e2vy5zU3nu1IPMrqBwOvvVwQTO1UvoxDGn9xFGsOMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFH8OMxAKi9DEhalXYj+JvsPGXvEuzvykLEY3WUJlK4mC2NvcKyFecMRlEq0IttTDDCRrzMwnF9nYKF31GKPiNbKjP/ot2/3U2Lgday3TENw1xBusY/nnXXU4OazUXCL2Ue+HjNt7MrQtFlh3sX20SqXJymTE0tjURxgwlP0MOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HencdQ5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HencdQ5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4998F1F00898;
	Thu,  4 Jun 2026 20:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605363;
	bh=bhRojyqIvVAuAQn/SyJnyO3rkyzuri5p/LOK2Hls3xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HencdQ5Kw0p9Ff2NnHBsWP8Acr6eL0tv5M/aH9wgEKfzYvJNVVBWhz6kWJ8yqJLTT
	 0qAZsNvHKYTdPvzVv0JGhTmaDRhHoTM7Qb2mKDqUgfQHljBgqDsaMtJZlOxStymUY0
	 sKHdp5e/6gLSXyhGJRTAGrVqxPo2eHYRCV/lYNm7OjqbQVADZ6+GAN2aNoc9LosY9D
	 XNErpvmjiRBXqOoGiY77ISstkB6UY2vco71MI/pvQybsGia9L2Ph8Cm2AG6XaYShUa
	 26f2FHgXaxvdZyvAtEMifrwKWTnOElci0x7rMkhZzvxjgQoUSQo3rax2SdXh1NLnHs
	 pbKzXvIH1a43Q==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 10/10] KVM: selftests: Trigger L2->L1 exits stress save+restore and #PF test
Date: Thu,  4 Jun 2026 20:35:46 +0000
Message-ID: <20260604203546.365658-11-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604203546.365658-1-yosry@kernel.org>
References: <20260604203546.365658-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the testing coverage in L2 by injecting a #UD into the vCPU every
other iteration during restore, and intercepting #UD from L1,
essentially forcing an L2 -> L1 VM-Exit directly after save+restore.

With this change, the test reliably reproduces the CR2 bug fixed by
commit 5c247d08bc81 ("KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12
on nested #VMEXIT") -- at least on Milan, Genoa, and Turin CPUs.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../kvm/x86/stress_save_restore_pf_test.c     | 47 +++++++++++++++++--
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
index c285ef093400d..6aae34cf8f13f 100644
--- a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
+++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
@@ -110,8 +110,12 @@ static void l1_svm_code(struct svm_test_data *svm)
 
 	generic_svm_setup(svm, guest_access_memory, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 
-	run_guest(svm->vmcb, svm->vmcb_gpa);
-	GUEST_ASSERT(false);
+	svm->vmcb->control.intercept_exceptions |= BIT(UD_VECTOR);
+
+	while (1) {
+		run_guest(svm->vmcb, svm->vmcb_gpa);
+		GUEST_ASSERT_EQ(svm->vmcb->control.exit_code, (SVM_EXIT_EXCP_BASE + UD_VECTOR));
+	}
 }
 
 static void l1_vmx_code(struct vmx_pages *vmx)
@@ -122,13 +126,17 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	GUEST_ASSERT(load_vmcs(vmx));
 	prepare_vmcs(vmx, guest_access_memory, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 
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
@@ -166,6 +174,24 @@ static void vcpu_sigusr_ignore(void)
 	sigaction(SIGUSR1, &sa, NULL);
 }
 
+static bool vcpu_state_is_guest_mode(struct kvm_x86_state *state)
+{
+	return !!(state->nested.flags & KVM_STATE_NESTED_GUEST_MODE);
+}
+
+static void vcpu_state_inject_ud(struct kvm_x86_state *state)
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
 static bool parse_args_nested(int argc, char *argv[])
 {
 	bool nested = false;
@@ -199,10 +225,13 @@ int main(int argc, char *argv[])
 	gva_t gva;
 	u64 pte;
 
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD));
+
 	nested = parse_args_nested(argc, argv);
 
 	vm = vm_create_with_one_vcpu(&vcpu, nested ? l1_guest_code : guest_access_memory);
 	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
+	vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
 
 	if (nested) {
 		TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
@@ -277,8 +306,16 @@ int main(int argc, char *argv[])
 
 		state = vcpu_save_state(vcpu);
 
+		/*
+		 * If the vCPU is in guest mode, inject a #UD to trigger an
+		 * L2->L1 VM-Exit every other iteration.
+		 */
+		if (nested && vcpu_state_is_guest_mode(state) && count % 2 == 0)
+			vcpu_state_inject_ud(state);
+
 		kvm_vm_release(vm);
 		vcpu = vm_recreate_with_one_vcpu(vm);
+		vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
 		vcpu_load_state(vcpu, state);
 		kvm_x86_state_cleanup(state);
 
-- 
2.54.0.1032.g2f8565e1d1-goog

