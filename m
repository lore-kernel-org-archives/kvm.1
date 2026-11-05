Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845988;
	b=bv3ZlVmhqRAdyGrhD0Ueva9eeKXDwkMS3riy7Dh2RHpO+eLm/JG5IeulYCYjwCCoUrAt
	 PjcKMyXzu4Vdb4S49B+dAtWc+/hfOrzVvrCkBxDRguKJevg2utZv8Jn+TpQciJ7ejypSP
	 gM3mWiXVcwHMq7nPVrI45Kz/7x7Z9aAKORnG64VTWFNTOGyZ2mKkddLS7d4j9JZaU9Zh+
	 4jt5i1CcNOPiOaaMsLsNh+4KRL/TmVvpTPZxNaRKoKDNxpI68t1HbAI0f/9wqLDcDnGr+
	 lGBl8P6PLy/OGSMLE9y+9SYbzODBMZPA3UbbjWGGdz8UeUqjC8CqfSSvWG4PJk/iyJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845988;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tinDBj+cvdQpvWX1kGaOHHmRbI9Dk0CoSS1KCLAvOdg=;
	b=eRtpqCA53CKBg3MUUalMyX0R/Vtm9GqqS4uQwHp0cDoCJP/D899bxWcXb6IwVQpf7xhu
	 lvUniIr/Y+aI1+E9jysPFMSNXnJCsStGFSlUotMDYrr/eiecyDsll6dVdc+WOFiTCzSbY
	 h6mhlTJXRTLO1SbzdrDHdwocR6KSpiZNOccvGrj/izukLFYK4E1dqxs3cZGHOfDcz+C6C
	 l64gh34RcXUdQcUMMCNqCy8aAC9aYGa3MnKx9LjCuye0CbfXpOtdZSiaBNMyKw/JscjE9
	 htm5RCTcBxpIv2yY6feFPGEhTN2GV9HRUlD4VN/YU8PRe3Mox8sQutCxNSN3yNjemCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cqXWLvw/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620D606A326;
	Thu,  5 Nov 2026 02:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqXWLvw/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217AE1F000C1;
	Thu,  5 Nov 2026 02:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793845987;
	bh=tinDBj+cvdQpvWX1kGaOHHmRbI9Dk0CoSS1KCLAvOdg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cqXWLvw/SK+G72I2O+RbdFJKiaPYVhE5HkorWYchOxIEDG34vyyN8PJBqFWwfxS9O
	 35MSqujR5Bt9/heKjW3/SKPG2HQWV8nSrs5ASqb7mu76YGHX/y/6jKEI2S3ak8Au4Y
	 F2R2aPmED74V+THnOg74f1EjxOwHXL0FgDTcT94hjU4DAnwfY8+fRbDOhWDO+4w++m
	 75gmQKy4dFabpN/WJxAxXQp/5Mx3v37chJpUnjAAovSUUn/KXpRSZSytoW/r6Y4P6Y
	 DoN44AUqESjUE60VohhvKYs6CjH70DOblzEjsShRyBP+r4G9gP+YxMcBaaz2rGRO2H
	 2Wd+CJDgIuvoQ==
Message-ID: <sashiko-outbox-198466@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/20] KVM: nVMX: Use pinned pfncache for L1 APIC
 virtualization pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261105020104.2507083-13-dwmw2@infradead.org>
References: <20261105020104.2507083-1-dwmw2@infradead.org>
 <20261105020104.2507083-13-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:33:06 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] KVM: nVMX: spurious L2 unhalt in vmx_has_nested_events() on invali=
d cache
- [High] KVM: nVMX: fatal exit and PI loss in vmx_complete_nested_posted_in=
terrupt()
- [Medium] KVM: nVMX: loss of entry-time semantics on retry in nested_get_v=
mcs12_pages()
- [Low] KVM: nVMX: redundant request repost in nested_gpc_hpa() when refres=
hing pin
--

commit 2e4c94957b2cebc2ce8ce9d33fd7500248768210
Author: Fred Griffoul <fgriffo@amazon.co.uk>

KVM: nVMX: Use pinned pfncache for L1 APIC virtualization pages

