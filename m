Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE126A0B9;
	Wed, 15 Apr 2026 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776255652; cv=none; b=cuFDQZW4XcDd0ip3VwSYM3x/VF1RGIp/RWJlF7Foa0qssy4jJX4W38hyTh4lPneS5sF3TApm9ID8rj9kqqVLsnM68odVvyVq3y5S7KAGJsow9s+lp+n9m2ZZ/x1NyD3HEK1ROeohGeWSplSHgzR2XskZRCToug5FpRstUib36n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776255652; c=relaxed/simple;
	bh=M+Nkagqh1TT5HUiFxEVn9yGoVnTHw2oBmtxXP4R6LgQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uRkstJXkREBRX0O/+MWNYaayEIK/3fnCBpbivhfPuvwgy9t+Sp2f70zV6vz195+O1RuDzrMcGxT2tpvQsxWrqrx2Bc1+tHPVtMwPHEZ9vddbWKU0hi3p8P7l6PZuJquCROy0CJ47VLS+UE9j3XlYfVl8q4lsDErYefnHakW0go8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BihzIQIA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BihzIQIA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776255650; x=1807791650;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=M+Nkagqh1TT5HUiFxEVn9yGoVnTHw2oBmtxXP4R6LgQ=;
  b=BihzIQIAcbCqgD/oMoTifUXnpmB5wtt+a5l3gxMfQdOMuFAeGA7Qe//F
   SK6CnTS+1p/sah45szb6wV+R3muqXvoNaPA4BdF2WRj0qIbw3F6MQIsYW
   foYAhlPuPYjlNc0xikjvp7rZf4GcEw96WGE0F8Bw/ihT66FfSVQZlON1D
   M3JvrQqOEaUi+zvsm+pSw7HH17qAIj3iYrfCsTwg+6U7ZGXaG5isrSuC4
   ySLit/5F5B1PeFfxDeyOQkmSuat/WGwGxSqx91xmF0+JdnOiHh3TOlkyr
   i8fMX3vZpY/MvwBXViiO6Suz/jZwc1+GCfr/uJ3L+1cLtyFoE+8vvgW5Q
   A==;
X-CSE-ConnectionGUID: 0onyUnpKSGGqsk+PIk0m/w==
X-CSE-MsgGUID: WHbUf0HuRPKTSIQ0jhppLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77106417"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77106417"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 05:20:50 -0700
X-CSE-ConnectionGUID: GsfC+ulPTm+RL4nwJsgncA==
X-CSE-MsgGUID: Jv4l+ZdgRKGnwd1b9EaMIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229375489"
Received: from unknown (HELO [10.239.158.42]) ([10.239.158.42])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 05:20:48 -0700
Message-ID: <e11d37d0-a143-44e7-b76d-bf2d5b386d16@intel.com>
Date: Wed, 15 Apr 2026 20:20:45 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Kai Huang <kai.huang@intel.com>, Chang Seok Bae
 <chang.seok.bae@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
 <kas@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>
References: <20260409224236.2021562-1-seanjc@google.com>
 <20260409224236.2021562-6-seanjc@google.com>
 <e6e82905e6b9b1637ccb640097e67d21793f5895.camel@intel.com>
 <ad0DrDUsUKTMfrDW@google.com>
 <d6f05e5fa781ccb465d27a4fb1c7c1ac1e9e95ff.camel@intel.com>
 <95a931f8-42cc-4834-953c-30c9167bfdc1@intel.com>
 <ad5JeT7UuiQI9Tqo@google.com>
 <c40b5057-4df5-44ba-93c9-5c46696de765@intel.com>
Content-Language: en-US
In-Reply-To: <c40b5057-4df5-44ba-93c9-5c46696de765@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/2026 7:29 PM, Xiaoyao Li wrote:
>> Note that updating only the "available" masks is wrong, as TDX needs 
>> to marshall
>> written registers back to their correct location.
> 
> In what case it needs to marshall written registers back? Can you 
> elaborate?

Sorry that I asked a silly question. I mistakenly thought TDVMCALL for 
instructions (like, CPUID, RDMSR, WRMSR) use the same output register as 
the x86 instructions. After checking the TDX GHCI, obviously I'm wrong.

But I don't understand what's is wrong regarding "updating only the 
"available" masks". Or what is missing for "marshall written registers 
back to their correct location"?
