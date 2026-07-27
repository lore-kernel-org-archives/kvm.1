Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FD3E47B
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181265; cv=none; b=svVvno/2cw0tEHE4hSpix9P06a016BjBUiK4TKY6j8d4t8S77az8N6yA3mjjH2TI9ABcEOzL12YQ6qPif5TKZjLp9JsX0DxzjUrdvmC8OU4e45I7apbULgFcX5UbB41skjdxQhJLt9PvXDzaSKM8veKAFo+u1KnYz7fssYcWHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181265; c=relaxed/simple;
	bh=VX0YrHBbLoqok5PR0RRjUBQwXjTxPG3Hz0nSr6cRcHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NCRZjzd6L+qc6hM+mxKmFmji/eGBRQdMR3ufmvdPoo3rBrKq/rrV/Mw4jVVtYmvZxq4rjnJ1Efv5Z3RJBhEiAnFazhAgZfpv1eBC9LGArXxlDMhx4InBoloq/fk/7kWpkVBMIrFNVWL+VtSLLDesXSS4iFYTWw9nrX7vuoxltzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n49jJ3Hm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n49jJ3Hm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BB81F000E9;
	Mon, 27 Jul 2026 19:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181264;
	bh=gTdWVn0R8GFWH2qsR62NxA2DPa5QveqWWAe46BFb4Jo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n49jJ3HmYa9LdDc8gT4Og8TSEHkxNt+RywKOwb/hxM/g4tZhLMBlT2JeZiEq7S2Rw
	 EtOwl8McmFYUEunBWSGm6UWTw+cThNFxrNnPjUumndlMunPbpehdwjvSk9sHCIcgO6
	 1x2y8feaD/aOOgWcvR4OTkcmBURgnapUlYvGCfQyrlqmCHyT7cuNz1S917AD9s3WjF
	 fVnwOfevEX37/P3sxBzDC1MqK8ZbRhR88yTeVvxlPmU2M+8CkFTN8vUlXK3bM7CjDe
	 seJqSjicYQDO974APcM30+XsSyehrXnBrMeaUfSw0oVrH/SWkE/r7glrMCNNLHhO45
	 jIhkS3b4lgCJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/9] KVM: x86/pmu: Restrict RDPMC passthrough to
 known CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727192131.582105-8-zide.chen@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
 <20260727192131.582105-8-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:41:03 +0000
Message-Id: <20260727194104.16BB81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Compilation failure due to undeclared identifier `INTEL_PANTHERLAKE=
_R`.
--

--- Patch [7]: [PATCH v7 7/9] KVM: x86/pmu: Restrict RDPMC passthrough to k=
nown CPUs ---
commit 4eba5efe34005f159dabad1f08138db5ccbe910e
Author: Zide Chen <zide.chen@intel.com>

KVM: x86/pmu: Restrict RDPMC passthrough to known CPUs

This commit restricts KVM RDPMC passthrough to a known list of CPUs with
audited RDPMC encodings to prevent host PMU information leaks to the guest.
It explicitly requires RDPMC interception for unknown CPUs.

> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index b983030fb910e..444a66ca33240 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -77,6 +77,21 @@ static const struct x86_cpu_id vmx_pebs_pdist_cpu[] =
=3D {
>  	{}
>  };
> =20
> +/*
> + * CPUs whose RDPMC encodings have been audited for KVM RDPMC
> + * passthrough support.
> + */
> +static const struct x86_cpu_id kvm_rdpmc_known_cpus[] =3D {
> +	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, NULL),
> +	X86_MATCH_VFM(INTEL_LUNARLAKE_M, NULL),
> +	X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
> +	X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
> +	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
> +	X86_MATCH_VFM(INTEL_PANTHERLAKE_R, NULL),

[Severity: Low]
Does this code build correctly on x86? It appears that INTEL_PANTHERLAKE_R
is an undeclared macro, which could cause a compilation failure when buildi=
ng
arch/x86/kvm/pmu.c.

> +	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
> +	{}
> +};
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192131.5821=
05-1-zide.chen@intel.com?part=3D7
