Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C837996B
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894981; cv=none; b=XabC17hh9wZiayvPCBK8rXEczPcRgF/lZAuXU+PNavD8zIQAuZLYoBMGaRweTuHlmxqMVTR8znxGfsdT9W+bbnyxR9/MYV1uURHB72X123Ak55pJnamDs8OUMAZCafxJWOib5MKeM/wphomu02frhYsf6doJGvgywOjit1lAQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894981; c=relaxed/simple;
	bh=gFs2XUoVH2HqWaGeczl/e1am50hppz8x7HLFDBuOWbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlkmWztUBMyw6TqXDFMb6w2XEsuBrSQa7cciFT9ocKGb0UQeXLrV30BZXK4dhzEj1q/t5vKXEh9s609P9gjhmlWhjjeTvykgLnwYaKlgoYWfx/iHqIbgcW2pgKVq8Pc16SrDdbcHqGUtbpMtChbqga2OTHB/d33DsGbzOrG5CTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICyrpx/J; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICyrpx/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779894978; x=1811430978;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gFs2XUoVH2HqWaGeczl/e1am50hppz8x7HLFDBuOWbk=;
  b=ICyrpx/JRUuO/oFISbEt+GRKXMkd/tlqaw5mfgHo5Dwk86jU42/LFHQ4
   U78Wqe3UosUepHrH1nmPG4MWl30c5aIT4uMXmY56WWXQbI/zvopS7GZJB
   f5GXstaADRjSZXMSKSmP0GayM6ZfAhXDoTtlDR2srK2riVz1jo7XzTsFm
   vFjufo+GpbgTAtIH7CXh4lV4rrmaxGAdcY/+Jy/fVL1OPEJAuKyN1J3WU
   wn44Od2B1JD02lbs5H5US73HJGK+sdFJXolcChDI3zI7+xJ6vU/+D8/QC
   ZZ1R2we31I37PemWel1faG/kPDZOGHQkie783O6rBXhe64x93NIXbjank
   A==;
X-CSE-ConnectionGUID: rnp0V9s3RGC/veKPPbu0XQ==
X-CSE-MsgGUID: a1iauqJNSQWl6b9y1oJypw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="68256652"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="68256652"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:16:16 -0700
X-CSE-ConnectionGUID: fB7fzIMiSzSiAh/Ys9NIaQ==
X-CSE-MsgGUID: duok0b6HRMmYjvmLKRA0kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="247221595"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:16:15 -0700
Message-ID: <eca019cb-142d-4933-8273-0607dd900565@intel.com>
Date: Wed, 27 May 2026 23:16:12 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 2/4] nVMX: Validate
 DEBUGCTLMSR_BUS_LOCK_DETECT states during VMX transitions
To: Sean Christopherson <seanjc@google.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20260526031704.109102-1-chenyi.qiang@intel.com>
 <20260526031704.109102-3-chenyi.qiang@intel.com>
 <a479bef3-f24a-458d-ab90-3216712e1fcb@intel.com>
 <d08b2f6f-b2f1-4cd3-a1fe-588261e3ee10@intel.com>
 <ahcGpKXNHOxMKNTo@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ahcGpKXNHOxMKNTo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/27/2026 10:58 PM, Sean Christopherson wrote:
> On Wed, May 27, 2026, Chenyi Qiang wrote:
>> On 5/26/2026 8:32 PM, Xiaoyao Li wrote:
>>> On 5/26/2026 11:16 AM, Chenyi Qiang wrote:
>>>> diff --git a/x86/unittests.cfg b/x86/unittests.cfg
>>>> index 48835eba..c8426770 100644
>>>> --- a/x86/unittests.cfg
>>>> +++ b/x86/unittests.cfg
>>>> @@ -471,6 +471,14 @@ arch = x86_64
>>>>    groups = vmx
>>>>    timeout = 240
>>>>    +[vmx_bus_lock_detect_test]
>>>> +file = vmx.flat
>>>> +test_args = "vmx_bus_lock_detect_test"
>>>> +qemu_params = -cpu max,+vmx
>>>> +arch = x86_64
>>>> +groups = vmx
>>>> +timeout = 240
> 
> Why does this need a separate config, and with a massive timeout?  This should
> be nearly instantaneous, no?
> 
> Ugh, because you copy+pasted vmx_cet.  That thing doesn't need to exist, the
> testcase is run by the common "vmx" entry.  I'll send a patch to drop vmx_cet.

I told Chenyi that to actually be able to test LBR bit, we might need 
some specific QEMU configuration to enable PMU and legacy LBR and it 
will need a specific config.

I missed that he even added the config for BUS_LOCK_DETECT and RTM tests.
