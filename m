Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F463B6C09
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772873; cv=none; b=Hr1vMqwc1FqtyqI3RIlc5rOU2jfoYo7DIQb2wPakvO7n/kbCwgKZD2fHmFSkLQymZxviKSyJv+h94iI/QfHjSt/L/CjttVJfJ8rw0BJ/t1GmSl6h03odZmXVlZ4GYdexUedYMgxH5Ky4iAcrZSNTCGzum38FxlPysKqYdmuTLf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772873; c=relaxed/simple;
	bh=BOV8CPyplS+xw4Hwl9oAILm10KCb5d1xX01syiMuFhs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SjZRnqdWk153QG91ClzNTEoofNo5LXvgVDto5u+IdQWVLAWE8TjmtftyrUyyIancibFqxYLtPrBiijCMh62xMmkPxvBpWrwhftK/3z/vDqdK3NfBdBZ7Zcly6E+xqV0SfD+1c/vulWj+0zC4vIeN07oCbXw1kYLiY0yuEmjjGjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEQo7CHj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEQo7CHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83541F000E9;
	Thu, 18 Jun 2026 08:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781772871;
	bh=ZzCDOzhJEEaxdgNSQtRDKYNVWB2Xm1xlX/gw3enb3oc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kEQo7CHjnDD6LCy+0HtT/8+K61JNGwuRWs3HSA50AYoLETPvW/GCotdao6VjFauu0
	 tWD8HCM9xMDnhEClR0dz+1j3S1MWVO0sIL8EeL5MlWKfX5h/RRoHlBr0gi/vJ7F+cW
	 NowLIj7n2QnKX44Q6cvFlcngjBMs3GLsiQgD83prHNuEL00ivcaN0BOEwZoI6so10e
	 XMb+BZmuru8a5EVs+Via4XwoawAHR6tVoGc/4ceSCynLE6y45NNleuD5Q+5eWG8s/v
	 9B7W6YsMgXQ3HLyyFxxnZmObZPTOBLlcE6V+hfU7d0WgvBnQ6Iyd3PlCKE/sbnxmt8
	 rBi6GhgnB3VNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/17] x86/virt/tdx: Make TDX module initialize the
 extensions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yilun" <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618081355.3253581-6-yilun.xu@linux.intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-6-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 08:54:31 +0000
Message-Id: <20260618085431.B83541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] tdx_ext_init() (added in this patch) and tdx_ext_mem_add() silen=
tly discard the 64-bit hardware error code from their SEAMCALLs and return =
-EFAULT without logging.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but by the earlier c=
ommit 'x86/virt/tdx: Add extra memory to TDX module for the extensions'. Th=
e `hpa_list` structure is allocated via `kzalloc_obj()` which does not guar=
antee page-alignment.
--

commit 555dbf36da39abb049edf2bd1291c474f12aac77
Author: Xu Yilun <yilun.xu@linux.intel.com>

x86/virt/tdx: Make TDX module initialize the extensions
   =20
After providing all required memory to TDX module, initialize TDX
module extensions via TDH.EXT.INIT, so extension SEAMCALLs can be used.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index dab17822c1c69..900928de373ae 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
[ ... ]
> @@ -1167,6 +1167,22 @@ static __init int init_tdmrs(struct tdmr_info_list=
 *tdmr_list)
>  	return 0;
>  }
> =20
> +/* Initialize TDX module extensions for extension SEAMCALLs */
> +static __init int tdx_ext_init(void)
> +{
> +	struct tdx_module_args args =3D {};
> +	u64 r;
> +
> +	do {
> +		r =3D seamcall(TDH_EXT_INIT, &args);
> +	} while (r =3D=3D TDX_INTERRUPTED_RESUMABLE);
> +
> +	if (r !=3D TDX_SUCCESS)
> +		return -EFAULT;

[Severity: Medium]
Does this code silently discard the 64-bit hardware error code?

When TDH_EXT_INIT fails, replacing the return value with -EFAULT means
the caller only logs a generic initialization failure without details.
Other TDX initialization functions use seamcall_prerr_ret() to preserve
and log the hardware error.

Could this be updated to use seamcall_prerr_ret() to ensure the exact
firmware failure reason is logged?

> +
> +	return 0;
> +}
> +
[ ... ]
> @@ -1285,7 +1301,11 @@ static __init int init_tdx_module_extensions(void)
>  	if (!sysinfo_ext.ext_required)
>  		return 0;
> =20
> -	return tdx_ext_mem_setup(sysinfo_ext.memory_pool_required_pages);
> +	ret =3D tdx_ext_mem_setup(sysinfo_ext.memory_pool_required_pages);

[Severity: High]
This isn't a bug introduced by this patch, but does the earlier
introduction of tdx_ext_mem_setup() cause an alignment issue?

Looking at tdx_ext_mem_setup() in arch/x86/virt/vmx/tdx/tdx.c:

tdx_ext_mem_setup() {
    ...
    hpa_list =3D kzalloc_obj(*hpa_list);
    if (!hpa_list)
        return -ENOMEM;
    ...
    ret =3D tdx_ext_mem_add(virt_to_page(hpa_list), nents);
    ...
}

The TDX module's TDH.EXT.MEM.ADD leaf expects a page-aligned PFN for the
HPA list. Since kmalloc does not guarantee page-alignment (especially if
CONFIG_SLUB_DEBUG is enabled), virt_to_page() drops the unaligned offset.

Will this result in the TDX module reading from offset 0 of the page,
potentially consuming SLUB metadata instead of the actual hpa_list
entries?

> +	if (ret)
> +		return ret;
> +
> +	return tdx_ext_init();
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618081355.3253=
581-1-yilun.xu@linux.intel.com?part=3D5
