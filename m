Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86FE339387
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114315; cv=none; b=HRjqo1a+kO7jlJFyLNSTNOCcc/OsmuLtpclOeOLtrYNVrHrhJjFZBscMEHLRY/qZBaLPugi8ImPtKSrYhoi7Wp09Uo4QqkuAWYXpx5WnN22/+pfgRyl3zBSl5/njn1XPmtYSa2Sj9iFNiOxkpMhKfU0sNMKGUO+/H4kz+Jkr7sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114315; c=relaxed/simple;
	bh=VYsTJgxpuTiMAdsEeVMomrXPwF2OYzGjV9xmmbZE6fs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=urHzy6IYDp8NZCUqaqn5Gx1b7Cm9CAT56hHsyECGTBwI37pB7dHzq+mYG4MGXJ33rwuzXrmuW04InLat2Q3B4vwY1W2scXCp3bvwjVv73YiZTCRfrQ2nce5iEH3QqqOBDQ93vcqzk4/A5j0+JAgiwTasR+pMCN0MFoMGvpJo5Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvQ4TRkM; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvQ4TRkM"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f5ac7354dso5031511a91.1
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786114312; x=1786719112; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bcha81M8/iIIMZssl7ipKuZecBT4SgONvRnxmuYhcFE=;
        b=bvQ4TRkMyukZI+BkBVa9HQL9PhTuUNfyXT2gwTivJWF3gOFaa6svja0BL4WQbcTj7F
         35fCRcZUpFOB2zshZFa5j23l/YfM2qVnPMoaTxdnbDmz9e44uRdNSw519p8anIeQrVLC
         aPY0+sSMhh/ybs+TDZra20V4uoKcp1Er5In9jf+Y39chmX/176LwgL86jBGbLHHSzxXy
         P0a5+tavYhrrrKEB10ETUhpO9iII8oWOXdopii6DYi7JnWbno0ofQaA7Gx3a2XS/5vxo
         9FAM09eCYY3J/kUhxSnTWcoA498ZyfAfZ0aR2AOmiGOmtmvlPY2lQb8K+fA+a7bP19JQ
         gBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786114312; x=1786719112;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bcha81M8/iIIMZssl7ipKuZecBT4SgONvRnxmuYhcFE=;
        b=fCkQwIAuiVx+T2ujdcq9J1YIZ6zP/yb0+YZBqOakauAvWlTQYQMMEfTOa9r7gmrlbQ
         Xl9/TwMBmeVHVGdJ5rFaDWFNB7Bvt3jdcouEfipXRZE9sz8Z80Q8LUt8jEfYX02C62FN
         LMr9X65OFSNa1WoKQb4PFwzbtN6vuRb09d2EnQB35+9poKPCckFlQZhyRx4K0hXpZPmc
         CFORliMWLEjOEoyKsSwMu+4BuDu/UpaV7YGbBwD5inRp3oLbLU1jjp7MIzCqW54xeEJ5
         JM5dMS3Dn5yJWryPmdewywuiDwvI0GyvqwdhsJtHWOAU6c5P4bZOYubZ9FR4kkHs+LWJ
         0VCQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmgxuqN/pABHd/WKk8IPDxssXPGr6zm5McNCO9CbYHFZwvsAAqQT+fxBENb4PWxTuQ7+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC8aPDztT68VUlrFdy9xxhvGZ4KikwHBC/sr8G5c8GnCVwIDmy
	NJXQRlgXasOuY+fO5hz3xYYAC46IB+8LHbLQWoRFwJi44TeT3cOJ77RSSddCT/TA1tBIHuKCZeN
	xxb+vvA==
