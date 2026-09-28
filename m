Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964F2EFD95;
	Mon, 28 Sep 2026 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627529; cv=none; b=n82Rwh7Mcm3lD+yRYcc88vrcKr/9YGAPRDkYq8CoTd4nwUY4ntiEfA2BJnlJeeE9mWXQlhLX0tfU7c4Exs5T962dDu6FnCfcUfRFxm8B+UYhjkJx8wsjyzK+3gRAWtMavxKSKVPZeitpR4gwzS9NGgrozMGBWMbFfVpVhseuGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627529; c=relaxed/simple;
	bh=QJT/VFsfMuyTEhWOGSXQHsacyCLEai39rY7yoGo5fQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nk84RTyf3hCkGdUg2Wq1r/K+nDlxI5LyJQdT3ganfuYztnbp+F7Vkmtc0p0NLbHD3IPnvNdjdkQO4p6RWsrmYGBB/vTi0X8ilwLbHluFA5IHscjZAeEolJVdS1t6n93LIP1Cr5JMA38y+g/wsqSZKXi0Usc94q6mIQfVY1C734o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ma1XlGr9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ma1XlGr9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790627527; x=1822163527;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QJT/VFsfMuyTEhWOGSXQHsacyCLEai39rY7yoGo5fQw=;
  b=Ma1XlGr9IfeOJ/trtZWqAfzS93NZ3tYOG65e7fKfn6wL9QgpOio9LtaQ
   8Hj1KBfF3ezCsrk1N9Mjs/AOM18Fnn+PlPXNGbw3RehnHB6AZIE/bEkUX
   Bn6tGFSV4yaKfMru4yO9yvavCtEeSrfZ68jzE1gA0UnpN3YXq+E2nydL+
   8Mf69/K+Gzva0KA/fYm4WwrZnbuHI6MuFUfxPVa/nAdSvGC0C1hYr3TAw
   cTJUFUmgQ5fQokjuu6sglVMcmZehhmy7QXPjHFykd1gtzY8mJpWaELbFn
   6a1Mxmyl7pcmyjSf2Bbsin6WfxvbYs74c9Vmu9ZI9N7dmD9ESNAf8LRp8
   A==;
X-CSE-ConnectionGUID: 5xGgvmAITE6XlOwWuzQ5vw==
X-CSE-MsgGUID: tDQD7URXQ6a3b0gaZMLUow==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="107719259"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="107719259"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 13:32:07 -0700
X-CSE-ConnectionGUID: jJoEi9HITqSvgDucda2zTw==
X-CSE-MsgGUID: gKJbCuUnQTqQ7Ia4XLTiAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="274265891"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 13:32:07 -0700
Message-ID: <61a63fcb-c40c-4259-b314-9ec63b0bc847@linux.intel.com>
Date: Mon, 28 Sep 2026 13:32:06 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
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
 <20260928100913.2265687-6-peter.fang@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260928100913.2265687-6-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/28/2026 3:08 AM, Peter Fang wrote:
> TDX attestation report ("Quote") sizes can grow with newer crypto
> algorithms, so guests can no longer rely on a fixed-size buffer for the
> Quote.
> 
> The TDX module added a new ABI that reports the largest possible Quote
> size via a metadata field [1]. Add a helper to query the size instead of
> exposing tdg_vm_rd() directly, as it can read arbitrary metadata fields.
> 
> The reported size covers every Quote type the platform can produce,
> including SGX-based Quotes.
> 
> Thanks to Xu Yilun for suggesting this in an off-list discussion.

If the patch is suggested by Xu Uilun you can use Suggested-by:

> 
> AI was used under supervision to collect/apply feedback, review code and
> workshop logs.
> 
> [1] Intel TDX Module ABI Definitions, August 2026, TD-scope metadata
>     field "TD_QUOTE_MAX_SIZE"
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> ---
> v5:
>  - Drop unused EXPORT_SYMBOL_GPL(). [Dave]
>  - Use an error code to report failure. [Dave]
>  - Drop the u32 cast. [Dave]
>  - Replace the kernel-doc comment with a one-liner. [Dave]
>  - Drop the RB tags, as the code changed substantially.
> v4:
>  - Update the TDCS_QUOTE_MAX_SIZE encoding to 0x9010000200000007. [1]
>  - Provide documentation for the metadata field. [Rick, Kiryl]
>  - Document that the reported size covers every Quote type. [Xiaoyao]
>  - Document that a module update does not change the reported size.
>    [Tony]
>  - Add Tony's Reviewed-by.
> v3:
>  - No code changes. Add Binbin's Reviewed-by.
> v2:
>  - Keep the explicit (u32) cast to document the metadata field width.
>    [Binbin]
>  - Note that Xu Yilun's suggestion was made in an off-list discussion.
>    [Sathya]
>  - Drop the Assisted-by tags, as the code was not written by AI.
> ---
>  arch/x86/coco/tdx/tdx.c           | 16 ++++++++++++++++
>  arch/x86/include/asm/shared/tdx.h |  1 +
>  arch/x86/include/asm/tdx.h        |  2 ++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index bcaf4180a8db..323e1efc78ea 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -198,6 +198,22 @@ u64 tdx_hcall_get_quote(void *buf, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
>  
> +/*
> + * Ask the TDX module what the largest possible Quote might be.
> + */
> +int tdx_get_max_quote_size(u64 *max_quote_size)
> +{
> +	u64 err;
> +
> +	err = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, max_quote_size);
> +
> +	/* Old modules do not support this. Tell the caller. */
> +	if (err)
> +		return -EINVAL;

I think -ENODEV or -EOPNOTSUPP is more appropriate return value
for unsupported case.

Also tdg_vm_rd() updates max_quote_size on error case as well.

You can reset it or use local variable to skip passing incorrect
value on error case.

> +
> +	return 0;
> +}
> +
>  static void __noreturn tdx_panic(const char *msg)
>  {
>  	struct tdx_module_args args = {
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index f20e91d7ac35..6f106d4b1a58 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -50,6 +50,7 @@
>  /* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
>  #define TDCS_CONFIG_FLAGS		0x1110000300000016
>  #define TDCS_TD_CTLS			0x1110000300000017
> +#define TDCS_QUOTE_MAX_SIZE		0x9010000200000007
>  #define TDCS_NOTIFY_ENABLES		0x9100000000000010
>  #define TDCS_TOPOLOGY_ENUM_CONFIGURED	0x9100000000000019
>  
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index a3c37d61e676..6a465827d8f9 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -83,6 +83,8 @@ int tdx_mcall_extend_rtmr(u8 index, u8 *data);
>  
>  u64 tdx_hcall_get_quote(void *buf, size_t size);
>  
> +int tdx_get_max_quote_size(u64 *max_quote_size);
> +
>  void __init tdx_dump_attributes(u64 td_attr);
>  void __init tdx_dump_td_ctls(u64 td_ctls);
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

