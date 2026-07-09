Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661742E173B
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598983; cv=none; b=tRSWIlTAdfTVP2wnCV6pWG54ucXkwHGyo/b4XXRP/z5oPlypn7mDifqgrK8LEmmLoV3g4MfI8ut+3McF+VhGuNzAdMWLOGZ3C04x8EjbWZE0jjkE9KpbrcmMrTtPLmGarCy99IY8X7ATFQzQ8jpUlIy3AwQ9+90XWoaVAPL8m4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598983; c=relaxed/simple;
	bh=JJF89OzjiK//aS6LuxvJBzPtSGMx5ZOY1ciycm1lkgE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZhJGm9PDQAntpLD85nwiFrMX3l8V0f6kw6As9d0VPHhYpzAAblDIyOHZ/McA78lMN5X4yVWrSBhfLlobewpisIQWRJReeKbkktq8fMYAq5cZsCtF/licj8NU5iwchErDP1pU3i7Fr8yUdwiijYk+RVGWeyW+ux1sID3q2uJZUHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3+xSzkB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3+xSzkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9001F000E9;
	Thu,  9 Jul 2026 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783598982;
	bh=zgYulmIFNOA0WutUN2Vp6LIMzrVxaLWeN9Hd/AZp7fU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D3+xSzkBc68K7N5F5OcyKv1eo6lf3FLbUK5MpbpsjLmXzUO8+zk+SEMRBUSh3aoBX
	 J689gK1J8yncOPQP9yEEGHXLE0/ikl8LWS9Z8yMqelLDrsl0sH/haNj6WPc5YJsWiM
	 l7bF7AhVgH6WHtW4Avk4/qmmRK0N0oke4w/s2AXKDE4ZUSquAOZWC7RX4S4B72pVW2
	 qT5+zGTODMETXkkGPLPNrf8dx9QKq+0VioT+a7RX3o+kjItT4adovKeYpBHIBUHceZ
	 VAruirgZo1ZZiMkNC7wPgiWlhaQMGTQWdA6QUNJOSmHSpK38sJmj6qeBU6FCysD0Eq
	 J935TMDiyRoSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Add kvm-riscv.wfi_trap_policy to control
 VS-mode WFI trapping
Reply-To: sashiko-reviews@lists.linux.dev
To: Yuhang.chen <yhchen312@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709115610.287420-1-yhchen312@gmail.com>
References: <20260709115610.287420-1-yhchen312@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:09:41 +0000
Message-Id: <20260709120941.BE9001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The use of `early_param` causes a build failure and breaks paramete=
r configuration when KVM is compiled as a loadable module (`CONFIG_KVM=3Dm`=
).
--

--- Patch [1]: [PATCH] RISC-V: KVM: Add kvm-riscv.wfi_trap_policy to contro=
l VS-mode WFI trapping ---
commit 6cc43e03229541ce24e1b37ff0f4554294688af7
Author: Yuhang.chen <yhchen312@gmail.com>

RISC-V: KVM: Add kvm-riscv.wfi_trap_policy to control VS-mode WFI trapping

This commit introduces a new parameter to control whether VS-mode WFI
instructions trap into KVM or execute natively.

> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index cf6e231e76e25..09afbb014b47d 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c

[ ... ]

> @@ -26,6 +27,42 @@
> =20
>  static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_former_vcpu);
> =20
> +/*
> + * WFI trap policy for VS-mode guests, controllable through the
> + * kvm-riscv.wfi_trap_policy=3D kernel command-line option.
> + */
> +enum kvm_riscv_wfi_trap_policy {
> +	KVM_RISCV_WFI_TRAP,	/* Default: trap VS-mode WFI into KVM */
> +	KVM_RISCV_WFI_NOTRAP,	/* Let VS-mode WFI execute natively */
> +};
> +
> +static enum kvm_riscv_wfi_trap_policy kvm_riscv_wfi_trap_policy __read_m=
ostly =3D
> +	KVM_RISCV_WFI_TRAP;
> +
> +static int __init early_kvm_riscv_wfi_trap_policy_cfg(char *arg)
> +{
[ ... ]
> +	if (strcmp(arg, "notrap") =3D=3D 0) {
> +		kvm_riscv_wfi_trap_policy =3D KVM_RISCV_WFI_NOTRAP;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +early_param("kvm-riscv.wfi_trap_policy", early_kvm_riscv_wfi_trap_policy=
_cfg);

[Severity: Low]
Since KVM can be compiled as a loadable module (CONFIG_KVM=3Dm), will this
use of early_param() cause a build failure?

In include/linux/init.h, early_param() is undefined when MODULE is defined.
Additionally, since early_param() only parses the early boot command line,
this setup prevents configuring the trap policy via arguments when KVM is
loaded dynamically.

Does this need to use module_param() or similar to ensure it builds correct=
ly
as a module and accepts runtime arguments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709115610.2874=
20-1-yhchen312@gmail.com?part=3D1
