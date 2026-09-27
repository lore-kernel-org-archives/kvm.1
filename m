Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84B3876CD
	for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790496302; cv=none; b=Koq2RQe9a5g6QILP6xZIdZn0vDMPIzhNU3AiLy2TlHRKNMMbgAcUkmthIvv/Sr+ePI7H/34StUWztzv+0My0ya2m0u0Fnm4I1et4mpiKkL2xctj4yOe98zw+QVl/4VblHU9JMm+93yKHV89olksnIQn8y6UZXAp/cLURKfsBlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790496302; c=relaxed/simple;
	bh=jokSKFB/N9WkFUXBJZswI6iJKEJnQF6V3/zesAljNe0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HAuy24x7RBt9HoLxq59RBrwOBPb1kXRDEWpyiib57gVPpny4H4Fng+kq7YnoCTAKiT8ZxV+btiCE0Yaww4utAq91NZTkTm1BGHLLIrQecWFkCcjYSPtI2GfvdKM8tyAioTbxiTRIzp1mIbMQgNGHdo4czVnUb9+lTFqO9xCDKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1prqNpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1prqNpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BC61F000FF;
	Sun, 27 Sep 2026 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790496301;
	bh=ZB/MXrTsRajs21sersAfuUhWTl980+9WcbXgO91mWCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1prqNpnLelquyyWCnjghfBsw07FR62cLyDJSDDSE04UTXwdWdyn0Xc4iGNCtkZIu
	 frOMDTa4oY3ilD3MeWBWuYyCel/ornkRi07mGQUskbZ6nUF4+EF76viwYTAFggvVbk
	 va8hWZTcL2MjULuiZk9w+VZUfkbeeabHPgI6l3tQHWjzx7j77lndTyUn7uzsJDJVzu
	 1kS0ysK8bjBf5XhJpv22GOvp2fC5xMTRwJ1RRT90/QYVurJx61v2pFs3AmgiBgaHSh
	 vOlGeyFfY+4cGyDwuRY+fxTALK2EoAR0m7QxsyrkQzCW49QXP9sJzGdhOpaLGUqubz
	 uJkHeFrd4WunQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] LoongArch: KVM: Load dmsintc pointer once in
 pch_msi_set_irq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260927075240.3007947-4-cui.tao@linux.dev>
References: <20260927075240.3007947-1-cui.tao@linux.dev>
 <20260927075240.3007947-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 08:05:00 +0000
Message-Id: <20260927080500.C4BC61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: missing READ_ONCE() allows TOCTOU NULL dereference in MSI rou=
ting
--

commit f8043137fe3c6524e920d9def763b80d52f1f8ae
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Load dmsintc pointer once in pch_msi_set_irq

This commit attempts to fix a time-of-check to time-of-use race
condition by loading the kvm->arch.dmsintc pointer into a local variable
once before checking it. This is intended to prevent a concurrent device
removal from causing a NULL pointer dereference.

> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/=
dmsintc.c
> index 194b9f748550e..802c8f9920935 100644
> --- a/arch/loongarch/kvm/intc/dmsintc.c
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> @@ -70,11 +70,13 @@ int dmsintc_set_irq(struct kvm *kvm, u64 addr, int da=
ta, int level)
>  	unsigned int irq, cpu;
>  	struct kvm_vcpu *vcpu;
> =20
> -	if (!kvm->arch.dmsintc)
> +	struct loongarch_dmsintc *s =3D kvm->arch.dmsintc;

[Severity: High]
Does this assignment prevent the C compiler from reloading the pointer from
memory? Without a READ_ONCE() wrapper around kvm->arch.dmsintc, the compiler
is permitted to optimize away the local storage and emit multiple loads from
the shared memory location. This could reintroduce the exact race condition
and NULL pointer dereference that this patch is trying to fix.

> +
> +	if (!s)
>  		return -EINVAL;
> =20
>  	irq =3D (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
> -	cpu =3D (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mask;
> +	cpu =3D (addr >> AVEC_CPU_SHIFT) & s->cpu_mask;
>  	if (cpu >=3D KVM_MAX_VCPUS)
>  		return -EINVAL;

[ ... ]

> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> index 2ac207271bab1..3517dcc42d22d 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -74,10 +74,11 @@ void pch_pic_set_irq(struct loongarch_pch_pic *s, int=
 irq, int level)
>  int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry=
 *e, int level)
>  {
>  	u64 msg_addr =3D (((u64)e->msi.address_hi) << 32) | e->msi.address_lo;
> +	struct loongarch_dmsintc *dmsintc =3D kvm->arch.dmsintc;

[Severity: High]
Could the compiler similarly reload kvm->arch.dmsintc here since it lacks a
READ_ONCE() wrapper? It seems like multiple memory accesses could still occ=
ur
during the address-window comparison below, exposing the vulnerability
during concurrent device removal.

> =20
> -	if (cpu_has_msgint && kvm->arch.dmsintc &&
> -		msg_addr >=3D kvm->arch.dmsintc->msg_addr_base &&
> -		msg_addr < (kvm->arch.dmsintc->msg_addr_base + kvm->arch.dmsintc->msg_=
addr_size)) {
> +	if (cpu_has_msgint && dmsintc &&
> +		msg_addr >=3D dmsintc->msg_addr_base &&
> +		msg_addr < (dmsintc->msg_addr_base + dmsintc->msg_addr_size)) {
>  		return dmsintc_set_irq(kvm, msg_addr, e->msi.data, level);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927075240.3007=
947-1-cui.tao@linux.dev?part=3D3
