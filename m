Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62554963C5
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185247; cv=none; b=Nzwr/wfITG9d1uXKbAvkhHvO5BHZlHUAPOYPT6CNpgLUNg3y18HWr6AkuZtozs2zcTvb6aCT/5UI55j01RrBDjg4e+DoM1KRVJYxO7q/CL8XZPgMYTVXZgPcGgyTXVbTtuyAGgB1JMkzlzJTgGxQ18ZAfsv3NtBvVwVA5kjt0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185247; c=relaxed/simple;
	bh=S0BkvKg0kbO1HyxpAHYNGek++mUq5yaU97H4xYUkyT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jes8eal9IPBwqwG9aFn1ncNUQL0BU0U4nwflcVsns+UWgwbUwqEAjww7hpTs9MPgUaAUbdLljL57c4f2yni6Bka4H/a+ZjtbQjwWmtNW3ndG3Ncr3/6G5QxNKJui/jK/roOLxsHrVTLolcqaVOOOu5EwW69m/IUcKJKfrKbKby8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwRCZZMt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwRCZZMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4EB1F00ACA
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788185244;
	bh=yAH1kAcmOp1Oc4wvgDM8TgcSQVhCKVp+yeDHlgM1nS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TwRCZZMtjrYE1QJPqPvLx+GiFzdqJGcIy2+4oVio6hVc2QPn4a9Pqp8sT+Ux18jYe
	 Uln0nIaZB8jTJ7R3YYf8yB9sbeQqJShena/eqMtBtgVOZ+251wrBkaRAx/r0ufU4so
	 wF/utT4sjoBIcOMtBiq2F6PHCv9rWdd3gMBk1yYcGh4XJuyErwQ8YrNx59pXGeRa5t
	 W3iDCd0xloNRHMFK3bGlKPR4/V8DucuPukTT+gX9Tmy7juy9EFS1d44/ve9gkX+OlH
	 +6Df4F9c3Sd6NR2aj6yW7d/J+kJzf9W2iu+kPSoiqFv6gVjSTNveAa4XviKo1sRV3P
	 JzNrvFo4fdLtQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c20e70a0962so459249466b.2
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 07:07:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpRAK3zGNUmXFgSy6yob0HpAn8jKdGnKxJq+VpVHdDovUeASn1zc90uzpEF30aJIwn6D2E=@vger.kernel.org
X-Gm-Message-State: AFuF++noeDt/Muq9SxkyF51xHRfOrkQr88OpPlN1nsYjuDd5DTqD+Jlm
	6M9q8DatzvhHiYD4ClinhxPIUtHLyglXQiOyI+sSTtXVlNIe0NxTQSpMsyoiy+1ErCFBed+LS8q
	TV3X4VW5jEID+2h38kfocPQevxJgb5UE=
X-Received: by 2002:a17:906:ba82:b0:c19:5572:d234 with SMTP id
 a640c23a62f3a-c25b3bb9038mr73788266b.1.1788185243242; Mon, 31 Aug 2026
 07:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814094738.2552440-1-cui.tao@linux.dev>
In-Reply-To: <20260814094738.2552440-1-cui.tao@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 31 Aug 2026 22:07:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H73i_hH75rNL_eKQWrxu3HTWhMgJpbkYqueoc4qb97TXQ@mail.gmail.com>
X-Gm-Features: AcwNN1WKhCQRqFpOy9hh68FYTR1pzxYaK_SVNxDleYQh6woMV8BDrJ8ZU1L6SKY
Message-ID: <CAAhV-H73i_hH75rNL_eKQWrxu3HTWhMgJpbkYqueoc4qb97TXQ@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: KVM: Fix TOCTOU race on pv_features
To: Tao Cui <cui.tao@linux.dev>
Cc: maobibo@loongson.cn, zhaotianrui@loongson.cn, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tao Cui <cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

What do you think about this?


Huacai

On Fri, Aug 14, 2026 at 5:47=E2=80=AFPM Tao Cui <cui.tao@linux.dev> wrote:
>
> From: Tao Cui <cuitao@kylinos.cn>
>
> The check-then-set on kvm->arch.pv_features in
> kvm_loongarch_cpucfg_set_attr() is lockless, so two vCPUs can race
> past the validation and set different values.  Add a spinlock to
> serialize it.
>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>
> Changes in v2: use a spinlock instead of a cmpxchg loop (Bibo Mao).
> Changes in v3: rename the lock to pv_setting_lock and place it next to
> phyid_map_lock (Huacai Chen).
>
> v1: https://lore.kernel.org/all/20260810081321.157258-1-cui.tao@linux.dev=
/
> v2: https://lore.kernel.org/all/20260813232542.2098930-1-cui.tao@linux.de=
v/
>
>  arch/loongarch/include/asm/kvm_host.h | 1 +
>  arch/loongarch/kvm/vcpu.c             | 6 +++++-
>  arch/loongarch/kvm/vm.c               | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/inclu=
de/asm/kvm_host.h
> index 23cfbecebbd7..3538a199aac6 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -125,6 +125,7 @@ struct kvm_arch {
>         unsigned int  pte_shifts[MAX_PGTABLE_LEVELS];
>         unsigned int  root_level;
>         spinlock_t    phyid_map_lock;
> +       spinlock_t    pv_setting_lock;
>         struct kvm_phyid_map  *phyid_map;
>         /* Enabled PV features */
>         unsigned long pv_features;
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 20c207d80e31..e47fa463a8be 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1165,10 +1165,14 @@ static int kvm_loongarch_cpucfg_set_attr(struct k=
vm_vcpu *vcpu,
>                         return -EINVAL;
>
>                 /* All vCPUs need set the same PV features */
> +               spin_lock(&kvm->arch.pv_setting_lock);
>                 if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
> -                               && ((kvm->arch.pv_features & valid) !=3D =
val))
> +                               && ((kvm->arch.pv_features & valid) !=3D =
val)) {
> +                       spin_unlock(&kvm->arch.pv_setting_lock);
>                         return -EINVAL;
> +               }
>                 kvm->arch.pv_features =3D val | LOONGARCH_PV_FEAT_UPDATED=
;
> +               spin_unlock(&kvm->arch.pv_setting_lock);
>                 return 0;
>         default:
>                 return -ENXIO;
> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 1317c718f896..86ba7d54e81f 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
> @@ -76,6 +76,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long typ=
e)
>                 return -ENOMEM;
>         }
>         spin_lock_init(&kvm->arch.phyid_map_lock);
> +       spin_lock_init(&kvm->arch.pv_setting_lock);
>
>         kvm_init_vmcs(kvm);
>         kvm_vm_init_features(kvm);
> --
> 2.43.0
>
