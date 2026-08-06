Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637002F5313
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021417; cv=none; b=uf6Acfimc2lbI0PfBd1UaEYC3CK32Qv6A58HHjtjqEbSla+JCos7sB7bA0PIBiATMSbQ+tkmKxrkZGTRWpqgMxFV51UcpZQRt/eHqAp+HNSkHVybOmVaS0EgbudZXGtAgJH+ZhWP0AMo748EslomxYyO9a4xseUUAfU9j8JysYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021417; c=relaxed/simple;
	bh=4A7aKQSDveq6QTmgYRdz90FxxB1u5FcMkc4PBkljdcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESAwXSUwCIm+/10tgEsfGf8kxfYtj1TOQLquRxuyPvodn20ufbfrat39uN4ajBYH57jidJaLCPnI/VxW/UD29RZPKHJ1dNtjnd2dUY/stcHUk7iVvn3eYpAE0vrBQ6ThH2GmAvWbrLZ/DhQkHxNKIOy1rhfhWkVcaqbsFwJGq9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hw0Y781V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hw0Y781V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A621F00A3A
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 13:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021408;
	bh=pQu1LyILaJ/us2VXdLm2kasN4/J6WTQSR9PhxSs27vE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hw0Y781V6yJU7hlklAs2D2rZaqvltmb5wXtfgGCx/Wn/BAAOYWBmVTPKG7OzjC0vb
	 du/SwT4kJa8hSX0gk21ZlsV3iOj1VwdpOEWMi0whanjCPWRFdEL0tBwn9SRjuYBuRM
	 ILRHpiBARBn0V0UVoeuqnRTg2gLWrVX92pBvTWhGz3l9sffLxidmGA80LEKcfPEDTI
	 fHgbC/WBQ7ev+JhVlrYvqdZ2gPyBvQIlcOMVwW06p3P1cTg0ZzjY8oYYAeYIiK8ohM
	 TAOS032l9/FPlrcg9M+rowKQbWg+T7Yp6Yl0xeSTJEC9xZHqsbXP2wtZ9aoS/0bl0q
	 Z+w2kn7PoyGUw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a17211b9ecso2848296a12.2
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 06:03:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrnbWVjJLM2uQtsNevS+dEHBgRNGPt2/zK6Yix+9NuG3CR7W1eu1xe+cH10Av1Fj+gsU08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8xKSfJigfJlmymRmNBWTbUdv/krtiqXyHVmQ0BDueN8KLw1AJ
	N2WXgKYKF6cLbMfS5V+WigQr/W9u3JvLgaVWl3ywgyF7WjVNhdPW1wWxebIHwyNXX//bLY5ZyMe
	IGhJEqXUn2msOIqZS4nyYGyaqmPofQEQ=
X-Received: by 2002:a05:6402:551b:b0:6a0:7a06:3031 with SMTP id
 4fb4d7f45d1cf-6a14f0a151cmr7985904a12.3.1786021406986; Thu, 06 Aug 2026
 06:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020739.2149268-1-maobibo@loongson.cn> <20260806020739.2149268-6-maobibo@loongson.cn>
 <CAAhV-H6cTtqzCGfr5aZNgpPBpG1YLkmZ9axq45ViAf2_x69fjg@mail.gmail.com> <ae64693c-0c99-9de9-c4d9-ed5ab6e55506@loongson.cn>
