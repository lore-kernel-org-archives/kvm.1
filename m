Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B736F901
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746829; cv=none; b=W2mLr2+CWIf3a6oyjafJMi45zl91LeOh5M6kVIVWBBK0G0m+GT0qtUoFPDZ4SIe8XjohqbPOTbHbZ+ccIkIn+XA0K4MUATHyGKLrk22PUIHY4w5KWsHq/1x+XgWa6O9lHRE+sQogLl+ysK+qjL69tJ1qgEJ5V5IuyHscn9c+YTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746829; c=relaxed/simple;
	bh=ezbTNjFlHLK3lNxSr8rj8/dxXRIIguvuSJhMZwuegCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmos2HqprcDIvSlSPldSySEWYrV8fdxOcBnuMLwWU0mjXF+YkIhDmd12THkspUWtPHJKQCh5Y/dW7HLoNAihfupO1+e4KwkJmH21MbcjT6adGVfmPU5AtHoWyf4Fv6C57N1e7nBAFyzQZh8zFFiPDejNGpCBKfacYr79ARovFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxV/MeOs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sBQpcxXu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxV/MeOs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sBQpcxXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789746825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UResCZ9OzK7oWswN7AjR3J3W8LAWr505DjUezablpNc=;
	b=WxV/MeOsU1TvJ2Vap8SIBaZmlnqG7CPO7zA2qnQa8t9n3BKxIkfHxewAff9mj7NjkpNGHt
	l+s2U5PFcIAcNzUuxxxK5GtnZ/AjS1frpxF6il49BgSDIEnVqF6m36wJVv451GAEjI16uT
	PNWBdhqNVN14kKpDmTkHLf/SUbDNi94=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-Lnykreo2PJa8f9mZLMCkrg-1; Fri, 18 Sep 2026 11:53:44 -0400
X-MC-Unique: Lnykreo2PJa8f9mZLMCkrg-1
X-Mimecast-MFC-AGG-ID: Lnykreo2PJa8f9mZLMCkrg_1789746824
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90e7f98bcb9so18182166d6.1
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789746824; x=1790351624; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UResCZ9OzK7oWswN7AjR3J3W8LAWr505DjUezablpNc=;
        b=sBQpcxXucz05AdguG0wQkYiq0zSRGDeuDBOk4c7igtoy7VK9WvbRhqnUn8+q3I1FAV
         DWivpqqVK8tKkkfTi4AC8QKBch2NCi+/LKutH4AsXRjGpowBK0ooiJr56frb53OD21y5
         2IBW+yguH9CIF7XuB+F35eORmD/Tdn2wyZnn7Z4zGeHbh2ts5t4H/h1OXzkaA+1R3cfb
         dP/+wREBVS26LnI5vIO+GjLxYu7dGQdZcq4qzk5EVk6NcttMWpW+APAQaPW3c6qTlo3+
         X+wDX/UuYw959B/SGrNGvdrECdsvCj1fhFFHhxquIJLq/dV5AyaHKs56xPXjF4SLNA7x
         K3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789746824; x=1790351624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UResCZ9OzK7oWswN7AjR3J3W8LAWr505DjUezablpNc=;
        b=n0zhfcYM8IevQCd05Bae13/vmuXYBFLrUKIEnx6pfjFeE9CcEZRVjEpV0GYvg9ii5J
         0/8ufIPrJTTvTr2SPHzf9G6Rnrnt/eSASfRq086wwqs7dusCIqch9reEVZM906gXhAJp
         ohSYKuXNyvIfXm7DZ4QU86SL3O9N3+hndRtaSUqNXOMDCLmAr30ILP4uffXZx3YzObT3
         5KPAnAHmUbpqdJjYK2ws/emAtX25ZyzTDHGHTR4Q6E2vhDMiqoxauqKs4JHUpO6gOirb
         qZtBcSXttOOIycIdCAQQxQoi7935pmRf+tbhwrCdxsgVMT+we7qXvDc5Ak96PuqFjQ0z
         8wgw==
