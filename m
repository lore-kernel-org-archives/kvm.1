Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793031133;
	b=rxgpCyNS65y6oVH3AbZ4op6372Q55Xc8GnqK6R/P0WzbRpj94XJF2VypGgl2KCssWl1C
	 W/tGNl061/Bfld9e251N0unpaqk0ZUThYr/XQzZez+dAIq8K88OL8biQ5YRIbqtBByyrn
	 DsYRLRNpcLrMPsrvRWOTnaf9d98kQgx+mGebS1Frk7OZoa1g5i5keE8blZJu6ZH2IWT7t
	 9lqWq3ATeFIiQMpXnwV2qx9daZhL1y3CfqiY9UoXKMhT7HEMMA1rhOBxbiJL1DAl4j+Mn
	 2HwFSeW1Zs9Vdwn21xg1ifzGf2ayubUAGnshB5e1dkNIQqHSJxki7La6SY5k8fzKSLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793031133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ycmooINHiCUBXKcsH9mP6G/KjVcguXUhbnVJK6FzmhA=;
	b=INwy9C6maVKJQLxKD1HarSUHqjSqNzV46rk7B/Q/eXOtgchK5pb4qqAJm1B8gDhuJjip
	 8EZxFt1O2PCJbGJGwtpTZeuuIrI94xM218vtz8OZJsp9x2JaoYPh1P02NzZjuieLLgpHV
	 Iv0gA4tjvDQPZeLTiNu+SrbM8NBh7i5Ktc1BcTn9nrsUdAo2ebwBXovhiklqIYw3tiLWZ
	 BlrYwUaqKhvL7LFbynTsZdDyhuprsbhCGYEu70q9sWMImBdYMcwhWK5G2npmY1glmTKA3
	 C5Y9cc5yhMvZiDH2cWhirhHM7NFhc4ISWFn8AlRgzbeu6nUUaKjqt7oO8GaPuNNGHsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fcDEmWvp;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF08F606A326
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 16:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF08F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fcDEmWvp
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48b042c0759so1798822f8f.2
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793031131; x=1793635931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ycmooINHiCUBXKcsH9mP6G/KjVcguXUhbnVJK6FzmhA=;
        b=fcDEmWvpYL2TRLOVT4tkHqk5itMssdsYdFhyz/HjqSlzi4o6vTSpT4Aw5ufrc8Ndeo
         WPhT6zaeePVkBuBMK3vJSKisL0XQXDUw0oTW+/rkt4ZbN4/ELpEmFF7deB0exSqqfdrA
         0vTpr/xgvTMHfJxWl9cGxk4trr/QGylKzOkgAnTnkAwdSILoyaWxXYNgZl9HG6hwHCAC
         HnO4jOOSXvsCmqWETW0+CybIUpYKv9OYEmTxoVzAqAjF+YaNeoxYW/2nU1xofNPqR3G1
         SsZN8+Nq53MVX5KQv0adziIvqWwX8N7X8vpsQzgRNKQR1/uYqqsLKySoLTrAPI3Mdl0l
         NvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793031131; x=1793635931;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycmooINHiCUBXKcsH9mP6G/KjVcguXUhbnVJK6FzmhA=;
        b=UMxvN5nXNFMxDMzUFP1MZru2vqoCadlgr+C8/W8iVLTw90qtg2TVujMxp1VxrCIl8O
         U8LmFpKnWf80lN3IGrt7Y/Sv2ZRWnaEzGrFsGli1XS+WP+21w9j41TCZ9sPFoNi3oqu1
         mXt0WB4Y0XAUsTvLEPonPQVR+zDTc0ul2XVf93cu7urMYhOGyJ1YL3mbOgWqpXaQAWBu
         +bJl7NXDwrswCjBzg3Y0+B9aUvIrv2ofx3I2NWrN3wAxNpQE5IQtpeL2gQbhdBI+9RNe
         23ZYaxlb5Vi0nhrFxXXRMuyqYHCE0RWuQ8l/rXn1ING8vLelxxhqOuh+Xxj4O8r2KdmA
         9GBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwf4tWKoLXeuhDmDyyBxmylFCtUoCz/xhIRf0vdGDg7BPALWcdqzlvOHVXDTPw+u5Hqxro=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTyPBm718vqgAW99nZqMijQIRdjDd/MQrGmvK6X6hwQXSCj15W
	qS69m3ByNk6GK/DPWizSbf0K81roIx1rROmdeQr+wrTP7WJF40PPJgLPD2jeoF3bTNk=
