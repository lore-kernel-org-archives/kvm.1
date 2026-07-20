Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1504252A6;
	Mon, 20 Jul 2026 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554533; cv=none; b=BxPrppoid+JiAM6GzDf8RAogwswIXNAez2ENvtSjwp8BMtMHkitGj7muNEcjtDX7exRm+AYBhYdsAt/zAUVFxP984pQupemMvrifdGVgkx08gOFuG0AXX0EKNmfAyX0Q+NKTn5dwTw7KqmeAsqWXPVpROL9WQofnWTM6SWdTukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554533; c=relaxed/simple;
	bh=LRYh8VodTkMTu2B3eYSDcqcZ6BmDB4cPjPTvidp/25s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLbzYTQH2ZhK+ZnSb0BEb1q5sAWu/a4qTFSXyAz5mdAQYWdQoFhHqwsNomf06KVq1v6iuk7N17ZLwN1onPWL02ad273r+QOYTfrt+2Z1pzTm+gpfywbkhpP4TnB+mPzj5P/xAM30I5zWBMnQ32wR4ZMnG0xl23PGMTkUhmB0JJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFhVQ61d; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFhVQ61d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784554532; x=1816090532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LRYh8VodTkMTu2B3eYSDcqcZ6BmDB4cPjPTvidp/25s=;
  b=mFhVQ61dA5aTnwD+mYtCUJe2GyGdzsIEK+g5c/PLGqrCY3ZIytjxSiBG
   QPGI2yO0aHMoXH4eR1ZjBDIhMjCnZQdl0vp8SFtY6Pu4f8XXlncPlEFda
   zRY68kV/7mNaSDcLPRB7UIuGeMxoUGrIYdfjJ31SyrmCkRIFq+mvbD79g
   qdQ1sY5lsFlTneFtQckFfW1MNRuMoSmfXvQztBGUhgh/kluwj1wmaDXwi
   lBPn+dNvbivfU3sWyFLQnJ0XWQGbzJ8MfwGkKnf72ymZhMXqhH7kwuqyN
   JAdKj65JDUGkwO10kpI4U9pNNyuqBxAPQP7dzy0cCt/5aN/JRUQzqUI3Y
   w==;
X-CSE-ConnectionGUID: xegLC1lCThKRzkNtMqJJcg==
X-CSE-MsgGUID: V53dqBOhTByvn21/iSdtHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="110681167"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="110681167"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 06:35:31 -0700
X-CSE-ConnectionGUID: CjZ/QZcNTY+r+S5kVlhTHA==
X-CSE-MsgGUID: krRVMdGlTmyuNN9YmnTZlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="258104739"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.156]) ([10.125.109.156])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 06:35:31 -0700
Message-ID: <51059852-9a10-4735-a81d-003b4b1963a6@intel.com>
Date: Mon, 20 Jul 2026 06:35:29 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
To: Peter Fang <peter.fang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
References: <20260717214349.4075994-1-peter.fang@intel.com>
 <20260717214349.4075994-3-peter.fang@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260717214349.4075994-3-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/26 14:43, Peter Fang wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> The TDX attestation driver currently uses a fixed 128 KB Quote buffer
> shared with the host VMM. This may be too small for Quotes using schemes
> such as post-quantum cryptography (PQC), where larger certificate chains
> can increase the Quote size significantly.
> 
> Allocate the Quote buffer based on the size reported by the TDX module
> instead of always reserving a fixed-size buffer. This avoids wasting
> memory on platforms that do not require larger Quotes. Older platforms
> fall back to the default 128 KB buffer.
> 
> Because the Quote buffer must be physically contiguous, its size is
> bound by the buddy allocator's maximum page order (4 MB), which should
> be sufficient for current attestation needs.

This is all talking about post-quantum-crypto and all that fancy stuff.

Isn't the important part here that the old TDX module ABI had static
quote sizes and now they're dynamic? Now, the reason it changed is all
the fancy stuff.

But the ABI changed. Right?

> -static void *alloc_quote_buf(void)
> +static size_t get_quote_buf_size(void)
>  {
> -	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
> -	unsigned int count = len >> PAGE_SHIFT;
> +	size_t buf_size = GET_QUOTE_DEFAULT_BUF_SIZE;
> +	u32 quote_size;
> +
> +	quote_size = tdx_get_max_quote_size();
> +
> +	if (quote_size)
> +		/* Reported size does not include GetQuote header */
> +		buf_size = TDX_QUOTE_BUF_LEN(quote_size);
> +
> +	return PAGE_ALIGN(buf_size);
> +}

