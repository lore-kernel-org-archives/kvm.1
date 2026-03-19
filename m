Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9923CF678
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773924490; cv=none; b=h+Ra2n1nYTAXgr37jbMEvhC7tj3ZI4teZZtR0AjX1arKW5njL4uUfFY+Aj08guytw8fnSl5N2iW8sI1U4MWexV01UFEElTnaDDK+d+HoZPvEtuwB/KYrZM7+fKHe/6gS4mXzMMuGV6VlWud5zaoin3NlTGPs30i2V1J+wEcqv7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773924490; c=relaxed/simple;
	bh=SbqkXRq0ja7cuWUf0xeeaWfYZjGP/+SIq83A5PorvrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDBW0gl/O5GROdGnpwqOTNjEPGfa7PTcdjVCQK/8MNuifA7BwZHA0BrHBgspkJz5L4FvoaDovSDlNmY07+MdJij5pe6JXwu/OVKQX9xa/JB3Re3HpvUKw0opeStxitI7F0j/zYnX0a/Rz4UZvd1gZHqD/rQ2ej/XjU+lLFRP4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFaGZW4m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFaGZW4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A64CC2BCB4
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 12:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773924490;
	bh=SbqkXRq0ja7cuWUf0xeeaWfYZjGP/+SIq83A5PorvrI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uFaGZW4mTxE9PZP/AWRdmxnMQKqR/DSAEjuqBt+NSOgYTOiyDBLEirwsSl6SM5oBp
	 L6afgm2ktQasjOnpAO41M7KBVwzYxEdoabeKmY+BudmqYdTorKUrg1DL3IRprsm/Lf
	 iJGWBS4Iht0zYuI5V6cRSx7T8wC7Nr9Yv4KDVaeFdNMVHv36e4+VFJPjdfRQC1DcT7
	 em3fi/LmvTZXQqexKST2GwrrZ0R/WCmHIh8GenskLSd58t3Kdk5SlyJMNOQiyABHi2
	 pFHNDxJjuNeaIMKEByu4sPXSVZ+GH0xZC8906ppVAebN2ZX1oMvuEpr+NZVLoKFrhn
	 EE9SFATzB272Q==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-664f8bef4e7so1307983a12.3
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 05:48:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDhYoLznoDBWO6hYeaBVNwiuJefdie2lNuWDhNCrQGjzBTk62PcdR+cpL/L6HdvtWk/V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVoPyv3zcZ4RhuGbB/UaGQeQ+utiHpPqVYzDHnYxb6TBJH7pb
	pYQbRsQi/fpDuAa3zFGGLK2YBh2J/YOmOy3GcaBEdI+c+gWlXw0329OhV2zbyi51e/TNbgs3ELh
	DivDDiFjD9/RHiIf4z+/gJyPGSeIqJIo=
X-Received: by 2002:a17:907:84d:b0:b88:4e52:bfb6 with SMTP id
 a640c23a62f3a-b97f4a32186mr445503566b.56.1773924488971; Thu, 19 Mar 2026
 05:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317092911.1400248-1-maobibo@loongson.cn> <20260317092911.1400248-4-maobibo@loongson.cn>
In-Reply-To: <20260317092911.1400248-4-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 19 Mar 2026 20:48:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5aKoTTdjwzco6Yv84SJgtt0Eq9xXNp6PkcDaxM+H9gZw@mail.gmail.com>
X-Gm-Features: AaiRm52d-uldn0ip33KfjiXps4IIs4qKy6WU0XqqA5mEV-xxXTSUXsRS0e_xaOA
Message-ID: <CAAhV-H5aKoTTdjwzco6Yv84SJgtt0Eq9xXNp6PkcDaxM+H9gZw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] LoongArch: KVM: Set vcpu_is_preempted() macro
 rather than function
To: Bibo Mao <maobibo@loongson.cn>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, kernel@xen0n.name, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Tue, Mar 17, 2026 at 5:29=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> vcpu_is_preempted() is performance sensitive called in function
> osq_lock(), here set it as macro. So that parameter is not parsed
> at most time, it can avoid cache line thrashing across numa node.
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
> index 66244801db67..b5d7a038faf1 100644
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
What is the test result with inline function? If it isn't
significantly worse than with macro, we usually prefer inline
functions.



Huacai

> + */
> +#define vcpu_is_preempted(cpu)                                          =
       \
> +({                                                                      =
       \
> +       bool __val;                                                      =
       \
> +                                                                        =
       \
> +       if (!static_branch_unlikely(&virt_preempt_key))                  =
       \
> +               __val =3D false;                                         =
         \
> +       else {                                                           =
       \
> +               struct kvm_steal_time *src;                              =
       \
> +               src =3D &per_cpu(steal_time, cpu);                       =
         \
> +               __val =3D !!(READ_ONCE(src->preempted) & KVM_VCPU_PREEMPT=
ED);     \
> +       }                                                                =
       \
> +       __val;                                                           =
       \
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
