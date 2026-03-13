Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B19182D0;
	Fri, 13 Mar 2026 00:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360643; cv=none; b=RU28coma+Y8XUED7jgGP5T1vOpvyuvDjgq4634D0Dq0VVVDkAr7lERFdw1ZfH2nhmT+m0AHSyvrr8+jKeqj7o1eVTkgz0F4i+Zt6c6xJPg3OXXrd9mVgkmsiD1ICxPPnd3GNQXcyXL1edHtXvIO9lswGncttR/xiBilVT7NmYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360643; c=relaxed/simple;
	bh=uSYzyoDiDO9EMcoYDi6QAbGw1/2SBApLvZxUUi5H+MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D72OhChUeaOuFZfsmGUVNxxA8nKWV8VyYqcCvJdJtnWTKS4UhHDWNTELKWO1pvAngpSA0FCFefutABjnevszKv63LmSMYrbtUgBbSDaXAe7v2CNGVsa4o4J8wFOwMj5S2dtU5vJkFMMc6K5m+hrQINyIlPMUBgJ+In2GJcez9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQjzrvfX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQjzrvfX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6DBC2BC87;
	Fri, 13 Mar 2026 00:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773360643;
	bh=uSYzyoDiDO9EMcoYDi6QAbGw1/2SBApLvZxUUi5H+MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQjzrvfXCDOyJjFVNU63TzXV3w4tEHUirwO4IkcBO1xgur8B3mkOny/Xu+k0lm9Wa
	 7m8MlYao2yC9NAeDFe2hGE/2MBrkWoaagCtWdPqjOpHNgvtgEW1zYv5KlrI0w2ep9O
	 +AYNyCTApFV3/FXmX+4NqIBJK39rcYQX2c1W/E3v+ex2ZDzZ2cBpP4YbM9MMr6DBSf
	 5xTVDDYim61oulrrVF6hAISB0ngRnojkLa1CglOTxjK8ZZoOBM7lr4TthcDhELgmgi
	 d+hjdEq6hVwVDKhpC2mr7MyCTPIhs9DaUsX9nL1UM9bp26kMwVrQfWamGBtYur8Y+Q
	 5nElhDF3EMkCQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 2/7] KVM: SVM: Check that RAX has legal GPA on #GP interception of SVM insns
Date: Fri, 13 Mar 2026 00:10:19 +0000
Message-ID: <20260313001024.136619-3-yosry@kernel.org>
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

KVM intercepts #GP when EFER.SVME is set if the CPU does not have
X86_FEATURE_SVME_ADDR_CHK to work around an erratum where some CPUs
check EAX against reserved memory regions. KVM re-injects the #GP if an
SVM instruction was executed with mis-aligned RAX, and it otherwise
emulates it.

However, a #GP should also be reinjected if RAX contains an illegal GPA,
according to the APM, one of #GP conditions is:

  rAX referenced a physical address above the maximum
  supported physical address.

Replace the PAGE_MASK check with page_address_valid(), which checks both
page-alignment as well as the legality of the GPA based on the vCPU's
MAXPHYADDR.

Note that this is currently not a problem, because kvm_vcpu_map() should
fail on illegal GPAs and inject a #GP anyway. However, following patches
will change the failure behavior of kvm_vcpu_map(), so make sure the #GP
interception handler does this appropriately.

Fixes: 82a11e9c6fa2 ("KVM: SVM: Add emulation support for #GP triggered by SVM instructions")
Fixes: d1cba6c92237 ("KVM: x86: nSVM: test eax for 4K alignment for GP errata workaround")
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d98fbc0e58e8f..796a6887305d6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2319,8 +2319,7 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 			return kvm_emulate_instruction(vcpu,
 				EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);
 	} else {
-		/* All SVM instructions expect page aligned RAX */
-		if (svm->vmcb->save.rax & ~PAGE_MASK)
+		if (!page_address_valid(vcpu, svm->vmcb->save.rax))
 			goto reinject;
 
 		return emulate_svm_instr(vcpu, opcode);
-- 
2.53.0.851.ga537e3e6e9-goog

