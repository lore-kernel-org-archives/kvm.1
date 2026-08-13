Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF5443AB0
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612388; cv=none; b=FzYTlafwnHK4Pk7UpKBRaMaYAomW7cv8ZRyvFTgGPQIM/InfM6KRdSz1NdaIeFmSPk38NRMrBFq+Br3yRsuT3+eOw9EbLe4dYgUs7kSIf2X/mfkVZiwYOhTv591YxyY3CPOc1eLZcZag3FvW2UNAL7nIkcujZnGGbzRdk1D0vvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612388; c=relaxed/simple;
	bh=ZbPcU3vUXXCAJitrsBOurxH0FdWsc3cUmDfX9VBbYhs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d5qwcHpixiG9bZ+EpOEkmm7D4GveezZroAqr5apJb9ArwfDhoNUU5fIDD0kYoMD7aiNhdav3iOfGPH2L4jodJvjH52DA/b+dC4UbbI5rUlMhQSj5PV5qtCgvnvhq63ImqyqjhuJgy/uVtfudtFt8OoUjwfDjO+pHaOJgtiVColE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVCwp2Sv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVCwp2Sv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235891F000E9;
	Thu, 13 Aug 2026 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786612385;
	bh=AFt2z29jLXYvosz8a3mm/63cTTrxjEzWErWP6yvMmuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OVCwp2SvTc5doqsomHTGuFNoJPnrb1VySFl6P4MAJoP4ygpZybcRxH8I9RCsoqamn
	 IB/Aq7oUn/R3araAzLwdifqh71bedD5si5NC/e+R84E/wqktfesGfXEm5mLGqTwhy9
	 acKpe1u0m6kOQcoyKbPqoeRAxW5mpxSUp8jMXDguKMrHcQ4H0kekGkNq2OGzqhDlAr
	 Y6Eadv0K/RrXcxyEaykdQ5clVo7kXl0x5ICbgEFIXG/kXWy57adEghugHfQVqFypmZ
	 8Vcym/q3eUgLq93FY37xyPzRS6Hxd/EHxeZcziEkS1zTHW1nkv+BG1oiU7u/2NXQXl
	 BOUyk8qIOtndw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10] KVM: selftests: riscv: Add lazy V extension
 enablement for guests
Reply-To: sashiko-reviews@lists.linux.dev
To: JinRui <jinrui@haiwei.tech>
Cc: kvm@vger.kernel.org
In-Reply-To: <733FC2542EECADE1+20260813090306.3756434-1-jinrui@haiwei.tech>
References: <034CA48A67574B32+20260811085036.2862645-1-jinrui@haiwei.tech>
 <733FC2542EECADE1+20260813090306.3756434-1-jinrui@haiwei.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 09:13:04 +0000
Message-Id: <20260813091305.235891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Lazy V extension enablement fails on hardware that does not popu=
late stval for illegal instructions.
- [Medium] Storing a per-vCPU V-extension availability flag in a VM-wide sh=
ared structure causes test failures in mixed-vCPU VMs.
--

--- Patch [1]: [PATCH v10] KVM: selftests: riscv: Add lazy V extension enab=
lement for guests ---
commit a24ebca96066b2892004c26d282cf14c6162da61
Author: jinrui <jinrui@haiwei.tech>
KVM: selftests: riscv: Add lazy V extension enablement for guests

This commit adds lazy V extension enablement for guests in KVM RISC-V selft=
ests
to handle auto-vectorized instructions when sstatus.VS is off. It registers=
 a
full exception vector table, advertises V to KVM, and lazily enables V in
route_exception().

> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index ded5429f34483..ffd84212c9b0d 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
[ ... ]
> @@ -348,8 +346,22 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm,=
 u32 vcpu_id)
>  	/* Setup sscratch for guest_get_vcpuid() */
>  	vcpu_set_reg(vcpu, RISCV_GENERAL_CSR_REG(sscratch), vcpu_id);
> =20
> -	/* Setup default exception vector of guest */
> -	vcpu_set_reg(vcpu, RISCV_GENERAL_CSR_REG(stvec), (unsigned long)guest_u=
nexp_trap);
> +	/*
> +	 * Advertise V to KVM so -O2 auto-vectorization in guest code is valid;
> +	 * ignore errors since the tests work without V too. Use the full
> +	 * exception vector table (which lazily enables V in route_exception())
> +	 * as the default handler; vm_init_vector_tables() is idempotent.
> +	 */
> +	__vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_V), 1);
> +	vm_init_vector_tables(vm);
> +	vcpu_init_vector_tables(vcpu);
> +
> +	/* Record V availability for route_exception(), which runs in guest con=
text. */
> +	{
> +		struct handlers *h =3D addr_gva2hva(vm, vm->handlers);
> +
> +		h->v_available =3D __vcpu_has_isa_ext(vcpu, KVM_RISCV_ISA_EXT_V);

[Severity: Medium]
Does this overwrite a shared VM-wide state with a per-vCPU capability?

The handlers structure is allocated once per VM in vm_init_vector_tables().
If a VM is created with a mix of vCPUs, and the last added vCPU has the V
extension, h->v_available will be true globally for all vCPUs.

If a non-V vCPU encounters an illegal instruction that happens to decode as=
 a
vector instruction, could route_exception() see h->v_available as true and
continually set SR_VS_INITIAL, causing an infinite exception loop?

> +	}
> =20
>  	return vcpu;
>  }
[ ... ]
> @@ -432,6 +468,20 @@ void route_exception(struct pt_regs *regs)
>  		ec =3D 0;
>  	}
> =20
> +	/*
> +	 * Lazily enable V on the first vector instruction: if the faulting
> +	 * instruction (stval) decodes as vector while VS is off, set VS to
> +	 * Initial and re-execute it, like the kernel's
> +	 * riscv_v_first_use_handler(). Genuinely illegal instructions fall
> +	 * through to the unexpected-exception path.
> +	 */
> +	if (!(regs->cause & CAUSE_IRQ_FLAG) && ec =3D=3D EXC_INST_ILLEGAL &&
> +	    handlers && handlers->v_available && !(regs->status & SR_VS) &&
> +	    insn_is_vector((u32)regs->badaddr)) {

[Severity: Medium]
Does this assume hardware always populates stval (which is mapped to
regs->badaddr) for illegal instruction exceptions?

If a test executes on hardware that does not populate stval and leaves it a=
s 0,
insn_is_vector() would evaluate to false.

Would this cause genuinely auto-vectorized instructions to unexpectedly fall
through to kvm_exit_unexpected_exception() instead of being lazily enabled?

Should this fall back to reading the instruction directly from guest memory=
 at
regs->epc when badaddr is 0?

> +		regs->status |=3D SR_VS_INITIAL;
> +		return;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/733FC2542EECADE1+20=
260813090306.3756434-1-jinrui@haiwei.tech?part=3D1
