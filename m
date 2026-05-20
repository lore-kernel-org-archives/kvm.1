Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCEB263F44
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238018; cv=none; b=dC1cpjEZBVw74iyvvCf4pHdTJu0Yh4CH6Bfzhu96nnVYw9Oz/+LLlsn2+3rrcatdVOeuMcYyXespaKK+4QetRp/5P2QBb6gfPCGQgvghzLDvTi324NYBlFiPyaTWiZwdXBoVIjClC2kcW/iduCUfNi0t9NCs/f4yB9aBAouBzbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238018; c=relaxed/simple;
	bh=rSn0dqt3mh81ujL8Uwk5l1IyplWUfnE5Y1iK/dkMcIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yxd+keLULM3wr47+/y/dr5YOjI7oH2RZ6Or5VhFMbSQCz/nCxxquat41X8R8FO/7ILwv2rZrCR5b6fy53zaV9DXDW4l5YbPr/YnCqh5p4RrKc4339htzqYtmZ/TmkZQHZa8DJZUj0SfKCSfF/ZFipwAWobDN8ReKCsdIP0Yloog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SI/u1cnG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SI/u1cnG"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so535ad.0
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 17:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779238017; x=1779842817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rBBKCEKqhwHVVYRUXd5DICTsn2lEPU8e5GKS7qMzkqc=;
        b=SI/u1cnG3yEsBz5KCDpxtyht7McZTRrKq8FwUU1JW8K+B67h6m1Io4TBnlKEd/lcPi
         LpFhc08MRDmY5ofTh8yU8MsGUbfQ2UgLgmUzFr1PrORV+a7j562FCJ9GQT+xnAkkLdGK
         vU6RDiQXYnD7Km4T0HTNwU4jc4kurfIIH/sYduChgNAgl0FjIueLATInY2Gv/P17ZnfB
         zmNgYwLLdjTBMGCal8XL2mojIl68xOhLIYzWldmz+CX0XZT7TIBEc2PO+l3XLXQVF665
         1u1fJXjh+k2ZbCbG00jw6nLTa2rLGNj3EpPnO2hiK+eog6mPS6SgBkSD3yJs7RBosTnC
         rtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779238017; x=1779842817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBBKCEKqhwHVVYRUXd5DICTsn2lEPU8e5GKS7qMzkqc=;
        b=QqkuKctwW5X3TsFw+6Y2AK3+TftUyjmeF2PIvbhw5yrmuuq7d564rR+tKD1SgZgb18
         QvUiGB1zpacuHfrWb1HZq40FkoupXRId38IvpiPjBMg01SBvoMcpR1Hu7M6kInFrcYBk
         UU6T+hCdv2ikF09bpZpWUXDmDUi922WVMZxL8Q07imylmyJWYFwgkGhOpNaMzbvtPIIG
         yMgkJU9dQDKuQMehAniQbrvmcBi3BMChrCyxMaEHq4IyQor30xu77nUiUK84HSUFMc4g
         l1WYXmsKc3a21ZD65PFdZVGkqs0sAYeiv+Lx1gQzDAMCKxaweQFWsZwAW4g1EsKFZB6z
         ijjw==
X-Forwarded-Encrypted: i=1; AFNElJ+hFJ/XlmleSGWEZ3x266aBZPihENs97xso3gou5GIkLPEWO0aJcMCIl8h9el/gz/Zc89M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqgV9Sf0/EbuRlOGGLS9ZpkyzmPrn8sL5sCJEfpTofDJDBJDGB
	3p3ojdyPbmMONsOfpMrNMYKK+cyk+JEbui5otVOPPZb0XTepbccoxOfihQTOZHvtCQ==
X-Gm-Gg: Acq92OFIrIgLLPTZKQiCOlVho/ogFBXkt+WpugTEX4eyY0hjPRl1LICNFNhll2LGwvb
	snNGf++WEE88S/QwTmyeSxP/TmeD6M1/4vCBADxm6M0pe9sqGS7ZW3UXWGKi+eyM8BdZ5ulHrRG
	WuTq8DxTWoJaYNVd0ATqWSKdlfYXofaXfupwoPCTbDW3igOi8xt4D4deEhQmD/1BAXHqNQHdAi/
	x33F9AU1/GZ1OF5wCe6u7F7KhH/LpNR0w80nVnexTOq5mRdlw7X/7/o0/FLBBg2d1B4RekVHg62
	d6rdRYMNtsFwD8kaDlSZE9CDAqQu8tfZML8t/cs/pjJ2XkiXPw6QUpm9LmkIyWX0c3E7yhX3dTW
	yjqDma5jXZ52nyeuG5KN9mLaDC3EvNVxo2qr45Bnse3oDAEOgSY+V77zOiv4svECnKnbmJ2kzV0
	18VvDKStHMpepnmPt3dpvlFVM/KLP4lcsAhKCvDvAQB3aRODBrsN8nu41xeFXWgqdaD55yv4/rs
	0qC7e0=
X-Received: by 2002:a17:903:1a2d:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2bdb32c212bmr7883845ad.17.1779238016087;
        Tue, 19 May 2026 17:46:56 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f727sm206411835ad.19.2026.05.19.17.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:46:55 -0700 (PDT)
Date: Wed, 20 May 2026 00:46:47 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 14/16] iommufd: Add APIs to preserve/unpreserve a vfio
 cdev
Message-ID: <ag0Ed8E39pSxaYXD@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-15-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-15-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:31PM +0000, Samiullah Khawaja wrote:
> Add APIs that can be used to preserve and unpreserve a vfio cdev. Use
> the APIs exported by the IOMMU core to preserve/unpreserve device.
> 
> The LUO token of the preserved iommufd is fetched and returned back to
> the caller as that can be used during restore to get the restored
> iommufd. Handle to the preserved state of the device is also returned to
> reassociate with the restored state after live update kexec.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/iommufd/device.c          | 102 ++++++++++++++++++++++++
>  drivers/iommu/iommufd/iommufd_private.h |   3 +
>  include/linux/iommufd.h                 |  29 +++++++
>  3 files changed, 134 insertions(+)
> 

The iommufd_device_replace() is ONLY reachable by VFIO which is blocked
by PATCH 15. LGTM.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
