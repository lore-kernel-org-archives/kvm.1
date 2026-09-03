Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FC23EB110
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428898; cv=none; b=eRiaYprNyd4eCE95E/7jSss+9gefYeqxi/Pw2SdPshx9uIzAomiMpmGtB2BR7LxDh0jTHOWOCar/YKlMmOW4AGgYlG8ozBWkuMTkCTqxcZStajkVMmUxErh3ePPn23VkSvFsCbSo9/8rNqqPXE0uNAaeqkXsnrmyv3NqMywRHsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428898; c=relaxed/simple;
	bh=yF5mpgCZv1aT/Wo2XI6U3e70uReO9AkCLJKwkcyEHt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=muW9Pxh26JKvT48Mr+vfk9dAs+XXFpUZtfTz5DhwF9PEnjMrWafKehd/WzNltKyRRmX1qLouk66r2bMmvGi5yNP+TcRnqLIoFX1iJbb9w/z+cbDHCGVtj1A7MWPes50xsM/Qhk2BfGcwHUD1DCu6HvH17qg43YZxLfU650lASOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqqzStIn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqqzStIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC02F1F000E9;
	Thu,  3 Sep 2026 09:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788428895;
	bh=/QRA4yCBg4Ri6Hiy70+NkFadn5fJ1SCESNOI6HYDVEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AqqzStInYJWynfPiHFc6gKF3qOVSY6VBoRIkg53bJDkjMiEO/Ok3oleO5wPC+Yes+
	 ADl1TZDgKEqqR6UatSWobeyMgQsXN3ZOXN1DDLLfSvXLW0HNJkpKesv83DqgavywKz
	 4V/3XfcXo3EvBeFIbMk1HLORQuELyEU0NPHIWDRKLnsk9sFypdmcn32cKdjVHKF45n
	 RrCNDHKUqTD7EfT5J8Z/SW4HgahjPsvCsDZSPlbLQYuYyF8aQwL3wW9tYBXVYvYL8I
	 4cgrHvKGBQgMQ1NAe72Swg3y9XD1kRmlrwCFLIIz5CdsNLzFnISZ8tsa5q16sD1Ut1
	 1WgEygXrdPsvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] vfio/platform: prevent read-only region mappings
 from becoming writable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdifatah Suruur" <suruurism@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260903092907.419-1-suruurism@gmail.com>
References: <20260903092907.419-1-suruurism@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 09:48:14 +0000
Message-Id: <20260903094814.EC02F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Modifying VMA flags post-merge inside the .mmap() callback silen=
tly breaks future VMA merges, leading to fragmentation.

Pre-existing issues:
- [High] Incomplete mprotect() hardening allows unauthorized read access to=
 write-only hardware regions.
- [High] Assigning a raw physical frame number (PFN) to `vma->vm_pgoff` for=
 a file-backed VMA corrupts the VMA interval tree.
--

commit 6c3ce3b68057fa0dfd3b9b92fc8493eaac414153
Author: Abdifatah Suruur <suruurism@gmail.com>
Subject: vfio/platform: prevent read-only region mappings from becoming wri=
table

vfio_platform_mmap() rejects writable mappings of regions without the
WRITE flag, but leaves VM_MAYWRITE set. Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect(). This
commit clears VM_MAYWRITE for regions without the WRITE flag.

> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/=
platform/vfio_platform_common.c
> index c72db5a99ebda..20d87c244ca28 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -595,6 +595,10 @@ int vfio_platform_mmap(struct vfio_device *core_vdev=
, struct vm_area_struct *vma
>  			&& (vma->vm_flags & VM_WRITE))
>  		return -EINVAL;
> =20
> +	/* Prevent read-only region mappings from being upgraded with mprotect(=
) */
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
> +		vm_flags_clear(vma, VM_MAYWRITE);

[Severity: High]
This isn't a bug introduced by this patch, but while this hardens the WRITE
path against mprotect upgrades, does it overlook hardening the READ path via
vm_flags_clear(vma, VM_MAYREAD)?

If a user maps a write-only region with PROT_NONE (or PROT_WRITE), they
bypass the initial vma->vm_flags & VM_READ check. Since the region lacks
the READ flag, the user should not be able to read it. However, because
VM_MAYREAD is not cleared, couldn't the user successfully call
mprotect(..., PROT_READ) to upgrade the VMA and read the memory?

Can this allow an attacker to gain unauthorized read access to write-only
hardware registers, which might corrupt hardware state machines, cause CPU
stalls, or trigger fatal bus errors (e.g., SError on ARM)?

[Severity: Medium]
Will modifying VMA flags post-merge inside the driver's mmap callback
silently break future VMA merges and lead to fragmentation?

When userspace mmaps a subsequent adjacent segment of the same region,
mmap_region() attempts to merge it using the proposed VMA flags, which
still contain VM_MAYWRITE by default. Because the existing adjacent VMA
had VM_MAYWRITE cleared by the driver's .mmap callback during its
creation, and VM_MAYWRITE is not in VMA_IGNORE_MERGE_FLAGS, the flags
will mismatch.

Won't is_mergeable_vma() reject the merge, causing VMA fragmentation for
adjacent mappings of the same read-only region?

> =20
>  	vma->vm_private_data =3D vdev;
> =20
>  	if (vdev->regions[index].type & VFIO_PLATFORM_REGION_TYPE_MMIO)
>  		return vfio_platform_mmap_mmio(vdev->regions[index], vma);

[Severity: High]
This is a pre-existing issue, but does assigning a raw physical frame
number (PFN) to vma->vm_pgoff for a file-backed VMA corrupt the VMA
interval tree?

vfio_platform_mmap_mmio() explicitly overwrites vma->vm_pgoff with the PFN
before calling remap_pfn_range():

drivers/vfio/platform/vfio_platform_common.c:vfio_platform_mmap_mmio() {
	...
	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
	vma->vm_pgoff =3D (region.addr >> PAGE_SHIFT) + pgoff;

	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
			       req_len, vma->vm_page_prot);
}

The VMA is inserted into the file's mapping->i_mmap interval tree using
the raw PFN as the index instead of the file offset. Won't any core kernel
mechanism (such as unmap_mapping_range) that searches the interval tree by
file offset fail to find the VMA?

While remap_pfn_range() expects the PFN as an argument, it does not
require overwriting vma->vm_pgoff for non-COW shared mappings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903092907.419-=
1-suruurism@gmail.com?part=3D1
