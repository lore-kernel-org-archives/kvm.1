Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A94223DFB
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862180; cv=none; b=HgbBjD8DP8Zz25rGMm1KyD/JanjV6zQK4kWNNN+KnfYHPkpKqfmuPoGA5m3p3TFQVG1CmoEDdfO3H/82s+SvHaQ0Snesj6sghLFCed3s9htEdJ1UtyarehOhBphkAxTpN6l7AgVDNn/1yHcVBu4zLNzWsm2nnKHb6pe36GRshoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862180; c=relaxed/simple;
	bh=DYTNLb98hZeGxyI5R92ohATyRHWcsN36bzgF2YeqRkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ty7MxRhlVG9Ui0pbBKLX8BVmMLz1mT+At5kJyB1AeSso01hCKiYY2rpTn8BDu2g8pbj+3ndeidX0ZF78yZ29uLSAmLy1eFAq8xNRCjhT/IeujW5MLrHB/LGmQFHq7qDvcF8nHjL2V5Jf92NdtL/UFOII7NflFEPy8QWotnaMBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZvG5mDfo; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvG5mDfo"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1270fc2bdf2so24265c88.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775862178; x=1776466978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sDo9cCb4JlomwDlOw2QqnoywLS/P6wn4vikeZZXB08=;
        b=ZvG5mDfohtU+wp3y4DQyx2twaIlpzyn/biAWXAl6NlYLRz+ylMDRYtwaUN5p0ZvWoB
         yKt5ytTMwyTkp4oVMdVaMvcqFfY90XxObt9Ek7sotwhHGlX+qi6yYs9IttrsAURIUz14
         yPFbru3z7/Y2bgMwwGr6De+pt/wNTmasoMHc8RQ88bzIFgJY7eQ1GeBIfBXcxsrG8O7+
         u18cm/vuegWnsCKrLdACdCeZSkh+gcDh96WxNxmjuxnigKx0mItjvN1lQachn5c0VLO+
         wsZt5fkJkEdWjuF8vzOX9d/X8Oe4IyjTC3/qvFQBuCnTGaC8ARgjk2y8Q/i1kv2yfSsG
         lGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775862178; x=1776466978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sDo9cCb4JlomwDlOw2QqnoywLS/P6wn4vikeZZXB08=;
        b=SLToTnV2lEvEneeJVxYHFJDKBPnByLZOcB8x21qSDkq6ODJMZIad5E1bUfTHdA2Zm5
         PB7ahYHIIoync0nZoQiEeYDH/3FXcwp0JO98/2lypf4ZLXd6UbZQe1GnUrs+fQ+KRHbH
         1R0AGbT0Mi39AjgDN4IoWhu/b3WJUVOx/lsCo1ckLwWgeaZai9FY54JwtOuIRpRxBO3S
         m82XnWVLOnOHsB/hhBJNRsOkp2wsHhPGQQkSNR76YYian0cP2/HtiNvEnTsz5h2On2dR
         448++h1TKpniYYUC+C62Ic7VYDbw5/+8QPZrJCBWYfwpZzmYunWK/MiVr3uBAg0Jt3a6
         sMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW72A3FALQgB55vnauycqZeZcmfd9gNiVHyXwQ93zgQYdKzlnaZJTRmwEiLu/EFAnSv9+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLT+gi5Hi4py85A9SEXXYqQCa880N2Fu52fwBnJWa0/mfL/+su
	vHhRkZLlFBx0jp1Ph8vWcyrRVmLomOSEqdAYmyR7VrG2DzpnxCFE94oDUbFDGTAadQ==
X-Gm-Gg: AeBDievhSgCqrwJ3Re7TJcSo+VXoMVqLHGSGwkdNl3XlAiqZQU58vODZHEmGBM+ov+3
	yPf/eNxpOSHL8H3gE7nUXS/N0w+WoGbKIZW2VeZtz6//HH5xkEVVLCukEBZm5hibibPMq4XatEh
	kSUjVNq/XnLjH9sbnLbmBoDVC3dqQByA3s4xP3pPoupyu2ZfhXy19Y+84S70FVIr4mIWdLWVnJ/
	mD4oMDG+ETe3sEoDLEaM+pVDlh0qMoVVtpS9JLcfP+WOCUV/CrB4+txkd9BWJP49uMCYZzWRNQW
	BbO6GmChVDKpBxCmYTtgqDpu8ZwI3OuxgQv7TdXlKoPMg5gJVyNhOgF8ns4Nrma/pfaXwa6aUBy
	y6a1B5erL1z/FbF1wSHeV+RQg3hcI/NHGNRMIVvO325m75Whz7U1W7MtQDyCspTICqjWEBxh+Rt
	uCRiymOWtph2GMFiazplh1HqnRNfMdFru5V0vET6j67gJZTiGR6cCflCUCcJLRW5ptqNNvbOGe
X-Received: by 2002:a05:7022:48e:b0:128:ba6e:f809 with SMTP id a92af1059eb24-12c28ea0f68mr430372c88.6.1775862177534;
        Fri, 10 Apr 2026 16:02:57 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2c09sm7935702eec.18.2026.04.10.16.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 16:02:57 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:02:52 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pranjal Shrivastava <praan@google.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <adl2QX6gra99bkOV@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
 <ab3CtC0vN6J975V5@google.com>
 <20260410141652.GV2551565@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260410141652.GV2551565@ziepe.ca>

On Fri, Apr 10, 2026 at 11:16:52AM -0300, Jason Gunthorpe wrote:
>On Fri, Mar 20, 2026 at 09:57:08PM +0000, Pranjal Shrivastava wrote:
>> > +static int __restore_tables(struct pt_range *range, void *arg,
>> > +			    unsigned int level, struct pt_table_p *table)
>> > +{
>> > +	struct pt_state pts = pt_init(range, level, table);
>> > +	int ret;
>> > +
>> > +	for_each_pt_level_entry(&pts) {
>> > +		if (pts.type == PT_ENTRY_TABLE) {
>> > +			iommu_restore_page(virt_to_phys(pts.table_lower));
>> > +			ret = pt_descend(&pts, arg, __restore_tables);
>> > +			if (ret)
>> > +				return ret;
>>
>> If pt_descend() returns an error, we immediately return ret. However, we
>> have already successfully called iommu_restore_page() on pts.table_lower
>> and potentially many other tables earlier in the loop or higher up in
>> the tree..
>
>It doesn't return an error, it just propogates errors from the
>callbacks which this one never errors. So this is just dead code.
>
>> > +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
>> > +{
>> > +	struct pt_iommu *iommu_table =
>> > +		container_of(domain, struct pt_iommu, domain);
>> > +	struct pt_common *common = common_from_iommu(iommu_table);
>> > +	struct pt_range range = pt_all_range(common);
>> > +
>> > +	iommu_restore_page(ser->top_table);
>> > +
>> > +	/* Free new table */
>> > +	iommu_free_pages(range.top_table);
>> > +
>> > +	/* Set the restored top table */
>> > +	pt_top_set(common, phys_to_virt(ser->top_table), ser->top_level);
>> > +
>> > +	/* Restore all pages*/
>> > +	range = pt_all_range(common);
>> > +	return pt_walk_range(&range, __restore_tables, NULL);
>
>This should probably be doing something with the FEAT flags and
>ias/oas too or do you imagine the calling driver has to deal with
>that?

During boot the iommu_domain is recreated in driver and it sets up the
FEAT flags and ias/oas properly. Then this generic callback is used to
restore the page tables.

Currently the FEAT flags of a domain are not explicitly preserved, I
will preserve them and error out here if there is a mismatch.
>
>Jason
