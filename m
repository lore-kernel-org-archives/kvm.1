Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA42FFF81;
	Thu,  9 Apr 2026 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720530; cv=none; b=icbK8htL63ktUbh39Nvb3vW9PHnUE2Ilc4VVF6pMfSLP1APdvtbJ4KV9jBR/y8TsaFNaDMvLGuI0IZANV+s6HKjPWIMHTaGg5NllDxRV+y5Yjwcgh8i4J5K0Ie9rzvp4ZfiYk6rqMWr/h+FNXDEP4c20XmsyTlOUJN4K2f9chYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720530; c=relaxed/simple;
	bh=J1ckw4CF/MXLrDiD+G3x+zo/BIbaic+0yXRNNalwVGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFvqm28/QMnr1JlzhKUYPObIMedf9F9xnD616GPtkxsdUGUZfsmTscSoUQjUP6TKZTI0HpQlHBb+I4fGLrBzwcw0Cfu5LZrf34VQVMvDL9SuJnNPNXFZQmPAyCRGQaSJEtthGUAmbuoWbeHc0A9ti4Qiz48uKxTnoAeLIcIl8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F30b0HJQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F30b0HJQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775720529; x=1807256529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J1ckw4CF/MXLrDiD+G3x+zo/BIbaic+0yXRNNalwVGA=;
  b=F30b0HJQA49teHXZkaRgRQaqRobfxwlgV7ahCBM8twwQH/4SYN92Vxdq
   8FHWIefmhamRK30yQZ+HETP7Psyi1DMrk2FOmM4zGe9auEcnXKFXTbbEW
   FVLDxZ5gb++96X1we/c8W8ZdaU6aqPMa+lsViYJDhV4W3Zb27/5LYlyWk
   hFhNW/dt3MbNx05+HV1IbbPfZFm5cvxcCZa2fkUcvaKokh1Jd2HTxTPUN
   dyfGrTlqZRkQmWXOA3GoC8l7UqfAghpAj/Ljhr/q3mMzEnIdxTev9x8oJ
   Be6newur3420dAoU+yu/AqTD0aXqE29Yu/ZRyLPQ1p1Mmn8wp1FyTjYlV
   g==;
X-CSE-ConnectionGUID: /HvKpnE7Sg6IRHW8M6edsQ==
X-CSE-MsgGUID: BbPLoDQJR1ujrDVNZw+jQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76605910"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76605910"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:42:08 -0700
X-CSE-ConnectionGUID: pK5iVEyBQBe77WajEr2fGg==
X-CSE-MsgGUID: YJyac0D6SmuG+gsc84M7Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="223946398"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:42:06 -0700
Message-ID: <129bdda8-a75c-4899-a671-0b553947cff4@linux.intel.com>
Date: Thu, 9 Apr 2026 15:42:04 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] KVM: x86: Drop superfluous caching of
 KVM_ASYNC_PF_SEND_ALWAYS
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com,
 Xiaoyao Li <xiaoyao.li@intel.com>, Ethan Yang <ethan.yang.kernel@gmail.com>
References: <20260406225359.1245490-1-seanjc@google.com>
 <20260406225359.1245490-4-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260406225359.1245490-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/2026 6:53 AM, Sean Christopherson wrote:
> Drop kvm_vcpu_arch.send_always and instead use msr_en_val as the source of
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

Nit:
Drop "e.g." ?

> 
> Fixes: 6adba5274206 ("KVM: Let host know whether the guest can handle async PF in non-userspace context.")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/include/asm/kvm_host.h |  1 -
>  arch/x86/kvm/x86.c              | 12 ++++--------
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index fae1f4aeca5a..2a6906597637 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1038,7 +1038,6 @@ struct kvm_vcpu_arch {
>  		u16 vec;
>  		u32 id;
>  		u32 host_apf_flags;
> -		bool send_always;
>  		bool pageready_pending;
>  	} apf;
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4632222a5d1c..e24877353f17 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3659,16 +3659,12 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>  
>  	vcpu->arch.apf.msr_en_val = data;
>  
> -	if (!__kvm_pv_async_pf_enabled(data)) {
> +	if (__kvm_pv_async_pf_enabled(data)) {
> +		kvm_async_pf_wakeup_all(vcpu);
> +	} else {
>  		kvm_clear_async_pf_completion_queue(vcpu);
>  		kvm_async_pf_hash_reset(vcpu);
> -		return 0;
>  	}
> -
> -	vcpu->arch.apf.send_always = (data & KVM_ASYNC_PF_SEND_ALWAYS);
> -
> -	kvm_async_pf_wakeup_all(vcpu);
> -
>  	return 0;
>  }
>  
> @@ -14025,7 +14021,7 @@ static bool kvm_can_deliver_async_pf(struct kvm_vcpu *vcpu)
>  	if (!kvm_pv_async_pf_enabled(vcpu))
>  		return false;
>  
> -	if (!vcpu->arch.apf.send_always &&
> +	if (!(vcpu->arch.apf.msr_en_val & KVM_ASYNC_PF_SEND_ALWAYS) &&
>  	    (vcpu->arch.guest_state_protected || !kvm_x86_call(get_cpl)(vcpu)))
>  		return false;
>  

