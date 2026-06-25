Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD071329E46;
	Thu, 25 Jun 2026 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384642; cv=none; b=HWSF4RxIH17XHFTAdblvDPxxUkXfOG2uV48CLoR44iIcGqmIFDhjdDG5uVrMdA+NESLGTQqEnSj+qEKTLekjHO0fstw1F6bFaYRwCX7AHZnTztwNdUmQq6+uOz8Pvk5vP/a3zE4PYtdcHabu97VqEJgCtLy43ZaqFfCzmzcQwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384642; c=relaxed/simple;
	bh=Q794jxvpN3RYVnGFiRc8AABrGLmQZmazq6J7iMfJkgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJS7TyyYqszwjdc/K26hJ+4TACz5iYtIoonLip9vGLVYQ8LSZq4j+oJ/bf9b1g1jHrG622hM0LFnmCmbA1WGMyb8C+haplO3POIXq85rjAc4XFGhMIq6KE+37EVINsSWRFfTJl+MqHvbDczPf/OXSAE5zAGcIugDeB3BcUZjveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jm/8q39l; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jm/8q39l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782384641; x=1813920641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q794jxvpN3RYVnGFiRc8AABrGLmQZmazq6J7iMfJkgw=;
  b=jm/8q39lxeDnrda+gcKMlUpUhAeh3l5etWYMXEKDxxxOTB3IdgU+NGm2
   IW/H+r7/TYdLJxnzEuh4ZG+K90IbWEJaVW8AKjnJmGtvP3aOPUz2GraFl
   +d1kNS5NHcpUlzLtJS0CIIalcrCmljo/XRU0+koMUZBnuKW2mSdppnaCU
   QV83jYK+ZDtmDjTu2sSCmlHwBLRdN5+tD6WSewP7M1xQtLjNopWn3LkNt
   ONrg9WKtRWnECH0ROg/At8OwqdtenQULgAE0e4xW/mcBIpxupRpGkJbIi
   CgJpydTQy8Ao5a2EQkQ95NFXhievIwqmOCDCfnUUqD2ocnp09wvsOPeXc
   Q==;
X-CSE-ConnectionGUID: xQzcgazPRpiUUVHF8DWxKg==
X-CSE-MsgGUID: ZAWPE/VKRO6kIbACmh3jsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94650222"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="94650222"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:50:41 -0700
X-CSE-ConnectionGUID: E3hHIgrJT7yHAx1Xaw7w1g==
X-CSE-MsgGUID: /dHp0zbqQ3ieesIJtsbyrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="255497412"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 25 Jun 2026 03:50:36 -0700
Date: Thu, 25 Jun 2026 18:50:35 +0800
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
Subject: Re: [PATCH v2 02/17] x86/virt/tdx: Configure add-on features on TDX
 module init and update
Message-ID: <aj0H+68svEME5x+h@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-3-yilun.xu@linux.intel.com>
 <ajpHRNaq+z5bdn+R@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajpHRNaq+z5bdn+R@intel.com>

> >For runtime update, Linux applies a policy that no newer features should
> >be added after update to avoid disrupting live TDX operations. To adhere
> >to this, TDH.SYS.UPDATE must configure the same features as the
> >TDH.SYS.CONFIG. Record the kernel required add-on feature bitmap in a
> >global var so that both phases can use it.
> 
> Actually, we do not need another global variable here. tdx_features0 is cached
> and is not updated across a runtime update, so the derived add-on feature
> bitmap will be the same before and after the update.

I think a global var "static u64 tdx_addon_feature0 *__ro_after_init*;"
better illustrates the policy that add-on feature bitmap should be decided at
boot up and never change later. It will also be used to decide if a specific
add-on feature initialization is needed. We don't want to calculate the bitmap
again and again, though the result must be the same.

Maybe I should strenghthen the commit message:

  ... both phases can use it. This actually mirrors a TDX module internal state
  so that kernel knows which add-on TDX operations (for example, quoting
  SEAMCALLs, which will be added in later patches) are valid.

> 
> 
> > static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
> > 				    u64 global_keyid)
> > {
> >+	u64 seamcall_fn = TDH_SYS_CONFIG_V0;
> > 	struct tdx_module_args args = {};
> > 	u64 *tdmr_pa_array;
> > 	size_t array_sz;
> >@@ -1032,7 +1042,15 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
> > 	args.rcx = __pa(tdmr_pa_array);
> > 	args.rdx = tdmr_list->nr_consumed_tdmrs;
> > 	args.r8 = global_keyid;
> >-	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
> >+
> >+	set_tdx_addon_features();
> >+
> >+	if (tdx_addon_feature0) {
> >+		args.r9 = tdx_addon_feature0;
> 
> How about moving this r9 assignment out of the if block and placing it next to
> 'args.r8 = global_keyid;'? There is no need to guard it, because args.r9 will
> be 0 when no add-on features are enabled, which is perfectly fine.

I tend to keep r9 assignment in the block, it clearly shows which
SEAMCALL version needs what parameters, help people map the code to TDX
module spec.

> 
> >+		seamcall_fn = TDH_SYS_CONFIG;
> >+	}
> >+
> >+	ret = seamcall_prerr(seamcall_fn, &args);
