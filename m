Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752092D6E44
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554463; cv=none; b=l9bOt/FywlKHKBOIRhMgMULiY/0vaI7bkzfS7TM3XyDt0fnBkDApQhPLyDaKLzim/tKA1clSef9/1N8v0pKmuOpaR+Buvun3yx+p7+2X8hIaU5NsQX2fgdDJ1YM6ufa53mq6sDAAxvOhE1ARrmY7BI/TnKZU7bZb0Sb7WIOkOu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554463; c=relaxed/simple;
	bh=g8A09Rcfkbasj2OjHZOVgPVO/aBXSvVY+q8Ak/ump0g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a090aVNrdr5v+lgFdqTwlwK7ETjNBlWj1O/EBu3qs5d1ec4+r7jRrN3kFOlnKenhPjB5TtfS5E74/pLbXNUo2APtxyBtjULk7JWZDBp206nRxbxTQz8EUAzazJDv96g1eY8sMV+QzqO/dbPU23KacWY5By52Jd9ZnaH8mjCXLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4rj0hKE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4rj0hKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25D91F000E9;
	Mon, 15 Jun 2026 20:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781554462;
	bh=qzRp0+MLmOzA+Ewugv5UnrBweFz16TDBCH7/IYzwSkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y4rj0hKEcm2ogr+vmEsGcxSIB3tN/912ua65JLYRbu2TAOR94RINbpP9+lSsKAiWX
	 rgMUgLHNTfYli16WJ7gyl7KzFbeEOA6V+usJ9Edh5L+5uP1PTV18YpSPIftn7Lc6Gm
	 mTWCnyTEXv6LHtvYNR0XCLJNyNn3cwccZTGEkJ0rkY5V8t/cCd+ACeoWxU2XifU/s0
	 d3eiQlvUjApi1Oz+HkIiEGH/F0GSbc3Cl3tX3ZYBzMKAnKqSOglZ1GNsMxkklKN51a
	 XRj6DxaWwNCVhGkW5qQxyfTOcrAPRvTa2z6FUR0sbB5d86btjeppobqjuKIwe6RavJ
	 o4EP0RVqi/l8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/7] x86/sev: Initialize RMPOPT configuration MSRs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <6a4d0ec9e037d91c0fdba9c525942ca288e1b1b2.1781419998.git.ashish.kalra@amd.com>
References: <6a4d0ec9e037d91c0fdba9c525942ca288e1b1b2.1781419998.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:14:21 +0000
Message-Id: <20260615201421.F25D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] MSR_AMD64_RMPOPT_BASE is not restored after suspend/resume, silent=
ly disabling the RMPOPT feature and leading to unhandled faults.
- [High] wrmsrq_on_cpu() silently swallows hardware faults, making WARN_ON_=
ONCE() checks ineffective and masking MSR setup failures.
--

commit 205a673f128c777438687610b84781bd7b8a3533
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Initialize RMPOPT configuration MSRs

The new RMPOPT instruction helps manage per-CPU RMP optimization
structures inside the CPU. Initialize the per-CPU RMPOPT table base to
the starting physical address to enable RMP optimization for up to 2 TB
of system RAM on all CPUs.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 8bcdce98f6dce..1b5c18408f0bf 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> @@ -555,6 +564,21 @@ int snp_prepare(void)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(snp_prepare, "ccp");
> =20
> +static void rmpopt_cleanup(void)
> +{
> +	int cpu;
> +
> +	cpus_read_lock();
> +
> +	for_each_cpu(cpu, &rmpopt_cpumask)
> +		WARN_ON_ONCE(wrmsrq_on_cpu(cpu, MSR_AMD64_RMPOPT_BASE, 0));

[Severity: High]
Does wrmsrq_on_cpu() return an error if the MSR write causes a hardware
fault?

Looking at wrmsrq_on_cpu(), it uses wrmsr() which relies on the exception
table handler to log the error and resume execution, and always returns 0
if the IPI succeeds.

If the MSR write causes a fault, it seems this WARN_ON_ONCE() won't trigger,
masking a potential disablement failure. Should wrmsrq_safe_on_cpu() be used
here instead?

> +
> +	cpus_read_unlock();
> +
> +	cpumask_clear(&rmpopt_cpumask);
> +	rmpopt_pa_start =3D 0;
> +}
> +

[ ... ]

> +void snp_setup_rmpopt(void)
> +{
> +	u64 rmpopt_base;
> +	int cpu;

[ ... ]

> +	/*
> +	 * Per-CPU RMPOPT tables support at most 2 TB of addressable memory
> +	 * for RMP optimizations. Initialize the per-CPU RMPOPT table base
> +	 * to the starting physical address to enable RMP optimizations for
> +	 * up to 2 TB of system RAM on all CPUs.
> +	 */
> +	for_each_cpu(cpu, &rmpopt_cpumask)
> +		WARN_ON_ONCE(wrmsrq_on_cpu(cpu, MSR_AMD64_RMPOPT_BASE, rmpopt_base));

[Severity: High]
If a system goes into a sleep state like suspend-to-RAM (S3), CPU MSRs are
typically reset.

Since this MSR is initialized here during boot, how is it restored when the
system wakes up?

Without a power management callback like syscore_ops resume hooks or CPU PM
notifiers, will the RMPOPT feature be silently disabled in hardware? While
a later patch disables CPU hotplug, S3 suspend via freeze_secondary_cpus()
explicitly bypasses the cpu_hotplug_disabled check, making this a reachable
path.

Also, similar to rmpopt_cleanup(), if this MSR setup silently fails because
wrmsrq_on_cpu() swallows hardware faults, could subsequent RMPOPT instructi=
ons
cause unhandled faults and lead to a kernel panic?

> +
> +	cpus_read_unlock();
> +}
> +EXPORT_SYMBOL_FOR_MODULES(snp_setup_rmpopt, "ccp");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781419998.gi=
t.ashish.kalra@amd.com?part=3D2
