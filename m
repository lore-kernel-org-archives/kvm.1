Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D228725B;
	Wed, 27 May 2026 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779845414; cv=none; b=PAnSz4J+CpxJAAqfxVW+QcvYrc9rCWGaWkXHBZ8Hu/Df8wlPjQaQUAGoZ62p/ET7DFAoz6TCiy7LIgLntOt9iWmxBB3R0b5zIq6AyONV+PegNIqiHdun8icCuaTSkphL1TmwjIJ6Vchv4xyKV8PHsMhZcgS6ZLVF0XgbGj0FOO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779845414; c=relaxed/simple;
	bh=4iZvbEc4EoOfmM/OxcolYEr8wy9z3bo9hjGNMkVHeek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KS9u/UXKGG3PvloUiz4uZ8Qybop8KafK5bYBPPfDjIXRwpuB7VQPt+K4MgpDHtWPNQYWO5yMAKCUG+AfJDpINaue+7j3fh9r5SQEXbo2uynr3Z7NSyl71mDk9ya0/IEZXTmjjkQFEQbgmW0juiR4fVv5sdnCJZNTsQGW2bUuAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9bRfPYV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9bRfPYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779845412; x=1811381412;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4iZvbEc4EoOfmM/OxcolYEr8wy9z3bo9hjGNMkVHeek=;
  b=P9bRfPYVZbv/KzFQDeLFt5+S7huSbCDfjk7nnIKjW7AkFca2K/pTjI/Q
   H33zA7Uyagi88fS5YpfofYRgLif0Cu1xYWAcqXHVf51v9zA4K3avveBGk
   NGhCV7GmJivhEvBYqtChFIUbt1Vb8Xlk7GYtqR3gSJYDwN2RpJI7dlHor
   r0MWwec3sW6la9WAelz9lA5wSi6cwKPp3uCcCxXDKATSGO2DzVTqJ1cpl
   jM03dbxg24OMbJztEKn4CgLiRQ2w0BYHl6wWTY7optiCTEffNB3YrXWmo
   V+YOxAsuksqzpB4Ll25zK5pz3RhT+G3fONM0TQlHOQ6MuhR5Xm4YC/dRY
   Q==;
X-CSE-ConnectionGUID: leC0ug5yQsCKzYqXviKn0A==
X-CSE-MsgGUID: oQg20SO2Tba752X/9biucw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="91777071"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="91777071"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 18:30:12 -0700
X-CSE-ConnectionGUID: iAS1q6SvS8+hGELWUqYDxw==
X-CSE-MsgGUID: f5tNwDbWQASzWZx8l2IKvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="265959363"
Received: from unknown (HELO [10.239.158.45]) ([10.239.158.45])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 18:30:08 -0700
Message-ID: <9c1d9fd0-9991-4853-99bf-ae454893a94a@intel.com>
Date: Wed, 27 May 2026 09:30:06 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/15] x86/virt/tdx: Enable TDX Quoting extension
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>, kas@kernel.org,
 djbw@kernel.org, rick.p.edgecombe@intel.com, x86@kernel.org,
 peter.fang@intel.com, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sohil.mehta@intel.com,
 yilun.xu@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-16-yilun.xu@linux.intel.com>
 <ahPbb1Ws9hBruJ2d@tlindgre-MOBL1>
 <892508b2-6c61-4db2-a12f-902f62385e71@intel.com>
 <ahXAL41ZmIDHmgfu@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ahXAL41ZmIDHmgfu@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/2026 11:45 PM, Xu Yilun wrote:
> On Mon, May 25, 2026 at 06:51:27PM +0800, Xiaoyao Li wrote:
>> On 5/25/2026 1:17 PM, Tony Lindgren wrote:
>>> On Fri, May 22, 2026 at 11:41:28AM +0800, Xu Yilun wrote:
>>>> From: Peter Fang <peter.fang@intel.com>
>>>>
>>>> TDX Module updates global metadata when add-on features are enabled.
>>>> Host should update the cached tdx_sysinfo to reflect these changes.
>>>
>>> This should be made clearer IMO. How about mention that get_tdx_sys_info()
>>> needs to get called again to reload the TDX module global metadata?
>>
>> Ah ha! This patch answers my comment to patch 1:
>> https://lore.kernel.org/all/956fa1e6-2920-4b2e-8037-d4b9d812ae53@intel.com/
>>
>> sysinfo_ext->memory_pool_required_pages and sysinfo_ext->ext_required will
>> be updated after extensions are enabled by TDH.SYS.CONFIG.
>>
>> Patch 06 in this series already reads the tdx_sys_info_quote out of
>> get_tdx_sys_info(), which mean get_tdx_sys_info() doesn't ensure all the
>> global metadata will be update again.
>>
>> So how about move the read of memory_pool_required_pages and ext_required
>> out of get_tdx_sys_info() and put them after TDH.SYS.CONFIG, so that we
>> don't need call get_tdx_sys_info() again?
> 
> Yes, I'm good to it. I hesitated to move them out in case we need some
> central control on global data. But now I see there is already a
> precedent:
> 
> https://lore.kernel.org/kvm/20260520133909.409394-22-chao.gao@intel.com/
> 
> Once we've agreed on moving add-on data reading out of get_tdx_sys_info(),
> we don't have to read them after TDH.SYS.CONFIG, read them when really
> needed. How about the following, that makes the Extension part in this
> series self-contained.

Actually below is what I meant after TDH.SYS.CONFIG.

And I think we can re-order the patches of enabling TDX extensions by 
moving the patch 04 as the first one.

> ----8<----
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 86e5b7ad19b3..b729c1f5ab9e 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1536,6 +1536,10 @@ static __init int init_tdx_ext(void)
>          if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
>                  return 0;
> 
> +       ret = get_tdx_sys_info_ext(&tdx_sysinfo.ext);
> +       if (ret)
> +               return ret;
> +
>          /* No feature requires TDX Module Extensions. */
>          if (!tdx_sysinfo.ext.ext_required)
>                  return 0;
> diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> index f9cc2dd02caf..e7d9e0c4b604 100644
> --- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> +++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> @@ -140,8 +140,5 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>          ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
>          ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
> 
> -       if (sysinfo->features.tdx_features0 & TDX_FEATURES0_EXT)
> -               ret = ret ?: get_tdx_sys_info_ext(&sysinfo->ext);
> -
>          return ret;
>   }

