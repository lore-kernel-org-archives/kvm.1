Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151B2318EFF;
	Mon,  8 Jun 2026 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903154; cv=none; b=uU3LBIg6RSHiP60/YgA33MHy9UcZuDNEjDZNW2llo0YT+QAMZRjzR96JuIE/xeV5nHITXYoJmTFXJnIDHAfwWSyQq3ZqRlpEeksCB3mGSx/Saqcop3GiDJps3QIltTBx/LCZKQwCOjsOt59XDv8kST0rO+n4d8g2BYN7GxQlSKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903154; c=relaxed/simple;
	bh=j16HnHumJlpOV5pgbjfvRktU8XXXUv1Da/NL5PH7GAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8EaVxkYIRcVCChJ+cSCsO0vxjGxnDhmmL4srRou4tYBuaThMnzCixORAN+hCTz2/e0/MWKFaT4FTRx5bgkfwRlZsssAz3O1Peb1pQqsFTRSU1rVQXOtb5PSTG6gIb6sSiNaHp1ZBxQ7T55kmi6NaNvujufI0ISfBdxUCKrkKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEDlSlAd; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEDlSlAd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780903153; x=1812439153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j16HnHumJlpOV5pgbjfvRktU8XXXUv1Da/NL5PH7GAg=;
  b=UEDlSlAdRh3EFw3bbc3fNyWMV6HTTMjA0X+u8mMmwbaVyHkBCw0Yq3Wq
   P/3SWIopolAX+zM5cnXMQ3x4gNnVWLjDmuyWLQsbfuWWazwgvIC5QPFLq
   vZr5vwZqasvck88gNBJd0jXQ7uCutiJjEFnhsUp8nO6O/iLtqlxRJfj9P
   mkeVGU6SfJdFfieTwaCqByxWmggvPY06ui+wAmeU5hqO+9+oIdBgsiD6e
   yIoeoQX24xscw9u1ve7hKU5jmLG7/sbo1RxgpHYm2ttO+7JOYylQVr4cT
   ifoTE5pZRjX1kzX3Wb5rHxd/VmEEt72Dfr5D1s8QvZ8ZVAntzxEjiEWWQ
   A==;
X-CSE-ConnectionGUID: wCXFP7IMQB6xRZ8IS+J0vg==
X-CSE-MsgGUID: wU76GQ98SWWre2BPkVen1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="91957163"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="91957163"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 00:19:12 -0700
X-CSE-ConnectionGUID: 1IN/Xup3SvSrMqgiJwyPNg==
X-CSE-MsgGUID: +49W69+rT1emC1gmwOC8yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="241290854"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 08 Jun 2026 00:19:09 -0700
Date: Mon, 8 Jun 2026 14:54:38 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX
 Quoting
Message-ID: <aiZnLqXIWBvo90vT@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <5c06bdbc-c847-4dfa-9c89-afbb52946b8f@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c06bdbc-c847-4dfa-9c89-afbb52946b8f@intel.com>

On Sat, Jun 06, 2026 at 09:36:41PM -0700, Kishen Maloor wrote:
> On 5/21/26 8:41 PM, Xu Yilun wrote:
> > ...
> > This series has 2 distinct parts:
> > 
> >    Patches  1-4:  TDX Module Extensions enabling
> >    Patches  5-15: DICE-based TDX Quoting, primarily Peter's work.
> > 
> Perhaps the extensions enabling patches could be organized more simply as
> these three?
> 
> 1. Add TDX extensions metadata structure and accessor
> 2. Add TDH.EXT.MEM.ADD
> 3. Add TDH.EXT.INIT and wire extensions init into init_tdx_module()
> 
> This introduces the SEAMCALLs and lets the wiring land with the patch
> that completes the init flow, avoiding a separate "enable" patch.

Yes, several comments point to a same concern for patch organization - no
need a separate "enable" patch. Also a more sound justfication to me is,
the Extension will not actually been enabled until an add-on feature is
explicitly configured (See patch #15). So we could add steps in nature
order without worrying the incomplete flow breaks the kernel.

My reordering is:

 1. Add a placeholder for Extension initialization to hook into
    init_tdx_module(). Give a chance to explain the considerations of
    the enable-at-boot-up policy.

 2. Detect if Extension is required based on the metadata, if no, skip.
    So no side effect for following steps.

 3. Add TDH.EXT.MEM.ADD

 4. Add TDH.EXT.INIT
> 
