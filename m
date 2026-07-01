Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0B38332E
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938619; cv=none; b=aLpUkK/fRHKXNfLyvyMYDNshApsN59lkJLbkqSQwAKl5dVra9GVFVxutBXB8iA59tn7C/8WU6F+kr7dIshhix/Vr3OFor5nf7DpVpeEHmch+6FJE2rQbAYp7TBf/3MTsj/8wVt8fmXsri2BjRkedjZtnCNR61Jn2yJ/V8/kuCyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938619; c=relaxed/simple;
	bh=flnzMXEUdYeeLUQNzPH9+LmsQDpzt3ePD5amC80Txio=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JsCgLwtz1iIlvSFcWPG1dYKzkp3uUTlkpwGxLQOS0P4mMkEzUYDFpcI4VNwcGnWmsHbT7MMimx1uQdzsmAZ2WPYiw3Yru22DEZ/Da1pggH/UDWNnGy4UGwB0gel3KxL5Q9VC+EZfEqnNYTjf9Zn7DEGhPfLsN7Pa/dwPoBPZ3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKecsOeq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKecsOeq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB561F000E9;
	Wed,  1 Jul 2026 20:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782938618;
	bh=h+dgLf1m0zB/eH8Ha9k1wCFbNFSwFiozL+eCL7MyZ30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RKecsOeqYQHcMVdmXEJ7kdpSW3hz7q5fi0AlikX/Fmg+JH/7pQD6onVQEnj5p6ZQy
	 lBmLqVJyanny6ySae1Y77b1HAAPQfwG5EAhhGt0XN1tJZ9qE22zlUJ1C8RfuTxDnfN
	 eO6XTjTH2dR6df94oNjCNYOsOs4LoxhTXYLYb3Q734RQG99PCOVzdmTNymAGZ5d9Iv
	 TmgepdopWUy3kiaVKSArbRnjUUvtJNdHMxf2JEATvLOPrO3FhrruLDQWjfRo9hitbW
	 /XlRjBrwlzXfyFTpFsbuiITs294AYkOJSh4SiLFmEVWcqCt1RFHjZiDr1mGNdrxElk
	 vIVxPTdMedJvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] vfio: selftests: Add memfd test to
 vfio_dma_mapping_perf_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Lewis" <aaronlewis@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701203311.326798-3-aaronlewis@google.com>
References: <20260701203311.326798-1-aaronlewis@google.com>
 <20260701203311.326798-3-aaronlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:43:36 +0000
Message-Id: <20260701204337.0EB561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Missing SKIP fallback for hugepage allocation failures.
- [Low] MAP_SHARED (an mmap flag) is incorrectly passed to memfd_create() v=
ia memfd_flags.
- [Low] memfd_create() return value is incorrectly validated against <=3D 0=
, which rejects fd 0 and leaks it.
--

commit ffa43469ab562932001b32361e9549a362e44c3c
Author: Aaron Lewis <aaronlewis@google.com>

vfio: selftests: Add memfd test to vfio_dma_mapping_perf_test

Add a second test to "vfio_dma_mapping_perf_test" to evaluate memfd
latencies. A key motivator for adding this test is to demonstrate that
the IOMMU_IOAS_MAP_FILE ioctl is significantly faster than other methods
of mapping DMA regions.

> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/=
tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> index 87d84450fc47e..4639bda7ebaa3 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
[ ... ]
> +#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _mmap_flags, =
_memfd_flags) \
> +FIXTURE_VARIANT_ADD(vfio_dma_mapping_perf_memfd_test, _iommu_mode ## _ #=
# _name) {    \
> +	.iommu_mode =3D #_iommu_mode,						      \
> +	.mmap_flags =3D MAP_SHARED | (_mmap_flags),				      \
> +	.memfd_flags =3D MAP_SHARED | (_memfd_flags),				      \

[Severity: Low]
Does this incorrectly pass the mmap flag MAP_SHARED to memfd_create() via
memfd_flags?

MAP_SHARED (0x01) aliases with MFD_CLOEXEC (0x0001U) in the memfd flag
namespace, which silently sets close-on-exec rather than failing at runtime.
Could conflating the namespaces here cause confusion?

> +}
> +
[ ... ]
> +static void *setup_memfd(int *fd, u64 size, int mmap_flags, int mfd_flag=
s)
> +{
> +	void *buf =3D MAP_FAILED;
> +	struct timespec start;
> +
> +	timer_start(&start);
> +	*fd =3D memfd_create("vfio_dma_mapping_perf_memfd_test", mfd_flags);
> +	printf("Completed memfd_create() in %.2lfms\n", timer_elapsed_ms(start)=
);
> +	if (*fd <=3D 0)
> +		return MAP_FAILED;

[Severity: Low]
Could this leak fd 0 if memfd_create() successfully returns it?

File descriptors can validly be 0 if the test is run with stdin closed.
Would it be better to check if (*fd < 0) instead so it doesn't reject fd 0?

> +
> +	if (ftruncate(*fd, size))
> +		goto out;
[ ... ]
> +TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
> +{
> +	const u64 size =3D SZ_1G;
> +	struct dma_region region;
> +	struct timespec start;
> +	u64 unmapped;
> +	int rc, fd;
> +
> +	region.vaddr =3D setup_memfd(&fd, size, variant->mmap_flags, variant->m=
emfd_flags);
> +	ASSERT_NE(region.vaddr, MAP_FAILED);

[Severity: Medium]
Will this unconditional ASSERT_NE cause the test suite to fail on systems
that do not have sufficient hugepages configured (e.g., for MFD_HUGE_1GB or
MFD_HUGE_2MB) instead of gracefully skipping the unsupported variants?

> +
> +	region.iova =3D iova_allocator_alloc(self->iova_allocator, size);
> +	region.size =3D size;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701203311.3267=
98-1-aaronlewis@google.com?part=3D2
