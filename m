Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B000483825;
	Tue, 22 Sep 2026 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061933; cv=none; b=npXdnunMedxf0CJ1an9d4kN7KtoGp1cvrxxv+P+MKamjNmgNn79cEiD+NRv7pRi7qe7xpHQ1rRYLCIcEPlz3mT2HtJOTUR2HYK+QXKPglDVNzn9lU0O+Z2WJx+KKWpTXjyJ2JsF2S8J6wMGhLxePSVPY9z2ydg7cZwPdHdapzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061933; c=relaxed/simple;
	bh=UG7loDTg64b7JQSr7l1wq8rnVZOHWP29afOuFfFMHdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trM1t0aoCzKTmVIFAV5FCZrVv/5Ju0t/DDqy9MeXxh8U6k8NVVbuxjbiQjnMirpBzAsBE7LZi/uoHl3k4T1Z52UXeAhJYRu96FZrqQHArkzCFmVS4ahwnXp+BvqeUIqzZ6JyMfSeXLLtGZn59b44PfIjN3M1Hbx8cfUPcFZPRYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CR7ZzN2p; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CR7ZzN2p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790061931; x=1821597931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UG7loDTg64b7JQSr7l1wq8rnVZOHWP29afOuFfFMHdg=;
  b=CR7ZzN2pHLvktjvTH1gTrjRUz+7mw6HfKV6HUliNPNXbbU87qxfzwNy3
   zsumG0g5JQ9cS7yqJ4sLNqnLI8DIWlN9+NnM3iYjiwdKZRD2TrRv5+6sc
   p44D4m5AFpNc/tzfqzY5gow5Rn2Age8/d+jDfYMLIH/pDetvUad0aWyGp
   IziNK8IBq6/ZwMXToCxdvaw6lWlcS0zNvjdFTjH5iQn8BlZqPLNZCCor2
   BgI7FxokymF3XKDnFAuGyxpAV1QxmqEHJbf7ZNgD1mAIwFsyxJ5yuMazS
   KiH18CPEJUCU2kEtRmNwxkOP18W/4z1rOm4JjpjJnReefiQ1c1/+pbCMX
   A==;
X-CSE-ConnectionGUID: PClvcNnyQYuXoPQYPfU4sg==
X-CSE-MsgGUID: 5v8a6IzHSWu6F+ZBzHEEYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="116161033"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="116161033"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 00:25:31 -0700
X-CSE-ConnectionGUID: 8d8O22H/TPicF7gc4wlsJA==
X-CSE-MsgGUID: Zu4FL1V7SzOFNmDXO9jRuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="4324451"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 00:25:25 -0700
Date: Tue, 22 Sep 2026 10:25:19 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	peter.fang@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, chao.gao@intel.com,
	artem.bityutskiy@linux.intel.com, kvm@vger.kernel.org,
	nik.borisov@suse.com
Subject: Re: [PATCH v2 4/5] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Message-ID: <arItX5wOG1eQIuIB@tlindgre-MOBL1>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-5-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915102658.713079-5-yilun.xu@linux.intel.com>

On Tue, Sep 15, 2026 at 06:26:57PM +0800, Xu Yilun wrote:
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1181,6 +1181,136 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
>  	return 0;
>  }
>  
> +#define TDX_HPA_LIST_MAX_NR_PAGES	(PAGE_SIZE / sizeof(u64))
> +
> +/*
> + * This is the "HPA_LIST" data structure defined in the "Intel TDX Module ABI
> + * Specification".
> + *
> + * It is the in-memory ABI that the kernel uses to add memory to the TDX
> + * module.
> + */
> +struct tdx_hpa_list {
> +	u64 phys[TDX_HPA_LIST_MAX_NR_PAGES];
> +};

Here too you could simplify the comments similar to what I suggested for
patch 1/5.

Other than that:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
