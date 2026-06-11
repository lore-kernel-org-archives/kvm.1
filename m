Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92FA359A70
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162243; cv=none; b=K154fpN0Iocuxj343LBdHLyWZuZPrqkN7CEquJlRbT/ue67D0zVgTQmTSsJRYUld8xAZ34V3ccpkeyRdtFaJP39zauQCmdpAYkN8qCAF7DbJasBJiw9eTUbx/C+o2pD0z7WpWJUo6ZZ6EoHh/vthR3G+VPzkpo8q6zCvuh2wUCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162243; c=relaxed/simple;
	bh=MhI9mgQEl9TLm10luS6OZL3j/cst0Tm01A8KU7pgJHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F5ocm51Xy1QYyKfsusjVyre4tPeSShQkVPthY4pFch6t34ULUfC4khePmsF8p3OVR0CD3hzu6uMg6uBxGmcO7u9Vl6EJlLO+8QLg9cqPWmt1adekvva8a7MUno+UfrL+NKoT9fgi7cr0lRpqKFfzNgLS2IO7o5SZajDYOF1YvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx7Kd3li; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx7Kd3li"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BF31F00893;
	Thu, 11 Jun 2026 07:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781162242;
	bh=kPfoagfXIUdCCBNH6u0WHFy2szeh8/0W5w/jINKXPGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nx7Kd3li1z5VpJrRfBXI6iAv9yqqFWoFPUwn6LLitW+FNUS5U27Uz9JY0X+pouEAr
	 Bs7yg4aNkFcH4sBX+7etTy/cATQw35i8uzRnKmMViaQkgKoO9yc3q0sreMfXoB20Vx
	 BBsoe5uDi3oH0R5mvjjJAT/Jiles+rI6K0dbcscPo46XvCccY1PIKiO+M2IfHYLeYs
	 8E4E87l+sbt2Mw+x0g9cu6ANd7UWwOV523VR9KyILCrtW3AA2+JzWj7yb2b9+drbn3
	 hK9dmRTEsD9Xh8yBt1YREK78/Q/QiVLTHPjikpqutjEfYvd/9H/Jr3v69jbA/My7kn
	 /phbom5DT76NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] LoongArch: KVM: Inject interrupt with batch
 method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260611065815.1439154-5-maobibo@loongson.cn>
References: <20260611065815.1439154-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 07:17:21 +0000
Message-Id: <20260611071722.41BF31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized stack array `vector` is accessed conditionally in `d=
msintc_inject_irq`, potentially leading to hardware state corruption.
--

commit 1bbf844f12dc29aa2ddec056c816e1245e63e5fb
Author: Bibo Mao <maobibo@loongson.cn>

    LoongArch: KVM: Inject interrupt with batch method

This commit converts interrupt injection and clearing to process multiple
interrupts simultaneously using a bitmask instead of one-by-one based on
priorities. It also removes the unused priority_to_irq array.

> diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrup=
t.c
> index 48dd56aa4dc56..c1afeb058c5b3 100644
> --- a/arch/loongarch/kvm/interrupt.c
> +++ b/arch/loongarch/kvm/interrupt.c
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
> +	irq =3D mask & KVM_ESTAT_INTI_MASK;
> +	if (irq) {
> +		if (irq & CPU_AVEC)
> +			dmsintc_inject_irq(vcpu);

[Severity: High]
This is a pre-existing issue, but does dmsintc_inject_irq() use an
uninitialized stack array?

Looking at dmsintc_inject_irq() in arch/loongarch/kvm/intc/dmsintc.c, the
array vector is declared without initialization:

arch/loongarch/kvm/intc/dmsintc.c:dmsintc_inject_irq() {
	unsigned int i;
	unsigned long vector[4], old;
	...
	for (i =3D 0; i < 4; i++) {
		old =3D atomic64_read(&(ds->vector_map[i]));
		if (old)
			vector[i] =3D atomic64_xchg(&(ds->vector_map[i]), 0);
	}

If old is zero, vector[i] is left uninitialized. Then later the
uninitialized memory is evaluated:

	if (vector[0]) {
		old =3D kvm_read_hw_gcsr(LOONGARCH_CSR_ISR0);
		kvm_write_hw_gcsr(LOONGARCH_CSR_ISR0, vector[0] | old);
	}
	...

Can this unpredictably corrupt the guest's interrupt state machine and
potentially cause guest kernel panics by writing garbage values to the
hardware CSR?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611065815.1439=
154-1-maobibo@loongson.cn?part=3D4
