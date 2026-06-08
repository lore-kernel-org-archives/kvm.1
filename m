Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09882F1FC9
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945973; cv=none; b=Te2LUlcfcDZ1pezLAcPUUr47E13BxDIvjkIhsbgss2fOPrz1xUk6Z4GGzIwk9QPmW4NZmZ+ZtkpBdECKvC8dd+48YNJD5UU3qp8K8OpaRlP+ceOb3DE0SGP3t+M1e2sCww6RaNd65e3MbRpKcul6RJxMJji+Vrzg5YY+rk5BftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945973; c=relaxed/simple;
	bh=+YDZrF6LHrXKpi2NZJBDcEWMJRdD0TmfEkIgb5k537E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hQb4hlgbabpNs8IhYH7MScaeVZtkyvwe2UvyDxtnBjf1RPnRAgfloGix3p/3OZXgHkLG9Y9ayMS4craZoGNiPMgb2yvP9LXNQ+1xD1Ycma8i/qeMVPFCk3GH7o/PKvQpEarYPO5g7kImckZfV4KspIjpFoQbW3lggHpzV382Jtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+OgeQ4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+OgeQ4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E181F00893;
	Mon,  8 Jun 2026 19:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780945971;
	bh=CFr/CA70Kf7Y5fELMTaarhByBdTk6nUWaprESOrruPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+OgeQ4iO2VWFKzsWOSFOQaDdoW57bH6a/w14smmjbfGY2iRI8CA6t9CWggE7zsnT
	 YX8JLTcCd5b/7NRSQlizKOraJOm7Bh8LzH2KOVeESTZw3hTckNIbDSQvN6rq+I+6eJ
	 67tBC5a+KFJP1SvJAGGC4wi+GtK154u4g5TGtPscsMpeynoj80XorNynpDFJg1ebEt
	 lTXei+IjztHqzkg0x2CuKpn6c4EZ5ILx9sC6zmgF9DV9Hoy6pO/S5jMH5lzhLqDz7o
	 BBbwCRMcIhZulRxAVdDXMF4EIjAbY10L3OGjWeiXvNEwteBavYBMiwUAk0xLuDHA+W
	 mwUJc0CYbfaig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/6] x86/sev: Add support to perform RMP
 optimizations asynchronously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <fc14f6cb80c37d08d308460d2f13279bf3a32ccb.1780903370.git.ashish.kalra@amd.com>
References: <fc14f6cb80c37d08d308460d2f13279bf3a32ccb.1780903370.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 19:12:51 +0000
Message-Id: <20260608191251.80E181F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Acquiring cpus_read_lock() while migrate_disable() is active creat=
es an AB-BA deadlock with CPU hotplug.
- [High] Executing the expensive RMP hardware scan via synchronous IPI risk=
s extreme IRQ latency and hard lockups.
- [High] Ignoring the IPI return value allows the fallback leader scan to s=
ilently fail, forcing all follower CPUs to execute the slow path simultaneo=
usly.
- [High] Holding `cpus_read_lock()` continuously across the entire multi-gi=
gabyte memory scan loop causes severe system-wide stalls.
- [Medium] Repeatedly calling `INIT_DELAYED_WORK()` on the statically alloc=
ated `rmpopt_delayed_work` triggers debugobjects warnings.
--

commit e93db67a4733d3052f6ffa4972745fd9c571f883
Author: Ashish Kalra <ashish.kalra@amd.com>
Subject: x86/sev: Add support to perform RMP optimizations asynchronously

When SEV-SNP is enabled, all writes to memory are checked to ensure
integrity of SNP guest memory. This imposes performance overhead on the
whole system.

[ ... ]

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 482008bb07e48..b42788a66d400 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> @@ -599,6 +620,146 @@ void snp_clear_rmpopt_configured(void)
>  	rmpopt_configured =3D false;
>  }
> =20
> +/*
> + * RMPOPT: F2 0F 01 FC
> + *   Input:  RAX =3D system physical address (1GB aligned)
> + *           RCX =3D operation type
> + *   Output: CF set if the range was optimized
> + */

[ ... ]

