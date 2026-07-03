Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52783B14A5
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072791; cv=pass; b=nj7Vr1ovFwA/KtxtfLgR0kZLWta2bV6OCgGtQE7EHvAcvA5kS005I7Gz2hgr/4dHzUAArp/s1B9stScMCt8IWvhQ9d5MTpfsC12mclH52rzrcdA+W5MI3H3W6Pg6K5seqUX9PDifcCTc0l+L0ZFaN5ryi6m7ei889SobmQ8znyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072791; c=relaxed/simple;
	bh=a3P3Tr5cp7+7D8TJqnA3Mjf9GQDMQvB2MGmfRIaPWhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qm6QwW+MaJVZCPQFTWRJIpYlRwSzrw7sUnaQzRtynn66WjmLyYx8SAUkszYAcwkQi3VC0O+ysjlBtHLOZIdtbLVp8tSVbeMQZ7/GrYWViJlw43KhJYxdzpk22eoHKOsXZivDWyLvraM1th5hgjMkBNtwum46045CokQhsnldJzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ybh0EtzN; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ybh0EtzN"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6651bc5730dso572270d50.2
        for <kvm@vger.kernel.org>; Fri, 03 Jul 2026 02:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783072787; cv=none;
        d=google.com; s=arc-20260327;
        b=fioIE0us38aNdH6S97HlQ66FcdOhBOHKqA/fYGw8I8HlY82poh7WOqon4/An3tQPeX
         Kgsm4XMEOHhMkl4Kea+cS//JQ4EOzoPM51OHMV/S7hXOhdKp/qUqzG8Dp2MecpDCyxUC
         REtS2KYpjsOG4aNcgdPrEDiAjgYTknIwQ2ty0mJvl6E9rWwfykO7r3UHfS8tb/g68yVO
         h7Sa0/uRduSCmTp8i/uKAAO+xY1z3eBpdpF+6yleSWHGCXk+6Fuk4v2rmdGYcYNpe95b
         CoKiTYo4RT/Uweozm6KftykAsBYRxTjDKipbFJrbpwpu9qQN39qmFhXUVeKzu74Nq/q0
         MuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a3P3Tr5cp7+7D8TJqnA3Mjf9GQDMQvB2MGmfRIaPWhg=;
        fh=EdQT2iPF8Sg18AHgr7uTyNnIuNjfC5YywJJU/pZSvnI=;
        b=b0vuMeOJC4ijRUTtcQIMLqheVtPoWGOk4UUAjvOyZ2fzYtrtRdnAzOBEo9nieSfKTO
         b22F3oVfHT79A3Oz2CloOOCfo0WXAiO9tMRRoks1nQcFGQTTc1YP3GXqMFou+RDzYSsq
         xPvNf3PHRvXV7yufQCKJumaQ5wz2lgng75XgGBwDKPYCCUis1cm3JDzcq0UVXvsiz5s5
         JaAYVHN0NeJ6jMSClHH+I7gXblAYprSMph+TPaLyivsGKblHNUOWwO7e857QdviJ48Ow
         EzmmezM85KjxXE3pkQXd/5QGf/OYSAAvsgeYzx7dQSJRfVwBWPo0JVSsiKaNSPR5/afL
         W0Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783072787; x=1783677587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3P3Tr5cp7+7D8TJqnA3Mjf9GQDMQvB2MGmfRIaPWhg=;
        b=Ybh0EtzNdpGpULrBR87hDEcSEgX+vYBAGyB2kp6GuU0HeZC9WoR4WoFBmWWOoWVv2L
         YCHkfmlw9lWahp5mvNbRnIm2888yFxgFKPLbAU7Cxc28vBdryy0J4pgN6c1psahO6uGi
         Ksg3bk1Ij96gNwbjj897mxptRT39U2wwGvwCmRnSJazhQ9bMW6foAGUqMfIcMT6sQDt5
         Coetqj/hZSo0hbz7cJtcz1L/0DkgizLMJ3h2MClf3bc/pB+YaN01MKSKgLz22hsVubZq
         bbzFuO2cs7EhN+8bKe8gWMzlYXwwBBxHAkitInZANpfUJbJEQgu7UTA9LU3PbYL3HfBt
         THKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783072787; x=1783677587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a3P3Tr5cp7+7D8TJqnA3Mjf9GQDMQvB2MGmfRIaPWhg=;
        b=A4Bmf/EbVAlEfzYqMXLJly5I7VQpECACCfOXGsxIr85OZol7pb2t0xCoxW7sFhZ7KX
         GAKTwUKLWpAuW+N9W18ln+MEqmFd2vOPIRbYQY8R4gMEuuTOowsaZU0WFtUK0Wx/E7yY
         rRor47kcLLChLtGWuUdYDkdwvQghqnb275ePvx3tQgi7YSyXJ3ExRdoQO+f/0zjn159F
         eCc46ZCdCgoyzV/w5rF8hn4TEiWXiSj4HpYlt6lfjXWGpS2EosmfUUhqeM2VqyA1n0ng
         +97hxh3iU5meD/S5xV8gzzo3Fbg5xV7paYHUP7lrq7SkwwLIPfREPWfZPPhZ2dTs+XYP
         7FLg==
