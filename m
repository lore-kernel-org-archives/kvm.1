Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D871F3BFE2B
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099640; cv=none; b=G5wCTW88F7RayuNZfqzWL47ALqh6hzoFB0T6Zx7+nnIlgcXRAZswZpga3Po5Vu9is1qVi94/3MhnxaDSSHrSrm/8fdzS+KoSTwnJYUpJKzALuDefgZqQlskcu+/gTgLS351U8OHwhScd8fLFcp1DxRDCwiiw03dYY5RTc0bd2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099640; c=relaxed/simple;
	bh=sBNGKVaxgwd2C7MUTMhk8j+hcEEhVpjA4Z4BJR89HfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RZFjxvs2wdTbwfl9+1UmPsvoQReupopry5xbTSr9o+r0HQ4+/2xQE4HL+5aeO/tNcTJNKlZklBRUNzTV05WtfA/pMG1Pwz9Te+TCmIRptbIjjYp7gYCpu9+AAEXrCIbU9GpQpW7nyivpuNMp7Eq5fRp0mjBC1NDrCegxbYEGMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jLJtVPaK; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jLJtVPaK"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d9336581a2so1451175ad.3
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790099638; x=1790704438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OTbYsyPMAXRNeqI3frHnGnx21T0lm+5EfthrZkUZKL0=;
        b=jLJtVPaKEk1SDZSA9LVDnw8MtrL/vf4mki9/IKIfycpLkaI4q2lXZWyqMxHiGW+o3o
         shUtF3luYqkKaJL38fg4nBzZklikV4gEyUe88uVIuX2vMZ64lhfr9d3t07Rnd9IZuLcU
         UWOZik/veM+I3LnCqxlZITpQzTx+a9PMvc8l0ssm/DaXuIvNnEAC2WAaZCnGIPp5lpll
         lrMZQVKuBfbKOacijTTXIatS92QUDfXVXnjeAMo33BKcnfIhjGtCB2NSb6oqxUTxcdAg
         /5HFjkFVwezQ7ZP0B8MXdDprLxGlQ2dr24IC6f6EnLRYYQDCVerfRXoqXVYPPcDHV5DY
         3VdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790099638; x=1790704438;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OTbYsyPMAXRNeqI3frHnGnx21T0lm+5EfthrZkUZKL0=;
        b=U8XxO8z96I8Ex37N199LR9U/UwL1ntADJn35mMgAbGzDFmDac1CBi+cIn1XJdO8+CM
         fq3/QNnxhoAl4zDXrGSfAVviP/vqiOeLaRr+51Kq2wgo4eimtJ89QV/Wsw2p8alYcWFc
         2/ci4d1G145CjLfAjnOX1x9bDhrXjFKC2DqI6QC+avQRrsgQEpDGpo9beNDR+vlaZkVY
         z+/9uiNfqMRwQYdoTLcKxJf3ACdHHveHlOQJ6Q7tRj1l1LF4SNE97NykVgmMT9lLwxZ1
         yBq2sCGKR0vUdRlOT7tF7JIxDmX56K1M6T7ZEHL/FV0PJ9ijkNxnYk/P1eiYpswuFWb6
         8IwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxn5ou5jlsWRCSyeb6AZHA+kMo0IZ0ItZ3NK5rUBM50x0FdmOb57I9wPZAK4NxTVEBbVEU=@vger.kernel.org
X-Gm-Message-State: AFuF++mjlYFSV2aFQs9JxLeLXp9vF1CYFFEccJRUIXgRHjn0xr/NSNW1
	Ntib5aGTNrSJLfkXBd0YNtkH19/9RiSUNpA5KKybJuCAxN4xE0P/CZuyqEJAeba1Dp880YcJObu
	xrI7mNQ==
X-Received: from ploc24.prod.google.com ([2002:a17:902:8498:b0:2dd:2e1c:cb90])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8a:b0:2dd:c100:9440
 with SMTP id d9443c01a7336-2df69e1c9bcmr1132185ad.62.1790099637923; Tue, 22
 Sep 2026 10:53:57 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:53:57 -0700
In-Reply-To: <CALMp9eQi0gm7ojijfKDZz9oZh+BK13qUkJOFrCmxjJTr5sx3Lg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918154530.4129698-1-jmattson@google.com> <20260918160109.E76B81F000FF@smtp.kernel.org>
 <arKJQwAPvApkeESD@google.com> <CALMp9eQboC6DTQfa3N58XCfOLf-qwJ2L7dC5vtqDerHG80eZLg@mail.gmail.com>
 <arKQJJJB8HMK0B1G@google.com> <CALMp9eQi0gm7ojijfKDZz9oZh+BK13qUkJOFrCmxjJTr5sx3Lg@mail.gmail.com>
Message-ID: <arLAtdMP7LV0r-D9@google.com>
Subject: Re: [PATCH] KVM: x86: Disallow EFER.LMSLE when EferLmsleUnsupported
 is set in guest CPUID
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026, Jim Mattson wrote:
> On Tue, Sep 22, 2026 at 7:26=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Sep 22, 2026, Jim Mattson wrote:
> > > On Tue, Sep 22, 2026 at 6:57=E2=80=AFAM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > > Gah, I hate the negative "feature" bits, I've gotten completely tur=
ned around
> > > > multiple times trying to sort through this.
> > >
> > > Me too!
> > >
> > > > IIUC, you're trying to "fix" setups where host CPUID.EFER_LMSLE_MBZ=
=3D0, but userspace
> > > > configured guest CPUID.EFER_LMSLE_MBZ=3D1?  If so, then Sashiko is =
right, it needs to
> > > > be declared with EMULATED_F().  I would even argue that technically=
 this isn't a KVM
> > > > bug, because KVM won't advertise EFER_LMSLE_MBZ in KVM_GET_SUPPORTE=
D_CPUID on such
> > > > hosts.
>
> > > I'm trying to make it possible to run a Rome vCPU on Milan or later.
> > >
> > > SInce this is a negative feature bit, it must be retained if the host
> > > reports it. That blocks running a Rome vCPU on Milan or later.
> > > However, a defeatured Rome (which reports LMSLE_MBZ as 1) can be run
> >
> > So, a partially defeatured Rome?  Because it sounds like the CPU report=
s LMSLE_MBZ=3D1,
> > but then still allows setting EFER.LMSLE=3D1?
>=20
> No; it should not allow setting EFER.LMSLE=3D1. That will fail on later
> platforms and would block live migration from Rome to later platforms.

Oh, drat, I misread the "Rome vCPU" vs. "defeatured Rome" paragraph.  You w=
ant to
be able to migrate a vCPU with guest.CPUID.LMSLE_MBZ=3D1 between a non-defe=
atured,
vanilla Rome and Milan+ (or a defeatured Rome).  Correct?

If so, then Sashiko is right, the flag needs to be EMULATED_F() so that KVM=
 will
advertise EFER_LMSLE_MBZ to userspace on the vanilla Rome host, and also do=
 the
right thing when guest.CPUID.EFER_LMSLE_MBZ=3D0.

If not correct, then I'm even more confused, because ignoring clear_cpuid,
guest_cpu_cap_has() will only ever return true if boot_cpu_has() also retur=
ns
true, in which case KVM *will* reject the value because EFER_LMSLE will not=
 be
listed as a supported EFER bit.

		if (!boot_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ))
			kvm_caps.supported_efer_bits |=3D EFER_LMSLE;

> I want KVM to abide by the guest CPUID bit and disallow setting
> EFER.LMSLE even on hardware that allows it.

Right, and that requires declaring EFER_LMSLE_MBZ with EMULATED_F().
