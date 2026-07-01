Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540414266AE
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906381; cv=none; b=UZWwrCVPs172ID/UnZhMY3wH2DnuG0ESKPcIyDebKraZEeXIjkTXN1/+CirUBD66OipVRdz0VPuaRtFkEpTqedXjT8/N9RHTqZf6K/5yuSyqHDwXKcHTc2SYvyAj0yIkBbmiXfUx9UHlJ9aLVs0TCxcqaxny4DEpCj1NZzn/8q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906381; c=relaxed/simple;
	bh=xTEfbWT5LJSM6gKyc3oFGUQ41/RoQ8ITPezgvgLQC0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSMvxTa9jhz5Cz62eJBrVsNKTqLuiISGy/TTkQAjIsihQpK4XxPQi06NSQgldThTMd8f35JWXJNMeRGRi1B+ZYPXkOFpW9Ms1C5wVJTIFFhyL9+N6XYTDUXTYecL/32qpGBQGsaN9W6UdAIwkF7iOlkDLOkkHEwuQAEj9JHnGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dys334I+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dys334I+"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493a97fad2fso4998865e9.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 04:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782906379; x=1783511179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=84l0kSo6RKfg4k5hRcx6ro1EZzuiFwmA3iygG4exLEE=;
        b=Dys334I+cANwPPPtLBupIKIimF1gBcHwKSt1z17utzyV1WIsBFKiTClpAfU9devm/I
         TgfimPBACia2XXSnWKPSEX1zEpjP3t2U8pPM532mtqTyRisD/B+iIl6HOcP/lLBlt7PE
         S3t/VlloqgcLwe+XbC7qR30y+533KBfdYdpXGBZtD8sm4OieAYBFgx+OYrnqSxg8d9KJ
         xYPdeznvWf+ks+VB4x91BOwoANjVG0y0KkhbNN0o4ahcJ6/Gd9QbILBjibLyJyisKAfa
         T4FraaN+/9K/dsYERmTqW474R9y6l5YaMcqtvOgJQuTUcprWwQ5VtM6rlcBuX6tA32Dh
         T6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906379; x=1783511179;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84l0kSo6RKfg4k5hRcx6ro1EZzuiFwmA3iygG4exLEE=;
        b=MUPD1TiuW1YzXw/ik0JdWs8rx1HWxYDAdRWtl2eDldisPMxjzkzdWPVcdPAvbrcj1/
         +esUlUmgx4E27kxZsFOvDIdwY0Qqtha1n8UvZbBi+aFsHdK3xG9NB2TngqMBFelz1XZF
         e4V6hc9V5YZOq9QlSTN8X1eVQIo1aSzy93y5+61M6QwwubdyTxKOUkJP4SUggFeYAwf3
         dnmRMS41cnF1Lba5gdQ8EJF5i4ZE11Uzj4+pmJDF8mBdmAASi7yghkNPrCPLsZcEjcqK
         rG/0lIkD3MYNZpINuDx8wIiBfWJ99Ee2p0Q9/g6Qph6iRqrIxFGJkqcghGFGoszTNOad
         rj+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Jb7unBtZyNjIhIX0fTJQ5Pbv20FjHybi0Uj9mSik5r3ZgzOt0SnjNASH/n6WDC6p55dI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx756ryxFjqzVOy2oxoJe3ZqnUZeg8wGA9qsNViLDr97ZNUQgq
	ywrrb+F/6p74j6ZAU5LTAiXQI51p/xl8HfNP3LdURV+nmWC2LjYbNHXexhZCZH+Md8U=
X-Gm-Gg: AfdE7ckW7EqPCNruJFRT+RWzQHtsJjdT1apL4o7bOjaLOWa7Z+W8ZeLY2JaVoLraZzS
	LAs7z/PBT4L25N2syUlqHFXrGeZXAVyTM768x6avkRQytuomB1+2K/2B26XGT9f0fTmrbTrBbZm
	L8jnyQqHlIoe97hWDLpJbZjE9itQ2u5z4XEvFOgNNRX9IYBg1wXyH2ZA12PJRhA6FoHwnz5cU/R
	4MkC1ZgFRMolPaDdoYfVzyaUAYxwHHcte1eYSyjlEXeLgh2keSiv3CHytQRtOm2aWOWHoOiVHuR
	Dni7xExBZBBHlDnNoURzot17DmORf4RGylToKilXgrvCcqoof0FAUuHTs+xvUBXdTzLfeWaGF1X
	A/2Ot3wdaHk/aRefOvqVyGplc/qw0dv8/3p595EvIYPKPc9tpgBXuRE1XGVt1a0A4x1X7e990SD
	vyo2wII2lX7xAXSgB3bGXBhZKmEQ==
X-Received: by 2002:a05:600c:e494:20b0:493:9661:f55d with SMTP id 5b1f17b1804b1-493c3cfd391mr2852225e9.30.1782906378668;
        Wed, 01 Jul 2026 04:46:18 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.207.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bfc32992sm61543595e9.11.2026.07.01.04.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 04:46:18 -0700 (PDT)
Message-ID: <a8441214-1560-498d-ba01-0807502d0e28@suse.com>
Date: Wed, 1 Jul 2026 14:46:16 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/15] x86/virt/tdx: Add interface to generate a Quote
To: Xu Yilun <yilun.xu@linux.intel.com>, kas@kernel.org, djbw@kernel.org,
 rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, xiaoyao.li@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-10-yilun.xu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260522034128.3144354-10-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/22/26 06:41, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Use the TDX Quoting extension's TDH.QUOTE.GET SEAMCALL to generate a
