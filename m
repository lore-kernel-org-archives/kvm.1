Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793323613;
	b=bIWU9f2gLGb9qIdc2HmdpSd3lYro2aIYkGs0z7h/zlTXY3Mi0FLhPsRoB1+pXO0uXJqr
	 st+G/CplUEx5Acscdjn75EMA8wz4tEvI7Wp0oH5Mnw76zOvqfwSom86Afc49duVo9ODER
	 zugVkavh0TN83KaxfqznbU8iO3032XnKb0UY2LNqkXyh+Wy18l5RhR/TZFMLsIBIeYnKl
	 cxIKVbluioegwB1j4LRUtjRonAs+37shOILvLtv6DaJlKLxhvLDc94ihuZ/VUcFVl3gwr
	 Hai4MATNERz0PZ8xpq9AvHG4uuF+xUmDmwJmOZjp5Va3VSXpchYpEb9IjivpL+BQofA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793323613;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7TidQHqBf1ZuOvcJ+LuDnP0h7WFNpRTpS1kTxbluEbQ=;
	b=dqHhJYXyqr2lvLSU0qyhb4sxk4MirUmooIBqcY4dV0YnKt3tocKLC3mPDD6tPOxcJjEz
	 CKt825yfPxvY//RHBOPbradr6es9oXhJ3wYuMD95DLKRRtP/RSOFhDSxkqUyYksP7Km4x
	 wbMDf/Z1UmzDjpce3z0GjjGvqY8mH5zDOJxHY7bChPN5wDpJe3YynKpKqxF3wJzGxHO3R
	 E4o7xK3QKuS2NYyFbdorxqSPk89Uo/bXkiCnxDIzNAsqvpbnl24xkMAIsIZM/V18BByqS
	 zO4Mgsq8DYQrkXGOgCA4T3aK2JZL/gj6CnxJcTKag4jj8vhw9d7bY6HVzYc737xhMgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="AnN/Hlyw";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81368606A31C;
	Fri, 30 Oct 2026 01:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81368606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AnN/Hlyw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793323613; x=1824859613;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vsYaPtnLT+8StniLOIYrIhlEUEjfJqUbSGNkv3n7U7Q=;
  b=AnN/Hlywa4JS/PqzUhHChIFX4In3qQyhXr3w/cyzwt3A3T3Q8C4LVGn2
   4SoZ5Ce2z2gV3E95+cDsMaGOO+X0pTRpQs3SOIWr2+Z5haG0Ap2MxrF93
   j1NAqjPfxnonAVnjas2aDLsf6Ll9MUQRjJk8atre88N9R0udh2uslrC4i
   gD/1/elAr4XZztOiSH+pwSJ3bP2lkeZJH3w2LagzTa/FTnOmvEqOJCsFc
   QSWVR0yzC4CNalvq5r/GDwGOxuZ9uOT30IKf6teljWcX1KKFMbbY1GJd0
   nxaaTWQBbo9Yl7lpidPySpLxa/FmQECuYnFsACGW3wEMrwRqf1lFpWMDk
   Q==;
X-CSE-ConnectionGUID: gqiGtMqRT8uxrb99pkVpcw==
X-CSE-MsgGUID: WMPkKC8gSWKIvewZVXDW2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1966073"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="1966073"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 18:26:52 -0700
X-CSE-ConnectionGUID: 6z5Zy7HLTGmjyxLmLUNK4w==
X-CSE-MsgGUID: sof9eSQbSoSaTMwE/9OSgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5629341"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 18:26:47 -0700
Message-ID: <d6e6abad-c3c7-4f99-996a-0030bf6ef166@linux.intel.com>
Date: Fri, 30 Oct 2026 09:26:45 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Pranjal Shrivastava <praan@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma
 <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>,
 Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 02/18] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-3-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-3-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
> IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
> the proper preservation and restoration of ioptdesc add helper
> functions.
> 
> Reviewed-by: Pranjal Shrivastava<praan@google.com>
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/iommu-pages.c | 109 ++++++++++++++++++++++++++++++++++--
>   drivers/iommu/iommu-pages.h |  30 ++++++++++
>   2 files changed, 135 insertions(+), 4 deletions(-)
> 

[...]

> +
> +/**
> + * iommu_restore_pages - Restore pages that were preserved in KHO
> + * @phys: Physical address of page to restore
> + */
> +void iommu_restore_pages(u64 phys)
> +{
> +	struct ioptdesc *iopt;
> +	struct folio *folio;
> +	unsigned long pgcnt;
> +	unsigned int order;
> +
> +	folio = kho_restore_folio(phys);
> +	if (!folio)
> +		panic("Failed to restore preserved IOMMU page %llx\n", phys);
> +
> +	iopt = folio_ioptdesc(folio);
> +
> +	/*
> +	 * For the restored pages incoherent is set to false as these are not
> +	 * mapped using the DMA_API. The remapping of these pages using DMA_API
> +	 * is not needed as these are not going to be written to by the new
> +	 * kernel.
> +	 */
> +	iopt->incoherent = false;
> +
> +	order = folio_order(folio);
> +	pgcnt = 1UL << order;
> +	iommu_folio_update_stats(folio, pgcnt);
> +}
> +EXPORT_SYMBOL_GPL(iommu_restore_pages);

The pages were charged to the VMM's memcg in the old kernel (iommufd
maps with GFP_KERNEL_ACCOUNT), but after the live update they are no
longer charged to any memcg. I think that's fine, because the restored
tables are immutable and will be replaced by ordinary ones after boot.

This patch looks good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
