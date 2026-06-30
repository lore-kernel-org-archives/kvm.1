Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8453DB635
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844352; cv=none; b=VSPbnHDOfrOL2XYxxsrcA5kRamzVM0zOebyBtiMLQ6/rc0x/wEf6xCmAvkm1zsyjPn0OzeoYIaIu8erpe31H+T11fQX7jqUC1lEaU5G1k17K/QAcxEMAgTk4QxoKIzT982EDU7jQRUL5fz0t76PD3dDsmTzMFWNqx/mKqV7xqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844352; c=relaxed/simple;
	bh=jFL1eeAvFwC4UkFwoyqlZ/l33ANtooJLc/MVp7q9NZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k6Oouj+qgmvyc7d1uABFwQCErR4hlYbWJJbYIokNz53t/SRrCIUsjsqFNg6KihXNbT0GMhTPbBUp1zoUfXJ5lKFHlBqpoZtpUYN2oBcRb2tfCX2mqZ/M+lnTa15Qs9oRjAVIvlE2wRE0rovuMGJnABjTsnA5I9JTlMuXetC6ITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPo4BFay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPo4BFay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393071F000E9;
	Tue, 30 Jun 2026 18:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782844351;
	bh=4Oz6KyxbBYp9K/z7ua9anQILjsjMQTGejkOiSmx6YAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CPo4BFayliG6nyX26cMU0qiqrhmsuz2vFnMDsBzzmb/5lkNRlbok6DJHnUw0oOh0D
	 QLhPv2L0Y9qD5r9e38GuN7RfiKZC4GEMMW2hTYxv8hZMnU+h5oqnfHlXDfxV+YcQj7
	 xGNyCQBpEM1b2feDWjkqk62YVrdwJcFnm0Db8Iuhi6h5BZKeY6VR8szCplO1tufyok
	 wPMbZ1EyWa/d9W4yxN1xLd375xbVIHaQo2EMh74GRC+gW+r+sS8m1HxLcz3uYR0MIn
	 p1iP3nyYNYN6DBQKgyxM7bu9w5lkUNIbzbUuplGYzPHiluiCiDl4G82yQw5vWdOLwI
	 7UFvREQURNdSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/6] x86/sev: Disable CPU hotplug while SNP is
 active
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <205a5259f9fd353dc0ca6b00565c8175a96768c7.1782841284.git.ashish.kalra@amd.com>
References: <cover.1782841284.git.ashish.kalra@amd.com>
 <205a5259f9fd353dc0ca6b00565c8175a96768c7.1782841284.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 18:32:30 +0000
Message-Id: <20260630183231.393071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] System suspend (PM transitions) bypasses `cpu_hotplug_disable(=
)`, stripping `SnpEn` from secondary CPUs on resume.
--

commit 29b8362e9ad72efa8892f6bb3124dbbcc29ee822
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Disable CPU hotplug while SNP is active

This commit disables CPU hotplug in snp_prepare() before SNP is enabled and
re-enables it in snp_shutdown(). This aims to prevent CPUs from coming onli=
ne
without the SnpEn bit set while SNP is active, as the firmware cannot track
OS CPU hotplug events.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index dab6e1c290bca..04a58ac4339cb 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -535,6 +535,15 @@ int snp_prepare(void)
> =20
>  	clear_rmp();
> =20
> +	/*
> +	 * Disable CPU hotplug before enabling SNP, so no CPU can come online
> +	 * without SnpEn while SNP is enabled; it is re-enabled in snp_shutdown=
()
> +	 * once SNP is disabled.  Must be before cpus_read_lock():
> +	 * cpu_hotplug_disable() takes cpu_add_remove_lock, which nests above
> +	 * cpu_hotplug_lock.
> +	 */
> +	cpu_hotplug_disable();

[Severity: Critical]
Does this actually prevent all CPUs from coming online without SnpEn?

Looking at system suspend (PM transitions), freeze_secondary_cpus() calls
_cpu_down() directly, which bypasses the cpu_hotplug_disabled check. Upon
resume, thaw_secondary_cpus() brings them back online via _cpu_up().

Since snp_enable() is called via a one-off on_each_cpu() in snp_prepare()
rather than being registered as a CPU hotplug callback, wouldn't secondary
CPUs resume with the SnpEn MSR bit cleared?=20

This could allow a suspend/resume cycle to create an asymmetrical state whe=
re
hardware RMP checks are bypassed.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782841284.gi=
t.ashish.kalra@amd.com?part=3D3
