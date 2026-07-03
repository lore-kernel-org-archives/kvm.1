Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F8367285
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066292; cv=none; b=C9MxwGVDSqgWhnuNtufQVAa466pnTm7DhBx5N6JimHC0bZuUapwCHFALfvqpEBxIIJD7k2vkm9Al+Q0klEjmUi+MTmeLejyHkuM/g8qdq7eA7jaN69jYB5hMhs6658iySscW42KN8HHiD93kxaArMCxoyRz5e3U8gRsX0xuLnfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066292; c=relaxed/simple;
	bh=LJxP7pnxl5uWOnWyivBKtVn7Fh8K1NV/AGZr9wlA6sI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fje6fWEdIfoHRt1wE/nyUZ6XkAobl/4HDG+ElH45DzJnf2JTmidgtaejkyRdlfajxTEYTwn+f4cLPCeXYK3E/IayCQjkzQyJibF9ayrA1tuUYF+eGvJmooRPv5cgF6qvbgP9joXhmeyVs2qDyPyqV6eOjRmXX2ZDvVuQWgY9yrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaU4YdvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaU4YdvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6188B1F00A3A;
	Fri,  3 Jul 2026 08:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783066291;
	bh=yYzf4Td4ok0HZYTgY7TVh4W/DneQTj5QoFKbIKX62ik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DaU4YdvHtw5ZXD+hFbuUKLSSACPGjmSrMEZhAMBdfROmuse3QAmzKRmA/ZgKtBuBq
	 XCInKXEbVFSBtgFrgJ8mJLsGkRS9dbaHT8547SBHd2wFKSgy0ILPTm1HT36SFhJXVS
	 /aMx4lJvdC8uLetTIR/6BiDREWIDJChuwbgTQQUjFPbL7q2xSnMeqAJnHBG1rF5tL5
	 Ffd4B2SowEg445YJx8XtAZ/SN6Y0bNpf4R4uJsJq7fGBUAR5elEj+7bdlD9c7KLUjt
	 vRhz1//4klyUP/kkB1Tj/cP0B0Od0/y43wZehD5Sky8CEmzXDgl8Q3znhEAmcLyjtW
	 XGmCRYjzLReng==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/6] selftests/vfio: Exercise sPAPR DDW path for
 hugepage DMA mappings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703032806.40946-5-nnmlinux@linux.ibm.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
 <20260703032806.40946-5-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 08:11:30 +0000
Message-Id: <20260703081131.6188B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest helper `spapr_tce_iova_inside_window` fails to chec=
k for arithmetic overflow when validating whether an IOVA range fits within=
 the window.
--

commit 09ce4770fae5d9e1ed108bb9feb0bc727a9b8bcc
Author: Narayana Murty N <nnmlinux@linux.ibm.com>

selftests/vfio: Exercise sPAPR DDW path for hugepage DMA mappings

Prepare the DMA window before IOVA allocation in the DMA mapping tests.
Anonymous mappings use the default sPAPR DMA window, while HugeTLB mappings
force a DDW with the requested page size. The tests are skipped gracefully
if allocation fails or if the platform lacks support.

> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools=
/testing/selftests/vfio/vfio_dma_mapping_test.c
> index 7d0de8c79de13..4411fdbd56da5 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
[ ... ]
> @@ -236,6 +249,13 @@ FIXTURE_SETUP(vfio_dma_map_limit_test)
> =20
>  	self->iommu =3D iommu_init(variant->iommu_mode);
>  	self->device =3D vfio_pci_device_init(device_bdf, self->iommu);
> +
> +	ret =3D iommu_prepare_dma_window(self->iommu, region_size, region_size,
> +				       false);

[Severity: Medium]
Will this setup cause the test suite to silently pass invalid mappings in t=
he
overflow test?

In tools/testing/selftests/vfio/lib/iommu.c, spapr_tce_iova_inside_window()
checks bounds using:

    if (region->iova + region->size > window->start + window->size)
        return false;

When the vfio_dma_map_limit_test's overflow test constructs a wrapping IOVA
(region->iova =3D ~(iova_t)0 & ~(region->size - 1)), region->iova + region-=
>size
will wrap around to 0.

Since 0 is not greater than window->start + window->size, the check incorre=
ctly
evaluates to false, making the function return true.  Does this missing ove=
rflow
check defeat the wrapper's bounds validation and pass invalid mapping reque=
sts
down to the kernel ioctl?

> +	if (ret)
> +		SKIP(return, "DMA window unavailable: %s (%d)\n",
> +		     strerror(-ret), -ret);
> +
>  	region->vaddr =3D mmap(NULL, self->mmap_size, PROT_READ | PROT_WRITE,
>  			     MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>  	ASSERT_NE(region->vaddr, MAP_FAILED);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703032806.4094=
6-1-nnmlinux@linux.ibm.com?part=3D4
