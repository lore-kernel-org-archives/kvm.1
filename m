Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A4387566
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433699; cv=none; b=I/KFKGbXllHuQqc364UlQGdTOdF4Uqhcrw1A2jwNy8pP65Wt5wbTGJPGuxeE6k0dTmsDgorNDdueYR5Cj8Dn78M4d+9kBQfW1rQeL2ExO6P6AEM1QXBQxNVlq8dz8McFZ5hXFTupj+imwvU4AtiWmrnyMh3+OZ6W7L6d5i3kXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433699; c=relaxed/simple;
	bh=RtYN1PFBOh4gpUdWlRbRi/qaZtnHx93ZUNes+kftCtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y4CLXvzwu8pWXCo+DHhhab83FYuAZQZGIK4YF5G90xx3qDvoKTeB/y5HXj5/x7CSbY9dRCPbKf7a7H8VQZ8s73DWw1qYEbjx43hOnLm2JOSZFMjyVBDb9AjthD3BVirxoUWOCG5rVgP7ciXoCd0yBipFCBPq3MUJdhSPbIsNkvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJQpkwZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJQpkwZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982A11F00893;
	Tue,  2 Jun 2026 20:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780433697;
	bh=ZagsUMYn9zDs1m60wOXY9deJS+9Btv9AVvWgq83puBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DJQpkwZza3RdjdG+Z6Nr2aYF9v6KdLWToP8G+EA/eNwkhHNfxBQ2DbhcXADVN26wj
	 XqURgaMMTNirvNGLUL4A5E3sG7TQ0DiNXWDAgRRXhdw3xunNTJUBMwSaWcJkn/IzKm
	 X6Uh+BamdTLx69WXjkZYu0Wqj3D2GukTCuXAYCmfznIK8j7st6S/rxZ09gz11FfeQ+
	 jAixr6HaMd35bivHkFZvXFDCt1601ors4ynISAdSmrL9R/C86vuP7Kdn8pc3WidXS1
	 xrHbUv+v9/DMUfQBlHuL+qVJ99wKTPBmrdBwnt0AdqyDdThBcFi4eJxNPnJmxGUi9Y
	 x9PBDY9CHMxHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] x86/sev: Add interface to re-enable RMP
 optimizations.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <3abe3f20a0bfe7518edadd3d36ca57b4189ca46d.1780427587.git.ashish.kalra@amd.com>
References: <3abe3f20a0bfe7518edadd3d36ca57b4189ca46d.1780427587.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 20:54:57 +0000
Message-Id: <20260602205457.982A11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The leader execution branches in `rmpopt_work_handler` lack `cond_=
resched()`, potentially causing softlockups on non-preemptible kernels duri=
ng the expensive RMP scan.
--

commit 083ce9f1c90cf08302bc96625ddfd8a7dbfd5a45
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Add interface to re-enable RMP optimizations.

This commit adds an interface to explicitly re-enable RMP optimizations.
It allows the processor to recover optimizations that may have been cleared
by events like RMPUPDATE by re-queuing the RMPOPT delayed work.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index d7e40a5fe5ca6..4442ecae3d18f 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -741,6 +741,21 @@ static void rmpopt_work_handler(struct work_struct *=
work)
>  	free_cpumask_var(follower_mask);
>  }

[Severity: High]
This is a pre-existing issue, but since the new code provides an interface
to explicitly re-queue this work, is there a risk of CPU stalls in the=20
work handler?

In rmpopt_work_handler() in arch/x86/virt/svm/sev.c, the leader execution
paths loop over up to 2TB of memory in 1GB chunks (up to 2048 iterations)
without yielding:

	for (pa =3D rmpopt_pa_start; pa < rmpopt_pa_end; pa +=3D SZ_1G)
		rmpopt(pa);

It also happens in the IPI loop:

	for (pa =3D rmpopt_pa_start; pa < rmpopt_pa_end; pa +=3D SZ_1G)
		smp_call_function_single(leader_cpu, rmpopt_smp,
					 (void *)pa, true);

Since RMPOPT is an expensive hardware instruction, could executing up to 20=
48
iterations sequentially without cond_resched() cause workqueue lockups and
softlockup warnings on non-preemptible kernels?

> =20
> +void snp_rmpopt_all_physmem(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_RMPOPT))
> +		return;
> +
> +	guard(mutex)(&rmpopt_wq_mutex);
> +
> +	if (!rmpopt_wq)
> +		return;
> +
> +	queue_delayed_work(rmpopt_wq, &rmpopt_delayed_work,
> +			   msecs_to_jiffies(RMPOPT_WORK_TIMEOUT));
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780427587.gi=
t.ashish.kalra@amd.com?part=3D4
