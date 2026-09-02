Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD440E8FD
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788386507; cv=none; b=UIEkkYc3DhkXUd+HOaHVFq/mCvyZEs+npoXjjaLaHhKILjnyFQCsqizFIQ1i5Ys6c/4uBfGr4dcJR3jNJ1viTJXYDl0xK+p/DzGLrml7cWN5XMcWORxbRrx8DMAzxH6KwO0ss1AjDeOd9H33QQkKTQ7oSw23Spugw4OukB59S6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788386507; c=relaxed/simple;
	bh=FoU/mDVknvdrYRU2ocWHPVsnASuPC3MbTTbQFshNI0E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=izaaRB1FdcVdt1KyxZ43ln5qVlH2vtzyrBMoNMLOycPXXn0rJhH2UDovMKMcCr7gQq16AGUTCJZWuD+/6+1NRkxZf8MNFxBJAX6hSDblmRFWcIvzaOd7v6XurtuhjDTpdQZdvnF5/4bFOW1zHG1tDeDf7iv2K1tWWQDysYisejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEH8nkqf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEH8nkqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6131F000E9;
	Wed,  2 Sep 2026 22:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788386500;
	bh=PFXHI/FkcKX9wAK9hmCvRi9EErQy0mYmpFg+5Qq7Liw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NEH8nkqfL9mXtxbgDEWuejjT2486/Ks55223vZtaZH5qiLB+n5UYPK+aQSZglevPr
	 y7G6FTOnkNlixrjRbgn/xLt49zSXs4B/av8MtmsCxSFiz4wvlzHjVyXZdgE6Dw7/ne
	 TX6Cvo+tmazLB8QVTZLuwjC/FA9XZnVUniijNMOI3sV4f+ZbO3yZLfUD7daRFDOdRq
	 8VokeiK9JRZMQ/oEvfqJpwpa5gYPBjBqT+Iuf58VGjlVfSozhr5dpjZ1m1puuGuxu9
	 iK6LbVHttTythhdrIn0O18QMF2jY6z4rta55RXXMCUMoH5ETGtowvYs+su+J9iejE0
	 LvARo8EkOiwJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 5/5] x86/sev: Re-enable RMP optimizations on SNP
 guest shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <e8a8d0ec63bda2db61cde7cf298a4ccb6a502c20.1788296083.git.ashish.kalra@amd.com>
References: <cover.1788296083.git.ashish.kalra@amd.com>
 <e8a8d0ec63bda2db61cde7cf298a4ccb6a502c20.1788296083.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 22:01:40 +0000
Message-Id: <20260902220140.BE6131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Redundant and costly RMP optimization scan in hardirq context caus=
ing severe CPU stalls
--

commit f95e55ff4f3219c5a1e0b2d2fc34fde539f227f7
Author: Ashish Kalra <ashish.kalra@amd.com>
x86/sev: Re-enable RMP optimizations on SNP guest shutdown

This commit introduces a mechanism to re-optimize memory on SNP guest
shutdown using a delayed work queue to batch multiple terminations.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index a4c0fe49b9ec7..fb66a1aa6fc35 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
[ ... ]
> @@ -659,6 +659,33 @@ static void do_rmpopt_work(struct work_struct *work)
>  	on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true=
);
>  }
> =20
> +/*
> + * Delay, in milliseconds, before the RMP re-optimization pass runs afte=
r an
> + * SNP guest is torn down.
[ ... ]
> +void snp_rmpopt_all_physmem(void)
> +{
> +	if (!rmpopt_capable())
> +		return;
> +
> +	guard(mutex)(&rmpopt_wq_mutex);
> +
> +	if (!rmpopt_wq)
> +		return;
> +
> +	mod_delayed_work(rmpopt_wq, &rmpopt_delayed_work,
> +			 msecs_to_jiffies(RMPOPT_WORK_TIMEOUT));
> +}

[Severity: High]
This is a pre-existing issue, but queueing the do_rmpopt_work task upon gue=
st=20
teardown exposes the host to severe CPU stalls.

Looking at do_rmpopt_work, it broadcasts an IPI to all primary threads:

arch/x86/virt/svm/sev.c:do_rmpopt_work() {
    ...
    migrate_disable();
    rmpopt_scan_range(NULL);
    migrate_enable();

    on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true=
);
}

The IPI handler rmpopt_scan_range executes the rmpopt hardware instruction=
=20
in hardirq context over up to 2TB of memory:

arch/x86/virt/svm/sev.c:rmpopt_scan_range() {
    ...
    for (pa =3D rmpopt_pa_start; pa < rmpopt_pa_end; pa +=3D SZ_1G)
        rmpopt(pa);
    ...
}

Since rmpopt is a very slow instruction, does iterating it over massive=20
memory ranges inside an IPI handler lead to soft lockups or host denial of=
=20
service, especially if frequent VM churn repeatedly tears down SNP guests=20
to trigger this scan?

Additionally, because rmpopt_wq is created as WQ_UNBOUND, the worker=20
thread might run on an SMT sibling. If so, wouldn't the initial local scan=
=20
execute on a CPU where MSR_AMD64_RMPOPT_BASE was never configured,=20
potentially leading to undefined behavior or faults?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788296083.gi=
t.ashish.kalra@amd.com?part=3D5
