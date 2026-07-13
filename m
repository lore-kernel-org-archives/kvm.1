Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750F137A83B
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941081; cv=none; b=VEdLKSMvTCIdvqnZbs0neDxYN6hL9ZCCjbli1ttrwTY48msuBMTFNxIUZggQRhEXf5ULgO51rQGx1L4jHsn9wKmNpEWbo7Kudt4PwhTMaj4ndQVEKbqbDg1c9bfTzT7fcqjGEQ4fUW4Nf6Y9Z1SE4cCBXapYC8KONTxte9oI0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941081; c=relaxed/simple;
	bh=fxd1cU59FaZ0RWF2zwSXjS+o4eQieFlfljSEXjnmDzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ukeuE9N06ElEd9PelpTGtO5F0QCSWTl+LVTO0vTNdkYyQdFVzm4+37wz7ttmuwwhJPcc2DmYxg7smJpuNlKGNTAyMfFf+2xFe8SYU7NjbTP9mNwksDQ2HmB4W6iq+MtJqcPHZdANjZ8YPxyUGYuUQoua0mKoiuu0yq2AH5Ty69Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu6Q/Y1d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu6Q/Y1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC35E1F000E9;
	Mon, 13 Jul 2026 11:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783941080;
	bh=8fqO4OEZJH9iO2NYxrHjpKvtCHEWk1Qjtd0EmYxj218=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lu6Q/Y1dPoHCuDs5T7RCz1akHBdWmEA/sMzyHaz1RcmLx/iiRK3uAnaTEfwGkV8Jr
	 uFErMtanDDi+jkwnfqsQRbenT0UJnU6nhIlKlPGRpKq5jP79I5KwqOUps2K3ZU797G
	 A2FNsiAlrJ3/WZnUXMXtPbTRdP8RUZfGEQjsmWnEEVSm9vuMSorkzNAc1jT6IsI4Dy
	 QbnubKDkPQ4VUW5MokfQra70p8zZobKWastJXcgRgktwd63vfpioTpwVQlUcW1MUqM
	 cKuWrtK6fjgt7I8zd/oyafE/SJ/EP40PVs7RYnEVEJ2+aYTmQZ4AksBFD6uMQZPNUR
	 JcfrR0v48rS8w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 5/6] KVM: SVM: Add support for AMD IOMMU Guest
 APIC Physical Processor Interrupt (GAPPI)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260713105033.15405-6-sarunkod@amd.com>
References: <20260713105033.15405-1-sarunkod@amd.com>
 <20260713105033.15405-6-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 11:11:19 +0000
Message-Id: <20260713111119.EC35E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Host-userspace-reachable WARN_ON due to uninitialized `svm->gappi_=
cpu` (-1) when configuring IRQ routing before a vCPU runs.
- [High] Missing CPU hotplug handling causes blocked vCPUs to hang if their=
 last-run physical CPU goes offline.
- [High] ABBA deadlock between scheduler `rq_lock` and `gappi_vcpu_wakeup_l=
ist_lock` due to manipulating the wakeup list during vCPU preemption.
- [Low] Mixing scoped `guard()` cleanup with `goto` error handling violates=
 architectural guidelines.
--

--- Patch [5]: [RFC PATCH v3 5/6] KVM: SVM: Add support for AMD IOMMU Guest=
 APIC Physical Processor Interrupt (GAPPI) ---
commit c3bb8845bd944e9a327f36d68b70032d436f727c
Author: Sairaj Kodilkar <sarunkod@amd.com>

    KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor Inter=
rupt (GAPPI)
   =20
    With AVIC guest-mode interrupt remapping, device interrupts are posted =
into
    the guest vAPIC backing page by the IOMMU. When the vCPU is not running
    (IRTE[IsRun] =3D 0), KVM must still be notified to schedule it. The leg=
acy
    path uses the GA log.

> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 3b2d92a587098..982a5988532ff 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -886,6 +892,42 @@ int avic_init_vcpu(struct vcpu_svm *svm)
>  	return ret;
>  }
> =20
> +static void avic_add_vcpu_to_gappi_wakeup_list(struct vcpu_svm *svm, int=
 cpu)
> +{
> +	struct list_head *wakeup_list;
> +	raw_spinlock_t *spinlock;
> +
> +	if (WARN_ON(unlikely(cpu < 0)))
> +		return;

[Severity: High]
Can an unprivileged user-space process trigger this WARN_ON?

When a vCPU is created, svm->gappi_cpu is initialized to -1 in
avic_init_vcpu(). It is only set to a valid CPU ID later during
__avic_vcpu_load().

If host user-space configures device interrupt routing via the KVM_IRQFD io=
ctl
before the vCPU runs, avic_pi_update_irte() is invoked. This will pass the
uninitialized svm->gappi_cpu (-1) down to this function, hitting the WARN_O=
N.
If the host has panic_on_warn enabled, this allows host userspace to trigger
a kernel panic.

[ ... ]
> @@ -947,6 +993,12 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irq=
fd, struct kvm *kvm,
>  		 * scheduled out, KVM will update the pCPU info when the vCPU
>  		 * is awakened and/or scheduled in.  See also avic_vcpu_load().
>  		 */
> +		if (amd_iommu_gappi)
> +			pi_data.ga_tag =3D POSTED_INTR_WAKEUP_VECTOR;
> +		else
> +			pi_data.ga_tag =3D AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
> +						    vcpu->vcpu_idx);
> +
>  		entry =3D svm->avic_physical_id_entry;
>  		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK) {
>  			pi_data.apicid =3D entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MA=
SK;
> @@ -955,11 +1007,19 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *i=
rqfd, struct kvm *kvm,
>  			pi_data.apicid =3D -1;
>  			pi_data.wakeup_intr =3D entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR;
>  			pi_data.is_running =3D false;
> +
> +			if (amd_iommu_gappi) {
> +				pi_data.apicid =3D kvm_cpu_get_apicid(svm->gappi_cpu);
> +				if (list_empty(&svm->ir_list)) {
> +					avic_add_vcpu_to_gappi_wakeup_list(svm, svm->gappi_cpu);
> +					is_vcpu_waiting =3D true;
> +				}
> +			}
>  		}
> =20
>  		ret =3D irq_set_vcpu_affinity(host_irq, &pi_data);
>  		if (ret)
> -			return ret;
> +			goto gappi_err_out;

