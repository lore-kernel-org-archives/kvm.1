Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EDA145355
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484193; cv=none; b=IgnJcxWAzK5rSXOQ3JunGPc6t2H5Nt5L85/4v9htxh+9QjBCfe93aawDtjYtEXA513wGuGGk+PZ9emxMkcpWctaR0nnc8hAP7+G0IRxKGtpvHr9mQBZol0qpN/abZZijNELi19QHxp317CDfb8kmaSUvveKGU7053+w1tU5r4dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484193; c=relaxed/simple;
	bh=Ga/XSqQK6HKy0Dl3aD8LE9+FbyO+uRDFEnE5zVDr73w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfBAl2ZgLBdBagbnKN/K1EVw7wKzzgcNgVpXIC6UQl3iWIUXRVK531dnamfpl5Yjzkj+u2K0vTR7Pi+nwINlXWoiYL9nOU9eN0PpBaXC5j0d3kVgFEHFv4Y15myWvoOM+Vq79L2wCyTktWuTm731BEJW5A3mAJfv20VyTVcJPhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmOeSSkd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmOeSSkd"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b052562254so50155ad.0
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 17:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774484191; x=1775088991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7oCiyyYQVCUAosHdVU4REC/mGXQFa/aTpvPTN8fvIE=;
        b=CmOeSSkdsyvLR9Ic5xcjBd2hPfWBklPD+Lj1aP/G82Iz5E+StJ0Kx50BOSO0Y1SXzo
         t0LKiFRyARa5bpZN1yrMk3xT2W7G2y+6Uumj/ie0dAYnNCJn137X3HESAN7pZZm3glpE
         nmrT9rh4yi6L57mOJWOQgARukLrqubYN1cTUjvf8TMO27IAt6LSHQ1X3W3GO2ezsd788
         SpGITfziOQGAqgTNo4Fnofph9OKjiK3d0NQ6DlCGDanpxq3gGdxPghbvEgJvvGCmPDcH
         WkdNY0P2Kfr5+v1kec1dZ9uv0NK3m9w320CHNKFU1WfqK/jAc8ZpQ9Mxe46p8Wm4OI6r
         2aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774484191; x=1775088991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7oCiyyYQVCUAosHdVU4REC/mGXQFa/aTpvPTN8fvIE=;
        b=sk1obxMdZ6xKYqN6d3vYITJBgJnqPoubpTVY9tkxaKH2benxCxfDHLGOuk1ij0Rm65
         b4mB+L0IiPDucg9JBOefxrz+5B2BwzZ+nhuUVIVBt6KHbo9OO6jw03YXhFK9brxtGjJJ
         HgddG4d0zM/HUiuy8vMPiMLZZITYW9kQXF56rIdcFxyJYT8z6+rCyC5qM3R13Eizw/aW
         KHAhHoLvY+usjqa8wVt/BGKD2zRqCfQ+B0erxsYYsPDgEHIzrk3y1B72ZDJ1vlYmJtTG
         IJmgnv9z03qS06y4pF4fZJzpXnsYS/RDcnERyXZkC+k6BTAYORPZRg4+p2or1ki7MUWS
         XbGA==
X-Forwarded-Encrypted: i=1; AJvYcCWdawrnGhVJ2r+bGT2cGUQPuPGyUuFi96YUSuVd4MesmECpayx2AvEVM6l8MmGaeo7x5tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqf8K0qR+hBz9Jbl7xMSgpsSLPE1bn5X9NyLTG05i15k1oU/Ph
	4XelHUcUUj7L6baERjwcO62pBXMs4oKZcJ8KrkS//Sk1nCG4fALtBVOT+gh3w32k/Q==
X-Gm-Gg: ATEYQzzlgVSxnxtshMyA4JQO346heMyl7zVtTlcuV66oFdFm9oQdkLqsCUa6b2iflvA
	sTjz6EBeGbsoArRTosrOvE4jeZsjMd+o44DPXeYAXaHnKESbJgWWD0GKHgUtTkhOA65zeJ6ctY7
	d+VXmu6Bf9Lw3Lfrir72QK1v+AHDSmkxBq8nwfehIPh8KuSORhJbVlQEw0j1HTR2FJihoBjdWrV
	t1tvxBNqEdAY6XBgMOQZO5rCmkPrumtsmiu88Tb3EohdthE3+ftMFNwIR+byUZwWDGB+7zkJ4ci
	JUJ615LXMgTral2wcLXW+9ridTTjGEhnkyl9TxojgT0cQQ0egKVcO2pYOl5oK1jAZDCS1UMJMyl
	L4htEn85bLLDoiTxLbXK1ZUhzw0FBCeA5e82vOe6iRVTt13NEJor/ZZQyFWPSlfP9Z9RXV2P0Zb
	FKrcrSqIZR33QDVr/H8XcE5EeSH90qYX7a++h3fPoyns0J8I0IJ5QPVRfrOCaNhg==
X-Received: by 2002:a17:902:daca:b0:2ad:ab68:f2c3 with SMTP id d9443c01a7336-2b0c11d9534mr432105ad.13.1774484190023;
        Wed, 25 Mar 2026 17:16:30 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76bc66sm10468195ad.13.2026.03.25.17.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 17:16:29 -0700 (PDT)
Date: Thu, 26 Mar 2026 00:16:25 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 12/14] iommufd: Add APIs to preserve/unpreserve a vfio
 cdev
