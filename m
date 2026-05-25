Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A93D3324;
	Mon, 25 May 2026 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699633; cv=none; b=rDpFRwVQgJF8LnqvxZ+Arbc2WHriGdwbQzD6/xol2Vc5DGoE6fJqNDTjk58deAMygJe7uBCn18aDbUfvGtyp89IbOa8iXImppGFjbj1NEMR/ecz/yLViw3/q8EfUhg7UW2eC9ZNpUTSRv1Si3F2NaDDzFIpQwOXX2LbTfkp1KG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699633; c=relaxed/simple;
	bh=II01BgHPbuxfYfWHvbxbqtpAwhuUtdh2oATpI0odFyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIGvJ+tDSwvSlYgq/2u4r3/37s5SlXfuD8EoERZD/JGlbOiYp4mLvnXNtXuNI3CobgqRuoMqRGgJVBp5NCNQHqPiCYPeKdddTJsoD79nn5ANRbJrODlFNCLiVU/H44amshyuzKhtEJDQtYsWFjOG9beqT/UFhFKvrcKwGUtMGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OT7RcNrO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OT7RcNrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779699632; x=1811235632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=II01BgHPbuxfYfWHvbxbqtpAwhuUtdh2oATpI0odFyU=;
  b=OT7RcNrOvNM0K9jetQJPukAN4YEFVLNLwDgGtdGKr+ZHnwTFGIY0bJvk
   LkWsMNYeWpVtRczz9PFzobvz0KGjC7VaUX2srgfZgQ4PMsp46bkaPJ+QP
   OCo+wrafM6WvyB2N05dNabSkouCDzP5AEclf3TlEy1idSspj4ZCxjtSDd
   pipElhMQ46dSfAdI6Y/SrebA6p9SIpHJkrLjEorozYQHdFfBLF1th1KPc
   O4m1GTM7ayBHnkH4xhS+y5BkUBDPpPrTAn3bS1M9BJBUqEbNKqHwdOkby
   BIbMMYxi1gBNDbklGd6gX8QiqW8t1g2E1FWqNPO6QQxMt+G97+mEMxsNN
   Q==;
X-CSE-ConnectionGUID: Nw2W/PyaRXKMVvgVSEmAwA==
X-CSE-MsgGUID: 6vvRBy+fTLm5a1bVpKgw7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="105982505"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="105982505"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 02:00:32 -0700
X-CSE-ConnectionGUID: WpZFYCQIRly07nziwXiAuw==
X-CSE-MsgGUID: qMqCx6s1QDmqfJ3ruOeCuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="265394358"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.239.158.44]) ([10.239.158.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 02:00:28 -0700
Message-ID: <90a4835f-bc11-4415-a7b6-84347f40861b@intel.com>
Date: Mon, 25 May 2026 17:00:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/15] x86/virt/tdx: Embed version info in SEAMCALL
 leaf function definitions
To: Xu Yilun <yilun.xu@linux.intel.com>, kas@kernel.org, djbw@kernel.org,
 rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-15-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260522034128.3144354-15-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2026 11:41 AM, Xu Yilun wrote:
> Embed version information in SEAMCALL leaf function definitions rather
> than let the caller open code them. For now, only TDH.VP.INIT is
> involved.
> 
> Don't bother the caller to choose the SEAMCALL version if unnecessary.
> New version SEAMCALLs are guaranteed to be backward compatible, so
> ideally kernel doesn't need to keep version history and only uses the
> latest version SEAMCALLs.
> 
> The concern is some old TDX Modules don't recognize new version
> SEAMCALLs. Multiple SEAMCALL versions co-exist when kernel should
> support these old Modules. As time goes by, the old Modules deprecate
> and old version SEAMCALL definitions should disappear.
> 
> The old TDX Modules that only support TDH.VP.INIT v0 are all deprecated,
> so only provide the latest (v1) definition.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>   arch/x86/virt/vmx/tdx/tdx.h | 23 ++++++++++++++---------
>   arch/x86/virt/vmx/tdx/tdx.c |  4 ++--
>   2 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index 01a7d7d8ada9..10aff23cd01f 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -2,6 +2,7 @@
>   #ifndef _X86_VIRT_TDX_H
>   #define _X86_VIRT_TDX_H
>   
> +#include <linux/bitfield.h>
>   #include <linux/bits.h>
>   
>   /*
> @@ -11,6 +12,18 @@
>    * architectural definitions come first.
>    */
>   
> +/*
> + * SEAMCALL leaf:
> + *
> + * Bit 15:0	Leaf number
> + * Bit 23:16	Version number
> + */
> +#define SEAMCALL_LEAF			GENMASK(15, 0)
> +#define SEAMCALL_VER			GENMASK(23, 16)
> +
> +#define SEAMCALL_LEAF_VER(l, v)		(FIELD_PREP(SEAMCALL_LEAF, l) | \
> +					 FIELD_PREP(SEAMCALL_VER, v))
> +
>   /*
>    * TDX module SEAMCALL leaf functions
>    */
> @@ -31,7 +44,7 @@
>   #define TDH_VP_CREATE			10
>   #define TDH_MNG_KEY_FREEID		20
>   #define TDH_MNG_INIT			21
> -#define TDH_VP_INIT			22
> +#define TDH_VP_INIT			SEAMCALL_LEAF_VER(22, 1)

how about

#define TDH_VP_INIT			22
#define TDH_VP_INIT_V1			SEAMCALL_LEAF_VER(TDH_VP_INIT, 1)

and use TDH_VP_INIT_V1 below?

>   #define TDH_PHYMEM_PAGE_RDMD		24
>   #define TDH_VP_RD			26
>   #define TDH_PHYMEM_PAGE_RECLAIM		28
> @@ -52,14 +65,6 @@
>   #define TDH_QUOTE_GET			98
>   #define TDH_QUOTE_INIT			100
>   
> -/*
> - * SEAMCALL leaf:
> - *
> - * Bit 15:0	Leaf number
> - * Bit 23:16	Version number
> - */
> -#define TDX_VERSION_SHIFT		16
> -
>   /* TDX page types */
>   #define	PT_NDA		0x0
>   #define	PT_RSVD		0x1
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 821f677e9a86..f7600f930c6e 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -2217,8 +2217,8 @@ u64 tdh_vp_init(struct tdx_vp *vp, u64 initial_rcx, u32 x2apicid)
>   		.r8 = x2apicid,
>   	};
>   
> -	/* apicid requires version == 1. */
> -	return seamcall(TDH_VP_INIT | (1ULL << TDX_VERSION_SHIFT), &args);
> +	/* apicid requires version == 1. See TDH_VP_INIT definition.*/
> +	return seamcall(TDH_VP_INIT, &args);
>   }
>   EXPORT_SYMBOL_FOR_KVM(tdh_vp_init);
>   

