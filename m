Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794591858;
	b=wOrHGcfHJCHNDeF/Yyvh50A49wZbYIqgupUI4KS9/P6xvHtuM7HEtm5p6CLaYlznhS17
	 lcY28deGYIKySv6NhKQzB+9FccucSeb9+m9LDOvo0nMtZIxSP1FDpRRRRr52g8wJkJT2W
	 Ff5i4aRh4bqTAz7iXLb6wtd0rEHYM+eQ7RrhNJvQjPD7lWQen+3YmD0FLldHNan40J+fU
	 eA1eJsSPQAfBg6uFLfjByFbdEMaW6IiPhNtME6bH3hBWTeAoc5zXx8llgCRhBRzlraULK
	 urq0UzWAiBas40ufSj0ODYHKm8snEr1VUmvXZgOnPhqa1mRX/JAsykrf+YhJ/xBpWCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SIB9b1uyCmmfDdvCfE7RWQ/VLis5GMfKngv4oEqkmjU=;
	b=EtxfodFiH5v6KScRm2wGFOzZeOqJOFRaQmFpObtsv+jy3T/8S+SAp0VRCLFJrikf2+r5
	 QUoSCy5R1ZOmDB86CM/gQBXjisjDHo+gIgnL3tbGe7EtOiIw8jD785BV8SApYGUYFUDwW
	 +YG5FO8Te2unePV9754GKpfBhhgntwnvFCeRuNUrS7cJAUfI1pSkeV7C59Fz0j5N6VetQ
	 eJCWUwCVBluax3fj0HjGJDAywP0uyJ+ll0zdNkeIuYdaCdqj9Vw/9qnAAwE6hou5cKYMN
	 iT2r2BPR48VgwHGOiICL3i3suGnEAiZueFJ/BxdLkCq+xEDVNu15v0I80K+AceZLuig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q2CzksVr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4B606BD0A
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 17:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DE4B606BD0A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q2CzksVr
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso18348a12.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:44:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794591856; cv=none;
        d=google.com; s=arc-20260327;
        b=hOBnBbQ+t7Vv8niW9x0iNpSLtzpijqfX3tb3p81iAHHFNhHcmU2sAos0P3Hu1b66g3
         kSDwAmoE6ijtarbslpjg45TxJPuN8nONtjd8+LIw4Dm+EzjSlBVqT2G1zSfh50g6ttlE
         InsKHukAhMcLp3wBIzHf7KBYfu3KH8ed5clJ4fsP7Fzrk26M2oAAxbvBAI6PN8PjnZrp
         6iv3juFlD/4RGZECvHQw9YDbyFaim16Zh6/MrKRApwmd+Hgu82+QYikHv+WWJUOP9TXd
         oJaD69BgUa7yIgvHdG+nOr2weaogDz00fLWJA/UI1SgJweK0/J2tqoY3qvcuKjWCOZes
         uvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SIB9b1uyCmmfDdvCfE7RWQ/VLis5GMfKngv4oEqkmjU=;
        fh=eiM0QRfeQ8xBkBCjYLOie5DOKoZQQtEeraC9WSj5Yt8=;
        b=k3tpcF1u1q5k2hLHhoPbhG1gLFUHB48FCMP6UQ1QYYE+EMYnKcpyDMft3Ir/LUipxh
         LhnKFIg9KzI9SYSAy6mpA6g2t8vVnwdWV1oM7y66Q/cXHFMN6npfN87K3/oK+aMaZo0c
         dxJRfNLQNkAIx7QNN3IdBRESBAbpSOyYcCqXmRmw/QmOSzBssRbqUX5S+yucs8ePp6gj
         MVeQydz2SGNIrokjVBqIUBW+RZ7et3vtnWmO/xXaMR+hI62G9JbwPCil0l1c7qjIClp3
         1yC/YiEqp5qFAOYUTZ8UUC/dkv5/RY5qJcG/lWEtMCkvXiu4mEt5CBImPyglL+e/3fmw
         E+Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794591856; x=1795196656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SIB9b1uyCmmfDdvCfE7RWQ/VLis5GMfKngv4oEqkmjU=;
        b=Q2CzksVryst1RGFu/7KmGgI6t+qEnVybucMThmJNiHCyzPRECh/XnYsZzFKlMrFtW5
         4Itfc1KqI5MiVE/x7uPcUIqeyYFFO1ay8JsyOsLfWPbOGjiGcHYUeBI/WSqzkdlR9iEL
         bvUD53FTPxf3a395jwQ0Y6W0lnVe8BfcV14xJu8ugM6/Lk1FYx9Iez4+UoiDrLeO6OfI
         STMfSIXOlg935C/asP+dEVcur8S9LIAm4/bk8wa6IErqT0HMyrGQWKtIpt+k7Dw2W5Ui
         cStaQ4MM2NjkqreZhSSR3Gw3dDg4+pdqLEdUZtZbyNVvz/nInFMvVLQT/R5hrzgN3Ygp
         mbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794591856; x=1795196656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SIB9b1uyCmmfDdvCfE7RWQ/VLis5GMfKngv4oEqkmjU=;
        b=FjWlEyL7swxlH0QauMM/ZjVmqioWA+yzNq7EMb+nko83I1kw8ihe5btu03AJNJF1u8
         i/sknGMDDCzu3TJpHhroBxsvOckx2ngCqrO3gXH9K6S3q7dJn49v+T3LHM4FGPXRJnNu
         SkNsAsctMBlurEVlsVtbFvFvI6AAtl+dEVxwOycsggFkRpgysq4uzYDd5Zj7b2RbRn5b
         Hr2yoJuBKkbWa84JnP8MJXvVuC3Cm3PH75K8Ptx0jiebLF0GwJoBwM7vVQLn4TJ+GnUP
         2ttjCbnhYk65d9dRqryGA6cryvixKNx14NB36IfJHubak8RXMCcxanPwkQG6uAE7BjjT
         sTzw==
