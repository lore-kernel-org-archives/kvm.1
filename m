Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673A349738A
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661262; cv=pass; b=JmZX8MR2XHuqyot3dVjXpayBUrMHe/WU+BbG6QxOpnqNAvvFFWOrMxTO1uWdg2VuNG2eeG7WX/h3+i+xlv+FNyN9pHK4vHRXB35l/UWE2XQDa/3GlNST4SDVC/jQvCNEiwqlkmLz6RE4Uzs87tA0oI5EYhTiYgWOFpouhUCo0DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661262; c=relaxed/simple;
	bh=/N1x2qJWKt/ISxWnj1C9Ez0cBTgeK7kvVDIzd5pQfgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYt2sXTJor8PZTJSeVYBDNZ4RMHNIqtH5XXfspsIAw5qSwEt9quoTdtVcmmSOQxxav0xr/YeEdOASuBpI2pCTfNKy2oeB0CsZVB/NKywRjyZS+uVNut4yOT17Lr5jQiPe3SxOH552WJsKAXmcWfMDctfGW4E0XdxAc8uR3eRwJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdRvKZrL; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdRvKZrL"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4bb359e6878so458399b6e.0
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 09:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789661259; cv=none;
        d=google.com; s=arc-20260327;
        b=R13/ry0HGfGTvi7sIISuVy/QpsaUshsxyc8kphv9wQ6+QRg0+11Zl3bn5za+Kh+6UX
         myivpziQkSs0sWLucyS5wTSGQ6SWa2OOuCEJz2hYcqiv80S+28Af2fEfB8BswYaUBQxY
         O/KR7Ts8oPKD6xFFAPRpvbnFhYp7KFCxu5hZpSZ9iAxLxnkjMYX7YdIZz+adXrVYmlMD
         VWbjXZrJuCenHkK+XpZVuKpu9bzMmEHFVRsJlFPlrfSQehrbCpdx+FVi7ABuhoyYnOb+
         fbDZoK4F6cmnjKg8JT20ZgRiAqfS32g/NGkFOkpxbNfwWay1RltRWd4AXKDMwE6wEL5N
         EGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l3MioL724gs+UVbiJEnls3vBD+TgOf8MlquQ8q/MLdA=;
        fh=excXzg3YEVkkJBKIiBdFVr6R1RJ+UujNla3XFNJ7OLk=;
        b=FadD63ZxGRDQFXsCiPZMUoK+Qf5EnERLY2l5NgextzZIUlAUzKAL9fNQV2dFZpoQ5+
         hf4Bmu3EXGWHFJSL8OWZuLCSgnlXh2iBtJ6B3qSKZyNv1NwOClFMmmXBNtZXWO9MKzlA
         xmwbbRL3+oUKG+9trt79mytveCMT7dhTDg1hmUpb+9jnYcK3fkDhOZhuRLV0a1puvSPF
         C80c2yibBaZLiKm3XCodQexrY+pHKYpfPXXFZXRqwtGxEtgOU9qTwSEAMZiTZkxOc0sY
         l/ywP4IDRyrzcLMt8/y5JFIJ5pduCughoCOq/wq1OPwegSgoFIS5nUM5uJghT6STN1UO
         Fvxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789661259; x=1790266059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l3MioL724gs+UVbiJEnls3vBD+TgOf8MlquQ8q/MLdA=;
        b=cdRvKZrLr+l5xgdGazxVtvyOxJeu5TOK9rhZEJNdx3IGUwoSLBXZgtqEXvul8rR/tT
         2mOfmgkKXxfTxNFFoQDBEJxpWzxi7cApefqPh7olpHU4aAHgLrzf0a77f2OAeznF6skA
         3NiN4JwfjR3qve7NODyJ7Fugclyq+7RubDgnOt92vJ0GquLphHoqbCfuD1EPkkYMeVkX
         L86hh4HRR/Qg6YfBkhTOeOrQ+mbE3Tjg/N5sjWgFiROpRS+LUEmoATf4QjagDtS/taFN
         v5CLL6IBYswlZw5WlHDYK02ojE1vpFDTZVV6Lw6X7YDhtJKsrL40GpBKAm1rRGzRXrE6
         vlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661259; x=1790266059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l3MioL724gs+UVbiJEnls3vBD+TgOf8MlquQ8q/MLdA=;
        b=0/cTZ2heUjHageGztVEjjDklpA14LD4ObbWcqAf2gBIG0uQraxH24cO4nHipQG64XD
         cAXU3NckAY53dBZMIsIaoir8n80HRhaZwIkh2HF2tz13OaRmgWaeR5Avnz48Dwqw9tJT
         UgAicp2f+McZEbkJC7uwBgC3JSpQ8bDVMzYnq3QMJkzRrC+HMgzM1i9HzjCgcYAWQtko
         6ZQfmjsATvsSYj7mnBulyv1xpb1lRV0cFkb5OsOdJoAt3sTfrQtBu90T/hMp6n/805sX
         5tjm8h17hw56JYEN0wcdu51kr8ctIdqah6FfKOKjaWjZA+Ft7CgZUmxCe12A2TJaoBvT
         R/qQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0ojH0GJhWoloHCHIZjqGCoCPOIH90hgF8xrlBnlL/kuqTIxINUU5cB+VJLC6ZQ3umI9M=@vger.kernel.org
