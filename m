Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440F2236F0
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926394; cv=none; b=PB/+GT27toCOC//xJ7/i3YoEacYUCHFDErl3NybMdlmWbNgLU2jWNY7/PBRaGeO0cY+WvmXNJ44SW5Q4LJ2ejEaQJeqqMk6SudeDIpkhIHkY03wKrhqZr9CRd6UezKNVhBXVSeCTxOjzCSKeU4xg43a6xl1NMQuHu+Z7seFjOHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926394; c=relaxed/simple;
	bh=SE5n/EyxmDywElY5Rj8CqxL6lnO0sAWwzvVzn1/swBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=enPVSuTFdx7wVzKMYBJSatkRBQ+PgZv3kTHKon7x0zhaJVnnRnOJsiyb8AxWxHaxu+Dz5SFh76xKNsblZI7RIzdSR24LrFw1e6YaJstIg+6iIg/oX06t07zMVzoLcUGrFvGXeN7BEeW+buCJV2x2D7GQ4PD7eVghfj8xjYZuDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G31Mw6Op; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G31Mw6Op"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BD71F000E9;
	Mon, 13 Jul 2026 07:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783926393;
	bh=MphTneh31AG5SZQSA6qxCfFP98a429PeQbwNqGghfIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G31Mw6Op76D800qKCGSy+c1CwbT4zbIdwm4lqIF9bMBvnmWPnb69ZY/IbFvZ9kp17
	 DpkF4rt5PVyissmzYz7rKzHwSea/n6+SWdd0LpYNXcLwnx9O3QAGAoICxq/4KqWlUg
	 ISIf31K+DbZEjpqwCId842H2YJk1O32ZdHibvbZrWM3EdGYIOU2xSvTM3uqwuavQoi
	 XpzHze9cadgPnhm2QH+xiE3BgQMj0vkA3rjoSzGF5B2yQPoRY0t3aDFjIxjuXcU8Wz
	 WoaLF211kvUADajzuo+Bzs0PaRvhztn51WMklH7UIkglC2qGU79PC6boH0tiYGYxiR
	 XJq8KEDseKhBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] RISC-V: KVM: Serialize virtual interrupt pending
 state updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xie Bo" <xb@ultrarisc.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260713064815.1276212-2-xb@ultrarisc.com>
References: <178159067899.108868.8176174463274678253@ultrarisc.com>
 <CAAhSdy3_YnzNiSE=KykriwSWU8X2CLhdr2E8CB=32JxA_L7caA@mail.gmail.com>
 <20260713064815.1276212-1-xb@ultrarisc.com>
 <20260713064815.1276212-2-xb@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 07:06:32 +0000
Message-Id: <20260713070632.90BD71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Acquiring a sleepable rwlock (`imsic->vsfile_lock`) while holding =
a raw spinlock (`vcpu->arch.irqs_pending_lock`) causes a PREEMPT_RT sleep-i=
n-atomic BUG, PROVE_RAW_LOCK_NESTING splats, and introduces an ABBA deadloc=
k.

Pre-existing issues:
- [High] Desynchronization between `irqs_pending` and `hvip` when user-spac=
e writes the `sip` CSR, potentially causing infinite WFI wakeup loops.
--

--- Patch [1]: [PATCH v3] RISC-V: KVM: Serialize virtual interrupt pending =
state updates ---
commit 84ae8e6240f7f5635c2560729711fc1ceb24234d
Author: Xie Bo <xb@ultrarisc.com>

RISC-V: KVM: Serialize virtual interrupt pending state updates

This commit replaces the lockless atomic operations for the irqs_pending
and irqs_pending_mask bitmaps with a per-vCPU raw spinlock. This groups
the updates into a single state transition to avoid losing interrupts.

> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index cf6e231e76e25..7d8d20839d46e 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
[ ... ]
> @@ -455,26 +469,33 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu =
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
> =20
>  	/* Check AIA high interrupts */
> -	return kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
> +	if (!ret)
> +		ret =3D kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
> +	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
> +
> +	return ret;
>  }

[Severity: High]
Does holding the raw irqs_pending_lock across kvm_riscv_vcpu_aia_has_interr=
upts()
cause a lock nesting issue and potential ABBA deadlock?

If kvm_riscv_vcpu_aia_has_interrupts() falls through to
kvm_riscv_vcpu_aia_imsic_has_interrupt(), that function acquires
imsic->vsfile_lock (an rwlock_t, which is sleepable on PREEMPT_RT).
Acquiring a sleepable lock while holding a raw spinlock triggers a
sleep-in-atomic bug and PROVE_RAW_LOCK_NESTING warnings.

Additionally, can this sequence deadlock against concurrent userspace
ioctl calls?

For example, a KVM_SET_DEVICE_ATTR call on the IMSIC triggers
kvm_riscv_aia_imsic_rw_attr(), which acquires imsic->vsfile_lock first:

kvm_riscv_aia_imsic_rw_attr()
  read_lock_irqsave(&imsic->vsfile_lock, flags);
  ...
  imsic_swfile_extirq_update(vcpu);
    kvm_riscv_vcpu_set_interrupt();
      raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);

If a vCPU thread running kvm_riscv_vcpu_has_interrupts() takes
irqs_pending_lock first, wouldn't these paths deadlock?

> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index bb920e8923c93..cba3682944b69 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
[ ... ]
> @@ -298,6 +298,7 @@ static int kvm_riscv_vcpu_general_set_csr(struct kvm_=
vcpu *vcpu,
[ ... ]
> -	if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip))
> -		WRITE_ONCE(vcpu->arch.irqs_pending_mask[0], 0);
> +	if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip)) {
> +		raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +		((unsigned long *)csr)[reg_num] =3D reg_val;
> +		vcpu->arch.irqs_pending_mask[0] =3D 0;
> +		raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
> +	} else {
> +		((unsigned long *)csr)[reg_num] =3D reg_val;
> +	}

[Severity: High]
This is a pre-existing issue, but does this clear of irqs_pending_mask leave
stale bits in irqs_pending?

If userspace writes 0 to the sip CSR, this code clears irqs_pending_mask[0]
and updates csr->hvip, but it does not clear any previously injected
interrupts in irqs_pending[0].=20

Because kvm_riscv_vcpu_has_interrupts() checks irqs_pending directly, can
this cause the vCPU to endlessly wake from WFI, finding no hardware interru=
pt
in HVIP, and immediately sleeping again?

The same situation appears to exist for the siph CSR update in
kvm_riscv_vcpu_aia_set_csr().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713064815.1276=
212-2-xb@ultrarisc.com?part=3D1
