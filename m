Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6A4AF685
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385520; cv=none; b=VB1CatNzH50YWsU+DQQQKL+vumc6P2gAQZNUmW0Z1iwSmTGIsMMCYaAG9x9lldMZ5W17YYBy77YmNuqktHGQJO3MtKADL52SXqk0MkoxoIB3dqbH2+6scqDHDyKy32kj03vtgNBPCqAWvAp0YMvAz2m8r0V2PD2pNWnWj9B36Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385520; c=relaxed/simple;
	bh=EitDeUmB3HVOPyP4is9qBEYYkV3jfK8cC/kWG0OerYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cVcwbLrNPh/wmgpxHckDKPP7YmsrFV9RYwbV6AnBWG7i3R287877LlNoY3xDW4gbp5qa5q/ovlr72K1WzBubTcPK28yercCniwASWyqHMP+SeMe/BMdZujwDBTPnAWEZsuDh6n5madwJD/61HjRaiKSNRe69jzs7mjZ/pivpgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+KykcnS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+KykcnS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B06D1F00A3F;
	Wed,  2 Sep 2026 21:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788385500;
	bh=GQvJnzzRdXc/6OXXU0nhwzrxHRDmL7IJ7Y36VqqECTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l+KykcnSomV9n3fW9KERSrGn9djAYHvRZBhARB6nMYSBLwjzNIOXGMMqo4yZP+bK4
	 DC2MBHk2AGuTHTwT7kpuO6kpQfLV6vxjauHR5mirOZu0BXRrgepl6YIopGUTNCQXGC
	 jWE/L6R6jZyLJ43RjU3OKVXHaV5dirleROhxmS80Xu0nUtXjb5czAGy3xieQWnoM4m
	 f0019S2U2GWF2VPMfFNMnegl4nYhKskYqiKDkKMtstOoU7p2LwSlQd5Oai1S4KY521
	 /SBhMQ+E5qrxbrusGIy3Vy4LhQRPIzTf7jaTa6mcHY0fRab9L8M/qZb3pHrI5zl3+5
	 FJ13IAkc7MGCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 3/5] x86/sev: Initialize RMPOPT configuration MSRs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <3ee20e3956ab0529aa7bf526b6a743fe970089a3.1788296083.git.ashish.kalra@amd.com>
References: <cover.1788296083.git.ashish.kalra@amd.com>
 <3ee20e3956ab0529aa7bf526b6a743fe970089a3.1788296083.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 21:44:59 +0000
Message-Id: <20260902214500.6B06D1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] CPU hotplug lock is leaked if SEV-SNP initialization fails.
--

commit 16bd9580b377dc645541bd4f478c471c109e65ae
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Initialize RMPOPT configuration MSRs

This commit introduces the RMPOPT configuration MSRs and adds support to
set up and enable RMPOPT once SNP is initialized. The RMPOPT table base
is initialized to enable RMP optimization for up to 2 TB of system RAM.

> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index f833cb7e4da36..287a8345854ba 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1663,6 +1663,8 @@ static int __sev_snp_init_locked(int *error, unsign=
ed int max_snp_asid)
> =20
>  	sev_es_tmr_size =3D SNP_TMR_SIZE;
> =20
> +	snp_setup_rmpopt();
> +

[Severity: High]
This is a pre-existing issue, but does __sev_snp_init_locked() permanently
leak the CPU hotplug lock if SEV-SNP initialization fails?

If snp_prepare() succeeds, it disables CPU hotplug. However, if an error
occurs later in the function (for example, if walk_iomem_res_desc() fails),
the function returns the error code without re-enabling CPU hotplug:

drivers/crypto/ccp/sev-dev.c:__sev_snp_init_locked() {
    ...
    rc =3D snp_prepare();
    if (rc)
        return rc;
    ...
    rc =3D walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_MEM, 0, ~0,
                             snp_range_list, snp_filter_reserved_mem_region=
s);
    if (rc) {
        dev_err(sev->dev,
                "SEV: SNP_INIT_EX walk_iomem_res_desc failed rc =3D %d\n", =
rc);
        return rc;
    }
    ...
}

This leaves cpu_hotplug_disabled strictly greater than zero, which would
permanently prevent CPUs from being onlined or offlined. Does this function
need an error handling path that calls cpu_hotplug_enable() before returning
on these failure paths?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788296083.gi=
t.ashish.kalra@amd.com?part=3D3
