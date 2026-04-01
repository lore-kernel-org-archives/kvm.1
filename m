Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541943DA40
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059380; cv=pass; b=g4hhzNWjAzz611I/TvP3olq/OBEAo72v6JkZySjZwQTEB49bh2GrTNaARmllyj9GxlfOS8JusAkO/TWQoKfhrv6o9bs+IWrmFRYyoG6PZA0cEBSmDFL8mnMbCSM3NRRZhQAbIwOmwVqQ0j9D7emQbWvrMMzxLft1HJ3tuWCKfMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059380; c=relaxed/simple;
	bh=MTd2nJRozrLx4GF5Tp5GXksqRhdnuTgVhQXXBU3eqRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCOo655dH87RzWrVttIwEeuKtT2EL/XJ3ZzAe6+1JeFfgn4li9mt9Mk/SnxIw7997fGbwEDqH8ytiy0wPVk+V2uFPxeD7Um03lMvpzDAEpReuFfrZWSDOM/o7OM6ZuvY5/zaJ10fpP4fwpVWNz3lafgsmtMxOsBpvAyP9mmlrk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=yCijcrZy; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="yCijcrZy"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso3875574a91.3
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 09:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775059378; cv=none;
        d=google.com; s=arc-20240605;
        b=bEAlvKK4ZvXTgTFRhBg5EdWDGevijKOYFGqEnXh6lK6pJp77zepz6idDwuJpk7zVzf
         p8lzPiBlSoTyOVZHWFi32Jxzf8YUA92yUfkpFwSsYazJ5IQU7zIrk92MXh6d/H/sDa6J
         9z5hOgu5XOG6Kxx+cx+Tnuv6FPK+fsD1goIsgVsyfEv956RBnKFM1W9xfI29f5rNHmSR
         9ZlosxA6a8DnL3RjMvBJtxjNCsVmW4G536/jbUlvn2RfbIrbm7e2iOC3dtYDPblbNWP6
         5sUPqJC1BoReIDd8qQ9Aqb147+aCW2/kMJ3yyPDG27wgYTl9KRnAc9fY+cC+df62UgWA
         KJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OMT9lulyLBcSntmXbpYFEYJQdhSRBHowu9klfJO+kOY=;
        fh=sNwqaLRhxUxU/VjRubjr+r04vPLn0SZbrVzhDAkKkSs=;
        b=ba0XVGwb6dapzsfVHwcN1H8k+c4gqfvQ3gE7VuzHslGZsyIN57laWuiEg8AfQnUx7O
         jgYe8+0CVCbtrVExbgTvw8EacjLzQ3SHU7fCd/F2wYIKycmaZxJ/XWYd1M+SQiTCwHxl
         ueM7y74a2V/jC5mYCDCFAZMBYmScF64OvBSQ0XRViBsc68x77xVKqbeTaSUT6FbnETWu
         dST2oWBiuOvt8qaVMVJQD9OpBx4/N9aB0pKtn+Slm8+dIxQCcO199ZaSzQ4pnTOFfVk6
         q+Y4U2bJNCW33kxLnLrPkYz7FWdaYSnUwzvkEg0iANKJ4lPztmLfa/xwVzgew108NDnY
         gCbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1775059378; x=1775664178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMT9lulyLBcSntmXbpYFEYJQdhSRBHowu9klfJO+kOY=;
        b=yCijcrZyyKWqXt4+hsa2Aw7zQRuYQ7JgsO9xCiaxG+3PA8UePNXvQ+bGnbC/si5DXF
         Cm8m+gRWIreAEnzzQtMqKEfuTOh1vNuCtU/xjeH6gPC0rK2EXydMMsxCeyyzDt5HB/2n
         Zpoy6vuNr3lJGveGV6aDEVPL65SoDVwYiq+xHZ/5kB7zpj1EKSSTl7uWHs1NnXl3gCWd
         qwMmkq6XGtfLtgbvP0HGiL5yiCTwOknF0gLGECdtocdn7mTu7KN9+cpeQgXzV1i51uIQ
         QqcU+gS4dftgdIUujPRq7fG2vwAay/iFsLJLxnQ5J5yBsLfXKvUzN/GXVX/rOPZjRxo/
         g40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059378; x=1775664178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OMT9lulyLBcSntmXbpYFEYJQdhSRBHowu9klfJO+kOY=;
        b=qSwd8pEc6K+z6P9R48uLBvn1AKQpUN7fO8kU11jhuUUmJa7H9RkL8mnzsrTbOGJnfJ
         4QXR50XWVxW8niO4IgTiO2qbvivFpPPg2D8gylVZ3KBOg1/3hR9rb0VTgKneO/ssloSi
         EmCRs3u+hk3W6HUi5QkMnB+mpcwKt7Lso566W3JcHDRm6OibamwzOuOJHTsg0Ks1kbi5
         krmwgKs+9fsfgAndb5LIspB1UoI3SPaA1Xi4FjncxLEbzq040KdgDZCTkMypO8IGwzuo
         XM/Uo8/OpxC5tOanigEs0BjG64/lRflfxhWkt/RPef/qE3TfZ8P6PeZkfA9hR+rAlPro
         Y2fw==
