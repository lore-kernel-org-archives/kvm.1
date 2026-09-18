Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBC434D4DE
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735603; cv=none; b=YLFiX8JxieOoA+RZLvvbJihYvQEDufRrrCpEPL30N+IlPjxpTUQZRKD4VSvqR88aGvs4tAjVW/TXQlwsIjC9+Kgt6wvsyb3EETHBj227ArmqI8Ed5Gdrob47C3Jo8TlOKfaLsRvJv7dVD34hWYzWiLYFo2jO9FicurW0kk0Px0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735603; c=relaxed/simple;
	bh=DL4GB0xdM7vn/vl+LrSt5ozHl+jUFfIPmMSAt1ZlloQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lHlOw3I8WUC2BQZ7E7fJmP+xlNp5TocAyGO1mxWlkaL8oXm87LwJdSRJ/l9lWOc6NDVr+yXi3JId29yf/koimplAbTLK1x8EIYZ8y9OoJ1eTq01hTOlnWyIdS0PueGrBaE1CMAqtAt1RXrNQ1VRaXU3RLI9C5JciET79kx83tA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aklzLC15; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aklzLC15"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso3738655e9.0
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789735597; x=1790340397; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dXattkTHG5g702ST/4gVZY4WYbu+TYgaSIkhBnqPELE=;
        b=aklzLC15Z2QIskBlFLg7sHTB4uqvM/K7NVgVu3cXoMNoFUGFnxr6q3abluvYwnBDhQ
         zoL5ISPy/H0nTAndD4LXE6zqeaYSawgJe6WBfYUfSDyAa+JADV0W/D3XH+8iDOB0Vix1
         20q+27/FORyfzl0nE0d6nsKsaTwteK9BvX1SdbB2JGpYHmbe/8ghGZq6/anko7vORayH
         AC5hkxYKVPwkAbRq3LzP/jBH8nVB3itDEj9uxWeXaXSS/IHbMlSRP8/Pz26kYOGiMKaD
         flYjROzg09jxmZww73qS+Dw46trfnsdyI0AAJg+bIHkddILaV2JuQPl3bt+1kwtBveCl
         /AYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789735597; x=1790340397;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXattkTHG5g702ST/4gVZY4WYbu+TYgaSIkhBnqPELE=;
        b=AhcpqScmKM1E+/n6QFdzSu4FWKnxkHLSDQZ6cIhQfMF3pHoJM8AGXbW+6pe/d90O6E
         TU4XD2ycthzQ1FjLBXRNsWXNsFgyUf57iLgkA3vwhJn4EvePZ/A7/lGfDMSqv4PLAzMv
         rho/FBgkJOcc/VB32Zc3Xs52UJm/GeWtNCfIVtdRj2yYWjA6tt1Sk0ncrCF11kFBo4qt
         DrRzzFCMlX/xOgnBkFBXagwnXWkM1QeAwZkzdt3COrNCbJOKtoKDSrypFN2dFnisAjE7
         AgGM33zy/FTIekmVOgxVjMqa+oFLSvFF0nOf2XZDBF/NbBuEIDH3zMvsGPeAPYjwRWCr
         RgHA==
X-Forwarded-Encrypted: i=1; AKwUvBw6/ROcVgmul8vZ4HY9oNR9jNuwz8kZM9iylqAM2Ga9nKe1akTMJVIkhCmOlY8ryei6duA=@vger.kernel.org
X-Gm-Message-State: AFuF++nENY/ASHF/XrBv+zS/y91+3n9/yxz7SmfyvdfvykX16BYYwlkl
	T0TSXrANccwMlzLG2q4VhYOgNvSJgVtOP/17aMvIQO4k+93fBmYzKdfy
