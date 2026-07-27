Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B33B42D2
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167174; cv=none; b=K4HyrAxWkPtQB9GVAd0Pqor7Ik1vAopc7Cy8xvcmZwLpjVhGeUQ3IW/Prs2qqcfQFIPYASvQQZlaSiejmodiZm1qeHDoGofQI8zHcKGvg2rp1SlUOq+nCXNoQnSC4y92K2YVEpkypxMmwri6hAu/JFZipfrw8HYP8AcmG3+WOjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167174; c=relaxed/simple;
	bh=B3JvxxhW5xdFEP/0r+PeLoui3FgtZYGOVPeMTky/iRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcMqPnpTSm3hzINQudg35llWI3i/z4mW05/RKZdqvzyI0ZK+ZXPPKE1a5AieKyRGGa5Ztnfnsl5Rkn8RyNhbVDyZn2zHlfTd0+RJaRdNTQZTk1t+ELtLOp3eZgUp7GQ1qmJFct07wxY7/oVPJSaTibEeOfAiUuLn6JwXVcq/74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuCckO7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuCckO7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C581F00A3E
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167173;
	bh=wIDKRUsDSh0BKsCU5dbDjZEUZSBD+ZsH2BEg5ooZF94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iuCckO7gLN2vhr01E/ib8n0RXBNiHMQ7l3pkoZHp8K9of587gAAl/ceKJgfLt1/3f
	 +IJE/5ZSvyfHWBJsFGNngC6RPmcRGMnr2+KuqtYEagvaGbe09k7gwXfye45I1RpoTO
	 AaEqO2Ec5WMjfTyCtY5aFSg+ppOKDF6Ppr/hIezC+U7ZhELyf78TNemHzre55kS+nf
	 4sywPbpFexvF5/XCC4uybgI6cbkmKEUldchhx4Ww4TxR2HDVES9K/ycin1wce9oPrn
	 dKMdK7n2viaY2Gh9hTir/b/QPQj8s/C8jQWdFsz1juxSIzEzPOS+A3El/wJNQ0QMA4
	 qp+54p/Bvl8kg==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69fe3cd5ee6so2457719a12.2
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 08:46:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrP0Kj9cvfPfRRzMY32lnupfNo8KDNgW8U6IxUein7GSpwLY0L9//GdKxHOv/1U7ATV1l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznEVPLcix0QLzikQVd4vyZH/V9xkbBd3ZJ4c/PaY5ovbUt9u4D
	OO7bPdvGc+4GP9RpB6ljgkTCpHahK/EMzfqLZ2mVfm148JguPRg6a/hM1rBAEFVyfoEniwVHqOf
	GmJ8HQvQt6LMJWKPFmrS9Z2qHNxW/MkM=
X-Received: by 2002:a17:906:4785:b0:c16:785:cfd1 with SMTP id
 a640c23a62f3a-c1f1f0e6af3mr390704666b.40.1785167171877; Mon, 27 Jul 2026
 08:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-23-yosry@kernel.org>
 <amFl89ch5Iej63L3@google.com> <amFms2CnzhDUuRCk@google.com>
 <amGiAKsC3XrF6DyA@google.com> <amIx9Ki6gv-wgBnX@google.com>
 <CAO9r8zMzV=DqR9NZdACzF1NF84GvPnUwP0p-0CypE-3vARxuWQ@mail.gmail.com> <amd7c9Dznv1XM0kj@google.com>
In-Reply-To: <amd7c9Dznv1XM0kj@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Jul 2026 08:46:00 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNE6E7GYg=jrtRVnyG-2xtkFCrNP6FRiH5ZVgmCRKMLtQ@mail.gmail.com>
X-Gm-Features: AUfX_mz2GQ2ktZC9QhVh-10PmBRIU5nhKhZGLhhrIq3MndO9TlybzuzJUYhG5QU
Message-ID: <CAO9r8zNE6E7GYg=jrtRVnyG-2xtkFCrNP6FRiH5ZVgmCRKMLtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/25] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to
 allow skipping the gva flush
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 8:38=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Jul 24, 2026, Yosry Ahmed wrote:
> > > > > > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > > > > > index 65c35ed8f4a01..3feb75732f7b4 100644
> > > > > > > --- a/arch/x86/kvm/mmu/mmu.c
> > > > > > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > > > > > @@ -6615,15 +6615,15 @@ static void kvm_mmu_invalidate_addr_i=
n_root(struct kvm_vcpu *vcpu,
> > > > > > >         write_unlock(&vcpu->kvm->mmu_lock);
> > > > > > >  }
> > > > > > >
> > > > > > > -void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct k=
vm_mmu *mmu,
> > > > > > > -                            u64 addr, unsigned long roots)
> > > > > > > +static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu,=
 struct kvm_mmu *mmu,
