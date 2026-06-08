Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C9431282C
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934072; cv=pass; b=lWtvPj5D/ogkA5DqCzlwtOultiaOpA+3UlvyMc+Rs9xW0ZhkDvZb7x2o+VkQbJzIQo0idDSK9Vp3w8P9xs7bhPWsCvtnmM+fOwGqH9p4i29pMlOJYJUC6xN29lO+uIp6jx0S+FnxYapO+7UAG3l0iulMk/0XtN8DTTGtLckQrZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934072; c=relaxed/simple;
	bh=UXvt4Ld38qEKi7ryjq5W+Ze/HtJalTSAq5J0olXAflo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7AMNneiqdKrPp4BXPg/LRNaYR4pV/zNVrR916R/c+3YSpyRjsFLWYGVXFPc7juXXf0OaWiE2RTPeBuMwRHLMXGNrGXSfff4ak/avdLiQX4+XSvBsKHhIvnBUT7XOHB+Y5Rjl30b3uAETMLIUM00jFotbO3xaR81uA+y+ye/szo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gAanc9oU; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gAanc9oU"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66077f6c438so3948740d50.2
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 08:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934070; cv=none;
        d=google.com; s=arc-20240605;
        b=NxDu+KJqJ+mhxPdn3iP0m/U50wzBGNxwglKJDFoYP+5pXQ+0RgE7JaHK56f8pFA1kD
         iVShB8nHQe6ixd09/SaE1hwp3lCrxaashB/uw3uukYHfTRD/ZXxJOJtXJ/5f01g71yLo
         dsmjr7EL1Z1y5CG6IWhYKpg/8qYJSZkbSpkGQSSfwEIAGdo6zLbY//y0EyNcv5aqDZLA
         C+qxmQOH/R7hbab5dD1krBFA4XIfsZb2mtfVRhfguU3nWHX5EEqzk328aKIKvqzM5TCr
         aBuEukzIHk4f68NlCkvHLjV95N0x/Wtsr9ALprfbbDdKzuh1EMe/m+tylwg9u3IPzG3A
         wo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s2/D3mnSjO7qP/IJ61hhyERcAo/83C6MsnIZ0N9mtts=;
        fh=rn5HF2xobclzCr+SyJsN1CrSwCP9qdUfosogVWlxc38=;
        b=S5HjkHEeUex2hpqg+v4j6gh52Sxx0NayD6woiF5mHqV19x0NArilGPp4oLgs+gWBIf
         4oevtfMOocubPZZQAAPCfi3H0yqpRJ+S+kViIC0UXXxt8UBUUiB/9Aj8TexJoQzAdJ0a
         B6xPYBfkbkOqQOETrDr6S4QroVxIDgtLirh4jsi4tQfwZkANbKWZxkcPC9BQiJtyWZaI
         gVbDT69mx4XQ+oLcsKSJQSLSfOp7oYcNMzqNBQKTMUu5N06YTx287SZgBRZwdTFJxCjl
         cQ0s8wA2gv3ffm15TcV1PfD28PwBRKImY/c9GKSuLQc8AOhuD90w1e7ssgecxCeZeUWT
         bBxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780934070; x=1781538870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2/D3mnSjO7qP/IJ61hhyERcAo/83C6MsnIZ0N9mtts=;
        b=gAanc9oU27aBfaWe2HziLbpv+dcq/CjrSaPUpYa4nTYOoVFpqYQmwi8XZG2IMGdpFm
         XTNNE0xNN594stOxZ7xK453/sp94zqvYdhCs+meV8rEAMaXjqEn25N90V8Ac6qmWN8Ol
         MXp89mDp4GQv+NvJ3b4rP7l/+YVa4B7qzFSjxYzBGL0lkx91qptcY2X3MiZTKVXJKbPJ
         VyDrotCWyzJ+P9Zmo9wm8nbN5cs9tWRVhqj3qebrMll9kKFrY09fcHbm22V8eI0qNqc1
         5329HBOuHR4Si9fw/uEbAH+9MRsVdfYnJAifOcsKvdpIRC9mgiB5r61qPbAQZGruhmQU
         4Hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934070; x=1781538870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s2/D3mnSjO7qP/IJ61hhyERcAo/83C6MsnIZ0N9mtts=;
        b=cpICIJIZd7Fyz+FGalWeQTc/DJd0eU6attzffEDbk5ol/Ds3JBatxL6BQbo2BTNgGh
         KReY6/KtsI2W1buoKAsn3gsaATeXnnYrMPMQPe6JRxy/EOk1ew2AQVsfDWnIaf6uMiJp
         F1g8IZMfXc/ewE27xVRoSNMVatCoCyKSIHqT7j2XmzAxbeoBYO44z/EjxY617f1qN2qT
         iKInn8Lt7oRX7I3jdWZ3Fc/ZZWPORI4W3rWhEGdH2cP8CZ7KTmSN2sD8ij8LQdfg9OFR
         +bjqXWyFEv5NgR+9kiu6IJ7iu69hu54g+C7LGTkyODA6/5BoHhIlqocfFlRMOpRVNv2f
         NByQ==
