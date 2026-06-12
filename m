Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC49370D69;
	Fri, 12 Jun 2026 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291292; cv=none; b=HvCiKRjgKxKaAh49a7zdpLWtofod86nGIeAx1+xEwaUIrVrkRfp73xyo5ZlP1yIIXMqrZfmMpvg8hnl9/hAF6RpMBx0c64Dcz4wmDzmLXk9SeeBbDyNw1dBAnYeBEJm+gTUy2+TlLJvRWCEnWbpYP4IuVZ9KTF1qV3fm1LYrPoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291292; c=relaxed/simple;
	bh=XSyJbc77u2uz/L8IDt8RwOLyCxA6BMkvlHDTvyOQnoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sz6Lk/RYvBtvuRHxVH0hWyPKQxBNKAiOXWxYjEsyz/oWjV/BdRAT16U7XIbsMkN5Gocb6iQLeAIdJvp8vfVETsfZD4T4TfUzxP1Sc10gTESi2SEKGK7Vo2007mzLKJRr5oDKNT6TxkfQM7axZrp/zIR5NyA7tD4iGL73msqY8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4kElD/8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4kElD/8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781291290; x=1812827290;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XSyJbc77u2uz/L8IDt8RwOLyCxA6BMkvlHDTvyOQnoY=;
  b=Y4kElD/8So6QkBr/d3TlLZhMpjpkMgq137GJ5DMys54LTku+Sd2x4KPj
   xU/0mhRtE09cOFL3Pgj8uDtr9JEs28G+//i81IuWOtVS6PxmoJe61/skV
   Q0w5TDFtEMQiplYCukH0xKE7gj90XQI7RJrNOR37SSPSNC7+k97afIAZF
   5LqHPnXNOxoPP10F9I0dGpd8CuXojw2kS0yvPui6Il4CjDsFXbd8i9iFW
   eaO+n0GS3JsiXDHags48eSWCZSNWKShsj/chX8vRdUr4wLlmNiU8r7VgZ
   1ma38VpNKpZ0BB/YO+QwCtdK5ASZx8XwseQ662HLtNWHgZvbryVyN2oF2
   w==;
X-CSE-ConnectionGUID: fkvHZkDuTl6CQl0G8xNp9w==
X-CSE-MsgGUID: SnGWKgNrQcKRa04jg1nHPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="82171483"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="82171483"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 12:08:09 -0700
X-CSE-ConnectionGUID: LEagXSZ0SSCCPSUcNTG3MQ==
X-CSE-MsgGUID: nr+SFvaAS0yPxYw69Q0uLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="277091048"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 12:08:08 -0700
Message-ID: <caa29b0f-3c44-4c37-baf7-64873123a8dd@intel.com>
Date: Fri, 12 Jun 2026 14:08:07 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] KVM: x86/pmu: Add hardware Topdown metrics support
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260423174639.56149-1-zide.chen@intel.com>
 <ainfKdOgKp9i2qDP@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <ainfKdOgKp9i2qDP@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/10/2026 5:03 PM, Sean Christopherson wrote:
> On Thu, Apr 23, 2026, Zide Chen wrote:
>> The Top-Down Microarchitecture Analysis (TMA) method is a structured
>> approach for identifying performance bottlenecks in out-of-order
>> processors.
>>
>> Currently, guests support the TMA method by collecting Topdown events
>> using GP counters, which may trigger multiplexing.  To free up scarce
>> GP counters, eliminate multiplexing-induced skew, and obtain coherent
>> Topdown metric ratios, it is desirable to expose fixed counter 3 and
>> the IA32_PERF_METRICS MSR to guests.
>>
>> Several attempts have been made to virtualize this under the legacy
>> vPMU model [1][2][3], but they were unsuccessful.  With the new mediated
>> vPMU, enabling TMA support in guests becomes much simpler.  It avoids
>> invasive changes to the perf core, eliminates CPU pinning and
>> fixed-counter affinity issues, and reduces the latge overhead of
>> trapping and emulating MSR accesses.
> 
> Please submit a new version of this to address Dapeng's feedback, rebase on the
> latest kvm-x86/next, and perhaps most importantly, to let Sashiko take a crack
> at it.

Yes, will submit V3 in coming days.
> Thanks!

