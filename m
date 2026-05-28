Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD3319857
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009543; cv=pass; b=IkNoA9sJttlwX0ytxa+ECh2hlpUJ2CrAYEK34G4hrclYX7mOcI6KAq8wvRMXeUuxg1y7gnpTmHigEpu5XSkzha8GmsjrVT6gTH7kDOCRUiox4cGvC4D47rV6dSOqpollPFbijv8SbdCnbIjKcEp+TumbFyR9aN+aDZLjYBGeodU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009543; c=relaxed/simple;
	bh=Wh16GYiFAdX9gnD7P42DOh2Y8bY01gD3w+UisbtGXZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjjCWyuDwon7L6LlBLTAsU/BPOCgU9w/SSN/X9bD7kEa93KIgRxovI8KgTmE7g1uSXySZNHllnFcZ+/xnspCXiayuHnfrE7tPbRp8xuaYK0p41iIkTddGfeYI3F1yiDGDsZ2THpm+jYF+exj05N2Bhf25qwT6Qb9oEAsjaYsMuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cO18ywuo; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cO18ywuo"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e61648f10so10601cf.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780009541; cv=none;
        d=google.com; s=arc-20240605;
        b=XT9dbp4KouqSzGTjhO/hv6gmnWTs4Ha6c7i0reIeDyv/A6rsJosMjoCH/ItZTV6PqV
         eOYDxaN0VtfrQxZSJJ4/f75ZDxjngsJvkoiF9iQOaAywDCA6+wxb2k8VNZ8eRjyDnIew
         hf4ftJ1TNr/wAzyLhu8oJq3E4X8HNVfSrLT/HXAhmG0BRXyjLIaN+tCg2seaZM2kPWHi
         A9Zk+lSmeAXbQzcAGB8lX0+xA8il+QSKVp6v3HkdldSaWYGmqVPXtTqXQGp6Rk9Kx2L5
         XiCthYcB6h81Bvoyn0XSrfSpJ3v/hosHYtFRvhdw3yccIe2mAXsufF+ILJ2foUMYraQy
         VAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j/2OjlBlYBkL0cBa0kFl0QtF7rjiwmQjKlS4SoFp+sI=;
        fh=13oZB5k5l2u8wJ99vysWQwt1PpBfV51GCcOv6Bk8DGE=;
        b=dyEqPkba2cFKdwSBlojjTykDMlcceSw7Bc9poZMC61C8txkqOy0eQ9bV9tcviXydC9
         x/i9eFQ9BnAYFnBCN5CFqBuUX3TPoFJvKUJQw6zPbbVzToUmqVWBBFHn/QY8utoRCsey
         f3Oo+Xv3fViyX/KWKiwhcJ/8PWQ0YUX7Ivyq3sAPL5bHY1CGgRYLcZx9AOP4wBEQYxSC
         9V2pTXtwyYKJ1lj7t/JKUasGrmpXxwYatd6/cAY847IgSbk3vJFFREtgrmYDsvTWuVDZ
         LXX2yprg0Ye177rtg/B4cmlo1pU+8K6AFoT+/uaQEnDlIwbnY9pJn5Bk2oi8Qlqs//Vt
         RViQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780009541; x=1780614341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/2OjlBlYBkL0cBa0kFl0QtF7rjiwmQjKlS4SoFp+sI=;
        b=cO18ywuoTg1hamCHC+Jjlr0EqbwDsIwO/Ws0XM+y/Zu4zDfQo5A5Frb3immjLtb2w4
         8BTq9ZJvCSx/F3GoKx8O9+gedXM4tIuXo4NbPRxDlK0s45L4boWpaFrp5FACGpnxdIB5
         b7YZPCy+3kPfcrWXs34rkKzE1bmssnFdRBh7W/G9U/+JEq3Kz1TKqb2eJqMJD0fAQCRE
         Lj8SJ+n40wnPIXYNjdAA/g+4+j3ODhr+uqxtYqpQWWlos/3z7kveXml41M/hucSZEhz5
         vln9l+kh6WieRbUUTaHKVqW5xa4gASC9+aV7f6ZOuulXqz3PUCaMkeYlW+rKVwpt6bzw
         CvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780009541; x=1780614341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j/2OjlBlYBkL0cBa0kFl0QtF7rjiwmQjKlS4SoFp+sI=;
        b=jvJeSkJewWo1qun/H7GJgCsGNwJBfmjPbbGGjphZFcEBgYghvs3bBmHzvY79Tr3SpI
         qKjkwhg65xAwGuJ9HehNL5xC+ppNp9Iq2CRqmjph11fl9sVF/VM1M3Ml20RXWB2xX8aL
         3xPI8YRgSmbzrgyaRfZiLkLM3Wn8xizrQ2o00eVsyU6cQgKikVrLj2CN089BBD48dTQ5
         +0wyEAe9NX04Au46y4+s8nDd1A+1gGyvqQSo33tk7lS2JZAl49DHYwQJPFtiDG+aKbG3
         ObQzJaR8rnAMpvRTRUHZdoKMMRF8E++fVCBURKBF6usdPinvYeks+kzruDy5PcclEvUo
         CXdA==
