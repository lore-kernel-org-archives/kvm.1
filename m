Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE6D3E5A1F;
	Tue, 13 Oct 2026 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886599; cv=none; b=sEfBE1+Rv8Z3FOS1KYh5ba0NuxRnUaQWHXdXf257W3wbTANsw5sTcJc/lR6zUHMCTr/u4/f9QURNaUWf/zSWSAC8QP9s5DY3jW4WNfjzAONTGvRQnOfG0ZjDdRgTRQKWps8HsauRbKYom1gcPnbn8W84BLK0uGVGvcAlcStyj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886599; c=relaxed/simple;
	bh=ekZQ0q+xdtGkn4NuaxVpvPPHaMamSLGnT/jXWIganUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pueA5SmnvE7BWlhc1tVwT3WRDeOlrHl/v1jn/MDfqsExwW8yUzezeDiTLVl+IetR4S2VB6Q7AlRR1xY+4xay+ZJchrPuPVMCQWStUYZ4iKbLuZFQOv6VkUcqHMiwOQDUyREcKmzR2GHcZHXWxapSAmQTaAdZKqblLZ3t9lCYl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FL9Egaw1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FL9Egaw1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791886598; x=1823422598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ekZQ0q+xdtGkn4NuaxVpvPPHaMamSLGnT/jXWIganUg=;
  b=FL9Egaw13+Z9uEg6bJ7PdBkyEqZp0JzBU/UCZxw9R+JJZaJ4/nz33d59
   5YXGehwXJV3tUXdxKhsKQxOo12L3V/7R9uvGZDrgtHP/2RwUtjHKyuRy1
   Z3hKuKVK90QgB+1Nx0jXlAcZNzwWfcO1lzGpbEdgd2BvpcBGnZLFEoipd
   VL+OiGkM7iPZgCkjWlkQYvnqVRlH3ipWD/pU64j6GDEkrwBPiVQDilLdS
   ItxckH8bvwLgV5Y0e8ZKWik871PpQt0BQUvRCg+nmp+XkIBObuSKdSTw+
   +LMyRIPD1hY4BOxnMCfDg1oppMqpI5IM47MkEZRxzSFmXUoNdhubJV3fu
   Q==;
X-CSE-ConnectionGUID: h9DQOjP/Q56D78P2agP4VA==
X-CSE-MsgGUID: NSt/t21LRKeTE/8lu/4i+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="507549"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="507549"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:16:37 -0700
X-CSE-ConnectionGUID: J91pIag2Q5+QTWnZtNGMMw==
X-CSE-MsgGUID: ifDbk/LoRWGR7DQlwV4PeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1099593"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa001.jf.intel.com with ESMTP; 13 Oct 2026 03:16:33 -0700
Date: Tue, 13 Oct 2026 18:12:40 +0800
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
Subject: Re: [PATCH v3 5/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Message-ID: <as4EGEMR2fQqnPMA@yilunxu-OptiPlex-7050>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-5-db52cb05b918@linux.intel.com>
 <98326b43a055030bfa4671df5c00a78dfc16322a.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98326b43a055030bfa4671df5c00a78dfc16322a.camel@intel.com>

On Fri, Oct 09, 2026 at 07:20:05PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2026-10-06 at 01:41 +0800, Xu Yilun wrote:
> > Runtime TDX module update introduces a mechanism to update the module
> > firmware while preserving and restoring TDX operations. The extensions
> > functionalities should also be re-initialized as part of the restoration
> > process.
> > 
> > The TDX architecture supports an update flow which allows updated
> > extensions to consume more memory than their original boot-time
> > requirement. So the arch defines the extensions re-initialization flow
> > the same as boot-up initialization: the host queries TDX module how much
> > additional memory needed, allocates it, adds it to the module via
> > TDH.EXT.MEM.ADD, then re-initializes the extensions via TDH.EXT.INIT.
> > 
> > Linux runs the updates in stop_machine() context, which prevents memory
> > allocation. So for Linux, a compatible update must not install updated
> > extensions that require additional memory.
> > 
> > Given that the memory for the extensions must not increase, the
> > re-initialization skips the memory adding steps. It is simplified as:
> > 
> >   - Check if the extensions are supported via TDX_FEATURES0_EXT. If not,
> >     skip the extensions re-initialization.
> > 
> >   - Re-initialize the extensions via TDH.EXT.INIT. The SEAMCALL leaf
> >     will fail if the updated extensions require more memory, which
> >     indicates the update image is not compatible.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> 
> Reviewed-by: Rick Edgecombe <rick.p.edgecome@intel.com>
                                             ^
AI said you are edgecombe not edgecome. :)

I fixed them inplace.
