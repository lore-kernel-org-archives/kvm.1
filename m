Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F40A519DE9
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678570; cv=none; b=osxkH4Nx66ZeOMcytjMa8GVSvSmMTdS6Msbrr6oWGAIUM8oBViXRV0hlEhYpYauxm63/36Mkzq++WxvF+npEmCK93z82JFnetK3XQ3sUjljT6OqFHJJEY2Dg+VPbdr55ANcGa5sQZSbM41WufMA3tbGvgZF+hib3/dhC2l3S7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678570; c=relaxed/simple;
	bh=rn5Gt3VFfBE5dKlYdI4q200gMKtpnsxlNkM21kxz64Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XlLbUwOkavbV//TfSho+aHj91OVI/rtNG8VBjXjOMKutxI9+iJd45mjh+trm/trmhA2Lh/j1SERjv7RLtRTue+tmpgz2+yIDjBBYrVxA/PQMwJhGhYLBmTB2hqi97rmCTIoylSXi3ff9PupdcQJErW8RXx6qWzVxnaAau3kq7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAO+Kju/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAO+Kju/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431EC1F000FF;
	Tue, 29 Sep 2026 10:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790678551;
	bh=/R8pcZIGRThEQoVJHLHwhIMkJKVMFXKW85XHUDhOeoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jAO+Kju/6arejod0esvLWepKArDD8EZ6l0J06c5ZeLdZI43ZEcSap2oGOwYlm66SY
	 s68/mAXPixv5TouGeG/lhvfNOWY2usnODIXlgaHpjK3f8oMGvucZTmzXbKeOsQIoYK
	 nPZh9xUCmUik650GbKlKKkZbFj6akA9k+p50wwJHPwX+8enuF83YkHXD7ZseMtoxKx
	 ik555fkEE4V1Em3YgA/BH4hlmInVhJiqh6lZaxhyb21WeT7gUNDB5hcFxn4sO040pP
	 uMMlOD3F8gW9fyElAvVoWUZrRd7LssR1AAUs5w2Lj4H+yS70Lclv1gsyOmyfisYOY1
	 eeqHBpUkwjxYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] LoongArch: KVM: Clear device pointer in irqchip
 destroy callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260929102821.36112-2-cui.tao@linux.dev>
References: <20260929102821.36112-1-cui.tao@linux.dev>
 <20260929102821.36112-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 10:42:30 +0000
Message-Id: <20260929104231.431EC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kvm: loongarch: NULL deref and UAF via lockless irqchip destru=
ction
--

commit 1d2bf4dc9e1262efde3462bede6b473d0a4a01e5
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Clear device pointer in irqchip destroy callbacks

The commit clears device pointers in the destroy callbacks for the four
LoongArch irqchip devices to prevent dangling pointers. This addresses an
issue where anon_inode_getfd() failures during KVM_CREATE_DEVICE can
leave the VM alive with a freed irqchip device.

> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/=
dmsintc.c
> index bb7285c49df3a..4bd98b888e3f1 100644
> --- a/arch/loongarch/kvm/intc/dmsintc.c
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> @@ -166,6 +166,7 @@ static void kvm_dmsintc_destroy(struct kvm_device *de=
v)
>  		return;
> =20
>  	kfree(dev->kvm->arch.dmsintc);
> +	dev->kvm->arch.dmsintc =3D NULL;

[Severity: Critical]
Does setting this pointer to NULL after freeing it leave a window open for
a use-after-free?

If anon_inode_getfd() fails during KVM_CREATE_DEVICE, the error path
calls ops->destroy() locklessly. At the same time, concurrent KVM_IRQ_LINE
requests can locklessly invoke kvm_set_irq(), which drops kvm->irq_srcu
before calling the routing callbacks.

If those callbacks read the pointer between the kfree() and this NULL
assignment, won't they dereference freed memory? Does this ordering defeat
any READ_ONCE() fixes intended for concurrent lockless readers?

[ ... ]

> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> index e7b77705c516a..5d046a1cab4e2 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -480,6 +480,7 @@ static void kvm_pch_pic_destroy(struct kvm_device *de=
v)
> =20
>  	kvm =3D dev->kvm;
>  	s =3D kvm->arch.pch_pic;
> +	kvm->arch.pch_pic =3D NULL;

[Severity: Critical]
Can assigning NULL here without synchronization lead to a deterministic NULL
pointer dereference and host panic?

If kvm->arch.pch_pic is set to NULL locklessly here, and a concurrent
KVM_IRQ_LINE ioctl calls into kvm_set_pic_irq(), the routing table
execution happens after kvm_set_irq() drops irq_srcu:

virt/kvm/irqchip.c:kvm_set_irq() {
    ...
    idx =3D srcu_read_lock(&kvm->irq_srcu);
    i =3D kvm_irq_map_gsi(kvm, irq_set, irq);
    srcu_read_unlock(&kvm->irq_srcu, idx);

    while (i--) {
        int r;
        r =3D irq_set[i].set(&irq_set[i], kvm, irq_source_id, level,
                           line_status);
    ...
}

The callback kvm_set_pic_irq() then blindly passes the newly-NULL pointer
to pch_pic_set_irq() without checking it:

arch/loongarch/kvm/irqfd.c:kvm_set_pic_irq() {
    ...
    pch_pic_set_irq(kvm->arch.pch_pic, e->irqchip.pin, level);
    ...
}

Since pch_pic_set_irq() unconditionally dereferences the pointer:

arch/loongarch/kvm/intc/pch_pic.c:pch_pic_set_irq() {
    ...
    spin_lock(&s->lock);
    ...
}

Doesn't this mean an unprivileged userspace process exhausting file
descriptors and concurrently injecting interrupts will trigger a host panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929102821.3611=
2-1-cui.tao@linux.dev?part=3D1
