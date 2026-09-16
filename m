Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E64A498E
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789597799; cv=none; b=jaiNAbVlVwXsIuR69ZD5Nk5xFTOriKWqioJGeocmuMqqHZNW8zx7lUS4d2lJ7wE3JWmo7jLa0QX42Fef3st0ESS3ptJl5qPtfcnwWan0Z2Gzi+1oS+YQRmT847DyKBoCVF7VAue7paziELNpcXpkxbyH8LTgdFQbUu/fIH7ozkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789597799; c=relaxed/simple;
	bh=swRUYzKY873Sm/uRjbtzMHCZv0NpfnXXBoRafq+YHZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QFqwWt12inATyEO2sP5pM/CqTl0uAOfE3Dip33UZPB2EwYoUf8tveKfvxI7vHzF4tnYevf5tOBpTX8GVrmPeWO3PEZ3hOFEbkanwc1ilBCrE+sYs7MeC6h19rVFEAByqs1LyPdGa/YhkHR0bcKJTF9pusgTskN3g71865Mf2V/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0XpHYW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0XpHYW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA32C1F000FF;
	Wed, 16 Sep 2026 22:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789597789;
	bh=u8SGNhmr/OUaVRFFYQj11VhGVeZqizpBt1N4nDb/l5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P0XpHYW7SuiOms5ihJm6a/9w1R4wfJCpRcYEUY90LvxbJIV13GS8nikwRpeeFKLcV
	 fEypq7zrGUofdCjY0tpRZleZhC1Cecv/uYjzdFFsbiI+znJCEu+B6UO/ill0KGDOAr
	 l9F7hqWuK6q7btmWzzpBHYNROLdTRtsf3F8Ga29sNwmjttA/D4y33zsazWQa0SV7gO
	 gVC5K9LamRsqhbTfzQjExpdLEQdg0svaEV0L5N2c82buAqUNzBd8Sigm4GxXeypn5/
	 H+IsLhTwnCABsTezhLj0g4SnnTnG9b3Tyjx9FTAyspkdLytBoC54UBmJ5coHz6JUbh
	 ngeQTZQO4ohqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 4/5] x86/sev: Perform RMP optimizations
 asynchronously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <daa513fbe8f0672b00bc5e026e4399244be6dc72.1789594774.git.ashish.kalra@amd.com>
References: <cover.1789594774.git.ashish.kalra@amd.com>
 <daa513fbe8f0672b00bc5e026e4399244be6dc72.1789594774.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:29:48 +0000
Message-Id: <20260916222948.EA32C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] x86/sev: fatal #GP on blind RMPOPT scan across MMIO holes
- [High] x86/sev: soft lockup via IRQ-disabled IPI for cold RMPOPT cache
- [High] x86/sev: fatal #UD race between RMPOPT and firmware SNP shutdown
--

commit 62479bc981175bad2d66a2cbd0e76b01cb89e84b
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Perform RMP optimizations asynchronously

This patch adds support for performing RMP optimizations asynchronously usi=
ng
a dedicated per-CPU workqueue. It scans physical memory up to 2TB and
executes RMPOPT to skip RMP checks for 1GB regions that do not contain SNP
guest memory.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 25cb486ff61b6..bd97135cacc22 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
[ ... ]
> @@ -557,6 +576,12 @@ int snp_prepare(void)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(snp_prepare, "ccp");
> =20
> +static void rmpopt_disable(void)
> +{
> +	if (rmpopt_wq)
> +		cancel_delayed_work_sync(&rmpopt_delayed_work);
> +}
> +
>  void snp_shutdown(void)
>  {
>  	u64 syscfg;
> @@ -565,6 +590,8 @@ void snp_shutdown(void)
>  	if (syscfg & MSR_AMD64_SYSCFG_SNP_EN)
>  		return;
> =20
> +	rmpopt_disable();

[Severity: High]
Is it safe to cancel the worker here?

When SNP is disabled, the CCP driver sends SEV_CMD_SNP_SHUTDOWN_EX to the
firmware, which clears the SnpEn hardware state. The driver then calls
snp_shutdown(), which calls cancel_delayed_work_sync() here.

Between the firmware clearing SnpEn and the work being cancelled, the
background worker or an IPI can concurrently execute the RMPOPT instruction.

Executing RMPOPT while SnpEn is clear causes a #UD exception, leading to a
kernel panic.

> +
>  	clear_rmp();
>  	on_each_cpu(mfd_reconfigure, NULL, 1);
> =20
[ ... ]
> @@ -580,8 +607,69 @@ EXPORT_SYMBOL_FOR_MODULES(snp_shutdown, "ccp");
>  static bool rmpopt_capable(void)
>  {
>  	return cpu_feature_enabled(X86_FEATURE_RMPOPT) &&
> -	       cc_platform_has(CC_ATTR_HOST_SEV_SNP);
> +	       cc_platform_has(CC_ATTR_HOST_SEV_SNP) && rmpopt_enabled;
> +}
> +
> +/*
> + * RMPOPT optimizations skip RMP checks at 1GB granularity if this range=
 of
> + * memory does not contain any SNP guest memory.
> + *
> + * @pa is a system physical address; RMPOPT operates on the containing 1=
GB.
> + */
> +static void rmpopt(u64 pa)
> +{
> +	enum rmpopt_op_type op =3D RMPOPT_OP_VERIFY_AND_REPORT_STATUS;
> +	u64 pa_start =3D ALIGN_DOWN(pa, SZ_1G);
> +
> +	/* Supported by binutils 2.48+ */
> +	asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfc"
> +		     :: "a" (pa_start), "c" (op)
> +		     : "memory", "cc");
> +}
> +
> +static void rmpopt_scan_range(void *arg)
> +{
> +	u64 pa;
> +
> +	for (pa =3D rmpopt_pa_start; pa < rmpopt_pa_end; pa +=3D SZ_1G)
> +		rmpopt(pa);

[Severity: High]
Does this iteration skip non-system RAM such as the PCI MMIO hole (e.g.,
3GB-4GB)?

This iterates over the entire physical address range from min_low_pfn to
max_pfn in 1GB steps. Executing the RMPOPT instruction on addresses not
backed by valid system memory causes a #GP.

Since the rmpopt() inline assembly lacks an exception handler, will this
result in a fatal kernel panic when executing on MMIO holes?

> +}
> +
> +static void do_rmpopt_work(struct work_struct *work)
> +{
> +	/*
> +	 * Warm up the RMPOPT cache on this pinned per-CPU worker with interrup=
ts
> +	 * enabled, so the IRQ-disabled fan-out below only issues cache-hit RMP=
OPTs.
> +	 */
> +	rmpopt_scan_range(NULL);
> +
> +	on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true=
);

[Severity: High]
Could this IPI cause severe scheduling latency or potential soft lockups?

do_rmpopt_work() calls rmpopt_scan_range() locally to warm up the RMPOPT
cache, then uses on_each_cpu_mask() to run it on all other CPUs via IPI.

Since the RMPOPT table is per-CPU, local warmup on the worker CPU does not
affect remote CPUs. The IPI forces all other CPUs to execute the scan with a
cold cache.

Executing up to 2048 cache-miss hardware instructions inside an IRQ-disabled
IPI handler seems likely to cause severe latency issues.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789594774.gi=
t.ashish.kalra@amd.com?part=3D4
