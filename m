Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6EC386C1C
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757328; cv=pass; b=btYLY8Co5p9Y4yqUJO5JX1Vmr9teAGnuBdywHaPRsTfixR0vJMnoygDKqCE0Iu6X//i2sOkpPlT1SkmczAS9k/bKrLtQ64J7EkJV9DUPeKvzMvlK8Dm8SX/EkOJPRHNNBDnKuAQhgbBFvKlBMh6qNIr29/G1nNpqsUyvn7CIb9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757328; c=relaxed/simple;
	bh=rTCC+Q2QI/RNZdcYErq5nB4Tg1Xxg7Ybj1fhnVetaOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRLtq7dFHYBY19chKZ0YbFbB0XSH06yvmYWEzTtRhWQAmM7q0uf5g3T9s3v8P/z+NTFDP6KKXLPGR8LYzm+tZoyYazZPyLO40+7T120lqC7c7aX5BEy/qWhvk/sMmoLNkS6CGleSku5TMzuZ2aUEMZ5rmA1EGnZGuXsj9A2a9fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZVlrTnH; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZVlrTnH"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4624a44e152so3347051f8f.2
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 11:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782757321; cv=none;
        d=google.com; s=arc-20260327;
        b=geBw6ZPTVSo5lFrkhhbmDX2/JamxwuGbSl2uY2Ez05Wl/5HGh3VumOyKa6jDKD1PaA
         itM5+3rI8jfYfZueiQ640XwvirrHFBDiWs4J+DRVZTVDA20RtI4/758QfPCOhICxsMIr
         ojXk5qLqpOxOXLlaCpCgBZZeJkY/k240peWS9JG+pq6YDGQ+Mxko7/KpYpgBHGLJj7Zy
         OGHwq8OO7xypj29aDrAYjdFYIUQfbSZan9rXrgm6aQHl+lSmAtom0XEyJZf1VQRzMxFX
         YPAuQBnkl2TsfIMntU0cbnO66UePmtwCYGH7AHGVAGhgVMtbkQd3ZZo5efjzzzOVzjN7
         bTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5NfKOjNU6srylE75C2adpej95bKtXYvziT0LYJSnVds=;
        fh=hKeXtSuMMex33b2xF3liZRf7E7+eeipe8mEb5zTVMRM=;
        b=NnxLsxJ3w3y6o3CaMJJEykdfew/XUCfEPte9zMLvGT+tRJYtM9wwbNbSZ13EO/1R7Q
         qDU1wJFrbqb/U4htOu/euuo/aLgy0SjlEuyor3wYvOT7/vxvsAmJCxe7A+jloN9aO4WH
         bvKZOGDS0qobCVz+7HuDnJgtS2htWk0WO4eVBdNnl6sTSv2yDoPPORSL1ByWy27IhADv
         zECStQmZfZqVCMisyygt0wJiI1sYxdtKEl61puaNDygasXWUIu8syEtFpVSpGA9y/jP1
         k4c//OnkvACFwgnld/zJjXBfb1EOKu/m1woCD+WIw1ti9sEIYn7SAPlsakkbWxY1FRo3
         uq/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782757321; x=1783362121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5NfKOjNU6srylE75C2adpej95bKtXYvziT0LYJSnVds=;
        b=lZVlrTnHAIE6MHhnr76cv5+Q9ab3WEF37l1jXtbCTR0zXFkwPQGjAcZs9ooF4TN2HA
         0zv3vLRXJ/Z4ZopSsJuTeilRNAlXpdGx3QyUDpnwM2wLstJ3OzCQas6HEMKgpo0BeKYJ
         qj7xeSFA26oJJb7ArIsLKQ8MBfTpLrvdPRsvqW2zDgjdJLFbP4TP+j14v/s7S+CqLrcc
         8O0IDAPaVGDl2vZiXU9ZFXkSR/oXnO0+fTzcGsoxpCfMkTGKGgQauqdKcH0ChPVIRWEr
         tD9o1Y7MPxLmN+a05ofn6At1meODNOzZbpa3hAkbYofXv4rW3ruTPeITd8d1GbJVn0wM
         sevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757321; x=1783362121;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5NfKOjNU6srylE75C2adpej95bKtXYvziT0LYJSnVds=;
        b=CrFgZEz/2xTJRuQZEQSWKvSrqwg3DcJ2Fr1qKe4sCbQ62HNMPMHY9yvtK0daXls5me
         k6rdLK+jjbMqp5zAcSTt1mHMTQPJmpT28uSiVZNzC+JUlKjLFQoxK6apHrvtsoN7Rzpu
         +yq1aHlqf9AjAeBWsD1xaMPSs8c+W7VL5eD76nqn4GffpHKMYiz7dTDirl3CzlV0dYWG
         0KlmzOuPdiiBnD9BciZ1M/UmaWKfz2J/SMObz4LJocoH6VJocaRxrAT1g7tS9iHdIdKl
         gNo4u4vpq+Yo41Ne1BulDLwQ4v0QCfkZbAjmL8/F3vEtj+Me5syxFmpXK4S/RaZ47Ii1
         oz5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rofr3JBrTYX3/MW9W37ICAWeRE0VKosN8SZp7HgYK+MASw4aEhdm3qc9LKuA3PEN/NAK48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZw78a8iJKPIvnzdYRes5w+/Wqpn7D85w7Z5Xucxw94bt+s39A
	Jd/fYiKi9STXNLDgT8+dlLde23aQgj4H3VJSQYxxUuH1oYSnF6DJI40L6G9KmItacWaAW2PDFIu
	Wi5GkWyKd+mCdsLspA/iDzE11ZOdPgg0=
