Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7619438332E
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938648; cv=none; b=H03uQ8HPsIhVHNMyYrHNrpfk+xrevZS8E/h+licK4tZEryiYZ4qKSZGFkVamB/CPlXR/kGEkrL1KZ+kocpynnD+quEZZcVuBNHh3dwR5pyKeHU7FwJSdR4PUhLgI5x9m9grXeR8hFn1iHsJwktFZUAWUMDq1POA4VmSCV3M+Lag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938648; c=relaxed/simple;
	bh=oJP+in/i18lJrPOUpqVuxVsQjPEcF8LTmnvJMKYr4nw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gglakdRh7zTT4ik3sbSK8ClwghGuH8uTnOixGLXIG/DFH4O6hqQB8poFBCPCbthLPZEkNETV4FTwz654soWCwSLbSRsiZCTHq+e/BqmBz5VtyihjSJO8trh1mXAYiMuHkXO9f9RzjPR8hVFCHuxMd1plio+e5p1yFbPRvjYbs78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTNVTDOW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTNVTDOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F9A1F00A3A;
	Wed,  1 Jul 2026 20:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782938647;
	bh=SHmZ0HrsGA7YlwwnGI8hj9wvSkqUoHvpQ1l5M5tX960=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fTNVTDOW20zsd14WfVJ222/y8KGLKA0bSnk7jBhpb1UxfAeC2krXu72gvz0vxLd47
	 ratdztxuy0VJq59KUUH3LMVGwndEan4OQ7HjcOkpfDSQpZrQq0P2YG2Be7pfZz1aBX
	 6i1c3WhrtIesxgHSyInsav0skNjpeLMT1lTvhNeJ6Lyv8IpMdBW9oKI/gwIc8SlKOk
	 81L1WwnRXPmWRH2LeN/fgin2i/v7VIsxYmsAsJ80Oltw1pQCy6/6EdSSCrFkSglFDe
	 KpMSFGtetqIqE4pRCVn/iQ1tGkIl84mijdgi1no0TYW/iqc662UQw/SiAXnMMF2XFk
	 0suS3hw+e61mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] vfio: selftests: Introduce
 vfio_dma_mapping_perf_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Lewis" <aaronlewis@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701203311.326798-2-aaronlewis@google.com>
References: <20260701203311.326798-1-aaronlewis@google.com>
 <20260701203311.326798-2-aaronlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:44:06 +0000
Message-Id: <20260701204407.30F9A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Format String Mismatch (Undefined Behavior) for 64-bit `u64` val=
ues.
- [Low] Unused struct `iommu_mapping` definition.
--

commit ed41e119412fd95d65a62de77183ae8dfc8f2449
Author: Aaron Lewis <aaronlewis@google.com>

vfio: selftests: Introduce vfio_dma_mapping_perf_test

Introduce a tool to aid in latency testing rather than a traditional
pass/fail test. Start with a basic test that performs a simple DMA
map/unmap and reports the duration of each operation.

> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/=
tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> new file mode 100644
> index 0000000000000..87d84450fc47e
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0-only
[ ... ]
> +static const char *device_bdf;
> +
> +struct iommu_mapping {
> +	u64 pgd;
> +	u64 p4d;
> +	u64 pud;
> +	u64 pmd;
> +	u64 pte;
> +};

[Severity: Low]
This isn't a bug, but struct iommu_mapping is defined and never used in this
file. Is it needed, or is it left over from earlier iterations?

[ ... ]
> +TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
> +{
> +	const u64 size =3D SZ_1G;
> +	const int flags =3D variant->mmap_flags;
> +	struct dma_region region;
> +	struct timespec start;
> +	u64 unmapped;
> +	int rc;
[ ... ]
> +	timer_start(&start);
> +	iommu_map(self->iommu, &region);
> +	printf("Mapped HVA %p (size %luG) at IOVA 0x%lx in %.2lfms\n",
> +	       region.vaddr, size / SZ_1G, region.iova, timer_elapsed_ms(start)=
);

[Severity: Medium]
Does this printf format string mismatch cause stack misalignment on 32-bit
platforms?

Because size / SZ_1G and region.iova are 64-bit u64 values, using %lu and %=
lx
instead of %llu and %llx can misalign the variadic arguments. On 32-bit
systems, %lu expects a 32-bit value, so printf will misread the 64-bit inte=
ger,
corrupting the subsequent double argument and producing garbage output for
timer_elapsed_ms().

> +	ASSERT_EQ(region.iova, to_iova(self->device, region.vaddr));
> +
> +	timer_start(&start);
> +	rc =3D __iommu_unmap(self->iommu, &region, &unmapped);
> +	printf("Unmapped IOVA 0x%lx in %.2lfms\n", region.iova, timer_elapsed_m=
s(start));

[Severity: Medium]
Similarly here, does region.iova need %llx to avoid stack misalignment issu=
es
with the subsequent double on 32-bit platforms?

> +	ASSERT_EQ(rc, 0);
> +	ASSERT_EQ(unmapped, region.size);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701203311.3267=
98-1-aaronlewis@google.com?part=3D1
