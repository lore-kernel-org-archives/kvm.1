Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40AF3BED1D
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774602038; cv=pass; b=Fyw1GpH3QcT8Me4p/TiITgLv8vnzumyyqXiMt+FB0hqxXkMidcFuouRNpA6awf1WR0brZlvRR7RIBnqbzBNgW1FdGGyBwsW6uTD/lq+RgEH6HWXv7PaSgfgFFAu5E7/SrwIsZFAnhB1yBRTvKPnnKqacR0uTdAyP+nHNtNvISA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774602038; c=relaxed/simple;
	bh=PQErMo2tH3t2XnWR73yPMCnulOQrwgjmdWJIjwxRxuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tloq2wkfpyyniXMbljVPQSC5gwQ5vYh++4e2MOKeQjFnv0kGw1NNJXcT04pnSciVEXR2kJbiEReZ/X6dIqJWiXyga46FP3Meu6RdSEr4wbwdjGvIBX0tdSMxNrLYRZioKndl/x0smz0b6fQhJgK1lCvVCowl3deccuKKhaDSp00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=wWXX82WX; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="wWXX82WX"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-67bad873c3eso1208666eaf.3
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 02:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774602035; cv=none;
        d=google.com; s=arc-20240605;
        b=aEQgNOfGoO9Gue+psHtYybGZNNCs+TfpYoP3WhQW5hbqsgpl48Ybf34oyw3mJAu/GY
         ZkuB+1Ow72FMG7tkgXFeA1Q5dUfN8r2LPg+/sEN5+CLVGB/LmJgNnv+TWV7XXjm4n0sE
         3bR4YBTYjcxs/BZQ+y6/ugpnXEa9c3m/y0alYy9S3I3bRX9jxsz+Qdmf5sCE4EVrIYtl
         +za+vfeG6nCf7cFrJzrgMPNT4jm7LsFh6WBA8bYTrOXVg5+puH2hJhbr32jKm0DCN9tK
         sa47ikxXykJJJJdPZbWMdtbykzKIs/pU0PY+6MWq1oqFdZIhM2ecx9orUQFeJcEWEHIe
         4Diw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8iPzBqHCfL3LcH+hQY6MvdDgBGLsYlEG1twB6MOAX5Q=;
        fh=a0DlmZ7eBMQtyMB/3FMpbRnD5csoeEJ7vLwkEdnKD2w=;
        b=BtF/Q1/YGlRpG/t4IKU60rvB5h0kz9B57VXC9y5/jehqKuLQhSzn4g0HiUWRZUrotz
         mKmzWqKb8HvU2Wqm/saa+d8SPGTBXZ/bk/ha3p0rDOFBbRdNqW02BNHfdR1hx4IvGNl/
         rpqztiq+gTXQR1re3vcLq6twSotRb8z6EBn5fdxXb3KcVGAOJkUwKdqOOkH0atav3F7N
         DWXs3kdB19oz2o+1HSTzF7isGvvCV4N1tBRs8uYacgGKlNeJKYrKby154jfQbvKJpGLg
         wDUcxe1ZGdQ8lw3FzL07GYUNcWHwCnrHmf8rVd7QB+cC4fOjzCVR8QwJE0LzopCkbiyu
         ZzuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774602035; x=1775206835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iPzBqHCfL3LcH+hQY6MvdDgBGLsYlEG1twB6MOAX5Q=;
        b=wWXX82WXBIB1o7jSYrKrLAn2ZPj8tDalt3B62TXeJRiyN1SCLAwMliOTALIyuGfd/I
         LiYhWCZXRUURrLoyT7it4HExqLxf+GgUI6iit/z/IMkKHNRCXaa5iYntQAtaoCMeztlC
         CY+fY/m9qzlasYQer3VYQArCX3sDbGj0B5I1yoaxskZqNHAS98qDPxKPfnNoF2Z5M6lY
         uD+x2WlnbhPssWRhCZfm2ORhiXayn+sGM4n8k0dymbNo1HP117gVkCP3z6kjdD4s1jBv
         2Wa1Ex8hKe+f3rrc4YiUIf0Io/Z91q8eBSQqpl3UH4n4/aiLmfXzMED20iSGuI25ExJi
         UPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774602035; x=1775206835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8iPzBqHCfL3LcH+hQY6MvdDgBGLsYlEG1twB6MOAX5Q=;
        b=GAaGsXxsnpd45ioMzBUPQphELCTD+rFw+C1yUs2qpMA89MseVdXdPQpqJANKjqq3VD
         6brpRfLS2DN1YiUZzaWnSmginz2HzS33U0vHdlxtLN/StmaF12ANlgnTNgOxuB3wQHx8
         VVk5Eq2CYzPCkluFX9FMmGlaHraTyCZeifF8W2AHYT8aa62pdAiCqeWjxBeexRO1+ZNh
         9A7yvttGdaGQNjGoyHwEDeWaCMcCEZ0pKqZfFNkbiaNf3IeEirFy5q1D8a0dW8kV7gKn
         NOU/cKdFjHu0hI4jsMe8gGpscvDi4YVQicSOWjlJMg6h2uoKh0L1+MIvm1ZjC3bVMYMh
         GKwg==
