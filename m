Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB32F49F6
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 05:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736464; cv=pass; b=cX1qIhr24ffhtFwVcPTa8fKygFi6bPEGFGf6RznZaODkOTrcLGFAhzElLv59HzdDDgbChdKjhUAlo0ilGYzDVvXoE1qT/CSl4d9IkxIXipKdCtKkK/FZnCcPrfrUGfnzOe44s10wR5ckWkcSI7GYemAWm7DX3sRpL+6kSzYbfPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736464; c=relaxed/simple;
	bh=dyUWV8KN04iAs0XyVi8CIp8B7jpfJ5SWIOxJEmg/PSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcEgqZkxvbWuUClqb1EVZK+bgp9ij3Zs8WM9cA/G/MCZ34YeVDqSah3tPnhryLotMT2hjom/oyp3t5oiCesMkXZ9IKFfLQhhg4fFg4krKOdunJYhde7hO6zQ4rrkHnsbVwUcHdm7jqksfOeh6/MvOD0VspuzdS0RW7JSYYQRRBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5G2/bLk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtT8wifR; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5G2/bLk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtT8wifR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785736461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5UzUHk/NqFH+dmmhPn/v4FC1befJierqvxDM4oRRwo=;
	b=V5G2/bLkTxxEvivho3sPnl1jVzeQcZFKrly3+pDrEJ7BxluEmPIm7WiR72vlbqsoF05rrN
	4Q8puQsH51iO/CbVApnmvM5Zuzq314F1q53wYKLTyDY4WBEZLibKyqjqyFOo2IFz5YNczJ
	865Sm+o35WM9lWbLZFZ1VTT6pyjKKck=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-rlC7DA78MhSUlE20pNetOQ-1; Mon, 03 Aug 2026 01:54:20 -0400
