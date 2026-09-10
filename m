Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E449E157
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079121; cv=none; b=GcQat5zTVENGMe+YDoEzuxb57RSVTVaJJLjuRmEAVPvDY2bH3d62F5Bwd5CyCcr5a1t3eyDzFO63pg9BJckVo7haQBTUG3EIzd5sdjPz07TtbJmKNZRWMyRsOqPd2ZmlMzDW+SuY8x0ZQYLb6Yzj49KMW5tEXemqXf/Zy2sAlkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079121; c=relaxed/simple;
	bh=0L0OAaGqDmPbtbdHcLV54zTSwXmDkyci1R4wrKacaRk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jEsa8Vg/KfCNmgGIqxhMvz3Yvi6SXchZt3UTA1snzhQEM2IlLrwhOL8UON8un532f5+r9v0wCiGJes0V8nOqY2EOQt8tT8N1YJJyJ0z+4TJrvgdE60xzobPOUkEDrEQFas1d3Wup/LqMLPveptS5+CxClP9d+LIy+sEN5VuZpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKqnpGAr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKqnpGAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5191F000FF;
	Thu, 10 Sep 2026 22:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789079118;
	bh=jB+eoQM6Urrnl+mQEI8Na3Epav19SomWWekTC/juaNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eKqnpGArn6RqdpdbvyUYNCLKdOf4oVyitQYEDDyGi/UDcyy1u72UD42I8FpJFAGeE
	 WwGvc4DQFuJWHTs6+RbB4U9zo7yvuDLancchhZjglFCxqcU44Ao6UKlYrjguXTYKJ8
	 jRYb9lAXxLDzydUFZpacD2TZzJYnsh01i53zhtMbY3yFh0sBTKLcHVul6Iph5pnktJ
	 bAGvRzFlu7JZpTYpbTBgeuF96l+aZq+xyUn5qp65bEkZFxvxfJpOENndMtohVIfoFN
	 UpySOCHCV1kz8GNdlH8OCO9vPlQ90EoU/qdAoOCMRBhCzZce7aD8r1oiGxqQPYDUC6
	 hlIJX2uKr3y8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 2/5] x86/sev: Disable CPU hotplug while SNP is
 active
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <cd6962a88d691a020c2bf40fe77a6a3f3852fdfc.1788984053.git.ashish.kalra@amd.com>
References: <cover.1788984053.git.ashish.kalra@amd.com>
 <cd6962a88d691a020c2bf40fe77a6a3f3852fdfc.1788984053.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 22:25:18 +0000
Message-Id: <20260910222518.AB5191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] System suspend/resume bypasses cpu_hotplug_disable() and brings CP=
Us online without SnpEn set, breaking the SNP invariant.
--

commit 0243c46e8f299e3de42fbcddbc4c7bd93fb68c65
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Disable CPU hotplug while SNP is active

This commit disables CPU hotplug while SEV-SNP is active. This ensures no
CPU can be brought online without the SnpEn bit set in MSR_AMD64_SYSCFG,
which is required for hardware RMP checks to function correctly.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index cff285d8ad8e3..558f7924a3f85 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
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

[Severity: High]
Does system suspend/resume bypass cpu_hotplug_disable() and bring CPUs onli=
ne
without SnpEn set, breaking the SNP invariant?

If the host initiates an ACPI system suspend (e.g., S3), freeze_secondary_c=
pus()
offlines all secondary CPUs via _cpu_down(), which bypasses the
cpu_hotplug_disabled counter incremented by cpu_hotplug_disable().

Upon resume, thaw_secondary_cpus() brings the CPUs back online via _cpu_up(=
).
Because CPU MSR state is lost during power-off in suspend and snp_enable() =
is
not registered as a CPU hotplug callback, the secondary CPUs wake up with S=
npEn
cleared. This would allow them to bypass hardware RMP checks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788984053.gi=
t.ashish.kalra@amd.com?part=3D2
