Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECAB3DCD8B
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844089; cv=none; b=QlKA3cVjPIK4TXHCR0zZQ60eV+k7lbFfcbAEugQ2Y9/sXd2sH6vcT0+4LLjhPfPzi7+sysbtcVP0uDrZ2c9Oj0wwtRCHCJc66WJzLECdv+Q3v3lAxjkb+uj1e6snJL7Voj8R26h3ZohRbPMmCSiobBu/GKMsruy5Osywa+Fkoyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844089; c=relaxed/simple;
	bh=JmwYm0sOeTLIZXaJiGGE1+OlVoaD+GQRkRqgMBtc0J4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o7Jpi6m2vatS/QCJITIupy4k5x9mP4LIqqg15tBo7wszY1qEub4ttO/h/IbMQaToH9LY6PPPyoGMqqyzBsav9oxRhp/76ijqV2scWEDF1R4bsdLMeeLZtGtQv6nkWgJ0J6hhRCIGIoxCxWbFfEy3ee6BhWKRoeYT9igniooYi4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrpJ10in; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrpJ10in"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6860E1F00A3A;
	Tue, 30 Jun 2026 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782844088;
	bh=coRCovvUadZx/BBiitaXioFwmhmLQ0zuQZKUKhyN89s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KrpJ10inMJXjL7Px1GTr4Y1cHgDJk+yY6MimeX9CN1ciDw5OhFP2i8RM+srFmVi1w
	 IFFZF+cOIDUB/QOriXXek35av7jF6bhWQXyTVTfRHdxgHsVtx4wMijOyiuhTaWnbmA
	 WTGKOFvvnW22JJ9W1Hs1wdxsFRcR5c7B2ZHVvHXe8DlGtZFnmpJU7QRRUVYJk517Kx
	 mMp+7RcG3t+e9NtciFPHxme3t+lN9TCmuHBmf5KSg39fkpl+9bb3lVxD/17uOy6BDK
	 gx2F2gJHr40QvltjSfCeas5TfBTF4NVcBUTpblTkKVtkAA3poLiCFHXyyR23nySlGe
	 Adbe2OUGo6o+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/6] x86/sev: Add support to perform RMP
 optimizations asynchronously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <ada64cdc976b98a70687b3a347bca0c25c89eb09.1782841284.git.ashish.kalra@amd.com>
References: <cover.1782841284.git.ashish.kalra@amd.com>
 <ada64cdc976b98a70687b3a347bca0c25c89eb09.1782841284.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 18:28:07 +0000
Message-Id: <20260630182808.6860E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Re-initializing SNP after a partial shutdown bypasses the RMPOPT=
 optimization pass, leaving the new RMP table unoptimized.
--

commit 2d85f8f029da9849b60d0154807adccc997f6502
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Add support to perform RMP optimizations asynchronously

This patch introduces support for the RMPOPT instruction to minimize perfor=
mance
overhead by skipping RMP checks on 1GB memory ranges known not to contain
SEV-SNP guest memory. It adds a dedicated workqueue to perform these
optimizations asynchronously.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 04a58ac4339cb..40b06e959ee87 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> @@ -625,14 +743,42 @@ void snp_setup_rmpopt(void)
>  	if (!cpu_feature_enabled(X86_FEATURE_RMPOPT) || !rmpopt_capable)
>  		return;
> =20
> +	guard(mutex)(&rmpopt_wq_mutex);
> +
> +	/*
> +	 * Guard against re-initialization.  When SNP_SHUTDOWN_EX is issued
> +	 * with x86_snp_shutdown=3D0, snp_shutdown() is not called and
> +	 * rmpopt_cleanup() is skipped, but snp_initialized is still cleared.
> +	 * A subsequent __sev_snp_init_locked() would call snp_setup_rmpopt()
> +	 * again, leaking the existing workqueue, delayed work, and cpumask
> +	 * state.
> +	 */
> +	if (rmpopt_wq)
> +		return;

[Severity: Medium]
Will this early return prevent the initial RMPOPT optimization pass if SNP =
is
re-initialized after a partial shutdown?

If a partial shutdown occurs where rmpopt_cleanup() is skipped, rmpopt_wq
remains allocated. When snp_setup_rmpopt() is called again during
re-initialization, returning early here skips the queue_delayed_work()
call at the end of the function.

Does this mean the system will run without RMP optimizations on the newly
initialized RMP table, incurring RMP check overhead until a later event
triggers a rescan?

[ ... ]

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782841284.gi=
t.ashish.kalra@amd.com?part=3D4
