Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D13F9F43
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528364; cv=pass; b=pfe63cLezwE39l3MofwXmm1DSxXhH9mPoNvHTmWCTbE2IEsoaEIbsvgdQnGrrw7j8dtQeot65R3oZRd72M7wDW8CDTEA0Xe+06mNNe1Q5CUMaXm5ZF9V+tHAfZvNdBWp4Aua2ur64e9HHW28Q4PkYVHeYtyi4YqTNLYPgfqUi4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528364; c=relaxed/simple;
	bh=Sj8GsS35CKdLRwTwe6Ms2P35K3pvoQvXEt6/mAcD8p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/o4IGhlhFGgNCuW+vvuWU522K9lkevBMS0XMcCNIngPykveEbcJ8Sc/X6g7So31lVM7tLmjDz1bgXMdANR2AmnXP2+ZNpFfTEaiKxuBL3TMLY/aZQOzeD4Lb42j03cDfw/3lWykv4RW1vTtByqkHiW3WhvK6DT6iQPgpwPi3AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=vIwM11wI; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="vIwM11wI"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d9d929e27aso713266a34.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 05:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774528358; cv=none;
        d=google.com; s=arc-20240605;
        b=g6mPHkiCBZQrI9IiT+Jn+NdTufdy7uOTQG2JTKuLHhMLEpY5B15o6Cjh9/FCC+sQ41
         rdrsQ05wEGjB1ffOFCf8x61xjV//glNutKjF9tuJXFkTh5nPYJLl/Y7pJgWmqg/iYEwM
         ZZTPN+FkHtR7HAiaArpz76uK3PQK5SSENnw4pZ1CYhwIBg9jVovTGry46GV3tOV+KKTl
         GMJlvGZ6tBITEIXRP6lKWAn0XdkLz376pqd209kl4+WvEZ2YxkB1O+9jwNp+PZ+TctJm
         MslAVpdKGVyKPKvHl1IeNb2xFSNdDwl6UhSt5ikcvkLYpB71bujA5dJWMtZ0bUQAll2u
         Rrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s5A1++5OwfMTff2//26cMDXzML41vSjWdt7IxBVidyI=;
        fh=Rd38RtyaNSlNV8VzXOvnFr5EAqBpnQQhAwVUYsdUKrI=;
        b=B534sAwqSpqrOc1bYLPqt8E8shcvi9FBYFdlBsRuceX4O0gzd4HaW9BTYMm1uvMn7r
         BaNSa64eP7lQdmq3JTdaonRgmz2hTLVBbcTMRn3B4GFjeOUJtbXAdD9C19lw6VvTHnx7
         l0MX7jvwn0eI1h5e1cJma5mXFe9Y3BZYlg6K0msCwmMr+2Gk1+wOP60VdU63YOyQIJ2t
         cZ5mrFznKWYzJWmVVLm8GSObjBWf9c3q0dC++TT9Iv2D7p16kvNfAvLuzEVKt18Vq/Fv
         bLIcEM7rGvHAY+RjjFKtFffEbQ09DIEHD+ZytDvjjiaHlJZobE1iSxo4t8zl8+INjeB7
         x0kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774528358; x=1775133158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5A1++5OwfMTff2//26cMDXzML41vSjWdt7IxBVidyI=;
        b=vIwM11wI26ynQF6uEP7xX9Fqvi1YjHt4A9SP/9NPwXBPPr6SJ4nU+n253uZvvumSFe
         5gQYRFDtKXuozq+8O/OOr3wzxIMefp012ItWFGhFKt98+weuZGdO67T2OBoVl3p8jvh4
         UcFBfuIEjJ4iHyv9cbkwRSRoMY3sU2VWwQ/d/YjOgApVrTi6+Cr7z+A4Kc2szF4emS72
         6kWxtr5qPy7S8E8AC4HiWnWX8+i52na348ZyiA+lCB1zgFc+BxcLhjUTdCWrCNBqr5VG
         DyPpElqvn1yGWynaNJyLc1h5TRMd1CpA9BliOr8aSDBp7GEEr+S3jyBRQUSnj/UauE40
         ycAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528358; x=1775133158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s5A1++5OwfMTff2//26cMDXzML41vSjWdt7IxBVidyI=;
        b=ewQqgvZY1J8oBJiUyCW3K89Gl0bD2NTtziOYzNPWKDJVyC7Xcz5Q8hqhZ84SguyWD6
         cJhcSQlrvMqe7wgELhcpZzsHXuu3w8yG3etvEKRmhxVVP+YbuahwTfXaPdIpzuE6QofY
         +mj2BWwpoQlEAXQbeNogsOITfiyHftBjqZk9lhVjqKUJMHAbqE5J17gvGE7XllFs2kQe
         MPq/nhuXqP45x4hV4jpxzSXVLaA7WK3xhMfo3bBe+z/ML0nco5LVwiiU6hBOJ3twmv3N
         Dm1hRCfgiYlr5JONuGZ6O3PJ0jQ5Wi8ziGrWZW1dQr1mH51wgit4KfvVq44ORVAKxLux
         2LWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdAmEY59w9qt87jMdn96GtpFw7PqP0xBkK12YM+P78LZxUC/1fdf8IiX4vJd97y8MMLHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKEID+bT8MemdCo8ebmi4tmvjfcxX2qMNuvd0zm+cKAnEKPzLM
	HBRosR8Ur14H+O5KSn/ysXXqjEBzI9c+kTTGHMVxdReYkmqPgcv6Bppbrghf0erCRZ2GohDgqT2
	k8gIvT2EuxlU3uG2RI+mloOHTkG3Delbgj2VPuzjgGw==
