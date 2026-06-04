Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBFE30D3E7
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616162; cv=pass; b=suqw0TCQ/bY07JzX9lKW6hO/g0eluiR8EVxWRYNvfUJMVoU1ze+PogiB/laCxEFIUiNxiMhFu7wG0CAi8wfQWRxTmfFwrj+DZRhqdFD7kQ5tJSPNdhGnvM7gx3bBEdC8zX5HX+tNKZ7zzSBJWcnx/sqpwCYp2awTs2X8b342DCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616162; c=relaxed/simple;
	bh=lZNIrukr/XGuzdYO5i8PX5pFSqQqCnKSKbLb/+CTF00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8UROmPwzOAkLW9rXti6MOYKa9scXlmpRzZV4v8q2NpChCDvyBlX/TRGoD4soDHY8ia1CbfpVZO/ItBfptlATTIqhezg0L1nYM+lXbDm8VTD/Fp+/25I8zhxxASeX4AZiwHHSn8J8WkACNunyOJgocfiXFXtcPzZkAgMmchMY3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qk3PZ5CI; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qk3PZ5CI"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137e75bcb5eso2277883c88.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 16:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780616160; cv=none;
        d=google.com; s=arc-20240605;
        b=bYH92yl6CE78E4hWqHQsgGpy19po+7G8rHJopUcFWtc6ZDJUnvHryT1D/oP45wYQ/i
         jGd3SSKrP0Z11Z5XbnL7JGhxQaIcJ0pTEbrKGfRrtAIyUwC9g7RZsj6coU6lleLSNkDz
         39dagnDeFBCOI1ELJU/AyJW4X0lu6Y1gDc4TdXqsjLAiXGNhrefmMwkZjKKzeyUGaPhW
         We7OuCXawJLWc5mWnLDvtKowj2IJOE9WrZejUwdbcOdqkewhApcOiQMOxM0q/QWWwoOd
         aEB4O6dis2lSAnS+4f7jZ3f0TXH3478hm0NeJkMh1sO7A/IVHZ4Z/Np+SxI2Amg+HVvm
         HIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6hacmDIYaj3bPSun8aAQ6iFwUy4En/VNVPH8yICaGZ0=;
        fh=X7edE/wTWlTR2AVt5lRjYWPhpxWY79jlPGe5dtlVGac=;
        b=gz8TbbPakIptLIv0JbNdUW4oHcq+gBVsayWuoOu9nHC3U27EU+7zh0sR4dA3aya7Ss
         fCLEX6ktvLLS+CRKXBfOwnddwaEvoaIi4WNlJvztxoYP4bfM2pmT0ZUXaNGY2sLFjVL/
         smp4SjOWjPgzc8zjencB826znYxVHrq/nqouba7bPnzlGpq1TbI3fAbXULiV88sxw7Vf
         PZ0fav2RyuFZEJWYzuniJBgnGdUUcymZ5l5+tnbeMH0ouVeSwpug6uY4P3nVPYWQVmx7
         Pkr1pHiHL0K+0G+smmjfkF1kOk/RF3FBAsLe+K628djK+GyzLvciSQDTV66zK4bW9/sN
         xCYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780616160; x=1781220960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hacmDIYaj3bPSun8aAQ6iFwUy4En/VNVPH8yICaGZ0=;
        b=qk3PZ5CIiLcdQcjwwY5zttnwMIEyX9/TkzYKspgRSDGQGqr/YdYloGVvGJVGoADjId
         AHCRAiut37q9bmAww++9+pLVom+VWKIvqbN0iAVoY9WrAxOMr+EpZ/jcaTbIN2F1bFmq
         wa4eGR9zLWKyiPfauNqpu1ssJKfB/7IcIyBZBQpmkwpaPY/j42yjexm5e11VEsiHCjPK
         qaHVFPeljSRFkSOhyYRhiMHmYctWu/VCmK3J/J7NnW8wHrZgRhdXLpbthf07GU/HYRnr
         X6kte9AV29XUUb9e4I/eLmzQkZaeftQ907e1L4vxKv8QS0Kzzw1848A3Ycxw0xrGDOpN
         LWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780616160; x=1781220960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6hacmDIYaj3bPSun8aAQ6iFwUy4En/VNVPH8yICaGZ0=;
        b=jguzQEfjBThbSJ6gHDdDAUxUCzRjALTQfpw7cCT1DJP1OL/vyBcOEyVAsOOth2nkOl
         Sn7klRAKLvtNixioH2u3V0YXy278MtfCowOuN5z408Ih8C4UhaeKsTz0YjjgI4aJZZtS
         +7zA4/CxFGG4eXK/sbvkDoR0r+m5KVXEplQVp2TLZ+9jWcHwxaKl6FB+Fa6q3wEuFYq1
         ono60saLwUzWqwTiCazb/lQlzX1m/YKY25J1FBkyuY54OE5VjHxxVD6hHHax3NAgS4Di
         m/LlMJYdelFgor4T2plh82EyZxhew+qvqOXlB1lFvzI5YTv9yYFv+wF7oaPmaBP0gqKw
         mUGQ==
