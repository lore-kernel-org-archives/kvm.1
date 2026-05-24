Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6DD2D131D
	for <kvm@vger.kernel.org>; Sun, 24 May 2026 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779600294; cv=pass; b=ut8lgd3UG33GXiogbgJMZqrS8QxHPZh2zF9sZsMVymNOApUKnuCCOE59yby3kqLc0f9Gcc7kz8o0XYEm6tkN6wytd0FljOC5FUl0l3z8VziT765N4S+OH26e1EjH2eOecFCj+EBQL2v75rS4ESR5nzu3bb9hjQbodSkB+/HIbXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779600294; c=relaxed/simple;
	bh=2TV1Cy+48jLn4vyUcx4YWWo/cRS9DikqYz2OrWfkNDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7OMtk0ASRO16N9lNfUoyGy1qlrWGcbfq7WIvr8+9nyMhrKft72nyRqYg/iMUgb5nQW5qOE1aNpGXH37py8XbHZEk5Gt85TSyOyywctANXJnFVvYdoRy70K64QuxvTZ5nycS3y4Tl9B3dI1NuEBuLVOpXVYISGap8PnaeFDu3Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=pk4/oQRm; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="pk4/oQRm"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e61d8d9a21so385679a34.0
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 22:24:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779600291; cv=none;
        d=google.com; s=arc-20240605;
        b=Hitsm71VJJkG++KMG5eQeN4xfbsnwucAwVgoSxxTdPNDNnffOF3mjCX96YvTvqk0FP
         cfGU5jW1zQjSzNeBlpPX4KQW0MUbu4QFY8PtG6I8J7eMf/7F7Q/vc4n7PtNkVolRDihG
         Q8CwA1Ghh29ECfFo9QgY2KhW1L7NeSVlb7oXTZIG5z9LMrjbQHCbGwXugBY84Qj1Fslg
         t26utoTkGQMK7RsziYN15nWEI2ZSqFBEq6h69+YKyCygNrKuKpNEdFewArEcLeZgOnhp
         UUwpq4ur+ZAdjqb4fs5UBbi4yIHEU9lIOntXg2kLpNVmnaLaeFyAeQuyTW8fD1kH8KgD
         v1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IbupSW0UagmshubFRiSQA618qybyRttziXYFiFa+ZEM=;
        fh=YNcWRp/dZEck0+NqxDPUO1WWLEezsZL5DPEu+tmsF1k=;
        b=OuLdS560OVNTo3s8ApbQjkNYgbHZpcl33CwD6B24oVgeKvQaC4xIlz2GiRPAONX9Kb
         F36dkhLZBCorpPVYk/hG31xi9ivXoaItRsAr6Bhzc6AnTMklBegAXHuAyI+EWcSwqRyl
         bX9iPM83tG7PzQ7HM8y+ma2GTgEYlApsnwLjgEYUMm9dBoRo1lwg3kBJxJp0P6agqYXj
         xQY7sW6WBEHy6a5LzFbj+0/jeLv/0FNnYkHs1ZeRlt9lsyFcIuwF6jm8mJdCbhL741O3
         qGibQt1/ryoa4Rm8XOu957PHkUNpvMI5P3pL2B7e0Ne/RbmXWgrroOYCywf/uuMlg3rL
         M6Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1779600291; x=1780205091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbupSW0UagmshubFRiSQA618qybyRttziXYFiFa+ZEM=;
        b=pk4/oQRmFB42sK2l863KHhJCB1NDGCjN2erCDikBkdpxpplUbSotDnL3xJjyTipUmf
         CHy/MIhdfFA4TgKtdap6Kr9dm174q89rKn4zbul3Gcrl8gqg2z/8z5DbKcHm5addIa9K
         TBz62WfiT0muvAM3NHa0hkOttPJjD/8wmUV9RtEJHn5ie9ZitRxjUYjKOftux8j8SaM9
         IoQasO41kMttG0JvoCNMA1d6jv+7MQK0eMu6yvJBgzaKvYFCaC4OAN57xe2Cz16m4EqR
         Wos9MfsvPB6rr8v+gCOQ+jw96bPQsa7tUrh7ufvv6X2YOm02KNZ7w9uqkGo/NpR3Rvdp
         ZgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779600291; x=1780205091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IbupSW0UagmshubFRiSQA618qybyRttziXYFiFa+ZEM=;
        b=C1xIVYnjRL8kg6UFgk1xu3YsILLPlJ95e+2ax2VQoRB48IpEfJSacyEODiWUVlTLqc
         0hpsXprSV+J63sSAP8q+kCPWCgn69rVCwNnJ6ydzj5XgZ08ZV5pJ88wLV5ItIgLt4XFU
         jV9XZeEHetgvbXLo1GMXdWxdNVuh9W2EUyFbzK6LFvbsuZd6bXCEGw9bgUH23UooJ1Xc
         fQUVnurNa+vHLasg/6mmlDlK6j6MLkeWkxtWmbB66NqwEhNXP+HwDm3FUxln2mUcjZUl
         NXmE6LTA38QaMIoZakOtjl8B7yaHAeVRdtQJY5I8ngPZDMy9upOC501yG0j/sExmDPfJ
         lE3w==
