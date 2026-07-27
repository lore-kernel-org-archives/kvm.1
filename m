Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8467B3CF1E1
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181892; cv=none; b=qVHANknrb3uD075brJJpR/sKRCK9vZR4oLo5ALhUCnN2Cys3Oezg3JFgMYU67EX11mIchqut+8WcEsAlj039tNvwVJhpSF2CdLgeGle9Ew5qFilr0m4DaK1/5Om9R4BlLpj4FXtdHwhgB9ty+yU8t2aAKZxV2NNx0kPD9t114sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181892; c=relaxed/simple;
	bh=hB/S+6dmIkAcbLej6wVROFLCHpOJy6NP8hdvmgXR/Bc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ui0ihgGjz/R1qs5FmifEdXQhFymelH61mqv65u4zG4/zoS2mv+pfQUFVoxeiq9ILUIKey0WlHn2Q8FbpADTaGXddUxthiD+tk669K9Ah11gl7ZSIgf/Rc+ZwaBYyL3RdI8xS3dTfWd9XzR0V28h5BzHJbAewwLyXJEPbkTMvEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT+76jFb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT+76jFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007701F00AC4;
	Mon, 27 Jul 2026 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181890;
	bh=GszHcw4J/2HbVpEan1Fy2cDbwDGcOzjkz7zVH7oc6JE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oT+76jFbF2s5GI4M6eekMS18dPEhBEXCXTCFY3IeIvJmjmOO3Nfg+TPGR1qKt7iij
	 0rAs+o8hHLoBJsTkbUv+YSapoAhE/WZkj3AZgia6aA70qQEgyAR9ErjSGng/wTNO3h
	 2GTPd6LdiSUc5YsIkO0aFjeOTfc9+lSs8hYH+RKNfiLNUIX3EfNPsFSrAj8W4MHnTT
	 ulPq+Cm0l/UtoMqQYJXSbkxStRxOWvOY8CrDHvngeWwdIX7RW8oSPJAxZISvn3ACTd
	 Sijv+P0/Wv80Q6TRFEa8lK44HwaQDrz6i+aoVHdUqWIvnaBw0T2y9pEEoD4/J3THCV
	 NbuRhayYJ2H+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/9] KVM: x86/pmu: Support Intel fixed counter 3 on
 mediated vPMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727192131.582105-3-zide.chen@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
 <20260727192131.582105-3-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:51:29 +0000
Message-Id: <20260727195130.007701F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The logic to filter non-contiguous fixed counters incorrectly uses=
 CPUID.0A:EDX[4:0] instead of counting the contiguous 1-bits in the ECX bit=
mask. This causes KVM to expose non-existent fixed counters to the guest wh=
ile hiding supported ones.
--

--- Patch [2]: [PATCH v7 2/9] KVM: x86/pmu: Support Intel fixed counter 3 o=
n mediated vPMU ---
commit 7c8d5061e2216416ace2a9414a66d8b5fc0bf8bd
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

KVM: x86/pmu: Support Intel fixed counter 3 on mediated vPMU

This commit exposes Intel's fixed counter 3 to guests when mediated vPMU is
enabled. It updates the maximum number of fixed counters and adds logic to
filter non-contiguous fixed counters since KVM currently does not support
them.

> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
[ ... ]
> @@ -181,6 +185,19 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu=
_ops)
>  	kvm_pmu_cap.num_counters_fixed =3D min(kvm_pmu_cap.num_counters_fixed,
>  					     KVM_MAX_NR_FIXED_COUNTERS);
> =20
> +	/*
> +	 * Currently, KVM doesn't support non-contiguous fixed counters; make
> +	 * sure only contiguous ones are retained in kvm_pmu_cap.
> +	 */
> +	if (kvm_host_pmu.version >=3D 5) {
> +		cpuid(0xa, &eax, &ebx, &ecx, &edx.full);
> +		if (kvm_pmu_cap.num_counters_fixed > edx.split.num_counters_fixed)
> +			kvm_pmu_cap.num_counters_fixed =3D edx.split.num_counters_fixed;

[Severity: High]
Does this logic correctly determine the number of contiguous fixed counters?

If a host supports PMU version 5 with fixed counters 0, 1, and 3, the ecx
bitmask would be 0xB, and kvm_pmu_cap.num_counters_fixed would initially be
populated with the weight of that mask, which is 3.

The value in edx.split.num_counters_fixed reports the maximum fixed counter
index plus one (4 in this scenario). The condition 3 > 4 evaluates to
false, so kvm_pmu_cap.num_counters_fixed remains 3.

This leaves KVM exposing the first three contiguous counters (0, 1, and 2)
to the guest. Since the host hardware does not actually support counter 2,
KVMs attempt to back it with a host perf event will fail.

Should this instead inspect the contiguous 1-bits starting from bit 0 in the
ecx bitmask, for example by using ffz(~ecx)?

> +	}
> +
> +	if (!enable_mediated_pmu && kvm_pmu_cap.num_counters_fixed > 3)
> +		kvm_pmu_cap.num_counters_fixed =3D 3;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192131.5821=
05-1-zide.chen@intel.com?part=3D2
