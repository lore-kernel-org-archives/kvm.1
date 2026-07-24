Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BFF4457D7
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913189; cv=none; b=oQmyEEgZGl+junNbdfGPxcZ3HFZedPciJDY68/kjJgQfSSwSbFu/ouPWKzjchrd4/fEq94USj2te1koi9LeJCTypVtGu7YVtWajaYN4vPYaCKO9u4Dp2rskoZnehtT4LnAxy3bqfaetxCKuZC0uaqTyabuZ/isMfYX5bQRlkbw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913189; c=relaxed/simple;
	bh=PkIdGOf4aGXd4nGTqcxd+CtyNvUTIC7W9CWUEkls5qY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iP2bXqyOQK2E2aqJOVJujkf/O5rcl94qBrWkbaTMGHhX4wxzu8RliaFpUV82XSdjwAgI+Qr0yb/9JZRsqM6+/zDLliw0DGqtqE4llXJKes21+c/I2erVP339GHO9SKhS5wkOwcLAnBb2mNb/PILqhuzMwQROAiztJZWjr0ThqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQyaBcx1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQyaBcx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3781F000E9;
	Fri, 24 Jul 2026 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784913187;
	bh=M62HvlriJBLk6CJCXVHGZYzMrk4MME5M3WLYKJFJfqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dQyaBcx1H/Ud9qJnuKqg13hWtef/25T9HvIFijzDQ92bg5iAjSZr3DuTPdIiU//ob
	 3nGIGh+jeK7x8lp2W0JyMdulSqySAa68hFwxQMraSOL6+2nYbCuErRFQ/Asm0PNgTB
	 6DADI782zne65QL/TALnEMzrEWW/eLsWzA971LflmFzyqgSt9ntugUSAm0AIwqXsjE
	 0F/bAv7guP2lhoeLMggNuQ3wGgheJNytwy6csx0Qx0cn+XTLj8Sb6OkSjThpcUXRqq
	 0V0pDKywYoBsuaXf0moSbciylc4MnT3go0HcwYUEefjpZLu0bv37+/fjTlJ2dQBfzj
	 7CyHgRLpEp9/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] RISC-V: KVM: fix vcpu vector context handling
 for kernel-mode vector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Chiu" <tchiu@tenstorrent.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260724165001.2317788-4-tchiu@tenstorrent.com>
References: <20260724165001.2317788-1-tchiu@tenstorrent.com>
 <20260724165001.2317788-4-tchiu@tenstorrent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 17:13:07 +0000
Message-Id: <20260724171307.AA3781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Non-atomic read-modify-write on thread flags leads to double-f=
lush and guest vector state corruption.
--

--- Patch [3]: [PATCH v3 3/3] RISC-V: KVM: fix vcpu vector context handling=
 for kernel-mode vector ---
commit a8a50591677d45441201aae73b3e95504bcf9fd4
Author: Andy Chiu <tchiu@tenstorrent.com>

RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector

Running vector workloads like perf + mcf on KVM can result in an
unexpected termination due to a vtype corruption. This happens because
the kernel-mode vector (KMV) misattributes the guest's vcpu context as
the user's context and source from a wrong status.VS.

> diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/k=
ernel_mode_vector.c
> index f76e52de11178..be0f6c7f78da2 100644
> --- a/arch/riscv/kernel/kernel_mode_vector.c
> +++ b/arch/riscv/kernel/kernel_mode_vector.c

[ ... ]

> @@ -147,13 +178,10 @@ static int riscv_v_start_kernel_context(void)
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
> +	riscv_v_start(RISCV_PREEMPT_V);
> +	put_cpu_vector_context();

[Severity: Critical]
Can a race condition occur here if a hardware interrupt is triggered?

It looks like get_cpu_vector_context() performs a non-atomic read-modify-wr=
ite
of the thread flags (via riscv_v_start()). If a vector-using hardware inter=
rupt
occurs right after the read, the interrupt handler could successfully flush=
 the
guest vector state and clobber the hardware vector registers with host data.

When the interrupt returns, would this VCPU thread write back the stale
riscv_v_flags, and then proceed to call __riscv_flush_vector_context() a
second time?

[ ... ]

> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 62d2fb77bb9b9..ef2eee6ec3086 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c

[ ... ]

> +void kvm_riscv_vcpu_flush_vector(void)
> +{
> +	struct kvm_vcpu *vcpu =3D *this_cpu_ptr(kvm_get_running_vcpus());
> +
> +	/*
> +	 * Only reached from __riscv_flush_vector_context() when RISCV_V_VCPU_C=
TX is set, which
> +	 * always have kvm_get_running_vcpus non-NULL.
> +	 */
> +	if (WARN_ON_ONCE(!vcpu))
> +		return;
> +
> +	kvm_riscv_vcpu_guest_vector_save(&vcpu->arch.guest_context, vcpu->arch.=
isa);

[Severity: Critical]
If kvm_riscv_vcpu_flush_vector() is executed a second time due to the race
described above, could this blindly save the interrupt-clobbered hardware
registers over the valid guest state in memory?

This seems like it might leak host vector data to the guest and completely
corrupt the guest's vector state.

> +
> +	if ((vcpu->arch.guest_context.sstatus & SR_VS) !=3D SR_VS_OFF)
> +		riscv_v_flags_set(riscv_v_flags() | RISCV_V_VCPU_NEED_RESTORE);
> +}
> +
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724165001.2317=
788-1-tchiu@tenstorrent.com?part=3D3
