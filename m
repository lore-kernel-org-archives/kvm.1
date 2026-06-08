Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185A0308F38;
	Mon,  8 Jun 2026 02:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780884726; cv=none; b=g/hyHnRCV/uXJM8eY1NnGuVOzI01gBLzTc1HJrPmfnUwLARaZS7OJN+1pLTwJJqb0Jw9tP/7oFq7YafFf0ACo4RXE4mLUO7PLytFvsN5E7rFhlpmC4BqmRHH0WQs6Vodx8RJGP+ZVTFxubxulnINfyHz8bUCONP3V6N2bTTegUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780884726; c=relaxed/simple;
	bh=YgjuCXZBdnyQCB48NR1QWbyj9Tv6nwGaCdrC3cGHDfs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=d35RfAr506oYzFNPoEO0M8uCvHsIIbsGZGcwbfBslyCaOPAHgXlxfSp/eM087IqJOKUo7P7PpxTUpNhHHnl/mNl7wbJT/d1hR06q36KphFwDwl1H1PP9FmYLaMPWB8Zbi0qNt8XwQARbRNSskcOlM5+nqAWgxaMWOA1WWPOlMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZeJbxQjn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZeJbxQjn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780884725; x=1812420725;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=YgjuCXZBdnyQCB48NR1QWbyj9Tv6nwGaCdrC3cGHDfs=;
  b=ZeJbxQjn2odwHVbogbNe1YHqlLzCr6tHnm9B3TfI2lbiCIcmZzNU3UL4
   RSWrhMYTzepPT2T010WmKeuop1E9kIx0ZCtxN7rWpDf41VRxTS05srjEK
   wecsVYru4LJLsunqOnyKW+XyVpPT0AF+wIDdi9HKZrLL1TilfukXBkAQ2
   MCHOu5gb4W5g7QjmqBCYsdtEySQotM3Gmg1iHHyacVrV32gJqUQS12nDk
   58FrDb9TAN/S+t8Dn+S3su1OldtRwY5CPr7emkg0k99MU9UaEsLRAycDr
   Nd9u92D7VTmmn5I4g9UKX5+omEWEQXobm99K7IcdSQWTuAyA69hcy9G0+
   Q==;
X-CSE-ConnectionGUID: Htwy/bvoRhGI3Pqkzv6w1A==
X-CSE-MsgGUID: CoA3DyNBT/+U4pSGm8XjAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="107055631"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="107055631"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 19:12:04 -0700
X-CSE-ConnectionGUID: XWql3BO6TiOyjGs+DduoGQ==
X-CSE-MsgGUID: eVxYfKnOTNS8Eudre30V4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="240961559"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 19:12:00 -0700
Message-ID: <50566572-6379-4100-8845-404f695e59cd@linux.intel.com>
Date: Mon, 8 Jun 2026 10:11:58 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v6 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com,
 pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org,
 vannapurve@google.com, x86@kernel.org, chao.gao@intel.com,
 yan.y.zhao@intel.com, kai.huang@intel.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-4-rick.p.edgecombe@intel.com>
Content-Language: en-US
In-Reply-To: <20260526023515.288829-4-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/2026 10:35 AM, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Add helpers to use when allocating or preparing pages that are handed to
> the TDX-Module for use as control/S-EPT pages, and thus need Dynamic PAMT
> adjustments.
> 
> The TDX module tracks some state for each page of physical memory that it
> might use. It calls this state the PAMT. It includes separate state for
> each page size a physical page could be utilized at within the TDX module
> (1GB, 2MB, 4KB). In Dynamic PAMT, only the 4KB page size state is
> allocated dynamically. So for pages that TDX will use as 2MB physically
> contiguous pages, Dynamic PAMT backing is not needed.
> 
> KVM will need to hand pages to the TDX module that it will use at 4KB
> granularity. So these pages will need Dynamic PAMT backing added before
> they are used by the TDX module, and removed afterwards.
> 
> Add tdx_alloc_control_page() and tdx_free_control_page() to handle both
> page allocation and Dynamic PAMT installation. Make them behave like
> normal alloc/free functions where allocation can fail in the case of no
> memory, but free (with any necessary Dynamic PAMT release) always
> succeeds. Do this so they can support the existing TDX flows that require
> teardowns to succeed.
> 
> Also create tdx_pamt_get/put() to handle installing Dynamic PAMT 4KB
> backing for pages that are already allocated (such as KVM's use of S-EPT
> page tables or guest private memory). Have them take a pfn instead of a
> struct page, as future changes will want to use these helpers for guest
> pages which are tracked by PFN.
> 
> Don't CLFLUSH the Dynamic PAMT pages handed to the TDX module, as is done
> for some other SEAMCALLs, as the TDX docs specify that this is only
> needed on "TD private memory or TD control structure page".
> 
> Since these allocations will be easily user triggerable, account the
> memory.
> 
> Leave logic to handle concurrency issues for future changes.
> 
> Assisted-by: GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7 Sashiko:claude-opus-4-6
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One comment below.


> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 82dc27aecf297..74e75db5728c7 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -37,6 +37,7 @@
>  
>  #include <uapi/asm/mce.h>
>  #include <asm/tdx_global_metadata.h>
> +#include <linux/mm.h>

I think the header is not needed here.

>  #include <linux/pgtable.h>
>  
>  /*
> @@ -160,6 +161,12 @@ void tdx_guest_keyid_free(unsigned int keyid);
>  
>  void tdx_quirk_reset_paddr(unsigned long base, unsigned long size);
>  
> +/* Number PAMT pages to be provided to TDX module per 2MB region of PA */
> +#define TDX_DPAMT_ENTRY_PAGE_CNT 2
> +
> +struct page *tdx_alloc_control_page(void);
> +void tdx_free_control_page(struct page *page);
> +
>  struct tdx_td {
>  	/* TD root structure: */
>  	struct page *tdr_page;
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 9ebd192cb5c17..9e0812d87ab06 100644[...]
