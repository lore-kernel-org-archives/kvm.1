Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685F35DD1C
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321835; cv=none; b=AsQwR2NiuFMOGlmxUC+nBSkHVpxXAgTB4bc2Cw7chxtsxYRT65+GX/8PjXbgkWU2RIrTc+N8OoacSC4thVtJJc1n7OOPpspLLI72kP/vnuX8lWg/hp+nABGytMjJZrRXRu8XEE+Ff02mi4cJpcbcvnKTWmrEIlzw3zmt+5wDVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321835; c=relaxed/simple;
	bh=DLH812F35I2eWsc72iXkL09vexV+kwkBtf76L1iLO1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDtVZ04miRTg++iDod7G8K8Q0o6CwQBG31ZTrW3bBZ6vbQ1wjxBjPUh/9bz3PSq/z9fRub44RfRitf3/m8P09VLpSYzaouejjPLx+s/aJ6vO1yPnfz0TEf2weUt4/Ti3OGs0mwU50+/LnvBQMXYbFqwqo9w1v5rcxkgB1GKN/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1iJJaAL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1iJJaAL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FD61F0089A
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780321833;
	bh=yOo7bRthzYlBt7hK0BoozVxscByCehQKzHazCsIQD+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=o1iJJaALifDQsuNyV+1deMAlq6HyotB3iIWmIUSFSpj4jmCjeI3wI2bGf95GdrKfH
	 mO7+a51uNC9doFjLgiqyNCG16spjHL4hk5pm5gONE00/PAGqUlFY3JpgsJjjEBWmh2
	 roNNH+1/BaOIpowLNKOG5qtRtODHJ/halC/COszd5EZWGAgAtmnVaACJCjYelMYlhe
	 28/HPCiQLU8PK+PPO904ImqLM+ZgQKILVwhGUcxSRPsm+uHOIcSEd8k+rvqAlCA6x/
	 JBUkC7SM3nMzx3d0mzt0YD79Kp5QoiPgNcJ/8n+3NpmPAV1ZZ3WWw0JsoMva5YmqlV
	 G9/RU6Mq3u/Qw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bebbc325000so188605066b.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 06:50:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9TUY5Iqg+nM1QLzY21jVcZ00A1+8I7ceb/fb08aE7aWttvdMphNo+9xfJxPiEcPsznYLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJufY8dRmisGMkH+9SeZ7g/mezKGnMKIQoB4VY43WIfS+8+pn
	THOzwHY3hxFBTyxffuoGJlBj6VeKA/ONTvp/dtotard4zUxdO+RXd77BXogYCKMgvgKFJ+gh6Gw
	jtsnpbDlrLEeK/tYBCeK34MRageDGY3o=
X-Received: by 2002:a17:906:3185:b0:bec:4906:44d6 with SMTP id
 a640c23a62f3a-bec4906452fmr278865266b.11.1780321832371; Mon, 01 Jun 2026
 06:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526125256.2511876-1-maobibo@loongson.cn> <20260526125256.2511876-4-maobibo@loongson.cn>
