Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32009126F3B
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 04:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773203935; cv=none; b=rlS07VesEPiKDrVurdTeV0Jrdjcm+981gSRsR9pJJ5TcLYpBOMQs0sjruYzWSaYFa0HTxSrc7McOE+TKfZawzloHm6uhxxlBBX9bICRqAkNTaNeQfIiPgpJMMy03iYAQTZm4Z1kU7WIXoUlQPF2bLhINJA84bkZeJyL0hrHWLKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773203935; c=relaxed/simple;
	bh=FYjkf/XPpQAQYCZ7NH+ogPLzbLlfLoodh05/RH99ZuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRxLAFFFrRhsGAzpxmunb4bnzP0a2KB0F4dYWbQ8dg2GKqubKOBojEid+gKZbt42fqWdy1+Nf8xo7Hw65VqmBf2kmCTpohZLyikbdyTuYE5EdW6XFBK0aHbe04sQUbU9LVDZqKHjBk6bOMwXEVf41jreMcl5jC9xpfO7EbGT1y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFMLl2Ya; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFMLl2Ya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8201C4CEF7
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 04:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773203934;
	bh=FYjkf/XPpQAQYCZ7NH+ogPLzbLlfLoodh05/RH99ZuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RFMLl2YaWFAeRNkO2F7N2pp92mCiUkPEkgOxEC3BHzwjtEgj/0Dxrefx3G7f1ydwY
	 0L2P1mi2+KVYlIasrItn+FoE9x6EFF6v9U4J++n5leta+WfARxM/n7134nC2nUOnKp
	 POAxXfZk4gfC30pqGrXGJa9TVYUIqkTKF7oMqM6klkyDWYOa9mf2Vr29qNtS7VxLHL
	 r854JUt1Gq1XjOtchkYMsEr7oRoKbO/on8zYaZ2wo3oyqGuXSUleb/5lClbA3DBl8y
	 AjtMPlPiZlYTG8ws69rgviip9RgE/bl9/p6TsROyckfkkgK/VPxHTNYbm/At986hoG
	 aSdUoum5VtqCQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6616cb8c80cso8930863a12.0
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 21:38:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXffdZI1D0tsZp1BYVMC8kACdXu6zuQYa2iGjB6LnKWREHp9kYP/8IekP4O4k1EGYRKJ0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSTM1wBj7PaznU3vyPbuVmqTQPDqt3cirUbhOA6P/fjg2C6sE7
	NkglYbwHH8HhOYGQO1eqFMuvSv+Te9q2WJV8ghq22CclU/sBCNzmhvabn6o3YhOd2GxSvN7kv0w
	xxbv4bMzDCTdwqTYV/zCORMQ2x0/92T4=
X-Received: by 2002:a05:6402:210b:b0:660:ce49:f6b6 with SMTP id
 4fb4d7f45d1cf-6631a8d3a69mr569779a12.29.1773203933374; Tue, 10 Mar 2026
 21:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311031857.3591470-1-maobibo@loongson.cn> <20260311031857.3591470-4-maobibo@loongson.cn>
 <CAAhV-H6p=bArdYHkE-0s55Ogvm+Dtv8TVVCLAHGeqA-pnPOXwA@mail.gmail.com> <7f4c6ef8-b24f-88c5-82f2-e00d1629ae4c@loongson.cn>
In-Reply-To: <7f4c6ef8-b24f-88c5-82f2-e00d1629ae4c@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 11 Mar 2026 12:38:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H499qApb0sW-HcyrHQS1Sn2gDp9jHVFahNz-u0GoLCLng@mail.gmail.com>
X-Gm-Features: AaiRm53pfc-DYY1bOysrdNJaqZFfDCvHHbBhyCftOy-jfqFYG1KhG_ln48PSw6w
Message-ID: <CAAhV-H499qApb0sW-HcyrHQS1Sn2gDp9jHVFahNz-u0GoLCLng@mail.gmail.com>
Subject: Re: [PATCH 3/3] LoongArch: KVM: Set vcpu_is_preempted() macro rather
 than function
To: Bibo Mao <maobibo@loongson.cn>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, kernel@xen0n.name, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 11:51=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
>
>
> On 2026/3/11 =E4=B8=8A=E5=8D=8811:35, Huacai Chen wrote:
> > Hi, Bibo,
> >
> > On Wed, Mar 11, 2026 at 11:21=E2=80=AFAM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>
> >> vcpu_is_preempted() is performance sensitive called in function
> >> osq_lock(), here set it as macro. So that parameter is not parsed
> >> at most time, it can avoid cache line thrashing across numa node.
> > I remember that I had suggested you define vcpu_is_preempted() in the
> > header file but you refused.
> yes, I refuse then, that is a tragedy, I am sorry for that:(
>
> By some benchmarks, vcpu_is_preempted() is called in busy-loop method,
> more obvious with more CPUs, it may be a bottleneck.
I also remember that you said the static key and percpu steal_time
structure should be EXPORT_SYMBOL, but you haven't done this patch.

Huacai

>
> Regards
> Bibo Mao
>
> >
> > Huacai
> >
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
> >> index 66244801db67..305afd37cdcb 100644
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
> >> +               __val =3D !!(src->preempted & KVM_VCPU_PREEMPTED);    =
    \
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
> >>
>
>
