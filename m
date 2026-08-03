Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56DA3859D7
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764459; cv=none; b=KCUj7JavK3Q5HCjIcUl5slQtGZ6E/PU1aQ42RqzIpYnsuBSQLJxIgxtzh1ATrL7ZoF6QnshRP1lE1CJGv/JjkGOV5pp5jFFIVcWh04XIzm1z9rZ3z2+hYDeR7pnQSeutzhrQafxcUwVhGUgJUjmRFNQAo/wJbqQRmJZh3EOYthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764459; c=relaxed/simple;
	bh=rY2g8///6Z3SBkyz4tupoNnDNJ74RHWhu0kftawIifg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LG9z88RlDzFsrm1MzAkJ3SgQyhupgErJADP9WM8WbHPDVwQNV2c9C+YX68LreVpCc2iYTjXB38sSHrosievxAMqbX3ipjuQM+iiZjHlMI9lacsKK8UNLuMEEk51pOayJMrlllEVnM9OTq4EEEXMQj4kVbu3qgF7i2gab6pdGPFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQHHcViV; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQHHcViV"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cee1ec30f2so38837475ad.3
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785764457; x=1786369257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pw/rx9SP+mM7O539KcUF3r0TBZVycpjXm5LE9RCSGg0=;
        b=SQHHcViVFidPeEvFTLn9e2ao2Kgn31ShLAVrbsX6s5qcXRhmh8o/VYyqQ9DdK5Bi/9
         ItDmbqzpnx1M/3gF+kQAucobAX5PdacfyT0d/jd4g2DQrgYZOuPIdidVKBCXl27I3qnb
         B/jlyfG1n/WqvBIOJzlrwz02lAZKG/EI6EcMnS7NmrRKbkYtFhkUTWLWDnKh+wTKmPPE
         fUAiMUf0btWjSTJB8fPknlerA3ri7ftQCdY8gcn+JQl529ll/GHFZk8insfZ4PzWQBFk
         nLdPdwvGrFyL1fjuKGiuwdK+T2DM+LlbJ53bYRKnMG7YdqP9p/L77IuCfun+oOR7jMKR
         /P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764457; x=1786369257;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pw/rx9SP+mM7O539KcUF3r0TBZVycpjXm5LE9RCSGg0=;
        b=dZttWM+vMGMWLrNpD112kbX216AbyGv+gCvFO8tsy+pWeT7B6Rn3NA59hu2GZqtGd0
         VZ1eaKjmjP/BtsHN+MSwDiKBHn/IoQqGVytV8g+Gq/ISePPHW/LiO7t3XsF6Llo0lLiP
         +SqOjp9n1e8raElqktjQ99Ss8Y1WVgUbH34L9Glo7BOJijq1J0B17WN+1I4JXSA2mi9t
         WqD99uxCGCaEooWkVXwNhrKvd6NzwVPWuC0o13X8rTbnuQP1UlNJl1UztWN8z6IHXYpC
         AeM3gsgj40uhWkFhb8eupjI8HaI80tVw+VMzp0FNzZ1bHfn1e9Ldf7NEBRLA6j6uqvxJ
         09SQ==
X-Forwarded-Encrypted: i=1; AHgh+Rql1izvbiEI55TRrOiZxjyCxj62/Uz5wwyR113OBO51PnzGC5/MBBQbKvSi/tJih+GSMNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiqgtHMeX0+D9Yqdi/icbkc1Bpd80qjdV6xE/0l9mGOOH4zv+c
	HVf8xirFGl9i5ZLPPQGe/XAc17NiwrD77PseOaGIdndhGOE0aw2fl5SXzTfyfR2xw10EWIgOwtX
	8Resslg==
