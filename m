Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528011;
	b=DUHi1nZkfTcWE2n4c7aV95ka2tFFGPPfjUJ6gokrZqxDRIsoMdc85iQAXB72eruzP4WY
	 KLY2THI/YpROZDRrjrmcSZVVH2mQThLfQ5ou1yu6n214UjHtLDpg7R9yFKUhSiNZPh1ny
	 sx3p49zjkGQ5B8I6xTXPPr7IFR50geMblxKRlZNUhsgnK57sO64+4bR59YZJQTT+sWqw7
	 ZJ4k2hkbr+RRWoemBH8EyrDh/ajN/cMf1/gTaePG8o5nnTV55fzEv3xtDF511OwhqZJ2Y
	 J4w0VDXzdSqx/9QGurRRA2SOvPUiNS1NnZ2KyHGW6vIZHcsEBbMeKg0/dc5fvL0qMew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528011;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=tB2CDFSNAQHG63R1fKA0lxUFEzusvt8zbvQv1xopf0Y=;
	b=Oi/pB97OfkRuSd6whumhXTeLBRhyQPOzyJwngdox0Hb2QR/kmK7uSkIONm12tDGTIkaW
	 gZxnn3DNO+EoIJT7Ge1h0BQm64YiUYkcs2Tgc5sJIapcv44iB2LbZ9gyT6vLGTE0vDXRL
	 sJbFFNfRNoIDvgUJ79cUkpV8dWj4aoRqpWnv6xQto7WCTcdB6lJOjUAF0kqYSyBs8C+dd
	 RpXzS3EMBMaeenKDb75kx+1cX1s/2EHRvd52JVsuGXhU4TzOzSFP3mXCpHvDrELxGaTDD
	 lJsO5VURXIM0hHgYkEH9lpvWLb6IDQrHHEAjxXlrIQ2gJzLoI1tROlXbu4q1s5HZYjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="OoMAyUJ/";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=lYXL7NEv;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A7606A33A;
	Fri, 13 Nov 2026 00:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE0A7606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OoMAyUJ/;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=lYXL7NEv
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794528007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tB2CDFSNAQHG63R1fKA0lxUFEzusvt8zbvQv1xopf0Y=;
	b=OoMAyUJ/fVovEwUQuTaBvbYZTnrRLX5QQkC91oB02/YyobUoIwW1FhNg+JOWuPLuGyPf2j
	X5e3UIFCnSefmSvgweufvhRgLM0TAHAu8kEv8LImb0pfQd3Fb5Os3WLLpHKPtJQVtidJV7
	kVDKJQINh2Q4u4vYAycblw0GdHA+cgWm+X6TAe+qn2TAxBn1pcCfqNGIV+Z7HJ4eljWdDW
	E1fOib0GIjR3wZUD6oPZmqJeb2/ftYF8ba6veeeISqYsy7c35VhmhiKD48HJsv/pqlC7NH
	Vb0Gd1bmqOoC14ssk4mq3Su94o9qgEaQKUoAFPcsMuIchO/G/6xV+SZ66DEhMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794528007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tB2CDFSNAQHG63R1fKA0lxUFEzusvt8zbvQv1xopf0Y=;
	b=lYXL7NEvwjrqgd4ZBfhr7W9Jh6ZSAzPXE3Uq4+yYP9LpzbBB1+qQxyzNY6eoKH6d7Glw16
	4sH4GAT17UoKLsDA==
To: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Breno Leitao <leitao@debian.org>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 vlad.wing@gmail.com, security@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 6.18.y] x86/cpufeatures: Make X86_FEATURE leaf 17
 Linux-specific
In-Reply-To: <20261112233327.GBavZMx2etyTFh1be4@fat_crate.local>
References: <20261111-stabe_srso-v1-1-45512320ba5e@debian.org>
 <20261112045703.GAavVHH8KA2yyCU7oc@fat_crate.local>
 <9492bce8-aab7-4982-8a0c-7d736c745e12@zytor.com>
 <29B14106-19E4-4589-BE40-3D42BA646CE3@alien8.de> <87o6btsl4g.ffs@fw13>
 <20261112233327.GBavZMx2etyTFh1be4@fat_crate.local>
Date: Fri, 13 Nov 2026 01:00:07 +0100
Message-ID: <87ik21sirc.ffs@fw13>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 12 2026 at 15:33, Borislav Petkov wrote:
> On Fri, Nov 13, 2026 at 12:09:03AM +0100, Thomas Gleixner wrote:
>> Even if a new leaf has only _ONE_ bit defined then it's a new leaf. This
>> whole "save space" nonsense has been source of a gazillion of subtle
>> bugs in the past and we just continue to "fix" them instead of actually
>> tackling the underlying problem.
>> 
>> Linux specific leafs want to be in a space which is reserved by
>> hardware for software purposes and not arbitrarily hacked into "holes".
>> 
>> Hardware defined leafs have to be represented by a proper entry even if
>> there is only one relevant bit in a leaf.
>
> Are you saying we should get rid of scattered.c?

Yes. It's an abomination as you know very well.

> Well, as a matter of fact, after stopping this silly nonsense of having to add
> a cpufeatures.h leaf just to advertise feature bits to a guests, the space
> saving is not really important anymore. We're much better there.
>
> So I could whack scattered.c, we make it a rule to allocate a new
> x86_capability leaf when we need it and then we will switch to the stuff Ahmed
> has been working on eventually, when we get that upstreamed.

Emphasis on eventually.

So another twenty years to actually have a proper design in place for
something which just resulted in duct tape layers since the initial
CPUID/feature management design mistake was made twenty years ago.

Until we get there we just add more duct tape which interferes with the
cleanup, right?

> Anything else missing?

Yes. The fact that it's ridiculous that we still have to debate this.

The time wasted on that, the time wasted by people to decode the subtle
bugs and the amount of AI tokens wasted to come up with more duct tape
fixes is at least an order of magnitude more expensive than funding the
completion of the overhaul.

But I just "work" here so I might be missing something important which
justifies that ...

Thanks,

        tglx
