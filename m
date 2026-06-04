Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734213A7F6B
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780541503; cv=none; b=CXpwiA733KsSMXZiWznaFuymlpFZoeykrqxGC8GA/25jM0vz8HxFK3BEy/DmPgHN1tUtT0wnxtcKSxcIqiYFcNiV1Om+KX1T4zkaZzandgOcleox57suRHhi1cCjNtinQa23/sF8/PinvbPS0bQ68wY5UsCl4g44oo1/TiGtXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780541503; c=relaxed/simple;
	bh=j5S8My6zmGxqWiOYcF/wn8xohOYDaVHG8KHqrawzCv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gj7YNBmFDextGCEyhRPe8CiOmCm6bMuLlS9dkXUX5W0wmNZncrya9ZHGi/LtNRnuKhXU8R15OCPhgMjKqxIZaO/rp+Eun/PjFw0M5ojD43F3+DGsLtHL0Mt2Tc7OZDHF3GWRDqW/MIbizr2csSYELYuYvQGuUQdg92/8Lx0v0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0ZSqFuT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0ZSqFuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200341F00893;
	Thu,  4 Jun 2026 02:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780541502;
	bh=OwSS2H01Kdoqs00Vah9H+9AaGjgsb8N0SXcxqT566vA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i0ZSqFuTvxkJlNSCK/0KI4NSnDss5awP/CUmIszrVgqJ2hqh8068uwelkItm/ZkCg
	 7UD23YyQnhWQ1kkSkvg7mx1lrwHkMPBy23wNedTy2gFJkLIr7SYuCywxLFFTHYRB+3
	 qj4Lh8L10r48Z/1rTNFYcZslM+BTWScGtwtAwi/oyeeuhAqnRYMtlNTF/k5lGsopHa
	 wD6G4PLI8MyxJBeyFefMoRFB4nYuU4urDQzRXGOy366tk5SJRSiAnb36aU7FWZjUv2
	 BpQi884kRipNsbc2y63RzmQ0FL6Fq5Knpd1NGtJzn+De+Kdh7Chlw+hlneS3dUdCUG
	 IjLXBfDmI2WTQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/4] KVM: x86: TDX: Report CORE_CAPABILITIES as
 supported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Wu" <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604023314.3907511-5-binbin.wu@linux.intel.com>
References: <20260604023314.3907511-5-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:51:41 +0000
Message-Id: <20260604025142.200341F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing handling of MSR_IA32_CORE_CAPS in tdx_set_msr() causes KVM=
_SET_MSRS to fail, breaking VM initialization and live migration.
--

commit 217a78047d73d2be68ef27e206470a6c237db79a
Author: Binbin Wu <binbin.wu@linux.intel.com>

KVM: x86: TDX: Report CORE_CAPABILITIES as supported

This commit adds CORE_CAPABILITIES to the TDX configurable CPUID allowlist
to accommodate legacy TDX module behavior. It also modifies tdx_get_msr()
to return 0 for MSR_IA32_CORE_CAPS.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 26a5ad59a5694..b7661ba98a8d4 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c

[ ... ]

> @@ -2319,6 +2319,14 @@ int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_=
data *msr)
>  			return 1;
>  		msr->data =3D vcpu->arch.mcg_ext_ctl;
>  		return 0;
> +	case MSR_IA32_CORE_CAPS:
> +		/*
> +		 * KVM doesn't support MSR_IA32_CORE_CAPS, however, in some old
> +		 * TDX modules, CPUID.0x7.0.EDX[30] is fixed-1. As a workaround,
> +		 * just return 0 for this MSR.
> +		 */
> +		msr->data =3D 0;
> +		return 0;

[Severity: High]
Since MSR_IA32_CORE_CAPS is now exposed to userspace via tdx_get_msr(), does
tdx_set_msr() need a corresponding update to accept host-initiated writes?

During VM migration or state restore, userspace typically reads MSRs on the
source and writes them to the destination. If tdx_set_msr() doesn't handle
MSR_IA32_CORE_CAPS, the KVM_SET_MSRS ioctl will fall through to the default
case.

Because tdx_has_emulated_msr() does not include MSR_IA32_CORE_CAPS, won't
tdx_set_msr() return an error and immediately abort the migration?

>  	default:
>  		if (!tdx_has_emulated_msr(msr->index))
>  			return 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604023314.3907=
511-1-binbin.wu@linux.intel.com?part=3D4
