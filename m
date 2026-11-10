Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287810;
	b=kN2WxbXKv0bQcgJrYR/NkIvPksZ9HRfw0AMznqoXOjG7lw/bAnBzGZtT6/3PV4J2pjvi
	 lkFO8ANM47R3Jzsm9YUUr43mzWSrJwYTYU/5cfXM3IbnbYRl89QigQaHNO026/rHLPtB6
	 TIOKawc6IE5KnDnN6VsPjNX2yF5WtF81RVOo4KZjJu9KRBgFufPqH6+ryUMqBophMjF2H
	 h9EJOwbEJeusYeC2/8rHC3AGeR7MgN2ZUSSLALO083+yORHkQ2KPqW5Qupv6rcPeXW/cP
	 hxnBIhSbYil5XDmQdmp3HvZkDE8E1QXjwJGC2cn1qkQ/XZbOSD1/051o+l4ogiUoQZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287810;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=4/nfkGQBu5KSWivhAQOet9GrZ8o9njJFE99m/pz7QN4=;
	b=PFus/GNdhA60/ajISekrZQCuOpZb1IJfm+M7ZpY1PQVAzltL42NWvmfw+W6B7Es996PA
	 AZ68hag1csANe7C2MImbAsMpj4NxfYRBlAs+1yl0wg8Dc/8MTseqW+Brsv7rtaI11X6UP
	 8Z4o4KeHyPh6xhZVZvFRvqtPEDNvXEOME3fN6CqpJdvA2/fxdzu8sbwNZYR11neDICcs8
	 qQ5ssRK+eEDNEQ0X04aqT9FhIcohF8m7CwUadq7MCQPYWxHKrJekH7cDpdNGNUb0z/vC0
	 cCUh1uEbXkpM3GON1UevStjx/xXfxC/StlMbfYB1k6vKq1uQJHxUSlGuNr+iT3/cR0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AqhCKZ2d;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C29606A321
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 05:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8C29606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AqhCKZ2d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794287809; x=1825823809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=p4O4GdlJfGDIXIXY0gm97ZySDZdgE24htA+wTQdqa5o=;
  b=AqhCKZ2djYNR4X3fZbhwoXPrNfCXn9Bm82Tyra1GUB/sAbih1xIAVtUI
   9/SV38RXwtU9C2BTsiI+SK1YnsMi4b2hs+4QBNNjCXvsn6n4mXT+2O8Nu
   cbG4fNrSzBMPxK9rvM9y66WBn7Uc7CGiEn16GIHxjLrjZRHmHzZ7rhIiu
   jsDhjRzIDzB8rtOKpLBr6c+JoiYsG15UPuCmnIjygVxJSG345ut7NhwPC
   YAQqhpnMx+8kvTq307+/PuUmbuGO1TThncmfNV08uq0bnaMmdetG8C8Xb
   KDap7NlI55mw3CDIw8qHLRB3pBN68VOHf9U+8ZOPebFqRQ5Pa73eIT9om
   w==;
X-CSE-ConnectionGUID: w7e9oPc6ShiFKi5dRmWOqg==
X-CSE-MsgGUID: mvJm+/R6SEqtBJB8WcRUGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2928066"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2928066"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 21:16:20 -0800
X-CSE-ConnectionGUID: ZMMNINYhSGe8SPmhWKPbdw==
X-CSE-MsgGUID: x0Ml0elmSm+U1+T+BPTwhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7911534"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 21:16:10 -0800
Date: Tue, 10 Nov 2026 07:16:06 +0200
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: "Serge Hallyn (AMD)" <sergeh@kernel.org>
Cc: Kishen Maloor <kishen.maloor@intel.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	David.Kaplan@amd.com, Mathias.Brossard@arm.com, tycho@kernel.org,
	"Adam, Mahmoud" <Mahmoud.Adam@amd.com>
Subject: Re: TDX migration model
Message-ID: <avKolvbIuZj-aLD-@tlindgre-MOBL1>
References: <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f4f34bc3dd22c0e47b5ee764b1a4db8940cbbbec.camel@gmail.com>
 <auyZnIfxMnxYD8rT@shallyn-amd>
 <85f899cd277b2188cd4b33f8f21b206fa2ff6f6f.camel@gmail.com>
 <auyx8C67zCnbPpuL@hallyn.com>
 <c77156d1-5a47-4a93-a18b-392081fad3ff@intel.com>
 <avF6DcmdoGeWeRxg@tlindgre-MOBL1>
 <avJGEYIohYUN9l10@shallyn-amd>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avJGEYIohYUN9l10@shallyn-amd>

