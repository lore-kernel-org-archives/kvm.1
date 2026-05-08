Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4224E4B5;
	Fri,  8 May 2026 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258625; cv=none; b=DzRyaV6KLipcU58bKXmUJCsoAWa0JCdEl9g9bw82SlCaGzX1LDhmvraQRSsi1nlfD0psOJiO5EjNc94LaqTn7fAzRpX1bCLI4huhEJrx3oYn/DI7wi13xiHrm3+6lEYYC1ngilLFBuPjqI1Rk7PqQ6H6FfoEkdkGpT15YYb4KiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258625; c=relaxed/simple;
	bh=SFApJzBeS8AfGIyyHt53Lv9NK+ILx1qlX2/i3FCfaYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdpMI92U24UxesnD/FFeJfPyHzhZE9sXyEsyvDizFYLyj21VzFFC3QY4rN9PHi8IgVyl/WCPo91j3DIC1NDD2q1ioNfoyxK3RM5plVkpAjxwH0MCkmt/MRmaVfWTQXwIRkkkK8XGanoyW3MUlMjNipFRaRP5ZMb6e0h5T8tUMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkUl1CUw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkUl1CUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E39C2BCB0;
	Fri,  8 May 2026 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778258624;
	bh=SFApJzBeS8AfGIyyHt53Lv9NK+ILx1qlX2/i3FCfaYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pkUl1CUwBZI0LG0Q0i79gUpxTEcY4bWet5Lbk2qgSvj8B8ltpK1chgHrqra9D5oUp
	 jEapHL7nNe2BVZyHy7BvxLWdzsL5TG7+OhKvJMo/aJMcGkTwy7SyHOMKPutYqb2KEu
	 MArNUu4X+iR6d27zlwcRdCDYbMJ+3LksAgyyIXEkg8MoiYdTnwTI84l4UYELuDKd08
	 8JT1VU8HfQd+11yb9fgZqJfDPmXGGCglsyRipGwV9ArL6gIfkiuEVengXua9sBZIRw
	 B+f/S/09FzRh+2WJ5/Bky26aWEndvXrQuqdxHea0mfeG2FNx6hMV3d7qofN/fyyFMa
	 te2joi+Ybxd8g==
Date: Fri, 8 May 2026 22:11:54 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] KVM: SVM: Always intercept RDMSR for TMCCT
 (current APIC timer count)
Message-ID: <af4Q2wkQPtYhwC1n@blrnaveerao1>
References: <20260506184746.2719880-1-seanjc@google.com>
 <20260506184746.2719880-3-seanjc@google.com>
 <afyfFRkUIHuodvG2@blrnaveerao1>
 <afyzRvFqb19Kodej@google.com>
 <afzZR3S43Ebr4khL@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afzZR3S43Ebr4khL@google.com>

On Thu, May 07, 2026 at 11:26:15AM -0700, Sean Christopherson wrote:
> On Thu, May 07, 2026, Sean Christopherson wrote:
> > Oh!  Actually, even better!  This is a great opportunity to dedup Intel vs. AMD
> > (and we can/should do the same for writes).
> 
> Scratch the writes idea, the behavior of Intel x2APIC virtualization and AMD x2AVIC
> are too different.  Intel doesn't trap writes when x2APIC virtualization is
> enabled, and instead redirects the raw value to the APIC backing page.  Which I
> guess makes sense since WRMSR interception is about the same overall cost, and
> it allows the host to safely and fully disable interception for registers it
> doesn't want/need to interpose on.
> 
> AMD on the other hand more or less follows the xAPIC (AVIC) behavior, where regs
> without "fancy" acceleration generate traps.

Sure, your earlier plan to update the readable registers mask is fine.

> 
> Side topic, handling a trap-like unaccelerated AVIC #VMEXIT is ~10 cycles faster
> than handling an intercepted WRMSR (out of ~1770+ cycles for a super simple reg
> like LVT0).  I.e. we _could_ deliberately disable interception of x2AVIC MSRs that
> get trap-like behavior, but for me, being perfectly consistent between Intel and
> AMD is more valuable than shaving a few cycles for paths that should rarely be hit
> (most of the trap-like registers are "configure once and forget about them").
> 
> The only reg that's at all hot is Timer Initial Count Register, and (a) it's a
> moot point with TSC Deadline mode, and (b) the cost to program hrtimers is so high
> than shaving ~10 cycles is completely meaningless.

Thanks for the checking this - this was something I wanted to check. And 
I agree with your assessment. None of those registers look to be 
commonly written to, and ~10 cycles is almost in the noise. If we ever 
come across a performance issue, it should be fairly simple to pass 
additional registers through (with good reason, of course).

On a side note, how did you measure this? My naive attempt showed a lot 
of variation between runs.


- Naveen

