Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859051;
	b=lLg7mbabnXqLq2fCV04NpBUvD7zJnqAtMuQYYsI2TLgfqb6cE8IZNFemYNnoRmgZOaOS
	 3uLSqGRm6KfaOiO3KaLiugSXPMeO9V8s0BwcIZmFQeudxGXNjX/Od6PwOcadQEPH8yvyu
	 4+mRR/YVdp1X5uaVEEe7mGkrAwze66CUg1wmtu4d9uxR/g8xqVFhQ90TYrmnIgsceHa2q
	 sINwYC0DyVFWB8h0wmq6+gF7Xij8/MPd6q+R07inO3o9Zuk9WaaGl4qnPm1CXDi7c09Dp
	 zFSzohq5biMNQw2uYi4KmD/iXpNQj/HFtn+ylXZy58t9Jti1kHrnmAikkLuxdFbqXYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859051;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+5BTrBne3OQ1DvExgeoc8tKlSX9T8xOtBCF+DWKH+FQ=;
	b=14AtpHR3bdE2jfQKH68GAMTFSxt9lbeFQgwRHExd1VdXbRERM+7hXL9dEorJ0gpfxLSR
	 vuEYb/Dk2gPjblxY1i2MBz6Hdeh31EaiCQTHXlg+yxEXpfyjn/DHhNfP2ZnRAtH2Pp4Ib
	 QMhRXc0Goi4c5s1aXJ8EvTJvBOZJR+GSJxCQRFPqta/QyENz64c/1HScZOOv15oodvZKO
	 Q03V2STVhEviN+dSom+RR+LHiiz8zaph9NpqtYuQpep6j/it2AEKkYwogcfwGYeNDsFcF
	 aXVCx+OUfaXODKafJ7/0zPBNNIKF/pwIFGvMaZknLkE5CvhlOjEP64JpjOEDFGaox8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="mbdQ/Jn8";
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D65606A326;
	Thu,  5 Nov 2026 06:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96D65606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mbdQ/Jn8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793859051; x=1825395051;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=baB3kBDGVPEF+a5Is1SFhYiKMmbqMXCz7Q2FtU0s8D4=;
  b=mbdQ/Jn8gFZDv7m2fUMJ3pVxdKyqBgBUARfAUyCobuI1/WDkPFPaZho4
   ENI/vR59xRtYzSPoRlbo+YSu+ZXkj3TnJC0w9uxteXNEQ7h3MPoCLssgb
   ZlHX/TTVD29AUf50CF+RQ4Y0P2sQlahTolvXaEJ+QoJW+KEAdQ1Yyvk+6
   4QJc99LIDTndn5uTIpjZCBuVAtAAjzMsseKxSFlHdj2LtxoxpN1bdLMe+
   O0S4CDFoASpHPt49sezM/LYplWwV/79UY8c/LPd+AqsRRMdbPZIfsmCSM
   kimSq4OU3R3+w0cONeicUVD9XP0wpOHAHH/MGnLHIgH6/DQfw2rJy4x8P
   g==;
X-CSE-ConnectionGUID: 5UFDd77BQ8ysJsKyCF6MSA==
X-CSE-MsgGUID: 4MT8Ke5hReiyJsgaa6qGoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2672475"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2672475"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:10:50 -0800
X-CSE-ConnectionGUID: 2YwIL/d2QmiYsRKmhMHdQg==
X-CSE-MsgGUID: pj4yiNuLRi6ZKOjNbx1kyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="8688640"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:10:46 -0800
Message-ID: <f60d1d10-b2cb-465d-8588-a61d26bbd648@linux.intel.com>
Date: Thu, 5 Nov 2026 14:10:44 +0800
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
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Kiryl Shutsemau
 <kas@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050> <20261015173707.GV14213@ziepe.ca>
 <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>
 <CO1PR11MB4836E2CB05E1448BB42047458C9B2@CO1PR11MB4836.namprd11.prod.outlook.com>
 <23a3c630-a3ad-4874-b13c-b8795cd194a6@linux.intel.com>
 <CO1PR11MB48354B1C84A6BD16CA2FFCA88C652@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB48354B1C84A6BD16CA2FFCA88C652@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/2026 12:07 PM, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Monday, October 19, 2026 4:12 PM
>>
>> On 10/16/2026 3:17 PM, Tian, Kevin wrote:
>>>>     - The TDX Connect architecture places requirements on the host
>>>>       iommu driver while the secure IOMMU is being set up. For example,
>>>>       the host iommu driver must block the enhanced command (ECMD)
>>>>       interface while the TDH.IOMMU.SETUP SEAMCALL runs, and it must
>>>>       reserve the upper half of the domain ID space. These steps have
>>>>       to happen atomically under the iommu driver's own locks. As a
>>>>       result, the Intel iommu driver needs to merge the two steps above
>>>>       into one.
>>> Didn't get this. Both ECMD and DID reservation are TDX specific things.
>>> How are they related to the two steps in the ARM sides and why calls
>>> for merging?
>>>
>>> and why are they must be done atomically? they are conditions to
>>> execute TDH.IOMMU.SETUP, but it is perfectly fine to reserve DID
>>> at an early point then block ECMD later...
>> You are right, "atomically" was too strong. Only the ECMD block has to
>> bracket TDH.IOMMU.SETUP. So I plan to restructure it as follows:
>>
>> - dmar_tdxcs_init_prepare(dev, &params): resolve the device's DRHD and
>>     take a reference on its secure-mode state. For the first user,
>>     validate the preconditions (TE/QI/SM enabled), reserve the upper half
>>     of the DID space (failing with -EBUSY if any of it is in use), block
>>     ECMD and return what tdx-host needs (register base, NUMA node, etc).
>>     If the unit is already in Secure TDX mode, just report that so
>>     tdx-host skips TDH.IOMMU.SETUP.
>>
>> - dmar_tdxcs_init_done(dev, result): unblock ECMD, then either mark the
>>     unit as being in Secure TDX mode or roll back (including the DID
>>     reservation), based on the SEAMCALL result. It must be called
>>     whenever init_prepare() returns success.
> We should continue blocking ECMD after the IOMMU successfully
> enters the TDX mode.

Updated.

Thanks,
baolu