X-Forwarded-Encrypted: i=1; AFNElJ8DpPJypgS9Ab9wTmWVU7oBwtgeB/PAD6+XvAgIJPwM6TGlaxoNF7XsnjoPnfniSkyl5Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQuKE888SZBdOaiOLN4IqiMHeQQnhxas4JVlJS7u5UPUYowpZJ
	tbADqW8P8BbHPZE+2sNDvdvLbC1QCYInhXhVdDuFsDlm4ivoejnrH6WbjE/y2YFw7+eq6qEJHn/
	D+HYH5cghuFYVl7Ls2RS0BBYb84tsowfINuJz95OPQg==
X-Gm-Gg: Acq92OE+WBQ+wZKb1SLXTXelUw7wg9fe1IoSi5lM9Xe8K8p3iBg5e4lxrw0WiZzFSer
	C2xrN2HIUf+UJNxX8YEBSHEWzchifJtxLj8W2sfVtRLwOexeqfhX9iJAkBZ4k0iHhRme0TAmeg/
	fLJdwxoKn5dHvdb1nDXN92exs5Jg0wTxRC/PW7HgufME+ywTFbN/jvIVFYRYV1b+2bpNoykO9Zm
	FBhjqrgiXht8FueXlchGz6303Cs6ezvTGWMAOm4nC1T03KzLnFFS2+3wZpIdnN0r+cFWzGTm4Ky
	piAc9mJCR1nocu8FdMG8x7ygP1jv8wy4VOQnbMWUdvqfZoeDzLHkwUHBKPQRMxqpMPDGiHA3uNh
	5m9dEKfTDZn349hrMskm5dBgprD8LMIcLReTwxA==
X-Received: by 2002:a05:6820:868b:b0:69b:5f97:de79 with SMTP id
 006d021491bc7-69d7eb91b64mr4064097eaf.19.1779600291542; Sat, 23 May 2026
 22:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425005916.3321811-1-guoren@kernel.org> <20260425005916.3321811-3-guoren@kernel.org>
In-Reply-To: <20260425005916.3321811-3-guoren@kernel.org>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 24 May 2026 10:54:39 +0530
X-Gm-Features: AVHnY4KihubV0U34tSm4W-TTo3A-ChHfjM74JnkAvA8gb0S55cVQRZv-mcQkpfE
Message-ID: <CAAhSdy1pDsRZGorxU9bJ7cs19v3LH40hhoaYvWQUsFo-z_Fjmw@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] RISC-V: KVM: AIA: Replace global HGEI count with
 simple enabled bool
To: guoren@kernel.org
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, atish.patra@linux.dev, 
	cp0613@linux.alibaba.com, fangyu.yu@linux.alibaba.com, gaohan@iscas.ac.cn, 
	inochiama@gmail.com, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, me@ziyao.cc, 
	palmer@dabbelt.com, pjw@kernel.org, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 6:29=E2=80=AFAM <guoren@kernel.org> wrote:
>
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> Now that HGEI line management is fully per-CPU (via struct
> aia_hgei_control::nr_hgei), the global `kvm_riscv_aia_nr_hgei`
> is no longer needed. Replace it with a simple `bool
> kvm_riscv_aia_hgei_enabled` that only indicates whether HGEI
> support is available at all.

As mentioned in PATCH1, this PATCH is not required.

