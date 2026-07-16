Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86D38A718
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216927; cv=none; b=C3Qe68R00sQlJDTOlyFs9NWOVxoAzvngeGyvIALhwn6a3qHc2hybNu39aUq2XUVjf+cjG6dFdn5/1+/MxELdJjmsOyPMXTV8KF9TRJFP0jv0IDdCfItQmgxP3IYfHYhlRX6WWSC+S4BcBFkZf4FlLDP54lklDsVqxEGmSUx+3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216927; c=relaxed/simple;
	bh=IdX5YU87t9ByWIrfaVJywH4RUiisxH5ISyV7gmGM7EE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dDV1PGgyIHn/7U8P0RkaX/22Xdy7THzVGvwJlm68meTnVfkeZ0ghAz607Dr0nwnim0ldDK4y8RKN4VcJ7TDPyhskZsox+ekWhLzK5D3hKYcS1iLCMacX41ksLThRabRlV0XYzwIWsfK8kPG4nK/BIE51vXtHF+m1GVtat/nj5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLmxGVgK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLmxGVgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1101F000E9;
	Thu, 16 Jul 2026 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784216926;
	bh=Hj00xazchf74wznbm8jgr6pdOJxxKzHAZP1EkoqJcLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QLmxGVgKPpWn5JoDq7lf0Y6VZRelEbHm5CKusCYsm/0vuX5YdQhRlymH3k1cEMITC
	 G7b4jlq+1lkedwb/982bPojDtCI3bArmWsbcT3PMGVGpcMdeNk+tiYvS+yOY3Oso7U
	 K6Q7br96HRfov8DN2iToQbXi+RcvPDCJuv9ni48PjLR9co8xinpbPtTzUp1FhhSUOa
	 8LrQpivOlblLVzE58WfxaGI4bYatPw6C+NwtW5Rqh0oUaeaYqZWB+1AmQ9zuDPWosH
	 fWDA/0NpfttzTC06kS5c+JICx57GNDQnsC58Dt8WQZ9R4kqBtqzhRdh0uIWZ128R/Q
	 YOvdqajyvq1kw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 10/11] selftests/kvm: gmem_provider iommufd tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, kvm@vger.kernel.org
In-Reply-To: <6c112e6062cf0cf4478b599fbc7e561a7035a32e.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
 <6c112e6062cf0cf4478b599fbc7e561a7035a32e.1784194290.git.dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:48:45 +0000
Message-Id: <20260716154845.DB1101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] The NVMe DMA test hardcodes the Amazon PCI Vendor ID (0x1d0f), c=
ausing false failures on generic hardware.
- [Medium] Missing compiler memory barrier before ringing the NVMe Submissi=
on Queue doorbell allows dangerous compiler reordering.
- [Medium] gmem_provider_iommufd_test fails to exercise the KVM guest_memfd=
 private memory path because it does not set the KVM_MEMORY_ATTRIBUTE_PRIVA=
TE attribute.
- [Medium] The test claims to confirm a fresh IOMMU_IOAS_MAP_FILE succeeds =
after restoring the page, but does not actually issue the ioctl.
- [Low] Comment incorrectly claims the NVMe completion phase bit is inverte=
d, contradicting the code and the NVMe specification.
--

--- Patch [10]: [RFC PATCH 10/11] selftests/kvm: gmem_provider iommufd test=
s ---
commit 104877080caa9ea2c6214f716d67d2b54448bb37
Author: David Woodhouse <dwmw@amazon.co.uk>
Date:   Thu Jul 16 09:31:30 2026 +0000

    selftests/kvm: gmem_provider iommufd tests
   =20
    Three selftests that exercise the guest_memfd provider ABI from the
    iommufd side, going progressively closer to a real assigned-device
    setup.

> diff --git a/tools/testing/selftests/kvm/x86/gmem_provider_iommufd_test.c=
 b/tools/testing/selftests/kvm/x86/gmem_provider_iommufd_test.c
> new file mode 100644
> index 0000000000000..0b2fc097b5a91
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/gmem_provider_iommufd_test.c

[ ... ]

> +	hva =3D mmap(NULL, DATA_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, gmem_=
fd, 0);
> +	TEST_ASSERT(hva !=3D MAP_FAILED,
> +		    "provider mmap failed errno=3D%d", errno);
> +	r =3D __vm_set_user_memory_region2(vm, DATA_SLOT, KVM_MEM_GUEST_MEMFD,
> +					 DATA_GPA, DATA_SIZE, hva, gmem_fd, 0);
> +	TEST_ASSERT(!r, "KVM_SET_USER_MEMORY_REGION2 failed r=3D%d errno=3D%d",=
 r, errno);
