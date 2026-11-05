Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902930;
	b=hj3+qh3/T0Rtea456rzhABk9plSdCZMBD913LcajTJ4KFQ/V5VSXtEkzOhxE7HJKynHf
	 gRYO3KO0nC44vWWe6lpSCrn2PWmLJJusEkSaGeGLLu1M306KBr3zoYfT6FFHX1ahLSqO+
	 zb1WkUgPYBP/sVUdKeo6/baquNT4uSTFWlmY2PhUL/A9yP38sGckIz57I0YeotqCyot03
	 +cTGOxa07mwRH4LB+ZQ0wy3lPNM2bJA0gjPvsQgZtvelo30d7aYB8MYY0CGHPRRyRZMHn
	 9R8xYpmKyznhx6CSSWuJvd6bLOoCh8eGwInXp3K3BXR9RTJ2v8tNTdvW25azvZcJHGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902930;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CEaWPjduGJC02fYR72s4uPAwZyDyMCak2eQCHyNKGDg=;
	b=dKlgfH9frUnX1/QG8Eoc86wf4ltCAy8f1HQYLsAlNNMn/eDfuvg4LY4F7VbgvgC9cb2x
	 USsYLVitSZOideXHTca9yjClRD4LB8bVMRa853F2g6qToH18yLyUrfUTTK6nHh8MbS6G7
	 FL3hQnCprmq4fKN7lAIATUfOQt6NFRjot8opqsdf34tldfS+hGueoox2oHjicAZmFQ74O
	 TBULUCLaNRbt/sNKq+KGr0LfcgG+5x0f14UiAAWygXwLzguzr/n0VLV/bkx5jtnbEhF/S
	 deCPiDBcK9MUZZg7o1Bkkvx1dHsOpb7XYjq/x94ffHx5mZte/7f22yHTZWzt6wAiy/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpyRrTF4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107CF606A31B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpyRrTF4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8639C1F000C1;
	Thu,  5 Nov 2026 18:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793902929;
	bh=CEaWPjduGJC02fYR72s4uPAwZyDyMCak2eQCHyNKGDg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MpyRrTF4B4M24dAAIIzWEE2yVa9/ubPm/mvvgAb5fYzOmaEHHuTD+Z26uJczMFAzP
	 mdSUvISCt98POWPuwtlKGXPAr4qYdhDfFV7FKz1b3cPpzgXa0bANqfJXFINEKKiK19
	 4oWmmvZkoWq8opDUGB3rxYGMePXvfixiP9IsynyBxn24OGSn5PQZ+c86WihhWhYYCS
	 9VTVtj8DgrtrQVu/4tUTUSzPa7eOJd1q2BccOMlBL4U1yEUP13ZuWcfZ9m8Xd3s1fu
	 SpCZsJ83utPn7rE3GyavLet8yEKSQys6HGhDjgsTSyWBrtjJR7R1JW+BZDuP95n5r7
	 IhzvCzvqxJMpA==
Message-ID: <sashiko-outbox-199742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/23] KVM: x86: Re-synchronize TSC after
 KVM_SET_TSC_KHZ
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261105154955.2525419-9-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
 <20261105154955.2525419-9-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:22:09 +0000
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
- [High] KVM: x86: premature kvm_synchronize_tsc() in kvm_arch_vcpu_create()
- [High] KVM: x86: VM-wide user_set_tsc check in kvm_set_tsc_khz() breaks s=
ync
- [Medium] KVM: x86: stale masterclock scaling state after kvm_set_tsc_khz()
- [Medium] KVM: x86: unmatched TSC generations in kvm_set_tsc_khz() after r=
un
--

commit 485fbef9a92020d117515ff0401050c42d986ac4
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ

This commit updates kvm_set_tsc_khz() to invoke kvm_synchronize_tsc() after
changing a vCPU's TSC frequency so that cur_tsc_scaling_ratio and TSC
generation tracking are updated. It also adds an explicit user_initiated
parameter to kvm_synchronize_tsc() to distinguish host userspace MSR_IA32_T=
SC
writes from internal frequency resynchronizations.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 77bd3e4bfdcd7..f551056d72746 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1064,6 +1064,7 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u=
32 user_tsc_khz)
>  {
>  	u32 thresh_lo, thresh_hi;
>  	int use_scaling =3D 0;
> +	u64 tsc;
> =20
>  	/* tsc_khz can be zero if TSC calibration fails */
>  	if (user_tsc_khz =3D=3D 0) {
> @@ -1091,7 +1092,34 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, =
u32 user_tsc_khz)
>  			 user_tsc_khz, thresh_lo, thresh_hi);
>  		use_scaling =3D 1;
>  	}
> -	return set_tsc_khz(vcpu, user_tsc_khz, use_scaling);
> +	/*
> +	 * Read the guest TSC before changing the ratio, so we can
> +	 * re-synchronize to preserve continuity across the change.
> +	 */
> +	tsc =3D kvm_read_l1_tsc(vcpu, rdtsc());
> +
> +	if (set_tsc_khz(vcpu, user_tsc_khz, use_scaling))
> +		return -1;
> +
> +	/*
> +	 * Preserving continuity only makes sense for a vCPU which has
> +	 * actually run; for one which has not, synchronize as for a zero
> +	 * write, joining the current generation. This makes vCPU creation
> +	 * (which comes through here with the default frequency) join the
> +	 * generation *explicitly*, rather than by the accident that the
> +	 * scaling ratio is still zero at this point so the TSC read above
> +	 * is zero anyway =E2=80=94 and it stops an explicit KVM_SET_TSC_KHZ on=
 a
> +	 * never-run vCPU, whose nonzero TSC value could never match, from
> +	 * opening a new generation and orphaning the matched state of its
> +	 * siblings. If userspace has already written a TSC, preserve the
> +	 * value even for a never-run vCPU =E2=80=94 a zero write would discard=
 it =E2=80=94
> +	 * and let the user-write matching window do its usual job.
> +	 */
> +	if (vcpu->arch.last_vmentry_cpu !=3D -1 || vcpu->kvm->arch.user_set_tsc)
> +		kvm_synchronize_tsc(vcpu, &tsc, false);

