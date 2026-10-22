Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792712751;
	b=a9xe3gekUtPgLsuUD56DtEOYOvKdXBLAS/AyGARt5wtHm0yWdiu/5eBmTrRSx0oJUE+e
	 XyUHKQOXek4qF9BTGT6Oi1F9ncTj+MLYNgphL/euMJEAVm8UrPCFvmmIJQzjS6A4ly43R
	 OYgpmpc962Cn3Xwv0hICf6cJTMAPfDKtemIg1Mxu9RZdWH0OGRq6oOcmsFhI7NOB1IW7D
	 Op3W8ytVb2ZL8IrY6t2iSc3ALQsM/SS6kympQdojCDAv9TL7y7YpUV9B5Y2wK2TW4nvM/
	 +wUaG9dAABQNGWP+liHAAUbjxW8tN4oW72eclWiD4gciVUXAeTUDlBucnYf9Id0Y9gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712751;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/ZbXBETW+3Stk8Its6L1Zw3qsl5qwxouYPxbY52pkQc=;
	b=mT6A2Kv/3wdR+sGzdC743KYSXLtCoVO26YT+vm4vbYSWpysk2ORyexaessP9QcKxScWP
	 GpS8g8fa4fhEIg2RgoO3O4HXaFxluLPkE9Klu37tRMyot4jVeSJep4oNUMJWNssvUOTDh
	 jjvdc6gDpUQG5IVF4K08Nm5k3mOwYuXknk9Kly8ai0K27dAjVvHuR9gG7y4l5mrbLPKNm
	 aOaz6oBo0ih5LHLi9lfKbeQU04+3bYLrtLq2AnianstTaOLrQ5Am2empZ2PGLbpMJwJ/w
	 IQ9CqClpADENn59qeIfM1HXzfKe7t6mCy0+GiyBHR7TAbuJarn2Pjwzx8+a8cUGvqOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVGMfoBJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48811606A31A;
	Thu, 22 Oct 2026 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVGMfoBJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9811F01825;
	Thu, 22 Oct 2026 23:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792712749;
	bh=/ZbXBETW+3Stk8Its6L1Zw3qsl5qwxouYPxbY52pkQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KVGMfoBJSMERSi9hAXcpA8UI1RhpkJmVK1tO0H6KyeUtJk48qlFQ/RMl4SakZJ+/s
	 l1yopN/0OthLVbMYxZhFYZadUcLslw/dfRP8bHv27/SFJYj2sALbm773QAoPQxrdL7
	 dzglYl3Tk0jTR4Rd55Kx2cZ3UAHI7TU1e3GQhThfoWkHTN+iqsgSj/TWPLbYclMyCU
	 fJ/LO4xUWNtE4X1Fvk7rPVWEjMBEf7h5Rs6GoUT8o9PJRb7ICpEayTLrOwAeLAyKOL
	 k+2eMUBh91bT32BZd7mJsFq5Cxs9XXsiRU6TcMn3sCoNM8426DDSvm6kGRn/k+XeZv
	 DeYAmuvVOZJCA==
Date: Thu, 22 Oct 2026 23:45:48 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, 
	pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] KVM: nSVM: Reset the virtual VMLOAD/VMSAVE bit in vmcb02
 on every nested VMRUN
Message-ID: <atqdBFgoztW0nhoC@google.com>
References: <20261016235221.33726-2-amirmohammad.eftekhar@cispa.de>
 <atpGGKVAL3bAnmnk@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atpGGKVAL3bAnmnk@google.com>

On Thu, Oct 22, 2026 at 10:21:28AM -0700, Sean Christopherson wrote:
> +Yosry and Jim
> 
> On Sat, Oct 17, 2026, Amirmohammad Eftekhar wrote:
> > The SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE (VLS) bit in
> > vmcb02->control.misc_ctl2 is OR-set in nested_vmcb02_prepare_control()
> > when L2 is allowed to use virtual VMLOAD/VMSAVE, but it is never reset.
> > vmcb02 is a persistent per-vCPU structure reused across nested VMRUNs,
> > so once one nested entry enables VLS the bit leaks into every later
> > entry -- including entries where vmcb12 has VLS cleared and L1 has asked
> > KVM to intercept VMLOAD/VMSAVE.  Per AMD's APM, virtual VMLOAD/VMSAVE is
> > honored over the VMLOAD/VMSAVE intercepts, so with the stale bit set
> > L2's VMLOAD/VMSAVE are virtualized and run without a #VMEXIT, and the
> > intercept L1 explicitly requested is silently dropped.

Does the APM say this? My version doesn't (Revision 4.09, March 2026):

	15.33.1 VMSAVE and VMLOAD Virtualization

	This feature allows the VMSAVE and VMLOAD instructions to
	execute in guest mode without causing a #VMEXIT. The VMCB
	address in RAX is treated as a guest physical address and is
	translated to a host physical address. Any page fault in
	attempting that translation will result in a normal #VMEXIT with
	a nested page fault exit code. If the translation is successful,
	the register state transfer to or from the VMCB will then be
	performed.

	Support for virtualized VMSAVE and VMLOAD is indicated by CPUID
	Fn8000_000A_EDX[15]=1.  When this feature is available, it must
	be explicitly enabled by setting bit 1 of VMCB offset 0B8h to 1.
	This enable bit is only recognized when the hypervisor is in 64
	bit mode, nested paging is enabled and Secure Encrypted
	Virtualization is disabled, otherwise attempted execution of a
	VMLOAD or VMSAVE in the guest will result in a #VMEXIT with a
	VMSAVE/VMLOAD exit code.

In fact, this is opposite to the conclusion I reached in 55780d8a1dcc9
("KVM: SVM: Stop toggling virtual VMSAVE/VMLOAD on intercept recalc"),
and I like to think that I tested on HW back then (tho I honestly don't
remember).

