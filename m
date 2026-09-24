Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C16425878
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234135; cv=none; b=Nmy2RJz4hGUJu/gNtetTAjcwYklpwCAG2T1Wk+We3wU4TIZTbICq5CQvMETygGizJ1ZobA57gBKpPb/TrAYvfDRq2MFCP6RFyVNHXGJS5Txu+O4KlZ8uoEz1Rydx2D8y5VeWHPrb5GbWaUX6u6rNZsWuGAGP7psGSIjJyeR9JZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234135; c=relaxed/simple;
	bh=4vlNw/6i5nVwBGL126hD2hlLHoM0xmoRtj93jsx2gq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guSIsqjMckpZ+N+2zqLnnvlqBViY3Wo08RtklAoaZb60eQa8tZA1QLvkXV5f4l3DuThBCuNtY85Mf1r2SnWHjv7+doz9xTAuYvGHfNRxp+wbJkMyR/QOtZKPiFpf5wkwU7Ibqbs1ip3xoxuwxX1+b8FeJdpCuytMypV7f4vp39M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXYZEEKb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXYZEEKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790234131; x=1821770131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4vlNw/6i5nVwBGL126hD2hlLHoM0xmoRtj93jsx2gq0=;
  b=FXYZEEKbnlb3kwlh2oAzX16MnmnhNmJsuhembisdRMh/rGFm3OvcgRVA
   /JgfsmetTHRFSyqzdqTRCdKIaa4omxfrsHk2DCFGRp2uIMnEysO+AgUmw
   LaEmeUb1CjyUYZqVQ/uKpFGVTiEHNBBSXoAaEN9CsEJRzSrIfGllIMDJ0
   OUe2WaQ33pYbGhm0276AbpHYff+UD8H9GzyQsnbf+Z6sFEshoe6ZZQWO+
   VeDWLREKcgtZWD9qjkZeCBGA7hdISJvhxk9syCjpz3mCQN3IVfn8CqGri
   mzS4SvmSniZQ0dSITEu7/nGbLTE9nxI2uV2Uq9XRtWVwrmS6I/CzmyMNV
   g==;
X-CSE-ConnectionGUID: ZEIrvoQ/T2uQfpu008HsSg==
X-CSE-MsgGUID: HSXZrHoKRPGX/gCZVaA4cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101652488"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101652488"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 00:15:28 -0700
X-CSE-ConnectionGUID: Lpp1suoeSXmjU5exj7UCEQ==
X-CSE-MsgGUID: gNqnwVvMRNGGru5Ejc46PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="300211604"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.13])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 00:15:20 -0700
Date: Thu, 24 Sep 2026 10:15:17 +0300
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
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
Message-ID: <arTOBQXhqcVVSyr7@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ab3c9e32-ab34-49bf-937a-4d3d736fb4dc@intel.com>
 <arDHbjcwaRFcHb08@tlindgre-MOBL1>
 <arDVIEobkRr3E7yS@tlindgre-MOBL1>
 <ae22e1df-c09c-4f8a-8010-41e542e4c663@intel.com>
 <arIfu_A1e6KEokWI@tlindgre-MOBL1>
 <288de298-2773-4fa5-8020-21b61bbcad67@intel.com>
 <arN20-sGytS6BlZc@tlindgre-MOBL1>
 <b6afcf8b-5cde-4c70-93fc-86127d1884e1@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6afcf8b-5cde-4c70-93fc-86127d1884e1@intel.com>

On Wed, Sep 23, 2026 at 10:34:14PM -0700, Kishen Maloor wrote:
> On 9/22/26 11:50 PM, Tony Lindgren wrote:
> > Based on what we've discussed, my preference is the following:
> > 
> > Keep the current buf naming. For the EXPORT/IMPORT type functions the use
> > should be obvious from the transfer type. 
> > 
> > Reserve enough space for a separate output buffer or results buffer or
> > whatever it might get called if such a use case ever pops up.
> 
> Reserved space can be named later without changing sizeof, so either way
> works. I'd mildly prefer to declare the second kvm_transfer_buffer just
> because declaring both would settle the second buffer's semantics now. Not
> something I'd push hard on though if you prefer reserving.

Let's just use buf and reserved space then. There is no known usecase
needing separate in and out buffers for EXPORT or IMPORT. And the separate
in and out buffers would have to be needed the same time rather than first
in and then out..
 
> > Add the datasize to struct kvm_transfer_buffer like you suggested and
> > rename size to bufsize.

And to recap, with the bufsize and datasize in the buffer, the needs we
discussed for separate in and out buffers went away.
