Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505CA3AA500;
	Tue,  7 Apr 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570835; cv=none; b=hq6xe3ahMQZ+YFjLs7brcL6Eroe+AGoFCIunMQ7Tig5KMK9xsU5TA/f/qJD5Wt0GZFxHleU0lQfNPeE7zTZ+K4K4N5pUOplzQzpkI5ESrtts3h8WaeKUZaX5NqiAbx2sJ8wlCtJxYFau3PJudylQnpQO70s79+iUdXZywUW0EU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570835; c=relaxed/simple;
	bh=9Fg8ZqXaSFnoLbiPJ26DE/xFpFeFJOSLH//uZn6xc8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8PJZITl6rX3JW8Khj7i2zP+WVvlq2Pu6DtBVQIB9twZeNfwbsVegdupJqqNCppZKpBNWLxUiydvRyrm0AXdzgFM1gJ44jBuOX8/9iydxkElq2diw6jH3WXyz/J+vo1Z+5TrEegO8yHQHd+VV6S3p0ZL8BRNd/SHe1i5WJzWhG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+j3C3S3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+j3C3S3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775570835; x=1807106835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9Fg8ZqXaSFnoLbiPJ26DE/xFpFeFJOSLH//uZn6xc8Y=;
  b=U+j3C3S3jvXGJOhgNusBEOKZ7i8rhj9yn4HIkabfjJ9xbZCl2jfAhtCz
   KRfRUbA/2aj1SGn/oBQik75oOone4LIQj8i+kDZYkbrcEguSe5c/Tj4/f
   v5iBLk+eT9npRtekqX3VegneLh8nvDjo0Oy4CT3Sb8zG+jSQ2iCOxRuNU
   9ZXlOkAa3NOD2hCL2XglKGisaHF/eszERmKKPV5JyQYe6QTfl+ezuRPXw
   lPRLGSez1ymtCt91FHzhncB91kSZRU6+EqDv0knJz7oPtGzHbBctZ+bRm
   LFeTMgDgl5kTo4BntLBhN6DhK00M4OIaR9EjdnbIlDA13KKw3R4oPXtOM
   Q==;
X-CSE-ConnectionGUID: vRohRrg9S/Ca+qpC/22mQw==
X-CSE-MsgGUID: C6sG8PonRpCGCd3OM9mrlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76547570"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76547570"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 07:06:49 -0700
X-CSE-ConnectionGUID: ypehSvtpS5my5SVthBerPQ==
X-CSE-MsgGUID: IVQ+4kiYTXuJv9oUvNN6Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="223391212"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.241.144]) ([10.124.241.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 07:06:47 -0700
Message-ID: <8accfcc2-6568-4219-9fa7-0567a8bd63f8@intel.com>
Date: Tue, 7 Apr 2026 22:06:44 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] KVM: x86: Drop superfluous caching of
 KVM_ASYNC_PF_SEND_ALWAYS
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com,
 Ethan Yang <ethan.yang.kernel@gmail.com>
References: <20260406225359.1245490-1-seanjc@google.com>
 <20260406225359.1245490-4-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260406225359.1245490-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/2026 6:53 AM, Sean Christopherson wrote:
> Drop kvm_vcpu_arch.send_always and instead use msr_en_val as the source of

Nit: kvm_vcpu_arch.apf.send_always

> truth to reduce the probability of operating on stale data.  This fixes
> flaws where KVM fails to update send_always when APF is explicitly
> disabled by the guest or implicitly disabled by KVM on INIT.  Absent other
> bugs, the flaws are benign as KVM *shouldn't* consume send_always when PV
> APF support is disabled.
> 
> Simply delete the field, as there's zero benefit to maintaining a separate
> "cache" of the state.
> 
> Opportunistically turn the enabled vs. disabled logic at the end of
> kvm_pv_enable_async_pf() into an if-else instead of using an early return,
> e.g. so that it's more obvious that both paths are "success" paths.
> 
> Fixes: 6adba5274206 ("KVM: Let host know whether the guest can handle async PF in non-userspace context.")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   arch/x86/include/asm/kvm_host.h |  1 -
>   arch/x86/kvm/x86.c              | 12 ++++--------
>   2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index fae1f4aeca5a..2a6906597637 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1038,7 +1038,6 @@ struct kvm_vcpu_arch {
>   		u16 vec;
>   		u32 id;
>   		u32 host_apf_flags;
> -		bool send_always;
>   		bool pageready_pending;
>   	} apf;
>   
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4632222a5d1c..e24877353f17 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3659,16 +3659,12 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>   
>   	vcpu->arch.apf.msr_en_val = data;
>   
> -	if (!__kvm_pv_async_pf_enabled(data)) {
> +	if (__kvm_pv_async_pf_enabled(data)) {
> +		kvm_async_pf_wakeup_all(vcpu);
> +	} else {
>   		kvm_clear_async_pf_completion_queue(vcpu);
>   		kvm_async_pf_hash_reset(vcpu);
> -		return 0;
>   	}
> -
> -	vcpu->arch.apf.send_always = (data & KVM_ASYNC_PF_SEND_ALWAYS);
> -
> -	kvm_async_pf_wakeup_all(vcpu);
> -
>   	return 0;
>   }
>   
> @@ -14025,7 +14021,7 @@ static bool kvm_can_deliver_async_pf(struct kvm_vcpu *vcpu)
>   	if (!kvm_pv_async_pf_enabled(vcpu))
>   		return false;
>   
> -	if (!vcpu->arch.apf.send_always &&
> +	if (!(vcpu->arch.apf.msr_en_val & KVM_ASYNC_PF_SEND_ALWAYS) &&
>   	    (vcpu->arch.guest_state_protected || !kvm_x86_call(get_cpl)(vcpu)))
>   		return false;
>   

