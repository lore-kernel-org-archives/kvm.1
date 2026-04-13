Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B435DA56
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776108691; cv=none; b=KdB48yF86a5wxEC2E31kW/qH5xRcR63a+g4HPLmwknlkWfcHJg4GyFJJIpFug3USPgFRRUJ9j1dxFSjoRSe8E0UQBC/NC5nYiSd1hlm0n/kyx652GPLEr0ZnUgHUezlSyvpSq91DYXanQEh+7gNWCjR9Ka5Ecf054TyqZjSxMvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776108691; c=relaxed/simple;
	bh=CC2nyShyWFv1Gy65La/U1u9FHqbHFUCiQ17U7vIiH74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnUQVwBdwn/hHueD8qtT62ik4llefUJsM7eTP8lOpnOmouA8b6FLHHUybia6r8j/fvPAx4hyS0qLcgv74/P6qI2KiyMzUYRB1kcZwYlX/rC5UeKZlv08yf8EE4EX1tdjrgeRzhh4DuSIIyOVRmSEe+OfyVzpEYSCZV/an7VUfvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5eSIzel; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5eSIzel"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1270fc2bdf2so39218c88.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776108689; x=1776713489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmEo2MDjIDDkENmGoPrF05ezLV8EbIzqq9cU9t7++Qw=;
        b=r5eSIzel3iPzdUHqTkmTlxNqqW50b7KB4CF0HWK+BO2UjCeUAsTiK9/njiBseL6X6F
         yR+f3HsHK9dfDorqlR5SWQxtpDWl5k/iuEAKtEBT1K517euIimYmGnREYb1FpSUpeYvK
         Hn3NUfPPJvGY7XJZA9Ve2OQug3EWftq114ORsfV3qNLOKwgY6BZeTwYeH5lExvXDiRl8
         W/Yjlvp50JdEY21+2duJDaNLKdUQolggk2MRl1n82X7/0RAlVU8nhro4pfPLwqWH1/HZ
         cGs05Qg3zt7NSdmOkBu3O2/aokW2Tg1tm5YRetEkRo1262eOmaMH2jkrdLn5vATfzn3u
         ysPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776108689; x=1776713489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmEo2MDjIDDkENmGoPrF05ezLV8EbIzqq9cU9t7++Qw=;
        b=RayCg6oRzm8wqZlUt2R+JvuFJoRvtZrxXACeEim+DyEHbBwfvdFLJtb8A1vIElKaBW
         50QD4LqAoV82+JEoPbrqHAm2/yWZsxLlT+zDzCG2sdxGPicT03e4qoDueVneM2BzXbEA
         azb4IK7hHc+e0lKYJFkJecFjn7h/otRc/AvQ3gNpmV26VFQu25nEaHUTwez82s/+X0oZ
         N7i6iL4ZK7Q0oU5bg2R87d/e79qVxs5ptF3ajsDqpj9Nh6FL4X1iAcOW97ZaNgKC0+Ge
         RPd4rYNZNcMSuSFS+LxVbLqUPfTJQAvCkg196fqvU2b2w0YIDbmAi9ZCod8lqGAsJYMv
         QkUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fYXcVnv65mblPrPOC7kouDYiix+/FdwJ1wHewG4ksfpu+mUHtkcPu5jQ11RPwLNV/eZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKjxr4BG1keGYH8s8GE/Cfzo0v6lUNpl19kshw4s9sBWLjbEnT
	ODVDb5dwf+Uoc7/fz64dncI63E1bmEVAWtbMlW3NYdZ47aoFivsizaccHoE9rjSMwN4UpH1WR96
	EbmKI6rJG
X-Gm-Gg: AeBDievhg+m3abWjXpzElso0sQhHH/uN80aTxK/4WzncC8ZJSwwafEkxuiJ9xSEsTMd
	HZhoiJF6+dH1qr3+3isyN8T6crPGBy/WTrIefV+hhY5KvWI1isRTsT2N6XMW8Uo07Cyfw64LAFM
	+6eDqvUamNxnrWJ2pIfwzHFLUkfGnqh6LhOp0lSl1p2zlw5fZPx6RTkNSg23sa1kgFE7P4TRgDv
	nGnhGh4fjL0piSbGWO2WX9MmKYsaO7YZB8HMz26OGH1md6zXEudz8FiHCQtnrijU+uQhYc0/PAs
	cgk+KwFJvF7fgLYU+mcO2ihohomcOZ3fXmYY4ZyBOHPH3T+diVEYMJAzhXiSOIWtZufmKKFwPq1
	h5FDkaJAKKpBD20rtuIq0Ps3halxlAPyL8kf39EcpmkXwQybRUiKew/xXgWXrKYXQK+tTKKiePL
	vnEnemknlzXEY3U9H6/eG6TiFdS2Oqlx0E3uELMpI+iTqSVJNWan62c6e7WMoV607XaLUcyE1gb
	y8EDqAoPDvn+aQQtmhHNg==
