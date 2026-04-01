Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AC743C054
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059403; cv=pass; b=ny1R+bScV+chnW+DobtLTNpRsHQ8KKhxvWZfgIgoXg3X0zrWfUA0k9LiifULweEc31XbNIeCGDhaWsirFcJLmXRcftN1Ca0LXRvub1Duawt/1vGPoJYL6WHNDzO8H43/Qstkf9kGnUHUYVtmCyi6ny+92fbybPtpNWSAsNMFxHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059403; c=relaxed/simple;
	bh=mbM3KRdOEwkdUCznnLGvGPclc/aEJCqs3l4Vg6JLXGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFowr8jH4AG/lepCVshKb/DRl/XYEkJUymK6QpBed68iY7ooqhtHaD2pxW71SNIrtCdVTPBp/B/Fm28bkSDxIMyjLjte4dFvc5wQdchNNBfy8+HKNAUxQxx1tIBO7k09eXF8bUdCGRKFOiEAJXG28tAJpWtGyhK8C6waobA70XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=qMaRzddn; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="qMaRzddn"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d7f09aa39fso8652873a34.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 09:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775059401; cv=none;
        d=google.com; s=arc-20240605;
        b=UU+fv1460c3s+dAFIt1CnkXvPLH1ubXJKr/vJ9gglCw4WVZT4mzYt1gqakkvk+E05Q
         wc2NXp+ShJo2uL9HJLXaJylM/moK+VrxPi8ro8aISmvwkmAmDD/AvWnBYQPMoPOy7KSt
         dUmoDBSm7LlVH7u2n958BjC5IUasmN702a7NaNBgm9spb3H0je3xIUqxT5fHhV3GnvVa
         XIAEbszIilvlmSjkC4r4Uy1WaqeV5sf1Uj5lHUJCiEI21b8SSOCpGGTt8srRfhdFQhrR
         SyVJfr2cdd3nMouzqa+rLuz1ydflUZlBpbikriXXHDmJPup2Iiw4WPE859zqlTe1ilN2
         tofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y6679k5FpZWkhzoFpnRhGVhgdQOTZFUspiwvpaGrRWs=;
        fh=1Tv8higzuVop/BmO+S3SlTicx7dhki/zli4VloSqM94=;
        b=G58x7HwSY+w+a31osnNnzufk0Fn6qR0+MqCsWa4uWp12P++E0UGlhrU1kdp/ZTQPKD
         BGOl2VlsTGRhrHC16gQFT0QbmrzZFPVlhH/t1d9l6agXy2pxU9mxFMYT0D458i0vLWza
         spmhPzPeHwyW8jv5v0FF6ZhkKstOMKMQKJVb5Pa0wRE0vWU9oTy2tvspwTPb4s4z4M3Q
         O44ZNZ/aWTG/Dq3tHkY0CxDyiRfcCwuicWsvFDAmq58j5l073R2M9dIaVOncsvMQk3D8
         Fyk+bmvtTnX0RvfsS3IwDDhF0MEOwDd+bsY6lwLCGR+Bb6kCVY7EfsFRqf6Yg5brN8BG
         HlPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1775059401; x=1775664201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6679k5FpZWkhzoFpnRhGVhgdQOTZFUspiwvpaGrRWs=;
        b=qMaRzddneZg4KABsuMVw33p5k9L/bKayYAi0TShK/p3CMonG9KBIjmzLsZf6zO3/zB
         RykBYN5ZJp79JnAB0kVNZZu1SH36jAn1N16RXqewgK6sFEkjs9Q9lhlhHvoplJu6V01L
         R7JwZOJ1fkNa1J2kiFVWky3gQQC705PQz3FemfsEMQOsRca+4zTaQS2DbyRXYKslZx6G
         NWY/KZrSupjCR1t1daDyeGEF4iub+KYlKPli2QdTyWGg1PNGlflP8r6yQuelCaV2YZOr
         kNi0HUIVNsri7IrLHcKn7PLEoa6pWCIvfUVXozsl/4Am+YRjnIljxz3kqqgut3OlkDHE
         A1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059401; x=1775664201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y6679k5FpZWkhzoFpnRhGVhgdQOTZFUspiwvpaGrRWs=;
        b=BINgDt0WeWY4Us9MXghujePUfZEYX+eO8xsfZO85ZKWHAsKhGlXCz6Q8wAZQ/MmbPg
         FLOR+L8cMplsY5Oa1bcXy5xS6x1zEHHFy0dH6Wyy1A18Fcn0GuqP0s8epx+5tU/lxxGd
         FawwQLAWGYnePqiI4L9Ww1w7eUVVFxcdZq616/b9uj80QQbW9W9MBH2/T97WR1fZkN76
         e8vrIbdNjkBgQ5JeI9HfcNjq7+qFu4TRcz4o03yb0/gdy608uf2gaDq8kCWJUpX0PZFz
         cFC5+i+BjUpNXO4aWhCpIdJa8RrmvPgVNhZTQLSdIRF1I2kFybBU+ChqHL1komjw7gkE
         z5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVuvAgKng0Tfjl1P5YgYT5uZ9O+ZvWEm7M4VMpfp2ceFggBKHVTSJzblYoW1WFCObL1edI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIsviIQk3PwisELcSKixNgpGHWPIm1TSF8ZfzXvqjb7PS+jdVQ
	3ucpARSyOmTrA83+QziCXDoyg9H/WxneCWjgPSvchFsnWqzJTOD0exyagFiBa9d3PjIwbSzIZnQ
	rmBl8bb5EEkT0gKgkBlz05Flj5Mbfu4bM7o65nU9bNw==
