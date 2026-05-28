Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7E33BBD0
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009684; cv=none; b=nFUqcBb01OyqhapknWoZOfWqvZfHeqktVMtgoBMx1zhiD83KTDhQBO9KqaqPArgk3KmcQVM+KZPv4XbDUE/+7mCNACGCmMEtXKRWlgllFp2yO7uP+4DO7RJV3U1rMymPQwoBedYmkZsCMyQxAWeOESr99XiPd0VgiGi1cdAN29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009684; c=relaxed/simple;
	bh=dk5J752CrboY0cT9L9q/A31Kn6PJ9TtEDu1SsAd9iqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YgcWR9NbJPHuRr3/VMC1KvVk/JafhUTU5S1BNxKWSOf8OWsTmOFTgLse/nFQ+TutmAmrwNKUb3UNF72EaotyZ0fXoCQW9c4seYNpvdZtmYFe8TENmUtT4nMuIcDxAervL0YwapdjgE+kV5FZAOpZhAOsBpewzfBe28jGU3fclW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yg+O2jO6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yg+O2jO6"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf08c2a24bso13786665ad.2
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780009682; x=1780614482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKnLxmBLes80fBb6aidC9rNT/r9MEqoEBbXJR1P8ohc=;
        b=Yg+O2jO6R5B8J5tSGem1dGPb+qAxZq/PPOtRHZpGuHEsWEBEzlw98TnrcHaz+AQwof
         JHDQwLUXGFxLGBSnyNXtoKiDREqqu5PaTMaX46aaeJjJZhz5Sh+j+3SfKpQ4k+hwMMK3
         bxJzJGeoasD3lroobqdqlygBppQQz2aGklEXGgyM0JDU1GuJvv/l9adDrx6c0A/+mWKz
         73VoxltnpTPsjydzNp09U3cuDipoVFeGCf5PivX6lIdoVWdlFwozPhPcz/yg4dWBYdVc
         lL30uBvEqgrlpyFna0q5RkTJdm6aTEu6I2ya4jb22bmGHJy2YtQz9YJFgBChu78cJkBv
         AKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780009682; x=1780614482;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mKnLxmBLes80fBb6aidC9rNT/r9MEqoEBbXJR1P8ohc=;
        b=VRH72kkpiXrb8gTCJHbewmGounf/dSuAmkEcCIL43BWAZFr0cPh3Sa8NxbWVDct6PD
         dM9zLEUJ68fP1nF3Sq/H5Yp0wEEwy1gaLVlY33oENcdPB+t2eLt8GdX1t2qTZ29fBiaI
         bEejyw7sNPNl7suwiXwl1d05nlMjN7xV7cqBZsRyXwsGNTwSeuoxP26geomP5ZzOliqT
         dYKISZo2eWqQ+FwCtKZMzI+dySJI/+HDjB24l1g66fW0KZKvYC1o/DTaQPAYoJ1702WW
         7eANjfKJW6MGNDX5L+sElVvl5eyVYSUbBZbHFQSOPWlt8tdUEIvKz+rKFi/GSP70SsL3
         Xulg==
X-Forwarded-Encrypted: i=1; AFNElJ+VEZtqMgetJSf/eLui38pLu1TZpW8Jt/3ObNA1PkGEYAHQPLNkyx+eywhP5YJ2N2g/TKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKStTctHEdrON7tAcUKmGG1nnEq9ot4dcV+TNdIYx8kCUAUU/
	89VnFkSx6EokAofpH3tB3ss1Xt2O8RD51wxHM/eelXd7JSkh4Z3CquvtvSuBOzrT9okwvt9mZe5
	TO9TWDw==
X-Received: from pgum16.prod.google.com ([2002:a65:6a10:0:b0:c82:7761:9936])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19d0:b0:2ba:7610:3f21
 with SMTP id d9443c01a7336-2bf20533576mr4731225ad.5.1780009681978; Thu, 28
 May 2026 16:08:01 -0700 (PDT)
Date: Thu, 28 May 2026 16:08:01 -0700
In-Reply-To: <CAAdrzjuJbLF19HeQ+_NC5boxmXVEczoMu4UX70i4v0zoP1ofDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com> <20260421231557.1254270-4-jrhilke@google.com>
 <ahZOebR5XXQNkyW0@google.com> <CAAdrzjuJbLF19HeQ+_NC5boxmXVEczoMu4UX70i4v0zoP1ofDQ@mail.gmail.com>
Message-ID: <ahjK0Si_ErZXFP8P@google.com>
Subject: Re: [PATCH v3 03/16] KVM: selftests: Add guest read/write macros
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026, Josh Hilke wrote:
> On Tue, May 26, 2026 at 6:52=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Apr 21, 2026, Josh Hilke wrote:
> > > diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing=
/selftests/kvm/steal_time.c
> > > index 7be8adfe5dd3..23380de79817 100644
> > > --- a/tools/testing/selftests/kvm/steal_time.c
> > > +++ b/tools/testing/selftests/kvm/steal_time.c
> > > @@ -72,8 +72,7 @@ static void steal_time_init(struct kvm_vcpu *vcpu, =
uint32_t i)
> > >       int ret;
> > >
> > >       /* ST_GPA_BASE is identity mapped */
> > > -     st_gva[i] =3D (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
> > > -     sync_global_to_guest(vcpu->vm, st_gva[i]);
> > > +     WRITE_AND_SYNC_TO_GUEST(vcpu->vm, st_gva[i], (void *)(ST_GPA_BA=
SE + i * STEAL_TIME_SIZE));
> >
> > Please wrap these.  80 chars is a soft limit (and so is 100 chars), but=
 the purpose
> > of the rules *and* their exceptions is to make the code easier to read.=
  This is
> > hard to parse, because there's so much going on in one line, whereas I =
find this
> > easier to tease apart:
> >
> >         WRITE_AND_SYNC_TO_GUEST(vcpu->vm, st_gva[i],
> >                                 (void *)(ST_GPA_BASE + i * STEAL_TIME_S=
IZE));
> >
> > >
> > >       ret =3D _vcpu_set_msr(vcpu, MSR_KVM_STEAL_TIME,
> > >                           (ulong)st_gva[i] | KVM_STEAL_RESERVED_MASK)=
;
>=20
> Will do.

FYI, upstream expectations are that review feedback will be addressed unles=
s there
is additional discussion that suggests otherwise.  I.e. there's no need to =
acknowledge
everything.  For me at least, ack responses do more harm than good because =
they're
pure noise 99.99999% of the time.
