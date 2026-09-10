Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8583C988E
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022008; cv=none; b=TOV3y40baU6q3FwlyoIR1R9687wamFiNiv95PJAG56ei6mvjd7BjHqY0V+kbWemu/evtpjmGbe2wN4T/XTGQOaWelMss1yZTlJXWvebMkGZidHAFS+Ujed2Me/LqKp5tUKNVVVa6/Ncz6YtPnWDEv5S7HqA/ghOJC3QUohgOb8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022008; c=relaxed/simple;
	bh=iWtx87iI3hY2QjLKAiF3jW7t4gEKXt5rGZP0Tjwpmno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfoaClWM4OwSEFJMc2OjWbgWvTPXiuxvaFa34/OmwmC9+BFe65sOWuqIAVxCi3Yn8+VVh1SbMoDrzUSHNtDMGenSDwzyj0qdVl1O7TAOkJ4/FDUodl+EvatRIITdKpHgi4DtrsWxPOcBtc5R5tVYeL5r89UkSapl0SdCZo8xs7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nuzNuuZo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nuzNuuZo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789022006; x=1820558006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iWtx87iI3hY2QjLKAiF3jW7t4gEKXt5rGZP0Tjwpmno=;
  b=nuzNuuZopFOXVLnmajTCaWJq020lTJl4NamLgml/xNFnh465Vfj5QIh/
   DW4gzfXAD9pThW2TLDgHvN4jgD78CFl8yoZEPmwcAlfrCb4ZGNf3/oBG1
   VsHPp9ggzVkqNsSTD0ypRLX27k0aQazaiBBKVG2tvosrWR/Mce/LddyaM
   CEW8cC+rdeZMDZYQsIf9gS/8zM0kkJym3FE8pBIvdRSV6BwZnLexYu+Ey
   0qmuzTiYyHgXW8SzrK+KrU7d789OHbSsbdJAGqug+o3ddLpv4/VrTzGtL
   xDcsfmNQq592BTWKpCcovqVa4YrzbXIiaQwK3Auk5LBDPH6nJROvhnrvm
   g==;
X-CSE-ConnectionGUID: PRFuygOARA6gZPkdKsbaIA==
X-CSE-MsgGUID: mb4GxzNOSo2jSbu4ONjRmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="112234882"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="112234882"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:33:26 -0700
X-CSE-ConnectionGUID: dkjSj9V0QbiMjt2o8L8yyg==
X-CSE-MsgGUID: 51Iy/gK5Ra2Yw08vk3z91A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="275685157"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.146])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:33:19 -0700
Date: Thu, 10 Sep 2026 09:33:16 +0300
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
Message-ID: <aqJPLEX51DSCF1zC@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ap6loazXtvSCqmpR@tlindgre-MOBL1>
 <ap64dFXpiDb_Hqxl@8bytes.org>
 <d25d652c34dedc209ccb3b758e7f624b9125eee5.camel@gmail.com>
 <ap-SihGd0fk02QV8@tlindgre-MOBL1>
 <4c07e70e-7639-4141-b602-1c09c9c7510c@intel.com>
 <aqEDQ5Qrv724gGzN@tlindgre-MOBL1>
 <0cf5b79e-521d-4c7c-97f2-673c51d42bbd@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cf5b79e-521d-4c7c-97f2-673c51d42bbd@intel.com>

On Wed, Sep 09, 2026 at 06:11:11PM -0700, Kishen Maloor wrote:
> On 9/8/26 11:57 PM, Tony Lindgren wrote:
> > On Tue, Sep 08, 2026 at 05:22:30PM -0700, Kishen Maloor wrote:
> >> On 9/7/26 9:43 PM, Tony Lindgren wrote:
> >>> On Mon, Sep 07, 2026 at 04:32:33PM +0300, Artem Bityutskiy wrote:
> >>>> On Mon, 2026-09-07 at 15:15 +0200, Jörg Rödel wrote:
> >>>>> The direction is always the same over a single live migration session, right?
> >>>>> So it could be a setup flag, on the other hand having separate KVM_EXPORT_CMD
> >>>>> and KVM_IMPORT_CMD seems to be a cleaner ABI.
> >>>
> >>> OK
> >>
> >>
> >> Just sharing an alternate point of view:
> >>
> >> The roles are fixed over a migration session. A split ABI is certainly more 
> >> self-describing, but it restates that invariant on every call, and therefore 
> >> also permits it to be contradicted -- a failure mode that does not otherwise
> >> exist. With a single KVM_MIGRATE_CMD and a per-session role recorded once (more 
> >> on that below), there is no need for per-call policing: the role could be 
> >> checked once when the session is established.
> > 
> > There are two occasions the role is set or changed. On starting the
> > destination the incoming role needs to configured at least for TDX.
> > And then after the migration, the role changes if re-migrated.
> 
> A destination TD needs a directive to not initialize the TD and its vCPUs.
> It comes from its launch parameters (e.g. QEMU cmdline) which selects the
> delayed_init path. That is a construction directive though, and it applies
> only to a destination -- a source needs nothing at init. A session role is
> symmetric and is what the transfer calls consume, so I don't think the two
> need to be the same thing.

