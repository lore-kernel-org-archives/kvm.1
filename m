Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A33F3233E8
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971080; cv=none; b=bTeAE1XcLG5TAyF+CkFoiu5qy8eh3I4z3cszHoqIZ7pl3G5jAwFqDwEuK0xEn66iKoTp6DYneN3bWfYP1gFkV8Qlz9E58W1+LoKuzFlMScbEVo7QCz86hwmylCmP8dwIGzBQrlRSPNYa57IbwWpq6ybo2kPY1N6OSVzMU4UQCys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971080; c=relaxed/simple;
	bh=2wVADvd0umcFzdWiDJ3FWh71nqjf7PAYIOKCjCWiKCI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RYLs1A0wfSY3TPu10uGzrt/1ko6Ww2FpH1yGFIRPIDD2VUJKLtWL4VNODoZ4laoTG/2vjYvlq6Yy3PCFjgHn1Qohg4AKBM+/JE7FY6R4vTLFu001SGJcgzR6tRZyjjc7K9yW4HDzVgeQoLaoCr0X/p0hbAoOfigvzbaKPBbb414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjL5rWVA; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjL5rWVA"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-823adac76e2so136602a34.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790971078; x=1791575878; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3rUnteK1Oq11SLbLa6kRScfvGLYTXhKfwk4EPFc7Iu4=;
        b=ZjL5rWVA1QWU9+hDNFsrbtEegdJS9bdqy9gXmvdgyOG3KNVosaSxJO+e0jevxFjigz
         g625UTlntRm1MBsKdnPUTtScDGUMoCmRNSbY0GIi0rtVD1RzjzKSGxLwpLgnoAKAgIXM
         Id6RdznKwosCuWEacfS9qNklR9Wrj86dBst6kIiHEdZLrGQd54dgifWO2lNx7ljfJqlq
         a4YaHyETW3uNA3JndCRKlxaPsyWzg3NYvJFu1/PuVEMNsx4Ld8ftXEZLYkm9qm+YapHy
         c5Xns2cJL1u48Ts/VMgb7lxT3yzswrvZBtmwh6tfCDg33bpm1RBc2xvkNU0B24V895Lt
         5f5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790971078; x=1791575878;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3rUnteK1Oq11SLbLa6kRScfvGLYTXhKfwk4EPFc7Iu4=;
        b=Q1ROnqkZNx4AnyZn0YasOExMkTtEOmPKLp5fCTSBWmv2wMPZwzEe4/MBTkM4wLNfBK
         416lAj1ANl0OsDev+2/XDWXGI/f222pHqGkrartTm+hELQ9KyyKDwoR2nVA1osXQJNtP
         W7RVwWhQRzcrk2XDm4FQTMdM7OEdXPRUkfuQmRGX2vk11f4LSULfu+8mj14sKAY8nCHm
         lYsybNJ7oc7YsTdRGDAV9WvfYfONfuNRQIfJ4VMz6kzi+HiApGRnr/1N1lphPhfy14ls
         d/y6/H63u1+UMGNfAHrQSBYL74PCNGVIVWQVjzvjy8AHOadSBvLgEVqTqtxHLJgh5m5Z
         BzTw==
X-Forwarded-Encrypted: i=1; AKwUvByopOWaFyw8xR5p/QKoLoIrObIoCYtkb3a63a+YYXi35e3kMA0R0sCQyAWB5XR0v9Kmh1A=@vger.kernel.org
X-Gm-Message-State: AFuF++mkHoKeP63CtHVxClvs/7oJNJyGwpSm64k0vLTl/3ppn35wAWIn
	Dx0aeNilPSJwjE/5W7RGzAX6a225kOdVLwErSrKVTlXPLnkImY9Dvu/6
X-Gm-Gg: AYBFou3CcsM4lmqtcRmjjL541TRGoR23W+jfG7hsQE/8gHQIkDhHy8liZi1XOYfoC1y
	KpfTAEyvdhtsnS+BWcNMSaMqQjVDcwR83V4fwWI8C/lpprGkTnzaW8+uwM/e/fvgF4kwX4Qq7vi
	C8KktgQjjv48N8iVEHPKlOyg128SDTe7G6hVOi8jXtUt0oDg6N876iHrB6C0NvJ1fuXipX0pdkf
	6C6tqaAuLNfRUjv5ug3p7SxtT86hRnmetZtnDqXqNVpd6edyvtEDv6+HkSWBHd0I3wN/b+iYZnc
	4pTqWsFR8OUGJgHz53AIz1pD1v3dghhB5mVTb75Qsen6xI2STZiohoFZ19zWiyNnS5QhmoN/UUR
	BaAcuFpPfxA0IZEIj5nRIF9BpIAK1pG5swuyOazRJuC7pffPIcAmUe/f7FK2Nnjv6wBoln7oeDo
	cpcnp2Nrj4VsepPz0ycAF90aKfx1EsM+mU29jnlb1eb7bOJBi3q/v/M4sHfUSxOjZ966hgUZER
