Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA443469E0
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778066606; cv=none; b=Y9Uu+dxcAI7zvnQUNhypkK3+d4GBiHpZzVx4hxvFswKWeuRRv+yirLa2ivALpQIuZAES22g3oct591Q6YgFMoMerdWIGRYc81uJMPK7rFou6lAPey1cCcQuQLQpBcLTfASaOKNCeriLhuTR3IttEPObD+AzCl+aIBRBoJ0uoYsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778066606; c=relaxed/simple;
	bh=J+4+XDqvcVOF08PSJ9ALOBQTTz0Xm8R+Ytm5q+oVbbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTu6Jf5AhzWJydMkTcg6DmhrD7ZITpHa+bst7zhNb4GQPhlRSv1n3XnG/hjTz33ftimIYiXldPji2ALZVai7ww/uk3m7W84BYkU1NO2Dq2VOJFIVvogtF7WtUJ6pEj8b5D5VBzP4ikmXOUpXndrsOlYn+ydxG25oJugnxlA+IUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fhd8mwnz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fhd8mwnz"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D64C040E019B;
	Wed,  6 May 2026 11:23:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6t_K8kTmxHZp; Wed,  6 May 2026 11:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1778066595; bh=wZq5mvLS7vtrsPx5AsfYWikVjhYvYXxhl5JGcniDvVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhd8mwnzN9rIOucVBTYOTnKIvdw2R2ZUT/SdofW7AgDqfmyN6Or3QZkTvjFZihlWU
	 eU5YjP7xHuqT8s/lxJdopzMqY1IFRa5Tpwc4KkBMJtjLWdp26KoDzPtScnbUMuKlVR
	 rYTZPrX9xFmawqm7o13AxdLLMFXjRjCVbR3ACa5v2f9kxjVAN6T5D8YZCWKq0LsdBZ
	 t5Sk6Fr1/kIvQ64rRRQZFIbnQk6/X2rderbS5Ji6573q2V1gQUvLzg8dYgihV6ePP9
	 Vq4Gi3k6R4BCY2FvBywockNHlhfBZNrFgilaPDsa5lxmhmclwX/0ADu8ipy65jDAb0
	 cc72jl/1NQ9mQzgnUIGHNyg0Mc2KWvgtETxWZK/MqGsJQo2/Qw4O6cjdIwrJRiWXBF
	 9NxktNxzwZS9DgN+qkPKymw0FfklGbZ5b7ehpUCtZvKqNov2jFvY+Qsz/INWtrvJmL
	 vzrd3xQwuaHhhD1oS+rUm3v46pWXrsw/sZgf4PEj1f2LoBtZF/b8XbcgqhY5v11uEx
	 gxPLZGkhSBcSuX/B9+vFKpVoCEA8ELp30srosxRBWN7GjdntfL/mSMi/9kv2gaeBij
	 oivaD/LUZ47szcXRgK1IzZ79tGQZyNrWwhrHxr3e/lfjuQOt8UYs50SWrFI8XVs/Ol
	 Fzgb5jqrgniRh/h2lpdGj/k4=
Received: from zn.tnic (pd953014d.dip0.t-ipconnect.de [217.83.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3B55A40E00BF;
	Wed,  6 May 2026 11:23:04 +0000 (UTC)
Date: Wed, 6 May 2026 13:22:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Manali Shukla <manali.shukla@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, mingo@redhat.com,
	dave.hansen@linux.intel.com, kvm@vger.kernel.org, x86@kernel.org,
	santosh.shukla@amd.com, nikunj.dadhania@amd.com, Naveen.Rao@amd.com,
	dapeng1.mi@linux.intel.com
Subject: Re: [PATCH v1 2/9] x86/apic: Add helper to get maximum number of
 Extended LVT registers
Message-ID: <20260506112234.GDafsken_RCmiP9gE-@fat_crate.local>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <20260204074452.55453-3-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260204074452.55453-3-manali.shukla@amd.com>

On Wed, Feb 04, 2026 at 07:44:45AM +0000, Manali Shukla wrote:
> +/**
> + * lapic_get_max_extlvt - Get number of extended LVT entries
> + */
> +int lapic_get_max_extlvt(void)
> +{
> +	u32 reg;
> +
> +	if (!boot_cpu_has(X86_FEATURE_EXTAPIC))

check_for_deprecated_apis: WARNING: arch/x86/kernel/apic/apic.c:263: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.

> +		return 0;
> +
> +	reg = apic_read(APIC_EFEAT);
> +
> +	/* Extract extended LVT count from bits 16-23 */
> +	return (reg >> 16) & 0xff;

Use GENMASK() and get rid of the comment because it is obvious then.

> +}
> +EXPORT_SYMBOL_GPL(lapic_get_max_extlvt);

EXPORT_SYMBOL_FOR_KVM_INTERNAL

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
