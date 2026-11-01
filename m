Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793514644;
	b=XelZK2zRxnjxkCzOIg1E2zls+pxV9F6NYmDzUiImT65fiLE+CRXJ1232kOwoQxjv3TC7
	 dd11XB1Nw2h5f0NjWhH0nY5uQwZamP11FAgFfrUxqkSlbVl5C0FLPgkCc1BQzixxSdovP
	 Xf6Zn4EAW1JFH+9PWsfvi8asyZ0J2uiDGhtxGXHwjDCE15k8fHEJ0p9GfimvdhFIDKB7j
	 fy19TK3RU5jYw+Z7jUQ/t9nfnr8UM2UN4DRckrLXHdZ3yvb/W8AhMC6IPrBcUBkxh4ypP
	 e5WImLBDUZ9i22xI1hC3i1y7P5qPz91d8pY0jh65s3ulWc7s8dpV8jT8fpqKsDYWC5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793514644;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8ZAwPeKhptZqDoNtuN654yQH/SKx+resgvJT3ESATdY=;
	b=xVyhR4D6vPMKwMqIWKWMPMPQmULlCSJv2IkR3vmGFjIeP/agyQU9CEdupeNMUHV+ODJf
	 U8oEncFGSrrWVOSyCTughyryCDPHL0DyhOCIry7pJS95mptJsL9CaLAAsOAk5Qj+lHPsv
	 CGa9Q7zo7J1xII3CAHMc0iL3BaSAABEWg+FFB9Ifn6ObE9tmQFsBkti1Ky1obydJntCZe
	 6hSsMSJjIm65tXiyDw+74Cv8/dc84CtIkgP68o/Dsm6eDNKzJLoeI/ypCzVOCw+3dUCal
	 FHuOPiwfxNwSuGe7dGatJEUe12Vqd0sS5qPojn/Exzi4ymrtAy+L7pSqZziDtkzNiJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAy+bQ3V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3D606A327
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAy+bQ3V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBD81F000C1;
	Sun,  1 Nov 2026 06:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793514644;
	bh=8ZAwPeKhptZqDoNtuN654yQH/SKx+resgvJT3ESATdY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=WAy+bQ3VNP4/gE0QXM/Kbfg1OXx4+pQWOKisHEZu/87Bb4Gh6GRco4ovQVUgXgurk
	 uIdgwI04GRMyU0U3Yizt+oJI5gqKZmUKB4tVvFJjZmw2MEbST6loF/TqdMAJfpvPaz
	 7ZPOEuiGhP8eGpkBf8txAkr5n2p6iTYvA/Ge0HJrUF+y0vHWXk+/BCS08Gx2GMk197
	 7+/m/lyWUuxf1anz1FIoiBTQn4NXrEKIX359ncnZuOyMIkrmseOlBtsgtY1P7bgrlQ
	 3jzWy6NRBJosCTpkNn8P8ubFYrxsjfWsBIaMLvkNFw4Ww51+4YHYmg6nBf4Z4yJPYX
	 T7z/zGu3nmfFw==
Message-ID: <sashiko-outbox-192290@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] vfio: selftests: Test BAR write faults after
 clear_refs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mina Almasry" <almasrymina@google.com>, kvm@vger.kernel.org
In-Reply-To: <20261101062049.998160-3-almasrymina@google.com>
References: <20261101062049.998160-1-almasrymina@google.com>
 <20261101062049.998160-3-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 06:30:43 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vfio: selftests: probe pre-faults BAR 0 before clear_soft_dirty_=
refs()
--

commit 43368d01d06eff4702b5d6cf5af459ab154dd5bc
Author: Mina Almasry <almasrymina@google.com>

vfio: selftests: Test BAR write faults after clear_refs

This commit adds a regression test in vfio_pci_device_test to verify that
huge_fault on writable MAP_SHARED VFIO PCI BAR mappings handles both
read-then-write and initial direct write faults after soft-dirty tracking
clears VM_SOFTDIRTY via /proc/self/clear_refs.

> diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/=
testing/selftests/vfio/vfio_pci_device_test.c
> index 93c11fd5e0818..75ccc557efb92 100644
> --- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
> +++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c

[ ... ]