[Severity: High]
Does checking the VM-wide vcpu->kvm->arch.user_set_tsc flag here break TSC
synchronization when userspace configures or restores multiple never-run
vCPUs sequentially?

In __kvm_synchronize_tsc(), user_set_tsc is a VM-wide flag on struct kvm_ar=
ch:

	if (user_set_tsc)
		vcpu->kvm->arch.user_set_tsc =3D true;

If userspace initializes or restores vCPUs in a per-vCPU loop by calling
KVM_SET_TSC_KHZ followed by KVM_SET_MSRS(MSR_IA32_TSC) on each vCPU in turn:

1. Userspace creates vCPU 0 and vCPU 1 (both have last_vmentry_cpu =3D=3D -=
1 and
   creation-time TSC offsets ticking from ~0).
2. On vCPU 0, userspace calls KVM_SET_TSC_KHZ and then writes MSR_IA32_TSC
   with a restored value T_restore (where T_restore > 1 second of guest
   uptime). That sets vcpu->kvm->arch.user_set_tsc =3D true and sets
   cur_tsc_write =3D T_restore.
3. On vCPU 1, before MSR_IA32_TSC is written on vCPU 1, userspace calls
   KVM_SET_TSC_KHZ. Because the VM-wide user_set_tsc flag is already true,
   kvm_set_tsc_khz() takes the first branch and passes vCPU 1's un-restored,
   near-zero creation TSC (&tsc) instead of NULL.
4. In kvm_synchronize_tsc(), vCPU 1's near-zero tsc is more than 1 second
   away from cur_tsc_write (T_restore), so it fails to match and opens a new
   TSC generation with cur_tsc_write overwritten to that near-zero value.
5. When userspace then writes MSR_IA32_TSC =3D T_restore on vCPU 1, T_resto=
re
   is more than 1 second away from the clobbered near-zero cur_tsc_write, so
   it fails to match again and leaves all_vcpus_matched_tsc false.

Should this check whether a TSC value was written by userspace on this
specific vCPU rather than checking the VM-wide vcpu->kvm->arch.user_set_tsc
(which is also read here without holding kvm->arch.tsc_write_lock)?

[Severity: Medium]
What happens in kvm_set_tsc_khz() when KVM_SET_TSC_KHZ is called on a
multi-vCPU guest whose vCPUs have already run (last_vmentry_cpu !=3D -1), if
userspace has never explicitly written MSR_IA32_TSC?

Because kvm_set_tsc_khz() passes &tsc (non-zero) with user_initiated =3D fa=
lse,
kvm->arch.user_set_tsc remains false. When kvm_synchronize_tsc() runs for e=
ach
vCPU:

	if (vcpu->arch.virtual_tsc_khz) {
		if (data =3D=3D 0) {
			synchronizing =3D true;
		} else if (kvm->arch.user_set_tsc) {
			...
		}
	}

Since data !=3D 0 and kvm->arch.user_set_tsc is false, synchronizing is fal=
se
for every vCPU. Doesn't each vCPU open a separate TSC generation with
nr_vcpus_matched_tsc =3D 1, orphaning its siblings and leaving
all_vcpus_matched_tsc permanently false?

> +	else
> +		kvm_synchronize_tsc(vcpu, NULL, false);
> +	return 0;

[Severity: High]
Can calling kvm_synchronize_tsc() unconditionally from kvm_set_tsc_khz()
corrupt VM-wide TSC matching state during KVM_CREATE_VCPU?

During vCPU creation, kvm_vm_ioctl_create_vcpu() calls:

  kvm_vm_ioctl_create_vcpu()
    -> kvm_arch_vcpu_create()
      -> kvm_set_tsc_khz(vcpu, vcpu->kvm->arch.default_tsc_khz)
        -> kvm_synchronize_tsc(vcpu, NULL, false)
          -> __kvm_synchronize_tsc()
            -> kvm_track_tsc_matching()

