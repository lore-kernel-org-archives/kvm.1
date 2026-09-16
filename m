Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE93D0C1D
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598202; cv=none; b=jU4v/qUZeKF8pcGKTpWqhUnZXtdPuOERSWgYzAOm8hhTD80BWmPM5+niYAkEB4vzzyWDTsuT2YIi/NSZrKFOdVV4CTcimc1a/osi9Nl3Z4NyD9zUTgpVihibk5kKpc0tkNF6H91OMSc4adc9gTwhE0j8na18qGGygGl6LFzmoyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598202; c=relaxed/simple;
	bh=yu0hmzH9RmKD8lmDRlnRosD01lDNKYQwmSfcqVNh4jc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lmmOK22HnUPC+tDdBBs6vkbbxonrFWl1McT9+z4phZ9QPZCk7N3XqdzLreYBUHRBx/CumH61ciisMxOp1Ta3T3W/a6x8Bpl7AasRVkTJvheE6I+LYIJvyyDKXzZlmREkYJC7aOBEMjW2bVunH105uw7Lgd2B0vGE0f2s1WgNxAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaHDdmFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaHDdmFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E1C1F000FF;
	Wed, 16 Sep 2026 22:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789598191;
	bh=iP/V//93qF4LV27JlKlcrT+OUp8TlObcr1ApvYd8NU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MaHDdmFJb2Ul7F0JBdYnYAXVSBo1epuxH1Bj9r5iD2A4Ur+RO070NigCWoraTwrmG
	 jjQ0f8kwkECRoZ/3g/2LEOYmfpy64qx5jvBzTFcvKjr9B/PmF0hQequtI8CDa4oMJw
	 UOidofAhVAoPp33HACl0YxrCnzCVq0VZfCH13A+Tse3HN25Q13OSv/sXn5NbP0Z4uX
	 om2kvGffS8lTBhwCCA3lpwRz8V5hVwD6cT5EVTHbXIwmF+kR4AXdybIGjyaLTRiATK
	 e/c2rEfSYOIPmtrOTT6ni1g+qr70fZGB7UwzANQnBmBuMAoR5fvFqTAjt9j+qU7d/S
	 KeX0zVGmTeFXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 2/5] x86/sev: Disable CPU hotplug while SNP is
 active
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <cd6962a88d691a020c2bf40fe77a6a3f3852fdfc.1789594774.git.ashish.kalra@amd.com>
References: <cover.1789594774.git.ashish.kalra@amd.com>
 <cd6962a88d691a020c2bf40fe77a6a3f3852fdfc.1789594774.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:36:30 +0000
Message-Id: <20260916223630.C5E1C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/sev: CPU hotplug disablement bypassed on early kexec errors
--

commit ac084f2d7188c520f2ee3ced2ab76e4c068df91f
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Disable CPU hotplug while SNP is active

This commit disables CPU hotplug when SNP is enabled to prevent SNP guest
memory from being broken by CPUs coming online without the SnpEn bit set.
It ties CPU hotplug to the SNP-enable bit, disabling it in snp_prepare()
and re-enabling it in snp_shutdown() when SNP is disabled. It also
explicitly disables CPU hotplug during kexec if SNP is already enabled.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index cff285d8ad8e3..558f7924a3f85 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> @@ -577,6 +582,8 @@ EXPORT_SYMBOL_FOR_MODULES(snp_shutdown, "ccp");
>   */
>  int __init snp_rmptable_init(void)
>  {
> +	u64 val;
> +
>  	if (WARN_ON_ONCE(!cc_platform_has(CC_ATTR_HOST_SEV_SNP)))
>  		return -ENOSYS;
> =20
> @@ -586,6 +593,15 @@ int __init snp_rmptable_init(void)
>  	if (!setup_rmptable())
>  		return -ENOSYS;
> =20
> +	/*
> +	 * On a kexec boot SNP may already be enabled (legacy firmware leaves
> +	 * SnpEn set across shutdown), in which case snp_prepare() bails without
> +	 * disabling CPU hotplug, so disable it here.
> +	 */
> +	rdmsrq(MSR_AMD64_SYSCFG, val);
> +	if (val & MSR_AMD64_SYSCFG_SNP_EN)
> +		cpu_hotplug_disable();

[Severity: High]
If a kexec kernel boots into a system where the previous kernel left
MSR_AMD64_SYSCFG_SNP_EN active, and an early initialization step fails
(such as passing amd_iommu=3Doff on the kernel command line resulting in
!amd_iommu_snp_en, or setup_rmptable() failing), snp_rmptable_init() will
return -ENOSYS before checking the physical MSR hardware state and
disabling CPU hotplug.

Because hotplug remains enabled and the CCP driver skips initialization on
failure (bypassing snp_prepare()), could a subsequently hotplugged CPU come
online without the SNP_EN bit set?

If this results in a mixed hardware state, does it violate firmware
constraints and cause fatal RMP faults when the new CPU accesses memory?

Should the hardware state be checked and hotplug disabled unconditionally
before the software configuration checks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789594774.gi=
t.ashish.kalra@amd.com?part=3D2
