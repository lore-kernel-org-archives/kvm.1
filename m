Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7AD219EB
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864842; cv=none; b=Y32bIfe/XzMva+30ECMvkH8fypwqYrtxAD8tYdeHW6I3wKMPGs21JRaswL1lyLUaZHXYRYhOh+Xwezh4zKlui6AwxKfmum1MNd1KcSWo1INHPRxQ2N6r8QLGGUjRHHHsbjV8xR7FuaN1D3R9dE14lHYcIgZ0bgzyrk71GXisgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864842; c=relaxed/simple;
	bh=iT+7QNViXsTcoOKSMxkSl/3+K2MWnvxdMNvdPB5bHcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K89/lUSFOBwfv5t6Zg5lkr5z9+vuycN6f+E4XwjT/5alYdjw6JKTsFTb+acbiDk0FwLzelSPq8JByoeO2uAvN9uDXsQKWzf6/PztknNaPyz0DOrzUt8le3ntXIcikDhkXFgLHogZy2WKar14heXTTcwxem1OTF2zIt5Kth29pcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE7iiVNV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE7iiVNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED33C2BCB2
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 10:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774864842;
	bh=iT+7QNViXsTcoOKSMxkSl/3+K2MWnvxdMNvdPB5bHcQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oE7iiVNVBRAlawKfDAK9EvQZGSVLSiVIwPPkwWKJnC8L5j3ivDZXsN+W7VEH4370o
	 59E8U6ZL5P8/PfohkD2cJhRqzbUC9BgceGGyp72MTijFUoiXUNqR2ea2TzRqV2kS3r
	 u6j134mrZ7IEPtUvJ/yUb5ytiy896P7QbUO1rHT+6dWZUdUrxAYntL230FETLgTEs6
	 ft3C0rLrku8xCnxl5zy0d2dpDRu8TJNkpJk7G+01ZRI5h9g+Dm/Lt1e9kyQYA8+snr
	 4XHLJEBqTFhoC1Kged0uK006jHJr21swnw7zH374Krm68JpB4z89aDvGdShFoqrq8o
	 7LpCWBUS+XiLw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b982d56dac4so730665966b.3
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 03:00:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWh++A/QEpPU5oCrpfTxHzMN36srHPG3GRNg05eV5JlyGAKw3H0846XX+9hIdDtLCoLSB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Ylw9ltUbqvSVnE3OHVxUg0Le0Kx0Fa9MWHyVg22+FtVI++jC
	sIpELZ6kzKxB6LpOXt+2ty0D7vs1GXZSYuzc8AL85V6G8otZmxwhR61I5/ILdMHEzq0uKOCn9ZM
	u8aW0oYp4P98fAdp1PEHHqKzCvguvd5g=
X-Received: by 2002:a17:907:98c:b0:b98:4d0c:db53 with SMTP id
 a640c23a62f3a-b9b502ba4c7mr840767066b.5.1774864841054; Mon, 30 Mar 2026
 03:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317092911.1400248-1-maobibo@loongson.cn> <20260317092911.1400248-4-maobibo@loongson.cn>
 <CAAhV-H5aKoTTdjwzco6Yv84SJgtt0Eq9xXNp6PkcDaxM+H9gZw@mail.gmail.com> <6118cbb5-f895-e04d-7b76-91f9e9ad3b05@loongson.cn>
In-Reply-To: <6118cbb5-f895-e04d-7b76-91f9e9ad3b05@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 30 Mar 2026 18:00:40 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5J-jaej47xSq6F8_Y6nTSJW3pJ=kd9sTAUxdKegmG+Yw@mail.gmail.com>
X-Gm-Features: AQROBzAn0W7QhJcUx1GSS-jyygZuq4-ybJ3Fza69ajKjVfi-Lp2YsovBU6aP23Y
Message-ID: <CAAhV-H5J-jaej47xSq6F8_Y6nTSJW3pJ=kd9sTAUxdKegmG+Yw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] LoongArch: KVM: Set vcpu_is_preempted() macro
 rather than function
