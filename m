Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8787383329
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352244; cv=none; b=SQwBIbZ20SftrAuwxQo3ILERp1KwAIgywV81tA4b2uONLX0P01LVogGSlhnuDUu5JInezYqpUCO8N6TOAs4zyakVv78KvCnw1ESzJFnN1rJGMOAK08pCi4+M0O38+84bSRqva1Xs0jW/q1agaCLni99uu6Vp6qUFpsoggoPO3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352244; c=relaxed/simple;
	bh=Y3Mm/trMCYCte5v5e5OyesdqSDN8lT4JiWBw2yRtY8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S5snjcC4V/DuFUuucHl/ltYABd3V8Zh+WEAsKpIGCWH9QHzESeVKcwAYPuHdapGF89q89sJPE939PPc+i+E8WNRPA+K9PumdphFeWB4L8TH2SmXQQOZzsrXXJz6k5UgfqfPQR99DpgmmSEf+JEEi9W1+GnCp8pI86tnOJFW6A/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEAt36R2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEAt36R2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C701F000E9;
	Thu, 25 Jun 2026 01:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782352243;
	bh=O6jCLqrB4QvNh26QjfQzkrEeueqBNau9snZDaNM5Pg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IEAt36R21W6xbnXuPDYuQ30RVMQKRRlCxBrIS4SI6JV+GrZopd/K38JjAaX3nMJAO
	 jIvb/dLKChYOqNDFWeCNp683Gvum/8dh0+NMGl3CDyJV2/ZrV5zDkaYsEiy2qhiVDd
	 yOTz5NVWNReuQxyRLdjgvuQB/cxF9WBxy4ImohxrEeRvrFIngRI71/Ex0gpGwrov+o
	 TbQJaYbHcvcPOHMrXAtPf1nOTpHmDT4MoPQF7rJpWfbY5jEHNDFk0G0/OeDZ7Wj0TV
	 3EwLzv7D2DqiHQNPv1WsKL169vCnpu9DrLyQeW4Xm16W7lB0AM62AL1sewD4RsM1d9
	 y6yp4it3FGz3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: RISC-V: Add CPU PM notifier for non-retention idle
 states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260624-kvm-cpu-pm-v1-1-52088e127a55@sifive.com>
References: <20260624-kvm-cpu-pm-v1-1-52088e127a55@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 01:50:42 +0000
Message-Id: <20260625015043.26C701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] The `SYSTEM_SUSPEND` check in the CPU PM notifier incorrectly =
skips CSR save/restore during suspend-to-idle (s2idle).
- [Critical] CPU PM notifier fails to clear KVM's vCPU cache, leading to gu=
est context loss and a potential sandbox escape.
- [High] Missing restoration of `CSR_HIE` (Hypervisor Interrupt Enable) for=
 Guest External Interrupts (`IRQ_S_GEXT`) on CPU PM exit.
- [High] SBI NACL (Nested Acceleration) shared memory configuration is not =
restored on CPU PM exit.
- [High] The KVM CPU PM notifier fails to handle `CPU_PM_ENTER_FAILED`, lea=
ving hypervisor CSRs permanently disabled if a suspend transition aborts.
- [Medium] The PM notifier may unconditionally run and use uninitialized AI=
A state, writing `~0UL` to `CSR_HGEIE` if KVM hardware virtualization is no=
t yet fully enabled.
--

commit 107ddca84d721ec26cecb9bff7a0c2d5722c8a92
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: KVM: RISC-V: Add CPU PM notifier for non-retention idle states

This patch registers a CPU_PM notifier to restore hypervisor CSR content
during CPU non-retention idle states. It handles state saving and restoring
when a CPU enters deep idle states that power off the CPU domain.

> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index bafb009c5ce55..82812493ac684 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
[ ... ]
> @@ -532,50 +532,61 @@ static void aia_hgei_exit(void)
[ ... ]
> -	raw_spin_lock_irqsave(&hgctrl->lock, flags);
> -	if (!hgctrl->free_bitmap_initialized) {
> -		hgctrl->free_bitmap =3D (hgctrl->nr_hgei) ? GENMASK_ULL(hgctrl->nr_hge=
i, 1) : 0;
> -		hgctrl->free_bitmap_initialized =3D true;
> +		raw_spin_lock_irqsave(&hgctrl->lock, flags);
> +		if (!hgctrl->free_bitmap_initialized) {
> +			hgctrl->free_bitmap =3D (hgctrl->nr_hgei) ?
> +					      GENMASK_ULL(hgctrl->nr_hgei, 1) :
> +					      0;
> +			hgctrl->free_bitmap_initialized =3D true;
> +		}
> +		raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
> +	} else {
> +		raw_spin_lock_irqsave(&hgctrl->lock, flags);
> +		csr_write(CSR_HGEIE, ~hgctrl->free_bitmap);
> +		raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
>  	}

