Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431CC531638
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165148; cv=none; b=Qo3yO4I/jdYRfkmbIN73YSRRUXbEx5kQNE7Bij6C5qAX4Njt5zG188k3huPIO+kgYvN+o6s0ER+Wd1fJSey2sjSrmAKolyIJdEpIFTojl/ygrS4OhZwRtKG03Ay7myb3BPlK2G1wCoLsXQxrMe8xVlo2m3Y3h4LUfwru05dKMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165148; c=relaxed/simple;
	bh=qVQasIL8+FkPYCII26Q3qBByP54S24792rXaW2l1l6U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AoM9Ltxg6Qd620sWnlMcV2DNG/8h3cVy1Dqs6be4bkyYuNJVfoJa5y1/E3g/H3tBhE6gHTpoxGBDLjgbQvK9u5jXiOWZTq6kAdNuuD1KrLH0HAwPxB0GqwRUTilA+Xah44R/Wf2dfG9A6bnhN/zYdoe/AoZe3uK8HFDDNSh+XYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAneSv7D; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAneSv7D"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c20ce3c118aso138520866b.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790165144; x=1790769944; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RyGhYMA9/NbI4/R5Va8XESSRVD8O5kDg9QJr8Feyn9U=;
        b=UAneSv7DCaL/agZvqmtviJQDti52FuWDr6PO4Ex8BAg0ftVdpmA4FFnX0Zxcc2zCxw
         owO0XOHDRFeI4hiX+i507rdWAkk/1Oerk2R0iyDaGNyTB+xZUH+isgTJy6sv1YL5KLgo
         5s4JWHlJYweLKil8EuWX6mlg0Ou6RpM8+aplmgxLGkHMvVNHdXak0yE00izStzqPlYBk
         +Q0xNwAFzZExh5Z1zf5/MOb4T+1GRQuCZe5upVHNj3nGe8tXdhmKZR0Izi31+Ov/Bm4H
         asc20S2wBhZyNekur7G86xqWQdZhz+VlzYTMOczFK6iMs7MAENx0hIqgwvoILSaTbdb1
         K99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790165144; x=1790769944;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RyGhYMA9/NbI4/R5Va8XESSRVD8O5kDg9QJr8Feyn9U=;
        b=wi80I8ArWk9m8UBiEm4sAiMR5tYI3DmSiav89/eEQXJmdNuftAe22fSPvlee2HVL+m
         PaiDur6lzXfs4LJ8vPDLtaMpc7FMjSURUFwBT1FuUOBwjGwkPk8nLU1JrUuYlngv1GgL
         r2HaO5WET2QrG/Tt62XjM0+IUXiN7SMtEOjRUJFV4/fUzlcajRH07CU37jxy3ynxDdgK
         s1rpKRNkNt5jGnUO2HLD5ziIF/5SOTAQQ2T+Y+b21BILPas4uC0rtEHV/5OUiY9Vno9a
         ESYKLZJ0sIO3J1nsDBRnglCPSR86+nvOEx6/4T6J1o+woGDTq0eHgaP0rKgBeEEj58gD
         DzPA==
X-Forwarded-Encrypted: i=1; AKwUvBwuCyklkyCJ3dJZjY3UVaQF4DEtgKW5Qsg98lI46pGWJXxWQIGSz2eZpk7LSu1iuaOM8sk=@vger.kernel.org
X-Gm-Message-State: AFuF++lWeiGgiTmo3BIIq1XNQrard6NSGjeIlo9MSq6+sVvn2G+3YiSm
	HgS26CCq2J4MCdfRD4H1E3kNlGtrfMxA6rUZhFNCNsoLee2ZMnaqkk+H
X-Gm-Gg: AYBFou2RwdF1SNwkGJzgIMBcHlID5VCt74W6DcWaFrS3B5wGHcScJo480JaQ0lhvwxE
	T/5dqsc1bEwATiM/zwFm1+8to9PaeOLiMf34c2ln2ghHhJ9w14/H8i59l5ldiUhPygDll1cNm7n
	jS0XcpWOAt07ciFO2rs4TIXaOhMTdmUDxxDOk1LVAegC5wf92knyuGL36z4NTMF1smCyrcmYblf
	0QHCqLziPNhFzy9N+/p5k+4Dg8tsNUb18GEJxQK5sXxHAhKKZVkLwwYuMuFd/Wa7O5HZFSR4YFc
	kD6CNRdv+XMmay8knMusruBNdq9kcu/wDx0uJ6TaZeVpfUoizwoqGGicJAnb2wZUhCy/qV+UyjK
	06CP95Lf84VE5ashy4UFZseHR/7w/xu+rW9VtM2ogRyKhV1JVEmzY30BlON3TuOPy6EcvmtwVNe
	+du15iPiWRHCgB5yufzADa51nasZvoy36sGYNQ6kRmAdjocwluetY86BNLg+P1TIiyNV7MdOkaM
	/c=
