Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33FE175A83;
	Thu, 14 May 2026 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748691; cv=none; b=WV1CIwfiA8rp/ci9N1QQ9bMrQe7doCkTFTnA6b8V4+sOBBRlHHiAZIrCxja6LUZtm/Af0Gz6iwNMYZg3030859FEGNATPl8IGkuSoEMVNoNu7qpZrddT5I9/uWmPCJyeajCmP6b+rerJlHhqL0+Gkk78OD+aBnrXpu4gLkxppK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748691; c=relaxed/simple;
	bh=aw7VbcHDB3t3kEfRnIh7txHh9szt7BlvEuFp5ev1pgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=A45oZBxk4yvyj/vKIOWxIKXBddHM+4gI8k+h78nAQ/yLzygkTGin0e1eNsBj/PXLHh756YcuG6L3MBIWYSDQcjUsZV+ugYdJ0jZ5h9i+veSxRn/LxXsW8xOazP4N71Ef5/xd6VAA1lU7DUZpRW1pJFguFJG4IAyAwCzuhjOi/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dA39OSD4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dA39OSD4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778748690; x=1810284690;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=aw7VbcHDB3t3kEfRnIh7txHh9szt7BlvEuFp5ev1pgU=;
  b=dA39OSD4W6ak8IKW6P5nlPQ1xJ7wAT+bEcobp/XkZ6JwHiOwSlWmSmTZ
   sLXOv/qyYU1AloRsqkax5TR6VJnuYxCaM4DwX/sruA7fK6dNIeGWOs1eO
   YjXgjqRBYtuSmm6ZuRVrQ3Vfheocsqk8w3UUvdP9iQh9/DqWoUqmWpIjU
   R3xJuNsr7ZTSbHvpo0VSaMfQDxgG83OryiflMRp9Me7EpAT1RuhglCd+3
   csVHfIe5WVGW7jfre4lxpnZzM4y8W4d/6UHVuiMeIRKb5xZtRJmYsDNs1
   sXjkfsIaAQNu/3rZqcZ5oTaQk43D18yDjDKNwU/dluDkkXCSFdblANupk
   w==;
X-CSE-ConnectionGUID: NmYaBGL9R0m1SHQzviSs3w==
X-CSE-MsgGUID: Z+ueqoeBQUedrWON2dg+8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="105146039"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="105146039"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 01:51:29 -0700
X-CSE-ConnectionGUID: qjU+0Lo9RL+hBwovprqX0w==
X-CSE-MsgGUID: 5J5jrHp/REWo4NSIiRhkIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="237466202"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 01:51:25 -0700
Message-ID: <7cea30b3-43c6-4d8a-818b-1f13a65e8519@linux.intel.com>
Date: Thu, 14 May 2026 16:51:22 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] KVM: x86: Remove supports_cpuid_fault() helper
To: Jim Mattson <jmattson@google.com>
References: <20260513224608.1859737-1-jmattson@google.com>
 <20260513224608.1859737-3-jmattson@google.com>
Content-Language: en-US
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, shuah@kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ctpence@google.com
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260513224608.1859737-3-jmattson@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/2026 6:46 AM, Jim Mattson wrote:
> The function, supports_cpuid_fault(), tests specifically for guest support
> of Intel's CPUID faulting feature. It does not test for guest support of
> AMD's CPUID faulting feature.
> 
> To avoid confusion, remove the helper.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/cpuid.h | 5 -----
>  arch/x86/kvm/x86.c   | 2 +-
>  2 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index bc4a8428b836..95d09ccbf951 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -183,11 +183,6 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
>  	return x86_stepping(best->eax);
>  }
>  
> -static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
> -{
> -	return vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT;
> -}
> -
>  static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
>  {
>  	return vcpu->arch.msr_misc_features_enables &
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 01c6b18d1fe5..c60773349f35 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4252,7 +4252,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_MISC_FEATURES_ENABLES:
>  		if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
>  		    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
> -		     !supports_cpuid_fault(vcpu)))
> +		     !(vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT)))
>  			return 1;
>  		vcpu->arch.msr_misc_features_enables = data;
>  		break;