This commit replaces kvm_host_map with pinned gfn_to_pfn_cache instances for
the L1 APIC-access page, virtual-APIC page, and posted interrupt descriptor
in vmcs02. Caches are pinned for guest use on nested entry or state
revalidation, and invalidated caches trigger KVM_REQ_GET_NESTED_STATE_PAGES
to refresh or degrade the corresponding vmcs02 controls.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index bb0baa79c28cb..23f1fff97917a 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -320,14 +320,140 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu,=
 struct loaded_vmcs *vmcs)
>  	kvm_reset_dirty_registers(vcpu);
>  }
> =20
> +/*
> + * Map a page of L1 memory, pin it for direct use by the guest (i.e. by
> + * the CPU while running the L2 guest, via a physical address in vmcs02),
> + * and return the host physical address to write into vmcs02. The pin
> + * guarantees that if the mapping is invalidated, this vCPU is forced out
> + * of guest mode and KVM_REQ_GET_NESTED_STATE_PAGES is posted so that the
> + * address is re-established (or the vCPU exits to userspace) before the
> + * next entry to guest mode.
> + */
> +static int nested_gpc_hpa(struct gfn_to_pfn_cache *gpc, gpa_t gpa, hpa_t=
 *hpa)
> +{
> +	int idx;
> +
> +	do {
> +		idx =3D kvm_gpc_lock_page(gpc, gpa);

[Severity: Low]
When KVM_REQ_GET_NESTED_STATE_PAGES runs to refresh an already-pinned cache
after an mmu_notifier invalidation or a memslot generation change,
GPC_GUEST_USING is still set in gpc->state because
gfn_to_pfn_cache_invalidate_start() preserves GPC_GUEST_USING in the state
word.

When nested_gpc_hpa() calls kvm_gpc_lock_page() -> kvm_gpc_activate() ->
__kvm_gpc_refresh() without unpinning first, __kvm_gpc_refresh() executes:

virt/kvm/pfncache.c:__kvm_gpc_refresh() {
    ...
	old_state =3D atomic_xchg(&gpc->state, GPC_INVALIDATING);
	gpc_kick_pinned_vcpu(gpc, old_state);
    ...
}

Because GPC_GUEST_USING is still present in old_state, gpc_kick_pinned_vcpu=
()
unconditionally re-posts KVM_REQ_GET_NESTED_STATE_PAGES even though the
request handler is already in the middle of servicing it. Once
vmx_get_nested_state_pages() finishes, vcpu_enter_guest() sees the newly
re-posted request at kvm_vcpu_exit_request() and aborts guest entry to run a
redundant second pass.

Should nested_gpc_hpa() call kvm_gpc_unpin_for_guest(gpc) before
kvm_gpc_lock_page()?

[ ... ]

> @@ -3467,41 +3611,117 @@ static bool nested_get_evmcs_page(struct kvm_vcp=
u *vcpu)
>  }
>  #endif
> =20
> -static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
> +static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu, bool lazy)
>  {

[ ... ]

>  	if (nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW)) {
> -		map =3D &vmx->nested.virtual_apic_map;
> +		int vapic_err =3D nested_gpc_hpa(&vmx->nested.virtual_apic_cache,
> +					       vmcs12->virtual_apic_page_addr, &hpa);
> +
> +		/*
> +		 * On failure, deactivate the cache: an active-but-invalid
> +		 * cache would read as "might have an event" to the
> +		 * non-sleeping check in vmx_has_nested_events(), causing
> +		 * spurious wakeups for as long as the page remains
> +		 * unbackable.
> +		 */
> +		if (vapic_err) {
> +			kvm_gpc_unpin_for_guest(&vmx->nested.virtual_apic_cache);
> +			kvm_gpc_deactivate(&vmx->nested.virtual_apic_cache);
> +		}
> =20
> -		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->virtual_apic_page_addr), ma=
p)) {
> -			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, pfn_to_hpa(map->pfn));
> +		if (vapic_err =3D=3D -EAGAIN)
> +			goto retry;
> +
> +		if (!vapic_err) {
> +			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, hpa);
> +			/* As for the APIC-access page: undo a lazy degrade. */
> +			exec_controls_setbit(vmx, CPU_BASED_TPR_SHADOW);
>  		} else if (nested_cpu_has(vmcs12, CPU_BASED_CR8_LOAD_EXITING) &&
>  		           nested_cpu_has(vmcs12, CPU_BASED_CR8_STORE_EXITING) &&
>  			   !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES))=
 {
> @@ -3514,6 +3734,27 @@ static bool nested_get_vmcs12_pages(struct kvm_vcp=
u *vcpu)
>  			 * only possibility we have.
>  			 */
>  			exec_controls_clearbit(vmx, CPU_BASED_TPR_SHADOW);
> +		} else if (lazy) {

[ ... ]

> +			goto retry;
> +		} else {
>  			/*
>  			 * Write an illegal value to VIRTUAL_APIC_PAGE_ADDR to
>  			 * force VM-Entry to fail.
>  			 */
>  			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, INVALID_GPA);
>  		}
>  	}