X-Gm-Gg: ATEYQzzjakoMV7RNRLeC2mqvKyGyH4ohUSWKnfn5Wid7W7YcE2tTFGxprbzSF0rAr3b
	M3a7laFM0tSdTzaCgbgXQYiPjjaZa8KYk/SD2vhvvpqDxkWRocssH+ZIoZiPHZXgupG3dK7aHt3
	sTkMT6Wx3/B3onid1tissILZjL9c0UECSUJri/0gdC8m3Ulqx4efsLToI3XB4Q7dvLRL7L44CPP
	Ltd+BT4ghTIqVywYOyCuKAfhiVgXfRlpMrh8CXFQU3TQbBGziGNu9gOZYrV9s7junQj3PZWwptR
	dVlXW+S4xhVwvYaivEK+BekS9O4wjATso5aB5lJ6MC2y/6qvGdQAkETUFrZOUJswmNe4bc5TPTa
	gxlTOWIYX9kf7FgKDLBRT5/E+y3g=
X-Received: by 2002:a4a:edcd:0:b0:67d:e836:2e32 with SMTP id
 006d021491bc7-67dff511512mr3387545eaf.35.1774528358402; Thu, 26 Mar 2026
 05:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204134507.33912-1-fangyu.yu@linux.alibaba.com> <20260204134507.33912-3-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260204134507.33912-3-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 26 Mar 2026 18:02:26 +0530
X-Gm-Features: AQROBzBjp1ya48QrrJubnKGHIPLce4xzbTMR8-Rif6cPLDOdnUusNCgeyKu5kPs
Message-ID: <CAAhSdy2uMY+-9W34G3QJ3m9XWg2dq_PeNB_9j9B3viZaRg=SUQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] RISC-V: KVM: Detect and expose supported HGATP
 G-stage modes
To: fangyu.yu@linux.alibaba.com
Cc: pbonzini@redhat.com, corbet@lwn.net, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, guoren@kernel.org, 
	radim.krcmar@oss.qualcomm.com, andrew.jones@oss.qualcomm.com, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 7:15=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote:
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
> ---
>  arch/riscv/include/asm/kvm_gstage.h | 11 ++++++++
>  arch/riscv/kvm/gstage.c             | 43 +++++++++++++++--------------
>  2 files changed, 34 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index b12605fbca44..76c37b5dc02d 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -30,6 +30,7 @@ struct kvm_gstage_mapping {
>  #endif
>
>  extern unsigned long kvm_riscv_gstage_max_pgd_levels;
> +extern u32 kvm_riscv_gstage_mode_mask;

s/u32/unsigned long/
s/kvm_riscv_gstage_mode_mask/kvm_riscv_gstage_supported_mode_mask/

>
>  #define kvm_riscv_gstage_pgd_xbits     2
>  #define kvm_riscv_gstage_pgd_size      (1UL << (HGATP_PAGE_SHIFT + kvm_r=
iscv_gstage_pgd_xbits))
> @@ -75,4 +76,14 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gsta=
ge, gpa_t start, gpa_t end
>
>  void kvm_riscv_gstage_mode_detect(void);
>
> +static inline u32 kvm_riscv_get_hgatp_mode_mask(void)
> +{
> +       return kvm_riscv_gstage_mode_mask;
> +}
> +
> +static inline bool kvm_riscv_hgatp_mode_is_valid(unsigned long mode)
> +{
> +       return kvm_riscv_gstage_mode_mask & BIT(mode);
> +}
> +
>  #endif
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index 2d0045f502d1..328d4138f162 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -16,6 +16,8 @@ unsigned long kvm_riscv_gstage_max_pgd_levels __ro_afte=
r_init =3D 3;
>  #else
>  unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init =3D 2;
>  #endif
> +/* Bitmask of supported HGATP.MODE encodings (BIT(HGATP_MODE_*)). */
> +u32 kvm_riscv_gstage_mode_mask __ro_after_init;
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
> +       kvm_riscv_gstage_mode_mask =3D 0;
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
> +               kvm_riscv_gstage_mode_mask |=3D BIT(HGATP_MODE_SV39X4);
> +               kvm_riscv_gstage_max_pgd_levels =3D 3;
>         }
>
>         /* Try Sv48x4 G-stage mode */
> -       csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V48X4) {
> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV48X4)) {
> +               kvm_riscv_gstage_mode_mask |=3D BIT(HGATP_MODE_SV48X4);
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
> +               kvm_riscv_gstage_mode_mask |=3D BIT(HGATP_MODE_SV57X4);
> +               kvm_riscv_gstage_max_pgd_levels =3D 5;
>         }
>  #else /* CONFIG_32BIT */
>         /* Try Sv32x4 G-stage mode */
> -       csr_write(CSR_HGATP, HGATP_MODE_SV32X4 << HGATP_MODE_SHIFT);
> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V32X4) {
> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV32X4)) {
> +               kvm_riscv_gstage_mode_mask |=3D BIT(HGATP_MODE_SV32X4);
>                 kvm_riscv_gstage_max_pgd_levels =3D 2;
> -               goto done;
>         }
>  #endif
>
> -       /* KVM depends on !HGATP_MODE_OFF */
> -       kvm_riscv_gstage_max_pgd_levels =3D 0;
> -
> -done:

Here are some statements from RISC-V privilege specification:
"Implementations that support Sv48 must also support Sv39."
"Implementations that support Sv57 must also support Sv48."
"The conversion of an Sv32x4, Sv39x4, Sv48x4, or Sv57x4 guest physical
address is accomplished with the
same algorithm used for Sv32, Sv39, Sv48, or Sv57, as presented in
Section 12.3.2, except that:"
"hgatp substitutes for the usual satp;"

Based on above it is a waste to try each and every mode.
For example: if mode Sv48x4 is supported then Sv39x4 is also supported.

Regards,
Anup
