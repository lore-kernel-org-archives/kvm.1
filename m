Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0CE368D77;
	Thu,  3 Sep 2026 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427031; cv=none; b=rTxPBKnf/appX4x0erAWP6SsjtNxIMNzqOJEnhu+kz9XweajuxdmHbFNLR1bCnX+Ib0S1VLS4xm9XQTa9hjV2jPJO9eBOXqVu8yd3HKf7eajx80gFSZeixqyOO6znrNSuQjaMWce04h9+VIhFN2aiA/I+FVWJVcSjNyIUlWlf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427031; c=relaxed/simple;
	bh=cPkBWl9CzFAkmw4xHDpff+Px7SG3JE3aclx4XkW1aKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uho7CllQTnrejOpkJAClkRMUePAVHKRSekrwNfsrPsqquNkzYlU+OAdIr1zvJJ1I556JXEmPpwh1f5QsDoqCMcy+IMYTkl4VbrzobOOPIsTiODdzOqTWDa0AGk8PwTcHYapOxvTB3pFnUeZOa6FnLcrn4OqvIszQdq7jU2LLuFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+hNqV6Z; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+hNqV6Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788427028; x=1819963028;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cPkBWl9CzFAkmw4xHDpff+Px7SG3JE3aclx4XkW1aKo=;
  b=U+hNqV6ZLSvZcvHYv2VwU+ld0uN9RNh7oxciSQu1UwylKOTOauiPudcA
   VYd7vpYXSrOn+kIAQUV0VG3CD1lLADybrWsLB0vpJLDHQGVy9lEMvijEj
   I+S9XA+RoC9YdVkG5h+UKLLZVNd2HiVi9ltJNi5kdoGPspKWFB9HeC2kQ
   oUDLNRREJCEgGYNVDKVVghbVbWM+mVVbogRXOyBf+7NjHEZGdNMQnI8cn
   Zy3vYGKVz5JtvLNjyosJ6PYiWI0DHqbkf/cewH9R2qNSP4EKlpTEYaVtl
   hNak1ofsXQGw0HHdk9IUhcUIySA/SJVtVmz1tjiy6GbTPcRWhDHm8p+86
   A==;
X-CSE-ConnectionGUID: HUrIVmJ+SnCuhdghaPiHow==
X-CSE-MsgGUID: S2yXbEvZQwmlbisc31YMOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="114448085"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="114448085"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 02:17:08 -0700
X-CSE-ConnectionGUID: 6Zd6i9fLQRGiHzw7r9v0gA==
X-CSE-MsgGUID: N99w6QUzTRCj2qs2U2WLjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="273179431"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 02:17:04 -0700
Message-ID: <75441677-635e-4a2b-8e11-f5e70a1433a5@linux.intel.com>
Date: Thu, 3 Sep 2026 17:17:02 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the Quote
 buffer size
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-4-peter.fang@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260729122939.1340412-4-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/2026 8:29 PM, Peter Fang wrote:
> In preparation for dynamic Quote buffer sizes, replace the fixed size
> constant with a variable.
> 
> The size is currently a constant sprinkled across several places. Store
> it in a variable and have all the users read it from there.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
> v3:
>  - Split out using a variable for the buffer size from the v2 "Allocate
>    Quote buffer dynamically" patch to refactor first. [Dave]
>  - Pass the buffer size into alloc_quote_buf() by value. [Dave]
>  - Drop the Reviewed-by tags from v2 (Kiryl, Binbin) as the patch was
>    reworked.
> ---
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index f47c5429d002..3d3f79ab45af 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -191,8 +191,9 @@ struct tdx_quote_buf {
>  	u8 data[];
>  };
>  
> -/* Quote data buffer */
> +/* Quote data buffer and length */
>  static void *quote_data;
> +static size_t quote_data_len;

Nit:
The existing code is using "quote_data", it's natural to follow the style.
I personally feel the var names are a bit ambiguous on whether it's the full
quote buffer or just the data part.
