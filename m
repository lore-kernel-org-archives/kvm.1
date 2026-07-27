Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1420C37A847
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180152; cv=none; b=PdTl+/SC2r+pYM8inkRiWRE5ApQa1+dhQ6MMTnTdQ1ItTP4p2Jonj3PbeF4L7FdTO7T0AxHvN8V1rbtOsAxOxRm7Hlisst/xODTvRYSI+uW3LTxfgLuCHtgDM+oQ0UeMm+zIAuiObPF21sD2f5WWITHWWyWTKNOJ9hHxwtDVvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180152; c=relaxed/simple;
	bh=2KfP/duPmwGscXLTndTdGCghsA08Jvo5RUX2o0nmN9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C24x2tD3XnO4538znyFtWdd041Z0OQolOkcBEsyon6b+ItuNowWWIGzoiGsYDBtVDhlQT+encU/FR+2fhNp9Ku/xC0nm6rzNnLtH3DmXvdnVvQnoWDMAjNWl5/eqi/QoNUw5/qAiMrjeJ6YsTSeHp/6uu61NO051G7NnQ84Gzmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCVm9ai9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCVm9ai9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADC91F000E9;
	Mon, 27 Jul 2026 19:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785180150;
	bh=uh0VAMssvl1cbDVCWHmR6r2Z5+Uf9j5cTeZ/oRCKvSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YCVm9ai9wZ7GY+PyJR43bPs+3Y3il2PA/fBeEM9IKdaPVrGHV57emjmc9rrKOmboB
	 PrN6c8E8O3AmrFccjAye5K6L5NguUQgOLM8AE5PaNxD57fXg5us22UF6yqXuuWwTWQ
	 BsQkTubOgoB0PZ/mqRKaffb57XyNuu//zNIzLS/6R2rtewvLaxe7Je1ZX/sSPV2EtN
	 KSBKrb/9yaW4nxc5D2PIeu3UdmdEUAjFJbEt8yRJwwohRhs1oo8ecm4lOgsKYuZz4r
	 HvXfN5nDQCF/q8/ONUhtEBxYwtCX5shVQuyz4EDy6Z8qy/Pqq6p+QUJdbi16clM0+M
	 5s4eyfDAEmkFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/6] x86/sev: Initialize RMPOPT configuration MSRs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <ff346ea1770cf996e1623270a085ac08d21888c6.1784844080.git.ashish.kalra@amd.com>
References: <cover.1784844080.git.ashish.kalra@amd.com>
 <ff346ea1770cf996e1623270a085ac08d21888c6.1784844080.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:22:30 +0000
Message-Id: <20260727192230.9ADC91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] `snp_cleanup_rmpopt()` unconditionally dereferences `rmpopt_cpumas=
k`, causing a deterministic kernel panic on shutdown if the mask was never =
allocated (e.g., on CPUs without RMPOPT support or if allocation fails).
- [High] If SEV-SNP firmware initialization fails, the error path returns d=
irectly without cleaning up the state set by `snp_prepare()`, leaving CPU h=
otplug permanently disabled.
- [Medium] Re-initializing SEV-SNP after a legacy shutdown leaks the `rmpop=
t_cpumask` allocation because the old pointer is overwritten without being =
freed.
--

--- Patch [3]: [PATCH v11 3/6] x86/sev: Initialize RMPOPT configuration MSR=
s ---
commit e4623d49ab6201adc5b609f5a6043ed6dfb7f55c
Author: Ashish Kalra <ashish.kalra@amd.com>
Subject: x86/sev: Initialize RMPOPT configuration MSRs

