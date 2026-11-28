Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795859891;
	b=MKEXNyUCvkAEBv247KqMHo7L5E8dxcxZ3HEur6ZoAcM+Vhg/NlrMNjX22a3pTdiYVVx2
	 jyQTl0PI9YdgZzMojlblPA5xISmzAoWzhhuWICFZf4aQ5qIeh6a/y4gfCF2NjL9dzCtsD
	 J/ISs0tRgbQsolSNtQiKiknut5FhbImBgFOKXy1mVCMl1bM7icZk8by+qL4o34pZCel+f
	 rkCFTKxwG7DBENuY+hRn+BJ9qudjtePTU1klGTQgXcdOJigMKchwCqpB3NxMCdLKgUo+t
	 nCG3elY3N6boWl2dQ2sq4TvNbWArhXs9zxbV+Of/oAS8bJWp+NxSrOOOPVkenvD7d3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795859891;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xkqf+7x7yPJWp9LWVs41Meh3hUDnubnEWLvvXH1f0OM=;
	b=QaQUyxx7gec5B7zyatlIuYVQD/5Fcxhclttd8AYQsyby4TLj50olD2tSzs0hRqCUHD+V
	 VdOOI0gQbGXEjsWZNNAEvcLDbWQRWbmofO7m+KwyerURfvB9Eqen747xKflHl4A+oCzMm
	 2TlLgbi2mKW1Z7LrnRxJF0K7kYP/XeT4dXBVKOMFkPMALUjsTCjrcEePAjo+5E5HLNFGI
	 982Cf+1d00kCjsYuVX4K8ljVQMRCtuPZpIIfPrEPjqwr1fHYdvCscEh85EVtaR1AGwZ8V
	 8VjQDYkyrLuUkv7+I618rgscxBGa9Rr4xjlkuDlVEBNRTqF33c19m9MeH7MzD4mydiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QX+pDT2F;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08594606A326;
	Sat, 28 Nov 2026 09:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08594606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QX+pDT2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795859891; x=1827395891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mDFNMlF4soO+khi9YXxQn3h0Ih/euUVIAPICgfLuLHc=;
  b=QX+pDT2FGyhSRGh1W3pmlhFmLl3iXJ3nDJT+0aCNAXZ7WrxN7zGLY9pV
   xEU5sm5u3JEb+VKa/LSHaGxQ4epu8zQgpNY1gbm5N4PAyu6zRCqxzV4VS
   FmbnWY5gqerW3EUV1V/ltzRR59VvUfqLg7EX/gQikOjOY/SJ7qiQEBlX2
   yE8bwRI62vqrtJsedFvOb547sTsmGozW7OWp7xtScqI04y0Nqb/QNk81y
   ncaNJ16v2e/tlnkHCxv2jZWzYjBRmszzaftGU6PrnMV6WuX6ya7cKLTLc
   mHdkmvrJkANHfPvpzd6tp0f2dBXcFaqLJSjGzrcs0pDOp0HfsveLgEBg2
   g==;
X-CSE-ConnectionGUID: b4Qdi9tqSt+TJCGu2C3//w==
X-CSE-MsgGUID: 0mQ2ZOmHTMy9J/P6+jsypw==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4759773"
X-IronPort-AV: E=Sophos;i="6.27,238,1787036400"; 
   d="scan'208";a="4759773"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2026 01:58:10 -0800
X-CSE-ConnectionGUID: fLpdUTWaRgyZzB03ldX3pQ==
X-CSE-MsgGUID: KJ5g+UYZTxmbGOq8qHT3/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,238,1787036400"; 
   d="scan'208";a="12409550"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa004.jf.intel.com with ESMTP; 28 Nov 2026 01:58:08 -0800
Date: Sat, 28 Nov 2026 17:47:46 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com,
	kevin.tian@intel.com, yilun.xu@intel.com, chao.p.peng@intel.com,
	baolu.lu@linux.intel.com, Kiryl Shutsemau <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH 3/7] coco/tdx-host: Exchange SPDM messages through DOE
Message-ID: <awqjQt8n7dUJ3RJo@yilunxu-OptiPlex-7050>
References: <20261116111037.3478844-1-chao.gao@intel.com>
 <20261116111037.3478844-4-chao.gao@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116111037.3478844-4-chao.gao@intel.com>

>  static int tdx_spdm_msg_exchange(struct tdx_tsm_link *tlink)

I remember there is a comment in internal review that suggests we use
struct pci_dev *pdev for this function, to explicit this is purly about
PCI, nothing to do with TSM firmware. I accept it at that time and still
feel good today. How do you think?

>  {
> -	/* TODO: implement the PCI DOE transfer */
> +	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
> +	struct pci_doe_msg *req  = page_address(tlink->out_msg);
> +	struct pci_doe_msg *resp = page_address(tlink->in_msg);
> +
> +	size_t req_sz		= req->header.length * sizeof(u32);
> +	size_t resp_sz		= PAGE_SIZE;
> +
> +	size_t req_payload_sz	= req_sz  - sizeof(struct pci_doe_header);
> +	size_t resp_payload_sz	= resp_sz - sizeof(struct pci_doe_header);
> +
> +	void *resp_payload_addr	= resp->payload;
> +	void *req_payload_addr	= req->payload;
> +
> +	u8 type = req->header.type;
> +
> +	int ret;
> +
> +	ret = pci_tsm_doe_transfer(pdev, type,
> +				   req_payload_addr, req_payload_sz,
> +				   resp_payload_addr, resp_payload_sz);
> +	if (ret < 0) {
> +		pci_err(pdev, "spdm msg exchange fail %d\n", ret);
> +		return ret;
> +	}
> +
> +	resp->header.vendor = PCI_VENDOR_ID_PCI_SIG;
> +	resp->header.type = type;
> +	resp->header.length = (ret + sizeof(struct pci_doe_header)) / sizeof(u32);
> +
>  	return 0;
>  }
>  
> -- 
> 2.52.0
> 
> 
