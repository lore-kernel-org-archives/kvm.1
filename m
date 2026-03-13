Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E095B1EB;
	Fri, 13 Mar 2026 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360644; cv=none; b=YAX8gU2Ift/flqG8hLA5JqmZYW7MyVJOVjIPsmsFOXjb0SV5kVQGyCs40rkhv3j7XdvwR8MA7YRICH14WkvCVlwP0dR/z9G8EG2u8FarvBzJVnLlYFbVyLdzBs2Rz4j7xFBQsd1g4+T18+Ti/QuaTfoqlXkuolmJzusIIGzuCes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360644; c=relaxed/simple;
	bh=/zXmpfg4Hgv7+5B7YMww2chChhal4Xauwbnqj5TACsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dA9tqW4RE68p/z8lnjD1y4kMr63HbeKsrVmKcZFiYDdr1Lh6iBXyBrGfSYT4NP9GXvoTcm+yK0cvNeMaB2ACBh5P5USeOuzIEd4ktfVAhVm5JFfcMqKt+XJQJI3GUrWNnZcVW8YBmLBcVmCufur/BFJ0XmfYlMapKd3GMnxFH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKuxEngQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKuxEngQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF833C2BC9E;
	Fri, 13 Mar 2026 00:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773360644;
	bh=/zXmpfg4Hgv7+5B7YMww2chChhal4Xauwbnqj5TACsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKuxEngQiN8DAKpBzSgu0PBFDVYWpUSPnP7Okp0klQA5ZjuzsEVEQgkUx76pCp5Wh
	 7K4GYShWzHLw9yw0QQHglm79VLt1WrlMOMNKQEV13QibXH0bjc/25ff/YfnWFtsUfl
	 2SOH+cLIPYPtmHYw82s8yqCSEtBBijd8ykQGxzujvwYtOHUSr60A7QVtAOdAzxxFRW
	 zEqwyfM8VXkr/xw8YnTEoIJFa76wmi3HUTtvMSDKmUkMjmtct0YcsuBHZZL22eSWpr
	 BAnWHWZq2reJZH69JnbC2IFti5B9Lp5h/a9kMuGIyapnkL0pBc7D5cyMKo76FEPyj8
	 xL772pWwAuWNg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 3/7] KVM: SVM: Move RAX legality check to SVM insn interception handlers
Date: Fri, 13 Mar 2026 00:10:20 +0000
Message-ID: <20260313001024.136619-4-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260313001024.136619-1-yosry@kernel.org>
References: <20260313001024.136619-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When #GP is intercepted by KVM, the #GP interception handler checks
whether the GPA in RAX is legal and reinjects the #GP accordingly.
Otherwise, it calls into the appropriate interception handler for
VMRUN/VMLOAD/VMSAVE. The intercept handlers do not check RAX.

However, according to the APM, the interception takes precedence
over #GP due to an invalid operand:

  Generally, instruction intercepts are checked after simple exceptions
  (such as #GP—when CPL is incorrect—or #UD) have been checked, but
  before exceptions related to memory accesses (such as page faults) and
  exceptions based on specific operand values.

Move the check into the interception handlers for VMRUN/VMLOAD/VMSAVE as
the CPU does not check RAX before the interception.

Opportunisitically make the non-SVM insn path in gp_interception() do an
early return to reduce intendation.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c |  5 +++++
 arch/x86/kvm/svm/svm.c    | 34 +++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5ff01d2ac85e4..016bf88ec2def 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1115,6 +1115,11 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 
 	vmcb12_gpa = svm->vmcb->save.rax;
 
+	if (!page_address_valid(vcpu, vmcb12_gpa)) {
+		kvm_inject_gp(vcpu, 0);
+		return 1;
+	}
+
 	ret = nested_svm_copy_vmcb12_to_cache(vcpu, vmcb12_gpa);
 	if (ret) {
 		if (ret == -EFAULT) {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 796a6887305d6..f019a3f7705ae 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2183,6 +2183,7 @@ static int intr_interception(struct kvm_vcpu *vcpu)
 static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	u64 vmcb12_gpa = svm->vmcb->save.rax;
 	struct vmcb *vmcb12;
 	struct kvm_host_map map;
 	int ret;
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
@@ -2306,24 +2312,18 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 		goto reinject;
 
 	opcode = svm_instr_opcode(vcpu);
+	if (opcode != NONE_SVM_INSTR)
+		return emulate_svm_instr(vcpu, opcode);
 
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
-		if (!page_address_valid(vcpu, svm->vmcb->save.rax))
-			goto reinject;
+	if (!enable_vmware_backdoor)
+		goto reinject;
 
-		return emulate_svm_instr(vcpu, opcode);
-	}
+	/*
+	 * VMware backdoor emulation on #GP interception only handles
+	 * IN{S}, OUT{S}, and RDPMC.
+	 */
+	if (!is_guest_mode(vcpu))
+		return kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);
 
 reinject:
 	kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
-- 
2.53.0.851.ga537e3e6e9-goog

