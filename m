Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F125441037
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330664; cv=pass; b=cH2IQf2Awe9rWeqbja1iRG6yikEZpR2v0A99Gs5rQNfUtsj5OO3wQytnC3Hz3sP3i9b10AT52Ta7N3Y+5/3Jg7dLyvi6VNt0YJhVfteCEco8A0RvwRjou+2NDlXQXKfvYIUXhyzGiWZ+0R7Avv9xG9TSgSkV9Y8e5HJivq+hMfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330664; c=relaxed/simple;
	bh=i6HAqTjIUPRyTQ2G4dQ7dkE3rQX7nqlDjKg58AqrlKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeRof7CcwbL/9Zb26InA1y1SS7SpL6qa0sc4RPjTsvuDb5lXiwSy14iExNe7HBsymj6aC798faGqeH9m+Lsj9/h1mgGs7hy/fjwXcGZrHbE9z3xdhPLc76Bz/2OaUut1WLFVdzpLuG90zYQdSovF5SfI6Tgr8f8xDu/9MIoVs9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=C6F5KJ0w; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="C6F5KJ0w"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47640541585so721952f8f.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 06:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785330659; cv=none;
        d=google.com; s=arc-20260327;
        b=AR7GDjXF8TTWutq6QUHX/jLCP12IUnpS5Rg7Ap25K0yOea7kGm/SObw0/9UKIdWNlI
         tk/sYDjOgV0H2dSegMCV7N8LsiYuDJ73CIf9H+CHOL6mid21TEOiTT9JxO4pelbvRlCy
         ScIXMOkhTZHko+06fGmvu5HCN4/G01uE05cEHaPqUApKocgMxI37b+I2mKdP6mD0PV+w
         sXO73UsQN+diX1gay78vc6IrEyG9W2V9oF1rm2dzUpUpqfBZ/VEiqXE/4xKiGhWCi5ou
         rN/y3UN1gtxGJoZXf2UkTQVxFDyN4oHiEGkHCeyHCUEqckQ2rkfLea+gFHx5fBNoDS6I
         99HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9x3/gz6Awf/XoZ9143h09QEhv/SMox5T2mVccN4dxLg=;
        fh=3JLZwQrbCXvtb//a2JE+bIuumwEB+yl1U3rU8Ob8NZg=;
        b=cFiO0f3sF1spL2UwEjDNtQaqTc0e10/AtwYY7mkSCupZPQRPQ4w/lNUCwbPLe+iyEe
         XBquLIgl2tvRg/uQ2C6nfSRe7g+pP/ZzelmvW7iQZzan8RjB8+tMq5ze8g3GRq1wnFV9
         e/JaC6bAXm2xMOMK4MDOY9vP8SM4osdLlf06osTzP/f3pCQAZrPpIeCe0U5zjdIVCnEQ
         2tWE9n1y5VK/uu2HgVGLedskNwylu4kbGpv2i4eUNx1tRdPVFFQwIjaXNYqUrI/uJzYr
         NGlIi1+LOIv9EISOKMZNSphMmTh+i4R5ROvxuzak3tiRl+oiK0meT+Huc0+cERRqN1Vc
         NoNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785330659; x=1785935459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9x3/gz6Awf/XoZ9143h09QEhv/SMox5T2mVccN4dxLg=;
        b=C6F5KJ0wnDcqJDaygd+KktUN9nJZh5lI45jvVw/4X5/mHprUAOjZOtXR8v2/a4m/Ue
         JP8wBcLXwRPnl08Qs3EJSBpOMZDNKp6UPxuWUHaLPuXDCpOwx7cujiWunltjc6kps89H
         zZ3x6rWIS242YY3S6Lx7FKmgpQt2P+n75e9j1xq4NI570ry+wJJOMtudWB6Y5FQK1/0C
         TmAn+Fuq+GCdjTpwQDbdTCLm/sWP4iy9hfnjbASOHhz4ymrnvqSKepAXcarjcXh4YKky
         EHImDrERcs03wvljAiIVEjGHoqN3gbJkm43mHkMKygzfazp0uaiCy2UZHx7WDMQHKdsH
         RueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330659; x=1785935459;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9x3/gz6Awf/XoZ9143h09QEhv/SMox5T2mVccN4dxLg=;
        b=GPbzwN4a6oEaBO/IcCPp6mXvcEd7MP3Y4WNq1DnBeks0VUnYfUhpPNMyPb6GZhRg5r
         cdSuQPBnxdQCeZW54fATbKZkX5/QzEXiCrh2bhYYu2Emwxau7F65Y1tUsgk62mV56IEy
         /KdUiKuW0Nnx+ULrEsp2F9av9HyUrVgyiJ5Ln568SymgXTJUwSsAqtK7S9wwEAl0egVv
         gGJ1sN6oOucDzsBY8HF+cX5djYIGW7R/gJaGxEr3SA7GXGOdTgJ7TzUdf83cKJVceT4V
         bEaLUvEtV7Y2qjxpXO8hdI79/tzAQTRI/l1SNrVVUyKyzDrhFx3yu5vHb4ZYnmlo1J+O
         XaPA==
