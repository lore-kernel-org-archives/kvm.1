Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490913;
	b=3xxNEICdtUI87/kAsPjUED4OJVfacqJDFBci2e8KhTJlt1pzVK9kSG1XHujdzLwIGZFi
	 +CaVPUsLBRKP+Dmnkb41WiPYQAnJutcH64yVutG5aB1KBg3aCuoLHq/DPHXBMzaFxjpJ2
	 ebpS6OxLScc3HJFw3HEUv237KsvsTtjs3kfbpdB8mXqi/WYS8DYpWoHZ6O+gl28Mo/QaI
	 2qnRngt7UE0i3dHAhXSiqd0lmLwuro2/WWYEQ5B9Q2eNyNYYewC8aLMDYShnrcXvdLUzB
	 20mGi/UJCEiGz3YqZ9CRKVid6e6o6apDYQh/vtIisz1Pa349AQEQdSp8U3HC/ddvcfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490913;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SjT5XBnlckbh7zbaJ4V23lj8qiCFtCBNLfeFwSuy4aA=;
	b=qDg6u+zfgYJd4Q3MX+wCMu62AocsQXqRu3yyPWUGBPeWqsangHP6Z+8wlOfpNkCT8GYU
	 0JISbwOpsIfI7RQaL7UxxG09BvaREUAIWoR2vE3qgNMb0wixYBW5VOBVbx9EiuzUNl4Cy
	 ImUt09ELxI3gxeIl2FhQAmhkEXfFhbtfenevSmqNZe0if1CCqtpG/whqew4bAlv9ehA80
	 OdgcE7gMv93WPHcr2owMepuLbW5U1g43z53rM5iC7nORxwa9MaJDIzikwiTxl8xFwUS4o
	 +jxEyk8AtxgJN/Y6XVgVpL9vcmHc/wFKoExbLY2TKsTQU86ekfWFBVktRBsX50/mOUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsLWhr02;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ED8606A32F
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsLWhr02
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807081F000C8;
	Tue, 20 Oct 2026 10:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792490912;
	bh=SjT5XBnlckbh7zbaJ4V23lj8qiCFtCBNLfeFwSuy4aA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QsLWhr02WdZGGsQKtJXP5jtm6P3ndNoAEjRCqZgaKUfboFTN/uqrmKSHEgoaN5c7o
	 i5VwTWDMP7MYSMqbuYyHuDEjs2t9C94r8zFNsfpdiKmKi9jEgzsFo+20WwhRd6HO0K
	 Yhp9T36auF89vjhXW0E86006rySCfv/Ih90ZR1HLy5vBb6x30srPkFVxsbrqVq/FEX
	 e8bNNKW8YzBnCYOdvB/eVdYqjFwScqCCf4FSIzgzbZLSA6ZclaZJnBF8TKb6qGvfP5
	 YzKcVfiWJNbf4bGCLw6yh24cDz9s5tt2gXg63SkP1GbwnHTiA3n4EDkl5Gjc8go34X
	 bOjO5TUrD7DbA==
Message-ID: <sashiko-outbox-178795@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: x86: Wake blocked vCPUs before offlining a
 CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinmeng Zhou" <jinmengzhou22@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261020085401.80296-3-jinmengzhou22@gmail.com>
References: <20260924080648.51014-1-zhoujinmeng@bytedance.com>
 <20261020085401.80296-1-jinmengzhou22@gmail.com>
 <20261020085401.80296-3-jinmengzhou22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 10:08:32 +0000
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
- [Critical] KVM: VMX: out-of-bounds per-CPU access in vmx_vcpu_pi_load() o=
n TDX CPU offline
- [High] KVM: x86: pi_cpu_offline() runs before CPUHP_AP_SCHED_WAIT_EMPTY d=
rains tasks
--

commit e59f5fb4482718a249da5dc7f86ef0922b551270
Author: Jinmeng Zhou <zhoujinmeng@bytedance.com>

KVM: x86: Wake blocked vCPUs before offlining a CPU

This commit adds an optional x86 vendor cpu_offline() callback invoked duri=
ng
CPUHP_AP_X86_KVM_ONLINE teardown and implements it for VMX to wake blocked
vCPUs on the outgoing CPU's posted-interrupt wakeup list so their
posted-interrupt destination state is migrated to an active CPU.

> diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_int=
r.c
> index 4a6d9a17da238..1905472b336d3 100644
> --- a/arch/x86/kvm/vmx/posted_intr.c
> +++ b/arch/x86/kvm/vmx/posted_intr.c
> @@ -266,6 +266,24 @@ void pi_wakeup_handler(void)
>  	raw_spin_unlock(spinlock);
>  }
> =20
> +void pi_cpu_offline(unsigned int cpu)
> +{
> +	struct list_head *wakeup_list =3D &per_cpu(wakeup_vcpus_on_cpu, cpu);
> +	raw_spinlock_t *spinlock =3D &per_cpu(wakeup_vcpus_on_cpu_lock, cpu);
> +	struct vcpu_vt *vt;
> +	unsigned long flags;
> +
> +	/*
> +	 * CPUHP_AP_ACTIVE has already deactivated the CPU.  Wake blocked vCPUs
> +	 * so that they are scheduled on another CPU and rebuild their posted
> +	 * interrupt wakeup state in vmx_vcpu_pi_load().
> +	 */
> +	raw_spin_lock_irqsave(spinlock, flags);
> +	list_for_each_entry(vt, wakeup_list, pi_wakeup_list)
> +		__kvm_vcpu_wake_up(vt_to_vcpu(vt));
> +	raw_spin_unlock_irqrestore(spinlock, flags);
> +}

[Severity: Critical]
Can this trigger an out-of-bounds per-CPU access in vmx_vcpu_pi_load() when
offlining a CPU with a blocked TDX vCPU that uses VT-d posted interrupts?

When a TDX vCPU blocks on CPU C with posted interrupts enabled,
tdx_vcpu_put() -> vmx_vcpu_pi_put() -> pi_enable_wakeup_handler() adds
vt->pi_wakeup_list to per_cpu(wakeup_vcpus_on_cpu, C) and sets pi_desc->nv =
to
POSTED_INTR_WAKEUP_VECTOR while the vCPU is on per_cpu(associated_tdvcpus, =
C)
with vcpu->cpu =3D=3D C.

During CPU hot-unplug of CPU C, pi_cpu_offline(C) calls __kvm_vcpu_wake_up(=
),
which asynchronously wakes the vCPU task on another active CPU D without
removing vt->pi_wakeup_list or waiting for the vCPU task to schedule in on
CPU D.

As CPU C continues hotplug teardown to CPUHP_AP_KVM_ONLINE (since
CPUHP_AP_SCHED_WAIT_EMPTY only waits for CPU C's own runqueue to drain),
kvm_offline_cpu() -> kvm_disable_virtualization_cpu() ->
vt_disable_virtualization_cpu() -> tdx_disable_virtualization_cpu() ->
tdx_flush_vp() -> tdx_disassociate_vp() runs on CPU C and resets vcpu->cpu =
to
-1:

arch/x86/kvm/vmx/tdx.c:tdx_disassociate_vp() {
	lockdep_assert_irqs_disabled();

	list_del(&to_tdx(vcpu)->cpu_list);
	...
	smp_wmb();

	vcpu->cpu =3D -1;
}

When the woken TDX vCPU task subsequently schedules in on CPU D,
kvm_sched_in() -> kvm_arch_vcpu_load() -> vt_vcpu_load() -> tdx_vcpu_load()
calls vmx_vcpu_pi_load(vcpu, D) before vcpu->cpu is updated at the end of
kvm_arch_vcpu_load():

arch/x86/kvm/vmx/posted_intr.c:vmx_vcpu_pi_load() {
	...
	if (pi_desc->nv =3D=3D POSTED_INTR_WAKEUP_VECTOR) {
		raw_spinlock_t *spinlock =3D &per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu=
);

		raw_spin_lock(spinlock);
		spin_acquire(&spinlock->dep_map, PI_LOCK_SCHED_OUT, 0, _RET_IP_);
		list_del(&vt->pi_wakeup_list);
		spin_release(&spinlock->dep_map, _RET_IP_);
		raw_spin_unlock(spinlock);
	}
}

