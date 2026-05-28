Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B91B194C98
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009351; cv=pass; b=JT7z3Yl+185yiIteiRprTQpKkB+Zq7rgMyBOi0dHnR++rQ9ENYyRxDy41XPSTaIU8rQXTkTxC5odSfTPiYu5klUf7AAYL14bkvHjoPFw4T7p4jCxnyyszI+6qrK2aMF66KZfT7w7yxe2H3vnWxZfqF5/QhHNUgIU6GV0vDPghgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009351; c=relaxed/simple;
	bh=Ys5YWJyjUpS/tTCRPkjAUhkgYOqsYb4FXCGAKLn47/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKo3iwLXlU8D7D71yo9TsJ2PI6EuIIjTCCwwqjD1hnM5LmheqTCh92+YutTprGBWh4Lglv7I2No1KU0uKeVxQL6AEkeaB9O0zJkjmEmQqeyZ9mX8Xwt326XNA7hcYZwwzGXAzl+vd6fdN84YLG70j1ucDcDvZ2b8ahTdKqS2kUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmdKG7yG; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmdKG7yG"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50e61648f10so8791cf.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780009349; cv=none;
        d=google.com; s=arc-20240605;
        b=ChT66kdrKM9F+K9K13EZsMSCWhZJxlI02lI/N8Zc0FaoiUEkfLEXYBY7UBzkayFF9J
         CvPQ9sYkLYH6aU0Vy6itVYMFbNg3tSmD/Rf88AdgCfilyFIBFlCHChrvYhlYuYxXc4aV
         gYv2cfJaDlEVHgvAD0Ogr0DFHB5SXkkJxh0NHlNOppA7RuINQnqcg4TkG78arm61vsJZ
         YAGORyf5CTQfih/6WFlLA9mxm4dNFh7Uby1YMjCGBsgYgQ6qkcGqLVz/37gCXG8Bj4dG
         8cKlH05IjWIDDPMl2NUmaTIFxek7TUYE1U4NS0rYqcYTdchBNsZzfmxm0Y9+UQeV/Ar9
         Uegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xwg+jbISvLhyapm1uoj8khKZjC/OWtORRE+im9Nb9ek=;
        fh=rLixPcV/JuCDEqLfbPHgJm+So/X2SCePWKvIEQKYYI8=;
        b=RC5nd9/h73dlgZ9azQUeNd9VQdZmaxydiKjZPJyWRGwJyT6zWu3cF5SToCeHfrfx4Q
         0b95eFFWEHj60uFv/AjvwXM8p7K184cp/T9vx9onbf7UZlEHUZC9HC5n+hbUX3OQKu9Z
         bOQB7RZmvOwBMXY9TpmG+AzHmH/JhkEC58IeYVkaRAH1j4yZDMEGDn/HQMe2PwCQi+Zg
         I7z1co6ygJAdX9d0mrZBwdq49UHxQ4zvNjEFlNtRz/E1WM0dPazWLgsp113Db0khn5xH
         C7HOF2HHI44oEQ7rti5YcS0V63ZwSVR3GMHbLPPfTO3achj8z8tHuWVYs+otpr2jaRx8
         L+6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780009349; x=1780614149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xwg+jbISvLhyapm1uoj8khKZjC/OWtORRE+im9Nb9ek=;
        b=qmdKG7yGRy+l5ujoOSd2xRCLS7Ocb8cwn/knVL20RjckHO26r9PLsxee5tyh2QVESY
         Dd6dUZ51Y8gwPbi9vdHKmw+43X2MkrGrpejS1iCb6eKJs2eSOxCeB+Tw9vA+2OrJNQ0y
         9sAQHt3n1iGDlOGeckHirqG5yGusKJUhObzbj5ZC2uycE/A0xsVFaecqSLVMD0Xe1ObF
         3BIkxX9sdIRoG6b6y+TVD+SA4Ieql2LCWbfLvZ+DItZ8hWXKIUlWPZ47Mv5gcD6ZOYPl
         MjMzSMn//sOMdlpA63bV+vyzC4nNmdiIBDGQnpsmwHZrXuT1Cdm9YxJ9cFHIwgbKNzhE
         9KGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780009349; x=1780614149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xwg+jbISvLhyapm1uoj8khKZjC/OWtORRE+im9Nb9ek=;
        b=X1nwVBNyX9PbJIruGPK9q2rUUewhMScfXaYLBLX8u0R2P+F0xwEga3fKSImhYb7Rt8
         VfZzpzXOGfnjpyRmAc7flfMCcSKRc9qqWcJh5lywD7G/MHwWYE4SY9Oz/fx8DZJzv+ay
         PVhmn6WQS2yC5yKJ/FNvwBP8+iagXtgPdVE1MUITKrGnSPuh1nS11t/xp04dr6JNvQPl
         dQ4hJNomEWyKmB+R15jMYraMBR5APZTCB/do8aZb2uLeWmuQOUl6a8e82nhL0Rovl71K
         kji2wsLboB6tp1c0KF86INPZ2HFitDGbLXERXwHiP0jO71Xii2WNK0IjFt0aRjMOqQId
         NjZg==
