Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1551829AB02
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938123; cv=none; b=OB5FHppOnW5Zsl1yJT1sx4tgk9X7vc8GbyXzxD11PXufXJ9jWkeDahv8Y8B/sAyT+cmc6DozBq4oWzy7Vu+xM0v2SF4kpfBb1zKx+d/MLgDgLVHa1bnUwORhRbswN/FrSEtdyQTJBOLr3YISutiGOreROCq+iV3L9+CG0J8AxYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938123; c=relaxed/simple;
	bh=mw4btTvK/1gBkb6sYCM9mnFdJzn0VFLK9WojcbfILaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HDgZg53jQti26OSBZ9FEG0O/J+dg823seyDsjNKxJK9cylLZvo2QTv1prZSuEKDn6i/FPcU1a61w1ddbB8+OkFtnyVN8/LbGpWuCGOK3rNZJqD3fhS54dt4lGFDmS5/zEiBg5AzdXUmwjCA3UvaVdG54mjLAc5X8YBaEa//SvB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FdU16ooi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FdU16ooi"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso3182861f8f.3
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780938120; x=1781542920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Xj+SKmjFc6s1UJlgY0hUfGaxYukZbxmJSQ4x5M+AHw=;
        b=FdU16ooiIGLPeS+fOu9xHM/m1672tYRzSd0xPiQ85fhcblWd4/WPFo9lMkWCAkH1Oi
         wDIxPeBLDheKuKuHNUlcDc9dzDaziNidlfXjA9ijVBDpkuPRf4M27+kTe5pW1S96NJoI
         1GXuw1w0/vQbVyDUmLWkt4thXnRUNUBR0RKySm8XpxEV5QwVNRnd3MQxULg/PitWdPgM
         /vFdQiqIfpM+TBQYj/TqviDql0R45eB9eTQaDEZ5bXarkHscp6QsJf06qnukZ2uOED9S
         Rk0f8iRgF924zR/TWxaAfcAH6Ot8Hny7pifYDn02MZQVzLWTqmf7ZyrX/8Z0Kmih/A2C
         iRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780938120; x=1781542920;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xj+SKmjFc6s1UJlgY0hUfGaxYukZbxmJSQ4x5M+AHw=;
        b=kriydNQPtPs62/XO/OimdGbeRDYYonJTDKqPcjGDXAFVgcmUXV27M+rFS36ip4Sq5z
         kz7mi55Vo2ucDY1Slnvue8cHW5/yOshGNpD1Nlt/bEH1/wHYmI4rsK441Ka1fIDejH1A
         9JzecamNMlAUp/Ur0U3LdKFtMqdc4h9zVYjY/Qv1hf3OEHgu9P28xSI/lMW/S3WCTf5a
         Ip8jEKgT0kfSsAdtCNXqvYhAX4kKHrNQzZz300ZRTq/nm8Cunge/fg5Oomj+F2YXj6jl
         nBeZ4TBMh2FcVChUioukZXm2q5waJ3ZU8k1jLDvGbG2EEW/pxDDT4zkAYLOTm0hTZYB8
         SQEg==
X-Forwarded-Encrypted: i=1; AFNElJ8w4nob5ExPmW7WTN0zuNZiDS4Wdep6A77D0Jl0GtXPloS/2PJmACuwVXwi2y8UUoQU42Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YweHXplMgfwA6udi4Q3okBoU0EXdcTOAcJZymPvor11Ez08s0pf
	CXn3UX7HuuT1WgK77DhXGDLdKqUSudhiZ8ghBpEogzqMQBAbF7xfTZSYgC8yVIXdS+mvzjn8bhF
	OayZp
X-Gm-Gg: Acq92OG/0WIQ63rc2JD5y22Fs19mxum+ffK9E8AruGOhyWLe2OTJ8N45y7rIRgbS4z9
	O7n6wSBdmzQ2xRV+xujNOQp05m19je2zTNIacjeTKTgnAn7r8siuGHilgxLGWZ8yW3wBh8uyxJm
	PoJKp/3gY/s9O9XFq55KbGLcqB1N1T6SR866Dp6zLz0pkC2c/87jKz65KWWql27IMWOeMgMq6jk
	5ENGbiqvt0idasL3Qd/9KWqnJu1QkWeEzL8KF0XgeS9a15OGKk5XkGNaHnXIE7sCYtUnqp4c4tb
	WoNIkX98kWQmyFt6fPI5tPVuYw5PX360F2nziffnXvfcwuDQN5ix5gHf0THbFG4Z9HnQ24hjsXb
	+3y/lZlSEwc27mf3/GwTmQIwv4TRo7WRtiLtamwi5i7tr558GkSanHssdiXYQ8kASvlfHbARrsv
	Opfw8dKnwkvSYfCItOLq/8gsFbBkDuoW9zPg==
