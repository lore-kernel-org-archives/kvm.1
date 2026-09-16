Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBA4AF69E
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789597616; cv=none; b=KG1Nth3ZWnZrlgbLy44LIzGvnLDoz69EJs702RMXPYA6yxA2shOgjmiY6Z4Djdyi0y9aKZJ6Z4W7NosqzyGBd1F4t6sHWGtVrFDKgl/lxiFd2lbXvbKNKb0N+Ng7g8lfsFH6APKcSE9LW6IfmQbwRMwhBYLqsXTL41ge0ujbBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789597616; c=relaxed/simple;
	bh=IeTRb04uoOveNPamREbwq9weMAUNxt9sVaAHN5lXxwQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VaOQycR6uFoKiPYNBd9zQQjZqmb9c+21eqjyoeS0igkIkL3+pzxIwov/pcF4HZFun0F6/orpR9t0HaaRrs9t9eP5l0/FcP18Ni7dqBP7rymkimh+sRcgAudAsQbUT0SMkwWfsxlKzfX1XMa8MJ2ie8byPnpWeuP2oqfFXF9RA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5+KCZVB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5+KCZVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E513D1F000FF;
	Wed, 16 Sep 2026 22:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789597605;
	bh=u0yFWs4fAszuxDN9prKKuMf7U0OG+hnYi+LAQD+ha4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V5+KCZVBst57Lp5wCsexij5+2/c6m4q8uCwIIew3hSf1cOcD1YydAoSUigoWHViye
	 7Xc0eD2RnKNbHnGy++3ER8a2whmF8YlZi+8oeNQmmGQ/Sgrpa8qzF0Hk0wYD+YRCyo
	 Ypv9s4nZBsMItEeLhjobEbKdCjYTWViwFKcOjvud393QAb0A7RHVpyXLU8XTDU0/vJ
	 hW/LrHGIQJI+st75BnDRIb6+/ESqxPw6MxW8XDdOjkg3dRyTn5iKeNOVga6+5tdRIg
	 jHNTNqyJep0lAds/lFPGzLBl8cdHR5BDs/0P95hC4H+9M3j9pOO2OQBeF2hU+YIOgb
	 rWozWj4zS2PBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 3/5] x86/sev: Initialize RMPOPT configuration MSRs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <7fdf0f5b1be4b561c884c5200d6606a947cbc09d.1789594774.git.ashish.kalra@amd.com>
References: <cover.1789594774.git.ashish.kalra@amd.com>
 <7fdf0f5b1be4b561c884c5200d6606a947cbc09d.1789594774.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:26:44 +0000
Message-Id: <20260916222644.E513D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/sev: missing MSR configuration on CPU hotplug cycle due to loc=
al check
--

commit f73eea5b303a29d64f9efe740eeba6e570bac844
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Initialize RMPOPT configuration MSRs

The new RMPOPT instruction helps manage per-CPU RMP optimization
structures inside the CPU. Initialize the per-CPU RMPOPT table base to
the starting physical address to enable RMP optimization for up to 2 TB
of system RAM on all CPUs.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 558f7924a3f85..25cb486ff61b6 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> @@ -575,6 +577,42 @@ void snp_shutdown(void)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(snp_shutdown, "ccp");
> =20
> +static bool rmpopt_capable(void)
> +{
> +	return cpu_feature_enabled(X86_FEATURE_RMPOPT) &&
> +	       cc_platform_has(CC_ATTR_HOST_SEV_SNP);
> +}
> +
> +void snp_enable_rmpopt(void)
> +{
> +	u64 base;
> +	int cpu;
> +
> +	if (!rmpopt_capable())
> +		return;
> +
> +	rmpopt_pa_start =3D ALIGN_DOWN(PFN_PHYS(min_low_pfn), SZ_1G);
> +
> +	/*
> +	 * Per-CPU RMPOPT tables cover at most 2 TB.  Program each core's
> +	 * RMPOPT_BASE with the start of RAM to optimize up to 2 TB.  The MSR
> +	 * can only be written after SNP is enabled, so this runs from the ccp
> +	 * SNP init path (and again on guest teardown) rather than an initcall.
> +	 *
> +	 * The loop below programs RMPOPT_BASE on all primary threads.  RMPOPT_=
EN
> +	 * cannot be cleared while SNP is enabled, and CPU hotplug is disabled
> +	 * while SNP is active, so once programmed the MSRs stay set on all CPUs
> +	 * until SNP is disabled.  A set RMPOPT_EN on the local CPU therefore
> +	 * means the programming has already been done, so skip it.
> +	 */
> +	rdmsrq(MSR_AMD64_RMPOPT_BASE, base);
> +	if (!(base & MSR_AMD64_RMPOPT_ENABLE))
> +		for_each_cpu(cpu, cpu_primary_thread_mask)
> +			wrmsrq_on_cpu(cpu, MSR_AMD64_RMPOPT_BASE,
> +				      rmpopt_pa_start | MSR_AMD64_RMPOPT_ENABLE);

[Severity: High]
Could this local CPU check cause hotplugged CPUs to miss MSR configuration?

If SNP is shut down, CPU hotplug is re-enabled but the MSR remains intact on
existing CPUs. If a CPU is offlined and brought back online, its MSR is res=
et
to the default.=20

Later, when SNP is re-enabled, the local CPU executing snp_enable_rmpopt()
might still have its own RMPOPT_ENABLE bit set. Will it erroneously assume
all CPUs are programmed and skip the wrmsrq_on_cpu() loop, leaving the
hotplugged CPU unconfigured?

> +}
> +EXPORT_SYMBOL_FOR_MODULES(snp_enable_rmpopt, "ccp");
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789594774.gi=
t.ashish.kalra@amd.com?part=3D3
