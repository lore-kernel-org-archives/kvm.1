Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26193F413D;
	Thu, 18 Jun 2026 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795101; cv=none; b=Zt8Yfz0v09Q3Ziw3cJySQOgzV5UMcLLAQm8cKDCMlltrt7Y07xj+rNkHlh8nGxmrKKTBTkVO7pZ9qxliwrA5vYjFBJxv5iUPkCUCTeZ07vi8BELsABs7k7z1RqEKB1h65satq0Jo+w3eFFotN6a+MR/balv+AMS9QeaRW/+HSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795101; c=relaxed/simple;
	bh=ro4+gpoLrqsLmi2y6DwQCGTfQAAwPydgwx+VKGvATtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCxVkcxDgofSMIvCWW7nL38R8FiXpNXoLG0ET1/ul8rbmVmCxe2i2K14t81XAcJchUf565okxJjsSmfA+dQDDS5iy4jHT+nKioypOWc05EcHCK/lIFAgixuI961YNaznQh5B379T+BIz7xBYCWcWxnC/xV9WcnIdozP5ryqzwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2bbruFF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2bbruFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781795100; x=1813331100;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ro4+gpoLrqsLmi2y6DwQCGTfQAAwPydgwx+VKGvATtU=;
  b=J2bbruFFpbDHGy8EuwwewY7+IfMh+vddvW+sBMUXN0khxiGOWEuM06L0
   16GhGYbFRZwj2XGuGfvRNRUa3jvABHATP523He9nAUcW08Fhq8nDbcoqN
   Kuzm2R6UL7sHBnjkaOlNH5UjggHeO4zY2DTph2ijT1Z0BShrmxm3A9tdR
   p+6vmLz5LxjmCic2uHMWgW7BhDy9pzqdBVRqdkO+SkpuK34UgebwKIP2+
   2h9a6TniwDxRfbJN09JufxRSK5Wv5+40tBmoyrenQ7B4rzWlWE4CCb+Xb
   7vSc+8fsFmi5+78mqlYDdDl/lvSGexkY1ftxVB6Q4Au1/lFjn+5nOaIX0
   g==;
X-CSE-ConnectionGUID: 0rgyKWE6TAi7pSs1x8qXoA==
X-CSE-MsgGUID: jIiGXMUnQt2jbTjuq4EKJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="86545390"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="86545390"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 08:05:00 -0700
X-CSE-ConnectionGUID: 9kUffgg9Scy/8SUvatPtOA==
X-CSE-MsgGUID: ebaT3CgCT0yxru2RWbcQpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248465617"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.111.222]) ([10.125.111.222])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 08:04:59 -0700
Message-ID: <4f4b0f29-424b-45ed-8cfd-c77da2ea390f@intel.com>
Date: Thu, 18 Jun 2026 08:04:58 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] x86/virt/tdx: Configure add-on features on TDX
 module init and update
To: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: djbw@kernel.org, kas@kernel.org, rick.p.edgecombe@intel.com,
 yilun.xu@intel.com, xiaoyao.li@intel.com, sohil.mehta@intel.com,
 adrian.hunter@intel.com, kishen.maloor@intel.com,
 tony.lindgren@linux.intel.com, peter.fang@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
 dave.hansen@linux.intel.com, seanjc@google.com
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-3-yilun.xu@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260618081355.3253581-3-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/26 01:13, Xu Yilun wrote:
>  int tdx_module_run_update(void)
>  {
> +	u64 seamcall_fn = TDH_SYS_UPDATE_V0;
>  	struct tdx_module_args args = {};
>  	int ret;
>  
> -	ret = seamcall_prerr(TDH_SYS_UPDATE, &args);
> +	if (tdx_addon_feature0) {
> +		args.r9 = tdx_addon_feature0;
> +		seamcall_fn = TDH_SYS_UPDATE;
> +	}

Heh, and it falls apart into craziness immediately. See how it
immediately loses the logical information that there's a version 1 and a
version 0? The "1" isn't even visible. It's hidden in "TDH_SYS_UPDATE".

Isn't this a million times more sane?

	struct tdx_module_args args = {};
	u64 version;
  	int ret;

	if (tdx_addon_feature0) {
		args.r9 = tdx_addon_feature0;
		version = 1;
	} else {
		version = 0;
	}

	ret = seamcall_prerr(TDH_SYS_UPDATE, version, &args);


There's also zero stopping us from putting version in args:

	struct tdx_module_args args = {};
  	int ret;

	if (tdx_addon_feature0) {
		args.r9 = tdx_addon_feature0;
		args.version = 1;
	}

	ret = seamcall_prerr(TDH_SYS_UPDATE, &args);

Eh?

That gives args.version==0 in all the normal cases which just happens to
be the exact behavior we want. It also avoids having to plumb version
through all the seamcall*() wrappers.

But this is *exactly* the kind of thing that shouldn't be a part of an
attestation patch series. This could very much have been a separate
discussion and happened a month or a year ago. But now it is blocking
this DICE thing from getting done <grumble>.
