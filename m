Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407005;
	b=3ABaOZnGUXg6+eWRfXBRH99dorhLHryLlSXLHZvGanqClfowqa5lWUKmsesU4GPWvVTs
	 IdM1Gzb2uiXEDz8WKbarUANT1y23rKYdlkr7AfsWKS1Kj+9RULPnFjsYNxCnbav0GhUlz
	 gHiBwQFV+CWFLBOl92Ojd9J3Isls2nwfPYJgjdTRs8v2pdVe3sFdE9rcadcR62cdnrhSv
	 COdFsibgNXefFh04ye71u8tMbmXVhU6boXui2Cl9TChWbnw6O26LHHZ0LRnyTHVpVHT3s
	 OWqruXbHETZ4PBLV5iY33YWMP/fV+cYhmRZGT58VX3tgG9laXUNVMNYcDztlNa4QR7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407005;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Mx1n/5e7VpS7gsTuSykTI7NgsVmEhfB+HEH46dRkddo=;
	b=D5pitBa/fXp9gX0W5NX48gXiD2OhwK2RNJjEimMUvwfKX5VlJuWSwRtzvlvVyDwhCe3t
	 +kCQ+Tq5r7bEAP6Ovx0KHAB2BkBF9AZAUp/FoIaN59GmF6OodEHg7plhN8FUa3z5cshkF
	 5V3B4FkNHWdtjA8t2Z959cVfihc5XXr5GS6gG8G/FyugADr6zh0soUbcOEIxhZXX14Hn5
	 qTXhxu0xv1rspusL3TRkoGCZirK3mL2pm9BJVay6/29iAkxqpo26pilyjM2txFoqB9gJ6
	 NxbXuyDSDoIQ1dFGJs82bOAYLxkKJw3dw81feE1IDdR3OimbBsQfto6g/Dd7gjA+fUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RDCM1A+V;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A86606A31E;
	Mon, 23 Nov 2026 04:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2A86606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RDCM1A+V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795407005; x=1826943005;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mx1n/5e7VpS7gsTuSykTI7NgsVmEhfB+HEH46dRkddo=;
  b=RDCM1A+VC80V9VEJLaBFraz8Z01p8ttOWJ2dnTIa2NWVLDX3HdFfmgyR
   jkEBB3fM3xt9M6P5oKQ4GzXqgoURL9/MiYPbpo/mzjG21mMNaBaxmOaOa
   yfIvnkSeG7R7TbMRh4cpbyFpchOLT1K5KcFbB6X7IU4vxttE8iv5Q6J3E
   wqnu0vPKYWohuGgtDpSRNvotwYLpB77A/Jsf2WQTkaaHMg3CaZSZLSoCC
   bJGrZY4FTTqfbx9h5oTTLeV0xL65lvZGflLN1tkBcCxinelCHjV868I3g
   rKuLeL4OApUh89F7b6wCmSI2ypxpPT7v2borG2Cq78BZSixTnjFGcBGbm
   w==;
X-CSE-ConnectionGUID: IaO+PrrVSWy8T/aIpHp6QA==
X-CSE-MsgGUID: hj3pIpO2QZOQw2/M593bnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4219539"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4219539"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 20:10:05 -0800
X-CSE-ConnectionGUID: d3caDCUYSjGdp6soPZQ3XQ==
X-CSE-MsgGUID: YlHLHHteTHyHLDISXNhA0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11087055"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 20:10:01 -0800
Message-ID: <158ce0a3-3bd7-4be6-89e7-ecac25027404@linux.intel.com>
Date: Mon, 23 Nov 2026 12:09:59 +0800
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
Subject: Re: [PATCH v3 2/9] x86/virt/tdx: Read global metadata for trusted
 IOMMU
To: Binbin Wu <binbin.wu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-3-baolu.lu@linux.intel.com>
 <f2c46640-959d-4fb6-a313-0f907c127414@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f2c46640-959d-4fb6-a313-0f907c127414@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/2026 9:39 PM, Binbin Wu wrote:
> On 11/12/2026 12:30 PM, Lu Baolu wrote:
>> Add support for reading the global metadata of the trusted IOMMU.
>>
>> The trusted IOMMU feature is optionally enumerated via TDX_FEATURES0.
> Nit:
> The feature enumerated is TDX Connect, I don't think they are interchangeable.
> Trusted IOMMU is part of TDX Connect, right?

Yes. I will update it like this:

Add support for reading the global metadata of the trusted IOMMU, which
is part of TDX Connect.

TDX Connect support is optionally enumerated via TDX_FEATURES0. Check
this feature bit before reading the metadata to avoid causing the entire
TDX initialization to fail on platforms that do not support it.

Thanks,
baolu
