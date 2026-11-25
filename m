Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588280;
	b=YXcO+XDbI/pbEfXMq6jyPH1+5hC2Ji4/NgxQhVY6XSWB4pgS143ytbDYnnizZqjFrKy2
	 3l7HUrQ40FS/uAUPwpGb+v3TDZmuMcAz5Azw1nPl4tMtQ5bz7jsUnf7DWNj30gplXNVhd
	 ZAYGqM5WdpWeWaTalNl3z/wlXA7dOkLbjsF7Y5kq6apAilFgPnoaAE273C9HB/nAeWl9/
	 BdyzhMPT84/yIZJdV9cCQSNuafiwUDgt0xryIi5BomwYOuf9jrhJWurGnoCdjwEtGj7VI
	 e0M66xZgh+wOMLXbmsKkpHT2wCTORp4FzvSQ/vvH53ykuOBpoUwBuOeloXS5T965ZBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588280;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dNNow8pU0EgspMEvDUxBJ5a9af5PUjY1loG/b00zoNY=;
	b=yNEmABX0zFcxPkaV+OEZ6k/2N/8DsSz9ziOtl2QcRoSjZM72Axubn9kyNoDaZXfn/cVD
	 uDtl3JrvaZ2vpzx6Bwo3vaH547VSTj0yGeBA+2g1Mc5bPGzSE+ehvbBJFr8urcKl8fvPM
	 r+x1xxK/OcUvXYk2gBLx4n9NTTTyvR7nGxW60zcvbWiloNOW8mLMwULimYcAqj52vzmnv
	 YpjAggwSRqvaW92tSmBg5IpMb5gvYllzEHHlx713LgFlr2j9v3NiaHTP6pPpnQLgtAOKi
	 VGl4LZsxgMaZ3hjho90Dhvdu734nQHTPE03fDTesw4boYic9OmB+3IfNHAXlNOVYMVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=exhRYpub;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048E606A31E;
	Wed, 25 Nov 2026 06:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5048E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=exhRYpub
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795588279; x=1827124279;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AY2ItQH4n8SPEJWuIkbJCQ/t2DnGTrUZX9TmGLTjYU4=;
  b=exhRYpubCZ4B+/4KTnFLkQmefLLvP6RLLTXN7FyOpiUqi12aoBv3askV
   ojeAVGigb2wIQxpAyzqSxJolpHe8VVS+wCur0UOMdz/AdRV4QxD39lcXg
   6YOXvo7UwbrUH3qUptK2R49KQVR/ORNks1JCvvIVFUlMb6Enjr8paLFYu
   b8uqZ7p7cex5GkMFYv+vZAeeQNgFHwalSWxZ+2Nc3vHtosinWIKsMkXL7
   cVo8yi+nEmJlKH4CvfEgwdwAvKJcx2mwId4HZW/NMd9CX6f/FRiVN/rAn
   GtzRYKuYc6MuPQjHYgoMstmmVC6YmNVvUAliJus2rX+DvNJTkhzV5Lx4v
   w==;
X-CSE-ConnectionGUID: h7+MUX2dS9iQUFACLDt2pA==
X-CSE-MsgGUID: kronBU0fQsa+1hkWLBk0Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4467694"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4467694"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 22:30:11 -0800
X-CSE-ConnectionGUID: Xa+KThYJQ/mz0e8mRQ2i5w==
X-CSE-MsgGUID: 4vr1ggl2Q1GgBnGRFyzm0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11891600"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 22:27:06 -0800
Message-ID: <9ce9d375-4a95-4e00-9d62-d6a0b2875a2d@linux.intel.com>
Date: Wed, 25 Nov 2026 14:27:02 +0800
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
Subject: Re: [PATCH v3 6/9] iommu/vt-d: Refuse system suspend while acquired
 by the TDX module
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-7-baolu.lu@linux.intel.com>
 <CO1PR11MB4835B7CA0A21EB68A2034C108C432@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB4835B7CA0A21EB68A2034C108C432@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/2026 12:01 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 12, 2026 12:31 PM
>>
>> While tdx-host has acquired an IOMMU, the VT-d driver blocks its GCMD
>> writes. TDX disables S3 by clearing acpi_suspend_lowlevel, but that is
>> only checked after the syscore suspend callbacks have run, so an S3
>> request, e.g. "echo mem > /sys/power/state", still runs iommu_suspend()
>> and then iommu_resume():
>>
>>    suspend_enter()
>>      syscore_suspend()
>>        iommu_suspend()                  <- runs on the acquired IOMMU
>>      suspend_ops->enter() = acpi_suspend_enter()
>>        if (!acpi_suspend_lowlevel)      <- TDX's "S3 disabled" check
>>            return -ENOSYS
>>      syscore_resume()
>>        iommu_resume()                   <- runs on the acquired IOMMU
>>
>> Register a PM notifier for each DMAR unit that supports trusted DMA and
>> refuse PM_SUSPEND_PREPARE with -EBUSY while the unit is acquired. The
>> suspend then fails before tasks are frozen and before syscore callbacks
>> run.
>>
> 
> what about directly returning error in iommu_suspend() if any acquired
> IOMMU exists? at this point all other processes are frozen so no contention
> exists at this point.
> 
> or introduce a new flag or counter (intel_iommu_suspend_disabled) which
> is set/cleared or incremented/decremented along with acquire/release,
> then just check this flag/counter in iommu_suspend().

I'm fine with this. It's actually what I did at first. The only downside
is that iommu_suspend() runs very late. By then, every device has
already been suspended, and suspending a device that is assigned to a TD
may affect its TDISP state. That shouldn't be the IOMMU driver's concern
anyway, so let's start with the simpler approach.

Thanks,
baolu
