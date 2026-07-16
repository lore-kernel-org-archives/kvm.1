Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044C3386425
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 04:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176060; cv=none; b=G34X2WvlO3pQoBzhEB1k8zTUyhrFAZSd47Ue3sANXQolBqvI1bNwHiW6B63jwXNQKSIV5WaVBrXuamxYqpDkKJEtFW+c6LytiR0avCWqZdrofKdki+VSnX/aU6K+/KT5K3rBLWxjNJYRA0Qnpzo1L7J3/AaJ/v/jhNRe+rp1lew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176060; c=relaxed/simple;
	bh=63gjmWL5Fz89F/dEprKVRiK17rGkpqgZZqPJjwqPtc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBraFZkDoQpuNU2jXMLqiukleil1DMVRIHHgDG/xBt9ZDX2oGxud9+CyiUZ4SBLz8IEaLgQXHHhADPDWgDQIwkT8J7UO9PSLFtbDzGzM/hm+rLDenEtusZpkkt23084DDFqKW9Bz+5lkTMahc7wSgy0nF5iJfYJKgiEWKAGPUpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oafvANcA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oafvANcA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3071F00AC4
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 04:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784176058;
	bh=lP101U3EtuK5bjCMOxvSA1SffQMwLcZldCvQuoqNvtc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oafvANcAdOUfD7cuYzp9MVGA95G9eWOwTDgZnw1GFnUItzikPbUtvwmYqnZVCwDGO
	 x4nzWSi9KEgwc0AgLdCJcJWd4eIGMZhs2E0er2LB4+76vhaJxpEpWQKLH2hHHgTIWX
	 RM1RhKkHQ6//kbr6nkSb+JpnlQBDbocstdaFlMugJ0YJCAPRobrcPIXBmph04yT9rM
	 w59JVAlG09oWhWOYk+X69PfRjfMkMNLl0iImXTq8tmjqZs4FIi3nhFCJP3V36o5ohJ
	 LU7e3sVBtsWpmwPLBi3qu38qDKHoIUAW0Qx2kDxZb4QvEV/oqgZZ4Qv85nKCBbNL0+
	 7cFxBtUou1J/A==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so8852753a12.2
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 21:27:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RronZLsLUHFT6ag4B48lLni44C/JEYeSVC2BUCSgDlUN5LQo64piJ6Bnysa5GZsgKj0dHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIE1SmcUp11OGx4hvJCeXkx6SMtO1mcJaPYRU6NACE3WCJN0+G
	SD6VD62K4Pi3Jkhs2kzGZeWfHgvrY3OGHgfj4P7oo1d9S/d26AvM2OOMqfrm6MlkD177PIrtRq9
	nFdz3jkrP37tMI6ShbVyNqHIvzTkIHEQ=
X-Received: by 2002:a17:907:3e0e:b0:bec:2ad0:cba5 with SMTP id
 a640c23a62f3a-c1667a57571mr554148366b.29.1784176057205; Wed, 15 Jul 2026
 21:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716013823.3259816-1-maobibo@loongson.cn>
In-Reply-To: <20260716013823.3259816-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 16 Jul 2026 12:27:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4RUWDWHRZ5FJ388e0ZcMD5VS=rPThY3kYNR+WY917i5w@mail.gmail.com>
X-Gm-Features: AUfX_mwwy76z4l2N9WQ2qnRsOCdpZt-K2IzS_6bSPA1MPvSNtn-TkRm3Fs2Zn8o
Message-ID: <CAAhV-H4RUWDWHRZ5FJ388e0ZcMD5VS=rPThY3kYNR+WY917i5w@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Allow to set pv_feature until vCPU run
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, Tao Cui <cui.tao@linux.dev>, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Thu, Jul 16, 2026 at 9:45=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> Now pv_feature can be set only once, there is problem with VM migration.
> Where it is set when vCPU is created and after migration, here it is
> allow to set for many times, until vCPU starts to run.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/kvm_host.h |  4 +++-
>  arch/loongarch/kvm/vcpu.c             | 15 +++++++++++----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/inclu=
de/asm/kvm_host.h
> index 23cfbecebbd7..af376fc44c44 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -163,7 +163,6 @@ enum emulation_result {
>  #define KVM_LARCH_SWCSR_LATEST (0x1 << 3)
>  #define KVM_LARCH_HWCSR_USABLE (0x1 << 4)
>
> -#define LOONGARCH_PV_FEAT_UPDATED      BIT_ULL(63)
>  #define LOONGARCH_PV_FEAT_MASK         (BIT(KVM_FEATURE_IPI) |         \
>                                          BIT(KVM_FEATURE_PREEMPT) |     \
>                                          BIT(KVM_FEATURE_STEAL_TIME) |  \
> @@ -250,6 +249,9 @@ struct kvm_vcpu_arch {
>         /* cpucfg */
>         u32 cpucfg[KVM_MAX_CPUCFG_REGS];
>
> +       /* VCPU ran at least once */
> +       bool ran_atleast_once;
So long a name? Maybe has_run is enough?

Huacai
> +
>         /* paravirt steal time */
>         struct {
>                 u64 guest_addr;
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 20c207d80e31..ce6a1b06d50d 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1164,11 +1164,14 @@ static int kvm_loongarch_cpucfg_set_attr(struct k=
vm_vcpu *vcpu,
>                 if (val & ~valid)
>                         return -EINVAL;
>
> -               /* All vCPUs need set the same PV features */
> -               if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
> -                               && ((kvm->arch.pv_features & valid) !=3D =
val))
> +               if ((kvm->arch.pv_features & valid) =3D=3D val)
> +                       return 0;
> +
> +               if (vcpu->arch.ran_atleast_once)
>                         return -EINVAL;
> -               kvm->arch.pv_features =3D val | LOONGARCH_PV_FEAT_UPDATED=
;
> +
> +               /* All vCPUs need set the same PV features */
> +               kvm->arch.pv_features =3D val;
>                 return 0;
>         default:
>                 return -ENXIO;
> @@ -1851,6 +1854,10 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>         int r =3D -EINTR;
>         struct kvm_run *run =3D vcpu->run;
>
> +       /* Mark this VCPU ran at least once */
> +       if (!vcpu->arch.ran_atleast_once)
> +               vcpu->arch.ran_atleast_once =3D true;
> +
>         if (vcpu->mmio_needed) {
>                 if (!vcpu->mmio_is_write)
>                         kvm_complete_mmio_read(vcpu, run);
>
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> --
> 2.39.3
>
