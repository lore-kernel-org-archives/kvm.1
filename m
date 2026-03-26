Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9951F4615
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511414; cv=none; b=XxU4waeu23ptfO2m0N4wGgCxUaN9EbCXdkK0nzl6vfmE9t3xABS380KIWvomKDG4/FjJ/6uMHwJuAiibOB84l+lJ/rrC80fkzi0C04jkjzLPe+5OZtAlrL4TjeO3yb1xjaTQWsP2Gqc9b3ug+3Y46FjVaJZiy5jsvRjNtoay840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511414; c=relaxed/simple;
	bh=CidhCkxqlmlhREGUgMDvYlj86xoccIq7LTI+/JoLyZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHl06PAZJBWMIQeyg+i/Bfl85y6PnkhmKaRArtZr5s1Ten6Kw0BI5b+gZsHxQQfwWqWlDbFw4Je1ZxT6YlKLM1oVw4+ZTOnxSdbkhM0ncsffpIWLFok6/i556Q36z/DcYkOvdtNa+egLBYhKDqUo2jTz6krl4P5OsBHltdsnI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGwvJqBM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGwvJqBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B42C19423
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 07:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774511413;
	bh=CidhCkxqlmlhREGUgMDvYlj86xoccIq7LTI+/JoLyZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qGwvJqBMyqAlyZXvw0pdOSbXDhRHajlR/t2bPHcuRUmTNBAgYS9SjT9bUjXaT8wcJ
	 dfPUALk0bAFQGTT4XYU/fiPNLmyuu1Ld1kZByB/O4IOxvxX0YYVEIaituQda6yluKW
	 hfoUxvc275/uG055GnafTGnxphLAtmh+nKNbXmeF+IFL00yOFnuvIy/VzYfuu1hlqC
	 M6qnfN5k6IH7JVI5gW6pZk4xZeK8TySZ8685GTVaYm6BUvLPIJz5EzVaMbi18eIkvY
	 QWh7/3dEW+JA3hfp67G/A/OwA1fsT2wyCdxNwDBygL+f9SfdashxxuMrueQCgqucIW
	 GW/xeGjKc4zDg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b97e6e48b24so106323366b.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 00:50:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9F2MkbGZkJbhF9r5hMwbFr0AFL8HHd6tfm8Ll/KUw5+EaQ4LkOhL31j5KEb32DLOD7ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FF9uGY7LKtYDOhH8eWq0t2nmyXcORWdAmUMwSgcxIUnxa5Xr
	sGgIMQtNihAEEx4YhhtupvI4L8bL+C+AGEXO1UQaURTRrAQpG8OGum6zlVFG/ZWW5km5fYmIJJt
	nEWdrHYUdMu3iTIDIzDchv4N4OLceki8=
X-Received: by 2002:a17:907:6d05:b0:b99:7462:3c57 with SMTP id
 a640c23a62f3a-b9b0f0ffb2dmr362584866b.14.1774511412117; Thu, 26 Mar 2026
 00:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324031506.264062-1-maobibo@loongson.cn>
In-Reply-To: <20260324031506.264062-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 26 Mar 2026 15:50:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6T46kbfHz-mhFVMy=JGkF3Vz9SjBeyBx=OCLiGJWjR1w@mail.gmail.com>
X-Gm-Features: AQROBzBwOrxmFRO_JN7udjv0Dk91DmL0OdTTwak67tLk1zOK-VjDTxgp8v4hUQU
Message-ID: <CAAhV-H6T46kbfHz-mhFVMy=JGkF3Vz9SjBeyBx=OCLiGJWjR1w@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Fix base address calculation problem in kvm_eiointc_regs_access()
To: Bibo Mao <maobibo@loongson.cn>
Cc: Aurelien Jarno <aurel32@debian.org>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Mar 24, 2026 at 11:15=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> In function kvm_eiointc_regs_access(), register base address is caculated
> from array base address plus offset, the offset is absolute value from ba=
se
> address. The data type of array base address is u64, it should be convert=
ed
> into void * type and then plus the offset.
>
> Cc: <stable@vger.kernel.org>
> Fixes: d3e43a1f34ac ("LoongArch: KVM: Use 64-bit register definition for =
EIOINTC").
> Reported-by: Aurelien Jarno <aurel32@debian.org>
> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1131431
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kvm/intc/eiointc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/=
eiointc.c
> index d2acb4d09e73..71bd67b57338 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -472,34 +472,34 @@ static int kvm_eiointc_regs_access(struct kvm_devic=
e *dev,
>         switch (addr) {
>         case EIOINTC_NODETYPE_START ... EIOINTC_NODETYPE_END:
>                 offset =3D (addr - EIOINTC_NODETYPE_START) / 4;
> -               p =3D s->nodetype + offset * 4;
> +               p =3D (void *)s->nodetype + offset * 4;
>                 break;
>         case EIOINTC_IPMAP_START ... EIOINTC_IPMAP_END:
>                 offset =3D (addr - EIOINTC_IPMAP_START) / 4;
> -               p =3D &s->ipmap + offset * 4;
> +               p =3D (void *)&s->ipmap + offset * 4;
>                 break;
>         case EIOINTC_ENABLE_START ... EIOINTC_ENABLE_END:
>                 offset =3D (addr - EIOINTC_ENABLE_START) / 4;
> -               p =3D s->enable + offset * 4;
> +               p =3D (void *)s->enable + offset * 4;
>                 break;
>         case EIOINTC_BOUNCE_START ... EIOINTC_BOUNCE_END:
>                 offset =3D (addr - EIOINTC_BOUNCE_START) / 4;
> -               p =3D s->bounce + offset * 4;
> +               p =3D (void *)s->bounce + offset * 4;
>                 break;
>         case EIOINTC_ISR_START ... EIOINTC_ISR_END:
>                 offset =3D (addr - EIOINTC_ISR_START) / 4;
> -               p =3D s->isr + offset * 4;
> +               p =3D (void *)s->isr + offset * 4;
>                 break;
>         case EIOINTC_COREISR_START ... EIOINTC_COREISR_END:
>                 if (cpu >=3D s->num_cpu)
>                         return -EINVAL;
>
>                 offset =3D (addr - EIOINTC_COREISR_START) / 4;
> -               p =3D s->coreisr[cpu] + offset * 4;
> +               p =3D (void *)s->coreisr[cpu] + offset * 4;
>                 break;
>         case EIOINTC_COREMAP_START ... EIOINTC_COREMAP_END:
>                 offset =3D (addr - EIOINTC_COREMAP_START) / 4;
> -               p =3D s->coremap + offset * 4;
> +               p =3D (void *)s->coremap + offset * 4;
>                 break;
>         default:
>                 kvm_err("%s: unknown eiointc register, addr =3D %d\n", __=
func__, addr);
>
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> --
> 2.39.3
>
>
