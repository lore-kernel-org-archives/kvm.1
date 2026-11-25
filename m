Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795574842;
	b=ZrKyKqztMSGK9xy1pm3DfXPOIikNXb3KquNGJALLjz/g7KS5tn1bPcBve5Yyr1BkXaYv
	 E3gi/q9cdqWcYpKqVY9NNSN1hmJ+2kBvN4PYpOdveYqpgVssZNuKHEvWol17KtiuYyg2P
	 f83UUMGjpx3P0WaoOXAMlnHm4bAo/3iUtzg//1Z08oil9aFnVN67YFWvKFuOCzFCk16NI
	 5/wMaLvgExadh5zXCGB9tCi4mxSG5Zs+xTFZ0QioarYIAMkRhOPnP83oXZa418LTMW7tE
	 mp/wqFg062ZyaTVLXAqdCXVBWOiGkBl1TxrkE8TJXiC9smFm9PLgo7bxL5G+P6F2lVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795574842;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=z9JDbde/cXF4XJwReg+HOems1VqaGbHn69aq5xTrCqE=;
	b=LUYsV4puDmhtXFKgZ8ihSwNUy6wQFn0Ydkn9Noc9JFqXQytC7bIsBk1kS54zdrUhYRwV
	 x3s97kRWCENZUltFwZiTH5qFLBLtKRFprtnxWERc+teg7eu9WbX5GukPJkBDVAdHguYtS
	 ai1F2YL6aCYvq5uY9nX07YQpEqZWmxgKEB+AsLXMuFxXy+C253MQr5ZnOBZMoLQTwe2fu
	 4RclQfrP4++jzVlq6aeFK8rmn4/BpGG3k4eyTEG/+ZYwJnw2I1j6TxPcc8HDaXmdtRLYW
	 8AKCCMT7ShPHC1Z6w+TwuWkfgWtJXJ/LfVVHB/72w/X+9KBYx+FN1oM//3LYYzFdB3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=btXTmNqm;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A254606A31E;
	Wed, 25 Nov 2026 02:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A254606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=btXTmNqm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795574842; x=1827110842;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bIWbjkSwt14UlfiTHh+BSFDnRyyXRUaOpT7+UMvcQVY=;
  b=btXTmNqm7SohNrwJhjNJPpv7Jcr39AKgBLGyhePiEPigjHRHoz+McKk8
   CKG3IV/gE0VQ70qdIAv3ZoI9TkvfNc93VTUAruoA9Di04ogTu9ffE5Hbp
   YUkzkp8LBpWYOamSPxbYWtDwgaR1j8dPc3ulNf+HS8Om0eeQsa7n9Ygwk
   5oM4JkDv0Q/98f2DNehMQjxcTI0IaE3q+ItTtfXuMxiMA2jY+5rK2nTsj
   Wg6oRVbOgH/aVBTxIrNlakpnvOn07+pzRsQ8sQI/5TK5nMGDl4Pz7Flel
   j+EdFxWxvVBNrrNl1WlwNE7Kt2meBIOSAlQtY7YgV6oCfoIShXq49DdjE
   A==;
X-CSE-ConnectionGUID: tErBLvIDT3qJxYHkQJaAsg==
X-CSE-MsgGUID: HyZNCITdQzGPnm5uDX9DTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4330514"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4330514"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 18:47:21 -0800
X-CSE-ConnectionGUID: AnU/EaElRhGYP22+6VFGmw==
X-CSE-MsgGUID: 4+etw+juR/qydXcwZgDt3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11868933"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 18:47:12 -0800
Message-ID: <8ef35412-44a1-4fca-8ba2-06bbad367b22@linux.intel.com>
Date: Wed, 25 Nov 2026 10:47:09 +0800
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
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kiryl Shutsemau <kas@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-2-baolu.lu@linux.intel.com>
 <CO1PR11MB4835FD5EB44EB94467A82E5F8C442@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB4835FD5EB44EB94467A82E5F8C442@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/2026 4:07 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 12, 2026 12:31 PM
>>
>> Intel VT-d hardware gains a second set of DMA translation structures,
>> managed by the TDX module and used only for devices assigned to TDs.
>> Each IOMMU has a trusted root-table address register and a trusted
>> invalidation queue, both accessible only from SEAM. The existing
>> untrusted DMA translation path of the IOMMU stays under host control.
>>
>> Before trusted DMA can be used through an IOMMU, the TDX module must
>> initialize these resources. TDH.IOMMU.SETUP does this: it puts the
>> IOMMU into Secure TDX Mode, programs the trusted root table and the
> 
> s/Secure TDX Mode/TDX mode/, across the series

Secure TDX Mode is the term used in TDX Connect ABI specification.

> 
>>   }
>> +
>> +/* No cache flush is needed; hardware keeps caches coherent across KeyIDs.
>> */
>> +u64 tdh_iommu_setup(u64 reg_base, struct tdx_iommu_mt_param *param,
>> +		    u64 *tdx_iommu_id)
> 
> No context why talking about cache flush here.

The kernel normally flushes the cache when handing pages over to
hardware or firmware. That isn't needed here because the hardware keeps
caches coherent across KeyIDs. The comment was meant to show that the
missing flush is intentional.

Thanks,
baolu
