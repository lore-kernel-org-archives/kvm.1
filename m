Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404053783D1
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780740173; cv=none; b=M26ajLXe8Sqx3XclYQpI7embHSKYtvZrOGzxZFyhILvJhi12+JkxcWcWqTbPvEKUQYBAp+sQC9KbXjDn01ZjJe7msWIu1BR7Bq+iyrxNDDygSLZYWErewywL12qinEdnwl56Y1jHTrCp6+7bFAdvz6bNj+MXpiw8ZqUaOjXJTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780740173; c=relaxed/simple;
	bh=SNgp6bJqe2KP92uO9l/9zXjCp+J8Shrf9qwDKo47fYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6PXY6+Al9tCTVXTIijF1ey8Xyc2jutcxu/HIIeFS3OJ59dx7J2Ub5Uwu0W2PNqeHR92BMAjBLfryHQ7F2VhbNNUnXcm1ViUuP5Vyp3qblk3P4hwztKw46aUn3iPom4WK7tHJclqVPVRjbNJ0quWjyLeybuIdgCxaYMav7laSB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkFo7HWP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkFo7HWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84231F0089D
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 10:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780740171;
	bh=rJ88a5JoswGEziEj0vW+aDlNK4Vs0Xp7gUsJSuTGboo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UkFo7HWPigjzaTl5W2fivHus4/gwNvDS105pglp618poF8txAmW3egOx5h6f+I3FA
	 Faai+7JYh5kzDwBB0SmIkAN82ih5KhfWcKvQcGsy5Q8nJRfu/KJDlu8bm5XAdUEPpK
	 2kDRnIE9p6n+Xt55+Bfa9DXYzQZoR79Z/yHE9dIB+4bHan7ekwqI3x22xPqO4imxQo
	 EWoprkrh3CKnK3fwadZh3JgvOIIaL1s9sRyINRrYFvvWMjstr7JsSA/Vn7jGKI5voP
	 0zVlnpZ/SXISNNeWxeWLBD/INHPX9DVHKFS280pO43RewH1PXhlLd0JEcMjAUcMz3D
	 ISTgVKLRV885w==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68d233bf083so3812165a12.1
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 03:02:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8LxeiWSmtk9/BxkYwgjMY0DAgp3LWraKfbQ+CVqDoEkx9as+UmPsWO7LcNQnTyhKikQ/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhyQUYEf5GfT4wSUDZo41aGTmcuTbOZb5FRnTy8ZMpV8NBEB1r
	mqUIPRLO6xDYua3ezsupEKNQDRJSDWyiEz5Uiw69R5N4doZOEWJDtgpi8D5kb7tFdgn5+Awi/jc
	E7jogNMTE/q91qZyPv8xF4n0YfWFghiM=
X-Received: by 2002:a05:6402:e86:b0:68c:bf82:8844 with SMTP id
 4fb4d7f45d1cf-68fa4c24a12mr3398543a12.6.1780740170387; Sat, 06 Jun 2026
 03:02:50 -0700 (PDT)
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
 <ec8614d5-ed40-d2b9-37c7-6f04b6bd010f@loongson.cn>
