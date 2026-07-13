Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F8282F3F;
	Mon, 13 Jul 2026 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958509; cv=none; b=PlAE34IQK9rqC/F91ahDYPdDxHVZFN1xIE76UvE/pWAwWcVZFtTOzqUkIQ81lpnNz9eXs5cHfP4NJ10iTZLfvWgFPiuUJyoOedmS0Nl3NwlFCfwXA2jiQl3x4V3ifs1QRqD3tXMDEuVGtUBQBGH2UO1VNyTv6zPqArINCsfIWWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958509; c=relaxed/simple;
	bh=CD954zLyW+H+N700cDO8caRM/+OWbiqnsi8A3hbhkKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXzYQdtGJnb3Zxqh8481smAeckj4kzzfBi8fRHwz6vlw4AFuFnWf6DunAeMkhkT0e0tC+nbYniji+y450ByuBUWT2p5diPLdLiBEC+feVh1pwx5G5Cl+e+RB087Q3taRInBYflQcODYBUMvHNIDzdJGbLBpNdC+atIz89dUGUaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJsNTqsz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJsNTqsz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783958506; x=1815494506;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CD954zLyW+H+N700cDO8caRM/+OWbiqnsi8A3hbhkKg=;
  b=NJsNTqszoFL2lIEnjT3uA220H6AoBiyyafyjqatbT03l7daIJAEzIK54
   /CJtV0+zF0QOgLsNs6RQV1doaSRveH3TJbcYbOoh0xYh3BZ8kijLNyZD7
   qQSbMXJJWtUlTF06vUasnLu7g033Cb+HZgPtA0k+hv/IsubWpjzC7cKYT
   1vmMSPNUJs82wCnSyL7oBWGlRp+WtP8skm/xeJiM73Cwey+3F7Q6oadZ5
   E1gmJpf6dD9ofSAJTtjxZsC4+05C7k7DugUBzTPQfMM/Suizxs7jTLYq7
   ycDaEDCeCmAUzScI2rFAI6boRyaFNFLyrmQAh7oNftUhnyeQuILNESkfA
   w==;
X-CSE-ConnectionGUID: c3KGFVLqQYyXTTlnD6P8cg==
X-CSE-MsgGUID: Yr0xRHp1TKmo281GeZELlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84348798"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84348798"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:01:45 -0700
X-CSE-ConnectionGUID: CPAh3dhWSUGNs6dbqkEkbQ==
X-CSE-MsgGUID: 21ZP3ox8SRypvlTcge7k1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="249238465"
Received: from unknown (HELO [10.24.80.90]) ([10.24.80.90])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:01:45 -0700
Message-ID: <680a2be7-5a10-448d-8552-cb9ef64b6be7@linux.intel.com>
Date: Mon, 13 Jul 2026 09:01:38 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/tdx: Add helper to query maximum TD Quote size
To: Peter Fang <peter.fang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-2-peter.fang@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260612110853.3188196-2-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/12/2026 4:08 AM, Peter Fang wrote:
> TDX attestation blob ("TD Quote") sizes can grow with newer
> cryptographic schemes, so guests can no longer rely on a fixed-size
> buffer for the Quote.
> 
> Newer TDX modules report the maximum TD Quote size via a TD-scope
> metadata field. Add a helper to query it instead of exposing tdg_vm_rd()
> directly, as it can read arbitrary metadata fields.
> 
> Thanks to Xu Yilun for suggesting this.

I'm not sure what the original suggestion was. Perhaps a link to the discussion
(or Xu Yilun's email) would be helpful for context.

> 
> Assisted-by: Claude:claude-opus-4-7
> Assisted-by: GitHub Copilot:gpt-5.4
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>



>  arch/x86/coco/tdx/tdx.c           | 19 +++++++++++++++++++
>  arch/x86/include/asm/shared/tdx.h |  1 +
>  arch/x86/include/asm/tdx.h        |  2 ++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 186915a17c50..88c66c46e70a 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -197,6 +197,25 @@ u64 tdx_hcall_get_quote(u8 *buf, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
>  
> +/**
> + * tdx_get_max_quote_size() - Get the maximum TD Quote size
> + *
> + * Read the maximum size of a TD Quote from a 4-byte TD metadata field. The TDX
> + * guest driver uses it to size the buffer for Quote retrieval. Older TDX
> + * modules do not support this field and return an error.
> + *
> + * Return: Maximum Quote size in bytes on success, or 0 on failure.
> + */
> +u32 tdx_get_max_quote_size(void)
> +{
> +	u64 val, ret;
> +
> +	ret = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, &val);
> +
> +	return ret ? 0 : (u32)val;
> +}
> +EXPORT_SYMBOL_GPL(tdx_get_max_quote_size);
> +
>  static void __noreturn tdx_panic(const char *msg)
>  {
>  	struct tdx_module_args args = {
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index 049638e3da74..2880f493a8e5 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -49,6 +49,7 @@
>  /* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
>  #define TDCS_CONFIG_FLAGS		0x1110000300000016
>  #define TDCS_TD_CTLS			0x1110000300000017
> +#define TDCS_QUOTE_MAX_SIZE		0x9010000200000008
>  #define TDCS_NOTIFY_ENABLES		0x9100000000000010
>  #define TDCS_TOPOLOGY_ENUM_CONFIGURED	0x9100000000000019
>  
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index a149740b24e8..ac39674c9479 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -72,6 +72,8 @@ int tdx_mcall_extend_rtmr(u8 index, u8 *data);
>  
>  u64 tdx_hcall_get_quote(u8 *buf, size_t size);
>  
> +u32 tdx_get_max_quote_size(void);
> +
>  void __init tdx_dump_attributes(u64 td_attr);
>  void __init tdx_dump_td_ctls(u64 td_ctls);
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

