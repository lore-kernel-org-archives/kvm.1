Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD95423A83
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064607; cv=none; b=Xmcmb2mJg3knULmCVv6EQgck80h+0j56iE1/zbiSpLo21ZbeAt63Iwni00kH2NR34R0xB5/5uizghve0HXgjOI6YXhETv9+mgGBthMWBFDuDxmaNU1EMAWjBLW+qruobNgUujfFo/ExBVE1UehX6eAYbqLiZfEB/5V4vqQS+7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064607; c=relaxed/simple;
	bh=jdEy50ZLrsS2t3bpXVFn6rL3LMrmzfxACm1O3zv6DKM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LNaXjCjSojZd449jIkR7uK8kB6x1MbeCSVdpUeB3MB0xV6k4jmUdWeiZwv4Arw++djmAkNfBVrnEFMNwuIwO4PsFz99DYokypU8uWdziX5EcduOz5Y7RmOAy+sCg6snvVMzZ/aKjJzb5gBmIqBkp8uz+xa0sCmTmBaE2L9rbdSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNPcHNi9; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNPcHNi9"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso21752985e9.2
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 01:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790064588; x=1790669388; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iOI8yNYKGvMgqAiBrTV03Nga9iDEMz5JR6+cjNdgRms=;
        b=tNPcHNi9lRxQXPityNVbMn5G1VFzV8YGntNx+Nbnjp2hOtjjcsLjx3x6chBTVFKyQ+
         +QvKH+RC8duQ9ATGcZVlB27AAf25pVIUWLYgbfe1qCziyA8JOR7bMLtPkO06B7DolRZR
         mfPvgW78Yr8FGsdK9ilKjZZ9i2f/4tB4vNQQZi/uvZ65cCsbKozePtFh+qxQ6YNc0WFf
         8oZAA4aomnRAJFrc3VS//AVJacUFy6My9mGmgshRA8T1MBXM3hOAIO/HHzrvZXPdkbc9
         lMhjX4/VacSgc0Vpn8/GwgmGPV70tEooXH/RpVNVmaADbxyx5WtapIyEc7BjGE3RaBap
         oXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790064588; x=1790669388;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iOI8yNYKGvMgqAiBrTV03Nga9iDEMz5JR6+cjNdgRms=;
        b=Thh2pJ0zAmj3AZbgUvRUBGeE9dmTw9N5EHhf2VYmN6bh8Vi6eln5Xgr3v+eSqBG0UW
         OuBmsewIivGS5zEeStM1LG7+5e9HpK8R4Pk40Q1OSP9F/h/hbufNe7GqCWcgZmArcexX
         YXLHBZpVQsEJLe+9kNZBguXHIxFSQO05zSG47VbOXvwjgZQdXNMpJ5VgskQ6j37oWhdj
         EM0xKq3z7BxrWkobpQVw7qbIQvaJqx7gG7pFbfUGc1RxQJM2Yb355FbDTy9/+jJwHVr+
         +TtyFx56/BT+n9iY6Zk8YNKW39/ek6JT9fbG1WM6FB52V0HVk2oapiCNi+cbDHSkx6pI
         XKvg==
X-Forwarded-Encrypted: i=1; AKwUvByivIj0Qu+X1Hg6jYd7F8VyzPCWUdGYtN5qt7/B/z0EuBXwY+86YF31EORsL2fbtiLzT70=@vger.kernel.org
X-Gm-Message-State: AFuF++mY33vqo8+Ezxr9LX/ZC09bzZaJ3SHP/sehk518ttleHNYB2iZ8
	FuLvexPRPBYteEQ+lYL+v4W3hKjrHkrhSqFygMxWC/5UCLoXs8UIJZU+
