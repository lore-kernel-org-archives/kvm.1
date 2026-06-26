Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDE3377EC2
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473121; cv=none; b=WzmEQ5qRdQm3wqLjms1Y4kC/ufZ1C7tIoamZiwnbQ9zc6f1AhEAIe4mjiL9OtCruzW1aQ5kEuMs47harRzqDlTjcX1srD+Y98/GaEExpz56yz59HCmktXoIcuvEWraa3wRnjEexLM+ezRBKYQ9WDj64GoNeMNYGe8frai9oXVGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473121; c=relaxed/simple;
	bh=6jnG4jp4ywQBAqZpnwI+HCPLkio+a9IH6ijqjUSpbII=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pS62Z3b+lYW9B55ue8NSF/Yara7grc0KlU53UEHBI5R4XqFHS5Z6t0oTHN4GdrSTCigv5dnbCjw+MJmvu6GdNis5kCKlZzvhePkUgHWlBJupSR+5EqZ+xNOX/1dECtYM14G9n6RCOHHSTrVbOoBLwsFuS1WH6M7VrlOFRvt2G2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBtqYi2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBtqYi2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A59C1F000E9;
	Fri, 26 Jun 2026 11:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782473119;
	bh=WykOcXwRdwVqT/mdqbs3/fRRFh31+n0NNEMppDgDAhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NBtqYi2cfKuGvUmckxFZQQJ1AUr5BeU0Je8aanQx2Tz6qHShZJpYzB9ubRfPw9Bvw
	 WmN/Pd/GNYAoqDHrdk0cI/Y7lEWwmlNaJO35iRyMkeej2ovmQMM8fP1wm+OVOpQN5k
	 F8/BlpISG7HeM+zjO1CnAclLUgEgFLnhjXWOh6VD20Z8TDA9cjqMzpJHPkn8OjeACY
	 sMCp9UlOopGIulTC+ysS/ckTZMpU+1b1pNzwIXbAEoLAPdc/PPkwNCS9FCDWFni6Qz
	 fXLnA/Yf1euJ6v3zanYA89MDqRust/Y2vbCCWuS+/bqzOu3Jk8zGXVjwcKVaVTi1Ll
	 DUzF4rOnofLuQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/5] kvm/svm: Update the per-CPU wakeup-list during
 vCPU load and unload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626105906.14577-5-sarunkod@amd.com>
References: <20260626105906.14577-1-sarunkod@amd.com>
 <20260626105906.14577-5-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 11:25:18 +0000
Message-Id: <20260626112519.6A59C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] `avic_remove_vcpu_from_gappi_wakeup_list` and `avic_add_vcpu_to_ga=
ppi_wakeup_list` acquire a raw spinlock without disabling interrupts, leadi=
ng to a hard deadlock with the GAPPI IPI hardirq handler.
- [High] Uninitialized `svm->gappi_cpu` (-1) is unconditionally passed to `=
kvm_cpu_get_apicid()` and `avic_add_vcpu_to_gappi_wakeup_list()`, causing a=
n out-of-bounds array read and a userspace-triggerable `WARN_ON`.
- [High] The GAPPI wakeup handler is registered with the core kernel but ne=
ver unregistered, leading to a dangling pointer if the KVM module is unload=
ed.
- [Medium] The per-CPU GAPPI wakeup lists lack CPU hotplug support, resulti=
ng in permanently lost device interrupts and hanging vCPUs if a CPU is offl=
ined.
--

commit 3af48ba2bd8326c04b2aa47ac47a9f53e0cd61a3
Author: Sairaj Kodilkar <sarunkod@amd.com>

kvm/svm: Update the per-CPU wakeup-list during vCPU load and unload

When a vCPU is unloaded from a physical CPU enqueue it on that CPU's
GAPPI wakeup list. Remove the vCPU from the wakeup list when it is loaded
on to a CPU again.

> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index e7a4c0e90e7a7..d238f65a8172b 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -889,6 +892,44 @@ int avic_init_vcpu(struct vcpu_svm *svm)
>  	return ret;
>  }
> =20
> +static void avic_add_vcpu_to_gappi_wakeup_list(struct vcpu_svm *svm, int=
 cpu)
> +{
> +	struct list_head *wakeup_list;
> +	raw_spinlock_t *spinlock;
> +
> +	if (WARN_ON(cpu < 0))
> +		return;
> +
> +	wakeup_list =3D &per_cpu(gappi_vcpu_wakeup_list, cpu);
> +	spinlock =3D &per_cpu(gappi_vcpu_wakeup_list_lock, cpu);
> +	raw_spin_lock(spinlock);
> +	if (list_empty(&svm->gappi_vcpu_wakeup_list))
> +		list_add_tail(&svm->gappi_vcpu_wakeup_list, wakeup_list);
> +	raw_spin_unlock(spinlock);
> +}
> +
> +static void avic_remove_vcpu_from_gappi_wakeup_list(struct vcpu_svm *svm=
, int cpu)
> +{
> +	raw_spinlock_t *spinlock;
> +
> +	if (WARN_ON(cpu < 0))
> +		return;
> +
> +	spinlock =3D &per_cpu(gappi_vcpu_wakeup_list_lock, cpu);
> +	raw_spin_lock(spinlock);
> +	if (!list_empty(&svm->gappi_vcpu_wakeup_list))
> +		list_del_init(&svm->gappi_vcpu_wakeup_list);
> +	raw_spin_unlock(spinlock);
> +}

[Severity: High]
Can this cause a hard deadlock with the GAPPI IPI hardirq handler?

When a user process destroys a VM, avic_destroy_vcpu() is called from
svm_vcpu_free() in normal thread context with interrupts enabled. If the
POSTED_INTR_WAKEUP_VECTOR IPI fires on the same CPU while this thread holds
the gappi_vcpu_wakeup_list_lock non-recursive raw spinlock, the interrupt
handler will spin forever attempting to acquire it.

Should these functions use raw_spin_lock_irqsave() to disable interrupts
during lock acquisition?

[ ... ]

> @@ -958,16 +1005,18 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *i=
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
Is it possible for svm->gappi_cpu to still be -1 here?

If userspace creates a VM but inhibits AVIC (for example, via an invalid
APIC ID), avic_vcpu_load() bails out early leaving svm->gappi_cpu as -1.
If userspace later assigns a device interrupt via KVM_IRQFD,
avic_pi_update_irte() will pass -1 to kvm_cpu_get_apicid().

This triggers a negative index array read yielding a garbage APIC ID, and
also hits the WARN_ON(cpu < 0) inside avic_add_vcpu_to_gappi_wakeup_list().

[ ... ]

> @@ -1353,6 +1436,7 @@ bool __init avic_hardware_setup(void)
>  		enable_ipiv =3D false;
> =20
>  	amd_iommu_register_ga_log_notifier(&avic_ga_log_notifier);
> +	kvm_set_posted_intr_wakeup_handler(&avic_gappi_wakeup_handler);
> =20
>  	return true;
>  }

[Severity: Medium]
Does the per-CPU GAPPI wakeup list need CPU hotplug coordination?

If a physical CPU is taken offline while a VM is running, any blocked
vCPUs queued on that offlined CPU's gappi_vcpu_wakeup_list might permanently
miss their GAPPI wakeups. Without a hotplug state notifier to migrate these
vCPUs, will they hang indefinitely?

[Severity: High]
Is there a missing module unload teardown for the wakeup handler?

This registers avic_gappi_wakeup_handler with the core kernel, but it
doesn't seem to be unregistered (via kvm_set_posted_intr_wakeup_handler(NUL=
L))
during module teardown in avic_hardware_unsetup(). If the kvm-amd module
is unloaded, could a subsequent POSTED_INTR_WAKEUP_VECTOR jump to unmapped
memory and cause a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626105906.1457=
7-1-sarunkod@amd.com?part=3D4
