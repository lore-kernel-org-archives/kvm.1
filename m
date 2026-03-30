Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6023B3D1CD5
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876889; cv=none; b=oetX++XH3n8BgnOHsPSbeMbAJi9lI1f/EDvxM3p4PkMk8qQkiodpy89AZs4wssad/IqHP6ML27/j/VWWVN/iofoo6tSbep39fMyOoPXD1Jx8aThxQd8efD5dmVpeY2zHNucr7/Wjhft7a+QXxo2R+k56giYYlSCL0TTdXcpBZTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876889; c=relaxed/simple;
	bh=K4enoH1uIcNth7px2S+L5509RwnVd2D+aJPB9WyfjFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbok5xZt/F99GdfSZ5mB1zS1wROnTZE8IJc+QeaaBt7GekpPaxCcEEUWaYFwYLRnchaU065yzXN9Nz6DJhzAmCoHcnB+UgkqEEoNg4e3r9a8SyHQy8F2YssJZF9RrQWSn7i0g+D2t47bjngcFRngU+tCBTg1VWQTcRRMOWvuW9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HefN63re; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HefN63re"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104F1C4CEF7
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 13:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774876889;
	bh=K4enoH1uIcNth7px2S+L5509RwnVd2D+aJPB9WyfjFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HefN63reBDUroRaB84JsKdEvsHZs8ioqV69APV8LG17ChAd9djVTsfxGKuVb+sxyG
	 MkmvvxJlEuk5faCR8O4DR6majxBvVFvikhQbNhW1lrVq+RivBqAVAsnBiKiRAHFChK
	 SHxQacqFB5CXZLnJuCcljU4yavfJqBPEQORfE/GZKF2aNxeHEavVzHrdq4cSmunuOi
	 x+r1IUYUwIYZjTEyVbjVEXTh60inV59LityQOFAzp3L2zEclZxRLbHq3V7SO1zaCox
	 AZ/952v2JHlUFQagAaf/LVrJPknSgxpq853beiqloKm4a1UEMd4teQzByB7uFOt/6n
	 ZWl3+ZtCmr27A==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b941762394aso667395366b.1
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 06:21:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0viDaWIq7jPOFmQ+faQRQlJixrkzHBYnMqQlJ/oGx2UPcr9zHOs/6KhqF1GUzmMMvlk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCChYL79yBtiRroMHhTugLvdWtvluVxPDjwYvC7AdqTslEwV2g
	/reVHg8/ZBAAJCtpknqD679Ps8UzjLXa+0t62meDANeFGoGn2vro306sYpWf6Ax9K7kv7YdbIDy
	ceEhcxlIzXe7Im1zsHsOCJcedw9jbTwY=
X-Received: by 2002:a17:907:c297:b0:b97:a9ac:5e05 with SMTP id
 a640c23a62f3a-b9b507b43d6mr736865366b.35.1774876887624; Mon, 30 Mar 2026
 06:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330122601.22140-1-fangyu.yu@linux.alibaba.com> <20260330122601.22140-4-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260330122601.22140-4-fangyu.yu@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 30 Mar 2026 21:21:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQRQdu58N8SbHw1k-FdYLPv1-441_8Kiscpm=QzF9ON=w@mail.gmail.com>
X-Gm-Features: AQROBzBGER0O9wkoHk1qED601JRkO-2es9K6oo1W-s6w41ltrFuST3jQ8Q_MsPU
Message-ID: <CAJF2gTQRQdu58N8SbHw1k-FdYLPv1-441_8Kiscpm=QzF9ON=w@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] RISC-V: KVM: Detect and expose supported HGATP
 G-stage modes
To: fangyu.yu@linux.alibaba.com
Cc: pbonzini@redhat.com, corbet@lwn.net, anup@brainfault.org, 
	atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, skhan@linuxfoundation.org, 
	radim.krcmar@oss.qualcomm.com, andrew.jones@oss.qualcomm.com, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 8:26=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote=
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
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
