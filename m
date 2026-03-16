Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99173EF0CB;
	Mon, 16 Mar 2026 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692863; cv=none; b=pyKs/R1dVppTPZGa9g2OiDhEo53S9WuU6UHQEUNbvXi31tZcBaFBZe0F8QFiYc+eoM3r9KZrsfqXrhqm+HzWX2iaFfn0UZny5PpfFhuZ/laHny0Tt4mKOGFrKB8MxHVcrj8BzLWcSYFtsFggzUD/PQ4qV5qv7UIoeS4iHuUbldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692863; c=relaxed/simple;
	bh=Z67genllzMsvnrjDnIBJ0sRjYbzzmleUqV1m1Ta0yVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAVvX2rfLUowIavLZs+TERq2KpuWyfMol86OKblK+J3bK0DvGDwba6c0v0hugn3zpkSp/t9AmRpmB7n+7xYb3ZYJ8GVBCaMlIEx0vdc5b+tAFrUyNLKioiK2WYgJs0Z1pjCmhSCXIZvidXbWfuxEFM5TjHBe5yD+jAY5c06mrlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aV1XDkG5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aV1XDkG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50132C19424;
	Mon, 16 Mar 2026 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692863;
	bh=Z67genllzMsvnrjDnIBJ0sRjYbzzmleUqV1m1Ta0yVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aV1XDkG539KTonHXvxad+8xI8hwor1AdCL1RXP8+ItuMh/aPvt8vg6zWpYU3A4p8f
	 jhpizvJogNCjzGTaFp0QxzCNTGGamtqdtRtCbC3hJ3I4JZjz6GOlWC30kfNXS0TI+4
	 HwLSNDjQMVraaoiaqnqA1au+68ML+C3Ds5lWyVY9SInad1rBP+JrZkXayxroKznX6Q
	 LIyZpkEuGG8vomdPobmAnrsYNNYg7tzdsOKYOraIQljAgQkxD6OEzrhEugi/sagnMC
	 C2JqDSTdl2FR5YVyI31qyVUo8z2T8BQSM3cXnBu013kt6hqJ93qvdRVw235dF5j/L6
	 GWfGn1dfo/sBw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 2/9] KVM: SVM: Refactor SVM instruction handling on #GP intercept
Date: Mon, 16 Mar 2026 20:27:25 +0000
Message-ID: <20260316202732.3164936-3-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260316202732.3164936-1-yosry@kernel.org>
References: <20260316202732.3164936-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of returning an opcode from svm_instr_opcode() and then passing
it to emulate_svm_instr(), which uses it to find the corresponding exit
code and intercept handler, return the exit code directly from
svm_instr_opcode(), and rename it to svm_instr_exit_code().

emulate_svm_instr() boils down to synthesizing a #VMEXIT or calling the
intercept handler, so open-code it in gp_interception(), and use
svm_invoke_exit_handler() to call the intercept handler based on
the exit code. This allows for dropping the SVM_INSTR_* enum, and the
const array mapping its values to exit codes and intercept handlers.

In gp_intercept(), handle SVM instructions first with an early return,
un-indenting the rest of the code.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 78 +++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 51 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d2ca226871c2f..392a5088f20bf 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2233,54 +2233,26 @@ static int vmrun_interception(struct kvm_vcpu *vcpu)
 	return nested_svm_vmrun(vcpu);
 }
 
-enum {
-	NONE_SVM_INSTR,
-	SVM_INSTR_VMRUN,
-	SVM_INSTR_VMLOAD,
-	SVM_INSTR_VMSAVE,
-};
-
-/* Return NONE_SVM_INSTR if not SVM instrs, otherwise return decode result */
-static int svm_instr_opcode(struct kvm_vcpu *vcpu)
+/* Return 0 if not SVM instr, otherwise return associated exit_code */
+static u64 svm_instr_exit_code(struct kvm_vcpu *vcpu)
 {
 	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
 
 	if (ctxt->b != 0x1 || ctxt->opcode_len != 2)
-		return NONE_SVM_INSTR;
+		return 0;
 
 	switch (ctxt->modrm) {
 	case 0xd8: /* VMRUN */
-		return SVM_INSTR_VMRUN;
+		return SVM_EXIT_VMRUN;
 	case 0xda: /* VMLOAD */
-		return SVM_INSTR_VMLOAD;
+		return SVM_EXIT_VMLOAD;
 	case 0xdb: /* VMSAVE */
-		return SVM_INSTR_VMSAVE;
+		return SVM_EXIT_VMSAVE;
 	default:
 		break;
 	}
 
-	return NONE_SVM_INSTR;
-}
-
-static int emulate_svm_instr(struct kvm_vcpu *vcpu, int opcode)
-{
-	const int guest_mode_exit_codes[] = {
-		[SVM_INSTR_VMRUN] = SVM_EXIT_VMRUN,
-		[SVM_INSTR_VMLOAD] = SVM_EXIT_VMLOAD,
-		[SVM_INSTR_VMSAVE] = SVM_EXIT_VMSAVE,
-	};
-	int (*const svm_instr_handlers[])(struct kvm_vcpu *vcpu) = {
-		[SVM_INSTR_VMRUN] = vmrun_interception,
-		[SVM_INSTR_VMLOAD] = vmload_interception,
-		[SVM_INSTR_VMSAVE] = vmsave_interception,
-	};
-	struct vcpu_svm *svm = to_svm(vcpu);
-
-	if (is_guest_mode(vcpu)) {
-		nested_svm_simple_vmexit(svm, guest_mode_exit_codes[opcode]);
-		return 1;
-	}
-	return svm_instr_handlers[opcode](vcpu);
+	return 0;
 }
 
 /*
@@ -2295,7 +2267,7 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 error_code = svm->vmcb->control.exit_info_1;
-	int opcode;
+	u64 svm_exit_code;
 
 	/* Both #GP cases have zero error_code */
 	if (error_code)
@@ -2305,27 +2277,31 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 	if (x86_decode_emulated_instruction(vcpu, 0, NULL, 0) != EMULATION_OK)
 		goto reinject;
 
-	opcode = svm_instr_opcode(vcpu);
-
-	if (opcode == NONE_SVM_INSTR) {
-		if (!enable_vmware_backdoor)
-			goto reinject;
-
-		/*
-		 * VMware backdoor emulation on #GP interception only handles
-		 * IN{S}, OUT{S}, and RDPMC.
-		 */
-		if (!is_guest_mode(vcpu))
-			return kvm_emulate_instruction(vcpu,
-				EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);
-	} else {
+	svm_exit_code = svm_instr_exit_code(vcpu);
+	if (svm_exit_code) {
 		/* All SVM instructions expect page aligned RAX */
 		if (svm->vmcb->save.rax & ~PAGE_MASK)
 			goto reinject;
 
-		return emulate_svm_instr(vcpu, opcode);
+		if (is_guest_mode(vcpu)) {
+			nested_svm_simple_vmexit(svm, svm_exit_code);
+			return 1;
+		}
+
+		return svm_invoke_exit_handler(vcpu, svm_exit_code);
 	}
 
+	if (!enable_vmware_backdoor)
+		goto reinject;
+
+	/*
+	 * VMware backdoor emulation on #GP interception only handles
+	 * IN{S}, OUT{S}, and RDPMC.
+	 */
+	if (!is_guest_mode(vcpu))
+		return kvm_emulate_instruction(vcpu,
+				EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);
+
 reinject:
 	kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
 	return 1;
-- 
2.53.0.851.ga537e3e6e9-goog

