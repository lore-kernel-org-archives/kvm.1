Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09A33E558C
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014233; cv=pass; b=X6qaYD8ZQ3yxwJVOy/42OwAsA6rHBlngzCv6rVSPLFCNk0MyMLJIAXZMP6PqBx+yRlMPM2ILmvdpwih8V270PfNEWWwbQDv0keSlv9rOeDyBZbslogpnsr31WumdLA4I4uiaJOBbaG9yTuQi/Ci4IoRTEabKFEj1+6XPqlWq0q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014233; c=relaxed/simple;
	bh=oiL+B2h6AuSfY8Rv3bYul6pnOV2F8Xe1GqK5pQzx4so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9CvugywJyhqvTgUcA7qqZyKDouQWxAQKVO3Ae/4bAc6ybpFYRViMdIJn2CUo/SXcbwMvxrcQNrAcWVLxV5wRo/GnFKFypn/1Nr7Dymo4hflMcNU1peKaD9JINKyhwCor7NP+O6aGyd/A8xD1y9QWzmlebprP0O0C2sM6dQFH1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y2zRExfB; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y2zRExfB"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-448b89f700fso1931504fac.2
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 04:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786014227; cv=none;
        d=google.com; s=arc-20260327;
        b=kGpsyIm3kb0vLanD0bYvAqqDlPqQdyaimqnwrkGzj5OpAv204MNt21pAcqZk+d/TxM
         ovX5zUK9r0lxO9wR9RTB3dXg7c01UTPhZBSzKhgviBVLL0JgeBGUbct4BcVW/oJOFV0+
         9lduYA0/1MP7UypILlHwqw8RyvIDJ5PrL9CydkXbTG8USSuhcUt8/UB70LoXr48Qojbt
         DuUP1DgXhoNxSp6sRx07ax9P/UOIobQhdqs0V0wTU0HAjBJ4B0aU/0cVAuTBMRy3WHOF
         B+fZ5rLVcM0eSgLCdiTOo2G3yEIqCS/PMnDDsR1RYUuAIq8E4bofkAHWWpHNX45QxvXP
         Ol/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kMaEeVh+/U+NbRzoGC8Idgo7QP/ahOzSH8HwXGJHBcU=;
        fh=sMuvlkk/wvYcJod/7viaAK7UUJVaIQ0DMUS5gofvFzU=;
        b=jZyVQDbIzypF7QZYObUyyQh/TC4GHVU8Txhw0cUUNWoJA2xk0MaOvtO6A3iwNiu1kc
         sYgZxu7fHj3Fv2GQ92yfC/CtV89lcC0Rh4np9V1tPn3ZT/6NhcbLAaSLodW4mdC9xvKb
         dUgvIq0aLth4ogx/rBfT0JE3MYnw0AGIrDnYPM8oB/dH2RAuJJHWtkgOC595nisACDO/
         8xAVYMKZX2y4NMlRzlchlTYkbbEiGtt2/0t7ilQMHXLcEwaBZWn+DDX3oQr3Xml+8dkE
         abKLPjzkUSoxlyT5HPt/Te09aylC/BXe4u0Mt9erZn2EZkGIUBfapWXLvcst/sGenQ7J
         3gnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786014227; x=1786619027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kMaEeVh+/U+NbRzoGC8Idgo7QP/ahOzSH8HwXGJHBcU=;
        b=Y2zRExfBLQUvPdcurbXQ/CJY0UazuSYyqdDTOQVrNvexWVITFePr1nVcS1wnxQKdUt
         hkFk3stB19A/OvTnQrXB+cLeYWOJ8Fbye8DSLu8x9sggIB1X9Ex1oKB7vjVgDkvwiBlK
         Rf9oJIRWAHrpC3mjFm+vOYFtqNCian6zNuAQFRGsjseLz2SRyDTYV/cnC4Kd1IARF/d8
         JW2jLO9E9q/M0vPP10EgItnb8qJXpJg4tm19XzjU/RoVNyiUdPV7qMWLDnngX1Pry0bR
         hpOdDdKEfQMB9JNokU/ghUdCcClHeHWDWKB6Z4lFlnAHhM5aKk7ZhLrK0Lv5bz7B95LD
         p/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014227; x=1786619027;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kMaEeVh+/U+NbRzoGC8Idgo7QP/ahOzSH8HwXGJHBcU=;
        b=MWbaY2VX9HxK4g9xVwBWHFRgSnOfgzLiG52pcNeig2HKXKF99wq6AGHB4Tkyoky3l7
         HDikcpe+Eao4ewwJssaG+b+Vodg7YBE9cDL/soLQNNAO4jWxiSD0djIojkjdIIRo2k5c
         Kf0oKU1NtxfPttQr137y/NNNllNDMHoA9OAR8aoido4kq/cU3MEJ3Usfe29TzTaF7291
         RTWyfiWjVg6g/FzrjNB+3WfimpCBSGW/ZAf/e1IRLrOsWtnTShXnCnkwf17uTnPf31M8
         DYR0JRd5yB1IWPZ7S6cvYp74pigaKA22j8QVaYD9go0vSB2gv+QO0Y7NpJP++m67w+2h
         hOQA==
