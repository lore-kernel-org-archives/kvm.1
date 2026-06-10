Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB2B3B19A8
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082693; cv=none; b=D/mReCoKgMkyOQ61bDxFtyZSRqdFITFW2iq9A+mX9Bymvz6h8ht5912TCBPdLCT7IBVJrR/S+7JfD1/iC0hLjwLEdyJ6UAZJM0tzkthcx1Fbo5FP8NTj7lVcOnPI+4Hjd2uwt+/kncBJFicE6mTt40W9izdk7e28BCcZuHD6CSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082693; c=relaxed/simple;
	bh=dadgJbnRTYQ1rz2/9PHuyR3TAlWs1uTRv5bASghSU5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTcK4eoExTkkwb0tKVJuiC0NGD5NbJebGfcAdIbQUZ8uLoS9lsrhCAjiQxqVSI+i1G9Ww74zQPBA6DnA5jHUphtJQqzg5yNz6qDPxG7RYi/5/0af0q0MAhGGFqvk36auEhPPcr/MlywgAZB09OLqEWZ2EmJftB7s+Uo3nKX4S4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2e91mw8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2e91mw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2461F00893
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781082691;
	bh=R2vpCuAgnwmJOPkYcqw6QnIp6UBB/1oC5OiuKjowSiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=h2e91mw8khkrrE40K75/SdqZP3o4d0cmeWMXzNhGFUCIt0rwQspDpxA6O0X9uFqeC
	 TX3zM0+P/OLI5iiiqMqUvtsEN/FJ5VeAm0SqYNlthMGtOo7VNQHwXG61VO2QjfkUsu
	 rtzF0zETIllQQyoiUhGRKk0OAeMTaNzVcDt9jXgkKyymWStxp+udhibb/j7g5xLBiq
	 NR3lqWdZpA6Z6EWjA10tyCR2HM1XQorsvj8THaLg5x6bsT2EXb3HPmNN17j5JtzU4P
	 a9MX3rPI/fu7fr/jYVSUa81P4wxsUJu657pJOpFtTnMSUJwv91ZMNzIja/ym7kEH1s
	 vLZfONbU0zLfQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6870ad8072eso2541675a12.0
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 02:11:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8PSVkDXm2JPXIeK0XW3y6T7PyA8OKV4q/dHyLBtpWGHXDULAQM0fSiIvklhBav0YE9VH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCC2shrTXNnf+AfwQjjb6LXdC7Xutg3Oj1qAR9HK42X6HDQAjs
	xFpDEzXvraxs039cFfzeUPLGal98CojB+WYwg0tA81A/v4Vv5lKPmpt2m9rLvk2EiFZZ1WEetwS
	RYm3YENTB9zv+s30+ZIW/KojSkFWW61E=
X-Received: by 2002:a05:6402:e9f:b0:688:e4c6:fd1c with SMTP id
 4fb4d7f45d1cf-68ff1d404d3mr8669214a12.8.1781082689746; Wed, 10 Jun 2026
 02:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526125256.2511876-1-maobibo@loongson.cn> <20260526125256.2511876-4-maobibo@loongson.cn>
 <CAAhV-H5Bkg1MrWr_8YcvCdHWAfX_-WLzdFGukJQVu330LoL5KA@mail.gmail.com>
 <d5722640-538c-4a97-7dff-bcec91a4c955@loongson.cn> <CAAhV-H6TfJ8c8SmLZ=9PtGPWWOjSTQD=utHVp5aoEa5ZoO71Cw@mail.gmail.com>
 <e228286e-7008-e66b-18b3-1140b2916f0e@loongson.cn> <CAAhV-H5gLxujRbS01zXjeof-F5RYw2MhMm-in8p83chfTt=0=w@mail.gmail.com>
 <ec8614d5-ed40-d2b9-37c7-6f04b6bd010f@loongson.cn> <CAAhV-H7M3Gbv8dXP=KnKzRSLJn5QoZt_hJvmuMmTL_MWo7gk0A@mail.gmail.com>
 <a1e65711-957f-2ff1-91e0-b1a93b687acb@loongson.cn>