X-Gm-Gg: ATEYQzzyarMeHPLaUU3K4ENMI36bISkRCNPs8Sa7Dc2TpAGt+KFIKmPyZ0MhjRsAh9k
	VYFOyXCdBvIHW98tbq8PcQASNKjBd8+zHATd0yM7XALqdSM6d30b5LjhBa53RXIUZ0JhMwqjh7B
	ByKoHHr6c5ROBTweIykBRAJRsGmQSoitFQq6I5DbnazdbSFIaG7KPmdlA+1ksjEi0V6GuShdjcN
	oSbg9Y9e0ZG+BY5TXlRMHyyTmuUezbJUyiSeWJCUCZOnwHP3FHnIK/h3MsJa0wv0JKqdEYROBzq
	9XDB2gGWCYc1hK3evWiDwdya+B8w2/Q2+nQwsGejtBTJrnNU9ftjR8hePubxML865B6Vu4VYYv2
	ltea/gyXPAEo3nYU4U0ZMBm+SaA==
X-Received: by 2002:a05:6820:1c93:b0:67e:1b8b:862c with SMTP id
 006d021491bc7-680a2679265mr21887eaf.0.1775059400448; Wed, 01 Apr 2026
 09:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330122601.22140-1-fangyu.yu@linux.alibaba.com> <20260330122601.22140-3-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260330122601.22140-3-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 1 Apr 2026 21:33:09 +0530
