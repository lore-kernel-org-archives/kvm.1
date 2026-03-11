Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C8926B777
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773200172; cv=none; b=pjh15CcUeg9cl3abinYcJf4REuuoR6aNFM2vw+U9x+CmjPuMOXJmE2R7Ti5jijKnxEJHQ0IptXeySwl9ZIluJi0eIJJljFy/ZcrDhH87H0VJxCZL0I8z6JW6Fqx4VL/VUUCkaWf7GdtEqNcb2/LnebUsYvgxOp03fKDWtg0DzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773200172; c=relaxed/simple;
	bh=G3lbtVHOqlO5w4/4VTIzsUhn3pEr1KZ39Nfi5EuNHBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIx7duo7ke1gMuKfYGbkHMwKz6Jzl2vUdbAg5L4ZvOfKj6YIeBRV3q9w+KV8bRwYDaBwoDLbYG0fWsgPTLaioYjUuhTdDy3OtQsBo8G6nOpl/odmgLCYmIyoTr7+zhZbKVcZo11BPHGpNATZRcncP6DSPt4bGR4XgxFehF4KLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mm3MFbTu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mm3MFbTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246B4C2BCB0
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 03:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773200172;
	bh=G3lbtVHOqlO5w4/4VTIzsUhn3pEr1KZ39Nfi5EuNHBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mm3MFbTuqFNLpmkVcmEkEor190dzL1dYrNfxUfMKc6Jn6qKBL+7HTBN0waFk5IpSS
	 6MNwjNWxvbJL+LE3LmVWwxZdKkwWqmfRunJD1cucIgb3UqJC+9Oeqh1JBr8g1tvsdE
	 6josuxQiZGAYEh7vNUsCMdCHCycXgbFwDQ8lecV7rkB7HTd2MdIQMIaYUc5BuwNsa6
	 WYsjYq49SEhqeO/zOw7k5Rq9tBuNWRS1uSAdQCRlCqX6jJSUqz06JgTLkWwdKonDoW
	 fcxw6EwRrPYABsK7xtP5RSXW/fGuAGcxFAAY0GwwtZMwVet8XZkvJRVpdfA3+/Q4ip
	 NInf6PY87npGw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6615c766e60so9632328a12.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 20:36:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMOKAXC/l06ce17qAmT+v4hrQrx+UOLhOOyhgLAj2t2J6npHWpVfmKjdlcUXjFEMzv+D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAfyrUyGjUOC/sCA+POSx45fxaKQrXeESP77uzpRrYHp28Kc28
	Wwj+SReW7VOf5jz8VSqP0WiGbXixZuN6N92BBgjbQmifTQtmWhyiEVPDBDrobDqv/m8FNxz97zC
	HeCLsjjfAVgZuVcNDCb8yhmxTRxew8fw=
X-Received: by 2002:a05:6402:26c4:b0:64b:7f98:c7e with SMTP id
 4fb4d7f45d1cf-663194cbe6dmr403091a12.1.1773200170607; Tue, 10 Mar 2026
 20:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311031857.3591470-1-maobibo@loongson.cn> <20260311031857.3591470-4-maobibo@loongson.cn>
In-Reply-To: <20260311031857.3591470-4-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 11 Mar 2026 11:35:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6p=bArdYHkE-0s55Ogvm+Dtv8TVVCLAHGeqA-pnPOXwA@mail.gmail.com>
X-Gm-Features: AaiRm51EAlIWsRIpqoPTR0FY_eDtNJSwTsPMu6u0RqGl8h9Wro4zNZuQpD3pLio
Message-ID: <CAAhV-H6p=bArdYHkE-0s55Ogvm+Dtv8TVVCLAHGeqA-pnPOXwA@mail.gmail.com>
Subject: Re: [PATCH 3/3] LoongArch: KVM: Set vcpu_is_preempted() macro rather
 than function