In-Reply-To: <a1e65711-957f-2ff1-91e0-b1a93b687acb@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 10 Jun 2026 17:11:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4XFbnNssUcnzhq2JQkSVqpJsTCb_+UM=F_A40oR=53qQ@mail.gmail.com>
X-Gm-Features: AVVi8CcA_su6sxGhh4Ew3czMYp4UHCTsfgzN6eN1ZGcE-sd5vYy4kKHpKozFbMg
Message-ID: <CAAhV-H4XFbnNssUcnzhq2JQkSVqpJsTCb_+UM=F_A40oR=53qQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] LoongArch: KVM: Use existing macro about interrupt
 bit mask
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 5:01=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2026/6/6 =E4=B8=8B=E5=8D=886:03, Huacai Chen wrote:
> > On Thu, Jun 4, 2026 at 9:51=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> On 2026/6/3 =E4=B8=8B=E5=8D=8810:23, Huacai Chen wrote:
> >>> On Tue, Jun 2, 2026 at 4:13=E2=80=AFPM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2026/6/2 =E4=B8=8B=E5=8D=881:01, Huacai Chen wrote:
> >>>>> On Tue, Jun 2, 2026 at 9:39=E2=80=AFAM Bibo Mao <maobibo@loongson.c=
n> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2026/6/1 =E4=B8=8B=E5=8D=889:50, Huacai Chen wrote:
> >>>>>>> Hi, Bibo,
> >>>>>>>
> >>>>>>> On Tue, May 26, 2026 at 8:53=E2=80=AFPM Bibo Mao <maobibo@loongso=
n.cn> wrote:
> >>>>>>>>
> >>>>>>>> With interrupt post, register CSR_GINTC and CSR_ESTAT is used, a=
nd
> >>>>>>>> CSR_ESTAT is used for percpu interrupt injection and CSR_GINTC i=
s for
> >>>>>>>> external hardware interrupt injection.
> >>>>>>>>
> >>>>>>>> Here use existing macro about interrupt bit of register CSR_GINT=
C and
> >>>>>>>> CSR_ESTAT, rather than hard coded constant value.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>>>>>> ---
> >>>>>>>>      arch/loongarch/include/asm/kvm_vcpu.h | 43 ++++++++++++++++=
++---------
> >>>>>>>>      1 file changed, 29 insertions(+), 14 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loonga=
rch/include/asm/kvm_vcpu.h
> >>>>>>>> index 3784ab4ccdb5..efe26b04b35f 100644
> >>>>>>>> --- a/arch/loongarch/include/asm/kvm_vcpu.h
> >>>>>>>> +++ b/arch/loongarch/include/asm/kvm_vcpu.h
> >>>>>>>> @@ -10,22 +10,37 @@
> >>>>>>>>      #include <asm/loongarch.h>
> >>>>>>>>
> >>>>>>>>      /* Controlled by 0x5 guest estat */
> >>>>>>>> -#define CPU_SIP0                       (_ULCAST_(1))
> >>>>>>>> -#define CPU_SIP1                       (_ULCAST_(1) << 1)
> >>>>>>>> -#define CPU_PMU                                (_ULCAST_(1) << =
10)
> >>>>>>>> -#define CPU_TIMER                      (_ULCAST_(1) << 11)
> >>>>>>>> -#define CPU_IPI                                (_ULCAST_(1) << =
12)
> >>>>>>>> -#define CPU_AVEC                        (_ULCAST_(1) << 14)
> >>>>>>>> +#define CPU_SIP0                       BIT(INT_SWI0)
> >>>>>>>> +#define CPU_SIP1                       BIT(INT_SWI1)
> >>>>>>>> +#define CPU_HWI0                       BIT(INT_HWI0)
> >>>>>>>> +#define CPU_HWI1                       BIT(INT_HWI1)
> >>>>>>>> +#define CPU_HWI2                       BIT(INT_HWI2)
> >>>>>>>> +#define CPU_HWI3                       BIT(INT_HWI3)
> >>>>>>>> +#define CPU_HWI4                       BIT(INT_HWI4)
> >>>>>>>> +#define CPU_HWI5                       BIT(INT_HWI5)
> >>>>>>>> +#define CPU_HWI6                       BIT(INT_HWI6)
> >>>>>>>> +#define CPU_HWI7                       BIT(INT_HWI7)
> >>>>>>>> +#define CPU_PMU                                BIT(INT_PCOV)
> >>>>>>>> +#define CPU_TIMER                      BIT(INT_TI)
> >>>>>>>> +#define CPU_IPI                                BIT(INT_IPI)
> >>>>>>>> +#define CPU_AVEC                       BIT(INT_AVEC)
> >>>>>>>> +#define KVM_ESTAT_IRQ_MASK             (CPU_SIP0 | CPU_SIP1 | C=
PU_PMU | CPU_TIMER \
> >>>>>>>> +                                               | CPU_IPI | CPU_=
AVEC)
> >>>>>>>> +#define KVM_ESTAT_HWI_MASK             (CPU_HWI0 | CPU_HWI1 | C=
PU_HWI2 | CPU_HWI3 \
> >>>>>>>> +                                               | CPU_HWI4 | CPU=
_HWI5 | CPU_HWI6 | CPU_HWI7)
> >>>>>>>>
> >>>>>>>>      /* Controlled by 0x52 guest exception VIP aligned to estat =
bit 5~12 */
> >>>>>>>> -#define CPU_IP0                                (_ULCAST_(1))
> >>>>>>>> -#define CPU_IP1                                (_ULCAST_(1) << =
1)
> >>>>>>>> -#define CPU_IP2                                (_ULCAST_(1) << =
2)
> >>>>>>>> -#define CPU_IP3                                (_ULCAST_(1) << =
3)
> >>>>>>>> -#define CPU_IP4                                (_ULCAST_(1) << =
4)
> >>>>>>>> -#define CPU_IP5                                (_ULCAST_(1) << =
5)
> >>>>>>>> -#define CPU_IP6                                (_ULCAST_(1) << =
6)
> >>>>>>>> -#define CPU_IP7                                (_ULCAST_(1) << =
7)
> >>>>>>>> +#define GINTC_VIP_DELTA                        (INT_HWI0 - CSR_=
GINTC_VIP_SHIFT)
> >>>>>>> Don't use too many wrappers, just use INT_HWI0 instead of
> >>>>>>> GINTC_VIP_DELTA in this series is perfect. In other places INT_SW=
I0 is
> >>>>>>> also used for shifts.
> >>>>>>
> >>>>>> The above macro definition is a little complicated, I do not know =
how to
> >>>>>> optimize it. do you mean remove GINTC_VIP_DELTA just use 2 such as=
:
> >>>>>> #define CPU_IP0                       BIT(INT_HWI0 - 2)
> >>>>> CSR_GINTC_VIP_SHIFT is 0 and GINTC_VIP_DELTA is equal to INT_HWI0. =
I
> >>>>> mean remove the GINTC_VIP_DELTA definition and use INT_HWI0 instead=
.
> >>>> For macro definition such CPU_IP0, GINTC_VIP_DELTA can be removed. A=
nd
> >>>> define it as follows directly.
> >>>> #define CPU_IP0                       BIT(0)
> >>>>
> >>>> However GINTC_VIP_DELTA is still useful, because bitmap with HWI0-HW=
I7
> >>>> in estat register starts from INT_HWI0, however with register gintc =
it
> >>>> starts from CSR_GINTC_VIP_SHIFT.
> >>>>
> >>>> For example with _kvm_getcsr() API, it is to get interrupt status. H=
ere
> >>>> is the example code.
> >>>> gintc =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC)& KVM_GINTC_IRQ_=
MASK;
> >>>> estat =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT) &~KVM_ESTAT_HWI=
_MASK;
> >>>> *val =3D estat | (gintc << GINTC_VIP_DELTA);
> >>>>
> >>>> Remove GINTC_VIP_DELTA and use INT_HWI0 directly, it will be
> >>>> *val =3D estat | (gintc << INT_HWI0);
> >>>>
> >>>> I do not know what is the meaning about "gintc << INT_HWI0", especia=
lly
> >>>> if the value of CSR_GINTC_VIP_SHIFT is no zero.
> >>> In your Patch-2 there is "clear_csr_estat(1 << INT_SWI0)", INT_SW0 an=
d
> >>> INT_HW0 are good friends. Why "1 << INT_SWI0" is acceptable but
> >>> "gintc << INT_HWI0" is not?
> >>
> >> The bit definition INT_SWI0 is for ESTAT register, is that right?
> >>
> >> The bitmap mask KVM_GINTC_IRQ_MASK is for GINTC register, to convert t=
o
> >> bitmap mask of ESTAT,  should not be (gintc >> CSR_GINTC_VIP_SHIFT) <<
> >> INT_HWI0? why CSR_GINTC_VIP_SHIFT is discarded here, just because it i=
s
> >> zero?
> > Yes, this is a reason,  but if you insist on, the macro can be
> > defined, but the name can be changed.
> yes, I want to use one macro describe the delta value.
>
> >
> > In theory, it is VIP_DELTA_BETWEEN_ESTAT_AND_GINTC, but we can just
> > use VIP_DELTA for short because CPU_IP0, CPU_IP1 .... also don't have
> > a "GINTC_" prefix.
> yes, prefix GINTC_ should be removed. VIP_DELTA_BETWEEN_ESTAT_AND_GINTC
> is a little long, how about KVM_VIP_DELTA or others for short.
This is a definition for hardware, not for KVM, so I prefer VIP_DELTA,
but KVM_VIP_DELTA is also OK.

