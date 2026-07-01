Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04F477998
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905111; cv=none; b=MUiyfUYWHRCMVhLKCyDHnxZv+9XjpjlQRJ7S9EshbnezZrmVKmILrmapG1P5mg4c/dyzWYzIzD19cbFKjlCAaZWNTD9jTtnEwevm9/j8sKHYWIIB0f0SlxO4raLrt5IrbvM9rwa3M7Uoe8HKhhuDEYrCSUjsPyrzQfGQ15jYhwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905111; c=relaxed/simple;
	bh=HGNviWTGMLP+ILhAVnLf+Fxqvk2nLeIYHo1SvKNsQR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJiRPUrGXOeO5PYlKaCs5AaHXthArBEyck2BUXolpYGv74H4X0dC2T4bSP4A7uluHMY0k7HgBg0zVz9uFelU9wPR69wmA2kTZH9w2Ren9LfFQf+Ai91ecxReT2/0F+9rRsfuqEwkSwa/FOa2d4WT76JYvOWrdUVoR1HEKjJUkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MfPNBcw9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MfPNBcw9"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so3494165e9.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782905108; x=1783509908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6ruABWkVWDFmLEtYThMIgGJ8AeKk7VYjaiWNv96SVUY=;
        b=MfPNBcw9/IdI40nCFlIm7YXEYRRyd38up6tnPHbaiQ8AGy4jzaDJkOcQ7FmfeYamxN
         xpOt+qNkeQ9I/+xLCZR5RAc9IPAra19Ip//D/sZ1wRGHmCqB92ClTkoWg+pvHHU6B3Cu
         n65DbYPLWNiJqzOKFykb9/wCqMbgA0Xn2OQ9OAzso5LlIE/0lI2sC5MNgoj/dTQiJ1L1
         ryqTDW9D4S9RUMtqeAxuQr3t1baI2+lMzGmOR1eQU+bntrQAB+n4ck7J2fGk/YCavOC5
         sKctgMdYhbUBQr4IZMKXLMuZtjeWsQ2ieyJ7sga53clMPI1myLS6rPmlQQgo2QgVLo0a
         oUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782905108; x=1783509908;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ruABWkVWDFmLEtYThMIgGJ8AeKk7VYjaiWNv96SVUY=;
        b=cFas6HkB3Mm0mS7GLVRuHtAdF6P4j4PWZ+WiNOIcxPvjdcIoKxPsoBqg1pQMp5s0gL
         IdI7wXDLxm7Rs0LD3CURagAEJmhEO57zZwVJavUoLsYllk9ij44NpfgDvuqef7AYT/Xv
         Hl6QV2VHpDWJ14Ia411wG+kIa01Bow3F7UfpEh/hMtmSKpwk3I7JstDKIMGGvEVyt4ux
         tQaG9gifrAWfQZaWwzH5Qg3xFGMtByEQCcJk7TCSeennl6g/nw3LG4tZ6LrspAb1g4jp
         4J0N5AaGi2VWxwf8ACw8BiMzro5wC5k0DiKuUlqQTuRyiA8mI6P2ai+4gVlf7v1tCCo3
         HfSg==
X-Forwarded-Encrypted: i=1; AFNElJ+mcMGJqsiySuwbb676gfxyMY9u2Sjpa6arVBDS6B8vDR9byoZm/YhNStbZ4m11At2Sjho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkuDWAOeGz7JAVm/8t69bZuzwc7AXVRXZRLtgz4gQYJjSbYzf0
	Xonbx7lShrvb1ZMufrzi2RDiR3Fek7ZmORfJ1pSi9lstdlt+CHHjFQdXcSBpNuTs/yVaHwYVxr6
	U4vjw2f0=
X-Gm-Gg: AfdE7ckdbPX4TZ7k67dmcTFymygiAYD/CODnSg+j1dHbuU6bj1+IEp7zzUJtxuXCoXJ
	/p8cPlJxGP6CgWL5hq4YphpLw4i9j38eVto0h2lPqbh0C1KzQp4FUWp71EJvk8j+lJAXtNv5fS5
	hPD6YZvIpaKUfcsroDaE8UNTCXjHJkHr0QfRr12bhQvo1XVoklUuyvpkLYDpql0FYFCVJqvdBeq
	qRRV1ZqzdEBbEhqPMJU96k5uWtsMJRDKpbXotjVZT/fV+U2RvXvwpQJtmAfukqIUDUDYY1CW4M1
	ja+7Bg8EB+Nwq/XlK/7jFdb384C5WgUrBJhuMkXyvJiN4FeKVT9PRUTqq/cb+8Ad/rnC1I32EUp
	TW2A9/hh9cZQZtSA/bYmWIY76012zxrhCWkMG4n49ew8PnrQ1vCrgsYbhq0BCg7b5xkbYzQ7Gi0
	tFd8gxtCMMIcBENIIhEXIQiySmdA==
X-Received: by 2002:a05:600c:8189:b0:493:b56b:c45c with SMTP id 5b1f17b1804b1-493c2b9cc74mr19272195e9.30.1782905108034;
        Wed, 01 Jul 2026 04:25:08 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.207.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4eee27sm65604685e9.12.2026.07.01.04.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 04:25:07 -0700 (PDT)
Message-ID: <3cf04184-c34a-4d49-926f-5791f12cd74e@suse.com>
Date: Wed, 1 Jul 2026 14:25:05 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/15] x86/virt/tdx: Add interface to check Quoting
 availability
To: Xu Yilun <yilun.xu@linux.intel.com>, kas@kernel.org, djbw@kernel.org,
 rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, xiaoyao.li@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-9-yilun.xu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260522034128.3144354-9-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/22/26 06:41, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> KVM needs to know if the Quoting extension is available to determine
> whether userspace must be involved in Quote generation.
> 
> Since the Quote buffer is always created during Quoting extension
> bringup, checking whether the buffer exists is sufficient.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>   arch/x86/include/asm/tdx.h  |  2 ++
>   arch/x86/virt/vmx/tdx/tdx.c | 15 +++++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 15eac89b0afb..7b257088aa1e 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -176,6 +176,8 @@ struct tdx_vp {
>   	struct page **tdcx_pages;
>   };
>   
> +bool tdx_quote_enabled(void);
> +
>   static inline u64 mk_keyed_paddr(u16 hkid, struct page *page)
>   {
>   	u64 ret;
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 9d04293394d7..b305fa5aab5c 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1213,6 +1213,21 @@ static inline u64 tdx_tdr_pa(struct tdx_td *td)
>   	return page_to_phys(td->tdr_page);
>   }
>   
> +/**
> + * tdx_quote_enabled() - Check whether TDX Quoting extension is available
> + *
> + * Return: %true if the Quoting extension is available, otherwise %false.
> + */
> +bool tdx_quote_enabled(void)

nit: Probably rename the function to tdx_quoting_ext_enabled or 
tdx_quote_ext_enabled, so it's abundantly clear it's about an extension 
and not the quoting functionality in general.


> +{
> +	/*
> +	 * No need for locking here. The quote buffer is initialized as part of
> +	 * core TDX bringup, which comes before KVM is ready for userspace.
> +	 */
> +	return !!quote_data.buf;

While this works it feels a bit like a hack, perhaps have a static 
boolean variable being set by the init code which is simply returned by 
this function.

> +}
> +EXPORT_SYMBOL_FOR_KVM(tdx_quote_enabled);
> +
>   #define HPAS_PER_PAGE			(PAGE_SIZE / sizeof(u64))
>   
>   static int tdx_quote_create_buf(unsigned int nr_pages, struct quote_data *qdata)

