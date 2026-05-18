Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC09739936F
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140399; cv=pass; b=bILFmwWZqqKUIY3gRRJ99aV/n7foKa732TuaQiV+oOpF9OeFCDJDtsFv0xtIdT7ZQi7yOzZosKKWgfnq5AOzO+rRCoocWRExUInk03ZNFICpwdjH1Uzn9dBQumeCQ49hwNjLFcXAz/jnfEcWcERJnYdk40sV8ornggCFVvwZH6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140399; c=relaxed/simple;
	bh=xT+2ZiaLoTAzFBIhyXQuJbWWFzSOhymsRPWYLiZlVq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt2YrPuSfDNwwGDYOADZIaCqqxk+VkPorpr/qOpw7kJnXsk4XIoQK2keRr/GScOiD+J6wgoSvZzC6mFIly2kaTkIt0Z5qpLrbTGewdA1PoI6qs8TDKK0jsWN6ioHt6SPBKSN6hNfJGu+4qnSTYTxlIoQaf2tzrmU7+aQh3pYofw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BmoT3R8w; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BmoT3R8w"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d864c23bdso3331cf.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 14:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779140396; cv=none;
        d=google.com; s=arc-20240605;
        b=VrmDIf4ENtZanoVtWIvwU88RD4kHFQ0FUCE52E6cxhe5e+Xt5MQAs/C0ndwzIoGJ2z
         MB4vWY8ZsENolSOeZpJxIvxDMy7JRoXqZAAKqHqh3SYndcR3m4ZfXImF8D6LfwqycqGw
         ehA+0ZrjWP2WMZk+PC0WXzyO4zb3IzKZF61lqOfpi3hk48igcMf9nGubcwe88j+ZZ7mb
         fZ26AkPvi8/qdhGbojGmxxjyvNOaEP+NPsRH7Yl75kaTrTsVR/h65w3N5B0/ysjtaRAe
         XzsoFr1O8nGDfRjgYCEF+vy+zsNgZa/eO35qAZVzqfeKQnYSeOJE1mxRymlCxfIMYg8M
         IF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KV05hHRZAOU+m7hMoQzSPD4CCTn+SfRHia9kny5iEuI=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=YD2Lrp0SISJX+OH5mLUjK9VSKNI5pwQu/LhKlQo9uGty/uK/GekNz2UvUIBFeP9r5n
         9V6s1busTs+NBlWXHvh6chPDn+Mf8iU4T8hOibiTgXhNbgHlMeC6i30TW5W4hyfPVdmU
         e3MSlpnVd4mKxQ/R7lgScbQA2MI9L1pnDi2x8wvb7BMcFLQbA6Z4qThic+vnLtdYPRxN
         Pnma42FYyUGylz2NdrCqvWWGj7Zo4Bat75KkiaN8b7k8dzgUi5V0FDtvRaFg4uoKT/a3
         7wn150j8qpLFoKAchVwPRtoNxXhCuP/WMUzOeH+AU7rXsekSxUr44I9YWROj59gh2jzL
         5wYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779140396; x=1779745196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV05hHRZAOU+m7hMoQzSPD4CCTn+SfRHia9kny5iEuI=;
        b=BmoT3R8wAP4Y6XoBUXdNj6pLqTm8qhvM3lqx9EG/IQcT16jl+0sDo755EK3N2jeMz5
         MnW6RHVaigHgKUIVOFkPbHZTmimAvxHOIh2oCzfgNmIHJJq2+gsob8KBc7qFZ0U0rLkt
         L/ZD9ynGHq7Qi1DkZkaVxo6jczrEbGT5yzV4qnQNtYYrhB6Y1lB8IkxAVMumhYsya/pf
         isypM2MEouEO1DA9RPyaJf19e3rc4MGlub6jfAXQPWn8nhJfaxMJVMYwEEh+rODrrYq0
         hXfLuaBehLCCivYvsQY3f9MWjCfk5c2De3ypY7iTOSEsjuLDaWMDcBku0RuLAVNhXSsX
         c1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779140396; x=1779745196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KV05hHRZAOU+m7hMoQzSPD4CCTn+SfRHia9kny5iEuI=;
        b=h5wfDU9flDwRZN1n9N8eBS87zCrbLi92ZvNcB8nRShm6WcP+6zyvQq9F7+3gEfOLM7
         D3jLfcubI27N4Prdqt6szPV/A60Olt66c6DWS0sEPMxLxI/91Jygtw5XyhCAjKtIq96+
         1Vaj4G3zuqDBXmHETAbJZFjFSzsAYsZPhv5FgS0MvqFxzlE8TJtxwIgiNuLmOlAtOCuK
         lmPM2iM7dt19lV8EYQfJ/q/v5EmuBy2eXHiZJBG0qR4oiKVL4xx3t5/sfNC/QYbln+WD
         l2OJS5FEsCAk3tEe8v8aXBoyymb75n/ZhEhuySxB6sgzH9KSjRrb2YEWYrCO9KCPKAnU
         /nEw==
