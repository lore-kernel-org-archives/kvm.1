Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65873115AF
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483151; cv=none; b=lavVZjvD3A3alf4nHuKTo90fgl55qipdprjk+kR5Xe+2dMac+ETDQB+YFi+Nxs7FMj+XSeGQlcJH4Xbeud1cnZ68rius8k/DKQ5si7Bi2tpyGEwz5RM8Y/TvCtmh/+DTnj00bS7GyuiUENv3PEv6G8Mdclqv6iK+eyXvR8aKVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483151; c=relaxed/simple;
	bh=sKOmlNO8YhusLqNkM7e85NDAv+uxTh+5tck4kIQmDsY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FBiQMVK6dhz8XZ8pudVbSfO7S9uiFL3PlkQ1tkpFBONtvn4PR9Lv8+zqWON3BvNRzX0I0+vOpKMklX7ljG3Tlb4N7AZdnEtlpgk9h+2zhbf8beaaDIqFd+iVwLWpXyysBEsRH8Pud8s5acA15SevCiTh1I9A44/DOk2sl3b9KaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1XruMx2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1XruMx2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0664E1F000E9;
	Wed,  8 Jul 2026 03:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783483150;
	bh=UrUIgxE+1YFTAqzT3AWPp3Gh1UujxG4lHgWq/oIlQ4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f1XruMx2FiS0i209NXyHBQM4i5VGsV9VUrpzln10lAHicxwY0cQpHEEErTAZnIkWl
	 N/8mPHtUxyDi4N87lbCWNZSKYmGXvHFm2/38HNLBYxNFt/2/UJlhgQGzxt7hEj/qmL
	 flcKP7rYTdWOrVSclTC6VHFZhx2pcB3MOjG9CB+W2B0JM72L2loEURxoSuACKmiyjL
	 rS4GLQXRrpkouyS1Nuldn0DpDc46+pLIYVmaeUF+V4uyPePMY9DL02iQ5UKkM+Jh/k
	 S+D58BwoSV/Zu0rgcL4YDG47N6P6s3+umxDR9mJlocE7FMz+qQgLJGuiXJ6L0XTOP4
	 vcKRYmXSAvEWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/17] KVM: riscv: selftests: Add mmio test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-11-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-11-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:59:09 +0000
Message-Id: <20260708035910.0664E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The selftest unconditionally creates a KVM_DEV_TYPE_TEST device =
without checking for host support, causing hard failures on standard kernel=
s.
- [Medium] Missing "memory" clobber in inline assembly allows compiler to r=
eorder or eliminate MMIO stores and local variable initializations.
- [Low] Overly broad inline assembly constraints for RISC-V compressed inst=
ructions will cause intermittent assembler errors.

Pre-existing issues:
- [High] The KVM MMIO test device fails to unregister its MMIO bus device o=
n teardown, leading to a Use-After-Free when the memory is subsequently fre=
ed.
--

--- Patch [11]: [PATCH v3 11/17] KVM: riscv: selftests: Add mmio test ---
commit 39a55e4a273642e2ad8e96502e3f7d6eb84c69ad
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

KVM: riscv: selftests: Add mmio test

This commit adds a test to validate that KVM properly emulates reads
and writes to a KVM test device. It checks all load and store
instructions emulated by KVM for RISC-V.

