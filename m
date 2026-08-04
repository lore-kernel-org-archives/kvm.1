Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36939099A
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876786; cv=none; b=jePkgLSy6dFAWF6TJzr42mbrzCjflILvsJvYJuh2sK6LSos6EQHKV1tV9y84NbFmPgyUGOBYSXJPvBjXmpUKn8ECkaOROALsRPT5WJgITOutKJ9Uwh8Kuv8ZHaIuVkQDT8RArh7f02v0w54gyDkYzvorDGJRts3A2Qasgi2WaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876786; c=relaxed/simple;
	bh=1VYl/mxD/qhb9nBBbbebEmQKneJJ6hinZnlIqttYT2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IOtrdRJqAyfediPtmU9PVkU4IKbmEjG+b5Q+DF6ehuOTxknQA883xIGn16RWZ+1fPZoVeRnFb4HAPLpUlrEbDOnJL7Jgp63NCvrWxBHhh/k+eVA/307viFNlgYN1hvXAnfxVTnBZHQkN2TbKCCIggmOBvMKNAw8CRSifKQL052M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7SaO9gF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7SaO9gF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550701F000E9;
	Tue,  4 Aug 2026 20:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785876784;
	bh=qQ6fndvJUwB38htqTUNrIjlTuOV664w2W9hoayjZbQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T7SaO9gFENj8uwnhfcKlghG9U+NlBs95aCxSPj4Qc1g6HDRdbG0W8Rnqm53LTquno
	 QabFdFHgqrODUMNdtENQfIaQPQFH8HDUuzARa3FeJ7FF/QWdrtMKxERM1VtmBGjtTQ
	 +vlUppaEPi5rvV2n7Txttpb10klYHwGaxhGuiAtsvdqoPb+ZgFq2JMcqTzPc+Ixs/l
	 UA0c+Y18njgaOIxMvuo3FUNnxeU3aUrLPl0rEyHYHk7+B2Je9R2xL+kZ7l13jHC647
	 ZzHOUtgDQmrIuEV1vLM9VSV6hOUHKq4LSIy49GPNK7yp3IYVJEUb3uYQTBanbg8Ysb
	 fJnZ2QLrC/m0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: selftests: Create one VM with many vCPUs
 for each major PMU counters test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804204048.3401810-3-seanjc@google.com>
References: <20260804204048.3401810-1-seanjc@google.com>
 <20260804204048.3401810-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 20:53:03 +0000
Message-Id: <20260804205304.550701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] `test_gp_counters()` sets the GP counters CPUID property to the =
maximum value in every iteration, ignoring the loop variable `j`.
- [Low] `pmu_vm_create_with_vcpus()` allocates the `vcpus` array using `siz=
eof(struct kvm_vcpu)` instead of `sizeof(struct kvm_vcpu *)`.
- [Low] `test_arch_events()` allocates and initializes more vCPUs than it a=
ctually consumes in its test loops.
--

--- Patch [2]: [PATCH v2 2/2] KVM: selftests: Create one VM with many vCPUs=
 for each major PMU counters test ---
commit a4cedd8a736c776f6a5266a65eb438757b2a50d6
Author: Sean Christopherson <seanjc@google.com>
Subject: KVM: selftests: Create one VM with many vCPUs for each major PMU c=
ounters test

To reduce the runtime of the PMU counters test by an order of magnitude,
create one VM per category of test (arch events, GP PMCs, fixed PMCs),
with N vCPUs per VM, where 'N' is the number of testscases to run per
category. The vast majority of the test's runtime is spent creating VMs.

> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/=
testing/selftests/kvm/x86/pmu_counters_test.c
> index 8abf17cc9469d..c7c5662203815 100644
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
>  {
> +	struct kvm_vcpu **vcpus =3D calloc(nr_vcpus, sizeof(struct kvm_vcpu));

[Severity: Low]
Does this calloc() call allocate too much memory?

The vcpus array contains pointers, so shouldn't the element size be
sizeof(struct kvm_vcpu *) instead of sizeof(struct kvm_vcpu)?

[ ... ]
> @@ -326,30 +339,72 @@ static void guest_test_arch_events(void)
[ ... ]
> +static void test_arch_events(u8 pmu_version, u64 perf_capabilities)
> +{
[ ... ]
> +	vm =3D pmu_vm_create_with_vcpus((NR_INTEL_ARCH_EVENTS + 2) * ARRAY_SIZE=
(unavailable_masks),
> +				      guest_test_arch_events, pmu_version,
> +				      perf_capabilities, &vcpus);
> +
> +	/*
> +	 * Test single bits for all PMU version and lengths up the number of
> +	 * events +1 (to verify KVM doesn't do weird things if the guest length
> +	 * is greater than the host length).  Explicitly test a mask of '0' and
> +	 * all ones i.e. all events being available and unavailable.
> +	 */
> +	for (j =3D 0; j <=3D NR_INTEL_ARCH_EVENTS + 1; j++) {
> +		for (k =3D 1; k < ARRAY_SIZE(unavailable_masks); k++)
> +			__test_arch_events(vcpus[i++], perf_capabilities, j,
> +					   unavailable_masks[k]);
> +	}

[Severity: Low]
Are we over-allocating vCPUs for this VM?

The VM is created with a vCPU count scaling by ARRAY_SIZE(unavailable_masks=
),
but the inner loop below it starts at k =3D 1.

This means the inner loop only executes ARRAY_SIZE - 1 times, leaving some
allocated and initialized vCPUs unused.

[ ... ]
> @@ -493,21 +548,27 @@ static void guest_test_gp_counters(void)
[ ... ]
> +static void test_gp_counters(u8 pmu_version, u64 perf_capabilities)
>  {
> +	u8 nr_gp_counters =3D kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
> +	struct kvm_vcpu **vcpus;
>  	struct kvm_vm *vm;
> +	u8 j;
> =20
> -	vm =3D pmu_vm_create_with_one_vcpu(&vcpu, guest_test_gp_counters,
> -					 pmu_version, perf_capabilities);
> +	pr_info("Testing %u GP counters, PMU version %u, perf_caps =3D %lx\n",
> +		nr_gp_counters, pmu_version, perf_capabilities);
> =20
> -	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_GP_COUNTERS,
> -				nr_gp_counters);
> +	vm =3D pmu_vm_create_with_vcpus(nr_gp_counters + 1, guest_test_gp_count=
ers,
> +				      pmu_version, perf_capabilities, &vcpus);
> =20
> -	run_vcpu(vcpu);
> +	for (j =3D 0; j <=3D nr_gp_counters; j++) {
> +		vcpu_set_cpuid_property(vcpus[j], X86_PROPERTY_PMU_NR_GP_COUNTERS,
> +					nr_gp_counters);

[Severity: Medium]
Should the third parameter to vcpu_set_cpuid_property() be j instead of
nr_gp_counters here?

Using nr_gp_counters sets the maximum value in every iteration, missing test
coverage for guests configured with fewer than the maximum number of GP
counters.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804204048.3401=
810-1-seanjc@google.com?part=3D2
