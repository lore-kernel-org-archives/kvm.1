Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0E752B1D2
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906282; cv=none; b=G6mB48fGztzk54hlTpKSrQVF2/YecmdbtnmPJkLQmH2s3TFKlca+HGuI3o1vy99bQW9HufBUxmr2KpIsHARqUJXdYruL+AswsDNuW/fWpNMAzeEs8Z02t/Q+eDsI3KYZWvCpmkHOrvik+fvAAszJfxsgHRLq4e5/DC6ks63dx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906282; c=relaxed/simple;
	bh=9+LYf36+e2dgHnnN/O2ZmnzzEk3G2DySBrMv/HUjwdA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=I77wTSMAyx6fM7SdjHYUAlBHu3YZZjSDuHX3KWS5jZPmbG0qCT9zRJkFbxD4t5zd+oUR91bQwgKh/H1bF65WTGLUbKrDI74wyoIX3id2qsIbm1h2DQaymJVF8IrY7/miwxj2rdfG3Ky8AiXuoEmjnbiu1QGXfOX4pRjhToJ68GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9Q7xv2E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9Q7xv2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5839C1F00893;
	Tue, 13 Oct 2026 15:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906281;
	bh=ZZyXm1TwM3dEva7DNZSnpYkANvU0Nxhlj/sRIkgJms0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E9Q7xv2EZKdLng//hUzxDMrt3v2VzVLtTaIdtUIA0g1NEaF05GMPdk16KCfKTYS0E
	 74AnhvLPu5Pytffjc/GsxN0EQ4IMcY2vY0sRq8qYrcIh6vHFvMJQFOx8MAyErRU/Sx
	 EVUKnbKh1I/Lx46zlP6E+z06UsYiBLXbQir5Y7UNyHZzp0lqdhwnAa1oZLR8At4ShU
	 DXZhNxoEoQNOWW6bWC7i4tjvRt2F6Gyd+7/4U1ivqJbOs/Nm2BzlIxbFiSwoVOQ9MW
	 ovyUGi9+0fuYfx9/iuFYbGIb05K3fxGiKevdYz9YkQ8ocwRT/rJRpcE+3qeZrQQyfJ
	 YlVgI1B/SsRAA==
Message-ID: <sashiko-outbox-170037@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yilun" <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261013-tdx-module-ext-v4-6-de5ffac65470@linux.intel.com>
References: <20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com>
 <20261013-tdx-module-ext-v4-6-de5ffac65470@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 15:44:40 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tdx: use stale features0 metadata for TDH.EXT.INIT during update
--

commit b9612f7aae2064bfaded9e7d4ac02af4fa76ac04
Author: Xu Yilun <yilun.xu@linux.intel.com>

x86/virt/tdx: Re-initialize the extensions on runtime TDX module update
   =20
Runtime TDX module update introduces a mechanism to update the module
firmware while preserving and restoring TDX operations. The extensions
functionalities should also be re-initialized as part of the restoration
process.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index f1cc0422d129a..4cce77b6a31f6 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c

[ ... ]

> @@ -1384,6 +1384,19 @@ static __init int init_tdx_module_extensions(void)
>  	return tdx_ext_init();
>  }
> =20
> +/*
> + * Don't update the memory requirement metadata or try memory allocation=
 in
> + * stop_machine(). If an incompatible update requires more memory, let t=
he
> + * extensions re-initialization fail.
> + */
> +static int reinit_tdx_module_extensions(void)
> +{
> +	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> +		return 0;
> +
> +	return tdx_ext_init();
> +}

[Severity: High]
Does this use stale features0 metadata during the update?

If an administrator applies a valid TDX firmware update that changes the
presence of zero-memory extensions, could relying on the boot-time cached
value of tdx_sysinfo.features.tdx_features0 cause problems?

If the update introduces zero-memory extensions to a module that originally
had none, the cached flag evaluates to 0, skipping TDH.EXT.INIT. According
to the TDX architecture, this could leave the new TDX module stuck in the
SYS_UPDATED state.

Conversely, if an update removes extensions, the cached flag remains 1,
causing the kernel to erroneously call TDH.EXT.INIT on a module that
doesn't support it.

Should the kernel read the updated TDX_FEATURES0 metadata field using
read_sys_metadata_field() during the update instead of relying on the
boot-time cached value?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-tdx-module=
-ext-v4-0-de5ffac65470@linux.intel.com?part=3D6
