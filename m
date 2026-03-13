Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A3C3B892F
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416208; cv=none; b=DeGmaxA6gGs106h4hPOoNK13Bm4aVhxHzq5gWXSKFsETnyoTaqa5I+t5BL+TzylhYbdB2Yis8Uu2jSksC6yrMSnxDZdd9JWB+nZPS+i0xp6jm9qu8Azh6xNyezlSYMxAuLaZ9dmOI7fHu5JSRNzLuMecE5iy+sQoK64FPLMTSE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416208; c=relaxed/simple;
	bh=mVJqAoGCdzDxY6EScXWW6YPCOZawlS/f85uqEYbM+Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U125buNfkScL9s3pDtBp9HKgxlQFWi5W8UvTbTk7/2gk9NFVM9StMWzKc5VRHgLd/FovouF2WoXCmk1eBEnP4TeTUWrapBk1OufkDiQXZbibxKTNBDtjdMTToQrOHaR+ybT+VBsZ6Rl5Fpt+eGAycidUxuDzuPC9DBTAbJWFFJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mrPerPN8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mrPerPN8"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae3f822163so106495ad.0
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773416202; x=1774021002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QnL4RthXjRr5EwbDeuhNCTPnFU8J1byxNF4coj8lpk8=;
        b=mrPerPN8okX5d0ruZqEPfEvotCwy/Ge651w1ElNmrleLuoE4md0XpFeWfT6g2XVq1Y
         q2sj7SkccFHRbfEbNj5Zj9du2fruXEb13SmB9L2+gR+OQTX20P6QtBRkYqXLQWGBKurg
         WbPUT6gG9jRu3tEtqHk4UXo3oELJuXRh5K36kDTsMg+/gC59vEG8RBfFjy6g1L1HwxTa
         PLCINWgd+uQ6FkCjq7sLYF38eeo5iMM95AJrnOXMEIpdV9S1DTRV6AEWFNNpY/pag2AI
         bi8lwZ9quiyum4iG9RG+E7ce1tPoWL8VOgkEJ+lXfgPHf9lShTVlrOgez2l2Jb0z6Scw
         a7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773416202; x=1774021002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnL4RthXjRr5EwbDeuhNCTPnFU8J1byxNF4coj8lpk8=;
        b=qN3joK3dEMrQAUujcTyyOiOjIeuMrV0RF+PiqM4STPutCrNC8a0ZNjdIg8SiP2/xtg
         Robig4a67ftsILsQiYLm5ObepSrbWsus5FKV1EXVVKkKjE+GAu/ekkqK4GlZrEfUAYgd
         Uriv0gxRR2cKPHfVBcFWBY0nCLUbuPww92VI8JiiefH6dvXdJV9cLzV0ZLRfAbe7TViT
         SSXsENsvueKPoyRFxWVzXvA0cNqlASwWaTQUvxJ23EJpVX7secybnHRQEZOjs2yB0ik9
         Z3kmaq3PwAYXkpwtgBFu0JhaaACXbfwd/jn/ktLOc0jVj6bn2mv7vafqMUt+XLsF7S0/
         H9WA==
X-Forwarded-Encrypted: i=1; AJvYcCUeo+/JbxTnbhoBOExUvNIo+p7UFy5NDLFpvKyO/B43lSaeyme9VB7DvjXnOZuyVcXrVKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjVmOe27nLB/AK6X37hiRjZSF2P9ipl+ENqbybE8FeHthNuDiD
	GCgtkBVLaUrNZuhSiii2G4aJLHfOwEEuScXJGgJ7f5lYXRB2O2XrovhBvMZMa/ai/Q==
X-Gm-Gg: ATEYQzyp4ueK5mfg43KU0Jr0yFcNDeH++qwFJZX8UM1X4b0OJD1ftfBIXGGUHgabPu6
	VSQjmkyQ3qLcNh9p7fc7G96RPpPDMi6gACcFBVbq1CorsNKIMJu9MJQVieYjDbdXa6lJu2i/PhK
	riGgNblqy7e62eb6jYDK7XBtr5Caps4QEap4sbzSTLk2907jIgwkjguMIgt4T/GH5tvj+dgX+s+
	c3cxITuEl0Rb9USn65Of429PxvP4grWc55j2TpzS1KnD9HQbz4bHq1eiHtpfd372O7jQkXz/xVS
	xlh1wBbBRaueqnzvKNddyw1Ip7S9UB9e+zXQKsmzyrWq/spv+FluW2wKkyzbwbfdA4p+wM57qWV
	0T5R8pitQv4A9daLFRRdAai5qOoJxs+8Lwl3FGRKE3Gwq3MlQK4Ldg74mUT+gZML0HZEDQbPfAG
	vUWvMSZnoH9+F7WTYYWLMwVhIiiR8NPw3O3fRVItegdJczJZTp0qjAUnPIZ+IqHpe0AeyO
