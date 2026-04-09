Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA4282F1E;
	Thu,  9 Apr 2026 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719509; cv=none; b=BADHgxfK0PD60dRd+3ooFPUUnFv9FH5TSF+egrBYy7kHSWWnWX6nBFXOnVUbqvxwm98DxWIyk4ZQKWOxE5ddJgjdALcGLqduEGwqUVPEPXvkIsB7eA9+KdoN/9yIsgkH+BGA62OJ1XDG5A/yPkLNia2qEyA2LJ+oHfwEDP0u+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719509; c=relaxed/simple;
	bh=xvAg37ZVYQxniJnoTw3jpdkc9KAhY0Jo/xdICCLn7xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzbO6avax7f79uOn3U0TGL3frzUxDDETjBOFZtGsdL5gXQ5lguKgvWyLMVrOmDjllWDrQKlUycP+vY+GJlsMbDHWt09l9ut8tVvg+4exVhLEXLmSfr+IUAFz/QFzyhQman5r+fYOHjOOo6QHfYOue1NfNVBO7qQgexeMcllK22g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyWVwaqk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyWVwaqk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775719508; x=1807255508;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xvAg37ZVYQxniJnoTw3jpdkc9KAhY0Jo/xdICCLn7xU=;
  b=eyWVwaqkfRugLn7RFWZ/+W6BqvMux3NPIgALt4RN+4MofiFjuxUWPVUc
   78ojTPb5n+Ln1m2/WJqbjmI5NmUuepEbUkOlg3yG1ydvfHpnBi6AcUFlY
   yKubndYl+QiNwt0Rz+XQjk+Pu19dfoEdK41jxFsyGgyGgXHS4fLadB8hr
   6fubaPl76xsKrXePBnC6M+Xacbi0AuXzhuzdMp1wMAldmJ8Ib0rcbKvtW
   A6riT/WSW0DGhAevmXH0YIaVB94n7JiFLuVaGyH1BQBR/pZTHwtYgvD9l
   WkF59iSfVtrBCqi8l5UvK/lvJ7T0rOwYCnjDIqS7+6oSzgSnqTFahkO5k
   g==;
X-CSE-ConnectionGUID: pW6N1bTNRzyJM38rNCu4JA==
X-CSE-MsgGUID: VyzsAbtYTjOBgPYAybCBmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="99343418"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="99343418"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:25:07 -0700
X-CSE-ConnectionGUID: HweCq4iCSCKc4IT4DeBu2A==
X-CSE-MsgGUID: tU0W3OEEQsCyjCiD1g9V9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="223944458"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:25:05 -0700
Message-ID: <f8d3fc8d-cf2a-4c7b-a334-adc7201986b1@linux.intel.com>
Date: Thu, 9 Apr 2026 15:25:03 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] KVM: x86: Drop superfluous caching of
 KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com,
 Xiaoyao Li <xiaoyao.li@intel.com>, Ethan Yang <ethan.yang.kernel@gmail.com>
References: <20260406225359.1245490-1-seanjc@google.com>
 <20260406225359.1245490-3-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260406225359.1245490-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/2026 6:53 AM, Sean Christopherson wrote:
> Drop kvm_vcpu_arch.delivery_as_pf_vmexit and instead use msr_en_val as the

Nit:
kvm_vcpu_arch.apf.elivery_as_pf_vmexit


> source of truth to reduce the probability of operating on stale data.  This
> fixes flaws where KVM fails to update delivery_as_pf_vmexit when APF is
> explicitly disabled by the guest or implicitly disabled by KVM on INIT.
> Absent other bugs, the flaws are benign as KVM *shouldn't* consume
> delivery_as_pf_vmexit when PV APF support is disabled.
> 
> Simply delete the field, as there's zero benefit to maintaining a separate
> "cache" of the state.
> 
> Fixes: 52a5c155cf79 ("KVM: async_pf: Let guest support delivery of async_pf from guest mode")
> Signed-off-by: Sean Christopherson <seanjc@google.com>


Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/include/asm/kvm_host.h | 1 -
>  arch/x86/kvm/x86.c              | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index c470e40a00aa..fae1f4aeca5a 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1039,7 +1039,6 @@ struct kvm_vcpu_arch {
>  		u32 id;
>  		u32 host_apf_flags;
>  		bool send_always;
> -		bool delivery_as_pf_vmexit;
>  		bool pageready_pending;
>  	} apf;
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c35d359b56dd..4632222a5d1c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3666,7 +3666,6 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>  	}
>  
>  	vcpu->arch.apf.send_always = (data & KVM_ASYNC_PF_SEND_ALWAYS);
> -	vcpu->arch.apf.delivery_as_pf_vmexit = data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
>  
>  	kvm_async_pf_wakeup_all(vcpu);
>  
> @@ -14035,7 +14034,7 @@ static bool kvm_can_deliver_async_pf(struct kvm_vcpu *vcpu)
>  		 * L1 needs to opt into the special #PF vmexits that are
>  		 * used to deliver async page faults.
>  		 */
> -		return vcpu->arch.apf.delivery_as_pf_vmexit;
> +		return vcpu->arch.apf.msr_en_val & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
>  	} else {
>  		/*
>  		 * Play it safe in case the guest temporarily disables paging.