X-Forwarded-Encrypted: i=1; AJvYcCUOZQUR8iewH45fMQM4AZbBzM89x1/4LCC2Cow1ZBZbrJapq+MyLQmb5AqpIs8TnMH/ANM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFOIMyBinlW9y1H8LGiBchYkzCl6m12URQN6zcT8375DI+phtu
	0NQfEW/zbecQANVmmy0fqzmOEozDOD++kB2qUuHbS0vDAyjmavMaAxeHxwpUtLyAWoj4gjdOAxq
	b0opNBxzRUFkB2wra76uUcsw2+AbUXHpmVSIyTLuuns7O7yo4FOAl2+Y=
X-Gm-Gg: ATEYQzxZ/xnT4V2YRAcBgMfsCm1O2JgA+JDD1hjX9U5gcJTz/I6a8t7YVOkzao2jVAE
	pk3FH3ZTc+72T9zMlJi1YBtzZ32Qq4Tu+Whep6iEi9CwPl9QYx/jSnLfYx6JtIuunTzFRYRdkIG
	4oEjvstYTMI2OQ8ONc00tWNqJUlGt6VaOupWR6x8uXODmWdp9ClTDjVetR6hLr0QRw/h9htg/gZ
	tlbSmDV56zdEFvnleIevqBt28rapTGokibYsAv+X/dzYWSJeSNA9XxUD+PXr6J3C+z2mj+H1/Dy
	bivAMKcOnc+d7TIrF2UsX2NM3b6km81jFQxOxD/CE/lqtoRIOOPNf2zhKv8XqBf+KHah5Nx2bAq
	Zw+gwBiNlJDtrombIIutoUI2yHg==
X-Received: by 2002:a05:6820:2294:b0:67c:2ad5:2b39 with SMTP id
 006d021491bc7-67e18641ffdmr874008eaf.23.1774602034585; Fri, 27 Mar 2026
 02:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhSdy2uMY+-9W34G3QJ3m9XWg2dq_PeNB_9j9B3viZaRg=SUQ@mail.gmail.com>
 <20260327015555.79223-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260327015555.79223-1-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 27 Mar 2026 14:30:21 +0530
X-Gm-Features: AQROBzB6k39KBSA1bOcm2FYN_Hf1EsV9UtH0iPUVwF6t7ZS-vmzIB0bn1mfZeas
Message-ID: <CAAhSdy1-OPSaigBarUGmNWfcDBqjine+Hm+Urdinv1nLooQMNA@mail.gmail.com>
Subject: Re: Re: [PATCH v5 2/3] RISC-V: KVM: Detect and expose supported HGATP
 G-stage modes
