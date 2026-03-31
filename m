Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3733EC2F4;
	Tue, 31 Mar 2026 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994256; cv=none; b=MUHNnAOZp+aOPQixmFcA2cZGtXXtEIgYgh93T3Dx2NKWctsgLZ4zOtE/1/8Ap7oAsQJGbwRhuRhOlJsQhUZlnLOBvPuAhWT/lqP5IwC7rfS7ySKMGR+bNe9cxXEVYrVOE6zElwy54uiuHLJT3Tx572IIAWv60MdWv/KYb3mBvzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994256; c=relaxed/simple;
	bh=uOuPEvwHizN6Y83fqDmEOv+kQCiiMjx/uNtq//NcO9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxTuZ8oLXwNU35Koe5BUiyhR0yCPkIIB5ojM3f9Xkj5L38t3PAcnyoCudrZyW+36KSuTkajoryGv+vG0fIf05ohYQ+3SsjjToCu/HF3cwOdIBEA2arDjI8sNIn5XnnOWdiO/G39Fdj41qDu5rNWN72Zwd4bCaKm2Yh1coaEKoNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1K1FQXn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1K1FQXn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774994254; x=1806530254;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uOuPEvwHizN6Y83fqDmEOv+kQCiiMjx/uNtq//NcO9Q=;
  b=h1K1FQXnBdpgj4BspR07cdro7Gwb7kwc3W5667NlU1zEz0TcA+3y0wYS
   ui1G3YKPQooazajqQOHdhV9DYHJlxHHvZ2txfSd1HyUdcr8/sMMnKoNKb
   RJdCYQdvh8fC1/HUhYqEgZmikJS0fu1KP2BTHQuVMcNBWCYpA17ozmBTq
   72J5BEyws1Vodc1DN4WFNJqEdz29V+XKi00usUsM2BqH1PuLtnCdjKLFL
   9OJO0vAOUyGVfxUJ/GPO48TupuKZ3u2myeQRc75V/AQRkY/HGX6VDEzHl
   Fgjg87CJfdIKcPpkkeNhxHlzW7uyGcRjUADpjx/bS9u8enQNO8es9lqLf
   w==;
X-CSE-ConnectionGUID: e+UJp+ZiSNyIVrfRedk0qg==
X-CSE-MsgGUID: vrod8zRWQ0GFeegQkE8iNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="93603550"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="93603550"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:57:33 -0700
X-CSE-ConnectionGUID: QFTIB9rGR4evUXeFW+xzPg==
X-CSE-MsgGUID: VbnlA3H2R/C9Vcd2AR4efA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="231288511"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:57:33 -0700
Message-ID: <ee096f1e-b994-4d56-a78c-cb0e867ea047@linux.intel.com>
Date: Tue, 31 Mar 2026 14:57:32 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/tdx: Fix off-by-one in port I/O handling
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
 <20260331112430.71425-2-kas@kernel.org>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260331112430.71425-2-kas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kirill,

On 3/31/2026 4:24 AM, Kiryl Shutsemau (Meta) wrote:
> handle_in() and handle_out() in arch/x86/coco/tdx/tdx.c use:
> 
>     u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
> 
> GENMASK(h, l) includes bit h. For size=1 (INB), this produces
> GENMASK(8, 0) = 0x1FF (9 bits) instead of GENMASK(7, 0) = 0xFF (8
> bits). The mask is one bit too wide for all I/O sizes.
> 
> Fix the mask calculation.
> 
> Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
> Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Cc: stable@vger.kernel.org
> ---

LGTM. Can you include a link to the bug report or related discussion in 
the commit log? It will help understand the impact of this issue.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/coco/tdx/tdx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 7b2833705d47..4d7f71d50122 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -693,7 +693,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
>  		.r13 = PORT_READ,
>  		.r14 = port,
>  	};
> -	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
> +	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
>  	bool success;
>  
>  	/*
> @@ -713,7 +713,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
>  
>  static bool handle_out(struct pt_regs *regs, int size, int port)
>  {
> -	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
> +	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
>  
>  	/*
>  	 * Emulate the I/O write via hypercall. More info about ABI can be found

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

