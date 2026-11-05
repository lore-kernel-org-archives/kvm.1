Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840674;
	b=Yu8jQltFaUZZzBWB+kRatPJCFvVnjxR+3fqK9d/BeN9iPH1OF+S1VPkKU9QFMv0mkDIP
	 zk1sW9YgBn6tVzNkIPn0/Zczk16IRSyyj+DhYX+iWsi2h0vnTYqy+1a8aGm2/5V89Vv44
	 RI0a6p+RwgghWs24NZvnqKp57n82o1IXfVd0NMaz6/ojUssue5+YnKUFJ0RYglFZAY9w/
	 pblRUBiTasI9kAsA8yCQcNQjmTq/7yaUdP+cUbzgpdFKCoXxfOmjZBDSeopxHLHStMsyu
	 d2KGwQ6N+BIyQqVpAirosurS0cwmf/4exhGRYldroe3Ki5ddLyCeABRW206H+cp9s8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=J/V2MM3Nib55ymN1PFersWhxlUY9HQHd9IKSm1IBsNY=;
	b=Oh3OGi0Y+QCrvsBvzilcH/GE+XH3Nv1ObwSSyDPY4Vnc9Na4RWQzWSiqGRB9cJgEDQCQ
	 fIAV0HoMu9BjEMO8eQFwVuXACMElEdbd3VpNy0biHBvHgmIh8hCuUNmg7FlqJyarCYwp7
	 sdpKb3+C5c9q95x5YoeFhtXgPYuQC3xcM42xgzz46D9Kx2wZICXx+4FIK7coavl7ymmtz
	 OgS7Qx7yBohKcajgGfS2l+12Q1ZuRj65urRyzSdv8XPCToXwUlEDvGyIQxtBxNAaDmNJI
	 DR3QWXCwukFWnq1Y3GvyO83qYIFdXGCa4z3IvGUfuZevn5i6N2OjWAvZb8Stzppo/VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oG4zRK4S;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35335606A31B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 01:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35335606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oG4zRK4S
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so2362506a91.2
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 17:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793840672; x=1794445472; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/V2MM3Nib55ymN1PFersWhxlUY9HQHd9IKSm1IBsNY=;
        b=oG4zRK4S8PvjualjA/itAs84LB8JRSICFRfbzDOWgCLXhDpXlpJ9f12Lt29Znc/w83
         p0FXpWJ/owTAywNIlMF+2HtLla5kGC0uyHH0jSVrO+bZqRk6mAWT65QmIHE8oYcrrxqw
         p+5j9DCwCqmMH1AXWUv6XhkhPonulJaK0kuD6nTS4Oseh2fqMndgF1BjUS40a33MIeq+
         vhooPe3TQ3954UtYzGjhO88H8MV7oOLqzKtkQQjXynwksHREsvkLZF91wwmiHwpHMX4G
         +kX9jp9zmBVKn9N5njPTxlXQA/sprUwXx7iLR09fLMuGUdThkOBb0Ha3mokUrxQn7mT4
         GeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793840672; x=1794445472;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J/V2MM3Nib55ymN1PFersWhxlUY9HQHd9IKSm1IBsNY=;
        b=zT6yIG7VAakBvxUqokoOUzwsPh0SdOLkYG2fAOJzXJB03lPym6NQVwSb95SDiPzzIZ
         g+MdOY7iijFS2c4NA07rfNbwwQCR7ATC5TNOCj72KMQBZ1ah/1V7xpe8T9UZATVApjtW
         5GcOfx7ELna03i9dRaq2D2s5LkG7lrHlEtzEOIzmTZ0oZu31TFTH9Jy+RvTX2Oeycdlw
         QdyZR4s25bxlQ3iZD5t8P+who5futQVhRBBpqwKrQDdPiqyheR1Viecnyf6aUByZeomU
         RDe9mNQ2o2t1fYzrIL2i99kFty0dpX5bzkiM2Bu2fV447Y9BqEmswF0THYpDFwt59Bfl
         002w==
X-Forwarded-Encrypted: i=1; AKwUvByGdcG5UY6/mFIRbvYVN1T8nn9/B7VI6GT2u1Nl03SOxEJMBX6H+z6vi6Vt6VS1EY0KZ34=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yE6XrhR9JTnHq/Wt3IXuFtGD/RaOtbHQQBpVLKU3r4ayses2K
	ucb9JuxJEhQAmwQNCfNIL1FqHPeKgMiytfRZZFPpykyy220HIHkLzesSWuPxOFMABwZ3C2ig4Yj
	XyYS+SA==
X-Received: from pjbkr3.prod.google.com ([2002:a17:90b:4903:b0:3ac:24b3:3484])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a84:b0:39d:84af:a0b3
 with SMTP id 98e67ed59e1d1-3ae897ea4admr14009144a91.18.1793840672374; Wed, 04
 Nov 2026 17:04:32 -0800 (PST)