In-Reply-To: <ae64693c-0c99-9de9-c4d9-ed5ab6e55506@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 6 Aug 2026 21:03:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H72fu7_WysWr1XWbFUbnw2cwcCUMgT1AZGnABpAgAd6xg@mail.gmail.com>
X-Gm-Features: AUfX_myJGGL7r3AsAvPy_KItZXNkXqhtkpNw3bbC-QYt6qiKg-oqZypyk-UApks
Message-ID: <CAAhV-H72fu7_WysWr1XWbFUbnw2cwcCUMgT1AZGnABpAgAd6xg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] LoongArch: KVM: Enable separate vmid feature
To: Bibo Mao <maobibo@loongson.cn>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	WANG Xuerui <kernel@xen0n.name>, Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 8:55=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2026/8/6 =E4=B8=8B=E5=8D=888:39, Huacai Chen wrote:
> > Hi, Bibo,
> >
> > On Thu, Aug 6, 2026 at 10:15=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> =
wrote:
> >>
> >> With CSR GTLBC shortname for Guest TLB Control Register, separate vmid
> >> feature will be enabled if bit 14 CSR_GTLBC_USEVMID is set. Enable
> >> this feature if cpu_has_guestid is true when LVZ is enabled and the LV=
Z
> >> version is 2.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   arch/loongarch/include/asm/loongarch.h | 5 +++++
> >>   arch/loongarch/kernel/cpu-probe.c      | 6 ++++++
> >>   arch/loongarch/kvm/main.c              | 4 +++-
> >>   3 files changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/i=
nclude/asm/loongarch.h
> >> index 2a6bc99177d8..a20fb68d8ac4 100644
> >> --- a/arch/loongarch/include/asm/loongarch.h
> >> +++ b/arch/loongarch/include/asm/loongarch.h
> >> @@ -138,6 +138,9 @@
> >>   #define  CPUCFG6_PMBITS_SHIFT          8
> >>   #define  CPUCFG6_UPM                   BIT(14)
> >>
> >> +#define LOONGARCH_CPUCFG8              0x8
> >> +#define  CPUCFG8_VMID                  BIT(8)
> >> +
> >>   #define LOONGARCH_CPUCFG16             0x10
> >>   #define  CPUCFG16_L1_IUPRE             BIT(0)
> >>   #define  CPUCFG16_L1_IUUNIFY           BIT(1)
> >> @@ -350,6 +353,8 @@
> >>   #define  CSR_GTLBC_TGID_WIDTH          8
> >>   #define  CSR_GTLBC_TGID_SHIFT_END      (CSR_GTLBC_TGID_SHIFT + CSR_G=
TLBC_TGID_WIDTH - 1)
> >>   #define  CSR_GTLBC_TGID                        (_ULCAST_(0xff) << CS=
R_GTLBC_TGID_SHIFT)
> >> +#define  CSR_GTLBC_USEVMID_SHIFT       14
> >> +#define  CSR_GTLBC_USEVMID             (_ULCAST_(0x1) << CSR_GTLBC_US=
EVMID_SHIFT)
> >
> > Other fields in GTLBC is TGID, so it is better to name it
> > CSR_GTLBC_USETGID, just use vpid/vmid for software purely.
>   - clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
>   + clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI | CSR_GTLBC_USEVMI=
D);
>
> There is CSR_GTLBC_USETGID enabled already which it bit 12 :)
Emmm, what is the difference between bit 12 and bit 14?

Huacai

>
> >
> >
> >
> > Huacai
> >
> >>   #define  CSR_GTLBC_TOTI_SHIFT          13
> >>   #define  CSR_GTLBC_TOTI                        (_ULCAST_(0x1) << CSR=
_GTLBC_TOTI_SHIFT)
> >>   #define  CSR_GTLBC_USETGID_SHIFT       12
> >> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel=
/cpu-probe.c
> >> index 74d31f260dfd..fc68f695d49c 100644
> >> --- a/arch/loongarch/kernel/cpu-probe.c
> >> +++ b/arch/loongarch/kernel/cpu-probe.c
> >> @@ -241,6 +241,12 @@ static void cpu_probe_common(struct cpuinfo_loong=
arch *c)
> >>          if (config & CPUCFG6_PMP)
> >>                  c->options |=3D LOONGARCH_CPU_PMP;
> >>
> >> +       if (c->options & LOONGARCH_CPU_LVZ) {
> >> +               config =3D read_cpucfg(LOONGARCH_CPUCFG8);
> >> +               if (config & CPUCFG8_VMID)
> >> +                       c->options |=3D LOONGARCH_CPU_GUESTID;
> >> +       }
> >> +
> >>          config =3D csr_read32(LOONGARCH_CSR_ASID);
> >>          config =3D (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
> >>          asid_mask =3D GENMASK(config - 1, 0);
> >> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> >> index 72c1d23156e5..712b078db0d5 100644
> >> --- a/arch/loongarch/kvm/main.c
> >> +++ b/arch/loongarch/kvm/main.c
> >> @@ -359,7 +359,7 @@ int kvm_arch_enable_virtualization_cpu(void)
> >>          write_csr_gcfg(0);
> >>          write_csr_gstat(0);
> >>          write_csr_gintc(0);
> >> -       clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
> >> +       clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI | CSR_GTLBC=
_USEVMID);
> >>
> >>          /*
> >>           * Enable virtualization features granting guest direct contr=
ol of
> >> @@ -382,6 +382,8 @@ int kvm_arch_enable_virtualization_cpu(void)
> >>
> >>          /* Enable using TGID  */
> >>          set_csr_gtlbc(CSR_GTLBC_USETGID);
> >> +       if (cpu_has_guestid)
> >> +               set_csr_gtlbc(CSR_GTLBC_USEVMID);
> >>          kvm_debug("GCFG:%lx GSTAT:%lx GINTC:%lx GTLBC:%lx",
> >>                    read_csr_gcfg(), read_csr_gstat(), read_csr_gintc()=
, read_csr_gtlbc());
> >>
> >> --
> >> 2.39.3
> >>
>
