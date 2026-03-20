Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710EF35C1BD
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774043839; cv=none; b=jZHp0W5+QI5WgNkj/iZDg5jXiLrZuPJVyBaiZNf5Tu/Z8xACgIotScfbfZS8odEPGITaBqNm6SjK6nIBSTgB1lSpndFclSABuB4dGiIFMEqJLydDfezWddAcEfN6BZ0opGl+dEs1EuY4JOzuQcaD42SOBVVeAVrz2nAcapWyy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774043839; c=relaxed/simple;
	bh=6xX94lNKuO8BJj4VJ5mCgOyTaqmlEHPePKXQLfsPth4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs9ZT2Q/1qzi7ENPMilnl6UyaIyd7gw1S6A39pccHLk8MWsW6MlogIFKqqp6mB425v+PxdazBMFAJMcHPY+Ai69301jn0Qoo3l8JGUj8kVsMNPoekDSQ/zW1DEt01qq/3Ebj9fOyRpUKkajRBGTGH7DXaRpRJLtecoHINf81AUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3QQR+a1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3QQR+a1"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b052562254so32195ad.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 14:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774043838; x=1774648638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ByWF9dCBnyH2oWxXkKU4G3r/BAZXT29KzMbckrH9HdY=;
        b=F3QQR+a1eh0o9JwYCxLYFH6Wd6AyrJ91wz/dmMDxAG//lzeU/u7wPNIBRLSjIQtbcO
         uE4AjTJI9oxUSRf+zDBMyU9qafou4OeJw3wekFq3kRodyAUVRxAMNlQW4OGtxcD1ihQN
         QNclZMLZ2sAgwia3LnSq/mWSulHy9DA/+HKkivRHReZ1a01sKk5IBBRy1jOqqoIgpQjj
         i83bO1SS98NdVlSOD51XXv3A8NEq26B2XCE4oZz4Hb1Uwd/Unm0g8R9fmG11aUP8J1Qm
         lqxFvNkZSN2jxLrP8sCKRKnmoBOF5pgVuW1HfVrGcoqjgpsFtu2EbNl3F1Htl/NuCeKZ
         tq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774043838; x=1774648638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByWF9dCBnyH2oWxXkKU4G3r/BAZXT29KzMbckrH9HdY=;
        b=K9NY4eAahY0uwcI7H8pG4/pLtIzvvii949c7Y1Ldp6DQZwnXyxxcZGTE37dLjTrUWG
         FpZGJEZIwX+/oJfRjtXNJT77o+0aPJd3ktKAqvptKVGOEl6omJa8sU/m73Gnczk0KfeQ
         HD+ZyzKsjI3+4ppAuKbpyPzjA5UqrwJKTLFFV7o3C4L1hf2j9ftEkn1o2PtIsN5kdCiV
         t2Jg0iLOdRkvKUAePgTEeJ1jtIUpsOfp7C2D1YXSf7u2/5b34+SiFzceTcGy1rwUyeuN
         Lc4mW8sTkItouX8MTCvB5jfdqKRhF8CmAD6Gov5azgXwBYZJzNldXijguRJgTX/2JvwI
         dxZw==
X-Forwarded-Encrypted: i=1; AJvYcCXpuczita5IGh84GDnw/p85bdJFI92rY+f1BSoHv9ZmJqxtNCPFkc6zdLKvhT3AHfqFb8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7lTyxjBkxxQN7m8Cwvz7M0TfxMuLvBty48TFLjZ4mOvYUi0z9
	yJPBsZHkUGW3ixdzWNXr3S7L7cbpgvU4VC1iMwkZGdAJFZ5TIKhSr8azTzUumyeWVg==
X-Gm-Gg: ATEYQzzn4UpBjkBdPJ2XIVcYKK+z3a4E2gOTYrf5PoJtLyf8AZjqHmW47BNAl4ZxvbY
	OzXFEqXI38YKa6gr3CMbKiQW8dijItAAVh2YzKwJEVZPmvARVuc089OMUDOfmyMrkSJae8mRdzD
	ahpNKAcuLfgVuWlqvncHLiftW4zBVs7gCJSDCvTUQQ7o1xRPZlp7+DJan6QCsCGwWOwJ9ruudT6
	j5n1DvL/IMlSg7IS9yMV1ya1FCpVonH2WRMemxmw2IdVOeRZSdCCgGkhPPGGCP9lQGmhynhEAUH
	Dzy7eEZsUDLkin63ZyblewHsaNQgJqBOm3b91Zl15Ez9P5Qt10/kHhJrXgOZMlr68dpUbZKL50w
	uxTUONwe9Vk3UMvNcxy+cieFzwVS2yUhgSknpqWF6Km1Kcu7LSieQlqaXhpqUnF6AyDTr4VL1mH
	ir6ZU0HVS+04zMxReM7PgqwJ4I16XF+5PjIGOWhOJN0oLDQZHxd25KhJCm9A==
