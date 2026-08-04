Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FD93ABD8D
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877981; cv=none; b=HExQ1fayQfy9S6D9KlvTRMg+QQAm2MIPhbMvNLbyoqm0faAjv1gISWdjAeDjuaIK7wMtDanUoMlnQ9q8JnByhZaYz1s/Ovg2sQGMn89qoE6e9fw8246ai2BLt4N4Eml/m71yd1GAzgeda7zYVBse2GDxqjBAvEQY1gOQcx2Q2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877981; c=relaxed/simple;
	bh=FUBankGmouUnFHbRCj9r4JDT/v6ofLF6OQBfmaOOLC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=omC1+6RGWFry0cy47+tvW4Er/WaxJUdSqD0bIN8mpkARfwihOwAsIsqJbEgvk3w3yfn9qgdbOuW0B3JOPSQG3tCRozKS0BNP0rT1KOVpJ+ohLCUfZCPneqZ31l518E8LzWQxHuWKxMBCKsBcB7aWCN+NVr6BuaAnHXQGQTaFOYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDqALtZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDqALtZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668C01F000E9;
	Tue,  4 Aug 2026 21:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785877980;
	bh=UNSulSzSc00yPg/LHP9TrPP3YgEetFGRrMuLEf+DTNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cDqALtZ2BDrThAOTo7J3Axp9+qFN3bF/4QJLNBK9kmBb2f9k2Ijevy8XdrIe7s9vQ
	 sdEhSauZY/f6GPWVnF+eikd4HftJkjqqulND+ihFYHdckbVflzuWvSSSkaLKdfbSw/
	 QkJmAc6h0V4mnWSjxffkhpThragr/cca2XlF0s76iX+6+MKmvh77FkwyyZEJ51yVMR
	 hkQ5UWBt1+v27zXrU/UD8GyVAfL1oSc7EjnbfFvWdaf6fRCfZufTZQZ8XMStxkJWzc
	 JtUTos2v5bP4WoZvGnmH7au/XXPxnpYijPf1iQz5V0AGPKmbdqd4yzxfeaG6Dnf2bf
	 FQq+EgEJ7ta5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] KVM: selftests: Create one VM with many vCPUs
 for each major PMU counters test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804210046.3413149-3-seanjc@google.com>
References: <20260804210046.3413149-1-seanjc@google.com>
 <20260804210046.3413149-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 21:12:59 +0000
Message-Id: <20260804211300.668C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The test now demands up to 144 vCPUs per VM and will assert/cras=
h on hosts with lower KVM max vCPU limits.
- [Low] The `perf_capabilities` parameter is unused in `__test_arch_events`.
- [Low] Confusing and unusual pointer syntax `struct kvm_vcpu **__vcpus[]` =
is used for an out parameter.
--

--- Patch [2]: [PATCH v3 2/2] KVM: selftests: Create one VM with many vCPUs=
 for each major PMU counters test ---
commit 135d3508be788c9140c4a2eec25c4bc440f48012
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Create one VM with many vCPUs for each major PMU counters t=
est

This commit updates the KVM PMU counters test to batch test cases into fewer
VMs by using multiple vCPUs per VM. This significantly reduces the total
runtime spent creating and destroying VMs.

> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/=
testing/selftests/kvm/x86/pmu_counters_test.c
> index 8abf17cc9469d..08bfa82d7ab84 100644
> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> @@ -87,14 +87,18 @@ static struct kvm_intel_pmu_event intel_event_to_feat=
ure(u8 idx)
>  	return __intel_event_to_feature[idx];
>  }
> =20
> -static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
> -						  void *guest_code,
> -						  u8 pmu_version,
> -						  u64 perf_capabilities)
> +static struct kvm_vm *pmu_vm_create_with_vcpus(u32 nr_vcpus, void *guest=
_code,
> +					       u8 pmu_version,
> +					       u64 perf_capabilities,
> +					       struct kvm_vcpu **__vcpus[])

[Severity: Low]
This isn't a bug, but is the struct kvm_vcpu **__vcpus[] signature
intentional? Mixing double pointers with array brackets in a function
signature can be a bit confusing to read compared to ***__vcpus.

[ ... ]

> @@ -326,30 +339,72 @@ static void guest_test_arch_events(void)
>  	GUEST_DONE();
>  }
> =20
> -static void test_arch_events(u8 pmu_version, u64 perf_capabilities,
> -			     u8 length, u32 unavailable_mask)
> +static void __test_arch_events(struct kvm_vcpu *vcpu, u64 perf_capabilit=
ies,
> +			       u8 length, u32 unavailable_mask)
>  {

[Severity: Low]
Is the perf_capabilities parameter still needed here? It looks like it is
no longer referenced in the function body since the MSR setup was moved into
pmu_vm_create_with_vcpus().

> -	struct kvm_vcpu *vcpu;
> -	struct kvm_vm *vm;
> -
> -	/* Testing arch events requires a vPMU (there are no negative tests). */
> -	if (!pmu_version)
> -		return;
> -
>  	unavailable_mask &=3D GENMASK(X86_PROPERTY_PMU_EVENTS_MASK.hi_bit,
>  				    X86_PROPERTY_PMU_EVENTS_MASK.lo_bit);
> =20

[ ... ]

> +static void test_arch_events(u8 pmu_version, u64 perf_capabilities)
> +{
> +	struct kvm_vcpu **vcpus;
> +	struct kvm_vm *vm;
> +	int i =3D 0;
> +	u32 k;
> +	u8 j;
> +

[ ... ]

> +	pr_info("Testing arch events, PMU version %u, perf_caps =3D %lx\n",
> +		pmu_version, perf_capabilities);
> +
> +	/* Testing arch events requires a vPMU (there are no negative tests). */
> +	if (!pmu_version)
> +		return;
> +
> +	vm =3D pmu_vm_create_with_vcpus((NR_INTEL_ARCH_EVENTS + 2) * (ARRAY_SIZ=
E(unavailable_masks) - 1),
> +				      guest_test_arch_events, pmu_version,
> +				      perf_capabilities, &vcpus);

[Severity: Medium]
Could this cause the test to assert on hosts with lower vCPU limits?

This calculation requests up to 144 vCPUs per VM ((14 + 2) * (10 - 1)). If =
the=20
host has a KVM_CAP_MAX_VCPUS limit lower than 144 (which is common in nested
virtualization or lightweight VMs), vm_create_with_vcpus() might fail with a
hard assertion.

Should this check against the host limit and either skip via TEST_REQUIRE()
or batch the creations into smaller groups of vCPUs?

> +
> +	/*
> +	 * Test single bits for all PMU version and lengths up the number of
> +	 * events +1 (to verify KVM doesn't do weird things if the guest length
> +	 * is greater than the host length).  Explicitly test a mask of '0' and
> +	 * all ones i.e. all events being available and unavailable.
> +	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804210046.3413=
149-1-seanjc@google.com?part=3D2
