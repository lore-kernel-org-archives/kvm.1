Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDBB33B969
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293483; cv=none; b=BWBX63nrTQSv9XUn4bNZX5nhaVzSqq6ufLTq2AKaSJ2LXtYM/UUwS+eZPC8o8ELK+hA6GsEgd7b8awZnmT4Rp7mue7QCMXgK7yy22+g51nz1SsHu2IN2omxIipSgK+jkLCwxFOWoVv/EQ7u968M9zCYD20hkKn8+kG0w4QHEI3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293483; c=relaxed/simple;
	bh=XvotjJdaksbDz01vA1sqF9jg8miawKFVp38hlIBRhu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GbY+ju5zBcFMsAAYC3yrDb1SOp/lljSjAAjYVWvTBLCH2pK5UZnYdhrCmSiNXrKgQ5uAfgEnK1d6q0I0beGDvL5KgRid1J5vPE+dztdhkL/IRB/KkZnQuLR+rN/a1ycYYuZ0ZCxMf0DEPaMy6EW5Oua+OcylJMTq9RJ+Yn+2l2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pptdlc+i; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pptdlc+i"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36641fe4aedso9855473a91.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779293481; x=1779898281; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPzBgFyVXTp/ZhGdi1mcM6qJLFUYx43ukQw57F4/Pr0=;
        b=Pptdlc+i8d412z1EtrozXe+VTh7ME1Hdi2FmORuBZ46BL53WCcVGrOk6yJA20qC3iD
         FJNWSuHNoW8FLfTOvPk4IoVNDarWBA2Da9tztI3xkNzLkbs1xBVgMBMe5z5fuFP5o09A
         hucAcjpWo5D+vFZ9vtV9Zu7Vjp+vcAoTVmUpVFrvTqMZxUo+u3AEYnJ8uZvxDL/tme/d
         tLTydvnUu/lWcGoQImclD3DM1gUbXYaTu07pjSBg4A/fQikhFoe+OElTZcGMXB2cbdyy
         ZxIvYT9pZAwzwFB8ir8uggkJSxRvKxrwlIL2lZTeY/M85SwxL3i0wIoSTaz1RLsuXstu
         n7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779293481; x=1779898281;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPzBgFyVXTp/ZhGdi1mcM6qJLFUYx43ukQw57F4/Pr0=;
        b=jRp8S5sH776HLowUPobKdX+3hTDpxTWiiX8ZUuMIn0NVM0/5E+OyHHmthzfWam14am
         RCCo/7BSrP1/gcbEhVSFvsL5FebGFI6JhgCTC9PH1gFwh9pxxIAB14nhZHXIFUP0TY8R
         +6tyM5OCNI3HEU0RMTrjoArV0Vop6CptduD55VGbyGt6fk/f4VYUbg9t0FO1nSldhH2w
         +NkEFgH9v6CYHRczh+XYGXia9kGX2u8oIZNwJ54PPxU1PXcvarCnNvjV/o6tcaPX2qCV
         hMjxu1wXp93alxq4joLuiaa2Np6CYf6OT+NE/a9RDb3zX+j9w1c54Dli7Ou5Lh5kJ2Rs
         b1gw==
X-Forwarded-Encrypted: i=1; AFNElJ9lZGn6Io+fknXMYYHOHCV62FwmJ5DbbIUYB8wxo7yX2DVsqEknyJ1c7ZTFEmNUbgovShA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQVrGwBWkavQT148HY8oWc3ilbkrT/Pmg9tafUB1Id7jYy0kUv
	ICGD9RVNSBlcWSafdgJwl6UIYxNnGZ8rmuXprgder3GSyPPouWhPN+528u0xxa0WO6tW0BJRM5B
	Nw2AnXg==
