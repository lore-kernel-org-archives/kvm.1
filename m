Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B51E28504D
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 04:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102284; cv=none; b=UdH4IpVfXJdQKD7o0Fuz3hE/ow1jJ9+qS/tqknocqCyvQbf7drmUlvMMtKPWMo3ALKbhFtB/LnJ/sRUK3Ev7lM5CEyd7mwJGXDqq0iLsZhGoJMew7C6z601br4j6Sos9WH+pl0Ah+6PhWI7FE1YfB61HYyAUaqyYQjuewGfHT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102284; c=relaxed/simple;
	bh=x2+ZDNl7cFyITOq+Yc/dCnlkz3adgyAAXFNamVd1XDc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G9izXLBcrApcwW8Ag+oeFFS0IVOG38WVFPUPd2U8+ZigAVEknm8vAmnj5q8t9M/L1A5W2KS6x7aEVKsSDVgqNCS8J6fZMTJkWI3cCfid3QKDCquyOlmh4qMUk3MYsyrvvKYYlm9o+EBxbo7c1FAOWQdjdJFTPoChxCWYDWc2uYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHFgPFVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHFgPFVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20A21F000E9;
	Mon, 22 Jun 2026 04:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782102282;
	bh=TGpIxOUTS7it1pHBHjKqwdx7N82W4OjQTRmdLNyDTs8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BHFgPFVnbCBREpBpRdTmzqe0aHQwpOft8nW7VQE88uy324kiY7SKpD1o09CTtVD6J
	 roDW8JjTHU6KKndz8f07NgyqONv4sjGU/jGk3AO4M4G0Hu7HE1PnFJ4/Q1x+V3NnPo
	 JD0LKGq9I8KeWRsNk/6bRWM3EhLAOc/dteaCU8vRUiasM0vWsErWsXVV8S6yb2HvOH
	 VN7/7ArwnBTBH1hV9A8bDtJLcMYn847Q2Xn6iDnDPMMTlgZco2ZF0QYe37bKiiGXqJ
	 z60l7oRVJto4HkXKE3QZDLirIFUFXE/1DLUOYejot6NGMZvB0/N9wcs+cDDSjwJqHe
	 YlFWTOKtyNplA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/16] KVM: riscv: selftests: Add csr emulation test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins via B4 Relay" <devnull+thecharlesjenkins.gmail.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260621-riscv_insn_table-v2-13-7f0810ee2274@gmail.com>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-13-7f0810ee2274@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:24:42 +0000
Message-Id: <20260622042442.A20A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The `kvm_create_device` wrapper is incorrectly used for feature pr=
obing, which turns an intended graceful skip into a hard assertion failure.
- [Medium] The test unconditionally manipulates the floating-point CSR (`fc=
sr`) and `sstatus.FS` without checking if the F (Floating-Point) extension =
is supported.
- [Medium] File descriptors returned by `kvm_create_device()` are leaked on=
 every successful execution.
- [Medium] Missing `.align 2` directive for the `stvec` target label risks =
creating an infinite exception loop.
- [Low] A local C variable is passed to an inline assembly block using the =
`"i"` (immediate) constraint, violating C compiler requirements and causing=
 build failures.
--

commit 9c090464385301d04ee38fa944d2379ab3dfd21a
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

KVM: riscv: selftests: Add csr emulation test
   =20
Introduce a kvm test that uses the emulated test csr to validate that
all emulated reads/writes to csrs function as expected.

> diff --git a/tools/testing/selftests/kvm/riscv/csr_test.c b/tools/testing=
/selftests/kvm/riscv/csr_test.c
> new file mode 100644
> index 0000000000000..b3e8b99b6e923
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/riscv/csr_test.c

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
> +	unsigned long mask =3D 0x15;								\
> +	asm volatile (										\
> +		"csrs	sstatus, %[enable_fp]\n"						\
> +		"csrw	fcsr, %[init]\n"							\

[Severity: Medium]
Does this code unconditionally manipulate the floating-point CSR (fcsr) and
sstatus.FS without checking if the F (Floating-Point) extension is supporte=
d?

On RISC-V targets lacking the F extension, accessing fcsr will raise an
illegal instruction exception and crash the test. Should there be a probe f=
or
the F extension (e.g., via KVM_RISCV_ISA_EXT_F) before proceeding?

> +		#write"	zero, fcsr, %[mask]\n"							\
> +		"csrr	%[ref_res], fcsr\n"							\
> +		: [ref_res] "=3D&r" (reference_result)						\
> +		: [enable_fp] "r" (FP), [mask] #mode(mask), [init] "r" (initial)		\

[Severity: Low]
Is it safe to pass the local variable mask using the "i" (immediate)
constraint?

For tests like test_csrrwi, #mode(mask) expands to an "i" constraint, but
compilers like GCC and Clang require the operand for an "i" constraint to be
a compile-time constant expression. Does this cause an 'impossible constrai=
nt
in asm' build error with -O0 or when using Clang?

> +		: "memory"									\
> +	);											\

