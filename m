Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430E1429D
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257988; cv=none; b=hMGuiXMCX29zHl9oZ8xsoPxCIYWuEYwNUhCFVfIUaJdTY1JZ8aDSqP/EJXnxdwydi/ey/BXnS/aX+SDaCGmr/b7L6nsVawZwCQkMb3g8OJ6LqcRidJrXoZH/u9KUYkvOIa0qPSOhy3wo0FZ+G7Kysb7iKM+vvPIHDHvSnzFCHbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257988; c=relaxed/simple;
	bh=2yUDm8yWsxVcK9WiZBMpXmBi5mwkYXR+g6ELFplaeHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jH4JE33QMU7WWLlMR6GFRrXlRO+JILyOtS/48WwQSTYLgfvWfjRKpGwGqHyd7+mwyG3+H94ewb414IDno1vbJ2L8lqubAJ06zF0U2xiztF7TpqEIzmGw/ZM0clgnWfd1+Wr4JwkXd12XhdbHrLR3MVJVOA+JBdmp394MywZMesM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKtl8fEx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKtl8fEx"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c798fc1a426so1297138a12.2
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778257985; x=1778862785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8p5i9N2+gRsF3bzAwgqqGISsjEAXTOtVi+F+eJp+Ks=;
        b=dKtl8fExiwe54e+JzGQKnzR9RuHGR8fnYF+14rlGiZlThkehqk9Tl5z04tHnsjGs42
         bMvVl1D1sd2YVJCGDDojQWWLNuJQpswNiCAQpSo6OT/Kfav+HXsgCLv5cuNlxZAuspw7
         71CeQj4VwJONy1/wuClFiLC7L8Wk73ZdMDGGUKiEVA3SWgOBxhDk7aaOVaTFym/j4DBT
         I89JsSOZSDCBPaU/swOM9ardVbyHvZWVIXBZ2uJAlwBWVgVqTM+mZ4KTLUX3S93JQGAX
         kqiHmUjLNrbCpL7de2zWh43JxYKLsS7pgJtWRUrc6as0h/Jmcz9gkP2ljXu9V/lEZi0b
         491Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778257985; x=1778862785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8p5i9N2+gRsF3bzAwgqqGISsjEAXTOtVi+F+eJp+Ks=;
        b=jLD2+qB8aKowbHfRZAq3aznxa+DAlSAIrs9mZttXT58XUBbiEWhQP+MByidk88L7b9
         DErpyGbGwzju5gbzoXWMJ7aXekYkeGn3AriCHrcnzKoBoL7RXkoneOg842yL8dhBkkMs
         qO/UmsKcY56j1Ds2M761ISwVqx3k9lJcBJEvcspw8InWN21fR92+pOUw787Bdw1QxYjW
         ioJ9TU70AHz05WXdvXvAwMI9WAIB/BBf/K6xds7BN1uPfZlHmnEPLrmM9w14T4ShYoHg
         dK9b7C6pEJAL0hDuEWKTNAK9Glu8ted6qdTtPCAAHptCQca46tZfPjk41dEEmA9yx3QV
         kBoA==
X-Gm-Message-State: AOJu0YzxOUdvPh8IawW9Wp3XPGewSjS0XYwFYPPQivJVXKb0Zgk28rzR
	p7/DE4743UXlKV6+8s4GL6Zl8PnEukxDR8aiEar9aQ2Dz/Ho6Byso5uyjPxrIUcK2b49Nje+hWI
	b5s9isA==