To: Bibo Mao <maobibo@loongson.cn>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, kernel@xen0n.name, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 11:01=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
>
>
> On 2026/3/19 =E4=B8=8B=E5=8D=888:48, Huacai Chen wrote:
> > Hi, Bibo,
> >
> > On Tue, Mar 17, 2026 at 5:29=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> =
wrote:
> >>
> >> vcpu_is_preempted() is performance sensitive called in function
> >> osq_lock(), here set it as macro. So that parameter is not parsed
> >> at most time, it can avoid cache line thrashing across numa node.
> >>
> >> Here is part of unixbench result on 3C5000 DualWay machine with 32
> >> Cores and 2 Numa node.
> >>            origin    with patch    CONFIG_PARAVIRT disabled
> >> execl     6871.9    7134.2        7190.8
> >> fstime    425.5     959.9         956.1
> >>
> >>  From the test result, with macro method it is almost the same with
> >> CONFIG_PARAVIRT disabled, and there is some improvment compared with
> >> function method.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   arch/loongarch/include/asm/qspinlock.h | 27 +++++++++++++++++++++---=
--
> >>   arch/loongarch/kernel/paravirt.c       | 15 ++------------
> >>   2 files changed, 24 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/i=
nclude/asm/qspinlock.h
> >> index 66244801db67..b5d7a038faf1 100644
> >> --- a/arch/loongarch/include/asm/qspinlock.h
> >> +++ b/arch/loongarch/include/asm/qspinlock.h
> >> @@ -5,8 +5,10 @@
> >>   #include <linux/jump_label.h>
> >>
> >>   #ifdef CONFIG_PARAVIRT
> >> -
> >> +#include <asm/kvm_para.h>
> >>   DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
> >> +DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
> >> +DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
> >>
> >>   #define virt_spin_lock virt_spin_lock
> >>
> >> @@ -34,10 +36,25 @@ static inline bool virt_spin_lock(struct qspinlock=
 *lock)
> >>          return true;
> >>   }
> >>
> >> -#define vcpu_is_preempted vcpu_is_preempted
> >> -
> >> -bool vcpu_is_preempted(int cpu);
> >> -
> >> +/*
> >> + * Macro is better than inline function here
> >> + * With inline function, parameter cpu is parsed even though it is no=
t used.
> >> + * This may cause cache line thrashing across NUMA node.
> >> + * With macro method, parameter cpu is parsed only when it is used.
> > What is the test result with inline function? If it isn't
> > significantly worse than with macro, we usually prefer inline
> > functions.
> In the beginning, I had the similar thoughts. And inline function is
> better to maintain, however here is obvious performance gap between
> inline and macro method.
Strange, try __always_inline to replace inline? Maybe inline fails for
some cases?


Huacai

>
> Here is part of unixbench result on 3C5000 DualWay machine with 32
> Cores and 2 Numa node, based on 7.0.0-rc4 kernel version.
> vcpu_is_preempted() is implemented with different methods.
>           origin (function)   inline        macro
> execl     7025.7             6991.2        7242.3
> fstime    474.6              703.1         1071.1
>
> Regards
> Bibo Mao
> >
> >
> >
> > Huacai
> >
> >> + */
> >> +#define vcpu_is_preempted(cpu)                                       =
          \
> >> +({                                                                   =
          \
> >> +       bool __val;                                                   =
          \
> >> +                                                                     =
          \
> >> +       if (!static_branch_unlikely(&virt_preempt_key))               =
          \
> >> +               __val =3D false;                                      =
            \
> >> +       else {                                                        =
          \
> >> +               struct kvm_steal_time *src;                           =
          \
> >> +               src =3D &per_cpu(steal_time, cpu);                    =
            \
> >> +               __val =3D !!(READ_ONCE(src->preempted) & KVM_VCPU_PREE=
MPTED);     \
> >> +       }                                                             =
          \
> >> +       __val;                                                        =
          \
> >> +})
> >>   #endif /* CONFIG_PARAVIRT */
> >>
> >>   #include <asm-generic/qspinlock.h>
> >> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/=
paravirt.c
> >> index b74fe6db49ab..2d1206e486e2 100644
> >> --- a/arch/loongarch/kernel/paravirt.c
> >> +++ b/arch/loongarch/kernel/paravirt.c
> >> @@ -10,8 +10,8 @@
> >>   #include <asm/paravirt.h>
> >>
> >>   static int has_steal_clock;
> >> -static DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64=
);
> >> -static DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
> >> +DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
> >> +DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
> >>   DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
> >>
> >>   static bool steal_acc =3D true;
> >> @@ -261,17 +261,6 @@ static int pv_time_cpu_down_prepare(unsigned int =
cpu)
> >>          return 0;
> >>   }
> >>
> >> -bool vcpu_is_preempted(int cpu)
> >> -{
> >> -       struct kvm_steal_time *src;
> >> -
> >> -       if (!static_branch_unlikely(&virt_preempt_key))
> >> -               return false;
> >> -
> >> -       src =3D &per_cpu(steal_time, cpu);
> >> -       return !!(src->preempted & KVM_VCPU_PREEMPTED);
> >> -}
> >> -EXPORT_SYMBOL(vcpu_is_preempted);
> >>   #endif
> >>
> >>   static void pv_cpu_reboot(void *unused)
> >> --
> >> 2.39.3
> >>
>
>
