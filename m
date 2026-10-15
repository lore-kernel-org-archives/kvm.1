Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7F3C345D
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 05:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043935; cv=none; b=sr0z63WtmmfRSkGvzqpa50WZvr7O1L3HzPLvXJVD31tYLqe7cIE+b8stb0dfUIEZosAtKgI54rBvCUrE5qJpM4AWJmIGH1xIOF3NlVyqlcGQNYB4skNomh2mpI6SlZP3EBRkfpqXi+0zqL6Pl8jR1+uohHjYp2n2PvdDvmPjuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043935; c=relaxed/simple;
	bh=Rumt3rawfRGLPEcwZOpRtwg8iUEMob58Xkt+bqJJ6ew=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c4CgXr4B9MSdm3N6MSBT2wVXy571/u/aFC9FoyaeHv/Q/CPD6ctILFB8rJ07az8sUHK3NPnPAVhNRfDVvbwm7KcMtfNSAWyBmlx8g6oHTxnOcRCahU19aINeIZdE84INN4YUk9egXSTw9Q7ojig861e2HpuJ2x7gXQzyUV3nmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAFrqwOQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAFrqwOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792043934; x=1823579934;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rumt3rawfRGLPEcwZOpRtwg8iUEMob58Xkt+bqJJ6ew=;
  b=fAFrqwOQfohSxCypS+9JMdaUqAMzeXGjNI6pBm7tnV+d/im7vF4cizkh
   pXutigSHkwecnxtjlWZYN8rz6sw0795OByHnOMm5eNfXFDV1pyTUgEH+H
   WBfl4CJ8gAlNCn+SP+6wkt9M4Gj/4Lv6JuGZubo/UbE7ZAiVE6v50V8qx
   ydchDlq+9JZQPMNqa4wx5LlLMqZoPattHdmDtKcnvgutYgyWapetP22RT
   Q/MYBnWjZECdlOuiqXgsVtPzdUs1VIMbkRYbT2qlDCbR0HOUwthZTt88F
   3PpJBDYrjF6CBdIYZviwsODTT3wqxl/kw0TOsieQO1pErdkr1s4+kBrs1
   g==;
X-CSE-ConnectionGUID: 8gq7DVJfTAaHuPaollzbHw==
X-CSE-MsgGUID: fje+z+tKT9KsjnuwBOLDUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="814511"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="814511"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 22:58:53 -0700
X-CSE-ConnectionGUID: dJZyUifzQtS690Ij6QpqYQ==
X-CSE-MsgGUID: JSnbhijjSIuvcQcoPxGi7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1952941"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 22:58:51 -0700
Message-ID: <a4f077a0-8b34-4eae-b5a0-567c706d0378@linux.intel.com>
Date: Thu, 15 Oct 2026 13:58:49 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <sashiko-outbox-172095@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <sashiko-outbox-172095@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/2026 9:31 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] virt/coco/tdx-host: desynchronized host/hardware state on xa_insert failure
> --
> 
> commit 83cda44603ec97cb10640905999d9a617eced100
> Author: Lu Baolu <baolu.lu@linux.intel.com>
> 
> coco/tdx-host: Initialize trusted DMA on all capable IOMMUs
> 
> Assigning a device to a TD for private memory access requires that DMA
> from that device be translated by structures the TDX module controls.
> An Intel IOMMU that implements the trusted DMA extension provides a
> parallel set of translation and invalidation resources for this purpose.
> 
>> diff --git a/drivers/virt/coco/tdx-host/iommu.c b/drivers/virt/coco/tdx-host/iommu.c
>> new file mode 100644
>> index 0000000000000..a80e57bf26a12
>> --- /dev/null
>> +++ b/drivers/virt/coco/tdx-host/iommu.c
> [ ... ]
>> +static int tdx_iommu_setup(struct dmar_drhd_unit *drhd)
>> +{
> [ ... ]
>> +	state = no_free_ptr(iommu_state);
>> +	state->drhd = drhd;
>> +	state->tdx_iommu_id = tdx_iommu_id;
>> +	state->mt_pages = no_free_ptr(iommu_mt);
>> +	ret = xa_insert(&tdx_iommu_xa, (unsigned long)tdx_iommu_id, state, GFP_KERNEL);
>> +	if (ret) {
>> +		WARN_ON(tdx_iommu_clear(state));
>> +		kfree(state);
>> +		return ret;
>> +	}
> 
> [Severity: High]
> If xa_insert() fails and tdx_iommu_clear(state) also fails, this code
> unconditionally frees state and returns an error. Does this leave the
> hardware state desynchronized?
> 
> When this function returns an error, the caller dmar_tdxcs_iommu_init_all() in
> drivers/iommu/intel/dmar.c restores iommu->max_domain_id to its full un-halved
> range and leaves drhd->tdx_mode = false:
> 
> 	ret = setup(drhd);
> 	...
> 	if (ret) {
> 		scoped_guard(mutex, &iommu->did_lock)
> 			iommu->max_domain_id = ndoms;
> 		...
> 		return ret;
> 	}
> 
> Because tdx_iommu_clear() failed, the physical hardware is permanently left in
> Secure TDX Mode, but the software state now believes it is not. Will this
> cause hardware faults or fatal domain ID conflicts when the host attempts to
> use domain IDs that now belong exclusively to TDX?
> 
> Unlike tdx_iommu_disable_all() which safely detects a clear failure and leaves
> tdx_mode true to confine the host to the lower half of the DID space, this
> error path completely loses track of the hardware state, breaking isolation.

That's correct in theory, but I don't think the extra complexity is
worth it here.

The path needs two independent failures happening together:

  - xa_insert() has to fail. In practice that means a small GFP_KERNEL
    allocation failing, or the TDX module returning a duplicate
    tdx_iommu_id, which would be a TDX module bug.

  - TDH.IOMMU.CLEAR then has to fail on an IOMMU the TDX module set up
    successfully moments earlier, with nothing in between.

If both happen, the system is already badly broken, and the WARN_ON()
makes it loud. Adding more tracking just for this case would complicate
the code without making a working system more robust.

Thanks,
baolu
