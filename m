Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445230;
	b=IevaBNg3AAVDgVTMCZUMaxSNz7Iu+udPbC5kVm+NoBCJFg+AMMPiPVZLPz6nw/AB341W
	 spsblsvX+M5xCYQzdh2M8iKGi0O106BstLyLj8Deiq9kxWV377mE7KC3TRbBoDT2HurPs
	 M7ZTNSzRKY4+ujq9lun8Rn7KR+clQmaJSivWQoWawD/ucrzidDkBlb1gfkgI6q9iF3cZK
	 gdlvnD1B0D3glkgVap3brIZbm72jGpJhLRuix/UbVj39fxpPj8lpS1xwAoHmUlmgjjPgj
	 ZPoMXG4KOxb9r+GEzRSAVxKj2ET0VFM2utYPeZ0PXs8BHrba2j7Q+dYPUTKfpfr1NFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445230;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8DHkGnFBcEp54nYO2eePiEHaMsvKGlleU1AIuv6QlNU=;
	b=qAzR18mw5+Q56YCEzBwM62/mDzfcMoNc9l9nWaCojPU0hMoaoee87kUlMp30aJ7TL/eQ
	 S74uhgR0eQYqEtA7pi9fYko/ekZLh0x5c6+1Z6F2jQHM9ubN2zGXkZPFZf4RuIhJpaXuj
	 SCbJhJ7ZjmV5A+bN56QGPGbLVFDlV63XDVTJAt1NfmYM4hYDXkNCcdwhckTbJnBHXc1Pk
	 ridL2wb387Uvf1VCBZnapzw09n7xkpJQa8cSu7X0dHGda8/7XBnaIsvodrZzRq0bAbHXt
	 ZNWDDrXJaLEyGSgR+nAb6aoyrGQ7790py3/R57thz7BWoLn2PL3XxAa7LWWpkTgL0KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2E84OPe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368C2606A31D
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2E84OPe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1851F000C4;
	Mon, 19 Oct 2026 21:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792445229;
	bh=8DHkGnFBcEp54nYO2eePiEHaMsvKGlleU1AIuv6QlNU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D2E84OPe7sZIg0oKkOGM8uOTmhZ9QsPOK0xi5NNAriLP1pRX0g/wz6+DtLLg5RFtr
	 kmiD/K0E4LNPgblUQzppQoumtDnPytrqZUQ8jcH1MRXmgXD1GHckD3Uvh6qtdb/eE2
	 3mKDIwYZpp2UbEkJJXdwsyQjI9Y8P6XCC8I1vox4wmv9i30yf4devdc12khtibx0Tx
	 aN6T5wxp5aqb0FV3HnWVAy4PKUSFIcP8u+poTpk5dfgFtSKYa3aLSn67T0r66fUAld
	 ddFIAczVpPRc4mJwvhmgoKT1+02FHcqWsqVP8t9ZP+tVeci2nPf8bsEqplCJWhEXFs
	 RgvbtffHQqnyg==
Message-ID: <sashiko-outbox-178255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/12] KVM: SVM: Advertise LbrExtV2 to userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261019210532.378628-8-shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-8-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:27:09 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] KVM: x86: __do_cpuid_func() reports lbr_v2_stack_sz when LBRv2 i=
s disabled
- [Medium] KVM: SVM: AMD_LBR_V2 not cleared in svm_set_cpu_caps() when !ena=
ble_pmu
--

commit 7e80a77e67ad5de914e6e6583e6c7b559aacbce2
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>

KVM: SVM: Advertise LbrExtV2 to userspace

This commit advertises X86_FEATURE_AMD_LBR_V2 and reports the LBRv2 stack
depth in CPUID leaf 0x80000022 when LBR virtualization, the mediated PMU,
PerfMonV2, and a 16-entry host LBR stack are available.

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index adafd6fa2c542..bb24d83621328 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1258,6 +1258,7 @@ void kvm_initialize_cpu_caps(void)
> =20
>  	kvm_cpu_cap_init(CPUID_8000_0022_EAX,
>  		F(PERFMON_V2),
> +		SCATTERED_F(AMD_LBR_V2),
>  	);
> =20
>  	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
> @@ -1904,6 +1905,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_=
array *array, u32 function)
>  		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
> =20
>  		ebx.split.num_core_pmc =3D kvm_pmu_cap.num_counters_gp;
> +		ebx.split.lbr_v2_stack_sz =3D kvm_pmu_cap.num_branches_lbr;

[Severity: Medium]
Should __do_cpuid_func() in arch/x86/kvm/cpuid.c check
kvm_cpu_cap_has(X86_FEATURE_AMD_LBR_V2) before populating
ebx.split.lbr_v2_stack_sz?

