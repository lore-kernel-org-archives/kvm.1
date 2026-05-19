Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B189E492180
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210907; cv=none; b=qicRDcVB4wJ0ZN37bve6MyjMsOgeYSzZxkLMLFEchPi7660d7FLjVv0qh0Wc80Ms6qf82YjIkiEC0e2z+qJcU/M9eUXVjHWKOshnUzn/fGbVBDA//TuodbUlJW3cZxQt76oec5I1BBfxBVD24AQdVdrQxWSuROn1DJPSD8xW3xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210907; c=relaxed/simple;
	bh=N0olbpp4+tbbF00EjqkPnSM7waYwBC1YIklDoPh4SKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiLrTbjVAzNC3E84uJPgziq2EWe5TYsAT2aeQ7dk2MSC2mv4QU4ehNRJjmmK+gbaePp82P1/I6T+1SedsaO7cgeuHUjZipRAkU8XcyNh70I26ViFr/Mmx66X9X1604OflOX3vCvI1MGA/Aq0WNDPCRxA5WevD4Qa9vpw9JuybO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=danw2frI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="danw2frI"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so465ad.0
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779210903; x=1779815703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvUscp3TmdBdYJXRIEvO1MdmjothbiB8jYKdWN5DkYE=;
        b=danw2frIg5E9TklgFEB/t36bxzS0UKmxVX6X0fkSA13/oJFptPYkN/N0Q7cNNYNf+q
         NMVFYthq3JFt83JOiayT1+3USXDyup0SjT+XPt6wDEGt0GyIHwqPAkYhR/vclZHgR7ns
         +5KQDsZJI7SPrhiXbYHdugJBKGtuPKJtTPN9+caoDybP1vSG0MNTdAOAzy64qoij2Xwp
         DWuanTi1w5KUbFhkkqvcGldTVYd1fYuJzk9jDGkPqDtL3MLj/upGFDPSKF0OG51Kyrzt
         SmCmfc31vAv6muCQG9YHACAWneShcLkHSqwG27gnDbd9Hlz1/OBK/cbyaJBIZnmyKa1F
         JCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779210903; x=1779815703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvUscp3TmdBdYJXRIEvO1MdmjothbiB8jYKdWN5DkYE=;
        b=aHF3GdWFJAND7PKgzsIn6jhj+USC99UC0uq+KqlyFt/w1ZrRBK3mdKFhiq405gXtZq
         Of55g6ugeBRenGOBn6gpUQUxnLQ/HS5TWEyAb7taidNwvMXYFfx/5rYc886bxy1DrQWp
         HVYY4L658dc7ifbATtMX0pOGXJIF4gHY6A+YaYQa7f//3o1Rd1bcEYsNiV6sa3vl7Uzi
         FGBLQV1gxZXMw69B2z00QW0D6FdjNRAEL9lV40p2C/cQlwhahpZHApiU82ojgj+nDbDk
         7HteNEUFK7qhofYNJnTpRO6zqH91uva2UzEuZvKnr2Ri0+SukflTnrtvQZ/+frH0k1iB
         /J4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8XGQAsPUBt6v6ECy6Mm4uoh+e8Qzjh0zWCTArxwVj1CA4syKzKNSeEii0de3nCm5rMolI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFoIAflVaPuYmfZzqnISquhO41VBq8PC0oLtZmP2LTGxtPQyPK
	X2gqQc+zV5/fbRBtLvLBsgUqUX/WES5G0nRxlSZdeayfP/IRJegkMAgVzs6ShCx+mQ==
X-Gm-Gg: Acq92OF/lc+DyGrr9k7SozxBLHh+f6gDmEjAt8UpANPhHuswyDKNN0BlUP4f7JCKtlU
	8MPF2VdNfCmFw4R419YTG7j1eXw7ORpV+VW8xjd931Re71jkz+N7bC83EZERhAam9QQ884LKg7E
	ZRzJNNBUSQ6pm1roCyvvAeT07GxiKEZ+ZyyhnzgikTUZGoYP/vqMo3AULMLtNgff+ROC2AYdq8E
	2T6I5z6m2o1ewZnoBMgaplcFhDSkKN+vfBCHS8mWrNirqFWu8EDx/EWLYtrubfW/zDkjcr/Q4yU
	8qnhByFZkYATwPX1AnZw5ZDNYktqEgy/04rXONStsVirBk37ZcmjeD/aSMscSiihd2gikBl7LZ4
	Kmk/rqOLv6tl5ojTDk7o6Wmx4+tovEE6rwMv2DikagDhKn9BJddfhbG9KSFfB0e3XAcusEnceYU
	RHcNi3wReWyCwpA7JjT5FKThKtWIUXf0BMeDP+3w0x7vdSxQUPwUcIKumZLsnjsjqySRQWAA==
