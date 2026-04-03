Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D258342524;
	Fri,  3 Apr 2026 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203925; cv=none; b=utyW2NKG/1qVRuzgnp8ZkvXOP+kivtGZ60cbC9vbdEf4RA7JzNrd4FlCYfT+dFes7BUU7iAx6QNoUewwbQ6jGjWVCYYWjlxRvRvaBBZ4hq3ErzauJMO07y6tvE0JQLrBQx6YAoKUIGH7OHDM3PdeanBKon/elmAtFjQeMksqpM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203925; c=relaxed/simple;
	bh=2U9LJNEdT0s9fi6twSIhs2Cdqsg3vAMOyvG/uPWp5DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ub7oiZpfHUmp2EnBnDXCFw3zJlJm5ePR2AFBeoHxSwqnKOXsxFNux+epBlu71vw6wbZVHx+9iJrGrjvuHgNHyDFBlq7mOAMiLZkFWS3h4r4/FGpt9xSi06ifRU2riBGZ9DCUUcWzyXW15MBw5HY5rLZmCITanvfEbBDBLxmVuXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=er6ORU+O; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="er6ORU+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775203922; x=1806739922;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2U9LJNEdT0s9fi6twSIhs2Cdqsg3vAMOyvG/uPWp5DI=;
  b=er6ORU+OTpQOmkZnglgbobt01BjgXwVNNKce+ug1D7zQdSGyoXyho+TO
   cw1ETVqYtBWnkHAVjwTgLq1+qwGbnbCO38qbG8KvoHeKMODYFPgCdL3Wf
   WS36SZIDlaJ8Qzs+1ZeCM/CuiT7GqFwIHG0CbkAR33gquWXVUDh5mWoD8
   5Ewlt2m6zKJC9bsCJUcBmnbG+Q9q2UHVzpaT5vLW3K68r0oqalopygkDv
   OWGV7C8/mNk7nLhlMeXuhmLkgDB7yFXI9n11UGyAaLiImydIIYYRcnOTJ
   ZWOWwCgj5i9uAatJ0zsc8+m4BK6Fm+ChxVu2kSPJDWYTO2DCxvfI/JONc
   g==;
X-CSE-ConnectionGUID: Ef1rAyrPQwiEDBGZ+V6g6g==
X-CSE-MsgGUID: LnWXPNpxQamJcdhim82gWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="87340011"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="87340011"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 01:12:01 -0700
X-CSE-ConnectionGUID: 8iWg0SscTiO8sX++hpPtCQ==
X-CSE-MsgGUID: upYqGi69T2eJdddNPmOnlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="231597915"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.241.144]) ([10.124.241.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 01:11:58 -0700
Message-ID: <3a4f4c0a-3ded-4064-9f58-48de6f72be08@intel.com>
Date: Fri, 3 Apr 2026 16:11:55 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Don't leave APF half-enabled on bad APF data
 GPA
To: Ethan Yang <ethan.yang.kernel@gmail.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com,
 syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 x86@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, glider@google.com
References: <6877331d.a00a0220.3af5df.000c.GAE@google.com>
 <20260403031111.3171-1-ethan.yang.kernel@gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260403031111.3171-1-ethan.yang.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/2026 11:11 AM, Ethan Yang wrote:
> kvm_pv_enable_async_pf() updates vcpu->arch.apf.msr_en_val before
> initializing the APF data gfn_to_hva cache. If userspace provides an
> invalid GPA, kvm_gfn_to_hva_cache_init() fails, but msr_en_val stays
> enabled and leaves APF state half-initialized.
> 
> Later APF paths can then try to use the empty cache and trigger
> WARN_ON() in kvm_read_guest_offset_cached().
> 
> Determine the new APF enabled state from the incoming MSR value, do cache
> initialization first on the enable path, and commit msr_en_val only after
> successful initialization. Keep the disable path behavior unchanged.
> 
> Reported-by: syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=bc0e18379a290e5edfe4
> Link: https://lore.kernel.org/r/aHfD3MczrDpzDX9O@google.com
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ethan Yang <ethan.yang.kernel@gmail.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

though some nits below.

> ---
>   arch/x86/kvm/x86.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fd1c4a36b59..c355bbd36c3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1041,11 +1041,15 @@ bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr)
>   }
>   EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_require_dr);
>   
> -static bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
> +static bool kvm_pv_async_pf_enabled_data(u64 data)

I'm not sure if the name with "__" as __kvm_pv_async_pf_enabled() fits 
better?

>   {
>   	u64 mask = KVM_ASYNC_PF_ENABLED | KVM_ASYNC_PF_DELIVERY_AS_INT;
> +	return (data & mask) == mask;
> +}
>   
> -	return (vcpu->arch.apf.msr_en_val & mask) == mask;
> +static bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
> +{
> +	return kvm_pv_async_pf_enabled_data(vcpu->arch.apf.msr_en_val);
>   }
>   
>   static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
> @@ -3645,17 +3649,20 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>   	if (!lapic_in_kernel(vcpu))
>   		return data ? 1 : 0;
>   
> +	bool new_enabled = kvm_pv_async_pf_enabled_data(data);

I would like just call it "enable"

> +
> +	if (new_enabled &&
> +		kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,

Please align the second line

> +			sizeof(u64)))
> +		return 1;
>   	vcpu->arch.apf.msr_en_val = data;
>   
> -	if (!kvm_pv_async_pf_enabled(vcpu)) {
> +	if (!new_enabled) {
>   		kvm_clear_async_pf_completion_queue(vcpu);
>   		kvm_async_pf_hash_reset(vcpu);
>   		return 0;
>   	}
>   
> -	if (kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,
> -					sizeof(u64)))
> -		return 1;
>   
>   	vcpu->arch.apf.send_always = (data & KVM_ASYNC_PF_SEND_ALWAYS);
>   	vcpu->arch.apf.delivery_as_pf_vmexit = data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;