X-Forwarded-Encrypted: i=1; AHgh+RqCFp3SS59cpHjTXzoBRxizbdBWl4Vt8+Kb6+1l0AY/MlYpBWdkx5CAU54GHOaeUzuSfIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxow5WLyQR5uplFPKzFmHXGRwya6jWTfMqcoDPzKB4jhiv9Fce
	kQ7shxohjtv++8MqVNoNv8ps++7Yd99ZjMkM7TKKC6LgxSX8F4F7H2yehht/z9r3JpQljsgesuQ
	4OsVOSBh+G6iFev/ATmP0JkLYZMGDb63xoWl7CeXLSw==
X-Gm-Gg: AR+sD11p+XrgXxH3wge8IGDNW/tPaUtqj4XVbF+ps0bVJbdzKkOupZuGnzBv0oxInb6
	irm0DEoePed8bqgv80yx5YtuS/NwLzlf34p9omtlr90Uzf5O+ya4Czeoztnve4b25jprbKCeDW8
	bH9aq/ctoBh2iOUMWwLFaKqwQpLO4nAEjrIDqZ9URkrLDekTvX/LU+cCNx8kQRveiJ8SBGTzPb0
	XOBI0pg6oAZalFYc/IDL8ip0F/X7Jco8hjdy3G9p+33vrt1lYqen4S9PzX0NEMILN2QrE2tZdcr
	c6A4TGNN8N4Dk2ZlTaaF7nSwWUTNd8FIqoMteQTmeGvDRtA=
X-Received: by 2002:a4a:e910:0:b0:6ac:ac32:b5ff with SMTP id
 006d021491bc7-6ae96c1b306mr7392747eaf.2.1786014225348; Thu, 06 Aug 2026
 04:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784201104.git.cuiyunhui@bytedance.com> <138d74aa9863ae8ff445e16a2798d062895b75bc.1784201104.git.cuiyunhui@bytedance.com>
 <anQ2bW3JxraT6PFY@lucifer>
In-Reply-To: <anQ2bW3JxraT6PFY@lucifer>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 6 Aug 2026 19:03:33 +0800
X-Gm-Features: AUfX_myo8uemIR_J8tcaFPQk5bQ_19S-a0xl3xjkzuEjy5SWJNGo65WwssSv6nw
Message-ID: <CAEEQ3wk62WBSJb5JcnPJoVSb+JQq3ZcE4CRmqqTvkAO20XFjbg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 10/15] mm/gup: add fast-GUP specific
 lockless PTE helpers
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Thu, Aug 6, 2026 at 3:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> +cc literally everybody you failed to contact...!
>
> Why on earth are you doing sending a series like this which changes core =
mm,
> non-RFC and at v2 to boot, without bothering to Cc relevant people?
>
> I am also very confused as to why you are sending an ostensible RISC-V se=
ries
> then changing how core mm works to fit it, that's not how that works.
>
> And if you're seeking to change core mm send it as an RFC!
>
> On Thu, Jul 16, 2026 at 08:41:45PM +0800, Yunhui Cui wrote:
> > fast-GUP snapshots a PTE without holding the PTL, pins the page, and
> > then revalidates that the PTE did not change. Keep both reads under the
> > same lockless PTE semantics by defaulting the fast-GUP revalidation to
> > ptep_get_lockless().
>
> Why?...

Thanks for the review. Let me first explain the motivation behind patch
10/15, and then address the RFC/Cc and naming issues.

The goal of this patchset is to let RISC-V Svnapot provide contiguous PTE
semantics similar to arm64 contpte: generic MM should still see a normal
per-page PTE view, while RISC-V can fold eligible PTE ranges into the
Svnapot/NAPOT encoding underneath. Because of that, the RISC-V public
ptep_get_lockless() may, for a Svnapot PTE, return the sub-PTE for the
current address expected by generic MM, after checking the whole NAPOT rang=
e
for consistency and aggregating block-wide A/D bits.

fast-GUP has a narrower requirement. It needs the PTE for the current addre=
ss
for permission/PFN/page lookup, then pins the page, and finally checks that
the page table entry it relied on did not change during the pin. fast-GUP d=
oes
not consume the block-wide A/D aggregation. If fast-GUP uses the public
ptep_get_lockless() for both the initial read and the revalidation, it pays
the cost of the NAPOT range scan and A/D aggregation in the fast path, even
though that information is not used.

So patch 10/15 is not trying to wrap a simple equality check. The intent is=
 to
separate two semantics: the current-address PTE consumed by fast-GUP, and t=
he
original PTE snapshot used for post-pin revalidation. On normal architectur=
es
these are the same value, and the default implementation preserves the
existing ptep_get_lockless() behavior. On RISC-V Svnapot, the value consume=
d
by fast-GUP is the sub-PTE, while revalidation compares whether the raw
snapshot has changed.

