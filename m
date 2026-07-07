Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A82D36DA0D
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783459737; cv=none; b=UdJx5g4ruw8MkHH8Kdg5u0QcUVSIhmEODAz0c6+2veJpgcZTcW1qU4/kURQ/eLvXvNLi8PWRs12l8TdXdXPnciA5vzK0pRtB5iGJv2Rn1twb8bxxUXZZ6ywsvpTTH8mUPny+78sIqvQaskA4F0RwmJJWAd0WOEP3SIl0SxjcSS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783459737; c=relaxed/simple;
	bh=PwFBE40ERj3S6NiWQaeCHb/x9hw5l+nzBG2YLBSfVcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1AWU464euimZi9qlh63UijcT1nBOGhYveUosyGGmQ79/fvIKvvL0uZI9/mAHCD3jGxi+gol9tWINhKZT6EBPSOcrYWgjLo8sEM366vYvj17IPBnfmrod+sbo8h6i8imD9BG6rJqpUW8uKmg1tIFGuhKGK3RTz9oL+Yr+O9uRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHQmSwpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHQmSwpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288641F000E9
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 21:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783459736;
	bh=k/Nwq7pIMFlergJC4OqMITakfXBO0aZdgHs3udUHgGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GHQmSwpnpuLM4dTKGeCDV28cuPvbLOJit5HD/ywmzLSZHDWdU73ySiN1xZ3dlSVGy
	 vJO9tCccSkno2mQwCO8uKBkGfc863FiAjyfs9LJ9yU/DCXeaoRIEdYH5aDydBF/bgc
	 iyy3NkOoXBrwAEnWH4pkMKJnDAh3e9mN6typRYlqxDJ8P32KQBBi/Cs4SOFNrG07RW
	 s2R9qXr6IAF+8JQlOi891MRenWwjqtELpxxYF57DzeGzUG4H9bE1nKts6tDVIkzkc2
	 7v4ZY4YTB8ZVaTEwozanExfWcDWQ7BUd9hvzmVDRFbyYkZw3aZzKOrieyj43LJoWOk
	 zRzoDpsa+CDNw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-697de23bd7dso23476a12.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 14:28:56 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx7ucRApZpYiPJ7pNcdDHugVzEAzG/jOW72Lw2u6krnwC7CFlIP
	GQs39J6swgMv/8gxS6PYRx3Bb79m4xXlGPpkzkm9eOM6e3nPfWYDuaRbByCznPtvZpp5UC0wAVy
	dQBXHLwaCmXzmA0LCZ1bZr7DzJlmnsBg=
X-Received: by 2002:a17:907:5cb:b0:c12:9b98:209e with SMTP id
 a640c23a62f3a-c15a685954dmr392976566b.23.1783459735056; Tue, 07 Jul 2026
 14:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-10-yosry@kernel.org> <20260616010850.12DE41F00A3E@smtp.kernel.org>
 <CAO9r8zO5cFy-OHLZr3Lkt7-_b0dVz6n_JQAsXuQG1yejXKJUEA@mail.gmail.com>
In-Reply-To: <CAO9r8zO5cFy-OHLZr3Lkt7-_b0dVz6n_JQAsXuQG1yejXKJUEA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 7 Jul 2026 14:28:43 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOmAHc19aT+yWUwVu-Hg9vxtBa4cuHDF+LQ29KQ8mvR=Q@mail.gmail.com>
X-Gm-Features: AVVi8Cdb-zdv1mxiA-lxte3c_j972rG7bsuKxqDiUTeMKYxVuDeZtETKlnv5NvU
Message-ID: <CAO9r8zOmAHc19aT+yWUwVu-Hg9vxtBa4cuHDF+LQ29KQ8mvR=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/25] KVM: SVM: Use a static ASID per vCPU
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 10:58=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Mon, Jun 15, 2026 at 6:08=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] KVM fails to load on systems where all guest ASIDs are assigne=
d to SEV (`nr_asids =3D=3D max_sev_asid + 1`), breaking SEV-only environmen=
ts.
> > --
> >
> > commit 6e1ef9a91f738606e7d8f9e36c1659d383c52061
> > Author: Yosry Ahmed <yosry@kernel.org>
> >
> > KVM: SVM: Use a static ASID per vCPU
> >
> > This patch switches KVM SVM from dynamic ASID allocation to a static
> > per-vCPU ASID to avoid full TLB flushes and simplify the code. It intro=
duces
> > a fallback ASID logic and relies on TLB tag tracking for the pool of
> > available ASIDs.
> >
> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index 5d4c45d788b54..fae5cb7102010 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> >
> > [ ... ]
> >
> > > @@ -5751,6 +5744,17 @@ static __init int svm_hardware_setup(void)
> > >
> > >       kvm_caps.inapplicable_quirks &=3D ~KVM_X86_QUIRK_CD_NW_CLEARED;
> > >
> > > +     /* Consumes max_sev_asid initialized by sev_hardware_setup() */
> > > +     min_asid =3D max_sev_asid + 1;
> > > +     nr_asids =3D cpuid_ebx(SVM_CPUID_FUNC);
> > > +     r =3D kvm_init_tlb_tags(min_asid, nr_asids - min_asid);
> >
> > [Severity: High]
> > Will this cause KVM to fail loading on systems where the BIOS configure=
s all
> > available guest ASIDs for SEV?
> >
> > If max_sev_asid equals nr_asids - 1 (a common configuration for cloud
> > servers dedicated to Confidential VMs), then min_asid will equal nr_asi=
ds.
> > This makes nr_asids - min_asid evaluate to 0.
> >
> > When kvm_init_tlb_tags() is called with a count of 0, it returns -EINVA=
L,
> > which causes svm_hardware_setup() to fail and prevents the KVM module f=
rom
> > loading entirely. Prior to this patch, KVM would successfully load in t=
his
> > configuration and allow SEV guests to run normally.
>
> Is this a realistic scenario?
>
> I can make it such that kvm_init_tlb_tags() doesn't fail with 0 ASIDs,
> and that failures to allocate the fallback_asid are also allowed. This
> will allow configuring all the ASIDs for SEV, and then allocate_asid()
> will fail vCPU creation for any non-ASID VMs. But I am not sure if we
> need to actually handle this.

I will do this for the next version, it shouldn't add significant complexit=
y.
