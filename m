Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA803F12C6;
	Mon, 12 Oct 2026 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848219; cv=none; b=g9/5KecL2PLqYZ3eHuwpJNLCAWVw09bmMIE4UjZSTr7+/MqCVrDLY4YwymOmVLCtMCLpBJLneqbjLUohMPl8eedUZdeweZuZhS28xOlRNCX+daRPYqpN7iEYUu9C4YPx9N1FqeBkUgeeAR3VblU7PBEBnbqHh0t+hMSegCNkvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848219; c=relaxed/simple;
	bh=k7+Bp07jhxIrhpNU8oLBvk636EqVV0cRlCT8o9q9ofU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hO3C7K5HWzibbZWF13ANfVDYa/zeNjZKIuyjBa1ur68MzIzLwHyYHVgsUYNxbR7VgIpFY8HGYOCiiJydtAuY2FkgzNgsR4FwnRvquOWQ8PNBqbEv7BOlEme2FQk5SalKTR84X1K7xU5laW6BjxVy2iX9dkhdOhymcFYkBwjynU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfAkKCuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfAkKCuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EE41F008A2;
	Mon, 12 Oct 2026 23:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848217;
	bh=XdAX+8/VrrR4H1lbBo+kqdDV2XPwGFCkWl3q+dZFPMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kfAkKCuXGPpvEvFzHYhZB1Kqq4VAZRdlZeInSBIHUTrfgt0+ycu0qxSrUe2KnFNmj
	 SKV580YCNfNysgVL60D4gb7U/r2QEl+2PtJbuiTfPxgVdBqpLCM5m9cZzZy50Beowk
	 ObIXemKTOIXzIIrqjn3qrUqc3Rku3FP2T2yEqvc8PCQ7Wt/EDsiMj85hrHs6L0xoMb
	 1274SiyMVx323wORDtlp4mGcYS321EroZVk+lB3Ls/CqrmquuSeyNcwJycIDaKgA6D
	 j9NZVD7O7PfCqkrlPW1BfH8MXsPLsUG7PYI8IKZoxpnGItVf/v5VmgFIGkLhAhtJQ5
	 GszWLPeIri/dg==
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
Subject: [PATCH v3 23/27] KVM: nSVM: Do not reset TLB_CONTROL in vmcb02 on nested VM-Enter
Date: Mon, 12 Oct 2026 23:36:34 +0000
Message-ID: <20261012233638.2546339-24-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop clearing TLB_CONTROL when preparing the control area of vmcb02, as
this potentially undoes pending TLB flushes for L2 (e.g. through
KVM_REQ_TLB_FLUSH while L1 is running), and remove the associated TODO
comment.

This is currently harmless, because nested_svm_entry_tlb_flush() always
requests KVM_REQ_TLB_FLUSH_CURRENT on nested VM-Enter, which sets
TLB_CONTROL again before L2 is actually run. However, always flushing
will soon go away with proper TLB handling for L2, at which point always
clearing TLB_CONTROL would be a bug.

Clearing TLB_CONTROL on nested VM-Enter was probably done because
TLB_CONTROL is not cleared by the CPU on VM-Exit. However, KVM always
clears TLB_CONTROL in the active VMCB after a successful VMRUN. Hence,
at nested VM-Enter, TLB_CONTROL in vmcb02 can only be non-zero if a TLB
flush is queued for L2 while L1 is running (i.e. KVM_REQ_TLB_FLUSH), and
that should never be ignored.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 8e4686b0d603a..738ec1f2ec869 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -723,12 +723,7 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 	}
 
-	/*
-	 * TODO: optimize unconditional TLB flush/MMU sync.  A partial list of
-	 * things to fix before this can be conditional:
-	 *
-	 *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
-	 */
+	/* TODO: optimize unconditional TLB flush/MMU sync */
 	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
@@ -975,9 +970,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 
 	vmcb02->control.asid = svm->nested.asid02;
 
-	/* Overwritten later if necessary.  */
-	vmcb_clr_flush_asid(vmcb02);
-
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
 	if (nested_npt_enabled(svm)) {
 		vmcb02->control.misc_ctl &= ~SVM_MISC_ENABLE_GMET;
-- 
2.56.0.385.gd3acb90ef8-goog