[ ... ]

> +retry:
> +	/*
> +	 * The gfn's memslot is being moved or deleted: present but
> +	 * flagged invalid, so the lookup failure is transient and the
> +	 * gfn must not (yet) be treated as unbacked. Re-post the
> +	 * request and report success: the pending request prevents
> +	 * any VM entry (vcpu_enter_guest() bails and reprocesses
> +	 * requests), so L2 cannot run with the partially-updated
> +	 * vmcs02, and the vCPU retries here until the memslot update
> +	 * completes or reverts. This mirrors RET_PF_RETRY for
> +	 * ordinary guest faults on an invalid slot; as there, a
> +	 * userspace which never completes the update leaves the vCPU
> +	 * retrying indefinitely, with signals and request processing
> +	 * still serviced.
> +	 */
> +	kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
> +	return true;
>  }
> =20
> -static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
> +static bool __vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
>  {
>  #ifdef CONFIG_KVM_HYPERV
>  	/*
> @@ -3567,9 +3830,39 @@ static bool vmx_get_nested_state_pages(struct kvm_=
vcpu *vcpu)
>  	}
>  #endif
> =20
> -	if (is_guest_mode(vcpu) && !nested_get_vmcs12_pages(vcpu))
> +	if (is_guest_mode(vcpu) &&
> +	    !nested_get_vmcs12_pages(vcpu, !to_vmx(vcpu)->nested.resume_pending=
))
>  		return false;
> =20
> +	/*
> +	 * Success consumes the resume classification (a -EAGAIN retry
> +	 * "succeeds" too: the resume did all it could against a memslot
> +	 * mid-update, and the re-posted request's consumption is a fresh
> +	 * revalidation like any other).
> +	 */
> +	to_vmx(vcpu)->nested.resume_pending =3D false;
> +	return true;
> +}

[Severity: Medium]
Does taking the retry path on -EAGAIN during entry-time resolution lose
entry-time (!lazy) semantics for the retry?

There appear to be two ways this happens:

1. During VMLAUNCH/VMRESUME, nested_vmx_enter_non_root_mode() calls
nested_get_vmcs12_pages(vcpu, false) while vmx->nested.resume_pending is
false. If nested_gpc_hpa() returns -EAGAIN because a memslot is mid-update,
nested_get_vmcs12_pages() posts KVM_REQ_GET_NESTED_STATE_PAGES and returns
true without setting resume_pending.

2. During KVM_SET_NESTED_STATE resume, __vmx_get_nested_state_pages() calls
nested_get_vmcs12_pages(vcpu, false) because resume_pending is true, but wh=
en
nested_get_vmcs12_pages() jumps to retry on -EAGAIN and returns true,
__vmx_get_nested_state_pages() clears resume_pending =3D false.

In both cases, the re-posted request runs nested_get_vmcs12_pages() with
lazy =3D true. If the in-flight memslot operation was a deletion (or if a
subsequent page in vmcs12 such as virtual_apic_page_addr had not been
checked yet on the first pass and is unbacked), the retry applies lazy
semantics: an unbacked apic_access_addr silently degrades
SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES instead of exiting with
KVM_EXIT_INTERNAL_ERROR, and an unbacked virtual_apic_page_addr spins
forever in KVM_RUN via goto retry instead of writing INVALID_GPA to
VIRTUAL_APIC_PAGE_ADDR to deliver VMfailValid to L1.

