Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDDF2F12D4
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796807; cv=none; b=qWCv7c3upyyEfzFTzbqvNFPStWIwbHPks31ZOuqscPsGly5kfo46gzM2SkfRLrZD/qjXc7nJERJFWfPzGb1UpizwHwZqEAdsN5MteoX7XZZPLv1PaS/Lp8ctzFJguaYSAcgZLI4wFK0AqGQRpvEUvYlxzsKM3IsMvxJFqIYyLZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796807; c=relaxed/simple;
	bh=f5KnnCh13WH8hydIQNCRaGLNUvn6tqMF4niyKermq+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sPw31LcilGH/nWqMjjHhaEBM6n/Q1cYWNd4QaNeMEywa1jt8k02ijRgsa2FU4C609WvaLTTe+/GXcz+SWkTGk5+yAnfKBtRGQVYsE8mePnYZhQKdapZjpaSHEaCR7fE273V/bRjXg66sT0t0ycdmuz9UIZdY8Ums+uzTAF4NxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOTxK6cw; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOTxK6cw"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848568a6f62so7768833b3a.0
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 15:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785796805; x=1786401605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Vh1mLm2+5zdW1p19BIdIC67znvPnKKEQ+YAJfKmB3X0=;
        b=hOTxK6cwOQpkc37MOU5++un20JZvHZwEauWpbTKqzowjwdtw5pyYpCVZSCrWY3Sfax
         6hgaCZb2YMSDlzDcO28Y/0ilYn+8JmoL7x6tVEls/O+Aez2DgZvJVuluroKi43iC3bHI
         G84CXtfQx7q6/ZH7gW4EDptyLtdnW3UnNXN60VtnpaaSYos+0n2lgGld9avaXNXl4oXC
         c3AtClQaYFZDzcX0n+37dkyW7zxqebsbhPR6ibLSt4A6hIgVRlpq6+Fs859kH2Ssqlpp
         X/2zDG73buEga2vjYew50o55InVUstxUIns0kGsSvwhNzL4XD4VThLn9dfvezXALXieQ
         Eewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796805; x=1786401605;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vh1mLm2+5zdW1p19BIdIC67znvPnKKEQ+YAJfKmB3X0=;
        b=pVFHgiUEMVq/TW/D0QyAjmkGg4Nr+JfI3bvUwWrbSNdE9Fc2T8BOwoqxqsNAgDTJdp
         /BcWBaMDDsgps5aVnZu8O7H2Z5RWnwrw3wHnTERrLq00u7cdC6CNTpoKqCZGMZ+Oguaa
         KiaO18vR+Mj8DTZer0rWKBgWvlwIEzon0FJw1XicLz34DYZo09N4J87lSP89UgpcC9Nz
         4PgN+DQ6juCurddXj5faGckVQlWHJrtegMdAPc4QapMzO2N6vGKDEXjfHCxvPTseLZMm
         wdpNT7rdO5PpCPZJRSqEtf11En2Mf1SYYYed6y+qn9vmNLGtczYFbCg7LjMCp7GZPDoc
         hLHA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7zUKX56Goey6Cuh4xQ/xnyjOAJgR5lUoSwDHGOrQkWk4R2ZmDK1UFLzgi7qpPJAXf5tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ8rWuV3ApL0kOvBRDAMKQ4Tany1RMj7zdE1qYvAVQSE4zpRlE
	TDRvEfhyP02gSnlC/cFSAnbtRBVc4/hdqtb//xlFOIzw1YJb2XnxTe/IE+7S3WffRjPkFBSC6vZ
	Kptm3pA==
