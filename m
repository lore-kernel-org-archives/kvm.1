Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E230C63B
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621152; cv=pass; b=S0/b2/unRbIvqwniSuMBsYbb9XYxzexRbzlrt614PeesAcio12dFu/LDF6dkHNu/bqN6Kn0xK5HtROBdV00eItW/V82R/Y3jLlbcsjRWg3pSORGdmwzGBVQY4BM+jCupuOpzF2oFncnPs2atG1Vnia0WykH0EAQVNMStr/K3aJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621152; c=relaxed/simple;
	bh=H05pu1oph6i20zdQPmfFwuNamYsmz88n81AK/YEWkBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfy1nDesNaLHoYUHBx9ycXdDVFfWJxdeDaarN7IXTSJJfE4aMk3i9VhF6Obt9hhZ2TSeDNaME1ZcNDlHLXevROQ30et1wfxvkMOJ5U8T2P8/sDMw0s4qkTsYh8vGbWWC2Zk4GlJW1rc/yQzfBsSY4telbeosr1oQKpI6k8DKm5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZZZ9lgRA; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZZ9lgRA"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64ae222d978so2211507d50.1
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 07:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621150; cv=none;
        d=google.com; s=arc-20240605;
        b=LPMZ6/olG9KEAwe6qtbX5d0maOdP9Bi5uikIbyq1dtvDs1KcnotYuIkeMtQojSArXt
         Qtn69wdPkcDPLSbStYUIM/2PgMecszqrd6P+64KftYUoDJLuxMMY2h50ReRZUfAYxiiQ
         wuF5L6rjx57qap8PqojqixVC0ZEI/BTNFaZs9W+ML4X8nzxvu7JERF/axnZuP69BMAjB
         Or6k2kItspuqasRwldDvXwd5QtIouNyqZkVSyWxY4d9qjHw0uk0LWChcA2UyAERE8ZOg
         dMCJSZOnj+uwWbvU1RtCD+0VZf79G4j8AEV5ea+IJkeZVzX3uipXiQA7Cx2K8y6HN7VQ
         wpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
        fh=dN/WU75V64dwpXo2/xj+an8CRJeV2Jy7tjZpdn2dpFI=;
        b=EOFL2lHs20pStUQKZ3guhT/kxFu5oihI8GwMOrI8K5zzER/gnRl+tnjYe0k8zbE5Vh
         wXgQbB2DSnh745PX0XTGr9JFUWLNqbY+m3d2+18PXQ83+2LvAI+BWdwC4Fw7DYaHCwC7
         32sP4c4ju26J4u2p/KXKjvoCiln6S5xkeDDkJCkVFClL5FkMqSLhUQ7axLI8RGGVpCnk
         M+jSchQ7jfOiy/YCvvnY05P6knnkH762FvIKDdUft0oUt1qb6wyAqfQ+/zYUJkO0hYNi
         s5NdwKngdmG02M1htUoFjUwcKLHiJ1Oym4dwYGTEnvyBerPRcHPgBhZ1mOphshDNvDS9
         Bldg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774621150; x=1775225950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
        b=ZZZ9lgRAZxHYCDECYbyPeSiPJmi4s4CeOGMmCmw69KZlX6W56zSYr9fwVcDrY18S59
         TBaHZ+YDQwqpJcrB3S3dFEJbG59nBPABOyfSPkd2Nqgt/AcwzAXbrrDaT8IOXdmpoQJh
         Id9Ds+H52VGf29w4KUW/itJ1LrfJ7wPwDetdrUO4WmStR60l3G35ceyDCnjyE+1ie421
         Ng8/gP2gCYyv0dkj05Gpg11UA/Vm67jRJwalAjV6/sbzfJ68pdIuEbK5GZBikR2w/Hdf
         8FU/e5MgQahtKupgb91nQEekLouqq1P5liTT52KR/IpdRqzmdigISYlQJsgoGn6PfYas
         /b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621150; x=1775225950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
        b=ASKGM8uYdSSNRQS8Aw/fLx9KoNf76C2JbIHmnQSkdLQj+rpdOpV21j9u/fR4OaSUeZ
         ZEDJmHxuh1i31mOwxYB5hMsCCGpCz8eyXZMY/wXNgqjYx/fOOjYxf4yRkyqYRI37V98m
         rQNFWBkqAWnQRJEb7qcRZoPue6flXwiy6xA3GhSRzhjs38neldcKIIfkekky0XItwCj2
         55o15O2HpwHnWSS7dpS6E43vM+dka8tkUvetAfQh77pvn3Cn2p0Ncn3A8JAajL1fM8C/
         EOln2Ha7bACskhfkK/W1njjy49zu9x0fBv/q/XwehuqELl5UrK2VoawMMZXEGipGi2YR
         Rjfg==
X-Forwarded-Encrypted: i=1; AJvYcCWOX1TPK9aPIQbCQDJx1CqxJYX6TyAZu6JeZF60dfBvyepMeXKPeAdbmkUmFLJ/v81RYm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAaH5MoVoigPCJ++e6mYS+UUAthTA6/+499O1epqZ2105tJk42
	ZayYhKiKv2AvUPfVbssVYH3XWi6SpwsfhjUMfRGMsUSLvMTk/LwbaZT0CIb4vXAHiA7ZcJfKLiX
	8QnypXruFK8RY8P3aYF5o7v5bYLXsOrNfL0CCiOVUiQ==
X-Gm-Gg: ATEYQzzrgBRO4I7L9jSerYspjI8OPTDWTnkh1/08affJaOc9Gjsy4wIPRbcOSvYVCt0
	zvQCerVhNqGZN0R9/oBG5JL3jIpmcangLdWvrQHowUiV1AGTttV7M9jdfB67di7RqaJSe0r0k6c
	szVb3sPLmj8rMQvlupPQjRFN/20XQ9KHgyhHO5eR+eswC54h7lzuOBbAgHSdrn0wPmeu2P8yFuN
	S+rpDJ4uC9ZVxuWz8HQVhzRnPxXEWmNTPEwoxARhlp5T0j65JctGQuS9uum9nsLpdyxlqRNNYAh
	j7i0tegL+bwxM/mehzz1lBmDL3sVJQHAKo29FxJE5mmWNXE25eH1L+Tua6c1CRGyCKI=
X-Received: by 2002:a05:690e:484d:b0:64e:a215:11de with SMTP id
 956f58d0204a3-64ff71af9ccmr2449912d50.15.1774621150217; Fri, 27 Mar 2026
 07:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com> <20260327134401.270186-11-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-11-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:18:58 +0000
X-Gm-Features: AQROBzBHLUrurUIL4GpoENhHthPYnPAJkGXERrAC4hbNeIBZKWENmbOHRY_hW5g
Message-ID: <CAFEAcA-v4E0kYu=aebegjaO3wU_en9peLUb5SubLSE1H-EV5TQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] hw/ppc: Use glib2 instead of strcasecmp/strncasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
	qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, 
	Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	=?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 13:45, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
