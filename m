Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED7B3BE628
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676023; cv=pass; b=jCRAKjBi6wWlrpaFe/Wyq/j/wNMFiI9mGFQSsVP2DjnNUXAIkRF9GjT6hHt6cJauZAn1Hez8PNr+qZacTUq/2De0VJTz4NIL/7fZ6aZes/u9XKo/25A3OHR/QA9xoCPpENMPs5gs7nv+VnLMUkbQf74AJBlXBK+Ov7z36naCC04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676023; c=relaxed/simple;
	bh=ASSI4TI1vO/M9QX+3fLfTeGqshl7AQiN4Qsyxv+hswE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9zez+NDwDXVL2vEC18yLSUNIhtGNqdau7ZFb8oanNaxGJY8b10pvKo41WcrBNkwoLYPGiWF/W1ZvQTG/vSoBEyKmOMBoofSafw6F0lmxcvkfKZpYUVwjbsc2hgAduBYThci2o1C7DsnvAqe60U9Y3IVtz4xtfSVdbe5vsIXL6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=HH8kyb01; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="HH8kyb01"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9158643e538so191809085a.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 09:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676021; cv=none;
        d=google.com; s=arc-20240605;
        b=bhU1EHHbe0HAGljhhVsNOyvs9qxQDs365wkH3y0x3UzY0zlt4XQroEPZX6b5nT5wYr
         M28A2eWnC3dIbiIAT5IWE3ZCtOoo/EYuTTUhNi/u4dlnrj7+NyD5UaF1t9VZ18m4ukX7
         l+t/ch69bm0vtlDBofyDv2MLmXChXsv3uQie0l9aJG3bqgjV0m1niRP7xmXtiHFy1+es
         LR2Jbel2fO6iE+gA2ul1lExojBWHTbiPwFEexc7aojDYY+QikemnQdeE+5oNkAGOMEay
         9wdvt2VOFAbt41YLqsmXSJax0/DxD7gcz6gN9NHjKuAMBJiEBkOAouQL11OkosHbiH12
         i33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yF6BXyz1ItQFIDAZ5TUGTorS1oqVWzcNFc1MXjsMoBM=;
        fh=unaPHBBn8zajKfp1fglQSdTwtwcg1k68QOlkkwEKQ9k=;
        b=LO2jViQFE3aj3Ub6VnhC8GV1o5mZX4sz2cSaJgCQkEjV6i1YRoGWvn7DNcj147BZEr
         5iXyRpblo8JYAB+VPXEvXfDHZo10pAlotz2y1V7hQc6HsAJzVfk6F8bLnQYQG89L93a3
         UEvI7R9Wj4kJCCAADGM/6GRy7oB4pz0b26n0JyZLZM1PEEmbaW4LJCcCvGOz7ez/LtZd
         ECBCANDhXY1R/47pJSRsdmafyaeg66+mYWaQJfhhn2EMeQ8+mHf8TZy8doEyVXQMUwZu
         LbFNxacljJreOQOaaNSg7IvXxHz8gGULNXmOY+yLU+CfHHALzKKQWpDXbsxZHNAKYITN
         ggJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780676021; x=1781280821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF6BXyz1ItQFIDAZ5TUGTorS1oqVWzcNFc1MXjsMoBM=;
        b=HH8kyb01mot6aBhXE/0AlZHUauWPN3YARo+JyTvO9ogSTcwvivzrnuhViOHr2pAyvi
         aEWjT9pfq4WzwA52yCfIXz7+hJ/6Or3zfl4lhEcwOSvzYMXOJZvbq4v5Ois8wAycOs4l
         BK4KvPzPbu3CysZL7kioOMg4qUmj0vGg/wBDkyVOZmOYGJClXlb+aa+4OQsHOIhVHZ6G
         jmSoS9+lvXKe9W9tU6j0SvaVv4x+xYe2TbumHT2j8pRade7gR7NeWzoOOivaZVgOlrSH
         j3n54mK9RK/qY0ic3cKfrn+W5QBCeGu47M8YzCMeERSNjy23cspQ9l9qe+uG4jPbjQK2
         Wf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676021; x=1781280821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yF6BXyz1ItQFIDAZ5TUGTorS1oqVWzcNFc1MXjsMoBM=;
        b=FQY3No55ucVstP1PsnYBCWYzA+MPQqX3AD4JKrbv0WhMx1hoAZ4XXWyRpbeWicBACv
         /236ehHUkkF/7BKNcxgIiZLLof6UlPdiXGgdkVs96/l+I9/+Ip3bHjAlP+iwTbRHuqDi
         Oipo/FhK6cWkHvrHiGloV2t2Y6762rCsnWPbPkNDbEiuXQmsauPAxcb996jAevpSCBa/
         v+CxiM6AY0oOVPuVEtk1ZdmZG5EmUgDRoHIByALlqVrhn8krSSm6yUOv4tdbbEhDQ+jp
         c7972wIfH6DbVWogDt+1ToaLU3kiCRt7ed/8YxJxBz95yYrJ5uusysZoVFmlTXJHGZpC
         nedQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Fio4A8A8VUVSG59zyHCNu2zcerIsaf+QgX9Xnv6q4fJ/YjTNZUiiBD56NzDwuOpdReFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuwUCH7fyBMieVWWypUi11S36JmB1EwZxST/SRrmnNitngBPck
	dcF+3D1xWGstXhSik7lR9R4SWmNVoHmh7z67MnZSdDWmoqjkWRbjND/YvfaAchv3jGRau9w+TF0
	FDTQ0C/9U42hBfiMOh4ChDi3CPPmGC6sPXcq5WvVRxQ==
