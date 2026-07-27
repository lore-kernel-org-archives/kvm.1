Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E243D301D
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180178; cv=none; b=i/RQjKKPs+LlGpCb3AfAoLfmV1LF3SLI5oTjcl1nKrYaXi4jHtN6XdzpyIRUM9jeIrJMB4eBjSe1wSfKzTd3svmLKCV9I3tzSzjCOTLT3sTRL7UrR7z6qxMKf9WTv+agxPiYQSBm3PMSXL953CdCNIrixyhDVvnv9GVlaq+onvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180178; c=relaxed/simple;
	bh=5okXD85Z8yuev6lF4N6NfqRh8D9MupHzleqyFohf7tU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o9RXJ1t8VNhnNEAb4QQ0J/OV4ccXE4ZMOj8UXxkyZSu4YmdSeMzm2WfZJNWav3JO1GvevhRu1E20zAMVFFu904m9/4SqCqykqXDyTGssGURtmwUukd3l5q8diTJ4HaCUvLDijPmAYqCeOPNiH+YFX7onGjSgtZn+mkQjSuKEm0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8rA5r2g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8rA5r2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAD31F000E9;
	Mon, 27 Jul 2026 19:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785180176;
	bh=m+PCsXrBJRJwqTkxV5cO5oK00rLTlqqZvBbTWulh9jE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q8rA5r2gzu+xuKyc8YtWbSp1prgy116Zu88s/FyHcRxg7MHTZtO7YiYrlj44Wg8lf
	 6v19Mv2bjl0t6dzq98/SePmx/l+HapvH6v0+5Pf0Z1i4Fn8gmyxMYcVNjI5wTBBSA+
	 Tff1BRzuwfKhPwRUemDXZWYSP2fO37PPKRd/3RidOsVAa+4FpGklKblSRSyRbdqMbS
	 9gE77rNP3oFrZQKDNq8Um2d5873t7mFH8qqFtGBMX80w4lYuWecpmOUm9TjG6w/hM+
	 7KP6+m9T9pok5rJF/N1nZMontWn7KX+5E81AmrJrMntZYHEEwZbmZ3GXqlGq7YFOl5
	 EYTpdNlk2mH8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/6] x86/sev: Add support to perform RMP
 optimizations asynchronously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <7f582569acea933c3045be604a81975e29b5ee2b.1784844080.git.ashish.kalra@amd.com>
References: <cover.1784844080.git.ashish.kalra@amd.com>
 <7f582569acea933c3045be604a81975e29b5ee2b.1784844080.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:22:56 +0000
Message-Id: <20260727192256.7EAD31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Inline assembly for __rmpopt fails to specify EAX/RAX as a clobber=
ed or output register, risking an infinite loop.
- [High] Missing CPU yield in long-running RMP optimization loops leads to =
soft lockups on non-preemptible kernels.
--

--- Patch [4]: [PATCH v11 4/6] x86/sev: Add support to perform RMP optimiza=
tions asynchronously ---
commit 9b1e0ac7d870b3ba02472132010185afc997e02d
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Add support to perform RMP optimizations asynchronously

This commit adds support for performing RMP optimizations asynchronously us=
ing
a dedicated workqueue. It introduces a new RMPOPT instruction to skip RMP c=
hecks
for 1GB regions not containing SEV-SNP guest memory. Optimizations are enab=
led
for up to 2TB of system RAM starting at RMP initialization time.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 8bfd802848361..04b19e64f8329 100644
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
Does this inline assembly need to specify EAX/RAX as a clobbered or output
register?

If the RMPOPT instruction modifies RAX (as AMD SEV-SNP instructions like
RMPUPDATE typically return an execution status code in EAX/RAX), the current
specification of RAX as input-only ("a" (pa_start)) could allow the compiler
to optimize the loop counter into RAX and silently overwrite it.

This could lead to an infinite loop during rmpopt_work_handler() execution.

> +
> +	return optimized;
> +}

[ ... ]

> +static void rmpopt_work_handler(struct work_struct *work)
> +{

[ ... ]

> +	migrate_disable();
> +	this_cpu =3D smp_processor_id();
> +
> +	cpumask_andnot(follower_mask, rmpopt_cpumask,
> +		       topology_sibling_cpumask(this_cpu));
> +
> +	for (pa =3D rmpopt_pa_start; pa < rmpopt_pa_end; pa +=3D SZ_1G)
> +		rmpopt(pa);

[Severity: High]
Does this loop need a cond_resched() to yield the CPU?

This loops up to 2048 times doing an expensive hardware scan inside a
migrate_disable() block. On kernels with CONFIG_PREEMPT_NONE or
PREEMPT_VOLUNTARY, preemption is not implicit.

Without explicitly yielding the CPU, this could cause severe scheduling lat=
ency
spikes or trigger a soft lockup watchdog panic.

> +
> +	migrate_enable();
> +
> +	/*
> +	 * Followers: run RMPOPT on the remaining cores.  cpus_read_lock() is
> +	 * intentionally not held here: CPU hotplug is disabled for the entire
> +	 * time SNP is active (see snp_prepare()), and this work only runs while
> +	 * SNP is active, so the follower set stays valid across the whole scan.
> +	 */
> +	for (pa =3D rmpopt_pa_start; pa < rmpopt_pa_end; pa +=3D SZ_1G)
> +		on_each_cpu_mask(follower_mask, rmpopt_smp, (void *)pa, true);

[Severity: High]
Could this secondary follower loop also need a cond_resched() to prevent
CPU monopolization?

This loop iterates up to 2048 times broadcasting IPIs via on_each_cpu_mask(=
).
Similar to the first loop, without a yield, this could lead to soft lockups=
 on
non-preemptible kernels.

> +
> +	free_cpumask_var(follower_mask);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784844080.gi=
t.ashish.kalra@amd.com?part=3D4
