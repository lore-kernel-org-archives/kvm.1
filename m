Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621227;
	b=uYA0TEcHq5GWEpum91f/WDgs4izi+A+w88m1lMpVKMnqDlnV7E2KtH5zf4OxIbqou8WS
	 eRQITeVCjiPeLhrgfGs6rG/m90EGbhANdsWQWjcFxZO0v++I3aQTQEeVf2YxFQ2b9EB/i
	 q0xzzxkSklft5f3CYiKEGKpSJzVK4B6AK2rm3td/U9pceL+G7bzI5yoZ8Irew0TRis/2A
	 MmDQrndof2VrsQY/Qlx8b/8jrKmy4xQNF8wj1q1ebGq4QetQy8PKXgF5vpYewbsVM0JXe
	 NpPLCaqH3fGMy3jgkGpZiBRsFaKigfcYXCoMfOc/9J/X6t8BYWY02L7DGWB20NtuY5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621227;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eie875xNMkWFXic9T7Jr0GRsawAWRJxR8/5JjlWGlhY=;
	b=goTNQmJIDC4kVIbPQI2t9kErY/u7sGcMuqhBOLeF2q6tXelPu+6SYgicOlSLadGjFlET
	 StpePzRG35Bh5EA6iB9Yac3P7oYGfu1iGLzs+AXAZc4/uP5Dp1RnnxVJH5KANIE4QflTb
	 9y8LUNKy0sxDs8MhGbKmDt/X6dZUdXJLVNKV/9NMqrVUWi6WNMQRUtNITUI5XXBVL0FAo
	 jfZ5Cqa0hqtKA8U43cdipBNzPhDg0wWSjSSsCz02k29QviHeMyV0rMWnr6kU0Hb5+MoKw
	 0B5xvrMdfaxsT1Q0dd7lD6i4jOs9NL6F41bt5hUxuRXU9jxzY0SbOXu2nra/GtC051Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPpHJhIP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE75606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPpHJhIP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2101F00A1B;
	Mon,  2 Nov 2026 12:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621226;
	bh=eie875xNMkWFXic9T7Jr0GRsawAWRJxR8/5JjlWGlhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oPpHJhIPHbnqIBcefnniQaWWWijq3ZJNuv7DQmpq1Y4szaFdlAE6FQO4fulC0cIHw
	 YVkwaEGsOVtSqSxYwqis3LR/dUrcyDUy5jAlXG7zXLf8OgbpPP+iYWCfQVCkzckuQi
	 TVoU/4+ILJWQQzQYLEa0kp5Wx4saJAX69GTx4oZfd1weW0kLlt0Dv+sLzfzdJkyVRp
	 PV9/FO0fG3grAB4ZUg8F2gKIQpefWWRXQPP4UggEmf5YLLeDowulu0lV3HnWYh4Fo3
	 +BVpW4u7jr5xMm6+8o9i4+OuJQqXIRknMTPwJL8k4tHl3ahfNb40h1dvzInhonu/Xz
	 7a1XzXzJEc+eg==
Message-ID: <sashiko-outbox-193369@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] KVM: SEV: Add SNP vCPU state get and set
 commands
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261102114137.1198982-7-joro@8bytes.org>
References: <20261102114137.1198982-1-joro@8bytes.org>
 <20261102114137.1198982-7-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:07:06 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] KVM: SEV: misuse of INVALID_PAGE for ghcb_gpa in snp_set/get_vcpu_=
state()
- [High] KVM: SEV: premature gmem fault-in and RMP update in snp_set_vcpu_s=
tate()
- [High] KVM: SEV: missing guest_state_protected check in snp_set_vcpu_stat=
e()
- [High] KVM: SEV: setting vmsa_pa in snp_set_vcpu_state() bypasses pre_sev=
_run()
- [Medium] KVM: SEV: unlocked sev->snp_context read in snp_get/set_vcpu_sta=
te()
- [Medium] KVM: SEV: stale VMSA state in snp_get_vcpu_state() on pending re=
load request
- [Medium] KVM: SEV: snp_get_vcpu_state() hides VMSA GPA when VMSA reload i=
s pending
--

commit 58d63c955c7c0bdc5747b6eafd39cb3beae4ba9d
Author: Joerg Roedel <joerg.roedel@amd.com>

KVM: SEV: Add SNP vCPU state get and set commands

