Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803753E5EF0
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735607; cv=none; b=EOiCuShH6xSb1sP+Uu1PRcmjvW+rv4FwbaNkpX0ieeiKkGwCH7PCw8hZHuHE396O+4buLZ78gBJmX0t3mJ6Fv3cvB6/CEwXXsO4ByYZZ2JKffYhv6v4vj0/7sQ1R24WDzcddojHu4XhVkqW1rIWCNMNZw9RoK50NVDv4AOZNTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735607; c=relaxed/simple;
	bh=QyW1nogWCg9uUY2YwvCsocz7+bDGiEw2VgmOQOY4vl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qTHjBAUjM7NeZIkY/WP5rGkm3yYC7ykTkNS9QsV5s6y+T2MaDKNVsMvK/xsmX03MU1IHTeSNSIh13ArrigI4iiD2spiANYNC56wBNfh5J6rS8Or9nAPxSJqR9WXeHC3yEjXQZ+TtE/SpfgwHc+j9VTaIoIf/1hPvFDaY3A6n2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpIkVg5r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpIkVg5r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDECD1F000E9;
	Wed, 22 Jul 2026 15:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784735606;
	bh=/pti9AZz02omNQVL7GMqw9i/AUdCTbliLbzzGOQNYHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UpIkVg5rLtU/xiHHTzHvlk6WcYYF7TATOg/kwiY9ROuHE0OXFnHAHUjpCf/I2p0Ic
	 825lxJa5YpjYUi4y5tgKQpsdGbxmHbt5ma9NvaV/rW7P4wdstHHxrZ4R1gEZy0SEGp
	 XuHuEyML/y8O8O8mxTGhoC0HSa7W8oy6vHzdNmsED5EIA2gNpGkY0wsEN81AuhFyZA
	 zc6b3AqrKNi9+ljgUe57Mu+9f0mAFYRZH2THe4MeA4scpY5Pa1xU0FrUgmFymfXzmn
	 TRfK/FWFbyWfV+1bnVKmBQWgc5x/a9lNC2FzB4lV7Geys0EocX4/Z14u5MKpoODMtV
	 pFgeKjgIvMnVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 09/20] loongarch: kvm: remove stack copy address
 of pXd in pXd_offset()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260722-dummy_ptxp3-v2-9-d9e4bad31e0a@arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-9-d9e4bad31e0a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 15:53:25 +0000
Message-Id: <20260722155325.EDECD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] host_pfn_mapping_level() does not check if the PUD entry is a =
huge page (leaf) before traversing to the PMD level, leading to an unmapped=
/unaligned address dereference (Host Kernel Panic).
--

--- Patch [9]: [PATCH RFC v2 09/20] loongarch: kvm: remove stack copy addre=
ss of pXd in pXd_offset() ---
commit 2f6da9236b45d60a4f233dc4f7a63b29a762f060
Author: Yeoreum Yun <yeoreum.yun@arm.com>

loongarch: kvm: remove stack copy address of pXd in pXd_offset()

This commit reworks host_pfn_mapping_level() to avoid using a stack copy
of a pXd and passes it as an argument to pXd_offset_lockless(). This
prepares the code for generic compile-time folded page tables.

> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> index e104897aa5328..837b40bb694f4 100644
> --- a/arch/loongarch/kvm/mmu.c
> +++ b/arch/loongarch/kvm/mmu.c

[ ... ]

> @@ -698,19 +698,23 @@ static int host_pfn_mapping_level(struct kvm *kvm, =
gfn_t gfn,
>  	 * value) and then p*d_offset() walks into the target huge page instead
>  	 * of the old page table (sees the new value).
>  	 */
> -	pgd =3D pgdp_get(pgd_offset(kvm->mm, hva));
> +	pgdp =3D pgd_offset(kvm->mm, hva);
> +	pgd =3D pgdp_get(pgdp);
>  	if (pgd_none(pgd))
>  		goto out;
> =20
> -	p4d =3D p4dp_get(p4d_offset(&pgd, hva));
> +	p4dp =3D p4d_offset_lockless(pgdp, pgd, hva);
> +	p4d =3D p4dp_get(p4dp);
>  	if (p4d_none(p4d) || !p4d_present(p4d))
>  		goto out;
> =20
> -	pud =3D pudp_get(pud_offset(&p4d, hva));
> +	pudp =3D pud_offset_lockless(p4dp, p4d, hva);
> +	pud =3D pudp_get(pudp);
>  	if (pud_none(pud) || !pud_present(pud))
>  		goto out;
> =20
> -	pmd =3D pmdp_get(pmd_offset(&pud, hva));
> +	pmdp =3D pmd_offset_lockless(pudp, pud, hva);
> +	pmd =3D pmdp_get(pmdp);

[Severity: Critical]
This is a pre-existing issue, but could this cause a host kernel panic if t=
he
VM is backed by 1GB huge pages (PUD level)?

In host_pfn_mapping_level(), there does not appear to be a check to see if =
the
PUD entry is already a leaf before descending to the PMD level.

If KVM walks the host page tables and reaches a PUD leaf entry, it seems it
would pass the PUD leaf directly into pmd_offset_lockless() since there is =
no
check similar to kvm_pte_huge() for the PUD.=20

Because the raw PUD entry still contains flag bits like _PAGE_PRESENT and
_PAGE_HUGE, converting it to a pointer and dereferencing it in pmdp_get() m=
ight
result in an unaligned address dereference, leading to a crash.

Would it make sense to check if the PUD is a huge page and return the mappi=
ng
level early before trying to resolve the PMD?

>  	if (pmd_none(pmd) || !pmd_present(pmd))
>  		goto out;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-dummy_ptxp=
3-v2-0-d9e4bad31e0a@arm.com?part=3D9