In-Reply-To: <ec8614d5-ed40-d2b9-37c7-6f04b6bd010f@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 6 Jun 2026 18:03:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7M3Gbv8dXP=KnKzRSLJn5QoZt_hJvmuMmTL_MWo7gk0A@mail.gmail.com>
X-Gm-Features: AVVi8Cd56x2PXHwYBCVz5EqouR1DVBaaSa3KFWUqfhRzMMjGo27iX6lqtTBgffA
Message-ID: <CAAhV-H7M3Gbv8dXP=KnKzRSLJn5QoZt_hJvmuMmTL_MWo7gk0A@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] LoongArch: KVM: Use existing macro about interrupt
 bit mask
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 9:51=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2026/6/3 =E4=B8=8B=E5=8D=8810:23, Huacai Chen wrote:
> > On Tue, Jun 2, 2026 at 4:13=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> On 2026/6/2 =E4=B8=8B=E5=8D=881:01, Huacai Chen wrote:
> >>> On Tue, Jun 2, 2026 at 9:39=E2=80=AFAM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2026/6/1 =E4=B8=8B=E5=8D=889:50, Huacai Chen wrote:
> >>>>> Hi, Bibo,
> >>>>>
> >>>>> On Tue, May 26, 2026 at 8:53=E2=80=AFPM Bibo Mao <maobibo@loongson.=
cn> wrote:
> >>>>>>
> >>>>>> With interrupt post, register CSR_GINTC and CSR_ESTAT is used, and
> >>>>>> CSR_ESTAT is used for percpu interrupt injection and CSR_GINTC is =
for
> >>>>>> external hardware interrupt injection.
> >>>>>>
> >>>>>> Here use existing macro about interrupt bit of register CSR_GINTC =
and
> >>>>>> CSR_ESTAT, rather than hard coded constant value.
> >>>>>>
> >>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>>>> ---
> >>>>>>     arch/loongarch/include/asm/kvm_vcpu.h | 43 ++++++++++++++++++-=
--------
> >>>>>>     1 file changed, 29 insertions(+), 14 deletions(-)
> >>>>>>
> >>>>>> diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarc=
h/include/asm/kvm_vcpu.h
> >>>>>> index 3784ab4ccdb5..efe26b04b35f 100644
> >>>>>> --- a/arch/loongarch/include/asm/kvm_vcpu.h
> >>>>>> +++ b/arch/loongarch/include/asm/kvm_vcpu.h
> >>>>>> @@ -10,22 +10,37 @@
> >>>>>>     #include <asm/loongarch.h>
> >>>>>>
> >>>>>>     /* Controlled by 0x5 guest estat */
> >>>>>> -#define CPU_SIP0                       (_ULCAST_(1))
> >>>>>> -#define CPU_SIP1                       (_ULCAST_(1) << 1)
> >>>>>> -#define CPU_PMU                                (_ULCAST_(1) << 10=
)
> >>>>>> -#define CPU_TIMER                      (_ULCAST_(1) << 11)
> >>>>>> -#define CPU_IPI                                (_ULCAST_(1) << 12=
)
> >>>>>> -#define CPU_AVEC                        (_ULCAST_(1) << 14)
> >>>>>> +#define CPU_SIP0                       BIT(INT_SWI0)
> >>>>>> +#define CPU_SIP1                       BIT(INT_SWI1)
> >>>>>> +#define CPU_HWI0                       BIT(INT_HWI0)
> >>>>>> +#define CPU_HWI1                       BIT(INT_HWI1)
> >>>>>> +#define CPU_HWI2                       BIT(INT_HWI2)
> >>>>>> +#define CPU_HWI3                       BIT(INT_HWI3)
> >>>>>> +#define CPU_HWI4                       BIT(INT_HWI4)
> >>>>>> +#define CPU_HWI5                       BIT(INT_HWI5)
> >>>>>> +#define CPU_HWI6                       BIT(INT_HWI6)
> >>>>>> +#define CPU_HWI7                       BIT(INT_HWI7)
> >>>>>> +#define CPU_PMU                                BIT(INT_PCOV)
> >>>>>> +#define CPU_TIMER                      BIT(INT_TI)
> >>>>>> +#define CPU_IPI                                BIT(INT_IPI)
> >>>>>> +#define CPU_AVEC                       BIT(INT_AVEC)
> >>>>>> +#define KVM_ESTAT_IRQ_MASK             (CPU_SIP0 | CPU_SIP1 | CPU=
_PMU | CPU_TIMER \
> >>>>>> +                                               | CPU_IPI | CPU_AV=
EC)
> >>>>>> +#define KVM_ESTAT_HWI_MASK             (CPU_HWI0 | CPU_HWI1 | CPU=
_HWI2 | CPU_HWI3 \
> >>>>>> +                                               | CPU_HWI4 | CPU_H=
WI5 | CPU_HWI6 | CPU_HWI7)
> >>>>>>
> >>>>>>     /* Controlled by 0x52 guest exception VIP aligned to estat bit=
 5~12 */
> >>>>>> -#define CPU_IP0                                (_ULCAST_(1))
> >>>>>> -#define CPU_IP1                                (_ULCAST_(1) << 1)
> >>>>>> -#define CPU_IP2                                (_ULCAST_(1) << 2)
> >>>>>> -#define CPU_IP3                                (_ULCAST_(1) << 3)
> >>>>>> -#define CPU_IP4                                (_ULCAST_(1) << 4)
> >>>>>> -#define CPU_IP5                                (_ULCAST_(1) << 5)
> >>>>>> -#define CPU_IP6                                (_ULCAST_(1) << 6)
> >>>>>> -#define CPU_IP7                                (_ULCAST_(1) << 7)
> >>>>>> +#define GINTC_VIP_DELTA                        (INT_HWI0 - CSR_GI=
NTC_VIP_SHIFT)
> >>>>> Don't use too many wrappers, just use INT_HWI0 instead of
> >>>>> GINTC_VIP_DELTA in this series is perfect. In other places INT_SWI0=
 is