> diff --git a/tools/testing/selftests/kvm/riscv/mmio_test.c b/tools/testin=
g/selftests/kvm/riscv/mmio_test.c
> new file mode 100644
> index 0000000000000..ea3837771a333
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/riscv/mmio_test.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0-only
[ ... ]
> +#define test_standard_read(len, instruction, name, options)					\
> +static void test_##name(void)									\
> +{												\
> +	unsigned long mmio_result, reference_result;						\
> +	/* Configure the MMIO to return 0xff for each byte to check sign extens=
ion */		\
> +	unsigned long reference =3D ((unsigned long)-1 >> ((sizeof(long) - len)=
 * 8));		\
> +	*((unsigned long *)MMIO_TEST_REGION) =3D reference;					\
> +	/* Check that reads through MMIO are equivalent to standard reads. */		=
	\
> +	asm volatile (										\
> +		".option push\n"								\
> +		options										\
> +		#instruction "	%[mmio_res], 0(%[region])\n"					\
> +		#instruction "	%[ref_res], 0(%[ref])\n"					\
> +		".option pop\n"									\
> +		: [mmio_res] "=3D&cr" (mmio_result), [ref_res] "=3D&cr" (reference_res=
ult)		\
> +		: [region] "cr" (MMIO_TEST_REGION), [ref] "cr" (&reference)			\
> +	);											\

[Severity: Medium]
Since the pointer to MMIO_TEST_REGION lacks a volatile qualifier and the
asm volatile block lacks a "memory" clobber, can the compiler optimize away
or reorder the store to MMIO_TEST_REGION?

GCC's dead store elimination might eliminate the initialization store since
it does not see any memory inputs to the assembly block, which could cause
the guest to execute with uninitialized memory and fail intermittently.

[Severity: Low]
Will using the "cr" constraint cause intermittent assembler errors for
compressed instructions?

For instructions like c.lw and c.sw, the assembler strictly requires
registers in the x8-x15 range. If GCC allocates a general register outside
this range, will the GNU Assembler fail with illegal operands?

> +	GUEST_ASSERT_EQ(mmio_result, reference_result);						\
> +	GUEST_DONE();										\
> +}
> +
> +#define test_sp_read(len, instruction, name)							\
> +static void test_##name(void)									\
> +{												\
> +	unsigned long mmio_result, reference_result;						\
> +	unsigned long tmp;									\
> +	/* Configure the MMIO to return 0xff for each byte to check sign extens=
ion */		\
> +	unsigned long reference =3D ((unsigned long)-1 >> ((sizeof(long) - len)=
 * 8));		\
> +	*(((unsigned long *)MMIO_TEST_REGION)) =3D reference;					\

[Severity: Medium]
Similarly to test_standard_read(), could the missing "memory" clobber or
volatile qualifier here allow the compiler to eliminate the reference store?

[ ... ]
> +#define test_standard_write(len, write, read, name, options)					\
> +static void test_##name(void)									\
> +{												\
> +	unsigned long result;									\
> +	unsigned long reference =3D (0x5555555555555555ULL >> ((sizeof(long) - =
len) * 8));	\
> +	/* Check that we can write and then read the same value. */				\
> +	asm volatile (										\
> +		".option push\n"								\
> +		options										\
> +		#write "	%[ref], 0(%[region])\n"						\
> +		#read "		%[res], 0(%[region])\n"						\
> +		".option pop\n"									\
> +		: [res] "=3D&cr" (result)								\
> +		: [region] "cr" (MMIO_TEST_REGION), [ref] "cr" (reference)			\
> +	);											\

[Severity: Low]
Could the "cr" constraint also cause assembler errors here when the macro
is expanded for compressed instructions like c.sw and c.lw?

[ ... ]
> +static void run(void *guest_code, char *instruction)
> +{
> +	int fd;
> +	struct ucall uc;
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> +	fd =3D kvm_create_device(vm, KVM_DEV_TYPE_TEST);

[Severity: Medium]
If the host kernel does not have CONFIG_KVM_MMIO_TEST enabled, will
kvm_create_device() fail with -ENODEV and cause the test to abort?

Would it be better to dynamically check for capabilities and skip
gracefully (for example, by using TEST_REQUIRE() or similar test helpers)
instead of failing?


[Severity: High]
This is a pre-existing issue, but there appears to be a use-after-free
during teardown in virt/kvm/mmio_test.c.

In mmio_test_destroy():

virt/kvm/mmio_test.c:mmio_test_destroy() {
        ...
        struct mmio_test *mmio_test =3D kvm_to_mmio_test_dev(dev);
        ...
        kvm_io_bus_unregister_dev(dev->kvm, KVM_MMIO_BUS, &mmio_test->dev);
        kfree(dev->private);
}

Does kvm_to_mmio_test_dev() expect a struct kvm_io_device pointer rather
than a struct kvm_device pointer?

If so, container_of() might compute an invalid pointer, causing
kvm_io_bus_unregister_dev() to fail to unregister the actual mmio_test->dev.
When the structure is later freed, will this leave a dangling pointer in
the KVM MMIO bus that triggers a use-after-free on subsequent MMIO
accesses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D11
