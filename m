Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B2337B02B
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483136; cv=none; b=ElMFY95EDyJPrkjHXqYqVlhZ3O7qhizSLW4dkk2iKfjeYxLJcDEVjy961lCs2UdYltF8EkvVd4HExwZKq86BHzCBdNegvS2FLM1ssAMk6tE5ii1pB7wzyEwUoFUCwDED7VpPyx80U3vxD8RIrxzP0tYOi7EWYjQRHcif/qZL5ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483136; c=relaxed/simple;
	bh=LpRCQZtaHOrW9Q8wSuafQwCs3Ast+cPS+YvQiqCjvDU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ngDxrbJe2BYHjx3l/a3AjvJ9sHpFCNGDHXqiqB6ZR10GiVaJNVmkKegnyuAnVCdhgycQm36Nvstv79YPs5jPUbwy94DdCR7Fcizszp7tjAeJhLlWl2JCU0vSgxaEoaRioaPdWJKrNBFnyEz2pVl5ZzLqb33EyUt30g+ukQLfS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJS985dU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJS985dU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485EB1F000E9;
	Wed,  8 Jul 2026 03:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783483134;
	bh=+gri9e3/2yZS+U5pnURVO4aNuY2UzXOLO7DOFydRClQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NJS985dU0dPJaPOGzGMcZPe0gbO9S7lZFLS6xK9mytePAdI9VvuG//QuzRniybZHb
	 1yuWWP3vcJmCNP8aIuM16sVDlHOr6lC2XEH+JCUVk1WLmy2ThXQn0uayItLSXAx7Li
	 2G61rwz4/VH44nirA+j2Uh2Im5VqOuGohEwkKtZ/ZUB8oYGmfoI1kwcjpJRin0HwuR
	 JTP743OJi9WgIl6ZC4l+rH2HVHV1+uLoPXorMcWZzhMu0hDnsAHjpzlVz2eBD5xr2a
	 2bXw1EVBSTIhxjb28iDFFZVKlUZl9SKtLX0ns0QEGswQe0yQ35esvVYRx6UbvpKDvj
	 VUafa8i8bfIYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/17] KVM: riscv: selftests: Add csr emulation test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-14-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-14-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:58:53 +0000
Message-Id: <20260708035854.485EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unaligned trap vector in `check_test_csr_guest` leads to an infini=
te exception loop.
- [Medium] Missing check for the RISC-V F (Floating-Point) extension causes=
 spurious test crashes on non-F systems.
--

--- Patch [14]: [PATCH v3 14/17] KVM: riscv: selftests: Add csr emulation t=
est ---
commit de141f953203428fe244492005f127de5ea224f3
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

KVM: riscv: selftests: Add csr emulation test

Introduce a kvm test that uses the emulated test csr to validate that
all emulated reads/writes to csrs function as expected.

> diff --git a/tools/testing/selftests/kvm/riscv/csr_test.c b/tools/testing=
/selftests/kvm/riscv/csr_test.c
> new file mode 100644
> index 0000000000000..bdedf7c84001c
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/riscv/csr_test.c
> @@ -0,0 +1,133 @@
[ ... ]
> +/*
> + * Use the fcsr as a U-mode accesible csr and compare against the custom=
 'test'
> + * hypervisor csr (currently using vsscratch)
> + */
> +#define test_csr(write, initial, mode)								\
> +static void test_##write(void)									\
> +{												\
> +	unsigned long hypervisor_result, reference_result, old_hypervisor;			\
> +	asm volatile (										\
> +		"csrs	sstatus, %[enable_fp]\n"						\
> +		"csrw	fcsr, %[init]\n"							\
> +		#write"	zero, fcsr, %[mask]\n"							\
> +		"csrr	%[ref_res], fcsr\n"							\

[Severity: Medium]
Will this test crash on systems lacking the RISC-V F (Floating-Point)
extension?

The test unconditionally writes to and reads from fcsr in test_csr(). On
hosts without the F extension, accessing fcsr will generate an illegal
instruction trap. Since this trap isn't caught, the selftest exception
handler will terminate the test rather than skipping gracefully.

Should main() verify KVM_RISCV_ISA_EXT_F is available before executing
the tests that depend on it?

[ ... ]
> +static void check_test_csr_guest(void)
> +{
> +	unsigned long scause, stvec;
> +
> +	asm volatile(
> +		".option push\n"
> +		".option norvc\n"
> +		"la	%[stvec], 1f\n"
> +		"csrw	stvec, %[stvec]\n"
> +		"csrwi	%[test_csr], 0x0\n"
> +		"1:\n"

[Severity: High]
Could this lead to an infinite exception loop due to an unaligned trap
vector?

The label 1: is used as the exception vector in check_test_csr_guest(),
but it lacks a .align 2 or .balign 4 directive.

The stvec register requires 4-byte alignment. If the compiler aligns the
inline assembly block such that 1: lands on a 2-byte boundary, writing
to stvec will mask the lower bits. When the csrwi instruction traps, the
CPU will jump to the masked address, which could land in the middle of
the instruction.

This immediately triggers another illegal instruction trap, leading to a
soft lockup and hanging the test suite.

Can a .balign 4 be added before the label to ensure proper alignment?

> +		"csrr	%[scause], scause\n"
> +		".option pop\n"
> +		: [scause] "=3D&r" (scause), [stvec] "=3D&r" (stvec)
> +		: [test_csr] "i" (CSR_TEST)
> +	);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D14
