Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229A0336EE1;
	Mon, 16 Mar 2026 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678529; cv=none; b=CeP/j3XUwmSTYhSg+Hx0UM17HodoPvXHbv7i7mRtR2pijf+V6adKP5W6cijwCgXv/j2N220MwOaeycsHdPH0xwx4Jy6PoEhk8lYEJ3ibVYNwOghNKQMPdW80wNE8v8V9OGKdIHCBDXxbKM/t+YeET9S9dVrwaNm/XfRfX8rdY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678529; c=relaxed/simple;
	bh=UZGAh9xjACpr5Oqiot7L02jfr8V3bwGeLC+baswYcLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh+nUeWKHiV2mmz96R/hL7QaIeTk25RG+v6bcIyF6O9VhZLdsUa50aSsTMKqD/xA9dRUpLOGYpwTtMKMRgC9HoRa0M1b64J2qeH+ofGGqmDMBriOpMYYokf6Eh4zEE1xKGCNvjBlcpQse6/ppv6onB66BP+0iS/Typ8oBiivX44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpBFmESZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpBFmESZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AA3C19421;
	Mon, 16 Mar 2026 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773678528;
	bh=UZGAh9xjACpr5Oqiot7L02jfr8V3bwGeLC+baswYcLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpBFmESZe+7+teMRsy5n+ezV+Nt9tggRNh7mVsB74n/O4cSdUCe+C/yJNpIR1VR64
	 JTYmxmR31q4blGP4DRBYl5FhD4biMfJNVDTr0Dl1w58KEEmItKq8ok/AI8VCtk4E4+
	 42UymADIalA2UeSYZj6KMDKTE4o+k2v0R8S90VsuJrg3aYqxRrsiWD/24ZslPX4dgI
	 zS7wjxm4MCbpieZcsjIJi2G/EroqM47yy/CZ/sIg36gGma05O6z+HTAUBG/7I2X3Gf
	 o9T1kBjo98fJE7D/BqnPmANlKYfaP6JNdJlQi3j5JQ9x63HxlVx8j5EZpERm1Y/GTl
	 MjG2PBBU2ELfw==
Date: Mon, 16 Mar 2026 16:28:47 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] KVM: SVM: Drop RAX check for SVM instructions
 from the emulator
Message-ID: <abglmIn4N5bJe5Ql@google.com>
References: <20260313001024.136619-1-yosry@kernel.org>
 <20260313001024.136619-2-yosry@kernel.org>
 <181d8563-14a2-4429-9e18-ede7a6aeb030@redhat.com>
 <CAO9r8zMxLx7fGGp1JPWatGNauY8fZvSECNGzC+o-p41BZrRGFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9r8zMxLx7fGGp1JPWatGNauY8fZvSECNGzC+o-p41BZrRGFg@mail.gmail.com>

On Mon, Mar 16, 2026 at 06:49:35AM -0700, Yosry Ahmed wrote:
> On Sun, Mar 15, 2026 at 5:55 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 3/13/26 01:10, Yosry Ahmed wrote:
> > > Outside of forced emulation or code stream rewriting,
> >
> > But isn't that the point? Due to code stream rewriting or intentional
> > usage of stale TLBs (so that the processor executes one instruction and
> > the emulator another), the emulator cannot assume that it will "never be
> > invoked with an actually illegal RAX".
> >
> > I realize that I'm late to the show, so I apologize in advance if this
> > has been discussed before.
> 
> Thanks for chiming in. FWIW, I initially intended to fix this check
> instead of removing it, the removal came after a discussion with Sean,
> see https://lore.kernel.org/kvm/abH0RdnM29Xyh_4G@google.com for more
> context.
> 
> TL;DR is that the emulator support for VMRUN/VMLOAD/VMSAVE is
> broken/unsupported anyway, beyond checking for intercepts and
> pre-intercept exceptions (well, even that is broken), and the RAX
> check should be after that architecturally.

No, this is wrong. I believe Sean's read of the APM was incomplete, he
quoted this part (which I did include in my changelog):

  Generally, instruction intercepts are checked after simple exceptions
  (such as #GP—when CPL is incorrect—or #UD) have been checked, but
  before exceptions related to memory accesses (such as page faults) and
  exceptions based on specific operand values.

But in table 15-7 for instruction intercepts, the rows for
VMRUN/VMLOAD/VMSAVE have this in the priority column:

  Checks exceptions (#GP) before the intercept.

Unlike other rows that specify #GP on CPL != 0.

Additionally, in the VMRUN pseudocode, we have this:

  IF ((MSR_EFER.SVME == 0) || (!PROTECTED_MODE))
    EXCEPTION [#UD] // This instruction can only be executed in
                       protected mode with SVM enabled
  IF (CPL != 0) // This instruction is only allowed at CPL 0
    EXCEPTION [#GP]
  IF (rAX contains an unsupported physical address)
    EXCEPTION [#GP]
  IF (intercepted(VMRUN))
    #VMEXIT (VMRUN)

The pseudocode for VMLOAD/VMSAVE does not have the intercepted() check
though, but I assume it's the save as VMRUN. I did confirm that with
vls=0, vmload_interception() is not being called on VMLOAD if RAX=-1ULL.

So I think the RAX check is actually intended to happen before the
intercept. I think I will go back to fixing the RAX check instead of
dropping it. 
