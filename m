Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D373B52FE
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286879; cv=pass; b=aeykwOKIo7HIXLp9H/1le0SA6klO0afGevgm2onKxCkq6rk0OST8EIDwgOFGBb9QbZCDnfzE1xEgtMsq0kJXNfTqBW1ykqoOZP4GVH2rc4QXi6oS+PPLWkeq2drlVv5nYfpFwMOMXDXKk5UR0QBew8TKHScxMuOHeucguWrA+hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286879; c=relaxed/simple;
	bh=JTBmSQoVH8zPHdxZjmbwpaK4P3gXmekiNNFmfdfC8zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8QUwBxmIi4eoGtGCju1gp6VQzULIcHSe8qMl7hmbrrsKHqgKdOVUHDiP9+vI2678IjGgl/xVu/pnC9fCKkuSGNm2CVnbF5a67m9d9Qo0V5RhjvmUfiEkHOKI3qXm1x2E01DDFV598l2nGdHpFu3lsl6KE+i0lkcx9gFawRNDqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H+L0d7vy; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+L0d7vy"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651d692e833so10222246d50.3
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 03:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777286877; cv=none;
        d=google.com; s=arc-20240605;
        b=Bn9hSQZbIa8Pr1vhDy5BKFdexgyzegnNmcLjxvOIlTRbcabOMUBFwnwEpUBS7AW6Ph
         FUc5tu/2PMemK0+Lup9ev76LrJZx2zsb0T8pVC48NIms7lFpvgYSMnnhgDJc5C3k9Zx2
         PjKPFUGpL2IKnH5svjgLd4RPU2xsPm2RPqkO5HOWv0JvE8h48i8zVaJ5z8yyFkNXoPQa
         jAcYzbKTyWb6NH6mBL8NTpIwK2Wds00NmwCAf2l0ZJTqfH0bcHOdOIYY9QgCLv4irME+
         eiJB2dxOW99DW0zAM2b1vNEbjoyH35CbjwBsJYazljXE8KYFvuQWx9HpzhiHSSy5JZwt
         PicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z0t2lMK8mMOQqjFYJtMIq0BWSHEnCJiR8+4AnCrJmw0=;
        fh=t+Jbjg9Te0HEAK2Cx1pnKgWS+tR6BZZ3lUahT4B4nQc=;
        b=FLJLKwGiOz+edN1emQ2ucssJyMjHnKfEwwor5eBuIyYx4HUoyPkFuV8Q03rNIIsL4O
         dTxQiPrwrF72z4ODD30Ju44XUv2tcVPk+TSPyvCcmWh8Ry2+OLuygy0ms+rBHUiztVgY
         w0HSom/0BKoONW7ULIY+0iW+DPI4ZDza+ZoqMXYI5dTzDcVRlAWVk6w33Xd+YXMxYvY7
         U8sByM9vLvkaDGgDglnlVA84JUPhRvg9V2Nfbqjws17DuScT0RL6j+gL1KnCkN1pOeSG
         epG06XYifLL2xPqDshMG4mvQxrxlZkPJVsQ0pcf9g3NuUA4566KchYEQ4noXUPEUyka2
         zybA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777286877; x=1777891677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0t2lMK8mMOQqjFYJtMIq0BWSHEnCJiR8+4AnCrJmw0=;
        b=H+L0d7vyQLTwkJGMunCFTtXWPvel2yU0NEKuynPQfAjyDBnDFVbYXsLgTqpQyQtUY1
         z50hpIYB0WsSBVCNRlVmsUl+/NwW2Qlrgrzg8JEuUkuK5UEL9hjNpFB8zSkagrl9Zqjc
         xf42r6zF9nV0he9xVZAUjKosKwfdzvLLlEybHRwY7lOGfsmrqSZgq6mSYgz1S2Yh0Oe9
         vAf/E1UFHnOLRPH+3NulcQOvqjbuGxnUH6TtQmPVuogsTFgvTCwlRKReBRBCMWanOe8i
         gkL83eG8ZpROIiifWMaFrcY3g8jM32BKngWkIBLQLGicbcwOlk0P+DFkJUAOf03YErZB
         Q21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286877; x=1777891677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z0t2lMK8mMOQqjFYJtMIq0BWSHEnCJiR8+4AnCrJmw0=;
        b=f21/H2utdcSh5XORlyXav57bLT7MFM35rZo8DoqnOwiF/7vm2ZjZk6EBxGMQANPFlS
         0bWFhvBQIYqqmFXFnmjajwvcdXCQLsP19xk8IyQq4BccuMw1dZTBqbBTdwtJGw4XFifX
         WYWRgSP0WUFRX/+1mmq+URF4IBw3z5Qw1FxO0b3tzxTt5/DtEluhBRFRpnFm9uuEh8k/
         u1NH01PoVVvcOMdUZn/z93U8rMLCuwBGAgxJO6DFO2jDlrkxbWTEJwQ43Y9tJg/Zc/WL
         jSjyZA1wZU+b4nyZDWHZIRkbZDzS1vV6XOk+6VRFTkIENz/4Egr5hIFliXciVm5DxMtL
         V+5Q==
