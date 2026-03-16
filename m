Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447D63EE1F5;
	Mon, 16 Mar 2026 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692863; cv=none; b=K0cejDm2SKg2jaaBvczOibyMCsEonDieJTYRtEWHxJinIonkrXEpCLVgBADqQ0ABOGuvBbE+vQqLobdvg6xAW4TiyhabOV0RTJvrhLymgiJvOt7zSWGJbeA+i+wWxylLRHrLllBIIRO2cMzr8ztpLmS5gRaX/XZ+f6vn3r+kQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692863; c=relaxed/simple;
	bh=EIrszS15i5/Uxlq5DyhfxznOK8FC3CIpI/Io3HTrbhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9hTbZMgcAVgoyldi8wZ2gkCXZFJ7N1yxetq3+ypxfFmFCYLwlSlCXzjSzJeuMSXwSLBOIIuje07TN8jWhbFw1cd4NCh43QYadJQpbOTOiddPiVkgA04DMZgkd1KiwYZ2wSiwH8NoGyIH4LGIKsUe9ofPQh2O8jHhBgpjicKn+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G58GA1f8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G58GA1f8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36E8C2BCAF;
	Mon, 16 Mar 2026 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692863;
	bh=EIrszS15i5/Uxlq5DyhfxznOK8FC3CIpI/Io3HTrbhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G58GA1f8CpFciPwkZNh22CITpx+9cKf0oOj+spvsHb484i/AvtsTSsGX01p/3iQKe
	 A+0rHCssWJQEwYt9xFOHaIafpZR4kP7ZYZc2ClkbqzW9+nPqNDUrHBU/kOfhNaOBrX
	 8ryXphf4cduA1Ow+wqh1xA7M2Y8zFnXUiZWY/pCw1zMShZ0bMhqR4NPwCpt+Uu5JG7
	 AipPvJNlks5F3ISX+lBv3glhej0kDkWRJIoolUJAKevbNrdyJQXHT13CIiBV69WbEG
	 WoSxsEEmzi+VtKveMoo2/FkF9ka8HbdTYTurFkaFgIA9h9+mKnOHaJiDdWRw0wOSIs
	 3jxG2NuEDwgFA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 1/9] KVM: SVM: Properly check RAX in the emulator for SVM instructions
Date: Mon, 16 Mar 2026 20:27:24 +0000
Message-ID: <20260316202732.3164936-2-yosry@kernel.org>
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

Architecturally, VMRUN/VMLOAD/VMSAVE should generate a #GP if the
physical address in RAX is not supported. check_svme_pa() hardcodes this
to checking that bits 63-48 are not set. This is incorrect on HW
supporting 52 bits of physical address space. Additionally, the emulator
does not check if the address is not aligned, which should also result
in #GP.

Use page_address_valid() which properly checks alignment and the address
legality based on the guest's MAXPHYADDR. Plumb it through
x86_emulate_ops, similar to is_canonical_addr(), to avoid directly
accessing the vCPU object in emulator code.

Fixes: 01de8b09e606 ("KVM: SVM: Add intercept checks for SVM instructions")
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/emulate.c     | 3 +--
 arch/x86/kvm/kvm_emulate.h | 2 ++
 arch/x86/kvm/x86.c         | 6 ++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 6145dac4a605a..c8c6cc0406d6d 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3887,8 +3887,7 @@ static int check_svme_pa(struct x86_emulate_ctxt *ctxt)
 {
 	u64 rax = reg_read(ctxt, VCPU_REGS_RAX);
 
-	/* Valid physical address? */
-	if (rax & 0xffff000000000000ULL)
+	if (!ctxt->ops->page_address_valid(ctxt, rax))
 		return emulate_gp(ctxt, 0);
 
 	return check_svme(ctxt);
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index fb3dab4b5a53e..0abff36d09942 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -245,6 +245,8 @@ struct x86_emulate_ops {
 
 	bool (*is_canonical_addr)(struct x86_emulate_ctxt *ctxt, gva_t addr,
 				  unsigned int flags);
+
+	bool (*page_address_valid)(struct x86_emulate_ctxt *ctxt, gpa_t gpa);
 };
 
 /* Type, address-of, and value of an instruction's operand. */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0b5d48e75b657..11d5bd84e323d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8916,6 +8916,11 @@ static bool emulator_is_canonical_addr(struct x86_emulate_ctxt *ctxt,
 	return !is_noncanonical_address(addr, emul_to_vcpu(ctxt), flags);
 }
 
+static bool emulator_page_address_valid(struct x86_emulate_ctxt *ctxt, gpa_t gpa)
+{
+	return page_address_valid(emul_to_vcpu(ctxt), gpa);
+}
+
 static const struct x86_emulate_ops emulate_ops = {
 	.vm_bugged           = emulator_vm_bugged,
 	.read_gpr            = emulator_read_gpr,
@@ -8963,6 +8968,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.set_xcr             = emulator_set_xcr,
 	.get_untagged_addr   = emulator_get_untagged_addr,
 	.is_canonical_addr   = emulator_is_canonical_addr,
+	.page_address_valid  = emulator_page_address_valid,
 };
 
 static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
-- 
2.53.0.851.ga537e3e6e9-goog

