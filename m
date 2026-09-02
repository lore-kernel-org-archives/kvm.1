Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5F4AA039;
	Wed,  2 Sep 2026 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366389; cv=none; b=k4VQN1qaU5slhTWxL4fGliR2c5NPsecEWgJ50nDV2JWaurFbGUu6eGQZVg5121x7ZN9x9vF2BmOlAvV2bcu+BPsoju8m5Hrqsl3dNgqyfiqEp6M+WsJrMEQ8O1yxvttNt3i2mntJMUM7wM0G3PopnV2NldsP3+y1v8C3s910iiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366389; c=relaxed/simple;
	bh=b1eWT7fYh/w6UUowPAHO0yzueW1k/PMN6343GWU/3lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mw5RA2GyrXllVmo989hQOb6Z6/lR6HLy2xxJXq4+x2ixFQchDQvDr+zX+trV/QNk+4VWoHtaLofF8JoU28LrWAIhjr7Dk6qkjEUDZeydIKB6LWQaQZG3qxZxAkdN9vNWcZXW2iimnLWvZkzcVq2s8hVjpP/OVAfJF4xNdQO8aXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxZ4exiJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxZ4exiJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788366387; x=1819902387;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b1eWT7fYh/w6UUowPAHO0yzueW1k/PMN6343GWU/3lM=;
  b=nxZ4exiJ4Qp7THoWmFNnN1S+5emVlrQE+CLZNbiG/Tmd7Ch1rPlOr6kb
   gTz8jsqZ08vLXJCiK2QOwZrnZp1XjPklRwDv+VHVoDzOHBow3OA7q15if
   pID23NEUIKicDjU7o0KzpQqtxpdlBkDTgb/l8E8tRcy5F2NGaoVnkobXx
   fgowmEn0I8z8TNqxSmj5EoFaoLk8mQd1N2rg2DvesKqNSuZ5rfHAf1BWc
   BJnvxVPUAIBxi/M47ASbhOk1kuFqm5ZzOtX2bLgY+yF7bPcddJHHbGerd
   2czbezUn2c+2G1LRH/2/oEmdPtgcerN1Hsek+CddwIhJvMbZnT9pgz2D8
   g==;
X-CSE-ConnectionGUID: jjWVwZfxRmqkQzBW1bAIKw==
X-CSE-MsgGUID: gHewxnR7Qd613uXfcRkGtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100185525"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="100185525"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 09:26:26 -0700
X-CSE-ConnectionGUID: nnJytENaQZW43E/puGQ36A==
X-CSE-MsgGUID: aX22XWNlQzC2sO6IoPN0QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307667717"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 09:26:23 -0700
Message-ID: <d1521557-8bb4-47e1-8750-9e4832f382be@linux.intel.com>
Date: Thu, 3 Sep 2026 00:26:21 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
 "Gao, Chao" <chao.gao@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
 <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
 <6f8f2c59-3336-4ed8-837f-57cb706ece30@intel.com>
 <69c42183261acb4150961cabf6318b92765b6562.camel@intel.com>
 <91c9e314-6b92-4f90-a2df-ed21104f84bc@intel.com>
 <e4b9509c4e4b91277a30f88cb7ca76c8ba016997.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <e4b9509c4e4b91277a30f88cb7ca76c8ba016997.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/2026 9:13 PM, Edgecombe, Rick P wrote:
> On Wed, 2026-09-02 at 18:29 +0800, Xiaoyao Li wrote:
>> So the proposal is making TDX behave as if the relevant VMCS save/load 
>> controls (if any) are set around TDH.VP.ENTER.
>>
>> In fact, what matters for host vmm is just the VM_EXIT_LOAD_XXX control. 
>> So the proposal becomes "If there is VM_EXIT_LOAD_XXX control for a 
>> state, TDX needs to restore the host state after TDH.VP.ENTER. If no 
>> such contorl, TDX sets the state to INIT state after TDH.VP.ENTER".
>>
>> It's a fancy idea. And it provides a clear rule of how TDX handles 
>> states of a feature so that host VMM developers don't need to read the 
>> TDX module API to figure out what's the value of a state after TDH.VP.ENTER.
>>
>> It's helpful for host VMM developers, though I'm not sure on TDX module 
>> developers.
> 
> I don't think they have agreed to it yet (Binbin?), 

Not yet. We just brought the topic to the community for discussion first.

> but I think it mostly works
> this way already. Why do you think it is a burden on TDX module developers?
> 
> Also, I think this can be the guideline. We could have exceptions.

