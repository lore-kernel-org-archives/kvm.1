Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB713B774D;
	Mon, 28 Sep 2026 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626577; cv=none; b=pqF2pSgqXxg3gRJQIOIVtk86Lm1rkaiITRYr9tnlGSHGrFANoJujZfXfpZAxEQflA1HYJDFdtbxOtdGbsS6G6YpB/P7rBjUrc0D0uLwbt56cjVZBLwO3yQkYOOHLymyvX9wHC2B46daMhorJGvV/JCLDY04oXmagy5bA06ZZ2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626577; c=relaxed/simple;
	bh=laWMqDwKNyVHhN/CJ9050mBI5WkmEpnHUc0KpFpy9Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNvhJ8JnfFwhyCXy37Gw1W78P7YpYQVWLDpofwzN/8eVTH+1+i5Hb9QPv8SAIxkXSj5ocYN/pfUnpvJfPL8yCYWkQlGNtWVHQ2eKLzVnWg8DR6AydKl86JbQJfiVvVuBU+bLPfCdgE13PkltyviXGgWMKPSz9fbzmPTUQoqL/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BoXY1HQB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BoXY1HQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790626575; x=1822162575;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=laWMqDwKNyVHhN/CJ9050mBI5WkmEpnHUc0KpFpy9Ms=;
  b=BoXY1HQBVBkHinaHq38CB466tkvtGUboJL+o43zGZiEZHHzlcMfHnyFO
   aPe4qMw6Kw4GlHclTCAQgtRUGVhxp1edAZ2oA4KyrbKOKami6D9cLXnjd
   saAUktpB2wP1wxyhjcJagdzQFQ7J3Q/HZmbmQMl0eE2XacvPFgkVpOteR
   3pL6VLgc0YMvBhyfq3svpYsemoNijUsoSg49TLIm1j6e81vMwi2hwrDNI
   6mEpW06330V7X/7rEbrbpa/2NdxygTzSoFnDog+MMLhGvTTbRNgHTeXc9
   ga9cvmJo1cOFC0fYjZMuUh+BZNaDLuGswxk2cUDxPFJQkpWNKQRuRA64b
   A==;
X-CSE-ConnectionGUID: fpFc46vjS6yUSJEnkL1zLQ==
X-CSE-MsgGUID: 20S6vZJBRfyrnwmIupzTFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90464121"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90464121"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 13:16:14 -0700
X-CSE-ConnectionGUID: lENdmf/XTF2I3brpvOpvTA==
X-CSE-MsgGUID: +oQCzvnwSlSOl1ubXbFAsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="274690778"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 13:16:15 -0700
Message-ID: <bf7e44c9-7a94-4771-9afa-d4bb513ffd32@linux.intel.com>
Date: Mon, 28 Sep 2026 13:16:14 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] virt: tdx-guest: Give the Quote buffer an explicit
 type
To: Peter Fang <peter.fang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
 Tony Lindgren <tony.lindgren@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>,
 Artem Bityutskiy <artem.bityutskiy@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-3-peter.fang@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260928100913.2265687-3-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/28/2026 3:08 AM, Peter Fang wrote:
