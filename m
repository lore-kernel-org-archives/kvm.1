Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ACA346E40;
	Mon, 13 Jul 2026 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963669; cv=none; b=uFVc4FlrJ3b6JbwVrXGIySiUWnq4KGRQAhHDmWCfKMD8gpuN0MKrpg604MNG91Xaep/UDF7CV+THVdgrea9Mvu3tEbruIlclI+UeCnfORbaEvvy+hxb6gakOwwAWsQ4IyoYqTE6lwbgNvYeAOLxizjwJcntSUnC/ZJGywD95Ht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963669; c=relaxed/simple;
	bh=tRHm/snbkZcCM8XoGyq3hn28EYvaTxM6F0inLOwAoGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eaLtPmnDH1ayu5aRkCV9pXKHU7jEmFwdwTFKCoNxyQnkG81pFUu8qKhlqN1oa2jXqXWOE+82H/OI64G/X9Hw9BC3jFZhT3kIvM35slBRGmgPcj5HKrR90hffaulpC8p4jYa/DV3FJ+fiN069h3VsYSN22wDzZmsGOS32VAVJCxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMFLJ4L3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMFLJ4L3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783963668; x=1815499668;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tRHm/snbkZcCM8XoGyq3hn28EYvaTxM6F0inLOwAoGA=;
  b=RMFLJ4L3cSddkit4I0+yMNUISOadPBajBNslTRSDdrj+PVAtJVYyplhp
   dQYDisJ/Q21CH9F6I/Fw769B9IBQv8HtOFIqxy7zvV4XWZMdwSnV6XR9r
   aAovOEiyUl24VBGtee+uiYRAQMPuVtX9iuGfDrNXDavCSuOSiOCAifHSc
   sPPT10uTj0OFXYeSGUmRoQTjdyxCh43G1/9ozKEsBWNk3Sr8blDTQ8bhE
   TtcSYfBezgqY+4I5MhiC6ETztvHSZTf5lT1r3ZQXBM4sOWRmPHcsQWLAK
   xBCvgesmncx/sk8zO78nU65sWIXx0YzVZkDSxvZQb1m2RdEonJ8/TFhoq
   w==;
X-CSE-ConnectionGUID: G4zimNlqQNyPD22Hg7x+PA==
X-CSE-MsgGUID: 3rM7W+FbQAytBw8RDzevGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84456441"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84456441"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:27:47 -0700
X-CSE-ConnectionGUID: baLMqwBFTOm/DA8GhbGnfg==
X-CSE-MsgGUID: gLzh6Y7+ReaGDTMSb3pw9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252232304"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:27:47 -0700
Message-ID: <283d7cc7-e87e-4d4e-b1d9-ae19725e1606@linux.intel.com>
Date: Mon, 13 Jul 2026 10:27:46 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
To: Peter Fang <peter.fang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-3-peter.fang@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260612110853.3188196-3-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

