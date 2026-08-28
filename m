Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC37727E074
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787944543; cv=pass; b=hhnLCG1Qqw+dsBM6uRk744X1UiLFHJBAP9q8ol+gJ+AhW3VQBcLBCW5+hJQooc1zbzlk53JPoeyHpaG6huIrRUUI08KcKGc0JXkfhdrWxqjGUSNyecFPnlkDRc75KCBtBGT0/4XStFL9OW73ATQOYNr1GXFlwCTMJbbf45BNDnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787944543; c=relaxed/simple;
	bh=N1Nbw3ovgXhbS9LBKa33iZ8SPB+0x1h20hpoEb1DbDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/uXQZHnbSa2qxPAemv4WEdblJas/DbOuHvbQ9JjbrYZx/46hPQfBICPxsa3aEUGktH4QxiZmnJAVGJ6vbevF/4NaHXfz6Kfcs3jn+DdvjxQyINUd2KVkntOhsA87zfuPWhlIISbJtVaJRoMZVDUjWszsO0F+rMTC2idQRuXB2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pG0TuFCI; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pG0TuFCI"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1cbb64a1fso1267000a12.1
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 12:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787944541; cv=none;
        d=google.com; s=arc-20260327;
        b=Te32YIINADDJ0rJBlUwnFqnWM0tg+3IaL4jv8eOATYwN+6ZKPWOK/x3FSat6/ZG25q
         GJZAJvwv6FNnEM5D5t0T9kJ6gScmZcqlCNV/FETNi7JCekwSU+QiBS2ULi8ecVDmwerI
         G6e9gEtOrLZeuXjpZWXgKJ5OSqZ6RJbD1CWv2zdXOeH02Y56LRxlpPHWoKMKfZq2gw0C
         CVVYR32WIrRcpDPhNDkBTMYI8St8DZyHbNvqmwu+8M788dyNm3H7RD630+qO0086XZWv
         4rrvyQHj/UHVHMfPflLzRqQXUifORemfalMv6aasnaFoQ00A6xC4hG4Elri5qwIKozXe
         zmVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kiyvKBshQ+wfh6yua+SMCW+QrMRbGzyCCyz1Zxa7SSM=;
        fh=+7AB/YdPk/Lztb04RUDDql14qfzMaDQyENnNl2IwjpQ=;
        b=Z6dohJpzCJtHpYYfJJIEni4EtY8OHK8GazIvTWxOsgdXuNP7s/axzpQhnvvUni/Smp
         A28rK5Heta60eW2lZzI9MgtX0u4TyJp3lglnKndnQ3sWNKhfMKtpM27UN5wT2XWnPN/L
         V8wZf0qP3tqQxAyXl4bDE1pHOcQqMmWFV9/wjX7H3nq6WHf981Xfo4E4oql7Qs5JRa/4
         id5WBF0QxWFkQ2bYbbYn9Vap2ZZzgLhyHuL2UI557Bam9d5QDlbE8OeBle3SCC/wFuoE
         nfHkwvrR9GfIRLwTi8cdnQoPfmyZsKrJBvtT7y6swd0//iLrfbPTtSRdizjx5ZTjS2az
         NF+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787944541; x=1788549341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kiyvKBshQ+wfh6yua+SMCW+QrMRbGzyCCyz1Zxa7SSM=;
        b=pG0TuFCIAnr8Cy5Po8NhtUftc/BBIS0W8f9vvZEEJnnqVnR1XT5HKTEpPyiFznFaQH
         c4EkS/C0CmfL016pKmwCOeIJ9B/NB9iH1rPWKvVfBBwgaMN0auEFj+UmkCw23r8cSwQv
         GUEkLBbVkVAiSx5FgNwNGlt5aLTLpp8yQqZEuQhx7zuzyg7wA+4cbb87fQppS8G/P0BN
         fhbtE7uQzs+Nd7lO/1pEfh04ugAU7IFHMOK6TiwUiUz58aODUMzRQSe99gje3EXWEg41
         No2bLN5UrA/0Imix7gj8z2jz2OKonkGA6PGDlpAH+ZsWKSkolqZ2Q0SifKWxUklqkxrR
         8lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787944541; x=1788549341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kiyvKBshQ+wfh6yua+SMCW+QrMRbGzyCCyz1Zxa7SSM=;
        b=EVhYgxAL+iWgN194Cq9jLck8VVcX6to4/BtxoW6tXDaLjlPeOiMnTDd0MePxF1hqrK
         QXSNX5zqtF2GZWF1NmcQndUo8HRBMOMsCp5gZSACa9p3/toKQegoDaKd7rg057lVxyIE
         oXzCCQSeS6pDwT8TEpyPZi8C6QPmXrhsLRtizPTqUYxhtqG7aROJvUTTGM0pLGIKV2cy
         PgSjAC6Wn80xB/m3PUB512Q5G3ZEVw+uQ/EeORUB2yv0dIGSz8abvcdCZbboQV4XfslJ
         Q+kWJbeApdjDa9KbGcyva9QtP0meZ+M6X8qAiN1utbzXkQAq9JYz2Z4UYu5xTFKkRvA3
         /1/g==
X-Gm-Message-State: AFuF++nmfAZD3hBX6tvVUf18jjdGy+z4Klca4v4n4n1JDtwxKWn0COSM
	qSTcXwrlZ0lBTvhEvWqpVAd3kQ8dwJj406eEgb25QVIM5VYjDuivTgTPAuNOckkgQGZWRbrPG3x
	AwJdM5+vJswSJQNlj79ihxOw/T4xa9JM24k+JhO9UWiUlCujdVEa0/SPtOho=
