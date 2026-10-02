Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62154772A6
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932448; cv=none; b=Uk5FDJg37UncQWHqR0sxd8YIAKRxrxHx4Q+ZqicgsMeeDvEbuVeHSKDGb0bFuPS3J/QFAuLGAe4FEmKuV1nQFSGFNZvZ+qx39+5gRBfpv3pdoG6KLuEhM68GdRav1tbYrJGHj44UW5ISscKb7PB5iYBiClFBsQeh4rsoGq7uGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932448; c=relaxed/simple;
	bh=QRq23FGkqgMgnrzRjmQN7GH6Khisn2+E/to1W8EIODY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jlBz89MRhyYQxnwadAVTk3SsLJCwwW+SQm21qDB6mXEURZUa0SkSctqvEOcDSLmXaCdK4gldenS/z7TDKV/m74oFgtgYk9AMeE9yvkb9mC2VvhJRURYoxb9mXu68q7Zh4MlKMbGs8JSnoPu3l0TSvBPVHLMCAOh58NOZqOPKHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsSmGAEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsSmGAEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993B61F00899;
	Fri,  2 Oct 2026 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932446;
	bh=aHFsRs62nqYSWB7eHFeeqN6duuRmwZjO5GelOkWuGFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bsSmGAExv3YOeB4HrInOrtoX/DicETbhmbMvvViCln2vKm9D3p7J8WpPj6kpKS7lR
	 nyYguXxoIgGMpxufmK+UdC2Vn0geytVn2DJ2zgj9PxmJGA7xbrsmwzQPAb5lUHTAIL
	 LLssR3KdmGRd/PLvXgX5NWvS4pToHX6CL50Uo6/ONnXJ6aF2kpSNXNGkzdo7G7Mn0t
	 UhMRmrRlD5mGqhYlOVv1OqjmXB9AoJDJZdjYfkiFT3hh8aelOhkrETF46ddC2TSUPn
	 X0+ms7rI9IstFHTEmscKhgyovRNWJvEQQSXrwb5tCVNeL3vI1L7K8Dz8Ccn2y5BNTD
	 3QS3eER+qhxLQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/7] vfio/selftests: Add observability test for IO
 page table usage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001224531.765278-8-praan@google.com>
References: <20261001224531.765278-1-praan@google.com>
 <20261001224531.765278-8-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:06 +0000
Message-Id: <20261002091406.993B61F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests: vfio_nr_pages_test skips IOMMUFD due to zero-initiali=
zed fd assumption
- [Medium] selftests: vfio_nr_pages_test crashes when mapping PROT_NONE mem=
ory
--

commit d7003d8f6957a90f40b858dea08cd7ccf897ea8b
Author: Pranjal Shrivastava <praan@google.com>

vfio/selftests: Add observability test for IO page table usage

This commit adds a new selftest, vfio_nr_pages_test, to validate the
iommu-nr-pages fdinfo metric across IOMMU backends. The test performs
sparse mappings to force deep page table allocation and checks that the
metric increases and remains allocated upon unmapping.

> diff --git a/tools/testing/selftests/vfio/vfio_nr_pages_test.c b/tools/te=
sting/selftests/vfio/vfio_nr_pages_test.c
> new file mode 100644
> index 0000000000000..aef6b1dd8e19d
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_nr_pages_test.c
> @@ -0,0 +1,119 @@

[ ... ]

> +static long read_nr_pages(struct iommu *iommu)
> +{
> +	char path[256];
> +	char line[128];
> +	FILE *f;
> +	long val =3D -1;
> +	int fd =3D iommu->container_fd !=3D -1 ? iommu->container_fd : iommu->i=
ommufd;

[Severity: Medium]
Will this ternary operation erroneously yield 0 instead of the actual
iommufd file descriptor?

In IOMMUFD mode, iommu->container_fd is implicitly initialized to 0 via
calloc_assert() in iommu_init(), while iommu->iommufd is initialized to the
actual file descriptor.

This causes the ternary operator iommu->container_fd !=3D -1 to evaluate to
true, assigning fd =3D 0.

The test then reads from /proc/self/fdinfo/0, fails to find the metric, and
silently skips execution for the IOMMUFD backend.

[ ... ]

> +TEST_F(vfio_nr_pages_test, sparse_mapping_sticky_reclamation)
> +{
> +	long nr_pages_initial, nr_pages_mapped, nr_pages_final;
> +	struct dma_region region1 =3D {0};
> +	struct dma_region region2 =3D {0};
> +
> +	if (!self->iommu || !self->device)
> +		SKIP(return, "Fixture setup failed");
> +
> +	nr_pages_initial =3D read_nr_pages(self->iommu);
> +	if (nr_pages_initial < 0)
> +		SKIP(return, "iommu-nr-pages not reported by this IOMMU");
> +
> +	/* Map a page at start */
> +	region1.size =3D SZ_4K;
> +	region1.vaddr =3D mmap_reserve(region1.size, region1.size, 0);
> +	ASSERT_NE(MAP_FAILED, region1.vaddr);
> +	region1.iova =3D 0x100000;
> +	iommu_map(self->iommu, &region1);

[Severity: Medium]
Does mapping this PROT_NONE region cause the test to crash?

mmap_reserve() provisions memory using mmap() with strictly PROT_NONE
protections. The test immediately passes this region to iommu_map()
without calling mprotect() or over-mapping with PROT_READ | PROT_WRITE.

The kernel will attempt to pin these pages using get_user_pages(), which
will fail with -EFAULT due to lack of read/write permissions.

The iommu_map() wrapper asserts success, causing the test to unconditionally
crash.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001224531.7652=
78-1-praan@google.com?part=3D7