> +	virt_map(vm, DATA_GPA, DATA_GPA, 1);
> +
> +	/*
> +	 * 3) iommufd side: allocate IOAS

[Severity: Medium]
Does main() actually exercise the KVM guest_memfd private memory path?

Because the KVM_MEMORY_ATTRIBUTE_PRIVATE attribute is never set on this
GPA via vm_mem_set_private(), KVM will fault on the shared memory HVA.

Does this completely bypass the KVM guest_memfd logic, with the guest write
reaching the provider fd via the HVA mmap path instead?

[ ... ]

> diff --git a/tools/testing/selftests/kvm/x86/gmem_provider_nvme_dma_test.=
c b/tools/testing/selftests/kvm/x86/gmem_provider_nvme_dma_test.c
> new file mode 100644
> index 0000000000000..8c8a4b2e8ac96
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/gmem_provider_nvme_dma_test.c

[ ... ]

> +	/* Identify Controller SQE at slot 0. */
> +	{
> +		uint32_t *s =3D (uint32_t *)sq_buf;
> +		memset(s, 0, 64);
> +		s[0]  =3D 0x00010006;	/* CID=3D1 << 16 | OPC=3DIdentify */
> +		s[1]  =3D 0;		/* NSID */
> +		/* PRP1 (offset 24 in SQE =3D dword 6) */
> +		s[6]  =3D (uint32_t)IOVA_DST;
> +		s[7]  =3D (uint32_t)(IOVA_DST >> 32);
> +		s[8]  =3D 0;
> +		s[9]  =3D 0;		/* PRP2 */
> +		s[10] =3D 0x01;		/* CDW10: CNS =3D Identify Controller */
> +	}
> +
> +	/* Ring SQ0 tail doorbell. */
> +	wr32(bar, NVME_SQ0TDBL, 1);

[Severity: Medium]
Is there a risk of the compiler reordering the SQE initialization after
the doorbell ring in main()?

Since the SQE is prepared via non-volatile stores and the doorbell is
written via a volatile cast, the C standard permits reordering
non-volatile stores after volatile stores. Could this result in the NVMe
controller processing an incomplete or zeroed command?

Would it be safer to add a compiler barrier before writing the doorbell?

[ ... ]

> +	/* Provider region now holds Identify Controller data.  VID/SSVID at by=
tes 0..3
> +	 * must equal the device's PCI vendor + subsystem vendor (both are Amaz=
on here). */
> +	{
> +		uint16_t vid  =3D ((uint16_t *)provider_hva)[0];
> +		uint16_t ssvid =3D ((uint16_t *)provider_hva)[1];
> +		uint8_t first =3D ((uint8_t *)provider_hva)[0];
> +		uint8_t poison_still =3D ((uint8_t *)provider_hva)[8];
> +		char mn[41] =3D {};
> +		memcpy(mn, (char *)provider_hva + 24, 40);
> +		fprintf(stderr, "MARKER: read done; byte0=3D0x%02x byte8=3D0x%02x\n",
> +			first, poison_still);
> +		fflush(stderr);
> +		pr_info("Identify Controller in provider: VID=3D0x%04x SSVID=3D0x%04x =
MN=3D'%s'\n",
> +			vid, ssvid, mn);
> +		fflush(stdout);
> +		TEST_ASSERT(vid =3D=3D 0x1d0f,
> +			    "unexpected VID 0x%04x in provider region -- Identify DMA landed =
elsewhere?\n"
> +			    "  poison=3D0x%02x byte0=3D0x%02x (poison intact=3DDMA didn't lan=
d here)",
> +			    vid, poison_still, first);

[Severity: Medium]
Does main() hardcode the Amazon PCI Vendor ID here?

If this test is run on a non-Amazon NVMe drive, won't this assertion
cause it to fail on generic hardware?

Should we fetch the PCI Vendor ID from the config space instead of
hardcoding it to 0x1d0f?

[ ... ]

> +		/* Issue a second Identify Controller aimed at the revoked IOVA.
> +		 * Use a new CID and place the SQE in slot 1; the SQ ring will
> +		 * wrap for larger runs but we only ever use slots 0 and 1.
> +		 */
> +		memset(&s[16], 0, 64);
> +		s[16] =3D 0x00020006;			/* CID=3D2 << 16 | OPC=3DIdentify */
> +		s[16 + 6] =3D (uint32_t)IOVA_DST;
> +		s[16 + 7] =3D (uint32_t)(IOVA_DST >> 32);
> +		s[16 + 10] =3D 0x01;			/* CNS =3D Identify Controller */
> +
> +		wr32(bar, NVME_SQ0TDBL, 2);

[Severity: Medium]
Similar to the first command submission in main(), does this need a
compiler barrier before the doorbell ring to prevent the compiler from
sinking the SQE initialization?

> +		pr_info("Identify Controller (revoked target) submitted (SQ0 tail=3D2)=
\n");
> +
> +		/* Poll for CQE at slot 1 with phase bit inverted from first pass. */
> +		for (i =3D 0; i < 5000; i++) {
> +			if ((c[4 + 3] & 0x10000))	/* CQE 1 P bit */

[Severity: Low]
Is this comment accurate?

Since this is only the second command in a 64-entry queue, the controller
is still on its first pass. The phase bit remains 1 and does not invert,
which matches the code's correct check for a 1 bit.

[ ... ]

> +		/* Restore and confirm a fresh IOMMU_IOAS_MAP_FILE succeeds. */
> +		rev.present =3D 1;
> +		ret =3D ioctl(gmem_fd, GMEM_PROVIDER_SET_PRESENT, &rev);
> +		TEST_ASSERT(ret =3D=3D 0, "SET_PRESENT(restore) errno=3D%d", errno);
> +		pr_info("Restore + revoke round trip complete\n");
> +	}

[Severity: Medium]
The comment in main() mentions confirming a fresh IOMMU_IOAS_MAP_FILE
succeeds, but does the test actually attempt to issue this ioctl after
restoring the page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f09647f427565c1789a=
6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk?part=3D10
