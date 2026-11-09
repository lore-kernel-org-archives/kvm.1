Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189199;
	b=n3/EZq+A1rIFjRWoqCmRBNdN0+5kd73WXAbUhma0Sa1hzATA5PCE7w/dj6mcTgXv+/0e
	 fcutSa3yIFPLPSzoUjC9qC+pvYgNfemwpAvI8+vGTaofNwsuhaUM3rlxgIPG4kV+3jCIk
	 28/qvrkQYbdVV2h1rlnvijEQhq8Adx3JNJhHBtYfYFjBuAxsdAi6lKk0qefNRuHnMRJla
	 M8Bu6Hly40/Hxwo16WsO0JJW/KDSrW0wzh3o3RI8eTf4v04pkH5Q+rT7eg93LJFxiTh4R
	 GvQgBc4GfMNTKOtE6VKkpxC/TSQPqkrJApr98jdmAviboJK4zu9fp4QrOt0VDFDiIdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189199;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vft12BI41qP9t626m6w34v7tcf/tINXg7Ct6LrUUSiI=;
	b=HTOO8JIc6RnG+nDP6Lfs/nwUva+ZdpjV1ZhCcCkbiWJ+osMIGW82tyoQAqaenm0nP+l0
	 rIJ0zsaNkSgtYb4KoXgfnYsh/7hC7+dJokg9A7XD7rIoAAUARo5tAu+cP98yd6332WYK9
	 IiUlqqHEmJEY2ivef6vQ4wxPZjhbrgKO0so6rxRsJvPcXcq8aeWws7yT0gmIaB/fn16G+
	 oG4Tl03ifyOsSipe2+enAMmYMzPdP9U+N1nEp77qLI6HAmORQ7wgqVOCOznd+oWKWNmtb
	 YJdvKz1CpnnkS5HMv7DL/pO7A28f87K0jqQmgPJ5CQxxwItTGA3ez/7Sf72yv6EnfjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+Pdq7kK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC888606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 01:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+Pdq7kK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A401F0089F;
	Mon,  9 Nov 2026 01:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794189198;
	bh=vft12BI41qP9t626m6w34v7tcf/tINXg7Ct6LrUUSiI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=W+Pdq7kKSOENrE4zPtCfhqPBU1RdoKgllePjnDtEEnc451vbbvq72S9yLxvkZm10l
	 89DJIg4WyJca8nbmJXT0WG6qG2gf9M4tnr3ACKpkjNmqHTaJh5hl7HgMVJhpjWh8fg
	 YIQEyU6J92LiERutEKeHXfOJZ2MJ0QvEmUlZIpX5AUt9L/uv6HExEhXyQebLw2dKZC
	 lNZzp+1Ds+YtraaLTKT1wZ3UbTpxuNtZJixaBzVXPVynYgq/leAXorj/WYcWZALIpS
	 a+N5QS9tzRpi6fWRB9+foypLRSSaSYD5T09W4WsbGVmQsyJpHA8w/lvcAv4uq88kD/
	 /cJwNsUbQar/A==
Message-ID: <sashiko-outbox-204330@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 07/24] KVM: x86: Avoid redundant masterclock updates
 from multiple vCPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261109012112.3415328-8-dwmw2@infradead.org>
References: <20261109012112.3415328-1-dwmw2@infradead.org>
 <20261109012112.3415328-8-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:53:17 +0000
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
- [Medium] KVM: x86: premature kvm_guest_time_update() in
  __kvm_start_pvclock_update()
- [Medium] KVM: x86: race in __kvm_start_pvclock_update() lets vCPUs
  skip clock update
--

commit 562c60eff9324c1010b59724e91ff05f45041197
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Avoid redundant masterclock updates from multiple vCPUs