X-Received: from pgbfy22.prod.google.com ([2002:a05:6a02:2a96:b0:c82:7c27:98a8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d9e:b0:39b:9644:6e93
 with SMTP id adf61e73a8af0-3b22e7add1cmr28600713637.6.1779293481198; Wed, 20
 May 2026 09:11:21 -0700 (PDT)
Date: Wed, 20 May 2026 09:11:20 -0700
In-Reply-To: <20260515222638.1949982-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515222638.1949982-1-seanjc@google.com> <20260515222638.1949982-2-seanjc@google.com>
Message-ID: <ag3dKPXqPTReuLOE@google.com>
Subject: Re: [PATCH v3 01/10] KVM: VMX: Refresh GUEST_PENDING_DBG_EXCEPTIONS.BS
 on all injected #DBs
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 15, 2026, Sean Christopherson wrote:
> Move KVM's stuffing of GUEST_PENDING_DBG_EXCEPTIONS.BS when RFLAGS.TF=1 and
> MOV/POP SS or STI blocking is active into the exception injection code so
> that KVM fixes up the VMCS for all injected #DBs, not only those that are
> reflected back into the guest after #DB interception.  E.g. if KVM queues
> a #DB in the emulator, or more importantly if userspace does save/restore
> exactly on the #DB+shadow boundary, then KVM needs to massage the VMCS to
> avoid the VM-Entry consistency check.
> 
> Opportunistically update the wording of the comment to describe the
> behavior as a workaround of flawed CPU behavior/architecture, to make it
> clear that the *only* thing KVM is doing is fudging around a consistency
> check.  Per the SDM:
> 
>   There are no pending debug exceptions after VM entry if any of the
>   following are true:
> 
>     * The VM entry is vectoring with one of the following interruption
>       types: external interrupt, non-maskable interrupt (NMI), hardware
>       exception, or privileged software exception.
> 
> I.e. forcing GUEST_PENDING_DBG_EXCEPTIONS.BS does *not* impact guest-
> visible behavior.
> 
> Fixes: b9bed78e2fa9 ("KVM: VMX: Set vmcs.PENDING_DBG.BS on #DB in STI/MOVSS blocking shadow")
> Cc: stable@vger.kernel.org
> Reported-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> Closes: https://lore.kernel.org/all/b1a294bc9ed4dae532474a5dc6c8cb6e5962de7c.1757416809.git.houwenlong.hwl@antgroup.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 1701db1b2e18..a0a0ccf342d3 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1909,6 +1909,24 @@ void vmx_inject_exception(struct kvm_vcpu *vcpu)
>  	u32 intr_info = ex->vector | INTR_INFO_VALID_MASK;
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  
> +	/*
> +	 * When injecting a #DB, single-stepping is enabled in RFLAGS, and STI
> +	 * or MOV-SS blocking is active, set vmcs.PENDING_DBG_EXCEPTIONS.BS to
> +	 * prevent a false positive from VM-Entry consistency check.  VM-Entry
> +	 * asserts that a single-step #DB _must_ be pending in this scenario,
> +	 * as the previous instruction cannot have toggled RFLAGS.TF 0=>1
> +	 * (because STI and POP/MOV don't modify RFLAGS), therefore the one
> +	 * instruction delay when activating single-step breakpoints must have
> +	 * already expired.  However, the CPU isn't smart enough to peek at
> +	 * vmcs.VM_ENTRY_INTR_INFO_FIELD and so doesn't realize that yes, there
> +	 * is indeed a #DB pending/imminent.
> +	 */
> +	if (ex->vector == DB_VECTOR &&
> +	    (vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
> +	    vmx_get_interrupt_shadow(vcpu))
> +		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
> +			    vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);

Pulling in a Sashiko comment:

 : By restricting this workaround to only when a #DB is injected, does this
 : leave the VM vulnerable to a VM-Entry failure regression after live migration?
 : 
 : KVM does not export GUEST_PENDING_DBG_EXCEPTIONS to userspace via
 : KVM_GET_VCPU_EVENTS. Therefore, upon migration, the destination KVM
 : initializes the VMCS with GUEST_PENDING_DBG_EXCEPTIONS=0.
 : 
 : If a live migration occurs when the guest is in an active interrupt shadow
 : with RFLAGS.TF=1, but a different event is pending (or no event is pending
 : due to a host timer preemption), this DB_VECTOR check is skipped or
 : vmx_inject_exception() is never called.
 : 
 : Consequently, KVM will attempt VM-Entry with TF=1, shadow=1, and BS=0.
 : The Intel SDM mandates that if RFLAGS.TF=1 and STI or MOV SS blocking is
 : active, the VM-Entry consistency check requires
 : GUEST_PENDING_DBG_EXCEPTIONS.BS=1. The hardware VM-Entry will fail due to
 : invalid guest state.
 : 
 : Since vmx_guest_state_valid() does not check the GUEST_PENDING_DBG_EXCEPTIONS
 : field, KVM's emulation_required flag evaluates to false. KVM then falls
 : into the error path in __vmx_handle_exit(), dumping the VMCS and crashing
 : the guest by returning KVM_EXIT_FAIL_ENTRY to userspace.
 : 
 : Does KVM need to handle the BS bit requirement in a broader context to
 : account for live migration when no #DB is being injected?

Yes, but that's a different problem entirely[*], and isn't even solvable on AMD
because SVM lacks an equivalent for GUEST_PENDING_DBG_EXCEPTIONS.  Note, only
MOV/POP-SS blocking matters, because STI blocking doesn't prevent single-step
#DBs, and single-step #DBs have higher priority than IRQs.

[*] https://lore.kernel.org/all/agUgeO5QNenQM9pT@google.com