X-Gm-Message-State: AOJu0YzT/aiU8rVmzh+bdreT81cVAklOAzRqy/Vgav/OyvFz8rfvZ2yY
	3824qDy5ZFBy/g+aQVBrPXrjm2EO+LZiuZwhjpvRUs14GQifHKoQiwdvxNYUf5HTtXi+doVPd18
	xOXmaMBF4TUmP2+O+0lDKVrHZdu9C/N2PnZzL2PSX08+aMDH1AoQX8p5C0QE=
X-Gm-Gg: Acq92OGADSZdmqfl+BjnOYlSfe9jAkq4VeT10K/qiSE8xX6To4h44lvLPRsXpOmBXh7
	jJ+CifTkb/udMtVNl3tDAbbNARrWBT9ntmCSaAk1qQxyd3CFh1SYn6kqdrtJXskSXJb+hVBAOxD
	E3oOvSLgDgQ+eiEo/bg0qoVcJf8bbJzuHTsbMjvcR3XbDdFyOoANdGzTWzM432tnu1bqQ6sfYRR
	NZWsoSOS5uy+VabBLNhKmnga3GUaTaEvMHtDypNwUSsfDivqF3AnZy/tNACRxCxDec+IABP1u6r
	QxX/Wupd96pJAHlovc9KXQOFkxjdIWgWZfB7+6hyzahd/IGp6RwpPBiWUPGTVzSg+VB0QPfjKZH
	u94NY7bg=
X-Received: by 2002:a05:622a:8414:20b0:516:8fad:8fd3 with SMTP id
 d75a77b69052e-516a76459b8mr777211cf.11.1779140395218; Mon, 18 May 2026
 14:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agt_1yfdx3YmjYei@google.com>
In-Reply-To: <agt_1yfdx3YmjYei@google.com>
From: Roman Gushchin <kfree@google.com>
Date: Mon, 18 May 2026 14:39:43 -0700
X-Gm-Features: AVHnY4IyvqzFzDkjI7CmsS20PXYlVfZKOrrAZXWkDOnlYtfdSZ_1wsxktDGGhKs
Message-ID: <CADKH=+2ZwLuona9esxGfbxO+g57EgmU96ReotPfQG3fY7Pp8KA@mail.gmail.com>
Subject: Re: sashiko-bot@kernel.org's Cc list on reviews
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 2:08=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Hey Roman!
>
> Sashiko's choice of Cc is... odd.  The original mail has a whole pile of =
folks
> in both the To: and Cc:, but sashiko-bot is only replying to myself and (=
very
> bizarrely) linux-hyperv@vger.kernel.org.
>
> Oooh, is it perhaps because linux-hyperv@vger.kernel.org is the only mail=
ing
> list on the original Cc that has opted-in to getting emails?  If that's t=
he case,
> we might want to change that, even though it could result in people getti=
ng grumpy
> about unwanted bot mail, because IMO the alternative is worse.  I've been=
 responding
> to some (mostly very good!) good sashiko-bot feedback, but only just now =
noticed
> that the vast majority of folks on the To/Cc of the original patch won't =
see the
> reviews.  That's bound to cause confusion, e.g. if someone reports the sa=
me issues
> and/or manually looks at sashiko.dev.

Hi Sean!

It's expected per configuration here:
https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_policy.t=
oml#L138
.
It can be configured to reply to all as well, but since there are some
very vocal anti-AI folks in the community, this might create some
friction. In any case, I'm relying on the corresponding maintainers'
decision on how they want to configure Sashiko.

Thanks!
