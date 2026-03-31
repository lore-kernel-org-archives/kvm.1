Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2694845348A
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992460; cv=pass; b=iYtv0aA6ur7YllsIlOUwb9xO5t0oWIs58DQusUPtxlebEaaTCoVFZh+pM8oGpEFgLl2QYZjHPduvhAEXwoaRr+hQJZz14Z7ZUaWPAHmBiLq5pwz7VH2LWhTqWeK3Upk9s8pVps/W4KWe4HwFyzI2w5U8Dn5Un813yTn8GzU/9dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992460; c=relaxed/simple;
	bh=IW/UPhNkJryUK6jHU7M+Zelo3rQP2OTqxdR0qNq1/BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msWweyozYHRByfjiKF8QPdASjc3WXVbAibYacjQi7mMNNbeAtHoY+B8bpMAqn9tL5ylatu4B2W9AqpjXYp/4wudk3IVdiFlLc5QiuANTmZEn9QzitjwXVsIBLHkgjiHslmD/Z2EDcEnLs1y/Ohxa9ywakqURGGTlCMpzD+1/WDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gf38fzyU; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gf38fzyU"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50b6c45781aso983881cf.0
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 14:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774992458; cv=none;
        d=google.com; s=arc-20240605;
        b=E+oER6KFPxiX1y2ghVujGkUR/Vf6pLn09FW08ZOSLkgcWxwfCEqzYZXIu+NrugXnCe
         e+49IJmroCIcNJ7RQdlGKGMdgvTpHQEoKBhcuP7QqQZnBgzDzx9ZVv+E5ipzsdglBVMW
         BXZIpve0jFxQUHDmvGb+AnxmGSAtw9GdpVKW5XDhBuACiV6+32LOyLoegoeZA9iXDYMV
         nykTWa+ukwXzbNKopTI0/cZiw9cOiCHAsUaH2jgSIIZhrhpLftmsZQiVDFBWbQcJ9Dg0
         ZwfyyRllslUcUz8isxWaGvv6aQprqRaJTA6BhIz3VTHtd5gXP8WBuM7CNFzh0OZtY267
         WvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=125PA+jy08FvMlmytdVFe9tf9fHqrztb2gBnsE/R67U=;
        fh=13+sCr/VnLs9NqqUhqsn8k4J0Cl4cbFnfXYr1k3wcSs=;
        b=g9sC536CeflRWUljNgjtVrHa5lb6yDVoVAkVhndaM4DUTNlPTVwmEEvu7h+8GBVMu8
         mGeSfDFh7LrwYCWSkVACffBODBeS1ZPalHb7EkZAvzEfoZlwX7u+xdHccdcVj2B+F2F6
         6KT4adzc02PBsEH0+BTomyXfBlFHEjblX8S9igO/+ukCpDIPK2c629zo86rDgei+Z/Yk
         InnmyJUmx8mZB8Znzgmsm1Dq5O4LNp2PssaQLU0xca4eT4aL7RP7whPqLRyav17SeyRi
         U14gPmMSBfaJ0j9XSGcI+UUMoeBPCT4VBfsX8bisD/s+OEX9KuB5agYIoqxTDFNP2g//
         WboQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774992458; x=1775597258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=125PA+jy08FvMlmytdVFe9tf9fHqrztb2gBnsE/R67U=;
        b=Gf38fzyUzFFP1Oen0JFbl1+4zY82GC5XEioYsQyqqFfSehmsdElozzvnqqLzqMQ6KS
         Q6+f/2Jz+W3VPgpLrlwqA/OKE8TCx0YmWGBfg5RO2ovZag0otI9O/spsS0C30B3mN43C
         rgLKXayKgDl/BQx7fj/P6vTvkOLGZc4t3lQydPivmfFQp0VtJb5/e9/vvGw+ZRyx8Gwk
         2DkaZ9wAu5lf7YcnsrunuwnG9POLp00jczOsPBZPczdXdHhYWbmiAJaoj1XBdwfn2GP6
         qVGV2ek986jr1OVm3VUQbXBVb30SaZCj7HC61ts0/GgQOFPyQekUs8RkEtZTBmhHyK6N
         5EQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774992458; x=1775597258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=125PA+jy08FvMlmytdVFe9tf9fHqrztb2gBnsE/R67U=;
        b=XAn7Ru+KeN2xITksi3AI0AJ2hTaN+/3KxHpyMb6Hn6FCMNavUiv3xpzziYKdLjqBdd
         +YI9/QHV8ZlevLFgIsmO4wurWPecbIKS4e0eGrt5+VpEKkY6FKVZltWUOLGMt0nOmRKB
         Adbwc9EOrGHJDRYg5AOWqjlE+yt8/sWe8tt+7gQvQ7nQH19GdBo3lHFTgCNR+HwVubdJ
         tL9xw/bQytFe3rgsMbINdwzoprmhkldRdWw1XFX6uEmBhFFmDS51/9uOEPj8N8ZAKEmf
         29mmko1L2QYN50eL7qWojFY1EL5qoNVwm+y1Pnaz0IcjU/XAmMR3k/5a/jvM8g+5Q8De
         mYjA==