X-Gm-Gg: AYBFou0uGbG4+orUJRBQYKdS04RTm9HQsOgLK+RlY3Ih8DHqUz1hhJjGupqeHw8kbda
	NTAOvmSbpLtejcDaxfXdc7vqcS7m8mPLK49RxAG8PxfWOB70cskqwgENWGnM+5Bk/V37aikdHfq
	1yB/uLY7eE2NkgQA8dLAZ/m6wUEKYcQkOJcNJnve2GtdsiF2lHc9yUYDoVhC8YaEy2FBx3ky+lb
	EUbWKPZNChzaPXUKgC6l9JiqIEDGTeZoufCZOJt6UQqkjBNwkUMhLlYWZhBb96pj3WoMxf0wFzi
	UMQ+ABG0tzLwvCQcTktxItcUzraXr/mtT2VoQnlM38ZjXRExVE6FvpayjcwJP7F5AQZM2igPTGU
	rB3f4c7nhs59BM1Yrvn0ag8/u37+KKzcuPExDjAESEMIMrb0buAvsgrJezYs6gcqD0TZEZ1A5Pt
	wAn1K0IjK2pcI8W5H/R4/2h6z8WbE4MnCkZnYDBCrurWJQIbwrQrOY2+oowlpsDiM631u5fDmNp
	VXR+j8ZEvTkD+rt++5Pa9LHRGmTv55XG0OADQSMG1YyY33ofPe0Aoe3r+mcmYpG3wrb8LZR+Tcs
X-Received: by 2002:a05:6000:481b:b0:48e:82f:48fc with SMTP id ffacd0b85a97d-48e3eb971ccmr15551944f8f.31.1793031131222;
        Mon, 26 Oct 2026 09:12:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48e0sm17884944f8f.38.2026.10.26.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:12:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 631EF5F7FF;
	Mon, 26 Oct 2026 16:12:09 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
  kvm@vger.kernel.org,  Troy Lee <leetroy@gmail.com>,  Hao Wu
 <wuhaotsh@google.com>,  Kane Chen <kane_chen@aspeedtech.com>,  Mohamed
 Mediouni <mohamed@unpredictable.fr>,  Steven Lee
 <steven_lee@aspeedtech.com>,  Joel Stanley <joel@jms.id.au>,  Jamin Lin
 <jamin_lin@aspeedtech.com>,  Pedro Barbuda <pbarbuda@microsoft.com>,
  Paolo Bonzini <pbonzini@redhat.com>,  Tyrone Ting <kfting@nuvoton.com>,
  Andrew Jeffery <andrew@codeconstruct.com.au>,  qemu-arm@nongnu.org,
  Alexander Graf <agraf@csgraf.de>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,
  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v9 6/7] target/arm: enable WFE sleeping for A-profile
In-Reply-To: <ae52ca61-b178-48bc-a456-27c6f3393b13@redhat.com> (Thomas Huth's
	message of "Mon, 26 Oct 2026 16:53:43 +0100")
References: <20260624103049.884930-1-alex.bennee@linaro.org>
	<20260624103049.884930-7-alex.bennee@linaro.org>
	<ae52ca61-b178-48bc-a456-27c6f3393b13@redhat.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Mon, 26 Oct 2026 16:12:09 +0000
Message-ID: <87se1s4f1i.fsf@draig.linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Huth <thuth@redhat.com> writes:

> On 24/06/2026 12.30, Alex Benn=C3=A9e wrote:
>> To enable full architectural behaviour for A-profile we need to do a
>> number of things:
>>    - add support for the event stream to wake things up
>>    - add support for potential trap on sleep
>>    - handle the global monitor's interactions with WFE
>>    - remove the M-profile specific gates
>  Hi Alex,
>
> this patch broke the test_arm_quanta_gsj test in
> tests/functional/arm/test_quanta_gsj.py. The test is not run by
> default, so nobody noticed. But if you run it like this:
>
>  QEMU_TEST_ALLOW_SLOW=3D1 QEMU_TEST_QEMU_BINARY=3D./qemu-system-arm ./run=
 \
>   ~/devel/qemu/tests/functional/arm/test_quanta_gsj.py
>
> you'll notice that the test never finishes on the current master
> branch. When switching back to the commit before the "enable WFE"
> patch, the test works fine again and finishes within a minute or two
> here.
>
> Could you please have a look when you've got some spare time?

It works on my current dev tree, probably because I have:

  Message-ID: <20261012134840.1051969-1-alex.bennee@linaro.org>
  Date: Mon, 12 Oct 2026 14:48:40 +0100
  Subject: [RFC PATCH] target/arm: hold bql when SEV sets the event_register
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

which needs a light re-spin when I have some spare time (sorry it's
review season so I'm trying to get them all done by EoTM).

>
>  Thanks,
>   Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
