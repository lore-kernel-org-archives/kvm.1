Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4383ED3CF
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385899; cv=none; b=MIdA+soebblWvJtGdIMBUIe4r0WIDzdROQ5xwFn+W07TFhTgR5Bei/5fl01RjhSQQDORsnZ7BlVb8YicKTMR84jFI4aVJUuA+w5ci0wY14xjKEshRRlU0IBfsBYXU+qkAbj1/tnuQdlQ8naYXaahc/1CN3OYPMVquzVXdJtG8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385899; c=relaxed/simple;
	bh=e+/ab9glg+9nl0XyTRt0nW22azAf590kdKxuvSFYtPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uUYeaVHkj6p4GgnuJihSypOzA732gZ9w4W21RW1GgYCrJ+8ydkVsiPsbkyBNoi9vg2K/akH47PMvlrFGTb5ivkV7oei8x5XoqD/b2cnb2DCDMO6Z8JBB4Lvk5dFHY6ZMjTvXKYb5xpDjUfyLVHM7VqMKsx0S1p1uLe1VzmOXTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E63el8J3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E63el8J3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260101F000E9;
	Wed,  2 Sep 2026 21:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788385890;
	bh=yMiAMIQFMJ1k2C0qm+n/bK3tJk915RxfE5RGpZYBaYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E63el8J3IZ2LO4f60vhmaR1PbCpH3SW4YrSKs7WaDayndEjcIwv+Z1dO2zexNCzsl
	 kLlTtZu9YG+YDnvLuFePiN2tsRHFCviP3ztvq4pppCcNZwiCc6PI1txX6KNntGit18
	 CH/OUZ+hrmd0GJcOYJRu6kXGhknGyaVdnUrZsssbtK/SkKX69eNuL0cPvMzbDmcbsQ
	 un0ZSP21ObtJJhzJfqG9WxIHMjK7fUuXKbWuaWrkGYuSDQWrN67+UtXZ5SKlQ3EHTU
	 +ZTN5bvJtKFW/evbHpaNY1jq825JU2D56/yqVOiQxVybf79NNvMJpzLEy2LZB3lK2H
	 8INFibyPvL0bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/5] x86/sev: Disable CPU hotplug while SNP is
 active
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <2c97a61a22a4808d422367e50db7ee0103a49860.1788296083.git.ashish.kalra@amd.com>
References: <cover.1788296083.git.ashish.kalra@amd.com>
 <2c97a61a22a4808d422367e50db7ee0103a49860.1788296083.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 21:51:29 +0000
Message-Id: <20260902215130.260101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] PM Suspend (S3) bypasses CPU hotplug disable, leading to secur=
ity breakdown
- [High] CPU hotplug remains enabled on kexec boot if setup_rmptable() fails
--

commit c91487bb659a8ce73e581c086c8aa1aa19f4b9aa
Author: Ashish Kalra <ashish.kalra@amd.com>
x86/sev: Disable CPU hotplug while SNP is active

This patch disables CPU hotplug while SNP is active to ensure no CPU comes
online without the SnpEn bit set. It ties hotplug to the SNP-enable bit by
disabling it in snp_prepare() and re-enabling it in snp_shutdown().

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

[Severity: Critical]
Does this sequence prevent CPUs from being onlined without SnpEn set during
power management transitions?

While cpu_hotplug_disable() blocks sysfs-initiated hotplug operations, it
appears that system suspend (S3) and hibernation (S4) bypass this mechanism.
During suspend, the PM core uses freeze_secondary_cpus() and
thaw_secondary_cpus(), which explicitly call _cpu_down() and _cpu_up()
regardless of the cpu_hotplug_disabled counter.

Additionally, MSR_AMD64_SYSCFG is not included in the list of MSRs saved and
restored during PM transitions in arch/x86/power/cpu.c.

If a system with SNP active goes to sleep and resumes, will the secondary
CPUs wake up without the SnpEn bit set, potentially breaking the SEV-SNP
security model by failing to enforce RMP checks?

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

[Severity: High]
If setup_rmptable() fails and returns -ENOSYS early, do we leave CPU hotplug
enabled even though the hardware might still have SNP enabled from a previo=
us
kernel?

When booting via kexec from an SNP-enabled kernel, the CPUs retain the SnpEn
bit in MSR_AMD64_SYSCFG. If setup_rmptable() fails here (for example, due to
a memremap failure), the function exits before reaching the new check that
disables CPU hotplug.

Because the function failed, the kernel clears CC_ATTR_HOST_SEV_SNP. If a C=
PU
is subsequently hotplugged via sysfs, the new kernel will not set SnpEn on
it, resulting in a state where boot CPUs have SnpEn set but the hotplugged
CPU does not.

Could this early return be moved after the MSR_AMD64_SYSCFG_SNP_EN check to
ensure hotplug is disabled whenever the hardware indicates SNP is active?

> +
> +	/*
> +	 * On a kexec boot SNP may already be enabled (legacy firmware leaves
> +	 * SnpEn set across shutdown), in which case snp_prepare() bails without
> +	 * disabling CPU hotplug, so disable it here.
> +	 */
> +	rdmsrq(MSR_AMD64_SYSCFG, val);
> +	if (val & MSR_AMD64_SYSCFG_SNP_EN)
> +		cpu_hotplug_disable();
> +
>  	/*
>  	 * Setting crash_kexec_post_notifiers to 'true' to ensure that SNP panic
>  	 * notifier is invoked to do SNP IOMMU shutdown before kdump.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788296083.gi=
t.ashish.kalra@amd.com?part=3D2
