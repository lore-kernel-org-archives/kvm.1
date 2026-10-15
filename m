Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ACF4A482C
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047819; cv=none; b=ABQ2dveLAz7eYPXxNzWpiBdwchBwthtd5mpQ3GHrxjQ8lBxORE3w0+R39Yix6HAOAjuSaBzS7UpHmJYA9dYV3DZreCYwXfLkWY+DnIRNtR5mIbPZtKnfMJy2Ub1eaeVBSqmVfP8MrheaH4v+GEBsS685+jrRYNH0YWRxhMGlMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047819; c=relaxed/simple;
	bh=aF93OKa0YO/RKw5ZE3joEa+gNQpCl1d8TSqQOlaggkA=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=RiDm4RSDLJ4DUsekr1+uk2tfi4lYXFH5Ey83k7iRE7DrgUp6d1Xq+j8zGwCR/fRvQCyHyctt1vJbdYFakIgUCagv/WQjY7awTDITM+dOt0vvwmuOgIgvCacXWMz6cSp1B7Aw740CQdjr5ZL/ItyBopgW1NK04zvXfEkwvIGnZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwDQt/vm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwDQt/vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5A51F000C4;
	Thu, 15 Oct 2026 07:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792047811;
	bh=EyVdMOQ1E6qS+YKt0sxYNFrNgtRLuW+mMHKlpVdw9Cw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JwDQt/vmo6ZKYaO1YNyCuGwCAD3BQ0vvafAfWR07yXTykMmt7ZLCSqgDXFz6hz6pv
	 ePuN/Zlrmxcu4CXkV18gB2IA8wd9Y1Cl3WaxaSV5g0iyfcAnhUuCBNKJ+M0qDqpVjq
	 jceFECwhmBzGiKiqS0LR2Y+DcaaagcOuV6Rrypdkkpj3GpjZ7zk7ZExY7hx/lbOt9x
	 REbvFs6oBJ7SgadwDOpa82vzBAliwGeRRM5KBwUcZGtUswOqsKBA1lvIEH58NoySvh
	 mdSM503s5rPzZFSWKL3l/CLanf4EA6CYjrXWd9jXjxF7UzxaZyFgkeOeuKlM4n0D6X
	 QYEkfNpC+ulvw==
Message-ID: <sashiko-outbox-172378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/7] iommu/amd: Program guest-mode IRTEs for GAPPI
 wakeup when IRTE[IsRun] = 0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261015064515.10700-5-sarunkod@amd.com>
References: <20261015064515.10700-1-sarunkod@amd.com>
 <20261015064515.10700-5-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 07:03:30 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] iommu/amd: stale gappi_dis hardware flag in IRTE when is_running=3D=
true
--

commit fed3ee87aa05f53cbc2ccd8dd9c45c2a8ad8bb44
Author: Sairaj Kodilkar <sarunkod@amd.com>

iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun] =3D 0

This commit enables programming the IRTE for Guest APIC Physical Processor
Interrupt (GAPPI) wakeup when a vCPU is not running. It allows suppressing
these interrupts using the IRTE[GAPPIDis] bit when KVM does not request a
wakeup interrupt.

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index c0eec32ee3cb6..7ceb6bf508f03 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -4004,8 +4004,18 @@ static void __amd_iommu_update_ga(struct irte_ga *=
entry, int apicid,
>  		entry->lo.fields_vapic.is_run =3D true;
>  		entry->lo.fields_vapic.ga_log_intr =3D false;

[Severity: Low]
When a vCPU transitions to the running state, ga_log_intr is explicitly
cleared here. Does gappi_dis also need to be cleared?

If a vCPU transitions to is_running=3Dfalse with wakeup_intr=3Dfalse,=20
gappi_dis can be set to 1 in the newly added else branch below. When the=20
vCPU transitions back to is_running=3Dtrue, this code path is taken, but it=
=20
leaves the gappi_dis bit stale.

Could this cause unintended interrupt suppression or hardware state mismatc=
hes=20
if the IOMMU hardware evaluates the bit unexpectedly?

>  	} else {
> -		entry->lo.fields_vapic.is_run =3D false;
> -		entry->lo.fields_vapic.ga_log_intr =3D wakeup_intr;
> +		if (amd_iommu_gappi) {
> +			entry->lo.fields_vapic.gappi_dis =3D !wakeup_intr &&
> +						check_feature2(FEATURE_GAPPIDISSUP);
> +			entry->lo.fields_vapic.is_run =3D false;
> +			entry->lo.fields_vapic.destination =3D
> +						APICID_TO_IRTE_DEST_LO(apicid);
> +			entry->hi.fields.destination =3D
> +						APICID_TO_IRTE_DEST_HI(apicid);
> +		} else {
> +			entry->lo.fields_vapic.is_run =3D false;
> +			entry->lo.fields_vapic.ga_log_intr =3D wakeup_intr;
> +		}
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015064515.1070=
0-1-sarunkod@amd.com?part=3D4
