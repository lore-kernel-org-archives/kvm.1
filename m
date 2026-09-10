Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35533C4B79
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078280; cv=none; b=AJpujNe/yrLrkucu2R58Za4HCb0wvG1c6ZJee4SN5JS/aQ4zVyizo0C9Hh8yCm6ZolR4es8S2Kev1ZRFSDysPF63kl/8VFdOJUtLeQ36u8mZssObpt9Fp8jRdxonT7LtJDDCni6Z/TJPIGQ0Zcy6AXc8Qu9z5lfCbsDmtuFVp2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078280; c=relaxed/simple;
	bh=jFGE5XZjV3Jan3eBYGs7RuNuMDzOHAM2Uk1M4LMlHHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NpNMFgbFvmX/OiE/ieUSoR/gAKXT7u4jizNO3a8yhA0HAzVOwB4p/t+0fl1JQNb3MG7k1dlNlKfVyucDI1zXcYMsoQSi0pqsPpbvDngch17fweDcm2AIkFWPECrFZpvyMfXa290TUhv/2Da0omUvnIzaXxb30O870j2/Z7wXQP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re14tB/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re14tB/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCF01F000FF;
	Thu, 10 Sep 2026 22:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789078278;
	bh=cE3ybpA6hcQKiin35A7Kbr2LxB74mP5sudOt6oqPDeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Re14tB/AvURU+3BWyh/q2EN/uJgp7G5XQgyYFjx0zO0S7o51rLUza9G+Pwj3d2bd9
	 1AxDh6RuBFsN5b/MWTcfG48H1X1+G3etw/kQreBQjF6zcfcRxTd1x8mGhRo6DNbP+C
	 bOJyimQtOObcGhG10CgKEJePxx79k3Kd+ZLq7+tDlAF9u/HljR8FCEvrgmakHMhTw2
	 bMHgsWaySr0T5l5x75EyTDV6n4Kv2uswZ079nO9327/2yODG0ZpD/N/eBBpkYL5jwg
	 xztKfG2PPLHyxL7ATtTfzYYkWePc2f0QNRbyaNiHxQCumpx4xnKs04NlHw2HlchyZr
	 NpSp1pSuOk2EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 4/5] x86/sev: Perform RMP optimizations
 asynchronously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <1e3d0edb6b275e33fa6f76b0c31db9e999d9a270.1788984053.git.ashish.kalra@amd.com>
References: <cover.1788984053.git.ashish.kalra@amd.com>
 <1e3d0edb6b275e33fa6f76b0c31db9e999d9a270.1788984053.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 22:11:17 +0000
Message-Id: <20260910221118.4FCF01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Re-initializing SNP after a CPU hotplug cycle skips programming th=
e RMPOPT_BASE MSR on the newly onlined CPU, leading to an Invalid Opcode (#=
UD) exception when executing RMPOPT.
- [High] The inline assembly for the RMPOPT instruction fails to declare `%=
rax` as an output constraint or clobber, leading to silent register corrupt=
ion and unpredictable loop behavior.
- [High] The RMPOPT 'warm-up' executes on a single CPU, causing the subsequ=
ent cross-CPU IPI to execute millions of slow RMPOPT instructions with IRQs=
 disabled on all other CPUs with cold caches, triggering hard lockups.
--

commit e2c3ac4ab3639e4c47a6c85a3acca0d88b6fb5a3
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Perform RMP optimizations asynchronously

This patch introduces asynchronous RMP optimizations by scanning and
optimizing up to 2TB of system memory at 1GB boundaries using a per-CPU
workqueue. When SNP guests are launched and regions are allocated, hardware
clears the optimizations, so the workqueue asynchronously reapplies them.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index a059327dc1071..35678b1f535d4 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
[ ... ]
> +static void rmpopt(u64 pa)
> +{
> +	enum rmpopt_op_type op =3D RMPOPT_OP_VERIFY_AND_REPORT_STATUS;
> +	u64 pa_start =3D ALIGN_DOWN(pa, SZ_1G);
> +
> +	/* Supported by binutils 2.48+ */
> +	asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfc"
> +		     :: "a" (pa_start), "c" (op)
> +		     : "memory", "cc");

[Severity: High]
Does this inline assembly need to declare %rax as an output or clobbered
register?

Since RMPOPT_OP_VERIFY_AND_REPORT_STATUS instructs the hardware to return a
status code in %rax, the compiler might allocate the loop counter pa to %rax
in rmpopt_scan_range(). If hardware overwrites %rax, the loop counter would
be reset, potentially causing an infinite loop.

> +}
> +
> +/* on_each_cpu() callback: optimize the whole RMPOPT range on this CPU. =
*/
> +static void rmpopt_scan_range(void *arg)
> +{
> +	u64 pa;
> +
> +	for (pa =3D rmpopt_pa_start; pa < rmpopt_pa_end; pa +=3D SZ_1G)
> +		rmpopt(pa);
> +}
> +
> +static void do_rmpopt_work(struct work_struct *work)
> +{
> +	/*
> +	 * Warm up the RMPOPT cache on this pinned per-CPU worker with interrup=
ts
> +	 * on, so the IRQ-disabled fan-out below only issues cache-hit RMPOPTs.
> +	 */
> +	rmpopt_scan_range(NULL);
> +
> +	on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true=
);

[Severity: High]
Could this fan-out cause significant stalls on other CPUs?

The RMPOPT cache is warmed up locally on the current CPU, but because the
caches are strictly per-CPU, all other CPUs will still have a cold cache.
When they receive the IPI, they will perform the full up to 2TB scan in
hardirq context with a cold cache, which seems likely to trigger NMI
watchdog timeouts across the system.

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
> +	guard(mutex)(&rmpopt_wq_mutex);
> +
> +	/*
> +	 * Set up once: the workqueue and RMPOPT_BASE MSRs are left in place on
> +	 * shutdown, so a later re-initialization just re-queues the optimizati=
on
> +	 * pass rather than redoing the setup.
> +	 */
> +	if (rmpopt_wq) {
> +		queue_delayed_work(rmpopt_wq, &rmpopt_delayed_work, 0);
> +		return;

[Severity: High]
Is it safe to skip programming MSR_AMD64_RMPOPT_BASE on newly onlined CPUs?

If a CPU is hot-unplugged and hot-plugged back, its MSRs are reset to their
defaults. If SNP is disabled and re-enabled during this cycle,
snp_setup_rmpopt() will see that rmpopt_wq is already allocated and return
early. This skips the MSR programming loop for the hotplugged CPU, which
would lead to an Invalid Opcode (#UD) exception when executing RMPOPT on it.

> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788984053.gi=
t.ashish.kalra@amd.com?part=3D4
