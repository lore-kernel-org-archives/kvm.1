Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A652749DF;
	Thu, 23 Jul 2026 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783251; cv=none; b=oivVmqpko1gpWdqfomiW/pTRi+K/3TCk4yOSEBwAqwKpvX0suWKmc4h3N7A0Mj6ZUFYSSWbSht2+1QJL7Sl5SwfE7+EEii68xl2yQukusT10Lkxvk5zMamN6MHz8bhk6IzV6lvT4ibCER4NlZc5XEKyMhz35C2h1Ib/LRyt6JKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783251; c=relaxed/simple;
	bh=Axw0m+UgoKLBeuen1aPczclM1tFfznoSQxW+ESahXFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTSuLO6SDbS4wtMsxudmuR0zembmYo50qLEhurtTFD13yyQ/Kb55ZELxEhiqMZv4Q6wfG1xijqkqRc2vPepSe4sjmqt4Z/ykc2M+p/xw8Eko2NDXa3d4EbJXz2t6kSuXCMFsBohqGSRKvdEJ0upGEmwhrnWO/wCDLNIBkNTBNjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHAgkex7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHAgkex7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998771F000E9;
	Thu, 23 Jul 2026 05:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784783249;
	bh=fAFV+EEVQVK0IDbIcWJaYXOTJla3MMQoqBWOe3+S6Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OHAgkex7rc++XbFbBnPhGrzZLPi2unLtENHc9ERNjp/lcU3yXevPfOmEw8J7p5OjA
	 B4OuToHcTStEJ/lQ5Bo4gq4va4WxqoPekD0B7jTzzULn6GNQQyH/PILmz/Ixs8pjnD
	 jBJiSTDFbCpdDpM5f6FrEiBqIC+ZcdAScABvFNQ941wUSLCEwjJFMCe/EFQbrtsFgb
	 48PWSxtoppgE0sMPxo604OoKqqNn7xa4yV13hK/Hpdtk14LfGvh+gT15jEZii6Yvzt
	 yRRLyAsiuxCIO/r2P3M+FdP58Rgo5n0D8EiGa1uFanh6uMUqaCvIHEx4WcopEGpyMZ
	 Wi/kSzSDGjQGg==
Date: Thu, 23 Jul 2026 05:07:28 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 15/25] KVM: nSVM: Call
 nested_svm_transition_tlb_flush() on every VMCB switch
Message-ID: <amGhgO7i--FXvaqc@google.com>
References: <20260616004155.1435766-1-yosry@kernel.org>
 <20260616004155.1435766-16-yosry@kernel.org>
 <amFjdi84r-tPgKqk@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amFjdi84r-tPgKqk@google.com>

On Wed, Jul 22, 2026 at 05:42:30PM -0700, Sean Christopherson wrote:
> On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> > Move the calls to nested_svm_transition_tlb_flush() in different
> > transition code paths to svm_switch_vmcb(). This ensures that TLB
> > flushes are not missed during switches, and makes it clearer that the
> > TLB flushes are directly related to the active VMCB.
> > 
> > The ordering currently doesn't matter, but as more TLB handling is added
> > for nested, requesting the TLB flushes *after* the VMCB switch will
> > become a requirement.
> > 
> > No functional change intended (for now).
> > 
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/svm/nested.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index 24a52aefe94ee..9a917d057aa8e 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -707,8 +707,12 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
> >  
> >  static void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
> >  {
> > +	struct kvm_vcpu *vcpu = &svm->vcpu;
> > +
> >  	svm->current_vmcb = target_vmcb;
> >  	svm->vmcb = target_vmcb->ptr;
> > +
> > +	nested_svm_transition_tlb_flush(vcpu);
> 
> I'm not convinced this is the right place to do the flushing.  Yes, manually
> doing the flushes requires more code, and arguably makes KVM less robust, but
> IMO there's value in mimicking architectural flows because it's the architecture
> that dictates the flushing.

Responded to the same comment in patch 17.
