Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056661DB13A;
	Sat,  9 May 2026 05:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778303634; cv=none; b=jbF6XG4laY2f17Ax9/AQi1H8fV7TYZXwDDPsEdh15mwdCXwcKFLmEBl4T+Q5ZgqI5VeP4oMEx6uK+0cIcNu1Lp03Bu/RTz5Z029uoXEl/QQIMEiY1WF9Tmb38ntgnTEcjDKRJ5i390psB9PSR1O4lKrdDZPOKUfJwdFxz9jnvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778303634; c=relaxed/simple;
	bh=n0IS+CQZcuOCZBc8/4rl4+mLZI+0FZq7y6KzL6tUt/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ymr6ERivG1LC+93MVEUEBCpsidNGkKFRw9CAsJwdduJt+iGKVqUwBxmrvRb3RhyCL8XZLkppZ9kRLhMBQDrzS+tAsQH9Hzdq7pZ8miHpuutabnz+1tK7RKEb32KjgmKZfQ2jTYD+IEACS15b6VQskS3tkC+lNm0cHU99tZd2sgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAmXgBhA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAmXgBhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1BEC2BCB2;
	Sat,  9 May 2026 05:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778303633;
	bh=n0IS+CQZcuOCZBc8/4rl4+mLZI+0FZq7y6KzL6tUt/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAmXgBhAZRu+Omwk1vobdH1UHSoIkihGRSbfU5CxhWF81GjhS23/81ZwJ4ErqA9Z5
	 UeWMOo2A2zt2jsKDZ5tm0YEBOx+apk8CEKZnMhp5T2STQiZxoX34cjqQKrYWDiDn40
	 5Gdkub7zjmBhTz/+cJaKzA8ookz3inwjqPj980cUKpf/jUwLMPgeib2a5iecxxfvc7
	 dIpHeYEk1gii1tdQXW8R3EF2ZaEha4WATBMN5hUmhrvYJJjIcgaeP08YLmvUi+eO3l
	 CRlRj43bWDQWDKmLAK8pbca+wFHBHHaB0Mi+g90x8GuYdTd8i213g5Ozx6TVAue9Cy
	 ee+s+CICqXBWQ==
Date: Sat, 9 May 2026 10:38:49 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] *** DO NOT MERGE *** KVM: x86: Hack in a stat to
 track guest-induced exits (for testing)
Message-ID: <af7ABspJnR0fdqiz@blrnaveerao1>
References: <20260506184746.2719880-1-seanjc@google.com>
 <20260506184746.2719880-5-seanjc@google.com>
 <af4YUUCJfp_X-bcu@blrnaveerao1>
 <af4iNmDIW-XCuX-0@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4iNmDIW-XCuX-0@google.com>

On Fri, May 08, 2026 at 10:49:42AM -0700, Sean Christopherson wrote:
> On Fri, May 08, 2026, Naveen N Rao wrote:
> > On Wed, May 06, 2026 at 11:47:45AM -0700, Sean Christopherson wrote:
> > > Not-signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/include/asm/kvm_host.h |  2 +
> > >  arch/x86/kvm/svm/svm.c          | 81 +++++++++++++++++++++++++++++++++
> > >  arch/x86/kvm/vmx/vmx.c          | 79 ++++++++++++++++++++++++++++++++
> > >  arch/x86/kvm/x86.c              |  2 +
> > >  4 files changed, 164 insertions(+)
> > > 
> > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > > index c470e40a00aa..bff534bd00dc 100644
> > > --- a/arch/x86/include/asm/kvm_host.h
> > > +++ b/arch/x86/include/asm/kvm_host.h
> > > @@ -1703,6 +1703,8 @@ struct kvm_vcpu_stat {
> > >  	u64 invlpg;
> > >  
> > >  	u64 exits;
> > > +	u64 guest_induced_exits;
> > > +	u64 msr_exits;
> > >  	u64 io_exits;
> > >  	u64 mmio_exits;
> > >  	u64 signal_exits;
> > 
> > This looks promising. I'm assuming 'hack' in the title is only meant to 
> > indicate the PoC nature of this?
> 
> More that I don't think I'll ever propose merging anything like this.
> 
> > Taking this forward, introducing a similar bucket for all AVIC/APICv 
> > related exits might help with a few tests.
> 
> I don't have any plans to take this forward.  guest_induced_exits alone simply
> isn't useful enough, even for tests.  Outside of tests, I don't think it has any
> usefulness, at all.
> 
> For tests and for real-world usage, we really do need per-exit tracking for it
> to be useful.  Maybe with some "bundling" allowed for exception vectors?  We can
> hack in one-off things like MSR exits, but either we'll have to be super hypocritical
> in choosing which use cases are justified and which are not, or we'll have created
> a slippery slope by adding a per-exit stat, i.e. we'd just be delaying the inevitable.

Ack.

> 
> For selftests, which is really the only test framework that can utilize stats in
> this way, BPF is probably a better answer, at least for the kernel, and probably
> for selftests in the long-run as well.  E.g. if we can make it easy-ish to use BPF
> in selftests (which is a tall order), then we can write tests that do *very* fancy
> validation of KVM behavior, e.g. by peeking at other vCPU state in the context of
> each and every exit.

That's good to hear - tracing was the alternative I had in mind, so it's 
good to know that's an option we can look at. Just hooking into the 
tracepoints should enable a lot of tests to begin with.


Thanks,
Naveen

