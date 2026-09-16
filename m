Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F718436BC9
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589541; cv=none; b=urQ4vTCfYgmgryxDf7JhMIaugc3xijSGu9Y4FjMann+clnZd9WKUVpy3NK1sxRH9fMd34LtTozp8TYQLOmLRcLNEoq8qUqsQiFmMNsAtcbFI18k4zadxnaA3aFwI45upzvnZcsivClVhZcftd1zLHGVCcfSzaC9Tp5nzfLcBzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589541; c=relaxed/simple;
	bh=Sz/9sAbagyqRUe0w4LWL1g6efeSvA++4DNYcZkMEM64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M4/Dd1eg2Av1zaTeRr4P2/8s3715jCJ12XGNzXEoTjwzGcvDgnnZQdjX0MsMdqHDMHvxkM2Iz/wB1//ZRcYIQu7N5nMD5O4p8thsyBJD0c+XLia4VTLHXnpc84BI0koy1/5/7N5E9JbwcYcDzE64oGAODsfqRPRLi2LyI8P3tYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkihcLhX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkihcLhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1BD1F000FF;
	Wed, 16 Sep 2026 20:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789589505;
	bh=JdCoE06bCA9CTat5TvO6QvMJhKqki09wA/Zicyzep+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dkihcLhX3CNPQBrkFOq4q7EB9ivNBB7O9Tl3f+ZbYB/KHOoaG9uVATQ2TAMeCVvgp
	 R9mTjySapHb4MOCWDKuQPYKIGFCZH69XgpL/mII5zQimoX77K1POiU0PLa9rM7DBvn
	 0D9p9FS397lcyYx0iSK0N8ZPs12n1Aq0XNjbO9K8knYSOxjqHZzhwJ4F3/QHASsTa4
	 mnZ707VhzpiUE2YzZ2GzWhELLptsk68q9aAoUvSjohUaHxO1B6olg2lVN8Y6/eqdQU
	 22FOSbRfj9QOdMVpCjZAILasOtPuu0Jg/DVpbN1r6Mq/CBh/3sfIRmBaMLT2ZQYM3a
	 1jvlgFAZKXvjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 2/5] x86/sev: Disable CPU hotplug while SNP is
 active
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <cd6962a88d691a020c2bf40fe77a6a3f3852fdfc.1789586444.git.ashish.kalra@amd.com>
References: <cover.1789586444.git.ashish.kalra@amd.com>
 <cd6962a88d691a020c2bf40fe77a6a3f3852fdfc.1789586444.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 20:11:45 +0000
Message-Id: <20260916201145.9B1BD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] x86/sev: PM suspend bypasses cpu_hotplug_disable() leading to miss=
ing SnpEn
- [Medium] x86/sev: early return skips cpu_hotplug_disable() when SnpEn is =
already set
--

commit b1980431b3abd35a5fe5e83fed1107ef1f0ec745
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Disable CPU hotplug while SNP is active

This patch ties CPU hotplug to the SNP-enable bit to prevent CPUs from
coming online without SNP enabled and initialized. It replaces the
cpus_read_lock() previously taken in snp_prepare() with
cpu_hotplug_disable() and reenables it in snp_shutdown(). Additionally,
it disables CPU hotplug in snp_rmptable_init() for kexec boots where
SNP is already active.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index cff285d8ad8e3..558f7924a3f85 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> @@ -526,14 +525,18 @@ int snp_prepare(void)
> =20
>  	clear_rmp();
> =20
> -	cpus_read_lock();
> +	/*
> +	 * No CPU may come online without SnpEn while SNP is active; disable
> +	 * hotplug here and re-enable it in snp_shutdown().
> +	 */
> +	cpu_hotplug_disable();
> =20
>  	if (!cpumask_equal(cpu_online_mask, cpu_present_mask)) {

[Severity: High]
Does this fully prevent secondary CPUs from coming online without SnpEn set
during power management suspend and resume?

Looking at the PM suspend path, freeze_secondary_cpus() calls _cpu_down(),
and thaw_secondary_cpus() calls _cpu_up().

Both of these internal functions bypass the cpu_hotplug_disabled counter
that is incremented by cpu_hotplug_disable().

Could a PM suspend/resume cycle successfully offline and online secondary
CPUs, causing them to resume without SnpEn set and bypassing hardware RMP
checks?

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

[Severity: Medium]
Could this leave CPU hotplug enabled if an early initialization step fails
during a kexec boot where legacy firmware leaves SnpEn set?

If setup_rmptable() fails and returns false, the function returns -ENOSYS
early.

Because the check for MSR_AMD64_SYSCFG_SNP_EN and the call to
cpu_hotplug_disable() happen after these early returns, CPU hotplug would
remain enabled.

Newly onlined CPUs might lack SnpEn as a result, creating a mixed hardware
state. Should the hotplug disablement happen before these early returns?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789586444.gi=
t.ashish.kalra@amd.com?part=3D2