X-Received: from pjbqb12.prod.google.com ([2002:a17:90b:280c:b0:38f:2874:84ed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d02:b0:37f:fdc8:71b4
 with SMTP id 98e67ed59e1d1-3903c599356mr23835973a91.2.1786114311806; Fri, 07
 Aug 2026 07:51:51 -0700 (PDT)
Date: Fri, 7 Aug 2026 07:51:51 -0700
In-Reply-To: <e606195a-6adf-412f-8b0b-4b3ca7b1ad0a@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
 <20260805031257.1844914-3-xiaoyao.li@intel.com> <20260805034602.5B2BB1F000E9@smtp.kernel.org>
 <4fedcaa6-d710-48f8-84c4-de682350bb2f@intel.com> <anNPAXShf1gjDdeu@google.com>
 <e606195a-6adf-412f-8b0b-4b3ca7b1ad0a@intel.com>
Message-ID: <anXxBzO41_5eaaOI@google.com>
Subject: Re: [PATCH 2/2] KVM: TDX: Enable Bus Lock VM exit
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 06, 2026, Xiaoyao Li wrote:
> On 8/5/2026 10:56 PM, Sean Christopherson wrote:
> > On Wed, Aug 05, 2026, Xiaoyao Li wrote:
> > > On 8/5/2026 11:46 AM, sashiko-bot@kernel.org wrote:
> > > > This also appears to affect tdx_to_vmx_exit_reason(), where comparing the raw
> > > > exit reason directly against 16-bit constants like EXIT_REASON_TDCALL will
> > > > fail to match if the bus lock bit is set, leading to incorrect emulation.
> > > 
> > > This is valid. We need to adjust tdx_to_vmx_exit_reason().
> > > 
> > > However, there is a more important problem. Since Bus Lock VM exit makes bit
> > > 26 possible in EXIT REASON, the trick of "return -1" in
> > > tdx_to_vmx_exit_reason() will introduce false-positive in the following
> > > check of if(vmx_get_exit_reason(vcpu).bus_lock_detected) added by this
> > > patch.
> > > 
> > > how about something like below:
> > 
> > Way too subtle.  tdx_to_vmx_exit_reason() should return the actual union, not a
> > raw u32, otherwise it's going to be extremely difficult to avoid reintroducing
> > similar bugs.
> > 
> > And looking at this all again, we should change the handling of actual
> > EXIT_REASON_EPT_MISCONFIG exits.  Stuffing a bogus value into the exit_reason
> > is "fine", but as Sashiko points out, it's extremely brittle.  Rather than
> > stuff the exit reason, we should stuff the status to signal TDX_SW_ERROR.
> > 
> > And to do that without introducing more fragility, we should flag the raw
> > vp_enter_ret as "unsafe", and explicitly track vp_enter_status.  I.e. separate
> > the status from the exit_reason immediately after VP.ENTER, instead of mixing
> > and matching the two concepts.
> > 
> > The fastpath "handler" is also all kinds of messed up.  KVM fails to trace_kvm_exit()
> > EPT misconfigs and software errors; even though the exit reason is undefined, it
> > should still be captured in the trace, otherwise it's a huge blindspot.  And AFAICT,
> > OPERAND_BUSY should be mutually exclusive with actual VM-Entry failures, so manually
> > checking for VM-Entry failure is completely unnecessary, just handle OPERAND_BUSY.
> > If TDX ever gains fastpath handlers, then we can add a true fastpath handler at
> > that time.  But OPERAND_BUSY should be a "never do the fastpath", because AIUI,
> > VM-Enter wasn't attempted, i.e. there's nothing to handle.
> > 
> > Compile tested only, and it should be chunked over several patches, but this?
> 
> Basically, it looks good except some nits.
> 
> I'll try to split into a formal sereis. Please let me know if you want to do
> if yourself.

All you.

> > -	if (unlikely(vp_enter_ret == EXIT_REASON_EPT_MISCONFIG)) {
> > -		KVM_BUG_ON(1, vcpu->kvm);
> > +	if (KVM_BUG_ON(exit_reason.basic == EXIT_REASON_EPT_MISCONFIG, vcpu->kvm))
> 
> We need to check tdx->vp_enter_ret__unsafe instead of exit_reason becase
> tdcall_to_vmx_exit_reason() translates TDVMCALL(EXIT_REASON_EPT_VIOLATION)
> from guest to EXIT_REASON_EPT_MISCONFIG

Ah shoot.  I actually handled that, but apparently I failed to refresh my
copy+paste.  Phew, I still have the local commit.  This is what I intended:

	/*
	 * Handle TDX SW errors, including TDX_SEAMCALL_UD, TDX_SEAMCALL_GP and
	 * TDX_SEAMCALL_VMFAILINVALID.
	 */
	if (unlikely((tdx->vp_enter_status & TDX_SW_ERROR) == TDX_SW_ERROR)) {
		/* Actual EPT Misconfigs are *always* KVM/kernel bugs. */
		if (KVM_BUG_ON(exit_reason.basic == EXIT_REASON_EPT_MISCONFIG, vcpu->kvm))
			return -EIO;

		KVM_BUG_ON(!virt_rebooting, vcpu->kvm);
		goto unhandled_exit;
	}

It pairs with a change in tdx_to_vmx_exit_reason(), renamed to tdx_process_vp_enter_return(),
to force the status to TDX_SW_ERROR.  That's another motivation for separately
tracking the status: KVM can clobber it without losing the original exit info.


	case EXIT_REASON_EPT_MISCONFIG:
		/*
		 * Actual EPT Misconfigs are KVM/kernel software bugs.  Set the
		 * status accordingly to differentiate from emulated MMIO exits.
		 */
		tdx->vp_enter_status = TDX_SW_ERROR;
		break;

Full diff at the bottom.

> <...>
> > diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
> > index ac8323a68b16..5564617fc12a 100644
> > --- a/arch/x86/kvm/vmx/tdx.h
> > +++ b/arch/x86/kvm/vmx/tdx.h
> > @@ -66,7 +66,12 @@ struct vcpu_tdx {
> >   	struct list_head cpu_list;
> > -	u64 vp_enter_ret;
> > +	/*
> > +	 * Discourage direct use of the raw VP.ENTER return value, as there are
> > +	 * several subtleties that need to be accounted for when working with
> > +	 * the raw value.
> > +	 */
> > +	u64 HINT_UNSAFE_IN_KVM(vp_enter_ret);
> 
> So the purpose is forcing people to think twice when using it because they
> see "__unsafe"? Maybe it's more for the reviewers and maintainers.

Not just think twice, but actively make it more difficult to use the field.  E.g.
trying to copy+paste vp_enter_ret directly will fail as there is no such field.
In the unlikely scenario that people insist on bypassing the protection, I'm sure
we could come up with an even fancier HINT_UNSAFE_IN_KVM() implementation to make
it more onerous to use the raw variable, but I don't expect that to be a problem.

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a7..89b9e4322151 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -921,12 +921,16 @@ static __always_inline u32 tdcall_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 	return EXIT_REASON_TDCALL;
 }
 
-static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
+static __always_inline union vmx_exit_reason tdx_process_vp_enter_return(struct kvm_vcpu *vcpu,
+									 u64 vp_enter_ret)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
-	u32 exit_reason;
+	union vmx_exit_reason exit_reason;
 
-	switch (tdx->vp_enter_ret & TDX_SEAMCALL_STATUS_MASK) {
+	tdx->vp_enter_ret__unsafe = vp_enter_ret;
+	tdx->vp_enter_status = vp_enter_ret & TDX_SEAMCALL_STATUS_MASK;
+
+	switch (tdx->vp_enter_status) {
 	case TDX_SUCCESS:
 	case TDX_NON_RECOVERABLE_VCPU:
 	case TDX_NON_RECOVERABLE_TD:
@@ -934,23 +938,32 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 	case TDX_NON_RECOVERABLE_TD_WRONG_APIC_MODE:
 		break;
 	default:
-		return -1u;
+		/*
+		 * Synthesize an invalid bogus Exit Reason, as the TDX-Module
+		 * never attempted to run the vCPU, i.e. the Exit Reason is
+		 * undefined, but this is NOT a failed VM-Enter.
+		 */
+		return (union vmx_exit_reason) {
+			.basic = -1,
+		};
 	}
 
-	exit_reason = tdx->vp_enter_ret;
+	exit_reason.full = (u32)vp_enter_ret;
 
-	switch (exit_reason) {
+	switch (exit_reason.basic) {
 	case EXIT_REASON_TDCALL:
 		if (tdvmcall_exit_type(vcpu))
-			return EXIT_REASON_VMCALL;
-
-		return tdcall_to_vmx_exit_reason(vcpu);
+			exit_reason.basic = EXIT_REASON_VMCALL;
+		else
+			exit_reason.basic = tdcall_to_vmx_exit_reason(vcpu);
+		break;
 	case EXIT_REASON_EPT_MISCONFIG:
 		/*
-		 * Defer KVM_BUG_ON() until tdx_handle_exit() because this is in
-		 * non-instrumentable code with interrupts disabled.
+		 * Actual EPT Misconfigs are KVM/kernel software bugs.  Set the
+		 * status accordingly to differentiate from emulated MMIO exits.
 		 */
-		return -1u;
+		tdx->vp_enter_status = TDX_SW_ERROR;
+		break;
 	default:
 		break;
 	}
@@ -962,12 +975,13 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	struct vcpu_vt *vt = to_vt(vcpu);
+	u64 ret;
 
 	guest_state_enter_irqoff();
 
-	tdx->vp_enter_ret = tdh_vp_enter(&tdx->vp, &tdx->vp_enter_args);
+	ret = tdh_vp_enter(&tdx->vp, &tdx->vp_enter_args);
 
-	vt->exit_reason.full = tdx_to_vmx_exit_reason(vcpu);
+	vt->exit_reason = tdx_process_vp_enter_return(vcpu, ret);
 
 	vt->exit_qualification = tdx->vp_enter_args.rcx;
 	tdx->ext_exit_qualification = tdx->vp_enter_args.rdx;
@@ -979,33 +993,6 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 	guest_state_exit_irqoff();
 }
 
-static bool tdx_failed_vmentry(struct kvm_vcpu *vcpu)
-{
-	return vmx_get_exit_reason(vcpu).failed_vmentry &&
-	       vmx_get_exit_reason(vcpu).full != -1u;
-}
-
-static fastpath_t tdx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
-{
-	u64 vp_enter_ret = to_tdx(vcpu)->vp_enter_ret;
-
-	/*
-	 * TDX_OPERAND_BUSY could be returned for SEPT due to 0-step mitigation
-	 * or for TD EPOCH due to contention with TDH.MEM.TRACK on TDH.VP.ENTER.
-	 *
-	 * When KVM requests KVM_REQ_OUTSIDE_GUEST_MODE, which has both
-	 * KVM_REQUEST_WAIT and KVM_REQUEST_NO_ACTION set, it requires target
-	 * vCPUs leaving fastpath so that interrupt can be enabled to ensure the
-	 * IPIs can be delivered. Return EXIT_FASTPATH_EXIT_HANDLED instead of
-	 * EXIT_FASTPATH_REENTER_GUEST to exit fastpath, otherwise, the
-	 * requester may be blocked endlessly.
-	 */
-	if (unlikely(tdx_operand_busy(vp_enter_ret)))
-		return EXIT_FASTPATH_EXIT_HANDLED;
-
-	return EXIT_FASTPATH_NONE;
-}
-
 #define TDX_REGS_AVAIL_SET	(BIT(VCPU_REG_EXIT_INFO_1) | \
 				 BIT(VCPU_REG_EXIT_INFO_2) | \
 				 BIT(VCPU_REGS_RAX) | \
@@ -1093,18 +1080,23 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	kvm_clear_available_registers(vcpu, ~TDX_REGS_AVAIL_SET);
 
-	if (unlikely(tdx->vp_enter_ret == EXIT_REASON_EPT_MISCONFIG))
-		return EXIT_FASTPATH_NONE;
-
-	if (unlikely((tdx->vp_enter_ret & TDX_SW_ERROR) == TDX_SW_ERROR))
-		return EXIT_FASTPATH_NONE;
-
 	trace_kvm_exit(vcpu, KVM_ISA_VMX);
 
-	if (unlikely(tdx_failed_vmentry(vcpu)))
-		return EXIT_FASTPATH_NONE;
+	/*
+	 * TDX_OPERAND_BUSY could be returned for SEPT due to 0-step mitigation
+	 * or for TD EPOCH due to contention with TDH.MEM.TRACK on TDH.VP.ENTER.
+	 *
+	 * When KVM requests KVM_REQ_OUTSIDE_GUEST_MODE, which has both
+	 * KVM_REQUEST_WAIT and KVM_REQUEST_NO_ACTION set, it requires target
+	 * vCPUs leaving fastpath so that interrupt can be enabled to ensure the
+	 * IPIs can be delivered. Return EXIT_FASTPATH_EXIT_HANDLED instead of
+	 * EXIT_FASTPATH_REENTER_GUEST to exit fastpath, otherwise, the
+	 * requester may be blocked endlessly.
+	 */
+	if (unlikely(tdx_operand_busy(tdx->vp_enter_status)))
+		return EXIT_FASTPATH_EXIT_HANDLED;
 
-	return tdx_exit_handlers_fastpath(vcpu);
+	return EXIT_FASTPATH_NONE;
 }
 
 void tdx_inject_nmi(struct kvm_vcpu *vcpu)
@@ -1300,7 +1292,7 @@ static int tdx_report_fatal_error(struct kvm_vcpu *vcpu)
 	vcpu->run->system_event.ndata = 16;
 
 	/* Dump 16 general-purpose registers to userspace in ascending order. */
-	regs[index++] = tdx->vp_enter_ret;
+	regs[index++] = tdx->vp_enter_ret__unsafe;
 	regs[index++] = tdx->vp_enter_args.rcx;
 	regs[index++] = tdx->vp_enter_args.rdx;
 	regs[index++] = tdx->vp_enter_args.rbx;
@@ -2030,48 +2022,44 @@ int tdx_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 
 int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 {
-	struct vcpu_tdx *tdx = to_tdx(vcpu);
-	u64 vp_enter_ret = tdx->vp_enter_ret;
 	union vmx_exit_reason exit_reason = vmx_get_exit_reason(vcpu);
+	struct vcpu_tdx *tdx = to_tdx(vcpu);
 
 	if (fastpath != EXIT_FASTPATH_NONE)
 		return 1;
 
-	if (unlikely(vp_enter_ret == EXIT_REASON_EPT_MISCONFIG)) {
-		KVM_BUG_ON(1, vcpu->kvm);
-		return -EIO;
-	}
-
 	/*
 	 * Handle TDX SW errors, including TDX_SEAMCALL_UD, TDX_SEAMCALL_GP and
 	 * TDX_SEAMCALL_VMFAILINVALID.
 	 */
-	if (unlikely((vp_enter_ret & TDX_SW_ERROR) == TDX_SW_ERROR)) {
+	if (unlikely((tdx->vp_enter_status & TDX_SW_ERROR) == TDX_SW_ERROR)) {
+		/* Actual EPT Misconfigs are *always* KVM/kernel bugs. */
+		if (KVM_BUG_ON(exit_reason.basic == EXIT_REASON_EPT_MISCONFIG, vcpu->kvm))
+			return -EIO;
+
 		KVM_BUG_ON(!virt_rebooting, vcpu->kvm);
 		goto unhandled_exit;
 	}
 
-	if (unlikely(tdx_failed_vmentry(vcpu))) {
+	if (unlikely(exit_reason.failed_vmentry)) {
 		/*
 		 * If the guest state is protected, that means off-TD debug is
 		 * not enabled, TDX_NON_RECOVERABLE must be set.
 		 */
 		WARN_ON_ONCE(vcpu->arch.guest_state_protected &&
-				!(vp_enter_ret & TDX_NON_RECOVERABLE));
+			     !(tdx->vp_enter_status & TDX_NON_RECOVERABLE));
 		vcpu->run->exit_reason = KVM_EXIT_FAIL_ENTRY;
 		vcpu->run->fail_entry.hardware_entry_failure_reason = exit_reason.full;
 		vcpu->run->fail_entry.cpu = vcpu->arch.last_vmentry_cpu;
 		return 0;
 	}
 
-	if (unlikely(vp_enter_ret & (TDX_ERROR | TDX_NON_RECOVERABLE)) &&
-		exit_reason.basic != EXIT_REASON_TRIPLE_FAULT) {
-		kvm_pr_unimpl("TD vp_enter_ret 0x%llx\n", vp_enter_ret);
+	if (unlikely(tdx->vp_enter_status & (TDX_ERROR | TDX_NON_RECOVERABLE)) &&
+	    exit_reason.basic != EXIT_REASON_TRIPLE_FAULT)
 		goto unhandled_exit;
-	}
 
-	WARN_ON_ONCE(exit_reason.basic != EXIT_REASON_TRIPLE_FAULT &&
-		     (vp_enter_ret & TDX_SEAMCALL_STATUS_MASK) != TDX_SUCCESS);
+	WARN_ON_ONCE(tdx->vp_enter_status != TDX_SUCCESS &&
+		     exit_reason.basic != EXIT_REASON_TRIPLE_FAULT);
 
 	switch (exit_reason.basic) {
 	case EXIT_REASON_TRIPLE_FAULT:
@@ -2131,7 +2119,8 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 	}
 
 unhandled_exit:
-	kvm_prepare_unexpected_reason_exit(vcpu, vp_enter_ret);
+	kvm_pr_unimpl("TD vp_enter_ret 0x%llx\n", tdx->vp_enter_ret__unsafe);
+	kvm_prepare_unexpected_reason_exit(vcpu, tdx->vp_enter_ret__unsafe);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index ac8323a68b16..472fe9a3e4ec 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -66,7 +66,13 @@ struct vcpu_tdx {
 
 	struct list_head cpu_list;
 
-	u64 vp_enter_ret;
+	/*
+	 * Discourage use of the raw VP.ENTER return value, it should only be
+	 * used to report errors to userspace, as there are several subtleties
+	 * that need to be accounted for when working with the raw value.
+	 */
+	u64 HINT_UNSAFE_IN_KVM(vp_enter_ret);
+	u64 vp_enter_status;
 
 	enum vcpu_tdx_state state;
 
