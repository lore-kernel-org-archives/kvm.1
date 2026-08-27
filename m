Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C253AF66D;
	Thu, 27 Aug 2026 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787830700; cv=none; b=phXnQlma0cWidYWOQuBexeUSXgc5QxBAzjAQfi7YkSDQxAPZT/MyBgUXQlEvIg9o1/lVL/vrPjIn5YKTEis0SIGl04r98s7UPMyXqB/3tullEOz21Y6xTidJc/WuCcb4J+jztG/T/+N2PfV773DHy+6fBc2eLHsCtz0a0kX5wTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787830700; c=relaxed/simple;
	bh=Wt1egI/uYCXuZ6lamv9uUhVqbAzBoKPheL/CSEwR4GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgUgV7uAYzK1IxPRVvhLFYsYiv9bpngo7rZg59XaNT8jpk3AC7ZbXlaKadULVk/yP9kMtIPxmz2qBVWVGk6cyhzyfcrahcnJD10/372dZXDeBTzA0sVgVUkeiD9Uo8ZKEVxo7My6xhw9+OHOgSAbHrMxFcrmSCQHsM7FvO359JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WydIshd1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WydIshd1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787830698; x=1819366698;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wt1egI/uYCXuZ6lamv9uUhVqbAzBoKPheL/CSEwR4GI=;
  b=WydIshd1WwiM7j+GH+YHBVzzqCCUXyRTOOdCPg677rfOdlXd67Ax6Qoo
   /AQ0AVnLqrZaKg+sqYvLHBiptNZXpFL0JHq9yttlREfVUEG0tYNHiO3r8
   QR4ZwuAU6slvlkSoBefeL/a7+6A6t5MI3vv32eylmDyVQylysicgT7UEk
   JxpW8QYdvAcdSLJPjCar9LCRl4sFOaHJhlQz1MIXCXrvdMfgq3yxDWlwG
   fs4at75t5uqdO+AeSbjQkKW9rUSxwZ15g3B6XZ8aT5CLoqHJgUFrsH0UG
   OdDzULZ2RxXTe5bktTD+pt1elIn/wkBzZB0/mgem/njTQHf5Dl4/FWlTi
   w==;
X-CSE-ConnectionGUID: k+1QA2Q5Sm+CunibzT7Mzw==
X-CSE-MsgGUID: wcOcWGSGSOiFLQbc9o3dIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="105702268"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="105702268"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 04:38:17 -0700
X-CSE-ConnectionGUID: cDM7bKp/Rbms+KWw4uENxg==
X-CSE-MsgGUID: q7xHARN1QzCNDh+meTDajg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="264074874"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 04:38:15 -0700
Message-ID: <d0d318a4-3f27-40dd-b089-2dd2638e8c53@intel.com>
Date: Thu, 27 Aug 2026 19:38:12 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] KVM: VMX: Rename posted interrupt prefixes from
 "vmx" to "vt"
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>
References: <20260826171246.777729-1-seanjc@google.com>
 <20260826171246.777729-5-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260826171246.777729-5-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/2026 1:12 AM, Sean Christopherson wrote:
> Rename all common posted interrupt APIs that use a "vmx" prefix to instead
> use a "vt" prefix to capture that they are used for both VMX and TDX vCPUs.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

With renaming vmx_needs_pi_wakeup() to vt_needs_pi_wakeup(),

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   arch/x86/kvm/vmx/common.h      |  4 ++--
>   arch/x86/kvm/vmx/main.c        |  4 ++--
>   arch/x86/kvm/vmx/posted_intr.c | 18 +++++++++---------
>   arch/x86/kvm/vmx/posted_intr.h |  8 ++++----
>   arch/x86/kvm/vmx/tdx.c         |  6 +++---
>   arch/x86/kvm/vmx/vmx.c         |  6 +++---
>   6 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
> index 4b1d46eafd0f..ff4f6a2b6402 100644
> --- a/arch/x86/kvm/vmx/common.h
> +++ b/arch/x86/kvm/vmx/common.h
> @@ -170,8 +170,8 @@ static inline void kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu,
>    * Post an interrupt to a vCPU's PIR and trigger the vCPU to process the
>    * interrupt if necessary.
>    */
> -static inline void __vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu,
> -						  struct pi_desc *pi_desc, int vector)
> +static inline void __vt_deliver_posted_interrupt(struct kvm_vcpu *vcpu,
> +						 struct pi_desc *pi_desc, int vector)

Nit: Maybe we can just name it vt_deliver_posted_interrupt() without 
underscore since no collide with vmx_deliver_posted_interrupt() anymore?

But it's OK to keep the underscore to indicate it's an common inner helper.