X-Received: from pfiu15.prod.google.com ([2002:a05:6a00:124f:b0:837:e90f:8cd9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a7:b0:398:8d38:c60c
 with SMTP id adf61e73a8af0-3aab187652dmr4189036637.55.1778257984969; Fri, 08
 May 2026 09:33:04 -0700 (PDT)
Date: Fri, 8 May 2026 09:33:04 -0700
In-Reply-To: <DS7PR12MB82010A5DF5F8DE5830CF16F9943C2@DS7PR12MB8201.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <DS7PR12MB820101CABFA34E85442EA256945AA@DS7PR12MB8201.namprd12.prod.outlook.com>
 <adVL9nqJhJwvu1QO@google.com> <DS7PR12MB820106A839105CD9E9E62328945AA@DS7PR12MB8201.namprd12.prod.outlook.com>
 <DS7PR12MB82010A5DF5F8DE5830CF16F9943C2@DS7PR12MB8201.namprd12.prod.outlook.com>
Message-ID: <af4QQFoMU6r7GnLZ@google.com>
Subject: Re: Bug with nested PAUSE intercept on SVM
From: Sean Christopherson <seanjc@google.com>
To: David Kaplan <David.Kaplan@amd.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 07, 2026, David Kaplan wrote:
> > From: Kaplan, David
> > > From: Sean Christopherson <seanjc@google.com>
> > > On Tue, Apr 07, 2026, David Kaplan wrote:
> > > > Hi,
> > > >
> > > > On AMD SVM when the L1 guest is trying to intercept every PAUSE instruction
> > > > in an L2 guest, the PAUSE intercept sometimes fails to fire.  I have a theory
> > > > on the source of the bug and also included a short reproducer below.
> > > >
> > > > In this scenario, L1 has created a guest with the pause count and threshold
> > > > set to 0, and the PAUSE intercept bit set.  I *think* the bug is that if the
> > > > vCPU gets scheduled out on L0 while we're in the L2 guest, then upon
> > > > resuming the vCPU KVM calls shrink_ple_window() which doesn't appear to take
> > > > into account the fact that svm->vmcb might be for the L2 guest and not the L1.
> > > >
> > > > As a result, it looks like it sets the pause count to the default
> > > > (3000) causing many PAUSE instructions in L2 to not be intercepted.
> > >
> > > It's probably even simpler than that: KVM is completely broken.
> > >
> > > https://lore.kernel.org/all/20250131010601.469904-1-seanjc@google.com
> > >
> > > Paolo, can I finally apply that patch?  I brought it up in PUCK a while back,
> > > and IIRC you were resistant to dropping "support" for cpu_pm=on setups.
> >
> > Interesting.  But does that patch solve my problem?  It looks like it would
> > still call shrink_ple_window even if L2 was scheduled out and change the
> > page_filter_count in vmcb02, if I'm reading it correctly.

Gah, probably not, because KVM does special case the scenario where L1 wants to
intercept PAUSE unconditionally.

	if (kvm_pause_in_guest(svm->vcpu.kvm)) {
		/* use guest values since host doesn't intercept PAUSE */
		vmcb02->control.pause_filter_count = pause_count12;
		vmcb02->control.pause_filter_thresh = pause_thresh12;

	} else {
		/* start from host values otherwise */
		vmcb02->control.pause_filter_count = vmcb01->control.pause_filter_count;
		vmcb02->control.pause_filter_thresh = vmcb01->control.pause_filter_thresh;

		/* ... but ensure filtering is disabled if so requested.  */
		if (vmcb12_is_intercept(vmcb12_ctrl, INTERCEPT_PAUSE)) {  <===========
			if (!pause_count12)
				vmcb02->control.pause_filter_count = 0;
			if (!pause_thresh12)
				vmcb02->control.pause_filter_thresh = 0;
		}
	}

But that's just a bug in my patch, because I very much intended to disable KVM's
PLE shenanigans entirely:

 : Never use L0's (KVM's) PAUSE loop exiting controls while L2 is running,
 : and instead always configure vmcb02 according to L1's exact capabilities
 : and desires.

I just forgot about the shrink case (the grow path should be unreachable).  Does
this fix your setup?  (compile tested only)

---
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Jan 2025 07:48:41 -0800
Subject: [PATCH] KVM: nSVM: Never use L0's PAUSE loop exiting while L2 is
 running

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
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
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

