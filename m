Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F4F31A7EA;
	Thu,  7 May 2026 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141232; cv=none; b=c1zxlzrVWa7/Jtxa0RahDIASWmq/tSkv1UHK1A13palaPKeBfLx/+hixVAiSjIVTcPJ0fkGq94iNFp0F77zf+kgYPhRumkzoDcFrdiiokS8EQtiAxJ/kYtSy9qYmw5mc541aCLCHVjPWgjjxn7cdsXvgUrP1ZjgLXqoFYqtovkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141232; c=relaxed/simple;
	bh=1ykmZnyKbg4QdVM/vqIsbsezVIsr372v8f4qVAoAG6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgcxB4gqnoJ35Y55QWEISUd6apYuab9+Y6B8VuK4Uu09qhDYKDxbWQ6Rl9ReDbs9ujo7xfNcWtN9hJ28KPNpxpvzK5zivsQkAnj6jB1Vlp7tRVx0W3EHkM3B9LY7Yy/ymPQkR4liVWs1kxMZO4TgoAVtAsYknB8QEhRAQeXAR6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nuUBOw8o; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nuUBOw8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778141231; x=1809677231;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1ykmZnyKbg4QdVM/vqIsbsezVIsr372v8f4qVAoAG6U=;
  b=nuUBOw8oTIolUNUdRwNO8ZveD8fEwqIxgMYeloEa7VcD7/pKp08Ka+yn
   dHEH3ALwzNnsTElhTtPkk5yKkSQvzfzDDO8V1aiBTojo29mOvUyooar70
   qwvQmNnozXefzbOsc5n91R9eNcleJehWTKaqwI3ou7macQ3QNHkEcMDz+
   b6GyliC/9/g/boESWvfyCqwtAznsvyGBDgkXnQFKJGJp7Q4Mlj1M0L/Dg
   +aW55snLvoDmcUTY6dO7yKSjXla/biTs4qAJgIGpeTxWhFdsTK4n9fEhM
   yvrDJgwlBLcxW//e+6TAxqHWWPhG7l8tJoONh3FCqqM2WAi7pse440E/T
   g==;
X-CSE-ConnectionGUID: xgqlP7hLTCKCyE1Chd4gdg==
X-CSE-MsgGUID: q1MIoUWkRBipXUZWvKJ91g==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="89393236"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="89393236"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 01:07:10 -0700
X-CSE-ConnectionGUID: Ap3NakbOQTmkaQ+bOiGiaQ==
X-CSE-MsgGUID: 1zM5aHn/QSC8xYAEZwAs5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="266774102"
Received: from unknown (HELO [10.239.158.42]) ([10.239.158.42])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 01:07:05 -0700
Message-ID: <3eadc407-181e-4cc5-a03a-78d3c0c39fcb@intel.com>
Date: Thu, 7 May 2026 16:07:01 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] x86/virt/tdx: Move mk_keyed_paddr() to tdx.c due
 to no external users
To: Yan Zhao <yan.y.zhao@intel.com>, dave.hansen@linux.intel.com,
 pbonzini@redhat.com, seanjc@google.com
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, kas@kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, kai.huang@intel.com, rick.p.edgecombe@intel.com,
 yilun.xu@linux.intel.com, vannapurve@google.com, ackerleytng@google.com,
 sagis@google.com, binbin.wu@linux.intel.com, isaku.yamahata@intel.com
References: <20260430014852.24183-1-yan.y.zhao@intel.com>
 <20260430015014.24261-1-yan.y.zhao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260430015014.24261-1-yan.y.zhao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/2026 9:50 AM, Yan Zhao wrote:
> Move mk_keyed_paddr() from tdx.h to tdx.c to avoid unnecessary header
> inclusion and improve encapsulation since there are no users outside of
> tdx.c.
> 
> No functional change intended.

Missing a new blank line.

> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   arch/x86/include/asm/tdx.h  | 6 ------
>   arch/x86/virt/vmx/tdx/tdx.c | 6 ++++++
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 9c63deaa0e8f..503f9a3f46d6 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -177,12 +177,6 @@ struct tdx_vp {
>   	struct page **tdcx_pages;
>   };
>   
> -static inline u64 mk_keyed_paddr(u16 hkid, kvm_pfn_t pfn)
> -{
> -	/* KeyID bits are just above the physical address bits. */
> -	return PFN_PHYS(pfn) | ((u64)hkid << boot_cpu_data.x86_phys_bits);
> -}
> -
>   u64 tdh_vp_enter(struct tdx_vp *vp, struct tdx_module_args *args);
>   u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page);
>   u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *source,
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index deb67e68f85f..967482ae3c80 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1911,6 +1911,12 @@ u64 tdh_phymem_cache_wb(bool resume)
>   }
>   EXPORT_SYMBOL_FOR_KVM(tdh_phymem_cache_wb);
>   
> +static inline u64 mk_keyed_paddr(u16 hkid, kvm_pfn_t pfn)
> +{
> +	/* KeyID bits are just above the physical address bits. */
> +	return PFN_PHYS(pfn) | ((u64)hkid << boot_cpu_data.x86_phys_bits);
> +}
> +
>   u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td)
>   {
>   	struct tdx_module_args args = {};

