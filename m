Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667D63A5E9F
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459491; cv=none; b=oqoZ1N1rxZRhwIGKRQ/61GDG/NonT65p45jrPD4cgFC3VWXdLBsI0j3WXRBCyumSpP4nb2TVbJ09AFFeX9g+QTl155hM5qrL0LjRClQlRpMDreXJIjdD0RPAi1Hwp5V1qn/XqIYdJfTGZk8zESBxwtH9GmfelZO7LMtWz5KOyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459491; c=relaxed/simple;
	bh=M9C13sMEhKp6VAGCd0Tlwx3P5oizXOctLFDHBySfqTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lkx7TJQJyX9X1DnrwEXuAfUhzLxWc2uAv9jPkkPAKQko22Hr8D2nrxMQTJHMuR1FMXzVtaoGAA3MG/ptON9UuVsswU6aEfHTuChtW9JO85a+EiWV0mEI3NJSQ0dUA6t/vxzw4JxqmtdkejPC1FGHnqtHUledxg6yDqKOI7vWNIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH0w84PO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH0w84PO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D960B1F000FF;
	Tue, 15 Sep 2026 08:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789459490;
	bh=saf/ROKuPaHFIKqukLEd1/mVOz6LPJF7wYw3HVTpqLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jH0w84POwU/loJnyFdTQh21JlCAidadB9cS+ukf+zoKYdeBmRGPTjozKMD4i4gztu
	 RzVr0HzwOZfc7yEdHK/H0p9RaPavexTZGUV8U5GLEcXgIbbbyHK5DbHiBKHZp8k2XZ
	 7ennXDvYgT6TZ5y5blDukdJjMp/RquQRyZDI7sOGVDc2mv/qz1pP+TjmxjyKyc07yB
	 RMwuA863CP1xSXlzC3Ljs+c6/+mMYCvaiOtwh54ri0WoUBv7Yka7HUQC0lkccwwXSL
	 hUsyVA1xO/Ch07KBrQ36SIN4wEx/akbjBYjgbfMVAtKpveaEH4dh4fiS8dodS0wJGu
	 CzsB5pr1DxTKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] iommu/vt-d: Add helpers to set up and tear down TDX
 extensions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lu Baolu" <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260915074235.1219183-5-baolu.lu@linux.intel.com>
References: <20260915074235.1219183-1-baolu.lu@linux.intel.com>
 <20260915074235.1219183-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 08:04:49 +0000
Message-Id: <20260915080449.D960B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] iommu: bounds check uses PAGE_SIZE while allocation uses SZ_4K
--

commit 4edc662d667d9a3f034b902dc510d5238c7c24a5
Author: Lu Baolu <baolu.lu@linux.intel.com>

iommu/vt-d: Add helpers to set up and tear down TDX extensions

This commit implements per-IOMMU TDX Connect bring-up and tear-down helpers.
It allocates and populates the IOMMU_MT parameter layout required by
TDH.IOMMU.SETUP, and handles initialization completion and rollback.

> diff --git a/drivers/iommu/intel/tdxc.c b/drivers/iommu/intel/tdxc.c
> index 559c752a15273..b5dfdeeb23dba 100644
> --- a/drivers/iommu/intel/tdxc.c
> +++ b/drivers/iommu/intel/tdxc.c

[ ... ]

> +static struct tdxc_pages *tdxc_alloc_mt_pages(struct intel_iommu *iommu,
> +					      unsigned int nr_mt_pages)
> +{
> +	unsigned int nr_entries =3D nr_mt_pages + IQ_BUFFERS_NUM;
> +	struct tdxc_pages *array;
> +
> +	if (!nr_mt_pages || nr_mt_pages > (PAGE_SIZE / sizeof(u64) - IQ_BUFFERS=
_NUM))

[Severity: Low]
Does this bounds check use the wrong size macro? It restricts nr_mt_pages
based on PAGE_SIZE, but the corresponding root array allocation below is
hardcoded to SZ_4K. Should this check use SZ_4K to match the allocation siz=
e?

> +		return NULL;
> +
> +	array =3D kzalloc_obj(*array);
> +	if (!array)
> +		return NULL;
> +
> +	array->root =3D iommu_alloc_pages_node_sz(iommu->node, GFP_KERNEL, SZ_4=
K);
> +	if (!array->root)
> +		goto free_array;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915074235.1219=
183-1-baolu.lu@linux.intel.com?part=3D4
