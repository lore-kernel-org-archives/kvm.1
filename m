Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5AE2DF152
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566013; cv=none; b=SQPp7VULvrO52PxzjprI9fvZYW36RpQNkRC8LdwhcBbO8/F3toHRyO0bah0oHcLgaSVtK+CzcQ28KpdJSJYxShV4g/PYs3N1Hdn0MJZrNq69dqdz8I6gVKfHQsAdVJroXBIOZse/a5uYWBW4PqzrXdU1LxvVz4CvO1+w8nYm4ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566013; c=relaxed/simple;
	bh=RqXgjuHVevvncdKluDagNLSfOrgbx856UfHs9mT6xHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C6jRVho9jHJdnPxmzra7nv7REsCDfHnTn7P1+PBnLa0cLsbrTWs1XDRRct80lgnXLaytDREEK9YHjU849iDZDU6FDqPcr6SCgrlszj7AZdOGprn7LjArHuwX8CUkNnWhsVKSEJztZ8VWo2Xl4mqB6/vyUGBsntxcbpmRjUBB3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSrcUaoz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSrcUaoz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768D71F000E9;
	Mon, 15 Jun 2026 23:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566012;
	bh=/tQs+HWdJ3GDrlOvttNbO0wEBhxIVUfm7CMlkB21zK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZSrcUaoznL7sikH4t29sbYhTjDnFNbZSAMV92sH07COsiXvZbSZouIxkO+K2fbGXy
	 l7VF5hryZQ9fZ8GaLtOFTcpMucSAE800UWLrXlbZCHXLMkPNO/ZwWrh5Ad/cKI+GqP
	 LVeeLDezsY4GT/HnbxUX/D015WXOSZsejv+RfFtnllOTwu47J0fUau354+RBxgcOMk
	 ezBlppiZSmWKdr0K3h3ju/w68k+ZQoTUtaMBWbw+kP+T90X4yo77HF7gAEgF+a8PJn
	 8ZtRrd+YbgSLVb7WDzKek5S8DIAZAb3HFdxuI/dxagd79JQBxbXJGPXlzMP1AWJKgQ
	 FjLJ/+vfmMlzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 4/4] KVM: selftests: Add perf_metrics and fixed
 counter 3 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260615230118.50718-5-zide.chen@intel.com>
References: <20260615230118.50718-5-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 23:26:52 +0000
Message-Id: <20260615232652.768D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A malicious or misconfigured guest can trigger a host-side WARN_ON=
_ONCE by forcing KVM to emulate an RDMSR or WRMSR to MSR_PERF_METRICS, lead=
ing to log spam or a host kernel panic.
--

commit 2e12d71150f3902b3e1f245bbcb48d6fe2235b4a
Author: Zide Chen <zide.chen@intel.com>

KVM: selftests: Add perf_metrics and fixed counter 3 tests

This commit adds a selftest to exercise IA32_PERF_METRICS support for Topdo=
wn
(TMA) Level 1 metrics. It checks for non-zero metrics derived from the
workload and extends the PMU selftest to cover Intel fixed counter 3 by
bumping MAX_NR_FIXED_COUNTERS to 4.

> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/=
testing/selftests/kvm/x86/pmu_counters_test.c
> index dc6afac3aa919..d4688a7d1e556 100644
> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
[ ... ]
> @@ -318,6 +322,56 @@ static void guest_test_arch_event(u8 idx)
>  				FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
>  }
> =20
> +static void guest_test_perf_metrics(void)
> +{
> +	int retiring, bad_spec, fe_bound, be_bound, sum;
> +	u64 global_ctrl, metrics;
> +
> +	if ((guest_get_pmu_version() < 2) ||	/* Does guest have GLOBAL_CTRL? */
> +	    !this_cpu_has(X86_FEATURE_PDCM) ||
> +	    !(rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_PERF_METRICS))
> +		return;
> +
> +	wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> +	wrmsr(MSR_CORE_PERF_FIXED_CTR3, 0);
> +	wrmsr(MSR_PERF_METRICS, 0);

[Severity: High]
This is a pre-existing issue, but since this test now exercises
MSR_PERF_METRICS, is it possible for a guest to trigger a host-side
WARN_ON_ONCE by forcing KVM to emulate RDMSR or WRMSR to MSR_PERF_METRICS?

Looking at KVM's emulation path in arch/x86/kvm/vmx/pmu_intel.c,
intel_pmu_get_msr() and intel_pmu_set_msr() both contain a WARN_ON_ONCE:

intel_pmu_get_msr() {
    ...
    case MSR_PERF_METRICS:
        WARN_ON_ONCE(!msr_info->host_initiated);
        msr_info->data =3D pmu->perf_metrics;
        break;
}

If a malicious guest forces instruction emulation for RDMSR or WRMSR target=
ing
this MSR (for example, by using the KVM_FEP forced emulation prefix, or by
executing the instruction from a page that triggers an EPT violation on
fetch), the instruction is processed by KVM's software emulator.

The emulator calls kvm_emulate_msr_read() or kvm_emulate_msr_write(), which
explicitly set msr_info.host_initiated =3D false.

Could this trigger the WARN_ON_ONCE in intel_pmu_get_msr() or
intel_pmu_set_msr() and allow an unprivileged guest to spam the host kernel
log or panic the host if panic_on_warn is enabled?

> +
> +	/* Enable fixed ctr3 (TOPDOWN.SLOTS) and PERF_METRICS. */
> +	wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(3, FIXED_PMC_KERNEL)=
);
> +	global_ctrl =3D FIXED_PMC_GLOBAL_CTRL_ENABLE(3) |
> +		      PERF_METRICS_GLOBAL_CTRL_ENABLE;
> +
> +	GUEST_RUN_PAYLOAD(MSR_CORE_PERF_GLOBAL_CTRL, global_ctrl, "");
> +
> +	/* Check test results. */
> +	metrics =3D rdmsr(MSR_PERF_METRICS);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615230118.5071=
8-1-zide.chen@intel.com?part=3D4
