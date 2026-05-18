Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D198392837;
	Mon, 18 May 2026 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135927; cv=none; b=bSPizq8G4oOBb5r2h73+5MlFg1tWjjGfRBys0MYMhUOSlyjdlOwxrbXvc9i3/NDGpgeJIIn7pb8b7NC2309SfS8Fg1ODeOzBJa3Z+992G6RZ4VcyHVoZZz6sC9wrvs+Np0+VGD7qFITOggSaarqhyy7Se3Wm4pbzgvPpHMlNQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135927; c=relaxed/simple;
	bh=dTzJGsHSZ8xqNjuDFrBzWN7hB/SUmhWgE/soZ0ivTrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebdXCREpHT1yZVc0Zx0zghFooWNtag90JLg+L+l/z3ke0LLFcClBFV9iJa0RtRXjWBkeDaNrFwkN/7in1O7ZSXOd0L3vQHFbi2/NS2VnbRPG+rcXE0AIdlkJ/KnzE8rgwgzNvwhM4NY1gJqgiiVyiGt2KWB3nIE8C0UB4wag5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgS0Xnag; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgS0Xnag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7284C2BCC6;
	Mon, 18 May 2026 20:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779135927;
	bh=dTzJGsHSZ8xqNjuDFrBzWN7hB/SUmhWgE/soZ0ivTrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WgS0Xnagi5hvlqRSd1uaKL28Dup8ukB6XofSFo1/iq3XVPFahNA3301Bl8KrPVVTB
	 uwxWZMinPC3B1l42OooiSOckKNEidbHew9Esa5uyCo2KxaHH0R4gJW/ft4KifnnslI
	 JBGhKOrsFfe5DheeSdMBN5B2b2jBt2vTv0jddYaYW5HSBQ9Lem5fGtwnyhpqVnqNpz
	 VZ/1OUHn5GqKTZZS+RoEgYrxDIZbO1Sd5qbjliRhXRP8G+txx6uT1asReHmZD/+Ku6
	 vVEulaGvDNJlWv1AfNBF/4esy7AgA3SansaD2t8XWtVPSlhk2rjXIQ8D20i74U4Kni
	 euYZf61oCUxrA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 8/8] KVM: selftests: Trigger L2->L1 exits stress save+restore and #PF test
Date: Mon, 18 May 2026 20:25:14 +0000
Message-ID: <20260518202514.2037078-9-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260518202514.2037078-1-yosry@kernel.org>
References: <20260518202514.2037078-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosryahmed@google.com>

Extend the testing coverage in L2 by injecting a #UD into the vCPU every
other iteration during restore, and intercepting #UD from L1,
essentially forcing an L2 -> L1 VM-Exit directly after save+restore.

With this change, the test reliably reproduces the CR2 bug fixed by
commit 5c247d08bc81 ("KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12
on nested #VMEXIT") -- at least on Milan, Genoa, and Turin CPUs.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../kvm/x86/stress_save_restore_pf_test.c     | 48 +++++++++++++++++--
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
index ec3d36d6e4846..e977d9786e392 100644
--- a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
+++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
@@ -115,8 +115,12 @@ static void l1_svm_code(struct svm_test_data *svm)
 
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
@@ -127,13 +131,17 @@ static void l1_vmx_code(struct vmx_pages *vmx)
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
@@ -171,6 +179,23 @@ static void vcpu_sigusr_ignore(void)
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
+}
+
 static bool parse_args_nested(int argc, char *argv[])
 {
 	bool nested = false;
@@ -202,10 +227,13 @@ int main(int argc, char *argv[])
 	gva_t gva;
 	gpa_t gpa;
 
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD));
+
 	nested = parse_args_nested(argc, argv);
 
 	vm = vm_create_with_one_vcpu(&vcpu, nested ? l1_guest_code : guest_access_memory);
 	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
+	vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
 
 	if (nested) {
 		TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
@@ -264,8 +292,18 @@ int main(int argc, char *argv[])
 
 		state = vcpu_save_state(vcpu);
 
+		/*
+		 * If the vCPU is in guest mode, inject a #UD to trigger an
+		 * L2->L1 VM-Exit every other iteration.
+		 */
+		if (vcpu_state_is_guest_mode(state) && count % 2 == 0) {
+			TEST_ASSERT(nested, "Unexpected guest mode");
+			vcpu_state_inject_ud(state);
+		}
+
 		kvm_vm_release(vm);
 		vcpu = vm_recreate_with_one_vcpu(vm);
+		vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
 		vcpu_load_state(vcpu, state);
 		kvm_x86_state_cleanup(state);
 
-- 
2.54.0.563.g4f69b47b94-goog