On 6/12/2026 4:08 AM, Peter Fang wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> The TDX attestation driver currently uses a fixed 128 KB Quote buffer
> shared with the host VMM. This may be too small for Quotes using schemes
> such as post-quantum cryptography (PQC), where certificate chains can
> increase the Quote size to several megabytes.
> 
> Allocate the Quote buffer based on the size reported by the TDX module
> instead of always reserving a fixed-size buffer. This avoids wasting
> memory on platforms that do not require larger Quotes. Older platforms
> fall back to the default 128 KB buffer.
> 
> Because the Quote buffer must be physically contiguous, its size is
> bound by the buddy allocator's maximum page order (4 MB), which should
> be sufficient for current attestation needs.
> 
> struct tdx_quote_buf has a trailing flexible array, so use offsetof()
> instead of sizeof() to calculate the header size.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Assisted-by: Claude:claude-opus-4-7
> Assisted-by: GitHub Copilot:gpt-5.4
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  drivers/virt/coco/tdx-guest/tdx-guest.c | 52 ++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index a9ecc46df187..162fb47f3fae 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -163,7 +163,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
>   * DICE-based attestation uses layered evidence that requires
>   * larger Quote size (~100K).
>   */
> -#define GET_QUOTE_BUF_SIZE		SZ_128K
> +#define GET_QUOTE_DEFAULT_BUF_SIZE	SZ_128K
>  
>  #define GET_QUOTE_CMD_VER		1
>  
> @@ -171,7 +171,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
>  #define GET_QUOTE_SUCCESS		0
>  #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
>  
> -#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
> +#define TDX_QUOTE_BUF_LEN(n)		(offsetof(struct tdx_quote_buf, data) + (n))
>  
>  /* struct tdx_quote_buf: Format of Quote request buffer.
>   * @version: Quote format version, filled by TD.
> @@ -192,8 +192,9 @@ struct tdx_quote_buf {
>  	u8 data[];
>  };
>  
> -/* Quote data buffer */
> +/* Quote data buffer and size */
>  static void *quote_data;
> +static size_t quote_data_size;
>  
>  /* Lock to streamline quote requests */
>  static DEFINE_MUTEX(quote_lock);
> @@ -210,9 +211,8 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
>  			     USER_SOCKPTR(req->tdreport));
>  }
>  
> -static void free_quote_buf(void *buf)
> +static void free_quote_buf(void *buf, size_t len)
>  {
> -	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
>  	unsigned int count = len >> PAGE_SHIFT;
>  
>  	if (set_memory_encrypted((unsigned long)buf, count)) {
> @@ -223,19 +223,43 @@ static void free_quote_buf(void *buf)
>  	free_pages_exact(buf, len);
>  }
>  
> -static void *alloc_quote_buf(void)
> +static size_t get_quote_buf_size(void)
>  {
> -	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
> -	unsigned int count = len >> PAGE_SHIFT;
> +	size_t buf_sz = GET_QUOTE_DEFAULT_BUF_SIZE;
> +	u32 quote_sz;
> +
> +	quote_sz = tdx_get_max_quote_size();
> +
> +	if (quote_sz)
> +		/* Reported size does not include GetQuote header */
> +		buf_sz = TDX_QUOTE_BUF_LEN(quote_sz);
> +
> +	return PAGE_ALIGN(buf_sz);
> +}
> +
> +static void *alloc_quote_buf(size_t *buflen)
> +{
> +	unsigned int count;
> +	size_t len;
>  	void *addr;
>  
> +	len = get_quote_buf_size();
> +
> +	/*
> +	 * This fails if the requested size exceeds the buddy allocator's
> +	 * maximum order (order-10, 4MB).
> +	 */
>  	addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
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
>  
> @@ -286,7 +310,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>  	if (desc->inblob_len != TDX_REPORTDATA_LEN)
>  		return -EINVAL;
>  
> -	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
> +	memset(quote_data, 0, quote_data_size);
>  
>  	/* Update Quote buffer header */
>  	quote_buf->version = GET_QUOTE_CMD_VER;
> @@ -297,7 +321,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>  	if (ret)
>  		return ret;
>  
> -	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
> +	err = tdx_hcall_get_quote(quote_data, quote_data_size);
>  	if (err) {
>  		pr_err("GetQuote hypercall failed, status:%llx\n", err);
>  		return -EIO;
> @@ -316,7 +340,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>  
>  	out_len = READ_ONCE(quote_buf->out_len);
>  
> -	if (out_len > TDX_QUOTE_MAX_LEN)
> +	if (TDX_QUOTE_BUF_LEN(out_len) > quote_data_size)
>  		return -EFBIG;

Nit: I think this check will be more readable if you can rename
quote_data_size to quote_buf_size (since it holds total buffer
size).

>  
>  	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
> @@ -418,7 +442,7 @@ static int __init tdx_guest_init(void)
>  	if (ret)
>  		goto deinit_mr;
>  
> -	quote_data = alloc_quote_buf();
> +	quote_data = alloc_quote_buf(&quote_data_size);
>  	if (!quote_data) {
>  		pr_err("Failed to allocate Quote buffer\n");
>  		ret = -ENOMEM;
> @@ -432,7 +456,7 @@ static int __init tdx_guest_init(void)
>  	return 0;
>  
>  free_quote:
> -	free_quote_buf(quote_data);
> +	free_quote_buf(quote_data, quote_data_size);
>  free_misc:
>  	misc_deregister(&tdx_misc_dev);
>  deinit_mr:
> @@ -445,7 +469,7 @@ module_init(tdx_guest_init);
>  static void __exit tdx_guest_exit(void)
>  {
>  	tsm_report_unregister(&tdx_tsm_ops);
> -	free_quote_buf(quote_data);
> +	free_quote_buf(quote_data, quote_data_size);
>  	misc_deregister(&tdx_misc_dev);
>  	tdx_mr_deinit(tdx_attr_groups[0]);
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

