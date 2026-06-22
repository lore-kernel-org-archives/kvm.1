Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE00379EE1;
	Mon, 22 Jun 2026 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129932; cv=none; b=MveCd9784uak5ZZI7YqqskvjJGAg0G+gztf91lkm6pyq/LpF8JR/8ZhNvDKkwncEc/IkzIFtmLQicQF9uRBXjxQnlGo6JQyEir36YmUcuQAY25AX8SV9NjJd9jd9ApzgoA0OcmbH7Wjh5T6sHb57cY9izVF3o2hKeZ/iZ157B50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129932; c=relaxed/simple;
	bh=BYS7T/Ih5enpda3QrTXqGfExXB6WnMBwqnxrQGORuDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyY0yfP3864e1HypiTPFF7q5qO6xFNNr55l5yL8eMukIw4eBqm24VQkS9hirBURhfpMH+XiZuwzhfrhfdor273R5WMrbhj3J76wTeOZW5qliqmgMVs1SdWd2dtreYHfuDXGvgwuSjeSL04CinqAeqCByjGgkKgJfX9vn3PdEBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRUhZQF8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRUhZQF8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782129931; x=1813665931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BYS7T/Ih5enpda3QrTXqGfExXB6WnMBwqnxrQGORuDQ=;
  b=CRUhZQF8Y1aD4XFutA/ajCc+MbNTEHc+GH5nuhzGkOnOcg/6sDeg8tHm
   OYxouIae47WA06NdPMi2udlPsG4hlsIkKbo0J2TdsQ1TFK9W1cEpw7T7s
   pRC7Xcuc5mOLrt50oP8JZk3WPo8MeGNgnTC+cezLnK1hkcw2QyLKInLR+
   Yo5e8oC3jo1qOLSs848RqYPPvnjZjfpaQbE40NCjH5QStTTUhh67EVv1b
   Fh+uQHZSUKS8+EgC/AGZvFcYP5d1Ufq0GQgpdEzdQHYbGQOFfnf/yCnSX
   GJHvEKnbzH9+V6SlzVyLu+kutQrdZzxk/FF3jAehUCxdCTKvBvFXgjzGA
   g==;
X-CSE-ConnectionGUID: Wxx/uaoyReCVBFTrzXarWQ==
X-CSE-MsgGUID: Rq9x/RVaSY+ua47I2Y+o4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82965905"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="82965905"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 05:05:30 -0700
X-CSE-ConnectionGUID: biJUyoNiS9+z5etFrODsNQ==
X-CSE-MsgGUID: VlNb0URbQ4CTngHkcl0Byw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="245060335"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 22 Jun 2026 05:05:26 -0700
Date: Mon, 22 Jun 2026 20:05:25 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	dave.hansen@linux.intel.com, seanjc@google.com
Subject: Re: [PATCH v2 01/17] x86/virt/tdx: Embed version info in SEAMCALL
 leaf function definitions
Message-ID: <ajklBUw1bmo3HoGZ@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-2-yilun.xu@linux.intel.com>
 <bdde1a33-9513-4be3-87cb-044c034eddb1@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdde1a33-9513-4be3-87cb-044c034eddb1@intel.com>

> This is jumping the gun a bit in the changelog.
> 
> What is a SEAMCALL leaf function?
> 
> How does the version fit in?

I think the word "leaf function" is confusing, maybe I should say
"... SEAMCALL interface function definitions..."?

And I missed some more context explanation here:

  SEAMCALL accepts parameters via CPU registers (RAX, RCX, RDX, ...),
  where RAX selects the specific TDX module function to execute. According
  to the TDX module SPEC, RAX is mainly composed of:

  1. leaf number: selects the function.
  2. version number: selects the function version. The newer version
     defines more operations. It also defines additional parameters for
     the rest of registers.

  Newer version SEAMCALL uses the same leaf number as older versions,
  with only the version number increased. Newer version SEAMCALLs are
  guaranteed to be backward compatible.

[...]

> > The old TDX modules that only support TDH.VP.INIT v0 are all deprecated,
> > so only provide the latest (v1) definition.
> 
> No, this isn't how this is going to work.
> 
> What do we *NEED* from v1? Why churn the code if we don't *NEED*
> something from v1 and can live with v0?

Sorry for the confusing words, for this TDH.VP.INIT, kernel is now using
v1, we need v1 for virtual x2APIC. Maybe I should add "No functional change
intended."

> It has *ZERO* to do with the TDX module being deprecated or whatever.

Since newer version SEAMCALLs are always backward compatible. TDH.VP.INIT v0
is only needed when we need to support legacy modules that don't understand
TDH.VP.INIT v1. We don't support such legacy modules, so I meant to
eliminate TDH.VP.INIT v0 definition and reduce histroy burdens.

We have some previous discussion that leads to "kernel don't keep SEAMCALL
version at all":

https://lore.kernel.org/all/ca331aa3-6304-4e07-9ed9-94dc69726382@intel.com/

But I have trouble for not keeping versions for TDH.SYS.CONFIG/UPDATE (in
next patch). No public module supports TDH.SYS.CONFIG/UPDATE v1 so I can't
eliminate TDH.SYS.CONFIG/UPDATE v0. I'm GOOD we are now considering keep
aware of SEAMCALL versions at some level. Keeping in mind which module
is published is another burden...

[...]

> But that whole scheme falls apart the first time the kernel needs
> functionality from v2. You'll need:
> 
> #define TDH_VP_INIT_V0			SEAMCALL_LEAF_VER(22, 0)
> #define TDH_VP_INIT_V1			SEAMCALL_LEAF_VER(22, 1)
> 
> and then the calls will do:
> 
> 	if (foo)
> 		return seamcall(TDH_VP_INIT_V0, &args);
> 	else
> 		return seamcall(TDH_VP_INIT_V1, &args);
> 
> So this 100% goes down the road of needing #defines for *EACH* version.

TDH_VP_INIT_V0 has no use case in current code, so maybe not #define for
EACH version.

And we have 100+ SEAMCALLs in SPEC, 30+ is being used in Linux, 20+ is
comming, only 3 need versions now. I think making versioned definitions
for EACH of them is overkill.

I see you have another suggestion in next patch which avoids the
#defines. Let me continue in that patch.


> The whole seamcall RAX thing is one step too clever. I think Linux did
> the right thing:
> 
> 5	common	open				sys_open
> 288	common	openat				sys_openat
> 437	common	openat2				sys_openat2
> 
> New ABI gets a new base number. No need for the other end of the ABI to
> know that 288 is arguably a later version of 5.

Yes, that's true.

> 
> Ugh. But why is this patch even in here in the first place? Why is this
> even *ASSOCIATED* with DICE-based attestation? Isn't this completely
> orthogonal?

TDH.SYS.UPDATE/CONFIG is the second user of the version stuff. So as
required, fix the open code issue of the first existing user.

https://lore.kernel.org/all/62bec236-4716-4326-8342-1863ad8a3f24@intel.com/

Thanks,
Yilun
