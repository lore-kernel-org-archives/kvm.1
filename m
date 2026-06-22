Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F31E351C2D
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 04:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782101902; cv=none; b=CR5nsHI8ZAFgx2DjwctOs49MqRGSPiLUcwo9jN/S73pzis6xCYNIwMmUw3SzVIw7cQ9y+DREtgvKCbfPJNbP7Fm+RrkyQfif9M+xECflPrBP50inU6cwAWYQJioDAslptHAInkOUWaIjbjD2p2VJl1wPoqc33hPM/u09xQqcEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782101902; c=relaxed/simple;
	bh=LsTuEP52/0UZkwdnSdEc+1NLLUpNbSGxX76G+H10ZQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tPt/+ELL+bPCifEoj2FBjsLt74YWcf4w7faXqqkZYK39Kk3xGFFCCRUWbRK7Y6RZbOq1rpfqzeRXq6aXMdSVtfA2bFrmV/1D08xfj4CRTeojIIXXIDOfyaqVvUPRgiJny5Jqn6Jmv39T/W6OCrLUpbp6K0O0dQ2unK5ZPCZ3C2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMAOevwS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMAOevwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC491F00A3E;
	Mon, 22 Jun 2026 04:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782101901;
	bh=21JgXcfiad4wBSAqXnJJJi5Yurt6CAg1Ce/k6DEjTDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mMAOevwS7y/G8/Js5qTk8b+099xIqphJNDSurGSQNhwfkvsP/nW7sN1eRB+iZ80gu
	 ZXPxB8sSK49NyssQafiO1XZeMWEkRZcp/PO8uTm3XCtWBtKjh7mpO7I9FDsf8RYo5A
	 ZCZnAoDcsT8Voez7lHwnJ3UKgoqfDqwbU7v9MV2kFWg6k+tiQ1nrM6sju0TxYIJLzI
	 V1SxzsBYj94FOenLA+QWmNOS+fOHd7Rt8bB6nZyclszHjYsNvAsamHStJ0fnvo9NoN
	 P105mwA1DMI3n1zKzFmLLO3mr3lAoVVNwLWwOks/o6aqLaHpr+6xfV5TA3yP2YjmA+
	 ACgwZDYpMVyFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/16] KVM: riscv: selftests: Add mmio test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins via B4 Relay" <devnull+thecharlesjenkins.gmail.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260621-riscv_insn_table-v2-10-7f0810ee2274@gmail.com>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-10-7f0810ee2274@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:18:20 +0000
Message-Id: <20260622041820.DFC491F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:

New issues:
- [High] The test pattern for MMIO writes uses a 32-bit literal, causing it=
 to evaluate to 0 when shifted on 64-bit architectures.
- [Medium] The compressed store instruction `c.sdsp` is entirely omitted fr=
om the test suite.
- [Medium] Standard 16-bit loads (`lh` and `lhu`) are erroneously restricte=
d to 64-bit RISC-V builds.
- [Medium] The KVM device file descriptor returned by `kvm_create_device` i=
s leaked, which also leaks the KVM VM.
- [Medium] The selftest fails to gracefully skip when KVM_DEV_TYPE_TEST is =
not supported by the kernel.

Pre-existing issues:
- [Critical] The KVM MMIO test device contains a heap buffer overflow and o=
ut-of-bounds read vulnerability due to a mismatch between the registered de=
vice size and its internal cache array capacity.
- [Critical] The mmio_test device fails to unregister itself from the KVM M=
MIO bus upon release, leading to a Use-After-Free vulnerability.
- [High] `mmio_test_create()` registers the device to the KVM IO bus withou=
t holding the required `kvm->slots_lock`.
- [High] The error cleanup path in `kvm_init()` unwinds initializations in =
the wrong order.
- [High] The return value of `kvm_io_bus_register_dev()` is ignored, potent=
ially leaking an unregistered device.
- [High] The `struct kvm_device` allocated for the test device is permanent=
ly leaked.
--

commit 91109e879d023e4a9b60888f79545187037508bf
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>
KVM: riscv: selftests: Add mmio test

This commit adds a new MMIO selftest for KVM on RISC-V. It introduces test
cases for various read and write instructions, including compressed
instructions, to ensure KVM properly emulates MMIO accesses.

