Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580865;
	b=PGt8Hb+XPZ/scYRwnDGVEq6Jrbp42BjsqM0UEKW8Auq/Vx9WRS8G9de5N/p9kxUrSarh
	 xYltKqty+XZ6/7hZyxh4tvhclLgguZjIc8L6lQ4qRp+C65Yd/FrkJHxrsD3cop3jE5GDB
	 6ZIqh8PuyROcQ2hc6qQ5noAzsc8YOWU/BKJ1qjO9ClVDAVkZxkp+2jQK/9DcTjJDtcJE5
	 QhEdqhdUCPQ6qKsLqYZaOzJE/3gsIteMS/HicvKKBPvPcITHq9YJTKCBz0NjkBnAkFI2f
	 h8ZZ9RENUGGEWKZfLUI30bB0LX7BAjlqQNqQQj3ynRTOC7arF4O0SDQ/bVTJS9xykRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580865;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=nVpT+yraa1yVDO8OUEHZEK0jQepG0L6bEBsfuNb+iGI=;
	b=Rw9VLpp6Hsu3n6ISKRga8NKa6a6fz+TIELRSy5V7DqTJT7VWw1uI2zR7rZDiwRhNJRKI
	 4GbmQXZiIN4LGfuxKA8fF0Ssy5hVuWPCauI4TyUIsQVIwCRXqvYSWfGzsbg6y50mIjCnO
	 Gv+YIfb5mWh3xmww51bqi/f8m4dN3v5S4tlu9yd1+Vfkrh73JyPDZljHfGo5Gz9orcIg2
	 6w03fm9Ybmgkh4Wtes5PARc+SEwCbU9ixzhJu06uL9z30pKOn//FiL+H6e3mBL0Q0aCJe
	 cO667HgmLJ+L+Rnmo7gyCCUZjOd6oGktdFF/ZuK1q6uBb6bxvcVRaausPl3T7mli7ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=max3s595;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572A1606A323;
	Wed, 25 Nov 2026 04:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 572A1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=max3s595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795580865; x=1827116865;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S0QOwBRZ6Kla96s+DysG5kGhzedqDXrOzukPb4PwcwQ=;
  b=max3s595MZiT93/eoaSvwXmLN+AmvzHMI3gwJceROHc0GK32jOalxpiH
   drrFz2JaeJ7RMmTjNtXZ2f38t2RKegQDrAp9f4wabbmLuWAJagTOEbeD7
   eEgh7WJuRQE74GkxZWRCPwDJsp6IAlB2JahrUCU3NhzS12Q9c1PeeyFIY
   PJQ3FmGGEQ8bHzdo08dnAWcnlUVzqdp09lxv5i0sSDeK69o0fBBx6knmc
   k7EZVfowY3cvcwt68wVpich4swUMTKB2dqHAfUruO9JgcDOVnl82xZxM7
   Y4o1vAKIEI/vgSsJ96vDOgTStD3pZsGhl9zy1FEacobRIB4ahWDOSnl0g
   Q==;
X-CSE-ConnectionGUID: dkIWpmPhTDih5Xmekx/oVQ==
X-CSE-MsgGUID: ZrWWg883RHe8U6RsFOvgiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4344767"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4344767"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 20:27:22 -0800
X-CSE-ConnectionGUID: 6cAE2U3XQ5KA5qmCb5h2Nw==
X-CSE-MsgGUID: eXgbEvJRSz+i35YH+AbkCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11747849"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 20:27:02 -0800
Message-ID: <9da20e39-4168-433f-a48e-857c1196bebe@linux.intel.com>
Date: Wed, 25 Nov 2026 12:26:59 +0800
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
 <8ef35412-44a1-4fca-8ba2-06bbad367b22@linux.intel.com>
 <CO1PR11MB4835DE6974C89C303A8C2B658C432@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB4835DE6974C89C303A8C2B658C432@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/2026 11:08 AM, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Wednesday, November 25, 2026 10:47 AM
>>
>> On 11/24/2026 4:07 PM, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Thursday, November 12, 2026 12:31 PM
>>>>
>>>> Intel VT-d hardware gains a second set of DMA translation structures,
>>>> managed by the TDX module and used only for devices assigned to TDs.
>>>> Each IOMMU has a trusted root-table address register and a trusted
>>>> invalidation queue, both accessible only from SEAM. The existing
>>>> untrusted DMA translation path of the IOMMU stays under host control.
>>>>
>>>> Before trusted DMA can be used through an IOMMU, the TDX module
>> must
>>>> initialize these resources. TDH.IOMMU.SETUP does this: it puts the
>>>> IOMMU into Secure TDX Mode, programs the trusted root table and the
>>> s/Secure TDX Mode/TDX mode/, across the series
>> Secure TDX Mode is the term used in TDX Connect ABI specification.
>>
> Can you double confirm it? I can see two "Secure TDX Mode"s and one
> "TDX Mode" in the public spec. so it's inconsistent.
> 
> Then from the internal ABI spec, still two "Secure TDX Mode"s but a lot
> of more "TDX mode"s...

You're right, the spec isn't consistent, and "TDX mode" is clear enough.
I'll use "TDX mode" across the series.

Thanks,
baolu
