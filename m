Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C663B3A7F66
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284803; cv=none; b=RjT9HMTBL3ZKpnFlMU6ejzJ2ralSzxwrsD5HgiGIautTVX0CD4BryG7DFCyZk6WY6Oun8SOXqEoaOpquLK6wdAwb0zYKz9i9Kr1gwIDAea1elmd7sMU5gF2lbxal2WKUUjCTrmkxhwsSnERmSfHxL6C0ZmmaD1Cy3gq72w9PGzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284803; c=relaxed/simple;
	bh=HwXCj7qapp7R+YamYm9jxyvDtGzei46R3weuhEntSds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxfuiqBvnfaG6gaskXol1p72hj/xkZC7Uvu4k38ekUxwc6oy91xeVp5vgKehIkEFeCKyZ7Yo4Ef0hQOWRB8vYV2AHywrFXIEzXe4gFFK75Ntg5QhaBUOuh2VXeYAqneX4FmzYYEf/RP5+IZZvsfANFUhGxNHqXjywkG3Quu6v0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPdWy1ON; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OymJCg1m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPdWy1ON";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OymJCg1m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790284794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvNZtoFlYOkfMw9mXNu6u3pvpRKJnp0QZtmXRiJVB70=;
	b=WPdWy1ON+rQmQgr+640kZFEXHi6rya/Az388H0dm/iUU2sJW774STvOjcHj99E3l2islk+
	dVwzqiXn38Rz1DNBqmezBOs3F+ZOHSfALsEVAfDLCC7sXoXHotMfbYgvj0zM6oaz59GzsE
	ojfnyIiTxApXwZfxhkFTQVp5yjs9AHg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-S5_-wFy4PUqKcwAoAMOk9g-1; Thu, 24 Sep 2026 17:19:53 -0400
X-MC-Unique: S5_-wFy4PUqKcwAoAMOk9g-1
X-Mimecast-MFC-AGG-ID: S5_-wFy4PUqKcwAoAMOk9g_1790284793
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-530e0cb072eso4758191cf.1
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 14:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790284793; x=1790889593; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WvNZtoFlYOkfMw9mXNu6u3pvpRKJnp0QZtmXRiJVB70=;
        b=OymJCg1m43XjnWFRhyHv786pKWSVwdjfegBfYN4+Vnvr9VUMh2aMF68G7zaEv+Urhd
         sbQHGGVSJNEHdmzJT2gVB9Zo5lI5eniGjOsQth3shLEOrhJe6cqLUISZpbyCLkqvKIoI
         zJXx3SJkZZGzNNVrql9QmhZ9vXipcuE7syMrOYfAULyBP2wSqRTb4vv6t3j8ENr/TJtX
         VhGXhHF+MyLFcoEvtkcvqyuyTgnjZjmDICDzmvROnob5NTRgDYuOTbZpqdBeQsKqBfg4
         V2O2axQtrAT0LtCauxCVQ/Kszy3AV52xqX4pMtQ+sTrwyrWgVn8qdqkyNAp50lzNYwVi
         hdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790284793; x=1790889593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WvNZtoFlYOkfMw9mXNu6u3pvpRKJnp0QZtmXRiJVB70=;
        b=e1xqU8JGQ7UX1ZkzyFHD95kILqN6/AvvJ78QUuly15vdDe3fk4vsQJKWKyv1xo5uwt
         /AlAU0wlcLZ6wQdFLiMnNT/Wv+xgwVO3Bl48/bHBcti5hg2v6muKZJBMSOhlFIEL78m6
         BE4RK/mfixPk3/9WaizZhOpOFqP3/au9HgoZV2lkLaKLobqwuSJdB1QLpVa3PmOa9Yg5
         GREcNjAaNFQNJbfkzOl5HccQK6MiaSsd7WDh8ekJI5A0Y/un59zg2paFOsqcElb2SVz/
         dKY8woLruLj8JtTs5up/WaxLC5JYKj54QjFPzO4Fe1r0xESxPmUS145ip7oVaStgorOW
         oUXw==
