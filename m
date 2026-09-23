Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404544683E;
	Wed, 23 Sep 2026 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147437; cv=none; b=nLo0GIpKld0wRUN/5K6ah8SYxKijElye7lYWsLAzX6hwziMq3aPmz1q341ZT7d69qA3icHArPPxKjrIqBfYMlP2Fjwkpe11aylDRw8IKXed33dpnbaJ4OgeeY0Jq8cACsEmc4pghBoPIK1O4Wt69QGseQUBuTLXKDKa7gMF/KT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147437; c=relaxed/simple;
	bh=JkSChL0vtocvr/tbCkoo+HdlZNHkoDcYYAOjIiPyrx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0MkkkvNcAAyl9KuvnPIYUM0r6jimtt4zyAs8vZJzPzysxSoTLffD3JaKJQs8LJmLf2uiaLF8oq4V8X81Zxcx32Rb2aMMWMfr7U9r7xiA+FIFrkEjuyMsxMDYpjHezoF7Pabl5A1oVVCdpORr9R2pKZ0tHKdR4kU1QT921Qanqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=git9Fm0j; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="git9Fm0j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790147434; x=1821683434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JkSChL0vtocvr/tbCkoo+HdlZNHkoDcYYAOjIiPyrx4=;
  b=git9Fm0jPfzK7M3IPynXwSndhX4mcQQcDHv/4RZhDafyNVZq25SF9HkX
   pfnweY03ed1u21i0BMdB2g8c8jkC+gtM5BJcE5wtjT4QNpY7BV+BZyD0h
   iCZlzCf//ytCGrBf0FCNVUmjmOft+rDHxJzrT9DLeAF7TVJQQgRgRe5I+
   7uBbNGOGjXy+/w8NEHFCLJ5dTqkasxTn79VyERVr69nKdOEmm9wME+xeb
   81rp/CbtyH+A/J6oidH7GhZ6M7Weh25255ePD56Bm+lSepippkLXexQMA
   IRVyf0Ad2erpKu48uJ4tkMOxTnJ4awjavXfTQHIJh1oRaJ+6Q4EB+NtUv
   A==;
X-CSE-ConnectionGUID: 9LwaLOytRDmMNdoyI1Ri8Q==
X-CSE-MsgGUID: thmYZFtgRA67xTS77UaXoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101475373"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="101475373"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 00:10:32 -0700
X-CSE-ConnectionGUID: /A0PgzoASFu2L+9OdWK7xA==
X-CSE-MsgGUID: MCGFTH42S7mHRHlMs8mCww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="278230367"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa004.fm.intel.com with ESMTP; 23 Sep 2026 00:10:29 -0700
Date: Wed, 23 Sep 2026 15:09:25 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, seanjc@google.com,
	x86@kernel.org, kas@kernel.org, adrian.hunter@intel.com,
	yan.y.zhao@intel.com, binbin.wu@intel.com, xiaoyao.li@intel.com,
	chao.gao@intel.com, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
Message-ID: <arN7JeQa1f8V61UJ@yilunxu-OptiPlex-7050>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
 <20260922205215.870563-3-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922205215.870563-3-rick.p.edgecombe@intel.com>

On Tue, Sep 22, 2026 at 01:52:15PM -0700, Rick Edgecombe wrote:
> In the early days of TDX it was expected that pages being reclaimed from 
> the TDX module would need any cacheline from their private KeyID alias 
> flushed. The TDX docs describe doing this in a couple cases, for example 
> reclaiming the TDR memory:
>   Flush MODIFIED cache lines: this is required to avoid corruption due to
>   cache line aliasing. Note that all cache lines for all other TD pages
>   must have been flushed before the TDR page was reclaimed.
> 
> For a similar reasons as why the CLFLUSH_BEFORE_ALLOC features0 bit was
> never actually set in any TDX module, this flush of the private KeyID
> cachelines turned out to not be needed by the final TDX solution. However,
> the TDX docs were never updated to reflect that.
> 
> Since private KeyID virtual mappings are reserved for TDX use, the TDX
> module has to do the clflush itself.

This paragraph is a little confusing to me. Here reads like the TDX
module does the clflush internally and the host doesn't have to opt-in.

> The TDH.PHYMEM.PAGE.WBINVD SEAMCALL
> leaf was created for this purpose.

But the SEAMCALL leaf shows host should opt-in.

Ah, you want to say host can't directly do clflush because of some
reason, so we need a SEAMCALL, is it?

[...]

> @@ -578,15 +577,6 @@ static void tdx_reclaim_td_control_pages(struct kvm *kvm)
>  	if (__tdx_reclaim_page(kvm_tdx->td.tdr_page))
>  		return;
>  
> -	/*
> -	 * Use a SEAMCALL to ask the TDX module to flush the cache based on the
> -	 * KeyID. TDX module may access TDR while operating on TD (Especially
> -	 * when it is reclaiming TDCS).
> -	 */
> -	err = tdh_phymem_page_wbinvd_tdr(&kvm_tdx->td);
> -	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
> -		return;
> -
>  	tdx_quirk_reset_paddr(page_to_phys(kvm_tdx->td.tdr_page), PAGE_SIZE);
>  
>  	__free_page(kvm_tdx->td.tdr_page);

After removing the wbinvd, we don't need open code to reclaim tdr
anymore, is it? tdx_reclaim_control_page(kvm_tdx->td.tdr_page)?

This may not be relevant to the topic, not sure if we are good to clean
up it in this series.


Another thing. There are also 2 wbinvd_on_all_cpus() on PAMT
adding/reclaiming. Remove them?
