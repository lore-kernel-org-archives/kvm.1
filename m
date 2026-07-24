Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0108003D
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923584; cv=none; b=hPu4birEpQe6blgWTfzvnQ87LsMMX9vqobu04+ZZQ3k06xsSnZW0OdkA6tK8NGlefqCEInOE40m+HfYYzkXJ9pMLaVpuCAzWpl9MAZVc+n+X+rqKJ3qIYzByCxiwAAljc6N0ROWAq1B+twAblJoniXyqTb7aX2lMDyHDKiDFpVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923584; c=relaxed/simple;
	bh=mhrlDpGNWjvln8++dXntmDJGxHv5F/2OL0Dy1aYiMEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lgVvkEILFJMV35tFTu/LDXWj6baH0d7H1ctuICG2QCYcd97HQZue6jJQjiIups2AAh5u24YKpgJPSSAX2W+VQ1lzvpuQ3+s4RF2SYWWt/6CSL+05uMFZrWztThXcGBeQg+8tR33WcBpCR+ayCYHe3OJLXCIhGemh1Imd0Ixx8nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrVgNOOM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrVgNOOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C411F000E9;
	Fri, 24 Jul 2026 20:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784923583;
	bh=rlQ8gDIflOdxoWb3FFZNf+S4qwCQ2AyTUIU4d24m9ig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KrVgNOOMAlTEb6gMd0JlhRd4hCeqtLeQe++pNst2nFO7qYZQCdvRcaIqer5/y1E8Q
	 /5Y7x4ijINfuM/brKxvstXbydgYilVwqpHkuHqIT2XXTj+ydXlz+nhfbMfUgGZFRYK
	 L5jV8htF3kEAGRU3Il5OiQNW6qc0rSfd/8iFN6gzXZkRP/L1HhAPOC5rTqg9f034uI
	 R9xzEL5tRsJARwbldwlKYcc9Xbom9QlpxhoWKhX5/50M03/sE0HEe0pjTg3d4HLdkF
	 0IxTvFxsfBkit4Tseb+oGFYnQywVFn3tIL2Qmvx8tlyK5BJd4es3ZPv5M1SKJZma4x
	 k9crnGVa3qIyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] KVM: SVM: Advertise LbrExtV2 to userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260724195040.630468-6-shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
 <20260724195040.630468-6-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 20:06:22 +0000
Message-Id: <20260724200623.15C411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM fails to gate the advertisement of AMD_LBR_V2 on a 16-entry =
host stack, violating the KVM CPUID API contract and causing a guest #GP up=
on PMU usage.
--

--- Patch [5]: [PATCH 5/7] KVM: SVM: Advertise LbrExtV2 to userspace ---
commit 9dead9faa6c004cfaa9aa0580ca255569674a36b
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>

KVM: SVM: Advertise LbrExtV2 to userspace
   =20
This commit advertises AMD LBR v2 to userspace and reports the LBR stack
depth in CPUID. It aims to gate this advertisement on LBR virtualization,
the mediated PMU, PerfMonV2, and a 16-entry host stack.

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 2698fa42cd971..d450a5b2499d9 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
[ ... ]
> @@ -1883,6 +1884,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid=
_array *array, u32 function)
>  		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
> =20
>  		ebx.split.num_core_pmc =3D kvm_pmu_cap.num_counters_gp;
> +
> +		if (kvm_cpu_cap_has(X86_FEATURE_AMD_LBR_V2))
> +			ebx.split.lbr_v2_stack_sz =3D
> +				min(kvm_pmu_cap.num_branches_lbr, SVM_LBR_V2_STACK_SIZE);
> +

[Severity: Medium]
If the host has kvm_pmu_cap.num_branches_lbr < 16, will this advertise an
unsupported stack size to userspace?

The commit message indicates the advertisement should be gated on a 16-entry
host stack, but it appears the host stack size is not checked before
X86_FEATURE_AMD_LBR_V2 is set.

>  		entry->ebx =3D ebx.full;
>  		break;
>  	}
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 04e386b838d38..4b84498e93be7 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
[ ... ]
> @@ -4846,6 +4860,10 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vc=
pu *vcpu)
>  	if (guest_cpuid_is_intel_compatible(vcpu))
>  		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
> =20
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2) &&
> +	    cpuid_query_lbrv2_stack_size(vcpu) !=3D SVM_LBR_V2_STACK_SIZE)
> +		guest_cpu_cap_clear(vcpu, X86_FEATURE_AMD_LBR_V2);
> +

[Severity: Medium]
If userspace configures the vCPU with the advertised CPUID (where stack size
is less than 16), will this silently drop the feature internally?

If the internal capability is cleared but the guest-visible CPUID remains s=
et,
would the guest receive a fatal #GP when attempting to access the LBR MSRs
that it thinks are supported?

>  	if (is_sev_guest(vcpu))
>  		sev_vcpu_after_set_cpuid(svm);
>  }
> @@ -5692,6 +5710,10 @@ static __init void svm_set_cpu_caps(void)
>  		if (kvm_pmu_cap.version !=3D 2 ||
>  		    !kvm_cpu_cap_has(X86_FEATURE_PERFCTR_CORE))
>  			kvm_cpu_cap_clear(X86_FEATURE_PERFMON_V2);
> +
> +		if (!lbrv || !enable_mediated_pmu ||
> +		    !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
> +			kvm_cpu_cap_clear(X86_FEATURE_AMD_LBR_V2);

[Severity: Medium]
Should there be an additional check here for the host stack size?

If kvm_pmu_cap.num_branches_lbr !=3D SVM_LBR_V2_STACK_SIZE, it seems
X86_FEATURE_AMD_LBR_V2 is not cleared. This appears to lead to the issues
mentioned above where KVM advertises a configuration it cannot faithfully
virtualize.

>  	}
> =20
>  	/* CPUID 0x8000001F (SME/SEV features) */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724195040.6304=
68-1-shivansh.dhiman@amd.com?part=3D5
