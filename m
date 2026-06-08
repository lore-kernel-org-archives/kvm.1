Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953882F90C9
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931560; cv=none; b=fVlFsRTJvTHHmWIOlvnCZSlGDNexyXnKwQxDtcyVjMzDK9LvX1r8ZtwtuumDtp80giwsIDEqRd1FdHU2WG8szoLb7q+p7k4dtGSIetaKILYXT2WYG2zhF9wTbz3w3TcElZlicmn/1oNRJo5hh+sATSowtr/klsiu7YSTF/EjlbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931560; c=relaxed/simple;
	bh=6o6TUjA1C098iC+iI12VoqpOHR1ohICwWRg1mJ1c79w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sqLe67f+yk+nrSdzjWh1O27ebk41NMEOFQ/oTiYxMf4dmFKRH/cxNsP3vqH0w/LS91Xsub+XT+Jb3Yucsm3eXZ7f3bzIo/pYYoI99VqzzhWJUBMRusOj7drtsCvkwKslaFvsTzBuyw8/gRTb21PGMc/QLvt4OGOyR9N3KBp1k40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQLxvoIO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQLxvoIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D9E1F00893;
	Mon,  8 Jun 2026 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780931559;
	bh=RN2kjWES+pcoCY6Oz4jUXZHFeq1UrPuQBgf8f9vY57U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aQLxvoIO//nakN0aVcgFF20mJnhHeu/Ijsx5VJ4EA9iZuhbcikFVKdXrgLDimzhgn
	 crycAEFa24gS6LCKE71+9vWlvnFWLSib5CM61dP/DWrCnG6rW7CNlTMazjIvGF+ycJ
	 adqJrXOZfzjur6HPYDX1evICaQWmbXb184+EFXsl+j2fxUhHApZO4TrQ3spEwMG8F4
	 oRMFpGo38LgPZn35+UquGMiFPqLvbNFfEBQ+jTmYUTHK7d+wdcStznnuxptqI1/odv
	 Ql0HMCVS12DlzefoBRw6aiRUNXwITA3dHpW0syI8WbA+MZDjPInsZ30ur5u6rLWeYp
	 z+q/Y2jPXU70w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/60] KVM: SVM: Inject #HV when Restricted Injection is
 active
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-4-joro@8bytes.org>
References: <20260608144252.351443-4-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:12:38 +0000
Message-Id: <20260608151239.29D9E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Multiple adversary-reachable WARN_ONCE and WARN_ON_ONCE assertions=
 allow host Denial of Service.
- [High] Modifications to the guest-mapped #HV doorbell page lack dirty pag=
e tracking, risking data loss during live migration.
- [High] Mapping the doorbell page in sev_snp_blocked within the fast-path =
polling check causes severe performance degradation and clobbers task state.
--

commit a8e775e3cfdeaa116335b8c455642286a69f773b
Author: Melody Wang <huibo.wang@amd.com>

KVM: SVM: Inject #HV when Restricted Injection is active

This commit implements #HV exception injection for SEV-SNP guests when
Restricted Injection is active. It maps the guest-provided doorbell page,
updates the pending events, and sets up the VMCB to deliver the exception.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index f022be532695a..cda83437382d7 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -5360,3 +5360,167 @@ void sev_free_decrypted_vmsa(struct kvm_vcpu *vcp=
u, struct vmcb_save_area *vmsa)
[ ... ]
> +static void unmap_hvdb(struct kvm_vcpu *vcpu, struct kvm_host_map *map)
> +{
> +	kvm_vcpu_unmap(vcpu, map);
> +}

[Severity: High]
Does unmapping the doorbell page without marking it dirty risk data loss
during live migration?

In __sev_snp_inject() and sev_snp_cancel_injection(), KVM writes to the
guest-mapped doorbell page (for example, updating events.vector or clearing
pending_events).

Since this wrapper only calls kvm_vcpu_unmap() without first calling
kvm_vcpu_mark_page_dirty(), the host kernel remains unaware of these
modifications. Will this cause the updated doorbell state to be silently
dropped when the VM is live-migrated?

