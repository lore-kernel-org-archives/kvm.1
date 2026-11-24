Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506773;
	b=It6Df0cqEV7FrHT0W0tVsw/wfz8RWjthhrkgtp31BanQCwUaS62t2wmaQBjchPUwgyhm
	 TEej7PQDSA6ReE57z00MwWFUcnyEmcrG5wXKmxrQvlzogMcSa8k8DjE+Ha3Jprfu6ledM
	 jrcxT67hDUL/JsIPAISesjpTz8JvKLcXdh0BeuuGIa93ZMSuJJ0n8Huz+SUEJF4IR4so8
	 dGkDwInk8rVVMGGt1GTW2JI3LwoAIka3vysxib3hpObxzFyQRswP9ht3zaSTYANxaZ5qF
	 36Tk0gnULzY2GQEBPY86sJq18FiEzkbCYfPuzM+DY7qFAPz5N1LaEvMo/QCOYv93NjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506773;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M3/E2iAsr1JkDFrAcF0mgjUv0O+BVkL84W/T+yLbVnM=;
	b=xIk8Ci4xQwhZPGl0b74fdYmhjIdXxXtRHc1yTJyTxREXFvULVT5WDmBH35yTnVKlkJe9
	 msQAKqAb06FhCSfILJF6OY9WH21sgvwC8sO/yI7oXa2MlaCF76WWbNWz9evii92kuqB38
	 KYlOdZs0whhHG2qqGlzSr8U6xw81Gd9sT0SXLE4EnguBSTHsUIIJsdQGYVxcuoJqdGVps
	 ccRp/38K/h+rM8E1EXX1o6tbwL+XGPd5HXX1kFpZX9h+IKWyxY40qrnTODwchtklj8w/5
	 R1FZ3hayl2reMlj0W1em6Yzh/7kMwCbcnqqldrccQhEjujArV+WwHyLyEXPxI/bduaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oi9hK6J8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F2D606A327
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oi9hK6J8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F261F000D2;
	Tue, 24 Nov 2026 07:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795506772;
	bh=M3/E2iAsr1JkDFrAcF0mgjUv0O+BVkL84W/T+yLbVnM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oi9hK6J82lVFkvg3bf+yt2CFGr+EKfvWlZG5yGwsIu2xWU0KlO5uHdTTaTAQkbwdA
	 1YpTjvKFZXwtI3+S0uoQNcVs8XFShrMjliwhU6LE85sQmde52LoPJKhFCQVzcLURcB
	 KZNR7ly5c5jO5YU9TRpKK5SEveHX3wJYNke1sKB8PcO226Rcd0Wzgso3VN2spIwN4i
	 QF+RVmrpqw+3pPpnPUCsc27aFnTFMI9Td0F+KMNk5AgBv4MWXvhRCk9ijyfdCmqZsK
	 BZ/sRE2Ltis9BCMQxZQ5UOLW7UjWKh2BLlbzCGDwROtzy7lu0MA1IEZIjDdX8sqKiA
	 ONu7Rup/f/HSw==
Message-ID: <sashiko-outbox-230684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] vfio/pci: Align BAR mappings for huge page support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261124073048.268988-3-guanghuifeng@linux.alibaba.com>
References: <20261124073048.268988-1-guanghuifeng@linux.alibaba.com>
 <20261124073048.268988-3-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 07:52:51 +0000
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
- [Medium] vfio/pci: wrong align and no PMD fallback in
  vfio_pci_core_get_unmapped_area()
- [Medium] vfio/pci: missing MAP_FIXED check in
  vfio_pci_core_get_unmapped_area()
--

commit 22651b52e2b64249734636f112ebe4aa3bd8ca86
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

vfio/pci: Align BAR mappings for huge page support

