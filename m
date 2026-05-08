Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41E26B74A
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778276004; cv=none; b=VW4oTLViHEyJA2x2q9Xbb+hCcc7YPQ3BfFF2avXNO2+HYgMO2+X0+b6mHwefo7xh9qhTPPdJk7BnriIPTcCh/nNdejoj1rtTNOQd45tGH+lFwE4qxTNzjAKbDfrck0WQdd4SbUCSLkrkLLRAdxblW/wF0QP7JkCYcgitVpaJFV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778276004; c=relaxed/simple;
	bh=yUHXgxBTh8v1xnQqwGXQbJ9yLER9JkWJBdWj8+ST9d0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WWCCsU/KdQFF5suFv9/Ity03eup/lGmLGJAOaJ7hvJpwCFPiqlEqtsqjs70rpOfhH7dJDNgr2+kYyqgtLPflulhk8HlDm4Fj7SYUlKMvaSUSnrx/+8w4UZaEwL7dXriWXcZwP1M/NTZtIZZYv/S7ZXNE7sCYUXlfsCaYixZ37as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p75lQMD1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p75lQMD1"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so2866437b3a.2
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 14:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778276003; x=1778880803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjofHkjWw2tFsTfMCyLcAchnEK9pNIRKLucCCawfiyI=;
        b=p75lQMD1vU9rFXs5Mx6E4InR70riqzAAQyO7P/QSPlQQpxlm73a4xio5nb8tSdmrfr
         fCZwKPzrBCIRcKsjWRrqZv3tSaQ1HlzhFGkXR/UIrz3rl1+FJQLZ19j510G6n4LQD4OV
         4QMP9gZ0SpSWcv+6HONR+oS1PvVE1jApJU8YYb6oeIjyD6ZkyZmYO81zuGa2XQuF0Beq
         K4yGtes40ER99y6PDCYz2uuXt7OlrCgsqRQ7yChACfazKqRsIggNwqMsX/m9bZa25L3t
         ZKxER2xh+Rf9dhBbJCEJFbFNagAbcaBmRgP/1NSnSdoGTRhgHmJ0sWG1WDXhVEffiD3/
         e8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778276003; x=1778880803;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjofHkjWw2tFsTfMCyLcAchnEK9pNIRKLucCCawfiyI=;
        b=drRsYCQ1hM3fi8pASwSpBpJOsZowEyirQP4G+/A2hDeZZ1YvpTx6lDo96MyU84N+lV
         z90IGQhAtZzdesNKSQGA9Z6nxIfEl9gAIpuuXiW9eL9t68wKhXhrlKsrK8792wms8lbw
         9e0ftisMrkA/hMfzI5+Lx4gTHZYQXD3OcHeKnXTEp2BZnrtzO0+c2n8P44lv/2oaaqO1
         Esynv1MhFRBVMmOscL7w9jrA0NCy7vbVorE35fODuHCJq4uC5UseW13whtT5b6ggIH/a
         8Ya4tg6nMCwbri38U2wYzI4ZVYXaeE9k9OA00dS9y+ssmrNNQnJO8Ml8hrJ0GoFerluA
         5S9A==
X-Gm-Message-State: AOJu0YyyZGLAYlum6QfawNkDOkX7dGRwER4aiA5hWSmRe1m+Yclp43Ne
	uYzcHHphB5kgr5ZZ1Uur3dfY4iQo60dfLsFnOpcWX8zRtchFWUqJUpXawD5JDZ0ynkbL9NuPPg8
	J72i5bA==
