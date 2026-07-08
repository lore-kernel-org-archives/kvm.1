Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6CE3EDE61
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503447; cv=none; b=MUD17EdscgfhnoQCFnCZOLk0ktypTVZNbHn3060oJZE2jqRF2DeJsTDuRYZ0lvj6cZjq5tt/6hyEjyq5TA+7tuUhpLzzba61xGagY6eS5x9KqeJcpVrUssQDcLB8oL5i1d0f3KQZQbLeziOCN8O5s4OqZyKOi0489gJmcIPbjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503447; c=relaxed/simple;
	bh=srZY2Gw60TRvDIp5AaM5SfmSvG4r6XLOqj/kKxV92fM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RV/mG/OXpHDtVdq7jciC82UdKKspXYgj8sCGWZVPeAHNQYOXiVxpIThcGCgVcvAQYGhcyZw4jnTF19CpY1xb4Ly1GMHdoHCOskNGsyxi1U0v6HNYUdxCwYDmoClWTT4jkT3xs5bvlW/TOmalVlzC5Ig4U9xURvwEXMHDfqCyHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/m8QbQP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/m8QbQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9CD1F000E9;
	Wed,  8 Jul 2026 09:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783503435;
	bh=df8IOshjzVLsQYuQET6xtg0Ft3m8yIKPmq2z5X1iAZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T/m8QbQP/ugpiz0OfW71sXZRnuX7cjn7T20BmnvOhfAegvV07vtTZ2cTZmpspHGWx
	 BQEWm++A4CXuWYbxZWp8Qh1FuSOTNSCzrE13m7YhIpOqVDYahWRiXcopg6JKr0UdAK
	 MiEBEYJMHJWIDkHRxMY7Ts+b6vy8wtiJW98JDCsIUROw9zvU/bftklkp1KwZDi94SG
	 9MfjosekHHXDmW7aBx4z/CNa9HodHvw+UK8GI/DCOB1w8zmi7EZpOPeR36BXY6FHXh
	 /wlM7btUb54nu+wcVpbb/E0Seos+jnEKtoTnud+KW/Q27cZdXr9pKbvxg8aeMt+ZwH
	 3sm7kprQnOChQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/5] kvm/svm: Update the per-CPU wakeup-list
 during vCPU load and unload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260708091408.12106-5-sarunkod@amd.com>
References: <20260708091408.12106-1-sarunkod@amd.com>
 <20260708091408.12106-5-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:37:15 +0000
Message-Id: <20260708093715.9B9CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Missing CPU hotplug teardown logic for `gappi_vcpu_wakeup_list` ca=
uses indefinitely stalled vCPUs when a physical CPU is taken offline.
- [High] Host-userspace reachable `WARN_ON(cpu < 0)` via uninitialized `svm=
->gappi_cpu` when setting up posted interrupts for AVIC-inhibited VMs.
- [High] Unconditional call to `avic_remove_vcpu_from_gappi_wakeup_list()` =
triggers a spurious `WARN_ON` when GAPPI is disabled.
- [Medium] Mixing `goto`-based error handling with `guard()` scope-based cl=
eanup in `avic_pi_update_irte()` violates subsystem guidelines.
--

--- Patch [4]: [RFC PATCH v2 4/5] kvm/svm: Update the per-CPU wakeup-list d=
uring vCPU load and unload ---
commit 943f44c8b99a66a1765989cd046e31b1a7a04469
Author: Sairaj Kodilkar <sarunkod@amd.com>

kvm/svm: Update the per-CPU wakeup-list during vCPU load and unload

When a vCPU is unloaded from a physical CPU enqueue it on that CPU's
GAPPI wakeup list. Remove the vCPU from the wakeup list when it is loaded
on to a CPU again.

Also enqueue from avic_pi_update_irte() when vCPU is not running and
ir_list is still empty.  This handles the condition where vCPU load skips
the per-CPU wakeup-list update when ir_list is empty.

The GAPPI wakeup handler walks this CPU's list and wakes vCPUs that still
have a pending IRR.  Install it with kvm_set_posted_intr_wakeup_handler()
so deliveries on POSTED_INTR_WAKEUP_VECTOR invoke it.

> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index e7a4c0e90e7a7..8185841d9b816 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c

[ ... ]

