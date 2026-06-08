Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9745D3ACF14
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946263; cv=none; b=njwxoiwT8XDg2F9GQz23pka58Z8R0Ve+nz3TsE/a/t6umlyV8yMjj6vGf3bX98KrUG7L4xdScpabVYzxAnlgkheZV54+WVtk+tYXxvut0Xn6YsZ3/PV7pC1R7S5RoYuPcHFMcab42gBeMGs7wS90OFcvmIITLpsm8pkTVAjpF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946263; c=relaxed/simple;
	bh=Lq37KQciIuDEf2yT5XZs0Qu3epqd0kbYLqeg1g2hIe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AvITO03LzXgMt0gNlLDsCfqnd8n4EpOXeZAgSuN13PY95IAQjvIWsB6ntwK473QX0OeDeN11POptXO7Pi6r49s+dyqXzRibNHB3dzMgZlHJRYXjH7XZa+i5bBqhBj9cEwKR1GuzjHf8cS006hqgvzJ8FLL+bt8P3/f2tUXd6l9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCmiewmy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCmiewmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21ABD1F00893;
	Mon,  8 Jun 2026 19:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780946262;
	bh=9lUr98WBt+zrrnIGrUFYtctUB3NBp3jkwxaNAvJFIIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MCmiewmy3Nd3so2L6FXhjtiq1a+OfhZoEN9NlUHYA9Rtdn5VBIk2Eo+nxcBs4E3B5
	 8/OL2nRUdjpK7rA5MDoSo0nG2KZ5B3MxzNxL7+hKr32Og/1NkHYZxu+I5G90g/+Tjb
	 OwZ79fE6qnn+wx2vQohzWlPdp3KFwSRPzUxv1L0j3shtTST0x621B7Q3JlbW6KL8Kw
	 8JswJZVBGDAmQl3/PlOWSRDYXcIczIw77lD7XD0K/9KCvMjd6yFaaaU1sRj5VQZaLe
	 ZtHxmwqgn3SmW0BW8QrzIApUCc/vg9ibnJIy4CrYwSkGbgGu+2w5miNknEkZTzp8mi
	 ZjL6+433kEX9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/6] x86/sev: Initialize RMPOPT configuration MSRs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <2c2ef36f9dfc5eebb719bf45457b48712ce7e821.1780903370.git.ashish.kalra@amd.com>
References: <2c2ef36f9dfc5eebb719bf45457b48712ce7e821.1780903370.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 19:17:41 +0000
Message-Id: <20260608191742.21ABD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `setup_clear_cpu_cap()` during initcalls triggers an uncon=
ditional kernel `WARN_ON` trace because CPU alternatives have already been =
patched.
--

commit 155a667bf78d513dde1064d7dae284cc80a5dcba
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Initialize RMPOPT configuration MSRs

The new RMPOPT instruction helps manage per-CPU RMP optimization
structures inside the CPU. It takes a 1GB-aligned physical address
and either returns the status of the optimizations or tries to enable
the optimizations.

> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index 989ca9f72ba30..a8fc2ae502985 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -172,6 +173,8 @@ static void amd_cc_platform_clear(enum cc_attr attr)
>  	switch (attr) {
>  	case CC_ATTR_HOST_SEV_SNP:
>  		cc_flags.host_sev_snp =3D 0;
> +		snp_clear_rmpopt_configured();
> +		setup_clear_cpu_cap(X86_FEATURE_RMPOPT);

[Severity: High]
Does this code trigger a WARN_ON() stack trace?

The function setup_clear_cpu_cap() has an explicit WARN_ON(alternatives_pat=
ched).
This path can be executed from initcalls long after arch_cpu_finalize_init()
has set alternatives_patched to 1.

>  		break;
>  	default:
>  		break;

[ ... ]

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 8bcdce98f6dce..482008bb07e48 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> @@ -488,9 +492,14 @@ static bool __init setup_segmented_rmptable(void)
>  static bool __init setup_rmptable(void)
>  {
>  	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED) {
> -		if (!setup_segmented_rmptable())
> +		if (!setup_segmented_rmptable()) {
> +			setup_clear_cpu_cap(X86_FEATURE_RMPOPT);

[Severity: High]
Can this also trigger the same alternatives_patched WARN_ON() trace?

Since setup_rmptable() can run as part of rootfs_initcalls (via pci_iommu_i=
nit()
and amd_iommu_init()), alternatives will already be patched by the time thi=
s runs.

>  			return false;
> +		}
> +		rmpopt_configured =3D true;
>  	} else {
> +		/* Note that Segmented RMP must be enabled to enable RMPOPT. */
> +		setup_clear_cpu_cap(X86_FEATURE_RMPOPT);

[Severity: High]
Would this also result in a WARN_ON() during boot if the system supports RM=
POPT
but segmented RMP is disabled?

>  		if (!setup_contiguous_rmptable())
>  			return false;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780903370.gi=
t.ashish.kalra@amd.com?part=3D2