X-Gm-Gg: Acq92OFk7q4wnIsvN/EloeAcyxt7s0o5FQrWSvBB5AurqMvGWtrM+UoNxny8yxvnquC
	2H1nArRXFYa1ngQpV93dp1DU8OYFpEO5rPeTjr+REPV6mGhzz+3BCnvaJ4Ijijtg9rMU47GnE0O
	CTI/EomqjZOFD5s7M+ZjmyVfqRjQGePTOQnu/dlUjdeSYuuqGNCAe+Xh5cuZR0csrjLtrx8YSpo
	qXxp86IPvKpVwWrQnYcKQl68FZnLvqfWlceaqUaXUs6rYg4wQGcja/XBI9ycrEqPNmueM4bJ17G
	ne61ABpfgiwm9oeBpO5y17wGlBPVxbbyK2VoQujGyDtuuVQuq2mp9yrpT9/vzfr0dOrVTq95RO9
	Jh56UDfPFGDA+tDAASks4ABB6XfO+enn459nw
X-Received: by 2002:a05:622a:1186:b0:516:dff5:68c4 with SMTP id
 d75a77b69052e-51795a0879emr66626951cf.7.1780676021330; Fri, 05 Jun 2026
 09:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com> <20260601-kvm-get_reg_list-v2-v5-4-415d08a2813b@sifive.com>
In-Reply-To: <20260601-kvm-get_reg_list-v2-v5-4-415d08a2813b@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 5 Jun 2026 21:43:28 +0530
X-Gm-Features: AVVi8Cdvoc0g8Ijx9YN_7UbfRyLpsCd3BL6KGQyBcDgtuzIqCFfAljqRHTimAnk
Message-ID: <CAAhSdy3ffD+ndNQFWeGZTQAwnQBhEB=fGKOJO4e0H2r66U7eEQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] KVM: riscv: selftests: Refactor ISA and SBI
 extension sublist macros
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, greentime.hu@sifive.com, vincent.chen@sifive.com, 
	zong.li@sifive.com, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, inochiama@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 3:56=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifive=
