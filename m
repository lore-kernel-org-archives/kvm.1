Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1FF477E51
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632740; cv=none; b=RpU2mgo7kK04Bj4oQf2O74v9WH0jfML4sy3EtT/QsbsYpdReIw9bPURgIx+/nE4R82bB7KnvJzlHSeFJg+oMehqRaxEnhAf4O3998clhP9v/I3MMgHkvddaywBsJKZePe9GIiePPxbhBDyGgB/YcocZ4zXTdnG1uW7jeMWwjrDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632740; c=relaxed/simple;
	bh=SqilRdnW+fpmB8NMJPTQOu+FxetnUPdPg41LwuuSXfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aH9O8Cln7Bc/s4a0f+Gq/dqZntUm8K8X4FPOhJBRav7hwQFMdgbCU/A/2/W2C03iH/ay31u8bWKBQZ7JiPAjzWGARiDhbATFZ+qSqz4qXN7xER8CtVsd6WoeEf87nI0ytLTXDBmgDgcfk6Z++rh3OYB27qkgORnpl/T3wdzDS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuR44K8F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuR44K8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653521F00A3A
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 17:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781632739;
	bh=qFnO2NNM++1aQPtUh6+XxuJ6kWr8jTAtmcYfh4TOl2s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CuR44K8FthE1QXlEh7WHWS77QPQeoaReAetxGaecc9oJRQhZoWfKgZvvj9LrExHIX
	 svidIHKcFFaCKcZfrhoH2Bo9qbwy3o3U+M/s9tE9whPbCbEXSTeZySdqLCtUjDuWgC
	 7SNaCiKq1jJDCQkadcROl8UFV6520n14Tjo41tQ2yNnRzdNMGjASQv2+fPkuMB1u94
	 4a7Tuamq3zDGfoIafN53EYdtD6FLHt/tdVzFDtD7RpL4nO/zsxus9upOsOLb16j5j+
	 l+s9sfP460Pj8Xf6L1wIOu7Y6yKnHsu5Y4c9hlk/KiBRFrPeUoB6Xt4kygSKTueFfR
	 SJTJ1xjCFVeRA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bef1e6423e7so534220966b.1
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 10:58:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YxWN/BSMxmoyyXVMiVs+fG9/w8v2XeGbS6I83pMG5L41GpVLjwn
	cDRKQPDWTeYv9f1LnTvmEmP3SmfKUSWi67tb3258gKeod0tiArxiDW/rCwyvr53NElb8tJSQ/Ps
	iEiBmOovDny18v0vBHDRS4Xmmk44XiSg=
X-Received: by 2002:a17:907:1b05:b0:bee:d554:f33e with SMTP id
 a640c23a62f3a-c05a5312e68mr51633966b.21.1781632738333; Tue, 16 Jun 2026
 10:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-10-yosry@kernel.org> <20260616010850.12DE41F00A3E@smtp.kernel.org>
In-Reply-To: <20260616010850.12DE41F00A3E@smtp.kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 16 Jun 2026 10:58:46 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO5cFy-OHLZr3Lkt7-_b0dVz6n_JQAsXuQG1yejXKJUEA@mail.gmail.com>
X-Gm-Features: AVVi8CfyEEm_sQXy-4aHKTzwNcBWZVxUlPZGGIlsA_lFsO7D-tfC65FkZ_Lq9sg
Message-ID: <CAO9r8zO5cFy-OHLZr3Lkt7-_b0dVz6n_JQAsXuQG1yejXKJUEA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/25] KVM: SVM: Use a static ASID per vCPU
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 6:08=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] KVM fails to load on systems where all guest ASIDs are assigned =
to SEV (`nr_asids =3D=3D max_sev_asid + 1`), breaking SEV-only environments=
.
> --
>
> commit 6e1ef9a91f738606e7d8f9e36c1659d383c52061
> Author: Yosry Ahmed <yosry@kernel.org>
>
> KVM: SVM: Use a static ASID per vCPU
>
> This patch switches KVM SVM from dynamic ASID allocation to a static
> per-vCPU ASID to avoid full TLB flushes and simplify the code. It introdu=
ces
> a fallback ASID logic and relies on TLB tag tracking for the pool of
> available ASIDs.
>
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 5d4c45d788b54..fae5cb7102010 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
>
> [ ... ]
>
> > @@ -5751,6 +5744,17 @@ static __init int svm_hardware_setup(void)
> >
> >       kvm_caps.inapplicable_quirks &=3D ~KVM_X86_QUIRK_CD_NW_CLEARED;
> >
> > +     /* Consumes max_sev_asid initialized by sev_hardware_setup() */
> > +     min_asid =3D max_sev_asid + 1;
> > +     nr_asids =3D cpuid_ebx(SVM_CPUID_FUNC);
> > +     r =3D kvm_init_tlb_tags(min_asid, nr_asids - min_asid);
>
> [Severity: High]
> Will this cause KVM to fail loading on systems where the BIOS configures =
all
> available guest ASIDs for SEV?
>
> If max_sev_asid equals nr_asids - 1 (a common configuration for cloud
> servers dedicated to Confidential VMs), then min_asid will equal nr_asids=
.
> This makes nr_asids - min_asid evaluate to 0.
>
> When kvm_init_tlb_tags() is called with a count of 0, it returns -EINVAL,
> which causes svm_hardware_setup() to fail and prevents the KVM module fro=
m
> loading entirely. Prior to this patch, KVM would successfully load in thi=
s
> configuration and allow SEV guests to run normally.

Is this a realistic scenario?

I can make it such that kvm_init_tlb_tags() doesn't fail with 0 ASIDs,
and that failures to allocate the fallback_asid are also allowed. This
will allow configuring all the ASIDs for SEV, and then allocate_asid()
will fail vCPU creation for any non-ASID VMs. But I am not sure if we
need to actually handle this.

Looking at the current code, I think initialization will succeed if
all ASIDs are allocated to SEV, but then new_asid() will allocate an
ASID larger than the max supported ASID. Not sure if that will fail a
VMRUN, or if the higher bits will be ignored.

>
> > +     if (r)
> > +             goto err;
> > +
> > +     fallback_asid =3D kvm_alloc_tlb_tag();
> > +     if (!fallback_asid)
> > +             goto err;
> > +
> >       for_each_possible_cpu(cpu) {
> >               r =3D svm_cpu_init(cpu);
> >               if (r)
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616004155.14=
35766-1-yosry@kernel.org?part=3D9