> @@ -899,13 +938,18 @@ static void svm_ir_list_del(struct kvm_kernel_irqfd=
 *irqfd)
>  {
>  	struct kvm_vcpu *vcpu =3D irqfd->irq_bypass_vcpu;
>  	unsigned long flags;
> +	struct vcpu_svm *svm;
> =20
>  	if (!vcpu)
>  		return;
> =20
> -	raw_spin_lock_irqsave(&to_svm(vcpu)->ir_list_lock, flags);
> +	svm =3D to_svm(vcpu);
> +
> +	raw_spin_lock_irqsave(&svm->ir_list_lock, flags);
>  	list_del(&irqfd->vcpu_list);
> -	raw_spin_unlock_irqrestore(&to_svm(vcpu)->ir_list_lock, flags);
> +	if (list_empty(&svm->ir_list))
> +		avic_remove_vcpu_from_gappi_wakeup_list(svm, svm->gappi_cpu);

[Severity: High]
If GAPPI is globally disabled (amd_iommu_gappi =3D=3D false), svm->gappi_cpu
remains at its initial value of -1 for the vCPU's entire lifetime.

When the last irqfd is deleted in svm_ir_list_del(), this calls
avic_remove_vcpu_from_gappi_wakeup_list() unconditionally without checking
if GAPPI is actually enabled.

Since cpu is -1, does this trigger the WARN_ON(cpu < 0) when host userspace
detaches an irqfd or shuts down a VM with assigned devices?

> +	raw_spin_unlock_irqrestore(&svm->ir_list_lock, flags);
>  }
> =20
>  int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,

[ ... ]

> @@ -958,16 +1003,18 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *i=
rqfd, struct kvm *kvm,
>  		} else {
>  			posted_intr =3D !!(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
>  			pi_data.flags =3D posted_intr << AMD_IOMMU_FLAG_POSTED_INTR_SHIFT;
> -			/* GAPPI is disabled at this point (amd_iommu_gappi is
> -			 * enabled in the following patches) hence keep the
> -			 * apicid as 0.
> -			 */
> -			pi_data.apicid =3D 0;
> +			if (amd_iommu_gappi) {
> +				pi_data.apicid =3D kvm_cpu_get_apicid(svm->gappi_cpu);
> +				if (list_empty(&svm->ir_list)) {
> +					avic_add_vcpu_to_gappi_wakeup_list(svm, svm->gappi_cpu);
> +					is_vcpu_waiting =3D true;
> +				}
> +			}
>  		}

[Severity: High]
svm->gappi_cpu is initialized to -1. If AVIC is disabled or inhibited for
the VM, kvm_vcpu_apicv_active() is false and avic_vcpu_load() is never
called, leaving svm->gappi_cpu as -1.

When userspace configures an IRQFD and the global amd_iommu_gappi flag is
true, this passes -1 to avic_add_vcpu_to_gappi_wakeup_list().

Could this trigger the host-userspace reachable WARN_ON(cpu < 0) in
avic_add_vcpu_to_gappi_wakeup_list()?

> =20
>  		ret =3D irq_set_vcpu_affinity(host_irq, &pi_data);
>  		if (ret)
> -			return ret;
> +			goto gappi_err_out;

[Severity: Medium]
This introduces goto-based error handling in avic_pi_update_irte(), which
already uses guard(raw_spinlock_irqsave)(&svm->ir_list_lock) earlier in
the function.

Does mixing goto-based cleanup labels and guard() declarations violate the
subsystem guidelines for cleanup function compatibility?

> =20
>  		/*
>  		 * Revert to legacy mode if the IOMMU didn't provide metadata

[ ... ]

> @@ -1310,6 +1376,21 @@ static bool __init avic_want_avic_enabled(void)
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
> +

[Severity: High]
The per-CPU wakeup list is processed here in avic_gappi_wakeup_handler(),
but this handler will never run for an offline CPU.

If a physical CPU is hot-unplugged, the IOMMU's GAPPI hardware doorbell
interrupts sent to that CPU are dropped.

Since there is no CPU hotplug teardown logic registered (e.g., via
cpuhp_setup_state() in avic_hardware_setup()) to drain the list or migrate
the vCPUs to an online CPU, will any vCPUs left on its list miss their
wakeup events and stall indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708091408.1210=
6-1-sarunkod@amd.com?part=3D4
