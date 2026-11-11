Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381318;
	b=AWchy2kdywHs39vvQC4GrDGhW5v1iJ6HMEyVThD8hCX7/ms3kFqUIQ4d9hHXRw7cuAkw
	 ELd0YSdpI8Iq7KA+likiO9RvNDVtm0zJDi8SPQi/KP57eAP+LK3q+8BF6vU9vYzHKqudl
	 BZAAU2VYOMLwb7AIo465iYiFy4sZf5nceQwzUbAOnhzej0rOYd2lOtWtHGrVc717F2Q42
	 tUnXMm9uFUQ8cvuS9Fqq3aTlta8z+u6YSu0Utra4dBQAG/8Nkok9eZ4WyklGQGW0arhfm
	 X9612oSGf+//sbeXcYnOEWKDVDSe+sZ9LKLPNjqhF8ufqe6ieX7xTN00aTThNeBXYSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381318;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AoJgv7dVRnfhf34/wVONE7S/4tJx9d9kLDaewhKb9Qc=;
	b=AdjjpSNTizUzNcyNV3lzT9Bng1A24Ok6LTNs5Mh2kTB/374Sv8E6XaQpuEy+5shVeDW7
	 UyFzKqhXSKoEKT2zAYtnloiK4t8KxyuIt3Jg+/qFNPjLTXkeZmJojw+NDh5LCiJFOmASk
	 uuI8NWraaBPTSxULgkb6UPlqjoe7tCBDnTolykkRItvlZOucmmbkLifkaOo2vNrlaJnq5
	 FSjXMXgUUgDpIAmurvXTeyzSCmyEvk58MyTKKyjh7eYgvXs3JrRrZQH7WY0ubfGoAEBpO
	 DugEeUbYxWIli7YbfV/Cb9GWHzgs3K4g8B6yR2zETuiGdFraqQRUEcVo/Fh8aXB4iEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNOnyRgf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37D606A320
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNOnyRgf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66B01F00A05;
	Wed, 11 Nov 2026 07:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794381317;
	bh=AoJgv7dVRnfhf34/wVONE7S/4tJx9d9kLDaewhKb9Qc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hNOnyRgf2Zm0wpJkZl/voCePAr9KLFnssJvtMa3aMMZIXu+Q8O5B9//jwIWQffevj
	 RxROgEpMPvfuTPkJV9UTGiAGxmA+DuYndYrNvWVmx1vd7wwojWviV7/lJice3x8JqW
	 SIdTpuiN7F5yYiDVaf7jZmUFPOa1uU8Ql170jb4GM2C43LJH5u2GUE8keggsFRDCoa
	 FvtpLvNEY3OnYAfZAYX7odYLhDdSax8P+p2Jq8OLhMx7TD1WdQgFZJuFQJEWTAr5BQ
	 /6eFyXMYB3FH1yWUPeGzpDS6/3Bnq3dVfWRpFTJ+CiYmoyDwTk4xm9wlU8siFT5lNF
	 w9vz9hslXgzDQ==
Message-ID: <sashiko-outbox-208500@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/7] KVM: SVM: Add support for AMD IOMMU Guest APIC
 Physical Processor Interrupt (GAPPI)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261111064242.29336-7-sarunkod@amd.com>
References: <20261111064242.29336-1-sarunkod@amd.com>
 <20261111064242.29336-7-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 07:15:17 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] KVM: SVM: circular lock dependency in __avic_vcpu_load() with
  GAPPI
- [Medium] KVM: SVM: non-blocking vCPUs queued on wakeup list on
  AVIC_STOP_RUNNING
- [Low] KVM: SVM: stale commit message and cleanup churn in
  avic_hardware_unsetup()
--

commit 569af3da1a9a9cddca4d1455d68973d185c0555b
Author: Sairaj Kodilkar <sarunkod@amd.com>

KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor Interrupt=
 (GAPPI)

This commit adds KVM SVM support for AMD IOMMU Guest APIC Physical Processor
Interrupt (GAPPI) to wake blocked vCPUs via POSTED_INTR_WAKEUP_VECTOR inste=
ad
of the legacy GA log mechanism.

> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index b975f08825ce2..ebfd74adc4cbd 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c

[ ... ]

