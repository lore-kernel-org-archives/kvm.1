Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA453C1D7D;
	Mon, 21 Sep 2026 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030825; cv=none; b=Jpu7DYfBEyprzEzuCaUad7g1coKErabcS5ITPRCaqkzf/fY/20e0Y6csHD6VWKBJOYVwhlR3LYcqq+zeSPf3hvvdnxtOd7qT9xhmKIbXq49+N4l94TR5FYubtkRq7WlpEIRwvsZm330vU0Hqezr8NS9agVkhLs2plhW35i0qHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030825; c=relaxed/simple;
	bh=rNqxnHIZZp8AeQxFEC2Wv+y5DCWvgxhQONt5DjyRBf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=psYh/1XDD4hxEP0P9Vkq4BjtTKaxsT7b+ARJPJauq3ftRwwXnuTAwLNroPIr/cQscbBAA9mvqs4DgCDQRqhfToOmYijAJJgA400UjB3xb7goE0SOCFfMqS/yxvpPUupv+BhngOSrIOn26r1WIKcANJnPLw9IbrdpL9Y+XBSvjJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isllbmtS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isllbmtS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790030823; x=1821566823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rNqxnHIZZp8AeQxFEC2Wv+y5DCWvgxhQONt5DjyRBf0=;
  b=isllbmtSiu/6mVrfCGdMt/mAPlr/zl6Jy4khPSOUd46cj6QXJuly8Q0t
   Ocbk4pcpcOSV9hXAle5c9DkDzudkd/NCgztp2TOv1qBnGoHr4S+axn6/s
   TBQfPJMU1BXhw7n0xq5bemKfXoBHAS8RvNgsipBODJ/RQxq2LzWJQpkzT
   tZJDBGsVWv2UAOvUe4usvgiFI7Bo23iK3O0nTKJXgfAS8Bs2RIB96Fxey
   rjvUmSG+tk6lb/MDwmx4dmTM+uaVou8zrtXJ5BzlQcEQ3hhaO7OI6a5RD
   Kmg/GzZsUsz4hynfJJKmHcdvnPM/pMHU7die1kHP4EfCqhPlEhsJOMsUK
   Q==;
X-CSE-ConnectionGUID: iOpJevTiTNG6Y3135wZpjw==
X-CSE-MsgGUID: 4YKc2gJVTCiQMcRhIIDqrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="93087279"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="93087279"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 15:47:02 -0700
X-CSE-ConnectionGUID: 9uPfTCbgRxWn+H8CGh5Y5A==
X-CSE-MsgGUID: tyT5fr15QAOz1asA+MrQ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="273021668"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.249]) ([10.125.109.249])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 15:47:01 -0700
Message-ID: <c88327ac-6227-4e4a-85b5-0ad320871637@intel.com>
Date: Mon, 21 Sep 2026 15:47:02 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] virt: tdx-guest: Allocate Quote buffer dynamically
To: Peter Fang <peter.fang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
 Tony Lindgren <tony.lindgren@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>,
 Artem Bityutskiy <artem.bityutskiy@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
 <20260915092632.2822169-5-peter.fang@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260915092632.2822169-5-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/26 02:26, Peter Fang wrote:
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index ec886c401fcb..7224a66b65d1 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -162,7 +162,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
>   * DICE-based attestation uses layered evidence that requires
>   * larger Quote size (~100K).
>   */
> -#define GET_QUOTE_BUF_SIZE		SZ_128K
> +#define GET_QUOTE_DEFAULT_BUF_SIZE	SZ_128K

The naming of "GET_QUOTE_DEFAULT_BUF_SIZE" is rather unfortunate. "GET"
is a verb. It is for functions.

Isn't it "TDX_DEFAULT_QUOTE_SIZE"?

I know the TDCALL leaf is "GET_QUOTE" but replaying that naming is
horribly confusing.

> @@ -222,11 +222,34 @@ static void free_quote_buf(void *buf, size_t len)
>  	free_pages_exact(buf, len);
>  }
>  
> +/*
> + * Return a buffer size large enough for a Quote. This covers all Quote
> + * types supported by the platform.
> + */
> +static size_t get_quote_buf_size(void)
> +{
> +	u32 quote_size = tdx_get_max_quote_size();
> +	size_t len;
> +
> +	if (quote_size)
> +		/* The reported size does not include the buffer header */
> +		len = TDX_QUOTE_BUF_LEN(quote_size);
> +	else
> +		/* Older TDX modules don't report the size, use the default */
> +		len = GET_QUOTE_DEFAULT_BUF_SIZE;
> +
> +	return len;
> +}

No, I'm sorry, that's not how we do multi-line if()'s. Brackets please.

I'd much rather see something structured this way:

static size_t get_quote_buf_size(void)
{
	static u32 full_quote_len;
	/* Size of the quote itself, no header: */
	u32 quote_data_len;

	if (full_quote_len)
		return full_quote_len;

	/* Ask the module for the max data size: */
	tdx_read_max_quote_data_len(&quote_data_len);

	/* Fall back to defaults on old TDX modules: */
	if (!quote_data_len)
		quote_data_len = GET_QUOTE_DEFAULT_DATA_SIZE;

	/* Add room for the header metadata: */
	full_quote_len = quote_data_len + sizeof(struct tdx_quote_buf);
	full_quote_len = PAGE_ALIGN(full_quote_len);

	return full_quote_len;
}

Having a static function variable beats a global every single time when
possible. This way, you can (guaranteed) see 100% of the code that reads
or writes the variable. Anybody can muck with a global and you need to
grep or search to look at all the other code in the file even for a
static global.

Also note that it talks about quote data and metadata instead of just
"lengths".

You also have a mess of naming there. Some 'len', some 'size'. Pick one.

>  static void *alloc_quote_buf(size_t len)
>  {
>  	unsigned int count = len >> PAGE_SHIFT;
>  	void *addr;
>  
> +	/*
> +	 * This fails if the requested size exceeds the buddy allocator's
> +	 * maximum order (order-10, 4MB).
> +	 */
...

I don't think you need to document the buddy allocator's behavior here.

Why did you even add this?
