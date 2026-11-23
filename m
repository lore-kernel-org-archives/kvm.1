Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406648;
	b=3QwV5YrlETY6jmqFE1E8cywmpPUtAMwF29MmariPXc5F6yyiPYt58x22irycJa7VHQGf
	 1ZjHZehibHUNKYGof0fab857fPiharGuZcamjqLehBFD3gc91EoHjxRlK/OkhHq7DydPi
	 RS6ZyQtff3VHfGuJYwv9Uxh05yyqsu8MHrB7aocXcJwObTs37rvya1KhYPFB1W+k5F9WQ
	 gASG+kai2WOpzTN7fw5svg6YareAy/+VitbUF+/XR9pBnlwOh+x7IDU3nCA4BCzc2zZjV
	 3VdAyR6snFgHIysy3UllDqtGKbnQxwMQUR7IXoW2hGjLjIHR1J0l8DcPhzbKG4SDUfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406648;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=L/ndKiHqAwsG8Q63MvIVcW/zI5TqmT0H63EXMbag2hU=;
	b=uiVXOVFTJJzVHt1sUotETFcC46MwautROnR5lTjHKKlQbAfFHmsoxSVqBvx0DwX29nyS
	 X2bsnvSQ7lN19opiCbA6dZ2rkgTCpb6aNHqHyEO+/tANjSsyON05U/dA2OILWlkScBRac
	 ggUfa4nSoujDAr1L3SYNfl3xJiXDgl5M5XyIF/62f167/lA5xL5kx3R7t3S6qmJIOsCpN
	 7GLpJYgqAPh9bGnI/oVBLlVD5LTqgxOffdgthmPaxO1GGrcZko3T9LRYESjTB9Z0gM8fI
	 uSBVfJFLDMujQu15tRI/oRqna98bsdOfbfj546oNTmPnLq1RzAZVfnCQjLMmCGAp1Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g1YBC98m;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7DF606A32A;
	Mon, 23 Nov 2026 04:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B7DF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g1YBC98m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795406644; x=1826942644;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/2JPg26k4eGPhYoW5PqQdEQbXOwMlhbiHh908evguOc=;
  b=g1YBC98mv1bhOyI0Y09bkql/vF1jYGtkhEh7ygq6gpwJap92nqBDYul6
   fb0Ah6655wj9YDq2O2TY0R7kPut/9/9XxHS4xHP4Xnperti3U1K5Y3l1t
   hmdvwobA2awFBi53lXOTC7S5VdBIkSErocOBzxjffON7q3Q8icjKZVceJ
   2eh9C3e8dqEP5Wo8ol3cRF7oV5zbJ7fj0dd6C2QG5+TE43FBvuFoJZJMS
   4iVz6XgL5S1v4aCrpE3RN0X/GMKQw0eiymiPxGsLvHOYGv6UNf5Rf/Qj7
   40gZkanZNBO5pMjekAPIIRcHL2GQh21w6PQECIItC00JImJq6q/jdlLTV
   Q==;
X-CSE-ConnectionGUID: sUZRE5NQS36U0KkJvl1tbg==
X-CSE-MsgGUID: hNst+y9ZSkSBlELJBEYBKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4219244"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4219244"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 20:04:02 -0800
X-CSE-ConnectionGUID: DRGib1DfRMmtM12iuyOqIA==
X-CSE-MsgGUID: xAJ+eoy9SSG6p9BwuMHvmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11085664"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 20:03:58 -0800
Message-ID: <70abb0ba-63f0-4edd-9359-bfd220b8ae3b@linux.intel.com>
Date: Mon, 23 Nov 2026 12:03:56 +0800
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
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, yilun.xu@linux.intel.com,
 xiaoyao.li@intel.com, Chao Gao <chao.gao@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
To: Binbin Wu <binbin.wu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-2-baolu.lu@linux.intel.com>
 <ed90de7e-6019-4d42-bc6e-5b586b460a31@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ed90de7e-6019-4d42-bc6e-5b586b460a31@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/2026 7:02 PM, Binbin Wu wrote:
> On 11/12/2026 12:30 PM, Lu Baolu wrote:
> [...]
> 
>> +
>> +/* No cache flush is needed; hardware keeps caches coherent across KeyIDs. */
> Nit:
> It's a bit confusing without the all the background.
> Once Rick's patch [1] removes tdx_clflush_page() and its comment, a reader may wonder
> why this wrapper explains the cache flush but the others don't.
> 
> Is it better to drop the comment and explain it in the change log?
> 
> [1]https://lore.kernel.org/all/20261015191710.3632302-2- 
> rick.p.edgecombe@intel.com/

Agreed and updated.

Thanks,
baolu
