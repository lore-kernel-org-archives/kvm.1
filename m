Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725BA3932D3
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680097; cv=none; b=rclPstQVV5pT4Uc2JrtKLklJt6S5lUsO8nwIVaj/GJZTrpKlIw104infSTsyT7Xi+Z2eLvXy/8NcwMn9/PFY3LrWsApCNDjwe2LOHwbl2u4Y0CQjcLq1O0ycBa5yW80RQP+ZO37K6XQtSY7e6D1dgjJejDZZzZw1IctIriYjupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680097; c=relaxed/simple;
	bh=36sYYGmi2L0ttT4WP8x7mYocG1QAtHKVbrZFranyit8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPELEUbrsGQlg4b4tofk8wzUnYmsBHpxRYG8FQ0xE54omd8so2LqQhCFOGUpkz8As2bt+su4/ZkvWh2n3D9lFcfQ70+OuKrd5c0csJT8oOJjMyosr/JSD4VAjGSgprB/zahm8YHLVRI8glemhIkkvvvxD4AKYqlW15NC2hJy2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY5NJac3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY5NJac3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C6F1F00A3A
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680096;
	bh=dUPCGYsHCPmgHH2jd59BEWjcGEGmNCjzIozfSkEI2Yc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DY5NJac3NeMZ5fU1MGjrbJBC93CsgNcXDNAH30j/oj7L2Xw+48axgVew6hY9UL1M5
	 YVG8bnXYtpUiWq3Q10RtasYiW+KFJIU1CzLjZ1pcdP2+F1wXc6qs34llg77RKEDtZD
	 G5bIfThJNEFVMcvwuBJ815SWhpSfHxL5eBYrJaZkSvP0JW8pxw/JOsEbY9/TrFzBcN
	 /hSAHiP3FKgFR45hemJnvVYdRNrS+WBG1n3VYWFM3F5Wm8ruNKCxj4clneU9Jxs/Az
	 ZzdVfwpt9uC1qb2pjZX52+CVIztiX1+imf3+In4Vrb0Dcc+A6ePLiSD8U5rdzTrRJ8
	 x4i7KjKJUu//Q==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so3931518a12.1
        for <kvm@vger.kernel.org>; Sun, 02 Aug 2026 07:14:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrc2SHGJ1e8oOpyAWwGRQLpoGVE6x7Ld9dbLf3QjmCjbg4xtDx/upqhPxIrondIO5DUaHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXW2ScPX5GYCEOUfCZG9wSMCSQRS464cBAtZoPAxe69ow3iV63
	3MfjvJOPlRAm6C7SPLeEe3KHZZ1JG/PB18OFJaEzNxbAKVlLRh6m4jZaO/fkmnqd+ZiIAws3ivs
	22Hw38xFty2OnTQ3W6TY+XyLk1KT/3BU=
X-Received: by 2002:a05:6402:400e:b0:698:ae69:3992 with SMTP id
 4fb4d7f45d1cf-6a0a7cb2408mr4834745a12.16.1785680094992; Sun, 02 Aug 2026
 07:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727072109.2151675-1-maobibo@loongson.cn> <20260727072109.2151675-7-maobibo@loongson.cn>
In-Reply-To: <20260727072109.2151675-7-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 2 Aug 2026 22:14:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H46JoQpPx4Eg1eGT010Gq_4OnLNExhVrgjkdXkeoHESCA@mail.gmail.com>
X-Gm-Features: AUfX_myzeQx5PaO8rHmAyAUfTju87FU8MUBsp72TmRfHJhN7cPfNdFRXOqjhdEA
Message-ID: <CAAhV-H46JoQpPx4Eg1eGT010Gq_4OnLNExhVrgjkdXkeoHESCA@mail.gmail.com>
Subject: Re: [PATCH 6/6] LoongArch: KVM: Enable separate vmid feature
To: Bibo Mao <maobibo@loongson.cn>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	WANG Xuerui <kernel@xen0n.name>, Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Mon, Jul 27, 2026 at 3:31=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> With CSR GTLBC shortname for Guest TLB Control Register, separate vmid
> feature will be enabled if bit 14 CSR_GTLBC_USEVMID is set. Enable
> this feature if cpu_has_guestid is true when LVZ is enabled and the LVZ
> version is 2.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/loongarch.h | 2 ++
>  arch/loongarch/kernel/cpu-probe.c      | 7 ++++++-
>  arch/loongarch/kvm/main.c              | 4 +++-
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/incl=
ude/asm/loongarch.h
> index 2a6bc99177d8..4c4249446a61 100644
> --- a/arch/loongarch/include/asm/loongarch.h
> +++ b/arch/loongarch/include/asm/loongarch.h
> @@ -350,6 +350,8 @@
>  #define  CSR_GTLBC_TGID_WIDTH          8
>  #define  CSR_GTLBC_TGID_SHIFT_END      (CSR_GTLBC_TGID_SHIFT + CSR_GTLBC=
_TGID_WIDTH - 1)
>  #define  CSR_GTLBC_TGID                        (_ULCAST_(0xff) << CSR_GT=
LBC_TGID_SHIFT)
> +#define  CSR_GTLBC_USEVMID_SHIFT       14
> +#define  CSR_GTLBC_USEVMID             (_ULCAST_(0x1) << CSR_GTLBC_USEVM=
ID_SHIFT)
>  #define  CSR_GTLBC_TOTI_SHIFT          13
>  #define  CSR_GTLBC_TOTI                        (_ULCAST_(0x1) << CSR_GTL=
BC_TOTI_SHIFT)
>  #define  CSR_GTLBC_USETGID_SHIFT       12
> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cp=
u-probe.c
> index 74d31f260dfd..cbf1dafac0a0 100644
> --- a/arch/loongarch/kernel/cpu-probe.c
> +++ b/arch/loongarch/kernel/cpu-probe.c
> @@ -135,7 +135,7 @@ static void set_isa(struct cpuinfo_loongarch *c, unsi=
gned int isa)
>
>  static void cpu_probe_common(struct cpuinfo_loongarch *c)
>  {
> -       unsigned int config;
> +       unsigned int config, version;
>         unsigned long asid_mask;
>
>         c->options =3D LOONGARCH_CPU_CPUCFG | LOONGARCH_CPU_CSR | LOONGAR=
CH_CPU_VINT;
> @@ -221,6 +221,11 @@ static void cpu_probe_common(struct cpuinfo_loongarc=
h *c)
>         if (config & CPUCFG2_LVZP) {
>                 c->options |=3D LOONGARCH_CPU_LVZ;
>                 elf_hwcap |=3D HWCAP_LOONGARCH_LVZ;
> +
> +               /* Separate VMID and VPID with LVZ version =3D=3D 2 */
> +               version =3D (config & CPUCFG2_LVZVER) >> 11;
> +               if (version =3D=3D 2)
I think ">1" judgement is better than "=3D=3D2".


Huacai

> +                       c->options |=3D LOONGARCH_CPU_GUESTID;
>         }
>  #ifdef CONFIG_CPU_HAS_LBT
>         if (config & CPUCFG2_X86BT) {
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 86b1af823e2b..43f5b40786f2 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -365,7 +365,7 @@ int kvm_arch_enable_virtualization_cpu(void)
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
> @@ -388,6 +388,8 @@ int kvm_arch_enable_virtualization_cpu(void)
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
>
