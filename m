Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795043136;
	b=4BM2DHPSnUVp9w5p0ZL8qX9bWtjjLzzqYx6oOPE6WWot/f/nfqbBTt5T1mXn2AP+/lWP
	 aZ1Q9X8V8pbP3cb92Zo4opyh0yGxuKQ8jx3bUkHIFFM4cwepiNhzMrjVn48/w2rUDlcZj
	 M23j/+TjQ4qSsVhh2BsRlR3rvS47omeygSzsS/A7viacX4jf+bvk2YX9oGuTLSL/XZcMP
	 qukmKfGqxLKk3mq8iTtcOCpj7hQpTu+MNllVvo3DenfvkWTYWPwraEkYStjwlmloWmH1+
	 A2wINSuPbVLdLMrT2m8JUTfvug5k58FMx47GWEcEthn4vuRmqkzM+irv/I6X4N+wB7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vCTbNVFwomUfL+eJ/r9dTAbaG7zQETK5dcr4yzGJzlY=;
	b=KGrkyDgoo1KuSyxaS1RzNtVlrySrNK/PE6jJZdLgNmHwQfeaWePRe17ujUDEh3sRasFO
	 Ujn/jaUo2OmU9I4KlHMrT6SQWvIBI4web07VFSnpY8/2+lu+Orh+nMO7gl8K8c/UGwgrQ
	 NrNYDWCkZlsW/ag0CMeObO2OjDWEZGB2iw8fGqB5NcEpo3hBA03n6cOMud+jzzhrw2JgD
	 gRF5VMcO9iVlEaYgsQHRNCqhsZPkktmmAiRN1rIW1RnVIMQrSOpS1Rn3PJpo3l9FCioYC
	 1h2gorUvLpbYSMjOUy55nbMyTOjx/FY8fB2Ni5tBlO/KN0ACEnN4ExWcfUMeiotncMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GOh2VdA7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670AA606A325
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 23:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 670AA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GOh2VdA7
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso5806a12.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 15:05:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795043134; cv=none;
        d=google.com; s=arc-20260327;
        b=a6bWcZcwts4YviB7jZj2hV1VE3L6DZmhOPmISxaqsW0xuYHR8YYyGnsix3bps97zlW
         anYRjn3tdJ23MUqqtukzH6ovfix3cGNNjkup6qbU5pBnXKenTv+KSgIbRbLPwAlmqpez
         g75f2yTzmyNTRADSY9nuiWu+MJxRZ5dPJpq0/Luk4QcZBglev3/cOhhNQuuVD3rIvYA9
         RToQOT7VerdKfx+ce7qD9v/0KN6zqA5nZJx2noSbQ2STZ8rG2VarE8Z4INl2ej8p1HjN
         tIfQD5M40W0S8o9Tj09QrZtpGpGJYZqcZRfGfKqYNaFyDGeVkhsy/jDxSghQICSeLKDO
         0MiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vCTbNVFwomUfL+eJ/r9dTAbaG7zQETK5dcr4yzGJzlY=;
        fh=qjtJS0XlpVBmmYTGHj4KWDJMY+CRvHLQuea+VLOzxTw=;
        b=VhtK4R9ozn8186TBXs7dayRQDEzgl/dg2qxVmY3hNyw2zZbsPRzlmjb1b0WIsMFjg7
         IUnTV5jf6oSaxf13czJc7xdXoJxAjuEEKR+4ifey1a2ZEWoRt9TPTxIMAYeEzRxwWl97
         ekLtyuC2osBIbQzffrxqUuKPBC3HWNzQjGKGi6YMPMtRTF/TqnxsMqcN1hPy/UT5+ZPG
         bfjTiVj+rJaZkFbOYjE3/sLGPddsJ/hLwzEL6ohV2nKaT1z4njcDG2gMz1+mYv7bFI4e
         wDfQQI7hz+u+DDl7WMGcP5loaDNmxc4zmlscB0U2oIUaN7AqaQ1gixlBXEYZTeMKdmZa
         W/BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795043134; x=1795647934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vCTbNVFwomUfL+eJ/r9dTAbaG7zQETK5dcr4yzGJzlY=;
        b=GOh2VdA7pX+eHuSnndG6XSsqBaH6971axHD5KjJBGKakl4wIINBs9QqMdI61sc1QjR
         ZpRYMJmz44N1EEK3CYhslQdaq6cEwLIh26/7Kg5CrQwRo+QIdH3hphuHhB5v4JTAr2bo
         sZCtZhUSBc33ZHRuuNljdr8c8OH5kIxriv7vEQe25fY1IcnE1yU6hEpJMRz1odPQix4g
         esUE0KCKQEuFVsJeQiYqG7UCyGJEyG7zMWEV+Tw+u6YN5DDdq8af/tvGpP50e+Ys6j2G
         /qcmO1ZoJFD9nk7sY8CBWP2qeQO2JnDDPdU9nGP51J8HoVerghxHSCiz4FOTE+NF1lkf
         Ty4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795043134; x=1795647934;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vCTbNVFwomUfL+eJ/r9dTAbaG7zQETK5dcr4yzGJzlY=;
        b=HZzlpPnMd3++AFGaXyFvHrso3w8dyoQUHwrNb7WNJT4lN8sZgJL+GUu1uVkxw28gYh
         +MvsUG6qbASP1dcoK1cxig4ccPuVGZVfnijx9iTQ3iHCuYPwp64fALWFZRPwY5eIiw0u
         RkK3wCjSVZHjWb+3m0EH3/T2L+ipCz5nAMehsXqN7l2NhIryXWgtu6xq8b1z6D2Hu2+E
         vCwFDSOuuOoGNimh41xqrUWCvQ2uzY8KtMOJJ/8yGUR4S7CFIM9ieLUMT+KpkWSsIDlE
         vpk1IanHk8TElQXhS9a9gTA9edGzbJvatLblt1iIB2wSKwV62PxRT7fYrFbkjY779IAM
         Y3YQ==
