Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB7E38F253
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330618; cv=pass; b=S6R8w0mnpiQCto6tUGd5YyBO0KkDO6zjd/cLwt9TgKNOhcmQS2B1GFpIKtKukVxtKDfBr54s66+CyxT4U3K4vSU+wxzTukRtha4/ayvJ6o5A0R2cmGWaT76AY1vzkuJ0XoHymj3AnWrhTKhjIRdCXC3SeoklmZwlDd+pso9QSwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330618; c=relaxed/simple;
	bh=HQMamYzrjc3kdo4OIOaw5dT7zfL51Msc3DUcmqn9HOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6Um+bnCSnnIAGiSsrHA3vJNFcK6/MEY/pwXmFGgxpQ1uu7q4DyDPnyv3/L04e/2uhlQpw73IYSvcDxTYI4oTR2hi1kHaeGXrcJu7ljssVNoC4EOVyH8sdJwPh/dg3n8sHJs+/8K41R3Qcj8K2fD1+K00FOsTwwzVp1Yb1vO0gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=a6hfJ3s9; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="a6hfJ3s9"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso865030f8f.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 06:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785330615; cv=none;
        d=google.com; s=arc-20260327;
        b=VTMD2G7gReTFqwiG8mOOpTGKEflQpYZ0t1e/pHLLRq/zz0lLCp7dxKxa81ZZXXOhqw
         bzZiYJ297R8FLGgV1w9uTtOdzsi7Ud1e39wuQgtnEJr1GUe/A/rCn8eL1GZdCroydwj5
         U401QJJ60AwHn7sC4TBmWhZRvuexsMknV/NioBYoreF6ykVBe0PpePsXtssVFujthidQ
         y6oIQopLNQ0rSBaomuKrSIqmCsT8Wss3r97OGBHUj45LAENTAu4VrTW1mg8ogOEuN9ak
         hMY6yE4DTrr2hDLICc8jWh8OZ3rXciyTN3to3AmTzKfnfftQfmnwQRIRH0XBms0Y/bqv
         nrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KlahTC06J1bekMd44QG1g3xZUKIEUfQuaHqFpAEocdM=;
        fh=bBiNJ2RAio65wNGhQbbw7nqcWADWUvIJmklrxOublRM=;
        b=Mj3cVJMrmtWcpX9UbQH1b0FhsflkyBHXBktgjPWP+vhRIABDYBtUQ2Bc8WWkDxBKSu
         PhQ4wcm2OJEckviAX0V1qNkUBwKZL4/94e2YgRvdiFNVSe6vtygTB8fcIeVB4sq+pCV7
         gq9zhQ7rivPKVrDgsYf6XX1Oybjw7+eWmgz1cHzoIO6xymlqQ7yxVexFX5bEXcAMI2RX
         SBUj1EP5NUI49EbDibgGSBdzoKhZTbS0N/Ml0W8BbKBaAWjOG/dZkYz23AU3aYdp5zAa
         zmvBCPjvSoQj5HhV6rJRHWllzJbs4CxQgLPewMpHD1P+OZxj4OARuClpb2wjJVZIDm/9
         1aYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785330615; x=1785935415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KlahTC06J1bekMd44QG1g3xZUKIEUfQuaHqFpAEocdM=;
        b=a6hfJ3s9chuvyxaRe44B66WI93pH2lAfcOOu5pAwJc6xZ37QD6Kls1Bf+pN19uhr+M
         FDc4Kh/fZn+6boa6eCtmnyUZlVIgXizkZ9LtQlaOLu5ch0RvFuKMPAJt3DoKDJ/Cvxr3
         OHmBiqjapMBx3ylmtGMbFBV7vli6Puw2bYdVfKMnzBpfWY4/GK3YMYi7FqxsiEv7LlG6
         CEyUM6Ix9szc+hxxbLWfAm6qacGzhaTV1JYNlW/8fEB06fqDU+PqyXmupFQP8O5UM9N4
         r7TLUP7HHc875mhC9N0V8t7HgGvma1K0uZJ1PmAl8q8cid07xeS3SYE5wwRNS5WzzaQl
         bU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330615; x=1785935415;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KlahTC06J1bekMd44QG1g3xZUKIEUfQuaHqFpAEocdM=;
        b=jEgzXGV/BdIQuCkqXjoR7auM7GjEAgsNiZUcLSdoGtFmWwmK8w4nGBrwIW1R72RJVn
         +TetTFWrICVTgWk4qOUfa3xIHrzf6OgJ4qYgyN4/nJX6JZVR6w+w1QW+Uj2pPMpudphv
         ZJ1Pb+0/Rz/+SUhvWVXnEaQTnItaBrzguvd+ndEqD7Zxa/z1WckfDiyVvOnwX1psZvqG
         EJcOdiA3Tb43I43MVfAeUlrKEIZt7Fat8FetVPYGYS+NdLa7sFbBQuPmO6nFiEGF9qBE
         FB8ajAR3P4wcQjEreGJhxWszXBBu2GMvYglnTkeaLX608nl8HoXXQNYtasv26Cruxplf
         S5/A==
