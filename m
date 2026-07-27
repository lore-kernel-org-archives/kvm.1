Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480673ABD9D
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140596; cv=none; b=FzudvblihQWeTlz8vBZtA6AqPQU/CyAAa6BHwPwT2fPC2KVVkd0AQVkzF3EFsMATCHla17PqaUP5/X93zCJTbQ1GMcOXoCbhzXRQ03TjnHKx3F6M1OtXooeObfyTUUYp/sG5oRT8GFekuM8Pzyuu17m6AN9FBU6ygHYgokgzteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140596; c=relaxed/simple;
	bh=nTAeuKeafdW0HJu/jJ8SEVDWxhTb6oLujYBvpoqBspk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QB4A+3OenRFLVFWr/TlQzX6TfiWbk2Mtku4QdSrQ2Gb2n+M6GNueMKnP7nM9OtpaJiSd9NoikbjLGzcnN4j7UlJWoDp250mYxRx0+Yk2hzDdwHL2yguOep1uRDJ5MpzcBu4YDxram1w4i8dYHyXkdKItwauAMIEmdaHxoS1c/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjDLIROc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjDLIROc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785140593; x=1816676593;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nTAeuKeafdW0HJu/jJ8SEVDWxhTb6oLujYBvpoqBspk=;
  b=NjDLIROcKf00s266Wv/BBYEMts02zCUoa+QKa3kN4G+hZhvxQa07VItG
   RfXTv3hfICvNuuzWlW+6tkGQbWCxJgDGQCkyWRX7/hpLv5ojN3zT573kS
   1jpYQRCp0B++NWzlS04CI+6S9D5/J3FjQsP5U+7PRbnGj/Fe8+JqNIBWt
   vaHu+ehGVGIXqAIdDa0PQMc5eQuc7ZN58g/equ+EJg+fjUvjUPNGjB6w2
   XdS48IQmZzd/lAuUlwoDIKNm9i22Gtl06+a1CIIVn+kD0zgJTuAakWh/Y
   4BJ35o0ptEMAskyFCktuNSYmWzmvS0eKPpOipRIrKnO96+npRZnxBqg3P
   Q==;
X-CSE-ConnectionGUID: DUXl5F2xRda4bULq9cLtcQ==
X-CSE-MsgGUID: gcdtdJI5TS6Hd+/CrV35jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85747079"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85747079"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:23:12 -0700
X-CSE-ConnectionGUID: hG6sP2n2Tyak6bGJMm0m8w==
X-CSE-MsgGUID: h5ccNoC1QYSdrVcbwevcyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="255031713"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.132]) ([10.238.208.132])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:23:06 -0700
Message-ID: <0d101660-8398-45f8-b732-8bfc37e4c257@intel.com>
Date: Mon, 27 Jul 2026 16:23:03 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] x86/virt/tdx: Make TDX module initialize the
 extensions
To: Xu Yilun <yilun.xu@linux.intel.com>, sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
 rick.p.edgecombe@intel.com, yilun.xu@intel.com, sohil.mehta@intel.com,
 adrian.hunter@intel.com, kishen.maloor@intel.com,
 tony.lindgren@linux.intel.com, peter.fang@intel.com, dave.hansen@intel.com,
 dave.hansen@linux.intel.com, chao.gao@intel.com
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-6-yilun.xu@linux.intel.com>
 <20260618085431.B83541F000E9@smtp.kernel.org>
 <ajq8RFjv2YFghvQp@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ajq8RFjv2YFghvQp@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/2026 1:03 AM, Xu Yilun wrote:
