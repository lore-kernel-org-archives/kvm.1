Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7752384245
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 04:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791000143; cv=none; b=Xp6n3DgNCUyWlTNkBFYRf6dkhQ4UT+BDZTqoXoRaP8rwf2vzB4HKL+JZAVPwocfJhaC5GY7CjfZB5F18LEo9Vr42udCwFw6hJJpIdd7UBOJNlKiMg3rwBE1wHDFXKx6yFhUtXUIvoX5yxTZFVZFcmyuNPbrRALrSTPfXNU7W8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791000143; c=relaxed/simple;
	bh=5Q0kOlBKlvQjrqJ2pLYH5gqFTYvbTL2pBiQx6XGdVTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GM4e/w+ETpYIUSxh6wz/xQHbYnREpYDvn0YIUQeYaAlr4DyLo9EHi73cqYgZLQGIPslZ/g+GAIao7yJ66x8JyBh1n/ZXcsCbpsrIDOj1NCZnjs18fiydHZqLbQx/gVoP28G+OhvYvsc8qcgizqXyNf+yFgHXMwLY2jMCcE6W8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRfUIPal; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRfUIPal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62DF1F00893
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 04:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791000141;
	bh=MuihY+3XOWOpC5dOkAt4kX96ocbnYzCapGNTqps8Dhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IRfUIPal0HS51hC9GsxkJQg+JoDR2Hbs+WFjnKLbuXPWsD5aX4TisHtKP2nEUeLSA
	 lvpKPjV/ZdCSqiWf5Sj9Mo0OOjXVuCwgXO1Z4hlMFjkomHfK0L7dKyFQtxBW839VoK
	 TQZ4me7Mwu0m3wah4Ye3cm2vHLJszfImoupIbaiTfz2R9vNyVOxFRB7YQMIqQgJODv
	 oMhmVoYmkVm8W8xHFM/RsWf/s4YCqjzf4S2Af/w6Lt4VJ3VE+yYWu3nqaeOrR/rgFg
	 K0Ov7pcAjM6dJYrxPJy+um8948hjfx2YhGILumQyh863/i3miFPWlTmzIJsi+CFC/L
	 FAQ9e6zkS0k3g==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6acb57c2b88so204184a12.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 21:02:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwBNH61xR5QVJD7Hivhno3kaCsuFZwZ2BBk/qUDVhZH8ftzNaur1T9FvAiq9rlqBS6mcPs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfRBfDeGPXxl7AOh/ER5pFxZv0sSJ35Ub1RHkmI9wxFmDij5DF
	CKxYFeqThvtEQHrIzqKkL1AthCNggbNLAFQtLlDSjbVadEqnzu224mNzsXxmBzP9lxOpd/ub+6e
	gTDVfmmmnH4btMdGkv1FUWFEr88pSUwE=
X-Received: by 2002:a05:6402:13ca:b0:6ab:1e8:8b7e with SMTP id
 4fb4d7f45d1cf-6afada11773mr1408726a12.32.1791000140360; Fri, 02 Oct 2026
 21:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923011803.1057945-1-maobibo@loongson.cn>
In-Reply-To: <20260923011803.1057945-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 3 Oct 2026 12:02:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4cB4A8kx1Ofsvk+-kEOMbv2kkBmRFv9PZEgBueDxN6KA@mail.gmail.com>
X-Gm-Features: AclHuK-kKHSj9T6BReavlusIsm1zDIL-x0f708Ue8Plb_-rvXrLHhN0sDUJ_pYE
Message-ID: <CAAhV-H4cB4A8kx1Ofsvk+-kEOMbv2kkBmRFv9PZEgBueDxN6KA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] LoongArch: KVM: Code cleanup with MSI intterupt injection
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.


Huacai

On Wed, Sep 23, 2026 at 9:25=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> Here is to remove some unnecessary parameter checking when injecting
> MSI interrupt, include MSI level parameter and vcpu::arch::dmsintc_state
> NULL pointer etc.
> ---
> v1 ... v2:
>   1. Remove function dmsintc_deliver_msi_to_vcpu() and inline it in
>      dmsintc_set_irq().
>
>   2. Keep return value with -1 rather than -EINVAL when level =3D=3D 0
>      in kvm_set_msi(). Return value with 0 is one option also, now keep
>      similar with other architectures, will modify this in future when th=
e
>      final solution is made.
> ---
> Bibo Mao (2):
>   LoongArch: KVM: Remove parameter line when inject MSI
>   LoongArch: KVM: Remove duplicated checking with DMSI irq injection
>
>  arch/loongarch/include/asm/kvm_dmsintc.h |  3 +-
>  arch/loongarch/include/asm/kvm_pch_pic.h |  2 +-
>  arch/loongarch/kvm/intc/dmsintc.c        | 37 +++++-------------------
>  arch/loongarch/kvm/intc/pch_pic.c        |  6 ++--
>  arch/loongarch/kvm/irqfd.c               |  4 +--
>  5 files changed, 15 insertions(+), 37 deletions(-)
>
>
> base-commit: 93f51579e7df248780214094418f205253383cc5
> --
> 2.39.3
>
>
