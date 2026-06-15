Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB33B52EE
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554470; cv=none; b=svAFxOZsH6xHCsqew5rjwa4OnMUuIJhH1ingOVUMysbmLTdk+1xHPjGgUktvEPbEVCSyVVVeUvTwKbw3RxzTpScHTcbJyz1j0NiEYI1133J2+UIrkJectAdDvlpfOok2z4Lzfn1xfVpTPliamGBjWz0m4M2xSAYKqZqkCJMBDZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554470; c=relaxed/simple;
	bh=ha9TsuHxZTAibEWk7ifvMQXYU0+acN+EQoc2UykxXtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hOyEKNXJQ6HhqA47eK9QJwzrddc247NZIAdgOnbE0ML6w8/JgCC4DHwTnps2GsETIh/3Ma8Iqn81UzHjumhqUFt5XW6HE2FnEjVdeWBNjhp32YriBBDp9ue5l8Ks7lZvczi3Ajkb1mUBlL2i6VPSR98rGivrZ5zN8R12mOdgnHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8sI+j2r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8sI+j2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940AC1F000E9;
	Mon, 15 Jun 2026 20:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781554468;
	bh=yy/v36kx2aVpFGkn7YhK1alpSjpZpgsv3u1kFaZh8hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F8sI+j2rc5G3CCj/NfYjoTQ5dVl8c7s0BzaXyyp0uUpMWa6tmsOZTB3qQgvlkiQzA
	 bcM4aIl1mbhQe/PpbZ1AFkH9RAN/ayUjY47KxIJdrbst7L2DupwAf5vLGvoiE+W9Lu
	 2lnh30XAdGhMkMdXtHelQDxx9CeikYumtx3vslNT36En2MdiG0eMBAx1XpfO+iSKMv
	 Kcp/SYAb2jiR2tJqzwNbD8LFY37b1HXhGqj3YvMKpSJSeDvdfSKU9LtUi9Tka5W5c+
	 n/9MS9PeHOUtATdRFcVaET4L9R0GpjpkjT66Y3VrjSyE/K34JA68o/er5Dy/XjINwA
	 YBldNI57aaNLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/7] crypto/ccp: Disable CPU hotplug while SNP is
 active
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <1feccf6e2a56d949b30f403c0ca7949f580e5982.1781419998.git.ashish.kalra@amd.com>
References: <1feccf6e2a56d949b30f403c0ca7949f580e5982.1781419998.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:14:28 +0000
Message-Id: <20260615201428.940AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The `snp_cpu_hotplug_disabled` flag is a module-local static var=
iable used to track the global `cpu_hotplug_disabled` counter. On systems w=
ith legacy firmware, CPU hotplug is intentionally left disabled when shutti=
ng down SNP. However, unloading and reloading the `ccp` module resets this =
static flag, causing subsequent SNP initializations to call `cpu_hotplug_di=
sable()` again. This unintentionally stacks the global counter, leading to =
a reference leak over multiple load/unload cycles.

Pre-existing issues:
- [High] If `SEV_CMD_SNP_DF_FLUSH` fails during SNP initialization, the fir=
mware state of HV_FIXED pages is leaked, potentially leading to RMP faults =
and host crashes when the pages are freed.
--

commit f12f8db5e522836adb88644cf2b682abf1545290
Author: Ashish Kalra <ashish.kalra@amd.com>

crypto/ccp: Disable CPU hotplug while SNP is active

This commit disables CPU hotplug during SNP execution to prevent
divergence between OS and firmware CPU expectations. It adds a static
flag to balance enable/disable calls and avoids re-enabling hotplug
on the legacy shutdown path.

> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index c002a7ca26a8a..cdda30a7677e2 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c

[ ... ]

> @@ -1478,6 +1481,17 @@ static int __sev_snp_init_locked(int *error, unsig=
ned int max_snp_asid)
> =20
>  	snp_hv_fixed_pages_state_update(sev, HV_FIXED);

[Severity: High]
This isn't a bug introduced by this patch, but if the preceding
SEV_CMD_SNP_DF_FLUSH command fails, the function returns early and
bypasses updating the software state of the HV_FIXED pages.

If the caller handles the initialization failure and cleans up via
snp_free_hv_fixed_pages(), will it see the state as ALLOCATED instead
of HV_FIXED?

drivers/crypto/ccp/sev-dev.c:snp_free_hv_fixed_pages() {
	...
	if (entry->page_state =3D=3D HV_FIXED) {
		entry->free =3D true;
	} else {
		__free_pages(page, entry->order);
		list_del(&entry->list);
		kfree(entry);
	}
	...
}

Could this incorrectly free firmware-locked pages to the buddy allocator,
potentially leading to RMP violations and host crashes later when those
pages are accessed?

> =20
> +	/*
> +	 * Disable CPU hotplug while SNP is active.  Guard against stacking
> +	 * the disable count: the legacy SNP_SHUTDOWN_EX path clears
> +	 * snp_initialized without re-enabling hotplug, so this can run
> +	 * again while hotplug is already disabled.
> +	 */
> +	if (!snp_cpu_hotplug_disabled) {
> +		cpu_hotplug_disable();
> +		snp_cpu_hotplug_disabled =3D true;
> +	}
> +
>  	snp_setup_rmpopt();

[Severity: Medium]
Since snp_cpu_hotplug_disabled is a module-local static variable,
does it get destroyed and reset to false when the ccp module is
unloaded?

If the legacy shutdown path intentionally keeps hotplug disabled,
would unloading and reloading the module cause this code to evaluate to
true?

If so, won't cpu_hotplug_disable() be called again, stacking the global
counter and causing a reference leak over multiple load/unload cycles?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781419998.gi=
t.ashish.kalra@amd.com?part=3D3
