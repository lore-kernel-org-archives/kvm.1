Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC88184524
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521330; cv=pass; b=uzLlnyoduu+fknFixWSKz1mmthOVxmxDeEW4b9UnilrSkCl3+y1jI8QaxE1UlF0tV5vt0ZCBBU1OJChn/IEBNQTA8seNvynNnlfuF7LGr0hcUh/ntBTTlJWWTOcSMpWe2UjeIf0tZ+ZvWbg2m6Xk8WZDc0jm9tWXMxpezeEFpTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521330; c=relaxed/simple;
	bh=jNfQreTErrv2hEpql/5UQFkOkdcHpUgBEKbRJ+ec8rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dp+ndK9MSqXbOwcz+aoWnhGZdJ1ZF/OkLr6dgKrIjqCRtXAFWrg3HwYF3dJlbUP41M1b4CwFKITtyJH2quFspb206adlP1afFLzPeFZ2hIXf1iXjuksOwua67P7hgEXmyeK9aXKVKT2NorrMywJt2Fw0cwlywM/Q5vhgUKuIDCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oiWSO8pV; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oiWSO8pV"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66049669d78so3011650d50.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 04:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781521328; cv=none;
        d=google.com; s=arc-20240605;
        b=X4k9U0Ioa/oeS8qKhw/2V7mcXm3m2OFyLQqp6GZWo3znHCxixe7t0eU2BDZYQDiFii
         /XChwRqlJihCiLCO8O575s+n+xVhykjuuokv4E0qAOr+J69AeYTF30Fi0CUGIrSjSFxG
         hsuvPiw5kfhwD2bkoHhNeMfvZeP7cOJqoQ0E5oecoRqsDWr5XjZ5U2NhcYVUDfY5vmFd
         Aor69Fy1f6YXCHZ3pduet+tUhqa5RIeFaUxvOY5VZUV1cYBhPMG8BY1SS4OXO/V0TC9B
         /6Tluy/oFt1nVSL3cqLhZ5WOW/62hqSMqKcOf4AjbE0vjGekh4NI6ObcrrNU20sSeJY4
         Uu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jNfQreTErrv2hEpql/5UQFkOkdcHpUgBEKbRJ+ec8rc=;
        fh=Qu8ZKtSyvOQCFdKmnXbyvOb5gXsLzlc6A2jhQ+vciF0=;
        b=FTsSXB0NFRMWXZPnny235eLv7LGUegoB44mRKrFTt7zs75cxIu7hlRnM0ytsyDYnps
         ES3mXqjNDDX2ie9AOvHjp+wTzhKhfuCWhXdGaxuEOq/58rnxkgVsvdRH0vLSXkLuRHj9
         Rg7hFn7KCK76M07Q7TDTEYjdlMrqhxgtgarIbq/QH8hBO3fRUHUFr+mPQfCrii/uA0QD
         gMYhYKg+lf1Ji4d1+/GUxGO6yOncnIz4QwfIjlI5+dDaiDPLD9J0FgfbPJf2gR82oF0y
         w9PltPz//UUSesti226x6NuhjpDE2xJXtXpwAGlpkj4PGDzI8kpm1IWgHqdPvkmBTc9J
         jIcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781521328; x=1782126128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNfQreTErrv2hEpql/5UQFkOkdcHpUgBEKbRJ+ec8rc=;
        b=oiWSO8pVTmym47TmD2Aqig3WkGvDa2BL2Zau1Xm3oQFphjo33vRESoery64/ZA7J6M
         INPpvoqET1WPo/vuA0/K3IjCfsMIVhqLDdzZ2YNRafQiveT1sEmxu5W+kAVmVIEmnWD5
         nciVND11k7l++hjuzbCsup70gI5hX05q8fKhId/BCyv+OT8UE5vRQY9qrw3kokGkbTJr
         1s9QxqY/QPQ+r9FoXdGWCTEHbiYvRzqspCdq5VYxAzQDl/Qls4iHHXo9OJBxY9lxs1Wj
         UgzxCa9CA72Xg5nn9ltxsPXxx7Tu4YQfoqdlHc+F9f2ZN2/QvW1uI50ku2mLBI9bu/2z
         rqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781521328; x=1782126128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jNfQreTErrv2hEpql/5UQFkOkdcHpUgBEKbRJ+ec8rc=;
        b=pUUdvBIV+WtznkZVcImisKmEXAIlTk6oYC4/uPG8L0WnqOP6r6D007/7lbk+r6VL+3
         3Q7ew0x78yBwX1CgRMIhdTSciRH1mmuX/M/oPFRZhgHJoeYplYoi/4Zs4zA9pUlHvZVH
         mP6zZ8DY/v7lU9ldK4TyNjJW67yaq5eb/L4/QJfNP+zF5Zob1Kd8WZPrpgm2zwjGTZj3
         wwzNs+kFkKOy0L7hcTy9fqEQTvkXY3l4oPA5eFJ2ImzrRbmn3JX7mXKPrT6XvcDalASc
         SXoDALC5smE12xHdpg3gBDPdY7e2A2fnPFuxB+GqunzABgmaWYdMUdJaE9T1LskaHk9S
         9BuA==
