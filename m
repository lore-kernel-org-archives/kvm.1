Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7E22DF152
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781565981; cv=none; b=thyuyQytLn+H+4pqk1j4wUk9vHiehBGtvg3bWxCOv/WZWOh7BlkpEwbc6Y+Wnd2XMSnEZTT6zfNmKWpuLAa5K3Sa9RlgiV8KXAnVBozQyuTV/KsVu5SJwlqk4gEG9XJn7CQMkbXMVGMhAlTckwFM1nWuvXM0M2rLfYrHmNFazTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781565981; c=relaxed/simple;
	bh=LsEr5pO0KRq/u9RnO+Ka1oviR4KeO4nOco0cmDV4wZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TRvw8iQyYvgjiDntna5yIg5D7b77jMbg3hzIXnsmQ7qQ9cE++65DmBZ7kA/3hVR8lut0bQhdwe7xtKPgSTG2OJiVOrsI/Ax5dTDn/ADfpI/YzPJJdH8klgqyEuE31nfi0Lyqdzje6sG34CrpR1Yk5OW7iEkp7FXy6VLNf3SEJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGro+HVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGro+HVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF811F000E9;
	Mon, 15 Jun 2026 23:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781565979;
	bh=Ee9slmD0tWW2pcl3y77bcIj9OwKvCPyWJ9PrK3PzGoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mGro+HVlvnn43VxFxoJcIZEhZ24vq+pgwyeybbS8GocsqPYXRfwlAZYeI4xdpYLy9
	 /aNm8A/Ab/QJbPAcYqzwIRS76aCb3TD3q7N26YU2RNg8DPfBjHjlH/pJ5GPbVBMQCM
	 MM1ZvbB+t5usZJayfGqZukranpfnG5T4ZjbDV4LrilvcnBvCZG/eIqAiaNNANbg435
	 /1toUccEhEc8vRTdXWK81gboPm+nrigBlfjhJUZERuMObJmICD3olQ7eSjlxzUQGA5
	 rRDeMTGYhC+uMgcaFQR/o3+Ya8E79ZMbtd9gRlNP3tgc8LgZ5TnLxSsok3sLf2ehaR
	 S+CHISE6FE1/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 3/4] KVM: x86/pmu: Support PERF_METRICS MSR in
 mediated vPMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260615230118.50718-4-zide.chen@intel.com>
References: <20260615230118.50718-4-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 23:26:18 +0000
Message-Id: <20260615232619.BBF811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Guest-reachable WARN_ON_ONCE assertions in MSR_PERF_METRICS access=
ors allow unprivileged guests to trigger host-side denial of service.
- [High] Software updates to MSR_PERF_METRICS via KVM ioctls or VCPU reset =
are silently clobbered by stale hardware MSR values during vcpu_put().
- [High] MSR_PERF_METRICS is passed through to the guest without context sw=
itching if the guest has a PMU version of 0, bypassing host isolation.
--

commit 65a5a5edf8809e596749d317875bbc842f4eb7fc
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU

This commit exposes the IA32_PERF_METRICS MSR to guests when mediated
vPMU is enabled. It allows host access via kvm_pmu_{get,set}_msr() and
handles save/restore during PMU context switches.

> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 05a59f4acfdd3..61102aa5e2f9e 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c

[ ... ]

> @@ -335,6 +337,10 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, =
struct msr_data *msr_info)
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		msr_info->data =3D pmu->fixed_ctr_ctrl;
>  		break;
> +	case MSR_PERF_METRICS:
> +		WARN_ON_ONCE(!msr_info->host_initiated);

[Severity: High]
Could this WARN_ON_ONCE() be triggered by an unprivileged guest?

If a guest forces KVM's instruction emulator to handle the MSR access, for
example by executing RDMSR over an MMIO page, the emulator might process the
instruction and invoke KVM's MSR handlers with host_initiated =3D false.

This would unconditionally trigger the warning and allow the guest to spam
the host kernel log or cause a host panic if panic_on_warn is enabled.

> +		msr_info->data =3D pmu->perf_metrics;
> +		break;
>  	case MSR_IA32_PEBS_ENABLE:
>  		msr_info->data =3D pmu->pebs_enable;
>  		break;

[ ... ]

> @@ -384,6 +390,15 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, =
struct msr_data *msr_info)
>  		if (pmu->fixed_ctr_ctrl !=3D data)
>  			reprogram_fixed_counters(pmu, data);
>  		break;
> +	case MSR_PERF_METRICS:
> +		WARN_ON_ONCE(!msr_info->host_initiated);

[Severity: High]
Can a malicious guest also trigger this WARN_ON_ONCE() by executing WRMSR
over an MMIO page to force instruction emulation?

> +
> +		/*
> +		 * If TMA level 2 is not supported, bits [63:32] are reserved
> +		 * and ignored on write, so no validation is needed here.
> +		 */
> +		pmu->perf_metrics =3D data;
> +		break;
>  	case MSR_IA32_PEBS_ENABLE:

[ ... ]

> @@ -622,6 +642,9 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
> =20
>  static void intel_pmu_reset(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> +
> +	pmu->perf_metrics =3D 0;
>  	intel_pmu_release_guest_lbr_event(vcpu);
>  }

[ ... ]

> @@ -821,6 +851,12 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *=
vcpu)
>  	 */
>  	if (pmu->fixed_ctr_ctrl_hw)
>  		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
> +
> +	if (vcpu_has_perf_metrics(vcpu)) {
> +		pmu->perf_metrics =3D rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);

[Severity: High]
Does this rdpmc() call silently clobber software updates made to
pmu->perf_metrics?

When the VCPU is loaded during a KVM_SET_MSRS ioctl or VCPU reset, updates
to pmu->perf_metrics in intel_pmu_set_msr() or intel_pmu_reset() modify the
software struct but do not synchronously write to the active hardware MSR.

Later, when the VCPU is descheduled, intel_mediated_pmu_put() reads the
physical MSR (which still holds the old pre-update value) and overwrites the
software state.

Will this permanently discard the new software state and break live
migration or VCPU resets?

> +		if (pmu->perf_metrics)
> +			wrmsrq(MSR_PERF_METRICS, 0);
> +	}
>  }

[ ... ]

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9324d60839419..475e72c733cee 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4247,6 +4247,9 @@ static void vmx_recalc_pmu_msr_intercepts(struct kv=
m_vcpu *vcpu)
>  				  MSR_TYPE_RW, intercept);
>  	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
>  				  MSR_TYPE_RW, intercept);
> +
> +	vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS, MSR_TYPE_RW,
> +				  !vcpu_has_perf_metrics(vcpu));

[Severity: High]
Could clearing the intercept here allow the guest direct, unintercepted
access to the host's physical MSR_PERF_METRICS register without a context
switch?

If enable_mediated_pmu is true, KVM exposes PERF_CAP_PERF_METRICS. A VMM
could configure a VCPU with MSR_IA32_PERF_CAPABILITIES.PERF_METRICS=3D1 but
leave the PMU version at 0.

In this scenario, vcpu_has_perf_metrics() would return true, clearing the
intercept. However, because the PMU version is 0,
kvm_vcpu_has_mediated_pmu() returns false.

This causes the context-switch handlers kvm_mediated_pmu_load() and
kvm_mediated_pmu_put() to exit early.

Does this bypass host isolation and allow the guest to leak or clobber host
PMU state?

>  }
> =20
>  static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615230118.5071=
8-1-zide.chen@intel.com?part=3D3