Yes the source vs destination role is there from the start for sure. And
changes on re-migration. Could be set in different ways.
 
> > I don't think there are other cases for role change, maybe cancelled
> > migration could require that for some hardware possibly.
> 
> Architecturally, per-session scoping of migration roles should be
> straightforward with any platform: each side asserts a role at the start of every 
> migration session and vendor code will either accept or reject the stated role.

Agreed.
 
> >> Along these lines: it raises a question of whether the MEMORY and VCPU
> >> calls should be coalesced as well into KVM_MIGRATE_MEMORY and KVM_MIGRATE_VCPU.
> >> As posted, direction is implicit for KVM_MIGRATE_CMD but encoded in the ioctl
> >> number for those transfers, so collapsing them would at least make the uAPI
> >> consistent about where direction comes from, and free two ioctls.
> > 
> > Using naming KVM_TRANSFER_MEMORY and KVM_TRANSFER_VCPU might be more
> > descriptive?
> > 
> > Eventually these same commands could be used to save the state to disk
> > for power management use.
> 
> Sure, and the save-to-disk case is a good argument for a more generic name.
> 
> > And going back to the dmaengine like analogy of what is being done..
> > 
> > The transfer direction flags could be KVM_TRANSFER_FROM_GUEST and
> > KVM_TRANSFER_TO_GUEST?
> 
> FROM_GUEST/TO_GUEST still encodes direction per call, which is the open
> question above. If direction is a per-session property, then KVM_TRANSFER_MEMORY
> and KVM_TRANSFER_VCPU are sufficient on their own -- no direction flag, and no
> separate export/import ioctls.
> 
> And if we settle on a per-session property, then SETUP could conceivably state a
> role for a non-migration transfer session as well.
> 
> >   
> >>>> For direction specifically, we could pass it to KVM on every call and let
> >>>> KVM stay stateless about it, or KVM could record it once and remember it for
> >>>> the rest of the session.
> >>>
> >>> Yes the "record and remember" is another option, it could be a sub-command
> >>> something like KVM_MIGRATE_DIRECTION.
> >>
> >>
> >> Agreed on record-and-remember, with a refinement on scope.
> >>
> >> A VM that was migrated in can later be migrated out, so the role is not a
> >> property of the VM -- it has to be recorded per session. SETUP is the call
> >> that starts a migration and runs ahead of all other migration calls, so its
> >> arguments look like the natural place for userspace to state the role; a
> >> separate sub-command would need its own scope rules relative to SETUP.
> >> KVM can then ask the vendor layer whether the requested role is permitted for
> >> this VM -- only it knows the confidential-VM state -- and on success record it
> >> in generic KVM state, where it then selects the export or import callbacks.
> > 
> > The role can change, but it can be VM specific for starting the migration
> > destination even before migration is started.
> > 
> > At least for TDX we need to specify direction for migration destination on
> > init to prevent fully initializing the TD and vCPUs.
> 
> As mentioned above, that is a destination launch time directive that we needn't
> conflate with a migration/transfer session role.

It's still the same role though. Yes we can set it on init, but would
be nice to have some generic way to do it for qemu -incoming.

Just brainstorming.. I wonder if we need two things though. A source vs
destination role. And then at some point possibly later on also a data
transfer direction enumeration similar to what Linux has in
include/linux/dma-direction.h.

We already need to make use of the QEMU return-path for the migration key
exchange. What if some hardware needs to make use of KVM_TRANSFER_MEMORY
from source to destination, and after that back from destination to source
to ack the transfer? Sure this is just speculation, I'm not aware of this
need right now.

In any case with handling the source vs destination role, the enumeration
for data direction can be added to the transfer flags later on as needed.
No need to try to stuff the data direction flag there until really needed.