X-Forwarded-Encrypted: i=1; AHgh+RpJvRa7r2Yrp3cb5Tp71enN0XzN3DNhGLgvnCTUa5X1lD0P5lJ86IFAHlriIEFjtceWFmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5D8Kcc2YElXb7VWkAFV9kHlS+KXCoUNUVjdX1Y1i+8pWZiYc
	0fKjdGEfoW49zM11uxI206P2vd7EP0K36YEgSiSU3+vmIpPr+qFMzdpyHmBmxWiNImyPt1nU8Q6
	NAKiXbqjMauQoaCgWnx3pS5al5VOAyc7/B+9FXcSdjw==
X-Gm-Gg: AR+sD10XJppej+xm+5FrwH5mTimKpMZOJWQfSdv+875AkAyOztq4aTLZlXL4ofeTzht
	1mh9jkxrFI0W5Ru1Qx6lr6nfssRIObzD5uJ4ekTaE0QZ1M7jum7SRzC/wFj14wVtH6ReihhcKIp
	rHwwJzuRaybj77FFZemZwzvNLgsF8U4RAEXF7zJDJ+EEmbygBPTf3RCLmq1prmTG82eVAbmgw16
	Hv0wGN68N9vZ3mUKI/ZcnOWiSbe7iZ2DwDuSFnp8jffGWaybK4wXQaoHIzo0PHlNyVtVvBmY+Vc
	i7gz3uA3Xh47Z4AoC26JZD2jNMBQ5AdzszWWsZGHg0Qqt8RZs2RY9tLEsLzh7M2dUcf943vqiZY
	2uJat/zOcHYfFXDcr6hHdWTmmG73I2M1Djdvkl+eUessLjj4yCGfliI1vJfulK+M=
X-Received: by 2002:a05:6000:707:b0:47f:90df:4ec6 with SMTP id
 ffacd0b85a97d-47fb1e5ffa9mr7439787f8f.6.1785330615148; Wed, 29 Jul 2026
 06:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713010302.303278-1-inochiama@gmail.com> <20260713010302.303278-8-inochiama@gmail.com>
In-Reply-To: <20260713010302.303278-8-inochiama@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 18:40:03 +0530
X-Gm-Features: AUfX_mzDcWuxE6PkzrbfuK4rtESRLEYMRMklaBIZb-MTh6f9nimxeIEC2cIHilw
Message-ID: <CAAhSdy2P3Fgfv3t9n=wNTfBL-63k+3qaDvsG1QWxtkWTFfvWvg@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] RISC-V: KVM: Add support for control-flow
 integrity FWFT features
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