>>> +/* Initialize TDX module extensions for extension SEAMCALLs */
>>> +static __init int tdx_ext_init(void)
>>> +{
>>> +	struct tdx_module_args args = {};
>>> +	u64 r;
>>> +
>>> +	do {
>>> +		r = seamcall(TDH_EXT_INIT, &args);
>>> +	} while (r == TDX_INTERRUPTED_RESUMABLE);
>>> +
>>> +	if (r != TDX_SUCCESS)
>>> +		return -EFAULT;

As Chao caught in patch 04, we need to return -EIO here for consistence.

>>
>> [Severity: Medium]
>> Does this code silently discard the 64-bit hardware error code?
>>
>> When TDH_EXT_INIT fails, replacing the return value with -EFAULT means
>> the caller only logs a generic initialization failure without details.
>> Other TDX initialization functions use seamcall_prerr_ret() to preserve
>> and log the hardware error.
>>
>> Could this be updated to use seamcall_prerr_ret() to ensure the exact
>> firmware failure reason is logged?
> 
> No, it can't use seamcall_prerr_ret() directly. TDX_INTERRUPTED_RESUMABLE
> can't be handled in a unified way for all SEAMCALLs so can't embed in
> fundamental seamcall wrappers. I see 2 conventions:
> 
>    1. Host should set a resume=1 parameter on retry, such as,
>       TDH_PHYMEM_CACHE_WB, and several migration SEAMCALLs,
>       TDH.EXPORT.MEM, TDH.EXPORT.STATE.XXX
> 
>    2. Host just refills the previous args (may have been modified by seamcall
>       output) on retry. Much more examples, TDH_EXT_INIT, TDH_EXT_MEM_ADD,
>       TDH_QUOTE_INIT, TDH_QUOTE_GET...
> 
> So I think there is a need the callers have to:
> 
>    1. call seamcall() or seamcall wrappers (tdh_xxx)
>    2. specific handling of raw SEAMCALL return code
>    3. do a standard TDX error logging and Linux errno conversion.
> 
> seamcall_prerr_ret() does 1 & 2 & 3, but can't customize step 2.
> 
> I tried to add some TDX error logging & errno conversion helpers, most of
> the code are abstracted from seamcall_prerr_ret(), see below.
> 
> But I'm not sure if it worths the churn.

Though I have some comment, below refactor doesn't look so bad.

The only risk is existing SEAMCALL warppers is a mess and people may not 
want to add any more before re-work them. So the conservative option 
would to just add an ad-hoc pr_err() for !TDX_SUCCESS case?

> ----8<----
> 
> 
> diff --git a/arch/x86/virt/vmx/tdx/seamcall_internal.h b/arch/x86/virt/vmx/tdx/seamcall_internal.h
> index be5f446467df..f838715c9446 100644
> --- a/arch/x86/virt/vmx/tdx/seamcall_internal.h
> +++ b/arch/x86/virt/vmx/tdx/seamcall_internal.h
> @@ -78,12 +78,10 @@ static inline void seamcall_err_ret(u64 fn, u64 err,
>                          args->r9, args->r10, args->r11);
>   }
> 
> -static __always_inline int sc_retry_prerr(sc_func_t func,
> -                                         sc_err_func_t err_func,
> -                                         u64 fn, struct tdx_module_args *args)
> +static inline int sc_errno_prerr(sc_err_func_t err_func,
> +                                u64 fn, u64 sret,
> +                                struct tdx_module_args *args)
>   {
> -       u64 sret = sc_retry(func, fn, args);
> -
>          if (sret == TDX_SUCCESS)
>                  return 0;
> 
> @@ -100,10 +98,25 @@ static __always_inline int sc_retry_prerr(sc_func_t func,
>          return -EIO;
>   }
> 
> +static __always_inline int sc_retry_prerr(sc_func_t func,
> +                                         sc_err_func_t err_func,
> +                                         u64 fn, struct tdx_module_args *args)
> +{
> +       u64 sret = sc_retry(func, fn, args);
> +
> +       return sc_errno_prerr(err_func, fn, sret, args);
> +}
> +
>   #define seamcall_prerr(__fn, __args)                                           \
>          sc_retry_prerr(__seamcall, seamcall_err, (__fn), (__args))
> 
>   #define seamcall_prerr_ret(__fn, __args)                                       \
>          sc_retry_prerr(__seamcall_ret, seamcall_err_ret, (__fn), (__args))
> 
> +#define seamcall_errno_prerr(__fn, __sret, __args)                             \
> +       sc_errno_prerr(seamcall_err, (__fn), (__sret), (__args))
> +
> +#define seamcall_errno_prerr_ret(__fn, __sret, __args)                         \
> +       sc_errno_prerr(seamcall_err_ret, (__fn), (__sret), (__args))

We don't need these two wrappers.

The existing seamcall_prerr() and seamcall_prerr_ret() do two things:
1. call SEAMCALL;
2. handling the return code of SEAMCALL;

But the 2 new wrappers only do setp 2. So we can just call 
sc_errno_prerr() in the following cases ...

>   #endif /* _X86_VIRT_SEAMCALL_INTERNAL_H */
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 826504fbcdc7..637ff01ed0f1 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1403,10 +1403,7 @@ static int tdx_ext_init(void)
>                  r = seamcall(TDH_EXT_INIT, &args);
>          } while (r == TDX_INTERRUPTED_RESUMABLE);
> 
> -       if (r != TDX_SUCCESS)
> -               return -EFAULT;
> -
> -       return 0;
> +       return seamcall_errno_prerr(TDH_EXT_INIT, r, &args);

... return sc_errno_prerr(seamcall_err, TDH_EXT_INIT, r, &args);

and

>   }
> 
>   #define HPA_LIST_INFO_FIRST_ENTRY      GENMASK_U64(11, 3)
> @@ -1438,10 +1435,7 @@ static __init int tdx_ext_mem_add(struct page *hpa_list_page,
>                  r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
>          } while (r == TDX_INTERRUPTED_RESUMABLE);
> 
> -       if (r != TDX_SUCCESS)
> -               return -EFAULT;
> -
> -       return 0;
> +       return seamcall_errno_prerr_ret(TDH_EXT_MEM_ADD, r, &args);

... return sc_errno_prerr(seamcall_err_ret, TDH_EXT_MEM_ADD, r, &args);

>   }