> > > > > > > +                                     u64 addr, unsigned long=
 roots, bool flush_gva)
> > > > > > >  {
> > > > > > >         int i;
> > > > > > >
> > > > > > >         WARN_ON_ONCE(roots & ~KVM_MMU_ROOTS_ALL);
> > > > > > >
> > > > > > >         /* It's actually a GPA for vcpu->arch.guest_mmu.  */
> > > > > > > -       if (mmu !=3D &vcpu->arch.guest_mmu) {
> > > > > > > +       if (flush_gva && mmu !=3D &vcpu->arch.guest_mmu) {
> > > > > > >                 /* INVLPG on a non-canonical address is a NOP=
 according to the SDM.  */
> > > > > > >                 if (is_noncanonical_invlpg_address(addr, vcpu=
))
> > > > > > >                         return;
> > > > > > > @@ -6642,9 +6642,15 @@ void kvm_mmu_invalidate_addr(struct kv=
m_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > > > >                         kvm_mmu_invalidate_addr_in_root(vcpu,=
 mmu, addr, mmu->prev_roots[i].hpa);
> > > > > > >         }
> > > > > > >  }
> > > > > > > +
> > > > > > > +void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct k=
vm_mmu *mmu,
> > > > > > > +                              u64 addr, unsigned long roots)
> > > > > >
> > > > > > Rather than kvm_mmu_invalidate_addr() for the wrapper, what if =
we call this
> > > > > > kvm_mmu_invalidate_gva()?  And then kvm_mmu_invlpg_gva().  Then=
 we don't need
> > > > > > to have the "in_root" version to a quad-underscores helper, and=
 IMO it's more
> > > > > > obvious what's different between the one-line wrappers and the =
inner helpers.
> > > > >
> > > > > Hrm, or maybe I'm not understanding what "flush_gva" means.  At f=
irst glance, I
> > > > > was assuming you were using it to differentiate between GVA and G=
PA, but IIUC,
> > > > > it's literally skipping the flush for the current context, which =
just so happens
> > > > > to be done only for GVAs.  I'd still like to avoid the "in_root" =
helper, if at
> > > > > all possible.
> > > >
> > > > Yes, it's skipping the TLB flush that is only needed for GVAs. The
> > > > alternative I had in mind (but thought was worse) was to refactor t=
he
> > > > TLB flush part out of kvm_mmu_invalidate_addr() (or
> > > > __kvm_mmu_invalidate_addr()) in this patch instead of adding a bool=
ean,
> > > > but this still requires adding a wrapper and the possibility of a
> > > > quad-underscore helper.
> > > >
> > > > What's the main objection to kvm_mmu_invalidate_addr_in_root()?
> > >
> > > I don't love the __kvm_mmu_invalidate_addr() =3D> kvm_mmu_invalidate_=
addr_in_root()
> > > callchain.  It's not at all obvious that the in_root() helper shouldn=
't be called
> > > directly.  I don't hate it, but I do think we need better clarity on =
what all this
> > > is doing.
> > >
> > > E.g. when looking at __kvm_inject_emulated_page_fault(), since it har=
dcodes a
> > > single root, it's a bit headscratching to use kvm_mmu_invalidate_addr=
() instead
> > > of kvm_mmu_invalidate_addr_in_root.
> >
> > Coming back to this, I agree it's confusing. I think this can be fixed
> > with a better name though. Looking at
> > kvm_mmu_invalidate_addr_in_root() (or __kvm_mmu_invalidate_addr() in
> > current code), seems like what it does is find SPTEs for that address,
> > sync them, and flush the TLB if needed.
> >
> > So maybe mmu_sync_addr_sptes() or mmu_sync_and_flush_addr_sptes()?
>
> kvm_mmu_sync_addr()?  The "sptes" part is implied in things like kvm_sync=
_page()
> and mmu_sync_children().

Sounds good. I assume you're okay with keeping everything else the
same way? I assume you didn't like any of the alternatives?