With vcpu->cpu =3D=3D -1, doesn't &per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->=
cpu)
index __per_cpu_offset[-1] out of bounds, pass an invalid spinlock pointer =
to
raw_spin_lock(), and delete vt->pi_wakeup_list without holding CPU C's
wakeup_vcpus_on_cpu_lock?

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a08ae25f373fb..38bffe6ec9b4b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6823,8 +6823,9 @@ static int kvm_x86_cpu_online(unsigned int cpu)
>  static int kvm_x86_cpu_offline(unsigned int cpu)
>  {
>  	if (!boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
> -		return kvmclock_cpu_down_prep(cpu);
> +		kvmclock_cpu_down_prep(cpu);
> =20
> +	kvm_x86_call(cpu_offline)(cpu);
>  	return 0;
>  }

[Severity: High]
Could a vCPU task in a migrate_disable() region still block on the outgoing
CPU and add itself to wakeup_vcpus_on_cpu after kvm_x86_cpu_offline() has
already walked the list?

During CPU teardown, callbacks run in descending order of enum cpuhp_state:

include/linux/cpuhotplug.h:
	CPUHP_AP_KVM_ONLINE,
	CPUHP_AP_SCHED_WAIT_EMPTY,
	...
	CPUHP_AP_X86_KVM_ONLINE,
	CPUHP_AP_ACTIVE,

In CPUHP_AP_ACTIVE, sched_cpu_deactivate() clears cpu_active_mask and enabl=
es
balance_push_set(cpu, true), but draining tasks in migrate_disable() regions
on the outgoing CPU happens later at CPUHP_AP_SCHED_WAIT_EMPTY via
sched_cpu_wait_empty() -> balance_hotplug_wait().

If a vCPU task running vcpu_run() enters a migrate_disable() region (for
example on CONFIG_PREEMPT_RT where spinlock_t, rwlock_t such as kvm->mmu_lo=
ck,
and local_lock_t call migrate_disable(), or via bpf_prog_run_pin_on_cpu())
and gets preempted or blocks on an rtmutex, __schedule() calls
migrate_disable_switch(), setting p->cpus_ptr =3D cpumask_of(cpu) while
p->cpus_mask retains its normal affinity mask.

CPUHP_AP_X86_KVM_ONLINE then runs kvm_x86_cpu_offline() -> pi_cpu_offline(c=
pu)
while the vCPU is not in kvm_vcpu_block(), and the hotplug thread waits at
CPUHP_AP_SCHED_WAIT_EMPTY in balance_hotplug_wait() because
rq_has_pinned_tasks(rq) is true.

When the vCPU task switches back in on the dying CPU, finish_lock_switch() =
->
__balance_callbacks() -> balance_push() returns early because migration is
disabled:

kernel/sched/core.c:balance_push() {
	...
	if (kthread_is_per_cpu(push_task) ||
	    is_migration_disabled(push_task)) {
		...
		return;
	}
}

When the vCPU task exits its migrate_disable() region, __migrate_enable() ->
___migrate_enable() -> __set_cpus_allowed_ptr() -> affine_move_task() checks
whether the current CPU is still in p->cpus_mask:

kernel/sched/core.c:affine_move_task() {
	...
	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask) ||
	    (task_current_donor(rq, p) && !task_current(rq, p))) {
		struct task_struct *push_task =3D NULL;

		if ((flags & SCA_MIGRATE_ENABLE) &&
		    (p->migration_flags & MDF_PUSH) && !rq->push_busy) {
			rq->push_busy =3D true;
			push_task =3D get_task_struct(p);
		}
		...
		return 0;
	}
}

Because offline CPUs are not cleared from p->cpus_mask for tasks in
top_cpuset, and MDF_PUSH was not set (MDF_PUSH is only set by RT/DL
push_cpu_stop()), affine_move_task() returns 0 without migrating the task or
setting TIF_NEED_RESCHED.

If the vCPU task then reaches kvm_vcpu_halt() -> kvm_vcpu_block() ->
schedule() before another preemption occurs, kvm_sched_out() ->
vmx_vcpu_pi_put() -> pi_enable_wakeup_handler() will add vt->pi_wakeup_list=
 to
per_cpu(wakeup_vcpus_on_cpu, cpu) with pi_desc.ndst targeting the offline C=
PU
after pi_cpu_offline(cpu) has already finished.

Should pi_cpu_offline() instead be invoked after CPUHP_AP_SCHED_WAIT_EMPTY
(for instance from the CPUHP_AP_KVM_ONLINE stage, which was placed below
CPUHP_AP_SCHED_WAIT_EMPTY so balance_hotplug_wait() has already drained all
vCPU tasks from the outgoing CPU)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020085401.8029=
6-1-jinmengzhou22@gmail.com?part=3D2
