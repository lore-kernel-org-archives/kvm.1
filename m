Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAEB282F29
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503480; cv=none; b=VbCfVegKyL4cRI/qGajXS2UxT+fii2DknjCXp2F73MWvNqga5nxXFF9EIn/88PTSNemTvhLjQm8gpTM8duI4ZLoVSFriy7cW+xFKebAWczBjltUrhcH8ye+W4RKTmBfMAgL0cez8dLjhVek8uj5l+9WIKoi+2M/OKJsD1LglXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503480; c=relaxed/simple;
	bh=mcjQg7K0m3S3l3gBqrT/Nbf3tjPAvc2vhk6oVk/w80g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nhb00EK9s6ZY3ctSTpS9041r3MmbLGSGLBwIheatOk4BFP7IfNPgIEWzpZ2qyDymGjdtMKL8meqTMwZQbqoKeeymPPOSbp6ORXoH9YmEPdvXqUVxJ0TzBfS8RGJaXuXb/YhN2rFnaE6vKAVxDMjFevdt8gc335pTrfCc1+miVgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lshTkXWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lshTkXWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B081F000E9;
	Wed,  8 Jul 2026 09:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783503479;
	bh=Pe26pZoGgIaJVWqb8K3dlgM2d0+k45CIJ2rVTpvvZd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lshTkXWAf4cQELSBfdGnMBNseZqjKWg///+HtiDABhlRCG1VGqIQBiXQz3fzC3HxK
	 vbmK8WrbAwlxzPgyecswhCNFvqMrUCL9rrUqJeQCdoUftv5QwYfoWRGaShdBDcDmRs
	 7Rx4DqrByuHcOp7LGqii8l2i+LJDVIAT6VLIpMwf7Bf/bYNL0j243uAkT29rk5yqob
	 bfpFKQuWEeclVSDpy5q7H1zB6LOF4x0A1fRy6O/J/HRO5H31ZD4ML9hm1H/+SGjOTy
	 LOBij04o6zCAK4oIjRYgF9hOBKtTXd060gnF6z0IcymVUCDNS5KW/IzuGpT6WcirfW
	 t3W0fG9tlcShw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/5] iommu/amd: Configure IRTE to use the GAPPI
 for posted interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260708091408.12106-3-sarunkod@amd.com>
References: <20260708091408.12106-1-sarunkod@amd.com>
 <20260708091408.12106-3-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:37:58 +0000
Message-Id: <20260708093758.F1B081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Duplicate declaration of `extern bool amd_iommu_gappi` in both publ=
ic and private headers.

Pre-existing issues:
- [High] AMD IOMMU IRTE updates can be silently lost because `try_cmpxchg12=
8` is not enclosed in a retry loop.
- [High] Concurrent lockless read-modify-write of `ir_data->entry` bitfield=
s between KVM and the IRQ core causes data corruption.
--

--- Patch [2]: [RFC PATCH v2 2/5] iommu/amd: Configure IRTE to use the GAPP=
I for posted interrupts ---
commit 8796a3bab1c73d13bf17fdf71bd3ce4a5028e70d
Author: Sairaj Kodilkar <sarunkod@amd.com>

iommu/amd: Configure IRTE to use the GAPPI for posted interrupts

This commit configures the IRTE for guest-mode to use GAPPI for posted
interrupts when GAPPI is enabled. It uses the POSTED_INTR_WAKEUP_VECTOR
for the wake vector, which is carried in ga_tag. The patch modifies
the guest-activated IRTE programming to set the proper apicid and
gappi_dis fields.

> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index a2fe804b038b6..d0dcaa4d5fe05 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -41,6 +41,7 @@ int amd_iommu_enable(void);
>  void amd_iommu_disable(void);
>  int amd_iommu_reenable(int mode);
>  int amd_iommu_enable_faulting(unsigned int cpu);
> +extern bool amd_iommu_gappi;

[Severity: Low]
Is it necessary to declare this in the internal driver header?

I noticed extern bool amd_iommu_gappi; is also correctly added to the publi=
c=20
header in include/linux/amd-iommu.h in this patch.

[ ... ]

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 51a2bd5435412..0040bced92ef9 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
[ ... ]
> @@ -4021,7 +4031,11 @@ int amd_iommu_activate_guest_mode(void *data, int =
apicid, int flags)
>  	entry->lo.fields_vapic.guest_mode  =3D 1;
>  	entry->hi.fields.ga_root_ptr       =3D ir_data->ga_root_ptr;
>  	entry->hi.fields.vector            =3D ir_data->ga_vector;
> -	entry->lo.fields_vapic.ga_tag      =3D ir_data->ga_tag;
> +
> +	if (amd_iommu_gappi)
> +		entry->lo.fields_vapic.ga_tag =3D POSTED_INTR_WAKEUP_VECTOR;
> +	else
> +		entry->lo.fields_vapic.ga_tag =3D ir_data->ga_tag;
> =20
>  	__amd_iommu_update_ga(entry, apicid, flags);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but can AMD IOMMU IRTE updates
be silently lost here?

Looking at __modify_irte_ga():

drivers/iommu/amd/iommu.c:__modify_irte_ga() {
    ...
    old =3D entry->irte;
    WARN_ON(!try_cmpxchg128(&entry->irte, &old, irte->irte));
    ...
}

Does the single try_cmpxchg128() without a retry loop silently drop software
updates on failure?

Could it also clobber asynchronous hardware updates to the IRTE on success
because it writes back a stale software shadow copy?

[Severity: High]
This is a pre-existing issue, but can this concurrent lockless
read-modify-write of ir_data->entry bitfields cause data corruption?

KVM modifies the shadow copy bitfields using only svm->ir_list_lock:

drivers/iommu/amd/iommu.c:amd_iommu_deactivate_guest_mode() {
    ...
    entry->lo.val =3D 0;
    entry->hi.val =3D 0;

    entry->lo.fields_remap.valid       =3D valid;
    ...
}

While the IRQ core concurrently modifies the same 64-bit word bitfields und=
er
desc->lock:

drivers/iommu/amd/iommu.c:irte_ga_set_affinity() {
    ...
    if (!irte->lo.fields_remap.guest_mode) {
        irte->hi.fields.vector =3D vector;
    ...
}

Could this race condition cause the hardware IRTE to be programmed with gar=
bage,
leading to lost or misrouted interrupts?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708091408.1210=
6-1-sarunkod@amd.com?part=3D2