X-Received: by 2002:a17:906:8d8b:b0:c26:1cfd:4244 with SMTP id a640c23a62f3a-c2a8d51eca2mr500630366b.11.1790165144071;
        Wed, 23 Sep 2026 05:05:44 -0700 (PDT)
Received: from [10.245.245.205] ([192.198.151.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6a4adasm107290566b.47.2026.09.23.05.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:05:43 -0700 (PDT)
Message-ID: <97c6ab9a9d5527776a580a242b6c8033cf1e9a36.camel@gmail.com>
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
Date: Wed, 23 Sep 2026 15:05:38 +0300
In-Reply-To: <arLwnNyM4Tkr-Oh3@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
	 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
	 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
	 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <f2889dd6e44333b2a5bbd4bd32a4557c3b50a3cc.camel@gmail.com>
	 <arLwnNyM4Tkr-Oh3@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 17:18 -0400, Peter Xu wrote:
> > thanks again for good comments and questions.
>=20
> My pleasure if I helped anything at all.

Honestly, yes. New insights, and even commenting on questions makes me
research more and dig deeper.

> >=20
> > Now, the limitation here is that if the abort is because the network
> > connectivity is lost, the abort token cannot be delivered. Then I'd gue=
ss
> > migration should stop, without destroying the source and the destinatio=
n,
> > and the token should be delivered later manually, QEMU could even provi=
de an
> > infrastructure / commands for that.
>=20
> Heh, this reminded me of postcopy recover that QEMU supported for years:
> not a trivial feature at all, people always want it to be there, but I'm
> not sure who is using it at all in production..
>=20
> Especially, normally who cares about migration will provide dedicated and
> reliable networking for migration purpose, so the failure will be even mo=
re
> unlikely.  Meanwhile who doesn't care enough, may simply crash the VM at =
a
> postcopy failure and reboot.. not bother to recover.
>=20
> I bet rarely people will hit a network failure happens exactly at
> forwarding the TDX START token to destination host, similarly for case (2=
)
> on ABORT token lost.  But yes, likely this is required to make the whole
> thing complete.


Thanks for the insights about users who really care about having a reliable
dedicated network.

I would like to make sure I understand correctly though. You refer to QEMU
post-copy recovery, which is basically all about restoring network
connectivity and finishing the migration. Is this right?

And to make sure we are on the same page, here is how I see things at a
high level.

1. Post-copy recovery is about handling the state split between source and
destination. I think this aspect is going to be similar, if not the same,
for traditional and CoCo VM migration. Same problem, same recovery
strategies, I'd guess.

2. The abort token stuff I discussed is about pre-copy. It is an artifact o=
f
the switchover: when src is paused and dst is allowed to start, an abort
token is needed to reverse this process. And whether post-copy is used or
not is orthogonal to the abort token stuff.

Did I miss something?

>=20
> > Specifically about TDX - the pause seamcall will return an error if TDI=
s
> > are not unassigned.
> >=20
> > While this is something that is not implemented in Linux yet, I believe=
 the
> > model will be that there is some uAPI to unassign TDIs, and it is not
> > related to migration. QEMU would just need to exercise this uAPI at the
> > right time.
>=20
> OK, this sounds working, but then it means the migration will be visible =
to
> the guest.  I wonder whether there's any attempt to make it more
> transparent, but we can also leave this question for later.

Correct. With a disclaimer that I am not a TDX Connect expert, I had the
impression that this is more of a compromise solution. The VMM is an
untrusted entity in the CoCo model, so the trust between the TD and the
PCIe/CXL TDX Connect device is built by the TD itself. It is the TD
establishing the cryptographic trust with a specific physical PCIe/CXL
device. Directly, not via VMM. This is part of the industry standard SPDM
protocol, which stands for Security Protocol and Data Model.

As I understand it, with the current SPDM protocol, this trust cannot be
transparently moved from one host to another: the destination host has a
different physical device, with different cryptographic keys, and the TD
would need to re-establish trust explicitly. VMM cannot do it on behalf of
the TD in a transparent manner. I would only speculate that this means
preserving the device state is a hard problem.

Maybe future TDX Connect and SPDM revisions will solve this problem, but fo=
r
now, this is the compromise solution we have.

But again, take it with a grain of salt, it is more of my intuition than
based on concrete knowledge.

> > The reason I am asking is that my assumption was that it is not importa=
nt.
> > But if it is, I will come back to the TDX module architects with a
> > request to revise the design to support independent dirty page tracking=
. Of
> > course they may have some reasons for not doing it, but I would try at
> > least.
>=20
> Thanks, I'll talk to our team and revisit this after I collect answers.

Many thanks!

> > Now, I am diverging, but just in case: in the PUCK call where we presen=
ted
> > TDX migration, Sean made an immediate observation that WP-based dirty
> > tracking is not categorically worse than PML-based dirty ring tracking,=
 it
> > depends on the workload.
>=20
> Hmm, I was expecting PML is still superior in most cases.  For "depending
> on workloads", is that perhaps when (1) huge pages are used, and (2) the
> workload writes only a small portion of guest memory?

Sorry, I did not communicate it correctly.Sean did not talk about huge
pages. I need to be very careful here. What I think was Sean's point is tha=
t
VM exits forced by the WP-based dirty tracking cause "back-pressure" as he
put it, meaning they work as a natural way to slow down vCPUs and improve
migration convergence. PML-based tracking does not cause as much
back-pressure, so, depending on workload, they may require artificial vCPU
throttling. But disclaimer, this is not a cite, this is my interpretation.

> > Then he learned that TDX module's dirty scanning does not use PML, and
> > was understandably surprised. Sean was concerned about dirty scanning
> > performance.
>=20
> I'm definitely surprised too that PML isn't used.  Could I ask if there's
> any simple reason not to use it for TDX?  Per my understanding, PML works
> with all kinds of loads, and I was expecting PML to be efficient and most
> ideal.

Another point where I need to be careful to not miscommunicate. The honest
answer is that I do not know for sure why PML specifically was not chosen.
Please take my comments below with a grain of salt - I am a software person
who tries to understand the design decisions made in the TDX module, but I
am not a TDX module architect.

Current Intel processors do not support PML for DMA - a TDI's DMA writes
would go untracked by PML. But they do set the Secure EPT Dirty bit, so
scanning works for catching both CPU and DMA writes.

My speculation is that once non-blocking scanning had to be built to cover
the TDX Connect case, it made sense to use it as the single mechanism for T=
D
migration in general.

AFAIU, the TDX guest migration implementation benchmarking results are
satisfactory with the scanning approach, but I do not have hard numbers to
share. I also feel that PML could offer better performance, at least for
memory-intensive workloads. But this is intuition only.=09

> Another approach is if TDX can take over the bitmap buffer from the
> relevant kvm memslots, update directly there alongside setting D bits in
> EPT PTEs; after all IIUC we assumed dirty info not part of confidential
> materials.  But that sounds more complex than PML if it's already working
> for years.

Well, then the dirty bitmap specifics would become the ABI - the hard
contract between the Intel platform and the OS.

But this is effectively what TDX module dirty scanning does already today:
on input you give it an array of up to 512 GPAs, on the output it marks
which entries are migration candidates and also for what reason.

Keep in mind that dirty pages are the majority of migration candidates, but
not all of them. Sometimes a migration candidate can be a page that was
already exported, but then was, for example, converted from private to
shared, or unaccepted by the TD (gone, in other words). In this case the TD=
X
module flags it as a migration candidate too. The memory export seamcall
treats it differently too - instead of exporting encrypted page data, it
exports a small record indicating that the page has changed its status
(gone).

IOW, in the TDX migration case, it is not just dirty pages. In an abstract
way, it is useful to think of it as the TDX module tracking both page data
and metadata changes.

We (me, Kishen, Tony) call them "dirty pages" for simplicity, but TDX specs
use the term "migration candidates". But again, most of them are dirty
pages.

> The current scan approach sounds like unpredictable in terms of downtime,
> in that even if with a scanner I don't see how TDX can guaratee the
> downtime for the last dirty sync from QEMU, which will completely be part
> of the blackout downtime.

Could you help me understand exactly what you mean by "predictable" here?
Let me walk through how I see it. Please correct me if I am wrong.

For a traditional VM: at some point QEMU decides that pre-copy has
converged. But the source VM keeps running until it is actually paused, and
it can dirty more pages. QEMU has no way to know in advance how many more
dirty pages there will be by the time the source VM is actually paused -
could be a few, could be a lot. So the time it takes to find and copy them
during the downtime is not fully predictable.

The same logic applies to a TDX guest using dirty scanning. Suppose the
final dirty scan is slower than a theoretical TDX PML-based approach would
have been. The prescan optimization I described in the previous e-mail
should help with this in an average case, but let's assume it does not
help for some special case - when the TD touches most of its memory, so
all EPT sub-trees end up touched. This should be rare, but let's assume it
happens.

In this case, whether that scan slowdown will actually matter for the
overall downtime also depends on the network. If the network is very fast,
the scan itself can become the dominant part of the downtime. If the
network=C2=A0is the slower part, the scan slowdown may barely matter.

So my understanding is that downtime is never fully predictable, for
either type of VM.

Intuitively, the TDX case does feel "less predictable". The open
question for me is whether the degree of unpredictability is large enough
to bother users. My attitude is to focus on getting something simple done
first, learn from real-world behavior, and improve it later if needed,
including exploring PML. The best is the enemy of the good sort of
attitude.

> Whenever switchover decision made, QEMU stops the VM, do the last time
> sync, move anything left.  So that last one will matter a lot if we care
> about downtime.

Could you please help me understand: in your experience, how much do users
care about the overall migration time?

My current assumption is that users mostly care about downtime, and care
little about the overall migration time. I guess nobody wants migration to
take days, but if it takes, say, 10 minutes, I assume no one would put in a
lot of effort to improve it to 9 minutes.

Thanks, Artem.