> @@ -102,6 +105,86 @@ TEST_F(vfio_pci_device_test, validate_bars)
>  	}
>  }
> =20
> +static int clear_soft_dirty_refs(void)
> +{
> +	ssize_t ret;
> +	int fd;
> +
> +	fd =3D open("/proc/self/clear_refs", O_WRONLY);
> +	if (fd < 0)
> +		return -errno;
> +
> +	ret =3D write(fd, "4\n", 2);
> +	if (ret < 0)
> +		ret =3D -errno;
> +	else
> +		VFIO_ASSERT_EQ(ret, 2);
> +
> +	VFIO_ASSERT_EQ(close(fd), 0);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +TEST_F(vfio_pci_device_test, bar_write_fault_after_clear_refs)
> +{
> +	const u32 rw_mmap_flags =3D VFIO_REGION_INFO_FLAG_MMAP |
> +				  VFIO_REGION_INFO_FLAG_READ |
> +				  VFIO_REGION_INFO_FLAG_WRITE;
> +	struct vfio_pci_bar *bar;
> +	bool tested =3D false;
> +	int ret, i;
> +	u32 val;
> +
> +	ret =3D clear_soft_dirty_refs();
> +	if (ret =3D=3D -ENOENT || ret =3D=3D -EINVAL)
> +		SKIP(return, "soft-dirty clear_refs unsupported (%d)\n", ret);
> +	ASSERT_EQ(0, ret);
> +
> +	vfio_pci_cmd_set(self->device, PCI_COMMAND_MEMORY);
> +
> +	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> +		void *vaddr;
> +
> +		bar =3D &self->device->bars[i];
> +		if ((bar->info.flags & rw_mmap_flags) !=3D rw_mmap_flags)
> +			continue;
> +
> +		ASSERT_NE(NULL, bar->vaddr);
> +
> +		/*
> +		 * clear_soft_dirty_refs() stripped write permissions from
> +		 * vma->vm_page_prot on the unpopulated BAR mapping created by
> +		 * vfio_pci_device_init(). Fault it read-only first, then write
> +		 * to exercise in-place write-upgrade (wp_huge_pmd/wp_huge_pud).
> +		 */
> +		val =3D READ_ONCE(*(u32 *)bar->vaddr);
> +		WRITE_ONCE(*(u32 *)bar->vaddr, val);

[Severity: Medium]
Is bar->vaddr guaranteed to be unpopulated at this point for BAR 0?

During FIXTURE_SETUP(vfio_pci_device_test), vfio_pci_device_init() maps the
BARs and then calls vfio_pci_driver_probe():

tools/testing/selftests/vfio/lib/vfio_pci_device.c:vfio_pci_device_init() {
	...
	vfio_pci_device_setup(device);
	vfio_pci_driver_probe(device);
	return device;
}

Several selftest drivers read from BAR 0 during probe:

- dsa_probe() -> dsa_int_handle_request_required() reads
  bar0 + IDXD_GENCAP_OFFSET
- ioat_probe() reads device->bars[0].vaddr + IOAT_VER_OFFSET
- nv_falcon_probe() reads bar0 + NV_PMC_BOOT_0

Because those reads happen before clear_soft_dirty_refs() is called,
VM_SOFTDIRTY is still set on the VMA and the fault installs a page table en=
try
that is already writable.

When clear_soft_dirty_refs() subsequently runs, clear_refs_write() updates
vma->vm_page_prot, but clear_refs_test_walk() skips walking page tables for
VM_PFNMAP VMAs:

fs/proc/task_mmu.c:clear_refs_test_walk() {
	...
	if (vma->vm_flags & VM_PFNMAP)
		return 1;
	...
}

As a result, the existing writable page table entry on BAR 0 remains in pla=
ce,
and the READ_ONCE() and WRITE_ONCE() above will not fault or exercise
wp_huge_pmd() / wp_huge_pud() on BAR 0 for those devices.

Should the test replace the VMA with a fresh mmap(MAP_FIXED) and
madvise(MADV_HUGEPAGE) (or zap the BAR mappings) before the first
clear_soft_dirty_refs() call so that the read-then-write sequence always st=
arts
from an unpopulated mapping?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101062049.9981=
60-1-almasrymina@google.com?part=3D2
