Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255873A7833
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992732; cv=none; b=W6zWyX4smbuaHsuvGWIvRhymZkuOLrZfYt08KNizp+BxxcFSp1VefHA3ZEabf2yyIHWdpvxUUX0YxFjU1FL0OhdGT0OyOb0+zkyUxrQCR5pi07zbV5zdC62kuR9EXxfczS8/bdKFcbrN5/MORLqlSYMWlgxQUAK07N2dzRznoAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992732; c=relaxed/simple;
	bh=U59YY8tWt2DXoeT3VNgQ0uOaUwp/owrCgMMuo/R+fdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TwgA1ysRB+LE80dmSkD0xKlmXxd4X0wSRHohPhqAjD9PwJI8k8qCgf4LHknlSTEtu9YmDGeS2AS1A2wrxDTp5Y+BElCIsMs/S82nPcO+FukM9BCe7oYIItT7fNnPwAeik0q2/+NJuKfh2dtVKTHAcNqCzg1JSH2wfQyqvK6lWFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQEiVoHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQEiVoHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FA61F000E9;
	Mon, 17 Aug 2026 18:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786992731;
	bh=31px42Tr6HXJg0KuJTF2qxS87jxczlKfIQkYxPKKug8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RQEiVoHJ59+LdRtd4pTdR6eA55MaYSthwPsfjxiuRCHes0ZAbXC5X3TIajF2fcsSX
	 tHwg7tf4VIUi33zFT7h7cj83CWsfXQs6FwwfuRmkRzcXzV4BKGWOdUmjfZL8Gft3dG
	 B5e4cH9x0AoXo5Trl3NLXB3YueftFqWvkRJKuYuvY2RakEUaX/8eo51HJuyvBDnN5w
	 cezan+H20BFMsHedASdRD/HgzL94fvmCfG/YdHMEcr0p32g2weBKzEQ4dn8vNLs5r5
	 XR/y3n7kmpVSShlRUIXcynkDtSVDA0uIA2Rlyoblz4YX3fn9eTkAsnX+jN23hm52Rc
	 566orMcX7ghSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/8] KVM: x86/pmu: Rename and move
 vcpu_get_perf_capabilities() to pmu.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260817183143.226156-4-zide.chen@intel.com>
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-4-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 18:52:10 +0000
Message-Id: <20260817185210.C9FA61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Header files pmu.h and pmu_intel.h lack required includes, violatin=
g self-contained header practices.
--

--- Patch [3]: [PATCH v8 3/8] KVM: x86/pmu: Rename and move vcpu_get_perf_c=
apabilities() to pmu.h ---
commit 7eb009fb5328b80368e10acda6cfe621b3e1e1c0
Author: Zide Chen <zide.chen@intel.com>

KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h

This commit renames vcpu_get_perf_capabilities() to kvm_vcpu_get_perf_caps()
and moves it to the common x86 PMU header. This prepares the function to be
called from common x86 code to check the guest's PERF_METRICS capability.

> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 090c9bbb74f48..82f955e5a4507 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
[ ... ]
> @@ -271,6 +271,14 @@ static inline bool kvm_pmu_is_fastpath_emulation_all=
owed(struct kvm_vcpu *vcpu)
>  				  X86_PMC_IDX_MAX);
>  }
> =20
> +static inline u64 kvm_vcpu_get_perf_caps(struct kvm_vcpu *vcpu)
> +{
> +	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
> +		return 0;

[Severity: Low]
Does this file need to include cpuid.h? guest_cpu_cap_has() is used here,
but pmu.h does not include the header that defines it.

> +
> +	return vcpu->arch.perf_capabilities;
> +}
> +
>  void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
[ ... ]
> diff --git a/arch/x86/kvm/vmx/pmu_intel.h b/arch/x86/kvm/vmx/pmu_intel.h
> index 5d9357640aa18..dd447d8b6fdde 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.h
> +++ b/arch/x86/kvm/vmx/pmu_intel.h
> @@ -4,19 +4,9 @@
> =20
>  #include <linux/kvm_host.h>
> =20
> -#include "cpuid.h"
> -
> -static inline u64 vcpu_get_perf_capabilities(struct kvm_vcpu *vcpu)
> -{
> -	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
> -		return 0;
> -
> -	return vcpu->arch.perf_capabilities;
> -}
> -
>  static inline bool fw_writes_is_enabled(struct kvm_vcpu *vcpu)
>  {
> -	return (vcpu_get_perf_capabilities(vcpu) & PERF_CAP_FW_WRITES) !=3D 0;
> +	return (kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_FW_WRITES) !=3D 0;

[Severity: Low]
Should pmu_intel.h include pmu.h? It calls kvm_vcpu_get_perf_caps() which
is now defined in pmu.h, but the include appears to be missing.

>  }
> =20
>  bool intel_pmu_lbr_is_enabled(struct kvm_vcpu *vcpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817183143.2261=
56-1-zide.chen@intel.com?part=3D3
