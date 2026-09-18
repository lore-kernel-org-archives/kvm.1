Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15F043E067;
	Fri, 18 Sep 2026 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725523; cv=none; b=V8CyDoyJO4ZV/KMIiic/MI97MqZs7QWjKrQ6XUO8e237yjB2eIFgif8jPBGZbA0LOOFxIiEUQhdMrkr2/Y/X4TaPlck6Ws7QzR3ks3NNtfscH3PXXjtY80h2rA8UF8KjrQkTAHUmN54SE/WJgCow3/dcWER318bmdpg5OKToWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725523; c=relaxed/simple;
	bh=9g67EQ9OuHY/G45gQSz7wbLlQ5TmF52uuKGJ5KtFVgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHqCogRpnuJF5yZNuV4DAEpKLjEIfTfxJ2M6Yoc3muGSwATr6Niw4rBQCGKoRv44w7X/xzzBy8FmlPv4uf2RKu0kW7jiFvAAHGo+nL4QGS269gagSCFu5sQpnkyxoy8Dr3azhj4dDzy1BvTtqJSp7P4GQpN/owZS1rfTXkSfi7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byG/jqvw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byG/jqvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789725522; x=1821261522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9g67EQ9OuHY/G45gQSz7wbLlQ5TmF52uuKGJ5KtFVgk=;
  b=byG/jqvwRvdl2ZXi+DQ004zrB618NZdtkkXs2vk62K/K2f3ne4F0nDMg
   pTvOnJL6XqYH38jR/+65SXSmwO5GaJOIVr9STNp1N79q+ziseA3bHf6/t
   MfsglnFjhjFKIY3zOAwTlIOHwtClUe1lrbl2tATFGic/GEt4vCY522r0a
   xw9a8yW7G14D+hKAGzsO6eJK3h4gRGHxU1rej5CZqro2XZmyRkbUkWQk0
   3g8VVh4AjegeL2uRtCp37jN2BXinln+Q6hUIQ9tTB8JeZMUBkkcxLQv4u
   W1HXVM/IM+Ap3LVsjTAq1Dswlur3oDyryy0x7f+6Qf9hFm0Uet2sadOJg
   w==;
X-CSE-ConnectionGUID: 5Iw/rcBeRQqY6Rp0Z79J6w==
X-CSE-MsgGUID: sR1sPobLR1yHhZTcim1NTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77784065"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77784065"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:58:41 -0700
X-CSE-ConnectionGUID: 3tnGNR3XSXSvKOqxjeHKcg==
X-CSE-MsgGUID: 5ObHnEfkSYadJJnDYqRKzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270642062"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 02:58:37 -0700
Date: Fri, 18 Sep 2026 17:58:14 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Detect if the extensions
 initialization is required
Message-ID: <aq0LNmCd296NjKI3@yilunxu-OptiPlex-7050>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-4-yilun.xu@linux.intel.com>
 <8c7a630c25f04dcf5b19e29d3b271c611bf90378.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c7a630c25f04dcf5b19e29d3b271c611bf90378.camel@intel.com>

> > +static __init int init_tdx_module_extensions(void)
> > +{
> > +	int ret;
> > +
> > +	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> > +		return 0;
> > +
> > +	ret = get_tdx_sys_info_ext(&tdx_sysinfo.ext);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * ext_required indicates if any add-on features requiring TDX module
> > +	 * extensions are configured via TDH.SYS.CONFIG. If none, skip the
> > +	 * initialization.
> > +	 */
> > +	if (!tdx_sysinfo.ext.ext_required)
> > +		return 0;
> 
> Hmm, now that we don't need to do this on update, we don't need to save
> ext.ext_required metadata.

Good to me.

> 
> Also, per:
> https://lore.kernel.org/all/aox8DgpnSnhZRfCv@yilunxu-OptiPlex-7050/
> the reason we even need to check anything is because TDH_EXT_INIT returns a
> strange error code TDX_EXT_MEMORY_POOL_REQUIRED. In the case of a TDX module
> that supports extensions, but none that the kernel knows about... what if
> TDH_EXT_INIT returned SUCCESS meaning that all requested extensions (0 of them)
> are initialized.
> 
> AFAICT the specs don't describe what to do in this situation. But does describe
> SUCCESS as a possible error code. And TDX_EXT_MEMORY_POOL_REQUIRED is wrong. So
> its probably the most sensible bug fix anyway.

I raised to the module team, and they will fix it.

> 
> Then basically this patch goes away? We still check TDX_FEATURES0_EXT, but it
> can be squashed into the other one?

Good to me.
