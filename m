Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E6397AEF
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487282; cv=pass; b=UJN0QgznTm5aIWNS39waCrDlsir6ZSj2jXCYqxdaiDJ2aXOcsX2dGS0n/4j4im8K/rS/iVjbjlzkEQ7mR2x43S24YMFSlHnRGigiijrjj90QzUqqSThgJ1lGZDGVo3YItw+zw8K1HVlQz4wiBpkETebzG4X4obPajcCUWvh68gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487282; c=relaxed/simple;
	bh=lKbj8Fii4ZKlUX/jvOQQ5A0Tevxh3L1P/3qq5zYe1xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeHkZOfE2a5lDrfZyaGsSbC5vsilJL83F54JghuB/jsMCq3b8BfmCGHouoXa+jMhMqyV8Z9/tWLcWuyTWw6y1ecqaqX21m/CRbRKGnjTStByZETxceiTqZsJdpuICV1Qu53DQOyVN7SQMLbYcmczDbAd2BMzfqTdc10ne32ef0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6PSzyiR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QG49GXXt; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6PSzyiR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QG49GXXt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780487280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyOLuzmjCrrVWycF+vR1+0ZMAWknGnaLw9YihpoorQQ=;
	b=c6PSzyiRTYdVL4NcEIASblkMYY/kNuuWxNxan/fjWoeODy9rcxJ2xxzATy+I0uMaoyvu2L
	6vh587Mfpw9lrWuXnssvupxJoPwgmsBOQaZn9l9X18+QuvP6nxGC2h9ajDzRSRXFaSewmu
	NTBrLT/nLQR9Xlal7SosZrtDhFnHM2U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-98SM8f2cPtKI_XJaw7LDVQ-1; Wed, 03 Jun 2026 07:47:58 -0400
X-MC-Unique: 98SM8f2cPtKI_XJaw7LDVQ-1
X-Mimecast-MFC-AGG-ID: 98SM8f2cPtKI_XJaw7LDVQ_1780487277
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b79e6b94so5066635e9.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 04:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780487277; cv=none;
        d=google.com; s=arc-20240605;
        b=LPKIWXQMGd8k64L7xn/6nWHvZkpIcKqlRFrof9EXUaKvEqz0SmpqqspEo3XoLL5yN4
         cTycIeuret/XjemEQnRkdK4UFpuwdPFJjGxRCq2rx9OiER4FVn+R4SmYb44ifctGg95X
         TCczrVdTN6soFh/sy1L2pMJ4129is83wOywSnOgTxJ3A3rowEbX1bOFMJo4AL9Y4AeMT
         n2MJuQ9f1Mowwnrf7rra7qwa0j7mf4IZUO17KI1bNw8rBjNAVGwfjXyViB15VrToKF+T
         CYoiE8D6LvAhk2bS9xkISEetRfLfLrH1tHtmMeFi+xW+Pe5/8oidL7r+R/fuvhmFElsb
         WH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cyOLuzmjCrrVWycF+vR1+0ZMAWknGnaLw9YihpoorQQ=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=AYwYZgvdJtMHJAOzKhzKvfatUtKvx837BGpbTmc8RX8DpzQbZiDfAD6g2wXJwxPadL
         iu+qLeLpNUiTrYNnJZLh+BCLksorTMeUlKIM/HiTs2fk1R/uPOqsWguQatCIbh1qWyjA
         r1dn/mJWho8N3uN7PFR/tlqK+77eSBwQrkcLoy0v14NmSMZQp5pO7m4d3vYnFJ0cEfbT
         cf6r95KlyoVcOgoJNP85rpmMbl8Pc1jC6ruuKoezbYOOJBYqPpv21FWARkE+bkcx/okH
         eech9dCPVU3YxO7A15oxQCMSrVd3FoYOPp0k03e2TSfBnGRLT02i1sEDsE13om/SUAkJ
         U0Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780487277; x=1781092077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyOLuzmjCrrVWycF+vR1+0ZMAWknGnaLw9YihpoorQQ=;
        b=QG49GXXtVncFvJiaAl0FoAypNwEpKLDnXwyHOFuN9o9gBbjbUnWxhjYxoLlueV3A1h
         6zC/Qoqoxw2ebZLfl3Ws+Q9w83kaFHq3JCv300z2y4MNxNfPWodjAhuceQkHCPlWd43H
         x7rTmwQ8H0NcMzEF/kPH1pcDPaoPruqSV89ck6YMmqtXGW5/P7zxSNlalKt4d+RlydW7
         VSTYcVdf+LLZlYviQRmfvbakRw8tjQR/j0UWl26gIMkcRls2gEkXQuFfaU7G0Tn68Kkf
         kSQvo8nVVbLmMopZX2CmpL88R9wOrxDT3RXH68Pt6vVwITwhCx6vAJEbsNgKwX+o++et
         L3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780487277; x=1781092077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyOLuzmjCrrVWycF+vR1+0ZMAWknGnaLw9YihpoorQQ=;
        b=YUgSNTTPLugpMhHDHKCxuMsArGABcruf6aysdyh3eeh+2ljL4ftCGxNZOS6/s2nBqG
         9hGvcvH7rOwTyhcDkLBEZacPvzGkowPt5Mp1AL9/lx7D450lZE88hsTcP/ayiwuwpWvp
         8NcENZsjByioypTAwDo/wtxv9KhaiPDKmwcW5IZ2DRSXE6AkqhM1eoDKcJfeKADaIxSL
         rFkcCGdg+PG7rHhiK0GvQBgkuAIMocBgflHFbto5D1HkwoAyY4d56D4w8HoH4jrzwhSC
         9H8UMQmzhlPULv2n3Oih0sGNp1LWgVYMVbl+s4ey6mBVMk+mAMfdDNHnmBN0VMpKDS8u
         FCOA==
