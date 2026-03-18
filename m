Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762A736AB50
	for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820263; cv=pass; b=NkxaO6yYzO8cX81XUgzQ9Uz+YXczTEk3AwAOJRkIDLMr6ZSGyO9O5cf1q7jkJpEl/T/aQSkThXtx0IaEpVD8Pxez6RB004rCdEs75lkz6ayCl7cFqHdb020d/iKjC8gwEXTOLMp+Pqir+frFM2VRV8TSZGwZ0aL6dlxIpZRCyKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820263; c=relaxed/simple;
	bh=MNEz/X85loWkzSvdeSo1EvIq0bBQvnEfbZRngw629Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oF4xLV/2NGrxc88CqLox8G9MhsrPWGJqnEldkK6RK+svFJkpG9LAKCdjUySzLtSAM9DjFTu7qzWXOTy88nA3kPpwyAgoAUSonCESJdnxy9/R8Vn0VVMPVZSbx+y+XSgmaVVPSeu5TQ5JqTYPrlRFXLpY8ojHnHj6tM7O2LbAswM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=fbdezFUW; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="fbdezFUW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so54014765e9.0
        for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 00:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773820261; cv=none;
        d=google.com; s=arc-20240605;
        b=TXiSsPD2A8/VfEoVg8usor0aBSUEyBdBx4XR2G9kU+PAaSPbmeZyM7oT0O99GjGuWk
         xvQBdnSZSRz3oSmVn4VNIrT1bWF4sJBey4EJjsX3unmqTP9RdcgqMCF+qMmw1IHnpYVo
         T2z75pXFrBTWwQlu7MhB7pEh4RBvN8vqaPf/rCs+iOgDMeiWKuPJcUYu/kQCXV6gPyis
         ifjhICmMdBg7BE1lzEnRwkMFvSMPWABQde29ZR1eoh8jD3+9JrslxtSJmv84/A3WXLYr
         7K5/bn0OpxsaT8mj2rztyW0HgwO70FGYJvTNqxVd5KpCJZ1X2TvNdoiL6B3TqSsADf+o
         uVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fMQRUHLyKxTqxNpKo/ip+ZuLi6vlM1ojm4NscfYg0vo=;
        fh=/goRtTuOe2Gq6c9MWiTHR/PMEOkFwDJC0nx2l6yUx98=;
        b=YmSs6XibsdPRLMBUrxQYUMjU6smAdt6ktv1j9pEh3aRDdlg1UT+kQkW19SvYpNGnHK
         NWMOqw7rcNwMY1JOmmnJo2QtskKE93eYAWgBsXqrmSyhMldxcuwRx3uQezNPR8YZpo34
         xNj1BveSoHyMotEs+kEk0aDdP5nkzImkvp//SLbRr7OGdVfzJnP6eRZH24zMn4lRosDz
         M9TNdxobfsv2ucVwWLLsUFstqAZKfFFPrxbHHWT9sfNyzw2O9oAZsl3dN38gjsEpBdHN
         kE8w5c6zu6WNi4HROc1XPEGtjmlQssYVKVETQEjz51ubgcFGdsIU3XJLQtAda3VFU5aY
         3cJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1773820261; x=1774425061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMQRUHLyKxTqxNpKo/ip+ZuLi6vlM1ojm4NscfYg0vo=;
        b=fbdezFUWGWfgzX1qB0wiu6X4VfJf4fHgK2GCbzArvHTKBqAMEkNYMbTVCjTIvaP00I
         +zSeQZvy91VIolnxHYRIHa4pBaKlQLkY8ikVRMjqwnmf4eR3zsX+Sz7o8BMg+WJwEJ+A
         BOzSw66ckIZAYLDymMSUtINbqJ30zziuiKiWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773820261; x=1774425061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMQRUHLyKxTqxNpKo/ip+ZuLi6vlM1ojm4NscfYg0vo=;
        b=SQWEW5Xn4uoUKagqOQEBJXYuaKIfKPJj8JSg01oktiVLLCLjmxRPwJMUxVf+6QCCQJ
         xdt9hb0DZozWXwwPnrJXjVsQmKORib0V/jhqh2msW1R/dgacrMgWhy6W/gr9oMDDZPG4
         bX8U8FuD20g5QxwvlHsVymAhuJ9iE8Y2zZSOzbu/jpKhOLG2n0fS2QgdRqRyHIo3HZXp
         3sapfRTsazjPtleTfAxYonG8Fqyqe8kMeCNvR9iIOWk1NprhRbqRLxo5xtRrdr/nBnL9
         5OoxO1f0AJknefqBTcI4agiQhtqZdMXyShF0QvG2T33YFyOzqmBI+3L1ZYvJxS81dCtg
         kI3g==
