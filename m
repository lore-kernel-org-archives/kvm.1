Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F084369A;
	Wed, 15 Apr 2026 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776216496; cv=none; b=q6211hPM+mRQ5E+Yi2WphHwbzY0sOI1608/Hc87vfcUv9tdoMaPa1H/leIrA+PVsNgR/xUokNsbmFNX8kCyDDA9oUitrfwCzwBWeDowezEBU5i2w/Q2wUAdRYlYePwK+NHvRtj2BTMWggA41hTKyCy8PML6eH8nmY5eyDOLNxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776216496; c=relaxed/simple;
	bh=corGwE67PhWUaR4XeSx2mCQn2p/gUch0h/xKCBWxFTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzSJano9ufYdFOqQe+23zpAMrn3rlUiIjGsqGmnoxbs9vzhMt0x/FgxW6chn1aYVdC2D+UMY3bsm42N4GuMI++5GCiWu2BipaXh0GRbRePZqjfQxYO70TEfXfzArOPTsk5FnSGnfTu46ypQFsL4WyeakC1y13gKUDGxKu/XVBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkzNAuEs; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkzNAuEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776216495; x=1807752495;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=corGwE67PhWUaR4XeSx2mCQn2p/gUch0h/xKCBWxFTo=;
  b=hkzNAuEsOyX48M2bSp3qborhb6/uwtsv82nnyS9phZpt4q29cRyOyvc9
   zVzdAbC5nxTdeJ+sup+f6BlpF15ix776B6QXcNCuiTyvf1YxkUmEM2b3/
   XJ1BShMkdrAnr4EWcR4B593grYkucrswnAX9M0Yzto3ZTTs3o+/5Cggpz
   cQf+VVkvYwqgDRgi317tQKX3aQ+9h1Yzo6armkrITAxg6jodRtytppPSs
   pzooQ835gz5msj5WB3eRw+PU8woDtQ/c+dkkoMOqFttpLPSaD5FL3eMX7
   kiR6GrKlwLnAoYL86bgq9yDRBnYFjucCff+B6Si9ZGaLED7OtsVnUA+HT
   w==;
X-CSE-ConnectionGUID: KtTeHR2LRMeM3ScFxBDHxw==
X-CSE-MsgGUID: WhbJWtQgRfmXoOGu5txRNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77259952"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77259952"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 18:28:14 -0700
X-CSE-ConnectionGUID: NR7ZQwpgR2OQjdRRK0iwYA==
X-CSE-MsgGUID: JIW33fbJTz6Fb2JHP+zCug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="232010142"
Received: from unknown (HELO [10.239.158.42]) ([10.239.158.42])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 18:28:12 -0700
Message-ID: <b6bc6b99-c8d5-4c2d-9ca8-42d36d60d197@intel.com>
Date: Wed, 15 Apr 2026 09:28:09 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] KVM: x86: Add dedicated storage for guest RIP
To: Sean Christopherson <seanjc@google.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260409224236.2021562-1-seanjc@google.com>
 <20260409224236.2021562-2-seanjc@google.com>
 <20b82b65-b156-4a2c-8094-b86dccfb3025@intel.com>
 <87e767b6-0324-44e6-92cb-f933002dec43@intel.com>
 <ad5fUya3W9BKO_iA@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ad5fUya3W9BKO_iA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/2026 11:37 PM, Sean Christopherson wrote:
> On Tue, Apr 14, 2026, Chang S. Bae wrote:
>> On 4/14/2026 5:31 AM, Xiaoyao Li wrote:
>>> Even leave RIP in regs[], what is the problem by just allocating the
>>> index 16-31 to R16-R31 and making RIP the index 32?
>>
>> But why?
>>
>> Even though the array isn't explicitly labeled as GPRs, that's effectively
>> how it's being used, and RIP isn't part of that set.
>>
>> I don't think there is any benefit of leaving it in regs[].
> 
> +1.  Chang's earlier argument that RIP isn't a proper GPR swayed me over, e.g. RIP
> doesn't have an architectural index.
> 
> Keeping RIP in regs[] saves one line of code in arch/x86/include/asm/kvm_host.h,
> at the cost of making the code less readable (IMO) and incorrectly suggesting that
> RIP can be accessed like other regs[].

I'm not trying to object this patch. Instead, I'm trying to understand 
the justification of the change.

So I would expected an updated changelog with above justifications 
incorporated.
