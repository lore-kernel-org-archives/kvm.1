Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B543CEE9;
	Tue, 14 Jul 2026 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020348; cv=none; b=eGzAJoSBESSpocZwC28XyX9p2w/aXKpX51T8/uiRh2/YLlGGFGOEVHqygk89kV++WevsoZYsORgc9QSKuKdNUkM+vCYMrx5V/M23vuETqIt0thd/vlO3VMJeo9LeyV+7BWXVJe5Ztmdvl1jKX7C0ngJMTJHpkQAc7vuRCAPPaG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020348; c=relaxed/simple;
	bh=FUofyG3fvR2x0LRMq6UC5hEF6mJPWsbVWmisDp+v3NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBxMGntdmd/DqFbJ33xKpAA9dp4Rg5NFRBhpSagOb08qIS5vIAX5WshCMriZdvbWNEvkv1mhaCn44GLEdtQt9BQOgoqRk6JKWthDmUkxkwEkHFS9Aa3dM6U5P7XB6cbuGdHR7X+qfRINWRoqsqQvVmvRn7m6jQPZp9TrwCMneJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLh4HalY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLh4HalY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CC21F000E9;
	Tue, 14 Jul 2026 09:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784020346;
	bh=AtASesUYj8bK3TrkD1mcttSIpdFz5Ax2S722mDl9fzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gLh4HalY0LR498d3UrgoDSFxMa0Dky2LaOvGeASTkOwpigE9BiTvxWRDO5uY0/3VT
	 nrjIvQiQz5sjabQo8aEBNwx8bGmf+QIuar5/qmB9uNzQfnE/rszpeSySNYsRLNxXuA
	 iCMwH0M0Tw1/NziChKaLuAdLAymhWHgDspDG+2GtsYJRdWR0/t3rDtn3OuKoT+DjaP
	 PAMiz6t40am59o6VsFNhVFDaztiC7yGn37+CA9Or7w7Bl6axQQn79Mcikv4CKz2HW2
	 2vsjvI0Kze2Jz8dmofYy6HBQB3dvIGgWWUMZ642LPfBRXlGLBFodDb2E0qwkMD21WD
	 aM3nT4G3KD60Q==
Date: Tue, 14 Jul 2026 14:32:51 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Tianyu Lan <tiala@microsoft.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [RFC PATCH v3 02/27] x86/apic: Drop savic_eoi() in favor of
 native_apic_msr_eoi() for Secure AVIC
Message-ID: <alX59ewiXXSx7J3R@blrnaveerao1>
References: <cover.1783490022.git.naveen@kernel.org>
 <36c039713c4b03c87b636635cb4c1f8b98c15eff.1783490022.git.naveen@kernel.org>
 <5f6bcceb-1c48-43e5-bafc-8f86676c4092@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f6bcceb-1c48-43e5-bafc-8f86676c4092@amd.com>

On Mon, Jul 13, 2026 at 12:43:45PM -0500, Tom Lendacky wrote:
> On 7/8/26 01:32, Naveen N Rao (AMD) wrote:
> > Drop savic_eoi() in favor of using the native helper that writes to the
> > APIC_EOI MSR. savic_eoi() was added mainly to be able to handle
> > level-triggered interrupts. However, it relies on APIC_TMR indicating a
> > vector to be level-triggered, but APIC_TMR can never have a bit set
> > since it is only updated when the LAPIC accepts a level-triggered
> > interrupt. In the case of a Secure AVIC SEV-SNP guest, all
> > level-triggered interrupt sources are in the VMM (emulated IOAPIC
> > primarily) and KVM accepts them on behalf of the guest resulting in the
> > APIC_TMR in KVM APIC backing page having a bit set. This is never seen
> > by the guest, which has its own private APIC backing page. As such, the
> > savic_eoi() handler is dead code. Remove it.
> > 
> > Fixes: 43b6687ac877 ("x86/apic: Handle EOI writes for Secure AVIC guests")
> > Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> 
> Another guest change which should be separate from this series.

Yes, I have called this out in the cover letter. I see now that I should 
have used a better subject for the cover letter though.

> 
> Is this causing issues with this hypervisor support or is just code that
> is never invoked? Do other hypervisors behave the same way and will
> removing this break them?

This is code that is never invoked and is independent of the hypervisor.  
No impact to hypervisor code.


- Naveen

