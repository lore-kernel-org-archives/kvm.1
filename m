Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5223393F;
	Wed, 20 May 2026 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268695; cv=none; b=nyCZAkbLU3dtpYceKw/qgbVdGzEN9ni+EvAt9LieYcelaDUwd2k7oAuEm3P9Prg/6RKU7/7BDrLaj93Nd4nXSO2PZLnvCkO56EMVQuWy7zHtyN0WiAjCnJsFo613gErbWaMPV7zG+5yVR05aNGmJH5yIvwY+u6g72nrEvqouQXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268695; c=relaxed/simple;
	bh=bHkIZwYQ4YehwcmiTQDqKFNVaSB9gZ+Ge9dQhvhj7WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QonIENfl1FqGfxKMdMl9phRuF8b5/QowBQEzyAr5iefGhsdG/fSWyRI/WMELdwbic15o4qH9WWbPz/NPOqrPFqfCCy41RQkNdLDp8VKXxTjuqpq+Q+y2AhMLRixlUz35vCTWsrHlaQulALB5kBDfNTc4aYEtVSQe+3DoZtQQJBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwFjMdG9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwFjMdG9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779268693; x=1810804693;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bHkIZwYQ4YehwcmiTQDqKFNVaSB9gZ+Ge9dQhvhj7WE=;
  b=EwFjMdG9x7eG+o17r2QRQt3j/3Ls8p3fVNlOEZEVZU8EOj7jVO8eAJol
   0Bgfl2zkxslwc2Oh/T5TMA/d8k0V+1IDJmeNQkqjGV4/YPZMYKoLKbBIk
   EZrAO9nNNCR1QN5yzLmfxuqN4V0+VC4cyGN3qQ7jjnAcDUvReoaoeM4sF
   uiXUBvZDCjQpKgbMueoZcXZ28G1v4Z5OBz/Sq7xflY4iKoRCYkcxTasgF
   E4RkVSxhodDGZTG3E2Tah99JxaoXvn2ETx6nN3xgA5eN+TRt6NrD4w812
   r+kL2Ex4Th9JhqrOToKr5tmzao5M1SPzbcIBuiMeVX/L61/sDmeYMLQiv
   g==;
X-CSE-ConnectionGUID: d4i/AOL5TaGgZYiPJPzB4g==
X-CSE-MsgGUID: ajMXzLR5S5md1I2YrGRAyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80012490"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80012490"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 02:18:12 -0700
X-CSE-ConnectionGUID: vDRIt/eMTRuPXWG3W3K6fQ==
X-CSE-MsgGUID: eho/zchdQXafYo1N5QZP1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="237105659"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 02:18:06 -0700
Message-ID: <804827af-f094-41e6-bba9-5f57d0e35cd0@linux.intel.com>
Date: Wed, 20 May 2026 17:18:03 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/23] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com, djbw@kernel.org,
 ira.weiny@intel.com, kai.huang@intel.com, kas@kernel.org,
 nik.borisov@suse.com, paulmck@kernel.org, pbonzini@redhat.com,
 reinette.chatre@intel.com, rick.p.edgecombe@intel.com, sagis@google.com,
 seanjc@google.com, tony.lindgren@linux.intel.com, vannapurve@google.com,
 vishal.l.verma@intel.com, yilun.xu@linux.intel.com, xiaoyao.li@intel.com,
 yan.y.zhao@intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-11-chao.gao@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260513151045.1420990-11-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/2026 11:09 PM, Chao Gao wrote:

> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
> index 7269a239bc22..7b345000d7c3 100644
> --- a/arch/x86/virt/vmx/tdx/seamldr.c
> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
> @@ -6,6 +6,7 @@
>   */
>  #define pr_fmt(fmt)	"seamldr: " fmt
>  
> +#include <linux/mm.h>

This is not needed in this patch.

>  #include <linux/spinlock.h>
>  
>  #include <asm/seamldr.h>
> @@ -41,3 +42,17 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
>  	return seamldr_call(P_SEAMLDR_INFO, &args);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
> +
> +/**
> + * seamldr_install_module - Install a new TDX module.
> + * @data: Pointer to the TDX module image.
> + * @size: Size of the TDX module image.
> + *
> + * Returns 0 on success, negative error code on failure.
> + */
> +int seamldr_install_module(const u8 *data, u32 size)
> +{
> +	/* TODO: Update TDX module here */
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(seamldr_install_module, "tdx-host");


