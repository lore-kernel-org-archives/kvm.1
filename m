Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F72EBB8D
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059562; cv=pass; b=Gc0aPUPyB3N+NpzxYhyy+UUvdmoI9Mu4ALbo7JMg8MJZEHBUmwQq5Y0Bqb7Z0ZUItvrkirW53PQIvUcfdfUdzaYdlXub6PVGxOxNUDiJAe6h0eGi4mU6H3uPHL83FXshDgFnt5jXHqI4JG7P/N808HdHvTRcymhS6RvAmrWj8/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059562; c=relaxed/simple;
	bh=vDEr12M9PgzwCflKiVXqB+gPHmI7O1NfvjvgGy/ZKC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGXC4+WW3MnXTi5GpcGH+sf1oNZAPUHy8xatIS/3LTWBuW/tn5CwnY08nH5+PCB7IkRNm/+3wkF/Bjr39nAZFAWhU6ihL2DXp02/X04c+gbwRqePKvUO0DsGu7OEOWxTs2bY50eXKuW0M1vjIAp7lXc6lsS1Apuxypa56s1l0XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=2UmXWEZJ; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="2UmXWEZJ"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-679b072ed3aso3822957eaf.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 09:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775059560; cv=none;
        d=google.com; s=arc-20240605;
        b=lZkh3gxQCadI3HzXdVr97DAzf8C3ETXjnVeZmjugKhqCnlbISd8RsOkDhClL62gBvm
         OB97lKplMW6Pis42l90a9teQBgSTB2UuUr52soh8wbP1A5waRCxoZOBMyOHS75LKyxTB
         fKE0aBUg1nt8RyN5BOrdaCLD4rh9/DzlC8gttlcn4daqLyP9umeMgBJzG8hX04L+tXyq
         BrzbNlGgqw6lFSA8bmGsHrj8UfYiuKRKpApegBj+j/i9hBA1hNRAXu+Kv9PwMMkamFrz
         c6rpx7MxnSO4BCuSHRCPIfrPVcPHE/ZCxuXLnpL3yS5Sd0hcVROt5wHxKTKXvzkpksfm
         QgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2K4NyhHCMd8zoqLYq9nB5V2Ysiwf1MV0VYCls+gbenU=;
        fh=oF7Sm0Ec2PKyD0teOVuJmNK9bJLDvtkDTiVr5f5vCoU=;
        b=dZVzyvkhNdzNEk+JfRqbFn7IgB9Vlz+OJ5zN0+6Yhyv700TP3koR9X1DV6/Ud2LZBB
         i+gGUMAfUpIM1ckmXV1veycwZgyEKaaj3L/Qa3cluuyoLESYELPUalVshfyvgKfP5aGu
         u7HJeS2NRjPIqQ3hBO+IqL3ici8RpAm9EZM16zzqzZaamo2g/LafCE7WLhhMiI4PFMNm
         zxx4gDFZAeXlatQSDADEdLVc9IF77NtyJxNbTNZg9BIhbFY8MS0c573m8d6Uc/8z9IL7
         7t73labbPPvPnB7+TRW9GjjJDBDIbkdArn4BsXsNe4/aIqZOwotCtueMAS12rhtFlqZY
         F4Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1775059560; x=1775664360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2K4NyhHCMd8zoqLYq9nB5V2Ysiwf1MV0VYCls+gbenU=;
        b=2UmXWEZJQAieOb2YCEOHpZqRXUf6cDUmAzxN7YYZuGyUdA9vTuHIp9Kmpshrg4ZkwV
         gj6R2B3RKB40GQl6WYgeYts9OKbvcQmXeuH/NnV0uhgeM1SXheZ6Bl4yvARiazUjG8cg
         z0guXopDReZ6f+FSaCSdDCcpAxHqLgjaGgiaZXDJcr0pZw4TyXDimRn5mzInsBTT+m9U
         10+nEloLjFxLQYgQYt0dWmd8BX6VazmvW1t/HM7o6goqqkNqvVzXDBj9r10RnL+en1eS
         e3hnNkKg8CJF7XB4I/rkA2Js2aSGvE8/uy8JM2tY4aUaNrzb8fZmDHEWbZmhCcOpvjIp
         z/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059560; x=1775664360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2K4NyhHCMd8zoqLYq9nB5V2Ysiwf1MV0VYCls+gbenU=;
        b=T624FiR8ysfQdbJNR1rVJIVLMDH+IY+P8Iz/u7eeMDz2arZqFglJqXkGsbkwxGogEO
         TKxiNt720XxmN5jrnvKe8efWIaZipAh33Ut9TXqil/g0q/BGRw36smd6XZ/gokS93F/u
         yq/5YKK9HWK5uP9Gj15Yy9HX+GDpnt2yyKkQ1UW3qqMIMiQE4OQG1RyHKfHM2soBsC2P
         fKw6MpgDU9qvyypxbrGGZSrfJeoYOUMz9a8CVxoExn1A+J2O78We2t3t/GBvBdM6OzS/
         Fs9QsGUI8MutCfHYLxY/NepLB/Jup01hYO9YqOIAh9/VRzNUXAu7hHsEJrQq/X4Vu8Lm
         drAg==