X-Forwarded-Encrypted: i=1; AJvYcCXzHuR6lVs1d97F/Q0v2d9+QNslXBsderMt+gDGQfgrRsugvW7DWr8CbIzW6GrxOA9Bl0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVHwYZx1N0wDKsyPmqTVyQeo0gF7+5AAsL3B5OrO49nkFYXUz
	hPTRxm6OB1zTWjj5wMHkjiqKAEe14PUjQdHNlrWAKdCfb1OPpKbQ2R6ui4FINbaDMOoY03mv5P/
	30yPEDicMKJehIyMGvMaAUyEEiLPZoRcfX+Mrx6t+
X-Gm-Gg: ATEYQzwrPNKehqvv2NSwSWu02CBZD8WdvuYcI4rVRqlxFyMjrki7gHPxAZ6hPJOCRK4
	MXIxiTDIEpVnnM0/xmffg4oDIj6dpOoCdlH02F0QiBgaHOVRLiY+dKlkK7lW+7WX8kWHnz3HIlG
	BOQnW8E0PPl7h79FlbWq4oZwmaOuqHg2JuVf0OeWiviIcSRGY0JtTlwpD+7yvsub+kiyDUu8OlN
	KsgoXH7M6QnMKuRM0BaaLYH4YWTIUiCGubsLj1IyItkU+sxMCOPIFk1NhTfU3fdieqK2+aRuE+I
	pOvhC6FmT4eozWlDV+8=
X-Received: by 2002:ac8:7c4a:0:b0:509:1cf9:ea11 with SMTP id
 d75a77b69052e-50d3e581ed4mr532271cf.7.1774992457555; Tue, 31 Mar 2026
 14:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303193822.2526335-1-rananta@google.com> <20260303193822.2526335-4-rananta@google.com>
 <aai39e81lFkxCBMp@google.com>
In-Reply-To: <aai39e81lFkxCBMp@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Tue, 31 Mar 2026 14:27:25 -0700
X-Gm-Features: AQROBzCX1B1N_bOWpcAUzNwnIDz50tv_V7NAdMVUWpfJbIwoIFzN1NMz1G1VgfY
Message-ID: <CAJHc60zku6Md6Uzb1_Jn9yx=SAeSVfzZ4OtKVDjOVAr9xODrpQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] vfio: selftests: Introduce a sysfs lib
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 2:53=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> On 2026-03-03 07:38 PM, Raghavendra Rao Ananta wrote:
>
> > +     ret =3D readlink(path, vf_path, PATH_MAX);
> > +     VFIO_ASSERT_NE(ret, -1);
> > +     vf_path[ret] =3D '\0';
>
> ...
>
> > +     ret =3D readlink(path, dev_iommu_group_path, sizeof(dev_iommu_gro=
up_path));
> > +     VFIO_ASSERT_NE(ret, -1, "Failed to get the IOMMU group for device=
: %s\n", bdf);
> > +     dev_iommu_group_path[ret] =3D '\0';
>
> ...
>
> > +     ret =3D readlink(path, driver_path, PATH_MAX);
> > +     if (ret =3D=3D -1) {
> > +             free(out_driver);
> > +
> > +             if (errno =3D=3D ENOENT)
> > +                     return NULL;
> > +
> > +             VFIO_FAIL("Failed to read %s\n", path);
> > +     }
> > +     driver_path[ret] =3D '\0';
>
> These can all write off the end of the buffer if ret =3D=3D PATH_MAX.
>
> Also there is an inconsistency in these calls. 2 use hard-coded PATH_MAX
> while the other uses sizeof().
>
> Perhaps add a wrapper to handle all the details?
>
> #define readlink_safe(path, buf) ({                           \
>         int __ret =3D readlink(_path, _buf, sizeof(_buf) - 1);  \
>         if (__ret !=3D -1)                                      \
>                 _buf[__ret] =3D 0;                              \
>         __ret;
> })

Yeah, good idea. I'll consider this in v7.

Thank you.
Raghavendra