To: Bibo Mao <maobibo@loongson.cn>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, kernel@xen0n.name, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Wed, Mar 11, 2026 at 11:21=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> vcpu_is_preempted() is performance sensitive called in function
> osq_lock(), here set it as macro. So that parameter is not parsed
> at most time, it can avoid cache line thrashing across numa node.
I remember that I had suggested you define vcpu_is_preempted() in the
header file but you refused.

Huacai

>
> Here is part of unixbench result on 3C5000 DualWay machine with 32
> Cores and 2 Numa node.
>           origin    with patch    CONFIG_PARAVIRT disabled
> execl     6871.9    7134.2        7190.8
> fstime    425.5     959.9         956.1
>
> From the test result, with macro method it is almost the same with
> CONFIG_PARAVIRT disabled, and there is some improvment compared with
> function method.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/qspinlock.h | 27 +++++++++++++++++++++-----
>  arch/loongarch/kernel/paravirt.c       | 15 ++------------
>  2 files changed, 24 insertions(+), 18 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/incl=
ude/asm/qspinlock.h
> index 66244801db67..305afd37cdcb 100644
> --- a/arch/loongarch/include/asm/qspinlock.h
> +++ b/arch/loongarch/include/asm/qspinlock.h
> @@ -5,8 +5,10 @@
>  #include <linux/jump_label.h>
>
>  #ifdef CONFIG_PARAVIRT
> -
> +#include <asm/kvm_para.h>
>  DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
> +DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
> +DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
>
>  #define virt_spin_lock virt_spin_lock
>
> @@ -34,10 +36,25 @@ static inline bool virt_spin_lock(struct qspinlock *l=
ock)
>         return true;
>  }
>
> -#define vcpu_is_preempted vcpu_is_preempted
> -
> -bool vcpu_is_preempted(int cpu);
> -
> +/*
> + * Macro is better than inline function here
> + * With inline function, parameter cpu is parsed even though it is not u=
sed.
> + * This may cause cache line thrashing across NUMA node.
> + * With macro method, parameter cpu is parsed only when it is used.
> + */
> +#define vcpu_is_preempted(cpu)                                         \
> +({                                                                     \
> +       bool __val;                                                     \
> +                                                                       \
> +       if (!static_branch_unlikely(&virt_preempt_key))                 \
> +               __val =3D false;                                         =
 \
> +       else {                                                          \
> +               struct kvm_steal_time *src;                             \
> +               src =3D &per_cpu(steal_time, cpu);                       =
 \
> +               __val =3D !!(src->preempted & KVM_VCPU_PREEMPTED);       =
 \
> +       }                                                               \
> +       __val;                                                          \
> +})
>  #endif /* CONFIG_PARAVIRT */
>
>  #include <asm-generic/qspinlock.h>
> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/par=
avirt.c
> index b74fe6db49ab..2d1206e486e2 100644
> --- a/arch/loongarch/kernel/paravirt.c
> +++ b/arch/loongarch/kernel/paravirt.c
> @@ -10,8 +10,8 @@
>  #include <asm/paravirt.h>
>
>  static int has_steal_clock;
> -static DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
> -static DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
> +DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
> +DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
>  DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
>
>  static bool steal_acc =3D true;
> @@ -261,17 +261,6 @@ static int pv_time_cpu_down_prepare(unsigned int cpu=
)
>         return 0;
>  }
>
> -bool vcpu_is_preempted(int cpu)
> -{
> -       struct kvm_steal_time *src;
> -
> -       if (!static_branch_unlikely(&virt_preempt_key))
> -               return false;
> -
> -       src =3D &per_cpu(steal_time, cpu);
> -       return !!(src->preempted & KVM_VCPU_PREEMPTED);
> -}
> -EXPORT_SYMBOL(vcpu_is_preempted);
>  #endif
>
>  static void pv_cpu_reboot(void *unused)
> --
> 2.39.3
>
>