This commit implements vfio_pci_core_get_unmapped_area() to align BAR
virtual addresses for PMD and PUD pfnmaps and sets VM_HUGEPAGE on BAR
VMAs.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index f2d5b6857925f..dd437f23b9384 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1878,12 +1878,107 @@ int vfio_pci_core_mmap(struct vfio_device *core_=
vdev, struct vm_area_struct *vma
[ ... ]
> +unsigned long vfio_pci_core_get_unmapped_area(struct vfio_device *core_v=
dev,
> +					      struct file *filp,
> +					      unsigned long addr,
> +					      unsigned long len,
> +					      unsigned long pgoff,
> +					      unsigned long flags)
> +{
> +	struct vfio_pci_core_device *vdev =3D
> +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	unsigned long align, off, off_end, off_align, len_align, addr_align;
> +	unsigned int index;
> +	u64 bar_len;
> +
> +	/* The user asked for a specific address, don't second guess it */
> +	if (addr)
> +		goto out;

[Severity: Medium]
Can this shift a fixed mapping at address 0 to a non-zero address when
flags has MAP_FIXED or MAP_FIXED_NOREPLACE set?

do_mmap() and vrm_set_new_addr() still invoke __get_unmapped_area() when
MAP_FIXED is set.  With addr =3D=3D 0 and MAP_FIXED, mm_get_unmapped_area()
returns 0 immediately, and the shift below changes the returned address to
off & (align - 1).  When (off & (align - 1)) >=3D mmap_min_addr, do_mmap()
with MAP_FIXED will then unmap and overwrite existing VMAs at
[off & (align - 1), (off & (align - 1)) + len) instead of failing on
address 0.

Checking if (addr || (flags & MAP_FIXED)) before aligning avoids mutating
a fixed address.

> +
> +	index =3D pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
> +	if (index >=3D VFIO_PCI_ROM_REGION_INDEX || !vdev->bar_mmap_supported[i=
ndex])
> +		goto out;
> +
> +	bar_len =3D pci_resource_len(pdev, index);
> +	if (!bar_len)
> +		goto out;
> +
> +	/* The BAR size caps the page size we can map it with */
> +	align =3D min_t(unsigned long, PUD_SIZE,
> +		      rounddown_pow_of_two((unsigned long)bar_len));
> +	if (align < PMD_SIZE)
> +		goto out;
> +	if (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP) && align > PMD_SIZE)
> +		align =3D PMD_SIZE;
> +
> +	/* Only an alignment that fits within the mapping length is useful */
> +	while (align > PMD_SIZE && len < align)
> +		align >>=3D 1;
> +	if (align < PMD_SIZE)
> +		goto out;
> +
> +	off =3D pgoff << PAGE_SHIFT;
> +	off_end =3D off + len;
> +	if (off_end < off)
> +		goto out;
> +	off_align =3D round_up(off, align);
> +
> +	/* The mapping has to span at least one fully aligned huge page */
> +	if (off_end <=3D off_align || off_end - off_align < align)
> +		goto out;

[Severity: Medium]
When CONFIG_ARCH_SUPPORTS_PUD_PFNMAP is enabled, doesn't this pick
intermediate power-of-two alignments between PMD_SIZE and PUD_SIZE, and
give up on PMD_SIZE alignment whenever the range does not span a full
block at that larger alignment?

vfio_pci_vmf_insert_pfn() only installs huge mappings at PUD_ORDER and
PMD_ORDER.  For a BAR or mapping length between PMD_SIZE and PUD_SIZE
(for example, a 16 MiB BAR with a 4 KiB MSI-X hole at the start and a
4 KiB PBA hole at the end), align becomes 8 MiB, off_align rounds up to
8 MiB, and off_end - off_align < align jumps to out with PAGE_SIZE
alignment instead of aligning to PMD_SIZE.  Even when off is 0, a BAR
between 4 MiB and 512 MiB reserves up to 512 MiB of extra virtual address
slack when only PMD_SIZE pages can be faulted in.  Also, the second
if (align < PMD_SIZE) check after the while loop cannot be reached because
align >=3D PMD_SIZE before the loop and the loop stops at PMD_SIZE.

Trying PUD_SIZE only when CONFIG_ARCH_SUPPORTS_PUD_PFNMAP is enabled and
the mapping spans a PUD_SIZE-aligned block, and falling back to PMD_SIZE
otherwise, would handle both full and sparse BAR mappings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124073048.2689=
88-1-guanghuifeng@linux.alibaba.com?part=3D2