Date: Wed, 4 Nov 2026 17:04:31 -0800
In-Reply-To: <aujZ6BuUPcKMzWZZ@blrnaveerao1>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1783490022.git.naveen@kernel.org> <36c039713c4b03c87b636635cb4c1f8b98c15eff.1783490022.git.naveen@kernel.org>
 <5f6bcceb-1c48-43e5-bafc-8f86676c4092@amd.com> <alX59ewiXXSx7J3R@blrnaveerao1>
 <asSSU2huZDlusYdG@google.com> <asXlwARv1cE1RREu@blrnaveerao1>
 <atDVyVCeUFafWPHm@google.com> <aujZ6BuUPcKMzWZZ@blrnaveerao1>
Message-ID: <auvWH8JDpc7cbhVO@google.com>
Subject: Re: [RFC PATCH v3 02/27] x86/apic: Drop savic_eoi() in favor of
 native_apic_msr_eoi() for Secure AVIC
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tianyu Lan <tiala@microsoft.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 03, 2026, Naveen N Rao wrote:
> On Thu, Oct 15, 2026 at 06:31:53AM -0700, Sean Christopherson wrote:
> > On Thu, Oct 08, 2026, Naveen N Rao wrote:
> > > On Mon, Oct 05, 2026 at 11:16:51PM -0700, Sean Christopherson wrote:
> > > > On Tue, Jul 14, 2026, Naveen N Rao wrote:
> > > > > On Mon, Jul 13, 2026 at 12:43:45PM -0500, Tom Lendacky wrote:
> > > > > > On 7/8/26 01:32, Naveen N Rao (AMD) wrote:
> > > > > > > Drop savic_eoi() in favor of using the native helper that writes to the
> > > > > > > APIC_EOI MSR. savic_eoi() was added mainly to be able to handle
> > > > > > > level-triggered interrupts. However, it relies on APIC_TMR indicating a
> > > > > > > vector to be level-triggered, but APIC_TMR can never have a bit set
> > > > > > > since it is only updated when the LAPIC accepts a level-triggered
> > > > > > > interrupt. In the case of a Secure AVIC SEV-SNP guest, all
> > > > > > > level-triggered interrupt sources are in the VMM (emulated IOAPIC
> > > > > > > primarily) and KVM accepts them on behalf of the guest resulting in the
> > > > > > > APIC_TMR in KVM APIC backing page having a bit set. This is never seen
> > > > > > > by the guest, which has its own private APIC backing page. As such, the
> > > > > > > savic_eoi() handler is dead code. Remove it.
> > > > > > > 
> > > > > > > Fixes: 43b6687ac877 ("x86/apic: Handle EOI writes for Secure AVIC guests")
> > > > > > > Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> > > > > > 
> > > > > > Another guest change which should be separate from this series.
> > > > > 
> > > > > Yes, I have called this out in the cover letter. I see now that I should 
> > > > > have used a better subject for the cover letter though.
> > > > > 
> > > > > > 
> > > > > > Is this causing issues with this hypervisor support or is just code that
> > > > > > is never invoked? Do other hypervisors behave the same way and will
> > > > > > removing this break them?
> > > > > 
> > > > > This is code that is never invoked and is independent of the hypervisor.  
> > > > > No impact to hypervisor code.
> > > > 
> > > > Doesn't that mean level-triggered interrupts are fundamentally incompatible with
> > > > Secure AVIC?
> > > 
> > > I think so, at least from the hypervisor front. Secure AVIC uses a 
> > > guest-private, encrypted APIC backing page. KVM's APIC_TMR is not 
> > > visible to the guest and the only injection mechanism is via 
> > > VMCB->Requested_IRR field, which can only carry vectors. This means 
> > > APIC_TMR in the guest backing page will never be set. So, all guest 
> > > writes to APIC_EOI are accelerated and do not cause an exit.
> > > 
> > > The guest could track level-triggered interrupts and notify the 
> > > hypervisor though. But, it isn't clear to me that is necessarily better.  
> > > Linux already seems to have a fallback which works for I/O APIC (see 
> > > below).
> > > 
> > > I believe TDX has similar restrictions?
> > 
> > No.  VMX lets the hypervisor select exactly which vectors will trigger a VM-Exit
> > on EOI, via a dedicated bitmap.  Only SVM's approach of keying off the TMR is
> > problematic.  FWIW, SVM's approach is flawed in general because it makes assumptions
> > about hypervisor behavior that don't hold true, e.g. see the games that have to
> > be played to deal with RTC tick stuffing when it's wired up as an edge-triggered
> > interrupt.
> 
> Agreed w.r.t VMX vs. SVM.
> 
> However, as far as I can tell, for TDX guests, the EOI exit bitmap is 
> not honored and so, level-triggered interrupts are incompatible with 
> those too, no?

Oh, right, duh, I see what you're saying.  Correct, TDX (deliberately, IIRCK)
doesn't support level-triggered interrupts.