X-Received: by 2002:a17:903:1b67:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2bdb03a2d5dmr6496795ad.2.1779210902187;
        Tue, 19 May 2026 10:15:02 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb114c08sm18103728a12.23.2026.05.19.10.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:15:01 -0700 (PDT)
Date: Tue, 19 May 2026 17:14:58 +0000
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
Subject: Re: [PATCH v2 06/16] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <agyaeRExaL6Tm47V@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-7-skhawaja@google.com>
 <agxiXNalisHyNkGt@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agxiXNalisHyNkGt@google.com>

On Tue, May 19, 2026 at 01:15:08PM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:23PM +0000, Samiullah Khawaja wrote:
>> Implement the iommu domain ops for presevation, unpresevation and
>> restoration of iommu domains for liveupdate. Use the existing page
>> walker to preserve the ioptdesc of the top_table and the lower tables.
>>
>> Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
>> the next kernel. On restore the domain has only the preserved features
>> enabled and all the other features are zeroed. This is ok since the
>> restored domain is made immutable and can only be freed. A kunit test is
>> added to verify that the IOMMU domain free can be done with trimmed
>> features.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/generic_pt/iommu_pt.h       | 131 ++++++++++++++++++++++
>>  drivers/iommu/generic_pt/kunit_iommu_pt.h |  28 +++++
>>  include/linux/generic_pt/iommu.h          |  19 +++-
>>  3 files changed, 177 insertions(+), 1 deletion(-)
>>
>
>[...]
>
>> +static const struct pt_iommu_ops NS(ops_immutable);
>> +
>> +/**
>> + * restore() - Restore page tables and other state of a domain.
>> + * @domain: Domain to preserve
>> + *
>> + * Returns: -ERRNO on failure, 0 on success.
>> + */
>> +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
>> +{
>> +	struct pt_iommu *iommu_table =
>> +		container_of(domain, struct pt_iommu, domain);
>> +	struct pt_common *common = common_from_iommu(iommu_table);
>> +	struct pt_range range;
>> +
>> +	common->max_vasz_lg2 = ser->vasz;
>> +
>> +	/* Make this domain immutable.*/
>> +	iommu_table->ops = &NS(ops_immutable);
>> +
>
>Nit: Let's consider adding a comment since we just have .deinit in ops:
>
>/*
> * Restored page tables are strictly transient and only permitted to be
> * destroyed via .deinit. Because we only preserve user-assigned devices
> * utilizing pass-through frameworks (VFIO / IOMMUFD), any concurrent or
> * subsequent map/unmap operations on a restored domain are explicitly
> * blocked at the subsystem boundary (e.g., via IOAS immutability seals).
> */
>
>This makes it explicitly clear that any nullptr dererfs occuring due to
>immutable_ops->map_range etc. (in the future) are considered as bugs.

Sounds great, will add a comment here.
>
>> +	/*
>> +	 * It is safe to override this here since this domain is immutable and
>> +	 * can only be freed.
>> +	 */
>> +	common->features = 0;
>> +	if (ser->sign_extend)
>> +		common->features |= BIT(PT_FEAT_SIGN_EXTEND);
>> +
>> +	range = pt_all_range(common);
>> +	iommu_restore_page(ser->top_table_phys);
>> +
>> +	/* Free new table */
>> +	iommu_free_pages(range.top_table);
>> +
>> +	/* Set the restored top table */
>> +	pt_top_set(common, phys_to_virt(ser->top_table_phys), ser->top_level);
>> +
>> +	/* Restore all pages*/
>> +	range = pt_all_range(common);
>> +	return pt_walk_range(&range, __restore_tables, NULL);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(restore), "GENERIC_PT_IOMMU");
>> +#endif
>> +
>>  struct pt_unmap_args {
>>  	struct iommu_pages_list free_list;
>>  	pt_vaddr_t unmapped;
>> @@ -1138,6 +1265,10 @@ static const struct pt_iommu_ops NS(ops) = {
>>  	.deinit = NS(deinit),
>>  };
>>
>> +static const struct pt_iommu_ops NS(ops_immutable) = {
>> +	.deinit = NS(deinit),
>> +};
>> +
>
>[...]
>
>Thanks,
>Praan

Sami