X-Forwarded-Encrypted: i=1; AFNElJ93hYNezlFnAj7Rw6oEn0Bn6EKX8Uak/YF3J0AikZTIhpmd7Tv08CghjHfMrDBQlx6O6tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYahrFNDUsfD4F8K7sIp3a2WpvCSe319ujhSfqzPG72ZjALNVF
	T9Zez7s6kDoTG0Z9phqpvzRyLW/xGSUsypXVhex0ANCAJbwB52NVAlNmrUG9W215hq6aOtNHhjY
	uc4v+XwEaTlb2SLr7SprAmdi+98PGbZYBVQzgoNUo
X-Gm-Gg: Acq92OFqkOMDye0jsQvwKSRbnCE63SxEP3qAulAKbgVMDKJ/HKXBcSxOyl2qBmXePAb
	EllwdI6l36YjuKgJRb8XYJLIphcjg/P/TDa9vFjoGMlQ4giL1GU3AmNC1BxXfnzRhfL4ugap1qb
	rAn5Rq8NpZ6zcRtJ9rbUBMQ6nNF2sL4cTfw2e9yQjYJBGBuNP7kBHYktfjiBoXTExU8zXZEs2pE
	2qopa3SFiolx3FiyeWXZxfktm0Ad/0KkaJmPCDoAyxhCCt+n9RM7hKVY30JZkbTMjmqIl15Av8+
	prmJsqHyk7vY2gAVkLkI52ulA+zK
X-Received: by 2002:a05:7022:e0b:b0:137:c0a7:8d01 with SMTP id
 a92af1059eb24-1380670bac7mr573637c88.23.1780616159860; Thu, 04 Jun 2026
 16:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com> <20260604020143.748245-8-jrhilke@google.com>
 <aiG8Q31nF2L1gNwa@google.com> <aiHRIhxgBCy1TVfQ@google.com> <aiIG2L_KdPwuxYA1@google.com>