X-Gm-Features: AQROBzBz6gVYqpB_gsnLxPPXEaaDdC4_ZJnZ_sb8SZfsx2vHypJpEdwwBwdfK7M
Message-ID: <CAAhSdy3qEOaow1YApEL3KiXPL6dGXu917HZGDB3Lw2VWWjAdTQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] RISC-V: KVM: Cache gstage pgd_levels in struct kvm_gstage
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
> Gstage page-table helpers frequently chase gstage->kvm->arch to
> fetch pgd_levels. This adds noise and repeats the same dereference
> chain in hot paths.
>
> Add pgd_levels to struct kvm_gstage and initialize it from kvm->arch
> when setting up a gstage instance. Introduce kvm_riscv_gstage_init()
> to centralize initialization and switch gstage code to use
> gstage->pgd_levels.
>
> Suggested-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kvm_gstage.h | 10 ++++++
>  arch/riscv/kvm/gstage.c             | 10 +++---
>  arch/riscv/kvm/mmu.c                | 50 ++++++-----------------------
>  3 files changed, 25 insertions(+), 45 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index 5aa58d1f692a..70d9d483365e 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -15,6 +15,7 @@ struct kvm_gstage {
>  #define KVM_GSTAGE_FLAGS_LOCAL         BIT(0)
>         unsigned long vmid;
>         pgd_t *pgd;
> +       unsigned long pgd_levels;
>  };
>
>  struct kvm_gstage_mapping {
> @@ -92,4 +93,13 @@ static inline unsigned long kvm_riscv_gstage_mode(unsi=
gned long pgd_levels)
>         }
>  }
>
> +static inline void kvm_riscv_gstage_init(struct kvm_gstage *gstage, stru=
ct kvm *kvm)
> +{
> +       gstage->kvm =3D kvm;
> +       gstage->flags =3D 0;
> +       gstage->vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
> +       gstage->pgd =3D kvm->arch.pgd;
> +       gstage->pgd_levels =3D kvm->arch.pgd_levels;
> +}
> +
>  #endif
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index 4beb9322fe76..7c4c34bc191b 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -26,7 +26,7 @@ static inline unsigned long gstage_pte_index(struct kvm=
_gstage *gstage,
>         unsigned long mask;
>         unsigned long shift =3D HGATP_PAGE_SHIFT + (kvm_riscv_gstage_inde=
x_bits * level);
>
> -       if (level =3D=3D gstage->kvm->arch.pgd_levels - 1)
> +       if (level =3D=3D gstage->pgd_levels - 1)
>                 mask =3D (PTRS_PER_PTE * (1UL << kvm_riscv_gstage_pgd_xbi=
ts)) - 1;
>         else
>                 mask =3D PTRS_PER_PTE - 1;
> @@ -45,7 +45,7 @@ static int gstage_page_size_to_level(struct kvm_gstage =
*gstage, unsigned long pa
>         u32 i;
>         unsigned long psz =3D 1UL << 12;
>
> -       for (i =3D 0; i < gstage->kvm->arch.pgd_levels; i++) {
> +       for (i =3D 0; i < gstage->pgd_levels; i++) {
>                 if (page_size =3D=3D (psz << (i * kvm_riscv_gstage_index_=
bits))) {
>                         *out_level =3D i;
>                         return 0;
> @@ -58,7 +58,7 @@ static int gstage_page_size_to_level(struct kvm_gstage =
*gstage, unsigned long pa
>  static int gstage_level_to_page_order(struct kvm_gstage *gstage, u32 lev=
el,
>                                       unsigned long *out_pgorder)
>  {
> -       if (gstage->kvm->arch.pgd_levels < level)
> +       if (gstage->pgd_levels < level)
>                 return -EINVAL;
>
>         *out_pgorder =3D 12 + (level * kvm_riscv_gstage_index_bits);
> @@ -83,7 +83,7 @@ bool kvm_riscv_gstage_get_leaf(struct kvm_gstage *gstag=
e, gpa_t addr,
>                                pte_t **ptepp, u32 *ptep_level)
>  {
>         pte_t *ptep;
> -       u32 current_level =3D gstage->kvm->arch.pgd_levels - 1;
> +       u32 current_level =3D gstage->pgd_levels - 1;
>
>         *ptep_level =3D current_level;
>         ptep =3D (pte_t *)gstage->pgd;
> @@ -127,7 +127,7 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstag=
e,
>                              struct kvm_mmu_memory_cache *pcache,
>                              const struct kvm_gstage_mapping *map)
>  {
> -       u32 current_level =3D gstage->kvm->arch.pgd_levels - 1;
> +       u32 current_level =3D gstage->pgd_levels - 1;
>         pte_t *next_ptep =3D (pte_t *)gstage->pgd;
>         pte_t *ptep =3D &next_ptep[gstage_pte_index(gstage, map->addr, cu=
rrent_level)];
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index fbcdd75cb9af..2d3def024270 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -24,10 +24,7 @@ static void mmu_wp_memory_region(struct kvm *kvm, int =
slot)
>         phys_addr_t end =3D (memslot->base_gfn + memslot->npages) << PAGE=
_SHIFT;
>         struct kvm_gstage gstage;
>
> -       gstage.kvm =3D kvm;
> -       gstage.flags =3D 0;
> -       gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
> -       gstage.pgd =3D kvm->arch.pgd;
> +       kvm_riscv_gstage_init(&gstage, kvm);
>
>         spin_lock(&kvm->mmu_lock);
>         kvm_riscv_gstage_wp_range(&gstage, start, end);
> @@ -49,10 +46,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, =
phys_addr_t hpa,
>         struct kvm_gstage_mapping map;
>         struct kvm_gstage gstage;
>
> -       gstage.kvm =3D kvm;
> -       gstage.flags =3D 0;
> -       gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
> -       gstage.pgd =3D kvm->arch.pgd;
> +       kvm_riscv_gstage_init(&gstage, kvm);
>
>         end =3D (gpa + size + PAGE_SIZE - 1) & PAGE_MASK;
>         pfn =3D __phys_to_pfn(hpa);
> @@ -89,10 +83,7 @@ void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa,=
 unsigned long size)
>  {
>         struct kvm_gstage gstage;
>
> -       gstage.kvm =3D kvm;
> -       gstage.flags =3D 0;
> -       gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
> -       gstage.pgd =3D kvm->arch.pgd;
> +       kvm_riscv_gstage_init(&gstage, kvm);
>
>         spin_lock(&kvm->mmu_lock);
>         kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
> @@ -109,10 +100,7 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct =
kvm *kvm,
>         phys_addr_t end =3D (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
>         struct kvm_gstage gstage;
>
> -       gstage.kvm =3D kvm;
> -       gstage.flags =3D 0;
> -       gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
> -       gstage.pgd =3D kvm->arch.pgd;
> +       kvm_riscv_gstage_init(&gstage, kvm);
>
>         kvm_riscv_gstage_wp_range(&gstage, start, end);
>  }
> @@ -141,10 +129,7 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>         phys_addr_t size =3D slot->npages << PAGE_SHIFT;
>         struct kvm_gstage gstage;
>
> -       gstage.kvm =3D kvm;
> -       gstage.flags =3D 0;
> -       gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
> -       gstage.pgd =3D kvm->arch.pgd;
> +       kvm_riscv_gstage_init(&gstage, kvm);
>
>         spin_lock(&kvm->mmu_lock);
>         kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
> @@ -250,10 +235,7 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm=
_gfn_range *range)
>         if (!kvm->arch.pgd)
>                 return false;
>
> -       gstage.kvm =3D kvm;
> -       gstage.flags =3D 0;
> -       gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
> -       gstage.pgd =3D kvm->arch.pgd;
> +       kvm_riscv_gstage_init(&gstage, kvm);
>         mmu_locked =3D spin_trylock(&kvm->mmu_lock);
>         kvm_riscv_gstage_unmap_range(&gstage, range->start << PAGE_SHIFT,
>                                      (range->end - range->start) << PAGE_=
SHIFT,
> @@ -275,10 +257,7 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_ran=
ge *range)
>
>         WARN_ON(size !=3D PAGE_SIZE && size !=3D PMD_SIZE && size !=3D PU=
D_SIZE);
>
> -       gstage.kvm =3D kvm;
> -       gstage.flags =3D 0;
> -       gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
> -       gstage.pgd =3D kvm->arch.pgd;
> +       kvm_riscv_gstage_init(&gstage, kvm);
>         if (!kvm_riscv_gstage_get_leaf(&gstage, range->start << PAGE_SHIF=
T,
>                                        &ptep, &ptep_level))
>                 return false;
> @@ -298,10 +277,7 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gf=
n_range *range)
>
>         WARN_ON(size !=3D PAGE_SIZE && size !=3D PMD_SIZE && size !=3D PU=
D_SIZE);
>
> -       gstage.kvm =3D kvm;
> -       gstage.flags =3D 0;
> -       gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
> -       gstage.pgd =3D kvm->arch.pgd;
> +       kvm_riscv_gstage_init(&gstage, kvm);
>         if (!kvm_riscv_gstage_get_leaf(&gstage, range->start << PAGE_SHIF=
T,
>                                        &ptep, &ptep_level))
>                 return false;
> @@ -463,10 +439,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct =
kvm_memory_slot *memslot,
>         struct kvm_gstage gstage;
>         struct page *page;
>
> -       gstage.kvm =3D kvm;
> -       gstage.flags =3D 0;
> -       gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
> -       gstage.pgd =3D kvm->arch.pgd;
> +       kvm_riscv_gstage_init(&gstage, kvm);
>
>         /* Setup initial state of output mapping */
>         memset(out_map, 0, sizeof(*out_map));
> @@ -587,10 +560,7 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>
>         spin_lock(&kvm->mmu_lock);
>         if (kvm->arch.pgd) {
> -               gstage.kvm =3D kvm;
> -               gstage.flags =3D 0;
> -               gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
> -               gstage.pgd =3D kvm->arch.pgd;
> +               kvm_riscv_gstage_init(&gstage, kvm);
>                 kvm_riscv_gstage_unmap_range(&gstage, 0UL,
>                         kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels), =
false);
>                 pgd =3D READ_ONCE(kvm->arch.pgd);
> --
> 2.50.1
>
