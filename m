Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFBC3F3297;
	Thu,  8 Oct 2026 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446397; cv=none; b=J2HlXCZF8MebDblmElp8Dwd18GyJU6djb3v9r/JiVOu0DNSsSJmlYjcN4ZXgvodRLFsgbX4zTdOsxY8Xsn93A1IwEg9fWaFa/RXof9/doOihiAYAD4nISyvTzLQUgSA9Bgt9cDJmrTuZy5LZiC2DE5HuN2ro0wdG3PUKRHuM6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446397; c=relaxed/simple;
	bh=5qiymqTm55xdehbhkUlU70UtU4+ZUyVHrcwFM54inqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohgWIwOgUYu6INuKWc0YimaLFVNoI1jvqAIsP7RhrHmDYDyG8Bfy0hudDGS8NssCuDmbYMuXa1ASnoSw9cxIYLaw7mzFXmS6SwLeNzKa6NXfD4HX/Jh1mm5/dHxJPbYczeRNDCqxG7JDlVVyB3ZhHQtNWHj+XHKtVO/tr5/V6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpTF3f+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpTF3f+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ABA1F000FF;
	Thu,  8 Oct 2026 07:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791446395;
	bh=XXdb1PMRkACtrUnm1F2Z/BVVymwhhAVPvnA5Qr8Nq0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BpTF3f+fdM/3KXjLcRi+nnsw+sUn76B9xwO+EoJ3uXc4G9wBLNXzvBdt08K8eBLTM
	 9UkKObKs95HWSY/mHhT7FpCck5vCNVJ8m6H88VTidxx1QS7Bq7Og7qGNm63XR8CJCu
	 JjaP6p39aFRfVOvB01ShvNJOpAB+muiHjuL1MClZYVjer0Vny9+bpjGBlMVoXShOW5
	 z5jhuQc4za0yAuWMHhvVdFjlS9qcVbwJG5ly8mBFbgpefu4qz3A54GnfubYGZsg7XU
	 tgBEv/ceq7jr40uVzCCa1AdZgrRvHR5xu4OCC1wrkeOWxRo8Hkr9iy8vPQ6uORliAp
	 1uaEGAIUYOaLA==
Date: Thu, 8 Oct 2026 13:27:58 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Tianyu Lan <tiala@microsoft.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [RFC PATCH v3 02/27] x86/apic: Drop savic_eoi() in favor of
 native_apic_msr_eoi() for Secure AVIC
Message-ID: <asdKMoiYva-lbs6f@blrnaveerao1>
References: <cover.1783490022.git.naveen@kernel.org>
 <36c039713c4b03c87b636635cb4c1f8b98c15eff.1783490022.git.naveen@kernel.org>
 <20261006032024.GEasRo-APHHt24pP4g@fat_crate.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006032024.GEasRo-APHHt24pP4g@fat_crate.local>

On Mon, Oct 05, 2026 at 08:20:24PM -0700, Borislav Petkov wrote:
> On Wed, Jul 08, 2026 at 12:02:00PM +0530, Naveen N Rao (AMD) wrote:
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
> 
> So this sounds to me like we forgot some detail while spec-cing SAVIC. Or
> maybe for SAVIC, KVM should not accept them on behalf of the guest anymore.
> But what do I know...

There were some changes proposed for KVM previously around this:
https://lore.kernel.org/kvm/20250923050317.205482-14-Neeraj.Upadhyay@amd.com/

The idea was to have KVM track the injected level-triggered interrupt in 
its copy of APIC_ISR so that it can issue EOI to the I/O APIC properly.

However, this would require some guest changes at least. Either:
- issuing a VMGEXIT on each EOI (regardless of APIC_TMR in the guest 
  backing page), or
- tracking level-triggered vectors in the guest and issuing a VMGEXIT on 
  EOI only for those.

The former is problematic since guests can queue IPIs themselves, so it 
isn't always possible to ensure EOI exits correspond to a previously 
injected I/O APIC interrupt. For the latter, guest will need to do more 
work to track and issue EOI accurately. Doable, I think, but it isn't 
clear to me that this is worthwhile, especially for modern SEV-SNP 
guests with Secure AVIC support.

> 
> Btw, In the future, pls split such conglomerate commit messages into paragraphs for
> better/easier readability.

Sure.


Thanks,
Naveen

