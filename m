Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1F837A83B;
	Thu,  3 Sep 2026 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417104; cv=none; b=hTJEVECVVIpPlRATN4bOvsyYRiSb0WZVh1ptshcFJJWe06o96aa8skrrLLbhrGWzexwo/NmaG6wdnCnfulMmMN2fijx18amXynpYhi0jQmUoKgL8Ep2zaEPReL7ipMGkB06P2QN02Sl7r8escEmaqiWXFwOTUfx/uhsAce+UB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417104; c=relaxed/simple;
	bh=YVucUw3YVfg82zo4PM4SYrWo1aven9VvV41QrSEm9Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw0q0PPyCZbSxdFHipN1Nv9m/Dfg0pUv08D2sPmAb6UcHbT5dSRg2MtCjCv2867ZnWkpZi44lppjViahP8OYERNUS1aPeCi8z6uYVIllqAUeUyAjeU9cmjeVBUSofAToxr/W5Pyv/bG0y4Z4knnj4DSyubN2ksQ2k9uVzDI3/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQ6uqq4i; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQ6uqq4i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788417103; x=1819953103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YVucUw3YVfg82zo4PM4SYrWo1aven9VvV41QrSEm9Jo=;
  b=JQ6uqq4iKNA3q33vTLitHXDQPjgTsySsb135wfpZwLtCcfdPz9xSX+Eh
   E311hTJ1qqTHyKf+xTj6XyCexQsEBQ8qB1izQ/FqxPK/9BTwAl35YjRUI
   UmWWYB4UDSHgX3GMgT4AXa7LofGWqA7sWAofQ1HIAPv/Oq85ryXxijvJj
   sr0X6eTZlwlsetjcyLBzVJv9ZFiuh+UCQgtIiTHCB2jI8JGJzz70hm0vJ
   Du6mZATKcsPD3eKYZ9Ip2c/qyqJAzWAxnnkoWGMylFs38hRyyRLWszQGB
   dJGMgCT4noR7yBiqjWnSqGAum3YA9wmd9R31SP+t4/8lrBPEfbyoacB0u
   A==;
X-CSE-ConnectionGUID: XNuZSCUfSgKicQlc6fzpSA==
X-CSE-MsgGUID: yAG2ZVqSQWiIXfXBrlSCIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="76441692"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="76441692"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:31:36 -0700
X-CSE-ConnectionGUID: WelPxJRuQUekczAxiS3jkQ==
X-CSE-MsgGUID: /1saqC4PQpivb9WDyq4Eaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="269632159"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.231])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:31:31 -0700
Date: Thu, 3 Sep 2026 09:31:28 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the
 Quote buffer size
Message-ID: <apkUQL5KJ7JQqtpY@tlindgre-MOBL1>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-4-peter.fang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729122939.1340412-4-peter.fang@intel.com>

On Wed, Jul 29, 2026 at 05:29:33AM -0700, Peter Fang wrote:
> In preparation for dynamic Quote buffer sizes, replace the fixed size
> constant with a variable.
> 
> The size is currently a constant sprinkled across several places. Store
> it in a variable and have all the users read it from there.
...
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -417,7 +416,8 @@ static int __init tdx_guest_init(void)
>  	if (ret)
>  		goto deinit_mr;
>  
> -	quote_data = alloc_quote_buf();
> +	quote_data_len = GET_QUOTE_BUF_SIZE;
> +	quote_data = alloc_quote_buf(quote_data_len);
>  	if (!quote_data) {
>  		pr_err("Failed to allocate Quote buffer\n");
>  		ret = -ENOMEM;

I assume the quote_data_len does not need to change after init because
of a TDX module update. So:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
