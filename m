Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB833470130
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706246; cv=none; b=FmhMxXo5VuwBDi0XVVisYTX2ar/XXFCrO9AZSukIMPWGH5wC0qXk8Wp5rn8h1GA77EEVsLTNcVRG/TaM/t3p4p+Qq/X/I+kO7fPC8RoMfgdrtnQa7AVZbyLgLNPdNlxL3+aQWLBVukrmqM3E1zwMCXtOJ30mQ3/BKz1rpc6KGZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706246; c=relaxed/simple;
	bh=z7hRmFx6Q/cKialkK+h+Uh2CuKM7Kat59hPecQV0BsQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bkII8Jzdi2ExX14QND+SAkPGqlhIrUkbsdXEGMeD0ym4WbyCIYbiavUJk+Xhr5CkxOd7uwXKWdVmcj28NNuE6j5h1sVgm2jrkYEpuqIU1z+mP3oLvgSLELLBHK8g/fabZNkJnwW2P5GFGTywfZqoTKerclAV4EHcQza0bwlwfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te1CbY9y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te1CbY9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5401F000E9;
	Wed, 22 Jul 2026 07:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784706245;
	bh=/NXYMk8gABnHL1dU/KQJEFSyreY3+dVw7DhD5lUr0Zg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Te1CbY9yFXweeBneGhFffPpOlAnKzXqhTFJXKiK3CtUNuY76B+946vyOMU9iSnyS/
	 AUth89Cswplic2QCP/RezPsjVySoxS89PWvIID2MVknLgefn8ipq9Bfk6l+am4OP/6
	 FRSY/paL/EvTuaEg5pgctJcccfuAiWpCIgQYWN37oKWo+Je8fn4gj9LNpNrcdGdwX0
	 Zj+xMxdN4hTpFQRLXsSWKwlWv4sUZ6CJUdsDiWHav7py8WGWtJeCx9PfXeI8jBrXlz
	 IdGGxw+Gm6Bxt1CViEJXoWe8HzaQNCsusaTSRzpYKShJ39oRVt1H0QJMUy78blYYtb
	 ztLRE8yJMv5JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] KVM: selftests: riscv: Add lazy V extension
 enablement for guests
Reply-To: sashiko-reviews@lists.linux.dev
To: JinRui <jinrui@haiwei.tech>
Cc: kvm@vger.kernel.org
In-Reply-To: <33AEC00DC78613A1+20260722073344.771230-1-jinrui@haiwei.tech>
References: <20260722062804.738428-1-jinrui@haiwei.tech>
 <33AEC00DC78613A1+20260722073344.771230-1-jinrui@haiwei.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:44:05 +0000
Message-Id: <20260722074405.8D5401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `v_epc` array for tracking vector extension enablement is si=
zed using `KVM_CAP_MAX_VCPUS` but indexed by `vcpu_id`. Since KVM allows `v=
cpu_id` up to `KVM_CAP_MAX_VCPU_ID` (which can be significantly larger than=
 `KVM_CAP_MAX_VCPUS` for sparse topologies), tests using large vCPU IDs wil=
l silently bypass the lazy V extension enablement and fail with an unhandle=
d exception.
--

--- Patch [1]: [PATCH v8] KVM: selftests: riscv: Add lazy V extension enabl=
ement for guests ---
commit fc8045a6835b1383f4809674a40465f3a99bc4f0
Author: jinrui <jinrui@haiwei.tech>

KVM: selftests: riscv: Add lazy V extension enablement for guests

This commit introduces lazy V extension enablement for RISC-V KVM selftests.
It replaces the default guest exception handler with the full vector table
and adds a check in route_exception() to lazily enable the V extension if
an EXC_INST_ILLEGAL is triggered by auto-vectorized instructions.

> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index ded5429f34483..624f20f0f4766 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c

[ ... ]

