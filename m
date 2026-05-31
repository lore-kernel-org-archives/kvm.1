Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2586314A6F
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236562; cv=none; b=vB3c2kZCAFVOVVpg1kgWZ3PZeHmqn3Tph9ic6DgBo23qdKoPf5xNpmnkWqhqHU/oipezkfEaA71shMBwBL+Zj3UvvdYDU8ZVa8/HXYuLAdPpmF3kjA5lOlmIUqO0GVA5kdnTv2UZnywPzXku8IS2F/jGnOYVWjLC9lOx/7Dt8OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236562; c=relaxed/simple;
	bh=fGnWYL7NUHR0zP37Z2pO5HR9OVaMqsofqMj77pNcocU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=shRRdMgW1IQ3aD5KCyZhX2cHhGjj2tcx5EyOPVpooDUDP5sYeva++z4i/XWXKPcFtiYIWqDBROHKHPRWHdsgXKP8n5LKgoxgSJs9ZAxCyVjSt19IJXR4lc/Ry/g8fOKPLCvoNqIpPThEyi2MNXjBdgZT/iG5pORkniudEAUCqa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2R147vm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2R147vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1181F00893;
	Sun, 31 May 2026 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780236561;
	bh=3ipWzw30AKnGYj9fKZiV7EEIoEQ1jOSo1lrwCpcNYzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L2R147vmYhdAB5NeJDZB8jjJU1LShUWbMY1lxSp7xqiU5opYLYyKodu85tIfNREI3
	 GYSMdFciNvcMII9Idpfsa5o7/R5IOAYSol5bIaG/t1l1vInaxv9hrdPybHq5cwvl3W
	 Kyot0AS0qu42wk0bO2ghvZ35bEuFqAtnQj/YoDnIJ6jan4m5XDEP1FbifbV6kSZGSQ
	 mS0CCVhYHdovNaRlftb+ZLngoOBU3EA65LZH2a6gLmVzELpNcC28NSGAgUkXCTg8rR
	 +uof3sqU2C+5pxQnB049ypX6NcxM9NzllRGfmPupV3+2xuapEB5B3GNSe7Jkrd8FhD
	 VaZVeWYgqJnXQ==
From: sashiko-bot@kernel.org
Subject: Re: [v2 1/2] KVM: LoongArch: Validate irqchip index in irqfd
 routing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanfei Xu" <yanfei.xu@bytedance.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260531135326.2238555-2-yanfei.xu@bytedance.com>
References: <20260531135326.2238555-2-yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 14:09:20 +0000
Message-Id: <20260531140921.1B1181F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds check on the `e->msi.data` value before using i=
t as an `irq` index in `eiointc_set_irq()` leads to an out-of-bounds memory=
 read and write.
--

commit 217e342828fa29f1b763464cad52ec8a004759a7
Author: Yanfei Xu <yanfei.xu@bytedance.com>

KVM: LoongArch: Validate irqchip index in irqfd routing

This commit adds validation for the irqchip index and pin in the LoongArch
KVM irqfd routing setup to prevent out-of-bounds array access.

Closes: https://lore.kernel.org/kvm/20260525051714.485D51F000E9@smtp.kernel=
.org/

> diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
> index f4f953b224192..40ed1081c4b62 100644
> --- a/arch/loongarch/kvm/irqfd.c
> +++ b/arch/loongarch/kvm/irqfd.c
> @@ -51,7 +51,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
>  		e->irqchip.irqchip =3D ue->u.irqchip.irqchip;
>  		e->irqchip.pin =3D ue->u.irqchip.pin;
> =20
> -		if (e->irqchip.pin >=3D KVM_IRQCHIP_NUM_PINS)
> +		if (e->irqchip.pin >=3D KVM_IRQCHIP_NUM_PINS ||
> +		    e->irqchip.irqchip >=3D KVM_NR_IRQCHIPS)
>  			return -EINVAL;
> =20
>  		return 0;

[Severity: Critical]
This is a pre-existing issue, but does this code also need bounds checking
for the MSI routing case?

When handling KVM_IRQ_ROUTING_MSI in kvm_set_routing_entry(), we copy the
user-controlled ue->u.msi.data into e->msi.data without any validation:

    e->msi.data =3D ue->u.msi.data;

During MSI injection, kvm_set_msi() passes this value down to
pch_msi_set_irq(), which directly uses it as the irq parameter:

    eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);

Inside eiointc_set_irq(), this untrusted value is used as an index in
bitwise operations against s->isr and passed to eiointc_update_irq():

    level ? __set_bit(irq, isr) : __clear_bit(irq, isr);
    ...
    cpu =3D s->sw_coremap[irq];

Could this allow a malicious guest or unprivileged host userspace to perform
an out-of-bounds memory read and write against the eiointc allocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531135326.2238=
555-1-yanfei.xu@bytedance.com?part=3D1
