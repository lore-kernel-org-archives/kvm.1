Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FEE414DFA
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788386276; cv=none; b=qQ5emvIjG6cFqv/OKYAZ4q8f+U3FDkaErHOJpg1eoQr8VXphTcOvkggDUWgcO/vAYA26WgDHsBIIKYPNoeFofF2UQFWmztGj6qv3g+TcMh7eogPA91mTyb02+PI5xKOzmtrZSB6D4j96PsWuYXLuEkuZG5UrXt77gg0g0sbOZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788386276; c=relaxed/simple;
	bh=/jfA32D3Gmd6nB8WjwU634ec6ikAGCBEXsbTWYbcCJo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zmmb8eU/rL6/a5jl2JVCDL4OVSuheXDTfuUtb5zNNkKoxpl1xf8FJ+CWGm2Pgivor/WEh3ZvdneWE6bD0YhTXHxzHAyI4uke8N6+XEBoDgO6YuVuJu6BNt/7jV9zldrc1nJXRg0yrqUjbdaND6EEPJ1gRGLIr+Yrxf1G95RwVnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUgarz/R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUgarz/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53081F000E9;
	Wed,  2 Sep 2026 21:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788386269;
	bh=6hutxXbttAPiqTJhuW3hdV6IRocxzdiwDGeqW5tuZdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IUgarz/RdxfG2duTxUtOKZVbCc8akdBKsjqfjcf4gegg7CLNy6lnKtlYwDSIRyL1Y
	 uLFBbxv0VmEcHpn7TfdrkjI0+1doV00NEi+Cl45N7fwd7HzOD4j/uLHcDPTWHISpGI
	 k4lslganIHNvetiAP/S8fR0EbeXFgZQZKeZMlVDUtnhVgD2eb/vbTfyWkynn3aslO9
	 ApygOfbYDHXsjhZisYabfZH1BtXDzmt1SoTWyWM3CMZp8wYm43YUsdc7x5Ag4uR3xT
	 8sSgjEZSUW4xfjQHyUUp8SZzhPbmcghfLf/EV4U3CsxaN01d9Kgz+L4a6hvt8JAv4b
	 2zS8XdNj13duw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 4/5] x86/sev: Add support to perform RMP
 optimizations asynchronously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <a31fc8c6d3f6c6bbe50dc4542c7091b0899d3e1b.1788296083.git.ashish.kalra@amd.com>
References: <cover.1788296083.git.ashish.kalra@amd.com>
 <a31fc8c6d3f6c6bbe50dc4542c7091b0899d3e1b.1788296083.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 21:57:48 +0000
Message-Id: <20260902215748.E53081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Declare %rax as clobbered or output in rmpopt() to prevent inf=
inite loops.
- [High] Schedule work in process context; executing on_each_cpu_mask trigg=
ers hard lockups.
- [High] Use ALIGN_DOWN for rmpopt_pa_end to prevent out-of-bounds RMP tabl=
e reads.
--

commit 0121e9d5bd127536db9548e1a9f202c9576ef5ff
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Add support to perform RMP optimizations asynchronously

This commit introduces support for asynchronous RMP checks on 1GB physical
memory regions to optimize performance on hardware supporting RMPOPT. A
dedicated workqueue triggers the optimization process during SNP
initialization and after legacy shutdowns.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 07f178eb76c7e..a4c0fe49b9ec7 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> @@ -595,6 +621,44 @@ static bool rmpopt_capable(void)
>  	       cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>  }
> =20
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
> +	asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfc"
> +		     :: "a" (pa_start), "c" (op)
> +		     : "memory", "cc");

[Severity: Critical]
Does this inline assembly need to declare %rax as an output or clobber?

Since the RMPOPT hardware instruction returns a status code in %rax, could
GCC assume %rax is unmodified because it is only provided as an input? If
rmpopt() is inlined, GCC might allocate %rax for the induction variable pa
in the calling loop. This would cause the loop step to compute incorrectly,
potentially resulting in an infinite loop during boot.

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
> +	 * RMPOPT caches the results of a RMP table scan in reserved processor
> +	 * memory, allowing future invocations to skip such costly operations.
> +	 */
> +	migrate_disable();
> +	rmpopt_scan_range(NULL);
> +	migrate_enable();
> +
> +	on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true=
);

[Severity: High]
Could executing on_each_cpu_mask() here with wait=3Dtrue trigger hard locku=
ps?

This call runs the rmpopt_scan_range() loop synchronously on all primary
threads in an IPI context with hardirqs disabled. Since the loop can
iterate up to 2048 times invoking the slow RMPOPT hardware instruction,
is it possible for remote CPUs with cold caches (like on multi-socket
systems) to stall for seconds inside the IPI handler and trigger an NMI
watchdog panic?

> +}

[ ... ]

> @@ -612,6 +704,23 @@ void snp_setup_rmpopt(void)
>  	 */
>  	for_each_cpu(cpu, cpu_primary_thread_mask)
>  		wrmsrq_on_cpu(cpu, MSR_AMD64_RMPOPT_BASE, rmpopt_base);
> +
> +	rmpopt_pa_end =3D ALIGN(PFN_PHYS(max_pfn), SZ_1G);

[Severity: High]
Should rmpopt_pa_end be calculated using ALIGN_DOWN() instead of ALIGN()?

If max_pfn is not 1GB aligned, aligning upwards creates a hardware scanning
range that extends into unbacked physical memory. When rmpopt_scan_range()
processes this final 1GB block, could the hardware instruction attempt to
read RMP entries beyond the allocated RMP table and cause a Machine Check
Exception or memory corruption?

> +
> +	/* Limit memory scanning to 2TB of RAM */
> +	if ((rmpopt_pa_end - rmpopt_pa_start) > SZ_2T) {
> +		pr_info("RMPOPT coverage limited to 2TB; memory above 0x%llx not optim=
ized\n",
> +			rmpopt_pa_start + SZ_2T);
> +		rmpopt_pa_end =3D rmpopt_pa_start + SZ_2T;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788296083.gi=
t.ashish.kalra@amd.com?part=3D4