X-Forwarded-Encrypted: i=1; AKwUvBwyd8dg/N+FPtHy5VNGE6r3eT65D+A5JUHriYH89/qscM7GNvfcrMYjtto7GVu70//i8b8=@vger.kernel.org
X-Gm-Message-State: AFuF++kQNjlPmTh7QS/jCNqmSHSSGyOQSRwv1Mf+btC+wEDnDCXp9OXA
	8vRqmtfywkAoApK8qU39co9Gc/+rtrEuvzsUWU+fcOewMDHW3zLKVnyhGZwviR52dQ9DhTNhLl4
	ER2J15633o/zayZ+uhIWa+3migCnVWIHpGeBmCz0rC3PR1QgbSoG3/A==
X-Gm-Gg: AYBFou13VxGlUJAdPdqz/Qh62yC41iMjo3f9QWCzqBNujnLUddQAE1psjwOHYohNbqU
	sLaUCavumvElGlGlJtvI5ZQRd5ZCNJ6/xZZkXAwQTpHljzp7UqbliXpJpDIGjd/DuxiTs6++rFO
	7xRQqMCSMqIN4g6N2tS3/bpGAE8mi/+PCEIZJqkzj7GE+AP+qstG7jDhO3VFOn/5EnC5QPhnLvf
	l/7P9CgDKLQJ9Nty9PzJtOAJF3TD40q4HYPZuUu/b94qbe/CwacH/tWi1JLM+eEBRa62ncQMDCd
	DMdnPBBvDa9GWxcgmwYxG2hf0iVWPoCzLGFnxNaCCARywYEKlJqpi3r/SdTy8xxln2NEETp9ctq
	TsyvAIsHcwOZOvzXbsPmNJ07ESbRTNO6sKkyYjXjNoHrOJhS4Ffa5Vjz3lhU=
X-Received: by 2002:a05:620a:1729:b0:939:6de6:9516 with SMTP id af79cd13be357-93bdca3ac7emr419754385a.45.1789746823422;
        Fri, 18 Sep 2026 08:53:43 -0700 (PDT)
X-Received: by 2002:a05:620a:1729:b0:939:6de6:9516 with SMTP id af79cd13be357-93bdca3ac7emr419744685a.45.1789746822448;
        Fri, 18 Sep 2026 08:53:42 -0700 (PDT)
