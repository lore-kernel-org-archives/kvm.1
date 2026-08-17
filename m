Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024A1F63D9
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786993471; cv=none; b=YMx+glFp2xrYMiJex55H0s2DdAeObiV5A98sJQ32wu/ZStjpdxv7QmoWsYJ+jQ0o4UUkXWs8czLB1FHvvAvevZe9iW7O5JkljHHqf0eqIOk/oKqkqXqIsHq2OOKYcHTGs907kEJxy7C/7RUKp7Y0bgoZ8AcThpts60G7tlTJ34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786993471; c=relaxed/simple;
	bh=bIKYsyoqgOcxfauvlclmxWBzkbdRr8Srf5QG4WbCkUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UXJeEZi12RRXB+8tadeHAVTpEofybiAtG5lvpBz0fIQ6yYmj/V70LWq2rMFf6dxxcMyfs7OJJMzB0w0XZYMeMugI2LMyY1evmVeOnwTv1hPyrE8i6UGvUw990yywGWntUOjaN/OWV+n71707Fe8JV5/hG+Qk3q7yzzlW8POgtMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPedmapb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPedmapb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD481F000E9;
	Mon, 17 Aug 2026 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786993469;
	bh=zeSI2iylcDbkjIDrKrf4V5ly0Mk3KWsfyDqMK8fksdY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XPedmapbDcriz+DuiObnCnaTx6so4ohlvcdGxSb+25qNywh46MnAn8C5IMuCnqJBI
	 YlmwSUXQ2ELIqiNzRyH6uYT1FloSDQh3qv3+IyBbizgIOHkkAbIxyz9i63GH83UmcQ
	 +Wd4xpqy1YhCcXkohuikRn47pj6u0yF6Sve8cheB6CtwRh1vtyLOqdiUCG/Hqm0xty
	 qx77GGCDhRkEkvuMdp4pgkzckHN8kLNcH4mTW8/RIczKqSrPMw+8L26VwYFyDUrdQZ
	 lTmQU+S9njE+eXxgEgVTHw4J43GsduveOdx2HqvyWEbvHLhZ1optRSIaIvT0Ox18On
	 VLNrBxh+V4WNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in
 mediated vPMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260817183143.226156-6-zide.chen@intel.com>
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-6-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 19:04:29 +0000
Message-Id: <20260817190429.7CD481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Unvalidated guest/userspace writes to MSR_PERF_METRICS cause h=
ost kernel WARN/Oops during PMU context load.
- [High] Missing RDPMC emulation for PERF_METRICS causes guest #GP when RDP=
MC is intercepted.
- [High] Missing RDPMC intercept allows information leak of host MSR_PERF_M=
ETRICS.

Pre-existing issues:
- [High] Intercepting MSR_CORE_PERF_GLOBAL_STATUS during mediated PMU opera=
tion breaks PMIs by returning stale overflow data to the guest.
--

--- Patch [5]: [PATCH v8 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in med=
iated vPMU ---
commit 3c012e6d223702ac2057eaf2c6a15810c5334d8c
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU

This patch exposes the IA32_PERF_METRICS MSR to the guest when mediated
vPMU is enabled. It allows host/guest PMU context switching to save and
restore this MSR, and intercepts MSR_CORE_PERF_GLOBAL_CTRL if the host
supports PERF_METRICS but it is not exposed to the guest.

> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 913a0ecbf2609..2fddcbc8924d4 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -806,9 +806,16 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vc=
pu *vcpu)
>  	       pmu->nr_arch_fixed_counters !=3D kvm_host_pmu.num_counters_fixed;
>  }
> =20
> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
> +{
> +	return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) &&
> +		!kvm_vcpu_has_perf_metrics(vcpu);
> +}
> +

[Severity: High]
Does this code miss checking for kvm_need_perf_metrics_intercept() in
kvm_need_rdpmc_intercept()?

