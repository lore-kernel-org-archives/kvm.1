Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D83EFD07;
	Mon, 16 Mar 2026 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692865; cv=none; b=eclL7rXch7XeenAy+X5OYu/0YCiFaPmuWoTBMbQXy1k4n30aLt7Z8qKcpwzGnqewONNxLL2NSqb+GLlFK9nAfEzUS9qWgCJrlWRSk3FdXXkIeEwa7ovuOhI+cKnx+zZaS+OIQjZJ1X0JdfiJd6aJLBaR5fJyRxCIwWexi9sg4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692865; c=relaxed/simple;
	bh=piNKmNlBx0IrNa9iajYbjvJyN1lke4bo4utyfiGpkVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMDv6fzgs4x3E9iRwMCRMO1BGxbCFIeCOPhdRqQN/9zljg0QGAUoJHMrNGBYNOfF1nmXh2Ksze//a7t51ZczPhvBgqMm0dz1X5eZXHRQoysMDymj2vf18hEGBRDQDsFIpESBj2wYlARY1+i4PkwhiZqzFQVbc0CjOaznWlMeWpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKec3K+q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKec3K+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AC5C4AF0B;
	Mon, 16 Mar 2026 20:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692864;
	bh=piNKmNlBx0IrNa9iajYbjvJyN1lke4bo4utyfiGpkVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vKec3K+qRjCFoboOaIZCZR3O0670/ajrritEVOKuzNKhSoCuQeV1bCSBMJKiOT+d9
	 EL+261NEPtIW9J/BXTg1oVzZniKPCBmK+1Jb/NPtBVvSU8+JHmIAYEdqGglGG1KYF+
	 rViUwQe/0dOgB2mVihyaOfNXaro+O2eTHCC87PCKVg3mCIq6+J+FQhI0d473RO4Jhs
	 1UdP+A9pCg0EWceIRWhUnbuOtMPlDE0lHto0Ed4JuXc2srjeliu6GJ77KkYIv6Jzqi
	 nL/K66gndq3jk2D93ir3fckP8xlDk/yMyJa89YfrZshkJYqd/wybC+3MEZyi4SuaqY
	 CmvANXNX8JDxQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 5/9] KVM: SVM: Check EFER.SVME and CPL on #GP intercept of SVM instructions
Date: Mon, 16 Mar 2026 20:27:28 +0000
Message-ID: <20260316202732.3164936-6-yosry@kernel.org>
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

When KVM intercepts #GP on an SVM instruction from L2, it checks the
legality of RAX, and injects a #GP if RAX is illegal, or otherwise
synthesizes a #VMEXIT to L1. However, checking EFER.SVME and CPL takes
precedence over both the RAX check and the intercept. Call
nested_svm_check_permissions() first to cover both.

Note that if #GP is intercepted on SVM instruction in L1, the intercept
handlers of VMRUN/VMLOAD/VMSAVE already perform these checks.

Note #2, if KVM does not intercept #GP, the check for EFER.SVME is not
done in the correct order, because KVM handles it by intercepting the
instructions when EFER.SVME=0 and injecting #UD.  However, a #GP
injected by hardware would happen before the instruction intercept,
leading to #GP taking precedence over #UD from the guest's perspective.
Opportunistically add a FIXME for this.

Fixes: 82a11e9c6fa2 ("KVM: SVM: Add emulation support for #GP triggered by SVM instructions")
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a511ee1139725..bb0bb0f9c858f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1052,6 +1052,11 @@ static void svm_recalc_instruction_intercepts(struct kvm_vcpu *vcpu)
 	 * No need to toggle any of the vgif/vls/etc. enable bits here, as they
 	 * are set when the VMCB is initialized and never cleared (if the
 	 * relevant intercepts are set, the enablements are meaningless anyway).
+	 *
+	 * FIXME: When #GP is not intercepted, a #GP on these instructions (e.g.
+	 * due to CPL > 0) could be injected by hardware before the instruction
+	 * is intercepted, leading to #GP taking precedence over #UD from the
+	 * guest's perspective.
 	 */
 	if (!(vcpu->arch.efer & EFER_SVME)) {
 		svm_set_intercept(svm, INTERCEPT_VMLOAD);
@@ -2289,6 +2294,9 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 		unsigned long rax = kvm_register_read(vcpu, VCPU_REGS_RAX);
 
 		if (is_guest_mode(vcpu)) {
+			if (nested_svm_check_permissions(vcpu))
+				return 1;
+
 			if (!page_address_valid(vcpu, rax))
 				goto reinject;
 
-- 
2.53.0.851.ga537e3e6e9-goog

