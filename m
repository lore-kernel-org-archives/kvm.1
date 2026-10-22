Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679549;
	b=uAxOSuSE3QyypLTirv3+nKUxGWEQY9kKCtCrQLKMLjkX4su+FMVoY5F57lxeAYMKr3Lb
	 RcPpyQ2LvifGy52TzkrH6bBt29OEuN75GU2GWoEAQ/oPWuHC4bDLCmVj8b4toVV5gB6BR
	 pict4MGIpRjDaugyU22YPNfkSx6Rg5u3sNnucdu33+hz9/iFqSBrWgZq8BN8a+AA87WII
	 MGfdk75+LkmiFRD3vtqskAd9m+PrtR/U5JhzyIB84dXrUDb8TUxxgbEaDSmH0+PPCUBlD
	 qYWl/LxByG1r9GPduqCBtDUYxsG12jGg+gqMvGeGnN4ZHBPNaYs9/4qhLQvZ9bsv1sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679549;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VRcuUxciBS4kxql1uP9iLuBxM/q3MNkhJJ328+6GZig=;
	b=F0cO/j9NZOh986/Mnltxv0MjTNKokqqp/4DQCJIUdA1ouTagIbPxhN+ZHQpNivi7Ls/h
	 uSLca8jyGkBtYgY25g2eMDpJ/+tkbLKw7s1qnUhoj+MZ/vKDSXpKndh50BXdz63WBk85n
	 gQHsNGMWmlmuiQKMQO784tkvD3RlHPZTy033H7HAg41rYP5OCMvTpwaG12jWYkF4NIigM
	 vBToLGJiH/XdQTtn/1VuQxyBtvsszptxvcV1gmq5ZxV1iu4yUuusMmj25cAjRuno7ASxs
	 cs8d9rl42sl+ioflBuZaSbiByuLIxPu8lDVfc44vfR2NDIctxTfpgB6814NYe2/rGDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebLCLNRp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570FA606A31D
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebLCLNRp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9730D1F000C1;
	Thu, 22 Oct 2026 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679548;
	bh=VRcuUxciBS4kxql1uP9iLuBxM/q3MNkhJJ328+6GZig=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ebLCLNRplvXzmW5sevd9tPtZt+dMjroKnBeqZvS8+XldzPhHQN7xfMIcdhQHpIRqt
	 DoZNZGpRXrQzAQhGJQovkOrhkSslcksfusSUWPAF24HrDaLIBr3wraZYstgS8imrh5
	 oI4ZhkaXA79HukVM4sP7Lv3zSMb0mFXBqYpHNPDmKiAnIiCwnSGey1tjU5kdYbitoT
	 HlHWoxlEIzCN/PK/UgENyR5lzYToafpMyScx0lfiPXbZCZeswdWFuoXMhcDcfh7/FD
	 kDkOXDL4pYJg0NEwzAm9VG/aYL3hrinVV2GJjhiBcWmtt7aT+lGo8Y2ZvKJ+WyCysH
	 H0bDzU7TUB8EQ==
Message-ID: <sashiko-outbox-181641@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/7] KVM: SVM: Add support for AMD IOMMU Guest APIC
 Physical Processor Interrupt (GAPPI)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261022140425.27465-7-sarunkod@amd.com>
References: <20261022140425.27465-1-sarunkod@amd.com>
 <20261022140425.27465-7-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 14:32:28 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] KVM: SVM: avic_update_iommu_vcpu_affinity() sets IRTE destination =
to -1
- [High] KVM: SVM: avic_update_iommu_vcpu_affinity() skips gappi_cpu on act=
ivate
- [High] KVM: SVM: circular lock dependency in __avic_vcpu_load() with GAPPI
--

commit eadb6986c75d5c64b26f6497306bb267961e5f78
Author: Sairaj Kodilkar <sarunkod@amd.com>

KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor Interrupt=
 (GAPPI)