> Quote. Since the interface is shared across all KVM instances,
> serialize access to the SEAMCALL buffer with a mutex.
> 
> Allocate and return a per-call buffer containing the generated Quote so
> callers don't need to size the Quote buffer themselves. The caller is
> responsible for freeing the returned buffer.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>   arch/x86/include/asm/tdx.h  |  2 +
>   arch/x86/virt/vmx/tdx/tdx.h |  1 +
>   arch/x86/virt/vmx/tdx/tdx.c | 82 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 85 insertions(+)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 7b257088aa1e..bc512a00a0d0 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -177,6 +177,8 @@ struct tdx_vp {
>   };
>   
>   bool tdx_quote_enabled(void);
> +void *tdx_quote_generate(struct tdx_td *td, void *in_data, u32 in_data_len,
> +			 u32 *quote_len);
>   
>   static inline u64 mk_keyed_paddr(u16 hkid, struct page *page)
>   {
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index 3849f4f9cc78..01a7d7d8ada9 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -49,6 +49,7 @@
>   #define TDH_EXT_INIT			60
>   #define TDH_EXT_MEM_ADD			61
>   #define TDH_SYS_DISABLE			69
> +#define TDH_QUOTE_GET			98
>   #define TDH_QUOTE_INIT			100
>   
>   /*
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index b305fa5aab5c..821f677e9a86 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -62,6 +62,8 @@ static LIST_HEAD(tdx_memlist);
>   static struct tdx_sys_info tdx_sysinfo __ro_after_init;
>   static bool tdx_module_initialized __ro_after_init;
>   
> +static DEFINE_MUTEX(tdx_quote_lock);
> +
>   static struct quote_data {
>   	void *buf;
>   	u64 buf_len;
> @@ -1228,6 +1230,86 @@ bool tdx_quote_enabled(void)
>   }
>   EXPORT_SYMBOL_FOR_KVM(tdx_quote_enabled);
>   
> +#define QUOTE_ID_MASK		GENMASK_U64(47, 32)
> +
> +static u64 tdx_quote_get(struct tdx_td *td, u64 in_data_pa, u64 in_data_len,
> +			 u64 hpa_list_pa, u64 total_len, u64 *quote_len)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = tdx_tdr_pa(td),
> +		/* Don't bother specifying the quote id */
> +		.rdx = QUOTE_ID_MASK & (u64)-1,

This is simply equal to QUOTE_ID_MASK, so why not create a special value 
meaning "ANY QUOTE" i.e

#define QUOTE_ID_MASK ....
#define ANY_QUOTE QUOTE_ID_MASK

or some such .

> +		.r8 = in_data_pa,
> +		.r9 = in_data_len,
> +		.r10 = hpa_list_pa,
> +		.r11 = total_len,
> +	};
> +	u64 r;
> +
> +	do {
> +		r = seamcall_ret(TDH_QUOTE_GET, &args);
> +	} while (r == TDX_INTERRUPTED_RESUMABLE);


nit: This pattern seems to repeat a lot, might be worth it to consider 
introducing a wrapper similar to existing sc_retry?
> +
> +	*quote_len = args.rcx;
> +
> +	return r;
> +}
> +
> +/**
> + * tdx_quote_generate() - Generate a quote for a TD
> + * @td: The TD to generate the quote for.
> + * @in_data: Input data for the quote request.
> + * @in_data_len: Size of the input data in bytes.
> + * @quote_len: Returned size of the generated quote in bytes.
> + *
> + * Use the TDX Quoting extension to generate a TD quote. Pass the input data
> + * through the shared quote buffer and return the quote.
> + *
> + * Return: Newly allocated quote buffer or %NULL on failure.
> + * The caller must free the returned buffer with kvfree().
> + */
> +void *tdx_quote_generate(struct tdx_td *td, void *in_data, u32 in_data_len,
> +			 u32 *quote_len)
> +{
> +	void *quote_dup = NULL;
> +	u64 r, out_len;
> +
> +	if (!tdx_quote_enabled())
> +		return NULL;
> +
> +	/* TDH.QUOTE.GET expects the input data to fit in a page */
> +	if (in_data_len > PAGE_SIZE)
> +		return NULL;
> +
> +	mutex_lock(&tdx_quote_lock);
> +
> +	/*
> +	 * Use the first page of the quote buffer for input data. The buffer
> +	 * must be at least one page in size. @in_data may not be page-aligned,
> +	 * but TDH.QUOTE.GET expects page-aligned addresses.
> +	 */
> +	memcpy(quote_data.buf, in_data, (size_t)in_data_len);

Perhaps you can use min(PAGE_SIZE, in_data_len) and that way you can 
eliminate the in_data_len check above and copy up-to PAGE_SIZE data, if 
the data is longer - you will copy PAGE_SIZE which will likely result in 
error on generating the quote?
> +
> +	r = tdx_quote_get(td, quote_data.hpa_list[0], (u64)in_data_len,
> +			  quote_data.hpa_list_pa, quote_data.buf_len, &out_len);
> +	if (r || !out_len || out_len > quote_data.buf_len)
> +		goto out;
> +
> +	/*
> +	 * The quote buffer is a shared resource, so use it only for the
> +	 * SEAMCALL and copy the data out as soon as possible.
> +	 */
> +	quote_dup = kvmemdup(quote_data.buf, out_len, GFP_KERNEL);
> +
> +out:
> +	mutex_unlock(&tdx_quote_lock);
> +
> +	*quote_len = (u32)out_len;
> +
> +	return quote_dup;
> +}
> +EXPORT_SYMBOL_FOR_KVM(tdx_quote_generate);
> +
>   #define HPAS_PER_PAGE			(PAGE_SIZE / sizeof(u64))
>   
>   static int tdx_quote_create_buf(unsigned int nr_pages, struct quote_data *qdata)

