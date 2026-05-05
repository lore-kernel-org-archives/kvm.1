Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E56F38B12B
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981975; cv=pass; b=qFfawNhrtMxPGbM9N5Mu5Av57IThPzKvKoxyIYipcqU8OWE07ZocoU5h3CJASsKoS61UQRjXqKLh+3AVRxKAMyR3PUkrmTkgkBbV0GmGtHfSuXpqjvs9hENPtH0JWjIfDfODe/9GBLcO0jLsZedkZOvUP08rDYpK4kpyB/Ma0ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981975; c=relaxed/simple;
	bh=5xFm/6VZfh7QumngVDzgPt66le+s6CIRgnaE1fBHlLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TubVLh4jENE0+n/ks++Q6bq+va6comKBeluXnpVez7RG7B7rfB+kSI1h2snSuKtzh5vPDud05HmIizAfaYfCEGsC9EnqS2ArwFxx6fmzvmwVrWjeNwRhxghxOErLZBTHPjAyNEljJBegEZtEOiAFSohG+WR01NeF+l7604RohRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO7vQqBR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXX2fVX/; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO7vQqBR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXX2fVX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777981973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVAK8QclidSN7r87l0VnRFJs0yHrHmyHsHmBXtcxHhg=;
	b=YO7vQqBRMUehRlgQxMfOgCbUpg8VRMI4nRqehuydKvOAgl+i4aqc84p7oj5ccd6l04VNmb
	S+pZSMVb9a5729uNqIpT9ve5bFUUkfxO5iWq4m+ZLIl4ClzIKslhGemy9DHefO1R8s5OKA
	eos3SOrpVMJUlOTi8BSowy8Pvr4qqGY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-vv05o8anPViHnH6kk1_R9A-1; Tue, 05 May 2026 07:52:24 -0400
X-MC-Unique: vv05o8anPViHnH6kk1_R9A-1
X-Mimecast-MFC-AGG-ID: vv05o8anPViHnH6kk1_R9A_1777981944
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c0fcc6deso29381875e9.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 04:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777981943; cv=none;
        d=google.com; s=arc-20240605;
        b=GWMQ3GxGuFZEIBeK12FZXwRe7sfld6G7hRQ3K6ixxh1/h6fszqafnX7kgH6pBGFvYY
         zo4vJW4wMbdjA6GB0+LVN3DmDEfUtACb6vsgfRgYKTQAiyUnM1D0uVcBQHoJurO5vh3k
         dpXDk6tQI+v5ef0QM7zdaNrZo0ARYj9+b5yVZGoQ0ciKC+89HVdnM3MOiqK+S14bHnVJ
         +VMTZox+xLLjMcXceS2jlqGgTmDaSUVO0z6cblzaKUQAqOYp3pOzmcJql7JKmrSrnYmB
         nIoNbHCn2Ho37X88nbU2k8aLfrlyLF3w4Z9OPVJIW6kOwvXAZLPRo+7wNHA27lUePCMP
         1n4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hVAK8QclidSN7r87l0VnRFJs0yHrHmyHsHmBXtcxHhg=;
        fh=Y407Ve4EUuHJHdnIUAU3cQLBB1F8S44BvsDkl30GjYg=;
        b=itSQaKHwBYmDsvqQNBvHNlEs2DbnWu4dHVgPauq0KRzSQFk0m2vNWp7/wB8DHRx4O+
         QqhV1dGNA3x4dPh9O5WSCrP5bACpV2XYJs7D3dXEkhO9QgDhKaKaVpEbxjkHB3+1ooKS
         YAP3VDkbti+foaqF19fzUlrDatjqz5yIlXtgMze8bnc3quH1mvAiQVSgqBcFV4xkYjbM
         4qEwat25uajOK0OGEOzVaKfyglN5Qte2JR3F4AYxT7xUttOJ9lpQuiSOTWLBi2E+ndcr
         ZrQrP2JRN+QFTBZg5je1C8MMHpohB6ANx7eU0qt/LeZ0mq3v9Y85vaEnkXPYJ83uH7Vw
         FxXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777981943; x=1778586743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVAK8QclidSN7r87l0VnRFJs0yHrHmyHsHmBXtcxHhg=;
        b=HXX2fVX/6EM2cVnYp0TUz7tZAd4joj56wxip6mvk2PWCDXOGkvzPwshTEVx92lJkcQ
         m+VE55pV7chvl+osjXiAz+pycNPIZcfisgQ96xV97gau1Y6awviHP3O594TLMP0Z0P36
         7oaD/05jnbRgdFWoRZ6TZtXPnDLht/bta8qEkQQw3qBjeZBNsxNd48qgcLKZlTM9/cx+
         /ndLq0+YS4nxjbomW6g5FTOSx3iDwMBpJQEp6tXeFb/iTC7/ErdpWZLi/G16NQ/VLJsM
         9ADR5ZEX+wox4l1USvecA19FO3glcCBi8HShXNXWimVnonsN6bj3DbNKyZ1jytNNyIuB
         s3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777981943; x=1778586743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hVAK8QclidSN7r87l0VnRFJs0yHrHmyHsHmBXtcxHhg=;
        b=G2SRnF0RrDZB18xBTtxWR6CBVA9M+FkArQm182ipUD+FFbhJ6azvDjvs8/jfD5W+mc
         7pxD8PzDcjW+1w6/EW8TuoHGp+NcmsI3WMNXu5Ulp6VQmwFakQAo774JAMLXxfgBPAQT
         d9Nmki3Fhdn+sPAxjDf7julMqmWGQZebuYuPCa4bn/OJtu6vgMtzocEebvPg3xyZtgRz
         dGNHO4kXc8+9cLOFGtyNLvxjaqQ72hVKu75fBDkaDS0nr77+O4n2kBiRgsIIbnGkOIXV
         D7u8H6Kjnf8xezKFvQDix3PES31VxzUI+Vg8olQIwvs8C4nXk5uTAcTlMUSC5EcOCwHA
         OswQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jqRlOBdM95ZzTPgCZOlqkO2800ELgcQpZqrSQTCihX5PWKycBSOelKWu/HZnIaYdNQlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykAEOUJlnzXB/wadkCze9el+gJWji4JYslVGXJB7kFWBvagffs
	WFX+kf2++2yCfTwwmRKFQps9v0TvOnmPFIUqGCJwBimQfaxAOOSV636mR6Mj1hI4W+3IEMrv1WJ
	XYZddBsprXCvd28Ne3fSEolUeOK8vk2sTzogrxj10u/ZGqDbnAy1WVwFeA9NOZe99tHGpKiLziD
	D1vSvVAhm8Sh241zVjBuypbH0v2Jn2