X-Forwarded-Encrypted: i=1; AJvYcCVZdUrWObWd6lmjqBgkoAPwgHuFpZLpf/8xP6g5RzReyLrVjfvXgt6WgzlIBI99vVJ38OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtEdcpodD3rwjcIp+npxUKSgYY3JB66DhztA/qGUwNVvzphCKq
	Pwi2/8+dmMOQFCTHZ6aB5/0/0biZklxgvpgHlHl3NpCKDkikrN/1KZy29466L40yIPh0rpEygcM
	2m/90JWVfene+VCqEvppUG8dIsqJsFf1M9UoQgIfSmQ==
X-Gm-Gg: ATEYQzwkvZs7KH5zN9/kUb6PcFZKT2lZlnmwYI5sDhDbDL4qnK2X6MP37J+OKUqOudq
	9QHZA2a6MPxan1soIyAg+AjSfznxoUdAnWK3QqEDTfd8RPuiZU7Zg7+2B0mYhZNB/UlH6Gc49v0
	lxeIGUbLQcbGyZv7PDnYEULMjRdAK4Cp+OudssRX4SnhrVqgVRouq50+jyOoOcg7G7PZ4mz3lFH
	/2FffVyVkrfxhrlUOq88olu7EOA81OI9Dk8kEU17XR3ynb3UDdSuA1eEg2sk6/yJXCvXKvQZDvN
	4Yr4s2IeGLsL6k2o4PRb3efFmP1uEm7wKYjJHQGfZ9rB2f93rnkG8GLL/Kc49nY7K+5rz8prUun
	aleLJJif9hoDsHaJQoB+BHb/KoQ==
X-Received: by 2002:a17:90b:4b05:b0:35b:e593:b1d7 with SMTP id
 98e67ed59e1d1-35dc6e6d8bfmr3795625a91.12.1775059378093; Wed, 01 Apr 2026
 09:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330122601.22140-1-fangyu.yu@linux.alibaba.com> <20260330122601.22140-2-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260330122601.22140-2-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 1 Apr 2026 21:32:46 +0530
