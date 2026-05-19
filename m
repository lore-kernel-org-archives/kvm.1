Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE23BCD21
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196519; cv=none; b=ss1n9JpjBRyvC9vKyfLVp7LTlpqtdw2HCB0q4NW0L7DJOOrO9V08iZ20rifxnMToeL8Y1C6lavo9Cueim96yTL4iy8IttMZQjAmOgxu5pcupGN9WPque0hduVRvb/1H/3y2Ol3h5fF/aoWjP8LAwvrIjqcN8BYOMofvJLI76yP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196519; c=relaxed/simple;
	bh=JDx2jF0ZO5E36Lw+1qDQU4xmk3oFKLnmUzLtiIUdQIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7+UrxHY6djxnieRMCs8JBLbdifCSSKTnkCUwhMe38tn/HLWmydKQ2rDvoiq4G4iOCAvSCOTEUYdWblOC558X7KGwLMFXrR7KKGCoWcgpbhrbP032kQdEBL4JKFcWVTxpUG+thtndNQyS6aXsn/TpXugf1FPOlGW4dEC/U7ZfSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDgA5FbH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDgA5FbH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so875ad.0
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779196518; x=1779801318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fBCxwoiS3sf2RQXUwxoqVP717F35PJZZr1FHXrdR8c=;
        b=RDgA5FbHSfzT26XoBO61B2jEUjzzmHh6YTh9KSgKb8MmTH5fNZ35J0iEQDpY4GH+vz
         Uq/NQtELN7KC0SvAcjl/oaFCjmCnPhoGujsrdko87pMtIlknbIMerfecwGrVFDsoz6LU
         WNv/xWvWvCZiCBJ02VIiyAB5Br3qCrm1Lv+fM9Mi/3qSTDCoOcnlkKEYDcaeTbNEB+f4
         IAQFDLmkzXMao2U1s1F3k46mPyZRw8pVWXiqkzRXPuH66HzJu5Eo1wMrYfDFfLoqshz8
         zclwgYG+KHO9ogdqYssFsH4boYgn3hHuTE1S/THgxjOrchZST3LvWt75WT2JXiuGgCNu
         Qm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196518; x=1779801318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fBCxwoiS3sf2RQXUwxoqVP717F35PJZZr1FHXrdR8c=;
        b=Cn7IMIYptRsv/j5nLaWLCAKoFYmDbU0rZB+28THLJ4pWeevyb7qI0R0h8oEcFwH2ca
         mODJpUchRJ8L90GYgYIjr0EXvy3qe50lH+xrHXzX2STCaEyB+g6JhO2QWIRpL2ac36Sp
         fwKupyitlJk6g02RZ77ZZQC0EPiyEcgB5J5jCBT3e51njc4P1RPiVn0HstiNecNZqhqi
         3/HR5+u/yUBSFgFO7doVgVr5WgXX3AvoMx16VqVdg8WwFCd7Z1Fz4XozMrhMv+foYiBl
         itLFYQxYyr1pJ+PV2+OUd6SdXvoylZWTXBSE/Jd0KbYv3XrnN1Zv2jVDoO225aLALwS+
         wrNg==
X-Forwarded-Encrypted: i=1; AFNElJ9z2uwczb9jHI6inj4LQx8pVF1WN+BVLIIAzOuAzneICMITILREjEnnWxnnUOAsd2aypBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0XUBCezXXmOtEAUc+gMvotulS4kowVyvgkEGKGHN2tAtEpFH
	2X3/vV9meN21tWuLVxPXnpkFx9HvzhzxDSVCAJXudMaP/T2NlwKS90MXeGLW/ueFiw==
X-Gm-Gg: Acq92OFVdNl/wOg3E4UdF7yQ/P9CGRTv5bqntfLYBj98ViHyANsp7MQAGUm/0nge7zF
	bksygclJxk125DK7WUH819cuUVjal/xrkETs55wZ7HDVqHj7vQ5RjC8Fxn9JRY09G8mQOGUtCF8
	som4e8MkztPcrKiq0CQZsfGDVYLBjrO+nbz+pvpAG+5p93mf+7kf6dkY78Bj6wGVe0YtaqHI81H
	92tpCB6ue6pQeKijewiuo3yfpyELPcKT2R5pIQvB7U6LuJCrkLEbBZhEwyxz7g5/7THND07DTzQ
	lyoOagrQlM8786bgMUzIKREUDB2MkkMRiPPu7X4Po+5+wBc9jxVz9wJjsA8btEPzmOET23yZDUD
	0NLd42znvi2fnl+QZe2KPiMCslkQ32t8aKduV/Ow0r1ujTrZW4tytKr4L4F81B822HZTbur56G6
	y9h3/4u3tc6RZ1GekZeIn1eemRF0f/8zDbohNSQCrD5kkZb8i9UNaHleB2BCfp4xNpxBU+
