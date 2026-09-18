Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688864D4893;
	Fri, 18 Sep 2026 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726017; cv=none; b=RlG6AcVcLILNa0F1d7n6zQQLNqoW0FK41Fvo4MqyJa2zSHzNMxxl1G3OJpnAn2crddi+yOFGrt58MMt7wREujExBw0iDgjzfK4VRt9SXtdiDUGc6ggxtiepKcg74JiOE0pqZEUz2R0vaPtN4QqTQGTKWCSKZQQSdYCCTrN3Erks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726017; c=relaxed/simple;
	bh=6WLjZbRvmVl2N7vLY5y93GfaimnjwySfhvh7VSdofr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7aI+5P1cSEiGzKk8yq2G6xXZAc/BG70A+PFz99XnFrYvRhfnD3up4rSoXI3xDPYtXMrUTrozKJXGTlMacHS3CnC1l3nUfgXCf+DB6FDd6Vt581KyzmA8+6pXqJrvVzuuHut6M2pV0ycD/kG7bcnk9C30Md237EBH0V7wKIUFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mylii047; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mylii047"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789726012; x=1821262012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6WLjZbRvmVl2N7vLY5y93GfaimnjwySfhvh7VSdofr4=;
  b=mylii047xx2WrvOt5/wmY3mnapE3riHv5IjD+bRpjoloPjrWpjr6qMFK
   /zVkmuT8PTFlysMdh/3kRhoDNpmI8p5X2mQL9y8zHZqF8zhOIxO3wEmmK
   4d2vGb2Ns2H9rql+839HTyht3MpA9NoX5kt8KVbQc9kLguhpqdbMll6Uk
   Kz/w5awCHm7gMsPndMIQmJCyNNDWfP4a1mSmd1MTa9UP9XN/kTEtlnLDO
   +Nd5c7R5oY0VVtrNsQ+lYU8COwKEtEtec0PUde0keSu1pXfaqht2TSUIZ
   W8bTmVKzufBl87t2yvHOTLMEqFsxp0W0jGF1+seiTahv0pPgazaym7MT0
   w==;
X-CSE-ConnectionGUID: EfoJMYtcQDaILDg8UEQzLA==
X-CSE-MsgGUID: oSkNTjDMSpOyMfzCsJdDtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100883807"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100883807"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 03:06:50 -0700
X-CSE-ConnectionGUID: cmSHFzgdSPqfvvvpE1kjuw==
X-CSE-MsgGUID: MFCrC+yGSf28levtRRmoAA==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa003.fm.intel.com with ESMTP; 18 Sep 2026 03:06:46 -0700
Date: Fri, 18 Sep 2026 18:06:23 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	artem.bityutskiy@linux.intel.com, kvm@vger.kernel.org,
	nik.borisov@suse.com
Subject: Re: [PATCH v2 4/5] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Message-ID: <aq0NH9jL/MIXpgIv@yilunxu-OptiPlex-7050>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-5-yilun.xu@linux.intel.com>
 <aqpIAxQ6C71bEqFm@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqpIAxQ6C71bEqFm@intel.com>

On Wed, Sep 16, 2026 at 03:40:51PM +0800, Chao Gao wrote:
> >+static __init int tdx_ext_mem_setup(void)
> >+{
> >+	unsigned int required_pages = tdx_sysinfo.ext.memory_pool_required_pages;
> >+	struct tdx_hpa_list *hpa_list;
> >+	unsigned int added_pages;
> >+	struct page *page;
> >+	int ret;
> >+
> >+	/*
> >+	 * TDX module uses the metadata memory_pool_required_pages to indicate
> >+	 * how much memory is still needed. This value decreases each time
> >+	 * memory is added via TDH.EXT.MEM.ADD.
> >+	 *
> >+	 * On first time initialization, a value of 0 before any memory is
> >+	 * added is unusual. But host makes no assumptions. Skip the memory
> >+	 * setup and let subsequent steps catch any actual errors.
> >+	 */
> 
> The fact that the value decreases on each TDH.EXT.MEM.ADD is not relevant
> here.
> 
> Also, calling 0 "unusual" does not help the reader. It is either a valid
> value the kernel needs to handle, or an invalid one the kernel can assert
> on.
> 
> How about:
> 	
> 	/*
> 	 * The TDX module may require no memory at all. Skip the memory
> 	 * setup in that case.
> 	 */

Since we will drop ext_required check, I've found a reason why no memory
is required.

	/*
	 * Skip the memory setup if no memory is required. This may happen when
	 * no add-on features requiring TDX module extensions are configured
	 * via TDH.SYS.CONFIG.
	 */

> 
> >+	if (!required_pages)
> >+		return 0;