To: fangyu.yu@linux.alibaba.com
Cc: alex@ghiti.fr, andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, 
	atish.patra@linux.dev, corbet@lwn.net, guoren@kernel.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, pbonzini@redhat.com, pjw@kernel.org, 
	radim.krcmar@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 7:26=E2=80=AFAM <fangyu.yu@linux.alibaba.com> wrote=
:
>
> >> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> >>
> >> Extend kvm_riscv_gstage_mode_detect() to probe all HGATP.MODE values
> >> supported by the host and record them in a bitmask. Keep tracking the
> >> maximum supported G-stage page table level for existing internal users=
.
> >>
> >> Also provide lightweight helpers to retrieve the supported-mode bitmas=
k
> >> and validate a requested HGATP.MODE against it.
> >>
> >> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> >> ---
> >>  arch/riscv/include/asm/kvm_gstage.h | 11 ++++++++
> >>  arch/riscv/kvm/gstage.c             | 43 +++++++++++++++-------------=
-
> >>  2 files changed, 34 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/=
asm/kvm_gstage.h
> >> index b12605fbca44..76c37b5dc02d 100644
> >> --- a/arch/riscv/include/asm/kvm_gstage.h
> >> +++ b/arch/riscv/include/asm/kvm_gstage.h
> >> @@ -30,6 +30,7 @@ struct kvm_gstage_mapping {
> >>  #endif
> >>
> >>  extern unsigned long kvm_riscv_gstage_max_pgd_levels;
> >> +extern u32 kvm_riscv_gstage_mode_mask;
> >
> >s/u32/unsigned long/
> >s/kvm_riscv_gstage_mode_mask/kvm_riscv_gstage_supported_mode_mask/
> >
>
> Ack, will switch the type to unsigned long and rename it to
> kvm_riscv_gstage_supported_mode_mask in the next revision.
>
> >>
> >>  #define kvm_riscv_gstage_pgd_xbits     2
> >>  #define kvm_riscv_gstage_pgd_size      (1UL << (HGATP_PAGE_SHIFT + kv=
m_riscv_gstage_pgd_xbits))
> >> @@ -75,4 +76,14 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *g=
stage, gpa_t start, gpa_t end
> >>
> >>  void kvm_riscv_gstage_mode_detect(void);
> >>
> >> +static inline u32 kvm_riscv_get_hgatp_mode_mask(void)
> >> +{
> >> +       return kvm_riscv_gstage_mode_mask;
> >> +}
> >> +
> >> +static inline bool kvm_riscv_hgatp_mode_is_valid(unsigned long mode)
> >> +{
> >> +       return kvm_riscv_gstage_mode_mask & BIT(mode);
> >> +}
> >> +
> >>  #endif
> >> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> >> index 2d0045f502d1..328d4138f162 100644
> >> --- a/arch/riscv/kvm/gstage.c
> >> +++ b/arch/riscv/kvm/gstage.c
> >> @@ -16,6 +16,8 @@ unsigned long kvm_riscv_gstage_max_pgd_levels __ro_a=
fter_init =3D 3;
> >>  #else
> >>  unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init =3D 2;
> >>  #endif
> >> +/* Bitmask of supported HGATP.MODE encodings (BIT(HGATP_MODE_*)). */
> >> +u32 kvm_riscv_gstage_mode_mask __ro_after_init;
> >>
> >>  #define gstage_pte_leaf(__ptep)        \
> >>         (pte_val(*(__ptep)) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC))
> >> @@ -315,42 +317,43 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage=
 *gstage, gpa_t start, gpa_t end
