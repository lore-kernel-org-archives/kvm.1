Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5732B10D
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812762; cv=none; b=D5czN+TRT+d+hyfsed/GlgzW3OUOVkm6LYBWmEphUXEvEUqyy6y0ZQTW/193eoIiFMW3/vRzS5DAfEsSBPQdVGF0hibuxfRtDA50jZW2Va6Qajo4/wldP4086ejVMqvQYqyhG/CYpAFJfaBZA4i4JEZmDBrAhpoNJylXqrGt0oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812762; c=relaxed/simple;
	bh=0qppeNMU+E+tKVsT6n59R1c00FEjAjv7dC71avcU2w8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NArcWOsTnPj5d3LSCknTM88VenhFeRwWyHIXS5ZKfMU/CEQFilwDXmw5wV8RHyAxktqYyI4VxcQkQ+wu8XFLg3ZoRetJwPBXX2lbeIU19JVIp8egkCPoIYnBZfg0mhoPwuViuR7yFn2MxTvQr5pNeab/u/i1NVYJ06QbNXtaZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mClekNhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mClekNhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93461F00A3A;
	Tue,  4 Aug 2026 03:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785812761;
	bh=WAZGJ3kKHQJth5YC5wm3va22If7gpHitIhzZb16jRds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mClekNhyoJDhanvr+ciBdugR8HUWWiajK0MsnXcr/TwODIoQBi50lxFzSb20A0kCw
	 6XDeayYKviwbRvm+uqVbTFTSakUuFsMLEzi2CYWfvs3B/71W2EnSkRTZ3d7npEOYV1
	 xYCMpRNYJ3Auecc29/aS+nFdm9++tSg/bLErtKzBdroJ69De/OIHvIK7qYxGsDrfXB
	 TxqNsD5nSAEk4m1UIp3ZC5N/LatPa/dM5uGodYu4GIYDvtTA0Vi4AJEDcTXw69Ae5V
	 NpQgrjZTChCv2zDm9ctkd4W4LdRDwVvvn/UCXJ7m9eFx8lENNP0mIrCdM0f5zyTKMn
	 9+xLqNORPZJsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] RISC-V: KVM: Add kvm-riscv.wfi_trap_policy to
 control VS-mode WFI trapping
Reply-To: sashiko-reviews@lists.linux.dev
To: Yuhang.Chen <yhchen312@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804024707.2400404-1-yhchen312@gmail.com>
References: <20260804024707.2400404-1-yhchen312@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 03:06:00 +0000
Message-Id: <20260804030600.C93461F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The dynamic WFI trap policy check is performed only in `kvm_arch_v=
cpu_load()`, leading to a TOCTOU race that causes CPU starvation for newly =
awakened tasks.
- [Low] Using `early_param` in a tristate KVM module breaks the build when =
KVM is compiled as a loadable module (`CONFIG_KVM=3Dm`).
--

--- Patch [1]: [PATCH v2] RISC-V: KVM: Add kvm-riscv.wfi_trap_policy to con=
trol VS-mode WFI trapping ---
commit 74512223938eb34f8681ae4dfb342e0d3e2fc417
Author: Yuhang.Chen <yhchen312@gmail.com>
Subject: RISC-V: KVM: Add kvm-riscv.wfi_trap_policy to control VS-mode WFI =
trapping

This patch adds a kernel command-line option to control whether a WFI
executed by a VS-mode guest traps into KVM or executes natively. The
policy can be 'trap' or 'auto', with 'auto' dynamically allowing native
WFI only when the vCPU is the sole runnable task.

> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 977e36ab83d3f..9a4a7d0729d37 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -26,6 +28,59 @@
> =20
>  static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_former_vcpu);
> =20
> +/*
> + * WFI trap policy for VS-mode guests, controllable through the
> + * kvm-riscv.wfi_trap_policy=3D kernel command-line option.
> + */

[ ... ]

> +static int __init early_kvm_riscv_wfi_trap_policy_cfg(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	if (strcmp(arg, "trap") =3D=3D 0) {
> +		kvm_riscv_wfi_trap_policy =3D KVM_RISCV_WFI_TRAP;
> +		return 0;
> +	}
> +
> +	if (strcmp(arg, "auto") =3D=3D 0) {
> +		kvm_riscv_wfi_trap_policy =3D KVM_RISCV_WFI_AUTO;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +early_param("kvm-riscv.wfi_trap_policy", early_kvm_riscv_wfi_trap_policy=
_cfg);

[Severity: Low]
Does using early_param() break the build when KVM is compiled as a loadable
module (CONFIG_KVM=3Dm)?

The early_param macro defined in include/linux/init.h is strictly wrapped in
an #ifndef MODULE block, leaving it undefined for loadable modules.

Since early_kvm_riscv_wfi_trap_policy_cfg() relies on this macro, would
compiling with CONFIG_KVM=3Dm result in implicit declaration or undefined m=
acro
errors?

[ ... ]

> @@ -637,6 +693,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cp=
u)
> =20
>  	kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
> =20
> +	/* Re-evaluate the WFI trap policy for this vCPU. */
> +	kvm_riscv_vcpu_update_wfi_trap(vcpu);
> +
>  	vcpu->cpu =3D cpu;
>  }

[Severity: High]
Is there a time-of-check to time-of-use race here that could cause CPU
starvation for newly awakened tasks?

The policy is evaluated in kvm_arch_vcpu_load(), which clears HSTATUS.VTW
when the vCPU is the sole runnable task.

If an interrupt wakes another task on the same CPU while the vCPU is in the
guest, but preemption is not immediately forced (e.g., the vCPU still has C=
FS
timeslice remaining), KVM handles the exit and re-enters the guest loop in
kvm_arch_vcpu_ioctl_run() without calling kvm_arch_vcpu_load().

Could the guest then execute WFI natively because HSTATUS.VTW remains stale
and cleared, halting the physical CPU and starving the newly woken task unt=
il
the next hardware interrupt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804024707.2400=
404-1-yhchen312@gmail.com?part=3D1
