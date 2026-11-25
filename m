Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575471;
	b=AaKqAuj4OIILtWAaJ31dt9Qlc7Nu5QyGPthViOwtbgtVdPZjrqoQx4lmrH/V1mjlGBVC
	 9D8XF7rJNFCRQgpuRK+rL11WUys9xDda3/2Q6DPtMR6zCX6rjYpQ1hy3Ud6LxSxlFEx2y
	 IO6mjzinOnWUK7QZ6XH/6DswZ8Ux+PY9d6bZ7DAgtMYl9IVQjUuJO15VnxmniE2gdxevm
	 OxPArib8kQf234FG4SPorQzz6W+3tGiYYplNjajZhz6Ua/kkxll113eg/8ZVm0cJANq8W
	 ZolXu65hM35q1x+8M/jUSV0xnKIJ6ZB8Fn3fmu/J3uJ1UaSQB62g0zNp4bGQ8ceztoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575471;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=DqdH48qbeeTIPU/MMal9aRyucQ5S+jscMJXwGqSYhak=;
	b=1qApcMQC6kXpYyq4EvpMVexJb1jmmWgycbPcIV0drNx4Y58hqq+cGg9G4hSSiw8+2aAB
	 q4Z7x/ec3QV9BFkGzltr72ypSrK9wGiSOadwqa7qkE8EB4z3cGq+tO+vfcPt08MdW1itU
	 f8mEHBfUQh3428XVeh+Ov25YGjCarGzL0roeLcxjWIgGhAESM90/MFPAIEOeUpE85ahgQ
	 OZboQ/tke3TNsiaYLmaoYo2t/qyeCOhMHcfkTYVJ//odCAW4X6YrG+TNfETnOV10qEi2V
	 u91KEq3wr00dU+VwgskNEUNW4a2RpUjjlmX++/ssxfeS1H1usPntPTmPhTCaWWkJdYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fpmd9S+W;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE95B606A323;
	Wed, 25 Nov 2026 02:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE95B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fpmd9S+W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795575471; x=1827111471;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hBXaaSjSnIZ8q+a+Q1Y+asuqrPnvsTtRyx/khUd1WI4=;
  b=Fpmd9S+W7cIr1VAcDni/Yg3s+lfn3WilqhRQVjEohcXxR0+rShyAN+E5
   rDUgiJRbB0l+Fi3Ns2+KzLojgJn6RJ3VOBcC0yej6N2pVjjGjbLSXX3GA
   tz6TLAU6d9D6ggzcKX/lPUeNaEAgKhrn9k0i6bQ+yXzdrTSypn9+ATzes
   Q7b5S+cczy0zyEp8AhIJ5ct+pv3ahDFMlMNWy51NW7RvZVx9W59cTVVbx
   I1SWE3YWmNz1hYIjTtissYjqAnDEAQ1thdWEkslsgdrFspVKdxtvQ26D6
   HBRUWRMEutMCk90DhmKNbcEAtql3FC+7SCGVjB7lCc2ItdDdNTFfDst1w
   g==;
X-CSE-ConnectionGUID: qUBb3aReSfqlkA14mR3KQg==
X-CSE-MsgGUID: gp88YJg9QCu1KDobzlRO0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4339248"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4339248"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 18:57:50 -0800
X-CSE-ConnectionGUID: XIQPsWwYQIy0N1gzI8vwlA==
X-CSE-MsgGUID: ldw1n/tdQgutvyocEUZdDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11529710"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 18:57:47 -0800
Message-ID: <b069428b-85e1-4aa4-a53a-d7baf43f629e@linux.intel.com>
Date: Wed, 25 Nov 2026 10:57:45 +0800
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
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kiryl Shutsemau <kas@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] x86/virt/tdx: Read global metadata for trusted
 IOMMU
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-3-baolu.lu@linux.intel.com>
 <f2c46640-959d-4fb6-a313-0f907c127414@linux.intel.com>
 <158ce0a3-3bd7-4be6-89e7-ecac25027404@linux.intel.com>
 <CO1PR11MB4835BE5970A03254F7B0BE518C442@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB4835BE5970A03254F7B0BE518C442@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/2026 4:13 PM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, November 23, 2026 12:10 PM
>>
>> On 11/18/2026 9:39 PM, Binbin Wu wrote:
>>> On 11/12/2026 12:30 PM, Lu Baolu wrote:
>>>> Add support for reading the global metadata of the trusted IOMMU.
>>>>
>>>> The trusted IOMMU feature is optionally enumerated via TDX_FEATURES0.
>>> Nit:
>>> The feature enumerated is TDX Connect, I don't think they are
>> interchangeable.
>>> Trusted IOMMU is part of TDX Connect, right?
>>
>> Yes. I will update it like this:
>>
>> Add support for reading the global metadata of the trusted IOMMU, which
>> is part of TDX Connect.
>>
>> TDX Connect support is optionally enumerated via TDX_FEATURES0. Check
>> this feature bit before reading the metadata to avoid causing the entire
>> TDX initialization to fail on platforms that do not support it.
>>
> 
> let's not introduce new terms here. TDX Connect is Intel's branding name
> for trusted I/O. Intel IOMMU introduces a new TDX mode to support
> trusted DMA for trusted I/O.
> 
> so here we just read metadata of the TDX Connect feature, which includes
> information to enable the TDX mode in Intel IOMMU, blah blah...

Okay, sure.

Thanks,
baolu
