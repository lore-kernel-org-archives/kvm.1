Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8EC47CA76
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015689; cv=none; b=ZO474z6GsMApeXbWFf2zO8rh0sGzaMFwyOgr9JzF+ZNBwYqxU57b8j0SUCdeeEgvcDcb49o2e+bCXHFpmejyo9W0R+eUxPHIox4dbTeiD7QfXKisj/R89RIWhBhQIlDo34O4zGZrhSyq7xkl/2e3OgEhXTm8XeLoz/8VtGJ1c5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015689; c=relaxed/simple;
	bh=W7YcGSKMlsONALoV83j6UEkvfWlb5AmoxbPzjc26wLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d516PEKTXoIj6kP3Wl/C4wq2NPAim5J3/2INmy5K72agic92lUkfrHkHaahtTJQAK2iwI6FnZEjKqFD2KNX2ncz7R0WbAuu6/FRalz+efTFRfs9zlQjy64cPW3SXNBo56P0rgPp7rxju523HzGMiL48G35FWGBK45v6N3oLTTbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4LqGTRR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4LqGTRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310451F000C6
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792015688;
	bh=zTE6DUFagBPa5gdr6mBV97huCIFJv592aB6rqYNnqqU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I4LqGTRRbaUoUT9SFAh2xZZJIsrqsBeF+eztkdizJB/7kiWnA5g2N2IiUAfud17m3
	 gRTNDeYFTf3JU0XKgdAevNDskF7g9rLZdcjovta9dM5NMnJXTJBwBP+/fQznKsnRtK
	 YK/lFNSxYppKxtfDtrgJGCdtUF9gQ+A+wstPWjl4GJYpNbc8V8Yn+PHJjucLKm6N4a
	 yOe8atuW92GO7F3BeDL3Br8HVM7iO+0c6B1Ee4WJgWsMvjZzwwiXYWLBkKzZHqFne2
	 h4HZg7r5MUMSI5nj/UdvSrB8fxUihYXoaxjLpKjlJ+SYfXOjmU62n43wyQ+vWT28gB
	 POAf3BdPGXtXA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso276308466b.2
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 15:08:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy5jUmu19l7ybIhyCyzEnSaUH5dLrKpRGhQ0g02PTLvTTJUFFWuYHIw/qnEpg9T9AaQ98U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpfy5wRXNzmW8PKD16IjA45B/U8NEbPJK4kauJQU3ZsacnaOPI
	ZppFALZLn79KyxaxRPXUEyRWdUXILPWYnHzfIDMAOiFgapW7lLdLKpnZMjCxpBZkQ3UzQLuYBBB
	h4/sfp0TXacz9sS6AFdJ547DCFo14Ft4=
X-Received: by 2002:a17:907:eccc:b0:c25:4f7c:8ec5 with SMTP id
 a640c23a62f3a-c31aa0291acmr1560206066b.23.1792015687089; Wed, 14 Oct 2026
 15:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-5-yosry@kernel.org>
 <CALMp9eQEEKVQT33t=UNDdGLotZWiUpznoM6Jxdc4u0W4vfcv1g@mail.gmail.com>
