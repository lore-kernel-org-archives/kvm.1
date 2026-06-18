Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D793B777F;
	Thu, 18 Jun 2026 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781793929; cv=none; b=nbMIu6jxechYCAssIfS+7XzNBW/eWfsBpTXYdoeZcjZvvo9ICavmStWKsW8u5M0k1zYm+R+PHbsUZIA9UQpEj2RA023eshghLLitwj8uLKUBWfzMlONcDw+zWEB7+Mfy6OYt9EX0mwYsbxH1UhJSoD04hxbLUAEYaAix2I1+q0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781793929; c=relaxed/simple;
	bh=A9WK/cPD3uw2LH2iZlFk79auznhqO1irExbdoBfW/PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mF5poMLsQbx4IthCFfLRZF0QmaFN1xgKCLadFEcfm93S0+nlopIQJZR6xem+XbC3fzm+oHAv3QhkEnh05EUegfrz9XpO9c6FWV9uD7wqPKbK1wG1Vmc/KNNRfH6O9gUIEV/3EpLjVO9od+yOEwYOUHCUeq2vS1HsyfWqployM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8cU5FaN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8cU5FaN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781793927; x=1813329927;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A9WK/cPD3uw2LH2iZlFk79auznhqO1irExbdoBfW/PU=;
  b=J8cU5FaNfEkhfBFhIOIrG/A501Qm4v6+z4CHcKfi2dwFPLwxvZo8A92A
   3R4lf+gvil4hyTLT2RXzabP9I6nYMxZwFhqB415bidosN5uN17k42BQGU
   N2wsTNEh6B0fec8oQITgE91j0PI1eExNzUA7yZmodPzd7CDY1q/Hpqbw5
   LbnQIleK7wqby5olqumbNdLeBODMFzqDRtreUSu58fgbnmtTylrsrAeUZ
   BronMpVdjj0b9pRS6XAKuUSVwKt2SLdhF8rguTorIsxI3GhIXI7wMlhnW
   /qjp2f1HvIOoZpu1gcIUUL9Uqv6viYkm320oezUzDPKv6BZ3lqUmMhSyr
   A==;
X-CSE-ConnectionGUID: l7cNAm32Su6ALSUTUrf2kA==
X-CSE-MsgGUID: YgFQeE0UQV28AQKCXSVF6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="94005376"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="94005376"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 07:45:26 -0700
X-CSE-ConnectionGUID: nF25pagpQ9uvctuMkgguDQ==
X-CSE-MsgGUID: oRaU7j/aRDuERW+LhZZEZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="247502339"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.111.222]) ([10.125.111.222])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 07:45:25 -0700
Message-ID: <bdde1a33-9513-4be3-87cb-044c034eddb1@intel.com>
Date: Thu, 18 Jun 2026 07:45:25 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] x86/virt/tdx: Embed version info in SEAMCALL
 leaf function definitions
To: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: djbw@kernel.org, kas@kernel.org, rick.p.edgecombe@intel.com,
 yilun.xu@intel.com, xiaoyao.li@intel.com, sohil.mehta@intel.com,
 adrian.hunter@intel.com, kishen.maloor@intel.com,
 tony.lindgren@linux.intel.com, peter.fang@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
 dave.hansen@linux.intel.com, seanjc@google.com
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-2-yilun.xu@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260618081355.3253581-2-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/26 01:13, Xu Yilun wrote:
> Embed version information in SEAMCALL leaf function definitions rather
> than let the caller open code them. For now, only TDH.VP.INIT is
> involved.

This is jumping the gun a bit in the changelog.

What is a SEAMCALL leaf function?

How does the version fit in?

> Don't bother the caller to choose the SEAMCALL version if unnecessary.

I think I see what you are trying to say here but it's more than that.

The question is whether there should be a base seamcall() API that takes
an explicit version or whether the version should be passed in by callers.

One wrinkle is that the naming of all of these things is around
"function", "func" and "fn":

u64 __seamcall(u64 fn, struct tdx_module_args *args);

A "function" is TDH.SYS.INIT or TDH.SYS.INFO, not 'TDH.SYS.INFO v123'.

But the low-level calls could be:

	u64 __seamcall(u64 fn, u64 version, ...);
	
or

	u64 __seamcall(u64 fn, ...);

Where 'fn' encodes the function *and* version.

> The old TDX modules that only support TDH.VP.INIT v0 are all deprecated,
> so only provide the latest (v1) definition.

No, this isn't how this is going to work.

What do we *NEED* from v1? Why churn the code if we don't *NEED*
something from v1 and can live with v0? It has *ZERO* to do with the TDX
module being deprecated or whatever.

Linux stays on the old interface until we need a new interface. We are
*not* going to bump version numbers just because.


>  /*
>   * TDX module SEAMCALL leaf functions
>   */
> @@ -31,7 +44,7 @@
>  #define TDH_VP_CREATE			10
>  #define TDH_MNG_KEY_FREEID		20
>  #define TDH_MNG_INIT			21
> -#define TDH_VP_INIT			22
> +#define TDH_VP_INIT			SEAMCALL_LEAF_VER(22, 1)
>  #define TDH_PHYMEM_PAGE_RDMD		24
>  #define TDH_VP_RD			26
>  #define TDH_PHYMEM_PAGE_RECLAIM		28
> @@ -50,14 +63,6 @@
>  #define TDH_SYS_UPDATE			53
>  #define TDH_SYS_DISABLE			69

That is unreadable and patterns can't be seen. This is better:

#define TDH_MNG_INIT			SEAMCALL_LEAF_VER(21, 0)
#define TDH_VP_INIT			SEAMCALL_LEAF_VER(22, 1)
#define TDH_PHYMEM_PAGE_RDMD		SEAMCALL_LEAF_VER(24, 0)

> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1903,8 +1903,7 @@ u64 tdh_vp_init(struct tdx_vp *vp, u64 initial_rcx, u32 x2apicid)
>  		.r8 = x2apicid,
>  	};
>  
> -	/* apicid requires version == 1. */
> -	return seamcall(TDH_VP_INIT | (1ULL << TDX_VERSION_SHIFT), &args);
> +	return seamcall(TDH_VP_INIT, &args);
>  }
>  EXPORT_SYMBOL_FOR_KVM(tdh_vp_init);

But that whole scheme falls apart the first time the kernel needs
functionality from v2. You'll need:

#define TDH_VP_INIT_V0			SEAMCALL_LEAF_VER(22, 0)
#define TDH_VP_INIT_V1			SEAMCALL_LEAF_VER(22, 1)

and then the calls will do:

	if (foo)
		return seamcall(TDH_VP_INIT_V0, &args);
	else
		return seamcall(TDH_VP_INIT_V1, &args);

So this 100% goes down the road of needing #defines for *EACH* version.
That's the real implication here and the real choice.

That said, I don't particularly like:

	if (foo)
		return seamcall(TDH_VP_INIT, 0, &args);
	else
		return seamcall(TDH_VP_INIT, 1, &args);

all that much either because of the seemingly magic numbers.

The whole seamcall RAX thing is one step too clever. I think Linux did
the right thing:

5	common	open				sys_open
288	common	openat				sys_openat
437	common	openat2				sys_openat2

New ABI gets a new base number. No need for the other end of the ABI to
know that 288 is arguably a later version of 5.

Ugh. But why is this patch even in here in the first place? Why is this
even *ASSOCIATED* with DICE-based attestation? Isn't this completely
orthogonal?
