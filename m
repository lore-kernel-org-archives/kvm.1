Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711348;
	b=eK1KmkL2H9GLe1BeMzgHwVW/vnSud8pVWnZ5PPGkAi4qg0qdNXBcEJgv84HEobC2Hxdd
	 8JMEzBegBEyVs4VMAcWPPuUaqeRnBc218zuiQqiDsaD/MWpIEqdEfpX2I/URkzchGHTFK
	 gfJ0k6mPNTMNKSXLz3lLjBdrg06mE3OwNEzpXLPahATunvO8/JAhJ1Gx+WC1ckbwhoC0I
	 KIlOGMKbg7I7KsK6qXLdHSxqNBZS8O4PhG5aNigCFkBcbWfnL5asbLzyXzRfCcr2QQzDD
	 aAlJqslY0I3tZnK+wsRsCm3K+4vALxeRhuFyk9Bk1ho0RM19HiveyKBbPcmJ+G+pfmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711348;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ebMqWZqU2b+vLMooDXv/kHFWotkjuWXg1E3C3JMTe/I=;
	b=eKzj5yYQVo+d3xqgAdCbWy0rnmV73f5xFNKBjRGfGlv7u7usanbRpcwoqMpZPVkw0m9v
	 1nj+avVUopzTgZaPFP4lbgHAv2ckwT2m927FOTt7fl3F6HupkRC4Rgh0y5fONE3QhZZci
	 Nn7663OK1pLPxbmlJ9TUyJR3Mw9OEelxDTZcW1TFdu1CM6LJ52I1AlfLT67TIITcCegRt
	 5I9YiJ3E/+tCfA1886m0BxjCn2NwP4lQ+ibM6VpeyIQiMQzQhZrQ60SX+V/Whk8r9M1oH
	 zCTXNHvODv9bw9ATej+8MdxUkMeapMpcQP8WH6f/Q/RSOHUs+NXJa9TIAHlKkg5X3Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kO4v3IO+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53F606A32F
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kO4v3IO+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1843D1F000C1;
	Tue,  3 Nov 2026 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711348;
	bh=ebMqWZqU2b+vLMooDXv/kHFWotkjuWXg1E3C3JMTe/I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kO4v3IO+lMG1d7U4FBbNp+MKCxgnEnp/RYQt2MDPQ5nOZoRFOUvjXRG+WJLbCFvJT
	 xgGBmO1mq8ssRQNQo0SrQSJXSxME+mkOTcX+RSOuMSKoPny+VmJKT1mFZ0mtPeK9tJ
	 VdoRLSrmyE1n2ZxEsdsCRodelkkCu2WKrBlOZTSiquM8K3qSnkgRnIHKjv8yfogPiO
	 6UIkpJtx3NFMa3D9XrpgJ0G66YGAQm6fOXkpyD3KgmOOoytVY9s/fd9nX13PFcT2Jd
	 E7WPYq8kqIYcEs5G5R7PCvFbtSRwkbcRbofeuXXe8Q7cLyTn7x6uDB5UpnJpMhRcSK
	 kqkU25vVRnBKQ==
Message-ID: <sashiko-outbox-195309@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: register asynchronous page fault waits with
 interrupts disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261103124930.2278671-2-pbonzini@redhat.com>
References: <20261103124930.2278671-1-pbonzini@redhat.com>
 <20261103124930.2278671-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 13:09:07 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM: x86: race on host_apf_node.wq in apf_task_wake_one() after vC=
PU migration
--

commit a7551b9e239e704cac35f0fb0f96e22e31414870
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: register asynchronous page fault waits with interrupts disabled

This commit splits asynchronous page fault waiter registration from waiting=
 so
that KVM can queue a per-vCPU sleep node while interrupts are still disabled
on #PF VM-exit, avoiding dummy sleep node allocations when a vCPU thread is
preempted before reaching kvm_handle_page_fault().

Link: https://lore.kernel.org/kvm/6adf2939.67317f00.38c4bc.00ae.GAE@google.=
com/

> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 9f0efbe947934..ca5dcdc7ffde8 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -108,12 +100,14 @@ static struct kvm_task_sleep_node *_find_apf_task(s=
truct kvm_task_sleep_head *b,
>  	return NULL;
>  }
> =20
> -static bool kvm_async_pf_queue_task(u32 token, struct kvm_task_sleep_nod=
e *n)
> +bool kvm_async_pf_queue_task(u32 token, struct kvm_task_sleep_node *n)
>  {
>  	u32 key =3D hash_32(token, KVM_TASK_SLEEP_HASHBITS);
>  	struct kvm_task_sleep_head *b =3D &async_pf_sleepers[key];
>  	struct kvm_task_sleep_node *e;
> =20
> +	lockdep_assert_irqs_disabled();
> +
>  	raw_spin_lock(&b->lock);
>  	e =3D _find_apf_task(b, token);
>  	if (e) {
> @@ -142,34 +136,31 @@ static bool kvm_async_pf_queue_task(u32 token, stru=
ct kvm_task_sleep_node *n)
>  	raw_spin_unlock(&b->lock);
>  	return true;
>  }
> +EXPORT_SYMBOL_FOR_KVM(kvm_async_pf_queue_task);
> =20
>  /*
>   * kvm_async_pf_task_wait_schedule - Wait for pagefault to be handled
> - * @token:	Token to identify the sleep node entry
> + * @n:	Previously queued sleep node.
>   *
>   * Invoked from the async pagefault handling code or from the VM exit pa=
ge
>   * fault handler. In both cases RCU is watching.
>   */
> -void kvm_async_pf_task_wait_schedule(u32 token)
> +void kvm_async_pf_task_wait_schedule(struct kvm_task_sleep_node *n)
>  {
> -	struct kvm_task_sleep_node n;
>  	DECLARE_SWAITQUEUE(wait);
> =20
>  	lockdep_assert_irqs_disabled();
> =20
> -	if (!kvm_async_pf_queue_task(token, &n))
> -		return;
> -
>  	for (;;) {
> -		prepare_to_swait_exclusive(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
> -		if (hlist_unhashed(&n.link))
> +		prepare_to_swait_exclusive(&n->wq, &wait, TASK_UNINTERRUPTIBLE);
> +		if (hlist_unhashed(&n->link))
>  			break;
> =20
>  		local_irq_enable();
>  		schedule();
>  		local_irq_disable();
>  	}
> -	finish_swait(&n.wq, &wait);
> +	finish_swait(&n->wq, &wait);
>  }
>  EXPORT_SYMBOL_FOR_KVM(kvm_async_pf_task_wait_schedule);

[ ... ]

> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index b2a295a9f084e..3cb2616d88aca 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -162,6 +162,20 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forc=
ed_root_level,
>  bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
>  int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
>  				u64 fault_address, char *insn, int insn_len);
> +
> +static inline void kvm_handle_host_apf_irqoff(struct kvm_vcpu *vcpu, u32=
 token)
> +{
> +	vcpu->arch.apf.host_apf_flags =3D kvm_read_and_reset_apf_flags();
> +	if ((vcpu->arch.apf.host_apf_flags & KVM_PV_REASON_PAGE_NOT_PRESENT) &&
> +	    !kvm_async_pf_queue_task(token, &vcpu->arch.apf.host_apf_node)) {

[Severity: High]
Can splitting kvm_async_pf_queue_task() from kvm_async_pf_task_wait_schedul=
e()
cause a race on vcpu->arch.apf.host_apf_node.wq if the vCPU task is preempt=
ed
and migrated between VM-exit and kvm_handle_page_fault()?

When svm_vcpu_run() or handle_exception_irqoff() calls
kvm_handle_host_apf_irqoff(), host_apf_node is linked into async_pf_sleepers
on CPU A while interrupts are disabled. Afterward, vcpu_enter_guest() enabl=
es
interrupts and preemption before calling into handle_exit() ->
kvm_handle_page_fault().

If the vCPU task is preempted in that window and migrated to CPU B, both CP=
Us
can access host_apf_node concurrently when the page-ready interrupt arrives=
 on
CPU A:

CPU B (vcpu task)                      CPU A (page-ready IRQ)
-----------------                      ----------------------
kvm_handle_page_fault()
  kvm_async_pf_task_wait_schedule()
    prepare_to_swait_exclusive(&n->wq, &wait, ...)
      /* adds wait to n->wq.task_list
         and drops n->wq.lock */
                                       kvm_async_pf_task_wake()
                                         raw_spin_lock(&b->lock);
                                         apf_task_wake_one(n)
                                           hlist_del_init(&n->link);
                                           if (swq_has_sleeper(&n->wq))
    if (hlist_unhashed(&n->link))
      break;
    finish_swait(&n->wq, &wait);
                                             swake_up_one(&n->wq);

Because apf_task_wake_one() unhashes n->link before calling swake_up_one(),
and kvm_async_pf_task_wait_schedule() does not synchronize with b->lock bef=
ore
returning, CPU B can observe hlist_unhashed(&n->link), remove wait via
finish_swait(), and return from kvm_async_pf_task_wait_schedule() while CPU=
 A
is still about to execute swake_up_one(&n->wq).

Could CPU B then re-enter the guest and call kvm_async_pf_queue_task() ->
init_swait_queue_head(&n->wq) for a subsequent async #PF (or exit to usersp=
ace
and free the vCPU) while swake_up_one(&n->wq) is still running on CPU A?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103124930.2278=
671-1-pbonzini@redhat.com?part=3D1