X-Forwarded-Encrypted: i=1; AFNElJ904cZ3wA+tAI1LNZ3Rp7gcTqMqs58RP/ro6skzeZ8lCZ0eqQNxuuNAO91OTcGjukuUBok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTts8YuMgIW2vAbl8wPZhYWUmte9OU6itzpjSB0sCVovKjP4zk
	/ERff+/InELX3SblpGjNxjVMCcAiwvGo/wz7Q0NTM9SBQRTUMncYx/QvNnkMGU6tZziv3BSLrIy
	7dpsfbQ73KJTbocGaaJ0CiWSXfX35ek8li+G7wESwsg==
X-Gm-Gg: AeBDies+uPF4+ddoNnEIuhtc2LhqzUML6mwzTpfoZxHqXNupWOuDNIFZANwA6iiU+Jj
	vHeVLrk8JVDQ31UyZLSQ9yvwuhw46y7BhHble2L34y7HqM3+E6EdmG5EedfFO9oHOYp1COdU7v0
	xC2B79/rrWDFuQuKLaIAesYSD8d+iZ2cUBavCYWSHBQ0iQb7NqmjMz1VPy6ZjbMt2BvTy9W3PvZ
	k3Rrxw6uWjitwwmhOI6r2aNzULMi/N2pTl+xYAfalj8FGERP87FmWGiEDXSi+OvMAeSQVwQwYCi
	W8swY3r4ScMRQxek16QdIHW3x7zyuqBwSl3i3l5043g/IBeAz8wD2mUO/hJIxzs0VW1KrjT6eMx
	SuAAP0s9Md6mn
X-Received: by 2002:a05:690e:1905:b0:657:1da9:7b36 with SMTP id
 956f58d0204a3-6571da98231mr10668146d50.17.1777286876891; Mon, 27 Apr 2026
 03:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422125250.1303100-1-alex.bennee@linaro.org> <87y0ic43v1.fsf@draig.linaro.org>
In-Reply-To: <87y0ic43v1.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 11:47:44 +0100
X-Gm-Features: AQROBzAuWfBl6vKMDHcIkxAyChVzQ7RDQMDZuaOHzbl4_ymulHU4IgwrU8kBqe4
Message-ID: <CAFEAcA_R-B7QHzSPmR+qhdn_ZRj=hx45Z4WrWaDmjnOpPn=b7w@mail.gmail.com>
Subject: Re: [PATCH v3 00/32] target/arm: fully model WFxT instructions for A-profile
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>, 
	Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Apr 2026 at 19:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > This series fully models the behaviour of WFxT instructions. We
> > already had support for WFE for M-profile but we left off A-profile as
> > it has more potential sources of wake-ups. The main one is the event
> > stream which includes events from significant bits of the timer
> > ticking over.
> >
> > The series starts with some refactoring of the syndrome register
> > helpers to use registerfields. We then expand the WFIT trap handling
> > to report the register used. We then implement the event stream events
> > for SEV, global monitor and the timer related ones before enabling WFE
> > for A-profile and then finally WFET.
> >
> > Note on AI usage. As an experiment I previously posted an RFC series
> > with the help of Gemini. This series however is a ground up
> > re-implementation which takes some different approaches on modelling
> > the event stream. In particular rather than running multiple timers we
> > use the same wxft timer and just compute if the timeout or timer event
> > will come first.
> >
> > v2
> >   - I've kept the tests separate, see:
> >
> >     Message-ID: <20260417164328.1009132-1-alex.bennee@linaro.org>
> >     Date: Fri, 17 Apr 2026 17:43:20 +0100
> >     Subject: [PATCH 0/7] tests/tcg: more capabilities for aarch64-softm=
mu tests
> >     From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.=
org>
> >
> >   - tweaks to global monitor behaviour
> >   - STLR/STL will also trigger events to avoid deadlocks
> >   - see under the --- in the patches for details
> >
> > v3
> >   - fixed the WFE exception handling
> >
> > Alex.
> >
> > Alex Benn=C3=A9e (32):
> >   target/arm: migrate basic syndrome helpers to registerfields
> >   target/arm: migrate system/cp trap syndromes to registerfields
> >   target/arm: migrate FP/SIMD trap syndromes to registerfields
> >   target/arm: migrate eret trap syndromes to registerfields
> >   target/arm: migrate SME trap syndromes to registerfields
> >   target/arm: migrate PAC trap syndromes to registerfields
> >   target/arm: migrate BTI trap syndromes to registerfields
> >   target/arm: migrate BXJ trap syndromes to registerfields
> >   target/arm: migrate Granule Protection traps to registerfields
> >   target/arm: migrate fault syndromes to registerfields
> >   target/arm: migrate debug syndromes to registerfields
> >   target/arm: migrate wfx syndromes to registerfields
> >   target/arm: migrate gcs syndromes to registerfields
> >   target/arm: migrate memory op syndromes to registerfields
> >   target/arm: migrate check_hcr_el2_trap to use syndrome helper
> >   target/arm: use syndrome helpers in arm_cpu_do_interrupt_aarch32_hyp
> >   target/arm: use syndrome helpers to set SAME_EL EC bit
> >   target/arm: make whpx use syndrome helpers for decode
> >   target/arm: make hvf use syndrome helpers for decode
> >   target/arm: use syndrome helpers in merge_syn_data_abort
> >   target/arm: use syndrome helpers to query VNCR bit
> >   target/arm: remove old syndrome defines
> >   target/arm: report register in WFIT syndromes
>
> Peter,
>
> Do you think you could take the patches up to here so I don't need to
> hold the re-factoring patches in the tree?

Sure; applied 1-23 to target-arm.next.

-- PMM
