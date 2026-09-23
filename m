Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43520363083
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137226; cv=none; b=IsNpPCw6Zs9960u9MLDv9jmUGS/1HyLphQb5m0Hhaw2DRMLuHtYa5tCc0dTy+vW1ja2dxVsipGxcfKREF05rC18eARht1kTljo5wARnBI+Yk/S/wwJN4A9U2gpbuzhSlvC/g/LfWtNVoEs2HbnLcXig3J2XmFBReeml0/creJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137226; c=relaxed/simple;
	bh=hM9FnilNgsJFxgnCumf3LJM15OZIZrKHUkXqf8citY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIS+BsZn12+ca4iBNPbgGFroCtX0MhsaP664A+3QFUZvtXgEe+hYhJBqpHvr/NhGYj6LNCTbM6jCeclDWT+7/Bhp3D1vUxyWYJ8gfwuHO//KcDvtb1blkUc/grekVCy9ToxNd5/xqDw0byvcEzi7V1pWKBPIyzYpJdABjZHC2Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUDprH0N; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUDprH0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790137224; x=1821673224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hM9FnilNgsJFxgnCumf3LJM15OZIZrKHUkXqf8citY8=;
  b=OUDprH0NsYUWaUJXUm9o2pB4Mpg9NEKoi6t4qJ6UgVgK8lYumE1c1FS7
   rmBL+eT9WhapX6oLqsGRgwxwmsyXALy4QkEz00BTvbjeO1on+eebE49OL
   tYOSFnhVHNuB1G2Dbh3mRVVmr5bz0UC0dxkGz9DlG77zF2qVcZdebHF8p
   uHVaWZBa6wXWi483zUWNcZnB2NOVvLMMuJBWD14GtjPFzti2mTgwlZeZ9
   /xvodSIjWnL4PsAWaHWtOAN4uWy+LK+w9FrG3C26dLGa+u/GJhU8Zivcq
   VXH19+W2UUGO9MXCpeWG8X3ziN+2yid9326z+V8aFVvFdDOlasaX4AG+H
   w==;
X-CSE-ConnectionGUID: +NHZ/tXoQCWdrQmGfmnGGQ==
X-CSE-MsgGUID: Ihkk2aXPQ9W5d1IOaxrxqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="116323479"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="116323479"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 21:20:23 -0700
X-CSE-ConnectionGUID: /JMKO42nRLGh+dgRK+yJig==
X-CSE-MsgGUID: Tq2JRI9eQiSnQsnIkmurEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="278183150"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.235])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 21:20:15 -0700
Date: Wed, 23 Sep 2026 07:20:07 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Message-ID: <arNTd7L2IrqSND-C@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f2889dd6e44333b2a5bbd4bd32a4557c3b50a3cc.camel@gmail.com>
 <arJNemNy_SK3mt_c@tlindgre-MOBL1>
 <d36468632f54e15c9107169af03b436f22e0a90f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d36468632f54e15c9107169af03b436f22e0a90f.camel@gmail.com>

On Tue, Sep 22, 2026 at 02:54:29PM +0300, Artem Bityutskiy wrote:
> On Tue, 2026-09-22 at 12:42 +0300, Tony Lindgren wrote:
> > 
> > > Anyway, if I can get the TDX module to allow dirty tracking independent of
> > > migration, we could pick either mechanism, or even implement both and add a
> > > TDX-specific ioctl to select which one to use. We could plug either method
> > > into the KVM_DIRTY_LOG ioctl - both would work, just differently.
> > 
> > Note that for TDX write-blocking is an older approach. The non-blocking
> > SEAMCALLs were added because of the issues noticed. Both features are not
> > usable the same time.
> 
> But let me clarify one point: write-blocking (the WP-based mechanism) isn't
> broken - it works fine. For fairness:
> 
> - MMU-intrusiveness - valid argument.
> - It is "older" - not on its own a strong argument. Older does not
>   automatically make it categorically worse.

Correct. And I'm of course a bit biased on the write-blocking migration
after tinkering with it some so please excuse me.

For reference, there are earlier WIP patches from 2023 for TDX using the
write-blocking at [0] and [1] below. While the write-blocking itself seems
fairly straight forward, it's interaction with live migration is complicated
to unblock pages.

You may want to add a VM exit and TDX module unblock for each 4K page to the
list for the TDX write-blocking migration.
 
> Side note: although I always try to remember that if there is a real need,
> we can work with the TDX module architects on the  ABI to reduce that
> intrusiveness. I do not see the need yet, though.
> 
> > If non-blocking is enabled for a TDX module write-blocking cannot be used.
> > Also note that the dirty log scan features depend on non-blocking features
> > being enabled.
> 
> To make it more pronounced: Tony says the blocking vs. non-blocking TDX
> export mode is:
> 
> - Global for all TDs, not a per-TD choice.
> - Decided at TDX module initialization time, and cannot be changed without
>   re-initializing or updating the module. So in practice, it's a kernel
>   init time decision.
> 
> So my suggestion that both could be implemented and selected via a uAPI is
> moot in practice.

Yup. If somebody really needs it, selecting write-blocking migration could
be a module param.

[0] https://github.com/intel-staging/tdx/commit/d6c63ebf463297a076984fe248aabeba0fa58864
[1] https://github.com/intel-staging/tdx/commit/782649ab74c1b3f05df7e38d5fc8e3f907a9394e
