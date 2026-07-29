Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E42D39FCB5
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355297; cv=none; b=EBWpPSYCvn/fYBvkonVK7TOP4ZW38cEe0VK0E76QEdXGeoY/v+keX01x4F99c4MAncNZP2jv2TPXWiK34OkeLW6qYAIcE0w588VmXc2OOqPPrG9hLb61JHeQSGgBhfgqkxU3G3QOUCMxC3hE7KyLVbc1YXJsvskc9GHmMfXRQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355297; c=relaxed/simple;
	bh=58EEADhXYuMTXCL2WqRm/2sanqRQvkXnVKoTkqshONU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YbprBk1Ah4c9iYJ0pfMH+uht5h1i5LC+lfpeSdYoJ256OEwUVn+Z0NoXfLxrkrBPk3bSFEITl/+i5u8KVPOuOqwEcoRUZkns2oSH02bF/tUaZUcDn7jCDIYnHzAz6TAyfMiFDP3e1LJja0QrCgSbvHO77kBPQlM81vHp8u6vBDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7ilozIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7ilozIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3281F000E9;
	Wed, 29 Jul 2026 20:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785355295;
	bh=+EG+KEVJllQQ5GhP9SIs6vEsdO5tQgjsyxyxfrUjOJM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h7ilozICsxcTBA/eGjFW86doV6C5VxsL7qx4gRhXiJYK1Yp1Ikv2g152nHy2Uej55
	 Xk6gH6hzXmD5b3kKzKDpeAYTvSV9AEkLmtECzhbhcgZceTj0VNKqtS9s5gbKwtmG62
	 NiFiRpibHqqja4GCPGwKD3wk7sRp3YjRwJt83MIHHjKr8UXpim3Qt8Qb+QTOu8hOiW
	 f5cinOyUhZDFcHTKL5FhwAEDELv8L9jVErElc/M9kXN7RryRtWO7o1PU4WVHpvB5d0
	 z0LxsVuT5QzPRwflfO6lLVAQu0jFfYsCcpTpe+DSjH/PjP59lB7mvR5z1kVsr0XVWc
	 VUazsqCUWXwtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/20] KVM: x86: Expose APX sub-features to userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729191656.598771-19-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
 <20260729191656.598771-19-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 20:01:35 +0000
Message-Id: <20260729200135.8F3281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM fails to mask host CPUID leaf 0x29 with its virtualization cap=
abilities, unconditionally exposing future host hardware features to usersp=
ace.
--

--- Patch [18]: [PATCH v6 18/20] KVM: x86: Expose APX sub-features to users=
pace ---
commit 858481784d49e0b77ae999aa39a6b6f4ada7e521
Author: Chang S. Bae <chang.seok.bae@intel.com>
Subject: KVM: x86: Expose APX sub-features to userspace

This commit adds CPUID leaf 0x29 sub-leaf 0 to expose APX sub-features
(NCI, NDD, NF) to userspace if the APX foundation is available.

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c

[ ... ]

> @@ -1719,7 +1723,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_=
array *array, u32 function)
>  	}
>  	/* APX sub-features */
>  	case 0x29:
> -		entry->eax =3D entry->ebx =3D entry->ecx =3D entry->edx =3D 0;
> +		if (!kvm_cpu_cap_has(X86_FEATURE_APX))
> +			entry->eax =3D entry->ebx =3D entry->ecx =3D entry->edx =3D 0;

[Severity: High]
If the host supports X86_FEATURE_APX, does __do_cpuid_func() bypass masking
the KVM CPU capabilities for leaf 0x29?

When kvm_cpu_cap_has(X86_FEATURE_APX) is true, this path breaks out without
applying cpuid_entry_override(entry, CPUID_29_0_EBX) or clearing the unused
registers (eax, ecx, edx).

Could this leak unmasked host CPUID values for leaf 0x29 directly to
userspace when KVM_GET_SUPPORTED_CPUID is called? Exposing unvetted
hardware features might break guest live migration to older hosts.

>  		break;
>  	case KVM_CPUID_SIGNATURE: {
>  		const u32 *sigptr =3D (const u32 *)KVM_SIGNATURE;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729191656.5987=
71-1-chang.seok.bae@intel.com?part=3D18