[ ... ]
> +static void __sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcp=
u)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	struct kvm_host_map hvdb_map;
> +	struct hvdb *hvdb;
> +
> +	hvdb =3D map_hvdb(vcpu, &hvdb_map);
> +	if (!hvdb) {
> +		WARN_ONCE(1, "Restricted Injection enabled, hvdb page mapping failed\n=
");

[Severity: High]
Is it safe to use a host-side WARN_ONCE here?

The guest controls the doorbell page GPA and can intentionally unshare the
page or provide an invalid GPA to cause a mapping failure. Since a malicious
guest can trigger this path, won't this allow a host denial of service if
panic_on_warn is enabled?

> +		return;
> +	}
[ ... ]
> +bool sev_snp_queue_exception(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +
> +	if (!sev_snp_is_rinj_active(vcpu))
> +		return false;
> +
> +	/*
> +	 * Restricted Injection is enabled, only #HV is supported.
> +	 * If the vector is not HV_VECTOR, do not inject the exception,
> +	 * then return true to skip the original injection path.
> +	 */
> +	if (WARN_ONCE(vcpu->arch.exception.vector !=3D HV_VECTOR,
> +		      "Restricted Injection enabled, exception vector %u injection not=
 supported\n",
> +		      vcpu->arch.exception.vector))

[Severity: High]
Could this warning be triggered by unprivileged host userspace?

If KVM queues an exception other than the HV vector, this WARN_ONCE
will trigger. Since host userspace can queue exceptions via the
KVM_SET_VCPU_EVENTS ioctl, can a malicious host userspace process use
this to trigger a host denial of service?

> +		return true;
[ ... ]
> +void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
> +{
[ ... ]
> +	/*
> +	 * Copy the information in the doorbell page into the event injection
> +	 * fields to complete the cancellation flow.
> +	 */
> +	hvdb =3D map_hvdb(vcpu, &hvdb_map);
> +	if (!hvdb)
> +		return;
> +
> +	if (!hvdb->events.pending_events) {
> +		/* No pending events, then event_inj field should be 0 */
> +		WARN_ON_ONCE(svm->vmcb->control.event_inj);

[Severity: High]
Can a concurrent vCPU cause this warning to fire?

The doorbell page resides in guest memory. If a concurrent vCPU simply
zeroes out the pending_events field while KVM handles a VM-Exit,
won't this WARN_ON_ONCE trigger?

> +		goto out;
> +	}
[ ... ]
> +bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_host_map hvdb_map;
> +	struct hvdb *hvdb;
> +	bool blocked;
> +
> +	/* Indicate interrupts are blocked if doorbell page can't be mapped */
> +	hvdb =3D map_hvdb(vcpu, &hvdb_map);

[Severity: High]
Does mapping the doorbell page dynamically inside this polling check
cause performance degradation and clobber task state?

This function is called continuously during the vCPU run loop from
svm_interrupt_blocked() via kvm_vcpu_has_events(). Calling map_hvdb()
here performs a full memslot lookup, address translation, and kmap/kunmap
on every invocation.

Furthermore, when kvm_vcpu_block() prepares to wait, it sets the task
state to TASK_INTERRUPTIBLE before calling kvm_vcpu_has_events(). If
kvm_vcpu_map() blocks (for example, during a page fault or when acquiring
mmap_lock):

virt/kvm/kvm_main.c:kvm_vcpu_block()
    prepare_to_rcuwait(&vcpu->wait);=20
    ...
    if (kvm_vcpu_check_block(vcpu) < 0)
        break;

The scheduler resets the task state to TASK_RUNNING if it blocks. Will
the subsequent schedule() call then return immediately, defeating the idle
wait and causing the vCPU thread to busy-spin?

> +	if (!hvdb)
> +		return true;
> +
> +	/* Indicate interrupts blocked based on guest acknowledgment */
> +	blocked =3D !!hvdb->events.vector;
> +
> +	unmap_hvdb(vcpu, &hvdb_map);
> +
> +	return blocked;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D3
