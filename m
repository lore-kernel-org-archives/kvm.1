Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986893E6DE7;
	Tue, 30 Jun 2026 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815260; cv=none; b=Mvt+uJmFP3Yl0342jPg6TEtPSNBMseSK8QayIutOYn/nIbndlFAJQTMPSMuGRtTlTqP9wyOANu18ILR/2ToD78QmCTvesRzZhSijJh/HaeRgV4sUO1YSPPSOLXIfU0/Sw+5a4dLQ1ux+i7DzAdeN/am8S3YnUdmG/Y7/mTNmKzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815260; c=relaxed/simple;
	bh=QDDSYdMdGP2ovms0lOZuTN+BTzI0+lAeZzZ2Fc3jSCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIM2Yws1OepPlK7cTlYl926v/hCj8qPY/3Vzoq5LXD9EC+vd1El3sw9icmU7i2tKFPnl57tMul2jkBQHVXwHeTGUEqU67jajGj+Fyg2gbzGB+b50l8y7m7lA1PUd7wa1UfFWweWF14cncMKZP7MQvIDsA147LEnLwVaSqBGCfsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYd0OM4D; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYd0OM4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782815259; x=1814351259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QDDSYdMdGP2ovms0lOZuTN+BTzI0+lAeZzZ2Fc3jSCk=;
  b=VYd0OM4DlnEgnlOp+EAxupyP+0KdVMj8cj3TszJT8nDvYxsZ/4TZm94Y
   3hVaoqGBaKajI+/Nzax6pE9XqlsgRSGM0J7kECYO2IMyza3WWePfkMMJw
   0p0YZGqYHK/TS9Juv5B37ZPutups23ipofwEWq9Tz/pKBBuqdpmM1CBEY
   V86B9gPIa9HxsvZB0FSVaaTMWkvJEjNG0oUdRFFMJI7NuePVkp19lDMsR
   +4R8RNBN64Igdi6SF7D5pz2Aoe9b7k0VqfMIsbV7sRohEJlG0IuVixAqb
   wNcG2liLBMnvzwtmvY+rdfW1oi+PN1crhiSEGwZqHqyJhY069Q/okkks/
   g==;
X-CSE-ConnectionGUID: B3ijwY1KTUC4ju05ovmf5A==
X-CSE-MsgGUID: zp8qkTL2QoyGnBpCSfoxHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82637712"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="82637712"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 03:27:39 -0700
X-CSE-ConnectionGUID: 6rD+6zbNT+mwNuGbuCeZig==
X-CSE-MsgGUID: MvmNzZDKS8q25JIWWpKKDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="276506274"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 30 Jun 2026 03:27:34 -0700
Date: Tue, 30 Jun 2026 18:27:33 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	dave.hansen@intel.com, dave.hansen@linux.intel.com,
	seanjc@google.com
Subject: Re: [PATCH v2 04/17] x86/virt/tdx: Add extra memory to TDX module
 for the extensions
Message-ID: <akOaFdwnQjk6zHwi@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-5-yilun.xu@linux.intel.com>
 <akIlHqh0/Rna7aYY@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akIlHqh0/Rna7aYY@intel.com>

> >+static __init int tdx_ext_mem_setup(unsigned int required_pages)
> >+{
> >+	struct tdx_hpa_list *hpa_list;
> >+	struct page *page;
> >+	unsigned int i;
> >+	int ret;
> >+
> >+	/*
> >+	 * memory_pool_required_pages == 0 means no need to add pages,
> >+	 * skip the memory setup.
> >+	 */
> 
> There is no "memory_pool_required_pages" here.

OK.

BTW, sashiko says the comment restates what the if-statement. So I
change to:


	/*
	 * This required_pages comes from the metadata
	 * memory_pool_required_pages. TDX module uses it to indicate how much
	 * memory is still needed. This value decreases each time memory is
	 * added via TDH.EXT.MEM.ADD.
	 *
	 * On first time initialization, a value of 0 before any memory is
	 * added is unusual. But host makes no assumptions. Skip the memory
	 * setup and let subsequent steps catch any actual errors.
	 */

> 
> >+	if (!required_pages)
> >+		return 0;

Other comments are all good, included.