X-MC-Unique: rlC7DA78MhSUlE20pNetOQ-1
X-Mimecast-MFC-AGG-ID: rlC7DA78MhSUlE20pNetOQ_1785736459
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f8f8fde2dso2105776f8f.0
        for <kvm@vger.kernel.org>; Sun, 02 Aug 2026 22:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785736459; cv=none;
        d=google.com; s=arc-20260327;
        b=Y+K2viN8lzuL5aRbKM3j8zFaEvsPxcsuP4XGbNLvl9mL5rwOCWsLoZ4X2vP6xfFtqw
         PgkqA50rrwlCINnJPo/Vfz4TVzbT6SYRMujKc7YBGF0FLZ4KEqpXDY0ne0/Wt7QnX/IY
         fUt5d48UKV8dSwJY8PsRmWkaxSNrq2s4RsztOWbYRCDrgF76aPqBlsoPZiOIphfKA7/m
         1tG9sfGalgMJ1yLlewQEhIojTyqh3FGtHKZmdvCs+X1OnbNCHRt8aWtwKAossR09/HAH
         aWqgQUzXTEYEs6R/h5qgobdAp80O1+kpYuIwnqYHSliNe7Vme5b+xekauhqo34Sx0SyY
         R0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V5UzUHk/NqFH+dmmhPn/v4FC1befJierqvxDM4oRRwo=;
        fh=KiUb6NMJaEloMC4NiVOFhmGRqeklaeAjU4iLeFMIwTc=;
        b=M83MvSduHfX3Nbz2CC+hhhv1opaOfFBQ1YR9Ey3u1z3zWweycgrYpduXUtr8ND54WP
         xlRgD12DJCRqDhGr2qZqbKzDCNS2njHKQ6GzHJLVr/1lqS/wk+sazWoQV2P2bYT4Thed
         r1NL9lINY02/Xw/Coe2vM8SbMB0diJcIfDCDbCN070eHHEgWCQm1kIpRO7JfCYWt1lnn
         vLRAfsu3vVxuTEbfOn957Ie1gDC4dRAfuQrkN3eRqcofP2XZjgUZ553NHelicBOr4uMU
         sXZd1+oQ4d0ofqqY/jDM9bHarUkn5FPJRpNoIefe6mfqkeACgVaLrj+8xRbX1v73ZJYJ
         +fPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785736459; x=1786341259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V5UzUHk/NqFH+dmmhPn/v4FC1befJierqvxDM4oRRwo=;
        b=WtT8wifRXu68hGiWWIOuAYMeXxLjH5eIq3KFEpjJTJ66pcl5vojKZpLi37z+XfiANi
         /tnFrYTwuPSaFoYsDnWEo1W034yv6/GRdawvzir4nGDw9JHx9S5kveCUwEFKnXWvonhL
         JVxs/guj4D2lYgMOzK5V3/EETnf5zCShnMl58Ok2sFly9V6R88iuWb8XC27Zv77qLwYP
         ct2j+U4vpZjLxdsFfKILnJRnbuVgSuuyNoPXfK6zrP41iISg5E+cB3zcA/E2Ggvqnu8D
         SmNSCBee9amU6TkklON62ON/y+QNxGXxJtLpZ2SJIIMnTmu1H7EDS0Nx4tMbqJrxJM4y
         Hw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785736459; x=1786341259;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V5UzUHk/NqFH+dmmhPn/v4FC1befJierqvxDM4oRRwo=;
        b=KOjv27MyclrDCRQU73t3VB8rEDoS6JzVAp09I7HQ42vv1by2kEf+mJsPiWooCYT1Sc
         tCdxenhxSD6JXpwo/7trykFKBtfUK34Bwan8akmiLZ0UjMsNTLSj0SkG8drvbv037cKJ
         sjuLBcLmX4rD+foBqQ4uOIFkcSiQVEG8BthXPOreLHzzWgJSxkWQvxWn1/lsA5gRW518
         0C11DmXMo3Sw9aqgi7ggKJdqX7R9/DmPYbJ2nZvERwY/4N0P8bQ7rdPJYRg9TQlsaCD4
         +QEkADtAvXCw3WDbPg8LS8EQyX8veykhn+OqR5QfJX5nvOYsuoFjUZvJkpC960HOW/WF
         7FcA==
X-Forwarded-Encrypted: i=1; AHgh+RpuTkFZ4/C+SfPCFqvMp8sacQoBGUXzIYkIyZyTYCk9fnXLaMrGpV4BDRzdnYmsNGfP3Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt4FfvxetrsXqiEyTsdS4gjivcEX748kDObyRYsdr8KVFdwDru
	7aDxItOk8DQwhnPHYlTMnMbonhrL/RR20j7LpTfPFJUJEftf3sZJhXqTispQvqhdOyWhJnB/pKg
	gnIkSpd2UAxA3GO/pqV0fV6I1zi1m6mDbyR14QQJZ4VZGK4m8Jw7+bi3BJUOLBnesQ9JeEYhvTW
	DiZz9+DHUyuW95aqgFUzf+t1ISn61E
X-Gm-Gg: AR+sD11P9nNRJGPsBKMowjSPv3BQjoZuh5LiNpBT4nr7SfrY1HZIJ/JGqArzNaXCuPB
	n8iPIFb81BIvyH+dxwu6AqWNhjSdfSFkoEQvpnMTKuJMDrPnWiK+e/2dJ3RnTiNReyHn/ajCYDx
	G6AXOWGNm8dvMAhq2z24XDu1lcr1mcpTh926z92dIa9g4CWKNM2ox979/Jd4HCE8Hzy+H7soB8U
	1QLKaNBEXXuG7VKj8SlhQuE8gKDjHhUWb5w3IzuUNsxgJHFXFG+ElN0GoA=
X-Received: by 2002:a05:6000:26d3:b0:47f:5369:bba with SMTP id ffacd0b85a97d-47fd72d3107mr20736400f8f.15.1785736459153;
        Sun, 02 Aug 2026 22:54:19 -0700 (PDT)
