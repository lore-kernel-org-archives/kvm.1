Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109823;
	b=IdHXgkQFjOFaIPCoycytQd1WJDWvbpgtmKbge0wpyfl/V7JXRD56em7TMJjdqkqhdLsO
	 p/h2Lk1viUzOQ7NpBS0S9UEt7LIHJeAEZNh5/XS/googiEfw9YfuS0XW8fEpPbGh0kMsW
	 cBbHLXvfjaayK9T33nw4JCmtWtZfvG0cvAzcFm1ixUOBvjK2+WjJuTuhWvr77jNBwj/Ra
	 RO2BeHDiY/e0vGb0lF8NbavciPffeQeT7qFIeqquqHDSRynm9wvUrgYMatjPqAGcidfpr
	 qPF327UwE+Ae9OS+ADW9UDKsGpoFC6zBg7ETrq6LuktSBV5ikQIeLM8o/eurNxEdjqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109823;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XoFMhljdtvesrCdXOtN3CnaAsyT2Zq81OSye7AuCvDQ=;
	b=RuKGVuuE3ULGcydgoazhUex1CL23+oNvonYYhMeMf5FCq9YVB5jOnOOcBUABX/zO+h+l
	 yR3y9PUh7zpvKUyVBGBldHH5waFoZI7olOJvcL8g1TmdF5UhG9/tmfAQKXhSp1h3L81ia
	 qVemdo3GS2M8uqEzGLPYLsjHtf001Cf2lkk+TyH9XIfFGF6TyYr5IJooG/DmST1NrjJaf
	 zyrp6FpdXEl6hxUmsIovV7SxT+L1r6WnkEdTq1YTlMhvG+k+RqK33kTDC05/DVn0hEnsv
	 o/INxaiS0FsndZHDLPC9OGlMiBAL2N+05h9/lv8gEoYNnjjEwf/3EPDbENvhwpKqwFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QiJ5wrpD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F0606A31D
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QiJ5wrpD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B9E1F01828;
	Tue, 27 Oct 2026 14:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109822;
	bh=XoFMhljdtvesrCdXOtN3CnaAsyT2Zq81OSye7AuCvDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QiJ5wrpDtPKaISqFb7rRXhy7eOcpbX/HZgC+YfWT+f6vwP3fs+a9JkxfIvDE3J3Xj
	 MjAxLQCGE08lrVLuyUJ7SJIOEMNkxOn3DwbK0tMJ3rfaCiCw/ZToYcr84Ixc/MzSM4
	 lnNODmpKj8xD9Z+kaEUhV5KZsUUrLLlLVVCmzrOe5dlRMplH7gPNeLlvjTc1FgW88w
	 obfIZpSIcNjCPbCm+cFG4zsyK3S60ok44OL81r6nnWrv3UwOut9UYp0d2XnF3PjpSh
	 9Es0yfjPdCgxpAT0qXTqQStHo4kpNEXVNPnt9NEJMBzKxDo5DLb/zHETkfZE9gWB2O
	 5OFleVfqXmEqA==
Message-ID: <sashiko-outbox-186687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] riscv: vector: Add a guest owner invalidation
 hook
Reply-To: sashiko-reviews@lists.linux.dev
To: "slack up" <yxcnew@outlook.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <OSQPR01MB6326C7FC1D0778FA203C4CC4C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
References: <OSQPR01MB63265385597FE472C4209353C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
 <OSQPR01MB6326C7FC1D0778FA203C4CC4C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:03:42 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] riscv: vector: RCU and noinstr violation in riscv_v_vstate_discard=
()
- [High] riscv: vector: missed owner invalidation in riscv_v_start_kernel_c=
ontext()
--

commit 1bfcfc81beacec1c831b6f2d3e0f036424e54b70
Author: Xiaochun Yu <yxcnew@outlook.com>

riscv: vector: Add a guest owner invalidation hook

This commit introduces an RCU-protected invalidation callback guarded by a
static key so generic RISC-V Vector paths can notify KVM before modifying
the hardware Vector register file. It adds invalidation hooks to task
Vector state save, restore, and discard paths, kernel-mode Vector entry,
and context switch resume for preemptible kernel Vector users.

> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index 1f8dcae3af517..967dd70f4ea4a 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h

[ ... ]

