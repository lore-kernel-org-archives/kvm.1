Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B746D2AF;
	Mon, 28 Sep 2026 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627834; cv=none; b=TeX4/LteWMXH6BbC+xndZKdFOc0v3zw4U8FIXuXOL3ubPLjJTMSouAAj9uO4OZN3hg3QvrGKuLYDMj9awFGoh89hbvUS3K0FsOZZ/5133GVLdXsC/NIIkl9JtAgKXj7kFFbG5sauzY5WiXaqeW+rblxc3D6x/pfQty1T9QxrzzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627834; c=relaxed/simple;
	bh=NioknLsD16oLtjxY+fFyJSlRvaGeEFxfDj064Z+6Myc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAW35Ljih2v9d2W0jljLZwqx7b3a/IdUCa9L4HMEklvnwOv7qvPS7fgL5Yy+q8LU9iVjRyat/1qqmJn7UY77wuYF5AHZbHHc4dnCqHWxTm2In0iv53MY8AiffQN6EkrawLLbD9zF5NjmlWM0rMxDlc9DHfNa5dbT/cq+XbYqaME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPTGN73E; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPTGN73E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790627832; x=1822163832;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NioknLsD16oLtjxY+fFyJSlRvaGeEFxfDj064Z+6Myc=;
  b=hPTGN73ER9g6OGlAHeXvk+mAU7h289+b4Gl1JggliAmXGpFQoKUjmo1T
   QMC7YYecbMZ9/w421IxmjP8LLMqpJwsPfnQ2yuAaxm1JgZChvNzrTAB05
   /ilXxbiNh+hT5VdydAQZ/BtETLN1D6pVPjCUZbtDTbDxeRHGW7PO5xME6
   8CZ5uhW3rdK+qIBGLazcYiv9KgxXK5/AWHReOoCQ9fnFg29J4cgw4N3zd
   3DT5Gc1zt0/sh9/7qY9NJdt5gt6q56z2Jvbctvdpq1y8yMMsHCx4Sf6Ad
   7bZbdT9MNHD0ejDrQ3e0IG31IWUHTnMQ0P68QRJgTMOKpbF2A7MhKX5QD
   A==;
X-CSE-ConnectionGUID: 0nKU0HqfSHWZwJpR2BLSlA==
X-CSE-MsgGUID: j91rGkiFTXCRTw2jscPimw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="107719892"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="107719892"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 13:37:12 -0700
X-CSE-ConnectionGUID: INVKBYsiSzquTZocL8W1fw==
X-CSE-MsgGUID: ga8jB+kuTs+snlgLVERsUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="274266408"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 13:37:12 -0700
Message-ID: <224672fa-8e29-4b0a-b472-6721e057b8a3@linux.intel.com>
Date: Mon, 28 Sep 2026 13:37:11 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] virt: tdx-guest: Make the Quote buffer size
 dynamic
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
 <20260928100913.2265687-7-peter.fang@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260928100913.2265687-7-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/28/2026 3:08 AM, Peter Fang wrote:
> Support a new TDX module ABI that reports the Quote size limit in a
> metadata field. The fixed 128KB buffer in the driver may be too small
> for Quotes that use new algorithms like post-quantum cryptography (PQC),
> which can produce much larger certificates. With this ABI, the guest
> sizes the buffer to the platform's needs and no longer has to rely on
> some empirical number.
> 
> The shared buffer comes from the buddy allocator, as the host expects it
> to be physically contiguous. The allocator's page order limit should be
> sufficient for current attestation needs. Platforms that don't report
> the limit fall back to the default 128KB buffer.
> 
> AI was used under supervision to collect/apply feedback, review code and
> workshop logs.
> 
> Based on a patch originally by Kuppuswamy Sathyanarayanan.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> ---
> v5:
>  - Do the export here, and use EXPORT_SYMBOL_FOR_MODULES() instead.
>    [Xiaoyao, Dave]
>  - Drop the comment about the buddy allocator. [Dave]
>  - Drop the RB tags, as the code changed substantially.
> v4:
>  - Move the PAGE_ALIGN() out of get_quote_buf_size(). [Xiaoyao]
>  - Improve the get_quote_buf_size() pattern again.
>  - Document that the reported size covers every Quote type. [Xiaoyao]
>  - Document that a module update does not change the reported size.
>    [Tony]
>  - Add Tony's Reviewed-by.
> v3:
>  - Split out from the v2 "Allocate Quote buffer dynamically" patch. Add
>    the dynamic buffer feature on top of the refactoring. [Dave]
>  - Improve the get_quote_buf_size() pattern for better readability.
>    [Dave]
>  - Drop __GFP_NOWARN so an allocation failure warns. [Dave, Rick, Kiryl]
>  - Drop the Reviewed-by tags from v2 (Kiryl, Binbin) as the patch was
>    reworked.
> ---
>  arch/x86/coco/tdx/tdx.c                 |  1 +
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 13 ++++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 323e1efc78ea..847430fc639f 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -213,6 +213,7 @@ int tdx_get_max_quote_size(u64 *max_quote_size)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_FOR_MODULES(tdx_get_max_quote_size, "tdx-guest");

I think you can cleanup other exports consumed by tdx-guest driver
to use the same format (in a prep patch).

tdx_hcall_get_quote(), tdx_mcall_get_report0() and tdx_mcall_extend_rtmr(0.

>  
>  static void __noreturn tdx_panic(const char *msg)
>  {
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index b79b4325da3a..ad2cb4740898 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -212,11 +212,22 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
>  static size_t get_quote_buf_size(void)
>  {
>  	static size_t quote_buf_size;
> +	u64 max_quote_size;
>  
>  	if (quote_buf_size)
>  		return quote_buf_size;
>  
> -	quote_buf_size = PAGE_ALIGN(TDX_DEFAULT_QUOTE_SIZE);
> +	/* Start with the default buffer size */
> +	quote_buf_size = TDX_DEFAULT_QUOTE_SIZE;
> +
> +	/*
> +	 * Override the default when the TDX module reports a size. Add room
> +	 * for the header metadata.
> +	 */
> +	if (!tdx_get_max_quote_size(&max_quote_size))
> +		quote_buf_size = TDX_QUOTE_TOTAL_SIZE(max_quote_size);
> +
> +	quote_buf_size = PAGE_ALIGN(quote_buf_size);
>  
>  	return quote_buf_size;
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

