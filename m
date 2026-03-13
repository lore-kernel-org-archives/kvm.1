Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0191DD525
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405197; cv=pass; b=s8ofEXWkUx5d4u9BIPXKLaWPONCKodePVmFUldJ8DvSGPel5Fsae5MvijyGNDbqkHQpa/PM7QBYXj8CC/odVKbJBXTj0KzgMtPsJMEwZhIjIjXY/l72GgSEZ3i/ZFWTl/UohJ2iPNtTiJQFsTkmiDZ2yy3j3VN+IL2QzWuQ4YF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405197; c=relaxed/simple;
	bh=jJMjBph/StN0dC8o+c9eXBdnlYzWCOKzg81V2+sJJlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMZMND4huktoX5CKkWLbXVP+JgtCsmPmCTwYJf1ZhDYGg+snpZymnamVzmZ4B1cOPn5gFVyVd34c/Rl0jhDyHs646eWOyF8s9EPf78VvqQPiRMV6aTC8DfpsXTIIwDdQA6QM+WQ5ypNmmWKZRNCCPIJFmeGUTn37NeyMklL7k80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y7s7NwMG; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y7s7NwMG"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64c97997b0fso1710600d50.3
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 05:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773405195; cv=none;
        d=google.com; s=arc-20240605;
        b=CiG5JzTIKbz0nMKrDKIuG1xb6ZMJp5sV4JZi1QWtawq9+pgogY5eL/D8J3lfMG+TLd
         Bau+/44cWE6HrEO26yjg2BjGX3nj/h2UI9hjuho4k21leSqfgQqpmftJqv+rt6AfpgtD
         xoTtNZlDdflUuvdMsR6mFvqyyRhaaeAyY1AGxxuTfpWkohbYIPY55BwSD0KyNiXWJOlJ
         47M0DnezOvsAg6u9kTqt8K24qxit8YVxgABU6ACsjnSOAkNTulSyoH+Q7Ht6TuSK6BP2
         AkNofKAcLUPn47NbT/tddTerUhtOXntbFxH4YxM1M0QzLSIMNxL8GFh/9pXnFAIWkf6r
         MFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8qpkgKKZi4M0dKGmoIqvJ6FewWUr3N/GbWr7jXlFiMc=;
        fh=IQ8htlR5xL876bBw1DvWOFPQTJ51NRGpYX07+K0mLX0=;
        b=WVSRXc5/ohWLVPk7MuxwzqVLn98rRvUN2UhTVKSR0oTriuXXrwm9Oofp9z5CNbHTam
         AF2QTJPB8sdtwujpsfv5mqAo81t0kSRB8n6oX46oPIZ675yN2aVeqZtFtVJ2LCooNkZy
         lCQpwtcM0u5MiD7ESymJ1mcUQncS0iXt1IVqbI0KuV62kwJZ6lGzKubwEr2733gOxQJc
         W7mCs0u8Nk6bwUV36OmUAhVC8uEtUsZQ04htfeRtAjjXBPWrPlyv/3J2jMUDHFXviHdJ
         9jw2vyUtmJC/fKlA7Mjp/ZDHTV3RgP+viEcLj2iehkNQwR7yWtfXmIqQtBuWfv8EqjH+
         6lgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773405195; x=1774009995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qpkgKKZi4M0dKGmoIqvJ6FewWUr3N/GbWr7jXlFiMc=;
        b=y7s7NwMGU2EFljlcQIV/C4o5OI+TJGzL4yFgRS7R5LoT2RlssgN2K1Gix1OBscLjsa
         n6HDLueGJYrZl79rvSlsLv+lQPKai7kjVko3hYY8TTIc4uWXUjTXHgCecy1fnCMuoUVN
         xLGcrs/9pXYoTh5md7IWYswCKAt86GKpXix6fd045CiAue6TCl3AYJHaGbB9hbEJkkRi
         4tqGNGl+s0R7k8UD3O68I54QKkLyzMcDygX+yy6B/CS/NysQF9O2RTU1hE0L2WDKfeqK
         jEpfmosWFctXYAP986drRM9gyGR51tlofZau51nFPCMx71P0XAo1H1zS3N0srSp2Mt5J
         jYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773405195; x=1774009995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8qpkgKKZi4M0dKGmoIqvJ6FewWUr3N/GbWr7jXlFiMc=;
        b=olfvr5dqpKxLNpCdj/c43JeS3T7KAZq9GR4lluYm0pqWJ5B/Aku2vw1+bHxG84Rkdn
         O6UtHkvQr4dH3DWlqXR5GdfUwyOIkjeXry6uZiwhxLY6MERdw8szUQCOFAsI1BTV7ZVp
         PQZPj8U24ScMB39xfxPJl1TJIHFKoL6wASb7s77K1j+hBYOhTeM0Do1Db8ZIHrJAunFX
         vrq2Q7do5WiHz/YSAEJ0wrgyJCQnaCr2epxKg/RUnqIsUISnfnYQXOjMEr+Ob5tYXMtz
         Hzmm1tc6MIrg7reEyIMkj8m4IHXcGg6HqVPsn21XFt7z6pa813Tf3PkNBJsAqeTjhc99
         OrnA==