This commit adds KVM_SEV_SNP_GET_VCPU_STATE and KVM_SEV_SNP_SET_VCPU_STATE
as vCPU-scoped KVM_MEMORY_ENCRYPT_OP commands and advertises
KVM_CAP_SNP_VCPU_STATE so userspace can configure and query guest-owned VMSA
and GHCB GPAs per vCPU.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 974651a70a7dd..ff696e21fe41b 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c

[ ... ]

> @@ -2606,6 +2608,89 @@ static int snp_launch_update_vmsa(struct kvm *kvm,=
 struct kvm_sev_cmd *argp)
>  	return ret;
>  }
> =20
> +static int snp_get_vcpu_state(struct kvm_vcpu *vcpu,
> +			      struct kvm_sev_cmd *argp)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	struct kvm *kvm =3D vcpu->kvm;
> +	struct kvm_sev_snp_vcpu_state state =3D {};
> +
> +	if (!is_sev_snp_guest(vcpu))
> +		return -ENOTTY;
> +	if (!to_kvm_sev_info(kvm)->snp_context)
> +		return -EINVAL;

[Severity: Medium]
Is it safe for snp_get_vcpu_state() and snp_set_vcpu_state() to read
sev->snp_context under vcpu->mutex without holding kvm->lock?

In snp_launch_start(), sev->snp_context is assigned under kvm->lock before
SEV_CMD_SNP_LAUNCH_START and snp_bind_asid() execute, and cleared via
snp_decommission_context() if either step fails:

arch/x86/kvm/svm/sev.c:snp_launch_start() {
	...
	sev->snp_context =3D snp_context_create(kvm, argp);
	if (!sev->snp_context)
		return -ENOTTY;
	...
e_free_context:
	snp_decommission_context(kvm);
	return rc;
}

If userspace invokes KVM_SEV_SNP_GET_VCPU_STATE or
KVM_SEV_SNP_SET_VCPU_STATE concurrently with KVM_SEV_SNP_LAUNCH_START, can
snp_set_vcpu_state() observe a transiently non-NULL sev->snp_context and
install state (including calling kvm_gmem_get_pfn() ->
sev_gmem_make_private()) before snp_bind_asid() has bound the asid or while
snp_launch_start() is failing and decommissioning the context?

> +
> +	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
> +
> +	if (VALID_PAGE(svm->sev_es.snp_guest_vmsa_gpa) &&
> +	    VALID_PAGE(svm->vmcb->control.vmsa_pa)) {
> +		state.vmsa_gpa =3D svm->sev_es.snp_guest_vmsa_gpa;
> +		state.valid_fields |=3D KVM_SEV_SNP_VCPU_STATE_VMSA_VALID;
> +	}

[Severity: Medium]
As reported by Sashiko on v2 [1], does checking
VALID_PAGE(svm->vmcb->control.vmsa_pa) here cause snp_get_vcpu_state() to
hide a valid snp_guest_vmsa_gpa whenever a deferred reload is pending?

Every path that clears or fails to install a guest-owned vmsa already sets
svm->sev_es.snp_guest_vmsa_gpa to INVALID_PAGE. The only case where
VALID_PAGE(svm->sev_es.snp_guest_vmsa_gpa) is true while
VALID_PAGE(svm->vmcb->control.vmsa_pa) is false is in
__sev_snp_reload_vmsa() when mmu_invalidate_retry_gfn() triggers a deferred
reload via KVM_REQ_VMSA_PAGE_RELOAD:

arch/x86/kvm/svm/sev.c:__sev_snp_reload_vmsa() {
	...
	svm->sev_es.snp_guest_vmsa_gpa =3D gpa;
	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn))
		kvm_make_request(KVM_REQ_VMSA_PAGE_RELOAD, vcpu);
	else
		svm->vmcb->control.vmsa_pa =3D pfn_to_hpa(pfn);
}

If the vCPU exits to userspace before vcpu_enter_guest() services
KVM_REQ_VMSA_PAGE_RELOAD, won't KVM_SEV_SNP_GET_VCPU_STATE omit
KVM_SEV_SNP_VCPU_STATE_VMSA_VALID and report vmsa_gpa as 0?

[Severity: Medium]
Conversely, what happens if the backing guest_memfd range or memslot is
invalidated while the vCPU is in userspace?

When sev_gmem_invalidate_range() runs, it reads snp_guest_vmsa_gpa via
READ_ONCE() and queues KVM_REQ_VMSA_PAGE_RELOAD without clearing
snp_guest_vmsa_gpa or vmsa_pa until the next KVM_RUN calls
sev_snp_reload_vmsa() in vcpu_enter_guest():