This commit deduplicates VM-wide masterclock updates by clearing pending
KVM_REQ_MASTERCLOCK_UPDATE bits across all vCPUs inside
__kvm_start_pvclock_update() under tsc_write_lock and bailing out if
another vCPU already serviced the request.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0348f24cfd1d3..290a3c3bb44fc 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1733,10 +1733,51 @@ static void kvm_make_mclock_inprogress_request(st=
ruct kvm *kvm)
>  	kvm_make_all_cpus_request(kvm, KVM_REQ_MCLOCK_INPROGRESS);
>  }
> =20
> -static void __kvm_start_pvclock_update(struct kvm *kvm)
> +static void kvm_clear_mclock_inprogress_request(struct kvm *kvm)
>  {
> +	struct kvm_vcpu *vcpu;
> +	unsigned long i;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
> +}
> +
> +static bool __kvm_start_pvclock_update(struct kvm *kvm, struct kvm_vcpu =
*requesting_vcpu)
> +{
> +	struct kvm_vcpu *vcpu;
> +	unsigned long i;
> +
>  	raw_spin_lock_irq(&kvm->arch.tsc_write_lock);
> +
> +	/*
> +	 * If another vCPU already did the update while we were waiting
> +	 * for the lock, our request will have been cleared. Bail out,
> +	 * clearing the KVM_REQ_MCLOCK_INPROGRESS kicks made on entry to
> +	 * kvm_update_masterclock() so vCPUs can enter the guest again.
> +	 *
> +	 * Clearing them VM-wide can also clear kicks just made by yet
> +	 * another updater still waiting for tsc_write_lock, letting
> +	 * vCPUs run while that update is in flight. That is not new:
> +	 * kvm_end_pvclock_update() has always cleared the request on
> +	 * every vCPU regardless of which updater made it. The window is
> +	 * harmless to readers (the pvclock seqcount covers the master
> +	 * state); a vCPU which slips in runs on the old snapshot until
> +	 * its KVM_REQ_CLOCK_UPDATE is serviced, exactly as if it had
> +	 * entered just before the update began.
> +	 */
> +	if (requesting_vcpu &&
> +	    !kvm_test_request(KVM_REQ_MASTERCLOCK_UPDATE, requesting_vcpu)) {
> +		kvm_clear_mclock_inprogress_request(kvm);
> +		raw_spin_unlock_irq(&kvm->arch.tsc_write_lock);
> +		return false;
> +	}

[Severity: Medium]
Can clearing KVM_REQ_MCLOCK_INPROGRESS while another updater is waiting on
tsc_write_lock allow a third vCPU whose KVM_REQ_MASTERCLOCK_UPDATE was
consumed to enter the guest before the update finishes, and stay in guest
mode without servicing KVM_REQ_CLOCK_UPDATE?

Because kvm_make_mclock_inprogress_request() runs before acquiring
tsc_write_lock, an updater bailing out (or finishing in
kvm_end_pvclock_update()) can clear the KVM_REQ_MCLOCK_INPROGRESS bits just
set by a second updater waiting on the lock.  When that second updater
acquires tsc_write_lock, it clears KVM_REQ_MASTERCLOCK_UPDATE on all vCPUs
before setting KVM_REQ_CLOCK_UPDATE in kvm_end_pvclock_update():

CPU0 (vcpu0)              CPU1 (vcpu1)              CPU2 (vcpu2)
------------              ------------              ------------
kvm_update_masterclock()
  /* cleared by prior
     updater */
                          kvm_update_masterclock()
                            kvm_make_mclock_inprogress_request()
  __kvm_start_pvclock_update()
    kvm_clear_mclock_inprogress_request()
    unlock(tsc_write_lock)
                            __kvm_start_pvclock_update()
                              lock(tsc_write_lock)
                              kvm_clear_request(MASTERCLOCK, vcpu2)
                                                    vcpu_enter_guest()
                                                      test(MASTERCLOCK) -> 0
                                                      check(CLOCK_UPDATE) -=
> 0
                                                      exit_request() -> 0
                                                      /* enters guest */
                              write_seqcount_begin(&pvclock_sc)
                            pvclock_update_vm_gtod_copy()
                            kvm_end_pvclock_update()
                              kvm_make_request(CLOCK_UPDATE, vcpu2)
                              /* no kick */

vcpu_enter_guest() only reads pvclock_sc inside kvm_guest_time_update()
when KVM_REQ_CLOCK_UPDATE is set.  If vcpu2 only had
KVM_REQ_MASTERCLOCK_UPDATE pending (for example, after enabling
HV_X64_MSR_REFERENCE_TSC in kvm_hv_set_msr_pw()), it skips both
kvm_update_masterclock() and kvm_guest_time_update(), sees
KVM_REQ_MCLOCK_INPROGRESS cleared, and enters the guest before
kvm_hv_setup_tsc_page() or pvclock_update_vm_gtod_copy() has run.
Unlike a vCPU that entered before the update began and was kicked by
kvm_make_mclock_inprogress_request(), kvm_end_pvclock_update() calls
kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu) without kicking, so vcpu2
remains in guest mode with stale clock state until an unrelated VM-exit.