X-Forwarded-Encrypted: i=1; AL+hErEiW1r0lxr/cXWDBrkwOGExvwiooZfGdebsVBR84qyQWlYpyc/xbnDll7fkOuUUAyxwMUk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+H47NKYF1i9IgUYpXlNmFrWQkwABUkkNEWhGK5EvmDpZbH2xPr
	/QzPSjBMrfjPqioY5lLCDaM91Wl9LdlmWp4n5mybf5ton7BwW7lKu3762fhn9Tgpxf6hwmrsXgC
	5OsckUSjw9QxLK+GsNdWli7TH2ngjgDneCuASYT+YIxSEPzLCqpwSUjcF
X-Gm-Gg: AYBFou3NWN3x9J73LnqyGA82JhRYimVzkyC0UnvJNtME/ps0NZf1KGFbD2Ex98ulCdh
	IN03D5oOHQtMbG4KJQEP4j6NsQWFELGt1red2xnKUKRwvbmAQrXDdEWvGNe//Q7jApqlalIXLeq
	CTANU9GgZqfdYuRT3aCl5LdH+cUhy4cNtuBH+BnGy3lSgRgVbPI77OgwwfNC1Co3v1849Wo5cVI
	5l19Ct9fGD/b+VY6cmbk1XunVs8mav0luglYtJ4Mtgi7LyxvlalxVgdWKY2FQWKlGDtdImft6KB
	2EnKM+pZSavEBqlkfmtWLT1oWpc54zKy4YLmD4oZo/D7srwTdmTjiK0fIzQx1SO/jwTwJEs0LDH
	It3MG13OgBXs0DLEudCs3gJ6408a3ZIzkVn4FeReo75AZ5jWC/psKewsMgVoW81c83D1Qal58
X-Received: by 2002:a05:6402:1650:b0:6b7:7598:67f9 with SMTP id
 4fb4d7f45d1cf-6b7c82ccaa0mr89134a12.8.1794591855386; Fri, 13 Nov 2026
 09:44:15 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113170405.473841-1-seanjc@google.com>
In-Reply-To: <20261113170405.473841-1-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 13 Nov 2026 09:44:02 -0800
X-Gm-Features: AclHuK__kUivciCr_b01NNPoODBlYUhIIdmNR_P1wSgEUvlhvY_vvZCLot-6Q5w
Message-ID: <CALMp9eT5S4N8PEA=F_j3vp35=QwNjzbF1LVsQwAir6=e59tw=A@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Leave nested if loading CR3 fails at the end
 of KVM_SET_NESTED_STATE
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 9:34=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Force the vCPU out of L2 if loading CR3 load at the end of setting nested
> state fails, otherwise KVM will leave the vCPU in a half-baked state, e.g=
.
> with L1's page walker, and if nested NPT is disabled, L1's PGD as well.
>
> Fixes: e1779c2714c3 ("KVM: x86: nSVM: fix potential NULL derefernce on ne=
sted migration")
> Cc: stable@vger.kernel.org
> Reported-by: Stefan Teodorescu <fane@google.com>
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-210535@kernel.org
> Closes: https://lore.kernel.org/all/sashiko-outbox-205939@kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