X-Received: by 2002:a05:6820:7083:20b0:6bd:df1c:23b1 with SMTP id 006d021491bc7-6df33c96e55mr2264083eaf.15.1790971078208;
        Fri, 02 Oct 2026 12:57:58 -0700 (PDT)
Received: from [10.245.245.16] ([192.198.151.47])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-822768d21b0sm3800250a34.1.2026.10.02.12.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:57:57 -0700 (PDT)
Message-ID: <c7d5adf38d6338857f73bb4b3f014a500b4c2fe1.camel@gmail.com>
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
Date: Fri, 02 Oct 2026 22:57:46 +0300
In-Reply-To: <arwoEgUjYR82OrLO@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
	 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
	 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
	 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <f2889dd6e44333b2a5bbd4bd32a4557c3b50a3cc.camel@gmail.com>
	 <arLwnNyM4Tkr-Oh3@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <97c6ab9a9d5527776a580a242b6c8033cf1e9a36.camel@gmail.com>
	 <arWT9fwpCkFneDKn@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <59384511c6070abfd048b37f5ec2831e5f8bb715.camel@gmail.com>
	 <arwoEgUjYR82OrLO@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-29 at 17:05 -0400, Peter Xu wrote:
> > Here is how I saw this, but I may be missing something (my excuse is th=
at I
> > am still new to the team and still learning).
> >=20
> > 1. QEMU has a bitmap of shared pages in RAMBlockAttributes, so it can
> >    distinguish shared pages.
> > 2. In general, QEMU does not distinguish private vs unaccepted pages, s=
o
> >    unaccepted pages are treated as private pages.
>=20
> Yes, the latter seems uncontroversial.
>=20
> The 1st one is true, and it just reminded me if the conversion is
> synchronous and one step requires the hypercall to QEMU, then indeed
> background conversion can be avoided by some form of userspace locking.
>=20
> Perhaps, a rwlock suites, each vCPU takes it for write whenever page
> conversion requested from the guest (private <-> shared; nothing about
> "accepted" that matters).  Then the migration threads, one or multiple,
> take the read lock, lookup the bit, do MEM.EXPORT, unlock.
>=20
> Then it seems fine in general, except that I donno if things can still go
> wrong when there are multiple versions of "if this page is private or
> shared".  Say, minimum of three?
>=20
>   (a) QEMU maintains the bitmap in RAMBlockAttributes, each bit represent=
s
>       if the page is shared or private
>=20
>   (b) KVM should maintain one, looks to me, kvm->mem_attr_array
>=20
>   (c) Hardware / Firmware may maintain its own, in case of TDX, is that o=
ne
>       bit on the SEPT pgtable?
>=20
> They don't change together, AFAIU, they change in order, I believe
> (c)->(a)->(b) if my above understanding is correct.

It looks like in terms of which layer saves the page type change first:

- Private->Shared: TDX -> KVM  -> QEMU
- Shared->Private: KVM -> QEMU -> TDX

In both cases the TD initiates the change. This ends up with a TD exit,
followed by KVM exiting to QEMU. QEMU calls kvm_convert_memory(), which
calls back into KVM (KVM_SET_MEMORY_ATTRIBUTES). At this point SEPT did not
change yet.

Private->Shared:
- KVM first removes the page from SEPT, so TDX sees the change first.
- KVM updates own data (kvm->mem_attr_array). So KVM "gets" the change
  second.
- QEMU updates RAMBlockAttributes, so QEMU "gets" the change last.

Shared->Private:
- KVM removes the page from the shared EPT, updates own data
  (kvm->mem_attr_array).
- QEMU updates RAMBlockAttributes, discards backing storage.
- Back to TD, which accepts the page. This causes an EPT violation, and
  KVM adds the page to SEPT (TDH.MEM.PAGE.AUG).

> Then, what if they report different things?
>=20
> Say, during migration the guest wants to convert a page from shared to
> private.  (c) can be already done saying one page "private" now for TDX,
> (a) tries to mark it "private" too, but now assuming page being accessed
> (read lock held), it may be trying to take a write lock and sleep, which
> means (b) will be "shared" so far.
>=20
> So what happens is, QEMU thinks this page "shared" because the conversion
> hasn't take place waiting for the write lock, however at least TDX may
> think it already "private" instead.
>=20
> Then QEMU logically can access HVA of that page, with (a)=3Dshared,
> (b)=3Dshared, (c)=3Dprivate.
>=20
> Would it cause trouble?

(c) should see it as private only after KVM and QEMU do.

But I am not sure about the entire idea. Holding the read lock around the
export ioctl means that a vCPU requesting a conversion waits until the
export finishes. One export call may cover many MiB of crypto work, so the
vCPU stalling may be significant, right?

Let's check the 2 cases.

Private -> Shared

QEMU calls the export ioctl for a page that it thinks is private, but
meanwhile it became shared. In this case, if the semantics of the export
ioctl is that such pages are skipped, we should be fine, right? QEMU will
just handle this page during the next round.

Shared -> Private

QEMU tries to migrate a shared page, which meanwhile became private. Readin=
g
it would result in zeros or some stale data, right? Would it help if QEMU
used a lock-check_if_still_shared-copy-release, and the same lock around
kvm_convert_memory()?

Artem.
