Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3F3EF65F;
	Mon, 16 Mar 2026 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692864; cv=none; b=bWpOk9PV2eickHINl9gYJhNHU20Z3oeaztrtJmMnOkCcEYIYU6OeEKh+2zpIL9PkrbNQ2a38ZHPIrFHsD+DMkCCd3Micskcucnu3FCesypURGA3CXD9YX6G3mQVTTm71cKYxbltFYXfdaHLFFfKYtvFm2s3s3AH8x6MJTblrw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692864; c=relaxed/simple;
	bh=6S4+JazBAejIpFtSmER6X/tB4z7ULTZ/icgKSEpS+mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctPdEIVvffXh9RH5H7DWPxZP/zT1LJCSQ/GJL+B6Mf4fQjVGUoeN2iGUkQjCYjRNnKB7X+9W5D29Cw6B9A3jL5a2dg4R2c5o4GQfhGbH5jcfHbD1MZzPiEvw7hJ3DPtswuTs4e1M0Jfwtb6LpDguS27xT2RqV8Lqh5sLUMiCHLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCWQdiku; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCWQdiku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E364C2BCAF;
	Mon, 16 Mar 2026 20:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692864;
	bh=6S4+JazBAejIpFtSmER6X/tB4z7ULTZ/icgKSEpS+mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCWQdikuPNWGR1JciHt3pe/bfTOJ5Pl7TU9HmA6EDztouZW4KnUysqIYeIaREIm/J
	 umiamlBeYC0ijAnKbWlXJncu+GUDeaWuKsqplPFJTRz6rTzOsmScjijrQe6TDSkx8G
	 zZ3JR09ns9T4JbsmoOhp2575mhRXcdtulKKdW7C+q+TbTbrNbBArDUkloQqEqQH6oM
	 2HISTJjyMex/82kypqepdkWcjBH4b0OisfZI0ggWu89+Q8oYsfXb/6VikFD3gR5c3v
	 NwjnbHgnUgHBtWF3az55UE+/8zGxdfziv+jJK/JdWFa8bYn6o3/Y8LjgU53EpN24RM
	 TACepcsFd8mdA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 4/9] KVM: SVM: Move RAX legality check to SVM insn interception handlers
Date: Mon, 16 Mar 2026 20:27:27 +0000
Message-ID: <20260316202732.3164936-5-yosry@kernel.org>
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

When #GP is intercepted by KVM, the #GP interception handler checks
whether the GPA in RAX is legal and reinjects the #GP accordingly.
Otherwise, it calls into the appropriate interception handler for
VMRUN/VMLOAD/VMSAVE. The intercept handlers do not check RAX.

However, the intercept handlers need to do the RAX check, because if the
guest has a smaller MAXPHYADDR, RAX could be legal from the hardware
perspective (i.e. CPU does not inject #GP), but not from the vCPU's
perspective. Note that with allow_smaller_maxphyaddr, both NPT and VLS
cannot be used, so VMLOAD/VMSAVE have to be intercepted, and RAX can
always be checked against the vCPU's MAXPHYADDR.

Move the check into the interception handlers for VMRUN/VMLOAD/VMSAVE as
the CPU does not check RAX before the interception. Read RAX using
kvm_register_read() to avoid a false negative on page_address_valid() on
32-bit due to garbage in the higher bits.

Keep the check in the #GP intercept handler in the nested case where
a #VMEXIT is synthesized into L1, as the RAX check is still needed there
and takes precedence over the intercept.

Opportunistically add a FIXME about the #VMEXIT being synthesized into
L1, as it needs to be conditional.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c |  6 +++++-
 arch/x86/kvm/svm/svm.c    | 21 +++++++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5ff01d2ac85e4..75943a607777c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1113,7 +1113,11 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(!svm->nested.initialized))
 		return -EINVAL;
 
-	vmcb12_gpa = svm->vmcb->save.rax;
+	vmcb12_gpa = kvm_register_read(vcpu, VCPU_REGS_RAX);
+	if (!page_address_valid(vcpu, vmcb12_gpa)) {
+		kvm_inject_gp(vcpu, 0);
+		return 1;
+	}
 
 	ret = nested_svm_copy_vmcb12_to_cache(vcpu, vmcb12_gpa);
 	if (ret) {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3122a98745ab7..a511ee1139725 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2182,6 +2182,7 @@ static int intr_interception(struct kvm_vcpu *vcpu)
 
 static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 {
+	u64 vmcb12_gpa = kvm_register_read(vcpu, VCPU_REGS_RAX);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb12;
 	struct kvm_host_map map;
@@ -2190,7 +2191,12 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 	if (nested_svm_check_permissions(vcpu))
 		return 1;
 
-	ret = kvm_vcpu_map(vcpu, gpa_to_gfn(svm->vmcb->save.rax), &map);
+	if (!page_address_valid(vcpu, vmcb12_gpa)) {
+		kvm_inject_gp(vcpu, 0);
+		return 1;
+	}
+
+	ret = kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map);
 	if (ret) {
 		if (ret == -EINVAL)
 			kvm_inject_gp(vcpu, 0);
@@ -2282,10 +2288,17 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 	if (svm_exit_code) {
 		unsigned long rax = kvm_register_read(vcpu, VCPU_REGS_RAX);
 
-		if (!page_address_valid(vcpu, rax))
-			goto reinject;
-
 		if (is_guest_mode(vcpu)) {
+			if (!page_address_valid(vcpu, rax))
+				goto reinject;
+
+			/*
+			 * FIXME: Only synthesize a #VMEXIT if L1 sets the
+			 * intercept, but only after the VMLOAD/VMSAVE exit
+			 * handlers can properly handle VMLOAD/VMSAVE from L2
+			 * with VLS enabled in L1 (i.e. RAX is an L2 GPA that
+			 * needs translation through L1's NPT).
+			 */
 			nested_svm_simple_vmexit(svm, svm_exit_code);
 			return 1;
 		}
-- 
2.53.0.851.ga537e3e6e9-goog

