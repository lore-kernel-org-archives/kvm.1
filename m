Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604AF1F192E
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784093683; cv=none; b=mmvQ8a2jsYVUsLqnBabF0H4Bexyf+TztE0P3rznkil+RexTAPvXaMzM2evA2Sq9qG9mAKe2JaTptVi1UBXQ2WZ7pg9y9s+v30cVj86fD/cevE3X02E2L8FHgxzDhmFA5dH4Kw49Nxvyx2k4meCp5+En5XgqXIhQtlmaUhG5R+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784093683; c=relaxed/simple;
	bh=eWOPrXnMsfT7YAkCdpedPcQgIefE+rjsPWP0Pc9qH5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YmqCnDb5jJOTmb6LYLEsAlKyZccNtdyxuuCLGG7ofXwXR0hOApICQ5+JPA+YsEOkwS98fo0g0byn1NIfgLHA5i6cn5EWWVhD4ZQXbsPj2BPRxLsQjuX77MXOeqa9qtJtgB0ScaTyjo2DV4z7iP3GNsgHleSeCgAtQZPNWXABF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+K6f5QR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+K6f5QR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BF41F000E9;
	Wed, 15 Jul 2026 05:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784093682;
	bh=lublCE11CUik7T24QQJw9Hy8+deTiepOQ2uy7K9DO20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T+K6f5QRBMJCDsJXvlWqSFNCWZ2dumBnSnctQe4+AVTM6V6EdO2d9pS+UauxVLL64
	 WEYFOdsJTR/TrVySClWDGBwcg+foBw2yJLluCeBlH16EuolEZ12Q4xPm0jr/PzQL5U
	 g3E6+0xjk2O9tFtFsuF0arxDPHwPFkOiRgK2AEp5tT0coTCmS2gp/EIJS8z+n89tFj
	 oFq1KI0ZxjkZwXtXy63gVbhY5W8dOZjQzWdi4voI6MA7+4k3GSZpD3xprbRgRqGGby
	 K9Erw931TX8yJR6yKGECBUHA1knnf0mur3m3NMKoqdWUiuTEg4dboJo+Ixw70QVy61
	 pZH8oauwGJATA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] RISC-V: KVM: fix vcpu vector context handling
 for kernel-mode vector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Chiu" <tchiu@tenstorrent.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260715051629.1169645-4-tchiu@tenstorrent.com>
References: <20260715051629.1169645-1-tchiu@tenstorrent.com>
 <20260715051629.1169645-4-tchiu@tenstorrent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 05:34:41 +0000
Message-Id: <20260715053441.E9BF41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The `RISCV_V_VCPU_NEED_RESTORE` thread flag is leaked across K=
VM_RUN boundaries, leading to uninitialized kernel memory disclosure.
--

--- Patch [3]: [PATCH v2 3/3] RISC-V: KVM: fix vcpu vector context handling=
 for kernel-mode vector ---
commit 48826c7676c07c389b4f37039e65e239445a85c8
Author: Andy Chiu <tchiu@tenstorrent.com>

RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector

This patch registers an RCU-protected callback to flush the vector context
when the kernel-mode vector is serving a guest. This addresses vtype
corruption during vector workloads by correctly saving the guest's context
and sourcing the right status.VS.

> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index cf6e231e76e25..b7b68809a5817 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c

[ ... ]

> @@ -765,6 +769,12 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct=
 kvm_vcpu *vcpu,
>  	kvm_riscv_vcpu_swap_in_guest_state(vcpu);
>  	guest_state_enter_irqoff();
> =20
> +	if (current->thread.riscv_v_flags & RISCV_V_VCPU_NEED_RESTORE) {
> +		current->thread.riscv_v_flags &=3D ~RISCV_V_VCPU_NEED_RESTORE;
> +		__kvm_riscv_vector_restore(gcntx);
> +		gcntx->sstatus =3D (gcntx->sstatus & ~SR_VS) | SR_VS_CLEAN;
> +	}
> +

[Severity: Critical]
Could this leak uninitialized kernel memory to the guest if the thread flag
carries over from a previous vCPU run?

If a softirq uses Kernel Mode Vector while a vCPU is loaded, it sets
RISCV_V_VCPU_NEED_RESTORE via kvm_riscv_vcpu_flush_vector(). If the thread
subsequently exits KVM to userspace, and then runs a different vCPU (for
example, one without the vector extension), this code will consume the
leaked flag.

Will this blindly restore the new vCPU's uninitialized gcntx->vector.datap
(which was allocated via kmalloc) into the physical vector registers, and
illegitimately force SR_VS_CLEAN in the guest's sstatus?

[ ... ]

> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 62d2fb77bb9b9..d25c10bd99a89 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c

[ ... ]

> @@ -72,6 +73,7 @@ void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_=
context *cntx)
>  {
>  	if (!kvm_riscv_isa_check_host(V))
>  		__kvm_riscv_vector_restore(cntx);
> +	riscv_v_flags_set(riscv_v_flags() & ~RISCV_V_VCPU_CTX);
>  }

[Severity: Critical]
Should RISCV_V_VCPU_NEED_RESTORE also be cleared here to prevent it from
leaking to the thread's future execution?

Since kvm_arch_vcpu_put() calls kvm_riscv_vcpu_host_vector_restore() during
KVM exit, clearing it here might prevent the cross-vCPU leakage described
above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715051629.1169=
645-1-tchiu@tenstorrent.com?part=3D3
