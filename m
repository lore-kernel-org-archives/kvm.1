Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09202673B0
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496641; cv=none; b=U3/OZem064I3MfwjV5RPmlmjd8WzuRC5GTdyREUNzTp0ZSyGeECZ1SoVzGEvGoa+Fx4ax5RmViKEwkW4aakrl3q59WpKKdd1j/hIlJtxtrXZDJQ52OFnD2hY1F8iki9KXsU6o2TpTAc2ztTuPCwyQlveFuWdJjJLJBVq7InHWgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496641; c=relaxed/simple;
	bh=tt+lEh+mTUwJv6ojFwkp0UlfGQA/vBCClUsh1Mmahbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKAHGTiBgF1pWdIbAK4o2l9EQuynK2T9e7sLC13QMf/qP92EIjv9iG1KajzH9/MkM+O4meSq0ss+JxjHAfUnol5pPKZOBE3a4FpAdUbftGAqy+b7Jd1aWSE6svj94ijnM79HanR7k5Jn58i5Arba0kg9pyRzxf490DC6EP0tkMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIbldwCu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIbldwCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B0D1F0089A
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 14:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780496639;
	bh=smiEpDnyV2qGRgGe0fQAQ/bIxwjZNYqGUHn7MZyT+LI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DIbldwCuK9S4F0Rrop38lGJdBoFhaFmqp5HXDm5fl7I08zkKjn0ge5odos27ShzHg
	 iYA+LQshzB6fbwQ1iptT2cWNLlj9h1ss95ZDGyO1c8TxLeiV5WZhbuv5fqm11grxyZ
	 oQgPGhzCBmCUI2aZRFqCelM86X9Iocdwfgv8iDmahOMemReV5krY0qmwjNpB/hqywP
	 mk/igpZ9mYEvux6ddLCMYO//Fw6QV1SvPnqc5hyEAMFStX91A2AtXwdm7m4fPmgfrO
	 0gpTYQaFobeY/DOh0M2zF0vihfAgk8StERiKn/1lmDBw2s0jkLoRn2jYq+vH0ivIwt
	 rPGWVk2vJoY/A==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-687e7edaafeso21456470a12.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 07:23:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+2MIAp9pXI7Yy3+G8N8+srbaZB/BirfU5Y49yU+WXwGdsgDXFbuiFb7CQV+6EvZp0fbMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG6YwLzkFjXqhip/G0bfuwBk3LvAbzNp2V5pSPfS+l8x7RU3Y9
	0N6a7Ta8BPukZZMtqIFLDOCWGze4gyn2fD3wx1bnl72dmRfxcMl/3SiPFKbGdHGRH2jBwsUYK/8
	bid2S7b5nAbevVEe5dx6TyAl3RuoHYHo=
X-Received: by 2002:a17:907:68a0:b0:bec:db41:e4ae with SMTP id
 a640c23a62f3a-bf0ab710c02mr118277666b.43.1780496638301; Wed, 03 Jun 2026
 07:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526125256.2511876-1-maobibo@loongson.cn> <20260526125256.2511876-4-maobibo@loongson.cn>
 <CAAhV-H5Bkg1MrWr_8YcvCdHWAfX_-WLzdFGukJQVu330LoL5KA@mail.gmail.com>
 <d5722640-538c-4a97-7dff-bcec91a4c955@loongson.cn> <CAAhV-H6TfJ8c8SmLZ=9PtGPWWOjSTQD=utHVp5aoEa5ZoO71Cw@mail.gmail.com>
 <e228286e-7008-e66b-18b3-1140b2916f0e@loongson.cn>
