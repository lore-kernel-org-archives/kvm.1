Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A0718DB1A
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928494; cv=none; b=ubP/jkBYC3SFOOfkU3ShrD0chzadNvy6idx2934mc9PWv2NqNWhaNkVRw2VrfLDSmZhGdb56bOZQeshvIyGozsTy3W6OXtOrLLIDHI91hTFq7RDIHDdRT+PP6FzvV/5oxIWqg5YaEyrFEoavxCHQF01XU2HHK0h2cMW5dWSgWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928494; c=relaxed/simple;
	bh=AAUZ+0y7IdxgQFN/S1vzNzFanlHQ2abAEDbMsCN6vPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PdXK3hE/okIZ0Rhno581/UR4UP8VUhax00rLSHxGKA1nHSdTgIPfDrWvHJYdxq2IRylaqPWYk+Msd1U7BXg5vm+N7MQlo3wJMHIRso/19+E9IITJIySgVYI3EMO3zPo5RqpdIv4/1KwOfSZUddQ5i3O0gInciT/1fxB+8gPBxPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVWTJ7gg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVWTJ7gg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7577E1F000E9;
	Thu, 28 May 2026 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779928492;
	bh=8YcbwyuKwujW3yiicKb8qQM131STlUXpBMXBdRFVhSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dVWTJ7gg/RKNMTjqM+qFeVP3qQQBUYtIvWNbOwfKRCYp0GzmlKQCPNPksQkyYxq//
	 e4SRuNAkqcGNLPqvzznz+qtmpVKd1cLE38LsSm1i3iRLfydUusHjo+9D31Nmpc2jrA
	 4PsTv6yxkGPlHXGu+Mz5DYWbGKjqRYN980GGLzJ9qzxnqBCsZoTtgzm5fYkzMzsMiB
	 yuGcpqRO6CM7uSP1ikdIgbVzKru4kpe/u6NYm+tNDsPrnlP3cAR2IbcAfoiR69/mAv
	 IJ4doVgrHe8W7TvlEtm/qgW5wJq3CaoQ2qRm7yCqBPxGGcaaWJSAxW1td9anq0/ENI
	 o0SqzoIzxgQ7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/17] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260527234711.4175166-11-yosry@kernel.org>
References: <20260527234711.4175166-11-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 00:34:51 +0000
Message-Id: <20260528003452.7577E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `amd_pmc_is_disabled_in_current_mode` incorrectly evaluates the L2=
 guest's `EFER.SVME` bit instead of the L1 guest's `EFER.SVME` during neste=
d execution, breaking L1's ability to profile L2.
--

commit 59cc076298715b9973873c88e8dfa9b46008c836
Author: Yosry Ahmed <yosry@kernel.org>

KVM: x86/pmu: Disable counters based on Host-Only/Guest-Only bits in SVM

This commit introduces an optional per-vendor PMU callback to check if a
counter is disabled in the current mode. For AMD, it registers a callback
to disable a counter based on the vCPU's setting of Host-Only or
Guest-Only EVENT_SELECT bits.

> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 7aa298eeb0721..41ee6532290e9 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
[ ... ]
> +static bool amd_pmc_is_disabled_in_current_mode(struct kvm_pmc *pmc)
> +{
> +	struct kvm_vcpu *vcpu =3D pmc->vcpu;
> +	u64 host_guest_bits;
> +
> +	if (!kvm_vcpu_has_mediated_pmu(vcpu))
> +		return false;
> +
> +	/* Common code is supposed to check the common enable bit */
> +	if (WARN_ON_ONCE(!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE)))
> +		return false;
> +
> +	/* If both bits are cleared, the counter is always enabled */
> +	host_guest_bits =3D pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
> +	if (!host_guest_bits)
> +		return false;
> +
> +	/* If EFER.SVME=3D0 and either bit is set, the counter is disabled */
> +	if (!(vcpu->arch.efer & EFER_SVME))

[Severity: High]
Does this correctly evaluate the L1 guest's EFER.SVME bit, or does it evalu=
ate
the L2 guest's EFER.SVME bit during nested execution?

When L1 programs a Guest-Only PMU counter to profile the L2 guest, KVM
evaluates L1's PMU configuration. However, during nested execution,
vcpu->arch.efer reflects the L2 guest's EFER.

Since most L2 guests do not enable nested SVM (meaning L2's EFER.SVME is 0),
could this cause the counter to be incorrectly disabled, preventing L1 from
profiling L2?

> +		return true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527234711.4175=
166-1-yosry@kernel.org?part=3D10