X-Received: by 2002:a05:7022:6611:b0:12b:ebf6:a3bf with SMTP id a92af1059eb24-12c29c2345bmr711976c88.5.1776108688158;
        Mon, 13 Apr 2026 12:31:28 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa556esm21143295eec.8.2026.04.13.12.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:31:27 -0700 (PDT)
Date: Mon, 13 Apr 2026 19:31:22 +0000
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
Message-ID: <ad0b-5aRU172-Od8@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
 <ab3CtC0vN6J975V5@google.com>
 <20260410141652.GV2551565@ziepe.ca>
 <adl2QX6gra99bkOV@google.com>
 <20260410231650.GD3694781@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260410231650.GD3694781@ziepe.ca>

On Fri, Apr 10, 2026 at 08:16:50PM -0300, Jason Gunthorpe wrote:
>On Fri, Apr 10, 2026 at 11:02:52PM +0000, Samiullah Khawaja wrote:
>> On Fri, Apr 10, 2026 at 11:16:52AM -0300, Jason Gunthorpe wrote:
>> > On Fri, Mar 20, 2026 at 09:57:08PM +0000, Pranjal Shrivastava wrote:
>> > > > +static int __restore_tables(struct pt_range *range, void *arg,
>> > > > +			    unsigned int level, struct pt_table_p *table)
>> > > > +{
>> > > > +	struct pt_state pts = pt_init(range, level, table);
>> > > > +	int ret;
>> > > > +
>> > > > +	for_each_pt_level_entry(&pts) {
>> > > > +		if (pts.type == PT_ENTRY_TABLE) {
>> > > > +			iommu_restore_page(virt_to_phys(pts.table_lower));
>> > > > +			ret = pt_descend(&pts, arg, __restore_tables);
>> > > > +			if (ret)
>> > > > +				return ret;
>> > >
>> > > If pt_descend() returns an error, we immediately return ret. However, we
>> > > have already successfully called iommu_restore_page() on pts.table_lower
>> > > and potentially many other tables earlier in the loop or higher up in
>> > > the tree..
>> >
>> > It doesn't return an error, it just propogates errors from the
>> > callbacks which this one never errors. So this is just dead code.
>> >
>> > > > +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
>> > > > +{
>> > > > +	struct pt_iommu *iommu_table =
>> > > > +		container_of(domain, struct pt_iommu, domain);
>> > > > +	struct pt_common *common = common_from_iommu(iommu_table);
>> > > > +	struct pt_range range = pt_all_range(common);
>> > > > +
>> > > > +	iommu_restore_page(ser->top_table);
>> > > > +
>> > > > +	/* Free new table */
>> > > > +	iommu_free_pages(range.top_table);
>> > > > +
>> > > > +	/* Set the restored top table */
>> > > > +	pt_top_set(common, phys_to_virt(ser->top_table), ser->top_level);
>> > > > +
>> > > > +	/* Restore all pages*/
>> > > > +	range = pt_all_range(common);
>> > > > +	return pt_walk_range(&range, __restore_tables, NULL);
>> >
>> > This should probably be doing something with the FEAT flags and
>> > ias/oas too or do you imagine the calling driver has to deal with
>> > that?
>>
>> During boot the iommu_domain is recreated in driver and it sets up the
>> FEAT flags and ias/oas properly. Then this generic callback is used to
>> restore the page tables.
>>
>> Currently the FEAT flags of a domain are not explicitly preserved, I
>> will preserve them and error out here if there is a mismatch.
>
>Hrm, that expands the ABI a bit though
>
>If the only operation on the restored table is free then I suppose it
>can be simplified quite a bit, you just need the minimal things that
>the collect walker in free touches.

Yes, we use the collect walker during KHO restore of the preserved pages
and also during free. But if I understand correctly, the collect walker
behaviour changes based on some FEAT_ flags (like SIGN_EXTEND). So we
have to be careful if the previous kernel was using different FEAT flags
that affect the collect walker. To handle this, we can just preserve the
u32 features from struct pt_common and deduce everything using that.

Or are you suggesting not to save u32 features at all?

Thinking about it more, we do preserve the top_level, so that could
potentially be used to walk over the page tables of these free-only
domains if we just set up the pts->index and pts->end_index properly by
initializing the range based on the top_level. Are you thinking of a
similar approach to walk these free-only domains?
>
>Is that the intention, free only?

Yes, the intention is to free only. This domain will be immutable and can
only be freed.
>
>If so then the restored iommu_domain should be some special free only
>domain too.

Agreed.
>
>Jason
