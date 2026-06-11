Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBDB3B8920
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162007; cv=none; b=eIBUuIuYvErnnVKz8Y2pkqDYBK4s00CTpUdQwwfo65e5BnRw+xqk99JXiuZszBZy/xx8O/ZIiKZMjylb7WyhIITXUQkg5Gq7nBsKSc1ltKVE866dEufKK9SXpZY32sq6CeXaeO+ttbdnQ9yV1WyxqYGPR3XODkfjYqmF6N/tgDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162007; c=relaxed/simple;
	bh=mmgDAIz5kampmpmRvPnP6cNgIueYwDFZWGJk2d6oaVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cih8kv34tu6qq5wAaGXllSGBGSg4hmrCr8Jbql37ho0Zdl74z8DhF+pvVbXVeYNdm65IqjD0ayZ10o4evBcgIxSvVULQgbCTP35KxifCOPmudLtqCrg7Hhp0Fo3EYqmmNNvHQQ8MOAiRAtEzw/CWs7lcu1vYiFxSoNa8FiBeEPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEsSZArm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEsSZArm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEA71F00893;
	Thu, 11 Jun 2026 07:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781162005;
	bh=S+ZG+58REGVGuyJgxHfckKS48mHvover8fk+nnZ1gNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LEsSZArmtLZwntexlFP+rFHQ4BGuBhKU1Pks5KkS1G0O3rocdii0t9ccrusI8E/oi
	 kL/INtkRdUDqwxzL8McnzGdjVle5CHbeWwRS9KXjpjwQX7AggHoEk74hgvALE7cgHF
	 uKdnHfFWb5c3acRn5G/e/DOVwebPvSb1uhcA6v1jhebo9EX+s1H2Ht4Uyl6qwzJ2xm
	 pTIscW/qr3ZNQoL2eos9FchSYbMM3OrldmPSoSc5VpqZC1EcKH/waAHjiaeftgusJx
	 jvhwAfp0CDuGvGO7lNRootFoEghLEpjWnTZ/HtMy9jQf5CE8HsKR0I/MY2I1u3W3MU
	 JPCwk7fXlsaIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6] LoongArch: KVM: Check msgint feature in
 interrupt post
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260611065815.1439154-3-maobibo@loongson.cn>
References: <20260611065815.1439154-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 07:13:25 +0000
Message-Id: <20260611071325.ADEA71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Uninitialized variable `vector` array leads to host stack data=
 leakage and guest state corruption.
- [High] Missing memory barriers between writing the MSI vector map and set=
ting the interrupt pending flag causes lost interrupts.
--

commit 7cbebc4f6556c5cec6e10f7b92d02d8b3f478b95
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Check msgint feature in interrupt post

Interrupt AVEC is valid only if VM has msgint feature, and this feature
is checked in interrupt handling. Since interrupt handling is executing
in VM context switch, and it is hot path, here move the feature checking
in interrupt post rather than interrupt handling.

> diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrup=
t.c
> index a18c60dffbbae..48dd56aa4dc56 100644
> --- a/arch/loongarch/kvm/interrupt.c
> +++ b/arch/loongarch/kvm/interrupt.c
> @@ -36,8 +36,6 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsig=
ned int priority)
> =20
>  	switch (priority) {
>  	case INT_AVEC:
> -		if (!kvm_guest_has_msgint(&vcpu->arch))
> -			break;
>  		dmsintc_inject_irq(vcpu);

[Severity: Critical]
This is a pre-existing issue, but in dmsintc_inject_irq() the vector array
is declared uninitialized:

arch/loongarch/kvm/intc/dmsintc.c:dmsintc_inject_irq() {
	unsigned long vector[4], old;
	...
	for (i =3D 0; i < 4; i++) {
		old =3D atomic64_read(&(ds->vector_map[i]));
		if (old)
			vector[i] =3D atomic64_xchg(&(ds->vector_map[i]), 0);
	}

	if (vector[0]) {
		...
}

If vector_map[i] is zero, vector[i] retains uninitialized stack memory.
Because the check if (vector[i]) evaluates this garbage, could this
unconditionally write uninitialized host stack data into the guest's ISR
registers and corrupt the guest's interrupt state?

>  		fallthrough;
>  	case INT_TI:

[ ... ]

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index df5be9b265e8d..e986146d22724 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1493,6 +1493,9 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,=
 struct kvm_interrupt *irq)
>  	if (vector >=3D EXCCODE_INT_NUM)
>  		return -EINVAL;
> =20
> +	if (!kvm_guest_has_msgint(&vcpu->arch) && (vector =3D=3D INT_AVEC))
> +		return -EINVAL;
> +
>  	if (intr > 0)
>  		kvm_queue_irq(vcpu, intr);

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing memory
barrier in the producer/consumer paths for MSI injection?

In dmsintc_deliver_msi_to_vcpu(), we update the vector map and then queue
the interrupt notification without a write barrier:

arch/loongarch/kvm/intc/dmsintc.c:dmsintc_deliver_msi_to_vcpu() {
	...
	set_bit(vector, (unsigned long *)&ds->vector_map);
	kvm_vcpu_ioctl_interrupt(vcpu, &vcpu_irq); // calls kvm_queue_irq()
}

On the consumer side, kvm_deliver_intr() reads irq_pending and calls
kvm_irq_deliver(), which clears the pending bit and reads the vector map:

arch/loongarch/kvm/interrupt.c:kvm_deliver_intr() {
	...
	for_each_set_bit(priority, pending, EXCCODE_INT_NUM)
		kvm_irq_deliver(vcpu, priority);
}

Since set_bit() doesn't imply a memory barrier, could the CPU reorder the
writes, causing the consumer to see a pending interrupt but an empty
vector_map, leading to permanently lost MSI interrupts?

>  	else if (intr < 0)
>  		kvm_dequeue_irq(vcpu, -intr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611065815.1439=
154-1-maobibo@loongson.cn?part=3D2
