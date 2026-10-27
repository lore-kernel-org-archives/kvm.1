Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110268;
	b=Zn/JEdcNZt7WbkQpN+HW3ZsI8n7HMbTQOybSVU7YQZgQSQ1uIQuQjF52nSIExr8REqRJ
	 efTNrTrQjD+qIRvUmwsCNsll0jBwAXuKBCUvyQw+3vUy0vTYpw/SZSDT53PTFJ9UUldga
	 cV6tAhpMEWaJM0jU5b58310+m4xToEA3NY5/EZvZjaS3HQR8T0rkej7mzm+sJl2YLzq6t
	 J3HmVw3bfGXeBJo+Nas0+pG9B6pjb2O2ZahGJ17zcDXmf09hTqAH72OACTID1aMcYtSG/
	 kV3cDXuSBb8Xlob2RRqK9yAnJ4wxK37Qb3HNvpumWRb0GED1H19dlPxVf37aaAKSc0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110268;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PSLRZXEA1oT99TyBIRuZEFfuScd69LinTOoUEodksYY=;
	b=d74FaSpuz8a8hfUwHYaGmn0QqHflmafzNXGcDWFoYndI1pHxz5PVDeu5l6XaH60ctDzC
	 kY7mqAv7m9liK9aiSgcNdJZXsEFIiBlrLhmvmd+hkeOpIQ1wy5BhrGLKnAvgTD8c93Shb
	 L4fdZVkBv3NwvcIiFGevTIcp1BD7khvsL3EfHuVYwqHwoRa7oHHfQg789RBoCZRWOE+jg
	 R7y6q1uG2hb5TbEXHW/DS9vp4GMhkPQl0SXusJTOI6ocJ6a2xGIC59OoDSV4jG5OaIjfF
	 5ntGzDdGHVodSTLDDGxyhx8jaL+ehHn/0gQW5JnnL4QIG83y8IZp0yr95zz8rjdA87w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jqqe0aUY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2942C606A32C
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jqqe0aUY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8D21F01829;
	Tue, 27 Oct 2026 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110267;
	bh=PSLRZXEA1oT99TyBIRuZEFfuScd69LinTOoUEodksYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jqqe0aUYrjxEfBG4D3iCgcqE3F8zFrQxsPB3srwXRNTE6taUBbmFE8e6KMPOzgjgE
	 7xEAlDj0aFJqT6s13lParQYJp5AC6h3eBNM3lTSwPlayG/qpD5O8/PuqW53jcqjwt5
	 MY/mWxsSbIgCeOJxhcUi8421PUvetxaA3oNx91kP50+cLf/qo4FZTH41Jh2uGxENCq
	 VMd8KNM2PJjvLt8JpEwb9nGKKhKBpCGI04XaLkuOxdxTZ3IhIEzclH5Xcs4cecY5Fa
	 ObS9bAYO9HpfIrCNGXTm0ZNVgh2WhbTxWbMl73ISigdt8nGLSRJrO8Hfp6LcxQLyE6
	 y456EyY1VkFHg==
Message-ID: <sashiko-outbox-186708@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/3] RISC-V: KVM: Preserve guest Vector state across
 vCPU put/load
Reply-To: sashiko-reviews@lists.linux.dev
To: "slack up" <yxcnew@outlook.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <OSQPR01MB63262D568C71BC3510AAC4A4C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
References: <OSQPR01MB63265385597FE472C4209353C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
 <OSQPR01MB63262D568C71BC3510AAC4A4C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:11:06 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] RISC-V: KVM: missing vector owner invalidation on preempt_v st=
art race
- [High] RISC-V: KVM: vector owner invalidation runs before enter_from_user=
_mode()
- [Low] RISC-V: KVM: missing kernel-parameters.txt entry for vector_owner_f=
astpath
--

commit f4e86411e0473662833880eb7f87be358e15d73e
Author: Xiaochun Yu <yxcnew@outlook.com>

RISC-V: KVM: Preserve guest Vector state across vCPU put/load

This commit introduces per-hart Vector owner tracking in RISC-V KVM so that=
 a
vCPU reloaded on the same hart can restore only Vector control CSRs when its
Vector data registers remain resident in hardware. The optimization is gated
behind a read-only vector_owner_fastpath module parameter and hooks into the
generic RISC-V Vector context invalidation callback.

> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index fefc2857f753a..c197d3d7b539d 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -17,7 +19,50 @@
>  #include <asm/kvm_vcpu_vector.h>
>  #include <asm/vector.h>
> =20
> +#include "trace.h"
> +
>  #ifdef CONFIG_RISCV_ISA_V

[ ... ]

> +static DEFINE_PER_CPU(struct kvm_riscv_vector_owner,
> +			      kvm_riscv_vector_owner);
> +static atomic64_t kvm_riscv_vector_owner_cookie =3D ATOMIC64_INIT(0);
> +static bool kvm_riscv_vector_owner_fastpath;
> +module_param_named(vector_owner_fastpath, kvm_riscv_vector_owner_fastpat=
h,
> +		   bool, 0444);
> +MODULE_PARM_DESC(vector_owner_fastpath,
> +		 "Preserve matched guest Vector registers across vCPU put/load");