X-Gm-Message-State: AFuF++mvjvu8L+UXRBO0IFu6bbgfTOS8OPmOZrU44T7NvoO/jbJ1pIAl
	N4dj9mPwwsu3n2plQ8gJNohdu44jI7bo/MxDIU9BQfKr55h73uF+1k+nCfR/p6uOG6CbPXo9R4U
	NeH5We46RmKqEqXAF5JG2T+Lz2PUSBLc=
X-Gm-Gg: AYBFou15ifp46qyHGH5V7f704vGL14fiBx39kwsXC9sw+b+nLR1ItI0bZ/g66WSWnm5
	1QZabtNcuXnPFV/aS4dxto8eORFidPBGxfjYu8jn52AGzra/H67LxyMgzmhP5GdtKpdKJ7INPeN
	Mnpf6Ua8bIWvwlz4uoTKIgGJBdMm4DmDzLeXaCZsQ9Jz8slT518+EuTP+g9LiAEZv+DYINMeR2f
	Fxze6EMI/DgteTGltyUaog7wqOhm1+9H6aODHXbnT9oGerT8mJYjLplilvB1Cx8KKDAmuiJvcBM
	sP+WSWCoXM5FrKyOS0+B2VaD/7F4XM+cdUJqr6QCVfV4vALo+AacVBfE
X-Received: by 2002:a05:6808:23c6:b0:4b2:8d89:69d4 with SMTP id
 5614622812f47-4ca4a2ee23fmr8263978b6e.13.1789661259006; Thu, 17 Sep 2026
 09:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910112027.34581-1-flyingpeng@tencent.com> <aqLBQ8AXe189POtS@google.com>