X-Gm-Gg: AfdE7cmuMiKxF3Ozf0Q8S25Dxpd0Vzs9ErZ4x4RVKFTYoc5ZoBcJtgCSCaAtU2lWJ8b
	Skx+nObuC9JIyVqiJWanv+XuX0fXEDUOdnQjhKI31of7UkMR8db3r9xPP7LRJvY1frQNrU2C+57
	9O7uasxm6tQZU0mHjVaMEwIu+l4TPAjG221EJH+wVeTnOZQBgJU6w5K2jkKDDlLbtsJ8RxncQLJ
	a4Qes4isytoyfXa023VKO0I8qImVnQQ7KLGY1gUDFsEqZl1qZfTOtyOmJicaPqimFPD13I20UI5
	bvAQB+F2P8WQHnvS0ri7qWHCSyXwQg==
X-Received: by 2002:a05:6000:460d:b0:473:6e8d:7f3 with SMTP id
 ffacd0b85a97d-475506e96a8mr558778f8f.1.1782757321163; Mon, 29 Jun 2026
 11:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611-rva23u64-hwprobe-v2-v4-0-3f01a2449488@gmail.com> <20260611-rva23u64-hwprobe-v2-v4-6-3f01a2449488@gmail.com>
In-Reply-To: <20260611-rva23u64-hwprobe-v2-v4-6-3f01a2449488@gmail.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Mon, 29 Jun 2026 14:21:24 -0400
X-Gm-Features: AVVi8CeVJe5kDV9ivsXrbK-CzxJfU-Om1AQNkB7-XLVhzZDb1etpOuW05CkKE0c
Message-ID: <CAJFTR8RK2sR88ePKREmZw-9FRkWEpV_FH6s7M9TegaObqU1cwA@mail.gmail.com>
Subject: Re: [PATCH v4 06/16] riscv: Add Ziccamoa, Ziccif, Ziccrse, and Za64rs
 to cpufeature and hwprobe
To: Guodong Xu <docular.xu@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yixun Lan <dlan@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
	spacemit@lists.linux.dev, sophgo@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 4:14=E2=80=AFPM Guodong Xu <docular.xu@gmail.com> w=