The new RMPOPT instruction helps manage per-CPU RMP optimization
structures inside the CPU. This commit initializes the per-CPU RMPOPT
table base to enable RMP optimization for up to 2 TB of system RAM.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index e2f69fba09389..8bfd802848361 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
[ ... ]
> @@ -558,6 +561,17 @@ int snp_prepare(void)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(snp_prepare, "ccp");
> =20
> +static void snp_cleanup_rmpopt(void)
> +{
> +	int cpu;
> +
> +	for_each_cpu(cpu, rmpopt_cpumask)

[Severity: High]
If rmpopt_cpumask was never allocated, does this macro dereference a NULL
pointer?

In snp_setup_rmpopt(), if rmpopt_capable() is false, the mask remains
unallocated. When snp_shutdown() subsequently calls snp_cleanup_rmpopt(),
it iterates over the mask without checking if it is available.

Can this cause a kernel panic on system shutdown or module unload for
systems without RMPOPT support?

> +		wrmsrq_on_cpu(cpu, MSR_AMD64_RMPOPT_BASE, 0);
> +
> +	free_cpumask_var(rmpopt_cpumask);
> +	rmpopt_pa_start =3D 0;
> +}
[ ... ]
> @@ -578,6 +593,46 @@ void snp_shutdown(void)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(snp_shutdown, "ccp");
> =20
> +static bool rmpopt_capable(void)
> +{
> +	return cpu_feature_enabled(X86_FEATURE_RMPOPT) &&
> +	       cc_platform_has(CC_ATTR_HOST_SEV_SNP);
> +}
> +
> +void snp_setup_rmpopt(void)
> +{
> +	u64 rmpopt_base;
> +	int cpu;
> +
> +	if (!rmpopt_capable())
> +		return;
> +
> +	if (!zalloc_cpumask_var(&rmpopt_cpumask, GFP_KERNEL)) {

[Severity: Medium]
Does this unconditional allocation leak the previously allocated cpumask
when SEV-SNP is re-initialized?

During a legacy shutdown, snp_shutdown() returns early when the SnpEn
firmware bit is still set, skipping snp_cleanup_rmpopt():

arch/x86/virt/svm/sev.c:snp_shutdown() {
...
	rdmsrq(MSR_AMD64_SYSCFG, syscfg);
	if (syscfg & MSR_AMD64_SYSCFG_SNP_EN)
		return;
...
}

A subsequent call to __sev_snp_init_locked() will invoke snp_setup_rmpopt()
again and overwrite the old pointer without freeing it.

> +		pr_err("Failed to allocate RMPOPT cpumask\n");
> +		return;
> +	}
[ ... ]
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index f833cb7e4da36..0b40d23a26b45 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1630,6 +1630,9 @@ static int __sev_snp_init_locked(int *error, unsign=
ed int max_snp_asid)
>  	}
> =20
>  	snp_hv_fixed_pages_state_update(sev, HV_FIXED);
> +
> +	snp_setup_rmpopt();
> +

[Severity: High]
If the SEV-SNP firmware initialization fails, does this leave CPU hotplug
permanently disabled?

A global cpu_hotplug_disable() call is made inside snp_prepare() right befo=
re
we reach this code. If the subsequent firmware command fails in
__sev_snp_init_locked(), it returns the error directly without cleaning up:

drivers/crypto/ccp/sev-dev.c:__sev_snp_init_locked() {
...
	rc =3D __sev_do_cmd_locked(cmd, arg, error);
	if (rc) {
		dev_err(sev->dev, "SEV-SNP: %s failed rc %d, error %#x\n",
			cmd =3D=3D SEV_CMD_SNP_INIT_EX ? "SNP_INIT_EX" : "SNP_INIT",
			rc, *error);
		return rc;
	}
...
}

Since sev->snp_initialized remains false on this error path, snp_shutdown()
is never executed on teardown, meaning cpu_hotplug_enable() is never invoked
to release the lock.

>  	sev->snp_initialized =3D true;
>  	dev_dbg(sev->dev, "SEV-SNP firmware initialized, SEV-TIO is %s\n",
>  		data.tio_en ? "enabled" : "disabled");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784844080.gi=
t.ashish.kalra@amd.com?part=3D3
