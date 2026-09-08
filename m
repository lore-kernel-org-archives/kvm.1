Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98D370ADB;
	Tue,  8 Sep 2026 04:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841440; cv=none; b=abmgDYBsPwaKYB26cLPo49LILbqJZSLLWoH9ycJDAvcmKkWWu1EQiI29DjWDv5kO/97MhRvJbiOsp50ptP1X4CHMqnV5Rv2SykxmvsPd79XboX+9+LoQvTpv/M0wq2zABa3ie2YRoNQF/pU6S74ab8UZdZ0vPPx7Q7ZyzGmm03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841440; c=relaxed/simple;
	bh=GmYx8/ubw28NBw8jeJfTzyqV+0OVFOHY0P+WebTdJJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgBCzxJll0EpbdjODJae9jwNmAKpGRAHbRcXYDAe014od1MAY4QAP+h2OJw3nnlIhJ0JhU+TbApdF5pDA5Ngx1DJXQ6/RfYBjdKrK/0+L2EQkx6kgj2ECG6pcaAvyTjstaBoYFknsTJzUIeRYAtpWdC8aryYFxc2p3fqLS4Yd7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPKEGi/3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPKEGi/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788841437; x=1820377437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GmYx8/ubw28NBw8jeJfTzyqV+0OVFOHY0P+WebTdJJE=;
  b=lPKEGi/3wlzPzLXuE6CXdgUfgJvvsl++sEUWlSyGC3/q+cCplf56PTZK
   sNcho2PtlkVciR982/pje+H10Lo08awFGds63KphgTPBvScSfb+gauxM6
   dx1DB4xYnTT1KUHwTV4WEGx1ra81w1INdtUYeHfOPBzvuUxAdb4HzeDgH
   2o5grjI8a9E02ISvJkedk+C7uOBet84GNLcEfdr8azcTp+MtWLp3CDH2M
   tw8hvGjemtMX6K4akEqoKaPSb1TdcLx+g2ks2Na+whFtMl77d1FdMGsF0
   zlHiR9sdDpwJzFveT1q6CBLzyQfCWXKAvc6upWxQesKnqo7zADIg3JBYc
   Q==;
X-CSE-ConnectionGUID: Rgvvt/jsRiaMH6cA/eDEfg==
X-CSE-MsgGUID: tz0kTdohTWaJO3tigoaT1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99828072"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="99828072"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 21:23:56 -0700
X-CSE-ConnectionGUID: 6OLZfPjkRTem3aJnhZIzZQ==
X-CSE-MsgGUID: aD7lpxQ8S0+iOuHd74rZdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="274657312"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 21:23:52 -0700
Date: Tue, 8 Sep 2026 07:23:49 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Peter Fang <peter.fang@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 4/4] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <ap-N1Q2puBWmmk7t@tlindgre-MOBL1>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-5-peter.fang@intel.com>
 <bf51e3d3-cf28-4155-9915-683bf6c848a4@intel.com>
 <apkUrXh4FJJua4mN@tlindgre-MOBL1>
 <apsxN4jYe3G3meNz@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apsxN4jYe3G3meNz@intel.com>

On Fri, Sep 04, 2026 at 01:59:35PM -0700, Peter Fang wrote:
> On Thu, Sep 03, 2026 at 09:33:17AM +0300, Tony Lindgren wrote:
> > On Thu, Sep 03, 2026 at 02:21:35PM +0800, Xiaoyao Li wrote:
> > > On 7/29/2026 8:29 PM, Peter Fang wrote:
> > > > A new TDX module ABI reports the TD Quote size limit in a metadata
> > > > field. This size used to be fixed at 128 KB.
> > > > 
> > > > The guest driver's Quote buffer is shared with the host VMM. The current
> > > > fixed size may be too small for Quotes using schemes such as
> > > > post-quantum cryptography (PQC), where larger certificate chains can
> > > > increase the Quote size significantly.
> > > > 
> > > > Allocate the Quote buffer based on the reported limit. This avoids
> > > > wasting memory on platforms that do not require larger Quotes. Older
> > > > platforms fall back to the default 128 KB buffer.
> > > 
> > > I think we need to justify why using the value reported by TDX module
> > > (i.e., QUOTE_MAX_SIZE) is safe.
> > > 
> > > From "Intel TDX Module Extension for Quoting" spec,
> > > 
> > >   QUOTE_MAX_SIZE that specifies the maximum size of the buffer that must be
> > >   allocated to contain the Intel TDX Quote received from Intel TDX Module.
> > > 
> > > So, TDX module only guarantees that QUOTE_MAX_SIZE is big enough to hold
> > > the quote that is generated by the TDX module. But for the current tdx
> > > guest driver, it doesn't know how host will generate the quote. Host can
> > > generate the SGX-based quote and we need to justify the QUOTE_MAX_SIZE will
> > > be enough for such case.
> 
> Thanks for pointing this out. I confirmed with the TDX security folks.
> The reported QUOTE_MAX_SIZE covers all possible quote types on the
> platform. If GetQuote gets routed to SGX and QUOTE_MAX_SIZE is too small
> for that, it's a TDX module bug.
> 
> I'll add a comment and update the changelog.
> 
> > 
> > And can we assume the TDX module provided size does not change after init
> > with a TDX module update?
> 
> Yep, it's safe to assume that.

Thanks for checking the above:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
