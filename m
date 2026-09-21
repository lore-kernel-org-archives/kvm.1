Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9769148D86B;
	Mon, 21 Sep 2026 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991015; cv=none; b=dauJKz9XswzjHj+HexVdaMWP5E/s+y5B4RufxYkFQTnUk4nBY50txUGb6XN17cVmuJDsY/oGzzJ2St3iBr5AkLoWkELW7S8EuVCSJ0nnz6R46H/xHQrIqNgYIJ22+xnjbnI8jrYjB4Ucyf8TOXg3EG0KLjk91OBq3tLHLZr6UlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991015; c=relaxed/simple;
	bh=/RT1+5/E52WlGRbRy8r6SoysexFm1DrziEDBiKHjW1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsXD4b4ftlWEGNJXu0Vh9GgDOSWEhBnSmTrjA84iebpdqpl6rkJz818DAUy78eElIAavRCxvIccyEfJIQikRXzc9baFKrXAE/X5yX9ZcewxmdcfMTyl85158/tJH3oiZ7qrNN5CShq5tV1+0iFFqdt7QHjmn4JhCMFUhgMl28pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EI1Aynum; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EI1Aynum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789991014; x=1821527014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/RT1+5/E52WlGRbRy8r6SoysexFm1DrziEDBiKHjW1o=;
  b=EI1Aynum2Sa9sRXDoiN+JHX/UeNL8VzD+yb/ik9IpmxY4rRPjAgoT4pn
   EFjb+dwcDW39CGmzlxia4MhGixV55r5VZi+tIl7nx9qV7eNhoAxv1VVtu
   NTzepe8dEO2EBfVDDPaFmOX0hZwtALA9zOj8jvd6EisejANQVGyu0OaY2
   Jt1ZR9qzV4VFiWkVAUE+an8u1DqQuJ0Fu8f3HU7Dg3L6coaL4YhpBgaXw
   ouavf2XDHcSAtFWYLjimYPvvD+sMupHaq+ulA5dWNP98zenXZ9Um0iEh0
   R0beLVWq0KfQo+YHxljPDD6yk9wFCwIB4baNVXir1qOjC+rJ1xz016BEI
   A==;
X-CSE-ConnectionGUID: 1yP+haCLT8K4E37CG7QbVg==
X-CSE-MsgGUID: iNrWWDxvQOy+7Qp3QNU+EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="107998157"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="107998157"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 04:43:33 -0700
X-CSE-ConnectionGUID: 3ITumidNRpmkDeKgPcw3lg==
X-CSE-MsgGUID: 68csLzsyQk+GWI625NrN8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="271774626"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2026 04:43:28 -0700
Date: Mon, 21 Sep 2026 19:42:40 +0800
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
Subject: Re: [PATCH v2 2/5] x86/virt/tdx: Configure add-on features on TDX
 module init
Message-ID: <arEYMCfdvmiqE4aR@yilunxu-OptiPlex-7050>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-3-yilun.xu@linux.intel.com>
 <2f6ac9afef52386fc491145222ea46e54c24a73f.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f6ac9afef52386fc491145222ea46e54c24a73f.camel@intel.com>

On Tue, Sep 15, 2026 at 08:54:01PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2026-09-15 at 18:26 +0800, Xu Yilun wrote:
> > @@ -1012,12 +1021,22 @@ struct tdmr_info_pa_array {
> >  static __init int tdx_sys_config(struct tdmr_info_pa_array *tdmr_pa_array,
> >  				 unsigned int nr_tdmr_pa, u64 global_keyid)
> >  {
> > +	u64 addon_features0 = get_tdx_addon_features0();
> >  	struct tdx_module_args args = {
> >  		.rcx = __pa(tdmr_pa_array),
> >  		.rdx = nr_tdmr_pa,
> >  		.r8 = global_keyid,
> >  	};
> 
> It seems inconsistent that global_keyid is passed in even though it is basically
> global state, while addon_features0 is retrieved from the global state. Passing
> the result of get_tdx_addon_features0() in from the caller doesn't make a ton of
> sense. And we already reference tdx_global_keyid globally from another seamcall
> wrapper. So I'd think dropping the arg when you create the wrapper would be best
> in the end.
> 
> The smallest change to stay consistent would be go add an addon_features0 arg to
> tdx_sys_config(), but it's hard to justify as good code. I'd maybe go with the
> global_keyid change and it probably is a separate patch, but we are brushing up
> against mixing cleanup and feature enabling... thoughts?

I'm not sure. My thought would be removing "u64 global_keyid" argument
for the new added tdx_sys_config(), to make this patch reasonable.

And the cleaning up of its caller - config_tdx_module() - could be in a
separate cleanup patch out of this series, make sense?

make W=1 doesn't complain, but maybe shashiko will.

> 
> 
> >  
> > +	/*
> > +	 * Use SEAMCALL version 1 that supports add-on features if any are
> > +	 * requested. Otherwise use version 0 for backward compatibility.
> > +	 */
> > +	if (addon_features0) {
> > +		args.r9 = addon_features0;
> > +		args.version = 1;
> > +	}
> > +
> >  	return seamcall_prerr(TDH_SYS_CONFIG, &args);
> >  }
> 
