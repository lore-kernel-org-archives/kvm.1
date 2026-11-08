Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098666;
	b=eb2bX/BOy60I5AQWmUC+bsZ3i4tbkxdjtnZSM8yFXb0iMe0qGQRf0k32Htxume6nYXvv
	 jrbMAYnUoOMbZE48TfWCO809099GG9lry+5HTzVfk/jYFgMxBQDqWAyt9QcoPMAIXKqsm
	 YuSpPCg2RA8AfFj5EGm/lPA+y6sz47YQ1ZAsvvtRdT/4KgkyB7f4f/SOA7lasEPUZjTU1
	 gUnPpkweuKaqIYdGagrzTc9ohgQeFiqX5D9yC2GFM2ECsq3MDDWDm/b+1XtWLHScvlhZe
	 23ZFUhetgKOMcsl3DnBcl5A/+ERfph8sGzqm+I6m/WdWLHQsO7gGk05r+LRFAEQWatA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098666;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NzgKCaaOpO5OPZjM6cxLw3sOwHEdopBIm6vAoyagCf8=;
	b=qKGLjUzaqCLZ3aNKWH4YM1d1yaAKEAvvFkCI5L+hhYYCsorBB9DVEMGg2qIT4QWZXTRi
	 d+vzu09ujPMq34rHqel1SjOKj0cHqeluKoJ2RhgKjVtekH/af2Y7YwK0GcO6dDCkNsz7C
	 ywhsFk5XX/rSxF17dh/RHGejzVEXrqq2nv3Gy/nlh1BM9Ugz76eMz+i/2+/X0QsgFRDjn
	 xvuMR4hmIvKV34VUN2Rr5pnxy54/QVmwX+gs0MZJkeEd000bz1VqyWIUmbJGp7jBsiOHL
	 LU6KolNVHa8Bnpau95xmqP9x+Iij8sqXyx/EW1pyscEJfERa2Kckip5Y3OIdbg1H7/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wde+O0Ho;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3552606A326
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wde+O0Ho
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D355E1F008A1;
	Sun,  8 Nov 2026 00:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098665;
	bh=NzgKCaaOpO5OPZjM6cxLw3sOwHEdopBIm6vAoyagCf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wde+O0HoNWg1ohadgAQE/p+7DRn/85zB1MFyBhSK9d7KpqnNeHXkE4s+xrL5MjcIa
	 6nMWmxKm3/qYazJ/COTxszVi3+McLQIDRt1/3nLMTpXfg/XA8QkBJvdspnRym7df0l
	 8NEvjSRRSGS8SZfcA3u2N+JRV+8OpPPwUZJQZ+ax4VPNV+Wbcc23FlJKzeoJLR7VMU
	 yvlxCx04lFaH7eqSJz5qbCByEArLNGzc8FR4ZpdiMVwNkmzgug0HqSjfAZ9D0RTO6E
	 F98Y+BXh3Yr8GB1oC8SMcNgnWSM4a61HHTkIqNfaSdLsE46YsZ/SPLPuPRSIY41DOb
	 TI2DLjV79/1HA==
Message-ID: <sashiko-outbox-203471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 60/88] vfio/pci: Implement get_pfn provider op
 for guest_memfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alexey Kardashevskiy" <aik@amd.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jianxiong
 Gao" <jxgao@google.com>, "John Starks" <John.Starks@microsoft.com>, "Michael
 Roth" <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Sean Christopherson" <seanjc@google.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Fuad
 Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261106-gmem-alternative-providers-v3-60-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-60-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:23 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] vfio/pci: sub-page mappable BARs rejected in
  vfio_pci_core_gmem_get_pfn()
- [Medium] vfio/pci: missing vfio_pci_core_get_iomap() check in
  vfio_pci_core_gmem_get_pfn()
--

commit 1661618156a57f40eb0f4fe51d0d5dccb4378f2f
Author: Ackerley Tng <ackerleytng@google.com>

vfio/pci: Implement get_pfn provider op for guest_memfd

This commit implements the .gmem_get_pfn callback for vfio-pci to translate
guest_memfd page offsets into physical PCI BAR frame numbers.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index c7b67fbce4cae..9551a067b5689 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2731,6 +2731,44 @@ void vfio_pci_core_gmem_release(struct vfio_device=
 *core_vdev)
>  	up_write(&vdev->memory_lock);
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_gmem_release);
> +
> +int vfio_pci_core_gmem_get_pfn(struct vfio_device *core_vdev, pgoff_t in=
dex,
> +			       unsigned long *pfn, int *max_order,
> +			       u64 *pfn_attrs)
> +{
> +	struct vfio_pci_core_device *vdev =3D
> +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	unsigned int bar;
> +	u64 pgoff;
> +
> +	/*
> +	 * Lockless check: if memory decoding is disabled or the device is in
> +	 * low-power D3, fail immediately without blocking on memory_lock.
> +	 */
> +	if (!smp_load_acquire(&vdev->bars_available))
> +		return -EFAULT;
> +
> +	bar =3D index >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
> +	pgoff =3D index & ((1ULL << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
> +
> +	if (bar >=3D PCI_STD_NUM_BARS || !vdev->bar_mmap_supported[bar])
> +		return -EINVAL;

[Severity: Medium]
Does vfio_pci_core_gmem_get_pfn() also need to check
vfio_pci_core_get_iomap(vdev, bar) before returning the BAR PFN?

vfio_pci_probe_mmaps() sets vdev->bar_mmap_supported[bar] based on resource
flags and alignment alone, while vfio_pci_core_map_bars() allows
pci_request_selected_regions() and pci_iomap() to fail softly by recording =
an
ERR_PTR in vdev->barmap[bar]:

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_core_map_bars() {
	...
		if (pci_request_selected_regions(pdev, 1 << bar, "vfio")) {
			pci_dbg(pdev, "Failed to reserve region %d\n", bar);
			vdev->barmap[bar] =3D IOMEM_ERR_PTR(-EBUSY);
			continue;
		}
	...
}

Unlike vfio_pci_core_mmap() and vfio_pci_core_feature_dma_buf(), which veri=
fy
!IS_ERR(vfio_pci_core_get_iomap()), skipping that check here lets guest_mem=
fd
map physical BAR frames that VFIO failed to reserve (for example, when owned
by another host driver such as efifb).

> +
> +	if (pgoff >=3D (pci_resource_len(pdev, bar) >> PAGE_SHIFT))
> +		return -EINVAL;

[Severity: Medium]
Does shifting pci_resource_len(pdev, bar) without PAGE_ALIGN() reject
page-aligned sub-page BARs?

When a BAR is smaller than PAGE_SIZE (for example, a 4 KiB BAR on a 64 KiB
PAGE_SIZE kernel) and page-aligned, vfio_pci_probe_mmaps() reserves the rest
of the host page with a dummy resource and sets
vdev->bar_mmap_supported[bar] =3D true.  Unlike vfio_pci_core_mmap(), which
computes PAGE_ALIGN(pci_resource_len(pdev, index)),
pci_resource_len(pdev, bar) >> PAGE_SHIFT evaluates to 0 for these BARs and
causes even pgoff =3D=3D 0 to fail with -EINVAL.  Because bar_mmap_supporte=
d[bar]
is true, vfio_pci_core_is_ctrl_plane() also returns false and blocks
read()/write() on a VFIO_DEVICE_BIND_FLAG_CTRL_ONLY descriptor, leaving the
BAR inaccessible.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D60