[ ... ]

> +static void run(void *guest_code, char *instruction)
> +{
> +	struct ucall uc;
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> +
> +	kvm_create_device(vm, KVM_DEV_TYPE_TEST);

[Severity: Medium]
Does this leak the file descriptor returned by kvm_create_device()?

The function returns a new file descriptor which is ignored here and never
explicitly closed. kvm_vm_free() only cleans up VM and vCPU file descriptor=
s.

> +
> +	vcpu_run(vcpu);
> +
> +	TEST_ASSERT(get_ucall(vcpu, &uc) =3D=3D UCALL_DONE,
> +		    "CSR instruction '%s' failed: '%s'", instruction,
> +		    uc.buffer);
> +
> +	kvm_vm_free(vm);
> +}
> +
> +static void check_test_csr_guest(void)
> +{
> +	unsigned long scause, stvec;
> +
> +	asm volatile(
> +		"la	%[stvec], 1f\n"
> +		"csrw	stvec, %[stvec]\n"
> +		"csrwi	%[test_csr], 0x0\n"
> +		"1:\n"

[Severity: Medium]
Could the lack of an .align 2 directive before the 1: label create an
infinite exception loop?

The RISC-V specification requires the stvec BASE address to be 4-byte
aligned. If the test is compiled with the Compressed extension, the 1: label
might reside at a 2-byte aligned boundary. When the hardware jumps to stvec,
it masks out the lower bits, potentially resuming execution at an invalid
offset.

> +		"csrr	%[scause], scause\n"
> +		: [scause] "=3D&r" (scause), [stvec] "=3D&r" (stvec)
> +		: [test_csr] "i" (CSR_TEST)
> +	);
> +
> +	/* An illegal instruction will be generated if CONFIG_RISCV_KVM_TEST_CS=
R is not enabled. */
> +	if (scause =3D=3D 2)
> +		GUEST_FAIL("CONFIG_RISCV_KVM_TEST_CSR not enabled.\n");
> +	GUEST_DONE();
> +}
> +
> +static int check_test_csr(void)
> +{
> +	struct ucall uc;
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +	int success;
> +
> +	vm =3D vm_create_with_one_vcpu(&vcpu, check_test_csr_guest);
> +
> +	/* Skip if CONFIG_KVM_MMIO_TEST not enabled */
> +	if (!kvm_create_device(vm, KVM_DEV_TYPE_TEST))
> +		exit(KSFT_SKIP);

[Severity: High]
Will this check crash with an assertion failure instead of gracefully
skipping?

The selftests wrapper kvm_create_device() internally asserts
TEST_ASSERT(fd >=3D 0, ...). If the host kernel does not support
KVM_DEV_TYPE_TEST, the ioctl returns a negative error code, triggering the
assertion rather than reaching the exit(KSFT_SKIP) path.

Also, on success, it returns a valid file descriptor (fd > 0), which
evaluates to true and bypasses the skip. Shouldn't we use
__kvm_test_create_device() or __kvm_create_device() to probe safely without
asserting?

[Severity: Medium]
Similar to the call in run(), does this also leak the file descriptor retur=
ned
by kvm_create_device() if the device creation is successful?

> +
> +	vcpu_run(vcpu);
> +
> +	success =3D get_ucall(vcpu, &uc) =3D=3D UCALL_DONE;
> +
> +	kvm_vm_free(vm);
> +
> +	return success;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-riscv_insn=
_table-v2-0-7f0810ee2274@gmail.com?part=3D13