Message-ID: <acRpb2ADF7cpsllM@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-13-skhawaja@google.com>
 <acREeKQJlSrd2kZS@google.com>
 <acRG3Vi3OGNsVgNR@google.com>
 <acRSQQt_V29S1Ufh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <acRSQQt_V29S1Ufh@google.com>

On Wed, Mar 25, 2026 at 09:23:13PM +0000, Pranjal Shrivastava wrote:
>On Wed, Mar 25, 2026 at 08:41:46PM +0000, Samiullah Khawaja wrote:
>> On Wed, Mar 25, 2026 at 08:24:24PM +0000, Pranjal Shrivastava wrote:
>> > On Tue, Feb 03, 2026 at 10:09:46PM +0000, Samiullah Khawaja wrote:
>> > > Add APIs that can be used to preserve and unpreserve a vfio cdev. Use
>> > > the APIs exported by the IOMMU core to preserve/unpreserve device. Pass
>> > > the LUO preservation token of the attached iommufd into IOMMU preserve
>> > > device API. This establishes the ownership of the device with the
>> > > preserved iommufd.
>> > >
>> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> > > ---
>> > >  drivers/iommu/iommufd/device.c | 69 ++++++++++++++++++++++++++++++++++
>> > >  include/linux/iommufd.h        | 23 ++++++++++++
>> > >  2 files changed, 92 insertions(+)
>> > >
>> > > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>> > > index 4c842368289f..30cb5218093b 100644
>> > > --- a/drivers/iommu/iommufd/device.c
>> > > +++ b/drivers/iommu/iommufd/device.c
>> > > @@ -2,6 +2,7 @@
>> > >  /* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
>> > >   */
>> > >  #include <linux/iommu.h>
>> > > +#include <linux/iommu-lu.h>
>> > >  #include <linux/iommufd.h>
>> > >  #include <linux/pci-ats.h>
>> > >  #include <linux/slab.h>
>> > > @@ -1661,3 +1662,71 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
>> > >  	iommufd_put_object(ucmd->ictx, &idev->obj);
>> > >  	return rc;
>> > >  }
>> > > +
>> > > +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> > > +int iommufd_device_preserve(struct liveupdate_session *s,
>> > > +			    struct iommufd_device *idev,
>> > > +			    u64 *tokenp)
>> > > +{
>> > > +	struct iommufd_group *igroup = idev->igroup;
>> > > +	struct iommufd_hwpt_paging *hwpt_paging;
>> > > +	struct iommufd_hw_pagetable *hwpt;
>> > > +	struct iommufd_attach *attach;
>> > > +	int ret;
>> > > +
>> > > +	mutex_lock(&igroup->lock);
>> > > +	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
>> >
>> > By explicitly looking up IOMMU_NO_PASID, we skip any PASID attachments
>> > the device might have. Since PASID live update is NOT supported in this
>> > series, should we check if the pasid_attach xarray contains anything
>> > other than IOMMU_NO_PASID and return -EOPNOTSUPP?
>> >
>> > Otherwise, we silently fail to preserve those domains without informing
>> > the VMM?
>>
>> VMM should be able to preserve the NO_PASID domains even if it has PASID
>> attachments. This is the intended behaviour, I will document it in the
>> uAPI docs.
>
>I think I'm miscommunicating here. My concern isn't about whether the
>kernel can mechanically preserve the NO_PASID domain when PASID
>attachments exist. I agree that part works fine.
>
>My concern is purely about silent state loss. If a VMM asks the kernel
>to preserve a device, it expects the entire IOMMU state for that device
>to be safely handed over. If the kernel silently skips the PASID
>attachments and returns success (0), the VMM on the new kernel will wake
>up assuming those PASIDs are still perfectly intact. When the guest
>attempts a PASID-tagged DMA, it will unexpectedly fault.

This is a valid concern about silent state loss and I should have been
elaborate in my reply earlier.

My thinking is that PASID preservation should be a granular and opt-in
feature.

- PRESERVE_DEVICE only preserves the IOMMU_NO_PASID attachment.
- A future patch would add mechanism to mark PASID attachment for
   preservation. The VMM would have to call this for each specific PASID
   it wants to preserve.
>
>So the question is: how strictly should the kernel protect userspace
>from this footgun? A few options that I can see:
>
>1. Rely on uAPI docs
>2. Fail the preserve ioctl (-EOPNOTSUPP) if active PASID attachments
>   are detected.
>3. Add an opt-in flag: We could add a flag to the ioctl
>   (IOMMU_LU_FLAG_IGNORE_PASID) so userspace has to explicitly
>   acknowledge the state drop?
>
>Options 2 or 3 are especially important when we consider backwards
>compatibility. If this series is merged in 7.2  with the "silent drop"
>behavior now, when full PASID live update support is eventually added
>in a future kernel, userspace will have no robust way to know if it's
>running on a kernel that preserves PASIDs or silently drops them. By
>returning an error or requiring a flag now, we reserve the right to
>cleanly implement the feature later without breaking the UAPI contract.

I think these are valid points and I will return -EOPNOTSUPP if active
PASID attachments are detected.

I will update this in next revision.
>
>This is an open question from me, I'm okay with any of the 3 options
>I'd like to know what the maintainers think about this as well.
>
>[ ---- >8 ----- ]
>
>Thanks,
>Praan

Thanks,
Sami
