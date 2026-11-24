Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500778;
	b=JSlBMeE4V8kAYqek9TZa03mESpk0odNdXjTTs+hvx/cY0cwQ3lQhrKbc8i7utPPnXzCc
	 DnMjpEwUx3mVBA5dAbrcUdXhzc6swaM25FoZ5OmtWqGCNiIagbe7r6Pl7yRupG4Havlp9
	 uRXKglcMoxtD1MPzpt/B6LaAsNReoyQyofOUwpR2rj78NwmfPwNMbM0W/fltP4VALG+ZT
	 NppcDrGZ1GZGfFJ3GUkex3/EVyVAupo7gIBe8xufWn6gN0WuJGOcJaKHE6svmbGlV+16U
	 K/D9III7nleTwD37ugBCnshPq0jw28kaEMHJWyDAS5UfsXuu1OApuK9iGIobZpQM8/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500778;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QzdUh4XotWO4fMpwdWgdpxjmPXBWaEs7LRNsn6Vs8uc=;
	b=GcBxzxL4RFNK8ccpLfANJ6SJ1HGWoRf42DowE6G2ND1fJ/w8aFtIsYJkTod/5Kq8R+sb
	 nMQDDWWH6rAPEfb6rLdqE/Sm29RRxU317lRB+qOTV81RqwhuZjM7lb5BxisC+A8igFu4Y
	 bHPdRnM+3ur3NEax1047oh/0JtZtKIAwFfSmR44EWQ8QzY6r01xIi9NKEr3a0w6lMZScp
	 jf6ADRZIyuLCNxOjXV6cfCm6f8eGvWrkYBABS7yqSVY4U/SoSMS/0TpaOwAK6XsR0Hqz6
	 ekP0Sm22ULRDeSImD8pw/vyFS1SONO6cZLxUn/+ecbF+2aI+1DSbnOj9/OFaq/Xa3jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PpMwdelt;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ED5606A339;
	Tue, 24 Nov 2026 06:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2ED5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PpMwdelt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795500777; x=1827036777;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rdPPUatwCGdhqseI0PStwl7g1cIqszizyHH+SlMOlkE=;
  b=PpMwdelt66ywM82RwzODCocmVkLXnuPTbbvRtu1QTRSSgPn5OOIK3nbU
   6SPOqQgiShpba+B8RG620HTg3uzMbUT1C/EYPRK1PHgKH0DS80ooLf8By
   4vcnBwGdJRdFIwG3OHSi18oGRBi0lhM5w2fS3UeAf6ZhbQadm+5lHdTnj
   K8JBFtdPJynhO8TU/oyVFczt2k7Uc7jnAZ6nJL9JG1aXmGo2Caqdw3BZ6
   Xn/a2MsxdFDQ+T+LxoGZetAWUjvDiRW+BO4r4xYG1CLs0ebji5Mtxt06E
   3Dn6LRLN4yvO0/gogaGnV8w1s+kZsikMkOq6QxtDOG9zxhqcGykRGJQvx
   w==;
X-CSE-ConnectionGUID: CkTz6y1vRuOjtFXIpjbBFw==
X-CSE-MsgGUID: yB3+2UdXQGi7qtw23x5k5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4336475"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4336475"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 22:07:07 -0800
X-CSE-ConnectionGUID: mh6gCppTTdmWalw5M2OvVw==
X-CSE-MsgGUID: URJvYw2ZSbCyOJUPgQ8oPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11688573"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 22:07:03 -0800
Message-ID: <9e7e8ed4-8f42-418e-831f-293614ef517d@linux.intel.com>
Date: Tue, 24 Nov 2026 14:07:00 +0800
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
Cc: baolu.lu@linux.intel.com, "Gao, Chao" <chao.gao@intel.com>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>, "x86@kernel.org" <x86@kernel.org>,
 "kas@kernel.org" <kas@kernel.org>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH v3 3/9] x86/virt/tdx: Export Dynamic PAMT helpers to
 tdx-host
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-4-baolu.lu@linux.intel.com>
 <awQUsufmV3NipqGX@yilunxu-OptiPlex-7050>
 <305d702ec6b5ef383115d3da9767df1ea6860da8.camel@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <305d702ec6b5ef383115d3da9767df1ea6860da8.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/2026 12:28 AM, Edgecombe, Rick P wrote:
> On Mon, 2026-11-23 at 18:25 +0800, Xu Yilun wrote:
>> On Thu, Nov 12, 2026 at 12:30:48PM +0800, Lu Baolu wrote:
>>> With Dynamic PAMT, any page handed to the TDX module needs PAMT backing
>>> first, via tdx_pamt_get(), and must drop it with tdx_pamt_put() once the
>>> TDX module gives the page back. Besides KVM, the tdx-host driver now
>>> hands pages to the TDX module: the IOMMU_MT pages for TDH.IOMMU.SETUP.
>>>
>>> Export the two helpers to tdx-host as well. A symbol can only be
>>> exported once, so replace EXPORT_SYMBOL_FOR_KVM() with an explicit list.
>>> Only kvm-intel calls these helpers in KVM.
>>
>> We are seeking for some simplified intial implementation without DPAMT
>> for TDX huge page feature. So we could also drop DPAMT support for TDX
>> Trusted I/O currently.
>>
>> As an temporary solution, we can disable TDX Trusted I/O if DPAMT is on.
>>
>> for example:
>>
>> static inline bool tdx_supports_trusted_io(const struct tdx_sys_info *sysinfo)
>> {
>> 	if (tdx_supports_dynamic_pamt(sysinfo))
>> 		return false;
>>
>> 	...
>> }
> 
> Yes, let's try to make DPAMT support optional for the initial upstream TDX
> connect target. We can add support for it in follow on patches and keep the
> initial code sets smaller. In order to facilitate this, we need to add a kernel
> param to control enabling DPAMT. I will send a patch soon.

Sounds good. I'll temperately drop the DPAMT support in the next
version.

Thanks,
baolu
