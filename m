Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950289;
	b=jX9+Gh4xagJg2gsC1KWgHayPsDpiJUDu7UwrpPOBaJANAk6HCYzSFmuTHDw42lnLa/AS
	 QiLmDB/56jcSYH1IydJzWkH9HjKsQQXB06BBfB0Sr4nX7cCHuZUShCekKjG7FU5+TSa/y
	 ERgIPe+Huo/wFShK8wo30FMIDTxW2avDjenFWX0h+I+J+YES+P7GhtzB/UhPVg6e8TgR1
	 PNQkG4qj1iQkBdnYenbetEAfQb+iERN3D/aDDXOWkXnERQzGaaCKLN50e6iBf/wzMLqyW
	 N8cfNLksreekgv2gp0wcBRCzB8SxST7Ak3BxQ0vrbCVhAmPYviZeQv7WtrwpeVHgxSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950289;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LIxmwWgjYm9pFhc8GJXxSWEFuoxzIZOZhgO5nztSz9I=;
	b=cWKJ7xtMa0X/b6D+AiYfn+Z3Nyt5dKv3FtHXoAcp461pX46mDRhAs5tkp4b/iZ6a+X+g
	 pyn+5oCKYY3/HwFpCldy5LnOgrgjAzp7o+szU5Gztw4kGnqQMN4/3e/xyq44C52E2z1g3
	 B0C9w8QCqNXEf9b7cJ08OMDdVojWDeOOJRb4phTTJiqaaRZ9bVF4qyZ9FZ8tzuXGqdmKc
	 sah9wqhN1WoYVMZ7emLbrmFrII87OR8BcjZAFMZOP/CcIzfW99fLsYO1z/JEVfUPj/KPF
	 Z/k29xNX1x9Sg/Sk08Af/NHvnuq9BJDKi7iDhoJ69O7vr9Vwq4/854/bLkbVPt/kbOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eh/BVdky";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1216606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eh/BVdky
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115E31F000C4;
	Tue, 17 Nov 2026 21:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794950289;
	bh=LIxmwWgjYm9pFhc8GJXxSWEFuoxzIZOZhgO5nztSz9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eh/BVdkyEH14uhE/AAUEcZROwxIxPc3OGqr4P0wF5kL+dVq1oBxHfdlgzEOt7MPA4
	 8sV0KP8GVb+jj6V2Au6HiRcnTZ5+0E9irCeYl0UYEuyJMcDrUrL6TWkDde+x9/4RM+
	 yrv773ywAAmRIVO9U1zkkciY8X0tqk/wV9W4owmw13W4l06cJQhmdVXKqx+JIXx3a6
	 XlwqE/uyhRR+MV7YU5lBMsndFXI1EASDnnyia2UjaL6O+hEqEHpqtfE7YW11Bd1y6m
	 bxjL3XJvVJPvD3DOQ1UcWf1BrsKjYbUtRDDxq6PNNKIqy1wRzv9wl2xHbtLp5MJ1cy
	 IbZOBu0stTyhA==
Message-ID: <sashiko-outbox-219682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: Send reschedule IPIs instead of SMP function calls
 for non-waiting requests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261117205428.3717-1-seanjc@google.com>
References: <20261117205428.3717-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 21:18:08 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] KVM: per-CPU cpu_kick_mask corruption in
  kvm_make_all_cpus_request()
- [High] KVM: s390 build failure in kvm_make_vcpu_request() with
  CONFIG_KVM=3Dm
--

commit 38c2c2306d98411374ab3430ab319733689457e7
Author: Sean Christopherson <seanjc@google.com>

KVM: Send reschedule IPIs instead of SMP function calls for non-waiting req=
uests

