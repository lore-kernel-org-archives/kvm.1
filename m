Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D16385D76;
	Fri, 12 Jun 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274312; cv=none; b=uxkDXdCNsHL21zjK9nFMJvVNx6BnQv7t002HiiNNtDgtZ2MighWO4Lhv7FkOwSvFyruRdkH3wh/+Tgg5YvAv0En0kDFaEo3WVgYtatd2YPuRTtFkf59IYxYgqSRd6/3xAmhXCt58vL6lSIp1Ft616jPMAOZUH0f95v8Njv9Z3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274312; c=relaxed/simple;
	bh=yWDIQ525CsCrGba842/ZiC36lT56EmiAWt4deOpVL6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TerLuEpKq3K1rK8mHmw+9pr/fS6iHNoV66xTexZzsjMqqpVignbzCeBR8c6ZMua7oyQvIvSNDJkAr7RJR89SuPoreo0OZf7CKXuzwGpxp5qVv4K2rbek89YvjPOOdCailybJyJUun3KoScKcvr8aTmT6rYh39faG6K7nXsTCv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sz76rST/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sz76rST/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781274309; x=1812810309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yWDIQ525CsCrGba842/ZiC36lT56EmiAWt4deOpVL6Y=;
  b=Sz76rST/AAjmIVwDbLEWtCcjdm6dy1Jzo0YQnIGwwc89+68QK2U/YjWR
   TbqMXnQpEx0CYuXYN3x4kdsWYJAtFpQQeMIVOTEX477iNY8BwHP7d2d6E
   rbLNGLg0KddvVOcER5C5uKNPgz4ZA/256VbYajFDBvxAK5I+4TmAh98Te
   6zTSYL9PiUJ0FODHWVZLQpIM/e5x77HNSjiMcKav5j8SEbVIJNGxgX0Lx
   q0JJUNOMjTLCiFGNYae90SlDCeOU2YOt5BaHLnLZ9cYLf6Z5PSeP4HqpX
   zeC6TVCGScy59CWzbp7bga1iUxIYZ7NC6dFX4/fPNkwjHZttWbTR+T+8A
   w==;
X-CSE-ConnectionGUID: D994XSUNRU+cY+KywyUVaw==
X-CSE-MsgGUID: D4XiI9ZLSD24EknMrjTBSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81116101"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81116101"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 07:25:09 -0700
X-CSE-ConnectionGUID: +a8NPcjIRDO8RZkcFNkx7w==
X-CSE-MsgGUID: 2vFqB7OMQQWGST3/MQ7/ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="243902245"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 07:25:06 -0700
Message-ID: <49728a57-a996-470d-92b7-209a010b4761@intel.com>
Date: Fri, 12 Jun 2026 22:25:03 +0800
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
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-2-peter.fang@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260612110853.3188196-2-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/2026 7:08 PM, Peter Fang wrote:
> TDX attestation blob ("TD Quote") sizes can grow with newer
> cryptographic schemes, so guests can no longer rely on a fixed-size
> buffer for the Quote.
> 
> Newer TDX modules report the maximum TD Quote size via a TD-scope
> metadata field. Add a helper to query it instead of exposing tdg_vm_rd()
> directly, as it can read arbitrary metadata fields.
> 
> Thanks to Xu Yilun for suggesting this.
> 
> Assisted-by: Claude:claude-opus-4-7
> Assisted-by: GitHub Copilot:gpt-5.4
> Signed-off-by: Peter Fang <peter.fang@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

I have another nit other than Kiryl's

> ---
>   arch/x86/coco/tdx/tdx.c           | 19 +++++++++++++++++++
>   arch/x86/include/asm/shared/tdx.h |  1 +
>   arch/x86/include/asm/tdx.h        |  2 ++
>   3 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 186915a17c50..88c66c46e70a 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -197,6 +197,25 @@ u64 tdx_hcall_get_quote(u8 *buf, size_t size)
>   }
>   EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
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

Do we need to start to use

EXPORT_SYMBOL_FOR_MODULES(tdx_get_max_quote_size, "tdx-guest") ?

> +
>   static void __noreturn tdx_panic(const char *msg)
>   {
>   	struct tdx_module_args args = {
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index 049638e3da74..2880f493a8e5 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -49,6 +49,7 @@
>   /* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
>   #define TDCS_CONFIG_FLAGS		0x1110000300000016
>   #define TDCS_TD_CTLS			0x1110000300000017
> +#define TDCS_QUOTE_MAX_SIZE		0x9010000200000008
>   #define TDCS_NOTIFY_ENABLES		0x9100000000000010
>   #define TDCS_TOPOLOGY_ENUM_CONFIGURED	0x9100000000000019
>   
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index a149740b24e8..ac39674c9479 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -72,6 +72,8 @@ int tdx_mcall_extend_rtmr(u8 index, u8 *data);
>   
>   u64 tdx_hcall_get_quote(u8 *buf, size_t size);
>   
> +u32 tdx_get_max_quote_size(void);
> +
>   void __init tdx_dump_attributes(u64 td_attr);
>   void __init tdx_dump_td_ctls(u64 td_ctls);
>   

