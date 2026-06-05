Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24161495528;
	Fri,  5 Jun 2026 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649174; cv=none; b=rrwObZgkVh1hwVYuBB/VHh7MLSr8DriL5/na17BckThEwzNv7FeAbgM9MXG6Lduu7B9xBgR87BI2c2PDGicPQPsaYFYCKi1kVp3rkaUnR1kjaJBaYT6hhoFh9hZazsKqeVjGOvyTI/ia2qWptNGRGg9LfmE5JIx8audHSpN/S14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649174; c=relaxed/simple;
	bh=GgLkpEzPDkB/91Z3ZI4vRKzV310DmEc0OQbfRGZ+3tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqFTCDpNo8J0imgIaVSSRazFWmG5nuKVM8SJ1107SzuXrLVl8LPwScY0pxCzAc88uffg0pFpIv+4hUNfMUPq1MZn824GMpgfXG2SCClYLXdF00LhTY1dW+lfJk405SmEyUZROiOB4jeSAQ0Oc+aYwbn7lh5Tn92wvUMM/NeH7wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cn30YrLi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cn30YrLi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780649172; x=1812185172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GgLkpEzPDkB/91Z3ZI4vRKzV310DmEc0OQbfRGZ+3tU=;
  b=Cn30YrLiRhf3MAx5XguO0VqBx3+n6c4nXO8aAkEVsmVWpjqAnKvXDSYT
   WG8yCB6bSoJ5oPP/d5m7FAqtCnzIqsdIdK9tV4nWILyj5+GdwVbRbE2LB
   wDZob/qg9L+N5CD6f3Ui51mmHjBzl+m1Xqu9ISABTQC7C27elW6sCcZkS
   SlbpTfR/DicERUdIvGZix4OtIgBqK6uxYpJsjhURxmdZywog0UOb2VmMi
   Xjr/mrHMfCAVreJQ1/8Tn8ZnvUuBeMW6QoJe9H7Z6ULzM8KPnxDiRLLgI
   mLQlZa3zwFbPCNQIQoUXaaTGujOF8skGgeZ+hLoJp3REd+jwZuhEDsBol
   g==;
X-CSE-ConnectionGUID: 9rjN3lvdRAijVJF4vjUbFw==
X-CSE-MsgGUID: XDAjrUKoQOSFORH5p8uR2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85102222"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="85102222"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 01:46:12 -0700
X-CSE-ConnectionGUID: gdxfUM6uTMabroerXqkAcw==
X-CSE-MsgGUID: T9iCOeqzTJW435rgcVSNQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="243956144"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.221])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 01:46:07 -0700
Date: Fri, 5 Jun 2026 11:46:04 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 03/15] x86/virt/tdx: Make TDX Module initialize Extensions
Message-ID: <aiKMzB5TDGEutYN5@tlindgre-MOBL1>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-4-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522034128.3144354-4-yilun.xu@linux.intel.com>

On Fri, May 22, 2026 at 11:41:16AM +0800, Xu Yilun wrote:
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1200,6 +1200,22 @@ static u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
>  	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, nr_pages - 1);
>  }
>  
> +/* Initialize the TDX Module Extensions then Extension-SEAMCALLs can be used */
> +static int tdx_ext_init(void)
> +{
> +	struct tdx_module_args args = {};
> +	u64 r;
> +
> +	do {
> +		r = seamcall(TDH_EXT_INIT, &args);
> +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> +
> +	if (r != TDX_SUCCESS)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
>  {
>  	struct tdx_module_args args = {

How about "Initialize the TDX Module Extensions for Extension-SEAMCALLs"
above for the comment?

Other than that:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
