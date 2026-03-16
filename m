Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1253EF648;
	Mon, 16 Mar 2026 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692864; cv=none; b=Oe7wEtKhju+HiwJaufXKkOntOgWYmk6YvwfYCwrdVmbITh3q7FWQ55KrG3AdNsgN2Z4+NFA+VA2e53XvSxS3ni8CNUkJGlFqBx7un3wQ4BHvmx6it9KkfvWEwOTKZIPq4U7rNBT1T2pqvGnNex/8bWW5ymyY/YHEk5bqB4ibtfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692864; c=relaxed/simple;
	bh=b8ai/VpIj8+raXLhl6mlAYJBLfYVeH84SMbuAIHHp2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4FhchfP+231Snl/eIUCj/c+93d50FB4IIZe/pqOtvMkFAOK5OYnLZRfC1smitgaVUslgJww+NK0hOM0GpwPbPmfEef1kB7SPOSVRYEZRqjfVRXeJ/SpOl7Bv7SjXrOTMn1WxHi7BmqyYg9AXLNr/q7p0J1x450uq67Ohl/yRMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su3dQyas; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Su3dQyas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0893C19421;
	Mon, 16 Mar 2026 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692864;
	bh=b8ai/VpIj8+raXLhl6mlAYJBLfYVeH84SMbuAIHHp2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Su3dQyasCCWwJuO+snMk1d4W1nDKQcTsaEGvitCUmndvYbUGlB1GrI7tSTrrwT50Z
	 fuO8n95KL7puio+Cc3fYAuzaREL4yz46qKnOtXhjUHoZF/jou+NYS2wdlr2pVZ7jsF
	 C/U4zeJrB+SUyGIEsdZTAU0yjgowmckzP4b+fwzL2blf67AmPvZpiRyBOG8nDowUhu
	 gHJhijHnDxh2dnNUZoWNd0TFUjuDWsxqZlwk9DZnDxcPXjw9hBW8LDKDEgIM7VJLA0
	 k1wMpRBnKf2E9/puCl4l0dzRrhJlDiDIfjtGn6LHyeivD6S5+DLfHsSNSAfnvcFK+A
	 PYzaGE0FgnnQA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 3/9] KVM: SVM: Properly check RAX on #GP intercept of SVM instructions
Date: Mon, 16 Mar 2026 20:27:26 +0000
Message-ID: <20260316202732.3164936-4-yosry@kernel.org>
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

When KVM intercepts #GP on an SVM instruction, it re-injects the #GP if
the instruction was executed with a mis-algined RAX. However, a #GP
should also be reinjected if RAX contains an illegal GPA, according to
the APM, one of #GP conditions is:

  rAX referenced a physical address above the maximum
  supported physical address.

Replace the PAGE_MASK check with page_address_valid(), which checks both
page-alignment as well as the legality of the GPA based on the vCPU's
MAXPHYADDR. Use kvm_register_read() to read RAX to avoid
page_address_valid() failing on 32-bit due to garbage in the higher
bits.

Note that this is currently only a problem if KVM is running an L2 guest
and ends up synthesizing a #VMEXIT to L1, as the RAX check takes
precedence over the intercept. Otherwise, if KVM emulates the
instruction, kvm_vcpu_map() should fail on illegal GPAs and inject a #GP
anyway. However, following patches will change the failure behavior of
kvm_vcpu_map(), so make sure the #GP interception handler does this
appropriately.

Opportunistically drop a teaser FIXME about the SVM instructions
handling on #GP belonging in the emulator.

Fixes: 82a11e9c6fa2 ("KVM: SVM: Add emulation support for #GP triggered by SVM instructions")
Fixes: d1cba6c92237 ("KVM: x86: nSVM: test eax for 4K alignment for GP errata workaround")
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 392a5088f20bf..3122a98745ab7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2277,10 +2277,12 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 	if (x86_decode_emulated_instruction(vcpu, 0, NULL, 0) != EMULATION_OK)
 		goto reinject;
 
+	/* FIXME: Handle SVM instructions through the emulator */
 	svm_exit_code = svm_instr_exit_code(vcpu);
 	if (svm_exit_code) {
-		/* All SVM instructions expect page aligned RAX */
-		if (svm->vmcb->save.rax & ~PAGE_MASK)
+		unsigned long rax = kvm_register_read(vcpu, VCPU_REGS_RAX);
+
+		if (!page_address_valid(vcpu, rax))
 			goto reinject;
 
 		if (is_guest_mode(vcpu)) {
-- 
2.53.0.851.ga537e3e6e9-goog

