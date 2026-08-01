Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69E37AA65
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574334; cv=pass; b=SvfQgggmDva+ctauiT183nhqO2MChxnABHfQSFDGIryjD9pyGDJieF7OrJsJjJwipF5Q/V1iv705PtcBpNK23sok4QpXn80uTtOMBpx+abuBqYtKO0oU+cKA+3vFh67rtWcEvB1wBoJDcei+qJ+qe2uiGT93LjB56SUhSgc7HGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574334; c=relaxed/simple;
	bh=vRZKEY8d4nz1lnBLS4virEdWYCCu9Yt/2KSkMZXy5ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fG9zPHjXTsU6bXpP8Q2ClIiTMAUGtWw+EhPgqF9hcKyatSuUa1SfvYJX2yf1ixeIj3pAAnM2oA+x94xhEDGauDupf9z2i3GSTq22a1euthrKxZEfrx8pYbohlj34S+OZaYI7KfYBwvu0W+o2j7l80KiWD+JT1u6zYWl3LGddOyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=nq7JZ/qs; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="nq7JZ/qs"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c953950dfso15438801fa.1
        for <kvm@vger.kernel.org>; Sat, 01 Aug 2026 01:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785574330; cv=none;
        d=google.com; s=arc-20260327;
        b=WUiGhlZZ29Tfr7JDp81ZchzcB/+0Fc+dDM8ofOiqzLpMIuKxPUA/oVypeM4ah+0n0H
         mViOOhhQv+iADZseqgyBog0QSN1D3njCcuhO6Ty+ZaebVoKM6CxbRID0PAtwv29rI0Of
         /3NZ1x5iHPtSRghByF9rlBuve4QVhVCqoplocV8GX8ro/rkRGEcP1+xRG96udy+6A/TC
         /PRmj9GmOHvSoEUjYVpRMIk0yG35nOjn5uvzslaVXjna3ib6pLW++D77vooYj/dsXjUc
         UHmMs1ya4L8dokLRH04CLPH0Ct0fGfxMLtufPDRSO7j64xvqr4rs0Wz9ht04aF/31l5M
         HaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OolFLJ3qIJliRKXCQGXygUbNJuKJwRQO7ZGmC2zl2Cg=;
        fh=ntJQTZKW5WX3UGalJmxQRTK2nM9AuGZatn2vKR15pCg=;
        b=PDP2zgd1Gjzd72f0lGO+cHDSrx/WvHKznimHvLurmsvG5/0Waq4ITDLTmOrNh9tLc2
         DNoUrKURwM9aSiB0GuuvlFiCbgfkvzTw1G+SnvSLALzc9oxZ7NppZke8rNGKG+myxvto
         ZtuWZEuhqmmVvhzDTH8wOHaXgy9CThxT+QlTCEjc+xbKa2H23fQVJHNnD02vG2DYUY4N
         bu6kbh/8Tll6fbySBOYcWB571MWA6Spy05Ek/BDGzydhPTSOvrFKWbcP6oeJdTZOE+q7
         zzrgC9MIiSyGUFvOH0+xnEHNWQsoJLYRGh6L4KDM9v/0HEdA0OwO5UueElw6tuJ3aSq2
         WQbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1785574330; x=1786179130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OolFLJ3qIJliRKXCQGXygUbNJuKJwRQO7ZGmC2zl2Cg=;
        b=nq7JZ/qsXXDyAowhUiFIyameaQaaQQXwBBfr7eHOlYYP8sOZXqxOGfIhJJsjkPtTHF
         ezEqTarblCHyBfFikxc+pBNxe9Dg+VGHs/k5DxdaDODz6SU4rcHXTNuoKuKjzT2cJ0SZ
         7HcoGxbDF6kzrq/CAAdJUP/0np2iGonpVX9pZtekBoKnvu0cv6ZldnB9pKAef/Utcbxq
         KcsZaEsmIw2+R9M6qC5+OqNVkN9V0BGr4R0BtNKPPs0KUHqd1dUU/BZpLFFU1GtcEUck
         CujB4IzEzO45X5+/+LWgDjVjtc84X+4MEs/Rbz5ssP1l9hk1vrywSVfQkb8ZexkqWwzL
         TMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785574330; x=1786179130;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OolFLJ3qIJliRKXCQGXygUbNJuKJwRQO7ZGmC2zl2Cg=;
        b=hT3vRk2bF1XcBtEt3u++U+O+jY/fGRINEoelO3ZLsUocQkme4/r9zGSRIqqqEm/i3d
         szJPr91kiQL+tZJ30GryvP/WbVDbrcg8vG7pDTpE0GByS16b7t4fjNMZEJudbImgg8M/
         FMWmMRp6VyZkil3hNY7YomVlqsHzJJaV2MM/3GKdiaiBW91hcMg+zU/gwUOkYHVv0Cs8
         pJu/ewu1Jj68++2CMwvxCIxgka4Yeg60g/tIMVoI42JUXMKbfq2rZDSRjc6MmTHx3247
         J667raSCq/QIV4qZTqa6yWUhqNx4nmHGcNbG6j1ssIL6XtEfmNTglnZsKIndCHCslHSr
         H1NA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0jUN9qpxyoVdokN+CjhSTJp5wxaR/sCyVdVNV0HMXAo2iQnOkS5ZOOk7upuKeJ8u3c+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNosuG/q6yMe0TzbFHKOhQ5/oP1RmpgNtOc7/pwZmSgsY9lhVG
	YBc6RjvXDBnP1mFKb+zmS1IIpioPDG0XoY0KdWnAu/Nnvl0oQJQbAM9GMZfjTaIWVqIcBIYKVK2
	xJGAoS3NXuMk+4yAgt6FuTpB59/GMLLXRCVFxtJrocA==