Received: from localhost (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0cc8ae4sm171592485a.2.2026.09.18.08.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:53:41 -0700 (PDT)
Date: Fri, 18 Sep 2026 11:53:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>,
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
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Message-ID: <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>

On Fri, Sep 18, 2026 at 03:46:32PM +0300, Artem Bityutskiy wrote:
> Hi Peter,

Hi, Artem,

> 
> thank you for your good comments and questions. A quick disclaimer before I
> address them. In my answers I try to keep three distinct things separate:
> 
> 1. The CoCo migration uAPI - the generic interface we ultimately want to
>    converge on. This is the end goal, not necessarily what these patches
>    propose. What is good for this uAPI is my priority at this point.
> 2. The TDX migration model - the mechanics offered by Intel TDX module for
>    TDX guest live migration today.
> 3. Our PoC - a concrete uAPI proposal and its example implementation for TDX
>    guests.
> 
> On Thu, 2026-09-17 at 17:27 -0400, Peter Xu wrote:
> > > Some example high-level topics that would be nice to get feedback on:
> > > 
> > > - Can we come up with a single set of generic migration uAPIs for different
> > >   CoCo models?
> > > - Or should some uAPIs be generic while others are vendor-specific?
> > > - Or should each CoCo model have its own vendor-specific set of migration
> > >   uAPIs?
> > 
> > It's always good if we can put together as much function to be shared with
> > generic ioctls as possible.  At some point, IMHO we need to collect such
> > information somehow, so when merging the generic API we know what vendor
> > specific API will be needed.  Hopefully this series is a good start.
> 
> Thanks, agreed.
> 
> On that note - does anyone know of a good doc describing the AMD, ARM, or
> other CoCo migration models? My knowledge is limited to TDX, so it is hard
> to tell what is common and what is TDX-specific.
> 
> FYI, I am working on a TDX migration model document. It describes what the
> TDX module offers, but unlike the specs it is oriented towards software
> engineers: much easier to read and it does not require deep TDX knowledge.
> It is all based on public specs, just distilled into readable mental models.
> I plan to publish it publicly. I am about 80% done.

That will be very useful, thanks for doing this. I'll be more than happy to
read it when it's done.  I wonder if we can, after TDX bits done, use this
doc as a base for others to add in theirs in separate tabs, keeping
everything together for the unified migration API work.

Out of pure curiosity, I also don't know where s390 stands; it's almost not
mentioned in the current API plan.

> 
> > > - Should the same uAPIs also support traditional VMs? But the only use-case
> > >   I imagine here is "for testing purposes".
> > 
> > This is an interesting idea, I think this could be useful.  Especially, I
> > wonder if you already have it done and PoC branches you can share, so that
> > I can play with it.
> 
> We do not have code. But Kishen spent time playing with it, and I think he
> concluded not to proceed with this. But he might have evaluated it from
> the "unify all migration into a single generic API" perspective. But may
> be as a "this is a test framework" perspective is different, at least I feel
> it may be the case. I think Kishen can provide more insight if needed, he
> is in CC.

Yes, thanks.  I'm willing to hear more, and I'm a bit surprised that
non-coco migration didn't fit already well into it, because IIUC non-coco
needs less in this case, not more.

> 
> > > 
> > > > Migration flow
> > > > ==============
> > > > 
> > > >  Source host                                      Destination host
> > > >  ===========                                      ================
> > > > 
> > > >  CMD(SETUP/SESSION)          <--- setup msgs ---> CMD(SETUP/SESSION)
> > > >        |    (repeated)                                  |
> > > >  CMD(SETUP/IMMUTABLE_STATE)  - immutable state -> CMD(SETUP/IMMUTABLE_STATE)
> > > >        |                                                |
> > > >  KVM_GET_DIRTY_LOG                                      |
> > > >  KVM_EXPORT_MEMORY           --- memory data ---> KVM_IMPORT_MEMORY
> > > >  CMD(ITERATION)              --- epoch token ---> CMD(ITERATION)
> > 
> > Could you elaborate this ITERATION operation?  Is that something the
> > userapp must do after full scan of a round of guest memory?
> 
> = Why no duplicate instances? =
> 
> First, let me answer the "why" question you asked further below: "why does
> the TDX module require that only the source or only the destination runs,
> never both?". Answering it first makes the tokens easier to understand. And
> the tokens are why we proposed the "ITERATION" operation.
> 
> I believe this is not TDX-specific, it is a confidential computing
> requirement. In short, cloning would give the VMM a very powerful primitive
> to attack confidential VMs. Here are a couple of example attack approaches:
> 
> - When you attest a CoCo VM remotely, you get an assurance that you talk to
>   this one specific instance. If duplication were allowed, many instances
>   could exist, and that assurance is gone.
> - With a clone you can security-upgrade the state of one copy, attest the
>   upgraded state, and then use the pre-upgraded copy: the user believes they
>   are working with an up-to-date CoCo VM, but in fact use an older, possibly
>   vulnerable version.
> 
> This is also why TDX migration requires that not only must the two copies
> never run at the same time, but after migration the destination must be
> exactly the same as the source. For example, the destination must not end up
> using an older copy of a page.
> 
> = ITERATION Operation =
> 
> In the QEMU model, the pre-copy phase is a set of rounds:
> 1. Get the list of dirty pages.
> 2. Copy them to the destination.
> 3. Repeat until the convergence criteria are met.
> 
> ITERATION is the explicit uAPI that ends the current pre-copy round. There
> is no equivalent uAPI for traditional VMs today.
> 
> In the TDX model, ending a round needs an extra step: the source generates
> an epoch token, and the destination imports it. Two seamcalls do this:
> 
> - TDH.EXPORT.TRACK generates the epoch token on the source.
> - TDH.IMPORT.TRACK imports it on the destination.
> 
> The token enforces integrity and ordering, for example:
> 
> - Every page exported on the source must be imported on the destination.
> - Once a newer version of a page is imported, an older version can no longer
>   be imported.
> 
> The final round is special. It uses the "done" flag, which is passed to the
> `TDH.EXPORT.TRACK` seamcall, and makes it export a special variant of the
> epoch token that is called the start token. On top of the integrity and
> ordering guarantees, the start token is what allows the destination to
> start: until the destination imports it, the TDX module will not let the
> destination TD run with partial state.

The methodology on unique VM attestation sounds comlex, but I think I get
it now, thank you.  It'll be nice if some of these reasonings will also be
there in the doc you're drafting.

> 
> > > >        |    (repeat until convergence)                  |
> > > >  CMD(STOP_AND_COPY/PAUSE)                               |
> > > >  CMD(STOP_AND_COPY/TD_STATE) --- VM state ------> CMD(STOP_AND_COPY/TD_STATE)
> > > >  KVM_EXPORT_VCPU             --- vCPU state ----> KVM_IMPORT_VCPU
> > > >  KVM_EXPORT_MEMORY           -- final memory ---> KVM_IMPORT_MEMORY
> > 
> > When read/write encrypted memories, two questions:
> > 
> > - Is there an upper bound of the buffer size per-page?
> 
> So generally, the assumption is that exporting N pages requires M pages,
> M > N, because there may be some metadata (e.g., MACs for integrity
> checks). In case of TDX module, M is predictable and can be calculated in
> advance.

I am just thinking out loud here: if the hardware is good enough to do
encryption plus (some?) compression, that would be very nice.  For "some",
I meant minimum over zero pages.  Because in this case even if host wants
to play tricks with zero pages, it can't anymore when un-readable.  Maybe
the guest driver can play some trick, but I'm also not sure if in CoCo.

M > N may imply it's not the case for now, but it's still sane as a start
even if so.

> 
> I believe in our current PoC, the ioctl requires the buffer size to be large
> enough to hold all the requested pages. But this is specific to our current
> PoC implementation.
> 
> In general, I feel like if buffer size is not enough, the uAPI could fill it
> with as much data as fits, and communicate back about what GPAs were
> exported. The caller could export the rest separately.

Yes, this will work.

Or maybe it's simpler to be able to export an upper bound in another API
that probes it (some KVM cap)?

Any retry is a wasted round trip from perf perspective.  The upper bound
can be relatively large, IMHO, which should be non-issue.  It should be
simpler for both userapp and kernel if feasible.

> 
> Context: I am new in the Intel TDX live migration team, and did not
> participate in TDX PoC, that's why I use "I believe". I am catching up. But
> I assume others will (Tony, Kishen) will correct me if I am wrong.

No worries, thanks for the detailed answers whatever offered; they're
already very helpful.

> 
> > - Does this operation supports concurrency?  If it supports, how well it
> >   scales per expectation (e.g. is there known big lock for that)?
> 
> From the TDX module perspective, parallel exports of different GPAs can run
> on multiple CPUs, so I expect the QEMU multifd model to work and scale.
> 
> In our current PoC the ioctl does not take a VM-wide lock, and concurrency
> is per-stream. I can expand on the stream concept if needed, but it is
> exactly about parallel import/export of memory and vCPU state.
> 
> In our PoC we are focusing on the basics, but multifd support is definitely
> a goal too, just later. Kishen was already prototyping it in QEMU.

Great.

> 
> From the uAPI point of view, I believe parallel export/import should be
> allowed. If a specific CoCo VM has issues with that, it would need to
> serialize the operations internally, I'd say.

Yes, it would be good to keep the critical section as small as possible in
this case. As long as we are fully aware of the concurrent use model from
userapp then it's good enough for now.

> 
> > - Does this operation supports concurrency?  If it supports, how well it
> >   scales per expectation (e.g. is there known big lock for that)?
> > 
> > Similar question to the vCPU getter and setter.  For now even without CoCo
> > we serialize vCPU get/set, but I want to understand the potential of
> > concurrent operations, and see if there's anything special for CoCo from
> > that regard.
> 
> Similar to memory import/export: the TDX module explicitly allows vCPU state
> to be exported and imported in parallel.
> 
> Our current PoC does not take advantage of this yet. vCPU export currently
> grabs the KVM MMU write lock, so vCPU exports are serialized today. I think
> Tony can comment more on the technical difficulties there.
> 
> From the uAPI point of view, I'd propose to allow concurrent vCPU
> operations.

Sounds good.

> 
> > > 
> > > It describes what the TDX module offers today and focuses on pre-copy
> > > migration. This is our interpretation of the TDX specifications, not a
> > 
> > IMHO we should really take postcopy into account when designing the API and
> > state machine.  We don't need to implement it in the first version, even
> > until merging, but we need to make sure postcopy will be new ioctls on top
> > of existing and it should have no major loopholes that it'll need a new set
> > of APIs.
> 
> I totally agree. I have not yet dug into the TDX module implementation
> details for post-copy, but I know it is supported and I know the basics. I
> plan to study it in detail later. So far I have not noticed anything that
> would prevent adding post-copy on top later.

As long as we have that in mind across working on this, that's good enough,
thanks.

> 
> > 
> > For example, I think we should consider KVM_EXPORT_MEMORY being usable
> > after END on source, KVM_IMPORT_MEMORY while TD is in operation, etc.  We
> > should likely also need to still picture the rough process of postcopy,
> > reserve those APIs since the start (but return -EINVAL or something).
> 
> Yes, agreed. I will spend more time looking at this. But at this point, I
> just assumed that the proposed uAPIs can be used at the post-copy phase in
> parallel with on-demand page delivery.
> 
> Just FYI, TDX module model allows for this, but we did not try it.
> 
> > 
> > AFAIU, postcopy is so far still the best solution for extremely large or
> > extremely busy VMs regarding user experience, and it will happen to CoCo
> > VMs one day or another.
> 
> Sure, thanks for sharing.
> 
> > >   destination may run, but never both. In other words, cloning a TD is not
> > >   allowed.
> > > - When migration completes, the destination must have the same memory and
> > >   vCPU state as the source. It must not end up with a partial or mixed
> > >   state.
> > 
> > If such happens, it's definitely a bug, even without CoCo.  Anything
> > specific about CoCo?  Like, whole-VM checksum?
> 
> Well, in CoCo VMs it is not just a bug, it is something the CoCo framework
> needs to make impossible, because VMM is considered to be untrusted, it can
> try to manipulate things and half-migrate, use it not as a bug but as attack
> vector. In TDX case, the TDX module will not allow you to run the TD - the
> TDH.VP.ENTER seamcall will fail.
> 
> Regarding checksums: there is no single whole-VM checksum in TDX migration
> model. Instead integrity is enforced continuously - every exported blob
> carries a MACs that the destination TDX module verifies on import, and the
> epoch/start tokens guarantee that everything was imported, in order.
> 
> > I want to understand what is extra for a CoCo VM in terms of "pause", say,
> > what's more than "stopping the vCPU threads".
> 
> TDX module guarantees the source won't run, even if VMM tries, the
> TDH.VP.ENTER seamcall will fail. So the source TD state is effectively
> frozen and cannot be modified by the VMM.

IIUC this should work for QEMU.

Said that, we'll need to be careful then in case of migration fallbacks at
the final stage. Nowadays, I believe QEMU can still fallback to source side
at a very, very late stage after all things applied.  If I'm not mistaken,
the final handshake is done at migration_incoming_state_destroy() ->
migrate_send_rp_shut() telling source to be gone.

After reading above, one thing we may want to make sure is TDX ENTER on
dest be exactly the last thing to do on destination, rather than dest QEMU
ENTER done then something else seems wrong, then dest can't fallback
anymore.  I didn't check into details, though, more of a heads-up to
whoever is working on QEMU for this in case useful.

> 
> > 
> > I saw there's mention of PRE_COPY_STOP state.  One example question is,
> > when reaching this state, can the guest memory still change?  What happens
> > if some emulated device are still DMAing to the guest memory (assuming
> > flipped from private to shared)?  In case of future IO zone support, what
> > happens if in case of VFIO-PCI assigned doing encrypted DMA?
> > 
> > From that regard, VFIO has the P2P state where it quiesce initiation of any
> > DMA from this specific device, then another round to fully stop all devices
> > into STOP_COPY phase.  I wonder if CoCo VMs need similar treatment.
> 
> Let me split this by device type, because TDX treats them very differently.
> 
> Emulated (virtio-net, virtio-blk, etc.) only use shared memory - they cannot
> read or DMA into TD private memory. So full device state lives in shared
> memory, and QEMU migrates them exactly the same way as for a traditional VM.
> This is entirely outside the TDX module migration model and outside the
> proposed uAPI - the uAPI is only for TD private memory.

I hope I understand it right, that all shared pages are out of the secure
zone TD manages, during migration or not (hence the same as some random
page the VMM has allocated)?  If so, anything about post_load operations
shouldn't be any concern, and should work as usual.

> 
> Directly assigned devices are only possible with TDX Connect, where a
> physical PCIe/CXL function (a "TDI") is assigned to the TD and can DMA into
> private memory over a cryptographically protected link. This is not
> implemented in Linux yet. For migration, the TDX module requires all TDIs to
> be unassigned before the source TD is paused - the TDH.EXPORT.PAUSE seamcall
> actually checks this. Unassigning a TDI tears down its whole TD-private
> footprint (MMIO unmapped from the Secure EPT, trusted DMA mappings removed),
> so no device-specific state is left to migrate. From the TD's point of view
> it is a full hot-unplug on the source and a fresh hot-plug on the
> destination.

Hmm, interesting.  Sorry if this follow up question may be slightly
off-topic of the new API, or maybe it matters, depends on the answer: do
you know who is in charge of this unplug / plug operation?  VMM or TD
(hence, transparent to VMM)?

If it's VMM, is QEMU involved?

> 
> Our current TDX guest migration PoC is built on this assumption.
> 
> > Could you elaborate what's the relations between TDH.MEM.SCAN.RANGE and the
> > GET_DIRTY_LOG ioctl?  I recall above mentioned GET_DIRTY_LOG will be
> > available even for CoCo, which makes sense assuming dirty information isn't
> > confidential.  However then I don't understand what TDH.MEM.SCAN.RANGE
> > plays the role here.
> 
> A few things here.
> 
> First, our plan is that the standard GET_DIRTY_LOG ioctl is backed by the
> `TDH.MEM.SCAN.RANGE` seamcall - that is how dirty tracking is implemented
> for a TD. So we do not propose any special uAPI for dirty tracking.
> 
> And I think you are right that the dirty information is not confidential -
> the TDX module exposes dirty page information to the VMM.
> 
> Second, FYI, in current TDX migration model, dirty page scanning
> (`TDH.MEM.SCAN.RANGE`) is only allowed during a migration session. The TDX
> module returns an error if the seamcall is issued before the session is set
> up (i.e. before the source and destination TDX modules have exchanged the
> migration key and established trust - what the SETUP command does in the
> proposed uAPI).
> 
> In other words, with our PoC, if someone tries to use GET_DIRTY_LOG without
> going through the migration setup - the ioctl will return an error.
> 
> But I wish it were an independent feature instead. Then we could work on
> upstreaming it on its own - Tony estimates it is about 20% of the current
> TDX migration PoC code.

Unexpected, that's a lot just for tracking.

> 
> I already raised this with the Intel TDX module architects, and they asked
> for use-cases. The only one we came up with is QEMU estimating the TD dirty
> rate before starting migration (the calc_dirty_rate command). I understand
> their position: without a use-case there is little reason to implement it,
> and they would also need to study the security implications - can it help
> an attacker in some way?
> 
> So if you or anyone else can educate me about use-cases for independent
> dirty page scanning, I would really appreciate it - I could take them back
> to the TDX module architects.

Yes, calc_dirty_rate will use it, I also can't think of another use case
that needs it.  RHEL supports it, so it would be nice this will be
supported for CoCo too.

QEMU also has another way to do it without KVM tracking, which is kind of
simle page hash daemon fully done in userspace. But in case of CoCo it'll
stop working too when most memory unreadable.  So GET_DIRTY_LOG seems the
only way to go.

We can still "emulate" it by initiating a remote migration just to collect
this info, I believe all attestations will simply pass and we do a fallback
when the admin turns it off.. but it's awkward and all the rest (including
trying to find another host suitable for migration, allocate resources..)
are pure wastes.

Btw, do you know if the private pages will be write-trappable by the host
kernel, with things like userfaultfd-wp or soft-dirty?  That'll be another
way to do this without TD involvement, but I don't know well enough to say.

It just sounds like if it's doable in KVM, it's still the best place, also
since GET_DIRTY_LOG is available as long as memslot marked tracking, it
sounds good to keep CoCo be compatible with that API if it is to be reused,
hence GET_DIRTY_LOG API is consistent across coco / non-coco.

Thanks,

-- 
Peter Xu