arch/x86/kvm/svm/sev.c:sev_gmem_invalidate_range() {
	...
	gpa_t gpa =3D READ_ONCE(to_svm(vcpu)->sev_es.snp_guest_vmsa_gpa);

	if (VALID_PAGE(gpa) &&
	    gpa_to_gfn(gpa) >=3D range->start &&
	    gpa_to_gfn(gpa) < range->end)
		kvm_make_request_and_kick(KVM_REQ_VMSA_PAGE_RELOAD, vcpu);
}

Because snp_get_vcpu_state() does not service pending
KVM_REQ_VMSA_PAGE_RELOAD (or KVM_REQ_UPDATE_PROTECTED_GUEST_STATE) requests,
won't KVM_SEV_SNP_GET_VCPU_STATE report stale vmsa state if called before
KVM_RUN?

Also, in snp_set_vcpu_state(), the else branch clears
svm->sev_es.snp_guest_vmsa_gpa =3D INVALID_PAGE outside mmu_lock without
WRITE_ONCE(), and neither branch clears a pending KVM_REQ_VMSA_PAGE_RELOAD
request. Should snp_set_vcpu_state() use WRITE_ONCE() and clear
KVM_REQ_VMSA_PAGE_RELOAD when updating or invalidating the vmsa?

> +
> +	if (VALID_PAGE(svm->vmcb->control.ghcb_gpa)) {
> +		state.ghcb_gpa =3D svm->vmcb->control.ghcb_gpa;
> +		state.valid_fields |=3D KVM_SEV_SNP_VCPU_STATE_GHCB_VALID;
> +	}
> +
> +	if (copy_to_user(u64_to_user_ptr(argp->data), &state, sizeof(state)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int snp_set_vcpu_state(struct kvm_vcpu *vcpu,
> +			      struct kvm_sev_cmd *argp)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	struct kvm *kvm =3D vcpu->kvm;
> +	struct kvm_sev_info *sev =3D to_kvm_sev_info(kvm);
> +	struct kvm_sev_snp_vcpu_state state;
> +	int ret;
> +
> +	if (!is_sev_snp_guest(vcpu))
> +		return -ENOTTY;
> +	if (!sev->snp_direct_vmsa)
> +		return -EINVAL;
> +	if (!sev->snp_context || kvm->arch.pre_fault_allowed)
> +		return -EINVAL;

[Severity: High]
Does checking kvm->arch.pre_fault_allowed under vcpu->mutex actually
serialize snp_set_vcpu_state() against launch finalization?

In snp_launch_finish(), snp_launch_update_vmsa() locks all vCPUs, sets
vcpu->arch.guest_state_protected =3D true, and immediately unlocks all vCPUs
before snp_launch_finish() copies the user blobs, issues
SEV_CMD_SNP_LAUNCH_FINISH, and sets kvm->arch.pre_fault_allowed =3D true:

arch/x86/kvm/svm/sev.c:snp_launch_update_vmsa() {
	...
protect_vcpu:
		svm->vcpu.arch.guest_state_protected =3D true;
		svm_enable_lbrv(vcpu);
	}

out:
	kvm_unlock_all_vcpus(kvm);
	return ret;
}

Once kvm_unlock_all_vcpus() releases the vCPU mutexes (either while
SEV_CMD_SNP_LAUNCH_FINISH is in flight, or if snp_launch_finish() fails
before setting pre_fault_allowed), another thread calling
KVM_SEV_SNP_SET_VCPU_STATE can acquire vcpu->mutex, see
kvm->arch.pre_fault_allowed =3D=3D false, and overwrite vmsa_pa,
snp_guest_vmsa_gpa, and ghcb_gpa on an already-protected vCPU.

Should snp_set_vcpu_state() check vcpu->arch.guest_state_protected instead?

> +
> +	if (copy_from_user(&state, u64_to_user_ptr(argp->data), sizeof(state)))
> +		return -EFAULT;
> +
> +	if (memchr_inv(state.pad, 0, sizeof(state.pad)) ||
> +	    state.valid_fields & ~(KVM_SEV_SNP_VCPU_STATE_VMSA_VALID |
> +				   KVM_SEV_SNP_VCPU_STATE_GHCB_VALID))
> +		return -EINVAL;
> +
> +	if (state.valid_fields & KVM_SEV_SNP_VCPU_STATE_VMSA_VALID) {
> +		if (!PAGE_ALIGNED(state.vmsa_gpa) ||
> +		    !page_address_valid(vcpu, state.vmsa_gpa) ||
> +		    IS_ALIGNED(state.vmsa_gpa, PMD_SIZE))
> +			return -EINVAL;
> +	}
> +
> +	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
> +
> +	if (state.valid_fields & KVM_SEV_SNP_VCPU_STATE_VMSA_VALID) {
> +		ret =3D sev_snp_install_guest_vmsa(svm, state.vmsa_gpa);
> +		if (ret)
> +			return ret;
> +	} else {
> +		svm->sev_es.snp_has_guest_vmsa =3D true;
> +		svm->sev_es.snp_guest_vmsa_gpa =3D INVALID_PAGE;
> +		svm->vmcb->control.vmsa_pa =3D INVALID_PAGE;
> +	}
> +
> +	if (state.valid_fields & KVM_SEV_SNP_VCPU_STATE_GHCB_VALID)
> +		svm->vmcb->control.ghcb_gpa =3D state.ghcb_gpa;
> +	else
> +		svm->vmcb->control.ghcb_gpa =3D INVALID_PAGE;

[Severity: High]
Does using INVALID_PAGE (~0ULL) for svm->vmcb->control.ghcb_gpa break GHCB
protocol handling and state reporting in snp_set_vcpu_state() and
snp_get_vcpu_state()?

svm->vmcb->control.ghcb_gpa backs MSR_AMD64_SEV_ES_GHCB, which is
initialized during vCPU reset in sev_es_init_vmcb() to the architectural
GHCB_MSR_SEV_INFO value:

arch/x86/kvm/svm/sev.c:sev_es_init_vmcb() {
	...
	if (!init_event)
		set_ghcb_msr(svm, GHCB_MSR_SEV_INFO((__u64)sev->ghcb_version,
						    GHCB_VERSION_MIN,
						    sev_enc_bit));
}

And sev_handle_vmgexit() inspects control->ghcb_gpa as follows:

arch/x86/kvm/svm/sev.c:sev_handle_vmgexit() {
	...
	ghcb_gpa =3D control->ghcb_gpa;
	if (ghcb_gpa & GHCB_MSR_INFO_MASK)
		return sev_handle_vmgexit_msr_protocol(svm);

	if (!ghcb_gpa) {
		...
	}

	if (is_sev_snp_guest(vcpu) &&
	    !ghcb_gpa_is_registered(svm, control->ghcb_gpa)) {
		...
		svm_vmgexit_bad_input(svm, GHCB_ERR_NOT_REGISTERED);
		return 1;
	}
}

This appears to cause three regressions:

1. When KVM_SEV_SNP_SET_VCPU_STATE is called without
KVM_SEV_SNP_VCPU_STATE_GHCB_VALID (for example, to set only the vmsa),
setting control.ghcb_gpa =3D INVALID_PAGE overwrites the GHCB_MSR_SEV_INFO
reset value with 0xffffffffffffffffULL, which has low 12 bits 0xfff and will
be misinterpreted by sev_handle_vmgexit() as a GHCB MSR protocol request.

2. When KVM_SEV_SNP_SET_VCPU_STATE is called with
KVM_SEV_SNP_VCPU_STATE_GHCB_VALID, snp_set_vcpu_state() writes
svm->vmcb->control.ghcb_gpa =3D state.ghcb_gpa without updating
svm->sev_es.ghcb_registered_gpa, so subsequent non-MSR VMGEXITs fail
ghcb_gpa_is_registered() with GHCB_ERR_NOT_REGISTERED.

3. In snp_get_vcpu_state(), VALID_PAGE(svm->vmcb->control.ghcb_gpa) only
tests !=3D INVALID_PAGE, which evaluates to true for the initial
GHCB_MSR_SEV_INFO reset value, 0, and any GHCB MSR protocol value.

> +
> +	vmcb_mark_all_dirty(svm->vmcb);
> +	return 0;
> +}