This commit sends a reschedule IPI to each target vCPU instead of batching
IPIs via smp_call_function_many() when making non-waiting multi-vCPU
requests, allowing non-waiting requests to be made with interrupts disabled.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf4cb586f1407..0b733746884ce 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -241,12 +244,20 @@ static void kvm_make_vcpu_request(struct kvm_vcpu *=
vcpu, unsigned int req,
>  	 * satisfied if the vCPU migrates. Entering READING_SHADOW_PAGE_TABLES
>  	 * after this point is also OK, as the requirement is only that KVM wait
>  	 * for vCPUs that were reading SPTEs _before_ any changes were
> -	 * finalized. See kvm_vcpu_kick() for more details on handling requests.
> +	 * finalized.
> +	 *
> +	 * See kvm_vcpu_kick() for more details on handling requests, including
> +	 * the use of a reschedule IPI for non-waiting requests.  If waiting is
> +	 * required, batch the SMP function call until after all to-be-kicked
> +	 * CPUs are gathered, to avoid waiting multiple times.
>  	 */
>  	if (kvm_request_needs_ipi(vcpu, req)) {
>  		cpu =3D READ_ONCE(vcpu->cpu);
> -		if (cpu !=3D -1 && cpu !=3D current_cpu)
> +		if (cpu !=3D -1 && cpu !=3D current_cpu) {
> +			if (!(req & KVM_REQUEST_WAIT))
> +				smp_send_reschedule(cpu);

[Severity: High]
Does calling smp_send_reschedule() here break the build on s390 when
CONFIG_KVM=3Dm?

On s390, smp_send_reschedule() expands to arch_smp_send_reschedule(),
which is not exported to modules.  __kvm_vcpu_kick() is guarded by
#ifndef CONFIG_S390 for that reason (see 0266c894b51c ("KVM: put back
#ifndef CONFIG_S390 around kvm_vcpu_kick")), whereas
kvm_make_vcpu_request() is built into kvm.ko on s390.

>  			__cpumask_set_cpu(cpu, tmp);
> +		}
>  	}
>  }

[Severity: High]
Can a non-waiting request in interrupt context clobber the per-CPU
cpu_kick_mask of an in-progress waiting request on the same CPU?

kvm_make_all_cpus_request() and kvm_make_vcpus_request_mask() only disable
preemption via get_cpu() while building cpu_kick_mask, leaving interrupts
enabled for waiting requests, and still clear and populate cpu_kick_mask
even when KVM_REQUEST_WAIT is not set:

virt/kvm/kvm_main.c:kvm_make_all_cpus_request() {
	me =3D get_cpu();

	cpus =3D this_cpu_cpumask_var_ptr(cpu_kick_mask);
	cpumask_clear(cpus);

	kvm_for_each_vcpu(i, vcpu, kvm)
		kvm_make_vcpu_request(vcpu, req, cpus, me);

	called =3D kvm_kick_many_cpus(cpus, !!(req & KVM_REQUEST_WAIT));
	put_cpu();
...
}

If an interrupt fires mid-loop and makes a non-waiting multi-vCPU request
(for example on arm64 via irqfd_wakeup() -> kvm_arch_set_irq_inatomic() ->
... -> vgic_queue_irq_unlock()):

kvm_flush_remote_tlbs()
  kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH)
    cpumask_clear(cpus)
    kvm_make_vcpu_request(vcpu0, ...)
      kvm_vcpu_exiting_guest_mode(vcpu0)
        cmpxchg(&vcpu0->mode, IN_GUEST_MODE, EXITING_GUEST_MODE)
      __cpumask_set_cpu(vcpu0->cpu, cpus)
    <hardirq>
      irqfd_wakeup()
        ...
          kvm_make_all_cpus_request(kvm, KVM_REQ_IRQ_PENDING)
            cpumask_clear(cpus)  <-- wipes vcpu0->cpu from cpu_kick_mask
            kvm_make_vcpu_request(vcpu0, ...)
              kvm_request_needs_ipi(vcpu0, ...)  <-- false (EXITING_GUEST_M=
ODE)
    kvm_kick_many_cpus(cpus, true)  <-- misses vcpu0->cpu

Because the outer request already transitioned vcpu0->mode from
IN_GUEST_MODE to EXITING_GUEST_MODE, the nested non-waiting request sees
mode !=3D IN_GUEST_MODE and neither sends a reschedule IPI nor re-adds
vcpu0->cpu to cpu_kick_mask.  When the interrupt returns,
kvm_kick_many_cpus() skips kicking and waiting for vcpu0, so the waiting
request (such as a remote TLB flush) can complete while vcpu0 is still in
guest mode or reading shadow page tables.

Only touching cpu_kick_mask when KVM_REQUEST_WAIT is set (and tracking
whether any CPU was kicked with a local boolean for the return value)
would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117205428.3717=
-1-seanjc@google.com?part=3D1