X-Gm-Message-State: AOJu0Yxhp7DMLTF88Lm/634KMJK7AtWVRJ6g4XFihLsoV0GDeoBb7IXc
	X0sQJzG1xbtKjsjxZudNoqdN942DsBzTWkpr8xNX670+S1qccyCAXaB8/Z7TqnhEopNn6u8X8XH
	dYbGbK0lo1iQIEvsDlJ2c0pzZZuR9BTFlC0t1wAUpRw==
X-Gm-Gg: ATEYQzxjdoRXn3sdZ+k4mCXKKD5qwaCNNXxy2CMqkj939xLnoF71lMMYOigz66eoAw5
	UC1YKmjrORhD+G0CZB/rKT2GFpLvBZp99Z8OXxq8R+N1TjuE4evCRzWTVRouApQufoFNSnsWw4n
	/0wmPtOVBsqojmzLnTx2awTaCW/qswrgDelvZRrRd4rW1360xwd+NNvKE00lyOYN2A4ob9lefoF
	ZFm0N8hVSs2aDLhUALquWKNGTOFzIda4sPjMSqw+sKv68fX4i4zSjBE7gYsCTSD6uPSLEtQ5yjO
	aOFbwN4=
X-Received: by 2002:a05:600c:4c24:b0:485:3a93:3a9e with SMTP id
 5b1f17b1804b1-486f4422015mr20802805e9.10.1773820260804; Wed, 18 Mar 2026
 00:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311105047.18517-1-0wn@theori.io> <abFzwjGJm1j02L36@google.com>
 <CAH-2XvJo_JiyAnb21_LYxSz8xZ96oUVF25eTnDyALF+wnZw8ww@mail.gmail.com>
In-Reply-To: <CAH-2XvJo_JiyAnb21_LYxSz8xZ96oUVF25eTnDyALF+wnZw8ww@mail.gmail.com>
From: Taeyang Lee <0wn@theori.io>
Date: Wed, 18 Mar 2026 16:50:24 +0900
X-Gm-Features: AaiRm51arlXQZeLuVomAxuvpszB6jxH0L9MqB5r-AcQ0b2yCwRP4hi6U-cDb5Fg
Message-ID: <CAH-2XvLboDdyeyHoLpnzm6e2++ksehDfosy_uKRH+emCrcWx0Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: clear map->gfn in kvm_vcpu_unmap() to prevent stale
 validity checks
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, KarimAllah Ahmed <karahmed@amazon.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Gentle ping on this. Based on your suggestion, it sounds like the right
approach is to backport the 321ef62b0c5f series to the affected LTS
branches.

However, looking at the lore link you shared, it seems like the backport
didn't apply cleanly due to SEV-SNP dependencies. Do you have any
thoughts on how best to handle this for the LTS branches?

Thanks


