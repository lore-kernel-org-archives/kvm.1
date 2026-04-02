Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FDB3346A8
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140839; cv=pass; b=qXwzFUBmAb6P19IZwZdEf0QkYneEoP/VRaHiwXUJDKRLUPuZ1LaV+YxKla2Npico1YzmaeGZ1So7Jn1WX17cWFkz01jYARnH6sUCfWjicgt0yGnfROnEYYJgXVbt0TrrII/uWjjSTpAFFv2Flvv0UnC0yXTMtaHXE5NnnrKijtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140839; c=relaxed/simple;
	bh=LFXyJNp8CuuqNXVe2fEioIz8ORWxU0kl5nw+pcgspDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRuzLZpOqBy7y2I+CG32E+K6vYJzvB/y/e5a9YI06EDBEmso2wyyxjNolHZfEVJK6Xn9N1tvf+K3hYg+NNwMV9ey+lqXzfFOpoOQjF0kXBHJZc/L9/cditXaIn7qwoOBcqZlkhUDAqlONq4xO1ydEMG8h6pUENLaf17z7nW4ZmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=eGDQBRDq; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="eGDQBRDq"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-67934c83063so359574eaf.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 07:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775140835; cv=none;
        d=google.com; s=arc-20240605;
        b=SWxXgq7Z+RsxAwyxaFlAcWY4BE+k0KTJOIBnZExqEClcRSmZBjEcwcbbSsfw0XyPv0
         aM1547zE3YES9VWfSNQ0K1kqg8B6y0WUYkOSvdXNccisfqCYm4k6T3+MLkCW35zZM8aj
         XerKMfO/wjp2Ihc47dtPhszSGaStw0Dn8w70Kzf8x1nJBlnpOFEyz/+ppgNMAJbmJthm
         ajZMAthBxZV/ViU/CMcFJoD6xAuyQFqYbfg5p1kHdQ1ceJ0ysLcVCoPkdUbAGqQKoYQo
         Ptif8ZJcrNobd0f1a/ZxqCPWMDVm45EsQ9R6J4M0TcjE0/+diYeigjohYf1X6otvv/hf
         UQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CgXVgNr9LcoHCMvR/4QMuJnwtL2EPpKXdJ8rG5+UP24=;
        fh=DkPKxS0rWzeZdN2k94nFqmrlvVi84XHUMGtbi1Pvr4M=;
        b=O4jyvKSBpEdP7gwW6ihUyBRZe/a0Yz55E4H1cIi1YfSH20/HulnXwc82ob2So+EJqY
         4Kbrry1A11tRQB4EyHADgZ7SRzKk0DgXHfad+KsNQn0wTdj7AIZziO5FmuUJUpHr5F1J
         WC6gMTEXLWKYzVAne6jvAPp3mL92UVanJ4lB2SfgE69Vy6Vbu9Y2yXgThSNB6FXUJrMJ
         ebcTKBsj6TnmVJaC01OOZN71YyesNdjuUr68jzBymEsjFtG0U4l3Pmb5WxCITMprawsT
         I2QB2MBo1ms/GITyGSFI00andyaGBfKmzGYF5pIFQr9KwSxUcB4/110ijEpyCnyE6oPh
         LZ5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1775140835; x=1775745635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgXVgNr9LcoHCMvR/4QMuJnwtL2EPpKXdJ8rG5+UP24=;
        b=eGDQBRDqO+9jofnOWMPzmaB0t0SkQcn20uJZAKHgLXa4NWcpxgQmrgnj4vuR88M13a
         LdMVBROHeCSG1LBaxDRI212csSp6wTwhYLcgGv+opF1AA9QSiql8N1PXlo31mGDeflQs
         96KlMgewmj+dtT+3ms/mQX2ypsN1p3sPC9KPgnDb2NO1sAHWwcwTm7G3OQLVCbWqd+d8
         X0kKWrop+TEmGDiwAd1zeiYqXjRFPpsGGXLSLp0bzF22H2ClQ8b21Lm3OZxHMu8rOVyX
         JMolLXHk4N94yEvbHbo/7TLavUBfAKCKugpk8rKKTXqHY6xTQUtd7aTAIF7qGvTbDkGK
         HDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140835; x=1775745635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CgXVgNr9LcoHCMvR/4QMuJnwtL2EPpKXdJ8rG5+UP24=;
        b=S96+4M0YzR+K2WPYiQL9Fg8ASI2YuyPVtvgPkYTRdA28417dJZwgW935EJFI3/lSYk
         NNjOZGH+pdufpLLuf7u4xnSM2igo6eKEkS5ks8iftJ88aoQx1z0/N2k3ym3HppMBTaJt
         Io/mn9ch8AFaw71Zuy6afWTxYKKE6TV/tm+sbexyX1G0mDyFKzn2809f7DFXHDhRlrMR
         hJGq7so9w/92Tg4T+KK2LKoIUA4l8lRF43RQjxYc4gvUJwNSefbPn6D7LG5T0Fx38rpd
         iDt5s5EDmBLrwnNnYEBonPBZBD7t3ivSf1aAiG/b3epMnTXUZI12pVbRd1Xt54bBvxBB
         kiKg==
