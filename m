Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51712980A8;
	Tue, 16 Jun 2026 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570546; cv=none; b=HKCOAT5GkwrRmsbskqYar9pw+ZKzU6CO5/qXIUToEc2NKP5q2WbxKzEq+IO0TWbifdsbkAsuhRrbQzZYpjPTjE+AjKEHwCVqBvCIsWGce0zBg+LaaI8RYOtdDT7Tjf3eylyeQqJCsZ+9FDXIWsr1ZyGghbdEQeo/om0BZ64AQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570546; c=relaxed/simple;
	bh=h2+WlcU2Ali/goE/6AB7a+urCj9QgVDDYuiTFC3uoiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwGvASQW7a/nIzGkvl3JrpgerAvPIC4Ei80JrST897wca2FE8mwMcRvBak8AQoNqq39Ej76+9XaRgb9DWsLTO8w3ttppn1Q4tfSHwvZcK4Yu1MErfWclkcR1PXvjmhn+IMus3Z9umskvyxInDtquWi0Q4XxoroiNHVWB4Gx95YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHFFM5Qt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHFFM5Qt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E721F00A3F;
	Tue, 16 Jun 2026 00:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570544;
	bh=UhLseoUQ1lvaxkyEJlu1xj22rOQWDST0Qc8m6dGpDnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZHFFM5Qtgrh7m388hJnBWUde1XPmMJR8e1iCLEclMg+RjfjQCtiY6AJ5PFiOFjKBg
	 3fxrN2fuHV5hrk35EKMWQJTLlZ+lWt6FDDnB86PzOdA1ZDDN5TxWZbA26FvQHDVDcP
	 OQc4BDm5x4lRpUh3qBfJTt+kGCvew0f+eE2DQ9Vihv0DH8IGBJX5B0cRwDY2z4Yl3H
	 mEZcnOb7aUgASqUIVhEFc2i2bYPQ1Cm5p5okbB6lgJXzVHcJpNTqFVYYS1O0Rl0NL4
	 TITAwd+Jfun0J0cxwHr8oUsNQwpp36WdoayeQ8RIJNCNONAgbNeyg1NZSFUf0nenV9
	 ndFb7Ubax0a2g==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH v2 06/25] KVM: SVM: Fallback to flush everything if FLUSHBYASID is not available
Date: Tue, 16 Jun 2026 00:41:35 +0000
Message-ID: <20260616004155.1435766-7-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616004155.1435766-1-yosry@kernel.org>
References: <20260616004155.1435766-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if FLUSHBYASID is not available when performing a TLB flush,
the fallback is decrementing the ASID generation to trigger allocating a
new ASID. In preparation for using a static ASID per vCPU (like VMX),
just fallback to flushing everything if FLUSHBYASID is not available.
This is probably worse from a performance perspective, but FLUSHBYASID
has been around for ~15 years and it's not worth carrying the
complexity.

The fallback logic is moved within vmcb_set_flush_asid(), as more
callers will be added and will need the fallback as well. The only other
current caller is from SEV code, and no CPUs support SEV but not
FLUSHBYASID (at least according to AI).

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 5 +----
 arch/x86/kvm/svm/svm.h | 5 ++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a7cc3cb101e57..159abf841738f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4185,10 +4185,7 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
 	 * unconditionally does a TLB flush on both nested VM-Enter and nested
 	 * VM-Exit (via kvm_mmu_reset_context()).
 	 */
-	if (static_cpu_has(X86_FEATURE_FLUSHBYASID))
-		vmcb_set_flush_asid(svm->vmcb);
-	else
-		svm->current_vmcb->asid_generation--;
+	vmcb_set_flush_asid(svm->vmcb);
 }
 
 static void svm_flush_tlb_current(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 5b4613b4d7bc2..4bf8afdc77cbd 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -478,7 +478,10 @@ static inline void vmcb_set_gpat(struct vmcb *vmcb, u64 data)
 
 static inline void vmcb_set_flush_asid(struct vmcb *vmcb)
 {
-	vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+	if (static_cpu_has(X86_FEATURE_FLUSHBYASID))
+		vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+	else
+		vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ALL_ASID;
 }
 
 static inline void vmcb_clr_flush_asid(struct vmcb *vmcb)
-- 
2.54.0.1136.gdb2ca164c4-goog