In-Reply-To: <aqLBQ8AXe189POtS@google.com>
From: Hao Peng <flyingpenghao@gmail.com>
Date: Fri, 18 Sep 2026 00:07:27 +0800
X-Gm-Features: AcwNN1UzhmOdKsaqnTxBHYemDUBJjqamB_h1j7T5aY91GOjS7twLBy2LpX6qhSU
Message-ID: <CAPm50a+13XCTFx39T1gtFKJJJYWpSzCHvA1sVmw9C9bGScpH-A@mail.gmail.com>
Subject: Re: [PATCH] KVM: Simplify backwards dirty ring batch check
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 10:40=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Sep 10, 2026, Peng Hao wrote:
> > The backwards coalescing path shifts mask left and back right to check
> > whether moving the batch base would discard set bits.  The shift fits i=
f
> > the distance is no greater than the number of leading zeroes in mask.
> >
> > Use that directly.  Convert delta to u64 before negating it so that a
> > positive delta, including one that wrapped to S64_MIN, is rejected by t=
he
> > unsigned comparison without invoking signed overflow.  Use __builtin_cl=
zl()
> > to match the unsigned long type of mask on both 32-bit and 64-bit build=
s.
> >
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>
> LOL, Paolo definitely has a different sense of "simple" when it comes to =
bitwise
> math.
>
> > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > ---
> >  virt/kvm/dirty_ring.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> > index 572b854edf74..8f39047ae7ab 100644
> > --- a/virt/kvm/dirty_ring.c
> > +++ b/virt/kvm/dirty_ring.c
> > @@ -170,9 +170,8 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kv=
m_dirty_ring *ring,
> >                                       continue;
> >                               }
> >
> > -                             /* Backwards visit, careful about overflo=
ws! */
> > -                             if (delta > -BITS_PER_LONG && delta < 0 &=
&
> > -                             (mask << -delta >> -delta) =3D=3D mask) {
> > +                             /* Backwards visit, but do not discard se=
t bits. */
>
> IMO, this really needs a more verbose comment.
>
> > +                             if (-(u64)delta <=3D __builtin_clzl(mask)=
) {
>
> Rather than the s64 =3D> u64 =3D> negated logic, which just makes my head=
 hurt even
> with the verbose changelog, what if we gate the entire outer if-statement=
 on the
> absolute delta, i.e. the shift, being within range?
>
> And probably in a separate patch, but I think we should also replace BITS=
_PER_LONG
> with BITS_PER_TYPE(mask) to communicate that the logic is all about not o=
verflowing
> "mask".
>
> >                                       cur_offset =3D next_offset;
> >                                       mask =3D (mask << -delta) | 1;
>
> Maybe also opportunistically use BIT_ULL() instead of open coding the bit=
 shifts?

Agreed.  I will add a more detailed comment and clean up the mask-width
and bit operations in the next patch.

Since mask is an unsigned long, I plan to use BITS_PER_TYPE(mask) and
BIT() rather than BIT_ULL().

For calculating the shift, abs(delta) is problematic if delta is
S64_MIN, and abs(next_offset - cur_offset) still performs the
 subtraction as u64 first.  I will instead compare the offsets directly
and calculate the unsigned distance by subtracting the smaller offset
from the larger one.

  Thanks,
  Peng
> The literal '1' is especially annoying, as it unnecessarily obfuscates th=
at the
> code is setting bit 0, i.e. that '1' isn't some magic number.
>
> Untested, but I think this would work?
>
>                         s64 delta =3D next_offset - cur_offset;
>
>                         /*
>                          * While the size of each ring is fixed, it's pos=
sible
>                          * for the ring to be constantly re-dirtied/harve=
sted
>                          * while the reset is in-progress (the hard limit=
 exists
>                          * only to guard against the count becoming negat=
ive).
>                          */
>                         cond_resched();
>
>                         /*
>                          * Try to coalesce the reset operations when the =
guest
>                          * is scanning pages in the same slot.
>                          */
>                         if (next_slot =3D=3D cur_slot &&
>                             abs(delta) < BITS_PER_TYPE(mask)) {
>                                 if (delta >=3D 0) {
>                                         mask |=3D BIT_ULL(delta);
>                                         continue;
>                                 }
>
>                                 /*
>                                  * The next offset is backwards relative =
to the
>                                  * current base of the mask of bits.  Shi=
ft the
>                                  * mask "backwards" as well so that the n=
ext
>                                  * offset becomes bit 0, unless doing so =
would
>                                  * drop bits from the mask.  If the numbe=
r of
>                                  * leading zeros is greater than or equal=
 to
>                                  * the shift, then no set bits will be dr=
opped.
>                                  */
>                                 if (-delta <=3D __builtin_clzl(mask)) {
>                                         cur_offset =3D next_offset;
>                                         mask =3D (mask << -delta) | BIT_U=
LL(0);
>                                         continue;
>                                 }
>                         }
>
>                         /*
>                          * Reset the slot for all the harvested entries t=
hat
>                          * have been gathered, but not yet fully processe=
d.
>                          */
>                         kvm_reset_dirty_gfn(kvm, cur_slot, cur_offset, ma=
sk);
>
> Or maybe capture the shift as a u64 early on?
>
>                         s64 delta =3D next_offset - cur_offset;
>                         u64 shift =3D abs(delta);
>
>                         /*
>                          * While the size of each ring is fixed, it's pos=
sible
>                          * for the ring to be constantly re-dirtied/harve=
sted
>                          * while the reset is in-progress (the hard limit=
 exists
>                          * only to guard against the count becoming negat=
ive).
>                          */
>                         cond_resched();
>
>                         /*
>                          * Try to coalesce the reset operations when the =
guest
>                          * is scanning pages in the same slot.
>                          */
>                         if (next_slot =3D=3D cur_slot && shift < BITS_PER=
_TYPE(mask)) {
>                                 if (delta >=3D 0) {
>                                         mask |=3D BIT_ULL(shift);
>                                         continue;
>                                 }
>
>                                 /*
>                                  * The next offset is backwards relative =
to the
>                                  * current base of the mask of bits.  Shi=
ft the
>                                  * mask "backwards" as well so that the n=
ext
>                                  * offset becomes bit 0, unless doing so =
would
>                                  * drop bits from the mask.  If the numbe=
r of
>                                  * leading zeros is greater than or equal=
 to
>                                  * the shift, then no set bits will be dr=
opped.
>                                  */
>                                 if (shift <=3D __builtin_clzl(mask)) {
>                                         cur_offset =3D next_offset;
>                                         mask =3D (mask << shift) | BIT_UL=
L(0);
>                                         continue;
>                                 }
>                         }
>
>                         /*
>                          * Reset the slot for all the harvested entries t=
hat
>                          * have been gathered, but not yet fully processe=
d.
>                          */
>                         kvm_reset_dirty_gfn(kvm, cur_slot, cur_offset, ma=
sk);
>
> Actually, I think I like option 3 the most: capture only the unsigned shi=
ft, and
> then explicitly check "next_offset >=3D cur_offset" instead of checking t=
he delta?
>
>                         u64 shift =3D abs(next_offset - cur_offset);
>
>                         /*
>                          * While the size of each ring is fixed, it's pos=
sible
>                          * for the ring to be constantly re-dirtied/harve=
sted
>                          * while the reset is in-progress (the hard limit=
 exists
>                          * only to guard against the count becoming negat=
ive).
>                          */
>                         cond_resched();
>
>                         /*
>                          * Try to coalesce the reset operations when the =
guest
>                          * is scanning pages in the same slot.
>                          */
>                         if (next_slot =3D=3D cur_slot && shift < BITS_PER=
_TYPE(mask)) {
>                                 if (next_offset >=3D cur_offset) {
>                                         mask |=3D BIT_ULL(shift);
>                                         continue;
>                                 }
>
>                                 /*
>                                  * The next offset is backwards relative =
to the
>                                  * current base of the mask of bits.  Shi=
ft the
>                                  * mask "backwards" as well so that the n=
ext
>                                  * offset becomes bit 0, unless doing so =
would
>                                  * drop bits from the mask.  If the numbe=
r of
>                                  * leading zeros is greater than or equal=
 to
>                                  * the shift, then no set bits will be dr=
opped.
>                                  */
>                                 if (shift <=3D __builtin_clzl(mask)) {
>                                         cur_offset =3D next_offset;
>                                         mask =3D (mask << shift) | BIT_UL=
L(0);
>                                         continue;
>                                 }
>                         }
>
>                         /*
>                          * Reset the slot for all the harvested entries t=
hat
>                          * have been gathered, but not yet fully processe=
d.
>                          */
>                         kvm_reset_dirty_gfn(kvm, cur_slot, cur_offset, ma=
sk);
>
> >                                       continue;
> > --
> > 2.43.7
> >