> @@ -432,6 +454,46 @@ void route_exception(struct pt_regs *regs)
>  		ec =3D 0;
>  	}
> =20
> +	/*
> +	 * Handle V (vector) extension lazy enablement before any
> +	 * registered handler. The compiler's default march may include
> +	 * V, and auto-vectorization generates vector instructions that
> +	 * trigger EXC_INST_ILLEGAL when VS (Vector Status) in sstatus
> +	 * is Off. Enable VS to Initial and re-execute the faulting
> +	 * instruction, mimicking what a real OS kernel does.
> +	 *
> +	 * This check runs before any test-registered handler, so tests
> +	 * that install their own EXC_INST_ILLEGAL handler (e.g.
> +	 * sbi_pmu_test) are not affected.
> +	 */
> +	if (!(regs->cause & CAUSE_IRQ_FLAG) && ec =3D=3D EXC_INST_ILLEGAL) {
> +		/*
> +		 * If KVM supports the V extension for this Guest and VS
> +		 * (Vector Status) is Off in the saved sstatus, set it to
> +		 * Initial and re-execute the faulting instruction.
> +		 *
> +		 * Use regs->status (saved at exception entry) rather than
> +		 * reading the live CSR to avoid a TOCTOU race.
> +		 *
> +		 * Track the epc per-vCPU to avoid an infinite loop when
> +		 * V is disabled or the hardware rejects the VS change.
> +		 * Using a per-vCPU array avoids races between concurrent
> +		 * vCPUs that would occur with a single shared (epc, vcpu)
> +		 * pair.
> +		 */
> +		if (handlers && handlers->v_available && !(regs->status & SR_VS)) {
> +			unsigned int vcpu_id;
> +
> +			asm volatile("csrr %0, sscratch" : "=3Dr" (vcpu_id));
> +			if (vcpu_id < handlers->v_epc_capacity &&
> +			    handlers->v_epc[vcpu_id] !=3D regs->epc) {
> +				handlers->v_epc[vcpu_id] =3D regs->epc;
> +				regs->status |=3D SR_VS_INITIAL;
> +				return;
> +			}
> +		}
> +	}
> +

[ ... ]

> @@ -448,9 +510,26 @@ void vcpu_init_vector_tables(struct kvm_vcpu *vcpu)
> =20
>  void vm_init_vector_tables(struct kvm_vm *vm)
>  {
> -	vm->handlers =3D __vm_alloc(vm, sizeof(struct handlers), vm->page_size,
> +	unsigned int max_vcpus;
> +	size_t size;
> +
> +	if (vm->handlers)
> +		return;
> +
> +	max_vcpus =3D kvm_check_cap(KVM_CAP_MAX_VCPUS);
> +	if (max_vcpus =3D=3D 0)
> +		max_vcpus =3D 512;
> +
> +	size =3D sizeof(struct handlers) + max_vcpus * sizeof(unsigned long);

[Severity: Medium]
Should this allocation use KVM_CAP_MAX_VCPU_ID instead of KVM_CAP_MAX_VCPUS?

The v_epc array is sized here using max_vcpus, but it is indexed by vcpu_id
when accessed in route_exception():

			asm volatile("csrr %0, sscratch" : "=3Dr" (vcpu_id));
			if (vcpu_id < handlers->v_epc_capacity &&
			    handlers->v_epc[vcpu_id] !=3D regs->epc) {
				handlers->v_epc[vcpu_id] =3D regs->epc;

Since KVM allows vcpu_id to go up to KVM_CAP_MAX_VCPU_ID, which can be
significantly larger than KVM_CAP_MAX_VCPUS for sparse topologies, tests
using large vCPU IDs might exceed this capacity. This would cause the bounds
check in route_exception() to fail, silently bypassing the lazy V extension
enablement and resulting in an unhandled exception for those tests.

> +	vm->handlers =3D __vm_alloc(vm, size, vm->page_size,
>  				  MEM_REGION_DATA);
> =20
> +	{
> +		struct handlers *h =3D addr_gva2hva(vm, vm->handlers);
> +
> +		h->v_epc_capacity =3D max_vcpus;
> +	}
> +
>  	*(gva_t *)addr_gva2hva(vm, (gva_t)(&exception_handlers)) =3D vm->handle=
rs;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/33AEC00DC78613A1+20=
260722073344.771230-1-jinrui@haiwei.tech?part=3D1