X-Forwarded-Encrypted: i=1; AHgh+RrTRjQdUzdPMCZ9V68d/sz1k+sUT8xHBDx8rBNmf9B/KM/1OjsD8qQ49bYLaeg/RorE4sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywns+kIP1T4cnq0e+bGEI5M7TpNrXnuRF+3iFgDX6PrRf0+f0BT
	DdxHRnppl1Z9Pr6N3FI5lxNGDTnALTb76itaP8WriWdku82bC+Tfj3heMgqGbeAd8J5qBpgG7gl
	Z/XnWkStkm8PsiIdqY+GPicbMfCFoK7H2S+W1wwTrRg==
X-Gm-Gg: AR+sD13F8ggQKAv2GHHwg23xrlKUMLdnOA6hK4169kp+Ra0EtqWS322BbuP6/v7AxHT
	EYUy7o1ngQ47+/RKoXvaZiEUL0Dy4g6fZE++fv6efyefqKR/hyJwLTujhoxctVp+IPuSGpOYZUA
	WzHDN4YXDAykw4b9yVZ/KYkqojlE4U5kFXeiu44aochRkGF/WJrfOetTP+EdjvGQzHOXhMD/NHg
	Z6eSh8CpEHJ2N6JOT/7pAwqeKAvlKVZKYJvUtwrKyVwl0w/VvCs4PpqzA71kD7Wu55DFjDePSA0
	7mGs8W8X8mpuZEHBVj//dWLC+AF/BEMyUA2bo2UoPTT1M01hWpk9v5maIZQufocvozN8nkqca07
	bM1nvnkTHhQXe77x2uphWv6UDvFZgj2euKvu8/Jmdx1WW9ppoKN6IPGblhQvW1d4=
X-Received: by 2002:a05:6000:18a3:b0:474:530:9d with SMTP id
 ffacd0b85a97d-47fb1ed94ffmr8909825f8f.13.1785330659285; Wed, 29 Jul 2026
 06:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713010302.303278-1-inochiama@gmail.com> <20260713010302.303278-9-inochiama@gmail.com>
In-Reply-To: <20260713010302.303278-9-inochiama@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 18:40:46 +0530
X-Gm-Features: AUfX_myNiqlbAha1KK8MC_yl8dulLIaxCr6_MgvrGaUHSeOXkgBH7keIZeV2P80
Message-ID: <CAAhSdy3uZOBsBzi10SOiPrnsUokP-KugHcfToyzT9t4rbUiUtw@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] KVM: riscv: selftests: add Zicfiss/Zicfilp
 extension to get-reg-list test
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
> The KVM RISC-V allows Zicfiss/Zicfilp extensions for Guest/VM so
> add these extensions to get-reg-list test.
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
>  .../selftests/kvm/riscv/get-reg-list.c        | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 94e33b2ee796..bf3980e9db12 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -90,6 +90,8 @@ bool filter_reg(__u64 reg)
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZICBOP:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZICBOZ:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZICCRSE:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZICFILP:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZICFISS:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZICNTR:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZICOND:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZICSR:
> @@ -358,6 +360,8 @@ static const char *core_id_to_str(const char *prefix,=
 __u64 id)
>         "KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_REG(" #csr ")"
>  #define RISCV_CSR_SMSTATEEN(csr) \
>         "KVM_REG_RISCV_CSR_SMSTATEEN | KVM_REG_RISCV_CSR_REG(" #csr ")"
> +#define RISCV_CSR_ZICFISS(csr) \
> +       "KVM_REG_RISCV_CSR_ZICFISS | KVM_REG_RISCV_CSR_ZICFISS_REG(" #csr=
 ")"
