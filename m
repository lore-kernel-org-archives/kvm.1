Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FB243CE77
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695844; cv=none; b=Mqkb4Cf412oMNF0Rdxzl8msFwvQrORfoSs36Vq2aKH3EihqtcvYyRoKCG9S71esOGmcJeo78jO4+J6ysssX8x+kqz5i8bSHUkv3d1oxroO3kGfldhrQ32IvgE7gqrxJNT/IkMt9TwjtlG+wuovJMHuRf+L73SYuDj2Ss23TwYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695844; c=relaxed/simple;
	bh=wR/C1kAtiHxDqpvh2S+uIo9Vv3OJqdF6tLmrJLhlvpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pgnakx6y86PqGfj6cxtyzq3iRZaStaT9sOCfJUOs7G0Q5s5wN0GCK7dH9HR/vqjHp40Dc1bQtmjkpC+8xUfzt1yj+Ngpw2dRCyHaQbazq6i4HbEEggWDTP4tCqQcjj3qYzvXBdJuG8N6LPAhmthAkJbPzLyZiefBtTtfxyFnK+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPAWGJsF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPAWGJsF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9FC1F00A3A
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786695842;
	bh=0hqmR9c3eXhhXW7cmtY2SuWIqL7AV95zNfMVB0Hvwi4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mPAWGJsF+ipfsqU9Axap3U9gkJOHD9m3hfjIt0F4AEJwVTb6GWHddtm6+VPmU6Bc8
	 E67zEKQcAcGAE6qwkBfJLHtlfzTIY9AXMvOO3UDFFs2OgOFtF7O6UdxoJvMEWs5tdL
	 JAGjXmiqPpnjNSjJYfyq9Rskxe5VDmDHCF2XkKyXkEMMRg96gnohfZrT/i5t9/avR7
	 5TY/l7wjzjxAqH74yf1rCS6nejtW+Wok7VpSa831dvoNXwsdR0K79/oWKXbiFykdS8
	 FKQwvTgZj2KWrNDUZ9ZA1RrCaETOSg8PhiIrOFrUc+4vYfiLtnDZmBupokqGor3q6H
	 RGJ5mCIYD8wSg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso1080179a12.0
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 01:24:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpFryiymGns28HIjsoUhMcfj5EoEBHvug68BbAS8r4JwmKSRt8V69sUCOFUaJJEkcRlC/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8BFYEss4WMyhe/c4YwQQr/BaXItFjxZu5tRKBr8k+q+D9gzN
	xMKvADQ8wMT/zgd9s+JgMi/4JKf8SB9U00rZZk4P1qYhrc1MzI4fO7+X9pnSZiqZIjjApStd57M
	eHWuzc7drxz54hw4n64l3ry3iqPQSkz4=
X-Received: by 2002:a05:6402:2499:b0:6a0:9468:a025 with SMTP id
 4fb4d7f45d1cf-6a38a987f5emr1870736a12.15.1786695840548; Fri, 14 Aug 2026
 01:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813232542.2098930-1-cui.tao@linux.dev> <d26fdd03-dcfe-8ae0-d925-d121866e566d@loongson.cn>
In-Reply-To: <d26fdd03-dcfe-8ae0-d925-d121866e566d@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 14 Aug 2026 16:24:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7b1sjB_-nP_UUN-rgv22YcPoiUAZDVfnDxHMs3cERWCQ@mail.gmail.com>
X-Gm-Features: AUfX_mxWyDA1cTYIFkL42OxEwPe6ykxpQPlyZVW-jBB2ME5eEmgky5lvPETXtBc
Message-ID: <CAAhV-H7b1sjB_-nP_UUN-rgv22YcPoiUAZDVfnDxHMs3cERWCQ@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: KVM: Fix TOCTOU race on pv_features
To: Bibo Mao <maobibo@loongson.cn>
Cc: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tao Cui <cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tao,

On Fri, Aug 14, 2026 at 9:09=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2026/8/14 =E4=B8=8A=E5=8D=887:25, Tao Cui wrote:
> > From: Tao Cui <cuitao@kylinos.cn>
> >
> > The check-then-set on kvm->arch.pv_features in
> > kvm_loongarch_cpucfg_set_attr() is lockless, so two vCPUs can race
> > past the validation and set different values.  Add a spinlock to
> > serialize it.
> >
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> > ---
> >
> > Changes in v2: use a spinlock instead of a cmpxchg loop (Bibo Mao).
> > Link: https://lore.kernel.org/all/20260810081321.157258-1-cui.tao@linux=
.dev/
> >
> >   arch/loongarch/include/asm/kvm_host.h | 2 ++
> >   arch/loongarch/kvm/vcpu.c             | 6 +++++-
> >   arch/loongarch/kvm/vm.c               | 1 +
> >   3 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/inc=
lude/asm/kvm_host.h
> > index 23cfbecebbd7..cdbbd90e0584 100644
> > --- a/arch/loongarch/include/asm/kvm_host.h
> > +++ b/arch/loongarch/include/asm/kvm_host.h
> > @@ -128,6 +128,8 @@ struct kvm_arch {
> >       struct kvm_phyid_map  *phyid_map;
> >       /* Enabled PV features */
> >       unsigned long pv_features;
> > +     /* Serializes pv_features updates */
> > +     spinlock_t pv_features_lock;
I think it is better to rename it to pv_setting_lock, and put it near
phyid_map_lock.

Huacai

> >       /* Supported KVM features */
> >       unsigned long kvm_features;
> >
> > diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> > index 20c207d80e31..551ed39b2d1f 100644
> > --- a/arch/loongarch/kvm/vcpu.c
> > +++ b/arch/loongarch/kvm/vcpu.c
> > @@ -1165,10 +1165,14 @@ static int kvm_loongarch_cpucfg_set_attr(struct=
 kvm_vcpu *vcpu,
> >                       return -EINVAL;
> >
> >               /* All vCPUs need set the same PV features */
> > +             spin_lock(&kvm->arch.pv_features_lock);
> >               if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
> > -                             && ((kvm->arch.pv_features & valid) !=3D =
val))
> > +                             && ((kvm->arch.pv_features & valid) !=3D =
val)) {
> > +                     spin_unlock(&kvm->arch.pv_features_lock);
> >                       return -EINVAL;
> > +             }
> >               kvm->arch.pv_features =3D val | LOONGARCH_PV_FEAT_UPDATED=
;
> > +             spin_unlock(&kvm->arch.pv_features_lock);
> >               return 0;
> >       default:
> >               return -ENXIO;
> > diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> > index 1317c718f896..b984cc54f305 100644
> > --- a/arch/loongarch/kvm/vm.c
> > +++ b/arch/loongarch/kvm/vm.c
> > @@ -76,6 +76,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long t=
ype)
> >               return -ENOMEM;
> >       }
> >       spin_lock_init(&kvm->arch.phyid_map_lock);
> > +     spin_lock_init(&kvm->arch.pv_features_lock);
> >
> >       kvm_init_vmcs(kvm);
> >       kvm_vm_init_features(kvm);
> >
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>
