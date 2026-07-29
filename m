Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413AC3ACEE0
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369261; cv=none; b=losUSVYbe4IhtKpMydCTYVkPQD/ebincCNUgJOssXSYWwoOs8aCJ1L8Jh9S5gBxO1LNckEKY795lBW7jJP3ErzKhi2zjqbf2p1mKW9UjU3n7PgmPqkL5OYJxQmePkPVC7rtJS/x2ms5unMOeFCclSqANpWAtCjQXKXLJA9G4d7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369261; c=relaxed/simple;
	bh=K9v08rLG0xUCV0/34cCopC2LdfQGSWFMfBPipip2QUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tNcN5T5TDr4oneMvufIMS/RqyFtV5qVgaoYrQrxRQP1Uw9KDW/wQYDAxvgWcXrpiCWHDRp4fK/MZX2aCb4lELT8WLFFeUwUPOu0h8ICcr/urslfNMzIcB9ZQ+ey9nI7JmkADIQ2BGG5dKxUezZhjuHod43qgXYLZ9lKACeoF+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjKA7MHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjKA7MHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3141F000E9;
	Wed, 29 Jul 2026 23:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785369259;
	bh=RfSIxv/8mfPLJHBsJa3bUgB7en0rQvT0+aznFdaRhGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UjKA7MHMcWyFJfLU+e1aQJlE8g5wAz5V/ZV9V5DwTaxPEX1uBdfiwkbXIJdoBJYQp
	 hicgiATl7UBrXGo516otpQeAlqRElUBnEl3TWJDdxdPYyQ3FQakrfUojaPydXn31GF
	 JTxkxVMSrKk5I/u4S6brlYmcQI1Xk+Fg9Sng8rmBHjS/xhc7Rs+xYEXC7nQSwYz7U1
	 b+VYa/ZipTz6rIsZJ84pw6VgG2RzmeDn5fYCZdfQByK24HlMaAvvphCMuaCLXo8go5
	 huRpsJTKEiehd+aLWk4I1jyV4kQmtJKCb9k0ikbk7S570vuqCbnpn4rjMN+qtbvk5s
	 3v26+YTDsYLQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] RISC-V: KVM: Mark the reset callback of FWFT
 extension always dirties CSR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729232527.139183-5-inochiama@gmail.com>
References: <20260729232527.139183-1-inochiama@gmail.com>
 <20260729232527.139183-5-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 23:54:19 +0000
Message-Id: <20260729235419.AA3141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The addition of `vcpu->arch.csr_dirty =3D true` in `kvm_sbi_ext_fwf=
t_reset()` is entirely redundant, contradicting the commit message premise.

Pre-existing issues:
- [High] Missing `vcpu_load()` around `KVM_SET_ONE_REG` for timer state cau=
ses physical CPU hardware CSR corruption.
--

--- Patch [4]: [PATCH v3 4/4] RISC-V: KVM: Mark the reset callback of FWFT =
extension always dirties CSR ---
commit 316b183f1319c7935d993137c0fbff524d4ecc07
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Mark the reset callback of FWFT extension always dirties CSR

As the CSR is only flushed when the csr_dirty is set, always set the
csr_dirty field in kvm_sbi_ext_fwft_reset() so the CSR change can take
effect immediately.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 2794e9e5b495e..8748df921f101 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -420,6 +420,8 @@ static void kvm_sbi_ext_fwft_reset(struct kvm_vcpu *v=
cpu)
>  		if (feature->reset)
>  			feature->reset(vcpu);
>  	}
> +
> +	vcpu->arch.csr_dirty =3D true;

[Severity: Low]
Is this assignment actually needed?

The commit message states csr_dirty =3D true is added so the CSR change tak=
es
effect immediately. However, kvm_sbi_ext_fwft_reset() is executed exclusive=
ly
via the .reset callback in two paths: riscv_vcpu_set_sbi_ext_single() (which
returns -EBUSY if the vCPU has already run) and kvm_riscv_vcpu_sbi_reset()
(called immediately after last_exit_cpu is explicitly set to -1).

In both scenarios, vcpu->arch.last_exit_cpu is guaranteed to be -1.
When kvm_arch_vcpu_load() later evaluates the fast-path condition:

arch/riscv/kvm/vcpu.c:kvm_arch_vcpu_load() {
    ...
	else if (vcpu->arch.last_exit_cpu =3D=3D cpu && !vcpu->arch.csr_dirty)
		goto csr_restore_done;
    ...
}

It will always evaluate to false (since physical cpu >=3D 0), meaning KVM
unconditionally bypasses the skip and flushes the CSRs anyway. Does this ma=
ke
the csr_dirty assignment redundant?

>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential hardware CSR
corruption when setting the timer state via ioctl.

Unlike x86, s390, MIPS, and LoongArch, the RISC-V implementation of
kvm_arch_vcpu_ioctl() handles KVM_SET_ONE_REG without acquiring
vcpu_load(vcpu):

arch/riscv/kvm/vcpu.c:kvm_arch_vcpu_ioctl() {
    ...
	if (ioctl =3D=3D KVM_SET_ONE_REG)
		r =3D kvm_riscv_vcpu_set_reg(vcpu, &reg);
    ...
}

When an unprivileged userspace process sets the timer state (e.g.,
KVM_REG_RISCV_TIMER_REG(state) to KVM_RISCV_TIMER_STATE_ON) on a system with
the SSTC extension, it eventually invokes kvm_riscv_vcpu_update_vstimecmp(),
which executes a direct hardware write:

arch/riscv/kvm/vcpu_timer.c:kvm_riscv_vcpu_update_vstimecmp() {
    ...
	ncsr_write(CSR_VSTIMECMP, ncycles);
    ...
}

Because the vCPU is not loaded onto the host CPU and preempt notifiers are
not active, does this directly corrupt the physical CPU's VSTIMECMP hardware
register?

If this destroys the -1UL safeguard, could it result in spurious guest timer
interrupts on the host, degraded power-savings (where WFI becomes a NOP), or
corruption of another running vCPU's timer state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729232527.1391=
83-1-inochiama@gmail.com?part=3D4
