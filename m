Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE71372662
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066091; cv=none; b=gmz1xYxooBKxnUBEY4K5qzLG0K1kVs8v9I/GHFmUEiEKqCnBBG2t/CgD2/DknuZC1JkScXKZkKVn+D464EeL5IxM2EYptiT0mM4HBrSbtXjY5wfxLkfds6J4w8eExzzRxYOAuyEWnvjz6Vs59r39hE2uWocq2RLYOYA/nBv8DQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066091; c=relaxed/simple;
	bh=vic5Yg5Fo9JM6EKxahhogmANU7zIHmA6bxHjnmTQZvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BjLpWME+2X2if7x/1cXtOflayoyo+40QZTWWYhqEs3Y7fMznm++ozP8vukCSanuFVCbM2/a5YROlWfgqb8fhY37hP+/bzQgPOcniQ670x3oRNyWNz0lLHRPforcn+8ZVyYZzPlwRNx04g0QYqZrrVAcP1DswLumtz5C+vzp67aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUu+ojjf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUu+ojjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348071F000E9;
	Fri,  3 Jul 2026 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783066090;
	bh=3wm49ykTCKSLxTImC7xRHgcWIv2MqzZfP5/Xe3uZf68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dUu+ojjfDe9EnIYguOQ3iFC/QwzZugh+BHhXsEz5PJOyTdynceqzbsvw8C4qYfEIT
	 IQ9w8nYOFGGbFzeN+t764erHOYLbWzB3VhA6PqxZOD1fLukse58r2okTd2PCfmB3FC
	 IxE3k36k/mwCdUcWhzMn5bEY/4JfG8Ppf8A76Nw6yVQsRtg3DPI9mxRcvuEu+7t9ll
	 1jwJbqqBwAaKeYsCbh3Ionu5NDXj9EOkv0etffES42Q5iIwGL+V0xlhATNPRqHUlAq
	 GNkvng5qbKYhVjdKbX0a1WsUeVRUHzNtpm+txxLkp7z0ZVunQ19EPxpUHETkOOdmWa
	 1Og2ZrrGKpAVg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/6] selftests/vfio: Accept sPAPR errno for DMA
 range overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703032806.40946-6-nnmlinux@linux.ibm.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
 <20260703032806.40946-6-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 08:08:09 +0000
Message-Id: <20260703080810.348071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Architecture-specific macro breaks test execution with alternati=
ve IOMMU backends on PowerPC.
- [Medium] The test's expectation of `-ENXIO` codifies and relies upon an i=
nteger overflow bug in the test library's user-space validation helper.
--

commit 93dbee7bb3c363a49eb5141c94b3669c7520cd26
Author: Narayana Murty N <nnmlinux@linux.ibm.com>

selftests/vfio: Accept sPAPR errno for DMA range overflow

The DMA map limit test expects an overflowing IOVA range to fail with
-EOVERFLOW. This commit modifies the test to expect -ENXIO when compiled
for powerpc to account for sPAPR TCE v2 rejecting the range as outside
the active TCE window.

> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools=
/testing/selftests/vfio/vfio_dma_mapping_test.c
> index 4411fdbd56da5..cd2d3276a46c4 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> @@ -316,10 +316,18 @@ TEST_F(vfio_dma_map_limit_test, overflow)
>  	region->size =3D self->mmap_size;
> =20
>  	rc =3D __iommu_map(self->iommu, region);
> +#ifdef __powerpc__
> +	ASSERT_EQ(rc, -ENXIO);

[Severity: Medium]
Will this architecture-specific macro break test execution if an alternative
IOMMU backend is used on PowerPC?

Since earlier patches in this series allow selecting the IOMMU backend via
the VFIO_SELFTESTS_IOMMU_MODE environment variable, running the test on
PowerPC with iommufd would return the generic -EOVERFLOW error. Because of
the #ifdef, the test would erroneously expect -ENXIO and fail.

Would it be better to base this branch on the active backend type (e.g.,
inspecting variant->iommu_mode) rather than the compilation target?

[Severity: Medium]
Does expecting -ENXIO here codify a bug in the user-space validation
helper?

In the overflow test, the region->iova is set to a large value so that
region->iova + region->size wraps around to 0.

Looking at spapr_tce_iova_inside_window() introduced earlier in the series,
it evaluates:

tools/testing/selftests/vfio/lib/iommu.c:spapr_tce_iova_inside_window() {
    ...
    if (region->iova + region->size > window->start + window->size)
        return false;
    ...
}

Due to the wrap-around, 0 > 0 + window->size evaluates to false, causing
the validation helper to return true. This bypasses user-space validation,
allowing the invalid IOVA to be sent to the kernel via VFIO_IOMMU_MAP_DMA,
which then rejects it with -ENXIO.

If the user-space bounds check is fixed to catch wrap-arounds (for example,
checking if region->iova + region->size < region->iova), the helper would
correctly return false and the user-space map attempt would return -EINVAL.

Would that fix cause this test to fail because it now explicitly expects
-ENXIO?

> +#else
>  	ASSERT_EQ(rc, -EOVERFLOW);
> +#endif
> =20
>  	rc =3D __iommu_unmap(self->iommu, region, NULL);
> +#ifdef __powerpc__
> +	ASSERT_EQ(rc, -ENXIO);
> +#else
>  	ASSERT_EQ(rc, -EOVERFLOW);
> +#endif
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703032806.4094=
6-1-nnmlinux@linux.ibm.com?part=3D5
