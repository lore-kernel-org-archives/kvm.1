Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E42F3C3D
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 02:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785724036; cv=none; b=m7hLmAsRyCEpYzjrJ1kRkqUIdsz+gc/FMHS9J9aFyJcPNjzaI1bgYEDoSdQ02AoqQ27I72Rno/f+VfJkWAjbQRCkvB07lXyqQgJr9rsfTCitlHOI6mQrtcwiLm35XalfKdSV2fkVqXxJ81rlPeq0+4c0hcFl/nUHt+dO8letTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785724036; c=relaxed/simple;
	bh=AIGTEahovfWLQaaQy5hTYypcO+jzOkfVyhuAEo4T+UQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JsM22FKHrMLrqTHTSKpioQDjAVAtTMRZvNsckj3yu0tXfJFmiE+tOElSVIW9fQVRbnFfCeETdUOyIrpGzgNxEtPUyxPy1dbx7tHUEGv5KsVweZyYuwIEsJRperaJMEH91azNPKK0+/ACCcD9C3uzvjER124amSTJJkmVvhmzC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sob8EeWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sob8EeWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972861F000E9;
	Mon,  3 Aug 2026 02:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785724034;
	bh=Cjf3EzDV0TulaGupAS8r4j+AzIN6yXNKz5eNe3H/Urk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sob8EeWCFC38xcb2LZMG0IzUpcvGyH397d5+3L1N6gukd85Si8YiNNZDD05lYw1Cr
	 p37261ShJrxAtlGJ3gT52/KDVHGShV6u72iEGlVX/0pAphD0RG32u5FQ8OIwo2h/X0
	 ZX4s5EIzdMMAA+gN5IsApakzgOoiTMNeDBEfM5y8zoV2Hkc1cGt0FIfD6ZnSgQo8W/
	 D2B8tQjkGupSIcPhuXSBVJ1UoF2ytck2BPxv3hQvc5S9harMY2jqWMMtty49I6Rob6
	 LmzF4GL9ypolHo6cNXgsANLs2BJfQSTpEIBjcR+MO3FXfG8jQqeWJS20qt5kyZKmi/
	 736L8ROqe8Ieg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] hisi_acc_vfio_pci: fix VF BAR2 mmap on 64KB page
 size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longfang Liu" <liulongfang@huawei.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260803021857.2370179-3-liulongfang@huawei.com>
References: <20260803021857.2370179-1-liulongfang@huawei.com>
 <20260803021857.2370179-3-liulongfang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 02:27:14 +0000
Message-Id: <20260803022714.972861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Guest memory-mapping of BAR2 allows direct access to sensitive=
 migration control registers, bypassing software isolation.
--

--- Patch [2]: [PATCH 2/2] hisi_acc_vfio_pci: fix VF BAR2 mmap on 64KB page=
 size ---
commit 6249c89b3b40e6c3a5627d170614fe16d3e815bf
Author: Longfang Liu <liulongfang@huawei.com>

hisi_acc_vfio_pci: fix VF BAR2 mmap on 64KB page size

This commit aligns the BAR2 functional region mmap boundaries to PAGE_SIZE.
This is intended to prevent guest mmap operations from being rejected on 64=
KB
page size kernels when the functional region is smaller.

> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfi=
o/pci/hisilicon/hisi_acc_vfio_pci.c
> index 36490be7a61aa..44b3e7d8fef5c 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1355,14 +1355,21 @@ static int hisi_acc_vfio_pci_mmap(struct vfio_dev=
ice *core_vdev,
>  	index =3D vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
>  	if (index =3D=3D VFIO_PCI_BAR2_REGION_INDEX) {
>  		u64 req_len, pgoff, req_start;
> -		resource_size_t end;
> +		resource_size_t end, dev_len;
> =20
> -		end =3D hisi_acc_get_resource_len(vdev, index);
> +		dev_len =3D hisi_acc_get_resource_len(vdev, index);
>  		req_len =3D vma->vm_end - vma->vm_start;
>  		pgoff =3D vma->vm_pgoff &
>  			((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
>  		req_start =3D pgoff << PAGE_SHIFT;
> -
> +		/*
> +		 * The BAR2 functional region (dev_len) may be smaller than the
> +		 * kernel page size. Align it to PAGE_SIZE so a page-rounded
> +		 * guest mmap is not rejected, which would make the VF unusable.
> +		 * The read/write path still truncates at the real functional
> +		 * boundary, keeping the migration registers inaccessible.
> +		 */
> +		end =3D PAGE_ALIGN(dev_len);
> +		if (req_start + req_len > end)
> +			return -EINVAL;

[Severity: Critical]
Does this change allow an untrusted guest or userspace process to bypass
software isolation and gain direct access to migration control registers?

By rounding dev_len up to PAGE_SIZE in hisi_acc_vfio_pci_mmap(), the bounda=
ry
check intended to prevent mapping of the hardware migration registers is
circumvented.

If a guest running on a 64KB page host requests an mmap of the BAR2
functional region, the code rounds dev_len up to PAGE_SIZE. This allows the
request to be validated and passed to vfio_pci_core_mmap(), mapping the
full 64KB physical page into the guest's stage-2 page tables.

If the functional region is 32KB and the migration registers reside in the
upper 32KB of the same physical page, the guest would gain unmediated
read/write access to the migration control registers via direct memory
load/store instructions. This appears to bypass the kernel's read/write
interception and the hisi_acc_pci_rw_access_check() boundary checks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803021857.2370=
179-1-liulongfang@huawei.com?part=3D2
