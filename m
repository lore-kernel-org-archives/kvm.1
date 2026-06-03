Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05294348C69
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500939; cv=none; b=mjdpvCNHgAIWLEqzt053+cAdq9Oh9tAb7b2unZysiLD/Mn4i0q2Ds7Yn86/PrW7z/wnVtR2DqV+73FlKgbNv+GWIQWNG7sM5z3DV5Oi5bJP4d9afyWFLaMsQnePXZSt1ViveU3ZF3jNrA6s1gkM+Z4d53ZX8lmmi4dquWAwiZoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500939; c=relaxed/simple;
	bh=lXHMK6OLnpaFuxHkUPCrzi+3QUx33UiOe16HEeR+ZbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FqOhrFohZLsa/IY0dsWN/KGwxhV0ZwE16kSKsiFK+JL18wVNNV9mgwLuvbdGfz1FYh/Vnq8rQVUHe8wH1tZ0shMra9fhY7g0xq/M9YxDfgL9xK/huUKDC7nQ3ZD5I/VMU+dqtYkM9+lupCR3tIg2ETHgd5R9uauYBRhUlhaAA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6IQxDkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6IQxDkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9971F00893;
	Wed,  3 Jun 2026 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500938;
	bh=kPZBsbdCmm36BRZUw3iS76jiQNOxOjTD1zye0IGFkLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a6IQxDkPxu9ygQzUYfgSmS3jC0jXjcS7n4CxpKX6bHtTVdIvnknVNJUqI4P8dXFN8
	 5DK/ic7pcqvj180SK3plYKQHfU/pEYKmc3gcbD3jBi2wVj4EOKSFxOVzqvlj2HdZtM
	 ZtSMqUkoG1WWJg1eFKSp/PFR61FmMHpau6s+XsW6iWB4hMsp5TRAAvkVjYHE337xDD
	 Nv6TJvUAdg5W7ir8LFG7r/71Q7Y+w/A+nKb9g7qxrXUVZumwINGNLGmTrHtlydIXm9
	 aTJJL/VCDWsvCAoXxtLpWptv+Ie0Euym22APCoOS4hVyo00SFC/kQliTyyqW1isxgq
	 gv5yqoz8zpqRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/32] iommu/io-pgtable-arm: introduce
 iova_to_phys_length in io_pgtable_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-3-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-3-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:35:38 +0000
Message-Id: <20260603153538.7C9971F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] arm_lpae_iova_to_phys_length unconditionally returns the full =
block size instead of the remaining mapped length from the given IOVA.
--

commit c1536d0ff7a2be05195b8dfb8b49fd2e59d5c8f3
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/io-pgtable-arm: introduce iova_to_phys_length in io_pgtable_ops

This commit adds a new iova_to_phys_length callback to struct io_pgtable_ops
and implements it for the ARM LPAE backend to return both the physical addr=
ess
and the length of the mapping. The existing iova_to_phys is updated to wrap
the new callback.

> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-ar=
m.c
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
[ ... ]
> @@ -776,13 +789,18 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_=
pgtable_ops *ops,
[ ... ]
>  	ret =3D __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_=
level);
>  	if (ret)
> -		return 0;
> +		return PHYS_ADDR_MAX;
> +
> +	block_size =3D ARM_LPAE_BLOCK_SIZE(d.lvl, data);
> +	if (mapped_length)
> +		*mapped_length =3D block_size;

[Severity: Critical]
Does this code return the correct length if the iova is not perfectly align=
ed
to the block boundary?

If the provided iova has an offset within the block, unconditionally assign=
ing
the full block_size to *mapped_length might cause callers to overestimate t=
he
contiguous physical memory mapped starting from that specific iova.

The actual remaining contiguous memory in the block from the iova would be
block_size - (iova & (block_size - 1)). Could returning the full block size
cause callers to overrun into unmapped physical memory or memory belonging =
to
other processes?

> =20
> -	iova &=3D (ARM_LPAE_BLOCK_SIZE(d.lvl, data) - 1);
> +	iova &=3D (block_size - 1);
>  	return iopte_to_paddr(d.pte, data) | iova;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D2