This commit adds KVM SVM support for AMD IOMMU Guest APIC Physical Processor
Interrupt (GAPPI) as an alternative to the legacy GA log mechanism for waki=
ng
non-running vCPUs when device interrupts are posted to the guest vAPIC
backing page. When a vCPU blocks, SVM places it on the previous pCPU's post=
ed
interrupt wakeup list and programs the IOMMU IRTE destination with that
pCPU's physical APIC ID and POSTED_INTR_WAKEUP_VECTOR.

> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index b975f08825ce2..baeca0ad8dfee 100644
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
> @@ -1027,6 +1047,25 @@ static void avic_update_iommu_vcpu_affinity(struct=
 kvm_vcpu *vcpu, int apicid,
> =20
>  	lockdep_assert_held(&svm->ir_list_lock);
> =20
> +	if (action & AVIC_TOGGLE_ON_OFF)
> +		/*
> +		 * When AVIC is disabled, IOMMU switches to legacy IRTE and
> +		 * does not genrate wakeup notification. Hence there is no
> +		 * need to add vCPU on wakeup list. This reduces the number of
> +		 * vCPUs on the list, effectively reducing interrupt handler
> +		 * time and avoiding spurious wakeup to the vCPU.
> +		 */
> +		goto skip_wakeup_handler;

[Severity: High]
When AVIC is activated on a vCPU via avic_refresh_apicv_exec_ctrl() ->
__avic_vcpu_load(vcpu, vcpu->cpu, AVIC_ACTIVATE), action is AVIC_ACTIVATE
(which is aliased to AVIC_TOGGLE_ON_OFF). Won't jumping to
skip_wakeup_handler here skip updating svm->gappi_cpu =3D cpu?

While APICv is inactive or temporarily inhibited (for example at vCPU start=
up
before the guest LAPIC is enabled, or due to nested virtualization or IRQ
window inhibits), svm_vcpu_load() in arch/x86/kvm/svm/svm.c does not call
avic_vcpu_load() when the vCPU migrates to another pCPU:

	if (kvm_vcpu_apicv_active(vcpu))
		avic_vcpu_load(vcpu, cpu);

When APICv is later enabled or uninhibited on the current pCPU,
avic_refresh_apicv_exec_ctrl() calls __avic_vcpu_load(vcpu, vcpu->cpu,
AVIC_ACTIVATE). Because AVIC_TOGGLE_ON_OFF jumps over svm->gappi_cpu =3D cp=
u,
svm->gappi_cpu remains at its previous value (or 0 if the vCPU started on a
non-zero pCPU).

If the vCPU then blocks via avic_vcpu_blocking() ->
__avic_vcpu_put(vcpu, AVIC_START_BLOCKING) before another schedule-out and
schedule-in cycle, or if avic_pi_update_irte() runs while it is not running,
won't KVM enqueue the vCPU on the wrong pCPU's wakeup_vcpus_on_cpu list and
program IRTE[Destination] with the stale pCPU's physical APIC ID (which may
even belong to an offline CPU if the previous pCPU was offlined while APICv
was inhibited)?

> +
> +	if (amd_iommu_gappi && is_running) {
> +		kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
> +		svm->gappi_cpu =3D cpu; /* Store cpu number as target for GAPPI */
> +	} else if (amd_iommu_gappi && wakeup_intr) {
> +		apicid =3D cpu_physical_id(svm->gappi_cpu);
> +		kvm_pi_enable_wakeup_handler(vcpu, svm->gappi_cpu);
> +	}

[Severity: High]
What happens when a running vCPU with an assigned device is scheduled out
without blocking (for example, preempted via kvm_sched_out() ->
kvm_arch_vcpu_put() -> svm_vcpu_put() -> avic_vcpu_put(), or put via
vcpu_put() on exit to userspace)?

In that path, avic_vcpu_put() calls __avic_vcpu_put(vcpu, AVIC_STOP_RUNNING=
),
which invokes avic_update_iommu_vcpu_affinity(vcpu, -1, -1,
AVIC_STOP_RUNNING). Both is_running (apicid >=3D 0) and wakeup_intr
(action & AVIC_START_BLOCKING) are false, so apicid is not updated to
cpu_physical_id(svm->gappi_cpu) and remains -1 (unlike avic_pi_update_irte(=
),
which sets pi_data.apicid =3D cpu_physical_id(svm->gappi_cpu) whenever
!is_running && amd_iommu_gappi).

