Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214638889D
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487484; cv=none; b=GACXMvVgTcgmy7f2TJHo53gVd3upS+iyp5eA0Nx2A8tzd0LfQ93jUKPlB2IvGiqr4+4axGPtVLp2N4ORekknO5pPGTrUNiFGpR1uR1b6jHci3cUvgZRCH5D+yxfEzcW2txCdqPHPI0OETnUK6hPxrVyYfyfYjRFMVisnYNbPMXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487484; c=relaxed/simple;
	bh=bhwb5RCXnJQWnrudqbalrymHVAxsdZY75TKYPm/Q+4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZNvxUiTdEBuxqb7EGuWvs3zIal6XgmxUvEJh7vEF6CMpDUvgQ9OfwkWc3+4vk6C+ekhgrtEG76jdqI0CgvM2CkIxneqN7a1CxgR4YOprNLSVoQHr59ADBDEm0fAwnyS0izoYb5f9uS3qZYMuNLmnDo2eAHfXRolLzITMtRT9RC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vs95uO9h; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vs95uO9h"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3663d5e9bf4so7389039a91.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 15:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487482; x=1780092282; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wT6zsNltjTLBvpxwu0pEFWeijmvjnAYH5BlpooJA52s=;
        b=vs95uO9h1dhTC20FeGk1qbVWULQMFfV5AKo+izYf9dTtylOXgG4c+8Iaqd1k7Vp9eh
         kG007U5JilEw/Bx6aFkUqhkXL7+3oMBrBlVM1xcEGxiiIt3+tFtCSI0jZpavImDawWrm
         ObkDfkcEpcAbe8QdSJxemyY/t29X8FuEKLZ8PFEjGh8N3CLjcfhU6rsAqig6nHeiQ0ik
         eAYwP1AGDeVpHGFJzBAxCg7YHtESCkqU1k8jOk1mT7+5t1NSdWwbdbfKm2361W7tT758
         kpjga35H5LcTnzQO69x+L7WnR4Wh7FRMVpRYCjIMJmhf5dZeNa71Ru7QAbhocQ25XkG4
         fKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487482; x=1780092282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wT6zsNltjTLBvpxwu0pEFWeijmvjnAYH5BlpooJA52s=;
        b=AE9Jcc6mGFOTNR3LzFXvybMMhZ28KS3ZeGWYw7blPkiWl5JYwonpcgjj68ujkIAM5+
         sbM9udXDSxvgxBJ176h/cf9JjleIWXJlJP3nfN4rzKzNbx+QiugFpYyNhsia0LfpNty/
         eLOBUBKTV6V4ZhbRFrmkUaxtW6LtIN8weDfzTCQmhg77qKQf7an/olZGq6ndZhglU9wu
         5lYRdlJgLJa2wAoYsHfN0IFQADbZf1dMBYelTk/ImCXDyeyMKmgiFD24OrJoXTWzlNfH
         7Rx9UYppX3+Tyv2vJSvHt6kfS+Wx2l6knAuDWuk17BYsqzCXnmYxfVymMfdRGj13fVS3
         Zwnw==
X-Forwarded-Encrypted: i=1; AFNElJ9bqGEoi99lI66itG6MMPRlgA2LA4mJZGIh1J2keJtVKNtRcOxXM3s0vqcoR359NisXo0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfPwQjSQCE8OdDwBNXFC8aDYN/geQl4qqz5k203SAoBhCKRm50
	c3YhtueZcSWgT4suVoqd785gsZgBvztL0TMocngspyNOJ9Ul5GvCqM912pECl4g1TnZUAjtNDQ9
	wJgMknQ==
