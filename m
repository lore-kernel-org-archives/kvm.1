Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD793BED4A
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463556; cv=none; b=jv6J4uzNgcJK/n0IGHemD0iqNICt0CxPAiIMX+lwpenJAIJSjCiZ3RmNvwTHjWFh6WvMsAAlhYBNWjPo6ujRHWyyu5E5LipK9N+xIbZQcUm1bZgJhD5eCh3CwOksqH/hIaDxgXqZTrYbyqP17w2IlT+XDGV8gDcabXo20sP0Aas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463556; c=relaxed/simple;
	bh=Z/jWvKS2isE2i5O2K+5sf/P7tPDD6kEse9Ze3a6umhI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jU6dTY/as3Z3ix6DKv4gmdh9VSchGAJrKanSYhnLNBsD31wHowVYBKiVYARpL4z7b92+Z3UvoNN5RMka/j2YnXWdhJbAAuJhCbYf4yTywrgph/2C0d/zSoh3L9drY4rIhjwn/svcOpJAeJbcI7mo21k+0bQEUhphSqthoAZXbZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPBJtj6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPBJtj6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C2E1F000E9;
	Fri, 26 Jun 2026 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782463554;
	bh=b7ZE+EUznPcQuHw4xnSR9fDvJlXQO89IslIk94mQgIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lPBJtj6QuiUsEMzlfCfveX35m+OXaqshE2qN8xL9YuuP6SAPEsfM63Zz0P5qyqY3B
	 C4+W9qf7vCG3G5l92pHu4sRMKv471OfRQoY1k7B7LmdJMBnaDms1i8KHZ4RgLYobtl
	 9WflTspkDfgiyDJ5z4Rcy30baDq1eHmsjAtBNWh5988qQhmyJRuNhAwe522ezwsXyT
	 EAxygsdpxSe/KxXUaZB81zdRUd4pu9QEQWTtZqKZjZYhrgfkvKMA+/i3qTvJYa16Np
	 jP7y6+U5R/Faxdojol0oiIUMvUK+tfKjcURx5xwPUpKXAyG1Z7K/1T7cMYZsJBeGQw
	 eNNIZ6hzAFheA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: RISC-V: Add CPU PM notifier for
 non-retention idle states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626-kvm-cpu-pm-v2-2-478e5ef8dc9b@sifive.com>
References: <20260626-kvm-cpu-pm-v2-0-478e5ef8dc9b@sifive.com>
 <20260626-kvm-cpu-pm-v2-2-478e5ef8dc9b@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 08:45:53 +0000
Message-Id: <20260626084554.93C2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] IMSIC guest interrupt files (VS-files) are permanently lost du=
ring non-retentive idle.
- [High] Nested Acceleration (NACL) is permanently disabled after a CPU dee=
p idle cycle, and doubly disabled on CPU offline.
- [High] The CPU PM notifier unconditionally restores KVM hardware state on=
 idle exit and creates a dangerous race during module unload.
- [High] Aborted system suspend bypasses state restoration, causing silent =
KVM hardware state loss.
--

commit 7c6e618531e4da8059b75390623f67b52d8838ff
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

KVM: RISC-V: Add CPU PM notifier for non-retention idle states

This commit adds a CPU PM notifier to save and restore hypervisor CSRs
during non-retention idle states. It checks system_state to avoid conflicts
with KVM's existing syscore suspend/resume handlers.

> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index bafb009c5ce55..4cf351f91c643 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
[ ... ]
> @@ -609,42 +620,49 @@ void kvm_riscv_aia_disable(void)
> =20
>  	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSCOFPMF))
>  		csr_clear(CSR_HVIEN, BIT(IRQ_PMU_OVF));
> -	/* Disable per-CPU SGEI interrupt */
> -	csr_clear(CSR_HIE, BIT(IRQ_S_GEXT));
> -	disable_percpu_irq(hgei_parent_irq);
> =20
> -	csr_write(CSR_HVICTL, aia_hvictl_value(false));
> -
> -	raw_spin_lock_irqsave(&hgctrl->lock, flags);
> -
> -	for (i =3D 0; i <=3D hgctrl->nr_hgei; i++) {
> -		vcpu =3D hgctrl->owners[i];
> -		if (!vcpu)
> -			continue;
> +	if (full_cleanup) {
> +		/* Disable per-CPU SGEI interrupt */
> +		csr_clear(CSR_HIE, BIT(IRQ_S_GEXT));
> +		disable_percpu_irq(hgei_parent_irq);
> +	}
> =20
> -		/*
> -		 * We release hgctrl->lock before notifying IMSIC
> -		 * so that we don't have lock ordering issues.
> -		 */
> -		raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
> +	csr_write(CSR_HVICTL, aia_hvictl_value(false));
> =20
> -		/* Notify IMSIC */
> -		kvm_riscv_vcpu_aia_imsic_release(vcpu);
> +	if (full_cleanup) {
> +		raw_spin_lock_irqsave(&hgctrl->lock, flags);
> =20
> -		/*
> -		 * Wakeup VCPU if it was blocked so that it can
> -		 * run on other HARTs
> -		 */
> -		if (csr_read(CSR_HGEIE) & BIT(i)) {
> -			csr_clear(CSR_HGEIE, BIT(i));
> -			kvm_vcpu_kick(vcpu);
> +		for (i =3D 0; i <=3D hgctrl->nr_hgei; i++) {
> +			vcpu =3D hgctrl->owners[i];
> +			if (!vcpu)
> +				continue;
> +
> +			/*
> +			 * We release hgctrl->lock before notifying IMSIC
> +			 * so that we don't have lock ordering issues.
> +			 */
> +			raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
> +
> +			/* Notify IMSIC */
> +			kvm_riscv_vcpu_aia_imsic_release(vcpu);
> +
> +			/*
> +			 * Wakeup VCPU if it was blocked so that it can
> +			 * run on other HARTs
> +			 */
> +			if (csr_read(CSR_HGEIE) & BIT(i)) {
> +				csr_clear(CSR_HGEIE, BIT(i));
> +				kvm_vcpu_kick(vcpu);
> +			}
> +
> +			raw_spin_lock_irqsave(&hgctrl->lock, flags);
>  		}
> =20
> -		raw_spin_lock_irqsave(&hgctrl->lock, flags);
> +		raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
> +	} else {
> +		hgctrl->saved_value =3D csr_read(CSR_HGEIE);
>  	}

[Severity: Critical]
Does skipping kvm_riscv_vcpu_aia_imsic_release() on the CPU_PM_ENTER path
cause IMSIC guest interrupt files (VS-files) to be permanently lost?

Since KVM RISC-V AIA uses lazy release for VS-files, vCPUs can remain attac=
hed
to the hardware IMSIC even when preempted. When a CPU enters deep idle, the
IMSIC hardware powers off, wiping the VS-file state.

This else branch skips saving the active VS-files to software, which means =
the
state is destroyed by power loss and not recovered upon wake. This could ca=
use
running VMs to hang or drop devices.

> =20
> -	raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
> -
>  	put_cpu_ptr(&aia_hgei);
>  }
> =20
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 350e4f097d6e8..f397a93881dc5 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
[ ... ]
> @@ -33,14 +34,9 @@ long kvm_arch_dev_ioctl(struct file *filp,
>  	return -EINVAL;
>  }
> =20
> -int kvm_arch_enable_virtualization_cpu(void)
> +/* Initialize hypervisor CSRs - called during CPU online and non-retenti=
on idle resume */
> +static void kvm_riscv_csr_enable(void)
>  {
> -	int rc;
> -
> -	rc =3D kvm_riscv_nacl_enable();
> -	if (rc)
> -		return rc;
> -
>  	csr_write(CSR_HEDELEG, 0);
>  	csr_write(CSR_HIDELEG, 0);
> =20
> @@ -48,16 +44,11 @@ int kvm_arch_enable_virtualization_cpu(void)
>  	csr_write(CSR_HCOUNTEREN, 0x02);
> =20
>  	csr_write(CSR_HVIP, 0);
> -
> -	kvm_riscv_aia_enable();
> -
> -	return 0;
>  }

[Severity: High]
Should this function call kvm_riscv_nacl_enable() to pair with the disable
call in kvm_riscv_csr_disable()?

Without it, the Nested Acceleration (NACL) shared memory feature is permane=
ntly
broken on a CPU once it enters deep idle, leading to silent failures or sta=
te
corruption for nested virtualization upon wake-up.

> =20
> -void kvm_arch_disable_virtualization_cpu(void)
> +/* Clear hypervisor CSRs - called during CPU offline and non-retention i=
dle entry */
> +static void kvm_riscv_csr_disable(void)
>  {
> -	kvm_riscv_aia_disable();
> -
>  	/*
>  	 * After clearing the hideleg CSR, the host kernel will receive
>  	 * spurious interrupts if hvip CSR has pending interrupts and the
> @@ -74,6 +65,59 @@ void kvm_arch_disable_virtualization_cpu(void)
>  	kvm_riscv_nacl_disable();
>  }

[Severity: High]
Does leaving kvm_riscv_nacl_disable() inside this refactored function cause
unintended side effects?

Because kvm_riscv_csr_disable() is now called by the CPU_PM_ENTER path, NACL
is explicitly torn down on every deep idle entry. Additionally, it causes a
double-disable of NACL during CPU offline operations since
kvm_arch_disable_virtualization_cpu() calls kvm_riscv_nacl_disable()
immediately after this function.

[ ... ]
> +static int kvm_riscv_cpu_pm_notifier(struct notifier_block *self, unsign=
ed long cmd, void *v)
> +{
> +	/*
> +	 * To avoid redundant disable/enable operations (since KVM's
> +	 * syscore ops will handle the state during system suspend),
> +	 * ignore CPU_PM events when a system suspend/resume is in
> +	 * progress.
> +	 */
> +	if (system_state =3D=3D SYSTEM_SUSPEND)
> +		return NOTIFY_DONE;

[Severity: High]
Could this check cause silent KVM hardware state loss if the suspend cycle
is aborted?

The kernel enters SYSTEM_SUSPEND early in the suspend process. If a CPU ent=
ers
deep idle while devices are still suspending, this notifier ignores it, and
the non-retentive idle zeroes out KVM CSRs.

If device suspend fails, the system aborts the suspend cycle and resumes to
SYSTEM_RUNNING without ever reaching KVM's syscore suspend/resume hooks. The
CPU wakes up with lost KVM state, and VMs resume execution with missing
interrupts and CSR configurations.

> +
> +	switch (cmd) {
> +	case CPU_PM_EXIT:
> +	case CPU_PM_ENTER_FAILED:
> +		kvm_riscv_csr_enable();
> +		kvm_riscv_aia_enable(false);
> +		return NOTIFY_OK;

[Severity: High]
Does this unconditionally restore hypervisor CSRs regardless of whether KVM
hardware virtualization is actually enabled on the CPU?

Host CPUs might run with active hypervisor CSRs (like IRQ_S_GEXT in CSR_HIE
enabled) even when KVM has no active VMs or is actively being unloaded. This
can lead to kernel panics if a spurious interrupt hits the hypervisor while
KVM is not meant to handle it.

> +	case CPU_PM_ENTER:
> +		kvm_riscv_aia_disable(false);
> +		kvm_riscv_csr_disable();
> +		return NOTIFY_OK;
> +	default:
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
[ ... ]
> @@ -192,6 +250,10 @@ static void __exit riscv_kvm_exit(void)
>  {
>  	kvm_exit();
> =20
> +	/* Unregister CPU PM notifier */
> +	if (IS_ENABLED(CONFIG_CPU_PM))
> +		cpu_pm_unregister_notifier(&kvm_riscv_cpu_pm_nb);
> +
>  	kvm_riscv_teardown();
>  }
>  module_exit(riscv_kvm_exit);

[Severity: High]
Is there a race condition here since the CPU PM notifier is unregistered af=
ter
kvm_exit()?

During riscv_kvm_exit(), kvm_exit() disables hardware virtualization. Howev=
er,
if a CPU enters and exits deep idle within this teardown window before the
notifier is unregistered, the PM notifier will spuriously reactivate hyperv=
isor
CSRs just before the KVM module is removed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-kvm-cpu-pm=
-v2-0-478e5ef8dc9b@sifive.com?part=3D2
