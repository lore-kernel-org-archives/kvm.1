Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C7330328
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482917; cv=none; b=JT5Jmj5+hEbwROZMT9sZjgJghm4m4Iu97VGfsHztLOX5MlsSyaLe08Vn+++z6WzPJdStH01rvLA2C4L13XsSEqoGTOGZnIQFaNYKCiBPWV5cuU2O543nplrbdqMg7DFurnQrDUpRwdGjzUF7zwozZjv/SoU2wnwxvQePX4xF0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482917; c=relaxed/simple;
	bh=TfN434rQMISx/l3rL+mHAP386uDccQufnScx7YDxrV0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ROmv/lZ5s3tGexqBR4FuiODwdAUUowfrvkr6sS/LoTn46umaYB/HmimIDjCgWF0kYvs/gSqGLhuwNganIULxQQmUtK78Z0RNIy+MXC5Q3iHx55acUw8Ufw37lepfAks24/QFrnQ6+HCIOoh8Pkcbh/mm8/4rM4dkSXoPoXqkRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuAr4mVB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuAr4mVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A691F00A3A;
	Wed,  8 Jul 2026 03:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783482915;
	bh=9NmegbwRZFT8WPdlnJ+I/Qd6dxZTAzAd9HCsF1owvEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iuAr4mVB+jvK9S5JyREWagrjpyCfCvJTfAKzTyAeDCSUsdiy7LTreQ+4srP+ChgC9
	 Ls5fGxkTfPugn2P/YMTDs6uQ0S3KYUCIloEiABZU4WWqVYTHS5lm4uAZkIgpS3uj3y
	 +AMhjz/0R5eTCyM4xLQHVJxizJCotdVGVuEegEAYXELXgRrpQnLcslDHqfnReiUVOl
	 pbg3h/4a/okjnzK52lo8uxl5NBC9vjGjEInKxAOi1Uel9uu6vBQvwSIpj0LW5LTraz
	 HFtPEtDOacCXvi4BtflTHKL6hT+WtB5FspZVh4wKTMEhoSQInaqGamg2Kx4ThLqXmG
	 l0zWTckc9NI7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] RISC-V: KVM: Serialize virtual interrupt pending
 state updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xie Bo" <xb@ultrarisc.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <178348173646.64306.17766618687631928432@ultrarisc.com>
References: <178348173646.64306.17443207006998871369@ultrarisc.com>
 <178348173646.64306.17766618687631928432@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:55:14 +0000
Message-Id: <20260708035515.12A691F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Updating `sip` or `siph` via CSR ioctls fails to update the master=
 `irqs_pending` bitmaps, which can lead to spurious wakeups or permanently =
blocked vCPUs in WFI.
- [High] Pre-existing bug: PMU overflow interrupt state (LCOFIP) is corrupt=
ed during userspace save/restore of the `sip` register.
--

--- Patch [1]: [PATCH v2 1/1] RISC-V: KVM: Serialize virtual interrupt pend=
ing state updates ---
commit 22c10234ade3ab313ea2d3d68ed12cccae2ba34a
Author: Xie Bo <xb@ultrarisc.com>

    RISC-V: KVM: Serialize virtual interrupt pending state updates

This patch introduces a per-vCPU raw spinlock to serialize updates to
virtual interrupt pending states. It replaces the existing lockless protocol
to prevent race conditions where newly injected interrupts could be lost
during guest HVIP sync.

> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index 5ec503288555d..821d2cb6d6a6d 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
[ ... ]
> @@ -214,11 +221,18 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcp=
u,
>  	reg_num =3D array_index_nospec(reg_num, regs_max);
> =20
>  	if (kvm_riscv_aia_available()) {
> -		((unsigned long *)csr)[reg_num] =3D val;
> -
>  #ifdef CONFIG_32BIT
> -		if (reg_num =3D=3D KVM_REG_RISCV_CSR_AIA_REG(siph))
> -			WRITE_ONCE(vcpu->arch.irqs_pending_mask[1], 0);
> +		if (reg_num =3D=3D KVM_REG_RISCV_CSR_AIA_REG(siph)) {
> +			raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +			((unsigned long *)csr)[reg_num] =3D val;
> +			vcpu->arch.irqs_pending_mask[1] =3D 0;
> +			raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock,
> +						   flags);

[Severity: High]
This isn't a bug introduced by this patch, but when restoring siph via ioct=
l,=20
we clear irqs_pending_mask[1] without syncing irqs_pending[1] with the new =
val.=20

Because kvm_arch_vcpu_runnable() relies exclusively on irqs_pending to
determine if a vCPU has pending events, could restoring a vCPU with
pending interrupts leave it permanently blocked in WFI since
irqs_pending isn't updated here?

> +		} else {
> +			((unsigned long *)csr)[reg_num] =3D val;
> +		}
> +#else
> +		((unsigned long *)csr)[reg_num] =3D val;
>  #endif
>  	}
> =20
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index bb920e8923c93..cba3682944b69 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
[ ... ]
> @@ -309,10 +310,14 @@ static int kvm_riscv_vcpu_general_set_csr(struct kv=
m_vcpu *vcpu,
>  	if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip)) {
>  		reg_val &=3D VSIP_VALID_MASK;
>  		reg_val <<=3D VSIP_TO_HVIP_SHIFT;
>  	}

[Severity: High]
This is a pre-existing issue, but does left-shifting the entire register
value here silently corrupt the PMU overflow interrupt state (LCOFIP)?

When userspace saves and restores the sip register, the IRQ_PMU_OVF bit
(bit 13) is shifted to bit 14 when saving to csr->hvip. Then on get_csr,
it shifts it back to bit 12, where it is subsequently cleared because
bit 12 is not included in VSIP_VALID_MASK. Will this break guest profiling
across migrations?

> -	((unsigned long *)csr)[reg_num] =3D reg_val;
> -
> -	if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip))
> -		WRITE_ONCE(vcpu->arch.irqs_pending_mask[0], 0);
> +	if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip)) {
> +		raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +		((unsigned long *)csr)[reg_num] =3D reg_val;
> +		vcpu->arch.irqs_pending_mask[0] =3D 0;
> +		raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);

[Severity: High]
This is also a pre-existing issue, but similar to the siph restore above,
we clear irqs_pending_mask[0] without updating irqs_pending[0] with the
new reg_val.=20

Can this leave the vCPU permanently blocked in WFI after live migration
since the irqs_pending bitmap isn't populated with the restored interrupts?

> +	} else {
> +		((unsigned long *)csr)[reg_num] =3D reg_val;
> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178348173646.64306.=
17766618687631928432@ultrarisc.com?part=3D1
