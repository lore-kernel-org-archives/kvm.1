Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20304772B5
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145238; cv=none; b=JRg4frpYqy8RoxIqp0Q1LZnS5ixT7LaEzVB9T1k+sF7IoM7f/XGjA9Ud4M6PGBYhgOIHVoYHVFLcZti1LkJTvOGRC87osdK6rqoBzmRU7fyg7u0if5MfNN941YbQmsNNSK+XOdY0mDX+Wc00HVkm6OjasB4stZHFxsRDOegidBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145238; c=relaxed/simple;
	bh=lXDU/ZpUNPUgFD+XotvjlxDVn1vbaoykba7e5YS1FHs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YxwTVyIv8hBknBN0NgUfdLFG8Pg4gTi1ZfObgVd8+kq/tZ0TgnmVkayhKQK/RbscIoD9n9U0SDLJ0NagFtnzts4LUVvD8d7k2Rdza5OzXDD0r425Mc7OHnXjisVQEbc6xVd3mCaHHyVS2QwweoK6NRbxFIAe8JIWB+llfqb2BxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdM99UTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdM99UTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47851F000C5;
	Fri, 16 Oct 2026 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145236;
	bh=Pg1wURaZtpJhqmR1/JldLnceqIw8L4F28UbVKiuf77Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kdM99UTgYsXutj8E2j2n6JoXsZTI6ab+ljczIRLWSu9iK7jrTmI1u5EXonZi03I2B
	 /0ohgBT9vpT6FS3jWmuo3EDEyOZ7VuL6Q95WeI6LysQ3LFXP0VhU5B6kVrsv+1mkvP
	 yJHTQA13QOHA0vYS6MP6pOvHv9nvxq/kqqexF+si25ID0rqydUbBTDDKBz6Uvo1bwv
	 vUNKWiLzpehpDqoYcBMwLwOKFpOCccbxllmnwttOOuxEUtAXFh1ywxOKUivY11sPGq
	 gmxXCV4sfooiyDqdox6GiU3WtFVIZZcGteCRjmZvGdz/yrCwV2dCQ9V7YsVNoiRKkV
	 FDBxAeeFTGqWw==
Message-ID: <sashiko-outbox-174122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] LoongArch: KVM: Clear device pointer in irqchip
 destroy callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261016095151.1155049-2-cui.tao@linux.dev>
References: <20261016095151.1155049-1-cui.tao@linux.dev>
 <20261016095151.1155049-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:07:13 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] kvm: NULL pointer dereference in lockless IRQ injection paths
- [High] kvm: loongarch: UAF window in kvm_dmsintc_destroy due to wrong kfr=
ee order
--

commit b63c6600199f59512e0a9603666fb0590806637a
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Clear device pointer in irqchip destroy callbacks
   =20
This commit clears the irqchip device pointers when destroying devices to
prevent dangling pointers from being dereferenced if device creation fails
later.

> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/=
dmsintc.c
> index ff327b4c05f7e..c182185a3d592 100644
> --- a/arch/loongarch/kvm/intc/dmsintc.c
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> @@ -146,6 +146,7 @@ static void kvm_dmsintc_destroy(struct kvm_device *de=
v)
>  		return;
> =20
>  	kfree(dev->kvm->arch.dmsintc);
> +	dev->kvm->arch.dmsintc =3D NULL;

[Severity: High]
Does this create a Use-After-Free window? The memory is freed before the
globally visible pointer is cleared. If KVM_CREATE_DEVICE succeeds but a
subsequent error (e.g. in anon_inode_getfd) triggers ops->destroy(), this
invokes kvm_dmsintc_destroy() while concurrent threads can still access the
pointer.

Should the pointer be cleared before calling kfree(), as is correctly done
for the other irqchip devices in this patch?

>  	kfree(dev);
>  }
> =20

[ ... ]

> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> index 220fc23ffe8cf..dab2d3f1b8f62 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -483,6 +483,7 @@ static void kvm_pch_pic_destroy(struct kvm_device *de=
v)
> =20
>  	kvm =3D dev->kvm;
>  	s =3D kvm->arch.pch_pic;
> +	kvm->arch.pch_pic =3D NULL;

[Severity: Critical]
Does setting this pointer to NULL introduce a NULL pointer dereference in t=
he
concurrent lockless IRQ injection paths?

If a user-space process maps GSI routing to an irqchip and races KVM_IRQ_LI=
NE
or KVM_IRQFD interrupt injection against a failing KVM_CREATE_DEVICE ioctl
(e.g. by hitting the process RLIMIT_NOFILE limit), this teardown path will
assign NULL to the irqchip pointer.

Concurrently, the IRQ injection path locklessly invokes routing callbacks
like kvm_set_pic_irq() which pass the potentially NULL kvm->arch.pch_pic in=
to
pch_pic_set_irq():

arch/loongarch/kvm/irqfd.c:kvm_set_pic_irq() {
    ...
    pch_pic_set_irq(kvm->arch.pch_pic, e->irqchip.pin, level);
    ...
}

The pointer is then unconditionally dereferenced:

arch/loongarch/kvm/intc/pch_pic.c:pch_pic_set_irq() {
    ...
    spin_lock(&s->lock);
    ...
}

A similar pattern exists for eiointc_set_irq() in
arch/loongarch/kvm/intc/eiointc.c.

Are NULL guard checks needed in the concurrent readers to safely handle this
regression?

>  	/* unregister pch pic device and free it's memory */
>  	mutex_lock(&kvm->slots_lock);
>  	kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &s->device);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016095151.1155=
049-1-cui.tao@linux.dev?part=3D1