X-Forwarded-Encrypted: i=1; AJvYcCWw51v8LP4n3kkaH1iNlbARAUhhY3Q9sIhokx4gJorDP9X608swfZfFVhBg4QcGxFdKHtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLgBpQiE3zUSyfsYcXfqTt++G5y4PXJZSrVxx64Rmb9KqXKxJ
	nBJ0SJTienXF9vmVJMOH03El4b/62RniAoXVg3el/NALZ3t5VcWMNH5oUQGlmagVGc8VAoEYDt8
	HlMqoPHMmNL+Tf5mPRkLhC/ChcDjjWgTYJFysq2csDw==
X-Gm-Gg: ATEYQzxAkhKwRUPJk1cf+ZK5lEBAjSFkGIAh5N3F5BXhjZTniIqmacXxRYQeTcm+CUI
	xUhEMj3b1NyzWnYgGZqI87x9ruUpKnBI3I0Dx/7CxfeZXS9wp6KxmJn17ZGCQNHq1o3cP7/wMM4
	fGrNMl9oLP6t16NGz7J5FYxVym4ru8wUUKgHK/hfhc/vfc0WqgRDfAFtTsHi62H/I1irn7jrdpY
	T1cgJefZ6TjlIc7yI02PPTQh2zrM+wxitrWpCuD/XzdyejfEcOSx54OkGhoHflysUetIYeqLYUa
	daCT6o9u9MldMHGut9bORJp4zdLkg2R4xtG1Qs/KnbgIsMv2mpXxGSLsERdGv0ze4bT5W0clcwN
	eedjWuedhvEuz2FM7jBWoK5Z+kQ==
X-Received: by 2002:a05:6820:20e:b0:67e:160c:36b2 with SMTP id
 006d021491bc7-67fabc4777emr2159558eaf.28.1775059560252; Wed, 01 Apr 2026
 09:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330122601.22140-1-fangyu.yu@linux.alibaba.com> <20260330122601.22140-4-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260330122601.22140-4-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 1 Apr 2026 21:35:48 +0530
X-Gm-Features: AQROBzDM7bVlUhSWF6Q8E65n0DpGAN3y24N8aEA-TFGvi-8F5L0Cn7-ZT4MJS6I
Message-ID: <CAAhSdy0ri8sWZn0CsCpfSgNqXw5gEesfKxcKqc56azVOrqz86w@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] RISC-V: KVM: Detect and expose supported HGATP
 G-stage modes
To: fangyu.yu@linux.alibaba.com
Cc: pbonzini@redhat.com, corbet@lwn.net, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	skhan@linuxfoundation.org, guoren@kernel.org, radim.krcmar@oss.qualcomm.com, 
	andrew.jones@oss.qualcomm.com, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 5:56=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote=
:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Extend kvm_riscv_gstage_mode_detect() to probe all HGATP.MODE values
> supported by the host and record them in a bitmask. Keep tracking the
> maximum supported G-stage page table level for existing internal users.
>
> Also provide lightweight helpers to retrieve the supported-mode bitmask
> and validate a requested HGATP.MODE against it.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---
>  arch/riscv/include/asm/kvm_gstage.h | 11 ++++++++
>  arch/riscv/kvm/gstage.c             | 43 +++++++++++++++--------------
>  2 files changed, 34 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index 70d9d483365e..bbf8f45c6563 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -31,6 +31,7 @@ struct kvm_gstage_mapping {
>  #endif
>
>  extern unsigned long kvm_riscv_gstage_max_pgd_levels;
> +extern u32 kvm_riscv_gstage_supported_mode_mask;
>
>  #define kvm_riscv_gstage_pgd_xbits     2
>  #define kvm_riscv_gstage_pgd_size      (1UL << (HGATP_PAGE_SHIFT + kvm_r=
iscv_gstage_pgd_xbits))
> @@ -102,4 +103,14 @@ static inline void kvm_riscv_gstage_init(struct kvm_=
gstage *gstage, struct kvm *
>         gstage->pgd_levels =3D kvm->arch.pgd_levels;
>  }
>
> +static inline u32 kvm_riscv_get_hgatp_mode_mask(void)
> +{
> +       return kvm_riscv_gstage_supported_mode_mask;
> +}
> +
> +static inline bool kvm_riscv_hgatp_mode_is_valid(unsigned long mode)
> +{
> +       return kvm_riscv_gstage_supported_mode_mask & BIT(mode);
> +}
> +
>  #endif
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index 7c4c34bc191b..459041255c14 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -16,6 +16,8 @@ unsigned long kvm_riscv_gstage_max_pgd_levels __ro_afte=
r_init =3D 3;
>  #else
>  unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init =3D 2;
>  #endif
> +/* Bitmask of supported HGATP.MODE encodings (BIT(HGATP_MODE_*)). */
> +u32 kvm_riscv_gstage_supported_mode_mask __ro_after_init;
>
>  #define gstage_pte_leaf(__ptep)        \
>         (pte_val(*(__ptep)) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC))
> @@ -315,42 +317,43 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *g=
stage, gpa_t start, gpa_t end
>         }
>  }
>
> +static bool __init kvm_riscv_hgatp_mode_supported(unsigned long mode)
> +{
> +       csr_write(CSR_HGATP, mode << HGATP_MODE_SHIFT);
> +       return ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D mode);
> +}
> +
>  void __init kvm_riscv_gstage_mode_detect(void)
>  {
> +       kvm_riscv_gstage_supported_mode_mask =3D 0;
> +       kvm_riscv_gstage_max_pgd_levels =3D 0;
> +
>  #ifdef CONFIG_64BIT
> -       /* Try Sv57x4 G-stage mode */
> -       csr_write(CSR_HGATP, HGATP_MODE_SV57X4 << HGATP_MODE_SHIFT);
> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V57X4) {
> -               kvm_riscv_gstage_max_pgd_levels =3D 5;
> -               goto done;
> +       /* Try Sv39x4 G-stage mode */
> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV39X4)) {
> +               kvm_riscv_gstage_supported_mode_mask |=3D BIT(HGATP_MODE_=
SV39X4);
> +               kvm_riscv_gstage_max_pgd_levels =3D 3;
>         }
>
>         /* Try Sv48x4 G-stage mode */
> -       csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V48X4) {
> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV48X4)) {
> +               kvm_riscv_gstage_supported_mode_mask |=3D BIT(HGATP_MODE_=
SV48X4);
>                 kvm_riscv_gstage_max_pgd_levels =3D 4;
> -               goto done;

Keep the original approach until then NACK to this series.

Regards,
Anup

>         }
>
> -       /* Try Sv39x4 G-stage mode */
> -       csr_write(CSR_HGATP, HGATP_MODE_SV39X4 << HGATP_MODE_SHIFT);
> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V39X4) {
> -               kvm_riscv_gstage_max_pgd_levels =3D 3;
> -               goto done;
> +       /* Try Sv57x4 G-stage mode */
> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV57X4)) {
> +               kvm_riscv_gstage_supported_mode_mask |=3D BIT(HGATP_MODE_=
SV57X4);
> +               kvm_riscv_gstage_max_pgd_levels =3D 5;
>         }
>  #else /* CONFIG_32BIT */
>         /* Try Sv32x4 G-stage mode */
> -       csr_write(CSR_HGATP, HGATP_MODE_SV32X4 << HGATP_MODE_SHIFT);
> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V32X4) {
> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV32X4)) {
> +               kvm_riscv_gstage_supported_mode_mask |=3D BIT(HGATP_MODE_=
SV32X4);
>                 kvm_riscv_gstage_max_pgd_levels =3D 2;
> -               goto done;
>         }
>  #endif
>
> -       /* KVM depends on !HGATP_MODE_OFF */
> -       kvm_riscv_gstage_max_pgd_levels =3D 0;
> -
> -done:
>         csr_write(CSR_HGATP, 0);
>         kvm_riscv_local_hfence_gvma_all();
>  }
> --
> 2.50.1
>