.com> wrote:
>
> Refactor the get-reg-list test to use unified sublist macros for ISA
> and SBI extensions, eliminating code duplication and improving
> maintainability.
>
> Previously, each extension had its own hand-coded sublist definition
> (e.g., SUBLIST_ZICBOM, SUBLIST_AIA, etc.) and the config structures
> repeated the same pattern. This made the code verbose and error-prone.
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 78 +++++++++---------=
------
>  1 file changed, 28 insertions(+), 50 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 8d6fdb5d38b8..5033c09201ef 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -1013,7 +1013,7 @@ static __u64 fp_d_regs[] =3D {
>  };
>
>  /* Define a default vector registers with length. This will be overwritt=
en at runtime */
> -static __u64 vector_regs[] =3D {
> +static __u64 v_regs[] =3D {
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_R=
EG_RISCV_VECTOR_CSR_REG(vstart),
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_R=
EG_RISCV_VECTOR_CSR_REG(vl),
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_R=
EG_RISCV_VECTOR_CSR_REG(vtype),
> @@ -1057,37 +1057,17 @@ static __u64 vector_regs[] =3D {
>  #define SUBLIST_BASE \
>         {"base", .regs =3D base_regs, .regs_n =3D ARRAY_SIZE(base_regs), =
\
>          .skips_set =3D base_skips_set, .skips_set_n =3D ARRAY_SIZE(base_=
skips_set),}
> -#define SUBLIST_SBI_BASE \
> -       {"sbi-base", .feature_type =3D VCPU_FEATURE_SBI_EXT, .feature =3D=
 KVM_RISCV_SBI_EXT_V01, \
> -        .regs =3D sbi_base_regs, .regs_n =3D ARRAY_SIZE(sbi_base_regs),}
> -#define SUBLIST_SBI_STA \
> -       {"sbi-sta", .feature_type =3D VCPU_FEATURE_SBI_EXT, .feature =3D =
KVM_RISCV_SBI_EXT_STA, \
> -        .regs =3D sbi_sta_regs, .regs_n =3D ARRAY_SIZE(sbi_sta_regs),}
> -#define SUBLIST_SBI_FWFT \
> -       {"sbi-fwft", .feature_type =3D VCPU_FEATURE_SBI_EXT, .feature =3D=
 KVM_RISCV_SBI_EXT_FWFT, \
> -        .regs =3D sbi_fwft_regs, .regs_n =3D ARRAY_SIZE(sbi_fwft_regs),}
> -#define SUBLIST_ZICBOM \
> -       {"zicbom", .feature =3D KVM_RISCV_ISA_EXT_ZICBOM, .regs =3D zicbo=
m_regs, .regs_n =3D ARRAY_SIZE(zicbom_regs),}
> -#define SUBLIST_ZICBOP \
> -       {"zicbop", .feature =3D KVM_RISCV_ISA_EXT_ZICBOP, .regs =3D zicbo=
p_regs, .regs_n =3D ARRAY_SIZE(zicbop_regs),}
> -#define SUBLIST_ZICBOZ \
> -       {"zicboz", .feature =3D KVM_RISCV_ISA_EXT_ZICBOZ, .regs =3D zicbo=
z_regs, .regs_n =3D ARRAY_SIZE(zicboz_regs),}
> -#define SUBLIST_AIA \
> -       {"aia", .feature =3D KVM_RISCV_ISA_EXT_SSAIA, .regs =3D aia_regs,=
 .regs_n =3D ARRAY_SIZE(aia_regs),}
> -#define SUBLIST_SMSTATEEN \
> -       {"smstateen", .feature =3D KVM_RISCV_ISA_EXT_SMSTATEEN, .regs =3D=
 smstateen_regs, .regs_n =3D ARRAY_SIZE(smstateen_regs),}
> -#define SUBLIST_FP_F \
> -       {"fp_f", .feature =3D KVM_RISCV_ISA_EXT_F, .regs =3D fp_f_regs, \
> -               .regs_n =3D ARRAY_SIZE(fp_f_regs),}
> -#define SUBLIST_FP_D \
> -       {"fp_d", .feature =3D KVM_RISCV_ISA_EXT_D, .regs =3D fp_d_regs, \
> -               .regs_n =3D ARRAY_SIZE(fp_d_regs),}
> -
> -#define SUBLIST_V \
> -       {"v", .feature =3D KVM_RISCV_ISA_EXT_V, .regs =3D vector_regs, .r=
egs_n =3D ARRAY_SIZE(vector_regs),}
> +
> +#define SUBLIST_ISA(ext, extu)                         \
> +       {                                               \
> +               .name =3D #ext,                           \
> +               .feature =3D KVM_RISCV_ISA_EXT_##extu,    \
> +               .regs =3D ext##_regs,                     \
> +               .regs_n =3D ARRAY_SIZE(ext##_regs),       \
> +       }
>
>  #define KVM_ISA_EXT_SIMPLE_CONFIG(ext, extu)                   \
> -static __u64 regs_##ext[] =3D {                                  \
> +static __u64 ext##_regs[] =3D {                                  \
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG |                    \
>         KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE |      \
>         KVM_RISCV_ISA_EXT_##extu,                               \
> @@ -1095,18 +1075,22 @@ static __u64 regs_##ext[] =3D {                  =
                 \
>  static struct vcpu_reg_list config_##ext =3D {                   \
>         .sublists =3D {                                           \
>                 SUBLIST_BASE,                                   \
> -               {                                               \
> -                       .name =3D #ext,                           \
> -                       .feature =3D KVM_RISCV_ISA_EXT_##extu,    \
> -                       .regs =3D regs_##ext,                     \
> -                       .regs_n =3D ARRAY_SIZE(regs_##ext),       \
> -               },                                              \
> +               SUBLIST_ISA(ext, extu),                         \
>                 {0},                                            \
>         },                                                      \
>  }                                                              \
>
> +#define SUBLIST_SBI(ext, extu)                                 \
> +       {                                                       \
> +               .name =3D "sbi-"#ext,                             \
> +               .feature_type =3D VCPU_FEATURE_SBI_EXT,           \
> +               .feature =3D KVM_RISCV_SBI_EXT_##extu,            \
> +               .regs =3D sbi_##ext##_regs,                       \
> +               .regs_n =3D ARRAY_SIZE(sbi_##ext##_regs),         \
> +       }
> +
>  #define KVM_SBI_EXT_SIMPLE_CONFIG(ext, extu)                   \
> -static __u64 regs_sbi_##ext[] =3D {                              \
> +static __u64 sbi_##ext##_regs[] =3D {                            \
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG |                    \
>         KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE |      \
>         KVM_RISCV_SBI_EXT_##extu,                               \
> @@ -1114,13 +1098,7 @@ static __u64 regs_sbi_##ext[] =3D {               =
                 \
>  static struct vcpu_reg_list config_sbi_##ext =3D {               \
>         .sublists =3D {                                           \
>                 SUBLIST_BASE,                                   \
> -               {                                               \
> -                       .name =3D "sbi-"#ext,                     \
> -                       .feature_type =3D VCPU_FEATURE_SBI_EXT,   \
> -                       .feature =3D KVM_RISCV_SBI_EXT_##extu,    \
> -                       .regs =3D regs_sbi_##ext,                 \
> -                       .regs_n =3D ARRAY_SIZE(regs_sbi_##ext),   \
> -               },                                              \
> +               SUBLIST_SBI(ext, extu),                         \
>                 {0},                                            \
>         },                                                      \
>  }                                                              \
> @@ -1129,7 +1107,7 @@ static struct vcpu_reg_list config_sbi_##ext =3D { =
         \
>  static struct vcpu_reg_list config_##ext =3D {                   \
>         .sublists =3D {                                           \
>                 SUBLIST_BASE,                                   \
> -               SUBLIST_##extu,                                 \
> +               SUBLIST_ISA(ext, extu),                         \
>                 {0},                                            \
>         },                                                      \
>  }                                                              \
> @@ -1138,14 +1116,14 @@ static struct vcpu_reg_list config_##ext =3D {   =
                 \
>  static struct vcpu_reg_list config_sbi_##ext =3D {               \
>         .sublists =3D {                                           \
>                 SUBLIST_BASE,                                   \
> -               SUBLIST_SBI_##extu,                             \
> +               SUBLIST_SBI(ext, extu),                         \
>                 {0},                                            \
>         },                                                      \
>  }                                                              \
>
>  /* Note: The below list is alphabetically sorted. */
>
> -KVM_SBI_EXT_SUBLIST_CONFIG(base, BASE);
> +KVM_SBI_EXT_SUBLIST_CONFIG(base, V01);
>  KVM_SBI_EXT_SUBLIST_CONFIG(sta, STA);
>  KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
>  KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
> @@ -1153,9 +1131,9 @@ KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
>  KVM_SBI_EXT_SIMPLE_CONFIG(mpxy, MPXY);
>  KVM_SBI_EXT_SUBLIST_CONFIG(fwft, FWFT);
>
> -KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
> -KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
> -KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
> +KVM_ISA_EXT_SUBLIST_CONFIG(aia, SSAIA);
> +KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, F);
> +KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, D);
>  KVM_ISA_EXT_SUBLIST_CONFIG(v, V);
>  KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
>  KVM_ISA_EXT_SIMPLE_CONFIG(smnpm, SMNPM);
>
> --
> 2.43.7
>