X-Gm-Gg: AeBDieu0vlf23TCEEBfiy5SKpfy9enfIm1iwUDWEclmIxAcCaZJNUTpQpD9mIbvwQa8
	wMDT1cvunL84f7tpJX+K3VagFMkMD8JcLhAXcWF6vsYodLNMDUwRNsu7T9IoyInDDN66RUGigE1
	qZck0qTmzclCuwqvNLjVYK0tg1qvbTq3SieqL+q40otiGzxkRmyHBW6CjX0AvyxlUCHTcHTa9D3
	qxsYZy69A+Fn9pVmjEn1RXBgF6ThR/5e3gxaq+spigWtg7A6/thLCzt7s/JAEyBpE89806/ioSk
	wAfybNd/PxfAi0ECX18=
X-Received: by 2002:a05:600c:8b11:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-48d186dc81bmr41444785e9.2.1777981943354;
        Tue, 05 May 2026 04:52:23 -0700 (PDT)
X-Received: by 2002:a05:600c:8b11:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-48d186dc81bmr41444355e9.2.1777981942949; Tue, 05 May 2026
 04:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503210917.121840-1-pbonzini@redhat.com> <afjW63q5KqkwHMK4@google.com>
 <afjnKSeSX2IegtW1@google.com>
In-Reply-To: <afjnKSeSX2IegtW1@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 5 May 2026 13:52:10 +0200
X-Gm-Features: AVHnY4Lc9X954kZAtXcIBtlG4hTg9WT5t9Jwghv2xqel7xVBivKniexDIDZI46M
Message-ID: <CABgObfYR1NLbzsgoe=agkpjVJ7hs3E_ftrJ5zNnu_xF5moeKLQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: use again the flush argument of __link_shadow_page()
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 8:36=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Mon, May 04, 2026, Sean Christopherson wrote:
> > x86/mmu
> >
> > On Sun, May 03, 2026, Paolo Bonzini wrote:
> > > Except in the case of parentless nested-TDP pages, mmu_page_zap_pte()
> > > clears the SPTE but leaves the invalid_list empty.  In this case, usi=
ng
> > > kvm_flush_remote_tlbs() as kvm_mmu_remote_flush_or_zap() does is over=
kill.
> > > Avoid flushing the entirety of the remote TLBs unless the invalid_lis=
t
> > > was populated: instead, use a more efficient gfn-targeting flush (if
> > > available) and skip it altogether if the caller guarantees that a TLB
> > > flush is not necessary.
> > >
> > > Based-on: <20260503201029.106481-1-pbonzini@redhat.com>
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >  arch/x86/kvm/mmu/mmu.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index 892246204435..85bec8eeace8 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -2541,8 +2541,10 @@ static void __link_shadow_page(struct kvm *kvm=
,
> > >             parent_sp =3D sptep_to_sp(sptep);
> > >             WARN_ON_ONCE(parent_sp->role.level =3D=3D PG_LEVEL_4K);
> > >
> > > -           mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list);
> > > -           kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, true);
> > > +           if (mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list=
))
> > > +                   kvm_mmu_commit_zap_page(kvm, &invalid_list);
> > > +           else if (flush)
> > > +                   kvm_flush_remote_tlbs_sptep(kvm, sptep);
> >
> > Duh, this is obvious in hindsight.
> >
> > Reviewed-by: Sean Christopherson <seanjc@google.com>
>
> An amendment to that: I thought this was just switching back to the more =
targeted
> range-based flushed, I didn't realize you applied the version that hardco=
ded the
> @flush param to kvm_mmu_remote_flush_or_zap() with "true".

Yes, I was hoping to simplify stable backports a bit.  Here is my
version of your comment (yes, I did try adding batched zapping to
shadow_mmu_split_huge_page() and failed):

/*
 * Note: while normally KVM uses a "bool flush" return value to let
 * the caller batch flushes, __link_shadow_page() flushes immediately
 * immediately before populating the parent PTE with the new shadow page.
 * The typical callers, direct_map() and FNAME(fetch)(), are not going
 * to zap more than one large SPTE anyway.
 *
 * The only exception, where @flush can be false, is when a large SPTE
 * is replaced with a large SPTE with a fully populated page table,
 * which can happen from shadow_mmu_split_huge_page().  In this case,
 * no memory is unmapped across the change to the page tables and no
 * immediate flush is needed for correctness.
 *
 * Even in that case, calls to kvm_mmu_commit_zap_page() are not
 * batched.  Doing so would require adding an invalid_list argument
 * all the way down to __walk_slot_rmaps().
 */

What do you think?

Paolo