On Mon, Nov 09, 2026 at 04:15:45PM -0600, Serge Hallyn (AMD) wrote:
> (Adding Tycho and Mahmoud, who will be working with me on this)
> 
> On Mon, Nov 09, 2026 at 09:45:17AM +0200, Tony Lindgren wrote:
> > On Thu, Nov 05, 2026 at 06:00:41PM -0800, Kishen Maloor wrote:
> > > On 11/5/26 8:42 AM, Serge E. Hallyn wrote:
> > > > On Thu, Nov 05, 2026 at 05:59:01PM +0200, Artem Bityutskiy wrote:
> > > >> On Thu, 2026-11-05 at 08:58 -0600, Serge Hallyn (AMD) wrote:
> > > >>> ...
> > > >>> So, looking at the section '### How the Setup Session Works', is it safe
> > > >>> to assume that you are using the qemu migration fd for the message
> > > >>> transfers?  So basically qemu loops over KVM_MIGRATE_SETUP calls, which
> > > >>> ...
> > > >> Yes, that's the flow. I’m not sure about the migration fd part, I believe we
> > > >> pass the setup session data via ioctl buffers. I am sure Kishen will can
> > > >> clarify.
> > > > 
> > > > If you mean pass via ioctl buffers from tdx->kvm-> back to qemu, which passes
> > > > it over the migration fd to the other side, then that's what I expected.
> > > > Othewise I'll be interested to the details :)
> > > 
> > > Hi Serge,
> > > 
> > > Your understanding is right. Migration setup requires a handshake of some sort
> > > between the source and destination. So the messages KVM_MIGRATE_SETUP returns
> > > are transferred over QEMU's migration channel to the other side and processed
> > > by a matching call.
> > 
> > Serge, on the QEMU side, we have been enabling the return-path early for
> > the key exchange before migration is active. Not sure if the key exchange
> > can be done using a VMState, possibly could be if we can ensure it happens
> > before the migration is active.
> 
> Key exchange requires bidirectional communication, so I don't think a
> VMState would work, at least not on its own. If the destination's
> info got send to the source out of band and delivered through migrate
> command option, that could work, but it seems much nicer to me if it's
> all done more transparently.  OTOH if this simplifies the qemu code
> enough, maybe it's worth it.

Yeah agreed and can be revisited.
 
> > For the migration related commands, looks like we can just make the
> > KVM_EXPORT_CMD and KVM_IMPORT_CMD subcommands a bit more finer grained and
> > then drop the vendor flags until needed:
> > 
> > #define KVM_MIGRATE_EXCHANGE_KEYS	0 (New, was KVM_MIGRATE_SETUP and a flag)
> 
> We are currently looking at a couple of messages back and forth during the
> setup negotiation, to accomplish both key exchange and verification of
> attestation reports.  I was actually just using KVM_MIGRATE_SETUP with
> flags for that.  Maybe KVM_MIGRATE_EXCHANGE_KEYS could be renamed to
> KVM_MIGRATE_NEGOTIATE?  Flags aren't strictly needed, if the
> KVM_MIGRATE_NEGOTIATE ioctl will be repeated depending on the return
> value.

OK geat, KVM_MIGRATE_NEGOTIATE sounds good to me.

> > #define KVM_MIGRATE_SETUP		1 (Migrates the immutable state)
> > #define KVM_MIGRATE_ITERATION		2 (Start a new pre-copy round)
> > #define KVM_MIGRATE_ITERATION_FINAL	3 (New, last pre-copy round before pause)
> > #define KVM_MIGRATE_PAUSE		4 (New, split from old STOP_AND_COPY)
> > #define KVM_MIGRATE_MUTABLE_STATE	5 (New, split from old STOP_AND_COPY)
> > #define KVM_MIGRATE_START_DESTINATION	6 (New, split from old STOP_AND_COPY)
> > #define KVM_MIGRATE_START_POSTCOPY	7 (New, could return -EOPNOTSUPP for now?)
> > #define KVM_MIGRATE_ABORT		8
> > #define KVM_MIGRATE_END			9
> > 
> > For the above PAUSE is four the source only. START_DESTINATION is for both
> > source and destination as source exports a start token for the destination.
> > START_POSTCOPY is not implemented but would be destination only when
> > implemented. ABORT is allowed at any point.
> > 
> > Any other subcommands needed at this point?
> 
> Not absolutely certain, but it looks like this might be complete.

OK thanks for checking. Might make sense to allocate a range of numbers
for each of the live migration phases.

And instead of the flags, we could add a range also for vendor specific
subcommands if/when needed.

Sounds like the subcommands should be u64 from the start.
 
> > Then for handling the results, the following seems to simplify things a bit:
> > 
> > - Results are copied back only on success, vendor error is returned as is
> > 
> > - Import is all or nothing, vendor code resumes on interruptions
> > 
> > - For memory transfer, a GFN can only be transferred once per round,
> >   duplicate import attempt returns -EINVAL
> 
> Hm, does the platform independent code need to worry about this?

At least so far we've had the vendor code manage to handle the busy
interruptions for TDX no problem so either success or error can be
returned.

For the duplicate GFNs, the TDX module will produce an error and Peter
asked about that earlier so seems like a good policy to establish.