X-Forwarded-Encrypted: i=1; AJvYcCVg0ADw30HbWW8ENb+9cRPgCOUfM4EPCWtvf63gsC9y9nUaABWcy5xvJu9RGimh5TwmoQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVWRjWPAWRarHXhHJq7sfNuvQgisCgtIhY/iOfRYWxZ0K+yq93
	7E9AnemiEPQRSQaj+ZZQkrr6auXdSFDPrcD+3xTsTD/4q16bgdZi8NyQ0L7IiouOFgr6LkSHsc1
	HZWe5k6vuxukPUWpSiBZAl/wZ9cWRprsZgEdcoHvg8g==
X-Gm-Gg: ATEYQzzryIPt27La6JNoms1FJ5scd3HyKbk5/eDRf1iTJbmGcD12Quy59w07dcAIMnO
	fkU37O9z7j55rIZAGsxiFy6r4+PbfD/5V3z9G0uztd0ukGrLnBgfHWg6tjYIjMkCo9JzsJd0o2j
	HKtc1mrhyFE5wP7u75q9/mIdRw6aY41w5tg9qHW3HXvxlOMvD6Tk/gssNDRlrT9NlaBeRFllqIZ
	AJyMConK8/pkmHt1TUVEsPSNE0Wr6TATkhsJ3j3isOEhxMiVhxxVOKtSf5P0UV+Biezdjkzf1CK
	yGRIuGdu+p9q1fu29xBKZ/ScfKHg66gb27xM3hfgKLWF5mxy779KCHd3CDRBf3VA08jXZbX/oba
	W+srYJPMLt6a0FDViQOh9kPlXow==
X-Received: by 2002:a05:6820:828:b0:67e:244a:7dd5 with SMTP id
 006d021491bc7-67fabcd8e2dmr3743192eaf.51.1775140835100; Thu, 02 Apr 2026
 07:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402132303.6252-1-fangyu.yu@linux.alibaba.com> <20260402132303.6252-4-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260402132303.6252-4-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 2 Apr 2026 20:10:23 +0530
X-Gm-Features: AQROBzDhVdJ-Rk6tIUeOmOBsDek_WXlm04aASx05OVR5rTbB0T6p0wGRWJFy36Q
Message-ID: <CAAhSdy3fVrw+=TgtgttQwnjUBy2s4OdhNcKZ+wK8pJFDi+Y89A@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] RISC-V: KVM: Detect and expose supported HGATP
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

On Thu, Apr 2, 2026 at 6:53=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Extend kvm_riscv_gstage_mode_detect() to record HGATP.MODE values in a
> bitmask. Keep tracking the maximum supported G-stage page table level
> for existing internal users.
>
> Also provide lightweight helpers to retrieve the supported-mode bitmask
> and validate a requested HGATP.MODE against it.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kvm_gstage.h | 11 +++++++++++
>  arch/riscv/kvm/gstage.c             | 15 ++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
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
> index 7c4c34bc191b..9204e6427d2d 100644
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
> @@ -317,11 +319,17 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *g=
stage, gpa_t start, gpa_t end
>
>  void __init kvm_riscv_gstage_mode_detect(void)
>  {
> +       kvm_riscv_gstage_supported_mode_mask =3D 0;
> +       kvm_riscv_gstage_max_pgd_levels =3D 0;
> +
>  #ifdef CONFIG_64BIT
>         /* Try Sv57x4 G-stage mode */
>         csr_write(CSR_HGATP, HGATP_MODE_SV57X4 << HGATP_MODE_SHIFT);
>         if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V57X4) {
>                 kvm_riscv_gstage_max_pgd_levels =3D 5;
> +               kvm_riscv_gstage_supported_mode_mask |=3D BIT(HGATP_MODE_=
SV57X4) |
> +                                                       BIT(HGATP_MODE_SV=
48X4) |
> +                                                       BIT(HGATP_MODE_SV=
39X4);
>                 goto done;
>         }
>
> @@ -329,6 +337,8 @@ void __init kvm_riscv_gstage_mode_detect(void)
>         csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
>         if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V48X4) {
>                 kvm_riscv_gstage_max_pgd_levels =3D 4;
> +               kvm_riscv_gstage_supported_mode_mask |=3D BIT(HGATP_MODE_=
SV48X4) |
> +                                                       BIT(HGATP_MODE_SV=
39X4);
>                 goto done;
>         }
>
> @@ -336,6 +346,7 @@ void __init kvm_riscv_gstage_mode_detect(void)
>         csr_write(CSR_HGATP, HGATP_MODE_SV39X4 << HGATP_MODE_SHIFT);
>         if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V39X4) {
>                 kvm_riscv_gstage_max_pgd_levels =3D 3;
> +               kvm_riscv_gstage_supported_mode_mask |=3D BIT(HGATP_MODE_=
SV39X4);
>                 goto done;
>         }
>  #else /* CONFIG_32BIT */
> @@ -343,13 +354,11 @@ void __init kvm_riscv_gstage_mode_detect(void)
>         csr_write(CSR_HGATP, HGATP_MODE_SV32X4 << HGATP_MODE_SHIFT);
>         if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V32X4) {
>                 kvm_riscv_gstage_max_pgd_levels =3D 2;
> +               kvm_riscv_gstage_supported_mode_mask |=3D BIT(HGATP_MODE_=
SV32X4);
>                 goto done;
>         }
>  #endif
>
> -       /* KVM depends on !HGATP_MODE_OFF */
> -       kvm_riscv_gstage_max_pgd_levels =3D 0;
> -
>  done:
>         csr_write(CSR_HGATP, 0);
>         kvm_riscv_local_hfence_gvma_all();
> --
> 2.50.1
>
