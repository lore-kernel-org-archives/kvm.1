Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098669;
	b=XZ5De2jzLLFZnpeISOkZ+zTEXLXUOikLV3TUYFAAST8Yq6RR7yXL07MIciakD7uKTYKD
	 I5gmyFzwovj01/IRP0k3H9Pv6AJ0hDeOUGj3NJKlV77XwrPMMyoanLFHZNAi6oojdPc7Z
	 TpikGPH6z47D7hyIRfkxmDQRdr21EGR4b03WWiTqRNewnUReFNMAn954hpsT0FDmmoVkx
	 AQo8c6tMJo8gVD7h8pAbGy+TnURygyi4i9Q7E8VWwm2dCsYvKh2rFRv26QyJOAXVZnZ7S
	 1leouEaQ9D9juAbeFrAnSaledmOzm9kEGhuLwwOFKixriErZ7EJWsyGDH1ZR/eeoBNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098669;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RN/YpW1d+rLEC4lvf1VLxyyCMB5R+rplHJxVFu1OKqA=;
	b=cbfcamljtnuWTedOjsIi7SoqAXsrUJYklwWhAfnkpUl4CstzYKE1RuC9KdAA0E8hJaxj
	 x3UQ2mmdn7KgTJIMLWr1pZla7NakeN94SX31DnvGARmianT5XolT8sr0E7+B0CSodr9K5
	 AdTDTsRvChc/fxqmeLg2YyJVm5vz4+YjPF00yb/2NW3v0LgSApOttOdIfdGOqq1u7B3c5
	 HC8tileDobeSlODA35FtMSwkIVoB0bb8e0M52+7eh4Z6ip9am5akgjSkeOP1OhMVSWQrY
	 9e3tsf2HgijS4YxdwNUcjC0xa2AU8b0jOI0ygKr/trZcYUgGaXwYPDmtRhRfEg5hBSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMkhsrLB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9215606A335
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMkhsrLB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7491F008A2;
	Sun,  8 Nov 2026 00:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098668;
	bh=RN/YpW1d+rLEC4lvf1VLxyyCMB5R+rplHJxVFu1OKqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iMkhsrLB8o4Trb6iqCaJNGzxbmt6R+q35jP5MuMx0T5I82qb/wgn4D2kHdk5mUQlV
	 HqMWYiXFlfT4J8GVOczPfLs4UvpxCjUY0svkhvkvwl2i9pyVZky739BHNrbrwvfUHp
	 bHEOmc5WbMj/CgjJGCtD9JPN/wNIjuCHKDTEzRlLo4IcowsSpYhqyf20CzW2WZaTiT
	 VNkBSUmMIbR8nrDz9/+1teCxDvA4kPUEkBPnXONk7tkdG7wzawWQd/L2CYc4qRSbMP
	 fqG1AMz8NeNpyRJ+CrzVB8WEdbTnRVG4NeB3pzsrVyB9tWvpWPm49Frc+HEkpcG49F
	 luP18AUN43Eew==
Message-ID: <sashiko-outbox-203474@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 63/88] vfio/pci: Implement check_set_attributes
 provider op for guest_memfd
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-63-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-63-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:27 +0000
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
- [High] vfio/pci: missing BAR checks in
  vfio_pci_core_gmem_check_set_attributes()
- [High] vfio/pci: unguarded linux/kvm_host.h include breaks non-KVM
  arch builds
--

commit 2255a7dd0042c189f9db1a91b5da96def65f3e26
Author: Ackerley Tng <ackerleytng@google.com>

vfio/pci: Implement check_set_attributes provider op for guest_memfd

This commit implements the .gmem_check_set_attributes callback in vfio-pci
to reject private attribute conversions on ranges overlapping the MSI-X
vector table.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 9551a067b5689..894b1332f8a0c 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -16,6 +16,7 @@
>  #include <linux/eventfd.h>
>  #include <linux/file.h>
>  #include <linux/guest_memfd.h>
> +#include <linux/kvm_host.h>
>  #include <linux/interrupt.h>
>  #include <linux/iommu.h>
>  #include <linux/module.h>

