Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645720;
	b=FyqiBby99kUAnvfQjasdsmK/uPehwIL+ldhagd4kzbqItSYJ/pSitD5Qx8C1nx7cNbjC
	 iNKv6l56iKOyq8hWSp8lQzNG6J04YKPmQD+T+kzGid0q+zhvvHDqQIXzUFp4U8KKtdbyU
	 29es/CCXJzTy4HLxUh3MaTwwEaFH02qBBzqfyHfhLwHzxBAQTowA/oGT+3pkTh2dP0Zng
	 neEmwzqS7R5Eld15jBy2mCca1pTLc+X9Di475SvJEya/TwZXNY3N8hWc6b4SJbi7WrCaA
	 t2I0rG5x0vjTrFdbhBChVfYVWQqNqZ1kEkLEh/g/JNZZysKr/iOq93g/sZOXjKANEdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645720;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=q+a6d1VrvhVSJwinXzVZd6V4L8Mih7bk8gcaP4YRihk=;
	b=xZ4B7wt3b6T+/X8AtVTbTUjLSwsmnAXkN4Em0OjLse2Q2V0wheK/DFokUuX/zR0kRJun
	 LQbJ9qFEUSF22ucOFHVlAT5tSFkOweDDHI3G7TyFRG2wfWGkO5JiErEEnMLPJqWYG/aaZ
	 /EQDm5nA+J2kjz2/EmA+sCUL8RLGDnKR8Qhds/TWNtCXxLFrkkQkkhIjwrqB88a/ZwpgU
	 Kz22jWpNsRYac5H7stPp9s6irL/gc1vGaKRKkr/q0LI7aA1BccGxKIsm9gUX8kGCLebNk
	 OQm/Dv1fMrNy02/b/t7n6T4oohGYn/HZSh8RaDaqhofQ3ADNRPuqpIs78vgIZMGTuaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VglL4fs7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E91606A324;
	Mon,  2 Nov 2026 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VglL4fs7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FB01F00A16;
	Mon,  2 Nov 2026 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793645719;
	bh=q+a6d1VrvhVSJwinXzVZd6V4L8Mih7bk8gcaP4YRihk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VglL4fs7480mcJ92S08Hi5fuXYtW/GFNLFIzyF2BMe2RReH9hPsRkqGB2qUnI0kcp
	 hWMC/bX571paRKhGlOKsSf5JgG/faMJ4UFGFGIlnUFe/r2TFHzGtPEvSr1+Cnx/ErJ
	 uCvcCoL7n3MXcNyuJnqVQn2bumMNjj2XmTQ1Nbc4rP39IrJsJ+iKT570c5f2TN+G3l
	 tNE14seAOJ1i6sn7RxHH9w3sKjPIGl7x2gBBzfwxm2AA4HLFiQYg5NiUJWH4b9hE1N
	 vBdzpp/rZRLTqtzC69GzNOwZae/AEUuR36dwz1wZkAgIgoQ6xV6CNqO34oOYrRhiIf
	 AZ56LYyBzMhnQ==
Date: Tue, 3 Nov 2026 00:15:52 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Tianyu Lan <tiala@microsoft.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [RFC PATCH v3 02/27] x86/apic: Drop savic_eoi() in favor of
 native_apic_msr_eoi() for Secure AVIC
Message-ID: <aujZ6BuUPcKMzWZZ@blrnaveerao1>
References: <cover.1783490022.git.naveen@kernel.org>
 <36c039713c4b03c87b636635cb4c1f8b98c15eff.1783490022.git.naveen@kernel.org>
 <5f6bcceb-1c48-43e5-bafc-8f86676c4092@amd.com>
 <alX59ewiXXSx7J3R@blrnaveerao1>
 <asSSU2huZDlusYdG@google.com>
 <asXlwARv1cE1RREu@blrnaveerao1>
 <atDVyVCeUFafWPHm@google.com>
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
In-Reply-To: <atDVyVCeUFafWPHm@google.com>

On Thu, Oct 15, 2026 at 06:31:53AM -0700, Sean Christopherson wrote:
> On Thu, Oct 08, 2026, Naveen N Rao wrote:
> > On Mon, Oct 05, 2026 at 11:16:51PM -0700, Sean Christopherson wrote:
> > > On Tue, Jul 14, 2026, Naveen N Rao wrote:
> > > > On Mon, Jul 13, 2026 at 12:43:45PM -0500, Tom Lendacky wrote:
> > > > > On 7/8/26 01:32, Naveen N Rao (AMD) wrote:
> > > > > > Drop savic_eoi() in favor of using the native helper that writes to the
> > > > > > APIC_EOI MSR. savic_eoi() was added mainly to be able to handle
> > > > > > level-triggered interrupts. However, it relies on APIC_TMR indicating a
> > > > > > vector to be level-triggered, but APIC_TMR can never have a bit set
> > > > > > since it is only updated when the LAPIC accepts a level-triggered
> > > > > > interrupt. In the case of a Secure AVIC SEV-SNP guest, all
> > > > > > level-triggered interrupt sources are in the VMM (emulated IOAPIC
> > > > > > primarily) and KVM accepts them on behalf of the guest resulting in the
> > > > > > APIC_TMR in KVM APIC backing page having a bit set. This is never seen
> > > > > > by the guest, which has its own private APIC backing page. As such, the
> > > > > > savic_eoi() handler is dead code. Remove it.
> > > > > > 
> > > > > > Fixes: 43b6687ac877 ("x86/apic: Handle EOI writes for Secure AVIC guests")
> > > > > > Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> > > > > 
> > > > > Another guest change which should be separate from this series.
> > > > 
> > > > Yes, I have called this out in the cover letter. I see now that I should 
> > > > have used a better subject for the cover letter though.
> > > > 
> > > > > 
> > > > > Is this causing issues with this hypervisor support or is just code that
> > > > > is never invoked? Do other hypervisors behave the same way and will
> > > > > removing this break them?
> > > > 
> > > > This is code that is never invoked and is independent of the hypervisor.  
> > > > No impact to hypervisor code.
> > > 
> > > Doesn't that mean level-triggered interrupts are fundamentally incompatible with
> > > Secure AVIC?
> > 
> > I think so, at least from the hypervisor front. Secure AVIC uses a 
> > guest-private, encrypted APIC backing page. KVM's APIC_TMR is not 
> > visible to the guest and the only injection mechanism is via 
> > VMCB->Requested_IRR field, which can only carry vectors. This means 
> > APIC_TMR in the guest backing page will never be set. So, all guest 
> > writes to APIC_EOI are accelerated and do not cause an exit.
> > 
> > The guest could track level-triggered interrupts and notify the 
> > hypervisor though. But, it isn't clear to me that is necessarily better.  
> > Linux already seems to have a fallback which works for I/O APIC (see 
> > below).
> > 
> > I believe TDX has similar restrictions?
> 
> No.  VMX lets the hypervisor select exactly which vectors will trigger a VM-Exit
> on EOI, via a dedicated bitmap.  Only SVM's approach of keying off the TMR is
> problematic.  FWIW, SVM's approach is flawed in general because it makes assumptions
> about hypervisor behavior that don't hold true, e.g. see the games that have to
> be played to deal with RTC tick stuffing when it's wired up as an edge-triggered
> interrupt.

Agreed w.r.t VMX vs. SVM.

However, as far as I can tell, for TDX guests, the EOI exit bitmap is 
not honored and so, level-triggered interrupts are incompatible with 
those too, no?


- Naveen
