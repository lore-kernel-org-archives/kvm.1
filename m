Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4E2264D6
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569772; cv=none; b=MhuFDHRDqSh5APQqgvAopRZ1G8/erCgghkWs0VP8bcETVtKeejZPg94BDA8iBTFYJ+Lq5wu/oF9WYKK0KitrSfxmKKH86E+PZibMvQd+LdRErBbdFW9JYuipSRx/HpVKC7PoxNM2/c9ocGiI1hLw1CaXZu2KTkDCUvEhKW0/9hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569772; c=relaxed/simple;
	bh=cO7b3MG4yboFtJsNQrpt1GtzpPAdcgS32+21LFtnCiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhP1Qbs5VUpoH55R2vWM1mLJbgSwNq+t8B8EAePQFdC0P3lvBArGuWgdZDBkiTYoZDUM0hdsshHIsJzjYsN4a0UslcmMyqWKWrfY4PJ4aQatwDkkLTfbcO1AO0/OPnenMYPPjMQ01SWQMBTGKCtgyhalS+d7VX97PUnSwvxLiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdeVohk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdeVohk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D591F00A3F
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 00:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781569771;
	bh=0WqX+XPqxOtZbvPuPykqUScHTwsxUzuTe6+MGhNvGIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cdeVohk8vjXQznlRUKDlbCitb6aweke64sCkheNk1g3ioStMKZBXyCfkX8X/WKlCw
	 jEhxV4fe/8iz8xrZ55RCEZigcCQkM/cPJ/4LoOrpq9KbPiBf6XlmFL3i7oTE57ynxu
	 MEglCvUYkWFZchfzPl+YnaJP8fb0oF8Ps4qLSrizAJIj5O/UbkTfKgPvwFMQLQoZ9Y
	 iGRjmSCTTuBEQoUyyB5d49y7EPEbbaqd1d7x4rO6M/rlD7nMzn4qsrp/ks7FYcSNeF
	 rIAXf3tFuue0drkmkp5zL1MiAThWsXyEANnzMfcCcRw2hatAtBWzA8PQu5zu28TKxN
	 JmWAq6PG4QoNQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68c3421b009so7617613a12.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 17:29:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/nvgeLCHvVtVEiBJz5oFIJw37533RQ/ymPWLyQ5daAnuBhZeTvq8/YKlOMoyCJy/0zNNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQf7TzjWSVjX7huo3gBDmpCQ9n5hc7nmlPZKf1Ux9YOE2oMGsj
	0uwavXUPTXsCwy/gpkeep699Ljoc0RLoEBbggEQ9ipHVfYWxo8VsgDVr7+WOdNg0KIG+TTcWFtE
	gfhMpXgXgJ9Gmy3juqQG31RUraT3Pwgs=
X-Received: by 2002:a17:907:94c8:b0:beb:f357:7755 with SMTP id
 a640c23a62f3a-c0416f223fdmr83100366b.12.1781569770354; Mon, 15 Jun 2026
 17:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612133727.411902-1-seanjc@google.com> <CAO9r8zNa+ueRh0hf-CJ8sdyOFrcF+nEc7S06ZkMmV=GAvum6hA@mail.gmail.com>
 <ajCOzEV6zIVegeWV@google.com> <CAO9r8zNqhUHCs=Q-jWUhQr8VJF7SgL-Kh4Ztji0E5vWpSB2UOg@mail.gmail.com>
 <ajCWvIiTDcYyjC-c@google.com>
In-Reply-To: <ajCWvIiTDcYyjC-c@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 15 Jun 2026 17:29:19 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNc82FoYjnkfNP+P52o8Jv6dnTeZknebiVf_6S-BuFjZQ@mail.gmail.com>
X-Gm-Features: AVVi8CenP8USgYfhNqxOwOk0jtLuOfsoO1oFsadjxniyfvVtghZrTQYdxPE3_ZI
Message-ID: <CAO9r8zNc82FoYjnkfNP+P52o8Jv6dnTeZknebiVf_6S-BuFjZQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Expose number of shadow MMU shadow pages
 as a stat
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 5:20=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Jun 15, 2026, Yosry Ahmed wrote:
> > On Mon, Jun 15, 2026 at 4:46=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > > > I guess for most cases, mmu_shadow_pages will represent either the =
MMU
> > > > pages used to shadow the VM's x86 page tables (with TDP off) or nes=
ted
> > > > TDP MMU pages (with TDP on and nested used) -- but I do remember so=
me
> > > > interesting case about direct mappings in the shadow MMU or sth?
> > >
> > > Yes, there can direct shadow pages in an indirect mmu (guest is using=
 a page size
> > > that is larger than the host, in which case there are no gPTEs to sha=
dow and thus
> > > the gva=3D>gpa / l2_gpa=3D>l1_gpa translations in KVM's shadow pages =
are "direct").
> >
> > I never understood why these are "direct" tho. Sure, they do not
> > directly correspond gPTEs, but they still are shadowing guest
> > mappings.
>
> No, the *parent* is shadowing a gPTE, the child is not.  Overall, KVM is =
shadowing
> a mapping, but individual shadow pages are shadowing a specific gPTE in a=
 specific
> context, not a full mapping.
>
> > IOW, if the guest has a PMD mapping and KVM has some PTE mappings, aren=
't
> > those PTE mappings still shadowing the PMD mapping,
>
> Nope, as above, there is an indirect shadow page with a base GFN that cor=
responds
> to the guest PMD entry, i.e. that is shadowing the huge gPMD.  And so if =
that
> gPMD is modified, KVM needs to adjust that parent shadow page.
>
> But for the PG_LEVEL_4K shadow pages, i.e. the children, there is no corr=
esponding
> page table, no gPTEs to shadow, no gfn that needs write-protection, no pr=
otection
> bits to account for, and no additional lookup to do when getting from the=
 base GFN
> to the final GFN.
>
> See the use of sp->shadowed_translation, e.g. in kvm_mmu_page_get_gfn() a=
nd
> kvm_mmu_page_get_access(), and also commit 9ecc1c119b28 ("KVM: x86/mmu: O=
nly
> allocate shadowed translation cache for sp->role.level <=3D KVM_MAX_HUGEP=
AGE_LEVEL"),
> which optimized KVM to avoid allocating unused metadata (KVM only ever ne=
eds to
> query the gfn and access protections for leaf SPTEs).

Yeah I guess the distinction makes sense from the shadow MMU
implementation perspective, what I was really getting at is that, to
your point, maybe it's best not to expose the direct/indirect
distinction to userspace (unless we already do elsewhere?). Seems like
the distinction (or rather the terminology) is implementation-specific
and can (in theory) change.

>
> > and still need to be sync'd in the same way they would if they were sha=
dowing
> > PTEs?
>
> Ignoring for the moment that KVM never unsyncs PMD+ gPTEs, "yes", but onl=
y the
> parents.
