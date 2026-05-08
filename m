Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB6A3603DF;
	Fri,  8 May 2026 06:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220522; cv=none; b=rkrv6NLoTJvm9lt7J5oCpZ8NRcdk1IF6fRgX7RIG6sJf2nF63i7rhx6A7Oswn9qqvYm8jimM89aV4TiH7nW5f9WoxTtLvjQmqWYW6HQ7jj8ylh8Q6t1Xd7BronZey5pIGjZEp1tciLqPY/weE9OkaojCdz2dJ1SiZjaL3PZK0TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220522; c=relaxed/simple;
	bh=dC6moos725vN40QiuJsjKokrVFl0dwcanMGIrdErclo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMgaaJ7t2vxLN0MfbnpL9x+NxMulMxpIGFFqUtML2bAFAC6n+hggKOk8S+floGvAvKu+FL005/RXM18z9I1PA17QLTNnV7+8h/je6ulOkeSNRz9Unq43aj0v71uwtpSCoUlucyPCjvWQdQI0nSLYuQlIR9azTHjMiGPpZJl5cgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVn0fuD4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVn0fuD4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778220518; x=1809756518;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dC6moos725vN40QiuJsjKokrVFl0dwcanMGIrdErclo=;
  b=IVn0fuD4mTc7Uz6cE+E4jHOY6mmKqYT6Pdo3sVBgpxtzaRwAGAbxFLjy
   3QSZDsfPiL3k2QOOttBzWt4wwpWrEd4TwkLVsUShLF23SoNw/mVHZggKp
   tnih5zDjY5RBiFZvlqAQsBelDlsFhLG+pp0bMMJUsFXDp+1KLnTCTmR4L
   lgih/r9Zhln7v+OjqeSbf9fcEVxrX6SLZpa0Fz8ttZZ0v6fZ8E8evYGQQ
   hBw5aRZh6q6K5nb0m7u7RsXn/8JVu1XqZ+o3dfSI1T11qne3XXtoALwZ9
   D7G3OcqO0NhnZq01e5gpPtLFRAholSLMD4ycwb1qoEDmCFvqR7nmIzPfX
   A==;