> >>>>> also used for shifts.
> >>>>
> >>>> The above macro definition is a little complicated, I do not know ho=
w to
> >>>> optimize it. do you mean remove GINTC_VIP_DELTA just use 2 such as:
> >>>> #define CPU_IP0                       BIT(INT_HWI0 - 2)
> >>> CSR_GINTC_VIP_SHIFT is 0 and GINTC_VIP_DELTA is equal to INT_HWI0. I
> >>> mean remove the GINTC_VIP_DELTA definition and use INT_HWI0 instead.
> >> For macro definition such CPU_IP0, GINTC_VIP_DELTA can be removed. And
> >> define it as follows directly.
> >> #define CPU_IP0                       BIT(0)
> >>
> >> However GINTC_VIP_DELTA is still useful, because bitmap with HWI0-HWI7
> >> in estat register starts from INT_HWI0, however with register gintc it
> >> starts from CSR_GINTC_VIP_SHIFT.
> >>
> >> For example with _kvm_getcsr() API, it is to get interrupt status. Her=
e
> >> is the example code.
> >> gintc =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC)& KVM_GINTC_IRQ_MA=
SK;
> >> estat =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT) &~KVM_ESTAT_HWI_M=
ASK;
> >> *val =3D estat | (gintc << GINTC_VIP_DELTA);
> >>
> >> Remove GINTC_VIP_DELTA and use INT_HWI0 directly, it will be
> >> *val =3D estat | (gintc << INT_HWI0);
> >>
> >> I do not know what is the meaning about "gintc << INT_HWI0", especiall=
y
> >> if the value of CSR_GINTC_VIP_SHIFT is no zero.
> > In your Patch-2 there is "clear_csr_estat(1 << INT_SWI0)", INT_SW0 and
> > INT_HW0 are good friends. Why "1 << INT_SWI0" is acceptable but
> > "gintc << INT_HWI0" is not?
>
> The bit definition INT_SWI0 is for ESTAT register, is that right?
>
> The bitmap mask KVM_GINTC_IRQ_MASK is for GINTC register, to convert to
> bitmap mask of ESTAT,  should not be (gintc >> CSR_GINTC_VIP_SHIFT) <<
> INT_HWI0? why CSR_GINTC_VIP_SHIFT is discarded here, just because it is
> zero?
Yes, this is a reason,  but if you insist on, the macro can be
defined, but the name can be changed.

In theory, it is VIP_DELTA_BETWEEN_ESTAT_AND_GINTC, but we can just
use VIP_DELTA for short because CPU_IP0, CPU_IP1 .... also don't have
a "GINTC_" prefix.

And KVM_ESTAT_IRQ_MASK is not suitable. In theory SWI and HWI are both
IRQ, so you cannot use KVM_ESTAT_IRQ_MASK to stand for the rest IRQ
bits of KVM_ESTAT_HWI_MASK.

Yes, KVM_ESTAT_SWI_MASK is also not suitable because TI, IPI are
"hardware interrupts" indeed, but KVM_ESTAT_SWI_MASK is still better
than KVM_ESTAT_IRQ_MASK.

A even better distinction is using "internal interrupts" and "external
interrupts" to describe, so KVM_ESTAT_INTI_MASK and
KVM_ESTAT_EXTI_MASK can be considered.


Huacai

>
> >
> > Huacai
> >
> >>
> >> Regards
> >> Bibo Mao
> >>>
> >>>
> >>> Huacai
> >>>
> >>>>
> >>>> or something like this:
> >>>> #define CPU_IP0                       (CPU_HWI0 >> GINTC_VIP_DELTA)
> >>>>
> >>>> Regards
> >>>> Bibo Mao
> >>>>>
> >>>>>
> >>>>> Huacai
> >>>>>
> >>>>>> +#define CPU_IP0                                BIT(INT_HWI0 - GIN=
TC_VIP_DELTA)
> >>>>>> +#define CPU_IP1                                BIT(INT_HWI1 - GIN=
TC_VIP_DELTA)
> >>>>>> +#define CPU_IP2                                BIT(INT_HWI2 - GIN=
TC_VIP_DELTA)
> >>>>>> +#define CPU_IP3                                BIT(INT_HWI3 - GIN=
TC_VIP_DELTA)
> >>>>>> +#define CPU_IP4                                BIT(INT_HWI4 - GIN=
TC_VIP_DELTA)
> >>>>>> +#define CPU_IP5                                BIT(INT_HWI5 - GIN=
TC_VIP_DELTA)
> >>>>>> +#define CPU_IP6                                BIT(INT_HWI6 - GIN=
TC_VIP_DELTA)
> >>>>>> +#define CPU_IP7                                BIT(INT_HWI7 - GIN=
TC_VIP_DELTA)
> >>>>>> +#define KVM_GINTC_IRQ_MASK             (CPU_IP0 | CPU_IP1 | CPU_I=
P2 | CPU_IP3 \
> >>>>>> +                                               | CPU_IP4 | CPU_IP=
5 | CPU_IP6 | CPU_IP7)
> >>>>>>
> >>>>>>     #define MNSEC_PER_SEC                  (NSEC_PER_SEC >> 20)
> >>>>>>
> >>>>>> --
> >>>>>> 2.39.3
> >>>>>>
> >>>>>>
> >>>>
> >>>>
> >>
> >>
>
