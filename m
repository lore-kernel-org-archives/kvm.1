Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618C3AC0D0
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773298854; cv=pass; b=CTO8REH5UarV/S/Iw6u/DMlCRN72AoalHrQCnP6Zsa6LJ7iKJInNjZ7GI4myCBdcumu0ajKjxliacFgFPOdeBXw491Bn8spDl9A4k/zTgK8mA11xnkDyys3cDK6NrNEfk9qvDjAWwzzVeo5hsoYrzbt3pv3LR6ry1oKIvBq6lx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773298854; c=relaxed/simple;
	bh=qWPLhWSyf1EIfo6jvLDnIYO6doU1eRWodDa3baXdf6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCCqY22y7VIANADRGdy1N/ejZpJgUZWS9DQDn+ytB6Kjc1iYX8Gj6WAY6qGnQEed3g5YIE84hf5rSEo0Oa/cgzZyYZfdc40ibAj3q+QEL3IFVRIIHJ7uMRJDedEfkOq6ONJkqoYVGH+kA8OfUzGVjeYU9BA/RCQ3OwfQbQF4gKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=VLayXvBA; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="VLayXvBA"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439d8df7620so436902f8f.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 00:00:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773298851; cv=none;
        d=google.com; s=arc-20240605;
        b=N8SjNE6PEJ31PGUJh4zj4pD4/OTmWD2a1KVABGOjnz5oEJh4K2zolwETgjBPESPhgd
         VrqWldUQJT3mHf2LT/96UQPOcYF91Tkb8oTC/llonxOhUhkzWsdgMInEGUHWd4HynCl8
         Wp4t9bHTUUaprdXGJU4be6pMeKR3Rm8TQASZ3+9TcCMhgCarUBwEiFZMO1NqVMGgGxTW
         bby+SAV3rtpaPePyaQzmICEQD7Ywuns0+zNhAghYnRY6/1leOtaEGlFvpRxETuajIpH4
         adO5q7Nckks5nGqVLNZ8ECpgRQuoM9vzfTcSSkSoRS4tZiUHzlIoQJadhaf2Gm/a7xPb
         CqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6bQt829ScL64SxJy1/G3Hp8ZoUZESXdhyl388i4pZik=;
        fh=/goRtTuOe2Gq6c9MWiTHR/PMEOkFwDJC0nx2l6yUx98=;
        b=Qv4JHczy/WjeoWMzajrxq1k7HFEfpIkFUADH/0ci5D1eFt6wHYvXuFgZMDwHXQYzTu
         F+S8dSZCfqb7mykg5YJAzdL2NK1eN57McF4vQzI0n3L+9JED3tFWd7iVuW1CNx4T1AAD
         7YRAezZlItf1OL7SsaxWMfBC9ELoJadaLqLTwEc1wfSukIakJxZlJrg4Gn3NDR9ivKSs
         GjDjU4oFSC0gpOELchJAQcLRf8VoWUqPkD6MQsJvgGWGYTn93WyLMNqMGKvcqMW9MBnp
         tuEsVeyChAw2C+kHmeVSUor9VmXj+Bqg4PahGVD4ZvSMAYxlM0oYdS91vY13tli9aCSC
         hUJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1773298851; x=1773903651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bQt829ScL64SxJy1/G3Hp8ZoUZESXdhyl388i4pZik=;
        b=VLayXvBAeULHEz8iz8Ig1W/lSD6sUiQcT3AWKVHJTMN9AQkgxARiTKULvYn1YaQwS1
         mFUi+3Jw6G15g3qvAZ4fOwR8jH4LfFY1y+/awU3OKS22DVT12KhuJwI4MVU24kwPIOgg
         U47p1nqFALhEnV3atnXibzd2AQcidBQBhhQSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773298851; x=1773903651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6bQt829ScL64SxJy1/G3Hp8ZoUZESXdhyl388i4pZik=;
        b=k4Lc+5k9+G4rizmlkyTsUUltbBuBKs2OQhNjAQjamQbKscVvQRvLvq2kz/5o58FeOb
         k28kVA3lvPhS9KLl5/d1EmwoAnnULGaa7falu+zvF2fTuQgibIwtuE49QI5V+TNMG7hA
         myn4JoIigvGORcCsMogwZu2lfeVGPKLnetLrxMKxDPjTR8LpLdHZIICn0HwhRgb5pMbZ
         +NcY4HH+kefv4yNrbwmT045QYrLc/wXMpII4kRilWOECN/xhqVbW+TIuo116v7vyWxud
         PMBgwDEvaG90UNkfaEguQN1mKAZw5fpFSHjwYfKnuLyrSry90I1R5+qK9ZIpAioiuET0
         V+ug==
X-Gm-Message-State: AOJu0YwMqII/ZDGGCNufZMHCZqecUIVMc81LoVapAGVOuKWMwD20R2WV
	JgDKvzXKwtvPdPyOaZDGa8n2Kl+aXeiuOvOlyChbqXJh0EYqIFvG8FldX/EiNpVqzay46UHfUZA
	y5J6/qjrcMtn4X2QRbSQJpmkNjkRD6tcdlBn+tcLzhg==
