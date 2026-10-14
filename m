Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EE32BDC28
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010316; cv=none; b=q+Xmje3QDG+qb8yBu1BA83jXnSaRVHAcsGGXMv2NH5rWFjze7SNaFRZjlbEREgFGsBdQ71s2PK/d12I5dUqDfaC1ElWMIbr0QWALLmwuDpG2qBfrxNkHStDsrLb4uj2zl74Y1U8neNx4tTYUnKYT6jixi/IBvo9SHA1ewuPAfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010316; c=relaxed/simple;
	bh=JoGPBXpoXq4TjNGJ7QeisPE4tusEKomuol6GAkp99TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VizkFYrqyi5TTL7fId0+EW7cUkPC+U1gRtLtJqpKDTQ4FjWlg6ylevkpdq5Ar2Dwb+J/yuOyLIG5AsPX2nxdchM+ND56DZ5sOt9u8K9qVZBlxVC1ftIB+XoX3zsqaTtqAOBSxazVI6z7KUBIGDH2ov1WPbbIpxqpI09fYP5/CIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbiUJrEm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbiUJrEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CF81F000CB
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 20:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792010315;
	bh=Sjzadb3/6SBUHyGfg8P51zJVcvSPD9TaqG+ALWUyrhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dbiUJrEmvgzaxNpGr0yD75XVvvB/mUdHBeMB2fxkgpvD99Jn4RDLbFWakDnipnavG
	 H5OkqoxHjlFdL7UjTDpmBJbT2cp7I1JvZCvJDBaaFkuhU5+O/D9Trz+mnh3H9RWNfj
	 3MezFhbu3mlxR8zaRga20/bMd/tmjQjareU1TRiuBfnPDev+sz1ZnqCz5eXLHwsj+z
	 1UgOFh/jgllgHvNw+RgqDROYeAbDclVnD4y0bz5OYOJFUvR6nG8gnIgO8WxgGP/sLx
	 ZyfLvyXffCcEqY8DVUf0raQsmh6W/lPICu/0+cMztwRDYbfYfNvqvCF4YwGIu02zZA
	 UXjHDLZbn8AwQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2e2007dd8bso765515566b.2
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 13:38:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByYlblsBS7EiBm8ewsh0Epqyef7c5p0oFFqOJ+Ou0+1lFfGQGCWlWyM2yzSh38gkh0bNh4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu1b8Vcy1KFL/P+KiU1e/hKKnQOG0wbPXZmTRECSnuFeTrc85/
	IVxPqSMJC5PsZtCZOYDUhWKKT7AnjGR97a+BILgZZBBxp5uTBEMmO/w1oXLMgCV6TefcF6ZYkGZ
	HvhLaE/awxxM/YuuW6L1XtJhFPTHI65A=
X-Received: by 2002:a17:907:3f20:b0:c3e:e726:9548 with SMTP id
 a640c23a62f3a-c3ee7269fcdmr47818566b.14.1792010314132; Wed, 14 Oct 2026
 13:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-4-yosry@kernel.org>
 <CALMp9eT9xOFKSFnOg5OeXgmXV0pr-4-yJdBFFMORPx22BgHnHw@mail.gmail.com>
