Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA6F49251A
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185138; cv=none; b=VZJRWJDsK7rV9rDh+jgjRxHs9Bs/M5C9vDrOgTURhnh0RtlJ+ppaLHZjURiStLeOPhKgrtKD/5MvTbKKWaCZ1LUywADov4Tvu9c/6hhjex5ID4q3F+rcwXBKF4E3tvYHch8YW4txSP4Sg0U3Lr8BZa9ZK2jdlVEKV404L3bLR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185138; c=relaxed/simple;
	bh=Rm4xkM59PDrDGUHsP7vwBFOEmR0A3mttMti8rHko1rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgwRQk4MyFRmAn41EAcjrSz6M/clhLd0tX88lfqOu51Ol1G0zW/b9PIa9Evan+ttTU3F784jiyiZUfc0LcZ4lVjR3fKe779Y7c+xqUtjSwVxoZJMA6T1ulfoZHXLZRo4EbPrhO6a8p6guekDXIb59XYLYSCLyWKVGEFXTVfmKxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG+D1oac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG+D1oac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE711F00ADB
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788185137;
	bh=6Icaf4X/kIyDc556ppK1wzC3lefymKH+ZzCaIE2uh4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eG+D1oacxYEoMEK6J9pEO6OoYDL1MSiq+q8EuN3n5U/YidRuSAk4I88LPQdMWJ2Q+
	 QTu2+jwYCitDZhgMLXxal0ZDqmtNOYAK2CZ5a4J7QOF1YZVk//B8/mCn6nPVfoRDaf
	 tUA+YPeNvmnsW/uwlI9MdFdo/c22l85iSNm608j5lW1y842ANtKJH+05E438ESHcFo
	 BiaACHjvWJsTNzLThSoP5AfVaK32fjiyHBozpusADjfjzqbyLnXTyTp63ItGmNHmXV
	 +ouzZafFaaT9du+veyHaYAsjlg/ozJiLt5ostNoHoaeV8VVorJO+W0t+TUlhymk0F2
	 HmJHkZD4ZDf/w==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1677c91969so335343266b.1
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 07:05:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByKjZOWYMVJAeTGvXhGNf0Q0oR74cHugUJ78c7uprdAi6zpK665tbSWx3lHjGPJPHFT/eo=@vger.kernel.org
X-Gm-Message-State: AFuF++mTNGVR01Gf4w/zirswkflwdtq8MLPOMyfaaX6XJ5giBeobwugb
	HMBXdhycfst4JMYVcMYl0gd89G2DGAck5+QO2YlobuGLfwPAVtMl+2/eXm9YAdyK3OG4w78u0aX
	qUJ1S74T4ujVDB75H2ufw+r57gJtXGjo=
X-Received: by 2002:a17:907:3e8d:b0:c21:601:6501 with SMTP id
 a640c23a62f3a-c25571d06f7mr1561606266b.20.1788185135715; Mon, 31 Aug 2026
 07:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817115847.2705791-1-nagachaithanya9911@gmail.com>
In-Reply-To: <20260817115847.2705791-1-nagachaithanya9911@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 31 Aug 2026 22:05:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Rt4Tvb8LuVZ1_Yna0eYa3bfmzHLUyh8v9=v2BtKH92g@mail.gmail.com>
X-Gm-Features: AcwNN1VuJY2FdGHf2YH0PvTrLOx4t1TxoEZpNPLnMKG5h3qPA3szQGgwiq-mgV4
Message-ID: <CAAhV-H6Rt4Tvb8LuVZ1_Yna0eYa3bfmzHLUyh8v9=v2BtKH92g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Fix memory leak in kvm_loongarch_env_init()
 error path
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Cc: zhaotianrui@loongson.cn, maobibo@loongson.cn, kernel@xen0n.name, 
	lixianglai@loongson.cn, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

What do you think about this?


Huacai

On Mon, Aug 17, 2026 at 7:59=E2=80=AFPM Chaithanya Lagisetty
<nagachaithanya9911@gmail.com> wrote:
>
> kvm_loongarch_env_init() allocates the per-CPU kvm_context (vmcs) and
> kvm_loongarch_ops, and registers the perf callbacks, before registering
> the IPI/EIOINTC/PCH-PIC/DMSINTC KVM devices. If any of those device
> registrations fails, the function returned the error directly without
> freeing vmcs and kvm_loongarch_ops or unregistering the perf callbacks.
> kvm_loongarch_init() propagates the error without calling
> kvm_loongarch_env_exit(), so these resources are leaked.
>
> Unwind the already-acquired resources on the error path, mirroring
> kvm_loongarch_env_exit().
>
> Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")
> Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
> ---
>  arch/loongarch/kvm/main.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 3e1005526f4b..685d334cf957 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -385,22 +385,33 @@ static int kvm_loongarch_env_init(void)
>         /* Register LoongArch IPI interrupt controller interface. */
>         ret =3D kvm_loongarch_register_ipi_device();
>         if (ret)
> -               return ret;
> +               goto err;
>
>         /* Register LoongArch EIOINTC interrupt controller interface. */
>         ret =3D kvm_loongarch_register_eiointc_device();
>         if (ret)
> -               return ret;
> +               goto err;
>
>         /* Register LoongArch PCH-PIC interrupt controller interface. */
>         ret =3D kvm_loongarch_register_pch_pic_device();
>         if (ret)
> -               return ret;
> +               goto err;
>
>         /* Register LoongArch DMSINTC interrupt contrroller interface */
> -       if (cpu_has_msgint)
> +       if (cpu_has_msgint) {
>                 ret =3D kvm_loongarch_register_dmsintc_device();
> +               if (ret)
> +                       goto err;
> +       }
>
> +       return 0;
> +
> +err:
> +       kvm_unregister_perf_callbacks();
> +       kfree(kvm_loongarch_ops);
> +       kvm_loongarch_ops =3D NULL;
> +       free_percpu(vmcs);
> +       vmcs =3D NULL;
>         return ret;
>  }
>
> --
> 2.43.0
>
