Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A24444716
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329106; cv=pass; b=D32saERFoFRK3oh49Ck9ERe8eY21a36AD9dhWKsp8vN5wC8PIjh79rYIphrtxWXoXhZZdXjvKHgeXHHMCNLY8thGlC4x25lIGwyFRqYcIwHP+cvN1fKZNWX2C60CGbgyCOMGV681ygqxEvHU2Qh2DMXg7EF6QgihEDpSAgLxZM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329106; c=relaxed/simple;
	bh=IcXINUZJryrsa4j+h81xUNPst6VWPwwEMFLIqHPQgjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hdb6IVz6RK+R068REsGCXOrxe1hLm1lskq75A3U9cd/pc94XDuAfh9L5X2HII93Lwgo4TCbj9ERX5sYt28rc8vD5c2L45yp15akDs1DIFKExyTvb+uqEei8zD6yRSMiZr0KnE7h0oG/D75ZSJff02VbgUcfB7oLlkU5fGBBJ2PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=OnSS1ZsR; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="OnSS1ZsR"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4720f3bf164so1351290f8f.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 05:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785329101; cv=none;
        d=google.com; s=arc-20260327;
        b=ZDDNu2hoEh91V8poEQx05RQDJ5DNvnH6OD1Ig+EaPWGco0YX7EQcz2xIKEm/SJZFe8
         /luapJaJBRoS5pRHhZKXkN9il6t0iF84JOPdwTMCMJaN8odAJH2h1wEqmexgX95hKASK
         d4cxKIvkpPDUxAjPH9E5z1EQDY/ok6egMIsZe2B2/VyTKHmoR1JmvohoJr4v8b+DRYXK
         OWYzVuRD+TEez7z8B6HyXn3hw1U5GvfiF6eMGRmGt8VgqLZcl5rq+5QSXw87CXuLrlP3
         kCoXCz1gK9N1n7etsz8kwiMpsb3TZTd6cV/maI10e+z5wE3bkAeq+KnUgT/XPwR9WEw0
         pHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iMeNu4+os+LxYP0wqrGsNdF408ZfmMDEahTjLviYQ3s=;
        fh=2d4wejE+9BOwqVlsrmKsoj4Zt7svuvPqvHy82Vy/PNo=;
        b=krZ3zJxd2wtBvsppf+CM/75ckR4esoD/qtVt6ZciDgnoojlylQpJyN+LSdsCp+e0Av
         6I2xZ0oZoVT7/fCUe0BRlIVWA91m/UGCt2erdYT5/TyBLOfr3ZcWdwgYzpUt4jgLpQ34
         eHvPZI6HEooJUFTunIboxEq/Vaa9AjsIhe0rDoYHrJDK32e9EfV0HZxTNuyg3GF0M4MK
         gyEQipk9KSs8NwwxJe797mQlFBq0+2lYSOMJ336XVKEW9mHDQLHzsz4RiS+SoCTzGO5L
         XpPzwqUfNkOf3pgFkFG5SsCdkFCbIhgnewfb7GTZOHlctWFUph3wAKQUUZvVaFMpPzoD
         UNFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785329101; x=1785933901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iMeNu4+os+LxYP0wqrGsNdF408ZfmMDEahTjLviYQ3s=;
        b=OnSS1ZsR2MhHXiAieSXsZTBp+T/WucpSi/BqUfrCpFmdcjYFSDIUEkGSr8WdEOcFXD
         U2Azdlk4RHdVimItI4xrxZo59Z1AcEKRaZ/+N71NgYg0NGhuvCBPRHVGtGprabhNX3TI
         lv/oI3MC2JoHfV3xxDpI5LcNbbOFLZDwIwDAUxKRIe0+j0FF2jktxvxP3aOtglN4u4mz
         CDc27HrdlVHv29uJ5ARPsXRjmYeQUqiTa8wRsXzF1quUuLx+HLjoyHbg2O0JKqxKXeGl
         +BTkDjNBTIMJSNtkkivCepE0XReRScq4yPVoZGIlrFZ0SYmcYmyWsafW2ri792x/bSUO
         GY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785329101; x=1785933901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iMeNu4+os+LxYP0wqrGsNdF408ZfmMDEahTjLviYQ3s=;
        b=cAq9fYlkC+4BVPHhbPJL6aonqFJklPeoBSS6sFsg18/YRk9rB8Kjwq3Vb3U8nTVq8a
         RDNf7sNsvYrkO1N49ygNu5sHi1J0WcDiAnh8S2D65C/isu/D54FwoK/ENQVfq72lqcRE
         DqpNTs7AMTDq5dgf6IM0X3ALxzAMektYkDkOUJ1XuGBn3jmdjQPhL54gyA4uNS87tLh4
         LliBnYzp1/okfdjZv3fV2ivqqlwyHV2wrJ0zitkUzt/pNPhn3sieThxNgjFEhtHDP0eA
         eRqixLD7f5dgkbNQXYPl5yfQIsNC4YSHgPjvD7YQ7FXXUZ347Q2+hDRY4UiuI3JVeIBW
         xMOw==
