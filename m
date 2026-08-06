Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9A2248BE
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019946; cv=none; b=Ptq39xKN+uOi1g3ZtuArCpeXD7oLLBWNXD4xu/8P/qooeLzvOgUC9NZ/wXsqaHUjgzw4gV6BkgvDRZdA4owUqiKQ6ivpkBN2yo1gVfl5qPx9p7kBXBSZCTzHoGWdxCaiJKjLdZ+5BqiD06H3eUD3Py+ctIjmRtAamhFU9bG25No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019946; c=relaxed/simple;
	bh=BqV15x6vu4Q2f5LzS6NZT09VzzZvGF8kWgNWZqDcwew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/fwYzBbKqE0BcxpMFajCI+7YTZeoi5GLh9Wc0WV9w5lCg+hcF4tpBdjqrtU2CNQZtKV9J7MI2rylAYSVl0YtrTX7bdwhRzz6kFjBsx+ro2z0nCBI+wrvUNqiqNCWhsbCUsDJXKo4nGaIRPeC8aV2bg/vWbWWOLyuORBQPrth18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=behTB2t5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="behTB2t5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AFC1F00AC4
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019944;
	bh=2vS3qOhEvUKhNLFGQtuxwqpkMA9igZqCrUwfBBq5lzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=behTB2t5WkzZpDM2vBDoGYE90PMvR3bh9tySrIHcgQ1Sk9bR57CcMdX1snrtpBY5g
	 iOHPmMWIuSq3W4qeef2DY8B9s1NpmjjQuyZsO4WailRwx0EOlhnM/9sqGdmzYuKv9p
	 MfERWoIjY+xdyPuRjKXYae/ifeSSEfzEF0uBUeA8yNusX8B92Cz4V7kpBcUCL9nVYS
	 1PQZYysIzBHvWBvt+f38IglU/lG7b5KFNGgUct6K4rr9NCTps3VBQt0lATbbBF9O2k
	 vrIvkkkrF4sntYmo30C3oI9DT2xc3CjbFeAimRWUcDTMVew1P5O7a0pDlquhh0ccH5
	 344Uty0Wv4lmQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a144c8eea2so2948500a12.0
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 05:39:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoDzukUkUqAibGF1qXXnPFYq+Dtvg0c23EBtekuh8X9gzlALWo8B4RJZa42B5p4C7LDox0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj0fb17hhxkJiXCbXy6s1stgAogYO66cyXQA/cDtW2V9k0vJWm
	pXVk+DvEmE1azenzvXN6L5CMA3Q3l9qk/Of6qzuh+xj4sViDRGwJc3xUCXIf9MOqtXQOe0XOwNr
	xBDQ2yyyMc7jfTmfN5M+iJ7V8ZCxvqdw=
X-Received: by 2002:a05:6402:3222:b0:69c:72e2:a3d9 with SMTP id
 4fb4d7f45d1cf-6a14f26c0f4mr8117939a12.21.1786019942971; Thu, 06 Aug 2026
 05:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020739.2149268-1-maobibo@loongson.cn> <20260806020739.2149268-6-maobibo@loongson.cn>
