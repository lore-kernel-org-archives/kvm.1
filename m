Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A22D23EAAD;
	Mon,  8 Jun 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932905; cv=none; b=mUQaBd2OKbMFbikq8OKlqXaSN92eeERYmHnyixprbKcAqdiUg3EobGrM/n2tTSwegDdQy9yBE4qc3+j62WH2WkvzPWuxpelZO08Aey45PPfNxpQMYbyGFA7gQQrLVBgvxQo/KeuMc8r7MYcTphxfchHUTA3e+BEyoJqmcPh8u2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932905; c=relaxed/simple;
	bh=LJ0Jbj9a+0TVtKGhGTHRqvJzO02a9KgcfakJQpkU9hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeQwBdsfrMR/aBtUOJU2aF9WXZ8pV/V52CnzIO+qD8mIk/i7Qr9fBs0PwDwtOqDh9W7QWBMONtWVhLpGmHP9Dwxt2X5NQsp0JsNrMNtWRJ+AFlPjsvKgk+PUkCMJTZimeQfdMiPnfbwI3K93ai6juXo3oouWByZsoJ5XAeWWFV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enFq5ybm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enFq5ybm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780932904; x=1812468904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LJ0Jbj9a+0TVtKGhGTHRqvJzO02a9KgcfakJQpkU9hE=;
  b=enFq5ybm+OHxGEHQ7pR6IjsddAkWqfBwWaZw/pVwprpdIXMPRPluugZP
   vze67wk32nI8w0kHmJ0xCFwlZ0VufzGn/kN1+PTOEnu95K3yG02tG9ICo
   es1mEU67yJ2WYQpFseAKpLk7iOFLXlzJTMSUDS+QLktNaWyQAJSgcWRKe
   7wQmeDfRMTwvV1hsByAXLtjqj8NykPimVXNJ2DwzPzHcXd+e5XysaX2MP
   BeKL1ot8VzZrPdXojDhsD2yiftZzjwdYR7Bd+wE0oDTJ+3VOIcvKt37aj
   CRVpK1YfLB+T2yar6oJzOa1CXeWn9rL1dX3cDDRd9GkuKN83LaCgmGCyM
   A==;
X-CSE-ConnectionGUID: EFeRyK7MQHG0tm078LYYTA==
X-CSE-MsgGUID: YWk3oOKgSXKURiW48NGBgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81718060"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81718060"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:35:04 -0700
X-CSE-ConnectionGUID: M8BRURc8RV6QZU0W3pf59A==
X-CSE-MsgGUID: G7cmvkLZT92J6dBW5WN/Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="244465076"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 08 Jun 2026 08:35:01 -0700
Date: Mon, 8 Jun 2026 23:10:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [RFC PATCH 15/15] x86/virt/tdx: Enable TDX Quoting extension
Message-ID: <aibbZcey8e4APa5N@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-16-yilun.xu@linux.intel.com>
 <caf5de99-bce3-4dc6-8757-cf2b4aaf85c9@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caf5de99-bce3-4dc6-8757-cf2b4aaf85c9@intel.com>

> > diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> > index 10aff23cd01f..524a14c01aa6 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.h
> > +++ b/arch/x86/virt/vmx/tdx/tdx.h
> > @@ -58,7 +58,8 @@
> >   #define TDH_PHYMEM_CACHE_WB		40
> >   #define TDH_PHYMEM_PAGE_WBINVD		41
> >   #define TDH_VP_WR			43
> > -#define TDH_SYS_CONFIG			45
> > +#define TDH_SYS_CONFIG_V0		45
> 
> Is it necessary to add _Vx macros when multiple versions can co-exist?
> 
> Just wondering if it would be cleaner in the following way?
> 
> - Leave the macros set at the current (non-deprecated) baseline version.
> - Select vX using SEAMCALL_LEAF_VER() in config_tdx_module() when a vX feature
>   is enabled.

My perference is to have the most simple rule for the unversioned macro.
And leave all workarounds to _Vx macros, they will eventually been
removed or deprecated.

Anyway this patch is not expected to merge with this series, maybe we
will have a public release with V1 supported when it is to be merged,
then we don't have to make such a hard choice.

> 
> u64 seamcall_fn = TDH_SYS_CONFIG;
> ...
> if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_QUOTE) {
> ...
>     seamcall_fn = SEAMCALL_LEAF_VER(TDH_SYS_CONFIG, 1);