X-Received: by 2002:a17:903:1a2d:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2bdb32c212bmr5844565ad.17.1779196516969;
        Tue, 19 May 2026 06:15:16 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7ccc7sm21316591b3a.58.2026.05.19.06.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:15:16 -0700 (PDT)
Date: Tue, 19 May 2026 13:15:08 +0000
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
Subject: Re: [PATCH v2 06/16] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <agxiXNalisHyNkGt@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-7-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-7-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:23PM +0000, Samiullah Khawaja wrote:
> Implement the iommu domain ops for presevation, unpresevation and
> restoration of iommu domains for liveupdate. Use the existing page
> walker to preserve the ioptdesc of the top_table and the lower tables.
> 
> Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
> the next kernel. On restore the domain has only the preserved features
> enabled and all the other features are zeroed. This is ok since the
> restored domain is made immutable and can only be freed. A kunit test is
> added to verify that the IOMMU domain free can be done with trimmed
> features.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h       | 131 ++++++++++++++++++++++
>  drivers/iommu/generic_pt/kunit_iommu_pt.h |  28 +++++
>  include/linux/generic_pt/iommu.h          |  19 +++-
>  3 files changed, 177 insertions(+), 1 deletion(-)
> 

[...]

> +static const struct pt_iommu_ops NS(ops_immutable);
> +
> +/**
> + * restore() - Restore page tables and other state of a domain.
> + * @domain: Domain to preserve
> + *
> + * Returns: -ERRNO on failure, 0 on success.
> + */
> +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
> +{
> +	struct pt_iommu *iommu_table =
> +		container_of(domain, struct pt_iommu, domain);
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range;
> +
> +	common->max_vasz_lg2 = ser->vasz;
> +
> +	/* Make this domain immutable.*/
> +	iommu_table->ops = &NS(ops_immutable);
> +

Nit: Let's consider adding a comment since we just have .deinit in ops:

/*
 * Restored page tables are strictly transient and only permitted to be
 * destroyed via .deinit. Because we only preserve user-assigned devices
 * utilizing pass-through frameworks (VFIO / IOMMUFD), any concurrent or
 * subsequent map/unmap operations on a restored domain are explicitly
 * blocked at the subsystem boundary (e.g., via IOAS immutability seals).
 */

This makes it explicitly clear that any nullptr dererfs occuring due to
immutable_ops->map_range etc. (in the future) are considered as bugs.

> +	/*
> +	 * It is safe to override this here since this domain is immutable and
> +	 * can only be freed.
> +	 */
> +	common->features = 0;
> +	if (ser->sign_extend)
> +		common->features |= BIT(PT_FEAT_SIGN_EXTEND);
> +
> +	range = pt_all_range(common);
> +	iommu_restore_page(ser->top_table_phys);
> +
> +	/* Free new table */
> +	iommu_free_pages(range.top_table);
> +
> +	/* Set the restored top table */
> +	pt_top_set(common, phys_to_virt(ser->top_table_phys), ser->top_level);
> +
> +	/* Restore all pages*/
> +	range = pt_all_range(common);
> +	return pt_walk_range(&range, __restore_tables, NULL);
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(restore), "GENERIC_PT_IOMMU");
> +#endif
> +
>  struct pt_unmap_args {
>  	struct iommu_pages_list free_list;
>  	pt_vaddr_t unmapped;
> @@ -1138,6 +1265,10 @@ static const struct pt_iommu_ops NS(ops) = {
>  	.deinit = NS(deinit),
>  };
>  
> +static const struct pt_iommu_ops NS(ops_immutable) = {
> +	.deinit = NS(deinit),
> +};
> +

[...]

Thanks,
Praan
