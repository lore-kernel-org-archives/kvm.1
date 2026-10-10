Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4CC352008
	for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791605003; cv=none; b=eqakiq0M+GrKBdqnRi195QJExqRcUmBS25XzJokxsW0lpsmDqU7IjQH+pATIYnliI7AqXRxVNMKCcsl44O7ivw7jHsdTj4ARcunqJ+Oze4C5kkrwI9gn1fab45v1g9tS5lRL4WieBWA4bFL9VignXUHuDrh/vBTCQ1S09ULp2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791605003; c=relaxed/simple;
	bh=Ejwhu/6CkTsJ1S4j1p20bCnMk+QTjT5h4/wH/FJ04D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGF1OlpzIh5PMTUIcWiSV3YcI5mDkyTYxrIeqWgKQK56/gKefhywdCASgOSi6x+P8u5veuP+vz7rrVAoaXayHw1s9hfIMZ+PCTi5/BHYcEmWVAhZbAP86Yj0ClEm/2PM0/3ZbuQdFqmGsZ9Zeh9CkEgF10OnUQ++GHo7kxgC6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PddQbhn8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PddQbhn8"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e8623790f8so11965ad.0
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 21:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791605001; x=1792209801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QCxXLqh4eBCoc+xD4Hz7gL94yd/wl3WV/0Db7GuN9jk=;
        b=PddQbhn8ljcFWeOHijF7ObtOViGIFQLkEVjVS08XZ8KbclTRPAcpBVT1onMlW1Tsrx
         L5D/Ik/UAkMbX/MzkdDlPrAEbUk1QoIqbsgMJgfzlXxMIALhCsfUesvZYfMGO2dhWy3X
         x0dTdqRV9NGbcHPo1Guxjr6A3NpVp0SiHfQb/jb8G2RL5sJ8JSznHbmhleL8hBHOw/WX
         zy3q96xgxgpofrhS0zMcXvDfFczYULkfeuk0y9ejfYMH9/pUrTlj7M0NRbGoLldKy3xj
         dGfqABRjKnjlLDWblpBUneX1ocK1/3JtbHyFDX+p2AvoVYbqGl8Kon1RNW8eOVpEa538
         o7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791605001; x=1792209801;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCxXLqh4eBCoc+xD4Hz7gL94yd/wl3WV/0Db7GuN9jk=;
        b=JdRhK6mZJ9qorEXnn49Ds/R2oXgYBfum3P4x3ZMMulWPQRi+uYGpr22E+mu5LI2Xdq
         4G9OjNSL00gExrv/xNGr1fRTrBDMaZ3e3N8ARztOA9z6V1xFXnUlt04MxMPeH8H0Yw5C
         Px/pOxOcfShHqdUYxUrRYdd5HpbteQjDq/IejVic7ts/UBv6mcCSBoAVrRW/MqFdiwrD
         5MkH32M81c/HmeRH2KzzRjNtoNOx4B6eKBXlz1FWk0dWxdQsiuZm/ahBsoXFU23sOWfF
         +JCBGnZ1Lijlbxy7vCsW2w7wJAEg0qLctPLgawo7CSt2O/MY7cVKAZj94DSAm78u5ZH4
         cE/A==
X-Forwarded-Encrypted: i=1; AKwUvByrcnA8BfrC+YBb9MwkT757kN9kRe8T3zkpP5dknNOl8s0WLDeyQA6Cp+uqlP3dkTGs17U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzaZwlNbZFHb6tcxrdJ9PFqeh3LEd7tdwlNhUa9l9SEUZD9BkM
	DNCWYA+KK31k5wEU6m75ZKzGwIHemR/O4NBn4ZSnVyxI+ewibq4GKhIQr/qcL9mXuQ==
X-Gm-Gg: AYBFou3xET8RkEDvMGuVOeNNVTbKf18iWcPmGMjgRHzRUI08Vt0T+JsdEE78bTrvXa+
	CRnB396f4WsmRyCPQDpHXCdmklIDnqhWf6DLJYsc7pA3HM9XjUndH7ekJBHiWB1nBjS5wLmmAHV
	UimKK6xHPtcs78/J5Ioke003l2NMunBcH/OaubGl7VctVFezFBq4/EnpUp9ImBKtv4th7VZVDB9
	ldAJzCmQP1Ldo2DdQAOQjxki1jKM3dTbb8FXpeCjgl56KMIjA/CrZpchSYJxKnBEbfxez60+VHP
	F1lS7X7/UAAAzdcXLgZ64oTTexnFGZ5PIkJ10H0JPNdjukcY8aEwysV/yTj/rt6176HORKFBCIk
	vgY4hV0fGtDitvZ3qhjrpxAWLo6ci2Q4OcPtabAPBM0h1MUcZjkpGat41P8H5iW0JPyL+gu8z9f
	deAT5bK/eBgUFuz6tkjxFQeDvbndXPcCaABiL9e+h1wcHVJBJ/OMhPzziXeKMDXWRcvSoLOS700
	LoR8s+Suq0Mr4ygyBjpZouMeOdHA+0B4Ls7abuyejuvK10py7tv925yoe8CQFtKo1E=
X-Received: by 2002:a17:903:1a2f:b0:2d5:c090:3810 with SMTP id d9443c01a7336-2e87b1611e7mr1347695ad.2.1791604998738;
        Fri, 09 Oct 2026 21:03:18 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e88645c20esm121255ad.41.2026.10.09.21.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 21:03:15 -0700 (PDT)