X-Gm-Gg: AYBFou1tKf6bIe4G3UiLoNldhd2ueNXPqs9BwD3PeOQ9Be5jcg2bVqb6YlWpN/C/iJm
	VicOloanFmMbOJ6/4baXpd1GC+gd2JnT7tFRpNtKWh5RKdUWb45yiNd/+tEucCTe/wYbstPdy9T
	+t+mP/xooK911/gcrPQGUfzTywgTfCy1yVI3LAAR68Af02UsB3EQWbgcgki3IGcTpBofTlPrrPw
	dcTJ3YNIorj2JTqQzssExkRbEx7W6D1KyC5vOhxNM4K/ic1CToUoXEGDwTJmLiU4wjqbOYfJnmA
	UlvZntWXQ1FMN33+yRImC++45O1Y9DHwL9xECYlOqK2MaWnpH+e0+kdj2bo1dakwjGriSh+pZLA
	CE2Je4n5zNMZPHkJxsLnjGsKRUBGR+NtH1nSN87Pgvl3zLkv3rNpWkCQxbQwe+OrtWGwOLRzjka
	3NnitI2hf/S8Wk8z4M7sBmuMHdy2fZQlBaOJ5UhyTRmCphaxoknZI7O5TiQmb0I0NWRhlb3oqAI
	oBwXMruKpLa
X-Received: by 2002:a05:600c:1989:b0:49c:e42b:a4ac with SMTP id 5b1f17b1804b1-49fc5714d14mr32315685e9.11.1789735596939;
        Fri, 18 Sep 2026 05:46:36 -0700 (PDT)
