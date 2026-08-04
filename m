Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6C3387581
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865581; cv=none; b=dpbeUm7Iw5yeJDNRg8l2avk6FNLoeEW6RqJxMyN5ueAbyl1SMTpZn7PUpPVIVEN0G1PhHPhZAPAmBWrOCl6ynrpEh+dhzNpfKWBAxRy+3oLLgTjqI3wjlnNEenUB57f3ZcYN1j9zNRoQ8pb2549l6/UImqJSZrSqbiQqo58hs+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865581; c=relaxed/simple;
	bh=a44UhiDQatY5mC1NSXLuTwfJ+jP5QEj9oFYelAwNVO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BpHtPDVeE2sYE7ij6ua+gebe3DzxMqsWvRGLyGYOzpp876VrkyOQIOrGpuIdAGS0xFV5wL9/9KyOw27oUNJ9bkdxVWqdpZ6UmoRrjSJb2Xv24DoyMLxCQO3Tm8li76+CatlBwaF7WjDb0pbjnIMiwU+qmLBZj36wxD3cOjOwok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccZ82bPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccZ82bPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465821F00A3E;
	Tue,  4 Aug 2026 17:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785865576;
	bh=c7eheK662atO3LWNdTjebTe7QsX0X3k5tCByn3zeOFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ccZ82bPjGI+y9PPD0Bz9BJowYMbkPa4dP2h/jDD+iK3yKu/VdQo2IR5nD/wWoA97V
	 mnHSJw7BLKnxw4Ma/GN3fzGny+N/EGWI4xIgrjoQp4EPKRHOhJaLb3YsMFA4q32ps7
	 g/L5Wvet2ahx4rb8U7Kdc1Qqh1ri5lViBHk9X6WPYVpb6wJM2WtCfBQai22AY8hezl
	 OjeUbbGyRVc3nOTZLU7s8hLpfXQTRELZ/HIi4TTucViHukI5jLzbn1BnxOQtAgrpyy
	 P8wH19aBUr/BDNyOnqQWDbLTFNAusPRXAlFbjpQ/Ff8UByPBE7XJ9ToJSsGhsp4bMw
	 acTx3HLyWYlSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: selftests: Create one VM with many vCPUs for
 each major PMU counters test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804173437.3339269-3-seanjc@google.com>
References: <20260804173437.3339269-1-seanjc@google.com>
 <20260804173437.3339269-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 17:46:15 +0000
Message-Id: <20260804174616.465821F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] In `test_gp_counters`, the refactoring incorrectly configures ev=
ery vCPU with the maximum number of GP counters, losing test coverage for i=
ntermediate values.
- [Low] The `vcpus` pointer array is allocated using the size of `struct kv=
m_vcpu` rather than the size of a pointer.
--

--- Patch [2]: [PATCH 2/2] KVM: selftests: Create one VM with many vCPUs fo=
r each major PMU counters test ---
commit f846c14eae6ee2689b438ef9a6cdf2439244aee5
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Create one VM with many vCPUs for each major PMU counters t=
est

This commit refactors the PMU counters test to create a single VM per=20
test category (arch events, GP PMCs, fixed PMCs) and provisions multiple
vCPUs within that VM. This drastically reduces the test runtime by
avoiding repeated VM creation overhead.

> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/=
testing/selftests/kvm/x86/pmu_counters_test.c
> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
[ ... ]
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
Is this allocating the correct size?

It looks like vcpus is an array of pointers, so this might need to be
sizeof(struct kvm_vcpu *) instead of sizeof(struct kvm_vcpu). While it
just results in a minor memory over-allocation here, it could be slightly
confusing.

[ ... ]
> -static void test_gp_counters(u8 pmu_version, u64 perf_capabilities,
> -			     u8 nr_gp_counters)
> +static void test_gp_counters(u8 pmu_version, u64 perf_capabilities)
>  {
> -	struct kvm_vcpu *vcpu;
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
Does this inadvertently lose test coverage for the intermediate counter val=
ues?

By setting X86_PROPERTY_PMU_NR_GP_COUNTERS to the loop upper bound=20
(nr_gp_counters) instead of the loop variable (j), we end up configuring
every vCPU with the maximum number of GP counters. This seems to bypass
testing edge cases like 0 GP counters entirely. Should this be passing j
instead of nr_gp_counters?

> =20
> -	kvm_vm_free(vm);
> +		run_vcpu(vcpus[j]);
> +	}
> +
> +	pmu_vm_free(vm, vcpus);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804173437.3339=
269-1-seanjc@google.com?part=3D2
