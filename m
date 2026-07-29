Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15CD47CC7A
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329056; cv=pass; b=GB7oqfijKJYQKK/qIkMqWBgT+ZSuGXF7LOKwKde87OezG/ZO62GOBvA0iT24IlWLi6PeapWMXEqK7RUvnum993kjxdYqe5j7Py6H5YnR2XgxlrZ9x0QPjIXEfH5kwX4CiZwK6ARgC1CU4ZaKDHMQSdCuB4ZgJ+MIF3tdDnf0AxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329056; c=relaxed/simple;
	bh=F8IHG4OYKgE61JI9JGANwQRR9aQYRg2JCeFAbzAKbyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0vn8LgdrIMFpNWzMeCgVNs9qPt7LjlBWtj9d4aw5B5J8i0NV/EiTC+uVNSDlVswMJJdv746OAF2d4TuFJQKAylNUrghn6BGb5WJjYSpwDa46IYSvdEDt4ddQ5el71dZe483JA9Tv3EC+ObUMIc1eksroUsqnvmGNZ5BJU7x7nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=DWQhrzYh; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="DWQhrzYh"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49550ec592cso13253145e9.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 05:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785329045; cv=none;
        d=google.com; s=arc-20260327;
        b=Xc0dpF9e5sVx1+Dxe9Rl1MdjwYMziWD0OBcEZ6mNrp4XedRbV26LKXoPH6Bz0dx4e0
         wt0ZhNBauLDF4ARR9oQSyW9teDhe4Vtqc4XI+lRf3F8WXbDOJ0lnGyRNi0xDKydkBTo5
         HpCHfpwLpW5kJpYYAiBS9otz+VQjHl3QTpThQI0/6paBc4wcrdkbS8hlecnjOu1Fh5cV
         nVuTNlA7hXbSE8jK/tGKswJP37aT2bvdPxrMDJRBrzykWjxcbbJgpdritzb4UpL8ZxkA
         vG3wesoMD3rDA6cx0IlpQf+07RKQ4jBCZqnH/hng+7SN8FTqihKXBiLMSvNt9qbE1seX
         8P1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hm5r/xpzCIodGlWiNThjdtOQlm2HxnqjU/kCjY5K+u0=;
        fh=1rpKrrDwHTIQWptClslz//ktqbv4cPnER5KdDsNP7as=;
        b=k/66hJn4wEq0+AI4wkIqBE6rEPHQY7plrdgoUTsIj4CKySWXe0NB/AhHWkvZupgVS5
         9ISUlKMtcjoaqI9OAmfN7xckOMxd3udCxoO1CNGl8fEoxn/N76Y9tFTYWm7BFOFPvcdN
         JTpP7w4VWnz6NjGp0ZzaGiz8PaGBDHBeRuFYCyIZXItmVolCrJbCl0rcOkMPDunri205
         sh7jDktr+TYVGUARa4BGyud0bg/RCl1JsbXDZg5rp3vKrKakWftTScV128dXgCKM5sHv
         r+35T3iSXKBWx/Js1lKh0gF0KvVnpE2hmAy5kQJH05e28Lh0l0AO+XUQjjHdX2nrccCt
         b38Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785329045; x=1785933845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hm5r/xpzCIodGlWiNThjdtOQlm2HxnqjU/kCjY5K+u0=;
        b=DWQhrzYheQhSynDBCEkUszZnFJZwWCS20UENDd6L65sUakFpmGW3q2aURTm2NWH9y6
         XcvXJU4y55EfBLCxo77wuEhDlSmMemY7bv+hPQTpCL6KsgualbKKlVC5itclC0w30sSY
         H0KVdStgG85k5bTEBtm+nIUsa4sCU00ighaIPpKhbLMRg9oDN4uQ+7YfsC6+BH0QL3Qa
         2VktVcrK0ghWi88gD/cj/VVeJF6FfNsMvAqtPw/TMb3M7xmx1zjyomQt2J3OdvmzbuIY
         yhaX48kML8Kw2w3EMcjmK03Pe1eoEKZj2VfTdW8qBEtJgLRQFWB73Bw+4XjwVZfKumFg
         Y89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785329045; x=1785933845;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hm5r/xpzCIodGlWiNThjdtOQlm2HxnqjU/kCjY5K+u0=;
        b=mJ3dGKCCqWoQDM/oUTyW+EriQdFj+BkRhwxyBeYv6n0qBDLfs1PdkpGWHf3AIsQ6v3
         yVmRwr/2NZUVN0OWw+c980As6Y3HQ5OkunToaoCvzp6/rWU1m7doXSH/Rkr5yH9lVnTJ
         IA/iON4kwIHrbVvzsfHQhZYwAH708PCN7XiIXLeHqrilVtdvvRtercAJiXaitji0Dpt3
         Kr+QEj8w6Weu3R/z6GnLC4rBWyZ7eaajp0YBWGfW/36DKzukXixkWF2psC7NvHeoL3FK
         6Nf6uSAqxbOs9eUBUMQ7Fhpfq5xeTEzB9KNCKo6oeWHuysUCdwjfpHBhTgfKVDsRJehq
         SqGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwK/gvHNH6fbTwsDNdbPgmk/0xihI5LkuwUTcmnICNvafk3aBjn5E2IRfHQFGxgaDbISM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCl695yZDjxGYaMDqXSp7/YIZ9fR40QakxcuM4Mc49R2hwRE7
	kcl8/zjPujPnadIfhgBNDcVr82xIoohKL32ZdeP6ZgMu1qbWOxijDiWcqJmphzGig/neaYTf+mc
	PWwKF7LCFx1ELWmAxaEBgc7uhkzP3q3k0mN3A90yQfA==
