Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314E442B35;
	Fri, 24 Jul 2026 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932046; cv=none; b=Bf6x46/IRUKISDmoM5m/htdqe5Fo7UnuAwBARfxE8MT3/zMK4mur6Xb55RZHbwbw3lvTpmxvKrXvgt7yvSpk/9H6ypoz7jUGUKYNTGahqXxHn0AYiGzhfX2lglb0Bjz6ZXpB11o8kP+fzl0BCh5msl5AZLd9f6uqBVtKOuv5xDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932046; c=relaxed/simple;
	bh=UuqU/vOe5f69DRnvyGp3IF2i9crp4bBpEIwxm12+1SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uy3LT5ecdRlY4SFR5u3bdMAwoY/oBhNrWldXMuFmMxOEY4p54ddKRCTxrTryJUPy5U+1aDY78hghaJlegkk5CD6xAzlwt5NVnUIRSuJDIK+s2u9KClVucHAWCyHbNNlB9L4NnPTlESgENkn9ieOa6UA2nhoD8X0TOqwLSpbYVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMcp3Hmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMcp3Hmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7E11F000E9;
	Fri, 24 Jul 2026 22:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784932045;
	bh=R2NBLL2p08rYPu2xP1Qh0B0LQZIwnYpKvzyluU3hlGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YMcp3HmxyKZH1+XmUU8pasfOW0ceLyu8hqq4I02Tn5OoFAYChua7+X+FBkRs/LijM
	 EsPh174xA5mR7YPl8MGt8q7vWgyqYmjnbnxOh5h4HXVbPt6HbDpfiPLfquoFnJqZbu
	 KN1InJBE9RKyjA+GjPchTyGlTGeIm0ci4E2JlbzMJkDNMvpf5mR58Jwf5PzVUR1IhI
	 A5HFbGPivhd+tnd+X6dElVdiknvVTWLmtQwuLucE08547IsB1RidelKobAu2jpSJhP
	 93W3JiqgX22VvB4is3nsTkKa+7r2QNdbr9XTBjHuTL0mThAbLMaqhAfzpV5m4PTL4P
	 7DLncZY3/rOtA==
Date: Fri, 24 Jul 2026 22:27:23 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 17/25] KVM: nSVM: Service local TLB flushes before
 nested transitions
Message-ID: <amPmtfdm69hw_CM3@google.com>
References: <20260616004155.1435766-18-yosry@kernel.org>
 <20260616012056.669B91F000E9@smtp.kernel.org>
 <CAO9r8zPRmcwKAtHch995Gm5EKxv07-3f90+H71g+w=iZ+VZfiQ@mail.gmail.com>
 <CAO9r8zPSEw0snypASanWEdaaTnqf-ZvzRgZpEc=M+sPjELQbSA@mail.gmail.com>
 <amFkZwsaoPvuNWDA@google.com>
 <amGg6WjP7P-xjpLQ@google.com>
 <amIYWOgQw9z3zedA@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amIYWOgQw9z3zedA@google.com>