[Severity: Medium]
Since cpu_pm_register_notifier() is called in riscv_kvm_init() before
kvm_init() has called hardware_enable_all(), can this PM notifier
unconditionally run before KVM hardware virtualization is fully enabled?

If a CPU enters and exits idle in this window, kvm_riscv_aia_enable(false)
writes ~hgctrl->free_bitmap to CSR_HGEIE. Because free_bitmap is
uninitialized (0), this writes ~0UL, which could lead to unexpected behavio=
r.

[ ... ]
> -	/* Enable per-CPU SGEI interrupt */
> -	enable_percpu_irq(hgei_parent_irq,
> -			  irq_get_trigger_type(hgei_parent_irq));
> -	csr_set(CSR_HIE, BIT(IRQ_S_GEXT));
> +	if (full_cleanup) {
> +		/* Enable per-CPU SGEI interrupt */
> +		enable_percpu_irq(hgei_parent_irq,
> +				  irq_get_trigger_type(hgei_parent_irq));
> +		csr_set(CSR_HIE, BIT(IRQ_S_GEXT));
> +	}

[Severity: High]
Does this prevent the restoration of CSR_HIE for guest external interrupts =
on
CPU PM exit?

When a CPU enters a non-retention deep idle state, hypervisor CSRs lose the=
ir
state. On PM exit, kvm_riscv_aia_enable(false) is invoked. However, because
full_cleanup is false, the CSR_HIE bit is never re-enabled.

This seems like it would cause the host CPU to permanently stop receiving
supervisor guest external interrupts, breaking interrupt delivery to VMs.

[ ... ]
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 0924c75100a2d..41ef91ea39218 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
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

[Severity: Critical]
Does this check incorrectly skip CSR save/restore during suspend-to-idle
(s2idle)?

During s2idle, CPUs are pushed into the idle loop instead of being hotplugg=
ed
offline, and syscore suspend callbacks do not execute. When the last CPU
freezes its tick, system_state is set to SYSTEM_SUSPEND. When CPUs
subsequently enter deep idle, KVM's notifier skips the state save due to th=
is
check, completely destroying the hypervisor state on resume.

> +
> +	switch (cmd) {
> +	case CPU_PM_EXIT:
> +		kvm_riscv_csr_enable();
> +		kvm_riscv_aia_enable(false);
> +		return NOTIFY_OK;

[Severity: High]
Does this omit the restoration of SBI nested acceleration (NACL) shared mem=
ory
configuration?

Firmware does not preserve extension-specific shared memory configuration a=
cross
non-retentive CPU suspend states. The PM exit handler restores base CSRs and
AIA, but lacks a call to kvm_riscv_nacl_enable(). This seems like it would
cause the NACL shmem mapping to be permanently lost on the CPU, breaking ne=
sted
virtualization acceleration.

[Severity: Critical]
Does the CPU PM notifier also need to clear KVM's vCPU cache to prevent gue=
st
context loss?

kvm_arch_vcpu_load() in arch/riscv/kvm/vcpu.c skips writing guest CSRs and
HGATP if vcpu matches the former vcpu and last_exit_cpu matches the current
cpu:

if (vcpu !=3D __this_cpu_read(kvm_former_vcpu))
    __this_cpu_write(kvm_former_vcpu, vcpu);
else if (vcpu->arch.last_exit_cpu =3D=3D cpu && !vcpu->arch.csr_dirty)
    goto csr_restore_done;

A non-retention idle state destroys the hardware CSR context (resetting them
to 0). Because the PM notifier does not clear kvm_former_vcpu, a VCPU
rescheduled on the same CPU after wakeup will hit this fast-path and execute
with zeroed hardware CSRs.

Entering guest mode with HGATP=3D0 configures G-stage translation to bare m=
ode,
mapping guest physical addresses directly to host physical memory. Can this
lead to a trivial sandbox escape?

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

[Severity: High]
Does this switch statement fail to handle CPU_PM_ENTER_FAILED?

If a subsequent notifier in the chain fails after KVM disables its hypervis=
or
CSRs on CPU_PM_ENTER, the PM subsystem aborts the suspend sequence and
broadcasts CPU_PM_ENTER_FAILED. Because KVM's notifier lacks a case for it,
it ignores this event.

Will this leave KVM's hypervisor CSRs permanently disabled until a full off=
line
and online cycle?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624-kvm-cpu-pm=
-v1-1-52088e127a55@sifive.com?part=3D1
