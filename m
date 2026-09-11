Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B6353A71
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 04:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789100619; cv=none; b=Cwr3ijV6flu+iWpN6D6LfjMs1922xRgMi9gINMtfKgq8qMqbwvy9QR3wQ1zTvc4y/duqqPwXn0eSRj5FFOOwmy0phCNd1uL8D7VRzdyir1abVGQN6bZNPxamYyS5O3VN9UuZLQ9zXVoEvWkcrDbc6yaF7G2iS63RpscVgn3Pbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789100619; c=relaxed/simple;
	bh=So+5Ctl6gocLk0GPLDgBmcFeH0F2hJcGVy/VqGIpxxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luahUcYwdKCiOStAvQbGE5h8x2XWlPIWQ4HFf8GBWQfgvJOZtkEV+x+adspNvceS7LbDRfjvXRTaSz5Ox34H/2LvOHHtKVSEVXqfWnJIZESDi6p9C0+KS6wYqbOkklW+58fYQyeFGxfzbK9pmlHkGNUDjsjYCkBuh/vhTNCE6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqmyQieE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqmyQieE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789100618; x=1820636618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=So+5Ctl6gocLk0GPLDgBmcFeH0F2hJcGVy/VqGIpxxg=;
  b=EqmyQieEQ/ghRGZb7KnpvXzl46uXpXJMmRCg9Fhb8ztmzfcQyf0eVRCO
   QfMHqE0p6etw2qoOMbEGUoR+fuNov4jKviggDLLtjlHqa+jKNTK6qLv3k
   fDKqpZvlERZE2wrkggW2F20wi0oTkM+RR2nlk/oa1lwDzWkiJKpgyv/aH
   HUU0cH3cE7HF1k7pj/d2Rknrgk+z+ScGztmw05vrYEH6pdnWAMpYPSJ7V
   dzp6vBxASlc1gukoI1jvAFL4KXKEJH+PHTtG5DksNtSdhecksKFm59QH2
   ocCivDzdW9l3Gd/rl5V1qzXAZ0POOxuJ0Dut+a0dxkAi8OMglqPd2ZlYQ
   Q==;
X-CSE-ConnectionGUID: Y6Ze/4S6QJemMZ7KSFI/2Q==
X-CSE-MsgGUID: SxlvpF5LSQe4jEzHun8BQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="112333768"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="112333768"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 21:23:37 -0700
X-CSE-ConnectionGUID: o0TqcZDeROexlek1J9BMTQ==
X-CSE-MsgGUID: F62moAh3Qt6uSgQliMfDqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="277060570"
Received: from wgawrons-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.183])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 21:23:29 -0700
Date: Fri, 11 Sep 2026 07:23:25 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
	Jon Grimm <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
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
Message-ID: <aqOCPVoFAFMv8ZYo@tlindgre-MOBL1>
References: <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ap6loazXtvSCqmpR@tlindgre-MOBL1>
 <ap64dFXpiDb_Hqxl@8bytes.org>
 <d25d652c34dedc209ccb3b758e7f624b9125eee5.camel@gmail.com>
 <ap-SihGd0fk02QV8@tlindgre-MOBL1>
 <4c07e70e-7639-4141-b602-1c09c9c7510c@intel.com>
 <aqEDQ5Qrv724gGzN@tlindgre-MOBL1>
 <0cf5b79e-521d-4c7c-97f2-673c51d42bbd@intel.com>
 <aqJPLEX51DSCF1zC@tlindgre-MOBL1>
 <be09b02d-c993-40ad-a690-753a7a50677c@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be09b02d-c993-40ad-a690-753a7a50677c@intel.com>

On Thu, Sep 10, 2026 at 06:40:04PM -0700, Kishen Maloor wrote:
> On 9/9/26 11:33 PM, Tony Lindgren wrote:
> > On Wed, Sep 09, 2026 at 06:11:11PM -0700, Kishen Maloor wrote:
> > ...
> >>
> >> As mentioned above, that is a destination launch time directive that we needn't
> >> conflate with a migration/transfer session role.
> > 
> > It's still the same role though. Yes we can set it on init, but would
> > be nice to have some generic way to do it for qemu -incoming.
> 
> I'd separate these.
> 
> On the role: it seems we agree on recording roles per-session. My only point
> then is that a VM created through the delayed_init flow doesn't additionally
> need a destination role recorded for it if SETUP will assert one when the
> migration is kicked off.
> 
> On generic plumbing for -incoming: is this about KVM_TDX_INIT_VM_F_DELAY_INIT?
> A generic mechanism would make sense to me if the flag were consumed by generic
> KVM code, but that isn't the case here. Userspace has to make a
> vendor-specific VM-init call like KVM_TDX_INIT_VM anyway, with the flag passed
> on that call. So I'm not sure what a generic version would add, unless you have
> something else in mind.

So we could add a SETUP subcommand SET_ROLE or SET_INCOMING. The
implementation could store the role at least initially. And if we want to
set the role with KVM_TDX_INIT_VM, we could recycle the role bit there.

> > Just brainstorming.. I wonder if we need two things though. A source vs
> > destination role. And then at some point possibly later on also a data
> > transfer direction enumeration similar to what Linux has in
> > include/linux/dma-direction.h.
> > 
> > We already need to make use of the QEMU return-path for the migration key
> > exchange. What if some hardware needs to make use of KVM_TRANSFER_MEMORY
> > from source to destination, and after that back from destination to source
> > to ack the transfer? Sure this is just speculation, I'm not aware of this
> > need right now.
> > 
> > In any case with handling the source vs destination role, the enumeration
> > for data direction can be added to the transfer flags later on as needed.
> > No need to try to stuff the data direction flag there until really needed.
> 
> Agree on deferring such an enumeration. More generally though, the session
> role determines which operations are permitted, and it seems like vendor code
> could be expected to handle those in context.
> 
> The TDX architecture already has a destination-to-source example:
> TDH.IMPORT.ABORT emits an abort token on the destination that
> TDH.EXPORT.ABORT consumes on the source. So KVM on the source would dispatch
> to its export-abort path and let the vendor layer decide what to do with
> the buffer. This doesn't require a direction flag.

Yes agreed with the role we can handle migration related transfers both
ways at least for TDX.
