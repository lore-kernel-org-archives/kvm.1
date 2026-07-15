Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3C86341
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 02:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784082186; cv=none; b=o8JauoGcIhuHmRrjHVnMrhy58ny4l/dn1F2uHPA5E/HnlQcBekAJewlLdUKVXdQLMRN/JQmZLw0PSYJ8zujKEbYymr/qyRIqIcj0yEbAf90z/dn+LxELczsl5kkoPAOqbd1DVoeZ0JV9DhbrfILEh62e186LwMx93+Rz3FbQ8so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784082186; c=relaxed/simple;
	bh=mZ39kLrFdGys5LsSwaBnA1a4wFNyQgpzLBsFdc2FWj8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=APQDhfR6FHgdCRB8DWIw9HubgsZyqIpzRMmWoSq4xzqQ2rnGrCosSfHLSIX1Qo7DapOy2vQp9D2GhGoaIkDxznX9uCyV7NroNvkwgL+yxapwYJko0+CbQuAp8KoiTmY4F58s+kC5WdUYwvlqbFOF0hU7OqXn2NEGIXOTIXRNVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGUyUoAY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGUyUoAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881CE1F000E9;
	Wed, 15 Jul 2026 02:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784082184;
	bh=HKcGNBZ4LLxovOerRAXwQjQp0OVhMwoKoYdTRfIDQCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AGUyUoAYqABKDLBuNFeEcHFe+TINy9UayIYfjHS5ZHaKC/1g2gkxe0X1BAeuvmRLq
	 WDQ0Wt73wDmqXstxnR05l/RcfTr0nsTmGnhzIXNDW56a08KpQ+aHec1yScRaksOJaf
	 NaREnSLjcMOPX1w+x/3t7vjLKfEM4Cygzb9MSt1jCVSO6s+1BYOVwYKMWIIBDe3y/O
	 ORZRsgnBQAqgp3f9uTsVQjjyL6NOeMmn66TeoA9O4/0bLxzthIoHihhKPbcLwjQfpG
	 o0NrjBoOEu8UyP0hnOpmAL2bVbWaBw/2yng1TtRCRwXi2XBIz+ULwYx846jx6FfjHg
	 10crrAqfqQOyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] RISC-V: KVM: Serialize virtual interrupt pending
 state updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xie Bo" <xb@ultrarisc.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260715020359.1521354-2-xb@ultrarisc.com>
References: <178159067899.108868.8176174463274678253@ultrarisc.com>
 <CAAhSdy3_YnzNiSE=KykriwSWU8X2CLhdr2E8CB=32JxA_L7caA@mail.gmail.com>
 <20260713073346.1293408-1-xb@ultrarisc.com>
 <20260713073346.1293408-2-xb@ultrarisc.com>
 <CAAhSdy0hX0z6BpOUZSnCmhh7aeHUm3Yh5k9TdzUGC+4A1W+Czw@mail.gmail.com>
 <20260715020359.1521354-1-xb@ultrarisc.com>
 <20260715020359.1521354-2-xb@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 02:23:04 +0000
Message-Id: <20260715022304.881CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] PMU overflow interrupts (`IRQ_PMU_OVF`) are never detected as pend=
ing in `kvm_riscv_vcpu_has_interrupts`, preventing the vCPU from waking up =
if it is the only pending interrupt.
- [High] KVM_SET_ONE_REG for CSR_SIP/CSR_HVIP and AIA SIPH zeroes `irqs_pen=
ding_mask` but fails to update `irqs_pending`, leading to stale interrupt t=
racking state and broken migration.
--

--- Patch [1]: [PATCH v5] RISC-V: KVM: Serialize virtual interrupt pending =
state updates ---
commit 1ce4c480c538ab1b292116e2773fceec94a4683c
Author: Xie Bo <xb@ultrarisc.com>

RISC-V: KVM: Serialize virtual interrupt pending state updates

RISC-V KVM tracks guest interrupt state with two bitmaps:
irqs_pending and irqs_pending_mask. The current code updates those
bitmaps with independent atomic bitops and assumes a multiple-producer,
single-consumer protocol, which does not hold. This commit serializes
updates with a per-vCPU raw spinlock.

> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index bafb009c5ce55..9a653b4ad40a5 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c

[ ... ]

> @@ -219,8 +236,12 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
>  		((unsigned long *)csr)[reg_num] =3D val;
> =20
>  #ifdef CONFIG_32BIT
> -		if (reg_num =3D=3D KVM_REG_RISCV_CSR_AIA_REG(siph))
> -			WRITE_ONCE(vcpu->arch.irqs_pending_mask[1], 0);
> +		if (reg_num =3D=3D KVM_REG_RISCV_CSR_AIA_REG(siph)) {
> +			raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +			vcpu->arch.irqs_pending_mask[1] =3D 0;

[Severity: High]
This is a pre-existing issue, but does kvm_riscv_vcpu_aia_set_csr() in
arch/riscv/kvm/aia.c also need to synchronize vcpu->arch.irqs_pending[1]?

When KVM_SET_ONE_REG is used for AIA SIPH, this zeroes irqs_pending_mask[1]
but fails to update irqs_pending[1].

During a VM restore, if a vCPU is migrated with pending interrupts,
could it spuriously block in WFI forever? kvm_riscv_vcpu_has_interrupts()
relies exclusively on irqs_pending to evaluate pending interrupts.

> +			raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock,
> +						   flags);
> +		}
>  #endif
>  	}

[ ... ]

> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index cf6e231e76e25..0065a15c9aadc 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c

[ ... ]

> @@ -439,26 +458,33 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu =
*vcpu, unsigned int irq)
[ ... ]
>  bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
>  {
> +	unsigned long flags;
>  	unsigned long ie;
> +	bool ret;
> =20
> +	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
>  	ie =3D ((vcpu->arch.guest_csr.vsie & VSIP_VALID_MASK)
>  		<< VSIP_TO_HVIP_SHIFT) & (unsigned long)mask;
>  	ie |=3D vcpu->arch.guest_csr.vsie & ~IRQ_LOCAL_MASK &
>  		(unsigned long)mask;
> -	if (READ_ONCE(vcpu->arch.irqs_pending[0]) & ie)
> -		return true;
> +	ret =3D vcpu->arch.irqs_pending[0] & ie;

[Severity: High]
This is a pre-existing issue, but are PMU overflow interrupts (IRQ_PMU_OVF)
always undetected in kvm_riscv_vcpu_has_interrupts() in arch/riscv/kvm/vcpu=
.c?

The `ie` mask shifts the PMU enable bit to position 14 (due to
VSIP_TO_HVIP_SHIFT), while `irqs_pending[0]` has the PMU interrupt at
position 13.

Since their bitwise AND always evaluates to zero for the PMU interrupt,
does this prevent the vCPU from waking up if a guest configures a PMU
overflow interrupt and executes WFI?

> +	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
> =20
>  	/* Check AIA high interrupts */
> -	return kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
> +	if (!ret)
> +		ret =3D kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
> +
> +	return ret;
>  }

[ ... ]

> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index bb920e8923c93..2031beb9bba6e 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c

[ ... ]

> @@ -311,8 +312,11 @@ static int kvm_riscv_vcpu_general_set_csr(struct kvm=
_vcpu *vcpu,
> =20
>  	((unsigned long *)csr)[reg_num] =3D reg_val;
> =20
> -	if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip))
> -		WRITE_ONCE(vcpu->arch.irqs_pending_mask[0], 0);
> +	if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip)) {
> +		raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +		vcpu->arch.irqs_pending_mask[0] =3D 0;

[Severity: High]
This is a pre-existing issue, but does kvm_riscv_vcpu_general_set_csr() in
arch/riscv/kvm/vcpu_onereg.c also need to synchronize
vcpu->arch.irqs_pending[0]?

When KVM_SET_ONE_REG is used for CSR_SIP/CSR_HVIP, this zeroes
irqs_pending_mask[0] to prevent clobbering the explicitly restored state,
but fails to update irqs_pending[0] with the new sip/hvip value.

If an interrupt is cleared via KVM_SET_ONE_REG, does it leave a stale bit
in irqs_pending[0] and prevent the vCPU from sleeping?

> +		raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715020359.1521=
354-2-xb@ultrarisc.com?part=3D1