> diff --git a/tools/testing/selftests/kvm/riscv/mmio_test.c b/tools/testin=
g/selftests/kvm/riscv/mmio_test.c
> new file mode 100644
> index 0000000000000..9726860a269a3
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/riscv/mmio_test.c
> @@ -0,0 +1,184 @@
[ ... ]
> +test_standard_read(4, lw, lw, "")
> +test_standard_read(4, c.lw, c_lw, ".option arch,+c\n")
> +test_sp_read(4, c.lwsp, c_lwsp)
> +
> +#if __riscv_xlen =3D=3D 64
> +test_standard_read(2, lh, lh, "")
> +test_standard_read(2, lhu, lhu, "")

[Severity: Medium]
Are lh and lhu intentionally restricted to 64-bit architectures here?

Since these are standard 16-bit loads in the RV32I base instruction set,
should they be moved outside the __riscv_xlen =3D=3D 64 check so they are a=
lso
tested on 32-bit platforms?

> +test_standard_read(4, lwu, lwu, "")
> +test_standard_read(8, ld, ld, "")
[ ... ]
> +#define test_standard_write(len, write, read, name, options)					\
> +static void test_##name(void)									\
> +{												\
> +	unsigned long result;									\
> +	unsigned long reference =3D (0x55555555UL >> ((sizeof(long) - len) * 8)=
);			\

[Severity: High]
Does this bitwise shift evaluate to 0 on 64-bit systems?

When __riscv_xlen =3D=3D 64, sizeof(long) is 8. For a 32-bit store (len=3D4=
),
this shifts 0x55555555UL right by 32 bits, resulting in 0.

For len=3D1 and len=3D2, it shifts by 56 and 48 bits, also resulting in 0.

Could this mask sign-extension or truncation issues by only ever verifying
a value of 0?

Should this use a 64-bit literal like 0x5555555555555555ULL instead?

> +	/* Check that we can write and then read the same value. */				\
> +	asm volatile (										\
[ ... ]
> +#define test_sp_write(len, write, read, name)							\
> +static void test_##name(void)									\
> +{												\
> +	unsigned long result;									\
> +	unsigned long tmp;									\
> +	unsigned long reference =3D (0x55555555UL >> ((sizeof(long) - len) * 8)=
);			\

[Severity: High]
Similar to test_standard_write, does this shift evaluate to 0 on 64-bit
systems for compressed stack-pointer relative writes?

> +	/* Check that we can write and then read the same value. */				\
[ ... ]
> +static void run(void *guest_code, char *instruction)
> +{
> +	struct ucall uc;
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> +	kvm_create_device(vm, KVM_DEV_TYPE_TEST);

[Severity: Medium]
Does this test need to gracefully skip if KVM_DEV_TYPE_TEST is unavailable?

kvm_create_device() uses TEST_ASSERT internally and will abort the test
if the kernel lacks support.

Would it be safer to check support with __kvm_create_device() and use
TEST_REQUIRE() to exit with a skip code in CI environments running older
kernels?

[Severity: Medium]
Does this leak the KVM device file descriptor returned by kvm_create_device=
()?

Since the file descriptor holds a reference to the KVM VM (kvm_get_kvm),
failing to close it will prevent the VM from being destroyed when
kvm_vm_free(vm) is called.

Since run() iterates for multiple instructions, will this accumulate file
descriptor and kernel memory leaks?

> +
> +	virt_map(vm, (unsigned long)MMIO_TEST_REGION, MMIO_TEST_REGION, 1);
[ ... ]
> +void test_mmio_read_sign_extension(void)
> +{
> +	run(test_lb, "lb");
[ ... ]
> +	run(test_c_lwsp, "c.lwsp");
> +
> +#if __riscv_xlen =3D=3D 64
> +	run(test_lh, "lh");
> +	run(test_lhu, "lhu");

[Severity: Medium]
Are the executions for lh and lhu also intentionally restricted to 64-bit
builds here?

> +	run(test_lwu, "lwu");
[ ... ]
> +void test_mmio_write(void)
> +{
> +	run(test_sb, "sb");
> +	run(test_sh, "sh");
> +	run(test_sw, "sw");
> +	run(test_c_sw, "c.sw");
> +	run(test_c_swsp, "c.swsp");
> +
> +#if __riscv_xlen =3D=3D 64
> +	run(test_sd, "sd");
> +	run(test_c_sd, "c.sd");

[Severity: Medium]
Is the compressed store instruction c.sdsp omitted from the 64-bit write
tests?

The commit message notes that all emulated load and store instructions are
checked, but c.sdsp appears to be missing an instantiation via
test_sp_write and execution via run(test_c_sdsp, "c.sdsp").

> +#endif
> +}

While reviewing how this selftest interacts with KVM_DEV_TYPE_TEST, I
noticed several pre-existing issues in the test device implementation itself
(virt/kvm/mmio_test.c and virt/kvm/kvm_main.c). I have included them here
for completeness:

virt/kvm/mmio_test.c:mmio_test_create():
    mmio_test->size =3D 0x16;

[Severity: Critical]
This is a pre-existing issue, but does mmio_test->size exceed the capacity
of the internal cache array?

The internal cache array is sized at 16 bytes (char cache[16];), but the
size field is initialized to 0x16 (22 bytes).

When a guest accesses an MMIO address near the end of the registered region,
the addr - start + len calculation inside mmio_write() and mmio_read()
can exceed 16.

Can this allow an unprivileged guest to trigger an out-of-bounds memcpy(),
leading to host heap corruption or information leaks?


virt/kvm/mmio_test.c:mmio_test_release():
static void mmio_test_release(struct kvm_device *dev)
{
    kfree(dev->private);
}

[Severity: Critical]
This is a pre-existing issue, but is there a use-after-free vulnerability h=
ere?

The release callback frees the backing dev->private structure, but it does
not call kvm_io_bus_unregister_dev().

The KVM MMIO bus retains a dangling pointer to the freed structure.

Will any subsequent MMIO access to the registered range by an active vCPU
dereference this freed pointer?


[Severity: High]
This is a pre-existing issue, but does mmio_test_release() leak the
struct kvm_device?

kvm_ioctl_create_device() dynamically allocates the struct kvm_device
using kzalloc().

The device implementation's .release or .destroy callback is responsible
for freeing this memory, but it appears to be omitted here.

Does this cause a permanent leak every time a test device is closed?


virt/kvm/mmio_test.c:mmio_test_create():
    kvm_io_bus_register_dev(dev->kvm, KVM_MMIO_BUS, mmio_test->start,
                            mmio_test->size, &mmio_test->dev);

[Severity: High]
This is a pre-existing issue, but is kvm_io_bus_register_dev() called
without holding the required kvm->slots_lock?

mmio_test_create() is invoked via kvm_ioctl_create_device(), which only
holds kvm->lock.

kvm_io_bus_register_dev() strictly requires kvm->slots_lock and enforces
it via lockdep.

Will this cause an immediate lockdep splat and a data race against concurre=
nt
MMIO bus updates?


[Severity: High]
This is a pre-existing issue, but is the return value of
kvm_io_bus_register_dev() safely ignored?

The function can fail (e.g., due to -ENOMEM or hitting NR_IOBUS_DEVS).

Since mmio_test_create() ignores the return value and unconditionally
returns 0, will userspace receive a valid fd for a device that was never
actually attached to the MMIO bus?


virt/kvm/kvm_main.c:kvm_init():
err_gmem:
    kvm_vfio_ops_exit();
err_vfio:
    kvm_mmio_test_ops_exit();
err_mmio_test:
    kvm_async_pf_deinit();

[Severity: High]
This is a pre-existing issue, but are the error unwinding labels interleaved
incorrectly?

kvm_init() initializes components in the order: VFIO, MMIO_TEST, and GMEM.

If kvm_gmem_init() fails, it jumps to err_gmem which executes
kvm_vfio_ops_exit() followed by kvm_mmio_test_ops_exit(), which is the
reverse of the correct unwinding order.

Furthermore, if kvm_vfio_ops_init() fails, it jumps to err_vfio and
attempts to exit mmio_test (which hasn't been initialized yet).

If kvm_mmio_test_ops_init() fails, it skips unwinding VFIO entirely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-riscv_insn=
_table-v2-0-7f0810ee2274@gmail.com?part=3D10
