Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C428690;
	Fri, 13 Mar 2026 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360645; cv=none; b=R+DO+D4r3LTGO0n8ezuKhAqAs2HOSZD8dKe8iTdKdMiDXM8c6jq45EMYmScyhuajTAQUY6XBXBdnGyiuWaoNCytQFwM8XraXuDPlSXKbaL7SfBIjFlnwu2yEmNm1fSkhZxAxVeqM/NGzl4hagTvTsuYvGoj/7RP/wnVPSd4bj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360645; c=relaxed/simple;
	bh=iT7ytVgEpQbRU1hUnmwIaSYlLLEpefPIQyU87UhnxmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dyo4FlMO+o+VrjxTkGwIPka6Mtq68YST/R5p2oeNhl+cCNu7qWgElsasrvVlO9hSrOF9pLJSJnmoXGcf6jMfYyREgIFnfEikIqHNmXvpwHYYdnuAgx12JP2ytlj6r0mvwVQ4a68ni5dRP3a+xt1yAdUPXlBo+HITNHkMEmhFbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7wMqaZ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7wMqaZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC57C2BC86;
	Fri, 13 Mar 2026 00:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773360644;
	bh=iT7ytVgEpQbRU1hUnmwIaSYlLLEpefPIQyU87UhnxmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7wMqaZ3KBW4J+jLyepP82QkOAlxwoDXhQZ4MRXmrQoZh1OcRRc3Mq15EEeIsSyP2
	 wrKJTHVtql0lWlTUADU+fU6WpJiKBI8kEDXgr5CDIb89A3laZwDVJrjo4/9A/T8NZF
	 4wcfvh5tgfIUIkk6VZm2RcmKzbV5L3gH3Gqlb04zqGw9GBBPW35zsgDftuFHo4euQ9
	 pCjfamJcQMMytNISEO84OCwASbt/XahgBLkwUnjPGDA/yJ0fyz+cJ97jUUKQc20jME
	 f4I+0o3jjxrPLX2KwPsFKDdtxFxQ0gIzANiyYVfTGniVrUG9HO0H1XTRcIbg05iyru
	 u+vbJwinCr7XQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 5/7] KVM: nSVM: Fail emulation of VMRUN/VMLOAD/VMSAVE if mapping vmcb12 fails
Date: Fri, 13 Mar 2026 00:10:22 +0000
Message-ID: <20260313001024.136619-6-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260313001024.136619-1-yosry@kernel.org>
References: <20260313001024.136619-1-yosry@kernel.org>
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
index 016bf88ec2def..8320c98b704ce 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1122,10 +1122,8 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 
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
index 3b1516ea45d4f..a0dacbeaa3c5a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2196,10 +2196,8 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 		return 1;
 	}
 
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(svm->vmcb->save.rax), &map)) {
-		kvm_inject_gp(vcpu, 0);
-		return 1;
-	}
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(svm->vmcb->save.rax), &map))
+		return kvm_handle_memory_failure(vcpu, X86EMUL_IO_NEEDED, NULL);
 
 	vmcb12 = map.hva;
 
-- 
2.53.0.851.ga537e3e6e9-goog

