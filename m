Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D9328C869
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101766; cv=pass; b=VHC7aLsy7Mk4NP6qH3NSHgs02inaRb5l+rXPwxVFSFmwHd4BI4BtEu3gcSfUBhvLDVjzJlE9cB0EYLP7yJmfZsoFzjRIxhOVlCKks6lvDBp5/5xG3UATBmGdqUhJ04Qpwfs0Ob4iKS5Mivk61GXXuZGoJ9WzEJEaBKJPgGu7uOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101766; c=relaxed/simple;
	bh=/5hCjxhlblu/dDXbaNzug8TLexppU7uEC3A76MTRqK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzCmP4BaV4Ckq1wVC3Y63232NAqkN1je7Uaf9vMgXOrFNM8GERTHVrDDjMgaXqXFCCIP63vdCPTiyAPToKcqW77TFLikZcZMg2nJr4D1+o7j6WbFwIfmVfgXo9qzZKwBFIVQmldGzcP37CUhfVP+RjjwFHhDLNwpOFfRuXXDLLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=ndRGDEmc; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ndRGDEmc"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66051672451so1182331d50.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780101760; cv=none;
        d=google.com; s=arc-20240605;
        b=E/03jRUnaMUteO062WH0XBLkmEq3GOeEEBE+vOn0kGfRAyWqF8GisrFDVReHe2Tlnx
         hszSIVMPSJ3/Uyw0Qwnq1wFMdxOeqar9k6RL8OkqwplmPgvHlguNF/SwQN9eosGx1EX3
         UMuDA8kLN9kjPde3MIlFrw3BGuioVPZNuW1NOpZ1udrEir37uDBxvG3w4U8XMFwyXSob
         10E1fT4nh0peO2fgB/J6WSbJLbciyXiYnNkFoP2QwHKzBE3Zv4dAEgMufeqf6Y5MliPr
         44hr9RYbx+SakeSTW9weuauVGSvq4qlhtyglqwNMZlyhsybvoxQrLMpKaAezGruwLAfz
         hDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9C6pC6G8jgQw8SEpFdd3tqY/qCEk2540e42V0ZevSno=;
        fh=eaekqUMLhblk2HnCblkN6BSp5uB+xREUL3gyTwFqB28=;
        b=N72PpXL0UMQr3kN3QIBwXfsWpAlrY9xRcdyvfxg8ISQmF+GwqOK68KorH+49GZ1ahg
         /IeSQiX62EzpDvdweGbal7bqiybjymFV2f76qMS+Rez2lOVpl2fuC0WPGGyEA1QWdH3r
         xbquXekXLgGcvQMzLOVy6u20m8bOqmCKkcSt7WPgAMkSqBEzBjuxgXykTD5QazQ9WSey
         kntdMWmMQnri7+Skp3oXMa+/He/x+JJcp4ir/x/iVDqx8WUsmVmY79MOUEkIY7LzmEoU
         JbQIXpSIcQQ6zqO8Yv8Wt1WaUzf3n0romLK1OgPMV0JMCBqILcyjYMr9n1XgtUiFPzVr
         UyOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780101760; x=1780706560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C6pC6G8jgQw8SEpFdd3tqY/qCEk2540e42V0ZevSno=;
        b=ndRGDEmcMS8m1gf3t/4lh9/7t0pDux+9viZ7kJ9bR+EDtuJsSFFFiksxQFI3uz/o8G
         f3HTIQtrcHjQpIffkMhhnDIAqB7wRdUt5KWK40x/lEoTnKAAz3gJ7H8HQRTV5vfkMqfx
         gcekgRx19xcqJ2N63kUWmX3P+GFGz1wVQvqx0pcJmcau8pJugYlX1A847j/WZYqj3RDD
         K3C68TKvSY7gJibeJXjzm2w5muAZ4FpxgiEtYOqn9lG6DngLmcKf5EPqpKAWhFQWuqX4
         NXWbp21Ya5vjsx4JPP0TrdoFR1DOINmf/SdyQSEA9Qz0iQh/dTP1kwXC/UeHWjHNJghu
         4X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780101760; x=1780706560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9C6pC6G8jgQw8SEpFdd3tqY/qCEk2540e42V0ZevSno=;
        b=s/shqB6ocXk8w7xLUe9NR3N2+fhuAz20ry9XPI2+2Jp1UIR6W1ll8JL0I23EqXqoAv
         dE59x9XDcwLcKngVydsrmwwdS4fBwI0n/SAVcg9QJgHyZbx3pzhJsl0kT4pSfc4byGZ/
         cgSoHnS49Ibdxhh3CBce45PmhKii6n78FqbhERENOEahOsKne0EH7SWdFqNVtqABGDDL
         lGne1JJg6BL0gsv5r3xU3aI/seXP7yVlV+eh37chhhnX6VfPA1J8vmDsWPlBmsYJzTdG
         FUxQi/sJUzaMeNfBc1AhuTJQv3jf4iJPMwV6xswxgntqqSDFF6REXSdnPA2ATwmV4oAo
         kSOg==
