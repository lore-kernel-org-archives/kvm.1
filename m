Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF4F334681;
	Fri, 24 Apr 2026 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013847; cv=none; b=cR9oFZ1U1CzUB2Gu4QjdcQbhBC86sWX26PmJSCowASEMac8krd6PpQ2ufpmxy43iwwCc91ePWA/JOOhE3cKDYphEmd48tHZAYQ/7vrpp/ergjiNAGIfDKSHWGrya/1/I30RgdTMO8PQECVGkKWo7s2pvYf5XaoHaHodrFwZ6ob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013847; c=relaxed/simple;
	bh=B5TKc3AC5y/I4kkZMYUd0LK/XgczJVicXWjds35vULs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESGU1HzNtrNKyDJopn3BC5a18q1aIrDm3/bjDqvSemd2HsXr2yR1DnJHp7kFnEAxgPtX5rsegOG8DQUU4HCf+8Pnb5fUUFnIxJWXAo3SszaiZUCYbGdnyuPNLXh2ZvItOhgYoxzfwBxkuyePFnE6kvpcZVjKdksNtyuR7yIuAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ztpz5W2x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ztpz5W2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736BBC2BCB4;
	Fri, 24 Apr 2026 06:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777013847;
	bh=B5TKc3AC5y/I4kkZMYUd0LK/XgczJVicXWjds35vULs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ztpz5W2xiQzdaiSPbnvn4grNSADwzRqq6EbrTWGORHFKeUSEGItT01Kljsy98j/7Z
	 EvC2k3t8ix1ZxX8VSiRKyL4ZjmJmef1RMFQqOctXklFOa7yfeuCHfRf5qS+WMKPfRu
	 b6+kIv9eSf+UwJ+N/z25PyYKUR3L0kL6RmfieAf8YuAMH0merfmyDFn24WUJHdLmCD
	 qGuYtE5mixJDgeVx/ohGD8vZynXVcCJwl0psc4LPO3cXC6iiLXXI3tlDht7qvbmfbw
	 yHj31Pt1eP1UaC1O4q+jGGVEvi0ZMsRdcLpP6drOH8l/gUJzaXmeWnVCXNZYZch8jw
	 xpTaQnvk8G1NQ==
Date: Fri, 24 Apr 2026 06:57:26 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
Message-ID: <aesUCLkUGUUbxdf7@google.com>
References: <20260326031150.3774017-5-yosry@kernel.org>
 <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com>
 <adfgPwgXz1iQHpVS@google.com>
 <CALMp9eRLpZtpmdH4LJGdNkFO_hdJFw0i9MS94Ou1_GKHADq13w@mail.gmail.com>
 <adfmVXRwzZkvRSnj@google.com>
 <CALMp9eTvH1Pg0Eb-KCcX7LLJPFgS1xTSR0DzeA8xo4Re7=p=7w@mail.gmail.com>
 <adfyKU5WUiW4OnUg@google.com>
 <adgYSnE-I1Z19fCY@google.com>
 <aefSuVNRtepzL921@google.com>
 <aelOwWh-kfM5EYsL@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aelOwWh-kfM5EYsL@google.com>

> > > What do you think about having two flavors of kvm_pmu_handle_nested_transition()?
> > > One that defers via a request, and a "special" (SVM-only?) version that does
> > > direct updates.
> > > 
> > > Poking into PMU state in arbitrary contexts makes me nervous.  E.g. when calling
> > > svm_leave_nested(), odds are good EFER isn't even correct, and the update *needs*
> > > to be deferred.
> > 
> > Hmm is it really that bad?
> 
> It's not horrible, but it's a lot of "I think" and "should" and whatnot.  I
> generally agree that it's unlikely to be a problem, but I can point at far too
> many bugs where KVM unexpectedly invokes a helper and consumes stale state.
> 
> I'm not completely opposed to non-deferred updates, but I really don't want to
> use them for svm_leave_nested(). 

That makes sense, I had similar thoughts at some point.

> 
> > - In the emulated VMRUN and #VMEXIT paths, EFER.SVME should be set in
> >   both L1 and L2, so it should be fine.
> > 
> > - In the restore path entering guest mode, EFER.SVME should also be set
> >   in both L1 and L2.
> > 
> > So I think svm_leave_nested() is the only interesting case:
> > 
> > - In the restore path, svm_leave_nested() should only be called if the
> >   CPU is in guest mode and EFER.SVME is set in both L1 and L2.
> > 
> > - In the EFER update path, L1 will get a shutdown if we forcefully leave
> >   nested anyway, unless userspace is setting state. Either way, the
> >   value of EFER should be correct and valid to use to update the PMU
> >   here.
> > 
> > - In the vCPU free path, it shouldn't really matter, but the value of
> >   EFER should still be correct.
> 
> > So I *think* generally the value of EFER should be fine to use. The
> > other inputs are is_guest_mode() and eventsel. In both cases we should
> > just make sure to update the PMU *after* updating the state.
> > 
> > So I think we'd end up with something similar to Jim's v2:
> > https://lore.kernel.org/kvm/20260129232835.3710773-1-jmattson@google.com/
> > 
> > We will directly re-evaluate eventsel_hw on nested transitions, EFER
> > updates, and PMU MSR updates -- without deferring anything.
> >
> > We'd still need to make other changes:
> > - Always disable the PMC if EFER.SVME is clear and either H/G bit (or
> >   both) is set.
> > 
> > - Handle VMRUN correctly. I was going to suggest just moving the call to
> >   kvm_skip_emulated_instruction() to the end of the function, but that
> >   doesn't handle the case where we inject #VMEXIT(INVALID) due to a
> >   VMRUN failure (e.g. consistency checks, loading CR3, etc).
> > 
> >   I am actually not sure if the instruction should count in host or
> >   guest mode in this case. Logically, we never entered the guest, so
> >   perhaps counting it in host mode is the right thing to do? I think
> >   we'll also need to test what HW does.
> > 
> >   Honestly, it would be a lot easier of someone from AMD could just tell
> >   us these things :)
> > 
> >   Basically:
> >   - Does the PMU generally count based on processor state (e.g. guest
> >     mode, EFER.SVME) before or after instruction retirement?
> >   - A successful VMRUN will be counted in guest mode, what about a
> >     failed VMRUN that produces #VMEXIT(INVALID)?
> > 
> > > I definitely don't love having two separate update mechanisms, but it seems like
> > > the safest option in this case.
> > 
> > Same here, and I like the deferred handling, but to Jim's point I think
> > we can use it anywhere :/
> 
> Why can't we defer the svm_leave_nested() case?  The only flows the invoke
> svm_leave_nested() are non-architectural, being precise there doesn't matter at
> all (and I'm not convinced it matters in general given none of us can figure
> out what hardware is _supposed_ to do).
> 
> Having a synchronous path for architectural flows, and a deferred mechanism for
> everything else seems reasonable, and would all but eliminate my concerns about
> consuming stale state and/or doing things like attempting to write MSRs while
> freeing a vCPU.

Sounds good to me. See my other reply about specifics.
