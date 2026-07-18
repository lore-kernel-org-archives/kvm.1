Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529C22FE0E
	for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784339788; cv=none; b=J8HGKJJCn1320U+EebBPx0lRDp37iYkYavSxNZSXY2lwZvYwGY2c9oZ8VQWYEnJcsOpNgYEkefC2Yxq8J56xJkgaynGhwDRsRwE9yjNB29EUam9uuc/6Uz/XGcCpPWDrNHjprPNrmGP8Jri3gXscZ1b6/e8r+c/SYVhqTba7hPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784339788; c=relaxed/simple;
	bh=ECyGiyl8EIOZflppUwcHEHPdM558pkpfPXCqCUf7m4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NRPSlZ0+Y7aX/PQsU93wtRxQ9s2ub4+vVEmKGcbM+eoQmkeQd+BWEWsSsQP48UVN7a3xB6jMUWn61wvKZ2MDeS93IxIihV7tQvaIgoWYjYe6qFWX1g3pnKmwfLmx9VwQ9KWpSwB9/BjcxCeY/YH0YNKeZDf9zfx47amVzw1OECc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBVSXfuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBVSXfuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D9F1F000E9;
	Sat, 18 Jul 2026 01:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784339787;
	bh=C1DJEZ2uUEq1nTVONdL2ND5gDICpAQo/paVnuDwx/E0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PBVSXfuXmYf9q/MwlUtmurhIyvlBRB8Xc/rpXE+uS1mVyq8li8atNK0fV1c4ncdoa
	 HLf8NBej7L/h3OPGJjHfozUfN1iA2DVyvuJipE4lMCtJ+/EWPpgHrhOuZEkI5PTIr0
	 sOm+g/h08R3qsv4nSxRTdgPBwcG4bBNEBbnOoJbbyNFwZHH2dOlieDjh8OketjqfPa
	 K0FrnsestRZMtIB37tVA405JsPUol3X4ZVb+0tPMQM0YjVesXBvuiz8GnFM395Utmn
	 ykblllA/zksL0TI0gy3DoIAsJsgE+4rg9hpyiWOr7gLAEj1IdoKgewN7JsB81IzW5/
	 tV8HL7NDM4YXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/11] x86/virt/tdx: Enable Dynamic PAMT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Edgecombe" <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260718014500.2231262-10-rick.p.edgecombe@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
 <20260718014500.2231262-10-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 01:56:26 +0000
Message-Id: <20260718015627.21D9F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The global variable `tdx_enable_dpamt` is defined without the `stat=
ic` keyword, polluting the global namespace.
--

--- Patch [9]: [PATCH v7 09/11] x86/virt/tdx: Enable Dynamic PAMT ---
commit a5e057035573a191a887572dacd25f3faa79112d
Author: Kiryl Shutsemau <kas@kernel.org>

x86/virt/tdx: Enable Dynamic PAMT

This commit enables Dynamic PAMT for TDX modules to reduce memory usage
during module initialization. It introduces a kernel command line parameter
"tdx_dpamt" to allow users to opt-in to this feature when supported by the
hardware.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index e31b62f36300d..69834b0d3e602 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -47,6 +47,8 @@
>  #include "seamcall_internal.h"
>  #include "tdx.h"
> =20
> +bool tdx_enable_dpamt __ro_after_init;

[Severity: Low]
Since tdx_enable_dpamt is only used within this file, should it be marked
as static? Leaving it globally exposed can trigger compiler warnings like
-Wmissing-declarations when building with W=3D1 and unnecessarily pollutes
the global namespace.

> +
>  struct tdx_module_state {
>  	bool initialized;
>  	bool sysinit_done;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718014500.2231=
262-1-rick.p.edgecombe@intel.com?part=3D9
