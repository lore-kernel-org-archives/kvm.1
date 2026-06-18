Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DE724293C
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772618; cv=none; b=jYo8UN+hmT1SykRMyOVc/pyE2LOoVe8zuO0bGOk2zgyRxL8wRcBMZ+i9np8LUVIErlnNJH67cevZv98snQqqcfcFbvWsVQcqmklzUnNAFJj1Idt+iKn8kIwpVvE10Fy8NLXSdq8p9CuzjiN+Vd/1KOJfH7UuYPWdlCnIk4U551k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772618; c=relaxed/simple;
	bh=5RBGw2LhcwzEIlg/zrK9W1+gpWhiJqh1a32A1NuID/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dwxkKFK212uR2kx55pG+IPtfsPoAMoFwlGRAZxAbP9jgWGJGSjJYsZ7MOoY9zMqMzZgWq5LcvfznBBeSqav3BIT0volt2PiEcTvG7aoGX18fn6Z5Nb2s9lbsY3yGeoucdJCr6fnclqreFmMHifd5Rz82daLgrl/eVSFn+4teGa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYCa9ohv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYCa9ohv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE151F000E9;
	Thu, 18 Jun 2026 08:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781772617;
	bh=iG+TkuJEiAeAZJuiOVTAs5pvwGy6AwjSaT/jkxWzY5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aYCa9ohvyABY+92Jjr90Y+sWrC3gej1xs6hzVE7x1RBo2n5gwdMg2C9/xkdkwJUj9
	 7QVH6djRQbpJe5Xg0bXbaiV9FQA4fJy3gg9rRo1NqAlupgBWGNCWAi8b2ZglGYUGDZ
	 l35JdxmrtjAyiflaN3gGe+fgSK2H8ofyvTEOsZPOW6ECgTuevnRYDC5meAGlTb3MsO
	 lJa6KVknGexde6gQRS84ecamr/AiGc0uZLNk8jUJKn07R5KFw1/+9wJX3Sg6d2eMMc
	 1fdctBmOqcV+yXROHWBZljYxwYJTNrSlmmgc2RTlw2m3xmpth5FxE2qkrV+bOVu0If
	 4K1qOchRNziHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/17] x86/virt/tdx: Initialize Quoting extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yilun" <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618081355.3253581-8-yilun.xu@linux.intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-8-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 08:50:16 +0000
Message-Id: <20260618085017.0EE151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using WARN_ON_ONCE() for an optional fallback feature causes kerne=
l panics with panic_on_warn and drops the actual hardware error code.
--

commit cc6fec2434c274e836f0735b1b3ace996ebcb151
Author: Peter Fang <peter.fang@intel.com>

x86/virt/tdx: Initialize Quoting extension

This commit initializes the Quoting extension during TDX bringup as an
optional feature. It intends to allow TDX initialization to gracefully
fall back to a userspace flow if the quoting initialization fails.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 4d2940f4538a2..06c42b86b05e8 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
[ ... ]
> +/* Initialize quoting extension */
> +static __init int tdx_quote_init(void)
> +{
> +	struct tdx_module_args args =3D {};
> +	u64 r;
> +
> +	do {
> +		r =3D seamcall(TDH_QUOTE_INIT, &args);
> +	} while (r =3D=3D TDX_INTERRUPTED_RESUMABLE);
> +
> +	if (r !=3D TDX_SUCCESS)
> +		return -EFAULT;

[Severity: High]
Does this discard the actual SEAMCALL error code? By returning -EFAULT
here, the specific hardware error information from TDH_QUOTE_INIT is lost,
which might make debugging initialization failures difficult.

> +
> +	return 0;
> +}
> +
> +static __init void init_tdx_quoting_extension(void)
> +{
> +	int ret;
> +
> +	if (tdx_addon_feature0 & TDX_FEATURES0_QUOTE) {
> +		ret =3D tdx_quote_init();
> +		WARN_ON_ONCE(ret);

[Severity: High]
The commit message explicitly states that quoting is an optional feature
and initialization failures shouldn't cause TDX bringup to fail.

Is WARN_ON_ONCE() too aggressive here? On systems configured with
panic_on_warn=3D1 (which is common in many environments), this will
trigger a kernel panic instead of gracefully falling back to the
userspace flow.

> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618081355.3253=
581-1-yilun.xu@linux.intel.com?part=3D7