X-Received: by 2002:a17:903:290:b0:2b0:5b4c:a439 with SMTP id d9443c01a7336-2b08b408c91mr957925ad.2.1774043837210;
        Fri, 20 Mar 2026 14:57:17 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd3458655sm1477816a91.3.2026.03.20.14.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 14:57:16 -0700 (PDT)
Date: Fri, 20 Mar 2026 21:57:08 +0000
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
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <ab3CtC0vN6J975V5@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-6-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:39PM +0000, Samiullah Khawaja wrote:
> Implement the iommu domain ops for presevation, unpresevation and
> restoration of iommu domains for liveupdate. Use the existing page
> walker to preserve the ioptdesc of the top_table and the lower tables.
> Preserve the top_level also so it can be restored during boot.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h | 96 +++++++++++++++++++++++++++++
>  include/linux/generic_pt/iommu.h    | 10 +++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
> index 3327116a441c..0a1adb6312dd 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -921,6 +921,102 @@ int DOMAIN_NS(map_pages)(struct iommu_domain *domain, unsigned long iova,
>  }
>  EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(map_pages), "GENERIC_PT_IOMMU");
>  
> +/**
> + * unpreserve() - Unpreserve page tables and other state of a domain.
> + * @domain: Domain to unpreserve
> + */
> +void DOMAIN_NS(unpreserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser)

I don't see us using the `ser` arg in this function? Shall we remove it?

> +{
> +	struct pt_iommu *iommu_table =
> +		container_of(domain, struct pt_iommu, domain);
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range = pt_all_range(common);
> +	struct pt_iommu_collect_args collect = {
> +		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
> +	};
> +
> +	iommu_pages_list_add(&collect.free_list, range.top_table);
> +	pt_walk_range(&range, __collect_tables, &collect);
> +
> +	iommu_unpreserve_pages(&collect.free_list, -1);
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(unpreserve), "GENERIC_PT_IOMMU");
> +
> +/**
> + * preserve() - Preserve page tables and other state of a domain.
> + * @domain: Domain to preserve
> + *
> + * Returns: -ERRNO on failure, on success.

Nit: 0 on success?

> + */
> +int DOMAIN_NS(preserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
> +{
> +	struct pt_iommu *iommu_table =
> +		container_of(domain, struct pt_iommu, domain);
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range = pt_all_range(common);
> +	struct pt_iommu_collect_args collect = {
> +		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
> +	};
> +	int ret;
> +
> +	iommu_pages_list_add(&collect.free_list, range.top_table);
> +	pt_walk_range(&range, __collect_tables, &collect);
> +
> +	ret = iommu_preserve_pages(&collect.free_list);
> +	if (ret)
> +		return ret;
> +
> +	ser->top_table = virt_to_phys(range.top_table);
> +	ser->top_level = range.top_level;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(preserve), "GENERIC_PT_IOMMU");
> +
> +static int __restore_tables(struct pt_range *range, void *arg,
> +			    unsigned int level, struct pt_table_p *table)
> +{
> +	struct pt_state pts = pt_init(range, level, table);
> +	int ret;
> +
> +	for_each_pt_level_entry(&pts) {
> +		if (pts.type == PT_ENTRY_TABLE) {
> +			iommu_restore_page(virt_to_phys(pts.table_lower));
> +			ret = pt_descend(&pts, arg, __restore_tables);
> +			if (ret)
> +				return ret;

If pt_descend() returns an error, we immediately return ret. However, we
have already successfully called iommu_restore_page() on pts.table_lower
and potentially many other tables earlier in the loop or higher up in
the tree..

If the domain restore fails halfway through the tree walk, how are these
partially restored pages cleaned up? Should we clean them up / free them
in an err label or does the caller perform a BUG_ON(ret) ?

> +		}
> +	}
> +	return 0;
> +}
> +
> +/**
> + * restore() - Restore page tables and other state of a domain.
> + * @domain: Domain to preserve
> + *
> + * Returns: -ERRNO on failure, on success.

Nit: 0 on success?

> + */
> +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
> +{
> +	struct pt_iommu *iommu_table =
> +		container_of(domain, struct pt_iommu, domain);
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range = pt_all_range(common);
> +
> +	iommu_restore_page(ser->top_table);
> +
> +	/* Free new table */
> +	iommu_free_pages(range.top_table);
> +
> +	/* Set the restored top table */
> +	pt_top_set(common, phys_to_virt(ser->top_table), ser->top_level);
> +
> +	/* Restore all pages*/
> +	range = pt_all_range(common);
> +	return pt_walk_range(&range, __restore_tables, NULL);
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(restore), "GENERIC_PT_IOMMU");
> +

[ ------ >8 Snip >8------]

Thanks,
Praan