X-Forwarded-Encrypted: i=1; AKwUvBzrEbUhBcvYTphyEBFtX5jtVsHWKDZH18jixN3q3sYVIEoQufPD+Ns4sn4IJGwUn+p6hIU=@vger.kernel.org
X-Gm-Message-State: AFuF++mR48YRfGToRJLwHeel72+NmVB4vXqOh5aoZqeiMWfIMoo4Lefn
	NPbVvffS0ZNeiz/dqYl7XCkEV6ScfHFE2m+uXPO0kElRMnG4GKtEaq0N/nBCc1Nt2Ce+jo4a9oe
	qbH2Dp35dfszYwHBVviFCnWq5SHMUEofDTyiG+PNnp9OqOSjLTgION+T4SDVMrfcv
X-Gm-Gg: AYBFou2xSEoE1IBWSmiR+KJoFU6KoFpEHLPaaTvkS5oDO+cknnDL9c1AQy95khytqhV
	Ja5Hbt9dkyu8c7qtDdwqUR5I4UklJxV+vvmMP9ifNzXqO8z92Ayxf2yfgP12qBtyjA8pyJWnjYO
	Xy7CeNGeH5jsajIp9M7u3pwJ/8qs3futGRhMnJ277kC5WOZseKZadOCjwVVpc/jvf7hBJ64MztQ
	RwCcHKKz2gQouXQ/3hbVbE1Hns7FFnNsXb9U41a+w04oi5hVYbh9CpZeV7suq1ncYpErx+8ARY9
	jI6/V2tOLHBpEY7j+smIHrlh+Tkpju9S5jBFdp8Q08Vq2RqJX7aQy7NxjK5F2wuOI+3o740=
X-Received: by 2002:ac8:5ccc:0:b0:532:cfd5:c1d6 with SMTP id d75a77b69052e-5330b69558fmr9831941cf.48.1790284792228;
        Thu, 24 Sep 2026 14:19:52 -0700 (PDT)
X-Received: by 2002:ac8:5ccc:0:b0:532:cfd5:c1d6 with SMTP id d75a77b69052e-5330b69558fmr9831191cf.48.1790284791550;
        Thu, 24 Sep 2026 14:19:51 -0700 (PDT)