X-Forwarded-Encrypted: i=1; AHgh+RpPXh0+9+rUKHeSgN3OgDPuYjSS+HY55/iZqAeKjuyExKEWjXBVnpUpdmT9JvY/QNe6IfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXcmKDQpuqTyL8lo3l+06q8yR80ooOtTHPHHt5ym3kRohz8ePq
	yRQpR63CoizEstB+cqoycos8LpKU1R6Vk77Cn2oT9Tjzit6+FiPQ2rCGKs/1mZgXLofXkul2GXW
	E5kWJHBSHviWvjMLGdylKpnRPHV5Sscyc7PQpYBBGSw==
X-Gm-Gg: AR+sD122l/DCbm/TeksINnnCiOBD80G3WJev46kQELq/HlIXO4S2/w6ethW8wOBFwkh
	cahsqGPpIEHfDn9Z2oLxZKw6GLIwOECqhyBgwOZ5Lsp3ZZD0zOp/2iTNSiwyicThsr8LWGwYBOY
	KYCOLJ0odV5XRyYMUPdFY6U04Ne6ZW/Tt8V3RyUxSoynybupkkGU+CVrZV+ESBCR7rk6CBnnj2y
	JvtHl7ibrHBqCY0ivD1F0GAZQOF/WjjXieBRwWkhu/n8fxswx34ETxxvItdwckiasfPa1DBYLgC
	2WFmLfE50HOb2GV83vhSgSm/EX3Tq+b3Ll7BrxOWT7Lxtjrejw+GlGfnSMDrZ3XXdbwGunHX3Nc
	prZC5mNxBFlCHSMIrejn/CI9CxLxfvPdOYt7kGzbWdFFoEGT7dw56EaYzDzQ5Dvw=
X-Received: by 2002:a05:6000:4b03:b0:47f:7ea0:6c20 with SMTP id
 ffacd0b85a97d-47fbabdeba5mr3222037f8f.15.1785329101087; Wed, 29 Jul 2026
 05:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713010302.303278-1-inochiama@gmail.com> <20260713010302.303278-3-inochiama@gmail.com>
In-Reply-To: <20260713010302.303278-3-inochiama@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 18:14:49 +0530
X-Gm-Features: AUfX_mw9Geq8pnQB8DXZRWmbfgR1VWYBcvVSDUq0mH-M8_MwEEaJfPpEFqa2qBs
Message-ID: <CAAhSdy0nPJAkkZM07D0Xm0Sd6tB7D2MK1aYvWZk0Mn4MbnNKjQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] KVM: riscv: selftests: add Svadu FWFT extension to
 get-reg-list test
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Andy Chiu <andybnac@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Deepak Gupta <debug@rivosinc.com>, 
	Thomas Huth <thuth@redhat.com>, Sergey Matyukevich <geomatsi@gmail.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 6:33=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> The KVM RISC-V allows Svadu FWFT for Guest/VM so add this extension
> to get-reg-list test.
>
> Assisted-by: YuanSheng:claude-4.7-opus
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  .../selftests/kvm/riscv/get-reg-list.c        | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index cb86cb6b3635..94e33b2ee796 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -745,6 +745,9 @@ static const char *sbi_fwft_id_to_str(__u64 reg_off)
>         case 3: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_R=
EG(pointer_masking.enable)";
>         case 4: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_R=
EG(pointer_masking.flags)";
>         case 5: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_R=
EG(pointer_masking.value)";
> +       case 6: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_R=
EG(pte_ad_hw_updating.enable)";
> +       case 7: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_R=
EG(pte_ad_hw_updating.flags)";
> +       case 8: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_R=
EG(pte_ad_hw_updating.value)";
>         }
>         return strdup_printf("KVM_REG_RISCV_SBI_FWFT | %lld /* UNKNOWN */=
", reg_off);
>  }
> @@ -944,6 +947,13 @@ static __u64 sbi_fwft_pointer_masking_regs[] =3D {
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.value),
>  };
>
> +static __u64 sbi_fwft_pte_ad_hw_updating_regs[] =3D {
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_=
REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT,
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.enable=
),
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.flags)=
,
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.value)=
,
> +};
> +
>  static __u64 zicbom_regs[] =3D {
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_R=
EG_RISCV_CONFIG_REG(zicbom_block_size),
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOM,
> @@ -1259,6 +1269,16 @@ static struct vcpu_reg_list config_sbi_fwft_pointe=
r_masking =3D {
>         },
>  };
>
> +static struct vcpu_reg_list config_sbi_fwft_pte_ad_hw_updating =3D {
> +       .sublists =3D {
> +               SUBLIST_BASE,
> +               SUBLIST_ISA(svade, SVADE),
> +               SUBLIST_ISA(svadu, SVADU),
> +               SUBLIST_SBI(fwft_pte_ad_hw_updating, FWFT),
> +               {0},
> +       },
> +};
> +
>  struct vcpu_reg_list *vcpu_configs[] =3D {
>         &config_sbi_base,
>         &config_sbi_sta,
> @@ -1268,6 +1288,7 @@ struct vcpu_reg_list *vcpu_configs[] =3D {
>         &config_sbi_mpxy,
>         &config_sbi_fwft_misaligned_deleg,
>         &config_sbi_fwft_pointer_masking,
> +       &config_sbi_fwft_pte_ad_hw_updating,
>         &config_aia,
>         &config_fp_f,
>         &config_fp_d,
> --
> 2.55.0
>
