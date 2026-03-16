Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B3F3EF0A9;
	Mon, 16 Mar 2026 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692865; cv=none; b=qvy7tKN+WzuSLCbq0GBTcYPpR1a+jVAjuqufd3IHSMFcIbAtdNlT2x03HAN8gew7LcvjsQI6tQDRKTpeJ+no03Je55ZBdiHmjTZ+qqj8wa0AWGsT3PgQuGORQi6hVdz5f85mj69q/padCGWYrB+m0sNXtLs4Zp2eeNfbFPlHCDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692865; c=relaxed/simple;
	bh=6INPicvGAwF0HOdZHKimaIrincjL/kzHV/eR4X4flmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h44yapEGzFFgrjkW+8oBSfuFBtN06qxuCV21ZwfsT6cQNKY2qIGd6kahd4DqMqccjb4Y6WE+zn9AxVGjFTVujYU9lRz6jMj024BNtp5/yXOBVs43ZwDWqxWEghKiPLugmtyzF4ncj8+5+RhC/A4pjKMRrsCAskMTNLI00flgFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3SB0UVL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3SB0UVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5637DC19424;
	Mon, 16 Mar 2026 20:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692865;
	bh=6INPicvGAwF0HOdZHKimaIrincjL/kzHV/eR4X4flmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D3SB0UVLuxlCvnjoiSo2cp759SuEqc9NQ+BIkBL08bIEftt+Xl6LGX9brvgTj17QZ
	 7ZBgnyzYtlaLMwmtuMf9U6N1i/OnyjP4w+fL0huniVfVkWK/Ec2gmR0waDt9SWeYFB
	 x6bPPUsjCTkOAJIjF5r2GcNWrIHfU3Cg/qzrByYF6LIGaJSR+sSAf/F+HlC7qF4kNw
	 D0yKCJdPbUCZdIuYiVAnGFNS5efZfZUJsoX2DKrSC62xytdC6gRt0CL/DquwJuF7BO
	 ulstZh9MWteYwXfhIcEvR7bDUs7rZAeERhMSx3yxUfRYeX+aEYLdvNK7ooHer5DW+T
	 D7i63Urx740LQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 7/9] KVM: nSVM: Fail emulation of VMRUN/VMLOAD/VMSAVE if mapping vmcb12 fails
Date: Mon, 16 Mar 2026 20:27:30 +0000
Message-ID: <20260316202732.3164936-8-yosry@kernel.org>
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

KVM currently injects a #GP if mapping vmcb12 fails when emulating
VMRUN/VMLOAD/VMSAVE. This is not architectural behavior, as #GP should
only be injected if the physical address is not supported or not
aligned. Instead, handle it as an emulation failure, similar to how nVMX
handles failures to read/write guest memory in several emulation paths.

When virtual VMLOAD/VMSAVE is enabled, if vmcb12's GPA is not mapped in
the NPTs a VMEXIT(#NPF) will be generated, and KVM will install an MMIO
SPTE and emulate the instruction if there is no corresponding memslot.
x86_emulate_insn() will return EMULATION_FAILED as VMLOAD/VMSAVE are not
handled as part of the twobyte_insn cases.

Even though this will also result in an emulation failure, it will only
result in a straight return to userspace if
KVM_CAP_EXIT_ON_EMULATION_FAILURE is set. Otherwise, it would inject #UD
and only exit to userspace if not in guest mode. So the behavior is
slightly different if virtual VMLOAD/VMSAVE is enabled.

Fixes: 3d6368ef580a ("KVM: SVM: Add VMRUN handler")
Reported-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 6 ++----
 arch/x86/kvm/svm/svm.c    | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 75943a607777c..73c0df0a81f0e 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1121,10 +1121,8 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 
 	ret = nested_svm_copy_vmcb12_to_cache(vcpu, vmcb12_gpa);
 	if (ret) {
-		if (ret == -EFAULT) {
-			kvm_inject_gp(vcpu, 0);
-			return 1;
-		}
+		if (ret == -EFAULT)
+			return kvm_handle_memory_failure(vcpu, X86EMUL_IO_NEEDED, NULL);
 
 		/* Advance RIP past VMRUN as part of the nested #VMEXIT. */
 		return kvm_skip_emulated_instruction(vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9f6f60fc8c133..1843627fa4cac 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2201,10 +2201,8 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 		return 1;
 	}
 
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map)) {
-		kvm_inject_gp(vcpu, 0);
-		return 1;
-	}
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map))
+		return kvm_handle_memory_failure(vcpu, X86EMUL_IO_NEEDED, NULL);
 
 	vmcb12 = map.hva;
 
-- 
2.53.0.851.ga537e3e6e9-goog

