Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9B3F0AAC
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015104; cv=none; b=ohoAhF0aos+DyR/kX/gKLZBa+XcT0zgq+FG9zSq1AjWbIWt7c8BB7MsS+BLzb+1PQ9mA4U6vKjKiUb6Pvrd4AJFzhWpPnypWsDrdNjNA5pylgd3Rw9rVwxClDbaZrQkf0pEvXINrm24y4drnQSQAIelJVXvCNX00RhXdwcZnISo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015104; c=relaxed/simple;
	bh=viJEnnDzl9DNuZNFllYLGigvCscDs03s1QgImP3+7h8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DNiTPBTxK6DVedIrVALu+IWSrUWV2szU85cZGO3tgekvBaa8T+2b44mpS7nVkBRpC9z/8J7T/CoOy8JtYmoe8Z/t1z5ixKNLa36jAD2EgO8ZWMPlHeE4spW6k8nBbp7eyiWyf3lXtiv2zgpYBqJaq/Kxme38AGz1dnpMRu/Fl7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oj5jg1Z9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oj5jg1Z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66221F000E9;
	Tue, 14 Jul 2026 07:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784015098;
	bh=mOj5K4tn1T+wdr+Djz/oAA42vSAntfDDCIr1O4T1zlE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oj5jg1Z9WECQ/sWqy9BMydtlHR2yZ86IT+g0uzjI94iiVPVQapy1CKqWyT34uKmuu
	 AEmpcSqClXFwMnsBCQ9e3sF7N2ajHmxSdnHfRxugWncs1k8hvFkczt94eoScrTCOTb
	 xpJQV44pC3Frc0sOMpdQYP6WU843BMlAJmWdCM61xIJVTus/3OAS7lWJwBsHLSsw+J
	 5I1gqInr9dxhOErv+zcpPH3BBAnYhfJ3B8k6REvxH7M0OPyJLu+wskkrcDFzyQ8V+b
	 +6lhN5ni6Q6WioMe1PHMZocKfLLRnc3lyHIy5ZxcQ3fOsUhybk28cq+GCykH8jo6BV
	 vkMewFM4IZdtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] LoongArch: KVM: Fix uninitialized stack variable
 issue with dmsintc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714072520.2745942-2-maobibo@loongson.cn>
References: <20260714072520.2745942-1-maobibo@loongson.cn>
 <20260714072520.2745942-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:44:57 +0000
Message-Id: <20260714074458.B66221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing memory barriers in lockless MSI injection between `vector_=
map` and `irq_pending` can cause lost interrupts.
--

--- Patch [1]: [PATCH v5 1/5] LoongArch: KVM: Fix uninitialized stack varia=
ble issue with dmsintc ---
commit 9139baa9157d8865599df0b5b9ceaace254286a5
Author: Bibo Mao <maobibo@loongson.cn>
LoongArch: KVM: Fix uninitialized stack variable issue with dmsintc

This commit fixes an uninitialized stack variable array in=20
dmsintc_inject_irq() by explicitly initializing it to 0 when no=20
pending interrupts are found in the vector map.

> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/=
dmsintc.c
> index de25735ce0394..0a8492c4394c7 100644
> --- a/arch/loongarch/kvm/intc/dmsintc.c
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> @@ -21,6 +21,8 @@ void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
>  		old =3D atomic64_read(&(ds->vector_map[i]));
>  		if (old)
>  			vector[i] =3D atomic64_xchg(&(ds->vector_map[i]), 0);

[Severity: High]
This is a pre-existing issue, but is there a missing memory barrier in the
lockless MSI injection mechanism that synchronizes vector_map and irq_pendi=
ng?

On the producer side, dmsintc_deliver_msi_to_vcpu() lacks a memory barrier
(e.g., smp_wmb()) between setting the payload (vector_map) and the
notification flag (irq_pending):

arch/loongarch/kvm/intc/dmsintc.c:dmsintc_deliver_msi_to_vcpu() {
    ...
	set_bit(vector, (unsigned long *)&ds->vector_map);
	kvm_vcpu_ioctl_interrupt(vcpu, &vcpu_irq);
    ...
}

Since set_bit() does not imply a memory barrier, the host CPU could reorder
these stores.

If reordered, the consumer side might observe the irq_pending flag but
read a stale 0 from vector_map, especially since it uses xchg_relaxed():

arch/loongarch/kvm/interrupt.c:kvm_deliver_intr() {
    ...
	mask =3D READ_ONCE(vcpu->arch.irq_pending);
	if (mask) {
		mask =3D xchg_relaxed(&vcpu->arch.irq_pending, 0);
		kvm_irq_deliver(vcpu, mask);
	}
    ...
}

Could this lead to the VCPU clearing irq_pending and skipping the injection,
permanently losing the interrupt and causing a guest VM hang?

> +		else
> +			vector[i] =3D 0;
>  	}
> =20
>  	if (vector[0]) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714072520.2745=
942-1-maobibo@loongson.cn?part=3D1
