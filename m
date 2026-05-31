Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5CA29BD95
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780221809; cv=none; b=e1SNpGGrdrxaWEpx7hPRbL1X/GchxegQOcjkZ9FKqmt5g+VRq1MVEQExECYyAFXH1dKVjMV483ai7pAzW72laHlP5bmjdF7YVWPo+C/mDzLGAL94qsKvH8nOYOyPuIC90kf/oqbG8IaGEg0XdvlSMUFhEV++ZWjEZ7EAVhycz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780221809; c=relaxed/simple;
	bh=SxYLG9AyO9gIolGqT8VyD2vSIew2DxI+Za3KHvPbaKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MTJ1HPKixsGynlKtRNk4n7ElFtY4vLHx2LxsLt0BJx9dFZdGQfrf4XiLUtyKByfvfGeemQ62JbyvvpFWjDGgwxvXt8yVF5a7s1iPfuqp8di6qXy33dite51P/WnL1o0mCZRmr6sGLuv9J+GKOaBS7M7a5NEJ1VnrPcMOAagtnRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBJbdkpQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBJbdkpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643091F00893;
	Sun, 31 May 2026 10:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780221807;
	bh=UaxytKz0fQa6RwRWjpZMEWEkNTci59USifutx3xas1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oBJbdkpQZaNZyQ6MTGFn9szDbF0T0R8YvXGmA230p6rTrIxqAC7jWCNuWgW9OHsNK
	 1pCvNMEofzxn82fl6L3SSHbETrf18qmjm1totIxXxxIzCAF1RCQN0icSsdP8j+AsIz
	 Ey4Rv9jQWe3jTY2qk+9420MyEczIC7Sn5omkz+xHSYn8eG7Sh0qTEl82Adl02lP2b+
	 sauNiA/+9dyqPA256q3TFzauwfLA6r7cBsZt3t8cTiD5d+lC+GrJtJWzG4ZtNOPCTN
	 6AfnKnVX1AVUiR01bLduLmyaBq5FClZIqOO+GjS4tqZt+fUSN7MNHI1nzirPYyeVwb
	 3MfsgTycSsPdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] iommu/io-pgtable: introduce iova_to_phys_length in
 io_pgtable_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260531093637.3893199-3-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-3-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 10:03:26 +0000
Message-Id: <20260531100327.643091F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The `iova_to_phys_length` implementations return the total blo=
ck/page size instead of the remaining mapped length, violating the API cont=
ract and risking out-of-bounds traversal.

Pre-existing issues:
- [High] Uninitialized stack variable usage in `arm_lpae_iova_to_phys_lengt=
h` when `iova` is `ULONG_MAX`.
- [High] Data race and TOCTOU vulnerability due to unprotected double-readi=
ng of the PTE in the page table walk callback.
--

commit 3219288135ef40cd65a3a4a3c01d71fbe03eb398
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Subject: iommu/io-pgtable: introduce iova_to_phys_length in io_pgtable_ops

This patch adds iova_to_phys_length to struct io_pgtable_ops. The new
callback returns the mapped length from iova to the end of the mapping
entry through the mapped_length parameter, and is implemented for the
ARM LPAE, ARM v7s, and DART backends.

> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtabl=
e-arm-v7s.c
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c

[ ... ]

> @@ -661,6 +673,11 @@ static phys_addr_t arm_v7s_iova_to_phys(struct io_pg=
table_ops *ops,
>  	mask =3D ARM_V7S_LVL_MASK(lvl);
>  	if (arm_v7s_pte_is_cont(pte, lvl))
>  		mask *=3D ARM_V7S_CONT_PAGES;
> +
> +	blk_size =3D ~mask + 1U;
> +	if (mapped_length)
> +		*mapped_length =3D blk_size;

[Severity: Critical]
Does this return the total block size instead of the remaining mapped lengt=
h?

The io_pgtable_ops documentation requires returning the remaining mapped le=
ngth
from the iova to the end of the mapping entry. However, this seems to return
the full block size without subtracting the intra-block offset.

If a caller passes an unaligned iova and uses mapped_length to advance its
traversal iterator, could this cause it to overshoot the current block and
skip subsequent page table regions?

This same pattern appears to be used in the ARM LPAE and DART implementatio=
ns
added in this patch as well.

> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-ar=
m.c
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c

[ ... ]

>  static int visit_iova_to_phys(struct io_pgtable_walk_data *walk_data, in=
t lvl,
>  			      arm_lpae_iopte *ptep, size_t size)
>  {
>  	struct iova_to_phys_data *data =3D walk_data->data;
>  	data->pte =3D *ptep;

[Severity: High]
This isn't a bug introduced by this patch, but could this unprotected read
of *ptep lead to a torn read or a Time-of-Check to Time-of-Use issue?

The caller io_pgtable_visit() safely reads the PTE into a local variable
using READ_ONCE() to validate it, but passes the raw ptep pointer to this
callback.

If the PTE is modified concurrently between the READ_ONCE() in the caller
and the direct dereference here, could we end up with torn reads on 32-bit
ARM systems or return a garbage physical address translation?

>  	data->lvl =3D lvl;
>  	return 0;
>  }

[ ... ]

> +static phys_addr_t arm_lpae_iova_to_phys_length(struct io_pgtable_ops *o=
ps,
> +						 unsigned long iova,
> +						 size_t *mapped_length)
>  {
>  	struct arm_lpae_io_pgtable *data =3D io_pgtable_ops_to_data(ops);
>  	struct iova_to_phys_data d;
>  	struct io_pgtable_walk_data walk_data =3D {
>  		.data =3D &d,
>  		.visit =3D visit_iova_to_phys,
>  		.addr =3D iova,
>  		.end =3D iova + 1,
>  	};

[Severity: High]
This is a pre-existing issue, but can walk_data.end overflow if iova is
ULONG_MAX?

If iova is ULONG_MAX, iova + 1 would wrap around to 0. During the walk in
__arm_lpae_iopte_walk(), the loop condition checks walk_data->addr <
walk_data->end. With end being 0, wouldn't this condition be immediately fa=
lse?

If the walk returns 0 (success) without calling the visit callback, could we
end up using the uninitialized d.lvl and d.pte fields to compute block_size
and the physical address?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531093637.3893=
199-1-guanghuifeng@linux.alibaba.com?part=3D2
