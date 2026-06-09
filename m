Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3CD22AE48
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964876; cv=none; b=FoXsscEVpDc0b7+WR1ApbvmqaBZZRsV0H+q0FdJgmtNcaIeUdIYXVhELlvMBKY5Qba9QsFKrruTO+Ez6Xi9kfCk81fyx9ZtYzQaVm/G6ar/Piw8+dLj/h0rPa3+y/eCb+iWHHQpu/SuXzSZ3yKBLdjuZBN1YvksvnlSJ5KqCx1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964876; c=relaxed/simple;
	bh=CyJYhincpsBrKG8sShUbIi1gZBMNawPNKO3PYXaDcBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OnF8/mp8cph6C9XZbvulGFzf/I/UgODjnSv6vxGrSjJbHpY1X4f7U++g2Btny/Q1im/SwyXLYKEwf1b18YF9Kutvgu4V3OkbTyCVUslEd/FgNOy0JXIFyHuRMfrSVfjXGTSSMEDLln3X+i3uDOqK1qTS2f/b89LoYNRtxM324rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED5zfHVK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED5zfHVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDCA1F00893;
	Tue,  9 Jun 2026 00:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780964875;
	bh=JvnHB8m/bh10enuFs57QX/dTjgadl7+Isi9HLfzS1QU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ED5zfHVK+jNrokaw/zMjMHbjmVGP7iP5SGui3Vkp4g6mklGXwaU00m4riuFzB90oE
	 2QvKoyghxpObjfOQChG1V0f3C5+t7jIOcYzLho6V0oQ4cDW52NxWqCAG1no2QK4e9h
	 eYiZu3y9AMqMPzhF/+C/DuiqULqbi9QayITq1uv8H6hXMvAhcpETJjbglLatGZ8kgT
	 SS8eTs97OShcN8Gc+l6rXtkepXyatJ4h7fdro89Qa9XQLdZyGny4mR0OH+gEaASP4j
	 1oaI9jPWMmYTCecgmvMIraIcbIPWoBU77Mm+fTtIwueyxyiOYUfRkCGrCaOVHDRJ/I
	 7b1BA9KjS3B/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 28/34] KVM: selftests: Add Xen/generic CPUID timing
 leaf test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-29-dwmw2@infradead.org>
References: <20260608145455.89187-29-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 00:27:55 +0000
Message-Id: <20260609002755.6BDCA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Using kvm_vm_release() instead of kvm_vm_free() leaks the struct=
 kvm_vm and its memory tracking structures on each test iteration.
- [Low] KVM_VCPU_TSC_SCALE is undeclared in UAPI headers, causing a build f=
ailure.
--

commit 520a5187b17e7c7df17d704853e3e3ea37d182f3
Author: David Woodhouse <dwmw@amazon.co.uk>

Verify that userspace can correctly populate Xen and generic CPUID
timing leaves using the KVM_VCPU_TSC_SCALE and
KVM_VCPU_TSC_SCALE attributes.

This patch adds a KVM selftest to validate that removing KVM's runtime
Xen CPUID modifications does not break guests. It queries effective
frequencies, computes pvclock variables, and verifies that the guest CPUID
instructions return the expected values.

> diff --git a/tools/testing/selftests/kvm/x86/xen_cpuid_timing_test.c b/to=
ols/testing/selftests/kvm/x86/xen_cpuid_timing_test.c
> new file mode 100644
> index 000000000000..a0c262b8db89
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/xen_cpuid_timing_test.c

[ ... ]

> +static void run_test(uint64_t tsc_khz)
> +{

[ ... ]

> +	/* If scaling wasn't applied, skip this frequency */
> +	if (tsc_khz && effective_tsc_khz =3D=3D host_khz) {
> +		pr_info("  TSC scaling not available, skipping\n");
> +		kvm_vm_release(vm);

[Severity: Medium]
Should this be a call to kvm_vm_free() instead of kvm_vm_release()?

In KVM selftests, kvm_vm_release() only closes file descriptors.

Calling it here leaves the struct kvm_vm and its associated memory structur=
es
dynamically allocated, which causes a memory leak on each skipped or
completed test iteration.

> +		return;
> +	}

[ ... ]

> +	switch (get_ucall(vcpu, &uc)) {
> +	case UCALL_ABORT:
> +		REPORT_GUEST_ASSERT(uc);
> +		break;
> +	case UCALL_SYNC:
> +		break;
> +	default:
> +		TEST_FAIL("Unexpected ucall");
> +	}
> +
> +	kvm_vm_release(vm);

[Severity: Medium]
As mentioned above, does this code leak the struct kvm_vm and its tracking
structures?

Using kvm_vm_free() here would free the tracking structures in addition to
closing the fds.

> +}
> +
> +int main(void)
> +{
> +	uint64_t freq;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct kvm_device_attr attr =3D {
> +		.group =3D KVM_VCPU_TSC_CTRL,
> +		.attr =3D KVM_VCPU_TSC_SCALE,

[Severity: Low]
Does this break the build due to KVM_VCPU_TSC_SCALE being undeclared?

It appears KVM_VCPU_TSC_SCALE isn't defined in the UAPI headers.

There is a hardcoded fallback 1 used earlier in run_test() that avoids
this issue, but it seems to have been missed here.

> +	};
> +
> +	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
> +
> +	/* Check KVM_VCPU_TSC_SCALE is supported (implies TSC scaling) */
> +	vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> +	TEST_REQUIRE(!__vcpu_ioctl(vcpu, KVM_HAS_DEVICE_ATTR, &attr));
> +	host_khz =3D __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
> +	kvm_vm_release(vm);

[Severity: Medium]
Similarly, could this leak the capability check VM?

It seems kvm_vm_free() is the intended cleanup function here.

> +
> +	/* Native frequency */
> +	run_test(0);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D28