[Severity: Low]
Is it safe to mix goto-based error handling in a function that uses guard()?

Earlier in avic_pi_update_irte(),
guard(raw_spinlock_irqsave)(&svm->ir_list_lock) is used. According to
include/linux/cleanup.h, mixing goto with guard() in the same function crea=
tes
confusing ownership semantics and violates the subsystem's cleanup rules.

> =20
>  		/*
>  		 * Revert to legacy mode if the IOMMU didn't provide metadata
> @@ -968,12 +1028,17 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *i=
rqfd, struct kvm *kvm,
>  		 */
>  		if (WARN_ON_ONCE(!pi_data.ir_data)) {
>  			irq_set_vcpu_affinity(host_irq, NULL);
> -			return -EIO;
> +			ret =3D -EIO;
> +			goto gappi_err_out;
>  		}
> =20
>  		irqfd->irq_bypass_data =3D pi_data.ir_data;
>  		list_add(&irqfd->vcpu_list, &svm->ir_list);
>  		return 0;
> +gappi_err_out:
> +		if (is_vcpu_waiting)
> +			avic_remove_vcpu_from_gappi_wakeup_list(svm, svm->gappi_cpu);
> +		return ret;
>  	}
>  	return irq_set_vcpu_affinity(host_irq, NULL);
>  }
[ ... ]
> @@ -1300,6 +1382,21 @@ static bool __init avic_want_avic_enabled(void)
>  	return true;
>  }
> =20
> +static void avic_gappi_wakeup_handler(void)
> +{
> +	int cpu =3D smp_processor_id();
> +	struct list_head *vcpu_wakeup_list =3D &per_cpu(gappi_vcpu_wakeup_list,=
 cpu);
> +	raw_spinlock_t *spinlock =3D &per_cpu(gappi_vcpu_wakeup_list_lock, cpu);
> +	struct vcpu_svm *svm;
> +
> +	raw_spin_lock(spinlock);
> +	list_for_each_entry(svm, vcpu_wakeup_list, gappi_vcpu_wakeup_list) {
> +		if (kvm_lapic_find_highest_irr(&svm->vcpu) >=3D 0)
> +			kvm_vcpu_wake_up(&svm->vcpu);
> +	}
> +	raw_spin_unlock(spinlock);
> +}

[Severity: High]
Does this lock ordering create an ABBA deadlock?

When a vCPU is preempted, the scheduler executes kvm_sched_out() while hold=
ing
the runqueue lock (rq_lock). KVM then calls __avic_vcpu_put(), which in turn
calls avic_add_vcpu_to_gappi_wakeup_list(). This acquires the
gappi_vcpu_wakeup_list_lock, establishing an ordering of rq_lock ->
gappi_vcpu_wakeup_list_lock.

Conversely, when a GAPPI interrupt arrives, avic_gappi_wakeup_handler()
acquires gappi_vcpu_wakeup_list_lock and calls kvm_vcpu_wake_up(). The wake=
up
path then attempts to acquire the target task's runqueue lock, establishing
the reverse order: gappi_vcpu_wakeup_list_lock -> rq_lock.

This inversion will likely trigger a lockdep ABBA deadlock splat and violat=
es
the scheduler locking hierarchy.

[ ... ]
> @@ -1308,12 +1405,18 @@ static bool __init avic_want_avic_enabled(void)
>   */
>  bool __init avic_hardware_setup(void)
>  {
> +	int cpu;
>  	avic =3D avic_want_avic_enabled();
>  	if (!avic)
>  		return false;
> =20
>  	pr_info("AVIC enabled\n");
> =20
> +	for_each_possible_cpu(cpu) {
> +		INIT_LIST_HEAD(&per_cpu(gappi_vcpu_wakeup_list, cpu));
> +		raw_spin_lock_init(&per_cpu(gappi_vcpu_wakeup_list_lock, cpu));
> +	}

[Severity: High]
Are blocked vCPUs left stranded if their physical CPU is taken offline?

The per-CPU wakeup lists queue blocked vCPUs on the physical CPU they last =
ran
on. However, there are no CPU hotplug callbacks registered. If a physical C=
PU
is taken offline, the IOMMU hardware will not deliver GAPPI interrupts for
that offlined CPU's APIC ID.

Since there is no mechanism to migrate the stranded vCPUs to an online CPU's
wakeup list during the offline event, these vCPUs could hang indefinitely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713105033.1540=
5-1-sarunkod@amd.com?part=3D5
