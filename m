Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359F93845A7
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433221; cv=none; b=rjYekY3m95HXXOP4hln0S3LZWfMXLiE1XE5nz2IH3n/Obh0ntT+YJQZXYGAGSZe5hFrEQywxmMrLS7nJSONZiQQc/CB7iW9KHCLY8AZaHkbZ+PqQW0NOlvOVTGg+ryQhmqTvoW/Z30VMPnj6SJEuCIvYjwA8UWW4QtY1XlfRsGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433221; c=relaxed/simple;
	bh=lb2XIbZlTjNGkUPWPpWm95ReJ5WNTIwuCYxz3VxOe7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dUvZDU+DJ6IIIEfvVwyl7BYujFasm6MTPqwHsZaqIDR5fwKZ1bkTxVp6f423IxedS3JIPubbNAFxjZg6VOsIV/ldlqWCUZ1oI87LduY7mOMR+mm7zH/wk730aRZG5XpFVFCqrdn/JZSMV2Q8TdeXWqhfnPQTu6yyVXAxwZrC+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QURh7Tw2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QURh7Tw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582D41F00893;
	Tue,  2 Jun 2026 20:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780433219;
	bh=MNdrsdm4Xhuoe6Hxf4H2i4bTonAA9JUAmIy3e+Mf3jI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QURh7Tw2Mnk4jFYxo56kblxp1j2e6SS+WFDHXRwMaLz3lgl2wDvibUOkc+8p6jXZ7
	 UFexkkdDcP4RwwoPCPoKoZ/Y6dIag6QvXxGeS/Sh6PvBp5YjSlzrDqfN4KDXfhLa9Z
	 7Nf/mwEa+BprrW1zk4Qjil7H9YxisKWlW1YqGT8O7fxIHZklbO0saXc3OxfGJAT6iL
	 j5qI0FOpCh7ZTF+1OCI3l7peoCvDrgpYFvQshwXz0SX70TSOYCikz6x8AKsS4d+4Vj
	 RR+wa9ajhdeyvFz6JyMT9an/X6IY8OuOEvke1ddrNJx9NqVXafQc8oEhOIGJZabbKW
	 iAAZXiVdVNY9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] x86/sev: Add support to perform RMP
 optimizations asynchronously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <29adedba9e093ec0c9aaafa006f4e822ac872d8a.1780427587.git.ashish.kalra@amd.com>
References: <29adedba9e093ec0c9aaafa006f4e822ac872d8a.1780427587.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 20:46:58 +0000
Message-Id: <20260602204659.582D41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing `cond_resched()` in the leader RMPOPT loops inside `rmpopt=
_work_handler` can trigger soft lockups.
- [High] The inline assembly for `__rmpopt()` fails to mark the RAX registe=
r as clobbered or output, which can corrupt the caller's loop variable.
--

commit dea16dc76b50a8acabc16915c0d451449f0d1849
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Add support to perform RMP optimizations asynchronously

This patch introduces support for the RMPOPT instruction to minimize RMP ch=
eck
overhead by skipping 1GB regions not containing SEV-SNP guest memory. It ad=
ds
a dedicated workqueue to process up to 2TB of RAM asynchronously.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 089c9a14edc74..d7e40a5fe5ca6 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> +static inline bool __rmpopt(u64 pa_start, u64 op_type)
> +{
> +	bool optimized;
> +
> +	asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfc"
> +		     : "=3D@ccc" (optimized)
> +		     : "a" (pa_start), "c" (op_type)
> +		     : "memory", "cc");

[Severity: High]
Does this inline assembly need to mark the RAX register as an output
or clobber?

Like other SEV-SNP instructions like PVALIDATE or RMPUPDATE, RMPOPT
returns a status code in RAX. Since the inline assembly block does not
mark RAX as modified by using "+a" (pa_start), the compiler is unaware
that the register's value has changed.

When rmpopt is inlined into the scanning loop, the compiler might
map the loop variable pa to RAX. If the hardware overwrites RAX with
a status code, could this corrupt the memory scan logic by resetting
the physical address being scanned?

> +
> +	return optimized;
> +}

[ ... ]

> +	if (cpumask_test_cpu(this_cpu, follower_mask)) {
> +		/*
> +		 * Current CPU is a primary thread in rmpopt_cpumask.
> +		 * Run leader locally and remove from follower mask.
> +		 */
> +		cpumask_clear_cpu(this_cpu, follower_mask);
> +
> +		for (pa =3D rmpopt_pa_start; pa < rmpopt_pa_end; pa +=3D SZ_1G)
> +			rmpopt(pa);

[Severity: High]
Could this loop run for a long time without yielding and trigger soft locku=
ps?

Since rmpopt_pa_end can be up to 2TB, this loop might execute up to 2048
times. The follower loop further down includes a cond_resched(), but this
leader loop and the sibling thread leader loop below omit it entirely.

> +	} else if (cpumask_intersects(topology_sibling_cpumask(this_cpu),
> +				      follower_mask)) {
> +		/*
> +		 * Current CPU is a sibling thread whose primary is in
> +		 * rmpopt_cpumask.  RMPOPT_BASE MSR is per-core, so it
> +		 * is safe to run the leader locally.  Remove the sibling's
> +		 * primary from the follower mask as this core is already
> +		 * covered by the leader.
> +		 */
> +		cpumask_andnot(follower_mask, follower_mask,
> +			       topology_sibling_cpumask(this_cpu));
> +
> +		for (pa =3D rmpopt_pa_start; pa < rmpopt_pa_end; pa +=3D SZ_1G)
> +			rmpopt(pa);
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
> +		for (pa =3D rmpopt_pa_start; pa < rmpopt_pa_end; pa +=3D SZ_1G)
> +			smp_call_function_single(leader_cpu, rmpopt_smp,
> +						 (void *)pa, true);

[Severity: High]
Does this loop also need to yield?

It sends an IPI and busy-waits with wait=3Dtrue for the expensive scan up to
2048 times without yielding.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780427587.gi=
t.ashish.kalra@amd.com?part=3D3
