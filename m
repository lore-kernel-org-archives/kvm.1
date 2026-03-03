Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572031F9BA;
	Tue,  3 Mar 2026 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498075; cv=none; b=eS5I1YLZLebnCiR1F1FYzxfEWDmZl9OosE1xc1IANwClgM6ajBNM4dMonxV3GUszna7bl2h1pMXz3nTD1OVGT/CO4ZMGPASg41pYE9AzQVpphO4wfG4+AUD9SYqqHMhIOJXgT8VYvRILN9Ujz6rSDHpetGAadibefJP8ZXaM9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498075; c=relaxed/simple;
	bh=5AMx4cXBCnhrwKkrVFnaBuckFWwMy/Uk+j0dXdWnDBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sf7SmRMWqcY89MfHfLBy7DsOS+hAFMs9GUFyX7n4pfIZzOeVOpP3SC2k8hDh8VSQO7/dIYVuT47TY/zalZEv770OQShL1jsPR0TfXT9hFLsrEe78mT1V9tCOtkGwlDBp2FDIhqy+ESa08LKk1LJN2idr9lf/b772pPGcgxFP0RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Stq6C2O6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Stq6C2O6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B27CC2BCB0;
	Tue,  3 Mar 2026 00:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772498074;
	bh=5AMx4cXBCnhrwKkrVFnaBuckFWwMy/Uk+j0dXdWnDBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Stq6C2O6l+yInvuMbZ9z0t3K3hhe9GFDd4a6CUH/Hu/sOvAUN5L/tK8GQLR61Lx2I
	 LgnbK1YXwKcez9QiFqHh1YR52KObEvT7uSXpgXxfcjfuBJIiLrwT4VJmCsaeCKK4wV
	 LJIEGPsvPWVYByNM6eqZ+1qhUtdLOI9wjNrhVbwZdZvBEFvI+nL0M22foZH+a4dvJH
	 91sYKC54WLr02fK2Q01uGT19Rg9AxGqL5WiQlVi4JDQooEGCXTJzplWF5+m/6cGdey
	 f64dYazkUT6r04NCu5yR8pEwrSwqPZoWC6if6gMYNXE4AOEQvNRbY//8EeJpSFwFjH
	 y2aRpeM2iFmpA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v7 08/26] KVM: nSVM: Triple fault if mapping VMCB12 fails on nested #VMEXIT
Date: Tue,  3 Mar 2026 00:34:02 +0000
Message-ID: <20260303003421.2185681-9-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260303003421.2185681-1-yosry@kernel.org>
References: <20260303003421.2185681-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM currently injects a #GP and hopes for the best if mapping VMCB12
fails on nested #VMEXIT, and only if the failure mode is -EINVAL.
Mapping the VMCB12 could also fail if creating host mappings fails.

After the #GP is injected, nested_svm_vmexit() bails early, without
cleaning up (e.g. KVM_REQ_GET_NESTED_STATE_PAGES is set, is_guest_mode()
is true, etc).

Instead of optionally injecting a #GP, triple fault the guest if mapping
VMCB12 fails since KVM cannot make a sane recovery. The APM states that
a #VMEXIT will triple fault if host state is illegal or an exception
occurs while loading host state, so the behavior is not entirely made
up.

Do not return early from nested_svm_vmexit(), continue cleaning up the
vCPU state (e.g. switch back to vmcb01), to handle the failure as
gracefully as possible.

Fixes: cf74a78b229d ("KVM: SVM: Add VMEXIT handler and intercepts")
CC: stable@vger.kernel.org
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 82a92501ee86a..5ad0ac3680fdd 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1200,12 +1200,8 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
 	int rc;
 
-	rc = nested_svm_vmexit_update_vmcb12(vcpu);
-	if (rc) {
-		if (rc == -EINVAL)
-			kvm_inject_gp(vcpu, 0);
-		return 1;
-	}
+	if (nested_svm_vmexit_update_vmcb12(vcpu))
+		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 
 	/* Exit Guest-Mode */
 	leave_guest_mode(vcpu);
-- 
2.53.0.473.g4a7958ca14-goog