At the point kvm_arch_vcpu_create() runs, atomic_inc(&kvm->online_vcpus) has
not happened yet:

virt/kvm/kvm_main.c:kvm_vm_ioctl_create_vcpu() {
	...
	r =3D kvm_arch_vcpu_create(vcpu);
	if (r)
		goto vcpu_free_run_page;
	...
	smp_wmb();
	atomic_inc(&kvm->online_vcpus);
	mutex_unlock(&vcpu->mutex);

	kvm_arch_vcpu_postcreate(vcpu);
}

Running __kvm_synchronize_tsc() and kvm_track_tsc_matching() before
online_vcpus is incremented appears to cause several regressions:

1. In kvm_track_tsc_matching():

	int online =3D atomic_read(&vcpu->kvm->online_vcpus);
	WRITE_ONCE(ka->all_vcpus_matched_tsc,
		   ka->nr_vcpus_matched_tsc >=3D online);

	update_mclock |=3D (prev_matched_tsc !=3D ka->all_vcpus_matched_tsc);

	if (ka->all_vcpus_matched_tsc ||
	    ka->nr_vcpus_matched_freq >=3D online)
		ka->all_vcpus_matched_freq =3D true;

   If vCPU 0 is already online (online =3D=3D 1) and configured to a non-de=
fault
   frequency F !=3D default_tsc_khz, creating vCPU 1 runs
   __kvm_synchronize_tsc() at default_tsc_khz while online is still 1. That
   resets ka->all_vcpus_matched_freq =3D false, increments
   ka->nr_vcpus_matched_freq to 1, and sets ka->cur_tsc_khz =3D default_tsc=
_khz.
   Then kvm_track_tsc_matching() sees nr_vcpus_matched_freq (1) >=3D online=
 (1)
   and latches ka->all_vcpus_matched_freq =3D true. When
   kvm_arch_vcpu_postcreate() later runs with online =3D=3D 2,
   vcpu->arch.virtual_tsc_khz already equals ka->cur_tsc_khz, so
   all_vcpus_matched_freq is never cleared and kvm_update_masterclock()
   enables masterclock mode across frequency-mismatched vCPUs.

2. If userspace creates and configures vCPUs one by one (create vCPU 0, call
   KVM_SET_TSC_KHZ(vcpu 0, F), then create vCPU 1, call
   KVM_SET_TSC_KHZ(vcpu 1, F)), creating vCPU 1 synchronizes it at
   default_tsc_khz, clobbering cur_tsc_khz, cur_tsc_offset,
   cur_tsc_freq_generation, and cur_tsc_generation so that the subsequent
   KVM_SET_TSC_KHZ(vcpu 1, F) only counts vCPU 1 and leaves
   all_vcpus_matched_freq and all_vcpus_matched_tsc false.

3. If kvm_dirty_ring_alloc(), xa_insert(), or create_vcpu_fd() fails in
   kvm_vm_ioctl_create_vcpu() after kvm_arch_vcpu_create(), the destroyed
   vCPU's increments and generation changes in kvm->arch remain permanently
   recorded.

Should kvm_set_tsc_khz() skip kvm_synchronize_tsc() during
kvm_arch_vcpu_create() and leave initial synchronization to
kvm_arch_vcpu_postcreate() after online_vcpus has been incremented?

[Severity: Medium]
Does the KVM_SET_TSC_KHZ ioctl path also need to process
KVM_REQ_MASTERCLOCK_UPDATE before returning to userspace?

Calling kvm_synchronize_tsc() from kvm_set_tsc_khz() updates
ka->cur_tsc_scaling_ratio and sets KVM_REQ_MASTERCLOCK_UPDATE on the vCPU v=
ia
kvm_track_tsc_matching(), but kvm_arch_vcpu_ioctl() returns to userspace
without calling kvm_update_masterclock().

In __get_kvmclock_master_clock(), get_kvmclock() uses
ka->master_tsc_scaling_ratio, ka->master_tsc_shift, and ka->master_tsc_mul,
which are only updated from ka->cur_tsc_scaling_ratio when
pvclock_update_vm_gtod_copy() runs via kvm_update_masterclock():

	hv_clock.tsc_shift =3D ka->master_tsc_shift;
	hv_clock.tsc_to_system_mul =3D ka->master_tsc_mul;

	if (kvm_caps.has_tsc_control) {
		u64 tsc_delta =3D data->host_tsc - ka->master_cycle_now;

		tsc_delta =3D kvm_scale_tsc(tsc_delta, ka->master_tsc_scaling_ratio);

If userspace calls KVM_SET_TSC_KHZ and then queries KVM_GET_CLOCK before
entering KVM_RUN, won't get_kvmclock() still use the stale masterclock
scaling parameters (or remain in masterclock mode despite a frequency
mismatch)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105154955.2525=
419-1-dwmw2@infradead.org?part=3D8
