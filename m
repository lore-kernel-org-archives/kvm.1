Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA3C39D6E9
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290256; cv=none; b=ZN77ysudsAkwyQ3uVPQ2kPx79Srk+gzATmJD6dbgURf50khIm1VyabFYtBYMk0vrRQxbN4XpTg9VSyBG2Q9O59cm0UNHVwhUUeLXYI0pt/ANqvh2DcmNxcOlrExmdwDJ+4zPH5EkwufNnIbiiSxWgkNWu7UF0W5AQmS0rOwjF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290256; c=relaxed/simple;
	bh=rOmxvRgPilijmh3Mmys5rUiYjkSPk65d+CBLecrHftg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VMwrm6koQ1MhjJ31VvT+9NwVn8gGuqLNqD8zpO3Xw5SfgUSkiD/cXHS8FI0xh1ywQ6DiU7P/DYoRhQUb2R0/kUbGA40aflSnniWw3ZzP+ApU3LrIeCtLyfTF4JuJfoUB5hwRebxeYlcr6jhPjjwJ+ZmPluZ8G1W3FtYaoYfhOR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NBn9vMXB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBn9vMXB"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4905529b933so13321145e9.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781290253; x=1781895053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9d5XdG4nK+gC6Q3Lj8SelKF0sJUz9ob8Vfp1Hz7sKDY=;
        b=NBn9vMXBg0gHWR/PaicqUa6R2STRywzCjX8ZU/dNyof3df5zUJzzEDkOOOhx4+lW8r
         mrNwYNy1/D6nAg2vLv/0vUBjvjtDOlNXUFyWRXIwfGKnahb6zaOQzVcj6K523D7aadx6
         Wr2l7uzYdUap44RNOhQVucoi2Ck/eWBaINEUDknCg9Oo+ozHAHPBG6PWlxN/BXS/8WB7
         WyHIHQfXuXCncApUQv/+FjGeBipBDiN60gQ1YGTBY20I/tGsKr14HeFW91PCuuKaeCU7
         MekhT/Mdx9TQMAt6FfzUnElIyeOZrgKVu3JdDCJoV6flgfnO4t9stA9Mg+2cBAd/t0d7
         EZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781290253; x=1781895053;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9d5XdG4nK+gC6Q3Lj8SelKF0sJUz9ob8Vfp1Hz7sKDY=;
        b=FFZu/YSljTmD6uge2vrm8ElWXc1tgq1ookO9p2Ne2gdYDAJ2AQcUEeXikaDX5FSCVL
         vFdcjkuIPtO43u911rJ9TRPVyH1entc+pGsh+45u6cqb0zdB/LMAlETMNRGY88PWwu7v
         qPwW84hEOUCn+sIoO9k5J+p2zmHxmIIShBHJHg6mSf2x13czhaC8cTuOrUUcdJS0W3aK
         RaEQgxjKOMCoDg0s6OAdVKc0qQeAub+EH/+pNPIdvOcP9qi07tCYBuLS5Ii4InIWIRKu
         UgbJadqUjZCRcI2mus/D7fdTuzMrS5KEBaWtTI9nQpEcwObKXd0Rm8WJsYluuovJkYB0
         iwUw==
X-Forwarded-Encrypted: i=1; AFNElJ90fsnEQfl83sTLg4b8wdOvJJcMrru3ksrplVXYj7tVnjbzCi+b72I4XwIwVIjSRJ3BKdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQwVwLbrn8fDD4WVXjwSy4NdrZ3JNk1Fze1jJCfm16kJ62NFEp
	opysXp5zKcumQ9/n/j62t4TYque9Gg1QbF7ycyExDRYB7DuCtzjuSQmFg/wlG7/hb9s=