X-Gm-Gg: AR+sD106uBaJo+GCBCH6csmItjHhSxw0Y/ul46pMfdP64csQgpcLGbz7JdJFRZ42vD2
	/XJPDwQyIgdadPMm5y6bSTghqWaTm7tsUbioqIPMpb9xT4Fe34PNbigWiuaC1yqLV764W8a8LrK
	1XUTpcqxQ5Rm0QsOxJZd6Xm4hF6CfmsYlnohk1AeS3S7LWc/Nn9U2X8yS1FzUDBF4YjEv2I1HUg
	huOHNGHQhY8uZqQcT/BKhxoA1+ixmCk9gwyKxs9wH21A7v0B8/84Xp2bWf8aMIqu+GyFVcLShtj
	tKJNodQa16ESVxyXg5Kpguo/MzHCM4dnDamR4OHjo8av5LkBETrVeZzZh8QhlquAu4iKoKWuytH
	zLGQ+tLb/peLSWBkmp2ADWqaQP83ep6wVAnaWv6d+nTtgzMt/7DjoyMFWyzaNWZZB
X-Received: by 2002:ac2:5a45:0:b0:5b0:1433:13b9 with SMTP id
 2adb3069b0e04-5b2e4f34619mr363739e87.25.1785574330267; Sat, 01 Aug 2026
 01:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716064112.2387938-1-yhchen312@gmail.com>
In-Reply-To: <20260716064112.2387938-1-yhchen312@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 1 Aug 2026 14:21:58 +0530
X-Gm-Features: AUfX_mzX7yVO0_wbnjUcTQveTiyE93ynqUCnT2aQAUQJKGgBPynLlffjyXq5axI
Message-ID: <CAAhSdy1JJxRsAGxKbOwy38rorCuiVkjp4QD8KCBS4Pc-7zea5g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Account VM-scoped allocations to the VM cgroup
To: yhchen312@gmail.com
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Quan Zhou <zhouquan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 12:11=E2=80=AFPM <yhchen312@gmail.com> wrote:
>
> From: "Yuhang.chen" <yhchen312@gmail.com>
>
> Charge the per-VM and per-vCPU allocations (stage-2 PGD, APLIC state,
> IMSIC context, vector context, FWFT config, PMU snapshot) to the
> allocating process's memory cgroup via GFP_KERNEL_ACCOUNT / __GFP_ACCOUNT=
.
> Per-CPU module-init allocations and transient scratch buffers are left
> unaccounted.
>
> Measured results (KVM guest run in a memory cgroup; VM cgroup
> memory.current after guest boot):
>
>   VM cgroup memory.current    1044480 bytes
>
> Assisted-by: YuanSheng:deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Yuhang.chen <yhchen312@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup

> ---
>  arch/riscv/kvm/aia_aplic.c     | 3 ++-
>  arch/riscv/kvm/aia_imsic.c     | 4 ++--
>  arch/riscv/kvm/mmu.c           | 4 ++--
>  arch/riscv/kvm/vcpu_pmu.c      | 2 +-
>  arch/riscv/kvm/vcpu_sbi_fwft.c | 2 +-
>  arch/riscv/kvm/vcpu_vector.c   | 4 ++--
>  6 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_aplic.c b/arch/riscv/kvm/aia_aplic.c
> index 748107c347d9..be902ea6480b 100644
> --- a/arch/riscv/kvm/aia_aplic.c
> +++ b/arch/riscv/kvm/aia_aplic.c
> @@ -581,7 +581,8 @@ int kvm_riscv_aia_aplic_init(struct kvm *kvm)
>                 return 0;
>
>         /* Allocate APLIC global state */
> -       aplic =3D kzalloc_flex(*aplic, irqs, kvm->arch.aia.nr_sources + 1=
);
> +       aplic =3D kzalloc_flex(*aplic, irqs, kvm->arch.aia.nr_sources + 1=
,
> +                            GFP_KERNEL_ACCOUNT);
>         if (!aplic)
>                 return -ENOMEM;
>         kvm->arch.aia.aplic_state =3D aplic;
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index d38f5de0834c..507d82e5bc88 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -1108,7 +1108,7 @@ int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu *=
vcpu)
>                 return -EINVAL;
>
>         /* Allocate IMSIC context */
> -       imsic =3D kzalloc_obj(*imsic);
> +       imsic =3D kzalloc_obj(*imsic, GFP_KERNEL_ACCOUNT);
>         if (!imsic)
>                 return -ENOMEM;
>         vcpu->arch.aia_context.imsic_state =3D imsic;
> @@ -1121,7 +1121,7 @@ int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu *=
vcpu)
>         imsic->vsfile_hgei =3D imsic->vsfile_cpu =3D -1;
>
>         /* Setup IMSIC SW-file */
> -       swfile_page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO,
> +       swfile_page =3D alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO,
>                                   get_order(sizeof(*imsic->swfile)));
>         if (!swfile_page) {
>                 ret =3D -ENOMEM;
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 082f9b261733..9b1d809daf2c 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -669,8 +669,8 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
>                 return -EINVAL;
>         }
>
> -       pgd_page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO,
> -                               get_order(kvm_riscv_gstage_pgd_size));
> +       pgd_page =3D alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO,
> +                              get_order(kvm_riscv_gstage_pgd_size));
>         if (!pgd_page)
>                 return -ENOMEM;
>         kvm->arch.pgd =3D page_to_virt(pgd_page);
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index bb46dcbfb24d..e5018784779d 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -452,7 +452,7 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_=
vcpu *vcpu, unsigned long s
>                 }
>         }
>
> -       kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC);
> +       kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC | __GFP_A=
CCOUNT);
>         if (!kvpmu->sdata) {
>                 sbiret =3D SBI_ERR_FAILURE;
>                 goto out;
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index ab39ac464ffd..4984d3e54e23 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -377,7 +377,7 @@ static int kvm_sbi_ext_fwft_init(struct kvm_vcpu *vcp=
u)
>         int i;
>
>         fwft->configs =3D kzalloc_objs(struct kvm_sbi_fwft_config,
> -                                    ARRAY_SIZE(features));
> +                                    ARRAY_SIZE(features), GFP_KERNEL_ACC=
OUNT);
>         if (!fwft->configs)
>                 return -ENOMEM;
>
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 62d2fb77bb9b..d748e7d825e1 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -76,11 +76,11 @@ void kvm_riscv_vcpu_host_vector_restore(struct kvm_cp=
u_context *cntx)
>
>  int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
>  {
> -       vcpu->arch.guest_context.vector.datap =3D kzalloc(riscv_v_vsize, =
GFP_KERNEL);
> +       vcpu->arch.guest_context.vector.datap =3D kzalloc(riscv_v_vsize, =
GFP_KERNEL_ACCOUNT);
>         if (!vcpu->arch.guest_context.vector.datap)
>                 return -ENOMEM;
>
> -       vcpu->arch.host_context.vector.datap =3D kzalloc(riscv_v_vsize, G=
FP_KERNEL);
> +       vcpu->arch.host_context.vector.datap =3D kzalloc(riscv_v_vsize, G=
FP_KERNEL_ACCOUNT);
>         if (!vcpu->arch.host_context.vector.datap) {
>                 kfree(vcpu->arch.guest_context.vector.datap);
>                 vcpu->arch.guest_context.vector.datap =3D NULL;
> --
> 2.34.1
>