X-Forwarded-Encrypted: i=1; AFNElJ9u/vRoAFWTbBhpIQ0XemVnrb6dQ1qQGpu3ybm6Srck4Z6umalAIefKQy1/dFH1WldMCOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynV/nMs+pIEIsrgbNXR87R2h69MKWrrkz3e+7xLZZsQGfexWlq
	yiRySXhsp06GQULA27mGiYz0mG5n4vbw8Gqfycnx57Yp79hAicks2ac20dxnGfrntFrJewCSxZ6
	Hx9XxSEqZpJ3xlX11UxvC8gkAN2+iQWBxpTnur40rFQ==
X-Gm-Gg: Acq92OETIGhRZxz/1XDhsEcFExwvIKfrzd7wL3Wj/ui0TRR3Uo/OZQwJpY/XUzRbB1K
	/tNqqmkpRd6alUzcdGJ7trWnnjR+reqEI69hHWdvZwTu9bj6vLrEIqRGiFQaIi/DuI8CWbi/np2
	gv7kxRemZ/ZYZUxtB3Mx+iJLDciJM8Z6E/5U+f73GmX7FsLbtGKTwYEQ5WdkZ0rRIh1NF/s6e0x
	S5VuzlwXirmGYcFeAH0Y5Ei2oItNtg3f7+fNLIk+gjqyYloPjG9ayvbyT1C85T9E3yV+A2Gfwcq
	ZwGqOW9H6RMKhbc8qh+6vA60w+0YQ5pZv00b0XB3hdxn5Z5oUqFCWdcdwnipRXg4+qM=
X-Received: by 2002:a05:690c:480b:b0:7bd:9566:ef0c with SMTP id
 00721157ae682-7e05ea4cc3cmr16766257b3.26.1780101760314; Fri, 29 May 2026
 17:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com>
 <20260511-rva23u64-hwprobe-v2-v2-8-21c5a544f1dc@riscstar.com> <5tjmypgyxbhgxfjub5q6ne475uysse6yl473sxisjoammkdvbu@yebejqbiy6e3>
In-Reply-To: <5tjmypgyxbhgxfjub5q6ne475uysse6yl473sxisjoammkdvbu@yebejqbiy6e3>
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 30 May 2026 08:42:29 +0800
X-Gm-Features: AVHnY4L-oTZDn7xRb_-W1DfskfLnWnQK7ds7jlg7EeJxNaRDPoWxDaghmy3erNI
Message-ID: <CAH1PCMa-5W9PsX8cDLUk6-MkcM53HOz2QtaxCHd+XOr7DgH5+w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] riscv: cpufeature: Introduce ISA bases bitmap
 and rva23u64 detection
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	Deepak Gupta <debug@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
	Christian Brauner <brauner@kernel.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, Guodong Xu <docularxu@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Drew