X-Received: by 2002:a05:6000:26d3:b0:47f:5369:bba with SMTP id
 ffacd0b85a97d-47fd72d3107mr20736380f8f.15.1785736458869; Sun, 02 Aug 2026
 22:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731175834.1121005-1-pbonzini@redhat.com> <amztmWhHXUR4zBv1@google.com>
In-Reply-To: <amztmWhHXUR4zBv1@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 3 Aug 2026 07:54:06 +0200
X-Gm-Features: AUfX_mygsFdJ7uqwBVFUqkdvo2pUCii1-TN0zbcktHcwEQDsD2t1D8hdelp5cCM
Message-ID: <CABgObfZ5sPgfJz-_reACs5WkjRRkdNuinfY+nSrdHvG5xSiKUA@mail.gmail.com>
Subject: Re: [PATCH] kvm: apply VM_READ/VM_WRITE checks to all VMA types
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 8:46=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> > * if the PTE is present, follow_pfnmap_start() sets args.writable to
> >   false and KVM_PFN_ERR_RO_FAULT is returned;
> >
> > * if no PTE is present, fixup_user_fault(FAULT_FLAG_WRITE) returns
> >   -EFAULT after checking vma_permits_fault(), and hva_to_pfn() ends
> >   up returning KVM_PFN_ERR_FAULT.
> >
> > With this patch KVM_PFN_ERR_RO_FAULT is returned uniformly.
>
> IMO, returning KVM_PFN_ERR_RO_FAULT on a read-only VMA is wrong.  AFAICT,=
 that
> behavior for VM_{IO,PFNMAP} was added by commit bd2fae8da794 ("KVM: do no=
t assume
> PTE is writable after follow_pfn").  Given that that's the only case wher=
e KVM
> returns KVM_PFN_ERR_RO_FAULT, I would much prefer to fix that wart and cr=
oss our
> fingers nothing has come to rely on the behavior in the last ~5 years.

We can try, but I'd rather not do that in stable releases (while this
patch would be applied there, as a first step towards fixing the DRM
issue that Sergio reported - it avoids the sashiko issue reported for
https://lore.kernel.org/r/20260731160514.1101989-1-pbonzini%40redhat.com/).

> > For regular mappings a PROT_READ VMA, if placed in a writable memslot,
> > would return KVM_PFN_ERR_FAULT instead of KVM_PFN_ERR_RO_FAULT when
> > the guest writes to it.  This would cause a -EFAULT exit to userspace,
> > instead of triggering emulation as the VM_IO|VM_PFNMAP arm would do;
>
> No, arm64 is checking the memslot, not the VMA.
>
>         hva =3D gfn_to_hva_memslot_prot(memslot, gfn, &writable);
>         write_fault =3D kvm_is_write_fault(vcpu);
>         if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
>
> Or are you talking about different code?

I am talking about the "arm" of the if/else if/else. :)

>
>         /*
>          * GUP failed.  It could be an inaccessible mapping, a pfnmap one=
,
>          * or the page might be absent.
>          */
>         if (vma =3D=3D NULL || unlikely(!(vma->vm_flags & VM_READ)) ||
>             ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_W=
RITE)))) {
>                 pfn =3D KVM_PFN_ERR_FAULT;
>         } else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
>                 r =3D hva_to_pfn_remapped(vma, kfp, &pfn);
>                 if (r =3D=3D -EAGAIN)
>                         goto retry;
>                 if (r < 0)
>                         pfn =3D KVM_PFN_ERR_FAULT;
>         } else {
>                 pfn =3D kfp->flags & FOLL_NOWAIT ? KVM_PFN_ERR_NEEDS_IO :
>                                                  KVM_PFN_ERR_FAULT;
>         }

Yes, but I'd do that only in 7.3.

Paolo

