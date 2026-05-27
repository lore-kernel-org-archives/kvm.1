Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D93CF95C
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 23:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926202; cv=none; b=ofWP0n0iLRFLK2pn38uLO1oIgQadjPZTqeLO3t7YJKYWeUj+MrNXnKcfd+xysISy/v80klYOtTrVwdnEB0w87FSRQcDNagQPC6HmyG9ByKrrtSr0RC7DQfaiYT1JYbrle5W3i1CwUp0YXlnNimsfsoUAOpgCwbEKoaIjmW/ZeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926202; c=relaxed/simple;
	bh=IIGyIA5SMBOmRdTG1ICC6Afj4/YKatDOg/BX1uRLj6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bE05ivhAti0zoWSbmNBB71h80zctBvDYB9MlqNnyMNYnKFRdEPzxTKDHw3Yky1LjYL00zB4aD8YvDqsCfNmNFXDMa/pZ20xLLDt9O8plzxmtjPoKGnTe4+HLoM1LPNtRgWW3qsPi6DjhhuLioPw6A3UGaLVI1fNFA48H0Ofnesw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+8Pyex6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+8Pyex6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CED1F00A3E
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 23:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779926201;
	bh=OmlKhgvwTL2etY+rJvxlx4RYl9yYL5ZQkRItvL8bbjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=S+8Pyex6vadOoLdHeWwUYeb1VQHlRdPLdS7Vulxs5wLB7n1XwWKbZH4nUJ5KiincU
	 thXOxMVh9LOxV0J/A2w5zDRFenxT1lzVkxVL+hN15gPAiiZZJ/PW+bqW7v7EZD18Vq
	 L7V6soZCORShU89G1zdUE0QnxR23gOxiwvYTr/WkA/ZKyS5mgCEHgtZ1ulknUNfNQf
	 7gIyuPv4BW+4zoRMhsOk9Ha6LkRVT3MDOdS8K4+DqtDWzktCS7Q7WOvFPGh1ETmh1W
	 KrczozpYi1mJ0Lrn6LPahvqxwN8DuGPJEMet5p/IjnKGGRxjcBpJsECnTkdnn68liK
	 ear4RDjpymKjQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bdbac72ac1fso1319420066b.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 16:56:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8MgwabnVfOdVY4t027D1Iv3VyE5+/lec1l2n2YPUpLbN0pxQR0ZUyv6bD2fNsBlse+CmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmurUnigOzrx8//qm3351WEUIJC5eVzuX3NxA3MnhEFP1MZvSV
	FtcvjBT4H8vulNsReCFkwY+ai2Aq7m+sJjPWfF17spWiCXYE5+mxWiY/i7XpoDbMnEJlXrtJfNt
	3MPR3Lcl8kcvzYPIX218hlpQtGLvUM2c=
X-Received: by 2002:a17:906:cc0d:b0:be4:4126:aa97 with SMTP id
 a640c23a62f3a-be44126ab27mr234537666b.46.1779926199900; Wed, 27 May 2026
 16:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527180417.4119289-1-seanjc@google.com> <CAO9r8zNrz3U18hGOj9MAd46X-OHYzs9-QebH=D1TRp=wcHmk=A@mail.gmail.com>
In-Reply-To: <CAO9r8zNrz3U18hGOj9MAd46X-OHYzs9-QebH=D1TRp=wcHmk=A@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 27 May 2026 16:56:28 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOLxAmtkGD0_pQdbikDR+jL2jaAgOY_nooyY+S_mOoo+Q@mail.gmail.com>
X-Gm-Features: AVHnY4KMzpcVg3Amj5kOqkYnrlx1cTU8MRnz8xKZlgxNf1of2PcoZSIuy6VtAdA
Message-ID: <CAO9r8zOLxAmtkGD0_pQdbikDR+jL2jaAgOY_nooyY+S_mOoo+Q@mail.gmail.com>
Subject: Re: [kvm-unit-tests GIT PULL] x86: random smattering of changes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > ----------------------------------------------------------------
> > Isaku Yamahata (2):
> >       x86: Replace NOP with CPUID after WRMSR(TSCDEADLINE) to serialize deadline timer
> >       x86: tscdeadline_latency: Remove unnecessary nop
> >
> > Jim Mattson (1):
> >       x86: nVMX: Add retry loop to advanced RTM debugging subtest
> >
> > Kevin Cheng (2):
> >       x86/svm: Add missing svm intercepts
> >       x86/svm: Add unsupported instruction intercept test
>
> Any reason not to include this series:
> https://lore.kernel.org/kvm/20260312200308.3089379-1-chengkev@google.com/?

Also this (but less importantly):
https://lore.kernel.org/kvm/20260317225327.4068448-1-yosry@kernel.org/.
