Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF212AD35;
	Sat, 11 Jul 2026 04:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783744650; cv=none; b=LERXxTpxxNmuDOrivb1XsgnL6btl8XhNVWKrzWQ8IOT5FQsKal20qg6dIrj6VDBTPCXoiUDINFhCB0rtqTLJkQo1KBkrZsrYGpYvxNzm37JyIPbOF5gzFFi/1Aagtg0BLzRiN6waQoduTzmLEqPAKRL/a+x90XUjldO81Teslck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783744650; c=relaxed/simple;
	bh=blsvIQptIXihjNTMDat5Bo07I/99InUE4kOzUW38Ywg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EY1CTlB94TYlGdNBVhB94Ku0sC3aQjRkfu5nT6FUqyMb8iKaChUQydfkKQR41Da2GJevm5YspkIRAznNeSpqipt+luzNLwxLoGMo0gZn17LcerGxUZEe450nAGQlveO9m807tH39KY7aHGfWY3hLa91b/uqh2LjbPIf+TU2msRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QN1Jz0+p; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QN1Jz0+p"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5860640E00C0;
	Sat, 11 Jul 2026 04:37:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JkGOu0WtGrdS; Sat, 11 Jul 2026 04:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783744636; bh=GIv6tjXNV6J/+db6nXk27xJr3fHNF2B5ol8TMky1cVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QN1Jz0+plACDdGvwesV5dFDG/G5aDLu+r+fiax4GkUAsJ45551nT1fQCteH0v1D+u
	 qyr5WktyBsQwgmJPctWLxJ4lpvPx9GYQo9m2TAbDBWH2rYCz9ei+gXNDW5rQaTsHM7
	 ikBvpGRh7hBJI/L+lsuE+ha/3sVMIeUhxUamp/G0F1NjrQHANjd/f/zDHydUU/nYHO
	 Z5rDhUWUIOAA++oQznguttZbCh3Gmj+41UH5YwoaLodP6joQ917wpZPeYUlad4x9V/
	 Ub+kaQ0nW6E+rTGzsn7EpzcywbbMDmOVocl1Uiaj5WJmpyiGoA1zOO92V7hCYy4wgz
	 6mhXl5DsjmafomJk3O+isMXo6IsdfoQA6R+npEVjMzlUDsx7UTHwCEvLtcM3BfkIMH
	 rP7EiYuKl9GxnU2lL4aAbdGDP6EN6znff76hufyhKOo8QIT9MgtkcFYCZu8XCWTHHL
	 0ovsHXk2Bspzz/BctFe2SAd1hAC826l90jzmrnnUp4Z5FS5zEkCgaYHORal0rO7ew3
	 /IqnGlIge4HCNtQwKgjoNammAXMlpSGEtQZT0ZHdHSNeBCKoNwl5dA2D4KJMtfNMpR
	 IRBjm7oaScOokfUTL4mQDgCYnWIzbVwgAG9Sj9gM8onCrxdb6Dq0iQHOQEdrPdFjDO
	 eeUbKDmrH1b2dc8JZNOnnasA=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 826EA40E02B0;
	Sat, 11 Jul 2026 04:37:04 +0000 (UTC)
Date: Fri, 10 Jul 2026 21:37:01 -0700
From: Borislav Petkov <bp@alien8.de>
To: Naveen N Rao <naveen@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [RFC PATCH v3 01/27] x86/apic: Propagate APIC_SPIV writes to hv
 for Secure AVIC
Message-ID: <20260711043701.GFalHIbbbNQ97S1Qoq@fat_crate.local>
References: <cover.1783490022.git.naveen@kernel.org>
 <891e7c5b74a9c027bc417a2dd32e23c0d4d0c336.1783490022.git.naveen@kernel.org>
 <20260710020349.GAalBTBSz6pX3FA_fd@fat_crate.local>
 <alEEqV6NshD-T2K9@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alEEqV6NshD-T2K9@blrnaveerao1>

On Fri, Jul 10, 2026 at 08:32:23PM +0530, Naveen N Rao wrote:
> Guest doesn't boot without this change.

Then give the commit message a second try and explain exactly the situation.

> APIC_SPIV has a bit to (soft-)disable the APIC. It starts off disabled 
> and the kernel has to write to it to enable the APIC. If writes from the 
> guest are not propagated to KVM, KVM does not deliver interrupts to the 
> guest since the APIC is disabled as far as it is concerned.
> 
> I will update the commit log with these details.

Oh yeah!

> I was genuinely unaware of this. Just so I get this right:
> - Add just the 'Sob:' for patches from others that I post un-modified 
>   (without a Co-developed-by: tag)

Yes, if you're handling the patch - it passes through you - SOB.

> - Add 'Co-developed-by:' if I make any changes to the patch (commit log 
>   included?)

Co-developed is when you've put a more serious effort into the patch than just
touch ups, I'd say.

But we have it all documented:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

especially:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

which answers your questions exactly.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