> +
> +	/* The update is VM-wide; prevent other vCPUs from redoing it. */
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		kvm_clear_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
> +
>  	write_seqcount_begin(&kvm->arch.pvclock_sc);
> +	return true;
>  }

[Severity: Medium]
Does clearing KVM_REQ_MASTERCLOCK_UPDATE on all vCPUs before
write_seqcount_begin(&kvm->arch.pvclock_sc) allow another vCPU to run
kvm_guest_time_update() against the stale masterclock snapshot?

When both KVM_REQ_MASTERCLOCK_UPDATE and KVM_REQ_CLOCK_UPDATE are pending
on vcpu1 (such as after kvm_write_system_time() or __kvm_synchronize_tsc()),
clearing KVM_REQ_MASTERCLOCK_UPDATE before opening pvclock_sc lets vcpu1
skip kvm_update_masterclock() without waiting on tsc_write_lock and read
pvclock_sc before the write section begins:

CPU0 (vcpu0)                            CPU1 (vcpu1)
------------                            ------------
__kvm_start_pvclock_update()
  kvm_clear_request(MASTERCLOCK, vcpu1)
                                        vcpu_enter_guest()
                                          test(MASTERCLOCK) -> false
                                          check(CLOCK_UPDATE) -> true
                                          kvm_guest_time_update()
                                            read_seqcount_begin(&pvclock_sc)
                                            /* reads stale masterclock */
                                            kvm_hv_setup_tsc_page()
  write_seqcount_begin(&pvclock_sc)
pvclock_update_vm_gtod_copy()
kvm_end_pvclock_update()

In addition to writing stale pvclock data to guest memory, the premature
kvm_hv_setup_tsc_page() call consumes HV_TSC_PAGE_HOST_CHANGED or
HV_TSC_PAGE_GUEST_CHANGED using the pre-update state and transitions
hv_tsc_page_status to HV_TSC_PAGE_SET or HV_TSC_PAGE_BROKEN:

arch/x86/kvm/hyperv.c:kvm_hv_setup_tsc_page() {
	...
	if (hv->hv_tsc_page_status =3D=3D HV_TSC_PAGE_BROKEN ||
	    hv->hv_tsc_page_status =3D=3D HV_TSC_PAGE_SET ||
	    hv->hv_tsc_page_status =3D=3D HV_TSC_PAGE_UNSET)
		return;
	...
}

When kvm_end_pvclock_update() subsequently requests KVM_REQ_CLOCK_UPDATE,
kvm_hv_setup_tsc_page() returns early and leaves the Hyper-V reference TSC
page stuck with stale parameters or permanently disabled.  Opening
pvclock_sc with write_seqcount_begin() before the kvm_for_each_vcpu() loop
that clears KVM_REQ_MASTERCLOCK_UPDATE would ensure any vCPU that sees its
request cleared already observes the open seqcount.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109012112.3415=
328-1-dwmw2@infradead.org?part=3D7