Received: from [10.245.245.176] ([192.198.151.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc6ca43edsm53201935e9.0.2026.09.18.05.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:46:36 -0700 (PDT)
Message-ID: <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
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
Date: Fri, 18 Sep 2026 15:46:32 +0300
In-Reply-To: <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
	 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
	 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Peter,

thank you for your good comments and questions. A quick disclaimer before I
address them. In my answers I try to keep three distinct things separate:

1. The CoCo migration uAPI - the generic interface we ultimately want to
   converge on. This is the end goal, not necessarily what these patches
   propose. What is good for this uAPI is my priority at this point.
2. The TDX migration model - the mechanics offered by Intel TDX module for
   TDX guest live migration today.
3. Our PoC - a concrete uAPI proposal and its example implementation for TD=
X
   guests.

On Thu, 2026-09-17 at 17:27 -0400, Peter Xu wrote:
> > Some example high-level topics that would be nice to get feedback on:
> >=20
> > - Can we come up with a single set of generic migration uAPIs for diffe=
rent
> >   CoCo models?
> > - Or should some uAPIs be generic while others are vendor-specific?
> > - Or should each CoCo model have its own vendor-specific set of migrati=
on
> >   uAPIs?
>=20
> It's always good if we can put together as much function to be shared wit=
h
> generic ioctls as possible.  At some point, IMHO we need to collect such
> information somehow, so when merging the generic API we know what vendor
> specific API will be needed.  Hopefully this series is a good start.

Thanks, agreed.

On that note - does anyone know of a good doc describing the AMD, ARM, or
other CoCo migration models? My knowledge is limited to TDX, so it is hard
to tell what is common and what is TDX-specific.

FYI, I am working on a TDX migration model document. It describes what the
TDX module offers, but unlike the specs it is oriented towards software
engineers: much easier to read and it does not require deep TDX knowledge.
It is all based on public specs, just distilled into readable mental models=
.
I plan to publish it publicly. I am about 80% done.

> > - Should the same uAPIs also support traditional VMs? But the only use-=
case
> >   I imagine here is "for testing purposes".
>=20
> This is an interesting idea, I think this could be useful.  Especially, I
> wonder if you already have it done and PoC branches you can share, so tha=
t
> I can play with it.

We do not have code. But Kishen spent time playing with it, and I think he
concluded not to proceed with this. But he might have evaluated it from
the "unify all migration into a single generic API" perspective. But may
be as a "this is a test framework" perspective is different, at least I fee=
l
it may be the case. I think Kishen can provide more insight if needed, he
is=C2=A0in CC.

> >=20
> > > Migration flow
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > >  Source host                                      Destination host
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                                   =
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > >  CMD(SETUP/SESSION)          <--- setup msgs ---> CMD(SETUP/SESSION)
> > >        |    (repeated)                                  |
> > >  CMD(SETUP/IMMUTABLE_STATE)  - immutable state -> CMD(SETUP/IMMUTABLE=
_STATE)
> > >        |                                                |
> > >  KVM_GET_DIRTY_LOG                                      |
> > >  KVM_EXPORT_MEMORY           --- memory data ---> KVM_IMPORT_MEMORY
> > >  CMD(ITERATION)              --- epoch token ---> CMD(ITERATION)
>=20
> Could you elaborate this ITERATION operation?  Is that something the
> userapp must do after full scan of a round of guest memory?

=3D Why no duplicate instances? =3D

First, let me answer the "why" question you asked further below: "why does
the TDX module require that only the source or only the destination runs,
never both?". Answering it first makes the tokens easier to understand. And
the tokens are why we proposed the "ITERATION" operation.

I believe this is not TDX-specific, it is a confidential computing
requirement. In short, cloning would give the VMM a very powerful primitive
to attack confidential VMs. Here are a couple of example attack approaches:

- When you attest a CoCo VM remotely, you get an assurance that you talk to
  this one specific instance. If duplication were allowed, many instances
  could exist, and that assurance is gone.
- With a clone you can security-upgrade the state of one copy, attest the
  upgraded state, and then use the pre-upgraded copy: the user believes the=
y
  are working with an up-to-date CoCo VM, but in fact use an older, possibl=
y
  vulnerable version.

This is also why TDX migration requires that not only must the two copies
never run at the same time, but after migration the destination must be
exactly the same as the source. For example, the destination must not end u=
p
using an older copy of a page.

=3D ITERATION Operation =3D

In the QEMU model, the pre-copy phase is a set of rounds:
1. Get the list of dirty pages.
2. Copy them to the destination.
3. Repeat until the convergence criteria are met.

ITERATION is the explicit uAPI that ends the current pre-copy round. There
is no equivalent uAPI for traditional VMs today.

In the TDX model, ending a round needs an extra step: the source generates
an epoch token, and the destination imports it. Two seamcalls do this:

- TDH.EXPORT.TRACK generates the epoch token on the source.
- TDH.IMPORT.TRACK imports it on the destination.

The token enforces integrity and ordering, for example:

- Every page exported on the source must be imported on the destination.
- Once a newer version of a page is imported, an older version can no longe=
r
  be imported.

The final round is special. It uses the "done" flag, which is passed to the
`TDH.EXPORT.TRACK` seamcall, and makes it export a special variant of the
epoch token that is called the start token. On top of the integrity and
ordering guarantees, the start token is what allows the destination to
start: until the destination imports it, the TDX module will not let the
destination TD run with partial state.

> > >        |    (repeat until convergence)                  |
> > >  CMD(STOP_AND_COPY/PAUSE)                               |
> > >  CMD(STOP_AND_COPY/TD_STATE) --- VM state ------> CMD(STOP_AND_COPY/T=
D_STATE)
> > >  KVM_EXPORT_VCPU             --- vCPU state ----> KVM_IMPORT_VCPU
> > >  KVM_EXPORT_MEMORY           -- final memory ---> KVM_IMPORT_MEMORY
>=20
> When read/write encrypted memories, two questions:
>=20
> - Is there an upper bound of the buffer size per-page?

So generally, the assumption is that exporting N pages requires M pages,
M > N, because there may be some metadata (e.g., MACs for integrity
checks). In case of TDX module, M is predictable and can be calculated in
advance.

I believe in our current PoC, the ioctl requires the buffer size to be larg=
e
enough to hold all the requested pages. But this is specific to our current
PoC implementation.

In general, I feel like if buffer size is not enough, the uAPI could fill i=
t
with as much data as fits, and communicate back about what GPAs were
exported. The caller could export the rest separately.

Context: I am new in the Intel TDX live migration team, and did not
participate in TDX PoC, that's why I use "I believe". I am catching up. But
I assume others will (Tony, Kishen) will correct me if I am wrong.

> - Does this operation supports concurrency?  If it supports, how well it
>   scales per expectation (e.g. is there known big lock for that)?

From the TDX module perspective, parallel exports of different GPAs can run
on multiple CPUs, so I expect the QEMU multifd model to work and scale.

In our current PoC the ioctl does not take a VM-wide lock, and concurrency
is per-stream. I can expand on the stream concept if needed, but it is
exactly about parallel import/export of memory and vCPU state.

In our PoC we are focusing on the basics, but multifd support is definitely
a goal too, just later. Kishen was already prototyping it in QEMU.

From the uAPI point of view, I believe parallel export/import should be
allowed. If a specific CoCo VM has issues with that, it would need to
serialize the operations internally, I'd say.

> - Does this operation supports concurrency?  If it supports, how well it
>   scales per expectation (e.g. is there known big lock for that)?
>=20
> Similar question to the vCPU getter and setter.  For now even without CoC=
o
> we serialize vCPU get/set, but I want to understand the potential of
> concurrent operations, and see if there's anything special for CoCo from
> that regard.

Similar to memory import/export: the TDX module explicitly allows vCPU stat=
e
to be exported and imported in parallel.

Our current PoC does not take advantage of this yet. vCPU export currently
grabs the KVM MMU write lock, so vCPU exports are serialized today. I think
Tony can comment more on the technical difficulties there.

From the uAPI point of view, I'd propose to allow concurrent vCPU
operations.

> >=20
> > It describes what the TDX module offers today and focuses on pre-copy
> > migration. This is our interpretation of the TDX specifications, not a
>=20
> IMHO we should really take postcopy into account when designing the API a=
nd
> state machine.  We don't need to implement it in the first version, even
> until merging, but we need to make sure postcopy will be new ioctls on to=
p
> of existing and it should have no major loopholes that it'll need a new s=
et
> of APIs.

I totally agree. I have not yet dug into the TDX module implementation
details for post-copy, but I know it is supported and I know the basics. I
plan to study it in detail later. So far I have not noticed anything that
would prevent adding post-copy on top later.

>=20
> For example, I think we should consider KVM_EXPORT_MEMORY being usable
> after END on source, KVM_IMPORT_MEMORY while TD is in operation, etc.  We
> should likely also need to still picture the rough process of postcopy,
> reserve those APIs since the start (but return -EINVAL or something).

Yes, agreed. I will spend more time looking at this. But at this point, I
just assumed that the proposed uAPIs can be used at the post-copy phase in
parallel with on-demand page delivery.

Just FYI, TDX module model allows for this, but we did not try it.

>=20
> AFAIU, postcopy is so far still the best solution for extremely large or
> extremely busy VMs regarding user experience, and it will happen to CoCo
> VMs one day or another.

Sure, thanks for sharing.

> >   destination may run, but never both. In other words, cloning a TD is =
not
> >   allowed.
> > - When migration completes, the destination must have the same memory a=
nd
> >   vCPU state as the source. It must not end up with a partial or mixed
> >   state.
>=20
> If such happens, it's definitely a bug, even without CoCo.  Anything
> specific about CoCo?  Like, whole-VM checksum?

Well, in CoCo VMs it is not just a bug, it is something the CoCo framework
needs to make impossible, because VMM is considered to be untrusted, it can
try to manipulate things and half-migrate, use it not as a bug but as attac=
k
vector. In TDX case, the TDX module will not allow you to run the TD - the
TDH.VP.ENTER seamcall will fail.

Regarding checksums: there is no single whole-VM checksum in TDX migration
model. Instead integrity is enforced continuously - every exported blob
carries a MACs that the destination TDX module verifies on import, and the
epoch/start tokens guarantee that everything was imported, in order.

> I want to understand what is extra for a CoCo VM in terms of "pause", say=
,
> what's more than "stopping the vCPU threads".

TDX module guarantees the source won't run, even if VMM tries, the
TDH.VP.ENTER seamcall will fail. So the source TD state is effectively
frozen and cannot be modified by the VMM.

>=20
> I saw there's mention of PRE_COPY_STOP state.  One example question is,
> when reaching this state, can the guest memory still change?  What happen=
s
> if some emulated device are still DMAing to the guest memory (assuming
> flipped from private to shared)?  In case of future IO zone support, what
> happens if in case of VFIO-PCI assigned doing encrypted DMA?
>=20
> From that regard, VFIO has the P2P state where it quiesce initiation of a=
ny
> DMA from this specific device, then another round to fully stop all devic=
es
> into STOP_COPY phase.  I wonder if CoCo VMs need similar treatment.

Let me split this by device type, because TDX treats them very differently.

Emulated (virtio-net, virtio-blk, etc.) only use shared memory - they canno=
t
read or DMA into TD private memory. So full device state lives in shared
memory, and QEMU migrates them exactly the same way as for a traditional VM=
.
This is entirely outside the TDX module migration model and outside the
proposed uAPI - the uAPI is only for TD private memory.

Directly assigned devices are only possible with TDX Connect, where a
physical PCIe/CXL function (a "TDI") is assigned to the TD and can DMA into
private memory over a cryptographically protected link. This is not
implemented in Linux yet. For migration, the TDX module requires all TDIs t=
o
be unassigned before the source TD is paused - the TDH.EXPORT.PAUSE seamcal=
l
actually checks this. Unassigning a TDI tears down its whole TD-private
footprint (MMIO unmapped from the Secure EPT, trusted DMA mappings removed)=
,
so no device-specific state is left to migrate. From the TD's point of view
it is a full hot-unplug on the source and a fresh hot-plug on the
destination.

Our current TDX guest migration PoC is built on this assumption.

> Could you elaborate what's the relations between TDH.MEM.SCAN.RANGE and t=
he
> GET_DIRTY_LOG ioctl?  I recall above mentioned GET_DIRTY_LOG will be
> available even for CoCo, which makes sense assuming dirty information isn=
't
> confidential.  However then I don't understand what TDH.MEM.SCAN.RANGE
> plays the role here.

A few things here.

First, our plan is that the standard GET_DIRTY_LOG ioctl is backed by the
`TDH.MEM.SCAN.RANGE` seamcall - that is how dirty tracking is implemented
for a TD. So we do not propose any special uAPI for dirty tracking.

And I think you are right that the dirty information is not confidential -
the TDX module exposes dirty page information to the VMM.

Second, FYI, in current TDX migration model, dirty page scanning
(`TDH.MEM.SCAN.RANGE`) is only allowed during a migration session. The TDX
module returns an error if the seamcall is issued before the session is set
up (i.e. before the source and destination TDX modules have exchanged the
migration key and established trust - what the SETUP command does in the
proposed uAPI).

In other words, with our PoC, if someone tries to use GET_DIRTY_LOG without
going through the migration setup - the ioctl will return an error.

But I wish it were an independent feature instead. Then we could work on
upstreaming it on its own - Tony estimates it is about 20% of the current
TDX migration PoC code.

I already raised this with the Intel TDX module architects, and they asked
for use-cases. The only one we came up with is QEMU estimating the TD dirty
rate before starting migration (the calc_dirty_rate command). I understand
their position: without a use-case there is little reason to implement it,
and they would also need to study the security implications - can it help
an attacker in some way?

So if you or anyone else can educate me about use-cases for independent
dirty page scanning, I would really appreciate it - I could take them back
to the TDX module architects.

Thanks,
Artem.