X-Received: from plsd7.prod.google.com ([2002:a17:902:b707:b0:2cf:ee73:1d9d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc3:b0:2ca:2079:91cc
 with SMTP id d9443c01a7336-2d052188c55mr109393695ad.5.1785764456738; Mon, 03
 Aug 2026 06:40:56 -0700 (PDT)
Date: Mon, 3 Aug 2026 06:40:53 -0700
In-Reply-To: <CABgObfZ5sPgfJz-_reACs5WkjRRkdNuinfY+nSrdHvG5xSiKUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731175834.1121005-1-pbonzini@redhat.com> <amztmWhHXUR4zBv1@google.com>
 <CABgObfZ5sPgfJz-_reACs5WkjRRkdNuinfY+nSrdHvG5xSiKUA@mail.gmail.com>
Message-ID: <anCZoc65i2xXNQgO@google.com>
Subject: Re: [PATCH] kvm: apply VM_READ/VM_WRITE checks to all VMA types
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2026, Paolo Bonzini wrote:
> On Fri, Jul 31, 2026 at 8:46=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > > * if the PTE is present, follow_pfnmap_start() sets args.writable to
> > >   false and KVM_PFN_ERR_RO_FAULT is returned;
> > >
> > > * if no PTE is present, fixup_user_fault(FAULT_FLAG_WRITE) returns
> > >   -EFAULT after checking vma_permits_fault(), and hva_to_pfn() ends
> > >   up returning KVM_PFN_ERR_FAULT.
> > >
> > > With this patch KVM_PFN_ERR_RO_FAULT is returned uniformly.
> >
> > IMO, returning KVM_PFN_ERR_RO_FAULT on a read-only VMA is wrong.  AFAIC=
T, that
> > behavior for VM_{IO,PFNMAP} was added by commit bd2fae8da794 ("KVM: do =
not assume
> > PTE is writable after follow_pfn").  Given that that's the only case wh=
ere KVM
> > returns KVM_PFN_ERR_RO_FAULT, I would much prefer to fix that wart and =
cross our
> > fingers nothing has come to rely on the behavior in the last ~5 years.
>=20
> We can try, but I'd rather not do that in stable releases (while this
> patch would be applied there, as a first step towards fixing the DRM
> issue that Sergio reported=20

I don't see how this would help with fixup_user_fault() not actually fixing=
 a
fault.  Neither returning -EFAULT nor emulating is correct KVM behavior.

> - it avoids the sashiko issue reported for
> https://lore.kernel.org/r/20260731160514.1101989-1-pbonzini%40redhat.com/=
).

But the issue Sashiko reported is just saying that KVM sometimes does what =
I'm
saying KVM should do all the time: return -EFAULT.  Or did I misunderstand =
that
one too? :-)

> > > For regular mappings a PROT_READ VMA, if placed in a writable memslot=
,
> > > would return KVM_PFN_ERR_FAULT instead of KVM_PFN_ERR_RO_FAULT when
> > > the guest writes to it.  This would cause a -EFAULT exit to userspace=
,
> > > instead of triggering emulation as the VM_IO|VM_PFNMAP arm would do;
> >
> > No, arm64 is checking the memslot, not the VMA.
> >
> >         hva =3D gfn_to_hva_memslot_prot(memslot, gfn, &writable);
> >         write_fault =3D kvm_is_write_fault(vcpu);
> >         if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
> >
> > Or are you talking about different code?
>=20
> I am talking about the "arm" of the if/else if/else. :)

LOL, overthought that one a bit.

> >
> >         /*
> >          * GUP failed.  It could be an inaccessible mapping, a pfnmap o=
ne,
> >          * or the page might be absent.
> >          */
> >         if (vma =3D=3D NULL || unlikely(!(vma->vm_flags & VM_READ)) ||
> >             ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM=
_WRITE)))) {
> >                 pfn =3D KVM_PFN_ERR_FAULT;
> >         } else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
> >                 r =3D hva_to_pfn_remapped(vma, kfp, &pfn);
> >                 if (r =3D=3D -EAGAIN)
> >                         goto retry;
> >                 if (r < 0)
> >                         pfn =3D KVM_PFN_ERR_FAULT;
> >         } else {
> >                 pfn =3D kfp->flags & FOLL_NOWAIT ? KVM_PFN_ERR_NEEDS_IO=
 :
> >                                                  KVM_PFN_ERR_FAULT;
> >         }
>=20
> Yes, but I'd do that only in 7.3.