X-Gm-Gg: AR+sD10Wy522fiRzt9vdICcClnT8xFKjM/1JHy6Hz/nCDgr/P1EbttLJQQ0a9QGoZGh
	/bxviBFHY2X/X2MQD9VaWmT1pcQb1ZQUuFJI7GFcB82aYyeQ/SUHJzU0rPnW7957APtjTyYP2JW
	auj21d/IkkFQgtXDD3Hbyqhfm8abfl9u9VpnOXu1GCCuGqqiJgzjNmv0ACyUFryk6uupAUuC3dA
	vsiU7YEFw5Bl9Erb6ta+5yOYKOkML5FLZ8fa/9Arj2fasrvzrrF5yfY2NW0ile+aPZ2lS0YiBzq
	/rd/iSMz8yj4ETy40f8Kta10fZuU9tK7X9MWh4iF7cSAhbyweDX+IJvNAZlbfvy+NRbPU7TIb5o
	=
X-Received: by 2002:a05:6a21:350f:b0:3d3:ae40:51e5 with SMTP id
 adf61e73a8af0-3d3ae405659mr3293243637.25.1787944539838; Fri, 28 Aug 2026
 12:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818223422.367803-1-jingzhangos@google.com> <87v795ndhz.wl-maz@kernel.org>
In-Reply-To: <87v795ndhz.wl-maz@kernel.org>
From: Jing Zhang <jingzhangos@google.com>
Date: Fri, 28 Aug 2026 12:15:26 -0700
X-Gm-Features: AcwNN1WrfuoxnPgMF7CmkqwFRNbRW29he8BaRItvN8ezR7fcwwGLFqlhRr6GqCg
Message-ID: <CAAdAUtiEKMW-Qx+afpFtQrVWgW3+Av0A0JVh+vSYqUg_q+ER1w@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: vgic-its: Fix O(C*I) loop in vgic_its_free_collection_list
To: Marc Zyngier <maz@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Steffen Eiden <seiden@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Faud,

Could you please include this patch in your series? I'll be out of
office until the end of September.

Thanks,
Jing

On Thu, Aug 20, 2026 at 6:08=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> [+Fuad, Steffen]
>
> Jing,
>
> Please make sure you add all the relevant reviewers in the Cc: list,
> specially as Fuad is doing a lot of work in that particular area.
>
> On Tue, 18 Aug 2026 23:34:22 +0100,
> Jing Zhang <jingzhangos@google.com> wrote:
> >
> > When destroying the vgic-its collection list,
> > vgic_its_free_collection_list() iterates over every collection and for
> > each, calls vgic_its_free_collection(). This function walks every
> > Interrupt Translation Entry (ITE) across all devices via
> > for_each_lpi_its() to nullify the collection pointer.
> >
> > A guest can allocate up to 65536 collections and hundreds of thousands
> > of ITEs. By clearing GITS_CTLR.Enable and writing Valid=3D0 to
> > GITS_BASER1, the guest can trigger this teardown path from a single MMI=
O
> > exit. The resulting O(Collections * ITEs) nested loop executes billions
> > of iterations without a single cond_resched(). This pins a physical CPU
> > and stalls RCU grace periods for seconds or minutes on PREEMPT_NONE
> > kernels.
> >
> > Fix this by replacing the O(Collections * ITEs) teardown with an
> > O(Collections + ITEs) pass. Since the entire collection list is being
> > freed, we can safely bulk-clear the collection pointers from all ITEs i=
n
> > a single pass, and then free all the collections in a second pass.
> >
> > Signed-off-by: Jing Zhang <jingzhangos@google.com>
> > ---
> >  arch/arm64/kvm/vgic/vgic-its.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-=
its.c
> > index 36ab3e4929154..a8e819fe97898 100644
> > --- a/arch/arm64/kvm/vgic/vgic-its.c
> > +++ b/arch/arm64/kvm/vgic/vgic-its.c
> > @@ -1133,9 +1133,21 @@ static void vgic_its_free_device_list(struct kvm=
 *kvm, struct vgic_its *its)
> >  static void vgic_its_free_collection_list(struct kvm *kvm, struct vgic=
_its *its)
> >  {
> >       struct its_collection *cur, *temp;
> > +     struct its_device *device;
> > +     struct its_ite *ite;
> >
> > -     list_for_each_entry_safe(cur, temp, &its->collection_list, coll_l=
ist)
> > -             vgic_its_free_collection(its, cur->collection_id);
> > +     /*
> > +      * Bulk-clear the collection pointers for all ITEs.
> > +      * This transforms the teardown complexity from O(Collections * I=
TEs)
> > +      * to O(Collections + ITEs), avoiding guest-triggered host RCU st=
alls.
> > +      */
>
> I don't think this comment needs to describe this. You already have
> described it *extremely thoroughly* in the commit message, and that's
> probably enough. I'd rather see a justification of why this is *safe*.
>
> > +     for_each_lpi_its(device, ite, its)
> > +             ite->collection =3D NULL;
> > +
> > +     list_for_each_entry_safe(cur, temp, &its->collection_list, coll_l=
ist) {
> > +             list_del(&cur->coll_list);
> > +             kfree(cur);
> > +     }
>
> The other thing that is missing is the invalidation of the translation
> cache. Please see the discussion at [1], and whether this needs to be
> taken care of here or in Fuad's series.
>
> Thanks,
>
>         M.
>
> [1] https://lore.kernel.org/r/20260819102809.310708-2-fuad.tabba@linux.de=
v
>
> --
> Jazz isn't dead. It just smells funny.
