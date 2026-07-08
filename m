Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B241C84A6
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 04:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483244; cv=none; b=Qdu6Gdgu91kX7cNmvs/WId0BHkIDeyF0Plj8WIXzN6GvNrkxjIaGIGDtN9o/Q1IklaAypb5cUF637NOiDuSHUObVkh2r7fC1V1vbspVRUZVOoDv1f16E0gnkKgaAyz8n7kIbXzlyIXQYsm6aOS1EQPYzutwF+aHyr+2P7nGonNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483244; c=relaxed/simple;
	bh=jMoOTFpGk6cMNAPQJ1fanXFLNAk96Ks5W4fSC9hFFD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Its92agh0OPwlRD2hlUHcMMR2rDaw1/qsYgqRm+Yh0GcOSyzbOHvZhCf+nP1k0Hj0CBeuRwiGu52XBSrh2c+VBe2jIVP7K5/v4vNdoEH3XwoXUy2CEBLlp1l8KCMkoj7OuxoasqC8n3pMBJstUpxqinLYHllU+Mf05Tk9te6HFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAuZVWrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAuZVWrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A081F000E9;
	Wed,  8 Jul 2026 04:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783483243;
	bh=GylafC4g7Oj8AT5N+l1T6Py7clGSHlGgSFawMlJfizs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JAuZVWrU5h1yWlll7n8ovjR0d2DXSHCKfiMdMUAtdMOs6qWpLFw3jOH6yHw2vHI5S
	 c5eij16y/i/Fbp+og27ps2K88dVOhuaYoEvFZDsnCB38UBzMR6xhFEcitOAcxqv5DX
	 a92HpkqrwrTZUX9MFdp094mtEwWQjrE1p6GCZOjeFJqMiguoaXkiEq9464adzVzGmg
	 Dx0OSgA1a/qslKiAHKvCr3SMLXnPAbL2CgdZLIvh2Wq7/b3k05TEWqW09I6JmhhOpG
	 UV2CuP4v9Cy3Wi8KMRS9jdCeL0qrHvCMdB5hyKtALc91UubUbrLHnCcRjoHl8mScrx
	 fSDb6uLWMR3uA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/17] riscv: kvm: Add emulated test csr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-13-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-13-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 04:00:42 +0000
Message-Id: <20260708040043.03A081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Hijacking the architectural `CSR_VSSCRATCH` for test emulation cre=
ates dual disjoint states, violating architecture invariants and breaking n=
ested virtualization.
- [Medium] The KVM CSR emulation test for `vsscratch` is non-functional and=
 unreachable. Accessing an HS-mode CSR (0x240) from a guest (VS-mode) gener=
ates an Illegal Instruction exception (Cause 2), not a Virtual Instruction =
fault, completely bypassing KVM's emulation logic.
- [Medium] The emulated vsscratch CSR is a silently-on guest-visible featur=
e that lacks state serialization, violating KVM live migration invariants.
--

--- Patch [13]: [PATCH v3 13/17] riscv: kvm: Add emulated test csr ---
commit c90a2625de316ca2ae3dfca0aa91c4a00b0acfef
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: kvm: Add emulated test csr

This commit introduces an emulated test CSR (vsscratch) for KVM on RISC-V.
It adds a new kernel config option CONFIG_RISCV_KVM_TEST_CSR to enable
interception and emulation of the vsscratch register for testing purposes.

> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 75b0a951c1bc6..4d30d30ebefc7 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
[ ... ]
> @@ -265,6 +271,10 @@ struct kvm_vcpu_arch {
>  		gpa_t shmem;
>  		u64 last_steal;
>  	} sta;
> +
> +#ifdef CONFIG_RISCV_KVM_TEST_CSR
> +	struct kvm_test_csr test_csr;
> +#endif
>  };

[Severity: Medium]
Since this newly added guest state is not exposed to userspace via the
KVM_GET_ONE_REG or KVM_SET_ONE_REG ioctls, will it be silently lost during
live migration?

> diff --git a/arch/riscv/include/asm/kvm_vcpu_test_csr.h b/arch/riscv/incl=
ude/asm/kvm_vcpu_test_csr.h
> new file mode 100644
> index 0000000000000..a844fccaafc34
> --- /dev/null
> +++ b/arch/riscv/include/asm/kvm_vcpu_test_csr.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __KVM_VCPU_RISCV_TEST_CSR_H
> +#define __KVM_VCPU_RISCV_TEST_CSR_H
> +
> +#include <asm/kvm_vcpu_insn.h>
> +
> +#define KVM_RISCV_VCPU_TEST_CSR_FUNCS \
> +	{.base =3D CSR_VSSCRATCH,	.count =3D 1,	.func =3D kvm_riscv_vcpu_test_c=
sr },