On Mon, Jul 13, 2026 at 6:34=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> Control-flow integrity is controlled through a WARL field in henvcfg.
> Expose the feature only if the Zicfilp/Zicfiss is supported for VS-mode.
> Allow the VMM to block access to the feature by disabling the ISA
> extension in the guest.
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
>  arch/riscv/include/uapi/asm/kvm.h |   2 +
>  arch/riscv/kvm/vcpu_sbi_fwft.c    | 107 ++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index fd4c81697617..20d9959ca44f 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -248,6 +248,8 @@ struct kvm_riscv_sbi_fwft {
>         struct kvm_riscv_sbi_fwft_feature misaligned_deleg;
>         struct kvm_riscv_sbi_fwft_feature pointer_masking;
>         struct kvm_riscv_sbi_fwft_feature pte_ad_hw_updating;
> +       struct kvm_riscv_sbi_fwft_feature landing_pad;
> +       struct kvm_riscv_sbi_fwft_feature shadow_stack;
>  };
>
>  /* If you need to interpret the index values, here is the key: */
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 4d474a439b29..03153fd8d15f 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -176,6 +176,95 @@ static long kvm_sbi_fwft_get_misaligned_delegation(s=
truct kvm_vcpu *vcpu,
>         return SBI_SUCCESS;
>  }
>
> +static long kvm_sbi_fwft_set_cfi(struct kvm_vcpu *vcpu,
> +                                struct kvm_sbi_fwft_config *conf,
> +                                bool one_reg_access, unsigned long value=
,
> +                                u64 flag)
> +{
> +       struct kvm_vcpu_config *cfg =3D &vcpu->arch.cfg;
> +
> +       if (value =3D=3D 0)
> +               cfg->henvcfg &=3D ~flag;
> +       else if (value =3D=3D 1)
> +               cfg->henvcfg |=3D flag;
> +       else
> +               return SBI_ERR_INVALID_PARAM;
> +
> +       if (cfg->henvcfg & (ENVCFG_LPE | ENVCFG_SSE))
> +               cfg->hedeleg |=3D BIT(EXC_SOFTWARE_CHECK);
> +       else
> +               cfg->hedeleg &=3D ~BIT(EXC_SOFTWARE_CHECK);
> +
> +       if (!one_reg_access) {
> +               csr_write(CSR_HEDELEG, cfg->hedeleg);
> +               /*
> +                * Both Bit LPE and SSE are in the lower part, so it is s=
afe
> +                * to only write the henvcfg
> +                */
> +               csr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
> +       }
> +
> +       return SBI_SUCCESS;
> +}
> +
> +static bool kvm_sbi_fwft_landing_pad_supported(struct kvm_vcpu *vcpu)
> +{
> +       return riscv_isa_extension_available(vcpu->arch.isa, ZICFILP);
> +}
> +
> +static void kvm_sbi_fwft_reset_landing_pad(struct kvm_vcpu *vcpu)
> +{
> +       struct kvm_vcpu_config *cfg =3D &vcpu->arch.cfg;
> +
> +       kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_LPE);
> +       if ((cfg->henvcfg & (ENVCFG_LPE | ENVCFG_SSE)) =3D=3D 0)
> +               cfg->hedeleg &=3D ~BIT(EXC_SOFTWARE_CHECK);
> +}
> +
> +static long kvm_sbi_fwft_set_landing_pad(struct kvm_vcpu *vcpu,
> +                                        struct kvm_sbi_fwft_config *conf=
,
> +                                        bool one_reg_access, unsigned lo=
ng value)
> +{
> +       return kvm_sbi_fwft_set_cfi(vcpu, conf, one_reg_access, value, EN=
VCFG_LPE);
> +}
> +
> +static long kvm_sbi_fwft_get_landing_pad(struct kvm_vcpu *vcpu,
> +                                        struct kvm_sbi_fwft_config *conf=
,
> +                                        bool one_reg_access, unsigned lo=
ng *value)
> +{
> +       return kvm_sbi_fwft_env_flag_get_helper(vcpu, conf, one_reg_acces=
s,
> +                                               value, ENVCFG_LPE);
> +}
> +
> +static bool kvm_sbi_fwft_shadow_stack_supported(struct kvm_vcpu *vcpu)
> +{
> +       return riscv_isa_extension_available(vcpu->arch.isa, ZICFISS);
> +}
> +
> +static void kvm_sbi_fwft_reset_shadow_stack(struct kvm_vcpu *vcpu)
> +{
> +       struct kvm_vcpu_config *cfg =3D &vcpu->arch.cfg;
> +
> +       kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_SSE);
> +       if ((cfg->henvcfg & (ENVCFG_LPE | ENVCFG_SSE)) =3D=3D 0)
> +               cfg->hedeleg &=3D ~BIT(EXC_SOFTWARE_CHECK);
> +}
> +
> +static long kvm_sbi_fwft_set_shadow_stack(struct kvm_vcpu *vcpu,
> +                                         struct kvm_sbi_fwft_config *con=
f,
> +                                         bool one_reg_access, unsigned l=
ong value)
> +{
> +       return kvm_sbi_fwft_set_cfi(vcpu, conf, one_reg_access, value, EN=
VCFG_SSE);
> +}
> +
> +static long kvm_sbi_fwft_get_shadow_stack(struct kvm_vcpu *vcpu,
> +                                         struct kvm_sbi_fwft_config *con=
f,
> +                                         bool one_reg_access, unsigned l=
ong *value)
> +{
> +       return kvm_sbi_fwft_env_flag_get_helper(vcpu, conf, one_reg_acces=
s,
> +                                               value, ENVCFG_SSE);
> +}
> +
>  static bool kvm_sbi_fwft_pte_ad_hw_updating_supported(struct kvm_vcpu *v=
cpu)
>  {
>         return riscv_isa_extension_available(vcpu->arch.isa, SVADU) &&
> @@ -313,6 +402,24 @@ static const struct kvm_sbi_fwft_feature features[] =
=3D {
>                 .set =3D kvm_sbi_fwft_set_misaligned_delegation,
>                 .get =3D kvm_sbi_fwft_get_misaligned_delegation,
>         },
> +       {
> +               .id =3D SBI_FWFT_LANDING_PAD,
> +               .first_reg_num =3D offsetof(struct kvm_riscv_sbi_fwft, la=
nding_pad.enable) /
> +                                sizeof(unsigned long),
> +               .supported =3D kvm_sbi_fwft_landing_pad_supported,
> +               .reset =3D kvm_sbi_fwft_reset_landing_pad,
> +               .set =3D kvm_sbi_fwft_set_landing_pad,
> +               .get =3D kvm_sbi_fwft_get_landing_pad,
> +       },
> +       {
> +               .id =3D SBI_FWFT_SHADOW_STACK,
> +               .first_reg_num =3D offsetof(struct kvm_riscv_sbi_fwft, sh=
adow_stack.enable) /
> +                                sizeof(unsigned long),
> +               .supported =3D kvm_sbi_fwft_shadow_stack_supported,
> +               .reset =3D kvm_sbi_fwft_reset_shadow_stack,
> +               .set =3D kvm_sbi_fwft_set_shadow_stack,
> +               .get =3D kvm_sbi_fwft_get_shadow_stack,
> +       },
>         {
>                 .id =3D SBI_FWFT_PTE_AD_HW_UPDATING,
>                 .first_reg_num =3D offsetof(struct kvm_riscv_sbi_fwft, pt=
e_ad_hw_updating.enable) /
> --
> 2.55.0
>
