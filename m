Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086BC239E9B
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451356; cv=none; b=rmLT2I4gcxOSYQs5xpUiD/VwOmLWmegCknBhaxbkEuyzVWfANpvVAS67VwUVOqvWINY65wGMpnLPX6dDrznRVedeMoWUpvc/t+9pWm9MMoZyOJmdnL4wL02zYf/cvCFMEN6SdfDT0Y/bs60wykb9O7KL11XohPGwAHLSPREfDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451356; c=relaxed/simple;
	bh=YmEgyo5dcFgxLPOo6cFg4GPczO7trT8msi81FHbTvDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faOzDpR5olAHCRCNROx0MbgEf7TftX1c2DmcakrFftmfP78SvPg4xo4Id7F5fcmX2+hzEwxFv7yauYWUlpXJoOA7cf2/1QVywlVhgXC3kyXVuZhDZr3QPefe6ROeorPYWrHuWSuPnVGUsoils/uwy9iHBAdKPO9ze8jAHNqD/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DX1B58ch; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DX1B58ch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791451351; x=1822987351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YmEgyo5dcFgxLPOo6cFg4GPczO7trT8msi81FHbTvDM=;
  b=DX1B58chGjQKgZGaJQfLC4ofxtg3ValV8p8RbNUYDrhxRzGX9VDKoe3E
   baIp2yRWXHTGRx0sZxH6IusGH0JfAMbKNbPMjXEV5LpTjaawpeDdRtZJD
   YhE6vLLeNOCVWpalr7wy+B7JzZg53gfSPc6jvkxd+8G0p4b8SP60j3oxi
   ZAqmvNtD5tZoVFDkdQl8ewViIgZCnXxBbkohVmsN9T94JqVrioYR6ec83
   DHJlWbGx2xj5ui9eN9X67JlY/aZ4CYhq/T3lXhcWYF3/dCfPqibxI/mpF
   CpgVadIm5oP9v2QhWPTxSL1SES7vNhqHPC3R2npf2uUbf5s1nls2cL4xq
   g==;
X-CSE-ConnectionGUID: YZQcEM4SRyG5SkcCinLR6A==
X-CSE-MsgGUID: 8Oy60V9uSTCMvofz7oYHKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="123115"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="123115"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 02:22:30 -0700
X-CSE-ConnectionGUID: fp1tF/wbQju1m90di+2vMg==
X-CSE-MsgGUID: jiRY4M51TjexkEwxPf0Rmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="99036"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 02:22:22 -0700
Date: Thu, 8 Oct 2026 12:22:19 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
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
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	mathias.brossard@arm.com
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
Message-ID: <asdgy2sGInTGZn59@tlindgre-MOBL1>
References: <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ab3c9e32-ab34-49bf-937a-4d3d736fb4dc@intel.com>
 <arDHbjcwaRFcHb08@tlindgre-MOBL1>
 <arDVIEobkRr3E7yS@tlindgre-MOBL1>
 <ae22e1df-c09c-4f8a-8010-41e542e4c663@intel.com>
 <arIfu_A1e6KEokWI@tlindgre-MOBL1>
 <288de298-2773-4fa5-8020-21b61bbcad67@intel.com>
 <arN20-sGytS6BlZc@tlindgre-MOBL1>
 <b6afcf8b-5cde-4c70-93fc-86127d1884e1@intel.com>
 <arTOBQXhqcVVSyr7@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arTOBQXhqcVVSyr7@tlindgre-MOBL1>

On Thu, Sep 24, 2026 at 10:15:17AM +0300, Tony Lindgren wrote:
> On Wed, Sep 23, 2026 at 10:34:14PM -0700, Kishen Maloor wrote:
> > On 9/22/26 11:50 PM, Tony Lindgren wrote:
> > > Based on what we've discussed, my preference is the following:
> > > 
> > > Keep the current buf naming. For the EXPORT/IMPORT type functions the use
> > > should be obvious from the transfer type. 
> > > 
> > > Reserve enough space for a separate output buffer or results buffer or
> > > whatever it might get called if such a use case ever pops up.
> > 
> > Reserved space can be named later without changing sizeof, so either way
> > works. I'd mildly prefer to declare the second kvm_transfer_buffer just
> > because declaring both would settle the second buffer's semantics now. Not
> > something I'd push hard on though if you prefer reserving.
> 
> Let's just use buf and reserved space then. There is no known usecase
> needing separate in and out buffers for EXPORT or IMPORT. And the separate
> in and out buffers would have to be needed the same time rather than first
> in and then out..
>  
> > > Add the datasize to struct kvm_transfer_buffer like you suggested and
> > > rename size to bufsize.
> 
> And to recap, with the bufsize and datasize in the buffer, the needs we
> discussed for separate in and out buffers went away.

Based on the ARM CCA live migration presentation at LPC by Mathias
Brossard, we now have a user for a separate metadata buffer. Adding
Mathias to Cc.

Page 8 of the presentation at [0] below lists it under feedback. And see
also page 10 for feedback.

Probably best to make the buffer a userspace array with an arch specific
define for the number of buffers. So far looks like two buffers for ARM,
and one might be enough for x86.

Looks like we should have a separate SETUP command to query the buffer
sizes for cmd, memory and vCPU transfers.

[0] https://lpc.events/event/20/contributions/2476/attachments/2235/4909/LPC2026_CCA_Live_Migration.pdf