Date: Sat, 10 Oct 2026 04:03:12 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 15/18] iommufd: Persist iommu hardware pagetables for
 live update
Message-ID: <asm2djTBxDLfrX4B@google.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-16-skhawaja@google.com>
 <asa6Q4t1pqn9gz3P@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <asa6Q4t1pqn9gz3P@nvidia.com>

On Wed, Oct 07, 2026 at 02:31:47PM -0700, Nicolin Chen wrote:
>On Mon, Sep 21, 2026 at 12:48:31AM +0000, Samiullah Khawaja wrote:
>> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>> index a33b32708afa..a4ddc29ec5ae 100644
>> --- a/drivers/iommu/iommufd/iommufd_private.h
>> +++ b/drivers/iommu/iommufd/iommufd_private.h
>> @@ -98,6 +98,9 @@ struct io_pagetable {
>>  	/* IOVA that cannot be allocated, struct iopt_reserved */
>>  	struct rb_root_cached reserved_itree;
>>  	u8 disable_large_pages;
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	u32 nr_preserved_domains;
>> +#endif
>
>In iommufd, "num_" is used more often than "nr_".

Will update.
>
>>  	unsigned long iova_alignment;
>>  };
>>
>> @@ -398,6 +401,7 @@ struct iommufd_hwpt_paging {
>>  	bool enforce_cache_coherency : 1;
>>  	bool nest_parent : 1;
>>  #ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	bool liveupdate_preserved;
>>  	u64 liveupdate_token;
>>  #endif
>>  	/* Head at iommufd_ioas::hwpt_list */
>
>> +static inline bool iopt_liveupdate_immutable(const struct io_pagetable *iopt)
>> +{
>> +	return iopt->nr_preserved_domains > 0;
>> +}
>
>It's used in io_pagetable file only. I'd move it out of the header:
>
>static inline bool iopt_liveupdate_immutable(const struct io_pagetable *iopt)
>{
>	bool immutable = false;
>
>	lockdep_assert_held(&iopt->domains_rwsem);
>
>#ifdef CONFIG_IOMMU_LIVEUPDATE
>	/* iopt becomes immutable once liveupdate preservation starts */
>	immutable = iopt->num_preserved_domains;
>#endif
>	return immutable;
>}

Will update.
>
>> diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
>> +static bool ioas_set_immutable(struct iommufd_ioas *ioas, bool set)
>> +{
>> +	bool was_immutable;
>> +
>> +	down_write(&ioas->iopt.domains_rwsem);
>> +	was_immutable = ioas->iopt.nr_preserved_domains > 0;
>> +	if (set)
>> +		ioas->iopt.nr_preserved_domains++;
>> +	else if (!WARN_ON(!was_immutable))
>> +		ioas->iopt.nr_preserved_domains--;
>> +
>> +	up_write(&ioas->iopt.domains_rwsem);
>> +
>> +	return was_immutable;
>> +}
>
>Since it has to handle refcount, an unset doesn't really unset the
>flag, which is confusing.
>
>Maybe just:
>  iopt_inc_num_preserved_domains
>  iopt_dec_num_preserved_domains

Sounds good. Will update.
>
>> +static int check_iopt_pages_preserved(struct liveupdate_session *s,
>> +				      struct iommufd_hwpt_paging *hwpt)
>
>static int iopt_validate_preserved_memory(struct io_pagetable *iopt,
>					  struct liveupdate_session *s)

Will update.
>
>> +{
>> +	u32 req_seals = F_SEAL_SEAL | F_SEAL_GROW | F_SEAL_SHRINK;
>> +	struct iopt_area *area;
>> +	int ret = 0;
>> +
>> +	down_read(&hwpt->ioas->iopt.iova_rwsem);
>> +	for (area = iopt_area_iter_first(&hwpt->ioas->iopt, 0, ULONG_MAX); area;
>> +	     area = iopt_area_iter_next(area, 0, ULONG_MAX)) {
>> +		struct iopt_pages *pages = area->pages;
>
>Move req_seals inside the for loop.

Will update.
>
>> +static int iommufd_liveupdate_preserve(struct liveupdate_file_op_args *args)
>[...]
>> +	iommufd_ser = mem;
>> +	iommufd_ser->nr_hwpts = nr_hwpts;
>> +
>> +	/* Preserve HWPTs */
>> +	i = 0;
>> +	xa_lock(&ictx->objects);
>> +	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
>[...]
>> +	}
>> +	xa_unlock(&ictx->objects);
>> +
>> +	/* Store the actual number of HWPTs that are preserved */
>> +	iommufd_ser->nr_hwpts = i;
>
>iommufd_ser->nr_hwpts is set twice. First one seems redundant.

Agreed.
>
>> +++ b/include/linux/kho/abi/iommufd.h
>> +/**
>> + * struct iommu_hwpt_ser - IOMMUFD HWPT serialized state
>> + * @domain_data: Physical address of the serialized state of associated domain
>
>Then, it could be domain_ser_phys?

Agreed.
>
>> + * @token: User provided token
>> + * @reclaimed: Whether the HWPT is reclaimed
>
>Once the hwpt is reclaimed, could we clear domain_data to indicate
>"it is reclaimed" instead of a separate field?

Agreed.
>
>Nicolin

Thanks,
Sami
