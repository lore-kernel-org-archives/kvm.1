Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0343BE155;
	Tue, 31 Mar 2026 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995026; cv=none; b=M8cyrOgRKGDDgypDrwQNRYkqyTiTaHX0NpCgPk/xEJjWWT4T1ayuDIcRcdzZ12XiOcZgZISmTh9GONfchN174SvzRqVJCd4hJk+VuM3JWz+GxUZtMuQ7aU5I+JHqwrnXfjEzJqG/asUFxIvYc99Q1pq06BPaYJHk1/lXKZK4sBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995026; c=relaxed/simple;
	bh=B4ge4IYMDMCd5FP9OO6dadr6jf7zkmpHNt2d2Wfp/m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElL9Oky5S3Xr6F0tFhyWQPU15TFP4HAUuIL2HYwX6hKDvSpE3Iqsd0yPvsZVD/mtfZzQHn8sFsyzi27VCVkK659nowLsflvdNdjOuaedHhtZJ4J6zQdfntQXkEYxujjAa2yZUtt7KY6k4+bq9EYB+az6yMCkwsoDSZRJsiyakyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cknMRyis; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cknMRyis"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774995025; x=1806531025;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B4ge4IYMDMCd5FP9OO6dadr6jf7zkmpHNt2d2Wfp/m4=;
  b=cknMRyisWMYJDb9JWUxpmheV/DK5CIQiArWkNJFqupyHTWnwW/IhfTZz
   izm78mggr48vMJJ0uibdevOEEgEnM5pixFRzXurJo/aR3B2QKIXJn9KXd
   3QI9kXunybfOEl59a2meNCIWa8Hi+RwcK4AqUrTghqyKk8pB9Knh5QRPt
   SSrNZxezHoQL00IifUwB0IJeUw2oor3tHdr+BxtBOC90Q9C1deOELu+Gk
   2msIK6hin4HoNO5tP9iXrSdIZrmrctqsfkvueKH1ELN9b45CtzM85xDpQ
   GKntNxIsPa+uYOSWWxwPeLKkVHyJWoMMxW22SF15y40KCYsZRkEJlIpWS
   w==;
X-CSE-ConnectionGUID: 3cIcbqRrSBy3sA2lW3XG5g==
X-CSE-MsgGUID: VksOqglWRry1vyUE0pXWaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79884327"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="79884327"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 15:10:24 -0700
X-CSE-ConnectionGUID: 3JyIKnzfR8SKB8Mj/0G4lQ==
X-CSE-MsgGUID: P7jIbOkRRJyHV+AFOZlHOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="249706506"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 15:10:23 -0700
Message-ID: <2a291f30-86c8-4043-933f-8d330a39e6c0@linux.intel.com>
Date: Tue, 31 Mar 2026 15:10:22 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, stable@vger.kernel.org
References: <20260331112430.71425-1-kas@kernel.org>
 <20260331112430.71425-3-kas@kernel.org>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260331112430.71425-3-kas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kiril,

On 3/31/2026 4:24 AM, Kiryl Shutsemau (Meta) wrote:
> According to x86 architecture rules, 32-bit operations zero-extend the
> result to 64 bits. The current implementation of handle_in() only masks
> the lower 32 bits, which preserves the upper 32 bits of RAX when a
> 32-bit port IN instruction is emulated.
> 
> Update handle_in() to zero out the entire RAX register when the I/O size
> is 4 bytes to ensure correct zero-extension. For smaller sizes (1 or 2
> bytes), continue to preserve the unaffected upper bits.
> 
> Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
> Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Cc: stable@vger.kernel.org
> ---

If you have bug or discussion link, please include it.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>



>  arch/x86/coco/tdx/tdx.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 4d7f71d50122..b9b9a2d75119 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -703,8 +703,17 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
>  	 */
>  	success = !__tdx_hypercall(&args);
>  
> -	/* Update part of the register affected by the emulated instruction */
> -	regs->ax &= ~mask;
> +	/*
> +	 * Update part of the register affected by the emulated instruction.
> +	 *
> +	 * 32-bit operands generate a 32-bit result, zero-extended to a 64-bit
> +	 * result.
> +	 */
> +	if (size < 4)
> +		regs->ax &= ~mask;
> +	else
> +		regs->ax = 0;

The logic would be more readable as:

	if (size == 4)
		regs->ax = 0;
	else
		regs->ax &= ~mask;

> +
>  	if (success)
>  		regs->ax |= args.r11 & mask;
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

