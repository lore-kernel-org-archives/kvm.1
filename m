Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5E224F3
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780541239; cv=none; b=MsaXKU8YAW7bqwpwsi0LERj/r0wOasGQUNVZeCH9Pdl1rW7k2xrrrAusQ8iqxdYpiCt7k6pTJqCeU2d+g2KBYdZEYDJxa0/whi9gOsH3RvWMi/+QmTV/VUvH0utLuW46y5jUj/FD5XPgKqIOz2FjiTF7Yh/JhIBr5Hk1B3ATZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780541239; c=relaxed/simple;
	bh=Sbstv83V/sR9AtMvVIZPKYtL6poLD5aZNSAiPwNZaoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l6rNpoTjyORHhRSZCSMNi8FsbntNnX0pWJ+XBW/K+zuvJJrfv2B/3eHPG8OG9/tkh+dC403yIl5yTDwXDjZl9vV04wOzifxuFXJUEPJhA4V5NwXZotnStJdjf0CmTEHH+3S2KjIo+1ENWBALLEuEXtA+5n1l1Lp0aCdpcAPuPnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx78ngiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx78ngiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497F21F00893;
	Thu,  4 Jun 2026 02:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780541238;
	bh=kKOP6eFYP25TAmj1nIp7jr3jV229xSLK8UHyVew1HSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gx78ngiD0GrhLqqnp7zEwRM7SF3F75sIwQLG0Q6OqQvhQp7Fxk2N0vG8fYctPwcfR
	 nAK62uGCgKzaeCQ+eZJVDB5r5qykg3npzk8YcjLr1yHv3ukshDQht0yzBV4V7lfNpX
	 tQtyYmEIZUxY1gA83XTLTrLqiJlbg+SKbWkm4SKGQGzqVUXjwNrNxRQis1gvLopGki
	 dAMT7t97I9nbHN1u/L+20hl0qa+JhICWWjv149um77NKZj72lWKZuHPxC3/9TTtEcD
	 qFSU2sNpnQt24J3JPjRaoDvZtdWdqrBvTHaph2kI3jSK9o2zWh56niVLnyiabV56zA
	 dfV65Tw1SlIJA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: TDX: Hide unsupported configurable
 CPUID bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Wu" <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604023314.3907511-3-binbin.wu@linux.intel.com>
References: <20260604023314.3907511-3-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:47:17 +0000
Message-Id: <20260604024718.497F21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The secure-by-default CPUID allowlist is applied to KVM capability=
 reporting but missing from TD initialization validation. This allows a mal=
icious userspace VMM to bypass capability enumeration and supply unsupporte=
d configurable CPUID bits directly to the TDX module, potentially causing h=
ost state corruption.
--

commit e4dd30c1f72bbeeb74f3ba5a865ab30e0c17bcf6
Author: Binbin Wu <binbin.wu@linux.intel.com>

KVM: x86: TDX: Hide unsupported configurable CPUID bits

This commit introduces get_supported_cfg_cpuid() to filter the CPUID=20
capabilities reported by KVM_TDX_CAPABILITIES. It replaces a hardcoded=20
denylist with a secure-by-default allowlist approach to prevent exposing=20
unsupported features that could lead to host state corruption.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 028d54c76b81e..befda6bc17b1e 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c

[ ... ]

> -static void clear_waitpkg(struct kvm_cpuid_entry2 *entry)
> +static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
>  {
> -	entry->ecx &=3D ~__feature_bit(X86_FEATURE_WAITPKG);
> +	return has_tsx(entry) || has_waitpkg(entry);
>  }

[Severity: High]
This is a pre-existing issue, but by keeping this legacy denylist active, is
there a risk that userspace can bypass the new secure-by-default allowlist
during TD initialization?

While this patch updates capability reporting to explicitly mask unsupporte=
d=20
features, the configuration path in setup_tdparams_cpuids() still appears t=
o=20
use this older denylist function to validate user input:

arch/x86/kvm/vmx/tdx.c:setup_tdparams_cpuids() {
        ...
        if (tdx_unsupported_cpuid(entry))
                return -EINVAL;

        value =3D &td_params->cpuid_values[i];
        value->eax =3D entry->eax;
        value->ebx =3D entry->ebx;
        value->ecx =3D entry->ecx;
        value->edx =3D entry->edx;
        ...
}

Because these user-provided CPUID values are copied directly into the hardw=
are=20
initialization parameters without being masked against the newly introduced=
=20
get_supported_cfg_cpuid() allowlist, could a VMM explicitly request and pas=
s=20
unsupported configurable CPUID bits directly to the TDX module?

Does this still leave the door open to the host state corruption mentioned
in the commit message if the TDX module only enforces hardware-level support
rather than KVM's software constraints?

> =20
> -static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
> +static u32 get_supported_cfg_cpuid(u32 function, u32 index, u8 reg)
>  {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604023314.3907=
511-1-binbin.wu@linux.intel.com?part=3D2