Received: from localhost ([142.188.212.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430da85f3sm2612806d6.10.2026.09.24.14.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:19:50 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:19:49 -0400
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
Message-ID: <arWT9fwpCkFneDKn@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f2889dd6e44333b2a5bbd4bd32a4557c3b50a3cc.camel@gmail.com>
 <arLwnNyM4Tkr-Oh3@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <97c6ab9a9d5527776a580a242b6c8033cf1e9a36.camel@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97c6ab9a9d5527776a580a242b6c8033cf1e9a36.camel@gmail.com>

On Wed, Sep 23, 2026 at 03:05:38PM +0300, Artem Bityutskiy wrote:

[...]

> I would like to make sure I understand correctly though. You refer to QEMU
> post-copy recovery, which is basically all about restoring network
> connectivity and finishing the migration. Is this right?

Correct.

> 
> And to make sure we are on the same page, here is how I see things at a
> high level.
> 
> 1. Post-copy recovery is about handling the state split between source and
> destination. I think this aspect is going to be similar, if not the same,
> for traditional and CoCo VM migration. Same problem, same recovery
> strategies, I'd guess.
> 
> 2. The abort token stuff I discussed is about pre-copy. It is an artifact of
> the switchover: when src is paused and dst is allowed to start, an abort
> token is needed to reverse this process. And whether post-copy is used or
> not is orthogonal to the abort token stuff.
> 
> Did I miss something?

I believe we're on the same page.

I mentioned the recovery feature because both of them (even if ABORT is
part of precopy rather than postcopy) describe such an use case where
network interruption can cause some form of split brain of the VM, causing
neither side be able to continue.

We used to not have such case with precopy, but then this ABORT / START
message can make it happen similarly like postcopy. Said that, the window
is much smaller than postcopy.

> 
> > 
> > > Specifically about TDX - the pause seamcall will return an error if TDIs
> > > are not unassigned.
> > > 
> > > While this is something that is not implemented in Linux yet, I believe the
> > > model will be that there is some uAPI to unassign TDIs, and it is not
> > > related to migration. QEMU would just need to exercise this uAPI at the
> > > right time.
> > 
> > OK, this sounds working, but then it means the migration will be visible to
> > the guest.  I wonder whether there's any attempt to make it more
> > transparent, but we can also leave this question for later.
> 
> Correct. With a disclaimer that I am not a TDX Connect expert, I had the
> impression that this is more of a compromise solution. The VMM is an
> untrusted entity in the CoCo model, so the trust between the TD and the
> PCIe/CXL TDX Connect device is built by the TD itself. It is the TD
> establishing the cryptographic trust with a specific physical PCIe/CXL
> device. Directly, not via VMM. This is part of the industry standard SPDM
> protocol, which stands for Security Protocol and Data Model.
> 
> As I understand it, with the current SPDM protocol, this trust cannot be
> transparently moved from one host to another: the destination host has a
> different physical device, with different cryptographic keys, and the TD
> would need to re-establish trust explicitly. VMM cannot do it on behalf of
> the TD in a transparent manner. I would only speculate that this means
> preserving the device state is a hard problem.
> 
> Maybe future TDX Connect and SPDM revisions will solve this problem, but for
> now, this is the compromise solution we have.
> 
> But again, take it with a grain of salt, it is more of my intuition than
> based on concrete knowledge.

AFAIU, preserving device states were a hard problem even on non-CoCo
before, but then I guess people thought VFIO performs so good, after that
people managed to work the problem out.. and now more people start to rely
on VFIO precopy migrations working in the clusters, non-CoCo.

I had a gut feeling it will happen too for CoCo some day, that unplug
approach was exactly what happens before VFIO migration is implemented...

But yes, let's leave this for later, thanks for sharing.

> > > The reason I am asking is that my assumption was that it is not important.
> > > But if it is, I will come back to the TDX module architects with a
> > > request to revise the design to support independent dirty page tracking. Of
> > > course they may have some reasons for not doing it, but I would try at
> > > least.
> > 
> > Thanks, I'll talk to our team and revisit this after I collect answers.
> 
> Many thanks!

I got some feedback on this, I'll try to provide a summary.

So, first of all, calc_dirty_rate isn't seem to be widely used across our
customers.

However, we do have customer case using calc_dirty_rate to evaluate
migrations of a VM fleet for cases like from one data centre to another.

I think it makes sense because the normal "try to migrate and fallback
otherwise" idea applies well to one VM, but perhaps not that good on a
fleet.

When a fleet is involved, we don't want to migrate 400 VMs then found
there're 30 critical VMs too busy and can't migrate, then due to whatever
reason (inter-VM communication / service locality ?) one is forced to
migrate that 400 VMs backwards.

IOW, it seems helpful to provide high-level evalutions of migration
decisions over a full cluster, concurrently and efficiently.

> > Hmm, I was expecting PML is still superior in most cases.  For "depending
> > on workloads", is that perhaps when (1) huge pages are used, and (2) the
> > workload writes only a small portion of guest memory?
> 
> Sorry, I did not communicate it correctly.Sean did not talk about huge
> pages. I need to be very careful here. What I think was Sean's point is that
> VM exits forced by the WP-based dirty tracking cause "back-pressure" as he
> put it, meaning they work as a natural way to slow down vCPUs and improve
> migration convergence. PML-based tracking does not cause as much
> back-pressure, so, depending on workload, they may require artificial vCPU
> throttling. But disclaimer, this is not a cite, this is my interpretation.

No worires, thanks for sharing your thoughts.  And I agree there is that
back pressure effect. Migration performance is one of the most weird
performance engineering topics I'm aware of for sure; sometimes, the better
a work done, the less likely it converges..

> 
> > > Then he learned that TDX module's dirty scanning does not use PML, and
> > > was understandably surprised. Sean was concerned about dirty scanning
> > > performance.
> > 
> > I'm definitely surprised too that PML isn't used.  Could I ask if there's
> > any simple reason not to use it for TDX?  Per my understanding, PML works
> > with all kinds of loads, and I was expecting PML to be efficient and most
> > ideal.
> 
> Another point where I need to be careful to not miscommunicate. The honest
> answer is that I do not know for sure why PML specifically was not chosen.
> Please take my comments below with a grain of salt - I am a software person
> who tries to understand the design decisions made in the TDX module, but I
> am not a TDX module architect.
> 
> Current Intel processors do not support PML for DMA - a TDI's DMA writes
> would go untracked by PML. But they do set the Secure EPT Dirty bit, so
> scanning works for catching both CPU and DMA writes.
> 
> My speculation is that once non-blocking scanning had to be built to cover
> the TDX Connect case, it made sense to use it as the single mechanism for TD
> migration in general.
> 
> AFAIU, the TDX guest migration implementation benchmarking results are
> satisfactory with the scanning approach, but I do not have hard numbers to
> share. I also feel that PML could offer better performance, at least for
> memory-intensive workloads. But this is intuition only.	

My gut feeling is DMA shouldn't be a blocker for PML: AFAIU we don't track
DMA from KVM side. Assigned device should have its own dirty tracking for
DMAs, either via device's own tracking facilities, or the IOMMU on the
host.  Feel free to refer to vfio_listener_log_sync() in QEMU.  In all
cases, it'll be great you could share the reason if you have more solid
clues.

> 
> > Another approach is if TDX can take over the bitmap buffer from the
> > relevant kvm memslots, update directly there alongside setting D bits in
> > EPT PTEs; after all IIUC we assumed dirty info not part of confidential
> > materials.  But that sounds more complex than PML if it's already working
> > for years.
> 
> Well, then the dirty bitmap specifics would become the ABI - the hard
> contract between the Intel platform and the OS.
> 
> But this is effectively what TDX module dirty scanning does already today:
> on input you give it an array of up to 512 GPAs, on the output it marks
> which entries are migration candidates and also for what reason.

Are we talking about the memory export/import API or GET_DIRTY_LOG?  IIUC,
GET_DIRTY_LOG always applies to a whole memslot,

struct kvm_dirty_log {
	__u32 slot;
	__u32 padding1;
	union {
		void *dirty_bitmap; /* one bit per page */
		__u64 padding2;
	};
};

> 
> Keep in mind that dirty pages are the majority of migration candidates, but
> not all of them. Sometimes a migration candidate can be a page that was
> already exported, but then was, for example, converted from private to
> shared, or unaccepted by the TD (gone, in other words). In this case the TDX
> module flags it as a migration candidate too. The memory export seamcall
> treats it differently too - instead of exporting encrypted page data, it
> exports a small record indicating that the page has changed its status
> (gone).

Yes, it makes sense.

So can I inteprete this as GET_DIRTY_LOG works seamlessly for both private
and shared pages (or even, unaccepted pages)?

Then I assume it means MEMORY.EXPORT should also be able to read shared or
unaccepted pages too, am I right?  Same to when apply with IMPORT.  Another
counter example is MEMORY.EXPORT returns a flag saying "this page is
shared, go read it directly from HVA", but then QEMU reading it may race
with a concurrent shared->private conversion crashing VMM.

Looks to me MEMORY.EXPORT must support shared too, then.

> 
> IOW, in the TDX migration case, it is not just dirty pages. In an abstract
> way, it is useful to think of it as the TDX module tracking both page data
> and metadata changes.
> 
> We (me, Kishen, Tony) call them "dirty pages" for simplicity, but TDX specs
> use the term "migration candidates". But again, most of them are dirty
> pages.

Yes, I didn't notice it before, but now I see that marking converted or
unaccepted pages to be dirty makes sense.  IIUC it's because that info
(shared, or private, or unaccepted) is part of page [meta]data that needs
to be migrated to reconstruct the whole VM on the other host.

> 
> > The current scan approach sounds like unpredictable in terms of downtime,
> > in that even if with a scanner I don't see how TDX can guaratee the
> > downtime for the last dirty sync from QEMU, which will completely be part
> > of the blackout downtime.
> 
> Could you help me understand exactly what you mean by "predictable" here?
> Let me walk through how I see it. Please correct me if I am wrong.
> 
> For a traditional VM: at some point QEMU decides that pre-copy has
> converged. But the source VM keeps running until it is actually paused, and
> it can dirty more pages. QEMU has no way to know in advance how many more
> dirty pages there will be by the time the source VM is actually paused -
> could be a few, could be a lot. So the time it takes to find and copy them
> during the downtime is not fully predictable.

Correct.

> 
> The same logic applies to a TDX guest using dirty scanning. Suppose the
> final dirty scan is slower than a theoretical TDX PML-based approach would
> have been. The prescan optimization I described in the previous e-mail
> should help with this in an average case, but let's assume it does not
> help for some special case - when the TD touches most of its memory, so
> all EPT sub-trees end up touched. This should be rare, but let's assume it
> happens.
> 
> In this case, whether that scan slowdown will actually matter for the
> overall downtime also depends on the network. If the network is very fast,
> the scan itself can become the dominant part of the downtime. If the
> network is the slower part, the scan slowdown may barely matter.
> 
> So my understanding is that downtime is never fully predictable, for
> either type of VM.

Right, but IMHO background scan of EPT pgtable dirty bits adds a completely
new reason to introduce downtime, and when I said "unpredictable", it is
about that part.  Also, I worry in some worst case this can be pretty large.

So we have two overheads here at this stage, unpredictable:

  (a) Scanning EPT pgtable, when very unlucky, can take a lot of time to
      finally reports to a GET_DIRTY_LOG request,

  (b) Migrating of dirty pages during blackout phase, which should be
      roughly linear to how many dirty pages we just collected.  (NOTE!  I
      think we may have way to fix this (b) or optimize it.. but this is
      off-topic; let's focus on the difference of (a) and (b) first)

When with PML, IIUC (a) is predictable: we have the bitmap on hand, plus a
maximum of some (my memory is, 512?) PML entries to flush per vCPU.
That'll be flushed automatically when we do vm_stop(), likely also
concurrently, atomically updating the bitmaps.  I never measured it, but it
is bounded, and sounds pretty fast.

When with scanning, (a) seems more unpredictable.  That's the part I was
slightly concerned.  But now after thinking a bit more, it seems fine.
Please read below.

> 
> Intuitively, the TDX case does feel "less predictable". The open
> question for me is whether the degree of unpredictability is large enough
> to bother users. My attitude is to focus on getting something simple done
> first, learn from real-world behavior, and improve it later if needed,
> including exploring PML. The best is the enemy of the good sort of
> attitude.

Yes, I think it's always fine we start with whatever is most feasible.

I think it actually may not be that bad. The last sync is special at least
on how QEMU treats it, it should look like:

  - GET_DIRTY_LOG, to do last math, decide to switchover, <------   [1]
  - vm_stop()
  - GET_DIRTY_LOG, this collects all rest dirty bits      <------   [2]
  - migrates the dirty pages, device states, etc.

So I expect there should be normally very small window between two
continuous GET_DIRTY_LOG across system.  Only [2] will be part of downtime.

Since you explained to me on how the background rescan roughly works, by
relying on A bit in pgtable directory entries, I do feel like in this case
most of the memory regions shouldn't be accessed during small window of
[1]->[2], then the range to scan should be very much under control too.  In
reality, it will likely be even smaller, [1]->vm_stop(), because after that
vCPUs are halted.

So it may not really be an issue in practise, but it still depends. In all
cases, some measurements after PoC ready would be nice on some large and
relatively busy VMs.

> 
> > Whenever switchover decision made, QEMU stops the VM, do the last time
> > sync, move anything left.  So that last one will matter a lot if we care
> > about downtime.
> 
> Could you please help me understand: in your experience, how much do users
> care about the overall migration time?
> 
> My current assumption is that users mostly care about downtime, and care
> little about the overall migration time. I guess nobody wants migration to
> take days, but if it takes, say, 10 minutes, I assume no one would put in a
> lot of effort to improve it to 9 minutes.

I agree.  I think some use case may care about total migration time, but I
would say in most cases, "10min or 9min total migration time" difference is
less of a concern than downtime effects.

Thanks,

-- 
Peter Xu