avic_update_iommu_vcpu_affinity() then passes apicid =3D -1 to
amd_iommu_update_ga(data, -1, false, false), where __amd_iommu_update_ga() =
in
drivers/iommu/amd/iommu.c unconditionally writes apicid into
IRTE[Destination]:

	if (amd_iommu_gappi) {
		entry->lo.fields_vapic.gappi_dis =3D !wakeup_intr &&
					check_feature2(FEATURE_GAPPIDISSUP);
		entry->lo.fields_vapic.is_run =3D false;
		entry->lo.fields_vapic.destination =3D
					APICID_TO_IRTE_DEST_LO(apicid);
		entry->hi.fields.destination =3D
					APICID_TO_IRTE_DEST_HI(apicid);
	}

Doesn't this program the live guest-mode IRTE destination fields to
0xffffffff (the broadcast APIC ID), causing the IOMMU to deliver broadcast
POSTED_INTR_WAKEUP_VECTOR interrupts across host CPUs on hardware that
supports GAPPI without FEATURE_GAPPIDISSUP?

> +
> +skip_wakeup_handler:
>  	/*
>  	 * Here, we go through the per-vcpu ir_list to update all existing
>  	 * interrupt remapping table entry targeting this vcpu.
> @@ -1093,7 +1132,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu,=
 int cpu,
> =20
>  	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
> =20
> -	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, action);
> +	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, cpu, action);
> =20
>  	raw_spin_unlock_irqrestore(&svm->ir_list_lock, flags);
>  }
> @@ -1135,7 +1174,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, =
enum avic_vcpu_action action)
>  	 */
>  	raw_spin_lock_irqsave(&svm->ir_list_lock, flags);
> =20
> -	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
> +	avic_update_iommu_vcpu_affinity(vcpu, -1, -1, action);

[Severity: High]
Can calling kvm_pi_disable_wakeup_handler() inside
avic_update_iommu_vcpu_affinity() while holding svm->ir_list_lock in
__avic_vcpu_load() trigger a circular lock dependency with the scheduler and
posted-interrupt wakeup locks?

1. In the POSTED_INTR_WAKEUP_VECTOR interrupt handler,
   kvm_pi_wakeup_handler() in arch/x86/kvm/x86.c acquires
   wakeup_vcpus_on_cpu_lock at subclass 0 and calls kvm_vcpu_wake_up() ->
   rcuwait_wake_up() -> wake_up_process() -> try_to_wake_up(), which acquir=
es
   p->pi_lock and rq->__lock:

   wakeup_vcpus_on_cpu_lock(0) -> p->pi_lock -> rq->__lock

2. When a vCPU is preempted during schedule(), prepare_task_switch() holds
   rq->__lock and invokes fire_sched_out_preempt_notifiers() ->
   kvm_sched_out() -> kvm_arch_vcpu_put() -> svm_vcpu_put() ->
   avic_vcpu_put() -> __avic_vcpu_put(), which acquires svm->ir_list_lock:

   rq->__lock -> svm->ir_list_lock

3. In __avic_vcpu_load() (called from svm_vcpu_load() and
   avic_vcpu_unblocking()), svm->ir_list_lock is held when
   avic_update_iommu_vcpu_affinity() calls
   kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu), which in
   arch/x86/kvm/x86.c acquires wakeup_vcpus_on_cpu_lock at subclass 0 before
   PI_LOCK_SCHED_OUT:

   svm->ir_list_lock -> wakeup_vcpus_on_cpu_lock(0)

Holding svm->ir_list_lock across kvm_pi_disable_wakeup_handler() bridges
rq->__lock to wakeup_vcpus_on_cpu_lock(0), defeating the PI_LOCK_SCHED_OUT
subclass separation and completing the lockdep cycle.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022140425.2746=
5-1-sarunkod@amd.com?part=3D6
