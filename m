Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C09370D70
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398544; cv=none; b=QRlMpfNsX2rIN5GAotAOqQIcx6pM4rniJKnzvmj/MDontuo2IIOBaGqeAy8j8WFPwOaW3htwfXAjNUUbevXRMbEjO1luHTSAbneaZhnoOvsm7q7mLo736sfCOXC9Q2yp5BL1G5IiRvwFWj+Kf9+iAZwKCB6eHq1Xt6JlPC3qV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398544; c=relaxed/simple;
	bh=Z+Bcxf3ug/ovtHCW5ITrTpBlha+3w8n22mOols0deaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BeeNs5XAWHmvQqAnkh8J2zZP8VHx7QJB+nE1xRGz2GOIzp9L+7KisUDw2A9UhXBscPx6nwyCZp4HGOvmN8AmVqtxxngPOPTF3oeq8bspHy/emvmRSGuWvnkY9E2+JAShTXw4m0YviHSS6RijU1PVA+xm49XH3wN7cz5yovt8QzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy1/QfPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy1/QfPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450AB1F00898;
	Tue,  2 Jun 2026 11:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398543;
	bh=U3coOuwfqTVP+qmnm4h59Nj6W7g/8lXWhkdv59oXWFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yy1/QfPCoyHlqR3Wodj1XhGFL6NXXKSRTQfikSUXsA9N9A0L2LXPXWQStZ1pIUF5O
	 i8vPcLB1xSbmaJg4LNQQpLS9883O6jPqUuwU3711cS8zecpGEmnoLIdNQGoWyjgT0E
	 tH4M4kE+tvfh2vn6Dz6hRN/SM7olUs7h3p5JVZuNZ8fbUmV1ieWX+9AcR6B0CTl8Jh
	 HtpVrvDmaCwsoL7Ng770SRhIdeisrss7P+BU38loCExz4PIQ83gdwmFqjObkP8onpt
	 vy8Fe5M/w0p/jOiPflL8pwHebntnzEb9830ip1Ln0oZowiA5aIQ2A21WjOSRpL2UEy
	 t1OadxPUfnlWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/30] iommu/io-pgtable-arm: introduce
 iova_to_phys_length in io_pgtable_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-3-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-3-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:09:02 +0000
Message-Id: <20260602110903.450AB1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The `PHYS_ADDR_MAX` error sentinel collides with a legitimate 32-b=
it physical address, breaking translations for PA 0xFFFFFFFF.
- [Medium] The documentation for `iova_to_phys_length` contradicts its impl=
ementation and callers' expectations, creating a dangerous API contract mis=
match.

Pre-existing issues:
- [High] If `iova` is `ULONG_MAX`, the page table walk loop silently skips =
execution and returns success, leading to undefined behavior and uninitiali=
zed stack variable usage.
- [High] Time-of-Check to Time-of-Use (TOCTOU) race and potential torn read=
 in lockless page table walk.
--

commit 8479ee64fd320d9e1e651dd5c19fe22d7dbeb287
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/io-pgtable-arm: introduce iova_to_phys_length in io_pgtable_ops

This commit adds iova_to_phys_length to struct io_pgtable_ops and implements
it for the ARM LPAE backend. The new function returns the physical address =
and
the mapped length at the resolved level.

> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-ar=
m.c
> index 476c0e25631af..2b94e0563e214 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -765,8 +765,21 @@ static int visit_iova_to_phys(struct io_pgtable_walk=
_data *walk_data, int lvl,
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but is there a risk of a torn read or
time-of-check to time-of-use (TOCTOU) race in the visitor callback?

While io_pgtable_visit() safely reads the entry via READ_ONCE(*ptep) to
protect against concurrent modification, it passes the raw ptep pointer to
visit_iova_to_phys(). The callback then performs a second unprotected read
via data->pte =3D *ptep.

If a concurrent page table modification occurs, the callback could capture a
new value while io_pgtable_visit() validated the old one. Additionally, sin=
ce
arm_lpae_iopte is 64-bit, reading it without READ_ONCE() on 32-bit ARM might
allow the compiler to emit multiple 32-bit loads, potentially resulting in a
torn read.

> =20
> +static phys_addr_t arm_lpae_iova_to_phys_length(struct io_pgtable_ops *o=
ps,
> +						 unsigned long iova,
> +						 size_t *mapped_length);
> +
> +static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
> +					 unsigned long iova)
> +{
> +	phys_addr_t phys =3D arm_lpae_iova_to_phys_length(ops, iova, NULL);
> +
> +	return (phys =3D=3D PHYS_ADDR_MAX) ? 0 : phys;
> +}

[Severity: High]
Could this return logic incorrectly mask a valid physical address?

On 32-bit platforms where phys_addr_t is 32 bits, PHYS_ADDR_MAX evaluates to
0xFFFFFFFF. If a valid MMIO or RAM region is mapped exactly at the top of t=
he
physical address space, returning 0xFFFFFFFF from
arm_lpae_iova_to_phys_length() would be treated as an error here, and
incorrectly return 0 instead.

> +
> +static phys_addr_t arm_lpae_iova_to_phys_length(struct io_pgtable_ops *o=
ps,
> +						 unsigned long iova,
> +						 size_t *mapped_length)
>  {
>  	struct arm_lpae_io_pgtable *data =3D io_pgtable_ops_to_data(ops);
>  	struct iova_to_phys_data d;
> @@ -776,13 +789,18 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_=
pgtable_ops *ops,
>  		.addr =3D iova,
>  		.end =3D iova + 1,
>  	};

[Severity: High]
This is a pre-existing issue, but what happens to the walk_data.end
calculation if iova is ULONG_MAX?

If iova is exactly ULONG_MAX, walk_data.end =3D iova + 1 will overflow to 0.
During the __arm_lpae_iopte_walk() loop, the condition
(walk_data->addr < walk_data->end) will evaluate to (ULONG_MAX < 0), which
is immediately false.

Because the loop exits without calling the visit_iova_to_phys() callback, t=
he
function would assume success and proceed to calculate the block_size using=
 an
uninitialized d.lvl variable from the stack.

[ ... ]

> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index e19872e37e067..42bcdd309b889 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -203,6 +203,10 @@ struct arm_lpae_io_pgtable_walk_data {
>   * @map_pages:    Map a physically contiguous range of pages of the same=
 size.
>   * @unmap_pages:  Unmap a range of virtually contiguous pages of the sam=
e size.
>   * @iova_to_phys: Translate iova to physical address.
> + * @iova_to_phys_length: Translate iova to physical address and return t=
he
> + *			  remaining mapped length from iova to the end of the
> + *			  mapping entry via @mapped_length. If @mapped_length is
> + *			  NULL, only the physical address is returned.

[Severity: Medium]
Does this documentation accurately describe the implementation?

The comment specifies that mapped_length outputs the remaining mapped length
from the IOVA to the end of the entry. However, the
arm_lpae_iova_to_phys_length() implementation returns the full block size of
the PTE mapping without subtracting the IOVA offset.

Could this mismatch mislead developers implementing future backends?

>   * @pgtable_walk: (optional) Perform a page table walk for a given iova.
>   * @read_and_clear_dirty: Record dirty info per IOVA. If an IOVA is dirt=
y,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D2