X-Gm-Gg: AR+sD12iQmkj+Tz9B+KrtaFDCNz1c9eeyaT3TbynA6zFQsygxTflm3OBoILlRwnX9fh
	1/f3owdYkzJy6N+UVfHUK9n5QcQJg6FcFeukPM1a/nLMcI00QZD8NHsVmvInNbD8K5TpBdhf3DB
	beiet0xrXIrvZY6u1g/9aALz/v//hha6eD6G6gfD/CbF8hmEqbaJeJ4khjfGuDS/OpmLEB/GAw3
	nbmzpmpWSHNTTOyT0FNXy9oFFRT/Hq1C5N6E8EwSCMKd/JEv8kD8r9ZmG5/KFjeaUml2LNnna8J
	h/4eFiZK4kzVFZqviZI2QgkdCPR6YtJjRoluopHyud5QhYD5H06ieczTovG0FkWvNe+lf4IVgfz
	9RqBtxDe0ZuIIGE9pYwUPVqux79vqsINc/C+Odm9/W+oUoD1n1JM/OacRfSo0lwU=
X-Received: by 2002:a05:600c:4746:b0:495:3c6f:7c18 with SMTP id
 5b1f17b1804b1-497fd2f50bbmr22311715e9.3.1785329045078; Wed, 29 Jul 2026
 05:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713010302.303278-1-inochiama@gmail.com> <20260713010302.303278-2-inochiama@gmail.com>
In-Reply-To: <20260713010302.303278-2-inochiama@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 18:13:52 +0530
X-Gm-Features: AUfX_mwNGvCJ0K_M3RbragaNPirqy3_PcAwefERtLMiHMQvQ2ITGlUlXogu6tRE
Message-ID: <CAAhSdy2dGry-jgpCGJyH6-qRbp2WVsJU39XskkigxCdyxmi=eQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] RISC-V: KVM: Add support for Svadu FWFT features
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
> Hardware updating of PTE A/D bits is controlled through ADUE bit in
> henvcfg Expose the feature only if both Svadu and Svade are supported
> for VS-mode.
>
> Allow the VMM to enable/disable this feature by change the ISA
> extension state in the guest.
>
> Assisted-by: YuanSheng:claude-4.7-opus
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h |  1 +
>  arch/riscv/kvm/vcpu_sbi_fwft.c    | 76 +++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 504e73305343..7bbea8812d92 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -240,6 +240,7 @@ struct kvm_riscv_sbi_fwft_feature {
>  struct kvm_riscv_sbi_fwft {
>         struct kvm_riscv_sbi_fwft_feature misaligned_deleg;
>         struct kvm_riscv_sbi_fwft_feature pointer_masking;
> +       struct kvm_riscv_sbi_fwft_feature pte_ad_hw_updating;
>  };
>
>  /* If you need to interpret the index values, here is the key: */
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index ab39ac464ffd..4d474a439b29 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -94,6 +94,45 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_=
feature_t feature)
>         return false;
>  }
>
> +static void kvm_sbi_fwft_env_flag_reset_helper(struct kvm_vcpu *vcpu,
> +                                              u64 flag)

Try to use upto 80-90 characters per-line.

s/kvm_sbi_fwft_env_flag_reset_helper/kvm_sbi_fwft_envcfg_flag_reset/

