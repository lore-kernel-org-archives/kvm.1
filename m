Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD2E53E0B
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 04:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190107; cv=none; b=KAqQBDJ09gn6MER4HPxPpVlAaJdoslqKC+2pnd9kinOQYfZtAUxofQ35obs7GNmptBOXQyfVMN/ugSCf4O4bxCXN5JABU9Y7bxoXKykh85tyzdSPKyWnsorogE4S87zpK5AucdxNcARdEWQ4qZxdwYljzGVQ9eFFOi91eBAIkWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190107; c=relaxed/simple;
	bh=XSWfFmWNeWXVK5B9EfbqMeQCSYxkPecpgO5qb+5Gojs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p0VMRNocsLVXme8PLRIL7EFAk3cFq5REJqdGsVZ1WQ82W210Yw4IaUDDKM/R+JGoL+ZEZ7Uwt5ZhDaActHD0Jmr7CS6l9NMK+A/ZBIeorFXtRJQ/pbRI+i4SuAVNblpe12vy79NTCoGYd2oFjiIQOKxHhfUreV5OlXgxAHTsXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arqcT/Ng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arqcT/Ng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592FF1F000E9;
	Tue, 23 Jun 2026 04:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782190106;
	bh=uwg2DlMSMLEDKkfs2z2J76HU1F581KAadq3I0B8m2EI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=arqcT/NgqvVtrom4mb+55q04fq9sYlsVpx71F++xbVZ2AUXCNXbFz5+EMiIotWy2a
	 jVwpE7dpc0SXIK2ar67msDjSCDSsg6qwTFehaRU+NP22Jx/BHjtRKmiGTFkgU709Ue
	 Ru8xluuEfwixIUWHh8MztwhVuptWqGM6LHBxKZwPGLGEbUGxy6I7CRshMz/LbXehtV
	 jYeT4m0SgLkVauQb8XtXKs4IjF9+MmygsAjU6WCBH/URMCUEv2yt6DW6PhJ3OeUdys
	 tXvSOYWSpQYXR4QBiH9yY6NyPUFajBc3fWpO7jpD+5bs2TzAphbEK4X53/fa3ZVyP6
	 WixqMH3XFtppA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 3/4] KVM: x86/pmu: Support PERF_METRICS MSR in
 mediated vPMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260623041927.178256-4-zide.chen@intel.com>
References: <20260623041927.178256-1-zide.chen@intel.com>
 <20260623041927.178256-4-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 04:48:25 +0000
Message-Id: <20260623044826.592FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Emulation of guest RDMSR and WRMSR for MSR_PERF_METRICS unconditio=
nally injects a #GP fault, breaking emulation and nested virtualization.
- [High] KVM_SET_MSRS for MSR_PERF_METRICS is silently discarded, breaking =
live migration of TMA metrics.
- [High] Host Topdown microarchitectural metrics are leaked to the guest vi=
a the RDPMC instruction when mediated PMU is enabled but the guest lacks th=
e PERF_METRICS capability.
--

commit 3d014d661f0ac59ad10f0335ced10697e72d7bf6
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU

This commit exposes the IA32_PERF_METRICS MSR to the guest when mediated vP=
MU
is enabled. It handles the MSR in kvm_pmu_{get,set}_msr() for host accesses
and saves/restores the value on PMU context switches to avoid clobbering ho=
st
data or leaking guest state.

> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 59b7a90c79e12..2c3367f5e2dfb 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
[ ... ]
> @@ -345,6 +347,11 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, =
struct msr_data *msr_info)
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		msr_info->data =3D pmu->fixed_ctr_ctrl;
>  		break;
> +	case MSR_PERF_METRICS:
> +		if (!msr_info->host_initiated)
> +			return 1;

[Severity: High]
If KVM needs to emulate a guest RDMSR instruction targeting MSR_PERF_METRIC=
S,
won't this unconditional return inject a #GP fault into the guest?

> +		msr_info->data =3D pmu->perf_metrics;
> +		break;
>  	case MSR_IA32_PEBS_ENABLE:
>  		msr_info->data =3D pmu->pebs_enable;
>  		break;
> @@ -394,6 +401,16 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, =
struct msr_data *msr_info)
>  		if (pmu->fixed_ctr_ctrl !=3D data)
>  			reprogram_fixed_counters(pmu, data);
>  		break;
> +	case MSR_PERF_METRICS:
> +		if (!msr_info->host_initiated)
> +			return 1;

[Severity: High]
Similarly, if KVM emulates a guest WRMSR instruction targeting
MSR_PERF_METRICS, does returning 1 here cause the emulator to incorrectly
inject a #GP fault?

> +
> +		/*
> +		 * If TMA level 2 is not supported, bits [63:32] are reserved
> +		 * and ignored on write, so no validation is needed here.
> +		 */
> +		pmu->perf_metrics =3D data;

[Severity: High]
When restoring guest state during live migration, userspace calls KVM_SET_M=
SRS
which is wrapped in vcpu_load() and vcpu_put(). Since intel_pmu_set_msr()
updates pmu->perf_metrics without updating the hardware MSR, won't the
subsequent intel_mediated_pmu_put() during vcpu_put() read the stale hardwa=
re
MSR and overwrite this newly restored value?

> +		break;
>  	case MSR_IA32_PEBS_ENABLE:
>  		if (data & pmu->pebs_enable_rsvd)
>  			return 1;
[ ... ]
> @@ -803,6 +828,13 @@ static void intel_mediated_pmu_load(struct kvm_vcpu =
*vcpu)
>  	struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
>  	u64 global_status, toggle;
> =20
> +	/*
> +	 * PERF_METRICS MSR must be restored closely after fixed counter 3,
> +	 * which was just restored by kvm_pmu_load_guest_pmcs().
> +	 */
> +	if (vcpu_has_perf_metrics(vcpu))
> +		wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
> +

[Severity: High]
If the guest is configured without PERF_CAP_PERF_METRICS but with mediated
PMU enabled, RDPMC exiting might be disabled. Since
intel_mediated_pmu_load() skips writing to MSR_PERF_METRICS in this case,
could the guest execute RDPMC and read the un-scrubbed host metrics, leaking
host microarchitectural state?

>  	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
>  	toggle =3D pmu->global_status ^ global_status;
>  	if (global_status & toggle)
> @@ -831,6 +863,12 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *=
vcpu)
>  	 */
>  	if (pmu->fixed_ctr_ctrl_hw)
>  		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
> +
> +	if (vcpu_has_perf_metrics(vcpu)) {
> +		pmu->perf_metrics =3D rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);
> +		if (pmu->perf_metrics)
> +			wrmsrq(MSR_PERF_METRICS, 0);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623041927.1782=
56-1-zide.chen@intel.com?part=3D3