If mediated PMU is active and the PMU counter topology matches the host,
RDPMC exiting is disabled. The guest can execute RDPMC with ECX=3D(1<<29)
directly on the hardware. Since intel_mediated_pmu_load() skips clearing
MSR_PERF_METRICS when the guest lacks the feature, the guest might observe
the host's raw active MSR_PERF_METRICS value.

>  bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>  {
>  	return kvm_need_any_pmc_intercept(vcpu) ||
> +	       kvm_need_perf_metrics_intercept(vcpu) ||
>  	       !kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
>  }

[Severity: High]
This is a pre-existing issue, but does forcing intercepts here break PMIs
for guests lacking PERF_METRICS?

By returning true here, MSR_CORE_PERF_GLOBAL_STATUS and
MSR_CORE_PERF_GLOBAL_OVF_CTRL are intercepted. During mediated PMU
operation, hardware updates the physical GLOBAL_STATUS directly on
overflow. Because KVM does not sync the physical MSR to
pmu->global_status on every VM-exit (only on vcpu_put()), guest reads
of the intercepted GLOBAL_STATUS could return stale cached data (0),
potentially hiding hardware PMIs from the guest.

[ ... ]
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 100c072b7fb38..1fd0480baf680 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
[ ... ]
> @@ -346,6 +348,9 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, s=
truct msr_data *msr_info)
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		msr_info->data =3D pmu->fixed_ctr_ctrl;
>  		break;
> +	case MSR_PERF_METRICS:
> +		msr_info->data =3D pmu->perf_metrics;
> +		break;

[Severity: High]
Does KVM also need to emulate RDPMC for PERF_METRICS?

The SDM specifies that IA32_PERF_METRICS can be read using the RDPMC
instruction with ECX =3D (1<<29) | 0. However, intel_rdpmc_ecx_to_pmc() only
recognizes GP counters (type 0) and fixed counters (type 1<<30).

If KVM intercepts RDPMC, could a guest attempt to read PERF_METRICS via
RDPMC fall through to the default case and return NULL, causing KVM to
inject a #GP?

>  	case MSR_IA32_PEBS_ENABLE:
>  		msr_info->data =3D pmu->pebs_enable;
>  		break;
[ ... ]
> @@ -395,6 +400,14 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, =
struct msr_data *msr_info)
>  		if (pmu->fixed_ctr_ctrl !=3D data)
>  			reprogram_fixed_counters(pmu, data);
>  		break;
> +	case MSR_PERF_METRICS:
> +		/*
> +		 * Bits [63:32] are ignored on hardware that supports only
> +		 * level-1 metrics, but may be valid on hardware that supports
> +		 * level-2 metrics. Preserve guest writes verbatim.
> +		 */
> +		pmu->perf_metrics =3D data;
> +		break;

[Severity: Critical]
Is it safe to accept untrusted guest or userspace data here without
validation?

If a malicious guest or host userspace (via KVM_SET_MSRS) injects a value
with reserved bits set into pmu->perf_metrics, it could cause a host #GP
during vcpu_load() when intel_mediated_pmu_load() blindly writes this
value to the physical MSR using the unsafe wrmsrq() macro.

>  	case MSR_IA32_PEBS_ENABLE:
>  		if (data & pmu->pebs_enable_rsvd)
>  			return 1;
[ ... ]
> @@ -803,6 +821,9 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *=
vcpu)
>  	struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
>  	u64 global_status, toggle;
> =20
> +	if (kvm_vcpu_has_perf_metrics(vcpu))
> +		wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
> +

[Severity: Critical]
Could this wrmsrq() cause a host oops or panic?

As mentioned above, if pmu->perf_metrics contains unvalidated data with
reserved bits set, wrmsrq() (which lacks an exception table entry) will
trigger a host #GP.

>  	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
>  	toggle =3D pmu->global_status ^ global_status;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817183143.2261=
56-1-zide.chen@intel.com?part=3D5
