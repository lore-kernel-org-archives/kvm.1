Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B33AF670
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542843; cv=none; b=c8ugIRl2fNt7uB5WxFA84E/xFkOOMW6T7WGOC667FlC5UxNv6uYuTVz+tN0ZVsPtgt+Zr8cFRUY48doj9LVGegEfJZMRTbgi6Pb5sH25Xa4sZ6TUbgTnJ6xHMm8nK2LhQSFic3diPRnempFLCwl3gzbXO4AYEZd6BalIbED1jmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542843; c=relaxed/simple;
	bh=BjMhBrjtywp6iQlrwG21PodVsE+wIwaz/oPlgP71X+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1g1RjDRWTbQSwqvUL8zfTTTNs3q2J/9gTrVBEXzdhq3y8kYwuKnHY72YICYKi0JTM7B3yZBhpRrlJowaK1S6n/2qQgRXSvky7RjhfMRP0Y7sHvKAxs4bJq1E4WQbduix7cerMU9aYVzCQ0QNRGHns0QTjf8Y+bLeNaVkkGvfDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+eG0k47; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+eG0k47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780542840; x=1812078840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BjMhBrjtywp6iQlrwG21PodVsE+wIwaz/oPlgP71X+k=;
  b=W+eG0k47L7XTtEmUOT0bo05nNDq5WIa1d+VVv+UxOKtMIySyTk/IuOIm
   9F2xHwvHP9pHJ/HeMr8TNkntRDzACZ/feHqcucEgSmEU420FpIxlcmUIh
   lxjF2OqahjMfJ5oPefykJ3K5/QURuvqWRHeIB56AYfhFZVGnOgQoPhIVR
   S6j4TDdDcBfjAEgIYSk7lSP0aMGwDrqnLT+bmwvtbiOiDej40/ExnchHU
   saxkhhxk5nJK6HA2cFuQOsEj3nxJIxebobNZLry7MZdbFguuVyeqYh7uz
   po+aENPqJEoJPSuw+RydzBFn9DTRP18JQpvZcI4h77eUl1PWpgFRDooEv
   w==;
X-CSE-ConnectionGUID: aYTTC43FRBap/p8i2Qm2Mg==
X-CSE-MsgGUID: w1lw1L6RRsm6Fr4ONKF69w==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="85253850"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="85253850"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:14:00 -0700
X-CSE-ConnectionGUID: LorJoaHCQjqcal03sNB+3w==
X-CSE-MsgGUID: EM+c4NrDSt2tCiWvhHg+mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="274656994"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:13:59 -0700
Message-ID: <3cbba342-058d-4c87-97f6-5a9e6007a428@linux.intel.com>
Date: Thu, 4 Jun 2026 11:13:56 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/4] KVM: x86: TDX: Validate userspace CPUID input
 for KVM_TDX_INIT_VM
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260604023314.3907511-4-binbin.wu@linux.intel.com>
 <20260604024927.E22311F00893@smtp.kernel.org>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260604024927.E22311F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/2026 10:49 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] `tdx_unsupported_cpuid()` incorrectly uses the userspace-provided CPUID index instead of the canonical TDX configurable index for validation, allowing feature allowlist bypasses.
> --
> 
> commit c2adba56353483cd6dcf40b3fe14141409c0ce54
> Author: Binbin Wu <binbin.wu@linux.intel.com>
> 
> KVM: x86: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM
> 
> This commit replaces the hardcoded CPUID denylist with a validation mechanism
> that checks userspace input against KVM's supported allowlist. It aims to
> prevent userspace from enabling unsupported TDX features during VM init.
> 
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
> [ ... ]
>> +static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *e,
>> +				  const struct kvm_cpuid_entry2 *mask)
>> +{
>> +	return ((e->eax & mask->eax & (~get_supported_cfg_cpuid(e->function, e->index, CPUID_EAX))) ||
>> +		(e->ebx & mask->ebx & (~get_supported_cfg_cpuid(e->function, e->index, CPUID_EBX))) ||
>> +		(e->ecx & mask->ecx & (~get_supported_cfg_cpuid(e->function, e->index, CPUID_ECX))) ||
>> +		(e->edx & mask->edx & (~get_supported_cfg_cpuid(e->function, e->index, CPUID_EDX))));
>> +}
> 
> [Severity: High]
> Does this validation query the allowlist using the correct index?
> 
> If userspace provides a CPUID entry with the KVM_CPUID_FLAG_SIGNIFCANT_INDEX
> flag cleared, kvm_find_cpuid_entry2() matches based solely on the function.
> This means the returned entry 'e' could contain an arbitrary, user-controlled
> index.
> 
> Because get_supported_cfg_cpuid() is queried using e->index instead of the
> canonical target subleaf mask->index, userspace could spoof e->index to
> point to a more permissive subleaf in KVM's allowlist. The TDX module would
> then blindly apply those validated bits to the original, narrower target
> subleaf, bypassing the intended feature restrictions.
> 
> Should this use mask->index instead of e->index when querying the allowlist?
> 

Right, it should use mask->index.

