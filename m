Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C505A389E13;
	Wed, 29 Jul 2026 03:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297019; cv=none; b=FVtKLCklMt5OT1y6ms0e4pTOB1hjBzXc4PKlo9qmzhyf5K/JW8Abi9HPjjeB/9MwlyUXTNNpZE8pV6sOdnqL5L8YREdqHOW3ot1M04JfYIyCV73KWL/gQu2kcqYoK38wecSz6BW0NlAxEiZjJW61U1+ZYlP3+GZlhCzemhRxxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297019; c=relaxed/simple;
	bh=cbVN8bTsMYC/fEX0aBjw6tK6TMP8uPsBPqZ7WnMAEPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwzKdeRIcq1Bh6BZkWj/6mHpvyvHMAifdb9EZGa78gGZSanCoSJzoNPdc96AXlcjXAcJ8+tolw0spQKsPCizlrOlhwH9WaoCwNjYhQK8PQF2yqDnTinGcAqzHW/6cKoqSsJFLvDmDUEhY/rtguky7jl6pukcdaHcaGwu2V0C6Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLbraXns; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLbraXns"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785297017; x=1816833017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cbVN8bTsMYC/fEX0aBjw6tK6TMP8uPsBPqZ7WnMAEPI=;
  b=iLbraXnsDs4OKcQQfYffS95JMGZge3nhBGHknKAwhGKSbdQEBchFWFtH
   a44ocxZaCNlHbMzaJLYNkPXEF7vr6jh74G4SHH/zPxVSG0ZE52/Ksmw1I
   9SfFMqjGGn+VgFLVJFjef6oJxxdBKwj1KDk2pH53PRrK1NcPWp6JJsk3l
   omZvTzrQJE+WEZi5dN/cIDHFyDgxWJWIlF6LmXfdee4zsMFgts5AxcI18
   ZgsPMJ992QFmx3/MqdWl5HxHaXjox4cC9LF4iGH5nWL861UVWBFWU7Z8F
   zC88ukQMRPHj77qh/hmNJGa3go83rRfp/3AqcAE2NBmn5NVLOJPin8D8c
   A==;
X-CSE-ConnectionGUID: n11PqbdmQQmvcFkvMJotBg==
X-CSE-MsgGUID: AzootewuQxSXrp2JgdcsUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86087105"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="86087105"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 20:50:15 -0700
X-CSE-ConnectionGUID: qVLynDEkQoucSwKjNXMeBQ==
X-CSE-MsgGUID: IGbDIZQQS7mPyj0BPNU4ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="283225576"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 28 Jul 2026 20:50:10 -0700
Date: Wed, 29 Jul 2026 11:50:09 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"djbw@kernel.org" <djbw@kernel.org>,
	"Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Message-ID: <aml4cVnFkKvmJimj@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-4-yilun.xu@linux.intel.com>
 <cfeee0fe-c61d-447c-86bc-8d8244090879@intel.com>
 <amdRWaoKa0k324JM@yilunxu-OptiPlex-7050>
 <7611fe250925614d64f05cac8d398f54ee386583.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7611fe250925614d64f05cac8d398f54ee386583.camel@intel.com>

On Mon, Jul 27, 2026 at 05:56:31PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2026-07-27 at 20:38 +0800, Xu Yilun wrote:
> > > This is not true. There are some normal (non-extension) SEAMCALLs also are
> > > preemptible and resumable. For example,
> > > 
> > > - TDH.PHYMEM.CACHE.WB
> > > - TDH.SYS.DISABLE
> > > - TDH.MEM.SEPT.ADD with version 1
> > 
> > No they are not preemptible and resumable. They just intentionally
> > yield and don't have a generic way to save/resume their context. You
> > can't rely on that to implement complex tasks in TDX module considering
> > the complexity. That's the main reason why TDX module extensions are
> > needed.
> 
> We have RESUMABLE seamcalls today. They are guaranteed to save state and make
> forward progress. Xiaoyao is right, this is not a new concept from the VMM side.

OK. Let me de-emphasize resumable.

And I'm thinking of how to stop explaining new terms again and again,
extension SEAMCALL is the one. I'm not sure if calling it "preemptible
SEAMCALLs" helps, or is it still a new term?

> But also why highlight this for the patch here. Are you trying to explain why
> extension initialization needs some special step?

I was following the suggestion [1] of explaining the context in general.
But yes, a brief explaination of why we need special initialization is
good to me: A global service environment should be built to provide
some general context switching mechanism inside TDX module.

[1]: https://lore.kernel.org/all/1783e7bd-3759-41f7-93e3-2f9e21264bd4@intel.com/

Refactored the first paragraph:

----8<----

  TDX adds a new class of SEAMCALLs which are preemptible and can cooperate
  with the host scheduling. Some features like TDISP, DICE-based quoting
  rely on these preemptible SEAMCALLs to implement higher order security
  protocols with simple ABIs. To enable preemptible SEAMCALLs, a global
  service environment, called TDX module extensions, must first be
  initialized.

  ...
