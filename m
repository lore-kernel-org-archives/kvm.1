Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517231;
	b=b5oRAgqvSJWuyvh+tx5w46ZTQrKiGtjMcFoPRAtfB5rDwrHwHdWeKmPuol9vlGHUhrx5
	 4h032HYMwS8zViO6B6mdvY9LGW6SM5BvVa488DqboIzIMj10wmlhFCK+CnIKCNJORtoEF
	 wSKARartcixEbb8GJ89iaXcY2X0gtCRCBBwtFrkK9BManY/AtREO3irSe7qJoVpfbBFI+
	 5OYBdlhdX9vDs3cC7/90WP1cEZvkhJmVaTID3vs7bdykb2XCOtj5MisRhxTAADEdNUYDu
	 ap6F+4F8+T8TN+yLLtZtJZNQbzCMg/gUQHMY7xK3hkwqVyxbU5U4sPjCbNsor9T8kgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517231;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VHaHU+bVMbG5rp/L3ZR3Vh4L196H50+Ilr7EizST4+w=;
	b=bP43g1f2SgrJsF+wE92Kp6pnIBq9hCr+y0ew+A0EwBtpGv9eNbOQ7BImhPZCnZUBlODw
	 PtYVBZKyhu12pWG/H+trONPkHVmOm3856u1kXM7ZhTUCYk4Ejmez/nHmz6oYaHblr7Yvw
	 PyriR1lfs6+L/HFS8WwcS/r9FJbhEx6sWVDZqRp0PsFYv/+BxEfDbgm1WrywAAdMjOL0O
	 Kadu5xVczUPN3ulCnRAqd6nCfE7PelwgZ9iuzEgUA+1rqGROFXI6atw/I7bZIaDIBjyRM
	 uMw2gRgAXHdPti45wKn62I8VNCBgQPSSSISKHcrcjsQJtvXEoG6cKiQwTvXXYjC2siA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNuJx0ST;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E720606A321
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNuJx0ST
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E5D1F000C4;
	Thu, 12 Nov 2026 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794517230;
	bh=VHaHU+bVMbG5rp/L3ZR3Vh4L196H50+Ilr7EizST4+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gNuJx0STOjmbMJDFwYuQ+7+Y/EsWMFGVjHTXmzEd8gj4FqMwl8M7eGwuSHNGc5K3A
	 iz42mxjuzg1HV5B7xV0JZRT3FctbkLMuGCN0wQQYtpPWPyPdbyOhdNseb0yFtOhc5j
	 J61tP0Y/pge7C4uvkd1pVDcb1T5p6gVoy4jtEpqq8wEVoQyVJhVsbNP0+wz/3qfeOx
	 207hyQx3MMBDaQ5HYs0Pzb7NLx9rfxYxD0We6aGwrgZr3whIl2RBMjiN+0oZKutAvT
	 v+3VG4NfgPz3tWw9h1qTK6otJaPnaS63Ktdw0UV2a4C9BW4YNahIFMaeNm0aQX9n6s
	 QjqeX+OIj3QVw==
Message-ID: <sashiko-outbox-211841@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 21/21] KVM: selftests: Support fixed counters bitmap
 in pmu_counters_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261112203227.289379-22-zide.chen@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-22-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 21:00:30 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: selftests: missing EDX/ECX combinations in
  test_fixed_counters()
--

commit 3d8b2ca900bb2a01f5f9cee15fc9a12bc40184ad
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

KVM: selftests: Support fixed counters bitmap in pmu_counters_test

This commit updates this_pmu_has() to check the guest PMU version before
consulting CPUID.0AH:ECX and updates test_fixed_counters() to test
supported fixed counter bitmasks alongside CPUID.0AH:EDX[4:0].

> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/=
testing/selftests/kvm/x86/pmu_counters_test.c
> index c3e784e16348c..61e6fe5b6ef48 100644
> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c

[ ... ]

