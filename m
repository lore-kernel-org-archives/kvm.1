Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13601377ECF;
	Wed, 27 May 2026 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879741; cv=none; b=XY+dnHUMcPIGqBuOdacsEzA3x8rQSlHRf6B1Z7jRH60so1+nKUI4jF0p54niTvpaf59SfQ1L1jkGfni9WjN0OHYBly6RQYD03ZONOrHU8EeGqqWVeH/GEDA+FET996bVwIiPa9CxoZVDM9y7IYQfM9QN0NllXA+VQ/RBmF5sXKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879741; c=relaxed/simple;
	bh=tFrXfqMuDYktSKSgxbr5V4AVjEfZpauBkUkMw2B2Drg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwFQh4NSt2rejgsrClBAr1gQINL8l8S+BohETi+IeK3NVbOW5gqCaU63rnyGQ8uluwzoHosiF342GJncjYp/FsKimvpjqcZY+Xrr4DwYu19Ysg6d2Cj1vF3TukXDnM1dDXhS1JNRVngTErUt5sNKg8S5l+vJkUkdXZJU/cBNuzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGvJffx6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGvJffx6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779879740; x=1811415740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tFrXfqMuDYktSKSgxbr5V4AVjEfZpauBkUkMw2B2Drg=;
  b=lGvJffx63ET38mUSK87EWvbiE7CCLBgp0kw5X1aDPvGwXH1XcRhDmtnB
   X0r55S6tc+5TsYDi/AQq5J09xWuAzsgvHdXyES99OXS/VB3YHVrrwl9Dq
   veIe8hImMIZAhE8D3AWXjmAcQXvP0ryb0pFRsJ3sY89oANBeT8WZTuhQc
   2sng77HwboyWCkVmDO5WojDxGq6ebbBmO8NvKfwuVZg2Nxf8xTYMEXECx
   Us5R17StsX3zonVYF7FjjOwCWc68QFD8S+m4oMpH5Q1kiZmmNUGYVNj5N
   +QAzb1utsWVLpCf3uWGMJf8G+cc4SKFXKMh4s9LGNyiRMBJ7UlEit91Hc
   w==;
X-CSE-ConnectionGUID: bCOMOliAQzay5nw4ZjMkVA==
X-CSE-MsgGUID: 5sK+JmQoRcihzOab1BFrpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80689185"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="80689185"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 04:02:19 -0700
X-CSE-ConnectionGUID: wE7RJuvZRKywoYyKsXJmTQ==
X-CSE-MsgGUID: 4fLQP8SqQICEgvIKIw/iCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="280338075"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 27 May 2026 04:02:16 -0700
Date: Wed, 27 May 2026 18:38:20 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX
 Quoting
Message-ID: <ahbJnCFlGFwxrEkw@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <2542e761-57ed-4170-8ce9-1de3fc685dea@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2542e761-57ed-4170-8ce9-1de3fc685dea@intel.com>

> > == Overview ==
> > 
> > TDX Module introduces the "TDX Module Extensions" to support long
> > running / hard-irq preemptible flows inside. This makes TDX Module
> > capable of handling complex tasks through "Extension SEAMCALLs".
> 
> Can we explain a bit more about why these extensions are needed or what
> would happen if the kernel didn't enable them? I ran the series through
> an LLM for my curiosity. I think something on the below lines might be a
> good addition for the cover letter itself.
> 
> (Please verify)
> 
> The TDX module's normal SEAMCALLs are designed to be short,
> non-preemptible operations. However, some newer features (like
> DICE-based TDX Quoting) require complex, potentially long-running
> computations that can't complete within the tight constraints of a
> single non-preemptible SEAMCALL.
> 
> The "TDX Module Extensions" solve this by introducing "Extension
> SEAMCALLs" — a new class of SEAMCALLs that are:
> 
> * Long-running — they may take significant time to complete (e.g.,
> cryptographic operations for attestation/quoting).
> 
> * Hard-IRQ preemptible — they can be interrupted by hardware interrupts
> and later resumed, so they don't monopolize the CPU or cause
> unacceptable interrupt latency.
> 
> Without this mechanism, complex operations like generating DICE
> attestation quotes would either block interrupts for too long
> (unacceptable for a host kernel) or wouldn't be possible inside the TDX
> module at all. The Extensions give the TDX module a way to handle these
> heavyweight tasks while remaining cooperative with the host's
> interrupt/scheduling model.

I'm good to these detailed description. I'll add them to the
cover-letter.

> 
> > 
> > TDX Module allows some add-on features to use the Extension. 
> 
> s/Module/module throughout the series.
> 
> The existing kernel code predominantly uses the lower case TDX "module".

OK.

> 
> 
> > The first feature to use Extensions is DICE-based TDX Quoting [1].
> > DICE is an industry-standard, certificate-backed attestation
> > framework that layers evidence through a chain of certificates.
> > 
> > This series adds infrastructure to enable the Extensions and then
> > implement DICE-based TDX Quoting.
> > 
> > The Extensions consumes relatively large amount of memory (~50MB). So it
> > is designed to be off by default. It must be enabled after basic TDX
> > Module initialization and when add-on features require it. To enable
> > the Extensions, host first adds extra memory to TDX Module via a
> > SEAMCALL (TDH.EXT.MEM.ADD), then uses another SEAMCALL (TDH.EXT.INIT) to
> > initialize Extensions, and then some add-on features, e.g. DICE, could
> > use Extension SEAMCALLs for work. Note that host can never get the added
> > memory back.
> > 
> > Theoretically, the Extensions doesn't need to be enabled right after
> > basic TDX initialization. It could be enabled right before the first
> > Extension SEAMCALL is issued. That would save or postpone memory usage.
> > But it isn't worth the complexity, the needs for the Extensions are vast
> > but the savings are little for a typical TDX capable system (about
> > 0.001% of memory). So the Linux decision is to just enable it along with
> > the basic TDX.
> > 
> 
> I think enabling it by default on TDX platforms (with the module
> extension) might make sense. But the explanation here is slightly
> confusing.
> 
> You said earlier that "The Extensions consumes relatively large amount
> of memory (~50MB)" so they must be off by default. Later you say that

Sorry maybe I should say "the firmware design is: 1. Off by default.
2. Must be enabled after basic TDX module ...". I'll try to update the
words.

> "..the saving are little .."

Because for security purpose, these add-on features are always needed,
even if not all of them, so Extensions will most likely be enabled.

And even if someone switched them off all and saved the memory, compared
to the memory of a typical TDX capable system (lets say 1TB), the saving
is still little (0.001%).

> 
> Are you saying that the dynamic enabling of the extensions is not worth

The dynamic enabling of the Extensions is not worth.

> it or the dynamic allocation of the memory needed to support them?
> 
> In addition, could you briefly describe the complexity we are trading off?

If we delay the Extensions initialization to the first Extension
SEAMCALL, we need to maintain additional TDX state machine for
lifecycle, and we need mechanisms to synchronize parallel Extension
enabling request from multiple callers.