In-Reply-To: <e228286e-7008-e66b-18b3-1140b2916f0e@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 3 Jun 2026 22:23:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5gLxujRbS01zXjeof-F5RYw2MhMm-in8p83chfTt=0=w@mail.gmail.com>
X-Gm-Features: AVHnY4If1dmqY3MgRa-oawXvb56F7bLohhkJePE51MOyBJqNlcTSLcAWbvbJjOA
Message-ID: <CAAhV-H5gLxujRbS01zXjeof-F5RYw2MhMm-in8p83chfTt=0=w@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] LoongArch: KVM: Use existing macro about interrupt
 bit mask
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:13=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2026/6/2 =E4=B8=8B=E5=8D=881:01, Huacai Chen wrote:
> > On Tue, Jun 2, 2026 at 9:39=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> On 2026/6/1 =E4=B8=8B=E5=8D=889:50, Huacai Chen wrote:
> >>> Hi, Bibo,
> >>>
> >>> On Tue, May 26, 2026 at 8:53=E2=80=AFPM Bibo Mao <maobibo@loongson.cn=
> wrote:
> >>>>
> >>>> With interrupt post, register CSR_GINTC and CSR_ESTAT is used, and
> >>>> CSR_ESTAT is used for percpu interrupt injection and CSR_GINTC is fo=
r
> >>>> external hardware interrupt injection.
> >>>>
> >>>> Here use existing macro about interrupt bit of register CSR_GINTC an=
d
> >>>> CSR_ESTAT, rather than hard coded constant value.
> >>>>
> >>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>> ---
> >>>>    arch/loongarch/include/asm/kvm_vcpu.h | 43 ++++++++++++++++++----=
-----
> >>>>    1 file changed, 29 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/=
include/asm/kvm_vcpu.h
> >>>> index 3784ab4ccdb5..efe26b04b35f 100644
> >>>> --- a/arch/loongarch/include/asm/kvm_vcpu.h
> >>>> +++ b/arch/loongarch/include/asm/kvm_vcpu.h
> >>>> @@ -10,22 +10,37 @@
> >>>>    #include <asm/loongarch.h>
> >>>>
> >>>>    /* Controlled by 0x5 guest estat */
> >>>> -#define CPU_SIP0                       (_ULCAST_(1))
> >>>> -#define CPU_SIP1                       (_ULCAST_(1) << 1)
> >>>> -#define CPU_PMU                                (_ULCAST_(1) << 10)
> >>>> -#define CPU_TIMER                      (_ULCAST_(1) << 11)
> >>>> -#define CPU_IPI                                (_ULCAST_(1) << 12)
> >>>> -#define CPU_AVEC                        (_ULCAST_(1) << 14)
> >>>> +#define CPU_SIP0                       BIT(INT_SWI0)
> >>>> +#define CPU_SIP1                       BIT(INT_SWI1)
> >>>> +#define CPU_HWI0                       BIT(INT_HWI0)
> >>>> +#define CPU_HWI1                       BIT(INT_HWI1)
> >>>> +#define CPU_HWI2                       BIT(INT_HWI2)
> >>>> +#define CPU_HWI3                       BIT(INT_HWI3)
> >>>> +#define CPU_HWI4                       BIT(INT_HWI4)
> >>>> +#define CPU_HWI5                       BIT(INT_HWI5)
> >>>> +#define CPU_HWI6                       BIT(INT_HWI6)
> >>>> +#define CPU_HWI7                       BIT(INT_HWI7)
> >>>> +#define CPU_PMU                                BIT(INT_PCOV)
> >>>> +#define CPU_TIMER                      BIT(INT_TI)
> >>>> +#define CPU_IPI                                BIT(INT_IPI)
> >>>> +#define CPU_AVEC                       BIT(INT_AVEC)
> >>>> +#define KVM_ESTAT_IRQ_MASK             (CPU_SIP0 | CPU_SIP1 | CPU_P=
MU | CPU_TIMER \
> >>>> +                                               | CPU_IPI | CPU_AVEC=
)
> >>>> +#define KVM_ESTAT_HWI_MASK             (CPU_HWI0 | CPU_HWI1 | CPU_H=
WI2 | CPU_HWI3 \
> >>>> +                                               | CPU_HWI4 | CPU_HWI=
5 | CPU_HWI6 | CPU_HWI7)
> >>>>
> >>>>    /* Controlled by 0x52 guest exception VIP aligned to estat bit 5~=
12 */
> >>>> -#define CPU_IP0                                (_ULCAST_(1))
> >>>> -#define CPU_IP1                                (_ULCAST_(1) << 1)
> >>>> -#define CPU_IP2                                (_ULCAST_(1) << 2)
> >>>> -#define CPU_IP3                                (_ULCAST_(1) << 3)
> >>>> -#define CPU_IP4                                (_ULCAST_(1) << 4)
> >>>> -#define CPU_IP5                                (_ULCAST_(1) << 5)
> >>>> -#define CPU_IP6                                (_ULCAST_(1) << 6)
> >>>> -#define CPU_IP7                                (_ULCAST_(1) << 7)
> >>>> +#define GINTC_VIP_DELTA                        (INT_HWI0 - CSR_GINT=
C_VIP_SHIFT)
> >>> Don't use too many wrappers, just use INT_HWI0 instead of
> >>> GINTC_VIP_DELTA in this series is perfect. In other places INT_SWI0 i=
s
> >>> also used for shifts.
> >>
> >> The above macro definition is a little complicated, I do not know how =
to
> >> optimize it. do you mean remove GINTC_VIP_DELTA just use 2 such as:
> >> #define CPU_IP0                       BIT(INT_HWI0 - 2)
> > CSR_GINTC_VIP_SHIFT is 0 and GINTC_VIP_DELTA is equal to INT_HWI0. I
> > mean remove the GINTC_VIP_DELTA definition and use INT_HWI0 instead.
> For macro definition such CPU_IP0, GINTC_VIP_DELTA can be removed. And
> define it as follows directly.
> #define CPU_IP0                       BIT(0)
>
> However GINTC_VIP_DELTA is still useful, because bitmap with HWI0-HWI7
> in estat register starts from INT_HWI0, however with register gintc it
> starts from CSR_GINTC_VIP_SHIFT.
>
> For example with _kvm_getcsr() API, it is to get interrupt status. Here
> is the example code.
> gintc =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC)& KVM_GINTC_IRQ_MASK;
> estat =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT) &~KVM_ESTAT_HWI_MASK=
;
> *val =3D estat | (gintc << GINTC_VIP_DELTA);
>
> Remove GINTC_VIP_DELTA and use INT_HWI0 directly, it will be
> *val =3D estat | (gintc << INT_HWI0);
>
> I do not know what is the meaning about "gintc << INT_HWI0", especially
> if the value of CSR_GINTC_VIP_SHIFT is no zero.
In your Patch-2 there is "clear_csr_estat(1 << INT_SWI0)", INT_SW0 and
INT_HW0 are good friends. Why "1 << INT_SWI0" is acceptable but
"gintc << INT_HWI0" is not?

