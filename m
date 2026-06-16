Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282EC31815D;
	Tue, 16 Jun 2026 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570551; cv=none; b=NxaAtrvydg9ywv/KDfCT7FRa4PWEWRkpEmS7a95sYMn7t1kKj92eQC1IWg897bdcEJfLhozvqR8/3dvSSNA1yHhFSWHJQV0mz29AJ6+gQyM8l+plcXw8MbAqozj2YpmSzRNGtYCjPoV8M4aJ/ZiGjPXffmJT1FnvcdI12Cvnk6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570551; c=relaxed/simple;
	bh=QwRdlAQwrwqh3SJdkLaTPk2Ru9TG5kK2Ur/9/MgX8IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=or12MOcapw4om1Z3VIQGZIiEIBOzJ2h84zG6dNTNVqE+nGbQBjtttSsUpvG0Uxfkbjq/srK4SWs8KLyHNy2IqMe0xP6SlDTNpmmtUtcFpfGC88XdkMvWG54hrXMqRrVg+rGb3C7FdQ5Vo8Qkj1yqFdsON7NhkOmkalGseiJpV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRmd6u2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRmd6u2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD011F00A3D;
	Tue, 16 Jun 2026 00:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570550;
	bh=UhBHjvxsNVuRTb80l3EKUhu83ZaJvwbzRMEnhGxES5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LRmd6u2uyAtN4d6ObHdpxTH9+6H6XsH3nz87D2PmszSJBSaQuFmXNWieiQwQX1hWb
	 I81FiwnqappbL4qrZmjRY4+KbqefW802H/q3Kqn+kMAE9M9UIY34Y3zKBv7dKTEjhP
	 G+MMKzvtVnT3ahRh+iee/+cS/csNBSnTS+4jmd/pMp3SLjt1fQBXyB2KDLl/3+aSFb
	 ugC+Dvuw0VU2YXR60qou+OPMBUxodpsJmxZAFOprmYDkCZ8GvWpRm2LBxoxh/iQ9+K
	 BL6LRhFgvDQot05Cw6kPMlZCPIPCLkIAztg5c/MD+Il+TV3bvWOrpxEZHFUhsvIgmg
	 KyY1RdWEjYFIw==
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
Subject: [RFC PATCH v2 17/25] KVM: nSVM: Service local TLB flushes before nested transitions
Date: Tue, 16 Jun 2026 00:41:46 +0000
Message-ID: <20260616004155.1435766-18-yosry@kernel.org>
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

KVM does not track TLB flush requests for L1 vs. L2. Hence, service
local flush that target the current context before switching to a new
one. Since TLB flushes are performed through the VMCB's TLB_CONTROL
field, service the flushes before every VMCB switch.

Note that nested_svm_{entry/exit}_tlb_flush() must be called after
kvm_service_local_tlb_flush_requests(), otherwise the TLB flushes will
be immediately serviced in the "old" VMCB rather than the new one.

This is conceptually similar to how nVMX calls
kvm_service_local_tlb_flush_requests() with a few differences:

1. VMX performs TLB flushes through INVVPID or INVEPT. The VPID is
   determined based on guest mode, and the EPT pointer is determined
   based on the active MMU. Hence, local TLB flushes are serviced before
   switching guest mode and switching the MMU. On the other hand, SVM
   performs TLB flushes by updating the VMCB, hence local TLB flushes
   are serviced before switching the VMCB.

2. VMX has a single code path for entering guest mode (i.e.
   nested_vmx_enter_non_root_mode()) and a single code path for exiting
   guest mode (i.e. nested_vmx_vmexit()). Other code paths like
   vmx_set_nested_state() and vmx_leave_nested() call into these
   functions. On the other hand, SVM open codes the switches in several
   places, so call kvm_service_local_tlb_flush_requests() from
   svm_switch_svm() to more-or-less guarantee it is not missed.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 234724d8b4c54..7b19191e0e43f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -717,9 +717,16 @@ static void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_v
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
+	/*
+	 * TLB flushes are applied to the VMCB, so apply any pending TLB flushes
+	 * on the current VMCB before switching to a new one..
+	 */
+	kvm_service_local_tlb_flush_requests(vcpu);
+
 	svm->current_vmcb = target_vmcb;
 	svm->vmcb = target_vmcb->ptr;
 
+	/* .. then request TLB flushes needed for the new VMCB */
 	if (target_vmcb == &svm->nested.vmcb02)
 		nested_svm_entry_tlb_flush(vcpu);
 	else
-- 
2.54.0.1136.gdb2ca164c4-goog