X-Forwarded-Encrypted: i=1; AJvYcCWHJaCRBqWGIN348p84HvS6VDoHz4p5TX+4XTutyAo138Sm6571VgAlDrDLlwP+VGrqsyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXwLz+mQxPit8ZtMzmCBT5tMhbAMLaxBDDf2oB5FlnZVcH/EnZ
	Wyb4ghbNzDGlMoCCIcoxXvv/T5qKzle3q1tYbTwAsbCRvyxSfxpnTGyPOUFJcKZ65xWKkn/cuGK
	8EbBXl5jKXYIkVM3Jz+6MhE4s0Z+V9gslzaI3oF3PnQ==
X-Gm-Gg: ATEYQzwnMpkNHBLN0L2Tp164q7+YLBF/gGuepMuCWI2mU2PA0OgcSDCzgdFPd3wuwgc
	bhlKBNHxb6I4te3QX+zhR+9Kvb4CVOToAuFoI2UadlMjCh/iq95bBxnQ8Mf6AyGZY0aKyicmXgq
	M9yJIIKKsL64+buruozDFdWqmj4lHy+3b6wghhvI+TlMdjbfKllfZtazSgPTDMaLvu6XI5pkT6d
	3qGYCPFXtnYgHSKG9fF1WeCFmqs2xQPnLdKu8226vTrqcB/LAgmfOAofLME0olx1+GSa1phvZDx
	im7yoK+Nv1nGueUF5Srbta9jv7W8Rm1+8iKZadXbgM4yNxU/jQUBBGvzL2NJjAi6Z5bMsUOZfZJ
	87Q==
X-Received: by 2002:a53:ee60:0:b0:64d:29b6:3853 with SMTP id
 956f58d0204a3-64e63084523mr2294434d50.62.1773405194653; Fri, 13 Mar 2026
 05:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311095405.26297-1-hi@alyssa.is> <CAFEAcA8ycT250JaECAYTKF+U2a4m6jauLPLbD8PVx2atd70A7g@mail.gmail.com>
 <87fr64vtms.fsf@alyssa.is>
In-Reply-To: <87fr64vtms.fsf@alyssa.is>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2026 12:33:02 +0000
X-Gm-Features: AaiRm524LdjNgHnlTdSFCUVAmKkaUkrny2G6lg3rMMTHEglnrcDvbVKjUJvoiPM
Message-ID: <CAFEAcA98aTmU0cKSbddQnLFwrmifNfXYaDeNsdvJR9XuB--6ew@mail.gmail.com>
Subject: Re: [PATCH] target/arm/kvm: fall back if nested unsupported
To: Alyssa Ross <hi@alyssa.is>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
	kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
	Miguel Luis <miguel.luis@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Mar 2026 at 11:47, Alyssa Ross <hi@alyssa.is> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Looking a bit closer at this, it's a bit awkward that we're
> > looking at a machine property in generic target/arm code.
>
> Isn't SMP a machine property that we're looking at just above?

It's one of the ones in the base MachineState that exist for
all boards.

> > There is no guarantee that the machine is "virt" or that every
> > KVM-supporting machine has a "virtualization" property, and
> > the target/ code isn't really supposed to do board-specific stuff.
>
> FWIW: there's another arm board with the same property, which I think
> would have the same requirements.  That's why I chose to just check the
> property rather than checking machine type =E2=80=94 the idea being to es=
tablish
> the convention that machines /do/ have a virtualization property where
> it makes sense.
>
> > The board-independent way to say "are we trying to enable EL2" is
> > to look at the CPU property has_el2. But the CPU isn't created at
> > this point, so it's too early to do that here.
>
> I spent a day or so trying to make something involving has_el2 work, but
> ultimately couldn't get anywhere with it.
>
> > Similar things where the early accelerator code wants information
> > from the board we have handled with a method in MachineClass,
> > like get_physical_address_range. We could do that here, but
> > maybe it's a bit over-engineered? IDK.
>
> I'll give it a go and see if I can make it work.
>
> > There are other cases also where the virt board will error
> > out for "KVM and some config we could do with TCG":
> >  * KVM + EL2 + GICv2
> >  * KVM + EL2 + kernel-irqchip=3Doff
> >  * KVM + GICv2 but host hardware doesn't support GICv2 emulation
> >  * KVM + GICv3 but host hardware doesn't support GICv3 emulation
> >  * KVM + MTE but host hardware/kernel doesn't support MTE
> >
> > The first two are "always fails", but if we're going to have
> > a mechanism for "figure out in kvm_arch_init what KVM features
> > the board is going to want to enable" then it might be nice
> > to also be able to use it for the last 3.
>
> I can try that.

Thanks, that would be helpful. I don't really have any
specific ideas about what kind of API might be best here.

There are probably similar issues with the other accelerators,
e.g. -accel hvf,tcg -machine virtualization=3Don
also ought to fall back to TCG, and similarly with "picked
a GIC version we can't handle with this accelerator".

-- PMM
