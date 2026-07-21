Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF5C48C3FA
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635624; cv=none; b=EF2Sv40g+BgBFuSa6XN03WW6O79Fesbt29OhQ3XoNqQLxp2GtVj24eBQNdh+W4y7iI8nt5hhbRK6MF4kavU8yl7un6Bm/81uygYk32HDgJgayo0SdeSdOtFntOkcE2HU5kJQc178kCAeAA6o52EcDZ8HwhPACbdBXT3ad1DKuLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635624; c=relaxed/simple;
	bh=YTwsDo/351qaj+NWSE/38K8DQUnjkMN4yr+qCQMhqz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gNFiNRzx6o+3Ny6vA/Be0+XJd7z53RvcB8X5splLXwq/uGCEMqjjS6/xQ34FAtmx7WLbJAziZbgBslGPto8unKzb2UCaOkGJ2/GwJBaMSNFIQynJrGByhsEJDMlEM0qRKsorwOasmw0tJjy6rDfqb16K23dbwo5obgWox8Bn+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6WwCMIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6WwCMIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6AB1F00A3A;
	Tue, 21 Jul 2026 12:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635622;
	bh=7ZezTetTDkGgNFDjZ/IwMJ5IYdjt9+vEsj4y6zZFlSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c6WwCMICViZNPOdKHTRoYGsaBWudyCv+ZogmU9A3UesVfOQiFIJmIcbsRZ7SyCBKn
	 gK3Sc6VWm4GEsb3/+k4Ny8KxXZI/NmXRj/8/kw1C0nrWhDF/PiuvqCoG2HbDWxeBMT
	 BLkQdg5HLEOOcQpaNtGIugZk6SgpP47bYLnYxJxSoHBNV2Tg/TLkuqfcpDke5B5tMC
	 4W7xzA8kPmLQIG3/FVKcmF3ymbTKocEAhAHSIJcDL1Ras53gZJ5vIWdBsQvE+ivkRb
	 kVKu513nUFcdM6C8uDLcyOp94jjcz8oUO1HDt614qYYeO8d6E5sC92atiqmEOMLAPa
	 oQyyqcy6ZmiuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] KVM: selftests: riscv: Add lazy V extension
 enablement for guests
Reply-To: sashiko-reviews@lists.linux.dev
To: JinRui <jinrui@haiwei.tech>
Cc: kvm@vger.kernel.org
In-Reply-To: <759A31C23819178D+20260721115558.341592-1-jinrui@haiwei.tech>
References: <20260721112454.330498-1-jinrui@haiwei.tech>
 <759A31C23819178D+20260721115558.341592-1-jinrui@haiwei.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 12:07:02 +0000
Message-Id: <20260721120702.BB6AB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] A stale `v_available` flag will cause an unbreakable infinite ex=
ception loop if a test explicitly disables the V extension after vCPU creat=
ion.
--

--- Patch [1]: [PATCH v4] KVM: selftests: riscv: Add lazy V extension enabl=
ement for guests ---
commit 86c97aea9514d3ca01973f19323ad00e29e959ab
Author: jinrui <jinrui@haiwei.tech>

KVM: selftests: riscv: Add lazy V extension enablement for guests

This commit introduces lazy V (vector) extension enablement for KVM RISC-V=
=20
selftest guests. It replaces the raw stvec handler with the full exception=
=20
vector table and adds a check in route_exception() to handle vector=20
instructions when sstatus.VS is Off. It also ensures vm_init_vector_tables(=
)=20
is idempotent.

> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index ded5429f34483..bf0675cc86d6d 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c

[ ... ]

> @@ -348,8 +340,33 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm,=
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
> +
> +	/*
> +	 * Use the full exception vector table (which provides lazy V
> +	 * extension enablement for EXC_INST_ILLEGAL in route_exception)
> +	 * as the default exception handler. vm_init_vector_tables() is
> +	 * idempotent; tests that call it again will get a no-op.
> +	 */
> +	vm_init_vector_tables(vm);
> +	vcpu_init_vector_tables(vcpu);
> +
> +	/*
> +	 * Record V extension availability in the handlers struct so that
> +	 * route_exception() (called from Guest context) can check it
> +	 * without relying on a host-side global variable.
> +	 */
> +	{
> +		struct handlers *h =3D addr_gva2hva(vm, vm->handlers);
> +
> +		h->v_available =3D __vcpu_has_isa_ext(vcpu, KVM_RISCV_ISA_EXT_V);
> +	}

[Severity: Medium]
Will this snapshot of v_available cause issues if a test explicitly disable=
s the
V extension after vCPU creation?

If a test uses vcpu_set_reg() to disable KVM_RISCV_ISA_EXT_V after calling
vm_arch_vcpu_add(), h->v_available remains true in the private handlers str=
uct.

[ ... ]

> @@ -432,6 +451,33 @@ void route_exception(struct pt_regs *regs)
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
> +		if (handlers && handlers->v_available && !(regs->status & SR_VS)) {
> +			regs->status |=3D SR_VS_INITIAL;
> +			return;
> +		}
> +	}

[Severity: Medium]
Could this result in an unbreakable infinite exception loop if the test
subsequently disabled the V extension?

Since h->v_available was cached during vm_arch_vcpu_add() and might still b=
e=20
true, this code will attempt lazy enablement by setting SR_VS_INITIAL and=20
returning via sret to re-execute the instruction.

However, because the V extension is actually disabled in KVM, the hardware =
and
hypervisor will enforce sstatus.VS =3D=3D 0. The instruction will fault aga=
in, and
route_exception() will retry the enablement indefinitely without ever break=
ing
the loop.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/759A31C23819178D+20=
260721115558.341592-1-jinrui@haiwei.tech?part=3D1
