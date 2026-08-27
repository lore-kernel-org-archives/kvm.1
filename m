Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1137C3CDBAA
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787871933; cv=none; b=Y29WvcX/QS5ah3LWhb+B+gkTzWk7/NGy+9nFmJuefwpwCoUTH8IF6kpT0POfFHJPmHrqFiheJs4z+P29MRYcGqtPLligcbcw1WR+jm9taEJNfNrTbJ05RX2OfsWUH5IHc08N5lJaOBdOZIpQG/a7v0SivDQYBTd8AyHsnmlaVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787871933; c=relaxed/simple;
	bh=ONAKOhVhXc13eWZBc1ZXTOyjns57rAGTHPsid0T5r1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RYJxce41NuKX/z1ZwtYt+40tEbB7XuJ9qa6BIVtt4KCLIIqMp6LHkHEq3Ov8SOeI63jRycoiqvBZawI2wEUAoLFgct6U6oq+rB+2IzsPLF3da+jx1r8KXVbKxZ15lMu6xYXFz7nEd0smTWkgD/4hZxHkB0zPjbkuX35Oa8FXOMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3yeUnHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3yeUnHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9652B1F000E9;
	Thu, 27 Aug 2026 23:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787871931;
	bh=oJZuzBaTI6CMpnCzgQb21RV8j6dL2ub4Iq1bOdFVob0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T3yeUnHsnaGY0K1xod3fcV22EPylht0Sq9ntC6he0amCCNqvLAPzwo4yzpumKeASI
	 tQXl58NmPJe/0/8KJUIv1P7/RnC3hQKI68aPzk+FUHLEXH372EwMR2luzozj3c3j0E
	 vD3J/vJy4TuCHCuKlakWKsY++R7/6jJmv5xaUXSjCR6vOie6UCtMj+SSBJWrB/z09U
	 /GWAzYk7arCsTRVKQbP7W/J1BgI9+n6weso60qAI/rSySJwUIiFhvmFuy2d+OCjvFQ
	 /1GtaXzcs4KUfz2FAC0fyNXiCoKmMukpUGIiIpXrs1rWyqeT3uDcJw03YhJmSvbK7Q
	 T4J8w6YAiNgPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET
 and GLOBAL_INUSE MSRs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260827223755.143247-12-zide.chen@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-12-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 23:05:31 +0000
Message-Id: <20260827230531.9652B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incorrect IN_USE bit calculation for fixed counters in IA32_PERF=
_GLOBAL_INUSE omits the INTEL_FIXED_0_ENABLE_PMI condition.
- [Medium] Emulated writes to MSR_CORE_PERF_GLOBAL_STATUS_SET fail to trigg=
er a PMI when the corresponding global_ctrl bit is set.
--

commit a29f967a55c3b6e45cb682091b4b9a33c0b976dc
Author: Zide Chen <zide.chen@intel.com>

KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and GLOBAL_INUSE MSRs

Intel PerfMon v4 introduces IA32_PERF_GLOBAL_STATUS_SET (0x391) and
IA32_PERF_GLOBAL_INUSE (0x392). This patch adds emulation for both MSRs
in KVM, but there appear to be a few issues with the implementation.

> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 437a7bc49bf84..7c05cf5157bfc 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
[ ... ]
> @@ -931,6 +934,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct ms=
r_data *msr_info)
>  		if (!msr_info->host_initiated)
>  			pmu->global_status &=3D ~data;
>  		break;
> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
> +		if (data & pmu->global_status_rsvd)
> +			return 1;
> +		if (!msr_info->host_initiated)
> +			pmu->global_status |=3D data;
> +		break;

[Severity: Medium]
Will emulated guest writes to MSR_CORE_PERF_GLOBAL_STATUS_SET fail to trigg=
er
a PMI when the corresponding global_ctrl bit is set?

This handler correctly updates the global status, but it appears to omit the
required secondary side-effect of generating a performance monitoring inter=
rupt.

If a guest writes a 1 to a bit in MSR_CORE_PERF_GLOBAL_STATUS_SET while the
corresponding bit in IA32_PERF_GLOBAL_CTRL is enabled, it seems the interru=
pt
will silently fail to generate because the code doesn't check global_ctrl or
set KVM_REQ_PMI.

>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>  		if (!msr_info->host_initiated)
>  			pmu->global_status |=3D data & ~pmu->global_status_rsvd;
[ ... ]
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 4df55a3e21da9..3070fba2687f4 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
[ ... ]
> @@ -341,6 +343,38 @@ static bool intel_pmu_handle_lbr_msrs_access(struct =
kvm_vcpu *vcpu,
>  	return true;
>  }
> =20
> +static u64 intel_pmu_get_global_inuse(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> +	unsigned long fixed_mask =3D kvm_fixed_pmc_mask(pmu);
> +	unsigned long gp_mask =3D kvm_gp_pmc_mask(pmu);
> +	bool pmi_inuse =3D false;
> +	u64 eventsel, data =3D 0;
> +	u32 fixed_ctrl;
> +	int i;
> +
> +	kvm_for_each_gp_counter(i, gp_mask) {
> +		eventsel =3D pmu->gp_counters[i].eventsel;
> +
> +		if (eventsel & ARCH_PERFMON_EVENTSEL_EVENT)
> +			data |=3D BIT_ULL(i);
> +		pmi_inuse |=3D eventsel & ARCH_PERFMON_EVENTSEL_INT;
> +	}
> +	kvm_for_each_fixed_counter(i, fixed_mask) {
> +		fixed_ctrl =3D fixed_ctrl_field(pmu->fixed_ctr_ctrl, i);
> +
> +		if (fixed_ctrl & (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER))
> +			data |=3D BIT_ULL(KVM_FIXED_PMC_BASE_IDX + i);

[Severity: Medium]
Does this code improperly omit INTEL_FIXED_0_ENABLE_PMI when calculating the
IN_USE bit for fixed counters?

If a fixed counter is configured only for PMI (without OS or User bits), th=
is
code seems to falsely report it as unused, which violates the Intel SDM
specification for FCn_InUse.=20

Should INTEL_FIXED_0_ENABLE_PMI be included in this condition to ensure the
availability check remains accurate?

> +		pmi_inuse |=3D fixed_ctrl & INTEL_FIXED_0_ENABLE_PMI;
> +	}
> +	pmi_inuse |=3D pmu->pebs_enable;
> +
> +	if (pmi_inuse)
> +		data |=3D PERF_GLOBAL_INUSE_PMI_INUSE;
> +
> +	return data;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827223755.1432=
47-1-zide.chen@intel.com?part=3D11