X-Gm-Gg: AYBFou3Kyud6IGLxTIvWr8nYiv6IF4ca7l+hguu7prhBIST6yHUEqRi+p/VWgcR85pP
	8ffzskTuacEFGiXlyoxsz/2GMHeVr9w5NQRujbqxUpPhk4356DrNyfPRyAQkQSqfGjy4AjIAOkA
	Flbc4srR+iYSYxn36J8FnBsPZN1vLcsIYWwZuQUgSZLR7hSs0mivfKBQMyxN9mwXPIIlV/2bcY6
	2DwVIP5etPlANcGwfBva3Uzgg8WFrrw+HnmBCinuEVWOuTfmfxcozPW2LQ3jBfMGpF2A9Ouefr6
	m8TBSLIFFfj8/vuopnBCqE0npTnCtju5XUL+jdEZO5Yj5PS0j6gYUDL7UGhrZ+TXm8sHJ3K4Zy8
	btAKkZsJ2Mlbk+hv5eZjdkZuzNK4ix4lk/TGN1dWQaVJd7yLV70T2owUD+Ih511q0Jk8baSvvVX
	e3pGAA+fOBDOfYG79kT1oAtIYWuX1EkoDPo0nZkrU6p6XaQ7GdxHcMAAsncQfRrboLnoFmGeWH
X-Received: by 2002:a05:600c:83cd:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-49fc56f7a11mr154946875e9.14.1790064587053;
        Tue, 22 Sep 2026 01:09:47 -0700 (PDT)