X-Gm-Gg: ATEYQzxVBQQXfSshebc8bR2XpkXSrrDnXsW9FU6yQ9iHOV0zLy9fdoAYfjyuT8HccV1
	cNDChyKKjU8w1gZ3BII8V9f/OKCovQkiROwLXWTmJAbwlfbAltCXvD/ZNIoGexPSALIFAVTRZmU
	EeQswxO918xTuMMjIfY8wKiqcJd1C6G2CMNzngkpnBjbKhLL+FOTLaORukyZvRm/nG0b2kWcghk
	Mohh/yCi5sC0H5DHE5TTvI02CCPb4Q6jOrN9fNJFTJubWLMmGpBV721HqvLKRbg1O2TdPf7AKpE
	lC0imUw=
X-Received: by 2002:a5d:5d84:0:b0:439:df25:b707 with SMTP id
 ffacd0b85a97d-439f84241b0mr10218944f8f.55.1773298850567; Thu, 12 Mar 2026
 00:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311105047.18517-1-0wn@theori.io> <abFzwjGJm1j02L36@google.com>
In-Reply-To: <abFzwjGJm1j02L36@google.com>
From: Taeyang Lee <0wn@theori.io>
Date: Thu, 12 Mar 2026 16:00:13 +0900
X-Gm-Features: AaiRm525L8Umq-xcjrFNU1Ty6kjIF9IN9U460nrmqS3kVIvhowjvKbxOTvw-Jvs
Message-ID: <CAH-2XvJo_JiyAnb21_LYxSz8xZ96oUVF25eTnDyALF+wnZw8ww@mail.gmail.com>
Subject: Re: [PATCH] KVM: clear map->gfn in kvm_vcpu_unmap() to prevent stale
 validity checks
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, KarimAllah Ahmed <karahmed@amazon.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

Thanks for the detailed review.

On Wed, Mar 11, 2026 at 10:53=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Wed, Mar 11, 2026, Taeyang Lee wrote:
> > kvm_vcpu_unmap() clears map->hva and map->page but leaves map->gfn with
> > its previous value. This creates an inconsistent state: callers that
> > check gfn !=3D 0 as a proxy for map validity will believe the map is st=
ill
>
> But that was and still is flat out wrong, '0' is a perfectly legal gfn.

You're right, I hadn't considered that. Setting gfn =3D 0 as a sentinel
is fundamentally incorrect.

>
> > valid when hva is already NULL.
> >
> > This pattern caused a null pointer dereference in the 6.1.x LTS branch,
> > where vmx_guest_apic_has_interrupt() checked virtual_apic_map.gfn but
> > dereferenced virtual_apic_map.hva unconditionally. That specific call
> > site no longer exists in mainline due to the gfn_to_pfn_cache
> > refactoring, but the inconsistency in kvm_vcpu_unmap() remains and coul=
d
> > affect future kvm_host_map users that rely on gfn for validity.
> >
> > Similarly, kvm_vcpu_map() does not modify the map struct on failure, so
> > stale gfn values from a previous successful mapping survive a failed
> > remap attempt. Clearing gfn in kvm_vcpu_unmap() ensures that after an
> > unmap-then-failed-remap sequence, gfn correctly reflects that no valid
> > mapping exists.
> >
> > Clear map->gfn in kvm_vcpu_unmap().
> >
> > Reported-by: Taeyang Lee <0wn@theori.io>
> > Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
>
> This is not the correct fixes, the blame lies squarely on 96c66e87deee ("=
KVM/nVMX:
> Use kvm_vcpu_map when mapping the virtual APIC page").  The API even prov=
ided
> kvm_vcpu_mapped() from the get-go; why commit e45adf665a53 checked the gf=
n, I have
> no idea.
>

Agreed =E2=80=94 the bug is in the caller misusing gfn instead of
kvm_vcpu_mapped(), not in the unmap API itself.

> > Signed-off-by: Taeyang Lee <0wn@theori.io>
> > ---
> >  virt/kvm/kvm_main.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 7a4fd1dbe0d7..88fc8b20aa8f 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2887,6 +2887,7 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct=
 kvm_host_map *map, bool dirty)
> >
> >       map->hva =3D NULL;
> >       map->page =3D NULL;
> > +     map->gfn =3D 0;
>
> As above, this is at best misleading.  If we wanted to harden this, we sh=
ould do
>
>         map->gfn =3D INVALID_GPA;
>
> but I honestly don't see the point.  Yes, we had terrible code in the pas=
t, but
> the above doesn't prevent terrible code.  E.g. the correct invalidation w=
ouldn't
> actually do anything to make the terrible code less broken.
>
> We even (somewhat unintentionally) removed that terrible code in commit 3=
21ef62b0c5f
> ("KVM: nVMX: Fold requested virtual interrupt check into has_nested_event=
s()").
> And that commit was tagged for stable@, it just didn't apply.  If we want=
 to do
> anything for 6.1.y (and 6.6.y?), we should backport that entire series:
>
>   https://lore.kernel.org/all/2024072925-straw-mashing-54f6@gregkh

I see =E2=80=94 so the proper LTS fix would be to backport that series rath=
er
than adding band-aid patches. That makes sense.

For context, I sent the patch because the NULL dereference appears
to be guest-triggerable on 6.1.y, and I wanted to suggest something
minimal for the LTS branches. But based on your feedback, backporting
the series that includes 321ef62b0c5f sounds like the correct fix.

I also sent a minimal NULL check patch for vmx_guest_apic_has_interrupt()
to stable@vger.kernel.org. Would that still be reasonable as an interim
fix until the full series is backported, or would you prefer to just
backport the series directly?

Thanks
