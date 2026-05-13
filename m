Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B76189B84
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778631336; cv=pass; b=KwzkP320iuCtRibM+GWXryFve8og/UI+nNByBDXWF0gnH8X/YS92M+mFI+9lnXELMf3CZm0EbqUfPyHywL3fnDbETktmXRBY1oboGb9BYhZ64g/b9qWfXEB9mGZIsdKp7HhSXC8Tsyd+LTEaYFZfMaig9OQnuvoQsFtBY6ZRl94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778631336; c=relaxed/simple;
	bh=jqF9yWl+8+e8UGoQerj+SOqhMnIaD1YKPDSoW7SSxyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ojmjs76ttbKXd9YE9bcAQbXcKidjCUhuxEE9tkVAuq6DmTrALtvzhqsXS4ir6j6RAWklLyOCHP6LIJxfPn3vXvHGSI5W00oFLB4yCh6m6HK8jPGjo3tQzkHDUQMtouG2f5/noqXuZ/S8ZtNDWSMJ8PblWbJaGK+LPnAmWfrYitI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lHwDeSYY; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHwDeSYY"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d6b393d60so811cf.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 17:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778631332; cv=none;
        d=google.com; s=arc-20240605;
        b=eYwPHOFgkRIww551cRQznItrzbhiSIp1+m5F7RfepK0zSjWULQzzi/LrGBxn4Zy2b3
         9G0T8g08PKI3TGOtE/3wzGGm14SajxEkol2qltf0AEG3B5Q/MpjNhW99VQNIUnM3VUuw
         BCzcmXgVWMIK25OzklrKeWvWlCesr4HRqxZfnP1DnjR11+A/nckWHDFprUD0gFLUCScy
         x8A1I0xa2s002PS3nJ3n5bDE2AHwMYewfpXjfXigHZ15yTKLwFyLbO5HsjuVgYjJiYN9
         uMMvEA3uFYf20KzU40MYHXxWNAFbJN617hz9lSCB20SM0VN+q9/R4Xe9rF49LKvw2aCm
         uI3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VQkRC/cGw/oCczwr3Ag9cPWTCPAnlFtom+KfBvvio8Y=;
        fh=skR0W6Wxzeke0Zlijg63qxLmHuxZ/n0yy2SsJ5nuzBQ=;
        b=ghtmQdUvwWqjgmVOq2XxIHZkO6LV5z6LL7d6hQAkYpYThbkSB4CKBQ0Hm8QzqcX66N
         jX210A2OWJZ8ppPa2fXL/Onf9POGFHu4pqOdGRz/uESsCAVu2SprlNZO9NPwL2szdzBf
         QrQmiB94PjuWVNSpmcWnUgoSEwcokXBvyaJ7Bszi9ZAvj9k5mlrBgKiqUJcjZ+Z1k3D0
         tbVRCyQgOm3r+Gw607Xb4x6FvAX8o/fOBrK1sFKKiUuAtc1/DzPWY27uWbl3P+ymAJB5
         9cEsYxDvGyIXehc4WoBVLZgX/Clqv5ILaJf9qP35BQpPuGrfU3NiYB4aEWPi43vJbYjc
         iIUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778631332; x=1779236132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQkRC/cGw/oCczwr3Ag9cPWTCPAnlFtom+KfBvvio8Y=;
        b=lHwDeSYYiIt0NVW18L80cgNz40OaJrN3G76ImQNdTC4E4YN/oqZCXG9H7UD6vrurXn
         Xs+m3yI2jDpaIdNjuGw/ICto83J54uPbi/cUHrfkZEIYtIzmby9zq7xOc1cevA97yOwa
         MLXMFaVFduwOwZcrWOPQpu8leIBL/LxEfVE0vzhdbmb7rRKvW67BEKtBj2drRigzADc9
         /4A9dmLltOaiTn+LMDufi+MPzqTTiNw8CPsztudfbweAAVAZrP98fqxyir/x3XdKk8gD
         KWseFgjBZJ+wYOBcwYHfZKiCCGjww+jhBg1PGK9y59tR08O36t+J7zyfECeLkTBIKa4c
         w1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778631332; x=1779236132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQkRC/cGw/oCczwr3Ag9cPWTCPAnlFtom+KfBvvio8Y=;
        b=sDOOtGNso7kRQ+IVaBEMEAipAbfxVvQGQRJqqeZeM0exMaHTTVNqL5wWsdxkI4ve59
         j5ZNzDa7e7TgwdE2kuiicOlSS1jTxCP6RVh9LSK1CELU/5DWP3dQci1AjEWPahzXh7oL
         PWXmMiD/TerBosfI+DyBBf0Y59dcZFfaL3I4JS4MmjNudL9lWhWQOvLoqY8jDzkATNaN
         4g6VZ86hlHgKuuv7a07bt7KnGvLX+4fd2X5nWAAum44oxPGBaBEguXZFTVD2mvIwXGst
         sZRVvSKDokhmHbAZgY7b5e39pfzlz7GpbfrcIDbp+z5ITM9oRAg2avS9Od5zDDuAIo74
         NAuA==
