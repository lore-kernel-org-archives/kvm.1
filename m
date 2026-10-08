Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE323D25A2;
	Thu,  8 Oct 2026 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445198; cv=none; b=QPUrSb79BovJpOCKcdMmvhU7q/WS/WVn34/ajMYOGYEJlTyqXbcf9KefDRqSptIUhyFkF2kW8RoWu97b2VOjs/qWS5qMeXNBhamHa40i6jxMOVkjw74whCOoQNc83rWo1fa3NZV+HSTfJem/zlWsfibBDWtEW1pbEmcuJ+Wz4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445198; c=relaxed/simple;
	bh=BXliohim3f/11B/NyJNQZCs8luaRUzNHcuHLEGPip3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0QgTTRPiX9/hMKbv/Kjs4ccy8J9FToGe8U4IHAd8FGYlcIqghhXtqAhPO7WZHSm4b8YZjZ9VwoT+cCa4X0DOQMFn1pFtvXfAEzAakYNdT/EgxPKpPwX73RmKSSBBAOcizQZvL4cHQJeFRK6B501qdOhRutDqc+mmAnWi1Hb1qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaqhK0tC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaqhK0tC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FF71F000FF;
	Thu,  8 Oct 2026 07:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791445195;
	bh=CY6cb7MQ4CjUMqGrTBGHTissFhPBASgdIVBTSfMZ4fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AaqhK0tCNaUGH1Cfs6UZE2ZlvE91lYRZDcfbKdav8wUfjNruU2gzjWZkHfUeoHkhy
	 pArXudiQZCnevngjwEA2UZkTyx6BNrfqyVpFp74fp7i2k3YeS5HkWJLP5oDiyxJDyl
	 v4MO/mbSBdv9OyDQkyv3Mvv/ZlC32IVNg3+pEYWEzXyqZH0u22bMCmN4Vk3zkJFmRQ
	 eQUTLYitqZRHDlUydEFds6CvWlSJJwgK9tfUysxyANrMnwJWCQE2kwsR80yLogzFoK
	 UmDc4R4DKeRSpoNWkfH9ymrXjMI8/JQJqzsZQ2e/kRzTGjBW+0JhOzwmr9F8uwgPj8
	 DV5OvshCk7E8A==
Date: Thu, 8 Oct 2026 13:05:06 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Tianyu Lan <tiala@microsoft.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [RFC PATCH v3 02/27] x86/apic: Drop savic_eoi() in favor of
 native_apic_msr_eoi() for Secure AVIC
Message-ID: <asXlwARv1cE1RREu@blrnaveerao1>
References: <cover.1783490022.git.naveen@kernel.org>
 <36c039713c4b03c87b636635cb4c1f8b98c15eff.1783490022.git.naveen@kernel.org>
 <5f6bcceb-1c48-43e5-bafc-8f86676c4092@amd.com>
 <alX59ewiXXSx7J3R@blrnaveerao1>
 <asSSU2huZDlusYdG@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asSSU2huZDlusYdG@google.com>

On Mon, Oct 05, 2026 at 11:16:51PM -0700, Sean Christopherson wrote:
> On Tue, Jul 14, 2026, Naveen N Rao wrote:
> > On Mon, Jul 13, 2026 at 12:43:45PM -0500, Tom Lendacky wrote:
> > > On 7/8/26 01:32, Naveen N Rao (AMD) wrote:
> > > > Drop savic_eoi() in favor of using the native helper that writes to the
> > > > APIC_EOI MSR. savic_eoi() was added mainly to be able to handle
> > > > level-triggered interrupts. However, it relies on APIC_TMR indicating a
> > > > vector to be level-triggered, but APIC_TMR can never have a bit set
> > > > since it is only updated when the LAPIC accepts a level-triggered
> > > > interrupt. In the case of a Secure AVIC SEV-SNP guest, all
> > > > level-triggered interrupt sources are in the VMM (emulated IOAPIC
> > > > primarily) and KVM accepts them on behalf of the guest resulting in the
> > > > APIC_TMR in KVM APIC backing page having a bit set. This is never seen
> > > > by the guest, which has its own private APIC backing page. As such, the
> > > > savic_eoi() handler is dead code. Remove it.
> > > > 
> > > > Fixes: 43b6687ac877 ("x86/apic: Handle EOI writes for Secure AVIC guests")
> > > > Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> > > 
> > > Another guest change which should be separate from this series.
> > 
> > Yes, I have called this out in the cover letter. I see now that I should 
> > have used a better subject for the cover letter though.
> > 
> > > 
> > > Is this causing issues with this hypervisor support or is just code that
> > > is never invoked? Do other hypervisors behave the same way and will
> > > removing this break them?
> > 
> > This is code that is never invoked and is independent of the hypervisor.  
> > No impact to hypervisor code.
> 
> Doesn't that mean level-triggered interrupts are fundamentally incompatible with
> Secure AVIC?

I think so, at least from the hypervisor front. Secure AVIC uses a 
guest-private, encrypted APIC backing page. KVM's APIC_TMR is not 
visible to the guest and the only injection mechanism is via 
VMCB->Requested_IRR field, which can only carry vectors. This means 
APIC_TMR in the guest backing page will never be set. So, all guest 
writes to APIC_EOI are accelerated and do not cause an exit.

The guest could track level-triggered interrupts and notify the 
hypervisor though. But, it isn't clear to me that is necessarily better.  
Linux already seems to have a fallback which works for I/O APIC (see 
below).

I believe TDX has similar restrictions?

> I don't see how the emulated I/O APIC will ever get an EOI.

My understanding is that the guest will have to signal EOI to the I/O 
APIC directly. Linux seems to do so (ioapic_ack_level() calls 
eoi_ioapic_pin() if APIC_TMR is not set for a level-triggered 
interrupt).


- Naveen

