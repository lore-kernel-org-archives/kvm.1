Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A748F842
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963461; cv=none; b=FYmZV8DaxmgU4PeR3d5AD5hXbSCWBEt0Nqe1NcdfoZkPjyEFdMDMhixCKOydt2Am/3AlYG86VC18CU2WTpr1bm0CDt21I7gNVGAL9dTi10eViyv8jQ/WiMlxiej3p8MDB+17AA3JAgaT/1OmEFiI1URa8y0cNPKnY6XKeOdg2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963461; c=relaxed/simple;
	bh=2Y9fbE9O7p8liEj4nGLfJ12MalMVV+gFP3WAl48R2RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsUOBlEJGoEVIylxRAqZDAyUwdws2scFJ5CwnWtiafbXCKZxirLFpVfXcrAgBN+TTv0gRss5T6hLttBynG5mh4Wy33Vi7qXqtcrpq5ZTQ+g+Xdqx8NXYhbsUCDtjg0JGam/eWGaeHPMnhM4msbHxJJt4B4wYgS+tt7OfW+RbrhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCmlq9Rx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCmlq9Rx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4553F1F0089D
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 07:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791963459;
	bh=GD+/Ha2/u4ZZXBCqFxIO50aJrY9gSr7+woMCBtv2vvw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QCmlq9RxZwZDnDSaQtL4l5SsOSSVWHNdqYeVB8POHxJJj8qMKyTmGIyowGQhn2g+z
	 C5apiUXipQI519XKCt1Tpb3q24ONuzrGel99EK6VOcz6+Y+4D4ogZdNan4ivHp6C30
	 EkGXg4zXnEPGKasmv1/2JsxVyulveXbL/OEijk2jxNLOAeeCSWULY+HL7mibiM5nwO
	 rVwiuHIp9Awhs7QCLvjyUgeslA/eKklPXVr2+bCSzTtDid3P6Dw6SsvRJ8L+gB1dze
	 XaAcy/5ntvXjGK7uOTsOmPQ4adW0Imj9tGs3wVRcTEOw5SwJXnsXb1W4HmXCvSPX5o
	 yAXMPR5NY345Q==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so5435021a12.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 00:37:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy+GPxmegjtrQsAQpil/P7rOlD2RXPLw7Ch/W9++NWkLWd0bNX+NYPAJ2qQ0rDDggPuLEo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFKmBa6pRTF/CVtAjBmzm6iOm4MygIgQu4qky/0xm+YHOXnRHf
	MjxsXainJyT7JhWyhPWocZsgReX+QpamdS/1fhBKC2JwJacJERkaP6QXJPjE2HSiwnawNE6e8Wk
	iELlq7PfMGLYmqfhkgGL6HvKmKkB+Uf8=
X-Received: by 2002:a05:6402:21c9:b0:6b1:d9ac:b757 with SMTP id
 4fb4d7f45d1cf-6b1d9acc3e6mr4316643a12.6.1791963457821; Wed, 14 Oct 2026
 00:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014052933.723303-1-cui.tao@linux.dev> <20261014052933.723303-4-cui.tao@linux.dev>
In-Reply-To: <20261014052933.723303-4-cui.tao@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 14 Oct 2026 15:37:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5SDKsifd1GwMLU_YMny8PqwHdyuvujrAiuvkALoi3+8A@mail.gmail.com>
X-Gm-Features: AclHuK9Ksa7VlvS-kSklI6Uruo2KF9go6WI1OnUs-g3EqUPWxpjWce4dC5vPHww
Message-ID: <CAAhV-H5SDKsifd1GwMLU_YMny8PqwHdyuvujrAiuvkALoi3+8A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
To: Tao Cui <cui.tao@linux.dev>
Cc: maobibo@loongson.cn, gaosong@loongson.cn, zhaotianrui@loongson.cn, 
	loongarch@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@xen0n.name, nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tao,

On Wed, Oct 14, 2026 at 1:30=E2=80=AFPM Tao Cui <cui.tao@linux.dev> wrote:
>
> From: Tao Cui <cuitao@kylinos.cn>
>
> KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT has no guard against repeated
> invocation: every call overwrites pch_pic_base and registers the same
> kvm_io_device on the MMIO bus at the new address, while
> kvm_pch_pic_destroy() unregisters only one bus range.  After a repeated
> init, MMIO to the stale ranges computes its register offset against the
> new base and silently reads 0 / drops writes, and the leftover bus
> entries persist until the VM is destroyed.
>
> Reject repeated initialization with -EEXIST, using the initialized
> state of the kvm_io_device as the indicator.  The MMIO base is only
> committed after a successful bus registration, and the real
> registration error is propagated instead of being replaced with
> -EFAULT.
>
> Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and write=
 functions")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  arch/loongarch/kvm/intc/pch_pic.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> index 51e4a6a39dc0..7979466de729 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -281,16 +281,22 @@ static int kvm_pch_pic_init(struct kvm_device *dev,=
 u64 addr)
>         struct kvm_io_device *device;
>         struct loongarch_pch_pic *s =3D dev->kvm->arch.pch_pic;
>
> -       s->pch_pic_base =3D addr;
>         device =3D &s->device;
> +       mutex_lock(&kvm->slots_lock);
Why move the mutex_lock()?

Huacai

> +       if (s->device.ops) {
> +               ret =3D -EEXIST;
> +               goto out;
> +       }
>         /* init device by pch pic writing and reading ops */
>         kvm_iodevice_init(device, &kvm_pch_pic_ops);
> -       mutex_lock(&kvm->slots_lock);
>         /* register pch pic device */
>         ret =3D kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_=
SIZE, device);
> +       if (!ret)
> +               s->pch_pic_base =3D addr;
> +out:
>         mutex_unlock(&kvm->slots_lock);
>
> -       return (ret < 0) ? -EFAULT : 0;
> +       return ret;
>  }
>
>  /* used by user space to get or set pch pic registers */
> --
> 2.43.0
>