Received: from [10.245.245.29] ([134.191.227.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdaafa9cfsm36819425e9.4.2026.09.22.01.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:09:46 -0700 (PDT)
Message-ID: <f2889dd6e44333b2a5bbd4bd32a4557c3b50a3cc.camel@gmail.com>
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Peter Xu <peterx@redhat.com>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>, Paolo Bonzini	
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Fabiano
 Rosas	 <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>, Pankaj Gupta	
 <pankaj.gupta@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Marc
 Zyngier	 <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Steven
 Price	 <steven.price@arm.com>, Anup Patel <anup@brainfault.org>, Samuel
 Ortiz	 <sameo@rivosinc.com>, Jakub =?UTF-8?Q?R=C5=AF=C5=BEi=C4=8Dka?=	
 <jakub.ruzicka@matfyz.cz>, =?ISO-8859-1?Q?J=F6rg_R=F6del?=
 <joro@8bytes.org>,  Vishal Annapurve <vannapurve@google.com>, Elena
 Reshetova <elena.reshetova@intel.com>, Kai Huang <kai.huang@intel.com>, 
 Kishen Maloor <kishen.maloor@intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Peter Fang	 <peter.fang@intel.com>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li	 <xiaoyao.li@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, 	kvm@vger.kernel.org
Date: Tue, 22 Sep 2026 11:09:42 +0300
In-Reply-To: <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
	 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
	 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
	 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Peter,

thanks again for good comments and questions.

On Fri, 2026-09-18 at 11:53 -0400, Peter Xu wrote:
> >=20
> > FYI, I am working on a TDX migration model document. It describes what =
the
> > TDX module offers, but unlike the specs it is oriented towards software
> > engineers: much easier to read and it does not require deep TDX knowled=
ge.
> > It is all based on public specs, just distilled into readable mental mo=
dels.
> > I plan to publish it publicly. I am about 80% done.
>=20
> That will be very useful, thanks for doing this. I'll be more than happy =
to
> read it when it's done.  I wonder if we can, after TDX bits done, use thi=
s
> doc as a base for others to add in theirs in separate tabs, keeping
> everything together for the unified migration API work.
>=20
> Out of pure curiosity, I also don't know where s390 stands; it's almost n=
ot
> mentioned in the current API plan.

In general, sounds like a good idea. Let me finish TDX and share it first,
then we can think about the next step. But in general a master doc with hig=
h
level overview and comparison of different CoCo migration models would be
awesome.

s390 - yes, would be curious to know.

> >=20
> > We do not have code. But Kishen spent time playing with it, and I think=
 he
> > concluded not to proceed with this. But he might have evaluated it from
> > the "unify all migration into a single generic API" perspective. But ma=
y
> > be as a "this is a test framework" perspective is different, at least I=
 feel
> > it may be the case. I think Kishen can provide more insight if needed, =
he
> > is=C2=A0in CC.
>=20
> Yes, thanks.  I'm willing to hear more, and I'm a bit surprised that
> non-coco migration didn't fit already well into it, because IIUC non-coco
> needs less in this case, not more.


Yeah, just thinking aloud now.

- Suppose QEMU and KVM support CoCo migration.
- Does it make sense to treat traditional VM as a CoCo VM for migration
  purposes?
  - Not for performance reasons - mmapped memory I/O is going to be more
    efficient than any sorts of export/import uAPIs.
  - Yes for testing/experimental purposes.
- Would it add a lot of code and complexity: would the benefits outweigh th=
e
  costs?
  - QEMU: Should require minimum amount of code. Would need a flag like
    "treat me as CoCo VM", may be some QEMU operator commands or cmdline
    options.
  - KVM: Not sure, but intuitively it may add noticeable amount of churn.

> > The final round is special. It uses the "done" flag, which is passed to=
 the
> > `TDH.EXPORT.TRACK` seamcall, and makes it export a special variant of t=
he
> > epoch token that is called the start token. On top of the integrity and
> > ordering guarantees, the start token is what allows the destination to
> > start: until the destination imports it, the TDX module will not let th=
e
> > destination TD run with partial state.
>=20
> The methodology on unique VM attestation sounds comlex, but I think I get
> it now, thank you.  It'll be nice if some of these reasonings will also b=
e
> there in the doc you're drafting.

Yes, will add.

> > > >=20
> I am just thinking out loud here: if the hardware is good enough to do
> encryption plus (some?) compression, that would be very nice.  For "some"=
,
> I meant minimum over zero pages.  Because in this case even if host wants
> to play tricks with zero pages, it can't anymore when un-readable.  Maybe
> the guest driver can play some trick, but I'm also not sure if in CoCo.
>=20
> M > N may imply it's not the case for now, but it's still sane as a start
> even if so.

Yeah. In case of TDX, the TDX module does not do compression today,
and there is no zero-page optimization either.

But keep in mind that what pages in TD are zero pages is by itself a secret=
.
Any sort of theoretical TDX module zero page compression optimization would
need to be done in a way that VMM cannot figure out what pages were zero
pages. So with a disclaimer that I am not really a security expert, I'd say
it is far-fetched.

> > I believe in our current PoC, the ioctl requires the buffer size to be =
large
> > enough to hold all the requested pages. But this is specific to our cur=
rent
> > PoC implementation.
> >=20
> > In general, I feel like if buffer size is not enough, the uAPI could fi=
ll it
> > with as much data as fits, and communicate back about what GPAs were
> > exported. The caller could export the rest separately.
>=20
> Yes, this will work.
>=20
> Or maybe it's simpler to be able to export an upper bound in another API
> that probes it (some KVM cap)?
>=20
> Any retry is a wasted round trip from perf perspective.  The upper bound
> can be relatively large, IMHO, which should be non-issue.  It should be
> simpler for both userapp and kernel if feasible.

OK, so by upper bound here you mean the maximum amount of data that can be
exported in a single memory export ioctl operation, right? And you mean tha=
t
there should be some sort of command to query it, similar to KVM_CAP_XSAVE2
capability returning the XSAVE buffer size? If so - yes, I think exposing
such an upper bound would be useful.

Let's see. In case of TDX, the `TDH.EXPORT.MEM` seamcall today can export
max. 512 pages at a time. Today only 4KiB pages are supported, so it is jus=
t
a 2MiB buffer. So this is the upper bound for the seamcall.

So in TDX case, 512 pages would be the absolute upper bound for the uAPI
input buffer size. The alternative is to accept larger input buffers and
internally do multiple seamcalls. For TDX case, I do not think the latter
makes much sense though. But, what I do think is that the uAPI itself
shouldn't mandate one approach over the other - a different CoCo
implementation may prefer to aggregate multiple hardware calls internally.

Also, today TDX can only migrate 4KiB pages - VMM must split larger pages
into 4KiB pages before migration. But I expect that in the future TDX may
implement larger pages migration too. So I think the cap should be expresse=
d
in page count rather than bytes.

That said, I don't think exposing this upper bound cap should replace the
flexibility we discussed earlier: the API itself should still allow
exporting as much as fits the output buffer, regardless of what the cap
reports. A specific CoCo implementation could still choose to just fail if
the buffer isn't large enough to hold all requested pages - but that would
be an implementation limitation, not an API limitation.

And the other question is whether to allow exporting a mix of large and
small pages, like N x 4KiB along with M x 2MiB and K x 1GiB pages. Or the
uAPI would allow to only export one page size at a time?

If large pages are added to TDX, I'd speculate that TDX seamcall would allo=
w
the mixing and matching - I can see that already today the seamcall API
is provisioned for this. uAPI could require that the input buffer (set of
pages) can contain a mix which should match the GPAs of the corresponding
memory regions. But then race conditions - the GPA layout of the VM may
change by the time the request reaches the hardware: large pages can be
split or the other way round, I guess? Then uAPI could return a "retry" sor=
t
of exit code, may be?

What do you think? I am just thinking aloud: looks like pages of different
size add a degree of complexity - I did not take that into account until
this conversation, thanks.

>=20
> Said that, we'll need to be careful then in case of migration fallbacks a=
t
> the final stage. Nowadays, I believe QEMU can still fallback to source si=
de
> at a very, very late stage after all things applied.  If I'm not mistaken=
,
> the final handshake is done at migration_incoming_state_destroy() ->
> migrate_send_rp_shut() telling source to be gone.

Right. In traditional pre-copy VM migration model, the fallback is possible
at any point before the destination VM starts running and modifying its
state.

The same is true for TDX, but with more complexity and limitations.

We have 2 points:
1. Before the source has exported the start token - fallback is similar to
   traditional VM migration - just abort the migration on source and
   continue running the source TD, and just destroy the destination TD.
2. After the source has exported the start token - fallback is still
   possible, but more complex - it requires the destination to first
   generate the abort token, which should be delivered to the source and
   consumed there. There are seamcalls for both generating and consuming th=
e
   abort token. The token basically makes sure the destination cannot run,
   and the source can run again - same "only one of the TDs can run at a
   time" security rule that we discussed earlier.

Now, the limitation here is that if the abort is because the network
connectivity is lost, the abort token cannot be delivered. Then I'd guess
migration should stop, without destroying the source and the destination,
and the token should be delivered later manually, QEMU could even provide a=
n
infrastructure / commands for that.

Would be very helpful to learn the abort protocol the other CoCo vendors
offer - is it similar to TDX or not?

In our PoC we did not implement the TDX abort token procedure. But the
proposed uAPI is provisioned for the abort token export/import.

> After reading above, one thing we may want to make sure is TDX ENTER on
> dest be exactly the last thing to do on destination, rather than dest QEM=
U
> ENTER done then something else seems wrong, then dest can't fallback
> anymore.  I didn't check into details, though, more of a heads-up to
> whoever is working on QEMU for this in case useful.


Well, first of all, as the above describes, in case of TDX late fallback is
still possible, just requires a more complex protocol. But from
recoverability point of view, I agree with your suggestion to make
TDH.VP.ENTER the last thing done on the destination, rather than starting
the destination early and doing more afterwards. However, the paramount
performance goal is to minimize the downtime, and it conflicts with the
suggested idea. In my mind, minimizing downtime should take precedence.

> > > I saw there's mention of PRE_COPY_STOP state.  One example question i=
s,
> > > when reaching this state, can the guest memory still change?  What ha=
ppens
> > > if some emulated device are still DMAing to the guest memory (assumin=
g
> > > flipped from private to shared)?  In case of future IO zone support, =
what
> > > happens if in case of VFIO-PCI assigned doing encrypted DMA?
> > >=20
> > > From that regard, VFIO has the P2P state where it quiesce initiation =
of any
> > > DMA from this specific device, then another round to fully stop all d=
evices
> > > into STOP_COPY phase.  I wonder if CoCo VMs need similar treatment.
> >=20
> > Let me split this by device type, because TDX treats them very differen=
tly.
> >=20
> > Emulated (virtio-net, virtio-blk, etc.) only use shared memory - they c=
annot
> > read or DMA into TD private memory. So full device state lives in share=
d
> > memory, and QEMU migrates them exactly the same way as for a traditiona=
l VM.
> > This is entirely outside the TDX module migration model and outside the
> > proposed uAPI - the uAPI is only for TD private memory.
>=20
> I hope I understand it right, that all shared pages are out of the secure
> zone TD manages, during migration or not (hence the same as some random
> page the VMM has allocated)?  If so, anything about post_load operations
> shouldn't be any concern, and should work as usual.

Yes, that is correct. Shared pages are fully managed by KVM, not by the TDX
module, regardless of whether migration is in progress or not. They are
migrated the standard QEMU way, same as for traditional VMs, so post_load
and any other migration code dealing with shared memory should work exactly
as it does today. Again, good to know how it is for other CoCo VMs.

> > Directly assigned devices are only possible with TDX Connect, where a
> > physical PCIe/CXL function (a "TDI") is assigned to the TD and can DMA =
into
> > private memory over a cryptographically protected link. This is not
> > implemented in Linux yet. For migration, the TDX module requires all TD=
Is to
> > be unassigned before the source TD is paused - the TDH.EXPORT.PAUSE sea=
mcall
> > actually checks this. Unassigning a TDI tears down its whole TD-private
> > footprint (MMIO unmapped from the Secure EPT, trusted DMA mappings remo=
ved),
> > so no device-specific state is left to migrate. From the TD's point of =
view
> > it is a full hot-unplug on the source and a fresh hot-plug on the
> > destination.
>=20
> Hmm, interesting.  Sorry if this follow up question may be slightly
> off-topic of the new API, or maybe it matters, depends on the answer: do
> you know who is in charge of this unplug / plug operation?  VMM or TD
> (hence, transparent to VMM)?
>=20
> If it's VMM, is QEMU involved?


Specifically about TDX - the pause seamcall will return an error if TDIs
are not unassigned.

While this is something that is not implemented in Linux yet, I believe the
model will be that there is some uAPI to unassign TDIs, and it is not
related to migration. QEMU would just need to exercise this uAPI at the
right time.

> >=20
> > But I wish it were an independent feature instead. Then we could work o=
n
> > upstreaming it on its own - Tony estimates it is about 20% of the curre=
nt
> > TDX migration PoC code.
>=20
> Unexpected, that's a lot just for tracking.

I assume because it brings various seamcall wrappers and some shared infra
code. But also Tony might have over-estimated - I'll let him comment on
this.

> > I already raised this with the Intel TDX module architects, and they as=
ked
> > for use-cases. The only one we came up with is QEMU estimating the TD d=
irty
> > rate before starting migration (the calc_dirty_rate command). I underst=
and
> > their position: without a use-case there is little reason to implement =
it,
> > and they would also need to study the security implications - can it he=
lp
> > an attacker in some way?
> >=20
> > So if you or anyone else can educate me about use-cases for independent
> > dirty page scanning, I would really appreciate it - I could take them b=
ack
> > to the TDX module architects.
>=20
> Yes, calc_dirty_rate will use it, I also can't think of another use case
> that needs it.  RHEL supports it, so it would be nice this will be
> supported for CoCo too.

Do you or someone else know how important it is to have it working?
Do actual customers use it in real setups and rely on it?
How bad or painful is it if this feature is not available?

The reason I am asking is that my assumption was that it is not important.
But if it is, I will come back to the TDX module architects with a
request to revise the design to support independent dirty page tracking. Of
course they may have some reasons for not doing it, but I would try at
least.

> QEMU also has another way to do it without KVM tracking, which is kind of
> simle page hash daemon fully done in userspace. But in case of CoCo it'll
> stop working too when most memory unreadable.  So GET_DIRTY_LOG seems the
> only way to go.
>=20
> We can still "emulate" it by initiating a remote migration just to collec=
t
> this info, I believe all attestations will simply pass and we do a fallba=
ck
> when the admin turns it off.. but it's awkward and all the rest (includin=
g
> trying to find another host suitable for migration, allocate resources..)
> are pure wastes.

Understood, thanks - sounds like this workaround is doable, but wasteful,
something to avoid if possible. That in itself is useful evidence I can
bring back to the TDX module architects.

Just to understand the real-world deployments better: do you know if anyone
actually falls back to this workaround today, or is it more of a theoretica=
l
idea that nobody actually uses?

>=20
> Btw, do you know if the private pages will be write-trappable by the host
> kernel, with things like userfaultfd-wp or soft-dirty?  That'll be anothe=
r
> way to do this without TD involvement, but I don't know well enough to sa=
y.

The short answer is - no, private pages are not write-trappable outside of
a migration session, so trapping cannot be used as a workaround for
independent dirty tracking today.

But a bit longer answer is that the TDX module provides 2 alternative dirty
page tracking mechanisms, and one of them is in fact a write-trapping
mechanism. In the TDX specs, these mechanisms are called Write-Blocking
Export and Non-Blocking Export.

- Write-blocking: the VMM write-blocks pages using `TDH.EXPORT.BLOCKW`, and
  gets a VM exit (an EPT violation) when the TD attempts to write a
  blocked page.
- Non-blocking: based on Secure EPT scanning, using `TDH.MEM.SCAN.RANGE`,
  which was mentioned earlier in this cover letter. I refer to it as dirty
  scanning.

Today, both mechanisms are only available during migration and require the
migration setup to be done first - neither can be used as a standalone. In
our PoC we use the dirty scanning mechanism, as we expect it to be more
performant.

But our PoC actually started with the write-blocking method. According to
Kishen and Tony, it required a lot of ugly code and was very intrusive into
the MMU code. But I'll let Kishen and Tony provide more details.

Anyway, if I can get the TDX module to allow dirty tracking independent of
migration, we could pick either mechanism, or even implement both and add a
TDX-specific ioctl to select which one to use. We could plug either method
into the KVM_DIRTY_LOG ioctl - both would work, just differently.

=3D Dirty Scanning Optimization in TDX Module =3D

Now, I am diverging, but just in case: in the PUCK call where we presented
TDX migration, Sean made an immediate observation that WP-based dirty
tracking is not categorically worse than PML-based dirty ring tracking, it
depends on the workload. Then he learned that TDX module's dirty scanning
does not use PML, and was understandably surprised. Sean was concerned abou=
t
dirty scanning performance.

So what I learned then about dirty scanning is that it is optimized for
minimizing the downtime. Before the source TD is paused, there are a couple
of seamcalls to invoke, let me refer to them as prescan seamcalls.

They scan the Secure EPT while the source is running, and mark the
sub-trees that do not have migration candidates as "clean". Then during
the actual final dirty scan in the downtime window, the scan can skip
those entire sub-trees and be more efficient.

Sean correctly pointed out that this would be problematic because on Intel
CPUs the EPT dirty flag is set only at leaf level, and does not propagate
all the way to the root level. However, what I learned is that the TDX
module uses the "accessed" bit instead of the dirty bit in this prescan
optimization - the accessed bit does propagate all the way to the root
level. I thought this was a nifty trick, but obviously it would also mark
sub-trees as "not-clean" on read access.

Now, I personally did not benchmark this optimization, but I heard that
some people did and the results showed acceptable performance.

> It just sounds like if it's doable in KVM, it's still the best place, als=
o
> since GET_DIRTY_LOG is available as long as memslot marked tracking, it
> sounds good to keep CoCo be compatible with that API if it is to be reuse=
d,
> hence GET_DIRTY_LOG API is consistent across coco / non-coco.


Yes, that's exactly the goal and the proposal: QEMU would use GET_DIRTY_LOG
API regardless of the VM type. In TDX guest case, KVM would use TDX-specifi=
c
dirty page scanning seamcalls to implement the GET_DIRTY_LOG API.

Thanks, Artem.
