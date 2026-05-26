Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4CD402B9E
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807979; cv=none; b=uvA/AObqtZvp9/MpbL66cxewP1+Z/iNANFP22CB4X0dTNklg0Q3DJCV5hMhAYZrmOZ4viGkNfpizBjNya3nm1pSNjk8grUevaDiDez/b89qQLuagObfzmZJVb/OYyEimhGOtIOakmmVUIsJawX7hlVK9XarZQhhzbExsZk7D2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807979; c=relaxed/simple;
	bh=yC1gJC0wGbY4EXVX+u2WSQKoe9np/z92NVvYENVx2xE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lJngEthIpLOswU0/KUKaXHml1iykthC5/IwCguyp6viAU0ZS0iqe7kwTqg0leil3HB1xk+cZBzGXN/ISygEVWv3tag5UVqsEEKj20qoFW6AUWOOBJzR0U2IEr0A77wTmBLN/Ywti2Fem5WfJ6EPL3O8e6zGc7mGflLMG+wTwvCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUkvc9LX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUkvc9LX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4721A1F00A3A;
	Tue, 26 May 2026 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807976;
	bh=waNCF2Cdqfr1xHDjy6aWA/CPgoyA4TWHeeJ8oaxZSqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TUkvc9LX+LPqRSlQNbIRYUrqJE0uA5PNKd7sKDq6KKO4WMHtRok6h9xoI7iqJkerR
	 8Y5Cdlc+Gz5iqUAvPLJLo4oDfomhjuz5/XPR5NiGoF2hWjUjsRnRBVsfzQbGqJbk6L
	 3Wd7cqGeLKpqglGplBow9JORztWwR7uuSOeN56XmxVcpai3UJoyH+DZafePrJ1kyY0
	 HoAHZJvuzQ75LsTlcUPDkV5/a9daR6Hu0rT4No0VDLgXESSVP754gw2lxesCJ+/1gn
	 V1y2wP5s2Qqu/y1QlQhivHHT3YIJu0GblX7vVXXHeXkDIYdzHElghACRjpen6+sXT4
	 SsoKuJ/Fl3DfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] LoongArch: KVM: Inject interrupt with batch
 method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526125256.2511876-5-maobibo@loongson.cn>
References: <20260526125256.2511876-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 15:06:15 +0000
Message-Id: <20260526150616.4721A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Dangling pointer in kvm->arch.dmsintc can lead to Use-After-Fr=
ee on KVM device creation failure.
- [High] Uninitialized stack array `vector` is used to branch and silently =
corrupt guest hardware CSRs.
--

commit c99b04775d4df30c8c3b8ac62860cd645d5d2d98
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Inject interrupt with batch method

This patch updates interrupt injection to use a bitmask and batch method=20
rather than injecting interrupts one by one. It also removes the unused=20
priority_to_irq[] array.

> diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrup=
t.c
> index 48dd56aa4dc56..50081484336eb 100644
> --- a/arch/loongarch/kvm/interrupt.c
> +++ b/arch/loongarch/kvm/interrupt.c
> @@ -9,39 +9,16 @@
>  #include <asm/kvm_vcpu.h>
>  #include <asm/kvm_dmsintc.h>
> =20
[ ... ]
> -static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
> +static void kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned long mask)
>  {
> -	unsigned int irq =3D 0;
> +	unsigned long irq;
>  	unsigned long old, new;
> =20
> -	clear_bit(priority, &vcpu->arch.irq_pending);
> -	if (priority < EXCCODE_INT_NUM)
> -		irq =3D priority_to_irq[priority];
> -
> -	switch (priority) {
> -	case INT_AVEC:
> -		dmsintc_inject_irq(vcpu);
> -		fallthrough;
> -	case INT_TI:
> -	case INT_IPI:
> -	case INT_SWI0:
> -	case INT_SWI1:
> +	irq =3D mask & KVM_ESTAT_IRQ_MASK;
> +	if (irq) {
> +		if (irq & CPU_AVEC)
> +			dmsintc_inject_irq(vcpu);

[Severity: Critical]
This isn't a bug introduced by this patch, but looking at the dmsintc device
code, can a dangling pointer lead to a Use-After-Free on KVM device creation
failure?

If KVM device creation fails at anon_inode_getfd() in
kvm_ioctl_create_device(), the cleanup path calls ops->destroy()
(kvm_dmsintc_destroy()).

kvm_dmsintc_destroy() frees dev->kvm->arch.dmsintc via kfree() but does not
set kvm->arch.dmsintc to NULL.

Because the KVM VM instance is not destroyed on device creation failure, ca=
n a
userspace program subsequently trigger interrupt injections (e.g. via the
KVM_IRQ_LINE ioctl) which route to pch_msi_set_irq()?

Since this function conditionally accesses kvm->arch.dmsintc->msg_addr_base,
does this lead to a fully triggerable Use-After-Free that can result in a h=
ost
kernel crash or privilege escalation?


[Severity: High]
This is a pre-existing issue, but does dmsintc_inject_irq() use an
uninitialized stack array that can silently corrupt guest hardware CSRs?

In dmsintc_inject_irq(), the array unsigned long vector[4] is declared on
the stack without initialization:

arch/loongarch/kvm/intc/dmsintc.c:dmsintc_inject_irq() {
	...
	unsigned long vector[4], old;
	...
	for (i =3D 0; i < 4; i++) {
		old =3D atomic64_read(&(ds->vector_map[i]));
		if (old)
			vector[i] =3D atomic64_xchg(&(ds->vector_map[i]), 0);
	}

	if (vector[0]) {
		old =3D kvm_read_hw_gcsr(LOONGARCH_CSR_ISR0);
		kvm_write_hw_gcsr(LOONGARCH_CSR_ISR0, vector[0] | old);
	}
	...
}

The for loop assigns to vector[i] only if ds->vector_map[i] is non-zero. If
it is zero, vector[i] remains uninitialized.

The code then evaluates if (vector[0]) and other array elements.

If the stack garbage happens to be non-zero, it reads the guest's CSR and
writes vector[i] | old back, corrupting the guest's LOONGARCH_CSR_ISR0 (and
others) with host kernel stack data.

Can this cause unpredictable guest behavior or act as an information leak f=
rom
the host kernel to the guest?

> +
>  		old =3D kvm_read_hw_gcsr(LOONGARCH_CSR_TVAL);
>  		set_gcsr_estat(irq);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526125256.2511=
876-1-maobibo@loongson.cn?part=3D4