>
>  static const char *general_csr_id_to_str(__u64 reg_off)
>  {
> @@ -425,6 +429,18 @@ static const char *smstateen_csr_id_to_str(__u64 reg=
_off)
>         return NULL;
>  }
>
> +static const char *zicfiss_csr_id_to_str(__u64 reg_off)
> +{
> +       /* reg_off is the offset into struct kvm_riscv_zicfiss_csr */
> +       switch (reg_off) {
> +       case KVM_REG_RISCV_CSR_ZICFISS_REG(ssp):
> +               return RISCV_CSR_ZICFISS(ssp);
> +       }
> +
> +       TEST_FAIL("Unknown zicfiss csr reg: 0x%llx", reg_off);
> +       return NULL;
> +}
> +
>  static const char *csr_id_to_str(const char *prefix, __u64 id)
>  {
>         __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_CSR);
> @@ -441,6 +457,8 @@ static const char *csr_id_to_str(const char *prefix, =
__u64 id)
>                 return aia_csr_id_to_str(reg_off);
>         case KVM_REG_RISCV_CSR_SMSTATEEN:
>                 return smstateen_csr_id_to_str(reg_off);
> +       case KVM_REG_RISCV_CSR_ZICFISS:
> +               return zicfiss_csr_id_to_str(reg_off);
>         }
>
>         return strdup_printf("%lld | %lld /* UNKNOWN */", reg_subtype, re=
g_off);
> @@ -585,6 +603,8 @@ static const char *isa_ext_single_id_to_str(__u64 reg=
_off)
>                 KVM_ISA_EXT_ARR(ZICBOP),
>                 KVM_ISA_EXT_ARR(ZICBOZ),
>                 KVM_ISA_EXT_ARR(ZICCRSE),
> +               KVM_ISA_EXT_ARR(ZICFILP),
> +               KVM_ISA_EXT_ARR(ZICFISS),
>                 KVM_ISA_EXT_ARR(ZICNTR),
>                 KVM_ISA_EXT_ARR(ZICOND),
>                 KVM_ISA_EXT_ARR(ZICSR),
> @@ -748,6 +768,12 @@ static const char *sbi_fwft_id_to_str(__u64 reg_off)
>         case 6: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_R=
EG(pte_ad_hw_updating.enable)";
>         case 7: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_R=
EG(pte_ad_hw_updating.flags)";
>         case 8: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_R=
EG(pte_ad_hw_updating.value)";
> +       case 9: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_R=
EG(landing_pad.enable)";
> +       case 10: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_=
REG(landing_pad.flags)";
> +       case 11: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_=
REG(landing_pad.value)";
> +       case 12: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_=
REG(shadow_stack.enable)";
> +       case 13: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_=
REG(shadow_stack.flags)";
> +       case 14: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_=
REG(shadow_stack.value)";
>         }
>         return strdup_printf("KVM_REG_RISCV_SBI_FWFT | %lld /* UNKNOWN */=
", reg_off);
>  }
> @@ -954,6 +980,20 @@ static __u64 sbi_fwft_pte_ad_hw_updating_regs[] =3D =
{
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.value)=
,
>  };
>
> +static __u64 sbi_fwft_landing_pad_regs[] =3D {
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_=
REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT,
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.enable),
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.flags),
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.value),
> +};
> +
> +static __u64 sbi_fwft_shadow_stack_regs[] =3D {
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_=
REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT,
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.enable),
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.flags),
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KV=
M_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.value),
> +};
> +
>  static __u64 zicbom_regs[] =3D {
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_R=
EG_RISCV_CONFIG_REG(zicbom_block_size),
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOM,
> @@ -969,6 +1009,11 @@ static __u64 zicboz_regs[] =3D {
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOZ,
>  };
>
> +static __u64 zicfiss_regs[] =3D {
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_=
RISCV_CSR_ZICFISS | KVM_REG_RISCV_CSR_ZICFISS_REG(ssp),
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICFISS,
> +};
> +
>  static __u64 aia_regs[] =3D {
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_=
RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect),
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_=
RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1),
> @@ -1220,6 +1265,8 @@ KVM_ISA_EXT_SUBLIST_CONFIG(zicbom, ZICBOM);
>  KVM_ISA_EXT_SUBLIST_CONFIG(zicbop, ZICBOP);
>  KVM_ISA_EXT_SUBLIST_CONFIG(zicboz, ZICBOZ);
>  KVM_ISA_EXT_SIMPLE_CONFIG(ziccrse, ZICCRSE);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zicfilp, ZICFILP);
> +KVM_ISA_EXT_SUBLIST_CONFIG(zicfiss, ZICFISS);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zicntr, ZICNTR);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zicond, ZICOND);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zicsr, ZICSR);
> @@ -1279,6 +1326,24 @@ static struct vcpu_reg_list config_sbi_fwft_pte_ad=
_hw_updating =3D {
>         },
>  };
>
> +static struct vcpu_reg_list config_sbi_fwft_landing_pad =3D {
> +       .sublists =3D {
> +               SUBLIST_BASE,
> +               SUBLIST_ISA(zicfilp, ZICFILP),
> +               SUBLIST_SBI(fwft_landing_pad, FWFT),
> +               {0},
> +       },
> +};
> +
> +static struct vcpu_reg_list config_sbi_fwft_shadow_stack =3D {
> +       .sublists =3D {
> +               SUBLIST_BASE,
> +               SUBLIST_ISA(zicfiss, ZICFISS),
> +               SUBLIST_SBI(fwft_shadow_stack, FWFT),
> +               {0},
> +       },
> +};
> +
>  struct vcpu_reg_list *vcpu_configs[] =3D {
>         &config_sbi_base,
>         &config_sbi_sta,
> @@ -1289,6 +1354,8 @@ struct vcpu_reg_list *vcpu_configs[] =3D {
>         &config_sbi_fwft_misaligned_deleg,
>         &config_sbi_fwft_pointer_masking,
>         &config_sbi_fwft_pte_ad_hw_updating,
> +       &config_sbi_fwft_landing_pad,
> +       &config_sbi_fwft_shadow_stack,
>         &config_aia,
>         &config_fp_f,
>         &config_fp_d,
> @@ -1332,6 +1399,8 @@ struct vcpu_reg_list *vcpu_configs[] =3D {
>         &config_zicbop,
>         &config_zicboz,
>         &config_ziccrse,
> +       &config_zicfilp,
> +       &config_zicfiss,
>         &config_zicntr,
>         &config_zicond,
>         &config_zicsr,
> --
> 2.55.0
>
