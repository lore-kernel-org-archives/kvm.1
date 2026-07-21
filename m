Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC9364943
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632010; cv=none; b=FafOfte5m67dsJzYuIA9chC5TpRlcwQUeOFzxTXIV8dJH5oiXV/whdG3kC93ZXQgqg0R3BjFQlSZ4OcdLjg0g9kL9Og0afhuqEOqFbxXbd/jEmPRLmd5//izGVojtSqwFiKt1tPZWVjwn7nYmz4MidpN3lFCiAO14gbb2DquCKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632010; c=relaxed/simple;
	bh=kMzACngeO53O5LcE7/jXPdCx7ahl/CemQiRZeYry7aw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I6YnhZv7GERgeAqkla3wt3MZaSncTFdk/bgCHTcdBRF9lwVGZKW3jFkDPliCuffzPONxcMo9a+5IYP7CbMLxn0Lp4HBKMm00IFuAixnZwZkC/QtBZXwvQtUhYI2PDIU4PUXnerSJDtZvtvn+NFLk/dC4uESmaaSknYdjR9ZCcKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOhUQVLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOhUQVLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984051F000E9;
	Tue, 21 Jul 2026 11:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784632008;
	bh=kLcmd5AsjTxbBOiT4yO3JBCYJ5yRwLGZ5TQvbrRaItQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KOhUQVLz/t0gtH/6UzJUMnVX0Xk8sXCr/3NSGG8LSn9TKThwqdJxRTjhxfvJwVs00
	 RR0KERH/COQ4tsauIz4MNzK4juqgW15kOK5qV5mVA/GWXCABlQCmYw5BS6gtRtE5nz
	 bNwlg244+uFgbvxtUHFcGDBRQ/59rR+EvhS1X+0hJGB6htskKF7zDT1a/RXjVakpY0
	 /Mppi94kLGjdyszannDEE+2YGQwu9JEVFG2Xxn9dtGF6mtXzxvNgS0dje68Bexi0kc
	 o80M3KsXa5n4vKIFbkjc1FuAcZTqQnoYHNVBA15KtUR/SSicaje+HF7Wyt+m42m9uJ
	 lFCdd1z5cwbeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: selftests: riscv: Add lazy V extension
 enablement for guests
Reply-To: sashiko-reviews@lists.linux.dev
To: JinRui <jinrui@haiwei.tech>
Cc: kvm@vger.kernel.org
In-Reply-To: <C286E18DD19A86E7+20260721105736.320687-1-jinrui@haiwei.tech>
References: <4FAAF34C966898C0+20260721101406.305108-1-jinrui@haiwei.tech>
 <C286E18DD19A86E7+20260721105736.320687-1-jinrui@haiwei.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:06:48 +0000
Message-Id: <20260721110648.984051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `v_available` global variable is modified by the host but ne=
ver synchronized to the guest, causing the lazy V extension enablement to f=
ail.
--

--- Patch [1]: [PATCH v2] KVM: selftests: riscv: Add lazy V extension enabl=
ement for guests ---
commit cbe1d2bca6a87eaa2ec0da02cdab16afeceb5c77
Author: jinrui <jinrui@haiwei.tech>

KVM: selftests: riscv: Add lazy V extension enablement for guests

This commit introduces lazy V extension enablement in RISC-V KVM selftests.
It adds a global variable to track V extension availability and updates the
guest exception handler to re-execute vector instructions when trapped.

> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c

[ ... ]

> @@ -348,8 +343,23 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm,=
 u32 vcpu_id)
>  	/* Setup sscratch for guest_get_vcpuid() */
>  	vcpu_set_reg(vcpu, RISCV_GENERAL_CSR_REG(sscratch), vcpu_id);
> =20
> -	/* Setup default exception vector of guest */
> -	vcpu_set_reg(vcpu, RISCV_GENERAL_CSR_REG(stvec), (unsigned long)guest_u=
nexp_trap);
> +	/*
> +	 * Enable the V (vector) extension in KVM so that the compiler can
> +	 * safely generate vector instructions (e.g. via -O2 auto-
> +	 * vectorization). Silently ignore errors; the test will still work
> +	 * without V.
> +	 */
> +	__vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_V), 1);
> +	v_available =3D __vcpu_has_isa_ext(vcpu, KVM_RISCV_ISA_EXT_V);

[Severity: Medium]
Does v_available need to be synchronized to the guest here using
sync_global_to_guest(vm, v_available)?

Because vm_arch_vcpu_add() updates this from the host context, the guest
will only see its own unsynchronized copy (which defaults to false).

> +
> +	/*
> +	 * Use the full exception vector table (which provides lazy V
> +	 * extension enablement for EXC_INST_ILLEGAL in route_exception)
> +	 * as the default exception handler. vm_init_vector_tables() is
> +	 * idempotent; tests that call it again will get a no-op.
> +	 */
> +	vm_init_vector_tables(vm);
> +	vcpu_init_vector_tables(vcpu);
> =20
>  	return vcpu;
>  }

[ ... ]

> @@ -432,6 +442,33 @@ void route_exception(struct pt_regs *regs)
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
> +		 * Initial and sret to re-execute the faulting instruction.
> +		 * Use regs->status (saved at exception entry) rather than
> +		 * reading the live CSR to avoid a TOCTOU race with nested
> +		 * exceptions.
> +		 */
> +		if (v_available && !(regs->status & SR_VS)) {

[Severity: Medium]
Since route_exception() runs in the guest, won't v_available always evaluate
to false without a prior sync_global_to_guest() call?

Could this cause a regression where the lazy enablement check is bypassed,
leading the guest to fail when it encounters an auto-vectorized instruction?

> +			regs->status |=3D SR_VS_INITIAL;
> +			return;
> +		}
> +	}
> +
>  	if (handlers && handlers->exception_handlers[vector][ec])
>  		return handlers->exception_handlers[vector][ec](regs);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/C286E18DD19A86E7+20=
260721105736.320687-1-jinrui@haiwei.tech?part=3D1