Patch 11/15 is the RISC-V use of this hook. It avoids the public
ptep_get_lockless() block-wide A/D aggregation path in fast-GUP, while stil=
l
keeping correctness through raw snapshot revalidation. In the 64K THP alway=
s
mode, fio 4K random direct read improved from 2.615M IOPS / 9.97GiB/s to
2.874M IOPS / 11.0GiB/s, and the average clat dropped from 95.54 usec to
86.97 usec.

Regarding the RFC/Cc issue, you are right, I handled that poorly. Although
this series is mainly about RISC-V Svnapot, patch 10/15 adds a generic MM/G=
UP
helper and patch 12/15 also changes the arm64 contpte fast-GUP path, so the=
y
are no longer RISC-V-local changes. I was worried that the large list of
individual recipients from get_maintainer.pl would create too much noise, s=
o
I mostly kept the mailing lists and dropped some individual Cc's. That was =
a
bad call; the relevant maintainers/reviewers should have been Cc'ed
explicitly. Sorry about that.

For the next version, I will split the generic fast-GUP helper out as a
separate RFC, add the relevant MM/GUP/arm64/RISC-V maintainers and reviewer=
s
to Cc, and explain the semantic difference between the PTE consumed by
fast-GUP and the post-pin revalidation snapshot. If I keep the arm64
optimization, I will include the arm64 maintainers/reviewers in that RFC;
otherwise I will drop it from the RISC-V series for now. I will also improv=
e
the naming, such as `rawp`/`raw_pte`, and add comments to make the snapshot
semantics clearer.

>
> >
> > Introduce fast-GUP specific PTE snapshot and revalidation helpers. The
> > default implementation preserves the existing ptep_get_lockless()
> > semantics, while allowing architectures to override the helpers when th=
e
> > public lockless getter provides extra semantics that fast-GUP does not
> > consume.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  include/linux/pgtable.h | 18 ++++++++++++++++++
> >  mm/gup.c                |  6 ++++--
> >  2 files changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index da14328093a86..62943fcbf7046 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -813,6 +813,24 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
> >  }
> >  #endif
> >
>
> Of course, no comments, helpful!
>
> > +#ifndef gup_ptep_get_lockless
> > +static inline pte_t gup_ptep_get_lockless(pte_t *ptep, pte_t *rawp)
>
> rawp? This is terrible naming.
>
> And 'gup_ptep_get_lockless()' is worse. What on earth is this function me=
ant to
> do? And why is 'gup lockless' considered different from lockless?
>
> And you return the value twice, because of course you do. Why? Who knows.
>
> > +{
> > +     pte_t pte =3D ptep_get_lockless(ptep);
> > +
> > +     *rawp =3D pte;
> > +
> > +     return pte;
> > +}
> > +#endif
> > +
> > +#ifndef gup_ptep_revalidate
> > +static inline bool gup_ptep_revalidate(pte_t *ptep, pte_t raw_pte)
> > +{
> > +     return pte_val(raw_pte) =3D=3D pte_val(ptep_get_lockless(ptep));
> > +}
>
> Again this naming is utterly terrible and I'm at a loss as to why on eart=
h
> you're doing this?
>
> We don't need to abstract equality checks?
>
> > +#endif
> > +
> >  #ifndef pmdp_get_lockless
> >  static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
> >  {
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 99902c15703b0..72fb147193e55 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2842,10 +2842,12 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t =
*pmdp, unsigned long addr,
> >       if (!ptep)
> >               return 0;
> >       do {
> > -             pte_t pte =3D ptep_get_lockless(ptep);
> > +             pte_t raw_pte, pte;
>
> What on earth is a 'raw' PTE?
>
> >               struct page *page;
> >               struct folio *folio;
> >
> > +             pte =3D gup_ptep_get_lockless(ptep, &raw_pte);
> > +
> >               /*
> >                * Always fallback to ordinary GUP on PROT_NONE-mapped pa=
ges:
> >                * pte_access_permitted() better should reject these page=
s
> > @@ -2871,7 +2873,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *p=
mdp, unsigned long addr,
> >                       goto pte_unmap;
> >
> >               if (unlikely(pmd_val(pmd) !=3D pmd_val(pmdp_get_lockless(=
pmdp))) ||
> > -                 unlikely(pte_val(pte) !=3D pte_val(ptep_get_lockless(=
ptep)))) {
> > +                 unlikely(!gup_ptep_revalidate(ptep, raw_pte))) {
>
> Why do we need to refadctor a comparison between a local variable and a l=
ockless
> get?
>
> I'm just so confused by what on earth this patch is meant to be or why it=
's here...
>
> >                       gup_put_folio(folio, 1, flags);
> >                       goto pte_unmap;
> >               }
> > --
> > 2.39.5
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> --
> Cheers, Lorenzo


Thanks,
Yunhui