[Severity: High]
Does including <linux/kvm_host.h> unconditionally break builds with
CONFIG_VFIO_PCI_CORE on architectures without KVM support (such as 32-bit
arm, sparc, parisc, or m68k)?

include/linux/kvm_host.h pulls in <asm/kvm.h> and <asm/kvm_host.h>, which
only exist on KVM-capable architectures; drivers/vfio/vfio_main.c guards
this include with #if IS_ENABLED(CONFIG_KVM).  (A later patch in this
series, commit "QUESTION: KVM: guest_memfd: Disallow private mappings of
shared-only PFNs", removes this include, but intermediate commits fail to
build on non-KVM architectures.)

> @@ -2769,6 +2770,39 @@ int vfio_pci_core_gmem_get_pfn(struct vfio_device =
*core_vdev, pgoff_t index,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_gmem_get_pfn);
> +
> +int vfio_pci_core_gmem_check_set_attributes(struct vfio_device *core_vde=
v,
> +					    pgoff_t index, size_t nr_pages,
> +					    u64 attributes)
> +{
> +	struct vfio_pci_core_device *vdev =3D
> +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +	pgoff_t bar_pgoff;
> +	size_t size;
> +	loff_t pos;
> +	int bar;
> +
> +	if (!(attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE))
> +		return 0;
> +
> +	/*
> +	 * Prevent private conversion of pages containing the MSI-X vector
> +	 * table. The host kernel directly programs MSI-X table entries to
> +	 * configure and mask interrupts; converting these pages to private
> +	 * would cause host kernel writes to trigger fatal hardware protection
> +	 * faults (e.g. RMP or GPT violations) on confidential compute platform=
s.
> +	 */
> +	bar =3D index >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
> +	bar_pgoff =3D index & ((1ULL << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) -=
 1);
> +	pos =3D (loff_t)bar_pgoff << PAGE_SHIFT;
> +	size =3D nr_pages << PAGE_SHIFT;
> +
> +	if (vfio_pci_range_overlaps_msix(vdev, bar, pos, size))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_gmem_check_set_attributes);
>  #endif

[Severity: High]
Does vfio_pci_core_gmem_check_set_attributes() miss checking that the BAR
is valid and supports mmap, and that [pos, pos + size) fits within
pci_resource_len(vdev->pdev, bar)?

The commit message states that this function verifies that the targeted BAR
is a standard memory BAR and that the range does not exceed the BAR's
physical resource size, as vfio_pci_core_gmem_get_pfn() does:

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_core_gmem_get_pfn() {
    ...
	if (bar >=3D PCI_STD_NUM_BARS || !vdev->bar_mmap_supported[bar])
		return -EINVAL;

	if (pgoff >=3D (pci_resource_len(pdev, bar) >> PAGE_SHIFT))
		return -EINVAL;
    ...
}

Without those checks, non-mmappable regions and offsets past the end of a
BAR can be marked private.  Furthermore, because kvm_gmem_set_attributes()
only bounds the request against the inode size spanning the 40-bit region
offset space and bar is decoded solely from the starting index, a
KVM_SET_MEMORY_ATTRIBUTES2 range starting in an earlier BAR (bar <
vdev->msix_bar) and spanning across the 40-bit boundary into vdev->msix_bar
has bar !=3D vdev->msix_bar in vfio_pci_range_overlaps_msix(), bypassing the
MSI-X overlap check and allowing the MSI-X table pages to be marked private
and later faulted in one page at a time via vfio_pci_core_gmem_get_pfn().
(Commit "QUESTION: KVM: guest_memfd: Disallow private mappings of
shared-only PFNs" later in the series replaces this callback, but these
checks are needed if the check_set_attributes approach is kept or when
bisecting.)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D63