X-Received: from pfau3.prod.google.com ([2002:a05:6a00:aa83:b0:848:4642:f1d3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14d3:b0:845:48be:b046
 with SMTP id d2e1a72fcca58-84ee4899b38mr10130120b3a.36.1785796805112; Mon, 03
 Aug 2026 15:40:05 -0700 (PDT)
Date: Mon, 3 Aug 2026 15:40:04 -0700
In-Reply-To: <46663836-fd97-4328-8c7d-5efeeb222ce6@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731175834.1121005-1-pbonzini@redhat.com> <amztmWhHXUR4zBv1@google.com>
 <CABgObfZ5sPgfJz-_reACs5WkjRRkdNuinfY+nSrdHvG5xSiKUA@mail.gmail.com>
 <anCZoc65i2xXNQgO@google.com> <46663836-fd97-4328-8c7d-5efeeb222ce6@redhat.com>
Message-ID: <anEYxL8kf0O889S2@google.com>
Subject: Re: [PATCH] kvm: apply VM_READ/VM_WRITE checks to all VMA types
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2026, Paolo Bonzini wrote:
> On 8/3/26 15:40, Sean Christopherson wrote:
> > On Mon, Aug 03, 2026, Paolo Bonzini wrote:
> > > On Fri, Jul 31, 2026 at 8:46=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > > > * if the PTE is present, follow_pfnmap_start() sets args.writable=
 to
> > > > >    false and KVM_PFN_ERR_RO_FAULT is returned;
> > > > >=20
> > > > > * if no PTE is present, fixup_user_fault(FAULT_FLAG_WRITE) return=
s
> > > > >    -EFAULT after checking vma_permits_fault(), and hva_to_pfn() e=
nds
> > > > >    up returning KVM_PFN_ERR_FAULT.
> > > > >=20
> > > > > With this patch KVM_PFN_ERR_RO_FAULT is returned uniformly.
> > > >=20
> > > > IMO, returning KVM_PFN_ERR_RO_FAULT on a read-only VMA is wrong.  A=
FAICT, that
> > > > behavior for VM_{IO,PFNMAP} was added by commit bd2fae8da794 ("KVM:=
 do not assume
> > > > PTE is writable after follow_pfn").  Given that that's the only cas=
e where KVM
> > > > returns KVM_PFN_ERR_RO_FAULT, I would much prefer to fix that wart =
and cross our
> > > > fingers nothing has come to rely on the behavior in the last ~5 yea=
rs.
> > >=20
> > > We can try, but I'd rather not do that in stable releases (while this
> > > patch would be applied there, as a first step towards fixing the DRM
> > > issue that Sergio reported
> >=20
> > I don't see how this would help with fixup_user_fault() not actually fi=
xing a
> > fault.  Neither returning -EFAULT nor emulating is correct KVM behavior=
.
> >=20
> > > - it avoids the sashiko issue reported for
> > > https://lore.kernel.org/r/20260731160514.1101989-1-pbonzini%40redhat.=
com/).
> >=20
> > But the issue Sashiko reported is just saying that KVM sometimes does w=
hat I'm
> > saying KVM should do all the time: return -EFAULT.  Or did I misunderst=
and that
> > one too? :-)
>=20
> Yes, that's correct.  My point is I'd rather not introduce other changes =
to
> the !VM_WRITE case in stable releases.

Yeah, agreed.  But what I don't understand is why this would be sent to sta=
ble@
in the first place.

> So, the follow_pfnmap_start() patch I posted last Friday is part of the f=
ix
> for Sergio's report; but it introduces one such change---which indeed we
> agree is desirable behavior, but which I'd rather not sneak in as part of=
 an
> unrelated fix for a regression.
>=20
> So, *this* patch removes a bunch of cases in which hva_to_pfn_remapped() =
is
> inconsistent, but it leaves RO_FAULT in place for now.  Then separately w=
e
> can, uniformly, do the change from RO_FAULT to -EFAULT.
>=20
> Paolo
>=20
> > > >          /*
> > > >           * GUP failed.  It could be an inaccessible mapping, a pfn=
map one,
> > > >           * or the page might be absent.
> > > >           */
> > > >          if (vma =3D=3D NULL || unlikely(!(vma->vm_flags & VM_READ)=
) ||
> > > >              ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags=
 & VM_WRITE)))) {
> > > >                  pfn =3D KVM_PFN_ERR_FAULT;
> > > >          } else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
> > > >                  r =3D hva_to_pfn_remapped(vma, kfp, &pfn);
> > > >                  if (r =3D=3D -EAGAIN)
> > > >                          goto retry;
> > > >                  if (r < 0)
> > > >                          pfn =3D KVM_PFN_ERR_FAULT;
> > > >          } else {
> > > >                  pfn =3D kfp->flags & FOLL_NOWAIT ? KVM_PFN_ERR_NEE=
DS_IO :
> > > >                                                   KVM_PFN_ERR_FAULT=
;
> > > >          }
> > >=20
> > > Yes, but I'd do that only in 7.3.
> >=20
>=20
>=20