In-Reply-To: <CALMp9eQEEKVQT33t=UNDdGLotZWiUpznoM6Jxdc4u0W4vfcv1g@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 14 Oct 2026 15:07:55 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPbwG+f+Df5bBtiBKv2hbjy6gXbV8biOQ7mzJkjWffWuA@mail.gmail.com>
X-Gm-Features: AclHuK-CAnvKOlKrWVsaR1s3p9qPydodr_9JLTrc46hJNTGEMgbHhC0o5f54zvE
Message-ID: <CAO9r8zPbwG+f+Df5bBtiBKv2hbjy6gXbV8biOQ7mzJkjWffWuA@mail.gmail.com>
Subject: Re: [PATCH v3 04/27] KVM: x86/mmu: Support specifying reserved TLB tags
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 2:50=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > In preparation for using the TLB tags allocator for SVM, which has a
> > range of ASIDs allocated for SEV/SNP, pass in the number of reserved TL=
B
> > tags when initializing the TLB tags allocator. The bitmap is
> > conceptually shifted such that bit=3D0 corresponds to tag=3Dnr_reserved=
.
> >
> > Specifying the minimum value during initialization also makes the API
> > clearer, as tag=3D0 is now explicitly reserved by the caller.
> >
> > No functional change intended for VMX as VPID=3D0 was already implicitl=
y
> > reserved.
> >
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/mmu.h     |  2 +-
> >  arch/x86/kvm/mmu/mmu.c | 42 ++++++++++++++++++++++++++++--------------
> >  arch/x86/kvm/vmx/vmx.h |  2 +-
> >  3 files changed, 30 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> > index de79e002edf8f..b443a5083bfb0 100644
> > --- a/arch/x86/kvm/mmu.h
> > +++ b/arch/x86/kvm/mmu.h
> > @@ -413,7 +413,7 @@ static inline bool kvm_is_gfn_alias(struct kvm *kvm=
, gfn_t gfn)
> >
> >  typedef unsigned int kvm_tlb_tag_t;
> >
> > -int kvm_init_tlb_tags(unsigned int nr);
> > +int kvm_init_tlb_tags(unsigned int nr_total, unsigned int nr_reserved)=
;
> >  void kvm_destroy_tlb_tags(void);
> >  kvm_tlb_tag_t kvm_alloc_tlb_tag(void);
> >  void kvm_free_tlb_tag(kvm_tlb_tag_t tag);
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 97d49247d9d82..c096c1a2b4684 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -8182,9 +8182,17 @@ static struct {
> >         spinlock_t      lock;
> >         unsigned long   *bitmap;
> >         unsigned int    nr;
> > +       kvm_tlb_tag_t   start;
> >  } tlb_tags;
> >
> > -int kvm_init_tlb_tags(unsigned int nr)
> > +/*
> > + * Initialize @nr_total TLB tags, where @nr_reserved of those tags are=
 reserved.
> > + * Reserved tags start at 0 and are contiguous. Hence, usable tags are
> > + * [nr_reserved, nr_total). At least one reserved tag is required, as =
0 is the
> > + * host TLB tag on both VMX and AMD, and is the value returned on a fa=
iled tag
>
> Nit: VMX and SVM -or- Intel and AMD

LOL, how did I end up with that.

>
> > + * allocation.
> > + */
> > +int kvm_init_tlb_tags(unsigned int nr_total, unsigned int nr_reserved)
> >  {
> >         /*
> >          * Limit the number of TLB tags to VMX's hardcoded maximum of 0=
x10000
> > @@ -8194,7 +8202,12 @@ int kvm_init_tlb_tags(unsigned int nr)
> >          * need a solution that works for both Intel and AMD.
> >          */
> >         const unsigned int MAX_NR_TLB_TAGS =3D VMX_NR_VPIDS;
> > +       unsigned int nr;
> >
> > +       if (WARN_ON_ONCE(!nr_reserved || nr_reserved > nr_total))
> > +               return -EINVAL;
> > +
> > +       nr =3D nr_total - nr_reserved;
> >         if (!nr)
> >                 return 0;
> >
> > @@ -8208,13 +8221,8 @@ int kvm_init_tlb_tags(unsigned int nr)
> >         if (!tlb_tags.bitmap)
> >                 return -ENOMEM;
> >
> > -       /*
> > -        * 0 is the host's TLB tag for both VMX's VPID and SVM's ASID, =
and is
> > -        * returned on failed allocations (e.g. no more tags left).
> > -        */
> > -       __set_bit(0, tlb_tags.bitmap);
> > -
> >         tlb_tags.nr =3D nr;
> > +       tlb_tags.start =3D nr_reserved;
>
> Can you also clear tlb_tags.start in kvm_destroy_tlb_tags()?

Can do.