X-Forwarded-Encrypted: i=1; AHgh+RrxbOJXIgtpRvHxJWysHsJvg2VBIGV1UrPNRU4IjsMgq8MVNKNzHzMGzCN6OclfY3UsSmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGixH7/1uaZ/+mqCgT3bXrcGlxUe7WiELfJUpMJ0kg0QaHFOvl
	xL2l/Brl4hPjkTm6aH+6nH0gkLaSDznsUE8yWzmYYlZNN5QEgaaabyPfKrMEnKjUzluleIRj5E4
	ekEyCLSVgyxSu2CYzAtdV1gEeFWniDEziJqniGz8bcA==
X-Gm-Gg: AfdE7cnFTQu3zhYXJ2U1KcYlncE08ZTeErvIcftj8sjiurBTe/lAt1tHFmHQaAEVVB3
	7YFgVipXmdEVENHgP31bn4H/JtEF3oCHm9e+ASK5o3EcyQnDxYteH8UGm1OdEm1V+0s5/p+LxEo
	yYZexS525WIY5cVrrCRvy9zJC8wV39Mm2X5hsFXOgV4r7KJdu3MKQ+EIDY0rMO388tWObS3HWf2
	VJod9YGWmaxQ01+0zlz+sOSf3S1MipfUo/7dBIM93GGL2ekjl+EnRnp9ssxuV28g+vLoR7jaYmj
	yQpDzcWi4+iJKA69TrNs7XaB/itgODd9OfFCRCdnqII0V5StGmMqySYr
X-Received: by 2002:a05:690e:4188:b0:664:b5a9:eef1 with SMTP id
 956f58d0204a3-66521b3a729mr8538474d50.64.1783072786955; Fri, 03 Jul 2026
 02:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624103049.884930-1-alex.bennee@linaro.org>
In-Reply-To: <20260624103049.884930-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 10:59:35 +0100
X-Gm-Features: AVVi8Cc0-9na2SVpfaB0sZbkOU-6Sk1x4LYlRjdp1IEN46Q2BYvTDWcdA-jULA4
Message-ID: <CAFEAcA-JmvT-S8q4F65+E1Ghf+DrUtB+WMqjpBF1xd9hcN5Bag@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] target/arm: fully model WFxT instructions for A-profile
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Troy Lee <leetroy@gmail.com>, 
	Hao Wu <wuhaotsh@google.com>, Kane Chen <kane_chen@aspeedtech.com>, 
	Mohamed Mediouni <mohamed@unpredictable.fr>, Steven Lee <steven_lee@aspeedtech.com>, 
	Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>, 
	Pedro Barbuda <pbarbuda@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tyrone Ting <kfting@nuvoton.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org, 
	Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jun 2026 at 11:30, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This series fully models the behaviour of WFxT instructions. We
> already had support for WFE for M-profile but we left off A-profile as
> it has more potential sources of wake-ups. The main one is the event
> stream which includes events from significant bits of the timer
> ticking over.
>
> The refactoring from the previous iterations of the patch have now
> been merged.
>
> I've dropped trying to fully model the global monitor in favour of
> taking advantage of the architectural flexibility to have an IMPDEF
> event wake up for any reason. We treat the setting of exclusive_addr
> as such a reason because it indicates the current vCPU is in a ldstx
> exclusive region and we don't want the guest to deadlock. This does mean
> the system won't sleep on WFE enabled locks but people shouldn't be
> relying on QEMU to model real world sleep patterns anyway given the
> efficiency of emulation compared to real HW.
>



Applied to target-arm.next, thanks.

-- PMM