In-Reply-To: <20260526125256.2511876-4-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 1 Jun 2026 21:50:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Bkg1MrWr_8YcvCdHWAfX_-WLzdFGukJQVu330LoL5KA@mail.gmail.com>
X-Gm-Features: AVHnY4I9TA6tKpchQArQkDB0tIJpJ2BIxu05g-b3HDWIwiQyt68YkqfH5yystfo
Message-ID: <CAAhV-H5Bkg1MrWr_8YcvCdHWAfX_-WLzdFGukJQVu330LoL5KA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] LoongArch: KVM: Use existing macro about interrupt
 bit mask
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Tue, May 26, 2026 at 8:53=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> With interrupt post, register CSR_GINTC and CSR_ESTAT is used, and
> CSR_ESTAT is used for percpu interrupt injection and CSR_GINTC is for
> external hardware interrupt injection.
>
> Here use existing macro about interrupt bit of register CSR_GINTC and
> CSR_ESTAT, rather than hard coded constant value.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/kvm_vcpu.h | 43 ++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 14 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/inclu=
de/asm/kvm_vcpu.h
> index 3784ab4ccdb5..efe26b04b35f 100644
> --- a/arch/loongarch/include/asm/kvm_vcpu.h
> +++ b/arch/loongarch/include/asm/kvm_vcpu.h
> @@ -10,22 +10,37 @@
>  #include <asm/loongarch.h>
>
>  /* Controlled by 0x5 guest estat */
> -#define CPU_SIP0                       (_ULCAST_(1))
> -#define CPU_SIP1                       (_ULCAST_(1) << 1)
> -#define CPU_PMU                                (_ULCAST_(1) << 10)
> -#define CPU_TIMER                      (_ULCAST_(1) << 11)
> -#define CPU_IPI                                (_ULCAST_(1) << 12)
> -#define CPU_AVEC                        (_ULCAST_(1) << 14)
> +#define CPU_SIP0                       BIT(INT_SWI0)
> +#define CPU_SIP1                       BIT(INT_SWI1)
> +#define CPU_HWI0                       BIT(INT_HWI0)
> +#define CPU_HWI1                       BIT(INT_HWI1)
> +#define CPU_HWI2                       BIT(INT_HWI2)
> +#define CPU_HWI3                       BIT(INT_HWI3)
> +#define CPU_HWI4                       BIT(INT_HWI4)
> +#define CPU_HWI5                       BIT(INT_HWI5)
> +#define CPU_HWI6                       BIT(INT_HWI6)
> +#define CPU_HWI7                       BIT(INT_HWI7)
> +#define CPU_PMU                                BIT(INT_PCOV)
> +#define CPU_TIMER                      BIT(INT_TI)
> +#define CPU_IPI                                BIT(INT_IPI)
> +#define CPU_AVEC                       BIT(INT_AVEC)
> +#define KVM_ESTAT_IRQ_MASK             (CPU_SIP0 | CPU_SIP1 | CPU_PMU | =
CPU_TIMER \
> +                                               | CPU_IPI | CPU_AVEC)
> +#define KVM_ESTAT_HWI_MASK             (CPU_HWI0 | CPU_HWI1 | CPU_HWI2 |=
 CPU_HWI3 \
> +                                               | CPU_HWI4 | CPU_HWI5 | C=
PU_HWI6 | CPU_HWI7)
>
>  /* Controlled by 0x52 guest exception VIP aligned to estat bit 5~12 */
> -#define CPU_IP0                                (_ULCAST_(1))
> -#define CPU_IP1                                (_ULCAST_(1) << 1)
> -#define CPU_IP2                                (_ULCAST_(1) << 2)
> -#define CPU_IP3                                (_ULCAST_(1) << 3)
> -#define CPU_IP4                                (_ULCAST_(1) << 4)
> -#define CPU_IP5                                (_ULCAST_(1) << 5)
> -#define CPU_IP6                                (_ULCAST_(1) << 6)
> -#define CPU_IP7                                (_ULCAST_(1) << 7)
> +#define GINTC_VIP_DELTA                        (INT_HWI0 - CSR_GINTC_VIP=
_SHIFT)
Don't use too many wrappers, just use INT_HWI0 instead of
GINTC_VIP_DELTA in this series is perfect. In other places INT_SWI0 is
also used for shifts.


Huacai

> +#define CPU_IP0                                BIT(INT_HWI0 - GINTC_VIP_=
DELTA)
> +#define CPU_IP1                                BIT(INT_HWI1 - GINTC_VIP_=
DELTA)
> +#define CPU_IP2                                BIT(INT_HWI2 - GINTC_VIP_=
DELTA)
> +#define CPU_IP3                                BIT(INT_HWI3 - GINTC_VIP_=
DELTA)
> +#define CPU_IP4                                BIT(INT_HWI4 - GINTC_VIP_=
DELTA)
> +#define CPU_IP5                                BIT(INT_HWI5 - GINTC_VIP_=
DELTA)
> +#define CPU_IP6                                BIT(INT_HWI6 - GINTC_VIP_=
DELTA)
> +#define CPU_IP7                                BIT(INT_HWI7 - GINTC_VIP_=
DELTA)
> +#define KVM_GINTC_IRQ_MASK             (CPU_IP0 | CPU_IP1 | CPU_IP2 | CP=
U_IP3 \
> +                                               | CPU_IP4 | CPU_IP5 | CPU=
_IP6 | CPU_IP7)
>
>  #define MNSEC_PER_SEC                  (NSEC_PER_SEC >> 20)
>
> --
> 2.39.3
>
>
