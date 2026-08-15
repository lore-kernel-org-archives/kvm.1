Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E93655D4;
	Sat, 15 Aug 2026 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786785472; cv=none; b=JAm4bfhl5OLlkbo2KWMFvpf42BmTN2W1SW1GzsofxNEUd5xttp1g+j767HlWK8gTdi0m3LJvKDIS9suLEu8Jmt0VAX+K5IHdr/eUUZZCEVTja8FcX5fz+z/CjxbVNwoM/sTnSPX/Pgbxn8RIVyxKCS8avPKSvqdkdr9nFvHHKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786785472; c=relaxed/simple;
	bh=svRArkOXWyF/IfmglPw4+QW++psuxkU5D4yBGbQ9Q3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s38+z3nE/EQQcgt1El3fayCWMFXKa3YqwlA+cyfBr5n+gyzGaPqES99cLkCSEefOaIVUkssLK4MJbxLgCYUXiSlap6zjFlrqOVC1xby+SaBWmL1kzwCgZFVz9dooulPGtD3z1PHnKaC0ijHshiJQyrZvxp1MN1IT1YrvpvR2pik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DL732SVg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DL732SVg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786785470; x=1818321470;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=svRArkOXWyF/IfmglPw4+QW++psuxkU5D4yBGbQ9Q3o=;
  b=DL732SVgATsg5dkqLZL/Y4RyqenJcniYWs2AKn0SaosrZZWgerl7/PWQ
   /vBVVoCKkMv3yz4Esov5jBikvIBPnmnjHzREepVrqjeOlzp7UcsapImAy
   1mDgMzv6SNA/imf/musrsLX7q+ir4QLuHoec3/Q/OoQtviRcOaCxhSX/8
   ZvxXop8sf5IAror6yYSRuFvltyRln8fijSk3/ZLcmozN2nUhJzeuMSgPV
   fJAgIpFNzQ9vsMNwvmY1pt5puH0RnrzJghXHbJ3KB8OI7mQ87iB9g2jC+
   ispwmTI5xWjVD/Fi7LRuPt7ngRLh5fU6dLcgp8vdfJS9v9JPmVtoQP50y
   A==;
X-CSE-ConnectionGUID: +pyO59XuQMqiyex4RzSbWA==
X-CSE-MsgGUID: d0olni8+R+61++CsyBTn0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="91018978"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="91018978"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 02:17:49 -0700
X-CSE-ConnectionGUID: wOdvqNPFStKVoyoG04Hffw==
X-CSE-MsgGUID: ZYM05GKERBKoTMVQsmcX2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="261794215"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 02:17:44 -0700
Message-ID: <93f122d3-38de-40f5-b655-2389ac393d21@intel.com>
Date: Sat, 15 Aug 2026 17:17:41 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/22] KVM: selftests: Initialize the TDX VM
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Aktas, Erdem" <erdemaktas@google.com>, "shuah@kernel.org"
 <shuah@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "afranji@google.com" <afranji@google.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>,
 "pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>,
 "oupton@kernel.org" <oupton@kernel.org>,
 "wyihan@google.com" <wyihan@google.com>, "sagis@google.com"
 <sagis@google.com>, "Wang, Roger" <runanwang@google.com>,
 "Gao, Chao" <chao.gao@intel.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
 "Qiang, Chenyi" <chenyi.qiang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "jmcrey@google.com" <jmcrey@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-3-15ad654a50db@google.com>
 <c8b7a800-58ed-4ef7-91bd-31da77763717@intel.com>
 <52fa4033cd3ccc4caf0bfd46fccca0bc8aac0dfa.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <52fa4033cd3ccc4caf0bfd46fccca0bc8aac0dfa.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/2026 7:41 AM, Edgecombe, Rick P wrote:
> On Thu, 2026-07-23 at 16:44 +0800, Xiaoyao Li wrote:
>>> +	init_vm->attributes = attributes;
>>
>> Besides CPUID, it only allows attributes to be configure but leave XFAM
>> as 0. I think the changelog needs to explain why we need to configure
>> attributes.
>>
>> The rest of the patch looks good to me.
> 
> How about directly setting xfam to zero for clarity?

Agreed. It's simple.