X-Received: from pglf31.prod.google.com ([2002:a63:101f:0:b0:c79:8b64:4c6f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6490:b0:39b:87f0:758e
 with SMTP id adf61e73a8af0-3b328c6ad42mr5814194637.8.1779487481631; Fri, 22
 May 2026 15:04:41 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:40 -0700
In-Reply-To: <20260313071033.4153209-3-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313071033.4153209-1-chengkev@google.com> <20260313071033.4153209-3-chengkev@google.com>
Message-ID: <ahDS-DR3-iqYpsdL@google.com>
Subject: Re: [PATCH V3 2/4] KVM: SVM: Fix nested NPF injection to set PFERR_GUEST_{PAGE,FINAL}_MASK
From: Sean Christopherson <seanjc@google.com>
To: Kevin Cheng <chengkev@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yosry@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 13, 2026, Kevin Cheng wrote:
> Fix nested_svm_inject_npf_exit() to correctly set the fault stage bits
> (PFERR_GUEST_PAGE_MASK vs PFERR_GUEST_FINAL_MASK) in exit_info_1 when
> injecting an NPF to L1.
> 
> There are two paths into nested_svm_inject_npf_exit(): hardware NPF
> exits (guest_mmu walker) and emulation-triggered faults (nested_mmu
> walker). For emulation, the nested_mmu walker knows whether the fault
> occurred on a page table page or the final translation, and sets the
> appropriate bit in fault->error_code via paging_tmpl.h. For hardware
> NPF exits, the guest_mmu walker cannot determine this. Only hardware
> knows, via exit_info_1 bits 32-33.
> 
> The old code hardcoded (1ULL << 32) for the emulation path, always
> setting PFERR_GUEST_FINAL_MASK even for page table walk faults. For the
> hardware NPF path, it preserved exit_info_1's upper bits and replaced
> the lower 32 bits with fault->error_code, which was correct but
> convoluted.
> 
> Introduce hardware_nested_page_fault in struct x86_exception to
> distinguish the two paths. For hardware NPF exits, take the fault stage
> bits from exit_info_1. For emulation faults, take them from
> fault->error_code. The lower 32 bits always come from fault->error_code,
> which reflects L1's NPT state (L0's NPT may differ since KVM only
> populates it when the full translation succeeds).

For changelogs, don't give a play-by-play of the code changes, let the patch do
that talking.  Describe the change in conversational language, e.g. minimize
using phrases "via exit_info_1 bits 32-33" and "hardcoded (1ULL << 32)".

    KVM: SVM: Fix nested NPF injection of PFERR_GUEST_{PAGE,FINAL}_MASK bits
    
    Fix KVM's generation of PFERR_GUEST_{PAGE,FINAL}_MASK bits when injecting a
    Nested Page Fault into L1.  Currently, KVM blindly stuffs GUEST_FINAL into
    L1, which is blatantly wrong given that KVM obviously generates NPFs for
    page table accesses.
    
    There are two paths that trigger NPF injection: hardware NPF exits (from
    L2) and emulation-triggered faults, i.e. when KVM detects a NPF as part of
    emulating an L2 GVA access.  For the hardware case, use the bits verbatim
    from the VMCB, as KVM is simply forwarding a NPF to L1.  For the emulation
    case, propagate the GUEST_{PAGE,FINAL} bits from the access field (which
    were recently added for MBEC+GMET support).
    
    To differentiate between the two cases, add "hardware_nested_page_fault"
    to "struct x86_exception", and set it when injecting a NPF in response to
    an NPF exit from L2.
    
    To help guard against future goofs, assert that exactly one of GUEST_PAGE
    or GUEST_FINAL is set when injecting a NPF.  Unlike VMX, there are no
    (known) cases where hardware doesn't set either bit, and KVM should always
    set one or the other when emulating a GVA access.

> Add a WARN_ON_ONCE if exactly one of PFERR_GUEST_FINAL_MASK or
> PFERR_GUEST_PAGE_MASK is not set in the final exit_info_1, as this
> would indicate a bug in the fault handling code.
> 
> Signed-off-by: Kevin Cheng <chengkev@google.com>
> ---

...

> @@ -452,8 +446,12 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>  #endif
>  
>  	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access, &walker->fault);
> -	if (real_gpa == INVALID_GPA)
> +	if (real_gpa == INVALID_GPA) {
> +#if PTTYPE != PTTYPE_EPT
> +		walker->fault.error_code |= PFERR_GUEST_FINAL_MASK;
> +#endif

Now that KVM passes this to kvm_translate_gpa() (see Paolo's MBEC+GMET support),
we can and should handle this when setting the other fault.error_code bits.  It's
not miles better, but I definitely like not duplicating the code.

@@ -548,6 +538,11 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
        walker->fault.nested_page_fault = mmu != vcpu->arch.walk_mmu;
        walker->fault.async_page_fault = false;
 
+#if PTTYPE != PTTYPE_EPT
+       if (walker->fault.nested_page_fault)
+               walker->fault.error_code |= access & PFERR_GUEST_FAULT_STAGE_MASK;
+#endif
+
        trace_kvm_mmu_walker_error(walker->fault.error_code);
        return 0;
 }


>  		return 0;
> +	}
>  
>  	walker->gfn = real_gpa >> PAGE_SHIFT;
>  
> @@ -787,8 +785,10 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>  	 * The page is not mapped by the guest.  Let the guest handle it.
>  	 */
>  	if (!r) {
> -		if (!fault->prefetch)
> +		if (!fault->prefetch) {
> +			walker.fault.hardware_nested_page_fault = walker.fault.nested_page_fault;

Hrm.  When I was debugging test failures (due to changes I made to the tests, and
due to changes from the MBEC+GMET support), one of my theories is that
hardware_nested_page_fault wasn't being initialized.  That wasn't the issue, but
it's still a concern, especially given the crusty nature of the related code
(there are definitely paths that don't initialize the entire structure).

Rather than add a field to x86_exception, we can plumb in a @from_hardware bool
to kvm_inject_emulated_page_fault() and kvm_mmu.inject_page_fault().  That way
there's zero chance of consuming stale data since all of the callers will hardcode
true/false.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 5ff01d2ac85e..62904ec08dda 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -38,19 +38,34 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	struct vmcb *vmcb = svm->vmcb;
> +	u64 fault_stage;
>  
> -	if (vmcb->control.exit_code != SVM_EXIT_NPF) {
> -		/*
> -		 * TODO: track the cause of the nested page fault, and
> -		 * correctly fill in the high bits of exit_info_1.
> -		 */
> -		vmcb->control.exit_code = SVM_EXIT_NPF;
> -		vmcb->control.exit_info_1 = (1ULL << 32);
> -		vmcb->control.exit_info_2 = fault->address;
> -	}
> +	/*
> +	 * For hardware NPF exits, the GUEST_FAULT_STAGE bits are only
> +	 * available in the hardware exit_info_1, since the guest_mmu
> +	 * walker doesn't know whether the faulting GPA was a page table
> +	 * page or final page from L2's perspective.
> +	 */
> +	if (fault->hardware_nested_page_fault)
> +		fault_stage = vmcb->control.exit_info_1 &
> +			      PFERR_GUEST_FAULT_STAGE_MASK;
> +	else
> +		fault_stage = fault->error_code & PFERR_GUEST_FAULT_STAGE_MASK;
> +
> +	vmcb->control.exit_code = SVM_EXIT_NPF;
> +	vmcb->control.exit_info_1 = fault_stage | fault->error_code;

PFERR_GUEST_FAULT_STAGE_MASK should be stripped from fault->error here, otherwise
it could trigger the WARN below due to combining vmcb->control.exit_info_1 with
fault->error_code.

> +	vmcb->control.exit_info_2 = fault->address;
>  
> -	vmcb->control.exit_info_1 &= ~0xffffffffULL;
> -	vmcb->control.exit_info_1 |= fault->error_code;
> +	/*
> +	 * All nested page faults should be annotated as occurring on the
> +	 * final translation *or* the page walk. Arbitrarily choose "final"
> +	 * if KVM is buggy and enumerated both or neither.
> +	 */
> +	if (WARN_ON_ONCE(hweight64(vmcb->control.exit_info_1 &
> +				   PFERR_GUEST_FAULT_STAGE_MASK) != 1)) {
> +		vmcb->control.exit_info_1 &= ~PFERR_GUEST_FAULT_STAGE_MASK;
> +		vmcb->control.exit_info_1 |= PFERR_GUEST_FINAL_MASK;

And then hoist this up and operate on fault_stage.  Then there's no need to clear
anything because fault_stage can simply be overwritten.

	/*
	 * For hardware NPF exits, the GUEST_FAULT_STAGE bits are only
	 * available in the hardware exit_info_1, since the guest_mmu
	 * walker doesn't know whether the faulting GPA was a page table
	 * page or final page from L2's perspective.
	 */
	if (from_hardware)
		fault_stage = vmcb->control.exit_info_1 &
			      PFERR_GUEST_FAULT_STAGE_MASK;
	else
		fault_stage = fault->error_code & PFERR_GUEST_FAULT_STAGE_MASK;

	/*
	 * All nested page faults should be annotated as occurring on the
	 * final translation *or* the page walk. Arbitrarily choose "final"
	 * if KVM is buggy and enumerated both or neither.
	 */
	if (WARN_ON_ONCE(hweight64(fault_stage) != 1))
		fault_stage = PFERR_GUEST_FINAL_MASK;

	vmcb->control.exit_code = SVM_EXIT_NPF;
	vmcb->control.exit_info_1 = fault_stage |
				    (fault->error_code & ~PFERR_GUEST_FAULT_STAGE_MASK);
	vmcb->control.exit_info_2 = fault->address;

> +	}
>  
>  	nested_svm_vmexit(svm);
>  }
> -- 
> 2.53.0.851.ga537e3e6e9-goog
> 