[ ... ]

> @@ -4080,6 +4194,54 @@ static int snp_begin_psc(struct vcpu_svm *svm)
>  	return snp_do_psc(svm);
>  }
> =20
> +/*
> + * Install a guest-owned VMSA.  The caller must serialize against AP cre=
ation
> + * and destruction with snp_vmsa_mutex.
> + */
> +static int sev_snp_install_guest_vmsa(struct vcpu_svm *svm, gpa_t gpa)
> +{
> +	struct kvm *kvm =3D svm->vcpu.kvm;
> +	struct kvm_memory_slot *slot;
> +	unsigned long mmu_seq;
> +	kvm_pfn_t pfn;
> +	gfn_t gfn;
> +	int idx;
> +	int ret;
> +
> +	lockdep_assert_held(&svm->sev_es.snp_vmsa_mutex);
> +
> +	gfn =3D gpa_to_gfn(gpa);
> +	idx =3D srcu_read_lock(&kvm->srcu);
> +	slot =3D gfn_to_memslot(kvm, gfn);
> +	if (!slot) {
> +		ret =3D -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	mmu_seq =3D kvm->mmu_invalidate_seq;
> +	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
> +	smp_rmb();
> +
> +	/* Guest-owned VMSAs are backed by guest_memfd private memory. */
> +	ret =3D kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, NULL);
> +	if (ret)
> +		goto out_unlock;

[Severity: High]
What happens if userspace calls KVM_SEV_SNP_SET_VCPU_STATE before populating
the vmsa page with KVM_SEV_SNP_LAUNCH_UPDATE?

In virt/kvm/guest_memfd.c, kvm_gmem_get_pfn() faults in an unpopulated folio
via FGP_CREAT and, if kvm_gmem_is_private_mem() is true, calls
kvm_arch_gmem_make_private() -> sev_gmem_make_private() ->
rmp_make_private(pfn, gpa, PG_LEVEL_4K, sev->asid, false):

virt/kvm/guest_memfd.c:kvm_gmem_get_pfn() {
	...
	folio =3D __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
	...
	if (kvm_arch_has_gmem_convert() &&
	    kvm_gmem_is_private_mem(file_inode(file), index))
		r =3D kvm_arch_gmem_make_private(kvm, gfn, *pfn,
					       (kvm_pfn_t)1 << *max_order);
}

That transitions the unpopulated page's rmp entry to an unmeasured private
data page (Assigned=3D1, VMSA=3D0), causing a subsequent
KVM_SEV_SNP_LAUNCH_UPDATE on that gfn to fail in sev_gmem_post_populate()
with -EEXIST when snp_lookup_rmpentry() sees assigned =3D=3D true.

In addition, kvm_gmem_get_pfn() returns -EFAULT if the memslot does not have
a guest_memfd (whereas !slot returns -EINVAL), and succeeds without error if
the gfn is currently marked shared in guest_memfd. Should
sev_snp_install_guest_vmsa() verify kvm_slot_has_gmem(slot),
kvm_mem_is_private(kvm, gfn), and that the page has already been populated =
as
a vmsa page rather than faulting it in via kvm_gmem_get_pfn()?

> +
> +	read_lock(&kvm->mmu_lock);
> +	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
> +		ret =3D -EAGAIN;
> +	} else {
> +		svm->sev_es.snp_has_guest_vmsa =3D true;
> +		WRITE_ONCE(svm->sev_es.snp_guest_vmsa_gpa, gpa);
> +		svm->vmcb->control.vmsa_pa =3D pfn_to_hpa(pfn);
> +	}

