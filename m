Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6874534389F
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929660; cv=none; b=YCOkIy7BHkva5DYv6BjIkxlNad8tTE2N542A+EuHjApAVTWjxKPsVz+1kEuaMM6PC2yy2rSpMFkqjt5FgXLdJWVCAO/1DRRzMsmgSsM984kQxXd9Gxna9wc40VNpJVio0nQzQGqP1n4hdM3rLz1sPO5LxOrmx/C5/qC3DA0SvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929660; c=relaxed/simple;
	bh=hOMm8vpPMpaUWvLh0Lg+ixjKw1k+BMGGh7C4GeWrDqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rKAu6ctsyOGbRjJEuErJPPRFAoTzMwiNN9K9NLjjzm0lUvwiCzibtfbI2chIn/K9N6MzuKVzaxcWnIVgfn60+/3PVS7HnvJWDmGefWaycIl1Q+6zFZXyNF3cWNMHlqnXmaVQ6jz+5ZMf+5NkPI7FEJvm8AprDFinQqhVGJaUxY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyyKA/jB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyyKA/jB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0228F1F00A3A;
	Thu, 28 May 2026 00:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779929659;
	bh=caNjmhS+e8RakSrLF30YVJPYm56LvmK5GmZIgYc/4fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hyyKA/jBut4xzr+QEvLNi+DtHNP0s91/Vb5R2EZxteCVu35/HUlvvIg5U5JyGfA6o
	 FPgg33zWaZMQCT1RncoosYLaZB8SVRPEumSTRL0BjBQLElxtyiOQj5o5oRf1EKw6ff
	 2g6V5PHLKy25yQBOqHFTdJBo5ffkPhBUXZXpm7S93dwOjCU/z6TyH9nA37n1WuzLiK
	 8QVgZGJLy7oj+4kSE2lvjxIDzq0SBuhoIjHiKxJQMFq3ds8ZWthhw8KztWHiYDrTZa
	 6ZnH66LqlBLmH4rwy8g4W0/dF45H3gXimUOPebGmtca5duAiFLyXUERcWggzLBT6DP
	 sS6dqIiwN9Pcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/17] KVM: x86/pmu: Check mediated PMU counter
 enablement before event filters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260527234711.4175166-9-yosry@kernel.org>
References: <20260527234711.4175166-9-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 00:54:18 +0000
Message-Id: <20260528005419.0228F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Guest can bypass PMU event filters for fixed counters by modifying=
 MSR_CORE_PERF_FIXED_CTR_CTRL.
--

commit 270fc772a7eb457f31ead154a0c426817961ae8a
Author: Yosry Ahmed <yosry@kernel.org>

KVM: x86/pmu: Check mediated PMU counter enablement before event filters

This commit checks if a PMU counter is enabled by the guest before performi=
ng
the potentially expensive PMU event filter lookup. It modifies
kvm_mediated_pmu_refresh_event_filter to use pmc_is_locally_enabled.

> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index afbc731e72174..67dbbd4c73036 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -532,7 +532,7 @@ static bool pmc_is_event_allowed(struct kvm_pmc *pmc)
> =20
>  static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
>  {
> -	bool allowed =3D pmc_is_event_allowed(pmc);
> +	bool allowed =3D pmc_is_locally_enabled(pmc) && pmc_is_event_allowed(pm=
c);

[Severity: High]
This is a pre-existing issue, but was it intended for guests to be able to
bypass PMU event filters for fixed counters by writing to the MSR twice?

Looking at reprogram_fixed_counters() in arch/x86/kvm/vmx/pmu_intel.c,
pmu->fixed_ctr_ctrl_hw is unconditionally overwritten with raw guest data
before checking which counters changed:

arch/x86/kvm/vmx/pmu_intel.c:reprogram_fixed_counters() {
    ...
	pmu->fixed_ctr_ctrl =3D data;
	pmu->fixed_ctr_ctrl_hw =3D data;
	for (i =3D 0; i < pmu->nr_arch_fixed_counters; i++) {
		u8 new_ctrl =3D fixed_ctrl_field(data, i);
		u8 old_ctrl =3D fixed_ctrl_field(old_fixed_ctr_ctrl, i);

		if (old_ctrl =3D=3D new_ctrl)
			continue;
    ...
		kvm_pmu_request_counter_reprogram(pmc);
	}
}

Because kvm_pmu_request_counter_reprogram() is skipped when the counter's
control bits haven't changed, kvm_mediated_pmu_refresh_event_filter() is
never called to apply the filter mask.

Could a guest enable a rejected counter (which gets correctly filtered and
cleared in fixed_ctr_ctrl_hw by the first write), and then write the MSR a
second time to enable a different counter while leaving the rejected
counter's bits set?

The second write would inject the unfiltered enable bits into
fixed_ctr_ctrl_hw, and since the software state (old_ctrl =3D=3D new_ctrl)
matches, KVM skips reprogramming it. Does this allow the rejected counter to
remain enabled in hardware upon the next VM-enter, completely bypassing the
event filters?

>  	struct kvm_pmu *pmu =3D pmc_to_pmu(pmc);
> =20
>  	if (pmc_is_gp(pmc)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527234711.4175=
166-1-yosry@kernel.org?part=3D8
