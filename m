Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD714C97
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501184; cv=none; b=RDoSc8TnugdOr44kfCcZwZ1dGhFVuyS2SHVjwUef+GwS8d9qWy0mAYYJBy+j962Jej6lqv7V2fu4vouNTKxT5rn1vtcHETtr52Mw06vBsop8gVVOQ6pN44bGUgzNXiju4TAM9vlhUonApsPMWuWhMeX/v3JrIq8Qx6ERBeeYLJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501184; c=relaxed/simple;
	bh=qWPgxV+zgkyq1zjzG1kd69R0HSAYtl6YJfNkTycGzX0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nOjkSM2eRWpKt8fTepZ+pu9/FiEIh3cSNkyM5dKe3gERVrK1jWqysx26rxndfgkY0jULsbAR10emSSWcmVnJLJ4oleIfbltmtIKGFEWxt9NO6OY8BoI0lg2Oj6BGn8s47nOgyIJD4bJ6vrCyRfX5C5XO6o6ItClp082I12uvlk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FX4mzFj+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FX4mzFj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB90B1F00893;
	Wed,  3 Jun 2026 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780501183;
	bh=n7w82Ww7bhM2TxMa/d7AZwocWgSt0IdRtx7SUdPwqTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FX4mzFj+wtNgAz1ociKz/79mjdSf/zBg2wqNlgiAiXxgYDzCd6pk3EKX5jRH99BkR
	 bpG38iYzKW/A749g1tp2yzrqZtMNxkO0+nrG9K1Q5t6RlXk21h/xnDNorJ5wUJBzmA
	 Nogcc65LWVGkSFcrIGTXr5VWPJBpMXwc5sZLu1c+99Cm+NZWDoqhHoRFJsiGRZSMxQ
	 SQXPhleMIw5T3mNOwrpk1JbuFdKsaBtaq2VCxw8r7xyMz1mbcBCLSwxyIqspF4FKX8
	 5QXYw2QTuX6+z/CQ6TbNqSCZujSZrncr8insD04akSdoQyt/msdmDwzaYm1d2xWEWZ
	 KwHd/M+OvULFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/32] iommu/generic_pt: implement
 iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-6-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-6-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:39:42 +0000
Message-Id: <20260603153942.DB90B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] iova_to_phys_length overstates mapped_length for unaligned IOVAs, =
causing boundary overshoot.
- [Medium] Unnecessary O(N) page table traversal when mapped_length is not =
requested.
- [Medium] Contiguous physical length accumulation artificially truncates a=
t page table boundaries.
--

commit a86cc79db974a9c9b664e54606ef192f94d2d77f
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/generic_pt: implement iova_to_phys_length
   =20
Extend the Generic Page Table framework to implement iova_to_phys_length.
Use pt_entry_oa_lg2sz() to determine PTE block size. Update
IOMMU_PT_DOMAIN_OPS macro to set .iova_to_phys_length.

> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_=
pt/iommu_pt.h
> index c2752151c80af..914215b467213 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
[ ... ]
> @@ -180,13 +180,21 @@ static inline unsigned int compute_best_pgsize(stru=
ct pt_state *pts,
> +static __always_inline int __do_iova_to_phys_length(struct pt_range *ran=
ge,
> +					       void *arg, unsigned int level,
> +					       struct pt_table_p *table,
> +					       pt_level_fn_t descend_fn)
>  {
[ ... ]
> +	data->phys =3D pt_entry_oa_exact(&pts);
> +	entry_lg2sz =3D pt_entry_oa_lg2sz(&pts);
> +	entry_sz =3D log2_to_int(entry_lg2sz);
> +
> +	/* Start with the full mapping size of the first entry */
> +	data->length =3D entry_sz;

[Severity: High]
Does this calculation overstate the mapped length for unaligned IOVAs?

If the IOVA is not aligned to the PTE block size, pt_entry_oa_exact()
includes the intra-page offset in data->phys. However, data->length
is unconditionally initialized to the full entry_sz rather than
entry_sz - offset. Callers relying on mapped_length might operate
on out-of-bounds memory because data->phys + data->length extends
beyond the valid mapped physical memory by the unaligned offset amount.

> +
> +	/* Accumulate subsequent physically contiguous entries */
> +	expected_oa =3D pt_entry_oa(&pts) + entry_sz;
> +	pts.end_index =3D log2_to_int(pt_num_items_lg2(&pts));
> +	pt_next_entry(&pts);
> +
> +	while (pts.index < pts.end_index) {

[Severity: Medium]
Could this introduce overhead by performing an unnecessary traversal?

When iova_to_phys_length() is called via API paths that do not request
a length (passing NULL for mapped_length), this loop still
unconditionally iterates over all remaining page table entries in the
current block. This adds extra work for lookups that just need the
physical address.

[Severity: Medium]
Is the contiguous physical length accumulation artificially truncated
at page table boundaries?

The function documentation states that callers can determine the full
contiguous mapping extent with a single call. However, this loop
terminates at pts.end_index, which is the end of the current leaf
page table block. It does not ascend or cross into the next page
table block to verify if the mapping remains physically contiguous.

> +		pt_load_entry(&pts);
> +		if (pts.type !=3D PT_ENTRY_OA)
> +			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D5
