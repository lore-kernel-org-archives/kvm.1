Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CAA4C33C1
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589399; cv=none; b=VhVz9NAYZ0qWya4p9B49VTRnOWpYJeo/Ywa6dKpck217MJ/a3nwyuieaTF/q0nvVNiDvK2EOcR8hqDujliVUAengvdXX8hMXlJ94JBY9YtnE1V8upD2CqkfF+r3N+Hr40LN2RcYHaVw7iuoWp6430dbovi38X95Qztz0B6m7SPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589399; c=relaxed/simple;
	bh=hcertrfFhdMAk8CMuarhry1CtQd9puFVzVLwFrpHmnw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dt7U8bXrCh+v0+0DUgNeWJLhqoLpc65kWcXvgxPsIkhUXrIrd22pR0lh1Vt+ZJvWd69aWv7jHQxLZoULnbGKXjACqOI3WKo55M/nIBocqGoENPVAvN1Qg2fFrmvv0zNYm9nz2yrdQyQc2ADWwfdyWvA30aXQIbHx55qo5ucGXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffYf2JhP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffYf2JhP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEB71F00893;
	Wed, 16 Sep 2026 20:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789589384;
	bh=BQsC/vXHR7ACyIdKIGvgmPdYst6aLbKFeO2A46DQJcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ffYf2JhPrjax6UB8+TJ5GjzPDZu3+ejW6LlM57CkdsU6s8HQGK3xo6o2AlwP/N8Cg
	 gVjyMMNy9pb4Hs15NGzcCXDWb+SPsgGSiOcTkyg1KWZF9dTcW9sqITfcneXXhu+sfl
	 ll5uLq2zpK4oOMFrlPgW0rlMkAaf1h0I/Qk8l3EHWnAZ6lWm/oL21o1GlGF4O+rSsy
	 Bs/6xCe5QnAa0wx+3dL4AL/r/s+JsKMR/ITf5Ak5TekvzncLcsEnHHbL2Vu24imENR
	 1Dr3e9WblcmaqBFanaI+AadVPh+dP6Z8szUumO7NRhiGGZ5p+xQ+l8A+vrsuHPgI5w
	 Uz3uafsJ3VyJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 4/5] x86/sev: Perform RMP optimizations
 asynchronously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <4d6d44f7a6483670b3f7c7362b1ea528cfbf8144.1789586444.git.ashish.kalra@amd.com>
References: <cover.1789586444.git.ashish.kalra@amd.com>
 <4d6d44f7a6483670b3f7c7362b1ea528cfbf8144.1789586444.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 20:09:43 +0000
Message-Id: <20260916200944.7AEB71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] x86/sev: missing output constraint in RMPOPT asm causes infini=
te loop
- [High] ccp: race condition in SEV-SNP shutdown causes RMPOPT #UD panic
- [High] x86/sev: per-CPU RMPOPT cache warmup logic causes massive NMI lock=
ups
--

commit c0d06ab160baf82951effc37ee61ce7592ca6b50
Author: Ashish Kalra <ashish.kalra@amd.com>

    x86/sev: Perform RMP optimizations asynchronously
   =20
    Add support for performing RMP optimizations asynchronously using a
    dedicated per-CPU workqueue. The workqueue is allocated from an initcal=
l,
    and snp_enable_rmpopt() queues the optimization pass.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index f458128b9864f..54520d4cf2803 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> @@ -565,6 +590,8 @@ void snp_shutdown(void)
>  	if (syscfg & MSR_AMD64_SYSCFG_SNP_EN)
>  		return;
> =20
> +	rmpopt_disable();

[Severity: High]
Does canceling the delayed work here leave a race window that could cause an
invalid opcode panic?

The SEV-SNP shutdown sequence sends the SEV_CMD_SNP_SHUTDOWN_EX command to =
the
firmware (e.g. from __sev_snp_shutdown_locked() in
drivers/crypto/ccp/sev-dev.c), which clears the SYSCFG.SNPEn MSR and disabl=
es
SNP enforcement in hardware.

By the time snp_shutdown() is called here and confirms the MSR is cleared, =
the
hardware feature is already disabled. If the delayed workqueue is executing
concurrently on another CPU during this window, could it attempt to execute=
 the
RMPOPT instruction while SNP is disabled, triggering an Invalid Opcode (#UD=
)?

[ ... ]

> @@ -580,8 +607,69 @@ EXPORT_SYMBOL_FOR_MODULES(snp_shutdown, "ccp");
>  static bool rmpopt_capable(void)
>  {
>  	return cpu_feature_enabled(X86_FEATURE_RMPOPT) &&
> -	       cc_platform_has(CC_ATTR_HOST_SEV_SNP);
> +	       cc_platform_has(CC_ATTR_HOST_SEV_SNP) && rmpopt_enabled;
>  }

[Severity: High]
Does checking static boot attributes rather than dynamic state here allow
subsequent caller sequences to bypass the capability check after a shutdown?

Because cc_platform_has(CC_ATTR_HOST_SEV_SNP) reflects boot state, if SNP is
dynamically disabled during a shutdown or kexec, rmpopt_capable() could sti=
ll
return true, allowing the workqueue to be improperly re-armed or the
MSR_AMD64_RMPOPT_BASE to be rewritten after a shutdown.

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

[Severity: Critical]
Is an output constraint missing for %rax here?

The RMPOPT instruction evaluates a physical memory region and returns a sta=
tus
code in %rax. The inline assembly passes pa_start via the "a" constraint
(placing it in %rax) but doesn't declare %rax as an output or clobber.

When rmpopt() is inlined into rmpopt_scan_range(), the compiler might place=
 the
loop variable pa in %rax, assuming it is preserved. After the assembly exec=
utes,
the hardware overwrites %rax with the status code (e.g., 0 for success).

Could this cause the loop to increment the status code by SZ_1G instead of =
the
original physical address, resulting in an infinite loop?

> +}
> +
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
> +	 * enabled, so the IRQ-disabled fan-out below only issues cache-hit RMP=
OPTs.
> +	 */
> +	rmpopt_scan_range(NULL);
> +
> +	on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true=
);

[Severity: High]
Is this per-CPU warmup logic sufficient to prevent cache-miss latencies on =
all
other CPUs?

Because RMPOPT tables and their caches are strictly per-CPU (as configured =
via
MSR_AMD64_RMPOPT_BASE), warming up the cache on a single worker CPU does not
populate the caches on the other CPUs.

When on_each_cpu_mask() broadcasts the scan with interrupts disabled (true),
won't every other primary thread execute up to 2048 cold-cache RMPOPT
instructions in hardirq context, potentially triggering NMI watchdog lockup=
s?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789586444.gi=
t.ashish.kalra@amd.com?part=3D4
