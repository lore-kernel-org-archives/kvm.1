Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F0E3C3BFC
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440653; cv=none; b=KWdS3PFHcNK8KokNJYJ/v32Rok5IR6P9upW2FjDOLp07PKuJJZKiVgJqqWOkwVHQyHgihsjITAj8mraylnyLVeYBdVUwpHedWlhBKykh4cHzhVT9CrfYshgshbvrf7odwFJnLzgUa+unVc0jKOkFKBPzwkXfw5duFS8XuDMT+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440653; c=relaxed/simple;
	bh=4CppR0bch+4s61gpyBTd7ZAokSJa1n93lkTtB6blPHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mwt9muUy0saLecmIM0ICe5VSxu6XfP0Z9kvtVFClYPAIPNr4CxUrMDDNr03pEYDMtK4lub8xkYSi0PN617G2RE3WnwqPCLiNLotMMuv3OmjCh8A5/GlkJvxIRdEuwH3NuzBomjHU2IY9akhTRYU4Juc3Vz3ZciixS/4cso2iUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IetvDEpS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IetvDEpS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791440651; x=1822976651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4CppR0bch+4s61gpyBTd7ZAokSJa1n93lkTtB6blPHA=;
  b=IetvDEpSifpkbZtCSm8EK+aEV+kVO2c6nmFbwLVK9qJsmsIBFe4U2pJA
   GZdXK0BqtTSOB+SDcVBroxzfnzOsxt0Z1aA9eQgcgNIl/Vbd3GxCY/ipr
   K+5MB3SLKrtCWoGN3iuyduvP6qXbXzS2eHXAAv1p7zevxh4q1ShqLCclB
   AsAUawMOv3RzSYCEvYimHc0S735VXBxcTX1rDufInSUo8GaPjXohfX3yT
   cBOy6rjQO4jAacfpXpNQ7P9bm3zXxgSgSE/5/PRpopC99yHZb25rXt8+X
   MEK5/DPWKj9MIoc0XSwVBR7SBhSosb/vtyBlDcTfmz00sHMAwfcq0mzEW
   g==;
X-CSE-ConnectionGUID: 9zxyTMoPRuWTMd016va9dA==
X-CSE-MsgGUID: DdxIpwLtSA+fT6r25RzzIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="233722"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="233722"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 23:24:09 -0700
X-CSE-ConnectionGUID: KVjcQy4uSv6TztbgWpKknA==
X-CSE-MsgGUID: m12afiHZSRS5uUhWftajNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="1766610"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 23:24:01 -0700
Date: Thu, 8 Oct 2026 09:23:57 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Peter Xu <peterx@redhat.com>
Cc: Kishen Maloor <kishen.maloor@intel.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
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
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Message-ID: <asc2_aQ_T91bwMIm@tlindgre-MOBL1>
References: <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <a4ec3af5-5494-4fb4-bf66-e3a8b67325e3@intel.com>
 <arRGYbvXgq8LLYQH@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <9fa229ea-818c-4ba9-81c6-be7ead5cb60a@intel.com>
 <araC0YkwLVPhGfy0@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <784c4ecc-da9d-44b8-9adc-1d1e92d20ae3@intel.com>
 <ar10Ncg2-GhzgBR9@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <30006d88-6679-4274-87fe-f1ce8732577c@intel.com>
 <asan7ETOVEZqRehY@zhexu-thinkpadt14gen5.rmtcaon.csb>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asan7ETOVEZqRehY@zhexu-thinkpadt14gen5.rmtcaon.csb>

On Wed, Oct 07, 2026 at 04:13:32PM -0400, Peter Xu wrote:
> On Tue, Oct 06, 2026 at 09:27:47PM -0700, Kishen Maloor wrote:
> > Hi Peter,
> 
> Hi, Kishen,
> 
> [...]
> 
> > > Especially, MEM.IMPORT seems trickier to me: MEM.EXPORT even if described
> > > in in GPA address space, can be converted to other address spaces at will,
> > > as long as QEMU has full knowledge of the mappings.  MEM.IMPORT, OTOH, may
> > > not trivially work in GPA terms, if memory mappings can overlap.
> > 
> > I can appreciate that. Working in GPA terms assumes that a GPA reference is
> > unambiguous over the duration of migration, which holds true in the TDX case.
> > 
> > But it would break if another backend is able to point a mapped GPA at a
> > different protected page while keeping both pages valid -- essentially
> > the PAM case on regular VMs.
> > 
> > One option that comes to mind is to add a 2nd optional identifier to
> > kvm_memory_transfer consisting of a guest_memfd fd and an offsets array.
> > That would be at parity with QEMU's block+offset and directly reference
> > specific storage units. Then QEMU and KVM backends for a platform would
> > decide what identifier to use.
> > 
> > The value might be that a bundle could be accepted by a backend for
> > storage that isn't currently mapped in a memslot.
> > 
> > OTOH, slot+offset as an identifier might face the same problem as GPA in
> > this case when a particular RAMBlock's storage isn't mapped at the time
> > on the destination.
> > 
> > Not sure if this idea is viable or even makes sense; this is mostly
> > for discussion, but would appreciate your thoughts.
> 
> Yes, I would think (gmemfd, [array of fd offsets]) a nice interface.
> 
> If we say gmemfd is the container of data in KVM world, then if it can
> provide all data accessors it feels all natural and fit.  And yes, it also
> works for overlapped.
> 
> Said that, it's a matter of if, TDX or any other solution, will use GPA to
> be part of attestation process when loading the data.  My intepretation is
> GPA was part of TDX MEM.IMPORT workflow and required, but now since you
> proposed gmem for indexing pages, maybe I was wrong.  In this case, I'd be
> more than happy if I was wrong..

Yes GPAs are part of the MAC generated by tdh_export_mem() so cannot change
for import. This can be seen at the TDX module source at [0] below.

What if we add a flag for the memory functions to describe the type of
addressing used?

[0] https://github.com/intel/confidential-computing.tdx.tdx-module/blob/tdx_1.5/src/vmm_dispatcher/migration_api_calls/tdh_export_mem.c#L1083
