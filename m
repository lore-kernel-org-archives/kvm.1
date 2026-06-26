Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92BF3EAC71
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467857; cv=none; b=U8afX6gRT2NZF7wxJZd/Or7JzbL/jZKxU341b5I21y/l69hLKCdxDs9+EVk+n44JwhQ/TIT7PY2dhsADs7gIixph3y1GeLixFS/kS+3Dmdr8xvQBxEiDRRLVV9HNyOgBnD/Fx8bmSGsBHh3JAbXmBlxqLLxFIgW+g0j3ZfOQAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467857; c=relaxed/simple;
	bh=NT5VYH2rjth6+FQKiP2jZFOeTNWLoNkIx9U8kORPlYU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=feOeRauhvDwzCueUwldzNg9NU3iqBXS2RSDJN3+1zxYZdvJDFF6mCnHwqxEKwyPQqr32WknHkFMcJsJ769zxvR+df2P0lfNsdeyr/dKwf4yMRdHBwPSgbdU25IZPO/AjniHq+mm6+6WYPXMByAYiXDOp/B4cJNODCuWwICA1Jq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTl+S2YN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTl+S2YN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA0F1F00A3D;
	Fri, 26 Jun 2026 09:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782467855;
	bh=YrLrSBUR1TdNzCrLyLlgJ3VXB4MqHuvbj85lpY0jrh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mTl+S2YNARsg0Pgj2Op7psyp7/4RKNrNOUVyIm7fCzp9D3klZWr3e6mGjfvYbl+Nb
	 bd5tU4REEMzVIXr9WrZ9BlLyxNGJRLMO9HN/cWp4QD21QCHhcwoSRyNWmcHu9I2Otv
	 i/kcZA0ykk5ZBSrtweG3IT45gz0cDYwQaHRZjg9NfCwKUCkV2w69BNByT5A+3XUxhK
	 1mK2iQhbjMSDJjR+7ATkYb+4JaPspIdRpruDbnhIst7xglFlS2nXo7Fcd059GouoSL
	 XJovhiUeBsXFZs8FfdZxD1bu07NASHZClxN+q0vMcFCL4O22MbZToe/FSTQrWSekLo
	 4lAzIhfDuwaww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] KVM: RISC-V: Add CPU PM notifier for
 non-retention idle states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626-kvm-cpu-pm-v3-2-be051aafe9ba@sifive.com>
References: <20260626-kvm-cpu-pm-v3-0-be051aafe9ba@sifive.com>
 <20260626-kvm-cpu-pm-v3-2-be051aafe9ba@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 09:57:35 +0000
Message-Id: <20260626095735.7AA0F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditional enablement of KVM hypervisor CSRs and interrupts on =
PM exit, even when virtualization is dynamically disabled.
- [High] KVM hypervisor state is lost on the last CPU during suspend-to-idl=
e (s2idle) due to a flawed system_state check.
--

commit 797004f764f4fde4a694224f3bd1d8ea2f590bd2
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

KVM: RISC-V: Add CPU PM notifier for non-retention idle states

This patch registers a CPU_PM notifier to save and restore hypervisor CSRs
during CPU non-retention idle states. It skips processing during system-wide
suspend/resume operations to avoid conflicts with KVM's syscore handlers.

> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 350e4f097d6e8..b8461f1a569fa 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
[ ... ]
> @@ -70,10 +61,61 @@ void kvm_arch_disable_virtualization_cpu(void)
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
During suspend-to-idle (s2idle), KVM's syscore_suspend() is skipped. Instea=
d,
CPUs enter idle via cpuidle_enter_s2idle(), which calls tick_freeze() before
cpu_pm_enter().

When the last online CPU calls tick_freeze(), it sets system_state to
SYSTEM_SUSPEND. Next, the idle driver invokes cpu_pm_enter(), triggering
this KVM PM notifier.

Because system_state is now SYSTEM_SUSPEND, will the notifier abort here
and fail to save the KVM CSRs? Upon wakeup, the notifier would again abort
on CPU_PM_EXIT before tick_unfreeze() restores the system state.

Could this cause the last CPU entering s2idle to completely lose its KVM
state (e.g., CSR_HGEIE, CSR_HEDELEG)?

> +
> +	switch (cmd) {
> +	case CPU_PM_EXIT:
> +	case CPU_PM_ENTER_FAILED:
> +		kvm_riscv_csr_enable();
> +		kvm_riscv_aia_enable(false);

[Severity: High]
KVM dynamically manages hardware virtualization on a per-CPU basis, disabli=
ng
it when no VMs are running.

When a CPU wakes up from a non-retention idle state, will this
unconditionally re-enable hypervisor CSRs and external interrupts (like
setting CSR_HIE.IRQ_S_GEXT in kvm_riscv_aia_enable()), even if KVM currently
considers virtualization disabled on this CPU?

Does this bypass KVM's dynamic hardware management and leave active
virtualization features enabled on the host CPU unexpectedly?

> +		return NOTIFY_OK;
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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-kvm-cpu-pm=
-v3-0-be051aafe9ba@sifive.com?part=3D2