[Severity: High]
Does setting svm->vmcb->control.vmsa_pa =3D pfn_to_hpa(pfn) here allow
userspace to invoke KVM_RUN before KVM_SEV_SNP_LAUNCH_FINISH completes?

In direct-vmsa mode, KVM_SEV_SNP_LAUNCH_UPDATE with
KVM_SEV_SNP_PAGE_TYPE_VMSA already marks the page as a valid vmsa in the rm=
p.
Once sev_snp_install_guest_vmsa() sets svm->vmcb->control.vmsa_pa to a valid
address, neither sev_vcpu_needs_initialization() nor pre_sev_run() blocks
KVM_RUN before KVM_SEV_SNP_LAUNCH_FINISH:

arch/x86/kvm/svm/sev.c:sev_vcpu_needs_initialization() {
	return to_kvm_sev_info(vcpu->kvm)->need_init;
}

arch/x86/kvm/svm/sev.c:pre_sev_run() {
	...
	if (is_sev_es_guest(vcpu) && !VALID_PAGE(svm->vmcb->control.vmsa_pa))
		return -EINVAL;
}

Can userspace call KVM_RUN right after KVM_SEV_SNP_SET_VCPU_STATE and enter
the guest before snp_launch_finish() has set
vcpu->arch.guest_state_protected =3D true and enabled lbr virtualization?

[1] https://lore.kernel.org/r/20260908103338.427254-7-joro@8bytes.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102114137.1198=
982-1-joro@8bytes.org?part=3D6
