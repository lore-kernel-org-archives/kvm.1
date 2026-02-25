Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214A2550D7;
	Wed, 25 Feb 2026 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771981201; cv=none; b=iJuJSUjTLVzOT9UVmGB7Cdo+OyUSLLo/MQOH88AbJJ591b5dins1/nrP04pxHfE/d2wYrk1+eyOkuwW4VsawhJSbt8jr44cewKsyqBR5R6TVzkYKm4N/Y+wb/dvO1WdOU3dZ1Mwj0grc8a4Q9E57D0xYtb3i121kzpXmOTTw6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771981201; c=relaxed/simple;
	bh=ie0AVX8TGkke+XKy2jolgP57NcWThLPLDLOV6InUL0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGVQeBjBQKXZOiREKxoDECOxEUZah9FlT8dwdGomTIsbMHza8F1I1qhAdnCuIEnVqMLU3CZf1xNjeb6alCL8hLuoziNmHQYJtniesR2GhqF8d+p8pcc0QB6UD3A/d8GLYoNkz3i2Z8opX4vtldPU9sooAB4P1xmsU8vwHn98mAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTnugetr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTnugetr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002F8C2BC87;
	Wed, 25 Feb 2026 01:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771981201;
	bh=ie0AVX8TGkke+XKy2jolgP57NcWThLPLDLOV6InUL0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTnugetriAb/QH4dEyuAR8OPIVvJo6d/MTkLXarDoxna7Evrrkk12wtIqofZ3jugF
	 XZeyKKbdwVgVONsB6QWNfaZqrmroMcUmLlGiMVK25wcEYCJ+p4cm02p79mD/NgLtTU
	 IDB1DS6PBPDRUR1d9Flgz9WasHSrhRfxEXxBpXF3nVL0jytYdbbd7H6YOEYEKHx/WA
	 0tDnDf0JrKoglidQcy7AQaYyZNYHHPhWeE4X6dhXkOp2hCNMcIfrwi/6UM1zc4iAj1
	 gOCEytmKgg6jTP+dQqluGJGKqZ0EdBzmYbnvjvgkUOjpgS0lRxW8hIfpFhj+8mvorn
	 3jd5/KdbgYJeg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 3/8] KVM: selftests: Extend state_test to check vGIF
Date: Wed, 25 Feb 2026 00:59:45 +0000
Message-ID: <20260225005950.3739782-4-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260225005950.3739782-1-yosry@kernel.org>
References: <20260225005950.3739782-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V_GIF_MASK is one of the fields written by the CPU after VMRUN, and
sync'd by KVM from vmcb02 to cached vmcb12 after running L2. Part of the
reason is to make sure V_GIF_MASK is saved/restored correctly, as the
cached vmcb12 is the payload of nested state.

Verify that V_GIF_MASK is saved/restored correctly in state_test by
enabling vGIF in vmcb12, toggling GIF in L2 at different GUEST_SYNC()
points, and verifying that V_GIF_MASK is correctly propagated to the
nested state.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/x86/state_test.c | 24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index f2c7a1c297e37..57c7546f3d7c5 100644
--- a/tools/testing/selftests/kvm/x86/state_test.c
+++ b/tools/testing/selftests/kvm/x86/state_test.c
@@ -26,7 +26,9 @@ void svm_l2_guest_code(void)
 	GUEST_SYNC(4);
 	/* Exit to L1 */
 	vmcall();
+	clgi();
 	GUEST_SYNC(6);
+	stgi();
 	/* Done, exit to L1 and never come back.  */
 	vmcall();
 }
@@ -41,6 +43,8 @@ static void svm_l1_guest_code(struct svm_test_data *svm)
 	generic_svm_setup(svm, svm_l2_guest_code,
 			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 
+	vmcb->control.int_ctl |= (V_GIF_ENABLE_MASK | V_GIF_MASK);
+
 	GUEST_SYNC(3);
 	run_guest(vmcb, svm->vmcb_gpa);
 	GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_VMMCALL);
@@ -222,6 +226,24 @@ static void __attribute__((__flatten__)) guest_code(void *arg)
 	GUEST_DONE();
 }
 
+void svm_check_nested_state(int stage, struct kvm_x86_state *state)
+{
+	struct vmcb *vmcb = (struct vmcb *)state->nested.data.svm;
+
+	if (kvm_cpu_has(X86_FEATURE_VGIF)) {
+		if (stage == 4)
+			TEST_ASSERT_EQ(!!(vmcb->control.int_ctl & V_GIF_MASK), 1);
+		if (stage == 6)
+			TEST_ASSERT_EQ(!!(vmcb->control.int_ctl & V_GIF_MASK), 0);
+	}
+}
+
+void check_nested_state(int stage, struct kvm_x86_state *state)
+{
+	if (kvm_has_cap(KVM_CAP_NESTED_STATE) && kvm_cpu_has(X86_FEATURE_SVM))
+		svm_check_nested_state(stage, state);
+}
+
 int main(int argc, char *argv[])
 {
 	uint64_t *xstate_bv, saved_xstate_bv;
@@ -278,6 +300,8 @@ int main(int argc, char *argv[])
 
 		kvm_vm_release(vm);
 
+		check_nested_state(stage, state);
+
 		/* Restore state in a new VM.  */
 		vcpu = vm_recreate_with_one_vcpu(vm);
 		vcpu_load_state(vcpu, state);
-- 
2.53.0.414.gf7e9f6c205-goog