X-Forwarded-Encrypted: i=1; AFNElJ/krItfn6Cpsqas6T03zKJbEaH1xtl+PErLvINMn48r21shixXJWvg0G0QxFrjECpVeHF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrVjC+PsbZxNctQYvfmy7hobwMDc9cxzCgEpr6ZjziRly0xdhX
	3Dl59NRSYPYmMQPNNtjqrK3Pw3/dn8YLJG6Ewmti6Edytkqbv6C20uIy6rcRJxLPxI6JBWuL6LQ
	tyGxPsyqJ2sv4r9NvMOsJTaGLESze1dRz/wsqrvvi1Dava0RznyYJrRE=
X-Gm-Gg: Acq92OEy0/emROfdYY5Kbva+528P+eaJ0E7RC8mxBOibLH2Vg2JIojlMql8fyDejgcw
	5HLmQjuxbXS1fJjnxgU3jJkqqgkxElbmKzUnKH9QHfNjEX3dtqUIHLHrchxaWmaa8N7SMol9jpa
	M/KOE+6mYOCJEMyTAIkNVl/KLeYXboFC/BJh19qYX4jKVml6s5S1tPPS46EZ1QgDvQbFi52Ivtt
	B71pclC1KT0Pa4UE1dKi4t54IwLeHJ14wsQspN95rMXIOSrj2zN6fZqsJrBUtWaf9OIcFmqqos0
	cHO++ChfMDXFLQcbeQPTF/UD2STcUeWiZdbfMk5l663AkQ9N9rEoY0XIiw==
X-Received: by 2002:a05:622a:a591:b0:516:4f62:85ea with SMTP id
 d75a77b69052e-5172df66553mr1613561cf.21.1780009348892; Thu, 28 May 2026
 16:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com> <20260421231557.1254270-7-jrhilke@google.com>
 <ahZSrlqWwe77HWw6@google.com>
In-Reply-To: <ahZSrlqWwe77HWw6@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Thu, 28 May 2026 16:02:16 -0700
X-Gm-Features: AVHnY4JghApBFFkwfJrZiK4BfUlNR05uahKZMrSJGxSPdwTmCMcN-RwHHKKJMvs
Message-ID: <CAAdrzjsoJeCWsSmQOnbtyk_8JxXRfjxvdfTpeyaoNLJ-aKRUHg@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] KVM: selftests: Add IRQ injection test
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 7:10=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Apr 21, 2026, Josh Hilke wrote:
> > +     for (i =3D 0; i < nr_irqs; i++) {
> > +             struct kvm_vcpu *vcpu =3D vcpus[i % nr_vcpus];
> > +             struct timespec start;
> > +
> > +             kvm_route_msi(vm, gsi, vcpu, vector);
> > +
> > +             for (j =3D 0; j < nr_vcpus; j++)
> > +                     TEST_ASSERT(
>
> Thou hast committed the cardinal sin of leaking the demonic influence of =
Google3
> into the kernel.
>
> Never, ever wrap immediately after the opening '('.

I'll grab my rosary beads to pay penance (and fix this in v4).

> > +                             !SYNC_FROM_GUEST_AND_READ(vm, guest_recei=
ved_irq[vcpus[j]->id]),
>
> Hmm, give how many times this shows up, maybe add a wrapper macro?
>
> #define GUEST_RECEIVED_IRQ(__vcpu)      \
>         SYNC_FROM_GUEST_AND_READ((__vcpu)->vm, guest_received_irq[(__vcpu=
)->id])
>
> Then this becomes:
>
>                         TEST_ASSERT(GUEST_RECEIVED_IRQ(vcpus[j]),
>                                     "Blah blah blah");
>
> > +                             "IRQ flag for vCPU %d not clear prior to =
test",
> > +                             vcpus[j]->id);
> > +
> > +             /* Trigger interrupt */
> > +             eventfd_write(eventfd, 1);
> > +
> > +             clock_gettime(CLOCK_MONOTONIC, &start);
> > +             for (;;) {
> > +                     if (SYNC_FROM_GUEST_AND_READ(vm, guest_received_i=
rq[vcpu->id]))
> > +                             break;
> > +
> > +                     if (timespec_to_ns(timespec_elapsed(start)) > tim=
eout_ns)
> > +                             TEST_FAIL(
> > +                                     "vCPU %d timed out waiting for IR=
Q from GSI %d (Vector 0x%x) !\n",
>
> Best get to reading Dante's Inferno.

Which circle am I going to? Need to know whether to bring a parka or
one of those mist fans people use at the beach to stay cool.