X-Forwarded-Encrypted: i=1; AL+hErH2A8f5ibvuwfiVMzag4BlDrN5eV6TaImKkqf9MjOmZ/lNosDXLbMaCLxj7p1Fw685gZCo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YhJMHP7bC43DyLG0iKTCq51GfJKqKxrQVlqW4kM2nLCsd5KPE
	0whIu6+GZrz73f5ukpoxb3aoPKt3ty6YcTyWTI2D0Vw5Uzsx1qasfxO5qwu7xRImHCzYk00c9Hx
	s7z9MOARWa7aIUGzq6xP6i4EyiScXL6fKBfmAWcdW
X-Gm-Gg: AYBFou3JUmjGeP4iUr7gJYjv4Fxdl4yaWMeHbUH1MbfC5IUaR4AIlzmw4TVOvyATp15
	0SArPRnymex502CNpElXDwiaCQaBu2cfxqm1/NZFV5hY50nfUf30PK5kogasOVydv9wZkL65mxc
	315lVrMZ2H3JDwrgwXKgxGDvtilsIfswrzwQiVBhpSyvhYN82zKLKhOmdtECp92ps6X87olB7IZ
	8okS3Zn/SEbruJoh8dh4V/vgrjfUc34kqQ3w5p8PC1Imh22wRZcaD53AJXouvWPHZHaUo5VFSrw
	0geDyi8wIRikxz4D3n/Z91x/wyYhw3k/RXu++wrApP37ZFCm2AaCFdZwEkH5VdwmvII5XZnQRu5
	R6vnuPy1cE9XGy4srDtrlCgkd/AUGMeZZpqY/ENc8Dl02SYpYGjrMKtlv6hj0oIPq6CAzgFK+Gv
	2TJmriEdXrZaZXT57zL7MEnyWodLV6jb2iWRXU6yRYJQAlrySJjVJJyA==
X-Received: by 2002:aa7:c4ec:0:b0:6b1:aa31:a627 with SMTP id
 4fb4d7f45d1cf-6ba03730308mr28151a12.4.1795043133405; Wed, 18 Nov 2026
 15:05:33 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117180310.921701-1-chang.seok.bae@intel.com> <20261117180310.921701-15-chang.seok.bae@intel.com>
In-Reply-To: <20261117180310.921701-15-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 18 Nov 2026 15:05:19 -0800
X-Gm-Features: AclHuK-SYB8IAK6eB4nGogyFLTmyTBaFT6vPSQiVW5NZq17xLmZCqU7xs_dCPY8
Message-ID: <CALMp9eTMywUdKiOwUwSw4Dg8Fgy9ZoRamthQatj_2ZqiERQfFg@mail.gmail.com>
Subject: Re: [PATCH v9 14/20] KVM: x86: Document EVEX-prefix not implemented
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:32=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
>
> The opcode is already marked as not implemented. Add a comment for clarit=
y.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