X-Received: by 2002:a05:6000:184e:b0:45d:77f4:1ac2 with SMTP id ffacd0b85a97d-46030183b8cmr26123425f8f.0.1780938120382;
        Mon, 08 Jun 2026 10:02:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm55826031f8f.1.2026.06.08.10.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:01:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 9E0755F7DE;
	Mon, 08 Jun 2026 18:01:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Alexander
 Graf <agraf@csgraf.de>,  Mohamed Mediouni <mohamed@unpredictable.fr>,
  Pedro Barbuda <pbarbuda@microsoft.com>,  qemu-arm@nongnu.org,
  kvm@vger.kernel.org
Subject: Re: [PATCH v7 0/8] target/arm: fully model WFxT instructions for
 A-profile
In-Reply-To: <CAFEAcA_5uw3z9ePV83Ni1fsVj_m3340i7E2X-DO0=st-ZDqxEg@mail.gmail.com>
	(Peter Maydell's message of "Mon, 8 Jun 2026 16:54:17 +0100")
References: <20260529082948.363931-1-alex.bennee@linaro.org>
	<CAFEAcA94+mh_pigFDi+tEPRJ416fSWfxsQ1Lj8Byemug9kBp6w@mail.gmail.com>
	<CAFEAcA_5uw3z9ePV83Ni1fsVj_m3340i7E2X-DO0=st-ZDqxEg@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 08 Jun 2026 18:01:58 +0100
Message-ID: <87h5ndge49.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 8 Jun 2026 at 14:51, Peter Maydell <peter.maydell@linaro.org> wro=
te:
>>
>> On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>> >
>> > This series fully models the behaviour of WFxT instructions. We
>> > already had support for WFE for M-profile but we left off A-profile as
>> > it has more potential sources of wake-ups. The main one is the event
>> > stream which includes events from significant bits of the timer
>> > ticking over.
>> >
>> > The refactoring from the previous iterations of the patch have now
>> > been merged.
>> >
>> > I've dropped trying to fully model the global monitor in favour of
>> > taking advantage of the architectural flexibility to have an IMPDEF
>> > event wake up for any reason. We treat the setting of exclusive_addr
>> > as such a reason because it indicates the current vCPU is in a ldstx
>> > exclusive region and we don't want the guest to deadlock. This does me=
an
>> > the system won't sleep on WFE enabled locks but people shouldn't be
>> > relying on QEMU to model real world sleep patterns anyway given the
>> > efficiency of emulation compared to real HW.
>> >
>> > I've written a test case using kvm-unit-tests:
>> >
>> >   Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
>> >   Date: Wed, 27 May 2026 12:18:21 +0100
>> >   Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
>> >   From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.o=
rg>
>> >
>> > All patches are now reviewed.
>>
>>
>>
>> Applied to target-arm.next, thanks.
>
> This turns out to cause failures in "make check-functional": some
> tests now time out. It looks like the patch that triggers this
> is the "enable event stream on WFE instructions".
>
> 13/79 func-thorough+func-arm-thorough+thorough -
> qemu:func-arm-aspeed_rainier               ERROR            36.17s
> exit status 1
> 74/79 func-thorough+func-arm-thorough+thorough -
> qemu:func-arm-smdkc210                     TIMEOUT          90.01s
> killed by signal 15 SIGTERM
> 75/79 func-thorough+func-arm-thorough+thorough - qemu:func-arm-raspi2
>                      TIMEOUT         120.01s   killed by signal 15
> SIGTERM
> 76/79 func-thorough+func-arm-thorough+thorough -
> qemu:func-arm-quanta_gsj                   TIMEOUT         240.01s
> killed by signal 15 SIGTERM
> 77/79 func-thorough+func-arm-thorough+thorough - qemu:func-arm-bpim2u
>                      TIMEOUT         500.01s   killed by signal 15
> SIGTERM
> 78/79 func-thorough+func-arm-thorough+thorough -
> qemu:func-arm-orangepi                     TIMEOUT         540.01s
> killed by signal 15 SIGTERM
> 79/79 func-thorough+func-aarch64-thorough+thorough -
> qemu:func-aarch64-sbsaref_freebsd      TIMEOUT         720.02s
> killed by signal 15 SIGTERM
>
>
> I've kept the first 4 patches, but dropped patches 5-8.
> I also noticed a problem with patch 5 which I've commented on.

OK I'll have a look.

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
