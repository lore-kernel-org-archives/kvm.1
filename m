Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D23CB54E
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181052; cv=none; b=glA51UdksVKh1pyyIu/wKG73IEUE3czY6rjKbp97i1ucdr68bw81z5Eitg1FFQI2l4eEbGKkutZOsaiwMlHQxiSe8UTY9DblkSazM8ge9H1cwrKsxvpih1a2wiz9HBl5uABy8LxersGzNVvFWgkY98L+F84mc4JpEaQHhJ8qC94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181052; c=relaxed/simple;
	bh=ViqyN1rm5iuNkpJtBRh2h+rLXuvCnpNPyZx6ygCyWf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PaCRTsmq+uQH2CObT0kmUHqJFmuBapdT4hbEWt3iRNfzciRA3ai+SeRgMxsBSRjae6oS5N3N8WzEidYKP6o7wpdgoyZ8ZsEjM271vfT7Qmlcukb+ozergp5y9Ow0VRNqjzQniljdzchdtM+2hkciRnlpbi63mMQlFztP94usaoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKmQuTkI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKmQuTkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8E21F000E9;
	Mon, 27 Jul 2026 19:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181049;
	bh=lFDXe0XVuKEGBk4QXGZOvC7BDuKKN0WA/0IsSdf3A7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aKmQuTkICimgUKAY4ADq6OJKXtIRvwLXvI8TgLywE/dqba10FqvX7Ri/tOMkFYMdM
	 Hj6d77FPUd/h7DFTYa1U4cLB5BHa/dN1EuuRWuuUwo0Yay6pK9o3aDBFAHFwgLj2Fp
	 Gvey9MfaTOAZgZYgFr3kyF2AMpPMB0DADB/AhrUTuHMmJpK3xhqamfZm8jXlUjwrHd
	 A1G6Xqci93c0osPJzO8IuJR+YA44POANqElq4HpHxed3SukEj4EngvpXbXtQyEq0n2
	 wBA/WBc6xY9SfrnWbjBoTQbN2PFuUrAmuN3LEmK29yvqEMFsK6RAKj0P0osxPMP1jv
	 OnSn1XGW+D46g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/6] x86/sev: Disable CPU hotplug while SNP is
 active
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <e1631971b3862bcd6043199feba3df51f3ba336c.1784844080.git.ashish.kalra@amd.com>
References: <cover.1784844080.git.ashish.kalra@amd.com>
 <e1631971b3862bcd6043199feba3df51f3ba336c.1784844080.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:37:29 +0000
Message-Id: <20260727193729.7D8E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] System suspend/resume bypasses `cpu_hotplug_disable()`, causing se=
condary CPUs to come online without the `SnpEn` bit set.
--

--- Patch [2]: [PATCH v11 2/6] x86/sev: Disable CPU hotplug while SNP is ac=
tive ---
commit 2ca360619d15fed203ba00f43d20453130503df3
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Disable CPU hotplug while SNP is active

This commit replaces cpus_read_lock() with cpu_hotplug_disable() in
snp_prepare() to prevent CPU hotplug while SEV-SNP is being enabled. It
additionally keeps hotplug disabled as long as SNP is active to ensure OS C=
PU
hotplug does not diverge from firmware expectations.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index cff285d8ad8e3..e2f69fba09389 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> @@ -526,14 +525,21 @@ int snp_prepare(void)
> =20
>  	clear_rmp();
> =20
> -	cpus_read_lock();
> +	/*
> +	 * Disable CPU hotplug before enabling SNP: no CPU may come online
> +	 * without SnpEn while SNP is active, and none may go offline during
> +	 * enable.  This keeps cpu_online_mask stable for the check and the
> +	 * on_each_cpu() calls below, so cpus_read_lock() is not needed.  It is
> +	 * re-enabled in snp_shutdown() once the firmware disables SNP.
> +	 */
> +	cpu_hotplug_disable();

[Severity: High]
This is a pre-existing issue, but does cpu_hotplug_disable() reliably
prevent secondary CPUs from coming online without the SnpEn bit set?

System suspend and resume transitions bypass the sysfs hotplug locks. Durin=
g a
suspend and resume cycle, freeze_secondary_cpus() and thaw_secondary_cpus()
directly invoke internal routines that offline and online CPUs, respectivel=
y.

Because snp_enable() is not registered in a CPU hotplug callback, if a
secondary CPU is thawed, it appears it would wake up and come online without
the MSR_AMD64_SYSCFG_SNP_EN bit set. Would this leave the system vulnerable
by allowing arbitrary host access to SEV-SNP guest memory, since no RMP
checks would be performed by those CPUs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784844080.gi=
t.ashish.kalra@amd.com?part=3D2