X-Received: by 2002:a17:902:ec82:b0:2ad:6f9b:7818 with SMTP id d9443c01a7336-2aecd67598fmr2482035ad.23.1773416201213;
        Fri, 13 Mar 2026 08:36:41 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb62f0esm2233230a12.17.2026.03.13.08.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:36:40 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:36:33 +0000
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
Subject: Re: [PATCH 01/14] iommu: Implement IOMMU LU FLB callbacks
Message-ID: <abQvAY8Ao4acgmk2@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-2-skhawaja@google.com>
 <abHZdOKyLmmmHADz@google.com>
 <abLi5giBpi05_CLn@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abLi5giBpi05_CLn@google.com>

On Thu, Mar 12, 2026 at 04:43:00PM +0000, Samiullah Khawaja wrote:
> On Wed, Mar 11, 2026 at 09:07:00PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Feb 03, 2026 at 10:09:35PM +0000, Samiullah Khawaja wrote:
> > > Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
> > > alloc/free helper functions to allocate memory for the IOMMU LU FLB
> > > object and the serialization structs for device, domain and iommu.
> > > 
> > > During retrieve, walk through the preserved objs nodes and restore each
> > > folio. Also recreate the FLB obj.
> > > 
> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > > ---
> > >  drivers/iommu/Kconfig         |  11 +++
> > >  drivers/iommu/Makefile        |   1 +
> > >  drivers/iommu/liveupdate.c    | 177 ++++++++++++++++++++++++++++++++++
> > >  include/linux/iommu-lu.h      |  17 ++++
> > >  include/linux/kho/abi/iommu.h | 119 +++++++++++++++++++++++
> > >  5 files changed, 325 insertions(+)
> > >  create mode 100644 drivers/iommu/liveupdate.c
> > >  create mode 100644 include/linux/iommu-lu.h
> > >  create mode 100644 include/linux/kho/abi/iommu.h
> > > 
> > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > index f86262b11416..fdcfbedee5ed 100644
> > > --- a/drivers/iommu/Kconfig
> > > +++ b/drivers/iommu/Kconfig
> > > @@ -11,6 +11,17 @@ config IOMMUFD_DRIVER
> > >  	bool
> > >  	default n
> > > 

[ snip ---- >8 -----]

> > 
> > > +enum iommu_lu_type {
> > > +	IOMMU_INVALID,
> > > +	IOMMU_INTEL,
> > > +};
> > > +
> > > +struct iommu_obj_ser {
> > > +	u32 idx;
> > > +	u32 ref_count;
> > > +	u32 deleted:1;
> > > +	u32 incoming:1;
> > > +} __packed;
> > > +
> > > +struct iommu_domain_ser {
> > > +	struct iommu_obj_ser obj;
> > > +	u64 top_table;
> > > +	u64 top_level;
> > > +	struct iommu_domain *restored_domain;
> > > +} __packed;
> > > +
> > > +struct device_domain_iommu_ser {
> > > +	u32 did;
> > > +	u64 domain_phys;
> > > +	u64 iommu_phys;
> > > +} __packed;
> > > +
> > > +struct device_ser {
> > > +	struct iommu_obj_ser obj;
> > > +	u64 token;
> > > +	u32 devid;
> > > +	u32 pci_domain;
> > > +	struct device_domain_iommu_ser domain_iommu_ser;
> > > +	enum iommu_lu_type type;
> > > +} __packed;
> > > +
> > > +struct iommu_intel_ser {
> > > +	u64 phys_addr;
> > > +	u64 root_table;
> > > +} __packed;
> > > +

One more thing here, let's add the "intel" stuff with the intel patches

Thanks,
Praan

> > > +struct iommu_ser {
> > > +	struct iommu_obj_ser obj;
> > > +	u64 token;
> > > +	enum iommu_lu_type type;
> > > +	union {
> > > +		struct iommu_intel_ser intel;
> > > +	};
> > > +} __packed;
> > > +
> > > +struct iommu_objs_ser {
> > > +	u64 next_objs;
> > > +	u64 nr_objs;
> > > +} __packed;
> > > +
> > > +struct iommus_ser {
> > > +	struct iommu_objs_ser objs;
> > > +	struct iommu_ser iommus[];
> > > +} __packed;
> > > +
> > > +struct iommu_domains_ser {
> > > +	struct iommu_objs_ser objs;
> > > +	struct iommu_domain_ser iommu_domains[];
> > > +} __packed;
> > > +
> > > +struct devices_ser {
> > > +	struct iommu_objs_ser objs;
> > > +	struct device_ser devices[];
> > > +} __packed;
> > > +

Thanks,
Praan