On Thu, Mar 12, 2026 at 4:00=E2=80=AFPM Taeyang Lee <0wn@theori.io> wrote:
>
> Hi Sean,
>
> Thanks for the detailed review.
>
> On Wed, Mar 11, 2026 at 10:53=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Wed, Mar 11, 2026, Taeyang Lee wrote:
> > > kvm_vcpu_unmap() clears map->hva and map->page but leaves map->gfn wi=
th
> > > its previous value. This creates an inconsistent state: callers that
> > > check gfn !=3D 0 as a proxy for map validity will believe the map is =
still
> >
> > But that was and still is flat out wrong, '0' is a perfectly legal gfn.
>
> You're right, I hadn't considered that. Setting gfn =3D 0 as a sentinel
> is fundamentally incorrect.
>
> >
> > > valid when hva is already NULL.
> > >
> > > This pattern caused a null pointer dereference in the 6.1.x LTS branc=
h,
> > > where vmx_guest_apic_has_interrupt() checked virtual_apic_map.gfn but
> > > dereferenced virtual_apic_map.hva unconditionally. That specific call
> > > site no longer exists in mainline due to the gfn_to_pfn_cache
> > > refactoring, but the inconsistency in kvm_vcpu_unmap() remains and co=
uld
> > > affect future kvm_host_map users that rely on gfn for validity.
> > >
> > > Similarly, kvm_vcpu_map() does not modify the map struct on failure, =
so
> > > stale gfn values from a previous successful mapping survive a failed
> > > remap attempt. Clearing gfn in kvm_vcpu_unmap() ensures that after an
> > > unmap-then-failed-remap sequence, gfn correctly reflects that no vali=
d
> > > mapping exists.
> > >
> > > Clear map->gfn in kvm_vcpu_unmap().
> > >
> > > Reported-by: Taeyang Lee <0wn@theori.io>
> > > Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
> >
> > This is not the correct fixes, the blame lies squarely on 96c66e87deee =
("KVM/nVMX:
> > Use kvm_vcpu_map when mapping the virtual APIC page").  The API even pr=
ovided
> > kvm_vcpu_mapped() from the get-go; why commit e45adf665a53 checked the =
gfn, I have
> > no idea.
> >
>
> Agreed =E2=80=94 the bug is in the caller misusing gfn instead of
> kvm_vcpu_mapped(), not in the unmap API itself.
>
> > > Signed-off-by: Taeyang Lee <0wn@theori.io>
> > > ---
> > >  virt/kvm/kvm_main.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index 7a4fd1dbe0d7..88fc8b20aa8f 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -2887,6 +2887,7 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, stru=
ct kvm_host_map *map, bool dirty)
> > >
> > >       map->hva =3D NULL;
> > >       map->page =3D NULL;
> > > +     map->gfn =3D 0;
> >
> > As above, this is at best misleading.  If we wanted to harden this, we =
should do
> >
> >         map->gfn =3D INVALID_GPA;
> >
> > but I honestly don't see the point.  Yes, we had terrible code in the p=
ast, but
> > the above doesn't prevent terrible code.  E.g. the correct invalidation=
 wouldn't
> > actually do anything to make the terrible code less broken.
> >
> > We even (somewhat unintentionally) removed that terrible code in commit=
 321ef62b0c5f
> > ("KVM: nVMX: Fold requested virtual interrupt check into has_nested_eve=
nts()").
> > And that commit was tagged for stable@, it just didn't apply.  If we wa=
nt to do
> > anything for 6.1.y (and 6.6.y?), we should backport that entire series:
> >
> >   https://lore.kernel.org/all/2024072925-straw-mashing-54f6@gregkh
>
> I see =E2=80=94 so the proper LTS fix would be to backport that series ra=
ther
> than adding band-aid patches. That makes sense.
>
> For context, I sent the patch because the NULL dereference appears
> to be guest-triggerable on 6.1.y, and I wanted to suggest something
> minimal for the LTS branches. But based on your feedback, backporting
> the series that includes 321ef62b0c5f sounds like the correct fix.
>
> I also sent a minimal NULL check patch for vmx_guest_apic_has_interrupt()
> to stable@vger.kernel.org. Would that still be reasonable as an interim
> fix until the full series is backported, or would you prefer to just
> backport the series directly?
>
> Thanks
