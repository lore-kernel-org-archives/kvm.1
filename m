Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F63A5452;
	Thu, 21 May 2026 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366810; cv=none; b=EoVszKhuSUP3z9XqMBgwRpxTYfFbp+2Uh7BN9lEQrJUAbXKHlVV+QJ62CuBdv4fvuQGjZyoUJW70jpP0tZHFUsIF16HCPRQmBwOy/+EFoo233qq/EJM4agVcrbja7UDee3IPQxeiQTUfccxXXHPQHI0BKgUdeokC/LQI9KZeEaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366810; c=relaxed/simple;
	bh=wm5kKA6unI/coX+VSaFghpxoyxjKEGE1e4af/nM4w7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhV5Y4fqT5s1XGzhQ37oV30pFCVuU6sWtNgBjT9Juv/3ZjKrbFFrxHt13qDGM+t3vcoTYvW61GNtNTuataRQyrDaoNLLZ/gQDg9YJtr6jgS2JnhyU7Ymx+0ImhbkuHfJqJ5P/WyjlpKa9sP3qgBI7zxoutqy9iRvC+3IcCqZpKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=fGh6WfVX; arc=none smtp.client-ip=115.124.28.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="fGh6WfVX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1779366795; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=TUQOpx80QeV28tI3NzfFrn9g/OFKMXFJ4t++ZPTUrm8=;
	b=fGh6WfVXvAce+53BwEtOhi97GymYjw1yoqmhXIReG8rz4iCLVvmsQas+C25bpnXP3RfagsvmJ2Y3YEyh8zCXspba2tQnSjO5mymv7255dZ4OPCIh62BDeoREHWM2fKSqdYQ5tU6b90vNV+2wKs/Z/kzUazRO+AWhbhH92Y4IlP0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---.hd6Kzav_1779366794;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.hd6Kzav_1779366794 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 21 May 2026 20:33:14 +0800
Date: Thu, 21 May 2026 20:33:14 +0800
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH v3 01/10] KVM: VMX: Refresh
 GUEST_PENDING_DBG_EXCEPTIONS.BS on all injected #DBs
Message-ID: <20260521123314.GA24720@k08j02272.eu95sqa>
References: <20260515222638.1949982-1-seanjc@google.com>
 <20260515222638.1949982-2-seanjc@google.com>
 <ag3dKPXqPTReuLOE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag3dKPXqPTReuLOE@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 20, 2026 at 09:11:20AM -0700, Sean Christopherson wrote:
> On Fri, May 15, 2026, Sean Christopherson wrote:
> > Move KVM's stuffing of GUEST_PENDING_DBG_EXCEPTIONS.BS when RFLAGS.TF=1 and
> > MOV/POP SS or STI blocking is active into the exception injection code so
> > that KVM fixes up the VMCS for all injected #DBs, not only those that are
> > reflected back into the guest after #DB interception.  E.g. if KVM queues
> > a #DB in the emulator, or more importantly if userspace does save/restore
> > exactly on the #DB+shadow boundary, then KVM needs to massage the VMCS to
> > avoid the VM-Entry consistency check.
> > 
> > Opportunistically update the wording of the comment to describe the
> > behavior as a workaround of flawed CPU behavior/architecture, to make it
> > clear that the *only* thing KVM is doing is fudging around a consistency
> > check.  Per the SDM:
> > 
> >   There are no pending debug exceptions after VM entry if any of the
> >   following are true:
> > 
> >     * The VM entry is vectoring with one of the following interruption
> >       types: external interrupt, non-maskable interrupt (NMI), hardware
> >       exception, or privileged software exception.
> > 
> > I.e. forcing GUEST_PENDING_DBG_EXCEPTIONS.BS does *not* impact guest-
> > visible behavior.
> > 
> > Fixes: b9bed78e2fa9 ("KVM: VMX: Set vmcs.PENDING_DBG.BS on #DB in STI/MOVSS blocking shadow")
> > Cc: stable@vger.kernel.org
> > Reported-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > Closes: https://lore.kernel.org/all/b1a294bc9ed4dae532474a5dc6c8cb6e5962de7c.1757416809.git.houwenlong.hwl@antgroup.com
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/vmx/vmx.c | 35 ++++++++++++++++++-----------------
> >  1 file changed, 18 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 1701db1b2e18..a0a0ccf342d3 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -1909,6 +1909,24 @@ void vmx_inject_exception(struct kvm_vcpu *vcpu)
> >  	u32 intr_info = ex->vector | INTR_INFO_VALID_MASK;
> >  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> >  
> > +	/*
> > +	 * When injecting a #DB, single-stepping is enabled in RFLAGS, and STI
> > +	 * or MOV-SS blocking is active, set vmcs.PENDING_DBG_EXCEPTIONS.BS to
> > +	 * prevent a false positive from VM-Entry consistency check.  VM-Entry
> > +	 * asserts that a single-step #DB _must_ be pending in this scenario,
> > +	 * as the previous instruction cannot have toggled RFLAGS.TF 0=>1
> > +	 * (because STI and POP/MOV don't modify RFLAGS), therefore the one
> > +	 * instruction delay when activating single-step breakpoints must have
> > +	 * already expired.  However, the CPU isn't smart enough to peek at
> > +	 * vmcs.VM_ENTRY_INTR_INFO_FIELD and so doesn't realize that yes, there
> > +	 * is indeed a #DB pending/imminent.
> > +	 */
> > +	if (ex->vector == DB_VECTOR &&
> > +	    (vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
> > +	    vmx_get_interrupt_shadow(vcpu))
> > +		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
> > +			    vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);
> 
> Pulling in a Sashiko comment:
> 
>  : By restricting this workaround to only when a #DB is injected, does this
>  : leave the VM vulnerable to a VM-Entry failure regression after live migration?
>  : 
>  : KVM does not export GUEST_PENDING_DBG_EXCEPTIONS to userspace via
>  : KVM_GET_VCPU_EVENTS. Therefore, upon migration, the destination KVM
>  : initializes the VMCS with GUEST_PENDING_DBG_EXCEPTIONS=0.
>  : 
>  : If a live migration occurs when the guest is in an active interrupt shadow
>  : with RFLAGS.TF=1, but a different event is pending (or no event is pending
>  : due to a host timer preemption), this DB_VECTOR check is skipped or
>  : vmx_inject_exception() is never called.
>  :

