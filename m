Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3103A9002
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107753; cv=none; b=faLzbIWWyAsoh8dE0qnqMX3sBbcrTScOS/BsTJKm4OdTlNcRkiKWukb7h+KKLMd72wojQXF25fTJEhqW7dpT1M79nI0+W5+LlWWdHp67tfwci//jmbX2Eo/Gh/ntA9oia8AIsjQkHYVcFXXxRnoOXhG39NhamM+Vnfd2Q7x9HAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107753; c=relaxed/simple;
	bh=+G3QdrWb+DjTK1gkBrMPvkkDnVbyE1tL7o774CpkQt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsNHziF5BTrfkj+/U7Y1Ggi0uCrjSTXp0YFiuNaXvR89E3x7xWvX/hFLwNMedVnPM47Gbdl6f5Ce9HMppOIb/EIDbe1g5T3cmUlDTD3K2MI9i3kTVsyzmDMTshm5xSb3J7RcqzQS6eg/9qG7L7jb8yNW3rahYGkSXnWmBvUfkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RKywGP1w; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RKywGP1w"
Date: Wed, 10 Jun 2026 11:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781107749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7R+JSxYAByMSC0PBU8VmMLwtrMhLnfEPXpYqg1aFv3E=;
	b=RKywGP1wXlaNL6CGuiDzsh6oHqXeyPW+wdoePk+GQeRZTjWYVJHxBZILNDKhl9Isq03R9Z
	Ogh8iJ14V4fLqKDxfGU6NQ82YASDVypQRBj6G3eeodwOBwRZk1UbvwhHeJbRI9FEg+hTI+
	WDR0e/blu7aeQ22Nul1lFQ9pFYARejQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Giacomo Mazzola <gmazz@amazon.de>
Cc: kvm@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH 7/8] efi: fix load_options_size conversion
 to character count
Message-ID: <6vt3a34rryk3qkx6wkhruhji6pktwoulok24txspq66u7fj2sx@ftpxx6oocmfz>
References: <20260609140901.95727-1-gmazz@amazon.de>
 <20260609140901.95727-8-gmazz@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609140901.95727-8-gmazz@amazon.de>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 09, 2026 at 02:08:59PM +0000, Giacomo Mazzola wrote:
> load_options_size is in bytes, but options_chars is used as the
> iteration count over the u16 load options array.  Divide by
> sizeof(u16) to convert from bytes to UTF-16 code units; without
> this, the loop reads past the end of the load options buffer.
> 
> The original Linux kernel code (drivers/firmware/efi/libstub/
> efi-stub-helper.c) from which this function was adapted performs
> the same conversion:
> 
>     options_chars = options_size / sizeof(efi_char16_t);
> 
> This was lost when the function was ported to KUT.
> 
> Fixes: 85c3c524 ("lib/efi: Add support for getting the cmdline")
> Signed-off-by: Giacomo Mazzola <gmazz@amazon.de>
> ---
>  lib/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/efi.c b/lib/efi.c
> index f396bd71..d1be2bfc 100644
> --- a/lib/efi.c
> +++ b/lib/efi.c
> @@ -134,7 +134,7 @@ static char *efi_convert_cmdline(struct efi_loaded_image_64 *image, int *cmd_lin
>  {
>  	const u16 *s2;
>  	unsigned long cmdline_addr = 0;
> -	int options_chars = image->load_options_size;
> +	int options_chars = image->load_options_size / sizeof(u16);
>  	const u16 *options = image->load_options;
>  	int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
>  	bool in_quote = false;
> -- 
> 2.47.3
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