X-Forwarded-Encrypted: i=1; AFNElJ911r3msmmYi3De3yUXGGGI/7yvZ9aBYwAtlx/FpczGgDRPbk/RT99Qyok+dEv9i0hxpy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgURtQmfpLtSL6AgNhs7QDtOEzj5Kq5qS3MAdK8eM06Fx6MWr
	Vwpwh9KirEoFuKQ6/T6kBlJH7uvVrdwf1HmOsck/krtL3E03SlsPM4SnHBOUaof6ATMuBxeugrl
	voryZm7Jud/TLRi1OJ33OnEwGQ6b08UK/LFCrTHl9
X-Gm-Gg: Acq92OHF5IbkIXw1URNkHyULcJCtwlFzjD0yiZJ4Qz3zFbZhUfa4F4dYssDOJCqSBMy
	bNBuuYFer08yV7TNKgvrkL/cp9Djj50wrfFzJNt4H+1NiLjzEOaWDmcIp7dHMIS0pAdMRxY2tOO
	Z5rLfdKFsZiplsT6a8/25C8V02+TRP3k6b9mn4XF99N7PQtJFTj9nTlWfKc+kbIi3BlkYF1dmXK
	QAv6cCIi+HtKCwdqI9ew2px2LVJQmse8zwTvt+54xMzu5PPCZogwqTLp3FCiddW/rDRv06tb73I
	6uChjBajb2IUaj1tOaFmR9NfjSMfy8aCYfjYbaL9eUBJtY4Y
X-Received: by 2002:ac8:5996:0:b0:509:1d4b:f86f with SMTP id
 d75a77b69052e-5162b156ecemr6249871cf.14.1778631331686; Tue, 12 May 2026
 17:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507212957.2629561-1-vannapurve@google.com> <agOt5nzP6pm5yyOZ@google.com>
In-Reply-To: <agOt5nzP6pm5yyOZ@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 12 May 2026 17:15:20 -0700
X-Gm-Features: AVHnY4KKpe94ZXp8N3WrNd8R5iDQPPRXzPKs8OHnL-oJfKDcOYWY0tznc4jkfJs
Message-ID: <CAGtprH9kZubz1=VvrRxN+ucFOqnvFKs8HM7TPUvNCtn8RUsTrw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] KVM: x86: Introduce has_protected_pmu state for
 TDX VMs
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	kai.huang@intel.com, jmattson@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:47=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, May 07, 2026, Vishal Annapurve wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 0a1b63c63d1a..c248abb0e2ab 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -6909,6 +6909,13 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
> >               if (!enable_pmu || (cap->args[0] & ~KVM_CAP_PMU_VALID_MAS=
K))
> >                       break;
> >
> > +             if (kvm->arch.has_protected_pmu) {
> > +                     WARN_ON_ONCE(kvm->arch.enable_pmu);
> > +                     if (cap->args[0] =3D=3D KVM_PMU_CAP_DISABLE)
> > +                             r =3D 0;
> > +                     break;
>
> Sashiko: 3, Sean: 0
>
>  : Does this code bypass standard lifecycle validation?
>  :
>  : For standard VMs, KVM strictly enforces that PMU capabilities can only=
 be
>  : configured before any vCPUs are created, returning -EINVAL otherwise. =
The newly
>  : added block for TDX VMs short-circuits this logic, returning 0 uncondi=
tionally
>  : when disabling the PMU, regardless of whether vCPUs have been created.
>  : Could this introduce a UAPI inconsistency where the same userspace seq=
uence
>  : could fail on standard VMs but silently succeed on TDX VMs, potentiall=
y
>  : hiding VMM initialization order bugs?
>
> That potential issue crossed my mind when first trying to figure out how =
to allow
> KVM_PMU_CAP_DISABLE for protected PMUs, but then SQUIRREL!!!
>
> I think my original reaction is the way to go: add extra validation for p=
rotected
> PMUs (reject everything except CAP_DISABLE), but otherwise let the normal=
 flow do
> it's thing.
>
> Completely untested, but I think this would do what we want?

SGTM. Will include this suggestion in the next version.

>
>         case KVM_CAP_PMU_CAPABILITY:
>                 r =3D -EINVAL;
>                 if (!enable_pmu || (cap->args[0] & ~KVM_CAP_PMU_VALID_MAS=
K))
>                         break;
>
>                 if (kvm->arch.has_protected_pmu &&
>                     cap->args[0] !=3D KVM_PMU_CAP_DISABLE)
>                         break;
>
>                 mutex_lock(&kvm->lock);
>                 if (!kvm->created_vcpus && !kvm->arch.created_mediated_pm=
u) {
>                         kvm->arch.enable_pmu =3D !(cap->args[0] & KVM_PMU=
_CAP_DISABLE);
>                         r =3D 0;
>                 }
>                 mutex_unlock(&kvm->lock);
>                 break;