On Thu, Jul 23, 2026 at 06:34:16AM -0700, Sean Christopherson wrote:
> On Thu, Jul 23, 2026, Yosry Ahmed wrote:
> > On Wed, Jul 22, 2026 at 05:46:31PM -0700, Sean Christopherson wrote:
> > > On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> > > > On Tue, Jun 16, 2026 at 11:06 AM Yosry Ahmed <yosry@kernel.org> wrote:
> > > > > > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > > > > > index 234724d8b4c54..7b19191e0e43f 100644
> > > > > > > --- a/arch/x86/kvm/svm/nested.c
> > > > > > > +++ b/arch/x86/kvm/svm/nested.c
> > > > > > > @@ -717,9 +717,16 @@ static void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_v
> > > > > > >  {
> > > > > > >       struct kvm_vcpu *vcpu = &svm->vcpu;
> > > > > > >
> > > > > > > +     /*
> > > > > > > +      * TLB flushes are applied to the VMCB, so apply any pending TLB flushes
> > > > > > > +      * on the current VMCB before switching to a new one..
> > > > > > > +      */
> > > > > > > +     kvm_service_local_tlb_flush_requests(vcpu);
> > > > > >
> > > > > > [Severity: High]
> > > > > > Does this clear global TLB flush requests (like KVM_REQ_TLB_FLUSH_GUEST)
> > > > > > while applying them only to the outgoing VMCB?
> > > > > >
> > > > > > If a host-initiated flush occurs (e.g., from page reclaim), the request
> > > > > > bit will be consumed and applied to the outgoing VMCB, leaving the incoming
> > > > > > VMCB to miss the flush and run with a stale TLB.
> > > > >
> > > > > Yeah it is intentional to apply the flushes to the
> > > > > current/old/outgoing context. If there are flushes needed in the new
> > > > > context, they are queued by nested_svm_{entry/exit}_tlb_flush().
> > > > > That's similar to what VMX does.
> > > > >
> > > > > >
> > > > > > Also, is there a context mismatch here during nested VM-Exit?
> > > > > >
> > > > > > In nested_svm_vmexit(), leave_guest_mode(vcpu) is called before
> > > > > > svm_switch_vmcb(svm, &svm->vmcb01).
> > > > > >
> > > > > > Because of this, kvm_service_local_tlb_flush_requests() will see
> > > > > > is_guest_mode(vcpu) as false. If Hyper-V is enabled, this means
> > > > > > kvm_hv_purge_tlb_flush_fifo() will incorrectly target L1's FIFO while the
> > > > > > hardware flushes are actually being applied to L2's vmcb02.
> > > > >
> > > > > Ugh.. yes. This is annoying. kvm_service_local_tlb_flush_requests()
> > > > > needs to be called on both the current/old/outgoing VMCB *and* guest
> > > > > mode. So we'll need to open-code the call in a bunch of places before
> > > > > svm_switch_vmcb() and {enter/leave}_guest_mode(). I really liked
> > > > > putting it in svm_switch_vmcb() together with
> > > > > nested_svm_{entry/exit}_tlb_flush() so that all the TLB flushing logic
> > > > > for nested transitions live in one place and the ordering needs to be
> > > > > handled in one place.
> > > > 
> > > > Maybe we can just re-order the code to always call svm_switch_vmcb()
> > > > before {enter/leave}_guest_mode(). We already do that on the entry
> > > > side, and seems to be straightforward on the exit side.
> > > 
> > > As stated earlier, I'd prefer to explicitly do flushing stuff where it fits from
> > > an architectural perspective.
> > 
> > I did it this way because (as you also stated) it's more robust, and it
> > also documents the ordering requirements:
> > - We need to service local flushes before switching to the new VMCB.
> 
> No, that's not the requirement.  The requirement is that KVM faithlyfully emulates
> the SVM architecture.  For KVM's implementation, that _mostly_ aligns with
> switching between vmcb01 and vmcb02, but that's not a hard guarantee.  Unlike VMX,
> SVM doesn't force KVM doesn't need to switch the active VMCB in order to make
> changes to a VMCB, so nSVM may never end up with as many switches as nVMX that
> don't need to trigger a TLB flush, but conceptually it's still inaccurate.
> 
> And regarding robustness, the flaw Sashiko pointed out regarding servicing pending
> flushes after leave_guest_mode(vcpu) highlights that burying architectural behaviors
> in what are effectively utility functions can be dangerous.  The counter-argument is
> that we ended up with a similar bug in nVMX where KVM straight up forgot to service
> the flushes, but my point is that handling this in svm_switch_vmcb() isn't a silver
> bullet.  And I really don't like adding an arbitrary constraint that the "new" VMCB
> needs to "match" the current L1 vs. L2 mode.
> 
> > - We need to queue new flushes after servicing local flushes.
> > 
> > I like that it's all in one place. All that being said, I did go
> > back-and-forth on this so I am not opposed to open-coding it. Let me know if
> > the above argument swayed you or if you still prefer open-coding.
> 
> I still prefer open-coding the calls to perform/request/serivce flushes.

For the record, I had locally added a warning to svm_switch_vmcb() to
make sure that guest_mode and the active VMCB are consistent when
kvm_service_local_tlb_flush_requests() is called. Given that we are
going with open coding the calls, I will add a wrapper for the
warn+call:

static void nested_svm_service_local_tlb_flushes(struct vcpu *vcpu)
{
        struct vcpu_svm *svm = to_svm(vcpu);

        /*
         * TLB flushes are applied to the VMCB, so apply any pending TLB flushes
         * on the outgoing VMCB before switching to a new one. A TLB flush could
         * purge the relevant HV TLB flush FIFO depending on guest_mode, so make
         * sure the VMCB and guest_mode context is consistent.
         */
        WARN_ON_ONCE(is_guest_mode(vcpu) != (svm->vmcb == svm->nested.vmcb02.ptr));
        kvm_service_local_tlb_flush_requests(vcpu);
}