On Thu, May 28, 2026 at 12:35=E2=80=AFAM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> On Mon, May 11, 2026 at 09:34:53PM -0400, Guodong Xu wrote:
> > Introduce a per-hart and host-wide bitmap of conformant ISA "bases" --
> > named profile-class sets such as IMA and RVA23U64 -- and compute
> > both at init time.
> >
> > This is the cache that subsequent consumers (hwprobe's
> > RVA23U64 base behavior bit, /proc/cpuinfo's "isa bases" lines, etc.)
> > read without recomputing.
> >
> > riscv_init_isa_bases() iterates over all possible cpus to populate
> > each hart_isa[cpu].isa_bases, then computes the host-wide
> > riscv_isa_bases against the AND-across-harts riscv_isa bitmap.  It is
> > registered as a subsys_initcall so it executes after
> > core_initcall(tagged_addr_init), which probes senvcfg.PMM and
> > populates have_user_pmlen_*.  Without that ordering,
> > riscv_have_user_pmlen(7) would still return its default false and the
> > RVA23U64 detection path would always bail.
> >
> > The detection itself is encapsulated in riscv_set_isa_bases(), which
> > takes an output bases bitmap and an input ISA bitmap.
> >
> > Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> > v2:
> > - Implement riscv_init_isa_bases() that runs at system init time,
> >   after tagged_addr_init() populates have_user_pmlen_*.
> > - Split RVA23S64 placeholder into a future patch.
> > ---
> >  arch/riscv/include/asm/cpufeature.h | 14 ++++++
> >  arch/riscv/kernel/cpufeature.c      | 92 +++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 106 insertions(+)
>
> Sashiko points out a few things about this patch which I think I
> agree with
>
> https://sashiko.dev/#/patchset/20260511-rva23u64-hwprobe-v2-v2-0-21c5a544=
f1dc%40riscstar.com?part=3D8

Quote the following from Sashiko.dev:
> Should this mask specify the individual subset extensions required by the
> profile instead of the superset extensions like RISCV_ISA_EXT_B,
> RISCV_ISA_EXT_C, and RISCV_ISA_EXT_V?

My preference is to leave the mask on B/C/V (and A) as-is. I'd prefer to
keep matching on the single-letter, rather than expanding them. Here is why=
:

- The RVA23 profile lists A, B, C and V as single-letter mandatory
  extensions; it doesn't enumerate Zaamo/Zalrsc, Zba/Zbb/Zbs, Zc* or the
  Zve*/Zvl* subsets in the mandatory set.

- In current merged code, hwprobe_isa_ext0() is already using
  riscv_isa_extension_available() signle letter checking for C and V.

PS:
B maybe a special one, just in case anybody raise it. As the community
discussed when I adding it into the bindings, because B comes later than
its sub-components zba/zbb/zbs, so, when I added B, I cleaned up all
in-tree dts files which declared zba/zbb/zbs but not B and made them declar=
e
both.

Link: https://lore.kernel.org/linux-riscv/20260115-adding-b-dtsi-v2-0-254dd=
61cf947@riscstar.com/
[1]

Also, in the bindings: extensions.yaml, a schema rule is added which requir=
es
a node listing zba, zbb and zbs to also list b (and the reverse). Moving on=
,
new dtsi/dts fils, a node with only the subsets fails dtbs_check.

One may argue that the schema check doesn't cover ACPI path. But again,
shouldn't the vendor who publishs RVA23 hardware be conformant to the
extensions wording in RVA23 v1.0 spec?

What do you think?

Thanks,
Guodong Xu
docularxu@outlook.com


>
> Additional nit below.
>
> >
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/a=
sm/cpufeature.h
> > index 739fcc84bf7b2..facc31b2960c6 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -25,10 +25,24 @@ struct riscv_cpuinfo {
> >       unsigned long mimpid;
> >  };
> >
> > +enum {
> > +     RISCV_ISA_BASE_IMA,
> > +     RISCV_ISA_BASE_RVA23U64,
> > +     RISCV_NR_ISA_BASES,
> > +};
> > +
> > +/**
> > + * struct riscv_isainfo - per-hart ISA state
> > + * @isa: bitmap of ISA extensions this hart implements
> > + * @isa_bases: bitmap of profile bases this hart conforms to
> > + */
> >  struct riscv_isainfo {
> >       DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
> > +     DECLARE_BITMAP(isa_bases, RISCV_NR_ISA_BASES);
> >  };
> >
> > +extern unsigned long riscv_isa_bases[BITS_TO_LONGS(RISCV_NR_ISA_BASES)=
];
> > +
> >  DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
> >
> >  extern const struct seq_operations cpuinfo_op;
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 81145621dc378..6e8dd33aa3888 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -41,6 +41,9 @@ unsigned long elf_hwcap __read_mostly;
> >  /* Host ISA bitmap */
> >  static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
> >
> > +/* Host ISA bases bitmap */
> > +DECLARE_BITMAP(riscv_isa_bases, RISCV_NR_ISA_BASES) __read_mostly;
> > +
> >  /* Per-cpu ISA extensions. */
> >  struct riscv_isainfo hart_isa[NR_CPUS];
> >
> > @@ -1305,3 +1308,92 @@ void __init_or_module riscv_cpufeature_patch_fun=
c(struct alt_entry *begin,
> >       }
> >  }
> >  #endif
> > +
> > +/*
> > + * Compute the set of profile bases (IMA, RVA23U64, ...) a hart
> > + * conforms to, given its resolved ISA bitmap.
> > + *
> > + * If @isa_bitmap is NULL, the host ISA bitmap (the AND across all har=
ts) is
> > + * used.
> > + */
> > +static void riscv_set_isa_bases(unsigned long *bases, const unsigned l=
ong *isa_bitmap)
> > +{
> > +     const unsigned long *isa =3D isa_bitmap ? isa_bitmap : riscv_isa;
> > +     DECLARE_BITMAP(ext_mask, RISCV_ISA_EXT_MAX) =3D { 0 };
> > +     DECLARE_BITMAP(tmp, RISCV_ISA_EXT_MAX);
> > +
> > +     /* IMA */
> > +     set_bit(RISCV_ISA_EXT_I, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_M, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_A, ext_mask);
> > +
> > +     if (bitmap_andnot(tmp, ext_mask, isa, RISCV_ISA_EXT_MAX))
> > +             return;
> > +
> > +     set_bit(RISCV_ISA_BASE_IMA, bases);
> > +
> > +     /* RVA23U64 */
> > +
> > +     /* Zic64b and Supm with PMLEN=3D7 */
> > +     if (riscv_cbom_block_size !=3D 64 ||
> > +         riscv_cbop_block_size !=3D 64 ||
> > +         riscv_cboz_block_size !=3D 64 ||
> > +         !riscv_have_user_pmlen(7))
> > +             return;
> > +
> > +     set_bit(RISCV_ISA_EXT_F, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_D, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_C, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_B, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZICSR, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZICNTR, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZIHPM, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZICCIF, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZICCRSE, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZICCAMOA, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZICCLSM, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZA64RS, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZIHINTPAUSE, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZICBOM, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZICBOP, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZICBOZ, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZFHMIN, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZKT, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_V, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZVFHMIN, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZVBB, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZVKT, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZIHINTNTL, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZICOND, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZIMOP, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZCMOP, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZCB, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZFA, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_ZAWRS, ext_mask);
> > +     set_bit(RISCV_ISA_EXT_SUPM, ext_mask);
> > +
> > +     if (bitmap_andnot(tmp, ext_mask, isa, RISCV_ISA_EXT_MAX))
> > +             return;
> > +
> > +     set_bit(RISCV_ISA_BASE_RVA23U64, bases);
> > +}
> > +
> > +/*
> > + * Populate the host ISA bases bitmap (riscv_isa_bases) and each
> > + * hart's per-cpu isa_bases.
> > + */
> > +static int __init riscv_init_isa_bases(void)
> > +{
> > +     int cpu;
> > +
> > +     for_each_possible_cpu(cpu)
> > +             riscv_set_isa_bases(hart_isa[cpu].isa_bases, hart_isa[cpu=
].isa);
> > +
> > +     riscv_set_isa_bases(riscv_isa_bases, NULL);
> > +     return 0;
> > +}
>
> Missing blank line here.
>
> Thanks,
> drew
>
> > +/*
> > + * Registered as subsys_initcall so it runs after
> > + * core_initcall(tagged_addr_init) populates have_user_pmlen_*.
> > + */
> > +subsys_initcall(riscv_init_isa_bases);
> >
> > --
> > 2.43.0
> >