In-Reply-To: <20260806020739.2149268-6-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 6 Aug 2026 20:39:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6cTtqzCGfr5aZNgpPBpG1YLkmZ9axq45ViAf2_x69fjg@mail.gmail.com>
X-Gm-Features: AUfX_mwEdiLE7YKW7xuVLNV25NqOMrismXeRJ7LJqpnjb63snPcwDtc-huE5Oys
Message-ID: <CAAhV-H6cTtqzCGfr5aZNgpPBpG1YLkmZ9axq45ViAf2_x69fjg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] LoongArch: KVM: Enable separate vmid feature
To: Bibo Mao <maobibo@loongson.cn>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	WANG Xuerui <kernel@xen0n.name>, Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Thu, Aug 6, 2026 at 10:15=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> With CSR GTLBC shortname for Guest TLB Control Register, separate vmid
> feature will be enabled if bit 14 CSR_GTLBC_USEVMID is set. Enable
> this feature if cpu_has_guestid is true when LVZ is enabled and the LVZ
> version is 2.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/loongarch.h | 5 +++++
>  arch/loongarch/kernel/cpu-probe.c      | 6 ++++++
>  arch/loongarch/kvm/main.c              | 4 +++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/incl=
ude/asm/loongarch.h
> index 2a6bc99177d8..a20fb68d8ac4 100644
> --- a/arch/loongarch/include/asm/loongarch.h
> +++ b/arch/loongarch/include/asm/loongarch.h
> @@ -138,6 +138,9 @@
>  #define  CPUCFG6_PMBITS_SHIFT          8
>  #define  CPUCFG6_UPM                   BIT(14)
>
> +#define LOONGARCH_CPUCFG8              0x8
> +#define  CPUCFG8_VMID                  BIT(8)
> +
>  #define LOONGARCH_CPUCFG16             0x10
>  #define  CPUCFG16_L1_IUPRE             BIT(0)
>  #define  CPUCFG16_L1_IUUNIFY           BIT(1)
> @@ -350,6 +353,8 @@
>  #define  CSR_GTLBC_TGID_WIDTH          8
>  #define  CSR_GTLBC_TGID_SHIFT_END      (CSR_GTLBC_TGID_SHIFT + CSR_GTLBC=
_TGID_WIDTH - 1)
>  #define  CSR_GTLBC_TGID                        (_ULCAST_(0xff) << CSR_GT=
LBC_TGID_SHIFT)
> +#define  CSR_GTLBC_USEVMID_SHIFT       14
> +#define  CSR_GTLBC_USEVMID             (_ULCAST_(0x1) << CSR_GTLBC_USEVM=
ID_SHIFT)

Other fields in GTLBC is TGID, so it is better to name it
CSR_GTLBC_USETGID, just use vpid/vmid for software purely.



Huacai

>  #define  CSR_GTLBC_TOTI_SHIFT          13
>  #define  CSR_GTLBC_TOTI                        (_ULCAST_(0x1) << CSR_GTL=
BC_TOTI_SHIFT)
>  #define  CSR_GTLBC_USETGID_SHIFT       12
> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cp=
u-probe.c
> index 74d31f260dfd..fc68f695d49c 100644
> --- a/arch/loongarch/kernel/cpu-probe.c
> +++ b/arch/loongarch/kernel/cpu-probe.c
> @@ -241,6 +241,12 @@ static void cpu_probe_common(struct cpuinfo_loongarc=
h *c)
>         if (config & CPUCFG6_PMP)
>                 c->options |=3D LOONGARCH_CPU_PMP;
>
> +       if (c->options & LOONGARCH_CPU_LVZ) {
> +               config =3D read_cpucfg(LOONGARCH_CPUCFG8);
> +               if (config & CPUCFG8_VMID)
> +                       c->options |=3D LOONGARCH_CPU_GUESTID;
> +       }
> +
>         config =3D csr_read32(LOONGARCH_CSR_ASID);
>         config =3D (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
>         asid_mask =3D GENMASK(config - 1, 0);
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 72c1d23156e5..712b078db0d5 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -359,7 +359,7 @@ int kvm_arch_enable_virtualization_cpu(void)
>         write_csr_gcfg(0);
>         write_csr_gstat(0);
>         write_csr_gintc(0);
> -       clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
> +       clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI | CSR_GTLBC_US=
EVMID);
>
>         /*
>          * Enable virtualization features granting guest direct control o=
f
> @@ -382,6 +382,8 @@ int kvm_arch_enable_virtualization_cpu(void)
>
>         /* Enable using TGID  */
>         set_csr_gtlbc(CSR_GTLBC_USETGID);
> +       if (cpu_has_guestid)
> +               set_csr_gtlbc(CSR_GTLBC_USEVMID);
>         kvm_debug("GCFG:%lx GSTAT:%lx GINTC:%lx GTLBC:%lx",
>                   read_csr_gcfg(), read_csr_gstat(), read_csr_gintc(), re=
ad_csr_gtlbc());
>
> --
> 2.39.3
>