>
> >
> > And KVM_ESTAT_IRQ_MASK is not suitable. In theory SWI and HWI are both
> > IRQ, so you cannot use KVM_ESTAT_IRQ_MASK to stand for the rest IRQ
> > bits of KVM_ESTAT_HWI_MASK.
> >
> > Yes, KVM_ESTAT_SWI_MASK is also not suitable because TI, IPI are
> > "hardware interrupts" indeed, but KVM_ESTAT_SWI_MASK is still better
> > than KVM_ESTAT_IRQ_MASK.
> >
> > A even better distinction is using "internal interrupts" and "external
> > interrupts" to describe, so KVM_ESTAT_INTI_MASK and
> > KVM_ESTAT_EXTI_MASK can be considered.
> KVM_ESTAT_EXTI_MASK is ok for me. With KVM_ESTAT_INTI_MASK, how about
> KVM_ESTAT_PPI_MASK or KVM_ESTAT_CPU_MASK to emphasize percpu interrupt?
> I am not name specialist, just a suggestion, or other names will be bette=
r.
PPI is hard to understand, CPU loses the "interrupt" information, so I
think KVM_ESTAT_INTI_MASK is better.

Though INT in INTI may be misunderstood, but it is defined near EXTI
so I think we needn't worry.


Huacai

