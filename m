Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511939DBD4
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503428; cv=none; b=XpnQIj94JP5lOfZq+7aBcDvvy9d0PszjOp/dWXe6Sr+EsT4ITAvloTyLx0VTlmVIMpAbonVfti+VO0hVzLupWd31ukTqXc2gXGKZJvZVWvMmstIM9sNLbBmae6kqZLGzKDZGZje6kovYry2MKKqzxQykE1SVm5yZFjP90DXLM1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503428; c=relaxed/simple;
	bh=pGfp0+B0fmf+y3aCVu8Js0EjwWzpnP6bZ1YmurxmPc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZLvwrNTmXZ5yeMKTb3uNsx9TT7fEHLQxhQgrU41Qgb1+LtuVyfjpTA4Ixt3Z3FellRaR4kA2pGtOKigdY2ibjDPL822jgxUqwgh2gWVXWqSqcCC4Wk/NRIFX6dWceT4WJ4PxbNSjlm06jmTNDU1ubeIoqAYyY4d5wElIzQMeBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCT++EoO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCT++EoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F201F00893;
	Wed,  3 Jun 2026 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503427;
	bh=dl2GVNYfryqqS0Xv7cnyxzf3LAuVIyA4Dd0ivK9M3+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aCT++EoOa20K7fIgnrLHBSg1saF2b6emxeQniNvA1/ulK6SxzcA/c+hk1GPTHiGln
	 ipTL7RBFrYefVfag+EqY8x5IbmngvR8snpKbkuyATlR3s8t1ofMguSdl0L8GxVyRnZ
	 XLyYjGhowlOnjTSJw2joDFT/bmEbS7tVHgo3dnyx51BQ5AVZL2TPyDRyNgpSBBNGvT
	 IeSPs7WGQjJqMSQMjN9+QwHhMnMcsYL5bwUK5h/XAJGkNIQTH3ybE0CtAr8exclSyH
	 zKxtjY29LMi0C3PJNC/0rXNu9rMBYruuwjKnhRmS/SK+caQvCNbXVunSHhn9arcfKk
	 9ADbtdP4NDbEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 25/32] iommufd/selftest: switch to
 iommu_iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-26-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-26-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:17:06 +0000
Message-Id: <20260603161707.29F201F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition and lockless access in IOMMU_TEST_OP_MD_CHECK_MAP l=
eading to UAF
--

commit bb925df740c15b99ff28ec1c448ae8c5dd87cd5d
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommufd/selftest: switch to iommu_iova_to_phys_length

This commit replaces the direct domain->ops->iova_to_phys() call with
the new iommu_iova_to_phys_length() interface in the iommufd selftest.

> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/sel=
ftest.c
> index af07c642a5260..d4dd399302243 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
[ ... ]
> @@ -1214,7 +1214,7 @@ static int iommufd_test_md_check_pa(struct iommufd_=
ucmd *ucmd,
>  		pfn =3D page_to_pfn(pages[0]);
>  		put_page(pages[0]);
> =20
> -		io_phys =3D mock->domain.ops->iova_to_phys(&mock->domain, iova);
> +		io_phys =3D iommu_iova_to_phys_length(&mock->domain, iova, NULL);

[Severity: High]
This is a pre-existing issue, but does this lockless call to
iommu_iova_to_phys_length() risk a use-after-free?

In iommufd_test_md_check_pa(), the page table walk is initiated on the
mock domain without holding any IOAS read range lock (like iopt->iova_rwsem=
).
Since the mock domain page tables use the generic_pt implementation, its API
contract requires the caller to hold a read range lock that includes the io=
va.

If a concurrent IOMMU_IOAS_UNMAP ioctl frees the intermediate page table
directories while this lockless walk is ongoing, could it lead to a
kernel crash?

>  		if (io_phys !=3D
>  		    pfn * PAGE_SIZE + ((uintptr_t)uptr % PAGE_SIZE)) {
>  			rc =3D -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D25