Additionally, in nested_get_vmcs12_pages(), the CR8 load/store exiting chec=
k:

	} else if (nested_cpu_has(vmcs12, CPU_BASED_CR8_LOAD_EXITING) &&
	           nested_cpu_has(vmcs12, CPU_BASED_CR8_STORE_EXITING) &&
		   !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
		exec_controls_clearbit(vmx, CPU_BASED_TPR_SHADOW);
	} else if (lazy) {

is evaluated before checking lazy, and without checking whether other APICv
controls that require CPU_BASED_TPR_SHADOW (such as
SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE, SECONDARY_EXEC_APIC_REGISTER_VIRT,
SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY, or PIN_BASED_POSTED_INTR) are enabled.
If L2 is running with x2APIC virtualization and CR8 load/store exiting when=
 a
lazy vAPIC revalidation fails during a memslot delete-then-recreate, cleari=
ng
CPU_BASED_TPR_SHADOW while SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE remains set
in vmcs02 will cause hardware VMRESUME to fail with
VMXERR_ENTRY_INVALID_CONTROL_FIELD instead of riding out the gap via
goto retry.

Should entry-time resolution preserve !lazy across -EAGAIN retries, and
should the lazy branch precede the CPU_BASED_TPR_SHADOW clearing fallback?

[ ... ]

> @@ -4054,6 +4354,8 @@ static void vmcs12_save_pending_event(struct kvm_vc=
pu *vcpu,
>  static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> +	int pi_idx, vapic_idx;
> +	struct pi_desc *pi_desc;
>  	int max_irr;
>  	void *vapic_page;
>  	u16 status;
> =20
>  	if (!vmx->nested.pi_pending)
>  		return 0;
> =20
> -	if (!vmx->nested.pi_desc)
> +	/*
> +	 * Resolve both caches before touching the descriptor: taking one
> +	 * cache's lock inside the other's would sleep in refresh (and
> +	 * wait a grace period on the gpc_srcu domain this task already
> +	 * reads) with preemption disabled. The vAPIC lock may go unused
> +	 * (no pending vector), and its absence only matters once a
> +	 * vector is found, so a failure is remembered, not acted on.
> +	 */
> +retry:
> +	vapic_idx =3D nested_gpc_lock_if_active(&vmx->nested.virtual_apic_cache=
);
> +
> +	pi_idx =3D nested_gpc_try_lock_if_active(&vmx->nested.pi_desc_cache);
> +	if (pi_idx =3D=3D -EWOULDBLOCK) {
> +		if (vapic_idx >=3D 0)
> +			kvm_gpc_unlock(&vmx->nested.virtual_apic_cache,
> +				       vapic_idx);
> +		if (kvm_gpc_refresh(&vmx->nested.pi_desc_cache, PAGE_SIZE))
> +			goto mmio_needed;
> +		goto retry;
> +	}
> +	if (pi_idx < 0) {
> +		if (vapic_idx >=3D 0)
> +			kvm_gpc_unlock(&vmx->nested.virtual_apic_cache,
> +				       vapic_idx);
>  		goto mmio_needed;
> +	}
> =20
> +	pi_desc =3D nested_pi_desc(vmx);
>  	vmx->nested.pi_pending =3D false;
> =20
> -	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
> +	if (!pi_test_and_clear_on(pi_desc)) {
> +		kvm_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
> +		if (vapic_idx >=3D 0)
> +			kvm_gpc_unlock(&vmx->nested.virtual_apic_cache,
> +				       vapic_idx);
>  		return 0;
> +	}
> =20
> -	max_irr =3D pi_find_highest_vector(vmx->nested.pi_desc);
> +	max_irr =3D pi_find_highest_vector(pi_desc);
>  	if (max_irr > 0) {
> -		vapic_page =3D vmx->nested.virtual_apic_map.hva;
> -		if (!vapic_page)
> +		if (vapic_idx < 0) {
> +			/* The ON bit is already cleared: mark the write. */
> +			kvm_gpc_mark_dirty_in_slot(&vmx->nested.pi_desc_cache);
> +			kvm_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
>  			goto mmio_needed;
> +		}

[Severity: High]
What happens in vmx_complete_nested_posted_interrupt() when
nested_get_vmcs12_pages() has deferred cache resolution via goto retry?

In nested_get_vmcs12_pages(), when resolving apic_access_page_cache,
virtual_apic_cache, or pi_desc_cache encounters an in-flight memslot update
(-EAGAIN) or a lazy unbacked virtual_apic_cache, it deactivates that cache,
re-posts KVM_REQ_GET_NESTED_STATE_PAGES, and returns true.

In vcpu_enter_guest(), because vmx_get_nested_state_pages() returns true,
execution continues to kvm_check_and_inject_events() ->
vmx_check_nested_events() -> vmx_complete_nested_posted_interrupt() before
kvm_vcpu_exit_request() is checked:

arch/x86/kvm/x86.c:vcpu_enter_guest() {
    ...
	if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
		if (unlikely(!static_call(kvm_x86_get_nested_state_pages)(vcpu))) {
			r =3D 0;
			goto out;
		}
	}
    ...
	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
	    kvm_xen_has_interrupt(vcpu)) {
		...
		if (kvm_check_and_inject_events(vcpu, & Bool) < 0) {
			r =3D 0;
			goto out;
		}
	}
    ...
	if (kvm_vcpu_exit_request(vcpu)) {
		vcpu->mode =3D OUTSIDE_GUEST_MODE;
		smp_wmb();
		local_irq_enable();
		preempt_enable();
		kvm_vcpu_srcu_read_lock(vcpu);
		r =3D 1;
		goto cancel_injection;
	}
}

(Similarly, if L2 is restored in KVM_MP_STATE_HALTED via KVM_SET_NESTED_STA=
TE,
vcpu_block() calls kvm_check_nested_events() before vcpu_enter_guest() has
ever run KVM_REQ_GET_NESTED_STATE_PAGES.)

If vmx->nested.pi_pending is true when vmx_complete_nested_posted_interrupt=
()
is called while KVM_REQ_GET_NESTED_STATE_PAGES is still pending:

1. If pi_desc_cache was deactivated (pi_idx =3D=3D -ENOENT) or its refresh =
hits
an in-flight KVM_MEMSLOT_INVALID slot, vmx_complete_nested_posted_interrupt=
()
jumps to mmio_needed and calls kvm_handle_memory_failure(), terminating the
VM with KVM_EXIT_INTERNAL_ERROR instead of waiting for the pending retry.

2. If pi_desc_cache is active and valid, but virtual_apic_cache was
deactivated by nested_get_vmcs12_pages() (or its refresh failed during a
memslot update, so vapic_idx < 0), vmx_complete_nested_posted_interrupt()
clears vmx->nested.pi_pending =3D false and clears POSTED_INTR_ON in pi_desc
before checking if (vapic_idx < 0) and jumping to mmio_needed, losing the
posted interrupt notification and killing the VM.

3. Because nested_put_vmcs12_pages() on nested VM-exit only unpins the cach=
es
without deactivating them, if apic_access_page_cache hits -EAGAIN at
VMLAUNCH/VMRESUME of a new L2, nested_get_vmcs12_pages() jumps to retry
before updating virtual_apic_cache and pi_desc_cache, leaving them active
with the previous L2's GPAs and pi_desc_offset when
vmx_complete_nested_posted_interrupt() runs.

Should vmx_complete_nested_posted_interrupt() (or vmx_check_nested_events())
defer processing while KVM_REQ_GET_NESTED_STATE_PAGES is pending, and avoid
clearing pi_pending or POSTED_INTR_ON until both caches are locked?

[ ... ]

> @@ -4225,20 +4566,57 @@ static bool vmx_has_nested_events(struct kvm_vcpu=
 *vcpu, bool for_injection)
>  	    __vmx_interrupt_blocked(vcpu))
>  		return false;
> =20
> -	if (!vapic)
> +	/*
> +	 * This is called from non-sleeping contexts (notably the
> +	 * kvm_vcpu_block() loop, under set_current_state()), so it must
> +	 * not refresh an unusable cache. Claim a pending event instead,
> +	 * and post KVM_REQ_GET_NESTED_STATE_PAGES: the bounce through
> +	 * vcpu_run services the request in a sleepable context,
> +	 * re-establishing the cache, and re-evaluates events for real.
> +	 * The request must be posted here rather than assumed pending =E2=80=94
> +	 * an invalidation posts one, but a cache can also fail the check
> +	 * on a bare memslot-generation bump (e.g. a dirty-logging toggle,
> +	 * KVM_MR_FLAGS_ONLY), where nothing else does, and without it
> +	 * the woken vCPU would re-enter, HLT, and spin back here. A
> +	 * spurious wakeup is safe; sleeping here is not, and returning
> +	 * false could miss a wakeup.
> +	 */
> +	idx =3D nested_gpc_try_lock_if_active(&vmx->nested.virtual_apic_cache);
> +	if (idx =3D=3D -EWOULDBLOCK) {
> +		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
> +		return true;
> +	}
> +	if (idx < 0)
>  		return false;
> =20
> +	vapic =3D vmx->nested.virtual_apic_cache.khva;
>  	vppr =3D *((u32 *)(vapic + APIC_PROCPRI));
> =20
> +	kvm_gpc_unlock(&vmx->nested.virtual_apic_cache, idx);
> +
>  	max_irr =3D vmx_get_rvi();
>  	if ((max_irr & 0xf0) > (vppr & 0xf0))
>  		return true;
> =20
> -	if (vmx->nested.pi_pending && vmx->nested.pi_desc &&
> -	    pi_test_on(vmx->nested.pi_desc)) {
> -		max_irr =3D pi_find_highest_vector(vmx->nested.pi_desc);
> -		if (max_irr > 0 && (max_irr & 0xf0) > (vppr & 0xf0))
> +	if (vmx->nested.pi_pending) {
> +		idx =3D nested_gpc_try_lock_if_active(&vmx->nested.pi_desc_cache);
> +		if (idx =3D=3D -EWOULDBLOCK) {
> +			kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
>  			return true;
> +		}
> +		if (idx < 0)
> +			return false;

[Severity: High]
Won't returning true on -EWOULDBLOCK here permanently unhalt a halted L2
vCPU instead of just bouncing through vcpu_run() to refresh the cache?

When a halted L2 vCPU is blocked in kvm_vcpu_block() and an mmu_notifier
invalidates virtual_apic_cache or a dirty-logging toggle bumps the memslot
generation, kvm_vcpu_check_block() -> kvm_arch_vcpu_runnable() ->
kvm_vcpu_has_events() -> vmx_has_nested_events() sees -EWOULDBLOCK, posts
KVM_REQ_GET_NESTED_STATE_PAGES, and returns true.

However, kvm_vcpu_block() returns to vcpu_block(), which immediately
re-checks kvm_arch_vcpu_runnable(vcpu) before returning to vcpu_run():

arch/x86/kvm/x86.c:vcpu_block() {
	bool hv_timer;

	if (!kvm_arch_vcpu_runnable(vcpu)) {
		...
		kvm_vcpu_halt(vcpu, &hv_timer);
		...
		if (!kvm_arch_vcpu_runnable(vcpu))
			return 1;
	}
	...
	switch(vcpu->arch.mp_state) {
	case KVM_MP_STATE_HALTED:
	case KVM_MP_STATE_AP_RESET_HOLD:
		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
	...
}

Because KVM_REQ_GET_NESTED_STATE_PAGES is only serviced in
vcpu_enter_guest() (which only runs when mp_state =3D=3D KVM_MP_STATE_RUNNA=
BLE),
nothing refreshes virtual_apic_cache or pi_desc_cache between the two
kvm_arch_vcpu_runnable() calls in vcpu_block(). The second call in
vcpu_block() invokes vmx_has_nested_events() again, still gets -EWOULDBLOCK,
and returns true again. vcpu_block() then transitions the vCPU from
KVM_MP_STATE_HALTED to KVM_MP_STATE_RUNNABLE, resuming L2 execution past HLT
without any architectural wake event.

The same thing happens when L2 executes HLT while a cache is invalid:
kvm_emulate_halt() advances RIP past HLT and calls __kvm_emulate_halt(),
which checks kvm_vcpu_has_events(vcpu) and sets KVM_MP_STATE_RUNNABLE
immediately instead of halting.

Conversely, if a vCPU is restored in L2 with KVM_MP_STATE_HALTED via
KVM_SET_NESTED_STATE (or enters L2 halted via RSM),
nested_vmx_enter_non_root_mode(vcpu, false) defers activating the caches to
KVM_REQ_GET_NESTED_STATE_PAGES. Because vcpu_run() calls vcpu_block()
directly when mp_state !=3D KVM_MP_STATE_RUNNABLE, the caches remain inacti=
ve
(!gpc->active), so nested_gpc_try_lock_if_active() returns -ENOENT and
vmx_has_nested_events() returns false, missing pending virtual or posted
interrupts until something else wakes the vCPU.

Should vmx_has_nested_events() refresh the cache when called from a
sleepable TASK_RUNNING context (similar to __kvm_xen_has_interrupt() checki=
ng
task_is_running(current) && !in_atomic()), or should vcpu_block() service
KVM_REQ_GET_NESTED_STATE_PAGES before re-evaluating kvm_arch_vcpu_runnable(=
)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105020104.2507=
083-1-dwmw2@infradead.org?part=3D12
