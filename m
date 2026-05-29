Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C33CAA48;
	Fri, 29 May 2026 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070322; cv=none; b=qTKHEBopzr4Q+q8Jmmiyv63uufbIHqC++SzznpA2il2ZWbmT8+ESgG9/X8DBAxQMPwrsqsYusEa0P3KAZPw9MHZRoW6vNBZpqRApqSe2UbQj7aGID2xDi1473dVMIlT1ucw+JCp5klcge72Ig1DEeaxYZRqx43HGkiZ9g7wFLHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070322; c=relaxed/simple;
	bh=Tk9Lpuz2uhne5+YJfPfVHY7ka8W0+dMo5hoFSYEYW+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7BIGPxbpAzyKOjOb4MlbHom9fOfz1XcgyZrMCw9RihGC5KZ9Z0s61rFk2YyQm3MEJWwkwRE1g3K4emM0XxabsmObMwgluEv02ZmTa+v3oVDDnUBN4cWxWiwYV2CUFqjlsdpbTjjbC8KOaU7UpXWJE1A371p27/dsuNTQmKphSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARu+xOfG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARu+xOfG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780070321; x=1811606321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Tk9Lpuz2uhne5+YJfPfVHY7ka8W0+dMo5hoFSYEYW+o=;
  b=ARu+xOfG87dTtLJH78+rbl3+QAZxJDWYIxATsXJQmxA2dNwTRHeAWNcY
   etxfx1ITao0yaphFcdvdkpyJWUhGZkd1rvVEcIlM0XTYiLqduNe6kGHOM
   xE2e2frXze9e32H0X0HqsrPqTTaMkx/r+mx/Rn39Mio4wkoK6+5K3astK
   PLLnBnss3T5R1UkaxNDc2YvcfFSApMTCwFQdd51+fuJhL2CqqSqO6rRNT
   sNkl0c29SZj8w8Zhky7+DZV+fAXrNWg+oz3sgwaPDPd7b4wQMxTJZiPlz
   jC/C8WAucVeO8Hb+a6xrRVY07aBOEk2U+ZKVTpxxOty2EBuOIUjzNGUcZ
   w==;
X-CSE-ConnectionGUID: 3vbTQBUOSTaGGtuNzo36Yg==
X-CSE-MsgGUID: ptVQUMsLTtO+TNhs6qzPuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91608772"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="91608772"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 08:58:40 -0700
X-CSE-ConnectionGUID: D5wsZsSZTTCfjaemcZq4DA==
X-CSE-MsgGUID: 8QvILgz5TU+J90z5pMWwGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="281006180"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 29 May 2026 08:58:37 -0700
Date: Fri, 29 May 2026 23:34:35 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kas@kernel.org" <kas@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"djbw@kernel.org" <djbw@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"Fang, Peter" <peter.fang@intel.com>
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
Message-ID: <ahmyCyF3BOrRz8oJ@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
 <956fa1e6-2920-4b2e-8037-d4b9d812ae53@intel.com>
 <ahcDvwEES7vqLLvg@thinkstation>
 <ahfD1KMYnTrXJziq@yilunxu-OptiPlex-7050>
 <5b2df6c780a0245cfc2ab4beb84883aba384e9f3.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b2df6c780a0245cfc2ab4beb84883aba384e9f3.camel@intel.com>

> Yea It is going to get confusing as to which metadata is populated at which
> step. And if anything updates it.
> 
> I'm not sure we need to have all the metadata stored permanently. Some of the
> metadata is needed for KVM and someday TSM. But a lot of it is onetime internal
> use. There is some handiness in referring to a global var, but also those
> reference add confusion as to when it got populated.
> 
> We only use ext_required, max_quote_size and memory_pool_required_pages each
> once. So why not just read them to the stack and leave them out of struct
> tdx_sys_info? Making it so there is not confusion of when it was read. And also
> saving a global var that is never used again is a bit wrong.
> 
> How about for struct tdx_sys_info_ext read it to the stack in init_tdx_ext() and
> pass it into init_tdx_ext_features(). For max_quote_size read it where it is

I think you mean "pass it into tdx_ext_mem_setup(). Yes, good to me.

> already read, but not into the global struct.
