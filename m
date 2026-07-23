Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C9470EB2;
	Thu, 23 Jul 2026 05:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783516; cv=none; b=oJDT+B4loEwh03N+GkeDsciicQqhlJ9ZnwkV+ZY9pSYO3YftNpT6nHCTXeICXltbd2mVT2P1ljz2cFcLpSjjLV6X5E92Rd874UitDP9617kxWWf0tZess1bQw5vu+EW3w0dOUnSWKDaFRXKLadubzM0WRrBFWvCk19EzfIW4I+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783516; c=relaxed/simple;
	bh=Ay8l7c88XfpSbFdV5zDduDc2iQSHOh9dyJnN4dzjXhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7tkoX3jcMZgs1E1G0Y5ytGgj6HxV+gt49eXgJaDWiLw638AUyyfY6h5M8ebvMwVHOo7ay8G4LP1ZgAZETaiSPqsarMVS10nn/b7VdPP5Ss1wl+xukHOj8YogdFUQ+2WucSisz0zf/jv/VLFh5D4uAKIEmkuj+V61/O2gFIMr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4olgVFU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4olgVFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F3A1F000E9;
	Thu, 23 Jul 2026 05:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784783515;
	bh=2RGGvdAxJ6bnF1ZM1cCgbtV9A5lKwAlQwY3M5zH8qCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l4olgVFUONyKj/yXqA+pn0qf7V2zDy45zQUPXm8fYVz0I5bCqIzpxz8t6E+d11j+f
	 4tBceRKL53XlQP/lWnG+XzjxCBjJs16M0noZEKdvt1Isf7gMaPB5vFD9inU1Qojy6I
	 JZ/fzsoz3BaMhFX+XNA3xZ0RXZlznR20kkFiRKewPzqByzqqLtyHsZlm9AFVUU9E8v
	 VjHEVgfTAn1P1yMPRROTZHlIaW3BemL/KUw7/g28TW27LyIsmewWlQ9OQdHUDhXx/U
	 r0x28wsuNznWMjIIcM08ECscCfV8UmF1wod7UEQxlKcxJlcOl2M8avIr9YDoHvlmrn
	 inEYPV03FuiCQ==
Date: Thu, 23 Jul 2026 05:11:53 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 22/25] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to
 allow skipping the gva flush
Message-ID: <amGiAKsC3XrF6DyA@google.com>
References: <20260616004155.1435766-1-yosry@kernel.org>
 <20260616004155.1435766-23-yosry@kernel.org>
 <amFl89ch5Iej63L3@google.com>
 <amFms2CnzhDUuRCk@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amFms2CnzhDUuRCk@google.com>

On Wed, Jul 22, 2026 at 05:56:19PM -0700, Sean Christopherson wrote:
> On Wed, Jul 22, 2026, Sean Christopherson wrote:
> > On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> > > Refactor helpers out of kvm_mmu_invalidate_addr() and kvm_mmu_invlpg()
> > > that take in an extra argument to skip the GVA flush.
> > > 
> > > This will be used when invalidating GVAs in a different context than the
> > > correct one (i.e.  invalidating an L2 GVA from L1), so flushing the
> > > current context would flush the wrong TLB entries.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > > ---
> > >  arch/x86/kvm/mmu/mmu.c | 23 +++++++++++++++++------
> > >  1 file changed, 17 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index 65c35ed8f4a01..3feb75732f7b4 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -6615,15 +6615,15 @@ static void kvm_mmu_invalidate_addr_in_root(struct kvm_vcpu *vcpu,
> > >  	write_unlock(&vcpu->kvm->mmu_lock);
> > >  }
> > >  
> > > -void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > -			     u64 addr, unsigned long roots)
> > > +static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > +				      u64 addr, unsigned long roots, bool flush_gva)
> > >  {
> > >  	int i;
> > >  
> > >  	WARN_ON_ONCE(roots & ~KVM_MMU_ROOTS_ALL);
> > >  
> > >  	/* It's actually a GPA for vcpu->arch.guest_mmu.  */
> > > -	if (mmu != &vcpu->arch.guest_mmu) {
> > > +	if (flush_gva && mmu != &vcpu->arch.guest_mmu) {
> > >  		/* INVLPG on a non-canonical address is a NOP according to the SDM.  */
> > >  		if (is_noncanonical_invlpg_address(addr, vcpu))
> > >  			return;
> > > @@ -6642,9 +6642,15 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > >  			kvm_mmu_invalidate_addr_in_root(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
> > >  	}
> > >  }
> > > +
> > > +void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > +			       u64 addr, unsigned long roots)
> > 
> > Rather than kvm_mmu_invalidate_addr() for the wrapper, what if we call this
> > kvm_mmu_invalidate_gva()?  And then kvm_mmu_invlpg_gva().  Then we don't need
> > to have the "in_root" version to a quad-underscores helper, and IMO it's more
> > obvious what's different between the one-line wrappers and the inner helpers.
> 
> Hrm, or maybe I'm not understanding what "flush_gva" means.  At first glance, I
> was assuming you were using it to differentiate between GVA and GPA, but IIUC,
> it's literally skipping the flush for the current context, which just so happens
> to be done only for GVAs.  I'd still like to avoid the "in_root" helper, if at
> all possible.

Yes, it's skipping the TLB flush that is only needed for GVAs. The
alternative I had in mind (but thought was worse) was to refactor the
TLB flush part out of kvm_mmu_invalidate_addr() (or
__kvm_mmu_invalidate_addr()) in this patch instead of adding a boolean,
but this still requires adding a wrapper and the possibility of a
quad-underscore helper.

What's the main objection to kvm_mmu_invalidate_addr_in_root()?
