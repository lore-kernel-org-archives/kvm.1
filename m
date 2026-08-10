Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BFD3C9EF1
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363438; cv=none; b=uDM6xCtExSwEFHM9o54DwR23bTJd5bqEq8mH/fuqITSUCmTXsz0yPgE4v1Nkm0Rd0xopC+yLZrqoFIE/4RrDxWb3ZHQT/TbUABykOgYK6fwtn6WIT+UIYIlvOKS+8yAOoxb8o07LMQlNyFs+/vR6kJ/99J1631l4bGt9HXqjUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363438; c=relaxed/simple;
	bh=F/KkaZzfG4eC2cp3ZYDb47BRxX9mE2ZD+43UkMZ4+94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiFfB17aP8TQdpq9JU4kBDmB2s30JF4MfwX1tixzCeNuCCH/gjg79SXUa6ioAs/QjcDxIG3B1Iv4oSglDp0DfJxNU/1bSArZdVBoZRQmrcWTSuZVhN6CsqVcP/e4FwwhJy+wiFf7n6Ln2uVZcvYebqwIot/QSQTbqAwSpjw9ZT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIDU/4Wi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIDU/4Wi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786363435; x=1817899435;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F/KkaZzfG4eC2cp3ZYDb47BRxX9mE2ZD+43UkMZ4+94=;
  b=XIDU/4WiXE9Xg7hk+CWP3pe5Wrqr6r6H7oKixWQD4SpiKJeroC12PkcJ
   w2v9Kmm5HRlmHjCQYmZTybOHkU0bLROyEtFokPlYA8dTvBJ4BF6JEunaO
   dUY0pmBygIjgnnHEf9+fFIJ4Tb9yhJfFDHDa3harD6m31pe463gtRPoWE
   2TwCRzKfA+FRNkjA0sGQYfl2v4iEdi43bXTtJdTNU0rw5SyXNNqwFCrHi
   CtEnBpePyks81R+FhYNr56QfokK39L9btT5lS7y66yujGjcxn+J44Pclq
   PrUx9BIVw++q26bTUK6d2urWs8wfMD9UL0GCWlnuwrQo1Y6UCy8YbJ/Wx
   w==;
X-CSE-ConnectionGUID: CrR3JP5pQ9KcpVojflpo3A==
X-CSE-MsgGUID: G/HdlRpwS1K9BDUtXY8LlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86951729"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="86951729"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 05:03:50 -0700
X-CSE-ConnectionGUID: 7YstxW58TVCCGlXCDOZb2w==
X-CSE-MsgGUID: z3rgMCjUSly4caejkcS2Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="265005815"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.248]) ([10.124.240.248])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 05:03:48 -0700
Message-ID: <7369dbdf-9daa-4543-b091-fb1289cbb3ea@intel.com>
Date: Mon, 10 Aug 2026 20:03:45 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] KVM: TDX: Enable Bus Lock VM exit
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-4-xiaoyao.li@intel.com>
 <20260810114648.758541F000E9@smtp.kernel.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260810114648.758541F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/2026 7:46 PM, sashiko-bot@kernel.org wrote:
>> @@ -2150,6 +2154,22 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
>>   	return 0;
>>   }
>>   
>> +int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
>> +{
>> +	int ret = __tdx_handle_exit(vcpu, fastpath);
>> +
>> +	/* Exit to user space when bus lock was detected */
>> +	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
>> +		if (ret > 0) {
>> +			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
>> +			ret = 0;
>> +		}
> [Severity: High]
> This is a pre-existing issue, but since you fixed the negative return value
> handling here for tdx_handle_exit() in v2, should a similar fix be applied
> to the pre-existing vmx_handle_exit() in arch/x86/kvm/vmx/vmx.c?

VMX fix was sent already:

https://lore.kernel.org/all/20260806111923.1990562-2-xiaoyao.li@intel.com/
