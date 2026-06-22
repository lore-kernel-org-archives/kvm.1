Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131128504D
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 04:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102207; cv=none; b=lFF7pTBx3tNaAEVaLENhwFVkBuevtfZBfONJAQVNs0S0t2XIv59DWaWh8hooLE6SbC+LJFE2u/p+RFsPjCmtHNaFieCU7K+L9Y8++pyTn/Tm5w+VdgYSnzkbN0giVMirZmj9n8IZlHagf2OxlpLzHarWMZ8gA1w+M/6/Qjshba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102207; c=relaxed/simple;
	bh=Ddpmap3HNEE4gPM0gXU3Kf61Ud2997HJZb945StfZMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dCC0lLXTQ5x+XvjN+n1Y7uDVnXTF+z5VQri6A66lbzZ7KJQClp9ZhksOVCRtyYhxIZ4ZD84QNZwDBMIZCsMVYmsmTH1BdARfFdjY4gQj+69KDok9SDqKPAO6zSosMVvBFPG3wRuZbJxunWGdjVriJCbq5GLp3dmYHyZhbqOkLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEejPmLj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEejPmLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FFF1F000E9;
	Mon, 22 Jun 2026 04:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782102206;
	bh=yLEsct0NJnJfQR1wsHDMkBxuBddq1AKONiKMmc132RQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nEejPmLj2lHlZzTQibXIzzkA5hjIcupWEq1XYi6Cvy+Prp+B2d6dV+w96RMC2MFbC
	 A89wHrQ15/P+rZlnykxoToQl4gFcZIWvsjcUrFIUkvQuxGRdj8ctXPh0/5YeHBpXSV
	 qWl5fUSOloFDwyxp9Voy+sxEZVqRj0MdZPZMJIBjGPWQ2casqj4hj1ZhVzcFqkJ2t9
	 RnJkBBUoWrOe6THH9EnkitD5Q4LEqI5kUprIZaa+HR7sDe+toP+bCKQPB8LZ406Mdo
	 yKFsg97R+bklXMRkTiAsvOWeE1C9Uy5PXF1Fhsm3UdRUEPXYtKDNf2DVLjUfAh7sIq
	 MqSREEp+V7j9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/16] riscv: kvm: Add emulated test csr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins via B4 Relay" <devnull+thecharlesjenkins.gmail.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260621-riscv_insn_table-v2-12-7f0810ee2274@gmail.com>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-12-7f0810ee2274@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:23:25 +0000
Message-Id: <20260622042326.46FFF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The `vsscratch` test CSR emulation handler is structurally unreach=
able, rendering the feature dead code because accesses to VS-level CSRs fro=
m VS-mode do not trap to KVM.
- [High] The emulated test CSR unconditionally introduces a silently-on gue=
st-visible feature and unmigratable state, violating KVM API invariants.
- [High] The patch hijacks the architectural `vsscratch` CSR, backing it wi=
th disconnected software state and causing split-brain register semantics.
- [Medium] The emulated test CSR state is not cleared during VCPU reset, le=
aking state across warm resets.
--

commit 783cfef4904ebb8469e4e71c63a55936a9c8e148
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: kvm: Add emulated test csr

This commit adds support to emulate the vsscratch CSR when
CONFIG_RISCV_KVM_TEST_CSR is set. It introduces a new kvm_test_csr
struct and hooks into the CSR instruction handling to reflect changes
when the vsscratch register is accessed.

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

[Severity: High]
Does this new guest-visible state need to be explicitly enabled by userspace
with a runtime capability check rather than just a compile-time config?=20

Also, since this state isn't exposed via the KVM_GET_ONE_REG or KVM_SET_ONE=
_REG
API, will it break live migration because it is completely invisible to
userspace?

[Severity: Medium]
Is this test_csr state cleared during a VCPU reset? It looks like it is mis=
sing
from the architecture-specific reset path kvm_riscv_vcpu_context_reset(),
which might allow the modified value to leak across warm resets.

> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index 1d8741d022425..c5a70de4a5790 100644
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
>  	{ .base =3D CSR_SEED, .count =3D 1, .func =3D seed_csr_rmw },
>  };

[Severity: High]
Will this CSR emulation handler ever be reached?

KVM's CSR emulation path kvm_riscv_vcpu_virtual_insn() is only invoked for
Virtual Instruction exceptions (EXC_VIRTUAL_INST_FAULT, cause 22). However,
accessing an HS-level CSR like vsscratch from VS-mode natively generates an
Illegal Instruction exception (EXC_INST_ILLEGAL, cause 2).

Since KVM explicitly delegates these exceptions directly to the guest's
VS-mode exception handler, it seems this handler gets bypassed entirely.

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
> +
> +	return KVM_INSN_CONTINUE_NEXT_SEPC;
> +}

[Severity: High]
Does using the architectural vsscratch CSR for this test cause a split-brain
state?

In a RISC-V guest, accessing sscratch implicitly accesses the hardware
vsscratch register, which KVM context-switches via its standard guest conte=
xt
structures.

By intercepting explicit guest accesses to the vsscratch address and direct=
ing
them to this disjoint test_csr.val variable, the guest will see different
values depending on whether it accesses the register implicitly via sscratch
or explicitly via vsscratch. Would it be safer for a test CSR to use a
reserved or custom CSR address?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-riscv_insn=
_table-v2-0-7f0810ee2274@gmail.com?part=3D12