When enable_pmu is true on an LBRv2-capable host, kvm_init_pmu_capability()
copies kvm_host_pmu into kvm_pmu_cap:

arch/x86/kvm/pmu.c:kvm_init_pmu_capability() {
    ...
    memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
    ...
}

In svm_set_cpu_caps(), if lbrv is false, enable_mediated_pmu is false, or
kvm_pmu_cap.num_branches_lbr is not SVM_LBR_V2_STACK_SIZE, KVM clears
X86_FEATURE_AMD_LBR_V2 while X86_FEATURE_PERFMON_V2 remains set and
kvm_pmu_cap.num_branches_lbr remains non-zero.

When userspace invokes KVM_GET_SUPPORTED_CPUID, __do_cpuid_func() for leaf
0x80000022 only checks enable_pmu and
kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2). Wouldn't this cause
KVM_GET_SUPPORTED_CPUID to report a non-zero lbr_v2_stack_sz in EBX even
when X86_FEATURE_AMD_LBR_V2 is cleared in EAX?

> +
>  		entry->ebx =3D ebx.full;
>  		break;
>  	}
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 69f9ea746bb6f..ea7535ccc3fe6 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5843,6 +5843,18 @@ static __init void svm_set_cpu_caps(void)
>  		if (kvm_pmu_cap.version !=3D 2 ||
>  		    !kvm_cpu_cap_has(X86_FEATURE_PERFCTR_CORE))
>  			kvm_cpu_cap_clear(X86_FEATURE_PERFMON_V2);
> +
> +		/*
> +		 * LBRv2 requires LBR virtualization and the mediated PMU to
> +		 * let the guest own the LBR stack, and is enumerated through
> +		 * PerfMonV2's CPUID leaf.  KVM also can't faithfully virtualize
> +		 * a stack depth other than the architectural 16 entries, as the
> +		 * VMCB save area provides exactly that many entries.
> +		 */
> +		if (!lbrv || !enable_mediated_pmu ||
> +		    !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2) ||
> +		    kvm_pmu_cap.num_branches_lbr !=3D SVM_LBR_V2_STACK_SIZE)
> +			kvm_cpu_cap_clear(X86_FEATURE_AMD_LBR_V2);
>  	}

[Severity: Medium]
In svm_set_cpu_caps() in arch/x86/kvm/svm/svm.c, both
kvm_cpu_cap_clear(X86_FEATURE_PERFMON_V2) and
kvm_cpu_cap_clear(X86_FEATURE_AMD_LBR_V2) are inside the if (enable_pmu)
block:

arch/x86/kvm/svm/svm.c:svm_set_cpu_caps() {
    ...
    if (enable_pmu) {
        ...
        if (kvm_pmu_cap.version !=3D 2 ||
            !kvm_cpu_cap_has(X86_FEATURE_PERFCTR_CORE))
            kvm_cpu_cap_clear(X86_FEATURE_PERFMON_V2);

        if (!lbrv || !enable_mediated_pmu ||
            !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2) ||
            kvm_pmu_cap.num_branches_lbr !=3D SVM_LBR_V2_STACK_SIZE)
            kvm_cpu_cap_clear(X86_FEATURE_AMD_LBR_V2);
    }
    ...
}

When enable_pmu is false on an LBRv2-capable host, kvm_initialize_cpu_caps()
still initializes CPUID_8000_0022_EAX with F(PERFMON_V2) and
SCATTERED_F(AMD_LBR_V2), and svm_set_cpu_caps() skips clearing them.

Because kvm_vcpu_after_set_cpuid() populates vcpu->arch.cpu_caps from
kvm_cpu_caps, doesn't this leave kvm_cpu_cap_has(X86_FEATURE_AMD_LBR_V2)
true globally and allow guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2) to
be set if userspace passes leaf 0x80000022 in KVM_SET_CPUID2 when enable_pmu
is false?

With the earlier commit ("KVM: nSVM: Propagate LBRv2 state across nested
transitions") in this series, svm_copy_vmrun_state() and
__nested_copy_vmcb_save_to_cache() check
kvm_cpu_cap_has(X86_FEATURE_AMD_LBR_V2), while nested_vmcb02_prepare_save(),
nested_svm_vmexit_update_vmcb12(), and nested_svm_vmexit() check
guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2). Wouldn't leaving
X86_FEATURE_AMD_LBR_V2 set when enable_pmu is false cause KVM to copy LBRv2
state into the L1 MSR_VM_HSAVE_PA area during SMM transitions and propagate
DBG_EXTN_CFG_LBRV2EN across nested transitions without mediated PMU support?

> =20
>  	/* CPUID 0x8000001F (SME/SEV features) */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019210532.3786=
28-1-shivansh.dhiman@amd.com?part=3D7
