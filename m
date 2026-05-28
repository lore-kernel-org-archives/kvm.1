Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D92B305693;
	Thu, 28 May 2026 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779941555; cv=none; b=NLZiGaE3mj06kQRbWdp/UqGKCAdDx+R98FindDnvb7m01SBdXjTBF4Y1wlze4W7/d2MAqpaZbncqLfnoMkVDob0/WVzd9yvizPhGXoLW10dgEWItUbKj5oLo3V6M96KQjy84CEJ1Rrvp2/j8K7CerTwlYKkwhFU+iASVD0mt/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779941555; c=relaxed/simple;
	bh=RqKg/e0A+ggtxQo/hFRYRuWamvv3CxGtxiW5IYeJr+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV5rBrFJj2yp5YCCvugviqNRgU/pdlL5yfEOgAMnHo6RTyXIY3dusEDROPspPbfcYfhVARm8bmNQNZIbB7MYWn3z9r2qT4Aw2dNsF6wVjG9w4P0k5IsjIqXT2jXxik4UDYM4MVUzFv42O02P9EGMIPMVXKhEfTlK7HuwS89akuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEqYhLBf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEqYhLBf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779941555; x=1811477555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RqKg/e0A+ggtxQo/hFRYRuWamvv3CxGtxiW5IYeJr+A=;
  b=ZEqYhLBfoxFlXfNbxAoWYXDgVRL9IOsX2oUv4eGQhOdqkF4nUILlW9T/
   V4ZtEYaOSP0jf2Cy5S+LGPNGYr24A9sgfMdh5NzkCpAec0pz6A1L8cPya
   X8/TePH3IlyGzeffRsJquAusC5WVTRmxMqqWXVpP6oZ/R3NYM9Cuk7i5m
   omMDQE1OHx49PrYzRH2tMx3dP1V1b9u97Pds81RBeQtnsEtg/NH8GVpJp
   bnCAyQikbf6sAWJYq0ss/uRqYQvkWO3XWjeAd1HnqB6kEysR8ZQLdLF/H
   czcp8cDKEyZifdu/8nJByntISR2ImiS9h+W91liMQMUxW/BdE603iGPy/
   g==;
X-CSE-ConnectionGUID: 6MhnTHaYST6C1KVHxIJ+iA==
X-CSE-MsgGUID: bvn12JazRMmm+i3DQR+VQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80634510"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80634510"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 21:12:34 -0700
X-CSE-ConnectionGUID: 3lKIU+2XTAGAuK7CPjCtMQ==
X-CSE-MsgGUID: /qV34K6WTGSHbIHkpu+kOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="246713473"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 27 May 2026 21:12:31 -0700
Date: Thu, 28 May 2026 11:48:33 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
Message-ID: <ahe7EQdb0C6gxGee@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
 <b25e03ad-0bf4-482f-86ec-eebc6ac03d95@intel.com>
 <ahaZPjf+A7ms0Ba9@yilunxu-OptiPlex-7050>
 <cdfa241c-2d8e-4aab-8491-1de4a54e8a59@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdfa241c-2d8e-4aab-8491-1de4a54e8a59@intel.com>

On Wed, May 27, 2026 at 10:17:36AM -0700, Sohil Mehta wrote:
> On 5/27/2026 12:11 AM, Xu Yilun wrote:
> 
> >>> +struct tdx_sys_info_ext {
> >>> +	u16 memory_pool_required_pages;
> >>> +	u8 ext_required;
> >>
> >> The name ext_required seems like a boolean. It is also used like a
> >> boolean later.
> >> 	if (!tdx_sysinfo.ext.ext_required)
> >> 		return 0;
> >>
> >> But, IIUC, is it actually a mask that lists any feature that needs
> > 
> > No it is just a bool about Extentions needs to be initialized or not.
> > 
> How does the kernel know which features need Extensions? Is there any
> hardware enumeration or the kernel just keeps a static list?

There is no HW enumeration, mm... seems this is an important reason that
we don't delay the Extensions enabling, kernel doesn't have to keep in
mind which features need Extensions.
