Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31BA2DB7B8;
	Sat, 13 Jun 2026 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781367605; cv=none; b=TAhHJBc6gi6IqNnHEfpYKirHC3OPouLna7TnN7eYtBnpOKOHOH7uupuPywu7Ybu/FuLzNuOZiEjihG/gReKu4FAznPENbuoSywjrrL1V8EztSXE0730EzuhDCv7uhyOhNgbBZeXqoso351HTY/YFtBk2HUFaSil8XJlTuwbOt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781367605; c=relaxed/simple;
	bh=Pn0O9H+dHOsZNix6wexCA4umwU7at3UPvyRFwrUZkuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfRA4sSj5ScaJApe5rXfSw3Yark1Y3XP14DldxWA7h3NG/UF5KUqh82UZA/x8994QR7Uawkj90hhyDJWU8iBs2jyxBAUL5rUOKUVdX2P7yeX4CT7+4qRKDbDKHGIdTDhz02lquNE9QnKXOqxlYVz/WdshOU3PfMFmm0K6SXLofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+0iz8Ps; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+0iz8Ps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781367602; x=1812903602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pn0O9H+dHOsZNix6wexCA4umwU7at3UPvyRFwrUZkuE=;
  b=h+0iz8Pssli9gSf9xssRbphnomKwnKJhSS9pNEEM6tcFP5mnEZootS4A
   8OXybKrNYr9IbkMZP1vPr0j1rggtUQoUkrwJ98Dj95Zz3IAyeERTXli5w
   bJhvPzGfhKtbVag3bMgMjuea62iJeD4ey4KWIlOOqVBOoxgF7Ct26Ytsn
   brj+td/eJ5HIiJUU6ly359WX79Z7gmn9K2GdFOqxy0K4KMVzRQxzCgzXu
   k/Fob2PWuUg3xG6tEY2M2gn6oZBsI06Inzz8Gty+p/pZFPNrBMt/qJvcg
   +3yiCmsWJ6/XJzEuvAXGvHS89Gh8fYrZ2J3aYKAFbvHKMrOH+OaKSCoQO
   g==;
X-CSE-ConnectionGUID: ep/KdQx+QZ6zCtJYbo1tKw==
X-CSE-MsgGUID: Q+TLOPalRm6jpbHybHKUWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="84742635"
X-IronPort-AV: E=Sophos;i="6.24,202,1774335600"; 
   d="scan'208";a="84742635"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 09:20:02 -0700
X-CSE-ConnectionGUID: z6Fm7FP6S5upqf2g1/QC9A==
X-CSE-MsgGUID: 94ECnm0ZQZaPGdWGUJUmwg==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 13 Jun 2026 09:19:59 -0700
Date: Sat, 13 Jun 2026 23:55:12 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [RFC PATCH 14/15] x86/virt/tdx: Embed version info in SEAMCALL
 leaf function definitions
Message-ID: <ai19YA+sy32CVIBv@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-15-yilun.xu@linux.intel.com>
 <dd9027c7-ea84-4cee-9484-4e464a766b0d@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd9027c7-ea84-4cee-9484-4e464a766b0d@intel.com>

On Fri, Jun 12, 2026 at 08:47:26AM +0300, Adrian Hunter wrote:
> On 22/05/2026 06:41, Xu Yilun wrote:
> > Embed version information in SEAMCALL leaf function definitions rather
> > than let the caller open code them. For now, only TDH.VP.INIT is
> > involved.
> 
> > @@ -31,7 +44,7 @@
> >  #define TDH_VP_CREATE			10
> >  #define TDH_MNG_KEY_FREEID		20
> >  #define TDH_MNG_INIT			21
> > -#define TDH_VP_INIT			22
> > +#define TDH_VP_INIT			SEAMCALL_LEAF_VER(22, 1)
> 
> FWIW I find the macro a bit ugly, and hiding the version number in
> the leaf number macro a little counter-intuitive compared with setting
> it at the call site.  It anyway needs some explanation at the call site.

We actually discussed about this and realized we don't need to keep
version. This is because:

  1. Newer version SEAMCALLs are always compatible with older ones.
  2. System security requires us to stop using an older TDX module when
     there is a newer one. So don't try to support an older TDX module
     which doesn't understand newer version SEAMCALLs.

https://lore.kernel.org/all/ca331aa3-6304-4e07-9ed9-94dc69726382@intel.com/

> 
> > @@ -2217,8 +2217,8 @@ u64 tdh_vp_init(struct tdx_vp *vp, u64 initial_rcx, u32 x2apicid)
> >  		.r8 = x2apicid,
> >  	};
> >  
> > -	/* apicid requires version == 1. */
> > -	return seamcall(TDH_VP_INIT | (1ULL << TDX_VERSION_SHIFT), &args);
> > +	/* apicid requires version == 1. See TDH_VP_INIT definition.*/
> > +	return seamcall(TDH_VP_INIT, &args);
> 
> Now the reader has to go look at TDH_VP_INIT.

mm.. I think I should just delete the comment.
