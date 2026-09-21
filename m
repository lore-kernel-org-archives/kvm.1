Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7540B282F3F
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973575; cv=none; b=AN0brBb6wo33RFP1JEvNEh1fgTr/+TIq3xcdwDgoLt5HzXZMJy+4W2mhoVc/rQuBYtmh4NIi3IX9fv3LRju8qW09ZLHUqOZ4qj9O4fd0qQhgTKPpz+lXCkQiBkccg2LNdpKNVgTnm9rrqvZ01kcm2Z8aSMiSs48aOTHNiGIWKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973575; c=relaxed/simple;
	bh=jTPDfssEaB19bppgBlEI9plfA/WUsD1mFQCWUnMhIy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTgnp0OwSiFP7DCNQPwae84aiesLulgv9VopvfAuLNYtU8xMgtLD3JxI+rQ+wbtu2UK32+YaTvlYUfufN2Ew2Zdsavk2oSkW8h6PKwGpd5zRsQDvBFBN//q6mmzLiq57kg74Sc0PZ4xhrF25FrVMjMO3JAj0U6lO2Nbuomv6tbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mugHUrHq; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mugHUrHq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789973574; x=1821509574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jTPDfssEaB19bppgBlEI9plfA/WUsD1mFQCWUnMhIy0=;
  b=mugHUrHqxpjidzbinGMeWMcLf3nLR2N6DLQ5n0AQJtClY/GtRY+bF4Zn
   0wauuu+8rSB+lJONLcDXm0PAevRmV6vN6OFkXbx3QLtMkBuINhfnpKJ1z
   DOflvBdF4LfbOnXf8wv0mcdmn0BR4LcgMd3Fy43McO19vFC320hTfqwZk
   zGR8xg1h4BOg1xElG5ZKpexubpPckQyJemDm2d/xDPMzeDY3f/q4adtS9
   Wsldm6iE7Mn9lh34Rc3aMJ/XYLlxijSLS+toa0CmLaHrysvzB/DAhWrww
   RFxYIM7JQhAKTG3/85dGng0EBk7nSRFgH8Co8PSuLgdoN5aON4mh2dJAV
   g==;
X-CSE-ConnectionGUID: oA4Bah8YTwKQRXMUV7YASg==
X-CSE-MsgGUID: YUeETERWQUuW1SLFl331aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="975419"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="975419"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 23:52:53 -0700
X-CSE-ConnectionGUID: TyGRBlgSRzqirq4LoGwVEw==
X-CSE-MsgGUID: hpcRNQY9TCeRW1TNqGyLvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3561387"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.168])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 23:52:45 -0700
Date: Mon, 21 Sep 2026 09:52:42 +0300
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
Message-ID: <arDUOl2WPKRxwrZW@tlindgre-MOBL1>
References: <aqOCPVoFAFMv8ZYo@tlindgre-MOBL1>
 <085c28db-31e3-4249-a9be-a2f9d7156719@intel.com>
 <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
 <e090caa0-be97-46cd-bde8-374f2522c986@intel.com>
 <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
 <3ee06a84-2c4b-4b2f-9899-68fc92b6daf7@intel.com>
 <aquL7kNJsjnY0mJ4@tlindgre-MOBL1>
 <b5906521-858b-487b-a262-7a86891a0731@intel.com>
 <aqzS_mCOT6YuHKxN@tlindgre-MOBL1>
 <e2f8b93a-fd42-4ee6-8b74-759d3052258a@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2f8b93a-fd42-4ee6-8b74-759d3052258a@intel.com>

