Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3D2F6920
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780739649; cv=none; b=NhIWxDfreVB0TFt5+xEx9RkcLxMd3lMK8/VIIB3+9d2TcqccLwFdpyUDeZWZC8d9BUupm3hGnqX7ee1QLKQjnNkGvoXJ/7IN4bpR3UFQpDDd/9kOKjR8J4w2/EmarSbbwtRKuhiXtMGPeEFPpSDFTYzxwMVR9v8epBaEcSo7YiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780739649; c=relaxed/simple;
	bh=OnuoKldbl6pPTlgnWrSwoJrlKDnzInysIn5Ah+Wdm00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1BY1Ke40EUNZecTf7yF7IOdE9DxCjo5XFcoGdSfl9DaZrBCA3rnW87EXo5rRzmvaqE6dFmY1ffTS35E4cGKuTSJ8bBrMvBN9DYb7tEC3waRZMycOOI3mPCAj3Lwr7AEJ63+cxuXSf0LcTYTI3rjok7J5WIKVujM5DPi9HrvVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsUzkKzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsUzkKzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AA11F0089A
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 09:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780739648;
	bh=vgAbjJEl/Q29qjPBbciattzY/7cgeBFYQXG5g1d2DYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JsUzkKzd/oiYzsRHcqg5itEDwi6qtTtf5Xg9icYZa7zv7vEFjs66Pp+AejGwGuL6f
	 ItN+lzZxJTw7VX/+o1rBC9lHH4cuaMecoaNrXneJ8JKXhArpmMLTYALqFm9q92w2sy
	 R7OxRLlubtGpPqMy0q+gVaKp1q3CE4XReH4Xcby9BOeo+jd8P3owbSY6eS+ki483IR
	 k5mt82d7zr+VN0iBUe8/xXcMkXXPHG2PZSiyoMa5ij3rIZPiBE6pTc27c/QhA6u+Km
	 zA4TKA+tCSpGCYUoQ7yiBLBrzZ8tPYP4BxSFsrclfHBavsbEA/m7QK9O39Bw8VdT3b
	 lbYFVlYfRyUrQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so379460266b.1
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 02:54:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Uh8AUhiswpL84KPFaBrHsQSWbOMoskkTc4ozZ9KilHqjrOh4xOxIhHfBuoNiiZz6Y5So=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+FolV+7nEK7GikmWt8c64jMqsfWFfHYfK+qOl+2Kbx+Nb1he+
	z0ruFQXUppcMLhr+qZUjvJuXgvAHoZXdOKcngKM8Yjxl1ectCVGhDsnYd5ejeofi0LkgYsKFxDZ
	9z6cELva7SGQhSHznkhWacQMszaXThJI=
X-Received: by 2002:a17:907:c247:b0:be2:9cf5:4e61 with SMTP id
 a640c23a62f3a-bf3743ea6abmr395521966b.40.1780739646522; Sat, 06 Jun 2026
 02:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526125256.2511876-1-maobibo@loongson.cn> <20260526125256.2511876-3-maobibo@loongson.cn>
In-Reply-To: <20260526125256.2511876-3-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 6 Jun 2026 17:54:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7RUdVJXOdjktn6vox3crhcXV0cEB1kUgu_zUVV5qpihA@mail.gmail.com>
X-Gm-Features: AVVi8Cfzf5hioHDOAqB-jCAFTQGZ8mR0MBhE03dOGiKHcX4n_LcXdMCEPYSuz20
Message-ID: <CAAhV-H7RUdVJXOdjktn6vox3crhcXV0cEB1kUgu_zUVV5qpihA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] LoongArch: KVM: Check msgint feature in interrupt post
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Tue, May 26, 2026 at 8:53=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> Interrupt AVEC is valid only if VM has msgint feature, and this feature
> is checked in interrupt handling. Since interrupt handling is executing
> in VM context switch, and it is hot path, here move the feature checking
> in interrupt post rather than interrupt handling.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kvm/interrupt.c |  5 -----
>  arch/loongarch/kvm/vcpu.c      | 14 +++++++++-----
>  2 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrup=
t.c
> index a18c60dffbba..48dd56aa4dc5 100644
> --- a/arch/loongarch/kvm/interrupt.c
> +++ b/arch/loongarch/kvm/interrupt.c
> @@ -36,8 +36,6 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsig=
ned int priority)
>
>         switch (priority) {
>         case INT_AVEC:
> -               if (!kvm_guest_has_msgint(&vcpu->arch))
> -                       break;
>                 dmsintc_inject_irq(vcpu);
>                 fallthrough;
>         case INT_TI:
> @@ -75,9 +73,6 @@ static int kvm_irq_clear(struct kvm_vcpu *vcpu, unsigne=
d int priority)
>
>         switch (priority) {
>         case INT_AVEC:
> -               if (!kvm_guest_has_msgint(&vcpu->arch))
> -                       break;
> -               fallthrough;
>         case INT_TI:
>         case INT_IPI:
>         case INT_SWI0:
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index df5be9b265e8..ebd432da3ca4 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1493,14 +1493,18 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcp=
u, struct kvm_interrupt *irq)
>         if (vector >=3D EXCCODE_INT_NUM)
>                 return -EINVAL;
>
> -       if (intr > 0)
> +       if (!kvm_guest_has_msgint(&vcpu->arch) && (vector =3D=3D INT_AVEC=
))
> +               return -EINVAL;
> +
> +       /*
> +        * Clear irq with INT_SWI0 (which is 0) is missing from SW side
> +        * INT_SWI0 is cleared by guest kernel with the similar instructi=
on
> +        * clear_csr_estat(1 << INT_SWI0)
> +        */
> +       if (intr >=3D 0)
>                 kvm_queue_irq(vcpu, intr);
>         else if (intr < 0)
I think "else if (intr < 0)" can be simplified as "else".


Huacai

>                 kvm_dequeue_irq(vcpu, -intr);
> -       else {
> -               kvm_err("%s: invalid interrupt ioctl %d\n", __func__, irq=
->irq);
> -               return -EINVAL;
> -       }
>
>         kvm_vcpu_kick(vcpu);
>
> --
> 2.39.3
>
>
