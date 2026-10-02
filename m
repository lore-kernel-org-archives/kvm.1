Received: from mail-lr2-f33.google.com (mail-lr2-f33.google.com [74.125.230.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B80362156
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924011; cv=pass; b=YIG1ydMooixPXdR4h7zZVgjShjxy4hHMA6McZrSgNmLLt4+suiDbijq0lPnzylQZVpXRon00HvTDh796Dr7dV9ocKlF6Yx8dPkBun7S1cAtlFsdLY8/wgS4HWab0Xf/+GjRRmc+O0yP51UzgtbBY1t78rXnBOCw1TE4Vu3Vbd6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924011; c=relaxed/simple;
	bh=8vyYczRg/F3HKKUEwv3mze+WuwZ1WjNqa4gJ0bL+AO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahXEeWmCBFlmv7BHs71+beUdGJWazPphNkjdBVCcM/OSXfC2VKWmJNpdnzWLJ6elVzsjVU2oO7yDtx8c39GIqzGzrByQTkiSaye9vsUkqoCGrX08A3DVy8Valkslyvr5k8Pi9YHfm188OShnlG0k4V5N7tHjiiJt/jUMzc80eEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=sTxin4iR; arc=pass smtp.client-ip=74.125.230.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="sTxin4iR"
Received: by mail-lr2-f33.google.com with SMTP id 38308e7fff4ca-3a8736cfa68so11704741fa.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 23:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790924008; cv=none;
        d=google.com; s=arc-20260327;
        b=mgkJJ3t+5nlrUnc3HDwCWVHTlahIgbOu/yt4MdfOCQGRv0ej8zbeIljzuxQyybqRb6
         wR6YyF7vDoQGjw2Y3JYXQrKspwCWf0yHrPRZ0ymP7Uc8bntMKNOGa4DqCV+FL0MAAHth
         8iviwOtsY6jrevH5R8N9nhyk3I1wN1Prf8lU80HcwRSlqRtiFzrm9jlIYuWu5a9hlXC7
         H5WlrIHAL2tZ9j8JJNh5GVqw84B+5/Je1o3t8FxkAVMXbUf2ZNOqKhchc5kneGwcN/DE
         MDHnQ5ib0/Wm+d8IJee8fz0gkluRJ3VhFvOFLKpmSC9kVLm5ZCrMEt7Zfqi/WJrx6JBg
         GdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pB/qGu4pK5apMENgJwNFrZAZpWxtcAn8jGhRKIo64Ro=;
        fh=tP/yGscZlFf95xLFHhS6Z/od/vFDanUZJoevkiLw7aQ=;
        b=q3rAeZXc/i2xYo3jv6pDRfX5IX+roXAYLxmY8cOBNYv8tnC8R6Osz7vaHHn6Qhl5Sl
         0uo+PKCOApbOZS8eK4rvm6yAGwFtLDb3FeuFd0itDxZpstvTlsFtFJUSfgOKtXekWUo5
         iWUk6nwYHUyQaU/2b48hPKHFFnsFlRmFykr1gXMq3wOc5FN60w/uHylx7jxoOOhME1ZW
         KTl5vLsAEeCX8C4xokXjO0QfkPzBHk7flcetimpyLZ3eSzYZs88eSEQUEZuO3obvNUV/
         wLAdXjI28cysZu4Abavs85njmhIn3bb3V8awszkzgkeekHVXC7xX8xtJy+GdH+R4l5AK
         B8mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1790924008; x=1791528808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pB/qGu4pK5apMENgJwNFrZAZpWxtcAn8jGhRKIo64Ro=;
        b=sTxin4iRwuxD3cR9twrKVwm4oKAGKRAKyTs8EKJyIja/hdwFSi7JtrruapecK2qG9g
         zlSHFHFH2nlN8PdlOeyqNkR37nDG2hQ5hBWh5I5KOMGOqkBgZXKnEDI/uX2vnRdn2tjX
         b23aSt5fFC1fz7WjFNAt98OyHZ9jMdVPB7h1kLUWSwBOjxjGZV7tPHvs5JQ9cmVHHibU
         MtcFN4JJo6m95iQ3sx+Czr6eu3pf4w3/hf1H/O6TzKOmsmukg8G5Zfq1g0OKW6E7odTW
         2aqikXWFm94EVFQ/nws1yiPSPh1idE7eVSzKNyUi6I37BAkdVGf+p6Nc211CFhRQjKbl
         heDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790924008; x=1791528808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pB/qGu4pK5apMENgJwNFrZAZpWxtcAn8jGhRKIo64Ro=;
        b=XFq7aOL11jZ5bjGIhsKJKlJQiuroqqmD/ohiGb95kGBixlkUSBfS/SiAC1PtW4sdI/
         +5qv44B3pmDVdJKEbas1hVvNvX1su3aKlsZTqIlShneANgV01hXZl3mg4K7EPydoY5ST
         jNnviDuy5dX3zRz/B0zCsaSB2Y4oDePjxcs5/kMVSDQ/7BrhXpsR4XnTceQYFpioMqjP
         5XV68tjyJLgR2np167fKhTIm117CLi1CZAWjFz7oPw08dpYCJuBUTGosUGgmVkQU9a2o
         NvwifBpVVZECDH/fio6tONPcuYRbEyReLGg80p2WHHPTt268c/2iRfEduTrQZ5hgOWsW
         T8Hg==
X-Forwarded-Encrypted: i=1; AKwUvByzFcYpZMuyeWyNgk77kqXZKcSuI/VB8DJtfRGk0OUb9f6kcS+vCNq0lCcY5Daj7/sch2Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJL6PPOUsgopgErKIx8j+k+f22BrbXD8mkMKvPRrAnkeMc0nU3f
	IarBZZaeef8VkCpdtDf9D83PZrHuttmgSawZD5SdqulOWM/DzdJLnLWkklS+buULPXlEs89blKD
	oP9Mo9GPjnO9VfrJCBzBZ22QWHSf9335nN78ZO4tkiA==
X-Gm-Gg: AYBFou3q/1BwseDDhjRX53u9SBp/W3eooOOHHgax7gOrS3gXJ08yPXL7q7wqSjJjpD3
	mIzwOqoMNZTxZd1n2IdYjQ6hINJwpncCn9fMEc8eGo6e8RrtgNKk2PqRc3RVGV6LllXYbPhrskF
	+1M0bxLj9Ejodw36jfRNeqO7uxnmh782wYjESB3GgVWEqEyp+KgJ8B+t+PYm+BsWFL42a47JSYV
	vW9L8mrIzfJdeQ6Ms3A54GEBaIp685JKRgmmYAgbR2uexDnSblXa3wPZxYjNmR1bsBdvBg2BWlf
	MUKpDZ+aodICKvQP7LumP8pyfIw1dXT9GoMevRJWugHUO8YjVbuJdyg6LC7rBYd//VQrztwj80m
	qQ2aDeakwOIDrioQRtz5gRADOvx9L7ewTcTxF1TZzKi/X+hWFfPnl9/+uXENaI++HuYTqL8Pw+Z
	c=
X-Received: by 2002:a2e:a802:0:b0:3a6:6f81:1027 with SMTP id
 38308e7fff4ca-3a88781b897mr3633851fa.24.1790924007662; Thu, 01 Oct 2026
 23:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730093614.983508-1-xiangwencheng@lanxincomputing.com>
In-Reply-To: <20260730093614.983508-1-xiangwencheng@lanxincomputing.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 2 Oct 2026 12:23:14 +0530
X-Gm-Features: AclHuK_kRPavXtWsReKC9CryYELBy8XCMd0E391B5VzjdtS0vtPoxj_Th0S8j2Y
Message-ID: <CAAhSdy0UgBGd2M=Zq3XiaTY-Y5uTrAcOtFF=haKgmFBRB1=ggw@mail.gmail.com>
Subject: Re: [PATCH] riscv: KVM: Add hart-to-vCPU mapping for faster MSI injection
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 3:06=E2=80=AFPM BillXiang
<xiangwencheng@lanxincomputing.com> wrote:
>
> Replace linear searches over all vCPUs in MSI injection paths with a
> direct hart_index -> vCPU lookup table. This avoids O(n) scans on
> every injected interrupt and improves performance when the number of
> vCPUs is large.
>
> Both kvm_riscv_aia_inject_msi_by_id() and kvm_riscv_aia_inject_msi()
> now use the table instead of iterating over the vCPU list.

The AIA hart_index bits for VCPUs are based on the IMSIC address
set by the KVM user-space and are not required to be contiguous hence
this patch is already broken.

NACK from my side.

Regards,
Anup

>
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> ---
>  arch/riscv/include/asm/kvm_aia.h |  2 +
>  arch/riscv/kvm/aia_device.c      | 67 +++++++++++++++++++++-----------
>  2 files changed, 47 insertions(+), 22 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kv=
m_aia.h
> index c67ec5ac0..71240b0a2 100644
> --- a/arch/riscv/include/asm/kvm_aia.h
> +++ b/arch/riscv/include/asm/kvm_aia.h
> @@ -47,6 +47,8 @@ struct kvm_aia {
>
>         /* Internal state of APLIC */
>         void            *aplic_state;
> +
> +       struct kvm_vcpu **hart_to_vcpu;
>  };
>
>  struct kvm_vcpu_aia_csr {
> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> index be83c2d5f..595553817 100644
> --- a/arch/riscv/kvm/aia_device.c
> +++ b/arch/riscv/kvm/aia_device.c
> @@ -253,6 +253,14 @@ static int aia_init(struct kvm *kvm)
>         if (ret)
>                 return ret;
>
> +       aia->hart_to_vcpu =3D kcalloc(kvm->created_vcpus,
> +                                       sizeof(struct kvm_vcpu*),
> +                                       GFP_KERNEL);
> +       if (!aia->hart_to_vcpu) {
> +               ret =3D -ENOMEM;
> +               goto fail_cleanup_aplic;
> +       }
> +
>         /* Iterate over each VCPU */
>         kvm_for_each_vcpu(idx, vcpu, kvm) {
>                 vaia =3D &vcpu->arch.aia_context;
> @@ -274,6 +282,12 @@ static int aia_init(struct kvm *kvm)
>                 /* Update HART index of the IMSIC based on IMSIC base */
>                 vaia->hart_index =3D aia_imsic_hart_index(aia,
>                                                         vaia->imsic_addr)=
;
> +
> +               if (aia->hart_to_vcpu[vaia->hart_index]) {
> +                       ret =3D -EINVAL;
> +                       goto fail_cleanup_imsics;
> +               }
> +               aia->hart_to_vcpu[vaia->hart_index] =3D vcpu;
>
>                 /* Initialize IMSIC for this VCPU */
>                 ret =3D kvm_riscv_vcpu_aia_imsic_init(vcpu);
> @@ -293,6 +307,9 @@ static int aia_init(struct kvm *kvm)
>                         continue;
>                 kvm_riscv_vcpu_aia_imsic_cleanup(vcpu);
>         }
> +       kfree(aia->hart_to_vcpu);
> +       aia->hart_to_vcpu =3D NULL;
> +fail_cleanup_aplic:
>         kvm_riscv_aia_aplic_cleanup(kvm);
>         return ret;
>  }
> @@ -551,30 +568,28 @@ void kvm_riscv_vcpu_aia_deinit(struct kvm_vcpu *vcp=
u)
>  int kvm_riscv_aia_inject_msi_by_id(struct kvm *kvm, u32 hart_index,
>                                    u32 guest_index, u32 iid)
>  {
> -       unsigned long idx;
>         struct kvm_vcpu *vcpu;
> +       struct kvm_aia *aia =3D &kvm->arch.aia;
>
>         /* Proceed only if AIA was initialized successfully */
>         if (!kvm_riscv_aia_initialized(kvm))
>                 return -EBUSY;
>
> -       /* Inject MSI to matching VCPU */
> -       kvm_for_each_vcpu(idx, vcpu, kvm) {
> -               if (vcpu->arch.aia_context.hart_index =3D=3D hart_index)
> -                       return kvm_riscv_vcpu_aia_imsic_inject(vcpu,
> -                                                              guest_inde=
x,
> -                                                              0, iid);
> -       }
> +       if (!aia->hart_to_vcpu || hart_index >=3D kvm->created_vcpus)
> +               return 0;
>
> -       return 0;
> +       vcpu =3D aia->hart_to_vcpu[hart_index];
> +       if (!vcpu)
> +               return 0;
> +
> +       return kvm_riscv_vcpu_aia_imsic_inject(vcpu, guest_index, 0, iid)=
;
>  }
>
>  int kvm_riscv_aia_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
>  {
>         gpa_t tppn, ippn;
> -       unsigned long idx;
>         struct kvm_vcpu *vcpu;
> -       u32 g, toff, iid =3D msi->data;
> +       u32 g, toff, iid =3D msi->data, hart_index;
>         struct kvm_aia *aia =3D &kvm->arch.aia;
>         gpa_t target =3D (((gpa_t)msi->address_hi) << 32) | msi->address_=
lo;
>
> @@ -589,18 +604,22 @@ int kvm_riscv_aia_inject_msi(struct kvm *kvm, struc=
t kvm_msi *msi)
>         g =3D tppn & (BIT(aia->nr_guest_bits) - 1);
>         tppn &=3D ~((gpa_t)(BIT(aia->nr_guest_bits) - 1));
>
> -       /* Inject MSI to matching VCPU */
> -       kvm_for_each_vcpu(idx, vcpu, kvm) {
> -               ippn =3D vcpu->arch.aia_context.imsic_addr >>
> -                                       IMSIC_MMIO_PAGE_SHIFT;
> -               if (ippn =3D=3D tppn) {
> -                       toff =3D target & (IMSIC_MMIO_PAGE_SZ - 1);
> -                       return kvm_riscv_vcpu_aia_imsic_inject(vcpu, g,
> -                                                              toff, iid)=
;
> -               }
> -       }
> +       if (!aia->hart_to_vcpu)
> +               return 0;
>
> -       return 0;
> +       hart_index =3D aia_imsic_hart_index(aia, target);
> +       if(hart_index >=3D kvm->created_vcpus)
> +               return 0;
> +
> +       vcpu =3D aia->hart_to_vcpu[hart_index];
> +       if (!vcpu)
> +               return 0;
> +
> +       ippn =3D vcpu->arch.aia_context.imsic_addr >> IMSIC_MMIO_PAGE_SHI=
FT;
> +       if (ippn !=3D tppn)
> +               return 0;
> +       toff =3D target & (IMSIC_MMIO_PAGE_SZ - 1);
> +       return kvm_riscv_vcpu_aia_imsic_inject(vcpu, g, toff, iid);
>  }
>
>  int kvm_riscv_aia_inject_irq(struct kvm *kvm, unsigned int irq, bool lev=
el)
> @@ -641,10 +660,14 @@ void kvm_riscv_aia_init_vm(struct kvm *kvm)
>
>  void kvm_riscv_aia_destroy_vm(struct kvm *kvm)
>  {
> +       struct kvm_aia *aia =3D &kvm->arch.aia;
>         /* Proceed only if AIA was initialized successfully */
>         if (!kvm_riscv_aia_initialized(kvm))
>                 return;
>
> +       kfree(aia->hart_to_vcpu);
> +       aia->hart_to_vcpu =3D NULL;
> +
>         /* Cleanup APLIC context */
>         kvm_riscv_aia_aplic_cleanup(kvm);
>  }
> --
> 2.53.0
