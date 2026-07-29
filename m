Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A84519A9;
	Wed, 29 Jul 2026 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350873; cv=none; b=hzc2iyhEqSYNhGVoLOVYimIQZJktWwXMaqgU65Jjf3CwzWyDTC0BYs4rDvxHGVlULZXQTlsp+5whn0OctrpYUv8pp7RN+26nZ6QuGK/bTSDSYTUWF4b7JIO5iIGJBsuCohgC/ShGEIOcjlUlcMLcynHPt5Fa+PKWKOrihO7KWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350873; c=relaxed/simple;
	bh=WAuGVOefYb5qmZcDX0ScB7/eM/8zJ5ZjkVzmfYbZwDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCa8VakCghD/TU6Y3iPNbse8/myckx07/8MH2CEsnxno7Mp39trZj3GCyPQcs7PnPdRZC009dSZ+rXmTJn+n4MqubdAsPeWUOE2vFKv55Goe4HDaek1L17FEYcEOTKxOjaxag97SqNbrF9QbqU2It1eQ/fcW+AMzEl+qovi1tcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cu7l/YF8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cu7l/YF8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785350872; x=1816886872;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WAuGVOefYb5qmZcDX0ScB7/eM/8zJ5ZjkVzmfYbZwDo=;
  b=cu7l/YF89/SG1cP8haGsbHWW1vv6INdP1ukhpG32/iEDAO1nLHRjtNs4
   86mL309TED2HubaSCFOuFbZpr2+2Id2xUohdr3b8TDG/PVcbB8m0WRoaZ
   emX2HGObFoTveKL6DRLPj5j9EMeQ3NvH63hSFLIVNhH1uWSKcT44JZDWS
   ZpkIO4cjWY65ILqAOq6zY5bKQlqU4nVka6aaPdkKARwgtsYsk+GLVB97C
   mUVucf79S4/WIzH0c8OedcNRS8bWkPvExiXmv8EtYz/TCQbfhGqZdsqoR
   khQtgM2VC0TdByP8eImaBPorxGNPH/M1zBojt44T0v5K2qMKoLx+BSF7W
   w==;
X-CSE-ConnectionGUID: /mz2yPm3S2+5JCZ42FFc0Q==
X-CSE-MsgGUID: d94ufvTURu+itPcNoeoAug==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85982151"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="85982151"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 11:47:51 -0700
X-CSE-ConnectionGUID: zI84s8Y1Qgqi4LRfNI3d2w==
X-CSE-MsgGUID: 7UY81pLXRfqVIv1ukPzUVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="264360743"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 11:47:51 -0700
Message-ID: <af483218-5c87-4ce1-b4a3-06132dcc3c49@linux.intel.com>
Date: Wed, 29 Jul 2026 11:47:51 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the Quote
 buffer size
To: Peter Fang <peter.fang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-4-peter.fang@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260729122939.1340412-4-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/2026 5:29 AM, Peter Fang wrote:
> In preparation for dynamic Quote buffer sizes, replace the fixed size

sizes -> size?

> constant with a variable.
> 
> The size is currently a constant sprinkled across several places. Store
> it in a variable and have all the users read it from there.

You are also dropping PAGE_ALIGN() in alloc and free calls. You can
mention it in commit log.

> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> v3:
>  - Split out using a variable for the buffer size from the v2 "Allocate
>    Quote buffer dynamically" patch to refactor first. [Dave]
>  - Pass the buffer size into alloc_quote_buf() by value. [Dave]
>  - Drop the Reviewed-by tags from v2 (Kiryl, Binbin) as the patch was
>    reworked.
> ---
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index f47c5429d002..3d3f79ab45af 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -191,8 +191,9 @@ struct tdx_quote_buf {
>  	u8 data[];
>  };
>  
> -/* Quote data buffer */
> +/* Quote data buffer and length */
>  static void *quote_data;
> +static size_t quote_data_len;
>  
>  /* Lock to streamline quote requests */
>  static DEFINE_MUTEX(quote_lock);
> @@ -209,9 +210,8 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
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
> @@ -222,9 +222,8 @@ static void free_quote_buf(void *buf)
>  	free_pages_exact(buf, len);
>  }
>  
> -static void *alloc_quote_buf(void)
> +static void *alloc_quote_buf(size_t len)
>  {
> -	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
>  	unsigned int count = len >> PAGE_SHIFT;
>  	void *addr;
>  
> @@ -285,7 +284,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>  	if (desc->inblob_len != TDX_REPORTDATA_LEN)
>  		return -EINVAL;
>  
> -	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
> +	memset(quote_data, 0, quote_data_len);
>  
>  	/* Update Quote buffer header */
>  	quote_buf->version = GET_QUOTE_CMD_VER;
> @@ -296,7 +295,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>  	if (ret)
>  		return ret;
>  
> -	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
> +	err = tdx_hcall_get_quote(quote_data, quote_data_len);
>  	if (err) {
>  		pr_err("GetQuote hypercall failed, status:%llx\n", err);
>  		return -EIO;
> @@ -315,7 +314,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>  
>  	out_len = READ_ONCE(quote_buf->out_len);
>  
> -	if (TDX_QUOTE_BUF_LEN(out_len) > GET_QUOTE_BUF_SIZE)
> +	if (TDX_QUOTE_BUF_LEN(out_len) > quote_data_len)
>  		return -EFBIG;
>  
>  	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
> @@ -417,7 +416,8 @@ static int __init tdx_guest_init(void)
>  	if (ret)
>  		goto deinit_mr;
>  
> -	quote_data = alloc_quote_buf();
> +	quote_data_len = GET_QUOTE_BUF_SIZE;
> +	quote_data = alloc_quote_buf(quote_data_len);
>  	if (!quote_data) {
>  		pr_err("Failed to allocate Quote buffer\n");
>  		ret = -ENOMEM;
> @@ -431,7 +431,7 @@ static int __init tdx_guest_init(void)
>  	return 0;
>  
>  free_quote:
> -	free_quote_buf(quote_data);
> +	free_quote_buf(quote_data, quote_data_len);
>  free_misc:
>  	misc_deregister(&tdx_misc_dev);
>  deinit_mr:
> @@ -444,7 +444,7 @@ module_init(tdx_guest_init);
>  static void __exit tdx_guest_exit(void)
>  {
>  	tsm_report_unregister(&tdx_tsm_ops);
> -	free_quote_buf(quote_data);
> +	free_quote_buf(quote_data, quote_data_len);
>  	misc_deregister(&tdx_misc_dev);
>  	tdx_mr_deinit(tdx_attr_groups[0]);
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

