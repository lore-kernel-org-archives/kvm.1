Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CCD33BBB1;
	Fri, 30 Jan 2026 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787962; cv=none; b=AsanWpNorDEz8eiMl8lvM66BmpM95U1N4Jrol43fD5x7tgCy2wV49iqfh7xWaLsGwKHSEnhgMed7VFfPt4cvWL3dxsaLnkiPJRFOrm0x8QjTIlD5uxR/8J0iByOGRp4g18sQ8YNUQFmkpkWjFqEChxZwrqEiuBu3al9BNnD3Jog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787962; c=relaxed/simple;
	bh=R8hjjlLqXHUgIxbS7cySvI+FSe63UlG3ERCJVG789W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K82hSjEL5QqNb4t/MkGoUGCPzgTbAdlZ1q3RAFnhbWE3XBKRrvn2mydM8qZJyrnQELIkCSQhZvksUAN9YrTdDz/bsgB9I4iLpfuPEVzIoVR1zbR9NLZzPL7xWwj21tr/aJ1HwZA45Qv89hpqYYfodJorOF3oTMmiq39lVGxoi/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Bw/BoPpc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Bw/BoPpc"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 506B940E01A3;
	Fri, 30 Jan 2026 15:45:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RBEiLlQbrqyW; Fri, 30 Jan 2026 15:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1769787954; bh=5AByOYUAjJfXCFaukea9DVG9ubECSe9kqGxiXxsLclo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bw/BoPpcZGu5fOEzxShw7rJR9OHAUuHKxZKBskYrML5ARA9BRaIgDreVCvwv3AQGK
	 oBkLtxs9GxTjwCDN4KgFT7gNBexBbuR+Virt9hCEbKveuWAMj5auwI4fk7RremKlXY
	 /gD6wq0XFqCICh3MOtZP3ezDqmD3sd8HaxhCsY9FeVfZOK8Nk26asv/x+Iy4WvIErR
	 pE4xi3XJft1HX6mzdXa3fpYkhCvHzipblFAEmTX7ezQ66b0tr8VL1nNVuIt2AEF074
	 aI0QxXgjJXifTkdxykoaOv//ocl9/YJV6T6Krb8XsgqV6w6NdICtfTMRefJ6UGmAY3
	 2Nk+wcSjvAyCy20eUFZe92sWJ/UN7e+4ZI5d2SM2CVmJ1C6NmvuLowFvZLKzdSdTQP
	 C3cUtTDQRhEgVGpafWO+KZ2We68ZZzp+INvqkKoSIWBHSKuOishSQ7IS4JBf78vau8
	 0JPtzjl4Wm9mEJVgI9pdPzxtfABafyrRGZTuOetBktK6P/VwHSMF334P5ADS4hiYJ8
	 0qPtuDK0CDW2+Oqh1xkAY7dgq/UCMHv84BZBA+oYdbC7px4peUvtxW8AT4DCjLtAym
	 GFc/Gk4XS2aFVryLYqc6oLHfMtaOgV9RFLxGtlNSOvweMJBLzgNe2k9/sCmRQXKp3r
	 AS4sgyx2k5N/5qJSyE2VE0pg=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7458F40E00DE;
	Fri, 30 Jan 2026 15:45:40 +0000 (UTC)
Date: Fri, 30 Jan 2026 16:45:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kim Phillips <kim.phillips@amd.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Naveen Rao <naveen.rao@amd.com>,
	David Kaplan <david.kaplan@amd.com>, stable@kernel.org
Subject: Re: [PATCH 1/2] KVM: SEV: IBPB-on-Entry guest support
Message-ID: <20260130154534.GCaXzSHgkEFnk5mX14@fat_crate.local>
References: <20260126224205.1442196-1-kim.phillips@amd.com>
 <20260126224205.1442196-2-kim.phillips@amd.com>
 <20260128192312.GQaXpiIL4YFmQB2LKL@fat_crate.local>
 <e7acf7ed-103b-46aa-a1f6-35bb6292d30f@amd.com>
 <20260129105116.GBaXs7pBF-k4x_5_W1@fat_crate.local>
 <f42e878a-d56f-413d-87e1-19acdc6de690@amd.com>
 <20260130123252.GAaXyk9DJEAiQeDyeh@fat_crate.local>
 <2295adbc-835f-4a84-934b-b7aba65137a8@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2295adbc-835f-4a84-934b-b7aba65137a8@amd.com>

On Fri, Jan 30, 2026 at 08:56:07AM -0600, Tom Lendacky wrote:
> It can be added. Any of the features added to SNP_FEATURES_PRESENT that
> aren't set in the SNP_FEATURES_IMPL_REQ bitmap are really a no-op. The
> SNP_FEATURES_PRESENT bitmap is meant to contain whatever bits are set in
> SNP_FEATURES_IMPL_REQ when an implementation has been implemented for the
> guest.
> 
> But, yeah, we could add all the bits that aren't set in
> SNP_FEATURES_IMPL_REQ to SNP_FEATURES_PRESENT if it makes it clearer.

Right, that's the question. SNP_FEATURES_PRESENT is used in the masking
operation to get the unsupported features.

But when we say a SNP feature is present, then, even if it doesn't need guest
implementation, that feature is still present nonetheless.

So our nomenclature is kinda imprecise here.

I'd say, we can always rename SNP_FEATURES_PRESENT to denote what it is there
for, i.e., the narrower functionality of the masking.

Or, if we want to gather there *all* features that are present, then we can
start adding them...

> If we do that, it should probably be a separate patch (?) that also
> rewords the comment above SNP_FEATURES_PRESENT

... yes, as a separate patch.

Question is, what do we really wanna do here?

Does it make sense and is it useful to have SNP_FEATURES_PRESENT contain *all*
guest SNP features...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
