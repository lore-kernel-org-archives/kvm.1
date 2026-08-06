Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE6225B09D
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 02:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982920; cv=none; b=aJ/DtV3M0KtiuztTGvu46xJNIAgNIwmcEfDz8ZEszOHiuyaZpipEbStNcM3sew6NX481UOBZYi+iyMkXEV0yMUdjpvJk/8IcPwbonPkxnIrAJwwQ/Wa1/IiN2ZS2OnFi2x5GDRHTnnZjmur5Vnad9mZ3FBaCeTrvxgZfM+FxS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982920; c=relaxed/simple;
	bh=V6SLIQeLVubuPFV8EnUKaw9lQ8rqour5MTwJlxb6Mgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FIpjdmKZPidGbHUMCWawvtf3iJEF0VJsYaWyexjypa98GQJnYQ3SCySmEjebLZh0O1aTNDxxLYtMYQP1+pjtJTyYcWGQhuuiEIwP57GolZrd44MIr5GOP5Un8ILHD+Q1b/MKwZxuwf/n8///C3vdlmYGLRzwDxkekbAvxXUBypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuhDSBdf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuhDSBdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586A11F000E9;
	Thu,  6 Aug 2026 02:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785982918;
	bh=/41zJusBPQ9r2FKuNB5nC9KafrPRjyfDVrUkcVVYy2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nuhDSBdfvNzwzDsTIZKNjapDHRrYldlSEhwDh/CnYugvcsRtpDQA+uqZUjLQlYSgt
	 nR2RaOmdOH2a3PQ2v/saaQr9P8yknDQ4xP8AGs7sLBi7xoUuJtHVvZBAsSCT6NwLog
	 jKS834w+2L64ChBwKKxlERsZamO1cmgBkZuxXgN2zGgEysLuyJkaaTyak7YaGlMWId
	 ozc/oxGm8UnecjKXx+2EVufDwc9QpwrxAHeP6isDCPx72c0ezSDqm6lenKp/TbqNSH
	 KzT9TDVXHycEyfWuaeQbIBwzsBtP/j0X16KrTgbHBh9DFfvGoOyPq69Xp7tsowZZMn
	 e0D4ZDz+2rU5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/11] x86/virt/tdx: Allocate refcounts for Dynamic
 PAMT memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Edgecombe" <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806020850.1221381-5-rick.p.edgecombe@intel.com>
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
 <20260806020850.1221381-5-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 02:21:57 +0000
Message-Id: <20260806022158.586A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vzalloc() lacks __GFP_RETRY_MAYFAIL, causing it to invoke the OOM =
killer and panic the kernel during boot on systems with sparse memory layou=
ts.
--

--- Patch [4]: [PATCH v9 04/11] x86/virt/tdx: Allocate refcounts for Dynami=
c PAMT memory ---
commit b63d4342b3d95af2bbe50ca5c66ac1ecbf04dedc
Author: Kiryl Shutsemau <kas@kernel.org>

x86/virt/tdx: Allocate refcounts for Dynamic PAMT memory

This commit allocates reference counters for every 2MB memory range to track
TDX memory usage. The allocation size is based on max_pfn and can be very=20
large on platforms with sparse memory layouts. If allocation fails, it is
intended to return -ENOMEM and fail TDX initialization.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 4d3427b8a5b71..b0ebd74a69fe2 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
[ ... ]
> @@ -252,6 +261,42 @@ static struct syscore tdx_syscore =3D {
>  	.ops =3D &tdx_syscore_ops,
>  };
> =20
> +/*
> + * Allocate PAMT reference counters for all physical memory.
> + *
> + * It consumes 2MB for every 1TB of physical memory.
> + */
> +static __init int init_pamt_refcounts(void)
> +{
> +	size_t size =3D DIV_ROUND_UP(max_pfn, PTRS_PER_PTE) * sizeof(*pamt_refc=
ounts);
> +
> +	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
> +		return 0;
> +
> +	pamt_refcounts =3D vzalloc(size);
> +	if (!pamt_refcounts)
> +		return -ENOMEM;

[Severity: High]
Could this vzalloc() call trigger a kernel panic on systems with sparse
memory layouts instead of gracefully disabling TDX?

The allocation size based on max_pfn can be extremely large (up to 8GB).
Because vzalloc() does not include __GFP_RETRY_MAYFAIL, an allocation
failure will invoke the page allocator slow path and the OOM killer. Since
this runs during early boot before any killable user processes exist, the
OOM killer will unconditionally call panic() instead of returning NULL.

Would it be safer to use __vmalloc() with GFP_KERNEL | __GFP_ZERO |
__GFP_RETRY_MAYFAIL | __GFP_NOWARN to ensure the allocator returns NULL
when memory is exhausted?

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806020850.1221=
381-1-rick.p.edgecombe@intel.com?part=3D4