In-Reply-To: <CALMp9eT9xOFKSFnOg5OeXgmXV0pr-4-yJdBFFMORPx22BgHnHw@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 14 Oct 2026 13:38:22 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMtrxJYN83_ht1wLfNrRvc_suLm7LyDhxZABQTBt-fN-w@mail.gmail.com>
X-Gm-Features: AclHuK_q9B9H0vjnxDInI4iEfaZY2mbRtIbinfw9U-aINMewKYSX43KqJ568UFM
Message-ID: <CAO9r8zMtrxJYN83_ht1wLfNrRvc_suLm7LyDhxZABQTBt-fN-w@mail.gmail.com>
Subject: Re: [PATCH v3 03/27] KVM: VMX: Generalize VPID allocation to be vendor-neutral
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:23=E2=80=AFAM Jim Mattson <jmattson@google.com> =
wrote:
>
> On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > In preparation for sharing with SVM, generalize the VMX VPID allocation
> > code and move it to common code as a TLB tags allocator. Parameterize
> > the TLB tags allocator by the number of tags, and allocate the bitmap
> > dynamically. Opportunisitcally use guards to acquire the lock instead o=
f
>
> s/Opportunisitcally/Opportunistically/
>
> > spin_{lock/unlock}().
> >
> > Keep the number of allowed tags capped at VMX's hardware cap, to avoid
> > allocating a huge bitmap if L0 advertises a huge number of ASIDs to an
> > L1 KVM. Realistically, the number of actual hardware ASIDs wouldn't be
> > that large so there is no benefit.
> >
> > Initialize the TLB tags allocator during hardware setup/unsetup, and
> > reserve tag=3D0 during initialziation, similar to how VPID=3D0 is curre=
ntly
>
> s/initialziation/initialization/
>
> > reserved in the VMX-specific bitmap during hardware setup.
> >
> > Allow nr=3D0 to allow allocating all ASIDs to SEV on AMD without failin=
g
> > hardware setup, if at all possible, in which case any tag allocation
> > fails (SEV won't use the tag allocator).  The number of tags includes
> > tag=3D0, which is not usable. The interface is a little confusing in th=
at
> > regard, but this will be changed soon when reserved tags are explicitly
> > introduced.
> >
> > Keep allocate_vpid() and free_vpid() as wrapper that check enable_vpid
> > to avoid checking at all callsites, and add init_vpids() and
> > destroy_vpids() to wrap init/destroy calls as well.
> >
> > No functional change intended.
>
> I don't think that's really true. If it is, then you failed. For
> example, the new -ENOMEM when the bitmap can't be dynamically
> allocated.

Point taken, will remove the claim.

>
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/mmu.h     |  8 +++++
> >  arch/x86/kvm/mmu/mmu.c | 78 ++++++++++++++++++++++++++++++++++++++++++
> >  arch/x86/kvm/vmx/vmx.c | 40 +++++-----------------
> >  arch/x86/kvm/vmx/vmx.h | 28 ++++++++++++---
> >  4 files changed, 119 insertions(+), 35 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> > index 2ae7f9ed4cf86..de79e002edf8f 100644
> > --- a/arch/x86/kvm/mmu.h
> > +++ b/arch/x86/kvm/mmu.h
> > @@ -410,4 +410,12 @@ static inline bool kvm_is_gfn_alias(struct kvm *kv=
m, gfn_t gfn)
> >  {
> >         return gfn & kvm_gfn_direct_bits(kvm);
> >  }
> > +
> > +typedef unsigned int kvm_tlb_tag_t;
> > +
> > +int kvm_init_tlb_tags(unsigned int nr);
> > +void kvm_destroy_tlb_tags(void);
> > +kvm_tlb_tag_t kvm_alloc_tlb_tag(void);
> > +void kvm_free_tlb_tag(kvm_tlb_tag_t tag);
> > +
> >  #endif
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index aadd5bdc2c97a..97d49247d9d82 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -8178,6 +8178,84 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
> >                 vhost_task_stop(kvm->arch.nx_huge_page_recovery_thread)=
;
> >  }
> >
> > +static struct {
> > +       spinlock_t      lock;
> > +       unsigned long   *bitmap;
> > +       unsigned int    nr;
> > +} tlb_tags;
>
> Can we statically initialize this to avoid the call to spin_lock_init()?
>
> ... tlb_tags =3D {
>         .lock =3D __SPIN_LOCK_UNLOCKED(tlb_tags.lock),
> };

The call to spin_lock_init() is less code, but I can make the change.
I don't have a preference.

>
> > +
> > +int kvm_init_tlb_tags(unsigned int nr)
> > +{
> > +       /*
> > +        * Limit the number of TLB tags to VMX's hardcoded maximum of 0=
x10000
> > +        * to avoid wasting memory for the bitmap in the unlikely scena=
rio the
> > +        * CPU supports an inordinate number of ASIDs (on AMD).  If use=
rspace
> > +        * wants to concurrently run tens of thousands of vCPUs, they'l=
l likely
> > +        * need a solution that works for both Intel and AMD.
> > +        */
> > +       const unsigned int MAX_NR_TLB_TAGS =3D VMX_NR_VPIDS;
> > +
> > +       if (!nr)
> > +               return 0;
> > +
> > +       if (nr > MAX_NR_TLB_TAGS) {
> > +               pr_warn_once("Number of TLB tags capped (%u instead of =
%u)\n",
> > +                            MAX_NR_TLB_TAGS, nr);
> > +               nr =3D MAX_NR_TLB_TAGS;
> > +       }
> > +
> > +       tlb_tags.bitmap =3D bitmap_zalloc(nr, GFP_KERNEL);
> > +       if (!tlb_tags.bitmap)
> > +               return -ENOMEM;
> > +
> > +       /*
> > +        * 0 is the host's TLB tag for both VMX's VPID and SVM's ASID, =
and is
> > +        * returned on failed allocations (e.g. no more tags left).
> > +        */
> > +       __set_bit(0, tlb_tags.bitmap);
> > +
> > +       tlb_tags.nr =3D nr;
> > +       spin_lock_init(&tlb_tags.lock);
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_tlb_tags);
> > +
> > +void kvm_destroy_tlb_tags(void)
> > +{
> > +       bitmap_free(tlb_tags.bitmap);
> > +       tlb_tags.bitmap =3D NULL;
>
> For consistency and future-proofing, it might be wise to clear tlb_tags.n=
r here.

Can do.

>
> > +}
> > +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_destroy_tlb_tags);