Nice AI review. This reminds me that before writing v1 I was wondering:
if KVM_GUESTDBG_SINGLESTEP is enabled and there is no #DB injection,
then single-stepping over STI should fail as well. Then I noticed the
following code:
```
    /* When single-stepping over STI and MOV SS, we must clear the
     * corresponding interruptibility bits in the guest state. Otherwise
     * vmentry fails as it then expects bit 14 (BS) in pending debug
     * exceptions being set, but that's not correct for the guest
     * debugging
     * case. */
    if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
            vmx_set_interrupt_shadow(vcpu, 0);
```

However, at that time I was missing the live-migration case.

>  : Crnsequently, KVM will attempt VM-Entry with TF=1, shadow=1, and BS=0.
>  : The Intel SDM mandates that if RFLAGS.TF=1 and STI or MOV SS blocking is
>  : active, the VM-Entry consistency check requires
>  : GUEST_PENDING_DBG_EXCEPTIONS.BS=1. The hardware VM-Entry will fail due to
>  : invalid guest state.
>  : 
>  : Since vmx_guest_state_valid() does not check the GUEST_PENDING_DBG_EXCEPTIONS
>  : field, KVM's emulation_required flag evaluates to false. KVM then falls
>  : into the error path in __vmx_handle_exit(), dumping the VMCS and crashing
>  : the guest by returning KVM_EXIT_FAIL_ENTRY to userspace.
>  : 
>  : Does KVM need to handle the BS bit requirement in a broader context to
>  : account for live migration when no #DB is being injected?
> 
> Yes, but that's a different problem entirely[*], and isn't even solvable on AMD
> because SVM lacks an equivalent for GUEST_PENDING_DBG_EXCEPTIONS.  Note, only
> MOV/POP-SS blocking matters, because STI blocking doesn't prevent single-step
> #DBs, and single-step #DBs have higher priority than IRQs.
> 

Besides that, if MOV/POP SS is emulated with single-stepping, the
emulator currently injects a #DB. As a result, the guest would observe a
single-step #DB during the MOV/POP SS shadow, as stated in Intel SDM
28.7.1:

"If the VM entry is vectoring, there is no blocking by STI or by MOV SS
following the VM entry, regardless of the contents of the
interruptibility-state field."

If we try to fix this by not injecting #DB, then VM entry fails again.
Since emulating MOV/POP SS only happens with force emulation, perhaps we
can simply document this behavior?

Thanks!

> [*] https://lore.kernel.org/all/agUgeO5QNenQM9pT@google.com


