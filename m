Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5834DB56
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554042; cv=none; b=surBZNLv5ACe4x6tTYCVJ9gzVZdVo9bn+rmf1BR+OzJoEmRCauEAkkf66M1BY0tIXWL1qmCdsVAeE7AYNY2hQuK0jqWjb31qKGd1uFRxuz3iSN+N4ubXii5MnX/Zvp9cXzQ5L1p5CKSLCCei+Imw90RiwbmkAzNmpQsYu1EcCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554042; c=relaxed/simple;
	bh=6sv3zANJ6Je86vns5ic/lE3db+BXqU6Kr0hlU6DnTs0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OV7dAUsx9BDlbltyJWfn887Y4Jah2FCbRXmtboCkR7Ri+SG1vEycTOYoozSZdNFNdreZklt9Yk8l3siUK9JraMmjM41UXEPZPIHHCdYm8A7NyXGuHsSCTiYXaE8tSKR2v+FR1y3sACJLjBZSqa57ql7MyyD9dowX1jUk2vyXh8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Utn9VKvo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Utn9VKvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4600C1F000E9;
	Mon, 15 Jun 2026 20:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781554041;
	bh=3ng8G6FISpiSURIRUETqDHMqXI7Phn9uvNmF2fauJDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Utn9VKvoRbirCv5A6o5/vZ02lnRdtTFh/dHb/sb05+t4COldiWiUCtmZIxU5Oie6m
	 sMTgk8Bj8vxBlW2HceKct9NwdkPkTgjsQGgxoCc3v17IbkV+tL+OMCFNOfgffT7TX9
	 bGxPEradAg1gRyd3c3dARlz2XjzQK2sKYkNe3z9aIuBtWFCUCgzJKBh8ClzTPKNdk1
	 p1YTqMs8JSnNjcU6fsa+5B6HMwHLCGPTOh51uZJ5D7JOuQ+UwigkLoIzMIuN9LGDHy
	 5tjrpmI4zCKORiv4e25pGvG+R5lj4nAbTvioDuXR9mawaCLv6aPfRTPRMGX8g9cVLU
	 /weqpWaZpVRHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/7] x86/sev: Add debugfs support for RMPOPT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <cc9aa9b6cfa2ce826f2ad53f8a13d3b7bf0790b6.1781419998.git.ashish.kalra@amd.com>
References: <cc9aa9b6cfa2ce826f2ad53f8a13d3b7bf0790b6.1781419998.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:07:20 +0000
Message-Id: <20260615200721.4600C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Broadcasting the RMPOPT instruction to cpu_online_mask in debugfs =
can trigger a kernel panic (#UD/#GP) if a core's primary thread is offline.
--

commit bd48c96c2b885c0673d20119de172ea1dd26cdf2
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Add debugfs support for RMPOPT

This commit adds a debugfs interface to report per-CPU RMPOPT status across
all system RAM.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> @@ -669,6 +686,115 @@ static long rmpopt_leader_fn(void *arg)

[ ... ]

> +static int rmpopt_table_seq_show(struct seq_file *seq, void *v)
> +{
> +	phys_addr_t *curr_paddr =3D v;
> +
> +	guard(mutex)(&rmpopt_show_mutex);
> +
> +	seq_printf(seq, "Memory @%3lluGB: ",
> +		   *curr_paddr >> (get_order(SZ_1G) + PAGE_SHIFT));
> +
> +	/*
> +	 * Query all online CPUs rather than just rmpopt_cpumask (primary
> +	 * threads only). The RMPOPT instruction only needs to run on one
> +	 * thread per core for the optimization to take effect, but debugfs
> +	 * reporting requires the RMPOPT status across all CPUs.
> +	 * Performance is not a concern for this diagnostic interface.
> +	 *
> +	 * This is safe because RMPOPT_BASE MSR is per-core and
> +	 * snp_prepare() ensures all CPUs are online when the MSR is
> +	 * programmed during snp_setup_rmpopt().
> +	 */
> +	cpumask_clear(&rmpopt_report_cpumask);
> +	on_each_cpu_mask(cpu_online_mask, rmpopt_report_status,
> +			 (void *)*curr_paddr, true);

[Severity: High]
Could broadcasting to cpu_online_mask here trigger a kernel panic
if a core's primary thread is offline?

In snp_setup_rmpopt(), the base msr is only programmed on cpus in
rmpopt_cpumask, which is strictly limited to online primary threads:

if (topology_is_primary_thread(cpu))
        cpumask_set_cpu(cpu, &rmpopt_cpumask);

If a core's primary thread is offline but its secondary thread is online,
the secondary thread will be included in cpu_online_mask, but the msr for
its core will remain unprogrammed.

When this debugfs file is read, that secondary thread will receive the ipi
and execute the rmpopt instruction in rmpopt_report_status(). Because its
core's msr was never enabled, won't executing the instruction raise
a fatal invalid opcode exception and panic the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781419998.gi=
t.ashish.kalra@amd.com?part=3D7
