Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8B733B6EF
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 04:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791433730; cv=none; b=ITJAYwgwFAuHLjR7pYEVAIetvTgJN3fExJ6fzm3DCsEup9Pl/g9BlsxsGu8wjBro9tTOQ7jWuzgjX18vmn3YiUcf1mue/Qv2AQaNiojL/TO2w/bFbwhXveug2PIceyyXu+oFbt2/DuB3SCrsLOnQkMVEO/TBXy1WDPdCGlem3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791433730; c=relaxed/simple;
	bh=dlJc+uuvGM//S+vGmmT8jyuYliCC6PzCD4tpQ60JXe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSKFJUFS+Poe48rkLw7JZwdD4PoODNuQkTetQK7F5Fd0Fl5+iSTvHMMabhSh14BxP/5cEMXI/1Y/TIukESKd8bHIb5jVRlUktFkJKwAzcx8h4P9O7qnwns/8cy2p12DRbyUmIKaXAqJBca4q2NEqzTRBAy8YBLfZ+c9xIYKnktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ciK4ntFV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ciK4ntFV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791433729; x=1822969729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dlJc+uuvGM//S+vGmmT8jyuYliCC6PzCD4tpQ60JXe4=;
  b=ciK4ntFVtvlcAHjJ9ajlfKY4EeXXeqpVH8XptDNtPpFI4GTPnbArXaV4
   Lm/2tC3xZkonCJH3y1tE077PtkrQ48qMzJw1EHtjKtFzd3xb5hWjv7O7A
   QmISkfDB3Mt3CiB4VAp8OahmNu3I9UoOiIaNOZGQFcWl7OT2HAoecE27u
   MVcIM57wgxYZjfaBVlksEXhgeJWL/oQr3JqvyeEOwxBqNPFIEduzHW/BE
   6PnlNhJxn1SFl0K4leE+yWxTlZ78LBF/ITV0p75rDXexbQEigLM4hjseV
   qd8xqqjCbJaFPd5G9Ym2ZuPGq8aMnKUwF3d+bOk+GDQApQr8yf3JWl/Hr
   g==;
X-CSE-ConnectionGUID: c6McThv+RfKmC8SczSXjVQ==
X-CSE-MsgGUID: 7IvWaLdjSBycSVJU9GMBNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="215737"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="215737"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 21:28:49 -0700
X-CSE-ConnectionGUID: t/JXL2iPSpSMs4j+npqj7g==
X-CSE-MsgGUID: cYkmzAqETU28Vd3uQePigw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="248324"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa007.fm.intel.com with ESMTP; 07 Oct 2026 21:28:48 -0700
Date: Thu, 8 Oct 2026 12:25:38 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v3 4/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Message-ID: <ascbQieA2L/Q1Fx7@yilunxu-OptiPlex-7050>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-4-db52cb05b918@linux.intel.com>
 <20261005180031.98BC61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005180031.98BC61F000FF@smtp.kernel.org>

On Mon, Oct 05, 2026 at 06:00:31PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] x86/tdx: missing cache flush for extension memory before TDH_EXT_MEM_ADD
> --
> 
> commit 218ae840fc4855126ea1a0f203de6a4e414fa8d7
> Author: Xu Yilun <yilun.xu@linux.intel.com>
> 
> x86/virt/tdx: Make TDX module initialize the extensions
> 
> TDX module extensions need memory for their execution environment
> to serve SEAMCALL leafs. Several add-on features depend on the
> extensions to execute their SEAMCALL leafs.
> 
> After providing all required memory to the TDX module, initialize TDX
> module extensions via TDH.EXT.INIT, then those add-on features can use
> their SEAMCALL leafs normally.
> 
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index c445359335516..d8df3b2b1d17d 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > @@ -1348,12 +1348,35 @@ static __init int tdx_ext_mem_setup(void)
> [ ... ]
> >  static __init int init_tdx_module_extensions(void)
> >  {
> > +	int ret;
> > +
> >  	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> >  		return 0;
> >  
> > -	return tdx_ext_mem_setup();
> > +	ret = tdx_ext_mem_setup();
> 
> [Severity: High]
> Does tdx_ext_mem_setup() need to explicitly flush the extension memory cache
> lines?
> 
> During TDX module initialization, a global cache flush (wbinvd_on_all_cpus())
> is performed via config_global_keyid(). After this global flush,
> init_tdx_module_extensions() is called, allocating memory via
> alloc_contig_pages() in tdx_ext_mem_setup().
> 
> Because this memory is allocated after the wbinvd, it may contain dirty cache
> lines. The pages are then passed to tdx_ext_mem_add() without an explicit
> cache flush (such as tdx_clflush_page()):

There is no dirty cache issue. It is clarified in this series:

https://lore.kernel.org/all/20260922205215.870563-1-rick.p.edgecombe@intel.com/

> 
> arch/x86/virt/vmx/tdx/tdx.c:tdx_ext_mem_setup() {
>     ...
> 		for (i = 0; i < chunk_pages; i++)
> 			hpa_list->phys[i] = page_to_phys(chunk + i);
> 
> 		ret = tdx_ext_mem_add(hpa_list, chunk_pages);
>     ...
> }
> 
> Could missing cache flushes when transferring memory from the host (KeyID 0)
> to the TDX module (which uses the global private KeyID) cause MKTME KeyID
> aliasing MCEs? If dirty cache lines associated with KeyID 0 remain in the CPU
> caches and are later evicted, they could corrupt the TDX module's private
> memory.
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	return tdx_ext_init();
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com?part=4