> @@ -303,6 +323,7 @@ static inline void __riscv_v_vstate_discard(void)
>  static inline void riscv_v_vstate_discard(struct pt_regs *regs)
>  {
>  	if (riscv_v_vstate_query(regs)) {
> +		riscv_v_owner_invalidate(RISCV_V_INVALIDATE_TASK_DISCARD);
>  		__riscv_v_vstate_discard();
>  		__riscv_v_vstate_dirty(regs);
>  	}

[Severity: High]
Is it safe to call riscv_v_owner_invalidate() from riscv_v_vstate_discard()
during syscall entry before RCU is watching?

In arch/riscv/kernel/traps.c, do_trap_ecall_u() is a __trap_section
(noinstr) handler that calls riscv_v_vstate_discard() before entering the
kernel context:

arch/riscv/kernel/traps.c:do_trap_ecall_u() {
	if (user_mode(regs)) {
		...
		riscv_v_vstate_discard(regs);

		if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &syscall)))=
 {

The transition out of the user-mode RCU extended quiescent state
(CT_STATE_USER) via enter_from_user_mode() -> user_exit_irqoff() only
happens inside syscall_enter_from_user_mode_randomize_stack().

When a userspace task with active Vector state issues a syscall while
riscv_v_owner_invalidate_key is enabled, riscv_v_vstate_discard() calls
into the instrumentable __riscv_v_owner_invalidate() function, which calls
rcu_read_lock(), rcu_dereference(), the registered callback, and
rcu_read_unlock() while the CPU is still in CT_STATE_USER.

On kernels with CONFIG_CONTEXT_TRACKING_USER=3Dy (such as CONFIG_NO_HZ_FULL=
=3Dy
or CONFIG_CONTEXT_TRACKING_FORCE=3Dy), RCU is not watching at this point.
Wouldn't this violate noinstr constraints, trigger the rcu_read_lock()
lockdep warning for being used while idle, and allow synchronize_rcu() in
kvm_riscv_unregister_vctx_invalidate() to finish while invalidate_callback()
is still executing?

> @@ -393,6 +416,13 @@ static inline void __switch_to_vector(struct task_st=
ruct *prev,
>  	}
> =20
>  	if (riscv_preempt_v_started(next)) {
> +		/*
> +		 * A preemptible kernel Vector user can be scheduled back after a
> +		 * vCPU published a guest owner on this hart.  Drop that owner before
> +		 * the kernel context resumes or restores and overwrites the register
> +		 * file.
> +		 */
> +		riscv_v_owner_invalidate(RISCV_V_INVALIDATE_KERNEL_VECTOR);
>  		if (next->thread.riscv_v_flags & RISCV_PREEMPT_V_IN_SCHEDULE) {
>  			next->thread.riscv_v_flags &=3D ~RISCV_PREEMPT_V_IN_SCHEDULE;
>  			riscv_v_enable();

[ ... ]

> diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/k=
ernel_mode_vector.c
> index 77e98b504485e..9e87bdf020285 100644
> --- a/arch/riscv/kernel/kernel_mode_vector.c
> +++ b/arch/riscv/kernel/kernel_mode_vector.c

[ ... ]

> @@ -106,6 +142,8 @@ static void __riscv_flush_vector_context(void)
>  {
>  	void (*vcpu_flush_v_callback)(void);
> =20
> +	riscv_v_owner_invalidate(RISCV_V_INVALIDATE_KERNEL_VECTOR);
> +
>  	if (riscv_v_flags() & RISCV_V_VCPU_CTX) {
>  		rcu_read_lock();
>  		vcpu_flush_v_callback =3D rcu_dereference(kvm_flush_vector_ctx_callbac=
k);

[Severity: High]
Can a preemption or migration between put_cpu_vector_context() and
riscv_v_start(RISCV_PREEMPT_V) in riscv_v_start_kernel_context() miss a
required guest owner invalidation?

With CONFIG_RISCV_ISA_V_PREEMPTIVE=3Dy, kernel_vector_begin() sets up
preemptible kernel Vector execution via riscv_v_start_kernel_context():

arch/riscv/kernel/kernel_mode_vector.c:riscv_v_start_kernel_context() {
	...
	/* Transfer the ownership of V from user to kernel, then save */
	get_cpu_vector_context();
	__riscv_flush_vector_context();
	put_cpu_vector_context();
	...
	riscv_v_start(RISCV_PREEMPT_V);
	return 0;
}

__riscv_flush_vector_context() calls riscv_v_owner_invalidate() on the
current hart while preemption is disabled, and then put_cpu_vector_context()
re-enables preemption and bottom halves before riscv_v_start(RISCV_PREEMPT_=
V)
sets RISCV_PREEMPT_V in current->thread.riscv_v_flags.

If the task is preempted in that window before RISCV_PREEMPT_V is set, a
vCPU thread can run on the same hart and publish guest Vector ownership, or
the task can migrate to another hart that already has a resident guest
Vector owner.

When the task is scheduled back in, __switch_to_vector() checks
riscv_preempt_v_started(next), which is still false because RISCV_PREEMPT_V
has not been set yet, so __switch_to_vector() skips
riscv_v_owner_invalidate(). The task then sets RISCV_PREEMPT_V, returns to
kernel_vector_begin(), calls riscv_v_enable(), and overwrites the hardware
Vector registers while the hart's guest Vector owner remains valid.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/OSQPR01MB6326538559=
7FE472C4209353C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com?part=3D1