rote:
>
> From: Andrew Jones <andrew.jones@oss.qualcomm.com>
>
> Add Ziccamoa, Ziccif, and Za64rs to riscv_isa_ext[] so they can be
> parsed from devicetree/ACPI ISA strings. Ziccrse is already present
> in cpufeature; this patch only adds its hwprobe exposure.
>
> Expose all four extensions via hwprobe through new bits in
> RISCV_HWPROBE_KEY_IMA_EXT_1 (RISCV_HWPROBE_EXT_ZICCAMOA, _ZICCIF,
> _ZICCRSE, _ZA64RS), so userspace can probe each of these
> RVA23U64-mandatory extensions individually.
>
> Rationale for the validation dependencies added for Ziccamoa and Za64rs:
>
> 1) Ziccamoa depends on Zaamo.  The RVA23 profile prose was updated
> post-ratification to spell out the Zaamo reference: commit
> 2b218613752d in riscv/riscv-profiles ("Improve description of
> Ziccamoa (#224)") reworded the rva23-profile.adoc (and other profiles
> that include Ziccamoa) text from "must support all atomics in A" to
> "must support all atomics in the Zaamo extension" [1].
>
> 2) Za64rs depends on Zalrsc. The unprivileged ISA manual src/zars.adoc,
> integrated in commit ebe06adc22cd ("Integrate profiles as Volume III
> (#2771)"), defines Za64rs as: "The Za64rs extension requires that the
> reservation sets used by the instructions in the Zalrsc extension be
> contiguous, naturally aligned, and at most 64 bytes in size" [2].
>
> Link: https://github.com/riscv/riscv-profiles/commit/2b218613752d63287286=
b5ae801b820cbd8cc10c [1]
> Link: https://github.com/riscv/riscv-isa-manual/blob/main/src/unpriv/zars=
.adoc [2]
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>

Reviewed-by: Jesse Taube <jtaubepe@redhat.com>

> ---
> v4: No change.
> v3: Indent the added hwprobe.rst entries to match the normalized style; n=
o other change.
> v2:
> - Rebased to v7.1-rc2.
> - Reworded subject and expanded commit message.
> - Validation added for Ziccamoa depending on Zaamo and Za64rs depending
>   on Zalrsc.
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 16 ++++++++++++++++
>  arch/riscv/include/asm/hwcap.h        |  3 +++
>  arch/riscv/include/uapi/asm/hwprobe.h |  4 ++++
>  arch/riscv/kernel/cpufeature.c        | 21 +++++++++++++++++++++
>  arch/riscv/kernel/sys_hwprobe.c       |  4 ++++
>  5 files changed, 48 insertions(+)
>
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/ri=
scv/hwprobe.rst
> index 49d9fb68632d0..893e1a1215d23 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -405,3 +405,19 @@ The following keys are defined:
>    * :c:macro:`RISCV_HWPROBE_EXT_ZICCLSM`: The Zicclsm extension is suppo=
rted,
>      as defined in the RISC-V Profiles specification starting from commit
>      b1d80660 ("Updated to ratified state.")
> +
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZICCAMOA`: The Ziccamoa extension is sup=
ported,
> +    as defined in the RISC-V Profiles specification starting from commit
> +    b1d80660 ("Updated to ratified state.")
> +
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZICCIF`: The Ziccif extension is support=
ed,
> +    as defined in the RISC-V Profiles specification starting from commit
> +    b1d80660 ("Updated to ratified state.")
> +
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZICCRSE`: The Ziccrse extension is suppo=
rted,
> +    as defined in the RISC-V Profiles specification starting from commit
> +    b1d80660 ("Updated to ratified state.")
> +
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZA64RS`: The Za64rs extension is support=
ed,
> +    as defined in the RISC-V Profiles specification starting from commit
> +    b1d80660 ("Updated to ratified state.")
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index e8f4a7dd96a93..0acb7a01ecc0f 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -113,6 +113,9 @@
>  #define RISCV_ISA_EXT_ZICFILP          104
>  #define RISCV_ISA_EXT_ZICFISS          105
>  #define RISCV_ISA_EXT_ZICCLSM          106
> +#define RISCV_ISA_EXT_ZICCAMOA         107
> +#define RISCV_ISA_EXT_ZICCIF           108
> +#define RISCV_ISA_EXT_ZA64RS           109
>
>  #define RISCV_ISA_EXT_XLINUXENVCFG     127
>
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index 6819df159c51e..58d1e86e47ae7 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -117,6 +117,10 @@ struct riscv_hwprobe {
>  #define RISCV_HWPROBE_KEY_IMA_EXT_1            16
>  #define                RISCV_HWPROBE_EXT_ZICFISS       (1ULL << 0)
>  #define                RISCV_HWPROBE_EXT_ZICCLSM       (1ULL << 1)
> +#define                RISCV_HWPROBE_EXT_ZICCAMOA      (1ULL << 2)
> +#define                RISCV_HWPROBE_EXT_ZICCIF        (1ULL << 3)
> +#define                RISCV_HWPROBE_EXT_ZICCRSE       (1ULL << 4)
> +#define                RISCV_HWPROBE_EXT_ZA64RS        (1ULL << 5)
>
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 1fb595581adcf..b9538e69fa1b3 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -90,6 +90,24 @@ static int riscv_ext_f_depends(const struct riscv_isa_=
ext_data *data,
>         return -EPROBE_DEFER;
>  }
>
> +static int riscv_ext_zaamo_depends(const struct riscv_isa_ext_data *data=
,
> +                                  const unsigned long *isa_bitmap)
> +{
> +       if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZAA=
MO))
> +               return 0;
> +
> +       return -EPROBE_DEFER;
> +}
> +
> +static int riscv_ext_zalrsc_depends(const struct riscv_isa_ext_data *dat=
a,
> +                                   const unsigned long *isa_bitmap)
> +{
> +       if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZAL=
RSC))
> +               return 0;
> +
> +       return -EPROBE_DEFER;
> +}
> +
>  static int riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *da=
ta,
>                                      const unsigned long *isa_bitmap)
>  {
> @@ -502,6 +520,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>         __RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, r=
iscv_xlinuxenvcfg_exts, riscv_ext_zicbom_validate),
>         __RISCV_ISA_EXT_DATA_VALIDATE(zicbop, RISCV_ISA_EXT_ZICBOP, riscv=
_ext_zicbop_validate),
>         __RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, r=
iscv_xlinuxenvcfg_exts, riscv_ext_zicboz_validate),
> +       __RISCV_ISA_EXT_DATA_VALIDATE(ziccamoa, RISCV_ISA_EXT_ZICCAMOA, r=
iscv_ext_zaamo_depends),
> +       __RISCV_ISA_EXT_DATA(ziccif, RISCV_ISA_EXT_ZICCIF),
>         __RISCV_ISA_EXT_DATA(zicclsm, RISCV_ISA_EXT_ZICCLSM),
>         __RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
>         __RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfilp, RISCV_ISA_EXT_ZICFILP,=
 riscv_xlinuxenvcfg_exts,