X-CSE-ConnectionGUID: gdCTkaesTDeBKIFJQawdKQ==
X-CSE-MsgGUID: RTqsAYWaTni24pieT6MTuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="81747150"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="81747150"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 23:08:33 -0700
X-CSE-ConnectionGUID: P2PrqLbrRAaXU+L+IQa6Tw==
X-CSE-MsgGUID: SnqLcs45Tty88p3nHthLSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="274800633"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 23:08:28 -0700
Message-ID: <666d749e-c1fd-44e1-bfe8-681ba04862e0@linux.intel.com>
Date: Fri, 8 May 2026 14:05:58 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] iommu/vt-d: preserve PASID table of preserved
 device
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 William Tu <witu@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 YiFei Zhu <zhuyifei@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-12-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260427175633.1978233-12-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/26 01:56, Samiullah Khawaja wrote:
> In scalable mode the PASID table is used to fetch the io page tables.
> Preserve and restore the PASID table of the preserved devices.
> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      |   5 +-
>   drivers/iommu/intel/iommu.h      |  12 +++
>   drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++++
>   drivers/iommu/intel/pasid.c      |   7 +-
>   drivers/iommu/intel/pasid.h      |   9 ++
>   include/linux/kho/abi/iommu.h    |  13 +++
>   6 files changed, 184 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b90757164cd8..6d42051dcf7c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2951,8 +2951,10 @@ static int clear_unpreserve_context_entry_fn(struct device *dev,
>   	if (!info)
>   		return 0;
>   
> -	if (dev_is_pci(dev) && dev_iommu_preserved_state(dev))
> +	if (dev_is_pci(dev) && dev_iommu_preserved_state(dev)) {
> +		pasid_cleanup_preserved_table(dev);
>   		return 0;
> +	}
>   
>   	domain_context_clear(info);
>   	return 0;
> @@ -4013,6 +4015,7 @@ const struct iommu_ops intel_iommu_ops = {
>   	.page_response		= intel_iommu_page_response,
>   #ifdef CONFIG_IOMMU_LIVEUPDATE
>   	.preserve_device	= intel_iommu_preserve_device,
> +	.unpreserve_device	= intel_iommu_unpreserve_device,
>   	.preserve		= intel_iommu_preserve,
>   	.unpreserve		= intel_iommu_unpreserve,
>   #endif
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 8e37acf7de12..62076a1a0b4d 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1290,12 +1290,15 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
>   #ifdef CONFIG_IOMMU_LIVEUPDATE
>   int intel_iommu_preserve_device(struct device *dev,
>   				struct iommu_device_ser *device_ser);
> +void intel_iommu_unpreserve_device(struct device *dev,
> +				   struct iommu_device_ser *device_ser);
>   int intel_iommu_preserve(struct iommu_device *iommu,
>   			 struct iommu_hw_ser *iommu_ser);
>   void intel_iommu_unpreserve(struct iommu_device *iommu,
>   			    struct iommu_hw_ser *iommu_ser);
>   void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>   					       struct iommu_hw_ser *iommu_ser);
> +void pasid_cleanup_preserved_table(struct device *dev);
>   #else
>   static inline int intel_iommu_preserve_device(struct device *dev,
>   					      struct iommu_device_ser *device_ser)
> @@ -1303,6 +1306,11 @@ static inline int intel_iommu_preserve_device(struct device *dev,
>   	return -EOPNOTSUPP;
>   }
>   
> +static inline void intel_iommu_unpreserve_device(struct device *dev,
> +						 struct iommu_device_ser *device_ser)
> +{
> +}
> +
>   static inline int intel_iommu_preserve(struct iommu_device *iommu,
>   				       struct iommu_hw_ser *iommu_ser)
>   {
> @@ -1318,6 +1326,10 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
>   							     struct iommu_hw_ser *iommu_ser)
>   {
>   }
> +
> +static inline void pasid_cleanup_preserved_table(struct device *dev)
> +{
> +}
>   #endif
>   
>   #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index 50a63812533f..404b485e97b9 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -14,6 +14,7 @@
>   #include <linux/pci.h>
>   
>   #include "iommu.h"
> +#include "pasid.h"
>   #include "../iommu-pages.h"
>   
>   static void unpreserve_iommu_context_table(struct intel_iommu *iommu, int end)
> @@ -140,10 +141,96 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>   	iommu_for_each_preserved_device(_restore_used_domain_ids, iommu);
>   }
>   
> +enum pasid_lu_op {
> +	PASID_LU_OP_PRESERVE = 1,
> +	PASID_LU_OP_UNPRESERVE,
> +	PASID_LU_OP_RESTORE,
> +	PASID_LU_OP_FREE,
> +};
> +
> +static int pasid_lu_do_op(void *table, enum pasid_lu_op op)
> +{
> +	int ret = 0;
> +
> +	switch (op) {
> +	case PASID_LU_OP_PRESERVE:
> +		ret = iommu_preserve_page(table);
> +		break;
> +	case PASID_LU_OP_UNPRESERVE:
> +		iommu_unpreserve_page(table);
> +		break;
> +	case PASID_LU_OP_RESTORE:
> +		iommu_restore_page(virt_to_phys(table));
> +		break;
> +	case PASID_LU_OP_FREE:
> +		iommu_free_pages(table);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int pasid_lu_handle_pd(struct pasid_dir_entry *dir, enum pasid_lu_op op)
> +{
> +	struct pasid_entry *table;
> +	int ret;
> +
> +	/* Only preserve first table for NO_PASID. */
> +	table = get_pasid_table_from_pde(&dir[0]);
> +	if (!table)
> +		return -EINVAL;
> +
> +	ret = pasid_lu_do_op(table, op);
> +	if (ret)
> +		return ret;
> +
> +	ret = pasid_lu_do_op(dir, op);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err:
> +	if (op == PASID_LU_OP_PRESERVE)
> +		pasid_lu_do_op(table, PASID_LU_OP_UNPRESERVE);
> +
> +	return ret;
> +}
> +
> +void pasid_cleanup_preserved_table(struct device *dev)
> +{
> +	struct pasid_table *pasid_table;
> +	struct pasid_dir_entry *dir;
> +	struct pasid_entry *table;
> +	size_t dir_size;
> +
> +	pasid_table = intel_pasid_get_table(dev);
> +	if (!pasid_table)
> +		return;
> +
> +	dir = pasid_table->table;
> +	table = get_pasid_table_from_pde(&dir[0]);
> +	if (!table)
> +		return;
> +
> +	/* Clear everything except the first entry in table. */
> +	memset(&table[1], 0, SZ_4K - sizeof(*table));
> +
> +	/* Use the folio order to calculate the size of Pasid Directory */
> +	dir_size = (1 << (folio_order(virt_to_folio(dir)) + PAGE_SHIFT));
> +
> +	/* Clear everything except the first entry in directory */
> +	memset(&dir[1], 0, dir_size - sizeof(struct pasid_dir_entry));
> +
> +	clflush_cache_range(&table[0], SZ_4K);
> +	clflush_cache_range(&dir[0], dir_size);
> +}

The PASID table is currently active and in use by the hardware. Clearing
the entries without the necessary hardware cache invalidation is buggy.

It seems this manual clearing is a workaround because PASID domain
preservation isn't supported yet. If so, rather than clearing the table
blindly, the code should verify if any PASIDs (other than
IOMMU_NO_PASID) are actually in use. If there are, the preserve callback
should return an error.

Or anything I overlooked here?

Thanks,
baolu
