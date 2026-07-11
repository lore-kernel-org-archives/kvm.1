Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4F1D5AD4
	for <kvm@vger.kernel.org>; Sat, 11 Jul 2026 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783736564; cv=none; b=j9TttskfYn4KnHj8zA7Wig1tPA5ER32JXQGSnSvT1fYIHBVloQ5UStREXH587M4oUv010luFcF5/q8hkaU3WgMtRfNRSexgASjL9Mvo+CClEct0vDgoQPR9ErOugorz5ZqUSDZYvx9UFlBX9ZfzCAbTgT3teFYJMmZT7Eukqzd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783736564; c=relaxed/simple;
	bh=4H/03OiDJUXmJe4MGGXB/NvkLJgsGdoRJhxOJA3tkSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kpKQ8H7nY/74yJk+lL9JtuSqvKPm7O3gGUbC0Gm2rZZ/UKwkZ9aknWV7czARAPYo6nKwPZGR9iGHA7lYhIbm5QDGKwTv5sjckTy3R8YkQMxtzGhet0R4g6rQ4UWrAbxasamI4e63KZ941b8w5U2BEL8ujdwzYOlGZdXm0UzM0kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGlKFGCy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGlKFGCy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DC61F000E9;
	Sat, 11 Jul 2026 02:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783736562;
	bh=XMhwqV9qfwRFVJnWF/oFOJEM14Bm6ejFza4XgZ+1DME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GGlKFGCyA7MkZ8ArM3v6nIfV/e8aXLSIdWD/8ZTUhxHLfufK/DDKDJ2BAUeC//jJB
	 qCl6Bqb0GPu+E88VrKbEsnu1rVZg8mjB3OGuFnsc8BZRV7y/lHDuuFcqvCzYb4g0Ld
	 840tAjwhlsZ0OTfg3vO7PPHJgi43zMzvRQfTZQLGjxTlVoqylVC0BoU/gDtTKVRVyx
	 eau1e4vl54dB61BTofRObWZ4dYzvmoxyNA57CsZBWJgzqrptfyZ3lPCamH7fRtPVPh
	 XhxgBrOgmCszj8SoE1l8LrVfMIluDVe82KdL+Gfvg5dZJj/GJo6kxONtNBiEHf1eOs
	 gKpx7wSXecNLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] RISC-V: KVM: fix vcpu vector context handling
 for kernel-mode vector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Chiu" <tchiu@tenstorrent.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260711015835.767259-3-tchiu@tenstorrent.com>
References: <20260711015835.767259-1-tchiu@tenstorrent.com>
 <20260711015835.767259-3-tchiu@tenstorrent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 02:22:42 +0000
Message-Id: <20260711022242.A4DC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Softirqs preempting `vcpu_load()` or `vcpu_put()` can call `kernel=
_vector_begin()` and catastrophically corrupt both host user and guest vect=
or states.
- [High] Missing `rcu_read_lock()` in `__riscv_flush_vector_context()` caus=
es a lockdep warning and a Use-After-Free on PREEMPT_RT kernels during KVM =
module unload.
- [High] Missing bitmask when checking guest `sstatus.VS` field uncondition=
ally forces vector enablement in the guest OS.
- [High] A preemption window allows guest vector state to overwrite the hos=
t userspace vector state buffer.
--

--- Patch [2]: [PATCH v1 2/2] RISC-V: KVM: fix vcpu vector context handling=
 for kernel-mode vector ---
commit 1f94d99a9de1c321461c33680cf69b26f4efb606
Author: Andy Chiu <tchiu@tenstorrent.com>
Subject: RISC-V: KVM: fix vcpu vector context handling for kernel-mode vect=
or

This patch registers an RCU-protected callback to allow the kernel-mode
vector code to safely flush the KVM guest's vector context. This addresses a
reverse dependency issue when KVM is configured as a module.

Fixes: ecd2ada8a5e0 ("riscv: Add support for kernel mode vector")

> diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/k=
ernel_mode_vector.c
> index 307ac369c3d4a..a83d5c26d3b2c 100644
> --- a/arch/riscv/kernel/kernel_mode_vector.c
> +++ b/arch/riscv/kernel/kernel_mode_vector.c
[ ... ]
> @@ -80,6 +99,19 @@ void put_cpu_vector_context(void)
>  		preempt_enable();
>  }
> =20
> +static void __riscv_flush_vector_context(void)
> +{
> +	bool (*vcpu_flush_v_callback)(void);
> +
> +	/* rcu_deference is protected by get/put_cpu_vector_context() */
> +	vcpu_flush_v_callback =3D rcu_dereference(kvm_flush_vector_ctx_callback=
);

[Severity: High]
Does this missing rcu_read_lock() trigger a lockdep warning and risk a
use-after-free on PREEMPT_RT?

The caller get_cpu_vector_context() disables softirqs (or preemption on
RT), which does not constitute an RCU read-side critical section.

Furthermore, on PREEMPT_RT, preempt_disable() does not block
synchronize_rcu(). Could kvm_riscv_unregister_vctx_callback() return while
the callback is still executing and prematurely free the memory?

> +	if (vcpu_flush_v_callback && vcpu_flush_v_callback())
> +		return;
> +
> +	riscv_v_vstate_save(&current->thread.vstate, task_pt_regs(current));
> +	riscv_v_vstate_set_restore(current, task_pt_regs(current));
> +}
[ ... ]
> @@ -141,13 +173,10 @@ static int riscv_v_start_kernel_context(void)
>  	}
> =20
>  	/* Transfer the ownership of V from user to kernel, then save */
> -	riscv_v_start(RISCV_PREEMPT_V | RISCV_PREEMPT_V_DIRTY);
> -	if (__riscv_v_vstate_check(task_pt_regs(current)->status, DIRTY)) {
> -		uvstate =3D &current->thread.vstate;
> -		__riscv_v_vstate_save(uvstate, uvstate->datap);
> -	}
> -	riscv_preempt_v_clear_dirty(current);
> -	riscv_v_vstate_set_restore(current, task_pt_regs(current));
> +	get_cpu_vector_context();
> +	__riscv_flush_vector_context();
> +	put_cpu_vector_context();
> +	riscv_v_start(RISCV_PREEMPT_V);

[Severity: High]
Does the gap between put_cpu_vector_context() and riscv_v_start() create
a preemption window that allows guest state to overwrite host user state?

Calling put_cpu_vector_context() enables preemption and bottom halves. If a
context switch occurs exactly here, switch_to() calls __switch_to_vector(),
which observes that riscv_preempt_v_started(prev) is false.=20

Since the host's status was not cleared of SR_VS_DIRTY, __switch_to_vector()
might save the physical vector registers (which contain guest state) into
the host QEMU process's prev->thread.vstate.

>  	return 0;
>  }
> =20
[ ... ]
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index cf6e231e76e25..60288bf6e9be4 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
[ ... ]
> @@ -765,6 +765,12 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct=
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

[Severity: High]
Could this forcefully overwrite the guest's sstatus register based on a fal=
se
positive in kvm_riscv_vcpu_flush_vector(), breaking guest OS lazy vector
state?

>  	if (kvm_riscv_nacl_sync_sret_available()) {
>  		nsh =3D nacl_shmem();
[ ... ]
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 62d2fb77bb9b9..3b94e6e7fec84 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
[ ... ]
> @@ -95,6 +95,24 @@ void kvm_riscv_vcpu_free_vector_context(struct kvm_vcp=
u *vcpu)
>  	kfree(vcpu->arch.guest_context.vector.datap);
>  	kfree(vcpu->arch.host_context.vector.datap);
>  }
> +
> +bool kvm_riscv_vcpu_flush_vector(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +
> +	vcpu =3D *this_cpu_ptr(kvm_get_running_vcpus());

[Severity: High]
Can a softirq occurring during vcpu_load() or vcpu_put() mistakenly use this
guest context?

In virt/kvm/kvm_main.c, vcpu_load() assigns the kvm_running_vcpu per-cpu
variable while preemption is disabled via get_cpu(), but hardware interrupts
can still occur. On return from a hardirq, invoke_softirq() could run.

If a softirq executes kernel_vector_begin(), it would find a non-NULL
kvm_running_vcpu here and wrongly assume the physical registers hold guest
state. This could result in saving the host userspace vector state into
guest_context, causing an information leak, and later clobbering the host
context in kvm_arch_vcpu_load().

> +	if (vcpu && riscv_isa_extension_available(vcpu->arch.isa, v)) {
> +		kvm_riscv_vcpu_guest_vector_save(&vcpu->arch.guest_context,
> +						 vcpu->arch.isa);
> +
> +		if (vcpu->arch.guest_context.sstatus !=3D SR_VS_OFF)

[Severity: High]
Does this comparison unconditionally evaluate to true because it is missing=
 a
bitwise AND mask?

Because sstatus usually contains other active flags (like SR_SPP), comparing
the entire 64-bit register against SR_VS_OFF (which is 0) will almost always
evaluate to true.=20

Could this use (vcpu->arch.guest_context.sstatus & SR_VS) !=3D SR_VS_OFF
instead?

> +			current->thread.riscv_v_flags |=3D RISCV_V_VCPU_NEED_RESTORE;
> +
> +		return true;
> +	}
> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711015835.7672=
59-1-tchiu@tenstorrent.com?part=3D2