X-Gm-Features: AQROBzC0R5KEvL-Idz4cBsai6m-vHMIkTNBV8qkH0V26M0g-Z9zdj8PhS1-m5hU
Message-ID: <CAAhSdy1D-6wNXGbaCF0LZ-29kQGDUEwGD0Q0t+Azc5=kS+E=xA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] RISC-V: KVM: Support runtime configuration for
 per-VM's HGATP mode
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
> Introduces one per-VM architecture-specific fields to support runtime
> configuration of the G-stage page table format:
>
> - kvm->arch.pgd_levels: the corresponding number of page table levels
>   for the selected mode.
>
> These fields replace the previous global variables
> kvm_riscv_gstage_mode and kvm_riscv_gstage_pgd_levels, enabling different
> virtual machines to independently select their G-stage page table format
> instead of being forced to share the maximum mode detected by the kernel
> at boot time.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kvm_gstage.h | 37 ++++++++++++----
>  arch/riscv/include/asm/kvm_host.h   |  1 +
>  arch/riscv/kvm/gstage.c             | 65 ++++++++++++++---------------
>  arch/riscv/kvm/main.c               | 12 +++---
>  arch/riscv/kvm/mmu.c                | 20 +++++----
>  arch/riscv/kvm/vm.c                 |  2 +-
>  arch/riscv/kvm/vmid.c               |  3 +-
>  7 files changed, 83 insertions(+), 57 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index 595e2183173e..5aa58d1f692a 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -29,16 +29,22 @@ struct kvm_gstage_mapping {
>  #define kvm_riscv_gstage_index_bits    10
>  #endif
>
> -extern unsigned long kvm_riscv_gstage_mode;
> -extern unsigned long kvm_riscv_gstage_pgd_levels;
> +extern unsigned long kvm_riscv_gstage_max_pgd_levels;
>
>  #define kvm_riscv_gstage_pgd_xbits     2
>  #define kvm_riscv_gstage_pgd_size      (1UL << (HGATP_PAGE_SHIFT + kvm_r=
iscv_gstage_pgd_xbits))
> -#define kvm_riscv_gstage_gpa_bits      (HGATP_PAGE_SHIFT + \
> -                                        (kvm_riscv_gstage_pgd_levels * \
> -                                         kvm_riscv_gstage_index_bits) + =
\
> -                                        kvm_riscv_gstage_pgd_xbits)
> -#define kvm_riscv_gstage_gpa_size      ((gpa_t)(1ULL << kvm_riscv_gstage=
_gpa_bits))
> +
> +static inline unsigned long kvm_riscv_gstage_gpa_bits(unsigned long pgd_=
levels)
> +{
> +       return (HGATP_PAGE_SHIFT +
> +               pgd_levels * kvm_riscv_gstage_index_bits +
> +               kvm_riscv_gstage_pgd_xbits);
> +}
> +
> +static inline gpa_t kvm_riscv_gstage_gpa_size(unsigned long pgd_levels)
> +{
> +       return BIT_ULL(kvm_riscv_gstage_gpa_bits(pgd_levels));
> +}
>
>  bool kvm_riscv_gstage_get_leaf(struct kvm_gstage *gstage, gpa_t addr,
>                                pte_t **ptepp, u32 *ptep_level);
> @@ -69,4 +75,21 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gsta=
ge, gpa_t start, gpa_t end
>
>  void kvm_riscv_gstage_mode_detect(void);
>
> +static inline unsigned long kvm_riscv_gstage_mode(unsigned long pgd_leve=
ls)
> +{
> +       switch (pgd_levels) {
> +       case 2:
> +               return HGATP_MODE_SV32X4;
> +       case 3:
> +               return HGATP_MODE_SV39X4;
> +       case 4:
> +               return HGATP_MODE_SV48X4;
> +       case 5:
> +               return HGATP_MODE_SV57X4;
> +       default:
> +               WARN_ON_ONCE(1);
> +               return HGATP_MODE_OFF;
> +       }
> +}
> +
>  #endif
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 24585304c02b..478f699e9dec 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -94,6 +94,7 @@ struct kvm_arch {
>         /* G-stage page table */
>         pgd_t *pgd;
>         phys_addr_t pgd_phys;
> +       unsigned long pgd_levels;
>
>         /* Guest Timer */
>         struct kvm_guest_timer timer;
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index b67d60d722c2..4beb9322fe76 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -12,22 +12,21 @@
>  #include <asm/kvm_gstage.h>
>
>  #ifdef CONFIG_64BIT
> -unsigned long kvm_riscv_gstage_mode __ro_after_init =3D HGATP_MODE_SV39X=
4;
> -unsigned long kvm_riscv_gstage_pgd_levels __ro_after_init =3D 3;
> +unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init =3D 3;
>  #else
> -unsigned long kvm_riscv_gstage_mode __ro_after_init =3D HGATP_MODE_SV32X=
4;
> -unsigned long kvm_riscv_gstage_pgd_levels __ro_after_init =3D 2;
> +unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init =3D 2;
>  #endif
>
>  #define gstage_pte_leaf(__ptep)        \
>         (pte_val(*(__ptep)) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC))
>
> -static inline unsigned long gstage_pte_index(gpa_t addr, u32 level)
> +static inline unsigned long gstage_pte_index(struct kvm_gstage *gstage,
> +                                            gpa_t addr, u32 level)
>  {
>         unsigned long mask;
>         unsigned long shift =3D HGATP_PAGE_SHIFT + (kvm_riscv_gstage_inde=
x_bits * level);
>
> -       if (level =3D=3D (kvm_riscv_gstage_pgd_levels - 1))
> +       if (level =3D=3D gstage->kvm->arch.pgd_levels - 1)
>                 mask =3D (PTRS_PER_PTE * (1UL << kvm_riscv_gstage_pgd_xbi=
ts)) - 1;
>         else
>                 mask =3D PTRS_PER_PTE - 1;
> @@ -40,12 +39,13 @@ static inline unsigned long gstage_pte_page_vaddr(pte=
_t pte)
>         return (unsigned long)pfn_to_virt(__page_val_to_pfn(pte_val(pte))=
);
>  }
>
> -static int gstage_page_size_to_level(unsigned long page_size, u32 *out_l=
evel)
> +static int gstage_page_size_to_level(struct kvm_gstage *gstage, unsigned=
 long page_size,
> +                                    u32 *out_level)
>  {
>         u32 i;
>         unsigned long psz =3D 1UL << 12;
>
> -       for (i =3D 0; i < kvm_riscv_gstage_pgd_levels; i++) {
> +       for (i =3D 0; i < gstage->kvm->arch.pgd_levels; i++) {
>                 if (page_size =3D=3D (psz << (i * kvm_riscv_gstage_index_=
bits))) {
>                         *out_level =3D i;
>                         return 0;
> @@ -55,21 +55,23 @@ static int gstage_page_size_to_level(unsigned long pa=
ge_size, u32 *out_level)
>         return -EINVAL;
>  }
>
> -static int gstage_level_to_page_order(u32 level, unsigned long *out_pgor=
der)
> +static int gstage_level_to_page_order(struct kvm_gstage *gstage, u32 lev=
el,
> +                                     unsigned long *out_pgorder)
>  {
> -       if (kvm_riscv_gstage_pgd_levels < level)
> +       if (gstage->kvm->arch.pgd_levels < level)
>                 return -EINVAL;
>
>         *out_pgorder =3D 12 + (level * kvm_riscv_gstage_index_bits);
>         return 0;
>  }
>
> -static int gstage_level_to_page_size(u32 level, unsigned long *out_pgsiz=
e)
> +static int gstage_level_to_page_size(struct kvm_gstage *gstage, u32 leve=
l,
> +                                    unsigned long *out_pgsize)
>  {
>         int rc;
>         unsigned long page_order =3D PAGE_SHIFT;
>
> -       rc =3D gstage_level_to_page_order(level, &page_order);
> +       rc =3D gstage_level_to_page_order(gstage, level, &page_order);
>         if (rc)
>                 return rc;
>
> @@ -81,11 +83,11 @@ bool kvm_riscv_gstage_get_leaf(struct kvm_gstage *gst=
age, gpa_t addr,
>                                pte_t **ptepp, u32 *ptep_level)
>  {
>         pte_t *ptep;
> -       u32 current_level =3D kvm_riscv_gstage_pgd_levels - 1;
> +       u32 current_level =3D gstage->kvm->arch.pgd_levels - 1;
>
>         *ptep_level =3D current_level;
>         ptep =3D (pte_t *)gstage->pgd;
> -       ptep =3D &ptep[gstage_pte_index(addr, current_level)];
> +       ptep =3D &ptep[gstage_pte_index(gstage, addr, current_level)];
>         while (ptep && pte_val(ptep_get(ptep))) {
>                 if (gstage_pte_leaf(ptep)) {
>                         *ptep_level =3D current_level;
> @@ -97,7 +99,7 @@ bool kvm_riscv_gstage_get_leaf(struct kvm_gstage *gstag=
e, gpa_t addr,
>                         current_level--;
>                         *ptep_level =3D current_level;
>                         ptep =3D (pte_t *)gstage_pte_page_vaddr(ptep_get(=
ptep));
> -                       ptep =3D &ptep[gstage_pte_index(addr, current_lev=
el)];
> +                       ptep =3D &ptep[gstage_pte_index(gstage, addr, cur=
rent_level)];
>                 } else {
>                         ptep =3D NULL;
>                 }
> @@ -110,7 +112,7 @@ static void gstage_tlb_flush(struct kvm_gstage *gstag=
e, u32 level, gpa_t addr)
>  {
>         unsigned long order =3D PAGE_SHIFT;
>
> -       if (gstage_level_to_page_order(level, &order))
> +       if (gstage_level_to_page_order(gstage, level, &order))
>                 return;
>         addr &=3D ~(BIT(order) - 1);
>
> @@ -125,9 +127,9 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstag=
e,
>                              struct kvm_mmu_memory_cache *pcache,
>                              const struct kvm_gstage_mapping *map)
>  {
> -       u32 current_level =3D kvm_riscv_gstage_pgd_levels - 1;
> +       u32 current_level =3D gstage->kvm->arch.pgd_levels - 1;
>         pte_t *next_ptep =3D (pte_t *)gstage->pgd;
> -       pte_t *ptep =3D &next_ptep[gstage_pte_index(map->addr, current_le=
vel)];
> +       pte_t *ptep =3D &next_ptep[gstage_pte_index(gstage, map->addr, cu=
rrent_level)];
>
>         if (current_level < map->level)
>                 return -EINVAL;
> @@ -151,7 +153,7 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstag=
e,
>                 }
>
>                 current_level--;
> -               ptep =3D &next_ptep[gstage_pte_index(map->addr, current_l=
evel)];
> +               ptep =3D &next_ptep[gstage_pte_index(gstage, map->addr, c=
urrent_level)];
>         }
>
>         if (pte_val(*ptep) !=3D pte_val(map->pte)) {
> @@ -175,7 +177,7 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gsta=
ge,
>         out_map->addr =3D gpa;
>         out_map->level =3D 0;
>
> -       ret =3D gstage_page_size_to_level(page_size, &out_map->level);
> +       ret =3D gstage_page_size_to_level(gstage, page_size, &out_map->le=
vel);
>         if (ret)
>                 return ret;
>
> @@ -217,7 +219,7 @@ void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstag=
e, gpa_t addr,
>         u32 next_ptep_level;
>         unsigned long next_page_size, page_size;
>
> -       ret =3D gstage_level_to_page_size(ptep_level, &page_size);
> +       ret =3D gstage_level_to_page_size(gstage, ptep_level, &page_size)=
;
>         if (ret)
>                 return;
>
> @@ -229,7 +231,7 @@ void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstag=
e, gpa_t addr,
>         if (ptep_level && !gstage_pte_leaf(ptep)) {
>                 next_ptep =3D (pte_t *)gstage_pte_page_vaddr(ptep_get(pte=
p));
>                 next_ptep_level =3D ptep_level - 1;
> -               ret =3D gstage_level_to_page_size(next_ptep_level, &next_=
page_size);
> +               ret =3D gstage_level_to_page_size(gstage, next_ptep_level=
, &next_page_size);
>                 if (ret)
>                         return;
>
> @@ -263,7 +265,7 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *=
gstage,
>
>         while (addr < end) {
>                 found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, addr, &p=
tep, &ptep_level);
> -               ret =3D gstage_level_to_page_size(ptep_level, &page_size)=
;
> +               ret =3D gstage_level_to_page_size(gstage, ptep_level, &pa=
ge_size);
>                 if (ret)
>                         break;
>
> @@ -297,7 +299,7 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gst=
age, gpa_t start, gpa_t end
>
>         while (addr < end) {
>                 found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, addr, &p=
tep, &ptep_level);
> -               ret =3D gstage_level_to_page_size(ptep_level, &page_size)=
;
> +               ret =3D gstage_level_to_page_size(gstage, ptep_level, &pa=
ge_size);
>                 if (ret)
>                         break;
>
> @@ -319,39 +321,34 @@ void __init kvm_riscv_gstage_mode_detect(void)
>         /* Try Sv57x4 G-stage mode */
>         csr_write(CSR_HGATP, HGATP_MODE_SV57X4 << HGATP_MODE_SHIFT);
>         if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V57X4) {
> -               kvm_riscv_gstage_mode =3D HGATP_MODE_SV57X4;
> -               kvm_riscv_gstage_pgd_levels =3D 5;
> +               kvm_riscv_gstage_max_pgd_levels =3D 5;
>                 goto done;
>         }
>
>         /* Try Sv48x4 G-stage mode */
>         csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
>         if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V48X4) {
> -               kvm_riscv_gstage_mode =3D HGATP_MODE_SV48X4;
> -               kvm_riscv_gstage_pgd_levels =3D 4;
> +               kvm_riscv_gstage_max_pgd_levels =3D 4;
>                 goto done;
>         }
>
>         /* Try Sv39x4 G-stage mode */
>         csr_write(CSR_HGATP, HGATP_MODE_SV39X4 << HGATP_MODE_SHIFT);
>         if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V39X4) {
> -               kvm_riscv_gstage_mode =3D HGATP_MODE_SV39X4;
> -               kvm_riscv_gstage_pgd_levels =3D 3;
> +               kvm_riscv_gstage_max_pgd_levels =3D 3;
>                 goto done;
>         }
>  #else /* CONFIG_32BIT */
>         /* Try Sv32x4 G-stage mode */
>         csr_write(CSR_HGATP, HGATP_MODE_SV32X4 << HGATP_MODE_SHIFT);
>         if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V32X4) {
> -               kvm_riscv_gstage_mode =3D HGATP_MODE_SV32X4;
> -               kvm_riscv_gstage_pgd_levels =3D 2;
> +               kvm_riscv_gstage_max_pgd_levels =3D 2;
>                 goto done;
>         }
>  #endif
>
>         /* KVM depends on !HGATP_MODE_OFF */
> -       kvm_riscv_gstage_mode =3D HGATP_MODE_OFF;
> -       kvm_riscv_gstage_pgd_levels =3D 0;
> +       kvm_riscv_gstage_max_pgd_levels =3D 0;
>
>  done:
>         csr_write(CSR_HGATP, 0);
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 0f3fe3986fc0..90ee0a032b9a 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -105,17 +105,17 @@ static int __init riscv_kvm_init(void)
>                 return rc;
>
>         kvm_riscv_gstage_mode_detect();
> -       switch (kvm_riscv_gstage_mode) {
> -       case HGATP_MODE_SV32X4:
> +       switch (kvm_riscv_gstage_max_pgd_levels) {
> +       case 2:
>                 str =3D "Sv32x4";
>                 break;
> -       case HGATP_MODE_SV39X4:
> +       case 3:
>                 str =3D "Sv39x4";
>                 break;
> -       case HGATP_MODE_SV48X4:
> +       case 4:
>                 str =3D "Sv48x4";
>                 break;
> -       case HGATP_MODE_SV57X4:
> +       case 5:
>                 str =3D "Sv57x4";
>                 break;
>         default:
> @@ -164,7 +164,7 @@ static int __init riscv_kvm_init(void)
>                          (rc) ? slist : "no features");
>         }
>
> -       kvm_info("using %s G-stage page table format\n", str);
> +       kvm_info("highest G-stage page table mode is %s\n", str);
>
>         kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits(=
));
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 088d33ba90ed..fbcdd75cb9af 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -67,7 +67,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, p=
hys_addr_t hpa,
>                 if (!writable)
>                         map.pte =3D pte_wrprotect(map.pte);
>
> -               ret =3D kvm_mmu_topup_memory_cache(&pcache, kvm_riscv_gst=
age_pgd_levels);
> +               ret =3D kvm_mmu_topup_memory_cache(&pcache, kvm->arch.pgd=
_levels);
>                 if (ret)
>                         goto out;
>
> @@ -186,7 +186,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>          * space addressable by the KVM guest GPA space.
>          */
>         if ((new->base_gfn + new->npages) >=3D
> -           (kvm_riscv_gstage_gpa_size >> PAGE_SHIFT))
> +            kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels) >> PAGE_SHIF=
T)
>                 return -EFAULT;
>
>         hva =3D new->userspace_addr;
> @@ -472,7 +472,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>         memset(out_map, 0, sizeof(*out_map));
>
>         /* We need minimum second+third level pages */
> -       ret =3D kvm_mmu_topup_memory_cache(pcache, kvm_riscv_gstage_pgd_l=
evels);
> +       ret =3D kvm_mmu_topup_memory_cache(pcache, kvm->arch.pgd_levels);
>         if (ret) {
>                 kvm_err("Failed to topup G-stage cache\n");
>                 return ret;
> @@ -575,6 +575,7 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
>                 return -ENOMEM;
>         kvm->arch.pgd =3D page_to_virt(pgd_page);
>         kvm->arch.pgd_phys =3D page_to_phys(pgd_page);
> +       kvm->arch.pgd_levels =3D kvm_riscv_gstage_max_pgd_levels;
>
>         return 0;
>  }
> @@ -590,10 +591,12 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>                 gstage.flags =3D 0;
>                 gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
>                 gstage.pgd =3D kvm->arch.pgd;
> -               kvm_riscv_gstage_unmap_range(&gstage, 0UL, kvm_riscv_gsta=
ge_gpa_size, false);
> +               kvm_riscv_gstage_unmap_range(&gstage, 0UL,
> +                       kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels), =
false);
>                 pgd =3D READ_ONCE(kvm->arch.pgd);
>                 kvm->arch.pgd =3D NULL;
>                 kvm->arch.pgd_phys =3D 0;
> +               kvm->arch.pgd_levels =3D 0;
>         }
>         spin_unlock(&kvm->mmu_lock);
>
> @@ -603,11 +606,12 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>
>  void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
>  {
> -       unsigned long hgatp =3D kvm_riscv_gstage_mode << HGATP_MODE_SHIFT=
;
> -       struct kvm_arch *k =3D &vcpu->kvm->arch;
> +       struct kvm_arch *ka =3D &vcpu->kvm->arch;
> +       unsigned long hgatp =3D kvm_riscv_gstage_mode(ka->pgd_levels)
> +                             << HGATP_MODE_SHIFT;
>
> -       hgatp |=3D (READ_ONCE(k->vmid.vmid) << HGATP_VMID_SHIFT) & HGATP_=
VMID;
> -       hgatp |=3D (k->pgd_phys >> PAGE_SHIFT) & HGATP_PPN;
> +       hgatp |=3D (READ_ONCE(ka->vmid.vmid) << HGATP_VMID_SHIFT) & HGATP=
_VMID;
> +       hgatp |=3D (ka->pgd_phys >> PAGE_SHIFT) & HGATP_PPN;
>
>         ncsr_write(CSR_HGATP, hgatp);
>
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index 13c63ae1a78b..4d82a886102c 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -199,7 +199,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>                 r =3D KVM_USER_MEM_SLOTS;
>                 break;
>         case KVM_CAP_VM_GPA_BITS:
> -               r =3D kvm_riscv_gstage_gpa_bits;
> +               r =3D kvm_riscv_gstage_gpa_bits(kvm->arch.pgd_levels);
>                 break;
>         default:
>                 r =3D 0;
> diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
> index cf34d448289d..c15bdb1dd8be 100644
> --- a/arch/riscv/kvm/vmid.c
> +++ b/arch/riscv/kvm/vmid.c
> @@ -26,7 +26,8 @@ static DEFINE_SPINLOCK(vmid_lock);
>  void __init kvm_riscv_gstage_vmid_detect(void)
>  {
>         /* Figure-out number of VMID bits in HW */
> -       csr_write(CSR_HGATP, (kvm_riscv_gstage_mode << HGATP_MODE_SHIFT) =
| HGATP_VMID);
> +       csr_write(CSR_HGATP, (kvm_riscv_gstage_mode(kvm_riscv_gstage_max_=
pgd_levels) <<
> +                             HGATP_MODE_SHIFT) | HGATP_VMID);
>         vmid_bits =3D csr_read(CSR_HGATP);
>         vmid_bits =3D (vmid_bits & HGATP_VMID) >> HGATP_VMID_SHIFT;
>         vmid_bits =3D fls_long(vmid_bits);
> --
> 2.50.1
>
