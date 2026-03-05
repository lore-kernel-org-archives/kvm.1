Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F0233A9DE;
	Thu,  5 Mar 2026 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742625; cv=none; b=Uo4LWBP2A8OfJvIkqBo9WIRuORraJG/4LKNfoKiZx3lauKR1tpmHxv8XKTg6WvaixNzJBBD9+q50INGoFTpMdeU94OSM6G16fgkt+HJo6RdkfI6ie22E74H/QN0ZwdOAzx+LmQNzKWA64d/nzhDXRn5JTOEQz78SSLQs/6CvY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742625; c=relaxed/simple;
	bh=rSa2W0G7aR8oOklcUQq87bd3yTbbQ5Kd8Baa+AD/1iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvtVP0O6XX5x3o3hhejLENdgFlLWybgJToFv6Y6clrAIIJwFwXBzxdeIz6kynWq3FDZh4isRi8fYpThdvAprjVDAtSX1Bnk1iuhYDbthf8C81ntUjcOTpzwFmgbwMSt/G9Ex9gt2aph2e/3qH1mdbrpn/vpqLuSwJoWu1z0pvfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUSOa6nO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUSOa6nO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB8FC19422;
	Thu,  5 Mar 2026 20:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742625;
	bh=rSa2W0G7aR8oOklcUQq87bd3yTbbQ5Kd8Baa+AD/1iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUSOa6nOBiKNmzJpkdg/KEjaV/dUDdPQYAz+DGv/436F1+KK/auKIIbqo8qYHaqkC
	 s4XhQSD4kv4kCv/Jd31o7DEsmQ+8rpkC5zSKgGBzGjVtLCzAglMjB+9U6IqWYu0WFM
	 ULhsEee2FD5YrNItpS5VuushXm6nv/gwFQ6kgEBA+4zwaPmd9pPgPSoq7mA0s/ph8P
	 2r2v9fHPrGHLlKE7UmDdd9ocBpyJ2mimUWqAEI1UK9+RAxrbJH3GEKUlnoWeuZ4BB7
	 EkoIicdrrSkON8/7QlRykFq1jIVlwoxr+YOP5mcyAh4u5FEABAdb84zmXMegOcQYaw
	 zmK0iXhnizfmw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 1/2] KVM: nSVM: Simplify error handling of nested_svm_copy_vmcb12_to_cache()
Date: Thu,  5 Mar 2026 20:30:04 +0000
Message-ID: <20260305203005.1021335-2-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260305203005.1021335-1-yosry@kernel.org>
References: <20260305203005.1021335-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nested_svm_vmrun() currently stores the return value of
nested_svm_copy_vmcb12_to_cache() in a local variable 'err', separate
from the generally used 'ret' variable. This is done to have a single
call to kvm_skip_emulated_instruction(), such that we can store the
return value of kvm_skip_emulated_instruction() in 'ret', and then
re-check the return value of nested_svm_copy_vmcb12_to_cache() in 'err'.

The code is unnecessarily confusing. Instead, call
kvm_skip_emulated_instruction() in the failure path of
nested_svm_copy_vmcb12_to_cache() if the return value is not -EFAULT,
and drop 'err'.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b191c6cab57db..54227bacc12e4 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1079,7 +1079,7 @@ static int nested_svm_copy_vmcb12_to_cache(struct kvm_vcpu *vcpu, u64 vmcb12_gpa
 int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	int ret, err;
+	int ret;
 	u64 vmcb12_gpa;
 	struct vmcb *vmcb01 = svm->vmcb01.ptr;
 
@@ -1104,19 +1104,20 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 		return -EINVAL;
 
 	vmcb12_gpa = svm->vmcb->save.rax;
-	err = nested_svm_copy_vmcb12_to_cache(vcpu, vmcb12_gpa);
-	if (err == -EFAULT) {
-		kvm_inject_gp(vcpu, 0);
-		return 1;
+	ret = nested_svm_copy_vmcb12_to_cache(vcpu, vmcb12_gpa);
+	if (ret) {
+		/*
+		 * Advance RIP if #GP or #UD are not injected, but otherwise
+		 * stop if copying and checking vmcb12 failed.
+		 */
+		if (ret == -EFAULT) {
+			kvm_inject_gp(vcpu, 0);
+			return 1;
+		}
+		return kvm_skip_emulated_instruction(vcpu);
 	}
 
-	/*
-	 * Advance RIP if #GP or #UD are not injected, but otherwise stop if
-	 * copying and checking vmcb12 failed.
-	 */
 	ret = kvm_skip_emulated_instruction(vcpu);
-	if (err)
-		return ret;
 
 	/*
 	 * Since vmcb01 is not in use, we can use it to store some of the L1
-- 
2.53.0.473.g4a7958ca14-goog