X-Forwarded-Encrypted: i=1; AFNElJ+grweKpzav25nsNz7AAdPEkBvZ2n6/ogIh54a8jC3gEqN8LLRgdfpKBQzDFMqNdO+fL5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5obx1i87x7T5LNs+gvifU+ZbaxLulKMR/3uJv4nvJnOcvYV1H
	OW/g8pgeCPuOdC7wMvb3FmxhX0ECet6qF4TZwi9HirOzK1B3B583iBF1iFNJjkG+nS2tXzpjZrX
	+Ftvvat0E7Cmt2JFWVdjzX0WQDrcBcKWzvp2QJgMdGA==
X-Gm-Gg: Acq92OHzDcETDhOPknP1EtwxRDtUatq75hJ9I/R+eff+PoQgw7B9Muvm5x5l/nO5pY7
	5gch5M/5cdRdOPcTUeW/rB0CcwLRYVZeun9z5eJ77YrIxkRiTSflaMHJ9LCGaAqU0uhBZ2Lb9sg
	GmasCRWJ5KTvL65XGFgTqApTnKjbov0aZ8c84ZnfLUEzfW7J7GhImDB5LYIrpqZatY0OIsa3c1k
	uMHdOPiQ67EOUTwMX7qE7LvSnB4EpZ10VtVUqxqM1H3SYGqItAh7JtsKCmcykCsDYNflOzkUn9/
	MFs9v8MbV08un8Ty/TgOM4vtiWUC9SX9leY0bhI8GR/jyXOA01cHTOMYFKMh3CMkDOs=
X-Received: by 2002:a05:690e:1c20:b0:660:5df1:f23f with SMTP id
 956f58d0204a3-6627834a0dfmr11152146d50.57.1781521328563; Mon, 15 Jun 2026
 04:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529082948.363931-1-alex.bennee@linaro.org>
 <20260529082948.363931-8-alex.bennee@linaro.org> <CAFEAcA8719Q=VCwOm790V6FPA8FyaFZEux=N-7PmOGaaq=O_sw@mail.gmail.com>
 <878q8gjcms.fsf@draig.linaro.org>
In-Reply-To: <878q8gjcms.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2026 12:01:56 +0100
X-Gm-Features: AVVi8CetPPb2pY0cel9IN6dR-6aJAbVnjHAtVmBC5Df3VBbHh0Upbt0eeYxUK3I
Message-ID: <CAFEAcA86_a3GfXCDOo2G-R6v3ALwUwNFRkspyTCR0umGiAB2Hw@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] target/arm: handle the WFE trap case
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <agraf@csgraf.de>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
	Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jun 2026 at 11:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>
> >> Now WFE can actually suspend on A-profile we also need to handle when
> >> its trapped. To do this we need to pass the instruction size so we can
> >> deal with the is_16bit syndrome encoding.
> >>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> > Doesn't this need to go earlier in the patchset? Otherwise there's
> > a point where WFE can go to sleep but doesn't honour the trap bit.
>
> Hmm - the way I read the description was we would only trap if we were
> going to sleep. Pre 6/8 we never sleep so we can't trap.

Yes, that's the point. The guarantee we have to uphold with
the trap bits is "if the WFE would actually go to sleep, then
we need to take the trap".

- before this patchset: we never sleep, so never need to trap
- after patch 6: we can sleep, but we incorrectly won't trap
- after this patch: we can sleep and will trap

So there's a window in this patchseries (after 6 but before 7)
where we don't do the right thing.

-- PMM
