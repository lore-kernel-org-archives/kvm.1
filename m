Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DA3EB0F7;
	Tue, 22 Sep 2026 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061247; cv=none; b=be/hg2DwFyNxogQKAiOfO3Z9XCrjw1xEwWIYbr9F5OHZJIhaJPU/Dknil05wBJj7bVTs99/cGFu/ibeOuQ/tC+it+YxyRVBdzT8EHBi7L3L3tKWUNyuki9f19cD5BjOT8QVD3vBMr2NS8UG/nyyRuCxmSVK64jhxsfthRGMMIGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061247; c=relaxed/simple;
	bh=tQvgjntbqI5y8oZjOXc1kY9IukzZun3Wrfm8zaqcS0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQnDfmaoBPfMooS6AfbcD6TN831GU9Rl/aJzepM1+gNh+iOR31HAyqMLxF3cI0+Zg9U1pFB0w1vSPYdtbJU2+CRvG+vKIIubl3axAxCGj7zh46JK5KpHYhAzpwGFbnh310KzZplozlsXMsu9apxLOPUVXuu1v8neulYSDALL4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHQha5Li; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHQha5Li"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790061246; x=1821597246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tQvgjntbqI5y8oZjOXc1kY9IukzZun3Wrfm8zaqcS0E=;
  b=iHQha5Li6UAlg8mGT6HkUVHuEhPvqQdjaX82AaCVi7VI20gCo1bOd++K
   HYNnU700BtdPmKCcH/7YthUCufoXOjmP1IUPrUZO2VAQ39RW9rPEuHfhd
   RkTPwhSSEf5MUH/rD/KxqxO+fZAzMKiqh6s0med8MXwJuB8HSSsEMocU2
   SEQQT8DZf5pkoWk5y9tfTNYKvzZ/cZy+SONogf11Yi24vaqpt8V16LkCz
   u+OJQlgLKZ4XeSE8qmGxQkT9oLprAbjem02Aa+Dzb0bWrX3Jf+JFMlcCq
   A2rBqxq6cTTmhCW63lS8VThTtHv23J7YPhcsKvIndxJpb1z7ycvMfw2qH
   w==;
X-CSE-ConnectionGUID: qdEPKPCpQ82o5wvcxBqa3w==
X-CSE-MsgGUID: YVaFd3CaSBO7wzaKvH0uWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1144077"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1144077"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 00:14:05 -0700
X-CSE-ConnectionGUID: pT9je1DmRFCGp4+fNfE97g==
X-CSE-MsgGUID: PSclx1Y/SraAv7EcSgQVKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="269538690"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.202])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 00:14:00 -0700
Date: Tue, 22 Sep 2026 10:13:56 +0300
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
Subject: Re: [PATCH v2 2/5] x86/virt/tdx: Configure add-on features on TDX
 module init
Message-ID: <arIqtGbSRHGw8fiT@tlindgre-MOBL1>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-3-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915102658.713079-3-yilun.xu@linux.intel.com>

On Tue, Sep 15, 2026 at 06:26:55PM +0800, Xu Yilun wrote:
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -998,6 +998,15 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
>  	return ret;
>  }
>  
> +/* List all kernel supported add-on features0 bits here */
> +#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0	(0)
> +
> +static __init u64 get_tdx_addon_features0(void)
> +{
> +	return tdx_sysinfo.features.tdx_features0 &
> +		TDX_KERNEL_SUPPORTED_ADDON_FEATURES0;
> +}

How about get_tdx_supported_addon_features() for the above? It makes the
calling code a bit more readable without having to figure out what it
returns.

Other than that:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
