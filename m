Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FC2FD7C3
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998765; cv=none; b=TjX1TExgKWfOswLkRu8nNB3Kzvrhtei9DGc2Xe8A9wYb2zNyUAos0db8/qXeRwc8OBU0spNIrKkDGotHLWDN3/ndDNBQi4AOPl6TRdN4uky42qAs3jJWrFNkOEpO0LH9oq1oOjR67Jl3R2Y/F1lpge05H3IcMH8k2YsxuTBFJRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998765; c=relaxed/simple;
	bh=hWtxtvENWQyQe0Khw88zyJWWVkqpgpkWOMUVSjeLUMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pzsj0FvW9stkADU3mbdhdgNHimQLbgHg6bGcBiypSqdtWltbyNWXM9Sk2cDfZYu9bAHcfd7i6vDrTLJu8BB/xk1iYpsAYl5sew1jpGjL6NKxjT8epJPMJ7uldWS3rvLQtbEqseC4Rt36+hKV4u4drtCKbPcjjufDti+a2iadzG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2zxvpXh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2zxvpXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37C41F00A3A;
	Thu, 28 May 2026 20:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779998764;
	bh=oINOVtTuOXtWNtBLpR3nB3EhwWMlVSRZq5tIjcpP1Ro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L2zxvpXh6TuTIVmsGzwkJDYqMzVgSdkXRFG/B7IO4fsVxiT+k83GEYnT0bwOEfS4j
	 TT9Pfik8CzX/ir3BvysOynBSmwRLRK/ZWh+bCFG8la9jqRbU0Jm5ij9qVeJ9WBcTX/
	 tNp1DYiZLY3NB6HYjLxH7QAD5Qzcy3dZdOAMDG8+/bmpqrKFnHM1UFSTlNm+mgkujd
	 9hEvtpURu2xPEgYPqwhUPCKY/Mg/GvOPmEU1PKHxpwrbxmWcdH8RrPLQLImeSgBt0U
	 dO6wn8qCv9fjZU4AUM/V3ePshaZpWjJKmGoZo+gg7mNQU3q+okiTydsI4yjjzwNFw0
	 yK0D/63tLP63g==
From: sashiko-bot@kernel.org
Subject: Re: [[PATCH] v4 1/4] riscv: vector: refactor vector context
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Chiu" <tchiu@tenstorrent.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528190927.886558-2-tchiu@tenstorrent.com>
References: <20260528190927.886558-2-tchiu@tenstorrent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 20:06:03 +0000
Message-Id: <20260528200603.F37C41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Data Corruption and KVM Vector State Leak due to stale DIRTY f=
lag.
- [Critical] Race condition in `riscv_v_start_kernel_context()` irreparably=
 clobbers user vector state.
--

commit 318d1ed373c5077cd222c2f2ebb920c9ca077d27
Author: Andy Chiu <tchiu@tenstorrent.com>

v4 1/4] riscv: vector: refactor vector context operations

This commit refactors the vector context saving and restoring operations
on RISC-V. It lifts riscv_v_enable() and riscv_v_disable() out of the
internal state save and restore functions to avoid repeatedly toggling
the vector extension.

> diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/k=
ernel_mode_vector.c
> index 99972a48e86bc..21127b33fea80 100644
> --- a/arch/riscv/kernel/kernel_mode_vector.c
> +++ b/arch/riscv/kernel/kernel_mode_vector.c
[ ... ]
> @@ -134,20 +134,35 @@ static int riscv_v_start_kernel_context(bool *is_ne=
sted)
>  		*is_nested =3D true;
>  		get_cpu_vector_context();
>  		if (riscv_preempt_v_dirty(current)) {
> +			riscv_v_enable();
>  			__riscv_v_vstate_save(kvstate, kvstate->datap);
> +			riscv_v_disable();
>  			riscv_preempt_v_clear_dirty(current);
>  		}
>  		riscv_preempt_v_set_restore(current);
>  		return 0;
>  	}
> =20
> -	/* Transfer the ownership of V from user to kernel, then save */
> -	riscv_v_start(RISCV_PREEMPT_V | RISCV_PREEMPT_V_DIRTY);
> +	/*
> +	 * Skip saving user's context if it is not DIRTY. We would have to star=
t KMV in "dirty" if
> +	 * this check is performed after KMV starts, to protect user's ctx. The=
n, we could waste
> +	 * time saving already "clean" context once KMV is started in "dirty".
> +	 */
>  	if (__riscv_v_vstate_check(task_pt_regs(current)->status, DIRTY)) {

[Severity: Critical]
This is a pre-existing issue, but can this lead to a data leak and corrupti=
on
if KVM is used?

When KVM's kvm_arch_vcpu_load() saves the host's vector state and loads the
guest's state into hardware registers, it doesn't appear to clear the
SR_VS_DIRTY flag in the host task's pt_regs->status.

If a host interrupt occurs while the vCPU is loaded, and the handler calls
kernel_vector_begin(), it would call riscv_v_start_kernel_context(). This
would see the DIRTY flag and save the guest's hardware state into the
host task's current->thread.vstate, corrupting it and leaking guest data.

When the interrupt handler uses vector instructions, it would clobber the
hardware registers. Upon returning to KVM, kvm_arch_vcpu_put() would save
the clobbered registers into the guest's context.

Could this cause a two-way data leak?

> -		uvstate =3D &current->thread.vstate;
> -		__riscv_v_vstate_save(uvstate, uvstate->datap);
> +		/* Transfer the ownership of V from user to kernel, then save */
> +		riscv_v_start(RISCV_PREEMPT_V | RISCV_PREEMPT_V_DIRTY);

[Severity: Critical]
This is a pre-existing issue, but does this create a race condition that
irreparably clobbers user vector state?

If an interrupt triggers a context switch immediately after riscv_v_start(),
__switch_to_vector() will save the hardware registers to kernel_vstate
due to the newly set flags:

__switch_to_vector()
  __riscv_v_vstate_save(&prev->thread.kernel_vstate, ...);

When the task is scheduled back, riscv_v_context_nesting_end() will execute
on return from the interrupt, restore the hardware registers from
kernel_vstate, and clean the status:

riscv_v_context_nesting_end()
  __riscv_v_vstate_restore(vstate, vstate->datap);
  __riscv_v_vstate_clean(regs);

> +		/*
> +		 * Calling the guarded version of vstate_save to make the code cleaner=
. Also, the
> +		 * vstate check within the call is necessary as context switch may hap=
pen between
> +		 * __riscv_v_vstate_check and riscv_v_start. In such case we are not s=
upposed to
> +		 * save the context again.
> +		 */
> +		riscv_v_vstate_save(&current->thread.vstate, task_pt_regs(current));

When execution resumes here, riscv_v_vstate_save() will silently skip saving
because regs->status is now CLEAN. current->thread.vstate is never updated.

When riscv_v_start_kernel_context() returns, the kernel vector code clobbers
the hardware registers. Since the user state was restored to hardware but
never saved to current->thread.vstate, does this destroy the user state and
leak the kernel's vector state back to the user process?

> +		riscv_preempt_v_clear_dirty(current);
> +		return 0;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528190927.8865=
58-1-tchiu@tenstorrent.com?part=3D1
