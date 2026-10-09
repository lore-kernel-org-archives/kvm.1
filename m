Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E743DEC7
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551498; cv=none; b=RuD4+uwhPSjjiiyK83kW+ksTbWPow2KeG4ce7rpFCHtpS15TP1rGEoptc+Lukqw++cO/RANm2g7/MaJotJNO4+jH1CFToCpYDrSmIVWgWvLqzyOqSR9WL4RnOqD148ym+15/woozbll3p6AYVfDNRFmlOizcGW2MadedWXgf14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551498; c=relaxed/simple;
	bh=8WVvmUjTXoMbdyVBpGpz2Dtdzid6a0wSqsgzmGHqCk0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K4MATyPBGUEV8O6ht4T/SFBza49T9bjtznpEvZkVFjRpZCG4V03Nw5wUYehAchDjTydxvox8tH6NFTmOSnjuXAF9yiRBjEB7uXYWWQAUZ8OIw5WSX6NY4q4u81ciEUG94V1RzL7QDoG6MwJN7dgPIcgH4ZodIQYZfUQ/sYUHH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSOYlXPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSOYlXPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3881F00898;
	Fri,  9 Oct 2026 13:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791551497;
	bh=L6A9Ek0062NjmD6A2fBTXgz80sgVBRuk+Dc3DvO0meE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VSOYlXPJoYAcUujz8qy1Xqr+N9nuibxwf1NHNIYO16QaZYmzMRgP7m9WTGQDSGQd/
	 dPA9K+lveZSr893SEMZ7IYHvGFtLAfnv6bA6anDWWcNLZw+Pm9CIHmh1hkFe/2lEh0
	 5BcmRq/FNiRGvZCPyA0Jc0sZGTh9mKSlcCbvkFKPMOT9NOZC0V4OJfjO4SrqEFDd5e
	 XYVS6Qhm2Cw3wpeQmPlKe0MwdwlfsUWul9tlLsyKD3tW896qZjnFcdr9u8zJJI06H1
	 Uxw+KFlpkv7SlI+7jJfpEM3yXs5cNjcgLvwnEmehnOcMyGLXFHe5Gnz8M3JebTzHqk
	 JY+QXIRLDW+bg==
Message-ID: <sashiko-outbox-165604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] KVM: selftests: memstress: Add option to enable
 dirty-ring on VM creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leonardo Bras" <leo.bras@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261009130054.3312154-4-leo.bras@arm.com>
References: <20261009130054.3312154-2-leo.bras@arm.com>
 <20261009130054.3312154-4-leo.bras@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:11:37 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: selftests: missing KVM_MAX_VCPUS bounds check in memstress_vm=
_create_with_vcpus()
--

commit 8f8ed5a2bb5936b315dc077d1f97ad188346d5a2
Author: Leonardo Bras <leo.bras@arm.com>

KVM: selftests: memstress: Add option to enable dirty-ring on VM creation

This commit adds an option to memstress_create_vm() to take a dirty-ring si=
ze
and enables it before vCPU creation. It introduces a new function
memstress_vm_create_with_vcpus() to handle this setup correctly.

> diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/=
selftests/kvm/lib/memstress.c
> index 880657df65e9e..b1f13499e85f4 100644
> --- a/tools/testing/selftests/kvm/lib/memstress.c
> +++ b/tools/testing/selftests/kvm/lib/memstress.c
> @@ -121,6 +121,27 @@ void memstress_setup_vcpus(struct kvm_vm *vm, int nr=
_vcpus,

[ ... ]

> +static struct kvm_vm *memstress_vm_create_with_vcpus(struct memstress_pa=
rams *params,
> +						     u64 extra_mem_pages)
> +{
> +	struct kvm_vm *vm;
> +	int i;
> +
> +	TEST_ASSERT(params->nr_vcpus > 0, "Invalid number of vCPUs (%d)",
> +		    params->nr_vcpus);
> +
> +	vm =3D __vm_create(VM_SHAPE(params->mode), params->nr_vcpus, extra_mem_=
pages);
> +
> +	if (params->dirty_ring_size)
> +		vm_enable_dirty_ring(vm, params->dirty_ring_size);
> +
> +	for (i =3D 0; i < params->nr_vcpus; ++i)

[Severity: High]
Can this loop overflow the statically sized vcpus array?

The vcpus array is bounded by KVM_MAX_VCPUS (512). When a user runs a
memstress-based test with an argument greater than 512 on a host kernel whe=
re
KVM_CAP_MAX_VCPUS is greater than 512, or runs mmu_stress_test on a host wi=
th
more than ~682 physical cores, the option parser checks against
KVM_CAP_MAX_VCPUS but not against KVM_MAX_VCPUS.

Passing this unbounded params->nr_vcpus value to
memstress_vm_create_with_vcpus() will blindly write past the end of the vcp=
us
array, causing memory corruption and crashing the selftest.

> +		vcpus[i] =3D vm_vcpu_add(vm, i, memstress_guest_code);
> +
> +	kvm_arch_vm_finalize_vcpus(vm);
> +	return vm;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009130054.3312=
154-2-leo.bras@arm.com?part=3D2