> @@ -1018,7 +1038,7 @@ enum avic_vcpu_action {
>  };
> =20
>  static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int a=
picid,
> -					    enum avic_vcpu_action action)
> +					    int cpu, enum avic_vcpu_action action)
>  {
>  	bool wakeup_intr =3D (action & AVIC_START_BLOCKING);
>  	bool is_running =3D apicid >=3D 0;
> @@ -1027,6 +1047,36 @@ static void avic_update_iommu_vcpu_affinity(struct=
 kvm_vcpu *vcpu, int apicid,
> =20
>  	lockdep_assert_held(&svm->ir_list_lock);
> =20
> +	if (!amd_iommu_gappi)
> +		goto skip_wakeup_handler;
> +
> +	if (action & AVIC_TOGGLE_ON_OFF) {
> +		/*
> +		 * When AVIC is disabled, IOMMU switches to legacy IRTE and
> +		 * does not generate wakeup notification. Hence there is no
> +		 * need to add vCPU on wakeup list. This reduces the number of
> +		 * vCPUs on the list, effectively reducing interrupt handler
> +		 * time and avoiding spurious wakeup to the vCPU.
> +		 */
> +		if (is_running)
> +			/*
> +			 * Store the CPU so that next call with
> +			 * AVIC_STOP_RUNNING can add the vCPU on to
> +			 * appropriate wakeup list.
> +			 */
> +			svm->gappi_cpu =3D cpu;
> +		goto skip_wakeup_handler;
> +	}
> +
> +	if (is_running) {
> +		kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
> +		svm->gappi_cpu =3D cpu;

[Severity: Medium]
Does calling kvm_pi_disable_wakeup_handler() while holding svm->ir_list_lock
introduce a lockdep circular locking dependency with the scheduler runqueue
lock?

CPU0 (<hardirq>)        CPU1                     CPU2
----                    ----                     ----
lock(wakeup_vcpus_on_cpu_lock)
                        lock(&rq->__lock)
                        lock(&svm->ir_list_lock)
                                                 lock(&svm->ir_list_lock)
                                                 lock(wakeup_vcpus_on_cpu_l=
ock)
lock(&rq->__lock)

 *** DEADLOCK ***

CPU0: kvm_pi_wakeup_handler() -> kvm_vcpu_wake_up() -> try_to_wake_up()
CPU1: schedule() -> kvm_sched_out() -> ... -> __avic_vcpu_put()
CPU2: __avic_vcpu_load() -> ... -> kvm_pi_disable_wakeup_handler()

kvm_pi_enable_wakeup_handler() uses PI_LOCK_SCHED_OUT to avoid a cycle when
called under rq->__lock during kvm_sched_out(), while
kvm_pi_disable_wakeup_handler() acquires wakeup_vcpus_on_cpu_lock at
subclass 0 before acquiring PI_LOCK_SCHED_OUT.  Because __avic_vcpu_put()
acquires svm->ir_list_lock under rq->__lock when a running vCPU is preempte=
d,
calling kvm_pi_disable_wakeup_handler() under svm->ir_list_lock in
__avic_vcpu_load() bridges rq->__lock to wakeup_vcpus_on_cpu_lock at
subclass 0 and triggers a lockdep splat on CONFIG_PROVE_LOCKING kernels.

> +	} else {
> +		apicid =3D cpu_physical_id(svm->gappi_cpu);
> +		kvm_pi_enable_wakeup_handler(vcpu, svm->gappi_cpu);
> +	}

[Severity: Medium]
Should kvm_pi_enable_wakeup_handler() only be called when wakeup_intr is tr=
ue
(action & AVIC_START_BLOCKING)?

When a vCPU is preempted or exits to userspace without blocking,
avic_vcpu_put() calls __avic_vcpu_put(vcpu, AVIC_STOP_RUNNING), where
is_running is false and wakeup_intr is false.  Enqueuing the vCPU here puts
non-blocking vCPUs onto per_cpu(wakeup_vcpus_on_cpu, svm->gappi_cpu) on eve=
ry
vcpu_put(), causing kvm_pi_wakeup_handler() to scan their vAPIC IRR bitmaps=
 on
every wakeup interrupt and requiring every subsequent __avic_vcpu_load() to
take wakeup_vcpus_on_cpu_lock to remove them.

[ ... ]

> @@ -1308,6 +1358,13 @@ static bool __init avic_want_avic_enabled(void)
>  	return true;
>  }
> =20
> +bool avic_vcpu_irq_pending(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +
> +	return kvm_lapic_find_highest_irr(&svm->vcpu) >=3D 0;
> +}
> +
>  /*
>   * Note:
>   * - The module param avic enable both xAPIC and x2APIC mode.
> @@ -1351,6 +1408,8 @@ bool __init avic_hardware_setup(void)
> =20
>  void avic_hardware_unsetup(void)
>  {
> -	if (avic)
> -		amd_iommu_register_ga_log_notifier(NULL);
> +	if (!avic)
> +		return;
> +
> +	amd_iommu_register_ga_log_notifier(NULL);
>  }

[Severity: Low]
This isn't a bug, but the change in avic_hardware_unsetup() looks like
leftover churn from when wakeup handler unregistration lived in SVM rather
than common x86 code.  Along the same lines, the commit message states that
SVM registers the GAPPI handler via kvm_set_posted_intr_wakeup_handler() and
walks the local vCPU list, which was moved to common x86 code in earlier
commit "KVM: VMX: Factor out wakeup list handling code to KVM".  Also,
avic_vcpu_irq_pending() can pass vcpu directly to kvm_lapic_find_highest_ir=
r()
without converting through to_svm(vcpu).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111064242.2933=
6-1-sarunkod@amd.com?part=3D6