> @@ -631,25 +632,43 @@ static void __test_fixed_counters(struct kvm_vcpu *=
vcpu, u8 nr_fixed_counters,
>  static void test_fixed_counters(u8 pmu_version, u64 perf_capabilities)
>  {
>  	u8 nr_fixed_counters =3D kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COU=
NTERS);
> +	unsigned long fixed_subset;
>  	struct kvm_vcpu **vcpus;
>  	struct kvm_vm *vm;
> +	u32 fixed_bitmap;
>  	int i =3D 0;
> -	u32 k;
>  	u8 j;
> =20
>  	pr_info("Testing %u fixed counters, PMU version %u, perf_caps =3D %lx\n=
",
>  		nr_fixed_counters, pmu_version, perf_capabilities);
> =20
> +	fixed_bitmap =3D BIT(nr_fixed_counters) - 1;
> +	if (pmu_version >=3D 5)
> +		fixed_bitmap |=3D kvm_cpu_property(X86_PROPERTY_PMU_FIXED_COUNTERS_BIT=
MASK);
> =20
> -	vm =3D pmu_vm_create_with_vcpus((nr_fixed_counters + 1) * BIT(nr_fixed_=
counters),
> +	/* One vCPU per subset of fixed_bitmap, plus one per legacy EDX test. */
> +	vm =3D pmu_vm_create_with_vcpus(BIT(__builtin_popcount(fixed_bitmap)) +=
 nr_fixed_counters,
>  				      guest_test_fixed_counters,
>  				      pmu_version, perf_capabilities, &vcpus);
> =20
> -	for (j =3D 0; j <=3D nr_fixed_counters; j++) {
> -		for (k =3D 0; k <=3D (BIT(nr_fixed_counters) - 1); k++)
> -			__test_fixed_counters(vcpus[i++], j, k);
> +	for (fixed_subset =3D 0; fixed_subset <=3D fixed_bitmap; fixed_subset++=
) {
> +		u32 nr_contiguous;
> +
> +		/*
> +		 * The loop walks all values from 0 to fixed_bitmap, so skip any
> +		 * value that is not a subset of fixed_bitmap.
> +		 */
> +		if (fixed_subset & ~fixed_bitmap)
> +			continue;
> +
> +		nr_contiguous =3D find_first_zero_bit(&fixed_subset,
> +						    MAX_NR_FIXED_COUNTERS);
> +		__test_fixed_counters(vcpus[i++], nr_contiguous, fixed_subset);
>  	}
> =20
> +	for (j =3D 1; j <=3D nr_fixed_counters; j++)
> +		__test_fixed_counters(vcpus[i++], j, 0);
> +
>  	pmu_vm_free(vm, vcpus);
>  }

[Severity: Medium]
Does deriving nr_contiguous from fixed_subset drop test coverage for fixed
counters enabled solely via CPUID.0AH:ECX when EDX[4:0] is 0?

Whenever bit 0 of fixed_subset is set, find_first_zero_bit() returns at
least 1, and the second loop only tests supported_bitmask =3D=3D 0 with j >=
=3D 1.
As a result, fixed counter 0 (and any contiguous prefix of fixed_subset
starting at bit 0) is never tested with nr_fixed_counters =3D=3D 0 and ECX[=
i]
set, nor does a guest with pmu_version < 5 get tested with EDX[4:0] =3D=3D 0
and a non-zero contiguous ECX mask to verify that KVM ignores ECX.

In addition, gating X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK on
pmu_version >=3D 5 skips non-contiguous host ECX bits when testing guest
pmu_version < 5, so the test never verifies that KVM ignores those bits on
older PMU versions.  Keeping the outer loop over j in 0..nr_fixed_counters
and the inner loop over subsets of an unconditionally constructed
fixed_bitmap would cover all (EDX[4:0], ECX) combinations across all PMU
versions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112203227.2893=
79-1-zide.chen@intel.com?part=3D21
