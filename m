Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6213290A0;
	Thu,  7 May 2026 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140983; cv=none; b=ni/rWZorDNqCKkrU23z+ZJ/ntqXRZ8e7T8sub+8oih4PieFsg+fh1315bxqJZ2RjD1gmISPVBhsfr7uJvLbHwQ1v0COM5LctTLypQWu2xToOnvCFl1AtF7F675MID5aczQZrb8osNmVGd6tqaEpcZkZWeTy8/+pdFAaFZ2mRCWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140983; c=relaxed/simple;
	bh=5IpvuiXPv82AY0isNcVKYbXTDB8EPnSG+x5AEN7RJvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lucyNpbzWlys9/HT4cg5QTKBRbnNeUT5NYvwJJodoIa9vZv7Jyr7Ey5Ncwfo/m6VLVT1IpOVnewYRYgWkmArcBGTIzl15bqJUks4VlSgEuMsAgyOU4ss6msPx7Mgbow7JSS0W9FvQ/rZknID94DRLFvhKRyhQGQLH+M/bNR9GYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFqeIFZ0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFqeIFZ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778140983; x=1809676983;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5IpvuiXPv82AY0isNcVKYbXTDB8EPnSG+x5AEN7RJvU=;
  b=WFqeIFZ003uWMWMiKj5cTvIsJrh9iAR/OVwVSPe62xH0pvGTLLIPV8x8
   tFSOwNweZxaWgcpTRXNzZUD0ZHDZ5EYikLm4Yrr1wWSuDPTViMdG0hLk4
   6CQDexgHsWGcIXkOvnRjNdeiL3RccM1JYxCGIpAguQ1zCheU3bFCcU0Oy
   lHqpmLAMAtQ3ghGHK/e4Z3mr0F8Yq/rjFufv+V57/7ADZjPq5M8nT+qnJ
   CXu3TQhn4VXLOYsVFheFhl2RYhWmJSCk51u+eXMBohojlfRC5OUCies5l
   xfL6SfAdDNKh6Lb9ePAQGwM4m9OsE/04VwfYtiWly25zJAfr0JmC5Ltwp
   g==;
X-CSE-ConnectionGUID: g7obuHdZRQmrvC+t9pELBg==
X-CSE-MsgGUID: D+IjRpTySVSbWKJGrzzOgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="96514181"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="96514181"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 01:03:02 -0700
X-CSE-ConnectionGUID: w8KCcscrRYOBaAVDpfKQJw==
X-CSE-MsgGUID: qhZIDK6eREmG6CD3xTfttw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="236513285"
Received: from unknown (HELO [10.239.158.42]) ([10.239.158.42])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 01:02:57 -0700
Message-ID: <28c33c92-e411-416a-9c21-21bb9c01434d@intel.com>
Date: Thu, 7 May 2026 16:02:54 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] x86/tdx: Drop exported function
 tdx_quirk_reset_page()
To: Yan Zhao <yan.y.zhao@intel.com>, dave.hansen@linux.intel.com,
 pbonzini@redhat.com, seanjc@google.com
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, kas@kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, kai.huang@intel.com, rick.p.edgecombe@intel.com,
 yilun.xu@linux.intel.com, vannapurve@google.com, ackerleytng@google.com,
 sagis@google.com, binbin.wu@linux.intel.com, isaku.yamahata@intel.com
References: <20260430014852.24183-1-yan.y.zhao@intel.com>
 <20260430015001.24242-1-yan.y.zhao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260430015001.24242-1-yan.y.zhao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/2026 9:50 AM, Yan Zhao wrote:
> KVM invokes tdx_quirk_reset_page() to reset TDX control pages (including
> S-EPT pages, TDR page, etc.), as all those pages are allocated by KVM TDX
> and thus always have struct page.
> 
> However, it's also reasonable for KVM to reset those TDX control pages via
> tdx_quirk_reset_paddr() directly, eliminating the need to export two
> parallel APIs. Keeping tdx_quirk_reset_page() as a one-line helper in the
> header file is also unnecessary.
> 
> No functional change intended.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   arch/x86/include/asm/tdx.h  | 1 -
>   arch/x86/kvm/vmx/tdx.c      | 4 ++--
>   arch/x86/virt/vmx/tdx/tdx.c | 6 ------
>   3 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 65f7d874fb5a..9c63deaa0e8f 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -153,7 +153,6 @@ int tdx_guest_keyid_alloc(void);
>   u32 tdx_get_nr_guest_keyids(void);
>   void tdx_guest_keyid_free(unsigned int keyid);
>   
> -void tdx_quirk_reset_page(struct page *page);
>   void tdx_quirk_reset_paddr(unsigned long base, unsigned long size);
>   
>   struct tdx_td {
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index a2aadc6d0174..9bd4fd748e2a 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -343,7 +343,7 @@ static int tdx_reclaim_page(struct page *page)
>   
>   	r = __tdx_reclaim_page(page);
>   	if (!r)
> -		tdx_quirk_reset_page(page);
> +		tdx_quirk_reset_paddr(page_to_phys(page), PAGE_SIZE);
>   	return r;
>   }
>   
> @@ -597,7 +597,7 @@ static void tdx_reclaim_td_control_pages(struct kvm *kvm)
>   	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
>   		return;
>   
> -	tdx_quirk_reset_page(kvm_tdx->td.tdr_page);
> +	tdx_quirk_reset_paddr(page_to_phys(kvm_tdx->td.tdr_page), PAGE_SIZE);
>   
>   	__free_page(kvm_tdx->td.tdr_page);
>   	kvm_tdx->td.tdr_page = NULL;
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index e5a37ea2d4a0..deb67e68f85f 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -731,12 +731,6 @@ void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)
>   }
>   EXPORT_SYMBOL_FOR_KVM(tdx_quirk_reset_paddr);
>   
> -void tdx_quirk_reset_page(struct page *page)
> -{
> -	tdx_quirk_reset_paddr(page_to_phys(page), PAGE_SIZE);
> -}
> -EXPORT_SYMBOL_FOR_KVM(tdx_quirk_reset_page);
> -
>   static __init void tdmr_quirk_reset_pamt(struct tdmr_info *tdmr)
>   
>   {