>
> Regards
> Bibo Mao
> >
> >
> > Huacai
> >
> >>
> >>>
> >>> Huacai
> >>>
> >>>>
> >>>> Regards
> >>>> Bibo Mao
> >>>>>
> >>>>>
> >>>>> Huacai
> >>>>>
> >>>>>>
> >>>>>> or something like this:
> >>>>>> #define CPU_IP0                       (CPU_HWI0 >> GINTC_VIP_DELTA=
)
> >>>>>>
> >>>>>> Regards
> >>>>>> Bibo Mao
> >>>>>>>
> >>>>>>>
> >>>>>>> Huacai
> >>>>>>>
> >>>>>>>> +#define CPU_IP0                                BIT(INT_HWI0 - G=
INTC_VIP_DELTA)
> >>>>>>>> +#define CPU_IP1                                BIT(INT_HWI1 - G=
INTC_VIP_DELTA)
> >>>>>>>> +#define CPU_IP2                                BIT(INT_HWI2 - G=
INTC_VIP_DELTA)
> >>>>>>>> +#define CPU_IP3                                BIT(INT_HWI3 - G=
INTC_VIP_DELTA)
> >>>>>>>> +#define CPU_IP4                                BIT(INT_HWI4 - G=
INTC_VIP_DELTA)
> >>>>>>>> +#define CPU_IP5                                BIT(INT_HWI5 - G=
INTC_VIP_DELTA)
> >>>>>>>> +#define CPU_IP6                                BIT(INT_HWI6 - G=
INTC_VIP_DELTA)
> >>>>>>>> +#define CPU_IP7                                BIT(INT_HWI7 - G=
INTC_VIP_DELTA)
> >>>>>>>> +#define KVM_GINTC_IRQ_MASK             (CPU_IP0 | CPU_IP1 | CPU=
_IP2 | CPU_IP3 \
> >>>>>>>> +                                               | CPU_IP4 | CPU_=
IP5 | CPU_IP6 | CPU_IP7)
> >>>>>>>>
> >>>>>>>>      #define MNSEC_PER_SEC                  (NSEC_PER_SEC >> 20)
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> 2.39.3
> >>>>>>>>
> >>>>>>>>
> >>>>>>
> >>>>>>
> >>>>
> >>>>
> >>
>
>
