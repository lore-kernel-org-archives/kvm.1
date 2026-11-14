Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662987;
	b=fVII65qapI/oD2JXzXhu1rVmJnpkrcKjdfXtf9lBGsO2fJcSpMe5yqOBAw3XOhS2Wwu7
	 ATnB0QafiZDSu2kApZhzVNqovEXLpsD8EhySfWJlczINkX8XKliy0Qx+nb2m9KeOmek30
	 2Umsv0xIR3PYeuHKDI8T1WIrK2cO9gEEvjZoqj71GRrp1//tpK5gt01GZUTuHnNaBXoBV
	 xP5cYzjdllMDjEjMT/bGS+cAWnJ9eoaxejaa4BiI2uFm6+yabSNgRa/Axx0LZXMfwBcG5
	 bLPqUZ8Q5L1BWjM9IxZQ0X1tRrTR/4Ldq6rSP7zD4IbxXLcdInWPEkwdgUjwLubXGtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aruHNWz43qxTdRIdWcT0acwNFreBxTIuNCiUvIYguos=;
	b=pwLxcMIJ0j/gx6HXruwm7eVumqTufLI+RonuQZDHyF2egINeiiXwN2TshEUNDYV8mngb
	 jzD+hN98atSQ/QWsDtXCQBhT4s4Vgl4kH9dZ6yn6VRhPLZnvulT5gtAKCpLnn4mR5AO4x
	 GjWLJJCZe7NTqn/xTfkT0lXFa4SNkAYpuptthf48vgobCxCFMnrKTOT9anVJ3VfiHduW0
	 j3EvOBXA9A+wx+ZkXyGmy1v7SlvR5n9oijj3di2VzRT9uImNdlmMyg5Lik+PDx63RBh0z
	 BT1dSQLlAQn+4rvIQav5Mo9SkidyZtlsDM23MJZPeB1I3jOb8Nh/whcdhTC1WZxtLeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keRQtnDV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A203606A323
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keRQtnDV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBD21F000C4;
	Sat, 14 Nov 2026 13:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662987;
	bh=aruHNWz43qxTdRIdWcT0acwNFreBxTIuNCiUvIYguos=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=keRQtnDVSTdcIwfGmDr1LK4j0kW1tcZ5yhHJ9HL2wDNgvIccQzUemZJAaRgT3L4vs
	 xyVNTxUx6/4xvnD5r3XEFhMYcQ6LcRw6VYjvchf2AN8+7I/e0fFqAXRxYazAZ6aCch
	 Hjxz+l5mHEvvXbhq65eX4pxOVJauZg+kQVP1BPPmTvBWgrRFM0gcxotOjLt58ivziF
	 rQbPT1ejzFEmgPhuL7gkDl0xFvRniAthSRgxmb2AjGgnesowhV0rWlgdXa2e7S3U0U
	 5JIdpp6/zv2Tkzmkn23iygMcdfHIdjBTyB7htnnx2bYk4JcLhzYWsO2hWNwJH+VzI+
	 ZYZmZvP08GHcA==
Message-ID: <sashiko-outbox-214571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] vfio: selftests: Allow a size for
 vfio_dma_mapping_perf_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Lewis" <aaronlewis@google.com>, kvm@vger.kernel.org
In-Reply-To: <20261114132200.113697-6-aaronlewis@google.com>
References: <20261114132200.113697-1-aaronlewis@google.com>
 <20261114132200.113697-6-aaronlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:29:46 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] vfio: selftests: non-power-of-2 -b size aborts in
  iova_allocator_alloc()
--

commit 7eb32375cc90a8bc43da0741f8174df52036eeb6
Author: Aaron Lewis <aaronlewis@google.com>

vfio: selftests: Allow a size for vfio_dma_mapping_perf_test

This commit adds a '-b' command-line option to vfio_dma_mapping_perf_test to
allow specifying the DMA region size to map and unmap.

> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/=
tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> index 086a63a50df80..6e38cc134a49c 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c

[ ... ]

> @@ -58,11 +136,16 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_perf_test)
> =20
>  TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
>  {
> -	const u64 size =3D SZ_1G;
> +	const u64 page_size =3D variant->page_size ?: getpagesize();
> +	const u64 size =3D test_params.size;
>  	const int flags =3D variant->mmap_flags;
>  	struct dma_region region;
> =20
> -	ksft_print_msg("mmap size =3D %lluG\n", (unsigned long long)(size / SZ_=
1G));
> +	if (!IS_ALIGNED(size, page_size))
> +		SKIP(return, "Size 0x%llx is not aligned to page size 0x%llx",
> +		     (unsigned long long)size, (unsigned long long)page_size);
> +
> +	ksft_print_msg("mmap size =3D %s\n", test_params.size_str);
> =20
>  	TIME("mmap",
>  	     region.vaddr =3D mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -=
1, 0));

[Severity: Low]
Will passing a non-power-of-2 size such as "-b 3G" abort the test inside
iova_allocator_alloc()?

parse_size() accepts any positive multiplier and both dma_map_unmap and
dma_map_unmap_from_file only check IS_ALIGNED(size, page_size), but after
populating the mapping they pass size directly to iova_allocator_alloc(),
which requires a power of two:

tools/testing/selftests/vfio/lib/iova_allocator.c:iova_allocator_alloc() {
	VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
	VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power-of-2\n");
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114132200.1136=
97-1-aaronlewis@google.com?part=3D5