X-Gm-Message-State: AOJu0YyZb6ssDAnN3T1J4v0n4N7RQ/Zkxi7xfFRna8BvieAk7AG3t3qU
	HZrXzVb5/Y5YMrvWOqPIrrwgGQ75tyv8qRvEoBKGSJmmmPvq6cJdQ05HI+O7z30wAfo9rI9Lq7E
	kmqYawM8JYu3ooVJ9QsTgBjEThZXhHq+FvHhb/ZDhd+5jws3bf4FjLThquoCRcO3ZqIsBibg6th
	J2Kb8fTp3hTh6sgZxLbFS0u7o5PAYEbUCdYu7xXEc=
X-Gm-Gg: Acq92OEXwRimePMRLujYjPPnFb0yofXjDMaw8amR02/F556aynXsG+AVTuQ5GItckEH
	aYRWgnIl9r99dVQyUt64YIT620NIuG1vAJ3I76gccOCg7dXwBwD13o/ERFnAUR88/a0LDzH7tAy
	/9jUsFIHag3bvF424h+xZQNdGwktQf/GQDoeyTTbD8eIjbrzxEpA7WL/6JzSFt0TS40twrD5pAM
	FAEDwpMZ7OcEEYsguHBlkzHaWlSA2GdLWPvW2x0u7dV/Ng6Ce1pTzotVCZXKOspoeKvgQnCIWA/
	A88JvJStFaJYtxnW
X-Received: by 2002:a05:600c:5288:b0:490:5191:6e26 with SMTP id 5b1f17b1804b1-490b5ecbd41mr49759785e9.18.1780487277385;
        Wed, 03 Jun 2026 04:47:57 -0700 (PDT)
X-Received: by 2002:a05:600c:5288:b0:490:5191:6e26 with SMTP id
 5b1f17b1804b1-490b5ecbd41mr49759325e9.18.1780487276971; Wed, 03 Jun 2026
 04:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603105814.10236-19-pbonzini@redhat.com> <20260603112429.6E35F1F00898@smtp.kernel.org>
In-Reply-To: <20260603112429.6E35F1F00898@smtp.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 3 Jun 2026 13:47:45 +0200
X-Gm-Features: AVHnY4Idh32ugck1G4tYpwxpaM-xZAMObaLqn8RdAOKK9GLvIcRCH1mKGlKqAQs
Message-ID: <CABgObfZHeoJ2v7U8guw0jG+Cs=28iBAOJdT3OS_Uv0pOMvO8wA@mail.gmail.com>
Subject: Re: [PATCH 18/24] KVM: x86/mmu: make gva_walk a value
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 1:24=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >       /* It's actually a GPA for vcpu->arch.guest_mmu.  */
> > -     if (w !=3D &vcpu->arch.guest_mmu.w) {
> > +     if (w =3D=3D &vcpu->arch.gva_walk) {
> >               /* INVLPG on a non-canonical address is a NOP according t=
o the SDM.  */
> >               if (is_noncanonical_invlpg_address(addr, vcpu))
> >                       return;
> >
> >               kvm_x86_call(flush_tlb_gva)(vcpu, addr);
> > -             if (w =3D=3D &vcpu->arch.ngva_walk)
> > +
> > +             if (tdp_enabled)
> >                       return;
> > +
> > +             mmu =3D &vcpu->arch.root_mmu;
> > +     } else {
> > +             mmu =3D &vcpu->arch.guest_mmu;
> >       }
>
> [Severity: High]
> If kvm_mmu_invalidate_addr() is called with w pointing to
> &vcpu->arch.root_mmu.w, this pointer check will fail and fall through to =
the
> else block, assigning mmu =3D &vcpu->arch.guest_mmu.
>
> Since guest_mmu is inactive when not nested, mmu->sync_spte would be NULL=
,
> causing an early return. Does this silently skip both the hardware TLB fl=
ush
> and the root_mmu shadow page invalidation, potentially creating an infini=
te
> page fault loop?
>
> I noticed this behavior can be triggered due to the changes in paging_tmp=
l.h
> and x86.c, which I've commented on below. I also see this is fixed later =
in
> the series by commit 9a1a629159ef9003 ("KVM: x86/mmu: pull struct
> kvm_pagewalk out of struct kvm_mmu"), but it seems this intermediate comm=
it
> breaks bisection.

Hmm, this seems correct. It's relatively easily solved by swapping
this commit and the next.

Paolo

