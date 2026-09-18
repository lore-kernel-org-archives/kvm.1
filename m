Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427FF502558
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762922; cv=none; b=lOwWczA9rfk5Xgem2+OfImoyFyHsVInW7QGUUCUypEn1jPD/7LmzzEtLt1AXkTLvVjvmQlgWtMrCSgBV92sbcIg+y6NcZ4zhjO+x6FVe+ANTuU8io3nijKojoWAHO6juXLxiOSFewu07oAkAXkZGKJShQh2fNji7ZQT1RX/LyF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762922; c=relaxed/simple;
	bh=FG/zDxYZJ0k1HNpIGPZZ96HGS0xuLRS6/pfJWtzxuAk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DnCM4rmddXkQa3hz2i5hoWJA1MXeCY3O0/Q8iNtKBPJt2i/tTplTXN9RcwrmtP07dh1E1B4NIMjM/PpetLHINk9LFdVMmCmXaREOuWTyBueKYXzi3JQ7wumTRVVWt1OZGsi/QWbqVsuHOsj23Trr1TevkDF1zKvWgWgK1AZqbQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfaqMCQA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfaqMCQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39971F000FF;
	Fri, 18 Sep 2026 20:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762921;
	bh=3YCbnBP/MPjn2g64JYEukDurHqSTNTVchXTHqpNJeQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZfaqMCQAXnQNLb/LIyZAsTXQK45/5Y62invkmjdQ/dqcVYb52l1wE4Mn3npoBI5kx
	 VMAttnsVHP4jFnyeH0BehLUsbs4XyP5FApjOvdegSaKJ63AJK+aryXu7N53IQ4WQ9k
	 bSbwsFHzlqTsU4IbVr6mAmfuxvTyg1DrBh3CKiAtEXBTKMKzybVBi+DcFkkklET1ip
	 rz0nkrW809ybJnZHVWIYHGkVjj1kVqKmiZdy6QgToyEhwB3Kl5KESFjxODAOwpPqA1
	 2v7QN/bRgXJYecvS5tz6pFeJEtqMhkhX0dskeEgLV2IH0FpkIDHwp3mn9qcQL0m8r4
	 pKaMBnrkSmAqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/12] KVM: x86/pmu: Support RDPMC Metrics Clear Mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918193937.569414-13-zide.chen@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-13-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:22:00 +0000
Message-Id: <20260918202200.F39971F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] pmu: event filter mistakenly strips METRICS_CLEAR_EN from fixed_ct=
r_ctrl_hw
- [Medium] pmu: METRICS_CLEAR_EN unmasked without validating fixed counter =
bounds
- [Low] pmu: emulation incorrectly ties PERF_METRICS clearing to SLOTS PMC =
existence
--

commit 8ba3725c32dbde4a1c3935cb433e898e06425b83
Author: Zide Chen <zide.chen@intel.com>

KVM: x86/pmu: Support RDPMC Metrics Clear Mode

This commit adds support for PERF_CAP_RDPMC_METRICS_CLEAR (bit 19 of
IA32_PERF_CAPABILITIES). It advertises this capability to guests when the
mediated PMU is enabled and the host reports it, unmasking the relevant
control bit. It also updates intel_emulate_rdpmc() to replicate the
clear-on-read behavior for consistency.

> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 98e2fb80347a1..3e5e8bae67ab0 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
[ ... ]
> @@ -138,6 +149,18 @@ static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu=
, unsigned int idx,
>  			return 1;
> =20
>  		*data =3D pmu->perf_metrics;
> +
> +		/*
> +		 * Per the SDM, RDPMC of PERF_METRICS clears both PERF_METRICS
> +		 * and the SLOTS fixed counter when Metrics Clear Mode is
> +		 * enabled via INTEL_FIXED_3_METRICS_CLEAR in FIXED_CTR_CTRL.
> +		 */
> +		pmc =3D kvm_pmc_idx_to_pmc(pmu, INTEL_PMC_IDX_FIXED_SLOTS);
> +		if (pmc && intel_pmu_metrics_clear_enabled(pmu)) {
> +			pmu->perf_metrics =3D 0;
> +			pmc_write_counter(pmc, 0);
> +		}
> +

[Severity: Low]
Does tying the clearing of PERF_METRICS to the existence of the SLOTS PMC in
intel_emulate_rdpmc() violate the hardware specification?

If the guest executes RDPMC natively and triggers an interception, and the
SLOTS counter is not exposed to the guest (making kvm_pmc_idx_to_pmc return
NULL), but METRICS_CLEAR_EN is enabled, this code silently skips clearing
PERF_METRICS.

Should the clearing of pmu->perf_metrics be performed independently of whet=
her
the software PMC object for the SLOTS counter exists?

>  		return 0;
>  	default:
>  		return 1;
[ ... ]
> @@ -601,6 +624,11 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  						 INTEL_FIXED_0_USER |
>  						 INTEL_FIXED_0_ENABLE_PMI);
> =20
> +	if (perf_capabilities & PERF_CAP_RDPMC_METRICS_CLEAR)
> +		pmu->fixed_ctr_ctrl_rsvd &=3D
> +			~intel_fixed_bits_by_idx(INTEL_FIXED_SLOTS_IDX,
> +						 INTEL_FIXED_3_METRICS_CLEAR);
> +

[Severity: Medium]
Does intel_pmu_refresh() unconditionally unmask the METRICS_CLEAR_EN bit
without verifying if the guest topology actually exposes the SLOTS counter?

If a VM is configured with 3 or fewer fixed counters, this unmasking would
allow the unprivileged guest OS to write to bit 14 in
MSR_CORE_PERF_FIXED_CTR_CTRL without triggering the expected #GP.

Should this be gated by checking if pmu->nr_arch_fixed_counters >
INTEL_FIXED_SLOTS_IDX?

[Severity: High]
Does this patch inadvertently cause event filters to strip the METRICS_CLEA=
R_EN
bit in kvm_mediated_pmu_refresh_event_filter()?

When a host-level event filter denies the SLOTS counter (counter 3) from
counting, KVM applies a 0xf hardware mask that zeroes all 4 configuration b=
its
for the counter:

arch/x86/kvm/pmu.c:kvm_mediated_pmu_refresh_event_filter() {
...
	} else {
		u64 mask =3D intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0=
xf);

		pmu->fixed_ctr_ctrl_hw &=3D ~mask;
		if (allowed)
			pmu->fixed_ctr_ctrl_hw |=3D pmu->fixed_ctr_ctrl & mask;
	}
}

Since this mask covers the entire 4-bit configuration block, it will also c=
lear
bit 14 (METRICS_CLEAR_EN) from hardware. If the guest sets METRICS_CLEAR_EN=
 and
then executes RDPMC natively, it will lead to un-cleared stale metrics.

Should the mask be updated to avoid interfering with this newly introduced
feature bit?

>  	counter_rsvd =3D ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
>  			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_ID=
X));
>  	pmu->global_ctrl_rsvd =3D counter_rsvd;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918193937.5694=
14-1-zide.chen@intel.com?part=3D12