Actually, looking at nested_vmsave_vmload_test.c, I make sure that the
intercepts are honored (in L1) *even* if VLS is enabled. I also *think*
that in that test, KVM will end up setting both the intercepts and VLS:
1. nested_vmcb_needs_vls_intercept() will return false because the guest
   supports VLS, has NPT, and enables VLS.
2. KVM still copies the intercepts from vmcb12 anyway, including VMSAVE
   and VMLOAD, see nested_vmcb02_recalc_intercepts(). KVM (correctly)
   doesn't clear VMSAVE/VMLOAD intercepts if VLS is enabled by L1 (but
   it does the opposite).

So this test case passing should be confirming my allegation that
intercepts take precedence over VLS.

I think the test also goes on to clear VLS and test the behavior with it
cleared, which should be further evidence that KVM leaving the bit set
is harmless, because KVM will intercept VMSAVE/VMLOAD if L1 clears VLS,
even tho it will leave VLS set in vmcb12.

> > 
> > misc_ctl is reset from vmcb01 a few lines earlier; misc_ctl2's VLS bit
> > has no equivalent reset.  The only writes to misc_ctl2 are this OR-set,
> > the vmcb01 init OR-set, and the independent V_LBR (bit 0) set/clear, so
> > nothing clears bit 1 between entries.  nested_vmcb02_recalc_intercepts()
> > sets INTERCEPT_VMLOAD/VMSAVE when nested_vmcb_needs_vls_intercept() is
> > true and otherwise only WARNs on the reverse condition; it never catches
> > the real hazard of VLS on while the intercept is also set.
> > 
> > Reset the VLS bit before the conditional set, mirroring misc_ctl, and
> > add a forward WARN so a future regression trips immediately.
> > 
> > This is distinct from CVE-2021-3656 (single-VMRUN under-sanitization of
> > a VLS bit L1 set in vmcb12 without being granted the feature); here L1
> > is granted VLS and uses it legitimately, and the bit goes stale across
> > VMRUNs.
> > 
> > Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
> > ---
> >  arch/x86/kvm/svm/nested.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index af0ef6784..65e61b796 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -197,6 +197,14 @@ void nested_vmcb02_recalc_intercepts(struct vcpu_svm *svm)
> >  	} else {
> >  		WARN_ON_ONCE(!(vmcb02->control.misc_ctl2 & SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE));
> >  	}
> > +
> > +	/*
> > +	 * If KVM is intercepting VMLOAD/VMSAVE, virtual VMLOAD/VMSAVE must be
> > +	 * off, or hardware would honor the virtualization and render the
> > +	 * intercept inert.
> > +	 */
> > +	WARN_ON_ONCE(vmcb_is_intercept(&vmcb02->control, INTERCEPT_VMLOAD) &&
> > +		     (vmcb02->control.misc_ctl2 & SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE));
> >  }
> >  
> >  /*
> > @@ -994,6 +1002,13 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
> >  
> >  	/* SVM_MISC2_ENABLE_V_LBR is controlled by svm_update_lbrv() */
> >  
> > +	/*
> > +	 * vmcb02 is reused across nested VMRUNs and the VLS bit below is only
> > +	 * OR-set, so clear it first; a stale bit would let L2 run VMLOAD/VMSAVE
> > +	 * unintercepted even on a VMRUN that asks KVM to intercept them.
> > +	 */
> 
> This becomes self-explanatory if written as:
> 
> 	if (nested_vmcb_needs_vls_intercept(svm))
> 		vmcb02->control.misc_ctl2 &= ~SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE;
> 	else
> 		vmcb02->control.misc_ctl2 |= SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE;

All that being said, I am not opposed to doing this in terms of hygiene.

> 
> and I definitely think we should un-invert the check to match nested_vmcb02_recalc_intercepts().
> 
> That said, not explicitly initializing all of misc_ctl2 is crazy.  AFAICT, LBR
> virtualization is the only other bit in misc_ctl2, and it to is always computed
> dynamically so I'd rather do this:
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 1503fee15baa..6ea35a3dc361 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -884,8 +884,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
>  	}
>  
>  	/*
> -	 * Copied from vmcb01.  msrpm_base can be overwritten later.
> -	 *
>  	 * SVM_MISC_ENABLE_NP in vmcb12 is only used for consistency checks.  If
>  	 * L1 enables NPTs, KVM shadows L1's NPTs and uses those to run L2. If
>  	 * L1 disables NPT, KVM runs L2 with the same NPTs used to run L1. For
> @@ -893,6 +891,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
>  	 * to L1 GPAs, so the same NPTs can be used for L1 and L2.
>  	 */
>  	vmcb02->control.misc_ctl = vmcb01->control.misc_ctl & (SVM_MISC_ENABLE_NP | SVM_MISC_ENABLE_GMET);
> +	vmcb02->control.misc_ctl2 = 0;
>  	vmcb02->control.iopm_base_pa = vmcb01->control.iopm_base_pa;
>  	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
>  	vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);

Also not opposed to this.

> 
> Argh!  But nested_vmcb02_prepare_save() isn't called in the svm_set_nested_state()
> case, so AFAICT svm_update_lbrv() is never called.  Though that seems like a
> pre-existing?

Yeah this seems like a pre-existing issue. I suppose we can move
svm_update_lbrv() outside of nested_vmcb02_prepare_control():

1. In enter_svm_guest_mode(), call it after
nested_vmcb02_prepare_save().
2. In svm_set_nested_state(), call it after
nested_vmcb02_prepare_control(), as svm_copy_vmrun_state() should have
already updated the LBR and dbgctl regs.
