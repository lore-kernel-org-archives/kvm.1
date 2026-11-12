Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509395;
	b=VIPESYOZRjO55c32sG8t+j3KA9AIblIt/bG7dyHTk1hBYyUU7B3c5F2GfAzO2sZhlReQ
	 XDWwdYidWxgCVwA6i/DjYTZYTezE4Qo8u9dcCQDc6WQ7yWP+HSmh1wcSragUudbPV/76d
	 YPOY2iCraUjcDwhpTjZZxhiFDouFuVsLfgGq/B450A2Z9xEfQOAl/QP7v61c4Q0DQsdyb
	 KTdn3byrxlyd6VY0sNvRVWsKllaCuRiw5QfqbsV5fljxWvQpnMZGhq4BjqsHALbr5ppTm
	 BOIzExtTqw+ZJUzLd0l8gYu0eqG4cUd1qYfHMe3VvmnumdvO9cvq8+BbdU5UrVrBFKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509395;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FEWlggs162FhFVPrPIGld2Gfxrm3EL58hFFmWLxOUWg=;
	b=nkwxKXXnWULJd4wPsE1ByFWKffyMxuu/qtkmlIOaYxqkhNxl5kyBehkEWHD4T1Nx7ybZ
	 wCIxjucdlJcoLx96QBldF8l1AG27c1XIRfixInwTQ1qEbJTMuJaq5TDQeupd7WAG8sgVi
	 +ZhaUzqIegt/OVySOMvW5yOKi+C+uR1bA/n/lust2uLg0q/WRWPiAcKsOMwcl6aKQWpGV
	 JSBrOVA8inZWqRfl/pyfSHp7+mwN8akyfCIm5QzhBgu4x7gkSVFWNJ4o0dZem7OeZ5UDn
	 uO5ESEAJPUSAyXZsyZZwHxaJSGFOFfud2x9Wm0wftG8JBRhTd5HOo+nXRt8gU8TkXcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="EmWG3x/G";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5D606A321;
	Thu, 12 Nov 2026 18:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEF5D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=EmWG3x/G
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ECCA940E0237;
	Thu, 12 Nov 2026 18:49:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UWxSyHXfrKDM; Thu, 12 Nov 2026 18:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794509389; bh=FEWlggs162FhFVPrPIGld2Gfxrm3EL58hFFmWLxOUWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EmWG3x/Gx6Bt4LkLC92Te6Ky5rkcXSySxN1UAc7XLAe25ON8QVQ2em8KmBb1L3aSZ
	 GefHgFWBn04RE2/MlP0amxq4zLGY18CNr+UFX1CIhJV4AFSy8kw0fBVroSk15yJADf
	 mam/eCWqeZgS/Cu05Jfne0lNELERYJ3QNDc8ar5a/HodLyYDPH0ANdQA9gBPzHzG4e
	 IkZy3sgWpcpMKCb4EelgVHIeO5DTwmamMkEFko/7i9oezDqTUW6dMB7C5XwDdyz2dj
	 yOZApmoUUah6OkPKH/Q83ZuYAm952X8O/JWjs3jYBpcnsSpiAXIgSw+LOyymrM5blf
	 whOJ4YP65xIyGDK9LVojdWHjdFFAtm4rNpF2v6yhXgK9y8GqGtxEeKolfXz20N8uJP
	 smtbD3UvMzAKkE1ay0AOtz5YAJq0jQi7OREpvkqQl8gzSsaqKzMydThGeKJ9/xhrOC
	 RW60fxGv+WP/GblcQ8T0Y31H6zbVrfwnbrh1xHz/N0kQtiK4A+LjPetjqIVun9MxSp
	 yWnIV0AKplWM1dvvsHcw072s9J1g4ExYwKBz4+fSDKYgCqIGJ6H+DQMNGoXU4887Fr
	 mrUWfJjDMK+TYTIHIya743i8i3NR/gJS8KMbFzmG7ivoSA8gpBgFZK0UbQ9hdHaVB+
	 E3Ef2pXLB19tn8P8Glol+uQQ=
Received: from stx.tnic (unknown [209.52.143.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E56C40E015B;
	Thu, 12 Nov 2026 18:49:35 +0000 (UTC)
Date: Thu, 12 Nov 2026 10:49:29 -0800
From: Borislav Petkov <bp@alien8.de>
To: "Pratik R. Sampat" <prsampat@amd.com>, seanjc@google.com
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
	pbonzini@redhat.com, thomas.lendacky@amd.com, kim.phillips@amd.com,
	nikunj@amd.com, michael.roth@amd.com, ashish.kalra@amd.com
Subject: Re: [Patch v4 3/4] x86/sev: Add guest support for Enhanced SMT
 Protection
Message-ID: <20261112184929.GGavYKObGQNQ0wbDpD@fat_crate.local>
References: <cover.1794244450.git.prsampat@amd.com>
 <c64b614ddc83eabc6bb1bdf288272110df04256a.1794244450.git.prsampat@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c64b614ddc83eabc6bb1bdf288272110df04256a.1794244450.git.prsampat@amd.com>

On Mon, Nov 09, 2026 at 08:35:13PM +0000, Pratik R. Sampat wrote:
> @@ -849,6 +850,18 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, unsigned
>  	vmsa->vmpl		= snp_vmpl;
>  	vmsa->sev_features	= sev_status >> 2;
>  
> +	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&
> +	    (sev_status & MSR_AMD64_SNP_ESMT_PROT)) {
> +		vmsa->vcpu_id = apic_id;
> +		/*
> +		 * The mask fully set puts every vCPU in one group, so any two
> +		 * of them may be co-resident. A legal ESMTP sibling must
> +		 * also match on ASID, so the sibling of a vCPU in guest mode is
> +		 * always either another vCPU of this same guest or idle.
> +		 */

This comment doesn't belong here.

In any case, this set touches multiple trees so I'm open to suggestions from
KVM folks how we should do the patch merging tetris eventually.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
