Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5143783A5
	for <kvm@vger.kernel.org>; Thu, 29 Jan 2026 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678859; cv=none; b=uS2yRRKSdmj75WpWU6ClqmhISb2EjIFascXaqOs2Y6G6TzSvMu8h6CM5SaeiI9Vu61NVwnL35ZdVEbCT1Sw/DiE26OoxKGshftG86zqwSkEnYnjDUL+UVpGHO//GaBGgyLz22QapGIr5IQ5LKh5wugkstmBGEfsMW0WRFx0bZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678859; c=relaxed/simple;
	bh=TF8K8U8wcqsRla+lRLhYDzrEMFAEdwBV9WYzTgc3juI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXH2wDa7z6D/LJQHzGs5qRMZXArkL0BLyhAOuWzLP2REzgi5zWgvYToSiPgyrT9224cyEO8S6unnnudrUvPUhCV2VsJLbOr0jcKC+S27qps3AquSYu7kqloTzG/bSxxQBgtSI3iKMyUFFU9o0DBayqSTNui+jL/nS2Bq4leXVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utI+Zq3l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utI+Zq3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34494C19421
	for <kvm@vger.kernel.org>; Thu, 29 Jan 2026 09:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769678859;
	bh=TF8K8U8wcqsRla+lRLhYDzrEMFAEdwBV9WYzTgc3juI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=utI+Zq3l3tGjZLLzngFCQcY2DnY8BP2HdmL08TbYuqifjdgjHK6m3Izf0GQ8DsO5e
	 Cgx5dKLoE7VBx10L1xLsqIRLLwqUctYEXEfCcpPLF3qaeqPixqn14RsMuHb6MfJxKK
	 39EOCVuiNce2GHYiHywZ1WOCy9kw7VtyBramApmvfYiU4x8VrJeYWoNDTNxII520BE
	 DoWWSjhTCg6x9Tx3vyKlnv7IFSDzVJqjCsap+Ys1tAido8C0/o7DYWUXAYbk0WnH0o
	 S7ii5Lh90rzsIdjMLIknEZXl6xEu8EB6Z3UiGnxun7okr9u/3BcqUyKs1Mbas4UvrJ
	 jZVmskLq3Uoyg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8838339fc6so158922766b.0
        for <kvm@vger.kernel.org>; Thu, 29 Jan 2026 01:27:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDOVkx5TdWkKXdHBbucCVqqMJhDChrL1wUucadymyQo0AElX/8M2Sr78qrCNfFtcNqyAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQgOlOQm617f3mybImOTxUuJFT4ihVrmlVDG3bzcJBnX23/9D/
	OoTlMzTJBtE9Oktoms51umdWwTxYMQAoLo8pi224IdD2yFNpjuaKQlYDehTz5kduhWcZjG5qTQP
	pofPGeURpBVc7qehZU20FwlzXTPSVOzU=
X-Received: by 2002:a17:906:9fcf:b0:b87:19ae:eb36 with SMTP id
 a640c23a62f3a-b8ddf80648dmr144098066b.7.1769678857728; Thu, 29 Jan 2026
 01:27:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126024840.2308379-1-maobibo@loongson.cn>
In-Reply-To: <20260126024840.2308379-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 29 Jan 2026 17:26:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H66uH1TpaKTsqNtSqKYUDatJWj+zAuw-MYE88BqOF0XTA@mail.gmail.com>
X-Gm-Features: AZwV_QgnTVJZtHCaxMK_Y7qIwj_iZiYHreq0re7gfqu8g0b3GElOliq10WXsWm0
Message-ID: <CAAhV-H66uH1TpaKTsqNtSqKYUDatJWj+zAuw-MYE88BqOF0XTA@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: KVM: Add more CPUCFG mask bit
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Mon, Jan 26, 2026 at 10:48=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> With LA664 CPU there are more features supported which are indicated
> in CPUCFG2 bit24:30 and CPUCFG3 bit17 and bit 23. KVM hypervisor can
> not enable or disable these features and there is no KVM exception
> when instructions of these features are used in guest mode.
>
> Here add more CPUCFG mask support with LA664 CPU type.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   1. Rebase on the latest version since some common CPUCFG bit macro
>      definitions are merged.
>   2. Modifiy the comments explaining why it comes from feature detect
>      of host CPU.
> ---
>  arch/loongarch/kvm/vcpu.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 656b954c1134..a9608469fa7a 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -652,6 +652,8 @@ static int _kvm_setcsr(struct kvm_vcpu *vcpu, unsigne=
d int id, u64 val)
>
>  static int _kvm_get_cpucfg_mask(int id, u64 *v)
>  {
> +       unsigned int config;
> +
>         if (id < 0 || id >=3D KVM_MAX_CPUCFG_REGS)
>                 return -EINVAL;
>
> @@ -684,9 +686,22 @@ static int _kvm_get_cpucfg_mask(int id, u64 *v)
>                 if (cpu_has_ptw)
>                         *v |=3D CPUCFG2_PTW;
>
> +               /*
> +                * The capability indication of some features are the sam=
e
> +                * between host CPU and guest vCPU, and there is no speci=
al
> +                * feature detect method with vCPU. Also KVM hypervisor c=
an
> +                * not enable or disable these features.
> +                *
> +                * Here use host CPU detected features for vCPU
> +                */
> +               config =3D read_cpucfg(LOONGARCH_CPUCFG2);
> +               *v |=3D config & (CPUCFG2_FRECIPE | CPUCFG2_DIV32 | CPUCF=
G2_LAM_BH);
> +               *v |=3D config & (CPUCFG2_LAMCAS | CPUCFG2_LLACQ_SCREL | =
CPUCFG2_SCQ);
>                 return 0;
>         case LOONGARCH_CPUCFG3:
>                 *v =3D GENMASK(16, 0);
> +               config =3D read_cpucfg(LOONGARCH_CPUCFG3);
> +               *v |=3D config & (CPUCFG3_DBAR_HINTS | CPUCFG3_SLDORDER_S=
TA);
What about adding CPUCFG3_ALDORDER_STA and CPUCFG3_ASTORDER_STA here, too?

Huacai

>                 return 0;
>         case LOONGARCH_CPUCFG4:
>         case LOONGARCH_CPUCFG5:
>
> base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
> --
> 2.39.3
>
>