X-Gm-Gg: Acq92OE4bXsUeC1WxdQ/p0xYn5Jmk1ziq1yM80CRNCrNqfPBunTLftOworOOZMD4Py4
	p4Aoz1LDqRAmQCir/u8fXRNV7OqimBVyg7ZykWTa0n+FFE4HZsBwSeh9/gUonmgHC1FR87hVq7D
	yqJwriJqBJHO6zHOz1PSRQ++2mSE1PItnPaoWdEY4o5/sPiKfZ06G0EH5plvODM9oLk9Iz3JzSg
	/Z8dDAVpgwvBX7YFKa9b3fgGbuBhHcoAITomx/pykQ49UxZDlBsoU+EBBRUBOO2SfkN6DLDXidw
	z/v8p+w1aFj9s9qrQiatvnufxKUvBQjP9aj/gtw4cpSZyKtG9KsAEkahWRT6u5MwR0hNJtuog4r
	rqcwhVxemSSiXGP4b7LJTa4v6EGHc6WoZzaVbgq3BbBCdISB1RtqErV3AmaoH7kD07gDcds5gQh
	52dx1xlXgO/R55r4fUGpHSiDs=
X-Received: by 2002:a05:600c:638d:b0:492:1e36:d16f with SMTP id 5b1f17b1804b1-4921e36d1b4mr21725105e9.37.1781290252735;
        Fri, 12 Jun 2026 11:50:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49220345528sm9705825e9.8.2026.06.12.11.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:50:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id DA3A85F814;
	Fri, 12 Jun 2026 19:50:50 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Alexander
 Graf <agraf@csgraf.de>,  Mohamed Mediouni <mohamed@unpredictable.fr>,
  Pedro Barbuda <pbarbuda@microsoft.com>,  qemu-arm@nongnu.org,
  kvm@vger.kernel.org
Subject: Re: [PATCH v7 0/8] target/arm: fully model WFxT instructions for
 A-profile
In-Reply-To: <CAFEAcA8yNGiKeMpN_wgWtc5EnfjsnxSvG6an4-UjBf6XG+4Yvw@mail.gmail.com>
	(Peter Maydell's message of "Fri, 12 Jun 2026 18:46:48 +0100")
References: <20260529082948.363931-1-alex.bennee@linaro.org>
	<CAFEAcA94+mh_pigFDi+tEPRJ416fSWfxsQ1Lj8Byemug9kBp6w@mail.gmail.com>
	<87h5n7ekxw.fsf@draig.linaro.org>
	<CAFEAcA8yNGiKeMpN_wgWtc5EnfjsnxSvG6an4-UjBf6XG+4Yvw@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Fri, 12 Jun 2026 19:50:50 +0100
Message-ID: <87bjdfegol.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 12 Jun 2026 at 18:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>> >>
>> >> This series fully models the behaviour of WFxT instructions. We
>> >> already had support for WFE for M-profile but we left off A-profile as
>> >> it has more potential sources of wake-ups. The main one is the event
>> >> stream which includes events from significant bits of the timer
>> >> ticking over.
>> >>
>> >> The refactoring from the previous iterations of the patch have now
>> >> been merged.
>> >>
>> >> I've dropped trying to fully model the global monitor in favour of
>> >> taking advantage of the architectural flexibility to have an IMPDEF
>> >> event wake up for any reason. We treat the setting of exclusive_addr
>> >> as such a reason because it indicates the current vCPU is in a ldstx
>> >> exclusive region and we don't want the guest to deadlock. This does m=
ean
>> >> the system won't sleep on WFE enabled locks but people shouldn't be
>> >> relying on QEMU to model real world sleep patterns anyway given the
>> >> efficiency of emulation compared to real HW.
>> >>
>> >> I've written a test case using kvm-unit-tests:
>> >>
>> >>   Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
>> >>   Date: Wed, 27 May 2026 12:18:21 +0100
>> >>   Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
>> >>   From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.=
org>
>> >>
>> >> All patches are now reviewed.
>> >
>> >
>> >
>> > Applied to target-arm.next, thanks.
>>
>> Is it too late to drop them? I've a fix for 2/8:
>
> That change is already in upstream git, so you'll need to
> send the fix as a standalone patch, I'm afraid.

No worries, I'll fix it up in the re-base.

>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
