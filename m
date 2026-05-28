Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7772F547F;
	Thu, 28 May 2026 04:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779943799; cv=none; b=VKGK8bHiC6gcZ1hWKJvSi8AP5C3avq/JfgxH11Mpelvi/UGeRXhewdq16rUmwYbmPcw15X62HLTQkZ318CjMDsOf3fnQQL8m7aNjtqjwntu53MWAnTBkNvZ404B31/9zY76/KwkgvPSHczF2M37zhPEpAvmSmqJfll0ijDRwQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779943799; c=relaxed/simple;
	bh=jSR0QcfdqpffkBeKE+I9lQuyBGyEuNJVQtIZkrY5uaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixkgQRMITySs6WlwsLIf6cKTmpDN0uhRIzbVNDXWobOR/ua7blxUEq+NcX3+bGNNuGdr7p1oA+K0DMR8ix9vB6uK/0yv6/DGGgNS2pMCqWCkgQ+29wiR/cNwmrTxJRjX/BioG7oPNgkeTLf4u1DnRyyFxAbGXOb4iUGc/feZBzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cAijzi+u; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cAijzi+u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779943798; x=1811479798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jSR0QcfdqpffkBeKE+I9lQuyBGyEuNJVQtIZkrY5uaA=;
  b=cAijzi+uKwRsEHUcmmp24JTRHfSOzroPtb29j0BhD0HEy8By722ZjgtF
   R22bxZubA6UuOJttQNKqHONPpXW2Sk6Waw35i1dif6n3nASTdspcUy+eG
   JDynyHeMCIT7p7F7n5MfSXMs/RHHweQ9yuCAlrFsB2Uoo1NA/IN0obmfn
   Den31VGCRsmFpaColmCOFreUJBnAO7+r55cAQai/FPkDm2mQiJLeIO/+4
   Dczx3/s3re/RAp3ccbIKfZARz8W6vl+m/tkdoMUx9DnphsdwmVwrhVjcw
   dEndokSXFXlCXq9QQqfRcKBPiyiaoxGrCGAEWHA3hY44kHjlkPL/Ch8VM
   Q==;
X-CSE-ConnectionGUID: 3uNlJBw7S4mSvl4Ro8wk0g==
X-CSE-MsgGUID: XhCOiCKcTfObMnBDkwgAgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="92170182"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="92170182"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 21:49:58 -0700
X-CSE-ConnectionGUID: rUjBSPePQxeyGYhS5DCRJw==
X-CSE-MsgGUID: k7y22UbpSNSpqBzrN3IdxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="272776026"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 27 May 2026 21:49:54 -0700
Date: Thu, 28 May 2026 12:25:56 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, djbw@kernel.org,
	rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
Message-ID: <ahfD1KMYnTrXJziq@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
 <956fa1e6-2920-4b2e-8037-d4b9d812ae53@intel.com>
 <ahcDvwEES7vqLLvg@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahcDvwEES7vqLLvg@thinkstation>

On Wed, May 27, 2026 at 04:35:36PM +0100, Kiryl Shutsemau wrote:
> On Mon, May 25, 2026 at 02:54:40PM +0800, Xiaoyao Li wrote:
> > On 5/22/2026 11:41 AM, Xu Yilun wrote:
> > ...
> > > +static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
> > > +{
> > > +	int ret = 0;
> > > +	u64 val;
> > > +
> > > +	if (!ret && !(ret = read_sys_metadata_field(0x3100000100000000, &val)))
> > > +		sysinfo_ext->memory_pool_required_pages = val;
> > > +	if (!ret && !(ret = read_sys_metadata_field(0x3100000000000001, &val)))
> > > +		sysinfo_ext->ext_required = val;
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >   static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
> > >   {
> > >   	int ret = 0;
> > > @@ -116,5 +129,8 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
> > >   	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
> > >   	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
> > > +	if (sysinfo->features.tdx_features0 & TDX_FEATURES0_EXT)
> > > +		ret = ret ?: get_tdx_sys_info_ext(&sysinfo->ext);
> > 
> > Is it correct to read "memory_pool_required_pages" and "ext_required" so
> > early in get_tdx_sys_info()? get_tdx_sys_info() is called before
> > config_tdx_module() which calls TDH.SYS.CONFIG.
> > 
> > If I read the TDX module base spec correctly, the amount of memory for
> > extensions and EXT_REQUIRED field depends on the enabled features, which is
> > determined by TDH.SYS.CONFIG/TDH.SYS.UPDATE ?

Yes.

> 
> This is my read too. Looks like we need a separate step after
> config_tdx_module() to readout config-dependatant metadata.


The timing for when metadata becomes valid is now variable, e.g., the
TDX QUOTING metadata is only valid after TDH.QUOTE.INIT [1].

Based on recent discussion, I think we should introduce runtime metadata
reading interfaces for specific metadata sets as needed, rather than
another catch-all step right after config_tdx_module(). See [2] for the
proposed approach for Extensions metadata.

[1]: https://lore.kernel.org/all/20260522034128.3144354-7-yilun.xu@linux.intel.com/
[2]: https://lore.kernel.org/all/ahXAL41ZmIDHmgfu@yilunxu-OptiPlex-7050/

