Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12CF3B2D0B;
	Sat, 10 Oct 2026 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651579; cv=none; b=ZCiXJ8mgiXBY4buewOydC3yQtsdGa8MsiexLmQrws3N1ZSWM1vafBfA1CGDc1xancpTgGyw0RWEBuF6BbF54pZLrO5HpfbXqFr0MCfpx3FLxPU3uX9WNkF4WQ9jA7ZDNN3bp2cNEMdGtvzIqurnKjm/MSWAQbNuSuHSRu7bJy7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651579; c=relaxed/simple;
	bh=Wc0a+mXNNhZfdKgzwWdQVOGoT9u4FAMY9yGFHnO9GQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibQwhMWiv1hezj4ryDOp2mTaeMpV6R+3Wu86VFzwbzfUcfUk2A1uvY5p2g7errBcUgp9LybYzH+q+GHSHHT936h6QXMJgAiaHemBAmLJX4SpEz4iJnkYrzyJbgY7O82YNBi/iGw76ybPnXIi/he0coFWMIR2cq8o1uDASZQOD1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGMt/kyG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGMt/kyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791651578; x=1823187578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wc0a+mXNNhZfdKgzwWdQVOGoT9u4FAMY9yGFHnO9GQs=;
  b=hGMt/kyGFCwdlzjwjcSsJ+9AZn1mF8ay2C/70nbtoLvegTH87NyOHImU
   6yeddUvzeFhl8RNffumEFiO2Cwt3lbzoTGsQt0FaTd7R3uHcsGsa147Zd
   Fb88cT/eVhyw5avdfhbbdONOJFw20uC86nnj495td8Bk2iKA2gaOH0vZy
   boFAmtGRE27K81OB5txoREa0eblYw2dpOPe4gSe3kY2BQAyysQGBcyBhe
   +GtQb2eaTWaAj5eZQrw1MLdhXBHhJv7Bw9PE08eDv/1Y1oVMKSeTxGFh8
   LFBR9Q/9B3iZsBcrh+6EI9CUWQ4HTIr7oeHSH15gAfT7VbFeYZIt0nGKr
   g==;
X-CSE-ConnectionGUID: v6ayu+l+S9WkusURVC1yYQ==
X-CSE-MsgGUID: 3mMDFO8oTPezLfGmciXTQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="301491"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="301491"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 09:59:37 -0700
X-CSE-ConnectionGUID: dLaGOM1gSHmrmFhoKsDQSQ==
X-CSE-MsgGUID: Qp+PzNnXRse/RNtTwuavQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="631713"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa004.fm.intel.com with ESMTP; 10 Oct 2026 09:59:32 -0700
Date: Sun, 11 Oct 2026 00:56:02 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>
Subject: Re: [PATCH v3 4/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Message-ID: <aspuIg3Oeaw1LWZ1@yilunxu-OptiPlex-7050>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-4-db52cb05b918@linux.intel.com>
 <1b142a6d4f4714796027876e765c0c27ae770eab.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b142a6d4f4714796027876e765c0c27ae770eab.camel@intel.com>

On Fri, Oct 09, 2026 at 07:03:08PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2026-10-06 at 01:41 +0800, Xu Yilun wrote:
> > TDX module extensions need memory for their execution environment
> > to serve SEAMCALL leafs. Several add-on features depend on the
> > extensions to execute their SEAMCALL leafs.
> 
> Can we get a little more about what this SEAMCALL is actually doing? To be able
> to reason about how long it will take. Obviously it does nothing now, but when
> we enable the fist extension.

Good to me. I re-wrote a new version:

    TDX module extensions use kernel-gifted memory for their execution
    environment to serve SEAMCALL leafs. Several add-on features depend on
    the extensions to execute their SEAMCALL leafs.

    After providing all required memory to the TDX module, initialize TDX
    module extensions via TDH.EXT.INIT. This is a time-consuming process,
    during which the TDX module loads its internal extension image into this
    memory and builds the execution environment. Once initialized, those
    add-on features can use their SEAMCALL leafs normally.