[Severity: Medium]
Will this emulation callback ever be reached?

CSR_VSSCRATCH (0x240) is an HS-mode CSR. When a guest in VS-mode attempts
to access it, the hardware generates an Illegal Instruction exception
(Cause 2) rather than a Virtual Instruction fault (Cause 22).

In kvm_riscv_vcpu_exit(), KVM directly injects EXC_INST_ILLEGAL back to the
guest:

arch/riscv/kvm/vcpu_exit.c:kvm_riscv_vcpu_exit() {
    ...
    case EXC_INST_ILLEGAL:
        kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_ILLEGAL_INSN);
        vcpu->stat.instr_illegal_exits++;
        ret =3D vcpu_redirect(vcpu, trap);
        break;
    ...
}

Because this bypasses the instruction decoder entirely, it seems the test
CSR emulation logic won't be executed.

> +
> +int kvm_riscv_vcpu_test_csr(struct kvm_vcpu *vcpu, unsigned int csr_num,
> +			    unsigned long *val, unsigned long new_val,
> +			    unsigned long wr_mask);
> +
> +#endif /* !__KVM_VCPU_RISCV_TEST_CSR_H */
> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index 78adc28308193..c3e4cf2cd44b7 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
[ ... ]
> @@ -112,6 +114,9 @@ static int seed_csr_rmw(struct kvm_vcpu *vcpu, unsign=
ed int csr_num,
>  static const struct csr_func csr_funcs[] =3D {
>  	KVM_RISCV_VCPU_AIA_CSR_FUNCS
>  	KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS
> +#ifdef CONFIG_RISCV_KVM_TEST_CSR
> +	KVM_RISCV_VCPU_TEST_CSR_FUNCS
> +#endif

[Severity: Medium]
Does unconditionally enabling this guest-visible feature for all VMs when t=
he
kernel config is set bypass KVM capability negotiation?

KVM features should generally be discoverable and opt-in by userspace to
ensure predictable migration behavior and compatibility.

>  	{ .base =3D CSR_SEED, .count =3D 1, .func =3D seed_csr_rmw },
>  };
> =20
> diff --git a/arch/riscv/kvm/vcpu_test_csr.c b/arch/riscv/kvm/vcpu_test_cs=
r.c
> new file mode 100644
> index 0000000000000..b8aa503cdaba7
> --- /dev/null
> +++ b/arch/riscv/kvm/vcpu_test_csr.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kvm_host.h>
> +#include <asm/kvm_vcpu_insn.h>
> +#include <asm/kvm_vcpu_test_csr.h>
> +
> +#define vcpu_to_test_csr(vcpu) (&(vcpu)->arch.test_csr)
> +
> +int kvm_riscv_vcpu_test_csr(struct kvm_vcpu *vcpu, unsigned int csr_num,
> +			    unsigned long *val, unsigned long new_val,
> +			    unsigned long wr_mask)
> +{
> +	struct kvm_test_csr *test_csr =3D vcpu_to_test_csr(vcpu);
> +
> +	*val =3D test_csr->val;
> +
> +	if (wr_mask)
> +		test_csr->val =3D (test_csr->val & ~wr_mask) | (new_val & wr_mask);

[Severity: High]
Does hijacking the architectural CSR_VSSCRATCH create disjoint states that
could corrupt nested virtualization?

Even if the emulation were reachable, it reads and writes to a dummy field
rather than the actual hardware state in vcpu->arch.guest_csr.vsscratch.

KVM natively context-switches the architectural CSR to hardware:

arch/riscv/kvm/vcpu.c:kvm_arch_vcpu_load() {
    ...
    csr_write(CSR_VSSCRATCH, csr->vsscratch);
    ...
}

Redirecting explicit accesses to this separate test variable decouples the
software-emulated state from the hardware state, which might break nested
hypervisors that rely on the architectural vsscratch holding the L2 guest's
sscratch.

> +
> +	return KVM_INSN_CONTINUE_NEXT_SEPC;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D13