X-Forwarded-Encrypted: i=1; AFNElJ8P/8zUe3KvL9QpoWCibp7TpBK1sr5XYLiUe0aJJ0ReRXAivD8htn2wIf3aUm4OEs/s1fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfIGSo9cu2IQla1dA84SHEQOFeu/Y0shIuPL0rhsXud1/JK5Bq
	p2sB6VdPUmWi6ZLw2dLzndG8Owz2gYi73qKgO9fwnsSqQ5/rVBlKmyIWsoumcfMYY/h0STACHnX
	43Orymg5ldoQuLsBhm6/tOahcYm4M9+Z5pWt15LIL8w==
X-Gm-Gg: Acq92OEoWf6pQY5X9UypBaTY/h9oZqxqk3i/OlJDRjy/GuGzYzhUXu2Ad8WXmb7MtDq
	VrFQoYl4cCKG+rzUrEdsZxN/ems9KZ1CQmnPIYyYHDbMOVoBKO+e8GN+LgatPiR2rQXe3q5KO3N
	7h1MlQLqXiHitJ2Nzf4mUKIjuhmfXFgTpwVvyHweaT3nNA+anfUsjDqj7ujdhSvY0bRrXO29Aw/
	c7uAVzLavR0ofqCjRDI0cY6Mq/MUXaCveXABX7KCa0TlAT1Bp1oUntWUieTazK8jIrgV2SJReA6
	n+VDmH5PmtZDNHC+cgmMiNPJSC5uSwzJ85HW5AwZb9uUjqsfl3zXSS/KY3mG/58H1lc2ZxY08uR
	dSg==
X-Received: by 2002:a05:690e:43ce:b0:660:9c4e:a453 with SMTP id
 956f58d0204a3-66106e12449mr9133744d50.16.1780934069939; Mon, 08 Jun 2026
 08:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529082948.363931-1-alex.bennee@linaro.org> <CAFEAcA94+mh_pigFDi+tEPRJ416fSWfxsQ1Lj8Byemug9kBp6w@mail.gmail.com>
In-Reply-To: <CAFEAcA94+mh_pigFDi+tEPRJ416fSWfxsQ1Lj8Byemug9kBp6w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 16:54:17 +0100
X-Gm-Features: AVVi8Cfcobky8tPd6t0Cm9SbpBYctPY7IQ1CxUYmRia6Q_QAliEI2uVYwa0G1l0
Message-ID: <CAFEAcA_5uw3z9ePV83Ni1fsVj_m3340i7E2X-DO0=st-ZDqxEg@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] target/arm: fully model WFxT instructions for A-profile
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <agraf@csgraf.de>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
	Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jun 2026 at 14:51, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> > This series fully models the behaviour of WFxT instructions. We
> > already had support for WFE for M-profile but we left off A-profile as
> > it has more potential sources of wake-ups. The main one is the event
> > stream which includes events from significant bits of the timer
> > ticking over.
> >
> > The refactoring from the previous iterations of the patch have now
> > been merged.
> >
> > I've dropped trying to fully model the global monitor in favour of
> > taking advantage of the architectural flexibility to have an IMPDEF
> > event wake up for any reason. We treat the setting of exclusive_addr
> > as such a reason because it indicates the current vCPU is in a ldstx
> > exclusive region and we don't want the guest to deadlock. This does mea=
n
> > the system won't sleep on WFE enabled locks but people shouldn't be
> > relying on QEMU to model real world sleep patterns anyway given the
> > efficiency of emulation compared to real HW.
> >
> > I've written a test case using kvm-unit-tests:
> >
> >   Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
> >   Date: Wed, 27 May 2026 12:18:21 +0100
> >   Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
> >   From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.or=
g>
> >
> > All patches are now reviewed.
>
>
>
> Applied to target-arm.next, thanks.

This turns out to cause failures in "make check-functional": some
tests now time out. It looks like the patch that triggers this
is the "enable event stream on WFE instructions".

13/79 func-thorough+func-arm-thorough+thorough -
qemu:func-arm-aspeed_rainier               ERROR            36.17s
exit status 1
74/79 func-thorough+func-arm-thorough+thorough -
qemu:func-arm-smdkc210                     TIMEOUT          90.01s
killed by signal 15 SIGTERM
75/79 func-thorough+func-arm-thorough+thorough - qemu:func-arm-raspi2
                     TIMEOUT         120.01s   killed by signal 15
SIGTERM
76/79 func-thorough+func-arm-thorough+thorough -
qemu:func-arm-quanta_gsj                   TIMEOUT         240.01s
killed by signal 15 SIGTERM
77/79 func-thorough+func-arm-thorough+thorough - qemu:func-arm-bpim2u
                     TIMEOUT         500.01s   killed by signal 15
SIGTERM
78/79 func-thorough+func-arm-thorough+thorough -
qemu:func-arm-orangepi                     TIMEOUT         540.01s
killed by signal 15 SIGTERM
79/79 func-thorough+func-aarch64-thorough+thorough -
qemu:func-aarch64-sbsaref_freebsd      TIMEOUT         720.02s
killed by signal 15 SIGTERM


I've kept the first 4 patches, but dropped patches 5-8.
I also noticed a problem with patch 5 which I've commented on.

thanks
-- PMM