This code is almost nonsensical on the surface.

It _really_ needs some commenting. Things like:

	/* Start with the default quote buffer size: */

...

	/* Override the default when ... */


You could even comment the function to say what it is trying to do overall.

> +static void *alloc_quote_buf(size_t *buflen)
> +{
> +	unsigned int count;
> +	size_t len;
>  	void *addr;
>  
> -	addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
> +	len = get_quote_buf_size();
> +
> +	/*
> +	 * This fails if the requested size exceeds the buddy allocator's
> +	 * maximum order. Use __GFP_NOWARN since the size comes from the host
> +	 * and should fail quietly rather than warn.
> +	 */
> +	addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN);

Bad Sashiko. Bad.

The host may be untrusted, but it's also a critical part of the system.
Are we sure we want to be completely quiet?

I used to see little dmesg warnings about TCP window shenanigans from
random systems on the Internet. Maybe that's not how we do things today,
but if a random dude on the Internet can spew one line to dmesg, is it
that crazy that a bad VMM be able to spew a warning?

>  	if (!addr)
>  		return NULL;
>  
> +	count = len >> PAGE_SHIFT;
> +
>  	if (set_memory_decrypted((unsigned long)addr, count))
>  		return NULL;
>  
> +	*buflen = len;
> +
>  	return addr;
>  }

This feels weird to me.

If the upper-layer function needs to know the size, why not have it just
call get_quote_buf_size()? Then there's no pass-by-address.

> @@ -285,7 +310,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>  	if (desc->inblob_len != TDX_REPORTDATA_LEN)
>  		return -EINVAL;
>  
> -	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
> +	memset(quote_data, 0, quote_data_len);
>  
>  	/* Update Quote buffer header */
>  	quote_buf->version = GET_QUOTE_CMD_VER;
> @@ -296,7 +321,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>  	if (ret)
>  		return ret;
>  
> -	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
> +	err = tdx_hcall_get_quote(quote_data, quote_data_len);
>  	if (err) {
>  		pr_err("GetQuote hypercall failed, status:%llx\n", err);
>  		return -EIO;
> @@ -315,7 +340,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>  
>  	out_len = READ_ONCE(quote_buf->out_len);
>  
> -	if (out_len > TDX_QUOTE_MAX_LEN)
> +	if (TDX_QUOTE_BUF_LEN(out_len) > quote_data_len)
>  		return -EFBIG;
>  
>  	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
> @@ -417,7 +442,7 @@ static int __init tdx_guest_init(void)
>  	if (ret)
>  		goto deinit_mr;
>  
> -	quote_data = alloc_quote_buf();
> +	quote_data = alloc_quote_buf(&quote_data_len);
>  	if (!quote_data) {
>  		pr_err("Failed to allocate Quote buffer\n");
>  		ret = -ENOMEM;
> @@ -431,7 +456,7 @@ static int __init tdx_guest_init(void)
>  	return 0;
>  
>  free_quote:
> -	free_quote_buf(quote_data);
> +	free_quote_buf(quote_data, quote_data_len);
>  free_misc:
>  	misc_deregister(&tdx_misc_dev);
>  deinit_mr:
> @@ -444,7 +469,7 @@ module_init(tdx_guest_init);
>  static void __exit tdx_guest_exit(void)
>  {
>  	tsm_report_unregister(&tdx_tsm_ops);
> -	free_quote_buf(quote_data);
> +	free_quote_buf(quote_data, quote_data_len);
>  	misc_deregister(&tdx_misc_dev);
>  	tdx_mr_deinit(tdx_attr_groups[0]);
>  }

So, yeah, this patch isn't gigantic. But it's also fundamentally not
doing a _nice_ refactoring the way we expect them to be done.

1. Refactor old code to make it nice for adding features
2. Add the feature

If this was doing it the nice way, we would *actually* have something
that's really close to s/GET_QUOTE_BUF_SIZE/quote_data_len/. But,
instead, this chose to cram the mechanical changes and the new feature
together.

Can we do it the right way, please? If for nothing else, for practice.
