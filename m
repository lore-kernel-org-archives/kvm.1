Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7E35CBD7
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325329; cv=none; b=WVAzHMJB5vcx6+Ry2QG3tPFpI77Ypmg8CPQNaQyr3UWgK+gJI2bBRcoRh9bgHa2p+l36gPzIoZu7OHWu/oIxIE2WMDI/LSf7wRCmfkMf4udNrBlCS9KwECT5sGk2bJ/aIToSF30Uj7Lull07C4Pz7AvbHAlr2Ey9xHIc9bqEp0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325329; c=relaxed/simple;
	bh=7uzHRvfR/ufhgXiF/rfcNKOw7xmLA0r/v6L6uESDo8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=otKq9ZT+bSmyt+7b15YJRoJn66PgnoynU35uquV0YSR4Frk94cr4sxtjsOhit0NDR6fQCthTvdWNDD7Ww0mmzaPd2MqAB0nMScwDCDiw051Z8VBG1b59SM+qj1YRdR76HCcXjOOU11/SI+jnyT4AIvKHABKwGUHz/Z0MEPgFAaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uhBSUGB8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhBSUGB8"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354bc535546so1096104a91.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773325327; x=1773930127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0se2Poh/I/LWasWALFXJj32ndneduPUQmFM4Y6q5SAk=;
        b=uhBSUGB8OGwfjsoZjMd3p3um1W/ZF7iFkkdSpmlrsQ0/dFpKgMQ4F3OS+U0OACh5Nb
         ZL/pGCr2xgwORMpxfo49yWpwMPc1UL5phzz2ZTFy+JfRwgsJ4BmvJpipgZPogJsxv7Zn
         MxMhoMNoRWX7W76unWR+th0lHDCMxKO5kTQYTrTrwwjCyUF6ef+9TqTDka0Y9x530Np8
         pjspBfk7aegKoMJ4vJyKuIHaRhCn8IvQIn/YtBGxEkAwCA62QNYLuy+nxI2zDFuAV4xx
         kHC/IpAg2wkcCIq8T63srdFhQ5o+86Os2yaX545/ijQkPb/gwUo1dvsmpk023d1P8lR/
         jBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773325327; x=1773930127;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0se2Poh/I/LWasWALFXJj32ndneduPUQmFM4Y6q5SAk=;
        b=XhKdcCQOm1Z1w0Tt1uTFCsUbrbD31qzce6vjQHHrqjAUvJApWViGg+FCn2/aHDOrys
         VQK3tJfJzDF7Wc4PqmAELNRR0Fua0Oh5PZJDkxBw/30AXVsUnQBNX+JNIJTgD6p3o/ok
         qKm0+w4DNvFV0jEF7CAFR+xxqURedmFTMqlU9jmvGa6fc9fNxtv2h2zpnRdYI6JxLgwU
         +E1R0L/NlNFxTGbB3IVY/vVE3IuflxN88LLIioiEeWlJuwSrPTWF48z/7paR9o0rH/RZ
         k/LBDIWvRqfhp1bRDUfbdTD0fI0VqpDoHN2Oll71OIRMHyjqCjTw/uXb6aVbfYA0vGID
         dXCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0BsFk6Zjg8EJEjgKpBxIPGgbEKyoUr4Cije0xJAIj35MC/l+B/697ojL67GmXD43kpvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWKcqCe2WkSaFHJtDe/RU4Yw6KbcjbGfuJDVOTW62hyx73PSFj
	7eWrMRSU8oFZV5HCfuMkipnyTK48HA+0I4kKTB9CnH4d7g2eddDwfELa5CD8WsTqUqn2Xvdvgjf
	RpluVcQ==
X-Received: from pjbfa23.prod.google.com ([2002:a17:90a:f0d7:b0:359:84b7:a9a2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fcd:b0:359:f55a:1f13
 with SMTP id 98e67ed59e1d1-35a019e8b90mr5305583a91.35.1773325327352; Thu, 12
 Mar 2026 07:22:07 -0700 (PDT)
Date: Thu, 12 Mar 2026 07:22:05 -0700
In-Reply-To: <CAO9r8zOJoc6R9WnYqKxFhssk5d7+TFt+6WGok1Nof=-DJK8pcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310224546.2582118-1-seanjc@google.com> <20260310224546.2582118-3-seanjc@google.com>
 <CAO9r8zMTEi++JvAfKbMd2676Z8cTPQKcWA+mydzXGYPenUrG6g@mail.gmail.com>
 <abFtshMZLoLLbbXO@google.com> <CAO9r8zOJoc6R9WnYqKxFhssk5d7+TFt+6WGok1Nof=-DJK8pcw@mail.gmail.com>
Message-ID: <abLMDY058srp_rT8@google.com>
Subject: Re: [PATCH 2/2] KVM: x86: Suppress WARNs on nested_run_pending after
 userspace exit
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026, Yosry Ahmed wrote:
> On Wed, Mar 11, 2026 at 6:27=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Mar 10, 2026, Yosry Ahmed wrote:
> > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > index 879cdeb6adde..cad16c83dcff 100644
> > > > --- a/arch/x86/kvm/x86.c
> > > > +++ b/arch/x86/kvm/x86.c
> > > > @@ -12090,6 +12090,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcp=
u *vcpu)
> > > >         if (r <=3D 0)
> > > >                 goto out;
> > > >
> > > > +       /*
> > > > +        * If userspace may have modified vCPU state, mark nested_r=
un_pending
> > > > +        * as "untrusted" to avoid triggering false-positive WARNs.
> > > > +        */
> > > > +       if (vcpu->arch.nested_run_pending =3D=3D KVM_NESTED_RUN_PEN=
DING)
> > > > +               vcpu->arch.nested_run_pending =3D KVM_NESTED_RUN_PE=
NDING_UNTRUSTED;
> > > > +
> > >
> > > Why not inside kvm_x86_vcpu_pre_run()?
> >
> > That, is a very good question.  /facepalm

Oh, I know why I put it here.  I didn't want to change nested_run_pending i=
f
kvm_x86_vcpu_pre_run() rejected KVM_RUN.  But looking at this again, it doe=
sn't
actually matter because for the "untrusted" state to matter, KVM must get p=
ast
kvm_x86_vcpu_pre_run() at some point.
