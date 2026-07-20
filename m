Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70242A80
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784583393; cv=none; b=OY15GFVfzV/rp+6ZuPyn57PUf1ztvSi9Ma7iZeBl9hVqsz+ILtlNSVnX13Dl5sfm9bh3dOxFdqoX0rlQKdH1gqmRRy54YIcS2Sq/35SLimDQu48LW1o2bao7IOahZE+HisIgXsv7xuQhnny2Gl4lLmXsIiOQV5K+2Fg2GxZ5bCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784583393; c=relaxed/simple;
	bh=nlpadB8mPjUEdDF/2Ws6h4BBV0j3TwXXp4YTcjZyGcw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nDataVBV70GURrsx48hQDf7/uxF7tGO0Ahmb8ypdl14rxhE4Xq75b0C0HNfIdxTlrxnSsoFNuGKvaxY/RU5Ieoy8dInAHv2joCNcswB2PHHhedKbU39taGSOPetXnfIbiglWKdSIclrrmfq23UhIpkUmrUbcj4HPY+LIMn3vrgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CooYYnVX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CooYYnVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3271F000E9;
	Mon, 20 Jul 2026 21:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784583392;
	bh=Yvv2YVzD6Vl6nxDeScFFIyBV9FGFDSZXoMcoZkci1X0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CooYYnVXCRlZBSRJ/lzh30bW8RSU25KjYqguYBGiFyaWXY6ulkVItssC+aHmvgaii
	 NTumHAJeG7HuZViwvLd06NHQB7+FdIeI7NCdn1QN1BGZbboAiqvmQFOlcH3noIMSlC
	 Xhavs8CajrCWoFQNxp4BD2G2SjE/0weJV2lyHMgrGrtxVtIn8boxcPtial+mYTAc7X
	 86RsTPqyaX4m7ap25w0QZkkHa3qJCDQuZJgCD+BwkM7Za/aOCnMQz98RTHoEae+7IL
	 ecothl/V3RnZXo09PpOw/2JjhoGMAGA3W59J67AClFDQ9NAFXsZW1Ch4B92sGeMxAi
	 89iq9zbXhRfDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: VMX: Cap VMX preemption timer to work around Intel
 errata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Mattson" <jmattson@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260720205230.1457146-1-jmattson@google.com>
References: <20260720205230.1457146-1-jmattson@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 21:36:31 +0000
Message-Id: <20260720213632.0F3271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces a 64-bit division using the `/` operator whic=
h will cause a link-time error (`undefined reference to __udivdi3`) on 32-b=
it x86 builds.
--

--- Patch [1]: [PATCH] KVM: VMX: Cap VMX preemption timer to work around In=
tel errata ---
commit 366ce3421414ba11b41c6d60e48e81bd155756a9
Author: Jim Mattson <jmattson@google.com>

KVM: VMX: Cap VMX preemption timer to work around Intel errata

Due to a widespread Intel erratum (e.g. EMR158), programming the
VMX-preemption timer with certain large values may cause the timer to expire
earlier than expected. This patch calculates a limit based on CPUID 15H and
returns -ERANGE in vmx_set_hv_timer() if the shifted delta_tsc reaches or
exceeds this preemption timer limit.

Link: https://lore.kernel.org/all/Zn9X0yFxZi_Mrlnt@google.com/

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 6b96f7aea20bd..9c540a50922a9 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c

[ ... ]

> @@ -8489,6 +8490,26 @@ static void __init vmx_setup_me_spte_mask(void)
>  	kvm_mmu_set_me_spte_mask(0, me_mask);
>  }
> =20
> +/*
> + * Workaround for a widespread Intel erratum (e.g. EMR158) where the
> + * VMX-preemption timer may expire earlier than expected when programmed
> + * with large values. The workaround is to cap the timer value to strict=
ly
> + * less than 2^25 * CPUID.15H:EBX / CPUID.15H:EAX.
> + */
> +static __init u64 calc_preemption_timer_limit(void)
> +{
> +	u32 eax, ebx, ecx, edx;
> +
> +	if (cpuid_eax(0) < 0x15)
> +		return 1ULL << 32;
> +
> +	cpuid(0x15, &eax, &ebx, &ecx, &edx);
> +	if (!eax || !ebx)
> +		return 1ULL << 32;
> +
> +	return min_t(u64, 1ULL << 32, ((u64)ebx << 25) / eax);
                                                         ^^^^^

[Severity: High]
Will this 64-bit division using the / operator cause a link-time error on
32-bit x86 builds?

Since the Linux kernel does not export the __udivdi3 compiler intrinsic on
32-bit x86, compiling with CONFIG_KVM_INTEL enabled on a 32-bit configurati=
on
might result in an undefined reference error during the build.

Should this use div_u64() from include/linux/math64.h to perform the 64-bit
by 32-bit division instead?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720205230.1457=
146-1-jmattson@google.com?part=3D1