> +static void rmpopt_work_handler(struct work_struct *work)
> +{
> +	cpumask_var_t follower_mask;
> +	phys_addr_t pa;
> +	int this_cpu;

[ ... ]

> +	/*
> +	 * Pin the worker to the current CPU for the leader loop so that
> +	 * this_cpu remains valid and the RMPOPT instruction executes on
> +	 * the correct CPU.
> +	 *
> +	 * Use migrate_disable() rather than get_cpu() to prevent
> +	 * migration while still allowing preemption.
> +	 */
> +	migrate_disable();
> +	this_cpu =3D smp_processor_id();
> +
> +	if (cpumask_test_cpu(this_cpu, follower_mask)) {

[ ... ]

> +	} else {
> +		/*
> +		 * Current CPU does not have RMPOPT_BASE MSR programmed.
> +		 * Pick an explicit leader from the cpumask to avoid #UD.
> +		 */
> +		int leader_cpu =3D cpumask_first(follower_mask);
> +
> +		if (WARN_ON_ONCE(leader_cpu >=3D nr_cpu_ids)) {
> +			migrate_enable();
> +			goto out;
> +		}
> +
> +		cpumask_clear_cpu(leader_cpu, follower_mask);
> +
> +		cpus_read_lock();

[Severity: High]
Does acquiring cpus_read_lock() while migrate_disable() is active create an
AB-BA deadlock with CPU hotplug?

The worker thread calls migrate_disable(), then attempts to acquire
cpus_read_lock() in the fallback leader path. A CPU hotplug thread acquires
the hotplug write lock and then waits for migration-disabled tasks to leave
the CPU, while the worker thread blocks on the hotplug lock waiting for the
write lock to be released.

> +		for (pa =3D rmpopt_pa_start; pa < rmpopt_pa_end; pa +=3D SZ_1G) {
> +			smp_call_function_single(leader_cpu, rmpopt_smp,
> +						 (void *)pa, true);

[Severity: High]
Will executing the expensive RMP hardware scan via synchronous IPI risk
extreme IRQ latency and hard lockups?

Both here and in the followers path, smp_call_function_single() and
on_each_cpu_mask() execute the rmpopt_smp callback in hardirq (IPI) context.
The commit message states the leader's scan is the most expensive part.
Executing a long-running hardware memory scan in hardirq context blocks all
interrupts on the target CPU for the duration of the scan, violating kernel
context rules.

[Severity: High]
Can ignoring the IPI return value allow the fallback leader scan to silently
fail?

If the leader CPU goes offline prior to the dispatch,
smp_call_function_single() returns an error (like -ENXIO) and rmpopt_smp is
never executed. Because this error is ignored, the required cached result
isn't generated. When the followers execute on_each_cpu_mask(), all primary
threads might simultaneously fall back to the slow, expensive scan path in
hardirq context, causing system-wide lockups.

> +			cond_resched();
> +		}
> +		cpus_read_unlock();
> +	}
> +
> +	migrate_enable();
> +
> +	/* Followers: run RMPOPT on remaining cores */
> +	cpus_read_lock();
> +	for (pa =3D rmpopt_pa_start; pa < rmpopt_pa_end; pa +=3D SZ_1G) {

[Severity: High]
Does holding cpus_read_lock() continuously across the entire multi-gigabyte
memory scan loop cause severe system-wide stalls?

The loop processing up to 2TB of physical memory in 1GB chunks holds
cpus_read_lock(). While the loop calls cond_resched(), this only yields the
CPU and does not release the cpus_read_lock() rwsem. Since the operation
involves thousands of synchronous IPIs and can take multiple seconds, any
attempt by a writer (such as CPU hotplug) to acquire the lock will block,
subsequently blocking all other readers system-wide.

> +		on_each_cpu_mask(follower_mask, rmpopt_smp,
> +				 (void *)pa, true);
> +
> +		 /* Give a chance for other threads to run */
> +		cond_resched();
> +	}
> +	cpus_read_unlock();
> +
> +out:
> +	free_cpumask_var(follower_mask);
> +}
> +
>  void snp_setup_rmpopt(void)
>  {

[ ... ]

> @@ -607,11 +768,35 @@ void snp_setup_rmpopt(void)
>  		return;
> =20
> +	guard(mutex)(&rmpopt_wq_mutex);

[ ... ]

>  	cpus_read_lock();
> =20
>  	/*
>  	 * The RMPOPT_BASE MSR is per-core, so only one thread per core needs
> -	 * to set up the RMPOPT_BASE MSR.
> +	 * to set up the RMPOPT_BASE MSR. Likewise, only one thread per core
> +	 * needs to issue the RMPOPT instruction.

[ ... ]

>  	cpus_read_unlock();
> +
> +	INIT_DELAYED_WORK(&rmpopt_delayed_work, rmpopt_work_handler);

[Severity: Medium]
Could repeatedly calling INIT_DELAYED_WORK() on the statically allocated
rmpopt_delayed_work trigger debugobjects warnings?

The INIT_DELAYED_WORK() macro unconditionally initializes the work structure
and its underlying timer. Because rmpopt_delayed_work is statically
allocated and not dynamically freed, calling it multiple times (which occurs
if SEV-SNP is disabled and re-enabled) re-initializes an already tracked
debug object, triggering an 'ODEBUG: init active' warning.

> +
> +	rmpopt_pa_end =3D ALIGN(PFN_PHYS(max_pfn), SZ_1G);
> +
> +	/* Limit memory scanning to 2TB of RAM */
> +	if ((rmpopt_pa_end - rmpopt_pa_start) > SZ_2T) {
> +		pr_info("RMPOPT coverage limited to 2TB; memory above 0x%llx not optim=
ized\n",
> +			rmpopt_pa_start + SZ_2T);
> +		rmpopt_pa_end =3D rmpopt_pa_start + SZ_2T;
> +	}
> +
> +	/*
> +	 * Once all per-CPU RMPOPT tables have been configured, enable RMPOPT
> +	 * optimizations on all physical memory.
> +	 */
> +	queue_delayed_work(rmpopt_wq, &rmpopt_delayed_work, 0);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(snp_setup_rmpopt, "ccp");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780903370.gi=
t.ashish.kalra@amd.com?part=3D3