[Severity: Low]
Since vector_owner_fastpath is a read-only module parameter checked during
initialization in kvm_riscv_v_init() (and passed on the kernel command line
as kvm.vector_owner_fastpath when KVM is built-in), should this parameter
also be documented in Documentation/admin-guide/kernel-parameters.txt?

> +
> +bool kvm_riscv_vcpu_vector_owner_enabled(void)
> +{
> +	return READ_ONCE(kvm_riscv_vector_owner_fastpath);
> +}

[ ... ]

> +bool kvm_riscv_vcpu_vector_owner_load(struct kvm_vcpu *vcpu, int cpu)
> +{
> +	struct kvm_riscv_vector_owner *owner;
> +	unsigned long guest_vs =3D vcpu->arch.guest_context.sstatus & SR_VS;
> +	unsigned long host_vs =3D task_pt_regs(current)->status & SR_VS;
> +	enum kvm_riscv_vector_owner_reason reason;
> +	bool eligible =3D false;
> +
> +	if (!kvm_riscv_vcpu_vector_owner_enabled())
> +		return false;
> +
> +	owner =3D this_cpu_ptr(&kvm_riscv_vector_owner);
> +	if (guest_vs =3D=3D SR_VS_OFF) {
> +		reason =3D KVM_RISCV_VECTOR_OWNER_GUEST_OFF;
> +	} else if (host_vs !=3D SR_VS_OFF) {
> +		reason =3D KVM_RISCV_VECTOR_OWNER_HOST_ON;
> +	} else if (!owner->identity) {
> +		reason =3D vcpu->arch.last_exit_cpu =3D=3D cpu ?
> +			 KVM_RISCV_VECTOR_OWNER_EMPTY :
> +			 KVM_RISCV_VECTOR_OWNER_MIGRATION;
> +	} else if (owner->identity !=3D (unsigned long)vcpu) {
> +		reason =3D KVM_RISCV_VECTOR_OWNER_OTHER_VCPU;
> +	} else if (owner->cookie !=3D vcpu->arch.vector_owner_cookie) {
> +		reason =3D KVM_RISCV_VECTOR_OWNER_COOKIE;
> +	} else if (owner->generation !=3D vcpu->arch.vector_state_generation) {
> +		reason =3D KVM_RISCV_VECTOR_OWNER_GENERATION;
> +	} else {
> +		reason =3D KVM_RISCV_VECTOR_OWNER_HIT;
> +		eligible =3D true;
> +	}

[Severity: Critical]
Can a preemption window in riscv_v_start_kernel_context() allow a kernel
Vector user to clobber the hardware Vector registers without invalidating
kvm_riscv_vector_owner, causing kvm_riscv_vcpu_vector_owner_load() to
falsely report KVM_RISCV_VECTOR_OWNER_HIT?

With CONFIG_RISCV_ISA_V_PREEMPTIVE=3Dy, kernel_vector_begin() calls
riscv_v_start_kernel_context() in arch/riscv/kernel/kernel_mode_vector.c:

	/* Transfer the ownership of V from user to kernel, then save */
	get_cpu_vector_context();
	__riscv_flush_vector_context();
	put_cpu_vector_context();
	/*
	 *  A voluntary context switch caused by put_cpu_vector_context() can
	 *  raise the NEED_RESTORE flag if preempt_v starts too early due to a
	 *  failed risv_v_is_on() check.
	 *
	 *  This causes the next context_nesting_end pollute the v-reg from
	 *  the stale context memory in kernel-mode vector.
	 */
	riscv_v_start(RISCV_PREEMPT_V);

__riscv_flush_vector_context() calls
riscv_v_owner_invalidate(RISCV_V_INVALIDATE_KERNEL_VECTOR) on the initial
hart, and then put_cpu_vector_context() clears RISCV_KERNEL_MODE_V and
re-enables bottom halves or preemption before RISCV_PREEMPT_V is set on
current->thread.riscv_v_flags.

If the task is preempted at put_cpu_vector_context() before
riscv_v_start(RISCV_PREEMPT_V) runs:
1. A vCPU thread can run on this hart and publish itself in
   kvm_riscv_vector_owner via kvm_arch_vcpu_put() ->
   kvm_riscv_vcpu_vector_owner_put(), or the preempted task can migrate to
   another hart that already has a published kvm_riscv_vector_owner.
2. When the task is scheduled back in, __switch_to_vector() in
   arch/riscv/include/asm/vector.h checks riscv_preempt_v_started(next):

	if (riscv_preempt_v_started(next)) {
		riscv_v_owner_invalidate(RISCV_V_INVALIDATE_KERNEL_VECTOR);
		...
	} else {
		riscv_v_vstate_set_restore(next, task_pt_regs(next));
	}

   Because RISCV_PREEMPT_V is not yet set, __switch_to_vector() skips
   riscv_v_owner_invalidate(RISCV_V_INVALIDATE_KERNEL_VECTOR).
3. The task then executes riscv_v_start(RISCV_PREEMPT_V), returns to
   kernel_vector_begin(), enables Vector, and overwrites v0..v31 with host
   kernel data while kvm_riscv_vector_owner on that hart still matches the
   vCPU.
4. When that vCPU reloads on the same hart,
   kvm_riscv_vcpu_vector_owner_load() sees a matching owner, cookie, and
   generation and requests RISCV_V_VCPU_CSR_RESTORE.
   kvm_riscv_vcpu_enter_exit() in arch/riscv/kvm/vcpu.c then restores only
   the Vector CSRs via __kvm_riscv_vector_restore_csrs() and enters the
   guest with host kernel Vector register contents in v0..v31.

> +
> +	trace_kvm_riscv_vector_owner(vcpu->vcpu_id, cpu, 0, eligible,
> +				     reason, host_vs, guest_vs,
> +				     vcpu->arch.vector_state_generation);

[ ... ]

> +void kvm_riscv_vcpu_vector_owner_invalidate(enum riscv_v_invalidate_reas=
on reason)
> +{
> +	struct kvm_riscv_vector_owner *owner;
> +	struct kvm_vcpu *vcpu;
> +	enum kvm_riscv_vector_owner_reason trace_reason;
> +	unsigned long host_vs;
> +	u32 flags;

[ ... ]

> +	preempt_disable();
> +	flags =3D riscv_v_flags();
> +	if (flags & RISCV_V_VCPU_CSR_RESTORE) {
> +		vcpu =3D *this_cpu_ptr(kvm_get_running_vcpus());
> +		if (!WARN_ON_ONCE(!vcpu)) {
> +			flags &=3D ~RISCV_V_VCPU_CSR_RESTORE;
> +			flags |=3D RISCV_V_VCPU_NEED_RESTORE;
> +			riscv_v_flags_set(flags);
> +			host_vs =3D task_pt_regs(current)->status & SR_VS;
> +			trace_kvm_riscv_vector_owner(vcpu->vcpu_id,
> +						     smp_processor_id(), 2, false,
> +					     trace_reason, host_vs,
> +					     vcpu->arch.guest_context.sstatus & SR_VS,
> +					     vcpu->arch.vector_state_generation);
> +		}
> +	}
> +
> +	owner =3D this_cpu_ptr(&kvm_riscv_vector_owner);
> +	if (!owner->identity)
> +		goto out;
> +
> +	host_vs =3D task_pt_regs(current)->status & SR_VS;
> +	trace_kvm_riscv_vector_owner(owner->vcpu_id, smp_processor_id(), 2,
> +				     false, trace_reason, host_vs,
> +				     owner->guest_vs, owner->generation);
> +	owner->identity =3D 0;
> +	owner->cookie =3D 0;
> +	owner->generation =3D 0;
> +	owner->vcpu_id =3D 0;
> +	owner->guest_vs =3D 0;
> +
> +out:
> +	preempt_enable();
> +}

[Severity: High]
When kvm_riscv_v_init() in arch/riscv/include/asm/kvm_vcpu_vector.h registe=
rs
kvm_riscv_vcpu_vector_owner_invalidate(), can this callback and its RCU
dispatch in __riscv_v_owner_invalidate() run from do_trap_ecall_u() before
enter_from_user_mode() transitions RCU and lockdep out of user mode?

In arch/riscv/kernel/traps.c, do_trap_ecall_u() is a noinstr trap handler
that calls riscv_v_vstate_discard(regs) before entering the kernel context:

	if (user_mode(regs)) {
		long syscall =3D regs->a7;

		regs->epc +=3D 4;
		regs->orig_a0 =3D regs->a0;
		regs->a0 =3D -ENOSYS;

		riscv_v_vstate_discard(regs);

		if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &syscall)))=
 {

When a user task with active Vector state issues a syscall,
riscv_v_vstate_discard(regs) in arch/riscv/include/asm/vector.h calls
riscv_v_owner_invalidate(RISCV_V_INVALIDATE_TASK_DISCARD) ->
__riscv_v_owner_invalidate() in arch/riscv/kernel/kernel_mode_vector.c:

	rcu_read_lock();
	invalidate_callback =3D rcu_dereference(kvm_invalidate_vector_ctx_callback=
);
	if (invalidate_callback)
		invalidate_callback(reason);
	rcu_read_unlock();

Because enter_from_user_mode() is only invoked later inside
syscall_enter_from_user_mode_randomize_stack(), on configurations with
CONFIG_CONTEXT_TRACKING_USER=3Dy (such as NO_HZ_FULL), RCU is still in
CT_STATE_USER (!rcu_is_watching()) and lockdep_hardirqs_off() has not run
yet. Calling rcu_read_lock(), rcu_dereference(), preempt_disable(), and
trace_kvm_riscv_vector_owner() here will trigger RCU and tracepoint lockdep
warnings and leave the callback invocation unprotected by synchronize_rcu()
during kvm_riscv_v_exit().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/OSQPR01MB6326538559=
7FE472C4209353C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com?part=3D2
