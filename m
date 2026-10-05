Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633EA2F6562
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791223121; cv=none; b=p3WNnMgYrzyOcCmHKte/hjVGGdTDHmsKlxvRH9rZxUYCvIF8ORceJOsdECXdgWULRMdIFhQS5vuVt7WUpMnnj0IcHVdyWD4u1JXDgy80fmOaAFeu1K2fxXavQ1E0ziqOYFr6V4NbzFmT5C4+CRuLqL+W0HlgbRqPMnljhZh5pbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791223121; c=relaxed/simple;
	bh=ZplVlzDWz/z4hAfHJhtPZ70/KjubclP6AYzJ6d9rk9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JJWM2eoAtQGgUvIgPy93gRTs8h3ek8LXJNJjfqikUXsye0fqt8/jhvwXkHoPMMYcISiYTM0KHj31qYLO2PPAQb9faIrfJkKDPNX9aRsOy0pTh1G8qWd/nBCvvq3WgELc7ResmuwAnt+E+eMtVe0fHz6YZrbKnP8jrxzMjub63CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYr/vTZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYr/vTZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2D81F000FF;
	Mon,  5 Oct 2026 17:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791223120;
	bh=sRTLieQ8H92le8BkFNagKfeB/UDJHtEp/u0xwwXcQyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GYr/vTZrGoWBYnYgewieu0qp25t4vdiQ6/T01Mgrb6o/Ae/PDXSN3zVV29tXzFZ+m
	 jhpNTGWSaW0DNsSN87HPTGPbGLZwS3v/p/6wZKt55kYH2RaOsDDD2IDs8vcPgh8PYf
	 mP+J2bfwZW3V0ArQyOX6LXJV4oFQI3UzE0sUQtAw+mN7M1c1d2nYxZ9BP6yowCfbnl
	 uZx3tm7mLXL5O+tQchDFrDtp3jwiEBiNcCbbOIdmnjvv/me4e3KXZDpzRdysabkFRK
	 Hp5XZ6TVh/3Kkq3zbpKh4B/CO13LgV1OXZBqR+Y7NXbTUC0hEWLz03F3v59h2HjDCC
	 qCh/V0VWUUr9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yilun" <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261006-tdx-module-ext-v3-5-db52cb05b918@linux.intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-5-db52cb05b918@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 17:58:39 +0000
Message-Id: <20261005175840.1F2D81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] virt/tdx: stale boot metadata breaks TDX extension initialization
--

commit c0a5cf03ba530712949cf538278d0905890ebf56
Author: Xu Yilun <yilun.xu@linux.intel.com>

x86/virt/tdx: Re-initialize the extensions on runtime TDX module update

This commit introduces a mechanism to re-initialize TDX module extensions
during a runtime update. It intentionally skips memory reallocation, expect=
ing
the TDH.EXT.INIT call to fail if the updated extensions require more memory
than what was originally allocated at boot.

> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c

[ ... ]

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
Will this logic use stale boot-time metadata to skip a mandatory
initialization step for updated modules that introduce extension support?

reinit_tdx_module_extensions() unconditionally reads from
tdx_sysinfo.features.tdx_features0. This struct is populated during boot
initialization.

If an administrator installs a TDX module update where the new firmware
introduces extension support, this check will incorrectly evaluate to 0 and
skip tdx_ext_init().

When a new module adds extension support, it transitions to a pending
initialization state after TDH.SYS.UPDATE and explicitly requires
TDH.EXT.INIT. By returning 0 (success) here, the kernel proceeds as if
the module is fully initialized.

The hardware is left trapped in an intermediate state, which will cause all
subsequent SEAMCALLs to fail and active or new TDs to crash. Conversely,
if an update removes extension support, the kernel will incorrectly attempt
TDH.EXT.INIT and fail the update.

Should the kernel dynamically read the new module's feature bit via
TDH.SYS.RD after the update to accurately determine if TDH.EXT.INIT
is required?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-tdx-module=
-ext-v3-0-db52cb05b918@linux.intel.com?part=3D5
