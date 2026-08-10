Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF026ED40
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358185; cv=none; b=pywA6v2sZzovadVwakVl2zZJrHTLZ4dhenWjDaJbLs7j2BjhhEg66qMEuPfI2kp1SmOHyTQz0mYxtaXtNJ1FMeOB2iMvS6pVbn4EUv4HuR1mirCW4Vd4Fvv3J5hwkwPaQP5zESWw24OcgjtIPdamCk5sL5OM70EMfVzAXFlv2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358185; c=relaxed/simple;
	bh=X/MqudKUUqK8W/F6yk+KoBbdbgjhT/e6UZ3pZJjvHx0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RoWw7XMjIKMtTYlE8pfPn0gxojMNiyTbwi4sZwDpLd0ep/VoBBkK3FdGmC3FXGxnsqp25/mKOwVlZVZCFVKfrQtmfO3kPmC+uj+5l8sPNdO1Sr3sNAz7DFTydOqmS1tOxMnd7xCwh0bK0TTEdndyMJXqYXM6PfzZhuB5lScksaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCyK89c1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCyK89c1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09F51F000E9;
	Mon, 10 Aug 2026 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786358183;
	bh=SsreJ1q7jBOUJ34ITTEhBGkZbh0HVhowh5cVLu/cK8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mCyK89c1d8rxZ1S+g04Mt7+Bay8YJE4r/V79djrMjhaQ3Y9kvDf9JRKpkp+2VHPdF
	 qKADq8zHTMmgSMydfLl/JSa/HEu3rZIqxjf5P5kHk8h8KUKPEHWTCD/3vTbLN/EADM
	 zg2Jw7b77AAiDrOzsDFVLhsFcipkZaDyDVCkbEvNOkFzX4U/6CGOKJ4KBEw1birWbt
	 ToVJkT4czBW2mbe99HnTW0jxr5oqBPx2g1wdpsHbJjVKxHDATeXChS/DP/s3QmggAa
	 5ec4ZHuFgVR6dlQLYGbuTnFBitP0uXjxL3q5vXdDOlB+G5NeohacV1vBal6S3XN1k7
	 SRUkWgdUjMJ7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] KVM: x86/pmu: Add support for hardware-switched PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <67cd3b3b8f031338d76094673d738d72caa10c31.1786345201.git.sandipan.das@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
 <67cd3b3b8f031338d76094673d738d72caa10c31.1786345201.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:36:22 +0000
Message-Id: <20260810103623.B09F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware-switched PMU state (PMCs, event selectors) is not synchro=
nized with the vendor save area during MSR access, VM reset, and event emul=
ation, causing data loss across live migration and incorrect event filterin=
g.
--

--- Patch [3]: [PATCH 3/8] KVM: x86/pmu: Add support for hardware-switched =
PMU ---
commit 388311da6f37e672745e8b6b16a96e9812fb8ddd
Author: Sandipan Das <sandipan.das@amd.com>

KVM: x86/pmu: Add support for hardware-switched PMU

This patch introduces the hardware-switched mode for the mediated PMU.
It transitions the guest PMU state to reside in a vendor save area
instead of the software kvm_pmu struct. The load and put functionality
is simplified to schedule host events in and out.

> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -844,10 +890,12 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct m=
sr_data *msr_info)
>  	switch (msr) {
>  	case MSR_CORE_PERF_GLOBAL_STATUS:
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
> +		kvm_pmu_get_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_STATUS);
>  		msr_info->data =3D pmu->global_status;
>  		break;
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
>  	case MSR_CORE_PERF_GLOBAL_CTRL:
> +		kvm_pmu_get_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_CTRL);
>  		msr_info->data =3D pmu->global_ctrl;
>  		break;

[Severity: High]
Does this miss synchronizing the PMCs and Event Selectors in the default
switch cases for kvm_pmu_get_msr() and kvm_pmu_set_msr()?

When userspace reads or writes the guest PMU state via KVM_GET_MSRS and
KVM_SET_MSRS, the default block falls through to vendor code:

	default:
		return kvm_pmu_call(get_msr)(vcpu, msr_info);

Without calling kvm_pmu_get_vendor_state() or kvm_pmu_set_vendor_state() for
these MSRs, KVM might return stale software values or fail to commit restor=
ed
values to the hardware save area. Since kvm_mediated_pmu_load() skips loadi=
ng
software state into hardware for the hardware-switched mode, could this cau=
se
data loss across live migration?

[ ... ]

> @@ -1140,11 +1202,17 @@ static void kvm_pmu_trigger_event(struct kvm_vcpu=
 *vcpu,
> =20
>  	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
>  	kvm_for_each_pmc(pmu, pmc, i, bitmap) {
> +		kvm_pmu_get_vendor_state(vcpu, pmc_counter_msr(pmc));
> +
>  		if (!pmc_is_event_allowed(pmc) || !cpl_is_matched(pmc))
>  			continue;
> =20
>  		kvm_pmu_incr_counter(pmc);
> +		kvm_pmu_set_vendor_state(vcpu, pmc_counter_msr(pmc));
>  	}

[Severity: High]
Are we evaluating the event filter with stale event selector state here?

While we fetch the latest counter values via kvm_pmu_get_vendor_state(),
pmc_is_event_allowed() and cpl_is_matched() still rely on pmc->eventsel
and pmu->fixed_ctr_ctrl. Without syncing the event selector or fixed counter
control from the vendor save area, might these checks use outdated software
state?

Additionally, how does KVM handle VM resets and instruction emulation track=
ing
with hardware-switched PMUs?

For resets, kvm_pmu_reset() zeroes out the PMCs and event selectors in the
software structures:

	pmc_stop_counter(pmc);
	pmc->counter =3D 0;
	pmc->emulated_counter =3D 0;

	if (pmc_is_gp(pmc)) {
		pmc->eventsel =3D 0;
		pmc->eventsel_hw =3D 0;

It doesn't seem to push this reset state down to the vendor save area.

For emulation, MSR writes bypass KVM interception in the hardware-switched
mode. Since KVM_REQ_PMU is never triggered, it appears that
kvm_pmu_recalc_pmc_emulation() won't run, leaving pmc_counting_instructions
and pmc_counting_branches empty. Could this cause KVM to silently fail to
increment counters during instruction and branch emulation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786345201.gi=
t.sandipan.das@amd.com?part=3D3