Huacai

>
> Regards
> Bibo Mao
> >
> >
> > Huacai
> >
> >>
> >> or something like this:
> >> #define CPU_IP0                       (CPU_HWI0 >> GINTC_VIP_DELTA)
> >>
> >> Regards
> >> Bibo Mao
> >>>
> >>>
> >>> Huacai
> >>>
> >>>> +#define CPU_IP0                                BIT(INT_HWI0 - GINTC=
_VIP_DELTA)
> >>>> +#define CPU_IP1                                BIT(INT_HWI1 - GINTC=
_VIP_DELTA)
> >>>> +#define CPU_IP2                                BIT(INT_HWI2 - GINTC=
_VIP_DELTA)
> >>>> +#define CPU_IP3                                BIT(INT_HWI3 - GINTC=
_VIP_DELTA)
> >>>> +#define CPU_IP4                                BIT(INT_HWI4 - GINTC=
_VIP_DELTA)
> >>>> +#define CPU_IP5                                BIT(INT_HWI5 - GINTC=
_VIP_DELTA)
> >>>> +#define CPU_IP6                                BIT(INT_HWI6 - GINTC=
_VIP_DELTA)
> >>>> +#define CPU_IP7                                BIT(INT_HWI7 - GINTC=
_VIP_DELTA)
> >>>> +#define KVM_GINTC_IRQ_MASK             (CPU_IP0 | CPU_IP1 | CPU_IP2=
 | CPU_IP3 \
> >>>> +                                               | CPU_IP4 | CPU_IP5 =
| CPU_IP6 | CPU_IP7)
> >>>>
> >>>>    #define MNSEC_PER_SEC                  (NSEC_PER_SEC >> 20)
> >>>>
> >>>> --
> >>>> 2.39.3
> >>>>
> >>>>
> >>
> >>
>
>