> +{
> +       vcpu->arch.cfg.henvcfg &=3D ~flag;
> +}
> +
> +static long kvm_sbi_fwft_env_flag_set_helper(struct kvm_vcpu *vcpu,
> +                                            struct kvm_sbi_fwft_config *=
conf,
> +                                            bool one_reg_access,
> +                                            unsigned long value, u64 fla=
g)

s/kvm_sbi_fwft_env_flag_set_helper/kvm_sbi_fwft_envcfg_flag_set/

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
> +       if (!one_reg_access) {
> +               csr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
> +               if (IS_ENABLED(CONFIG_32BIT))
> +                       csr_write(CSR_HENVCFGH, vcpu->arch.cfg.henvcfg >>=
 32);
> +       }
> +
> +       return SBI_SUCCESS;
> +}
> +
> +static long kvm_sbi_fwft_env_flag_get_helper(struct kvm_vcpu *vcpu,
> +                                            struct kvm_sbi_fwft_config *=
conf,
> +                                            bool one_reg_access,
> +                                            unsigned long *value, u64 fl=
ag)

s/kvm_sbi_fwft_env_flag_get_helper/kvm_sbi_fwft_envcfg_flag_get/

> +{
> +       *value =3D (vcpu->arch.cfg.henvcfg & flag) =3D=3D flag;
> +
> +       return SBI_SUCCESS;
> +}
> +
>  static bool kvm_sbi_fwft_misaligned_delegation_supported(struct kvm_vcpu=
 *vcpu)
>  {
>         return misaligned_traps_can_delegate();
> @@ -137,6 +176,34 @@ static long kvm_sbi_fwft_get_misaligned_delegation(s=
truct kvm_vcpu *vcpu,
>         return SBI_SUCCESS;
>  }
>
> +static bool kvm_sbi_fwft_pte_ad_hw_updating_supported(struct kvm_vcpu *v=
cpu)
> +{
> +       return riscv_isa_extension_available(vcpu->arch.isa, SVADU) &&
> +               riscv_isa_extension_available(vcpu->arch.isa, SVADE);
> +}
> +
> +static void kvm_sbi_fwft_reset_pte_ad_hw_updating(struct kvm_vcpu *vcpu)
> +{
> +       if (kvm_sbi_fwft_pte_ad_hw_updating_supported(vcpu))
> +               kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_ADUE);
> +}
> +
> +static long kvm_sbi_fwft_set_pte_ad_hw_updating(struct kvm_vcpu *vcpu,
> +                                               struct kvm_sbi_fwft_confi=
g *conf,
> +                                               bool one_reg_access, unsi=
gned long value)
> +{
> +       return kvm_sbi_fwft_env_flag_set_helper(vcpu, conf, one_reg_acces=
s,
> +                                               value, ENVCFG_ADUE);
> +}
> +
> +static long kvm_sbi_fwft_get_pte_ad_hw_updating(struct kvm_vcpu *vcpu,
> +                                               struct kvm_sbi_fwft_confi=
g *conf,
> +                                               bool one_reg_access, unsi=
gned long *value)
> +{
> +       return kvm_sbi_fwft_env_flag_get_helper(vcpu, conf, one_reg_acces=
s,
> +                                               value, ENVCFG_ADUE);
> +}
> +
>  #ifndef CONFIG_32BIT
>
>  static bool try_to_set_pmm(unsigned long value)
> @@ -246,6 +313,15 @@ static const struct kvm_sbi_fwft_feature features[] =
=3D {
>                 .set =3D kvm_sbi_fwft_set_misaligned_delegation,
>                 .get =3D kvm_sbi_fwft_get_misaligned_delegation,
>         },
> +       {
> +               .id =3D SBI_FWFT_PTE_AD_HW_UPDATING,
> +               .first_reg_num =3D offsetof(struct kvm_riscv_sbi_fwft, pt=
e_ad_hw_updating.enable) /
> +                                sizeof(unsigned long),
> +               .supported =3D kvm_sbi_fwft_pte_ad_hw_updating_supported,
> +               .reset =3D kvm_sbi_fwft_reset_pte_ad_hw_updating,
> +               .set =3D kvm_sbi_fwft_set_pte_ad_hw_updating,
> +               .get =3D kvm_sbi_fwft_get_pte_ad_hw_updating,
> +       },
>  #ifndef CONFIG_32BIT
>         {
>                 .id =3D SBI_FWFT_POINTER_MASKING_PMLEN,
> --
> 2.55.0
>

Otherwise, this looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