In-Reply-To: <aiIG2L_KdPwuxYA1@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 4 Jun 2026 16:35:32 -0700
X-Gm-Features: AVHnY4LcVAUK67LqIQWfiHIY4e7rUa6x5JPA65Wx8H9jRJ2yraguBRk9QbmUwgk
Message-ID: <CALzav=d3xiQaYC4J25+y9e0jKg5S2oaLRTXRkk0EtpuiAQFx1w@mail.gmail.com>
Subject: Re: [PATCH v5 07/21] KVM: selftests: Verify IRQ bypass works in IRQ test
To: Sean Christopherson <seanjc@google.com>
Cc: Josh Hilke <jrhilke@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 4:14=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Jun 04, 2026, Sean Christopherson wrote:
> > On Thu, Jun 04, 2026, Sean Christopherson wrote:
> > > The shortlog is at best misleading.  There are zero guarantees that I=
RQ bypass
> > > is supported and enabled.
> > >
> > > On Thu, Jun 04, 2026, Josh Hilke wrote:
> > > > From: David Matlack <dmatlack@google.com>
> > > >
> > > > Trigger interrupts from a VFIO device instead of emulating interrup=
ts
> > >
> > > It's not emulating, it's synthesizing.  Emulating implies there's a d=
evice of
> > > some kind that the test is mimicking.
> > >
> > > > using KVM eventfds. This verifies that guests receive interrupts vi=
a IRQ
> > > > bypass.
> > >
> > > No, it verifies that delivery of a VFIO MSI-X through VFIO=3D>KVM wor=
ks, and *may*
> > > verify IRQ bypass.  And all of that very much relies on the eventfds =
to be in
> > > place.
> > >
> > > > @@ -119,7 +160,17 @@ int main(int argc, char **argv)
> > > >   vm =3D vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> > > >   vm_install_exception_handler(vm, vector, guest_irq_handler);
> > > >
> > > > - eventfd =3D kvm_new_eventfd();
> > > > + if (device_bdf) {
> > > > +         iommu =3D iommu_init(default_iommu_mode);
> > >
> > > This needs:
> > >
> > > diff --git tools/testing/selftests/kvm/irq_test.c tools/testing/selft=
ests/kvm/irq_test.c
> > > index cf4568718cee..2e7e100d4815 100644
> > > --- tools/testing/selftests/kvm/irq_test.c
> > > +++ tools/testing/selftests/kvm/irq_test.c
> > > @@ -235,6 +235,8 @@ int main(int argc, char **argv)
> > >         }
> > >
> > >         if (device_bdf) {
> > > +               __open_path_or_exit("/dev/iommu", O_RDONLY, "Is IOMMU=
FD available?");
> > > +
> > >                 iommu =3D iommu_init(default_iommu_mode);
> >
> > *sigh*
> >
> > <rant>
> > This is beyond frustating.  I have A PERFECTLY FUNCTIONAL KERNEL, but t=
his test
> > VERY SUBTLY "defaults" to IOMMUFD.  ARGH!!!!!
>
> Ok, here's what I ended up with.  A param to let the user force a specifi=
c type:
>
>         printf("-t      Override the IOMMU type to use (vfio_type1_iommu =
or iommufd)\n");
>
>
> And then auto-probe logic to make a halfway decent guess as to which type=
/mode
> to use.
>
>   static const char *probe_iommu_type(void)
>   {
>         int io_fd;
>
>         io_fd =3D open("/dev/iommu", O_RDONLY);
>         if (io_fd >=3D 0) {
>                 close(io_fd);
>                 return MODE_IOMMUFD;
>         }
>
>         io_fd =3D __open_path_or_exit("/dev/vfio", O_RDONLY,
>                                     "Is VFIO (or IOMMUFD) loaded and enab=
led?");
>         close(io_fd);
>         return MODE_VFIO_TYPE1_IOMMU;
>   }
>
> ...
>
>                 if (!iommu_type)
>                         iommu_type =3D probe_iommu_type();
>
> I'll probably throw a TODO in there, because the VFIO/IOMMU infrastructur=
e really
> needs to handle this, *especially* since "default_iommu_mode" is globally=
 visible.
> Hardcoding a "default" to an entirely optional thing is just evil.
>
> E.g. instead of iommu_init() =3D> lookup_iommu_mode() using default_iommu=
_mode when
> passed a NULL pointer, have it choose the type that's most likely to work=
.  Then
> the IRQ test can drop its probing logic.

Yeah, choosing the default IOMMU type is something the VFIO selftests
library can provide better helpers for. Feel free to leave a TODO to
replace this.