>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/kvm_aia.h |  2 +-
>  arch/riscv/kvm/aia.c             | 18 ++++++++----------
>  arch/riscv/kvm/aia_device.c      |  4 ++--
>  arch/riscv/kvm/main.c            |  3 +--
>  4 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kv=
m_aia.h
> index b04ecdd1a860..e8749ac6bed7 100644
> --- a/arch/riscv/include/asm/kvm_aia.h
> +++ b/arch/riscv/include/asm/kvm_aia.h
> @@ -79,7 +79,7 @@ struct kvm_vcpu_aia {
>
>  #define irqchip_in_kernel(k)           ((k)->arch.aia.in_kernel)
>
> -extern unsigned int kvm_riscv_aia_nr_hgei;
> +extern bool kvm_riscv_aia_hgei_enabled;
>  extern unsigned int kvm_riscv_aia_max_ids;
>  DECLARE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
>  #define kvm_riscv_aia_available() \
> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index a23729052cfb..70ff1d25dd99 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
> @@ -28,7 +28,7 @@ struct aia_hgei_control {
>  static DEFINE_PER_CPU(struct aia_hgei_control, aia_hgei);
>  static int hgei_parent_irq;
>
> -unsigned int kvm_riscv_aia_nr_hgei;
> +bool kvm_riscv_aia_hgei_enabled;
>  unsigned int kvm_riscv_aia_max_ids;
>  DEFINE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
>
> @@ -491,7 +491,7 @@ static int aia_hgei_init(void)
>         struct irq_domain *domain;
>
>         /* Skip SGEI interrupt setup for zero guest external interrupts *=
/
> -       if (!kvm_riscv_aia_nr_hgei)
> +       if (!kvm_riscv_aia_hgei_enabled)
>                 goto skip_sgei_interrupt;
>
>         /* Find INTC irq domain */
> @@ -524,7 +524,7 @@ static int aia_hgei_init(void)
>  static void aia_hgei_exit(void)
>  {
>         /* Do nothing for zero guest external interrupts */
> -       if (!kvm_riscv_aia_nr_hgei)
> +       if (!kvm_riscv_aia_hgei_enabled)
>                 return;
>
>         /* Free per-CPU SGEI interrupt */
> @@ -631,6 +631,7 @@ int kvm_riscv_aia_init(void)
>  {
>         int rc;
>         const struct imsic_global_config *gc;
> +       unsigned int kvm_riscv_aia_nr_hgei;
>
>         if (!riscv_isa_extension_available(NULL, SxAIA))
>                 return -ENODEV;
> @@ -641,21 +642,18 @@ int kvm_riscv_aia_init(void)
>         kvm_riscv_aia_nr_hgei =3D fls_long(csr_read(CSR_HGEIE));
>         csr_write(CSR_HGEIE, 0);
>         if (kvm_riscv_aia_nr_hgei)
> -               kvm_riscv_aia_nr_hgei--;
> +               kvm_riscv_aia_hgei_enabled =3D true;
>
>         /*
>          * Number of usable HGEI lines should be minimum of per-HART
>          * IMSIC guest files and number of bits in HGEIE
>          */
> -       if (gc)
> -               kvm_riscv_aia_nr_hgei =3D min((ulong)kvm_riscv_aia_nr_hge=
i,
> -                                           gc->nr_guest_files);
> -       else
> -               kvm_riscv_aia_nr_hgei =3D 0;
> +       if (!gc)
> +               kvm_riscv_aia_hgei_enabled =3D 0;
>
>         /* Find number of guest MSI IDs */
>         kvm_riscv_aia_max_ids =3D IMSIC_MAX_ID;
> -       if (gc && kvm_riscv_aia_nr_hgei)
> +       if (gc && kvm_riscv_aia_hgei_enabled)
>                 kvm_riscv_aia_max_ids =3D gc->nr_guest_ids + 1;
>
>         /* Initialize guest external interrupt line management */
> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> index 3d1e81e2a36b..5b45b1114425 100644
> --- a/arch/riscv/kvm/aia_device.c
> +++ b/arch/riscv/kvm/aia_device.c
> @@ -71,7 +71,7 @@ static int aia_config(struct kvm *kvm, unsigned long ty=
pe,
>                                  * external interrupts (i.e. non-zero
>                                  * VS-level IMSIC pages).
>                                  */
> -                               if (!kvm_riscv_aia_nr_hgei)
> +                               if (!kvm_riscv_aia_hgei_enabled)
>                                         return -EINVAL;
>                                 break;
>                         default:
> @@ -628,7 +628,7 @@ void kvm_riscv_aia_init_vm(struct kvm *kvm)
>          */
>
>         /* Initialize default values in AIA global context */
> -       aia->mode =3D (kvm_riscv_aia_nr_hgei) ?
> +       aia->mode =3D (kvm_riscv_aia_hgei_enabled) ?
>                 KVM_DEV_RISCV_AIA_MODE_AUTO : KVM_DEV_RISCV_AIA_MODE_EMUL=
;
>         aia->nr_ids =3D kvm_riscv_aia_max_ids - 1;
>         aia->nr_sources =3D 0;
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index cb8a65273c1f..bcfa139f4871 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -169,8 +169,7 @@ static int __init riscv_kvm_init(void)
>         kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits(=
));
>
>         if (kvm_riscv_aia_available())
> -               kvm_info("AIA available with %d guest external interrupts=
\n",
> -                        kvm_riscv_aia_nr_hgei);
> +               kvm_info("AIA available with guest external interrupts\n"=
);
>
>         kvm_riscv_setup_vendor_features();
>
> --
> 2.43.0
>

Regards,
Anup