> >>         }
> >>  }
> >>
> >> +static bool __init kvm_riscv_hgatp_mode_supported(unsigned long mode)
> >> +{
> >> +       csr_write(CSR_HGATP, mode << HGATP_MODE_SHIFT);
> >> +       return ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D mode)=
;
> >> +}
> >> +
> >>  void __init kvm_riscv_gstage_mode_detect(void)
> >>  {
> >> +       kvm_riscv_gstage_mode_mask =3D 0;
> >> +       kvm_riscv_gstage_max_pgd_levels =3D 0;
> >> +
> >>  #ifdef CONFIG_64BIT
> >> -       /* Try Sv57x4 G-stage mode */
> >> -       csr_write(CSR_HGATP, HGATP_MODE_SV57X4 << HGATP_MODE_SHIFT);
> >> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MOD=
E_SV57X4) {
> >> -               kvm_riscv_gstage_max_pgd_levels =3D 5;
> >> -               goto done;
> >> +       /* Try Sv39x4 G-stage mode */
> >> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV39X4)) {
> >> +               kvm_riscv_gstage_mode_mask |=3D BIT(HGATP_MODE_SV39X4)=
;
> >> +               kvm_riscv_gstage_max_pgd_levels =3D 3;
> >>         }
> >>
> >>         /* Try Sv48x4 G-stage mode */
> >> -       csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
> >> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MOD=
E_SV48X4) {
> >> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV48X4)) {
> >> +               kvm_riscv_gstage_mode_mask |=3D BIT(HGATP_MODE_SV48X4)=
;
> >>                 kvm_riscv_gstage_max_pgd_levels =3D 4;
> >> -               goto done;
> >>         }
> >>
> >> -       /* Try Sv39x4 G-stage mode */
> >> -       csr_write(CSR_HGATP, HGATP_MODE_SV39X4 << HGATP_MODE_SHIFT);
> >> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MOD=
E_SV39X4) {
> >> -               kvm_riscv_gstage_max_pgd_levels =3D 3;
> >> -               goto done;
> >> +       /* Try Sv57x4 G-stage mode */
> >> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV57X4)) {
> >> +               kvm_riscv_gstage_mode_mask |=3D BIT(HGATP_MODE_SV57X4)=
;
> >> +               kvm_riscv_gstage_max_pgd_levels =3D 5;
> >>         }
> >>  #else /* CONFIG_32BIT */
> >>         /* Try Sv32x4 G-stage mode */
> >> -       csr_write(CSR_HGATP, HGATP_MODE_SV32X4 << HGATP_MODE_SHIFT);
> >> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MOD=
E_SV32X4) {
> >> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV32X4)) {
> >> +               kvm_riscv_gstage_mode_mask |=3D BIT(HGATP_MODE_SV32X4)=
;
> >>                 kvm_riscv_gstage_max_pgd_levels =3D 2;
> >> -               goto done;
> >>         }
> >>  #endif
> >>
> >> -       /* KVM depends on !HGATP_MODE_OFF */
> >> -       kvm_riscv_gstage_max_pgd_levels =3D 0;
> >> -
> >> -done:
> >
> >Here are some statements from RISC-V privilege specification:
> >"Implementations that support Sv48 must also support Sv39."
> >"Implementations that support Sv57 must also support Sv48."
> >"The conversion of an Sv32x4, Sv39x4, Sv48x4, or Sv57x4 guest physical
> >address is accomplished with the
> >same algorithm used for Sv32, Sv39, Sv48, or Sv57, as presented in
> >Section 12.3.2, except that:"
> >"hgatp substitutes for the usual satp;"
> >
> >Based on above it is a waste to try each and every mode.
> >For example: if mode Sv48x4 is supported then Sv39x4 is also supported.
> >
>
> Radmi and I discussed this topic before; please refer to the following li=
nk:
> https://lore.kernel.org/linux-riscv/20260131061238.52708-1-fangyu.yu@linu=
x.alibaba.com/

Privilege spec mandates Sv48 and Sv39 when Sv57 is supported
so the current approach is not based on any assumption.

Regards,
Anup
