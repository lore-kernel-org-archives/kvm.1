Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB53AEB2C
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554028; cv=none; b=QQofv5iioYD0Ek1x/7YFTxsBUJL+zXDjGiuebJzUSiSapVbj8hpFBY1j1wHDw4zYxG8X9BXxMYZE4pEJFim7fgzRfkSXsXyE4MlZ3ZS3B7OYZ+r6alluX5kDsJjkCfn3alzwUJW0whdWcwMHFHeuZ7PLFj6NFd0LYlJrgXfVGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554028; c=relaxed/simple;
	bh=pqX14oeAB9NxjurGPA6WAZ7UQ5+E6uD2Ft0xq37N5A4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cfc+/uzUqYLcekcTCDM/TK98cOzJMxdjyavErcEzjnCvCXRY2PI/1Hsy7fStptOMvzUmDgMeuuNZPW1lxsOFoZPzXBr88a5jcjiW986CBC8lR6uqBXoEORtp08Z5ilcdPtbyIZYK3l70jGXvTm5XmvmPtRhFBHITuaq7RPqUhyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWTZSLeJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWTZSLeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044A41F000E9;
	Mon, 15 Jun 2026 20:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781554027;
	bh=vM5U3rDtuO+wZS/1EuQ6hdS15PMag6IkDFvT+P88p3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YWTZSLeJqx5LtoLr/cxirK6SVbbNheG1sZqDUs91jFIYvc79TEYx/KLpseLQnge+R
	 sO9MR4DuMsbI5zlE5dEEoDCJpn5CLFKDpZOI61gCz4AZ7T1HASGLrhW1gXF8ygJF98
	 joHuYiODv/eUd6FbFX7CgOFoP6dkM+YytXhwoCe4ZVik8p/SaueSrb847S6qIGgtbh
	 TtjTruWlmijyKdqMi4t7j0AvxaNFlKDMzjWA5lL5/+DnV1uqssSLFGDgHgAXJt7GsC
	 vHvmcZSjHOE8Im3Mru239vYW9kTS2GEzCUnm+te/HRCsC8KPaOnRrJ9xF2KGjLuVsk
	 TArRhWUIFFgRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/7] x86/sev: Add support to perform RMP
 optimizations asynchronously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <de274c2fb3f794ff1f19f0c96184ee50d04d1282.1781419998.git.ashish.kalra@amd.com>
References: <de274c2fb3f794ff1f19f0c96184ee50d04d1282.1781419998.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:07:06 +0000
Message-Id: <20260615200707.044A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unsynchronized MSR teardown causes #UD panic when reading RMPOPT d=
ebugfs file.
--

commit f092a06fad8eb0834da2fe3bbc80d3b029232484
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Add support to perform RMP optimizations asynchronously

When SEV-SNP is enabled, all writes to memory are checked to ensure
integrity of SNP guest memory. This imposes performance overhead on the
whole system. This patch adds support for performing RMP optimizations
asynchronously using a dedicated workqueue.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 1b5c18408f0bf..b63b639bfc30b 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> @@ -568,6 +580,14 @@ static void rmpopt_cleanup(void)
>  {
>  	int cpu;
> =20
> +	guard(mutex)(&rmpopt_wq_mutex);
> +
> +	if (!rmpopt_wq)
> +		return;
> +
> +	cancel_delayed_work_sync(&rmpopt_delayed_work);
> +	destroy_workqueue(rmpopt_wq);
> +
>  	cpus_read_lock();
> =20
>  	for_each_cpu(cpu, &rmpopt_cpumask)
> @@ -576,7 +596,8 @@ static void rmpopt_cleanup(void)
>  	cpus_read_unlock();
> =20
>  	cpumask_clear(&rmpopt_cpumask);
> -	rmpopt_pa_start =3D 0;
> +	rmpopt_pa_start =3D rmpopt_pa_end =3D 0;
> +	rmpopt_wq =3D NULL;
>  }

[Severity: High]
Could this MSR teardown cause a #UD panic if it races with the debugfs
interface introduced later in this series?

rmpopt_table_seq_show() unconditionally executes the RMPOPT instruction on
all online CPUs to display their optimization status, protected only by
rmpopt_show_mutex.

If system operations like module unload or kexec trigger snp_shutdown(),
it invokes rmpopt_cleanup() which tears down the feature by writing 0 to
the MSR_AMD64_RMPOPT_BASE MSR on all CPUs:

arch/x86/virt/svm/sev.c:rmpopt_cleanup() {
    ...
    for_each_cpu(cpu, &rmpopt_cpumask)
        WARN_ON_ONCE(wrmsrq_on_cpu(cpu, MSR_AMD64_RMPOPT_BASE, 0));
    ...
}

However, rmpopt_cleanup() does not acquire rmpopt_show_mutex, and the call
to debugfs_remove_recursive() does not block or abort in-progress read()
operations.

If rmpopt_cleanup() zeroes the MSR while rmpopt_table_seq_show() is still
executing on_each_cpu_mask(), could any CPU executing RMPOPT with the MSR
disabled generate an unhandled #UD (Invalid Opcode) exception?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781419998.gi=
t.ashish.kalra@amd.com?part=3D4