> @@ -516,6 +536,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>         __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>         __RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
>         __RISCV_ISA_EXT_DATA(zimop, RISCV_ISA_EXT_ZIMOP),
> +       __RISCV_ISA_EXT_DATA_VALIDATE(za64rs, RISCV_ISA_EXT_ZA64RS, riscv=
_ext_zalrsc_depends),
>         __RISCV_ISA_EXT_DATA(zaamo, RISCV_ISA_EXT_ZAAMO),
>         __RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
>         __RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index 9cf62266f1890..b15ac9adf7920 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -206,6 +206,10 @@ static void hwprobe_isa_ext1(struct riscv_hwprobe *p=
air,
>                  */
>                 EXT_KEY(isainfo->isa, ZICFISS, pair->value, missing);
>                 EXT_KEY(isainfo->isa, ZICCLSM, pair->value, missing);
> +               EXT_KEY(isainfo->isa, ZICCAMOA, pair->value, missing);
> +               EXT_KEY(isainfo->isa, ZICCIF, pair->value, missing);
> +               EXT_KEY(isainfo->isa, ZICCRSE, pair->value, missing);
> +               EXT_KEY(isainfo->isa, ZA64RS, pair->value, missing);
>         }
>
>         /* Now turn off reporting features if any CPU is missing it. */
>
> --
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