X-Forwarded-Encrypted: i=1; AFNElJ/gLVrLezvHVVEg1Yn8Gjj88mrj8EbW3GCY1iy23Uv0qNcjIaDdKGEAbwOWWkGhWfv+sRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwmTR2auvpUolHnxZq2Kd5B+wIhsXFZnsPj//x37vevTLp+ro6
	DbCf4IUscX8f+ny/YfGrRgEKniv5n6istoS4AuwvPdpa1GfWgGAz7yVDk02PaeIU+LZQTQGOVX0
	aUlDLwUoXPridybdGap8+2d7TQfmAPjPRbTCaWrU=
X-Gm-Gg: Acq92OESeEqAW5+mPKXAHfu4sFYLKsBreJahsbHXhnBwxiTnbCsT0ilU6IQVZXpGoFl
	zHGU/ZxL9PN92icf22sz+X+5Q6FbHfUOF0RMwPSj5E0Ek5LsIp/e/GtsB+/5W+9yk34iS6ZXvKB
	4DHrDlv+qRtIolM3aI8W7YEeAGTUnfMymog7m4fkp1f0f1QEvSwUmgXjidq56fTAqTwB77zFVH+
	Yb2acqMgXG9fqS36yHKrJLP9c4BlQRGf26DUNzrtUqKwy8WeWJvFLreMC01xWuYXVItAvsgojHB
	XQ3mNddIlAvfiY/e4i659f9HaKXvhvhF4NirINqs/mjEsQs=
X-Received: by 2002:a05:622a:d02:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-5172ddf7d2fmr2144211cf.16.1780009540224; Thu, 28 May 2026
 16:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com> <20260421231557.1254270-14-jrhilke@google.com>
 <ahZVi0njg6j38Q2f@google.com>
In-Reply-To: <ahZVi0njg6j38Q2f@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Thu, 28 May 2026 16:05:28 -0700
X-Gm-Features: AVHnY4LeL4ehxNKYE5P3UIVP7t3OH17JmCEeIzI5jFx5pPDbl-uGbc-vlihNXw8
Message-ID: <CAAdrzjuUEX=p0uX6mavaNv318AkgNG29263JPtXJGqjnmfxrfg@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] KVM: selftests: Verify vCPU migration during IRQ delivery
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 7:23=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Apr 21, 2026, Josh Hilke wrote:
> > +static inline int gettid(void)
>
> gettid() already exists in at least some of my environments:

Should we just use syscall(__NR_gettid) to avoid any compatibility
issues? It's only used once in the test.

> > +void pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus)
> > +{
> > +     int i =3D 0, nr_cpus =3D CPU_COUNT(possible_cpus);
> > +     int cpu, target_idx;
> > +
> > +     target_idx =3D kvm_random_u64(&kvm_rng) % nr_cpus;
> > +
> > +     for (cpu =3D 0; i < nr_cpus; cpu++) {
>
> Shouldn't this be bounded on "cpu < nr_cpus"?  If 'i' gets to nr_cpus, it=
 means
> "i =3D=3D target_idx" was never taken.  And at that point, the loop will =
hang
> indefinitely because cpu will likely be waaaay out of bounds of possible_=
cpus,
> i.e. the loop will always continue.
>
> > +             if (!CPU_ISSET(cpu, possible_cpus))
> > +                     continue;
> > +
> > +             if (i =3D=3D target_idx) {
> > +                     pin_task_to_cpu(task, cpu);
> > +                     return;
> > +             }
> > +             i++;
> > +     }

Ahh, true. I think it actually needs to be bounded on "cpu <
CPU_SETSIZE" so that we iterate through all of the CPUs.

> This should TEST_FAIL().  Or maybe "break" on the match, and the assert t=
hat
> i =3D=3D target_idx?

Will do
