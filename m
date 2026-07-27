Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F983FF8A4;
	Mon, 27 Jul 2026 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155936; cv=none; b=AfRTM+6f22pi4TsM40XcE06FwCYhFDT9ZxLx9VDfxlXVvMfjVc4Du8GhO6CnoSzaWiYab1X6BxaJWnRv/0KQ2rHHh0NAktwfFv1CgkroxLYdb49iFkZ6I8q18/x7tUvuYESegqXTNdGRdbitB9GBlaTGVI7n52hsX5C0emCBnvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155936; c=relaxed/simple;
	bh=uo+UuR9oaaB90JXN6bGEXiAvzWQ4YpLIMthZ8Yizd9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEDINi8OELWc6fdjtL2kfGtxlxV6iI5BQIRBOrqlzJjMSdXWUs1nvLdS0yNAajOG2Z4jjmnrc9Dgig9C8L7C9s1dAhb39xUS35Lul26jAcPhAQnthygcG8rDAlB+XfOlYOl43h7mKPArNoCFqa5rgXZETbAFV/2BSR9rXosdzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvdoJtjr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvdoJtjr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785155934; x=1816691934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uo+UuR9oaaB90JXN6bGEXiAvzWQ4YpLIMthZ8Yizd9s=;
  b=lvdoJtjrtKObCnom5RSJQKP+BPJUIAIfSQI/8Bg1vq3iQvH8f27iM8Mn
   W+opK3gfPLzIEcuHDTC/J+I7QAco4jcUqUDVTND03zdvwyrr09wClSR1P
   l3ethd3Xg9luPSfmJBPNKTbqBUuGS8EUwWnVLqrzxL3BoF9AmCF0Dc62F
   /iqJ+rQDQBcCFuB4kX5T2p4kguQAqAwdSBp57+ojbwYgk/SOsiAFyEdGy
   ErURGGqcfN2NpYrvVSiGdVw/YEiN+MVnXLNP87qL9WlSeZTThZxM+X72j
   pfivXff/As4nfASQLIXxfXF7eUccYSYZXZC6UhU7gB3XWbnZynwKTgHTU
   Q==;
X-CSE-ConnectionGUID: Ye9dVb+2S+GK1jbi8SNlXQ==
X-CSE-MsgGUID: ktZXpPRLRdetpSAuK7uvsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="111265965"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="111265965"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 05:38:53 -0700
X-CSE-ConnectionGUID: xy/PzWN/ROu15CayvUdxyA==
X-CSE-MsgGUID: gstEUFE0SFK00gJr5FwCYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="258838957"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 27 Jul 2026 05:38:50 -0700
Date: Mon, 27 Jul 2026 20:38:49 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	sohil.mehta@intel.com, adrian.hunter@intel.com,
	kishen.maloor@intel.com, tony.lindgren@linux.intel.com,
	peter.fang@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, seanjc@google.com
Subject: Re: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Message-ID: <amdRWaoKa0k324JM@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-4-yilun.xu@linux.intel.com>
 <cfeee0fe-c61d-447c-86bc-8d8244090879@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfeee0fe-c61d-447c-86bc-8d8244090879@intel.com>

On Fri, Jul 24, 2026 at 04:42:33PM +0800, Xiaoyao Li wrote:
> On 6/18/2026 4:13 PM, Xu Yilun wrote:
> > TDX module extensions support extension SEAMCALLs that are preemptible
> > and resumable, unlike normal SEAMCALLs that run to completion while
> > monopolizing the CPU.
> 
> This is not true. There are some normal (non-extension) SEAMCALLs also are
> preemptible and resumable. For example,
> 
> - TDH.PHYMEM.CACHE.WB
> - TDH.SYS.DISABLE
> - TDH.MEM.SEPT.ADD with version 1

No they are not preemptible and resumable. They just intentionally
yield and don't have a generic way to save/resume their context. You
can't rely on that to implement complex tasks in TDX module considering
the complexity. That's the main reason why TDX module extensions are
needed.

> 
> (There might be more. I didn't check all.)
> 
> > This allows for higher-level API constructions,
> > so better supports some add-on features that implement higher order
> > security protocols.
> 
> I think we don't need to explain this? Just that some add-on features
> require the functionalities of TDX module extensions is enough?

mm.. a big part of the series is to bring up the TDX module extensions,
and this is the first patch to start implementing TDX module extensions,
a comment [1] said we could explain the context a little bit in general.

[1]: https://lore.kernel.org/all/1783e7bd-3759-41f7-93e3-2f9e21264bd4@intel.com/

[...]

> > +static __init int init_tdx_module_extensions(void)
> > +{
> > +	struct tdx_sys_info_ext sysinfo_ext;
> > +	int ret;
> > +
> > +	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> > +		return 0;
> > +
> > +	ret = get_tdx_sys_info_ext(&sysinfo_ext);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Skip if no feature requires TDX module extensions. */
> > +	if (!sysinfo_ext.ext_required)
> > +		return 0;
> 
> There was the discussion around it in [1]. I agree with the point to make
> kernel code simple. But it requires change/clarification from TDX spec,

I got the answer from TDX module team, that there is no use case ext
memory is needed/the Extensions are enabled but TDH.EXT.INIT is not
required. IOW ext_required == false exactly means TDX module extensions
are not required and no extension SEAMCALLs should be invoked.

> right? So will TDX spec change?

No I didn't raise this nits to distract their main focus on blocking
changes. But yes I can raise a ticket for this.

> 
> If so, you would need to mention it somewhere.
> 
> [1] https://lore.kernel.org/all/9c00b87b7b69470ad1e7b1d2788414002b9a1c77.camel@intel.com/