On Sun, Sep 20, 2026 at 05:13:10PM -0700, Kishen Maloor wrote:
> On 9/17/26 10:58 PM, Tony Lindgren wrote:
> > On Thu, Sep 17, 2026 at 09:32:23PM -0700, Kishen Maloor wrote:
> >> On 9/16/26 11:42 PM, Tony Lindgren wrote:
> >>> On Wed, Sep 16, 2026 at 08:31:32PM -0700, Kishen Maloor wrote:
> >>>> On 9/15/26 10:09 PM, Tony Lindgren wrote:
> >>>>> So trying to summarize the common flags for the role and separate vendor
> >>>>> flags:
> >>>>>
> >>>>> struct kvm_migrate_cmd {
> >>>>> 	__u16 command;
> >>>>> 	__u16 flags;
> >>>>> 	__u16 vflags;
> >>>>> 	__u16 reserved;
> >>>>> 	__u32 reserved;
> >>>>> 	struct kvm_transfer_buffer buf;
> >>>>> };
> >>>>>
> >>>>> Is the above along the lines what you were thinking?
> >>>>
> >>>> No, I was suggesting a 'role' field carved out of the 'reserved' space,
> >>>> like this:
> >>>>
> >>>> struct kvm_migrate_cmd {
> >>>>       __u16 command;
> >>>>       __u16 flags;
> >>>>       __u8  role;     /* 0 = unset, 1 = source, 2 = destination */
> >>>>       __u8  reserved[3];
> >>>>       struct kvm_transfer_buffer buf;
> >>>> };
> >>>
> >>> OK yes thanks for clarifying, that works for me.
> >>>  
> >>>>> Ah OK, yes that would also tell "the hardware has been initialized to a
> >>>>> certain migration role". That seems like a usable common feature.
> >>>>
> >>>> Not quite. It tells us that userspace asserted a role for this VM's migration
> >>>> session. Whether a TD was created for import is a separate, vendor-level detail.
> >>>> The generic layer only needs the role to reject a session that never stated one,
> >>>> and to pick the export or import callback. That callback then knows which side
> >>>> it's on and can reject an incorrect role (e.g., if SETUP asserted dst for a src TD).
> >>>
> >>> That's a good point, the hardware role may not be set yet.
> >>>
> >>> I'm still wondering if there is a need to stash the userspace set role in
> >>> KVM though. Likely only the hardware specific code can properly track the
> >>> state of the hardware and adjust to the userspace requests. Seems just
> >>> being able to pass the role in struct kvm_migrate_cmd should be enough?
> >>
> >> Passing it in kvm_migrate_cmd is enough for SETUP itself, but the commands
> >> after SETUP like memory/vcpu transfers still have to reach the right
> >> callback. So KVM would need to remember what was asserted so that the
> >> generic layer can dispatch to the export or import facing callbacks.
> >> We've been sketching (on this thread) an alternative UAPI set
> >> (3 vs 5 ioctls) for consideration which this stored role enables:
> >>
> >> Proposed in the RFC              Alternative
> >> KVM_MIGRATE_CMD                  KVM_MIGRATE_CMD
> >> KVM_EXPORT_MEMORY                 
> >> KVM_IMPORT_MEMORY                KVM_TRANSFER_MEMORY       
> >> KVM_EXPORT_VCPU
> >> KVM_IMPORT_VCPU                  KVM_TRANSFER_VCPU
> >>
> >> It's just a record (1 byte) of what userspace asserted for the current session 
> >> at SETUP. Vendor code still owns the hardware state and remains free to reject a 
> >> role that doesn't match it. It is also what lets the generic layer reject a 
> >> command to a VM that never set up a session.
> > 
> > For the TRANSFER style operations, I would assume the direction is passed
> > for each transfer, just like the Linux does for the dmaengine. It's
> > possible that there may be transfers going both directions without the
> > role changing.
> > 
> > So looks like we have tree things to consider: userspace set migration
> > role, the hardware state, and transfer direction.
> 
> Two of those three I agree with: userspace passes the role at SETUP, and
> the vendor implementation tracks the hardware state. It's the per-transfer
> direction I don't think we need.

Ack on the userspace passing the role at SETUP and vendor implementation
tracking the hardware state.

Then for KVM tracking the role, I don't think we need it with the two
above. The role tracking can always be added if really needed. Any other
opinions on this one?

The transfer direction is there with the EXPORT/IMPORT naming. Maybe
just let's keep that naming for easier readability rather than try to 
switch to TRANSFER style naming. No transfer direction flag needed.

> > What if userspace always passes the role and transfer direction where it
> > makes sense? And then the hardware specific implementation tracks the
> > hardware state?
> 
> Unless there's another meaning, direction would indicate that an operation
> must produce or consume a blob into/from a buffer. Such an indication would be
> necessary if the layer below the API cannot know what to do with a buffer,
> which may well be the case in your dmaengine analogy. However, in this case a
> vendor implementation sits below the generic layer and could derive what it
> needs to do from the role, command, and any session state it maintains. The
> TDH.EXPORT.ABORT example I cited upthread expects a token only once the
> session has left its pre-copy phase, so what to do with the buffer follows
> from state the vendor layer already holds.

Yeah I don't think the dmaengine API ever expects to get back a blob as a
result of an outgoing transfer.. That would be a separate DMA transfer. 
 
> The gap I do see is in how the buffer itself is described: we have no way to
> express a command that takes an input and produces an output. A direction flag
> doesn't help there either, since it can only say one thing. My comments on patch 2
> suggest a new 'capacity' field alongside a reframing of 'size' in kvm_transfer_buffer,
> where capacity bounds what the kernel may write and size reports what is actually
> there. That covers the both-ways case, and it also leaves nothing for a direction
> field to convey. Maybe that addresses your concern?

Yes that's a good point, a transfer command may also return data in the
transfer buffer and the size of returned data needs to be known. Replied
to your patch #2 comments with some ideas on it.
