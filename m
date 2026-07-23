Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC45330644;
	Thu, 23 Jul 2026 05:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783213; cv=none; b=eQ0nYSILDTpJIasIX514a27LB6fl21ru8JWwHjrXRlVqxsK7IBEzEOk2rxZBSpQJDmZMfpblOj/m/pNMirOuMMbsQxxvlfYrOBpe44uEjujuQkIeLEyJIBUeoRGeKXz3pbGhVFP+diT6V3i2Bz75Js1EniE55Ju8vy87ElIifss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783213; c=relaxed/simple;
	bh=pUUMBXCGvZo5YGIEVovoFfOZqw4QwyqttiDvkFQRxow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRZtsfVITy0bjQ8skDh6tQ/RRb4OO21bhtFhaA4g1/RNnsv51Sj3MRdKhjzSTmqt1Z52F5d0Swo/+wy2DxjbW3g8UdLY6xC7Npz45vRMcShQG2l8D7ja1go/Ix7J6G62NLpRIdVyt3SOYibklBliLjzUSLjIEpPhZN2DVMCRZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/KmqBZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/KmqBZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5C41F000E9;
	Thu, 23 Jul 2026 05:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784783211;
	bh=wHM115D6B2FenxtP6KpecaowPDUiHanAAqRuphFSkz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k/KmqBZ2e7C3AN0Ta2WRyGvGDG8VjBbgylskt081uOUFt548MlVzTQCoJQ8AG0xLx
	 9BOi/4nUdOt+tO9ZWbnxH3UI94teuxfXDAM0XKQHMNTec7Ng+CIyeaDQuiiSyoDcar
	 1nRx5MYDeW1xRTMcHl5hi1vV7op3/TdDCrFMsrujFpexiUwV8qsJPvK8fB7pb/Ubs1
	 YgoPu7tme/Ms5uAdbbON5OXepXjM9SDyvoAvbx3pwK9wgE4lk/pBN5EVcBgndeHhSF
	 G/r6MNbL8gm156znCLaJOVQgXWNCFwm71irZTY32kMcPJzikGw3nHqhy1zqKchVA3A
	 M5JgJpbrDD4kw==
Date: Thu, 23 Jul 2026 05:06:50 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 17/25] KVM: nSVM: Service local TLB flushes before
 nested transitions
Message-ID: <amGg6WjP7P-xjpLQ@google.com>
References: <20260616004155.1435766-18-yosry@kernel.org>
 <20260616012056.669B91F000E9@smtp.kernel.org>
 <CAO9r8zPRmcwKAtHch995Gm5EKxv07-3f90+H71g+w=iZ+VZfiQ@mail.gmail.com>
 <CAO9r8zPSEw0snypASanWEdaaTnqf-ZvzRgZpEc=M+sPjELQbSA@mail.gmail.com>
 <amFkZwsaoPvuNWDA@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amFkZwsaoPvuNWDA@google.com>

On Wed, Jul 22, 2026 at 05:46:31PM -0700, Sean Christopherson wrote:
> On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> > On Tue, Jun 16, 2026 at 11:06 AM Yosry Ahmed <yosry@kernel.org> wrote:
> > > > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > > > index 234724d8b4c54..7b19191e0e43f 100644
> > > > > --- a/arch/x86/kvm/svm/nested.c
> > > > > +++ b/arch/x86/kvm/svm/nested.c
> > > > > @@ -717,9 +717,16 @@ static void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_v
> > > > >  {
> > > > >       struct kvm_vcpu *vcpu = &svm->vcpu;
> > > > >
> > > > > +     /*
> > > > > +      * TLB flushes are applied to the VMCB, so apply any pending TLB flushes
> > > > > +      * on the current VMCB before switching to a new one..
> > > > > +      */
> > > > > +     kvm_service_local_tlb_flush_requests(vcpu);
> > > >
> > > > [Severity: High]
> > > > Does this clear global TLB flush requests (like KVM_REQ_TLB_FLUSH_GUEST)
> > > > while applying them only to the outgoing VMCB?
> > > >
> > > > If a host-initiated flush occurs (e.g., from page reclaim), the request
> > > > bit will be consumed and applied to the outgoing VMCB, leaving the incoming
> > > > VMCB to miss the flush and run with a stale TLB.
> > >
> > > Yeah it is intentional to apply the flushes to the
> > > current/old/outgoing context. If there are flushes needed in the new
> > > context, they are queued by nested_svm_{entry/exit}_tlb_flush().
> > > That's similar to what VMX does.
> > >
> > > >
> > > > Also, is there a context mismatch here during nested VM-Exit?
> > > >
> > > > In nested_svm_vmexit(), leave_guest_mode(vcpu) is called before
> > > > svm_switch_vmcb(svm, &svm->vmcb01).
> > > >
> > > > Because of this, kvm_service_local_tlb_flush_requests() will see
> > > > is_guest_mode(vcpu) as false. If Hyper-V is enabled, this means
> > > > kvm_hv_purge_tlb_flush_fifo() will incorrectly target L1's FIFO while the
> > > > hardware flushes are actually being applied to L2's vmcb02.
> > >
> > > Ugh.. yes. This is annoying. kvm_service_local_tlb_flush_requests()
> > > needs to be called on both the current/old/outgoing VMCB *and* guest
> > > mode. So we'll need to open-code the call in a bunch of places before
> > > svm_switch_vmcb() and {enter/leave}_guest_mode(). I really liked
> > > putting it in svm_switch_vmcb() together with
> > > nested_svm_{entry/exit}_tlb_flush() so that all the TLB flushing logic
> > > for nested transitions live in one place and the ordering needs to be
> > > handled in one place.
> > 
> > Maybe we can just re-order the code to always call svm_switch_vmcb()
> > before {enter/leave}_guest_mode(). We already do that on the entry
> > side, and seems to be straightforward on the exit side.
> 
> As stated earlier, I'd prefer to explicitly do flushing stuff where it fits from
> an architectural perspective.

I did it this way because (as you also stated) it's more robust, and it
also documents the ordering requirements:
- We need to service local flushes before switching to the new VMCB.
- We need to queue new flushes after servicing local flushes.

I like that it's all in one place. All that being said, I did go
back-and-forth on this so I am not opposed to open-coding it. Let me
know if the above argument swayed you or if you still prefer
open-coding.
