Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A93F23D7
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473383; cv=none; b=AtSlpEzNwX4k+4g/rROJ/UnP0pHVh84WTHJEaSuo9Z3jDwMtxf9/vG21HV+/SeJR+xwW9G5Yk67eO2hIyKVFljCp9fCErvp+PAfwcMrzCzfwOTJuO0FOwJNXIoihJkYKxUPoW4QZ3/T/V6Wifh+GAT5CNnzFjmx4uTv+OdJkPnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473383; c=relaxed/simple;
	bh=rUXlA1jXakncTzZEmvdE6NjlvS8eLgyvw8clZ60qIFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t3PgMp287tN89vze7fSadxjEWc553IPO9J8CQx9+6MDAbwse6JFtd5YqWMpATrIHZjm8yMuDyh4EchJvTbN4I4yXGxb3IfvFrC0g6BPxtiIT7ow8A3mTWFh2bTvXC7Xv0UpwdEHTlzbQ+Vw9gsH1tggx02CODWDY6haHiSIEXKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlqTWMQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlqTWMQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3D51F000E9;
	Fri, 26 Jun 2026 11:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782473382;
	bh=OJe359it65xxNvLTDjnbdRCzcIfKgpS14Cor6BR0J9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RlqTWMQ3dxfUOLTQHpvRXxvPSlqyfRUknJK8zzE51SMdt87KXfcf0l+SE9kH0qXZu
	 Tr9CtRSjgv1XiFNvre+DNFd8q+p0dN6mhwmccO8Drdxfs2lX3ZwCtJ1lcAJB+LRnLn
	 OMYpHc3xXRcMtAxSnkHKl3RlAdkkXCkPb70E9MsKCs1eGQpZVcNVULi5mO4+NtuUya
	 CgZTkTuo7rYbxuR1OZNo1zWNoIIQHgbWkwmQTTl39T1592gHZtI8wx+FXHYqAb5slW
	 AkqBEqbC2TbgMUj/AcCqIPQpRYdOfIFt+8t4fhSTvw8BOgpPqyLO1MYZhZ28PzRYQ9
	 d67AFFOUmhLxw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/5] iommu/amd: Configure IRTE to use the GAPPI for
 posted interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626105906.14577-3-sarunkod@amd.com>
References: <20260626105906.14577-1-sarunkod@amd.com>
 <20260626105906.14577-3-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 11:29:41 +0000
Message-Id: <20260626112941.EC3D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `amd_iommu_update_ga` dynamically modifies the `gappi_dis` field=
 in the IRTE without issuing an IOMMU invalidation, which may result in per=
manently lost wakeups.
--

commit f265b23208b1df21d27bc13bee3b5f94ce45d71c
Author: Sairaj Kodilkar <sarunkod@amd.com>

iommu/amd: Configure IRTE to use the GAPPI for posted interrupts

This commit updates the AMD IOMMU driver to support Guest APIC Posted
Interrupts (GAPPI). It configures the Interrupt Remapping Table Entry (IRTE)
for wakeups using the reserved POSTED_INTR_WAKEUP_VECTOR when the guest
is not running.

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
[ ... ]
> @@ -3969,9 +3969,18 @@ static void __amd_iommu_update_ga(struct irte_ga *=
entry, int apicid, int flags)
>  		entry->lo.fields_vapic.is_run =3D true;
>  		entry->lo.fields_vapic.ga_log_intr =3D false;
>  	} else {
> -		entry->lo.fields_vapic.is_run =3D false;
> -		entry->lo.fields_vapic.ga_log_intr =3D !!(flags &
> -							AMD_IOMMU_FLAG_POSTED_INTR);
> +		bool posted_intr =3D !!(flags & AMD_IOMMU_FLAG_POSTED_INTR);
> +		if (amd_iommu_gappi) {
> +			entry->lo.fields_vapic.gappi_dis =3D !posted_intr &&
> +							   check_feature2(FEATURE_GAPPIDISSUP);

[Severity: Medium]
Does this code need to issue an IOMMU cache invalidation after modifying
gappi_dis?

Since __amd_iommu_update_ga() is a fast-path update function, it appears
there is no subsequent IOMMU cache flush when gappi_dis changes. If KVM
schedules out a vCPU (setting gappi_dis =3D 1) and then the vCPU blocks
(setting gappi_dis =3D 0), hardware that caches the gappi_dis bit might not
observe the transition back to 0.

Could this caching behavior lead to permanently dropped wakeup interrupts
and indefinite vCPU hangs?

> +			entry->lo.fields_vapic.is_run =3D false;
> +			entry->lo.fields_vapic.destination =3D
> +						APICID_TO_IRTE_DEST_LO(apicid);
> +			entry->hi.fields.destination =3D APICID_TO_IRTE_DEST_HI(apicid);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626105906.1457=
7-1-sarunkod@amd.com?part=3D2