> The Quote buffer is always a "struct tdx_quote_buf", but its global
> pointer is a "void *". A function would have to convert it back to make
> sense of it.
> 
> Declare the global with its actual type, and give it a better name.
> 
> This creates variable shadowing in wait_for_quote_completion(), so
> rename its parameter for clarity.
> 
> AI was used under supervision to collect/apply feedback, review code and
> workshop logs.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> v5:
>  - New patch. [Dave]
> ---
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 35 ++++++++++++-------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index d0303e31e816..896eb0a09c4a 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -192,7 +192,7 @@ struct tdx_quote_buf {
>  };
>  
>  /* Quote data buffer */
> -static void *quote_data;
> +static struct tdx_quote_buf *quote_buf;
>  
>  /* Lock to streamline quote requests */
>  static DEFINE_MUTEX(quote_lock);
> @@ -209,7 +209,7 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
>  			     USER_SOCKPTR(req->tdreport));
>  }
>  
> -static void free_quote_buf(void *buf)
> +static void free_quote_buf(struct tdx_quote_buf *buf)
>  {
>  	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
>  	unsigned int count = len >> PAGE_SHIFT;
> @@ -222,25 +222,25 @@ static void free_quote_buf(void *buf)
>  	free_pages_exact(buf, len);
>  }
>  
> -static void *alloc_quote_buf(void)
> +static struct tdx_quote_buf *alloc_quote_buf(void)
>  {
>  	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
>  	unsigned int count = len >> PAGE_SHIFT;
> -	void *addr;
> +	struct tdx_quote_buf *buf;
>  
> -	addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
> -	if (!addr)
> +	buf = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
> +	if (!buf)
>  		return NULL;
>  
> -	if (set_memory_decrypted((unsigned long)addr, count))
> +	if (set_memory_decrypted((unsigned long)buf, count))
>  		return NULL;
>  
> -	return addr;
> +	return buf;
>  }
>  
>  /*
>   * wait_for_quote_completion() - Wait for Quote request completion
> - * @quote_buf: Address of Quote buffer.
> + * @buf: Address of Quote buffer.
>   * @timeout: Timeout in seconds to wait for the Quote generation.
>   *
>   * As per TDX GHCI v1.0 specification, sec titled "TDG.VP.VMCALL<GetQuote>",
> @@ -249,7 +249,7 @@ static void *alloc_quote_buf(void)
>   * or error code after processing is complete. So wait till the status
>   * changes from GET_QUOTE_IN_FLIGHT or the request being timed out.
>   */
> -static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeout)
> +static int wait_for_quote_completion(struct tdx_quote_buf *buf, u32 timeout)
>  {
>  	int i = 0;
>  
> @@ -257,7 +257,7 @@ static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeou
>  	 * Quote requests usually take a few seconds to complete, so waking up
>  	 * once per second to recheck the status is fine for this use case.
>  	 */
> -	while (quote_buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
> +	while (buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
>  		if (msleep_interruptible(MSEC_PER_SEC))
>  			return -EINTR;
>  	}
> @@ -268,7 +268,6 @@ static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeou
>  static int tdx_report_new_locked(struct tsm_report *report, void *data)
>  {
>  	u8 *buf;
> -	struct tdx_quote_buf *quote_buf = quote_data;
>  	struct tsm_report_desc *desc = &report->desc;
>  	u32 out_len;
>  	int ret;
> @@ -285,7 +284,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>  	if (desc->inblob_len != TDX_REPORTDATA_LEN)
>  		return -EINVAL;
>  
> -	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
> +	memset(quote_buf, 0, GET_QUOTE_BUF_SIZE);
>  
>  	/* Update Quote buffer header */
>  	quote_buf->version = GET_QUOTE_CMD_VER;
> @@ -296,7 +295,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>  	if (ret)
>  		return ret;
>  
> -	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
> +	err = tdx_hcall_get_quote(quote_buf, GET_QUOTE_BUF_SIZE);
>  	if (err) {
>  		pr_err("GetQuote hypercall failed, status:%llx\n", err);
>  		return -EIO;
> @@ -417,8 +416,8 @@ static int __init tdx_guest_init(void)
>  	if (ret)
>  		goto deinit_mr;
>  
> -	quote_data = alloc_quote_buf();
> -	if (!quote_data) {
> +	quote_buf = alloc_quote_buf();
> +	if (!quote_buf) {
>  		pr_err("Failed to allocate Quote buffer\n");
>  		ret = -ENOMEM;
>  		goto free_misc;
> @@ -431,7 +430,7 @@ static int __init tdx_guest_init(void)
>  	return 0;
>  
>  free_quote:
> -	free_quote_buf(quote_data);
> +	free_quote_buf(quote_buf);
>  free_misc:
>  	misc_deregister(&tdx_misc_dev);
>  deinit_mr:
> @@ -444,7 +443,7 @@ module_init(tdx_guest_init);
>  static void __exit tdx_guest_exit(void)
>  {
>  	tsm_report_unregister(&tdx_tsm_ops);
> -	free_quote_buf(quote_data);
> +	free_quote_buf(quote_buf);
>  	misc_deregister(&tdx_misc_dev);
>  	tdx_mr_deinit(tdx_attr_groups[0]);
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