X-Received: from pfmm3.prod.google.com ([2002:a05:6a00:2483:b0:836:6db4:9aa7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:238c:b0:82c:d986:e917
 with SMTP id d2e1a72fcca58-83a5c8b015dmr13965264b3a.22.1778276002373; Fri, 08
 May 2026 14:33:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 May 2026 14:33:21 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508213321.373309-1-seanjc@google.com>
Subject: [PATCH v2] KVM: nSVM: Never use L0's PAUSE loop exiting while L2 is running
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, David Kaplan <david.kaplan@amd.com>
Content-Type: text/plain; charset="UTF-8"

Never use L0's (KVM's) PAUSE loop exiting controls while L2 is running,
and instead always configure vmcb02 according to L1's exact capabilities
and desires.

The purpose of intercepting PAUSE after N attempts is to detect when the
vCPU may be stuck waiting on a lock, so that KVM can schedule in a
different vCPU that may be holding said lock.  Barring a very interesting
setup, L1 and L2 do not share locks, and it's extremely unlikely that an
L1 vCPU would hold a spinlock while running L2.  I.e. having a vCPU
executing in L1 yield to a vCPU running in L2 will not allow the L1 vCPU
to make forward progress, and vice versa.

While teaching KVM's "on spin" logic to only yield to other vCPUs in L2 is
doable, in all likelihood it would do more harm than good for most setups.
KVM has limited visibility into which L2 "vCPUs" belong to the same VM,
and thus share a locking domain.  And even if L2 vCPUs are in the same
VM, KVM has no visilibity into L2 vCPU's that are scheduled out by the
L1 hypervisor.

Furthermore, KVM doesn't actually steal PAUSE exits from L1. If L1 is
intercepting PAUSE, KVM will route PAUSE exits to L1, not L0, as
nested_svm_intercept() gives priority to the vmcb12 intercept.  As such,
overriding the count/threshold fields in vmcb02 with vmcb01's values is
nonsensical, as doing so clobbers all the training/learning that has been
done in L1.

Even worse, if L1 is not intercepting PAUSE, i.e. KVM is handling PAUSE
exits, then KVM will adjust the PLE knobs based on L2 behavior, which could
very well be detrimental to L1, e.g. due to essentially poisoning L1 PLE
training with bad data.

And copying the count from vmcb02 to vmcb01 on a nested VM-Exit makes even
less sense, because again, the purpose of PLE is to detect spinning vCPUs.
Whether or not a vCPU is spinning in L2 at the time of a nested VM-Exit
has no relevance as to the behavior of the vCPU when it executes in L1.

The only scenarios where any of this actually works is if at least one
of KVM or L1 is NOT intercepting PAUSE for the guest.  Per the original
changelog, those were the only scenarios considered to be supported.
Disabling KVM's use of PLE makes it so the VM is always in a "supported"
mode.

Last, but certainly not least, using KVM's count/threshold instead of the
values provided by L1 is a blatant violation of the SVM architecture.

Fixes: 74fd41ed16fd ("KVM: x86: nSVM: support PAUSE filtering when L0 doesn't intercept PAUSE")
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Tested-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v2:
 - Don't apply PLE shrink when L2 is active, WARN if L2 is active in grow
   path (i.e. if KVM handles PAUSE interception). [David]

v1: https://lore.kernel.org/all/20250131010601.469904-1-seanjc@google.com

 arch/x86/kvm/svm/nested.c | 43 +++++++++++++--------------------------
 arch/x86/kvm/svm/svm.c    |  9 ++++++--
 2 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 961804df5f45..b340dc9991ad 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -160,6 +160,16 @@ void nested_vmcb02_recalc_intercepts(struct vcpu_svm *svm)
 	if (!intercept_smi)
 		vmcb_clr_intercept(&vmcb02->control, INTERCEPT_SMI);
 
+	/*
+	 * Intercept PAUSE if and only if L1 wants to.  KVM intercepts PAUSE so
+	 * that a vCPU that may be spinning waiting for a lock can be scheduled
+	 * out in favor of the vCPU that holds said lock.  KVM doesn't support
+	 * yielding across L2 vCPUs, as KVM has limited visilibity into which
+	 * L2 vCPUs are in the same L2 VM, i.e. may be contending for locks.
+	 */
+	if (!vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_PAUSE))
+		vmcb_clr_intercept(&vmcb02->control, INTERCEPT_PAUSE);
+
 	if (nested_vmcb_needs_vls_intercept(svm)) {
 		/*
 		 * If the virtual VMLOAD/VMSAVE is not enabled for the L2,
@@ -819,7 +829,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
 	struct vmcb *vmcb01 = svm->vmcb01.ptr;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
-	u32 pause_count12, pause_thresh12;
 
 	nested_svm_transition_tlb_flush(vcpu);
 
@@ -947,31 +956,13 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 		vmcb02->control.misc_ctl2 |= SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE;
 
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_PAUSEFILTER))
-		pause_count12 = vmcb12_ctrl->pause_filter_count;
+		vmcb02->control.pause_filter_count = vmcb12_ctrl->pause_filter_count;
 	else
-		pause_count12 = 0;
+		vmcb02->control.pause_filter_count = 0;
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_PFTHRESHOLD))
-		pause_thresh12 = vmcb12_ctrl->pause_filter_thresh;
+		vmcb02->control.pause_filter_thresh = vmcb12_ctrl->pause_filter_thresh;
 	else
-		pause_thresh12 = 0;
-	if (kvm_pause_in_guest(svm->vcpu.kvm)) {
-		/* use guest values since host doesn't intercept PAUSE */
-		vmcb02->control.pause_filter_count = pause_count12;
-		vmcb02->control.pause_filter_thresh = pause_thresh12;
-
-	} else {
-		/* start from host values otherwise */
-		vmcb02->control.pause_filter_count = vmcb01->control.pause_filter_count;
-		vmcb02->control.pause_filter_thresh = vmcb01->control.pause_filter_thresh;
-
-		/* ... but ensure filtering is disabled if so requested.  */
-		if (vmcb12_is_intercept(vmcb12_ctrl, INTERCEPT_PAUSE)) {
-			if (!pause_count12)
-				vmcb02->control.pause_filter_count = 0;
-			if (!pause_thresh12)
-				vmcb02->control.pause_filter_thresh = 0;
-		}
-	}
+		vmcb02->control.pause_filter_thresh = 0;
 
 	/*
 	 * Take ALLOW_LARGER_RAP from vmcb12 even though it should be safe to
@@ -1298,12 +1289,6 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	/* in case we halted in L2 */
 	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 
