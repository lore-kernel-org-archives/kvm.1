Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F53405C21;
	Mon, 15 Jun 2026 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538463; cv=none; b=iLFB/8dD8OGamhQbfgZVImqYqMy4ODpqFlMfSo5SYGa8mn/2x7BVxuojeV/drc0cwOyulK/gPRWt1J0TYiCucFL44PEoTF6Q+4YM1X/3HrvaUHpT9j0PemmBMeph7pW2bcmn6/mu4Puw5iP4JN1BytMidk/l+xxkSOwcxqe3e+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538463; c=relaxed/simple;
	bh=s5SNeakhFf5GRw3iiYXSIN3p/gjwim3Vefo2sUWBCKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALopwsNmgCTd0uApyHzT4sc1wSB2IgMcZLbnZxeUDuT5mc5sCR+GFmB0Zv6sz3Y9zdZPa/EyFePHaXRhGrKMDGsPpSmfUsGwojNp9Bef4BO/LaP1ATlKBvJMja38kmRwy0sr/vNOufBM+lthcHhq128ZMW+EGodDTRW0ho5igIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOZfzMG4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOZfzMG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781538463; x=1813074463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s5SNeakhFf5GRw3iiYXSIN3p/gjwim3Vefo2sUWBCKk=;
  b=fOZfzMG4v1aGhvRj+3o7PMU3oZATy7DfvLw8nGGQzVbqSQ52amDz7Z/8
   ATeEz0MqBGipCobkmW2QH3S5rcdJ3YFREyqO79Ao6p+XUeGIPpxJ9W1V5
   kEHzyLUYMdXdlMQ3lkQ6u2+v5FAoL0Q9hcQZo49ouTixRVHK3Pdc9W86j
   AQM5II51U9qSdEGU5akKRvE+P0T8Vf4Ss3OEPcC9kiaFm6/1tCe5R3H/K
   oJWzXBp4OJ1WDeVl0cVeyHhqd5n1DkM8q6I0Qz/+94BlLwOjYmOMC1o/w
   l46HfptCrXbGZ/q7Kh2ikzzB6Lq3Aei8YBBjePxUK7C9RAHglw8KK51u0
   g==;
X-CSE-ConnectionGUID: OO5TjjUaQfylDWWmmzoPfQ==
X-CSE-MsgGUID: +aVZP6wYT02o3hh5J2B3yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86183230"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="86183230"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 08:47:42 -0700
X-CSE-ConnectionGUID: dxTWT7UBSQmtiabpz15mOg==
X-CSE-MsgGUID: GP1+6tDTTcaajYtUILXXYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="271206560"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 15 Jun 2026 08:47:38 -0700
Date: Mon, 15 Jun 2026 23:22:46 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: kas@kernel.org, rick.p.edgecombe@intel.com, x86@kernel.org,
	peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX
 Quoting
Message-ID: <ajAYxo83xVV1Sb+Y@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <6a2c821a99e3_9b8551002a@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a2c821a99e3_9b8551002a@djbw-dev.notmuch>

> The internal implementation details of extension seamcalls buries the
> lead on why this mechanism is important, why Linux should care, and why
> this brings TDX in line with the other major CC architectures. Something
> like:
> 
> ===
> To date, SEAMCALLs have been short lived routines that monopolize the
> CPU for their duration. This limits their utility for implementing
> higher order security protocols or pushes complexity into Linux. The
> Linux appetite for ingesting complexity is low, so TDX now adds a new
> class of SEAMCALLs that are preemptible and resumable. This capability
> enables higher order service APIs to carry out a security protocol like
> "establish an SPDM session".
> 
> The TDX "Extension SEAMCALL" capability is akin to ARM CCA's "Stateful
> RMI Operations (SRO)", and achieves similar externalized complexity
> relief as a dedicated hardware coprocessor like AMD SEV-SNP. The

I may not include the ARM/AMD examples, not sure I can explain them
well.

> mechanism is "give the service environment some memory", "invoke the
> service API", and "continue invoking until complete". All protocol state
> is internal the service API.
> 
> The simplest class of extension SEAMCALLs to support are in support of
> "DICE-based TDX Quoting", a service to turn guest launch attestation
> reports into a document that can be externally verified.
> ===

[...]

> > The Extensions consumes relatively large amount of memory (~50MB). So it
> > is designed to be off by default.
> 
> This confuses the TDX design with the Linux design, and sets up "50MB" as
> something to be quibbled with. The Linux design is turn on all the
> features that Linux knows about all the time. Unless and until the "any
> available, all the time" becomes untenable it just simplifies the init
> flow to not play piecemeal games. Await evidence to change the simple
> policy. Suffice to say the cost of this policy will burn 10s of
> megabytes.

[...]

> 
> > == Some history ==
> > 
> > The TDX Module Extensions part was first posted along with TDX
> > Connect [2]. Now this part is remarkably smaller because we've removed
> > the generic tdx_page_array abstraction for HPA_LIST_INFO. TDX Module
> > Extensions is the first user of HPA_LIST_INFO, and doesn't use it in a
> > typical way (HPA_LIST_INFO can only hold at most 2MB memory). There
> > isn't enough justification to make the abstraction in this series. A
> > possible plan is to rebuild tdx_page_array iteratively when more use
> > cases arise.
> 
> No need to talk about details not in this series. I would maybe just
> note that quoting is the simplest first consumer and was chosen as the
> lead vehicle over TDX Connect previously posted in case anyone asks.

Good to me, will include most of them, thanks.
