Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1AC3D1707
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181811; cv=none; b=bh8jT7BNRDUnZUWtEagiZn37/i9KISIAgDKtPgrJeqiaDePkW8rEzsehRP3Uwf4uuJp149aXS+HwLShbUrH71Zrv/uMV6D/q0RQLvvlkYgRUYCewwfsSC8hNkg/9Od/toeP+sktmEPY5vjkXMrjUeRqVrX+1c8phIGODW+I5IN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181811; c=relaxed/simple;
	bh=8KMQyKTIhFtB00sYqL8IrYrGo9jnykKWZs4XtcJXEUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f8SBONX0scepkh7hJKFUBQjk+d3F/OwPrIpKuY/1E1uM9E/+1Hq2Q4Gkmra/kYyL7uaiu7JYqCh34I9Wu4tkl7YDjWaxwtoM4QcM+LJshTVRQ+PiQX9PKx2QnWY0bGe6ZBtPnFgUhMsWdzQfnfYQ+lBmDgj3wtomzEafqgrpNhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTz1NyfU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTz1NyfU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4851A1F000E9;
	Mon, 27 Jul 2026 19:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181809;
	bh=xHjjqZ3danpnxfC0dilwRidzDP93TiWQp3UiE6xDit0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HTz1NyfUTJzg6RuaMmCCNK6OgF03poW3IQLGQ/M+jZA9AYjR+58JBm0N4c4IV5HY9
	 +p81fDCHiMjHrSd0ECWGvVYvmgYtNN93V5sH57a0aCgHuUWQ4Kp74UpS6zrvKI/L5Y
	 9CHhVeiEpU5SWB5IKRw9nFmt7X2501JKkLlAoTL1CACNW1EivEalk6SSf/wf8llKzI
	 ZXLGOEKTBIMpB/eQvBZNsVv/NJrNwAYeSpSYaelNhxTiB0Ga53SqKSKfwa9YTFSOkv
	 QBPDkuoMzb8S/sB7pXi2FU3Su9TwVjmAA3FdUtltJMHy3dpqHu1Y7QpNQK9ozkDgj1
	 e3rq5nl5kbUzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/9] KVM: x86/pmu: Support PERF_METRICS MSR in
 mediated vPMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727192131.582105-6-zide.chen@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
 <20260727192131.582105-6-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:50:08 +0000
Message-Id: <20260727195009.4851A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Guest PMU state in MSR_PERF_METRICS is leaked to the host and othe=
r VMs because KVM fails to clear it on PMU context switch when the guest is=
 configured without the PERF_CAP_PERF_METRICS feature.
--

--- Patch [5]: [PATCH v7 5/9] KVM: x86/pmu: Support PERF_METRICS MSR in med=
iated vPMU ---
commit 2933f2f58fa948287c388e166de23d159332fdf8
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU

This commit exposes the IA32_PERF_METRICS MSR to guests when mediated
vPMU is enabled. It handles passthrough of the MSR and saves or restores
its state during PMU context switches to prevent clobbering or leaking
state.

> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c

[ ... ]

> @@ -831,6 +852,19 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *=
vcpu)
>  	 */
>  	if (pmu->fixed_ctr_ctrl_hw)
>  		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
> +
> +	if (kvm_vcpu_has_perf_metrics(vcpu)) {
        ^^^^

[Severity: High]
Could this leak guest PMU state to the host or other VMs?

In intel_mediated_pmu_put(), this checks if the guest has the
PERF_CAP_PERF_METRICS capability before clearing MSR_PERF_METRICS.
However, if the physical CPU supports this feature but the guest is
configured without it, could the guest still activate it?

If KVM configures MSR_CORE_PERF_GLOBAL_CTRL for passthrough (which happens
when counter counts match, as kvm_need_perf_global_ctrl_intercept() only
checks counter counts), the guest can write to bit 48 of
MSR_CORE_PERF_GLOBAL_CTRL. The hardware PMU would then start updating
MSR_PERF_METRICS.

Since kvm_vcpu_has_perf_metrics() returns false in this scenario, this path
would skip clearing the physical MSR_PERF_METRICS on VM-exit, leaving guest
state in the hardware register for the next VM or host to read.

> +		pmu->perf_metrics =3D rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);
> +		/*
> +		 * The SDM requires restoring fixed counter 3 before
> +		 * PERF_METRICS. However, this path writes 0 to PERF_METRICS
> +		 * before fixed counter 3. For this all-zero case, the
> +		 * resulting hardware state is therefore the same regardless
> +		 * of write order.
> +		 */
> +		if (pmu->perf_metrics)
> +			wrmsrq(MSR_PERF_METRICS, 0);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192131.5821=
05-1-zide.chen@intel.com?part=3D5