-	if (!kvm_pause_in_guest(vcpu->kvm)) {
-		vmcb01->control.pause_filter_count = vmcb02->control.pause_filter_count;
-		vmcb_mark_dirty(vmcb01, VMCB_INTERCEPTS);
-
-	}
-
 	/*
 	 * Invalidate last_bus_lock_rip unless KVM is still waiting for the
 	 * guest to make forward progress before re-enabling bus lock detection.
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..ac21f402c1ca 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -913,7 +913,12 @@ static void grow_ple_window(struct kvm_vcpu *vcpu)
 	struct vmcb_control_area *control = &svm->vmcb->control;
 	int old = control->pause_filter_count;
 
-	if (kvm_pause_in_guest(vcpu->kvm))
+	/*
+	 * While running L2, KVM should intercept PAUSE if and only if L1 wants
+	 * to intercept PAUSE, and L1's intercept should take priority, i.e.
+	 * KVM should never handle a PAUSE intercept from L2.
+	 */
+	if (WARN_ON_ONCE(is_guest_mode(vcpu) || kvm_pause_in_guest(vcpu->kvm)))
 		return;
 
 	control->pause_filter_count = __grow_ple_window(old,
@@ -934,7 +939,7 @@ static void shrink_ple_window(struct kvm_vcpu *vcpu)
 	struct vmcb_control_area *control = &svm->vmcb->control;
 	int old = control->pause_filter_count;
 
-	if (kvm_pause_in_guest(vcpu->kvm))
+	if (is_guest_mode(vcpu))
 		return;
 
 	control->pause_filter_count =

base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
-- 
2.54.0.563.g4f69b47b94-goog

