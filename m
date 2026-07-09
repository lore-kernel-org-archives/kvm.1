Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFD3264C8;
	Thu,  9 Jul 2026 02:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783563165; cv=none; b=RO0BbgDEHTZfvMeEZfvehUhKLzdd3z25okLhzar6UbGsBoZjoKZ8BTVsaF3tK597AGSnnd6dWyDe+jTu17pV8uWiGOXYivX8n5BOt2izXznjofZDt7+DfP5BOv6hIm5Mu3hYmMxqRncA+4r1FFMT5LHkIg73VFe+sSJ5xX5Hf4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783563165; c=relaxed/simple;
	bh=cioIJ9pAho326QawJGpDwmY7RY71ajJ+St5ILGdHfO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTGolkNMGp+tjFYtZoGOTCNRlZ4aUNw8sVLL/XWga35l6BCt4ZkSVLPrU/zotqZhVUqBSUEP00RTGgCqaB9r6+oWLhc7hVg66/uag4UOj+W73eL38biwkpssMPZ1Wr37v1RigT/JzUwkN33FE9aUZyOUqYne7sH+TjWHRGmTQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/0nBHF0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/0nBHF0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783563163; x=1815099163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cioIJ9pAho326QawJGpDwmY7RY71ajJ+St5ILGdHfO8=;
  b=i/0nBHF0Nwse1fkAe2PdZBitA0ThmjXhQYDpnJ+q5FMmNe2D/nfPMOTw
   eaVCRZhyQGYendml0w2QMndZ3+LAUXxTa9Rk1M6KNzzBOZ30o/8OaBlvZ
   OrOwIiIfl+YkbjFN/1yM5XuYQJNGQlktINADngNymt7nrmOFtQFMtYJqs
   YfeNWyGx4ImYSC030bUSWUvxWUWc2FzPjPsgyjLcdX8nWt2srVYpEuEDo
   ssDaEaXZF852ecDPshkdAdAqm6dJezO4YbNAKwPxXmCxTzBK7uG6hxsMy
   GK730Afm/nvACNHK9J9thrZfFF1S4Y7aWFHE4jJKG0OtEKoDhUP1+x8O8
   Q==;
X-CSE-ConnectionGUID: hsUHXVAjQkWNciEZIKuAlA==
X-CSE-MsgGUID: 3wfyH9PLSza8qwV8UzGjRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94884488"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94884488"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 19:12:42 -0700
X-CSE-ConnectionGUID: dinEKornREuhN81oI3uN1A==
X-CSE-MsgGUID: Q4knhfEyTouvEvSZOWYlxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250463377"
Received: from unknown (HELO [10.239.158.29]) ([10.239.158.29])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 19:12:40 -0700
Message-ID: <b9410638-57bd-46c8-b455-d4b288f0a9b1@intel.com>
Date: Thu, 9 Jul 2026 10:12:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Remove AMX-TF32 enumeration
To: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
 Zhao Liu <zhao1.liu@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
References: <20260708210118.402005-1-chang.seok.bae@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260708210118.402005-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/2026 5:01 AM, Chang S. Bae wrote:
> AMX-TF32 enumeration was added based on the Intel documentation [1]. The
> recent update removed the feature, indicating that the feature is no
> longer planned for hardware implementation.

Patch looks good to me.

BTW, I think the bit cannot be assigned for new other usage in the 
future and becomes reserved forever, right?

> [1] Intel Architecture Instruction Set Extensions and Future Features
> 
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> Note: The feature first appeared in the September 2025 revision of the
> document and was removed in the June 2026 revision.
> ---
>   arch/x86/kvm/cpuid.c         | 1 -
>   arch/x86/kvm/reverse_cpuid.h | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 591d2294acd7..759a1c557080 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1082,7 +1082,6 @@ void kvm_initialize_cpu_caps(void)
>   		F(AMX_COMPLEX_ALIAS),
>   		F(AMX_FP16_ALIAS),
>   		F(AMX_FP8),
> -		F(AMX_TF32),
>   		F(AMX_AVX512),
>   		F(AMX_MOVRS),
>   	);
> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
> index 2ad25781cefb..1bb13903c5b2 100644
> --- a/arch/x86/kvm/reverse_cpuid.h
> +++ b/arch/x86/kvm/reverse_cpuid.h
> @@ -56,7 +56,6 @@
>   #define X86_FEATURE_AMX_COMPLEX_ALIAS	KVM_X86_FEATURE(CPUID_1E_1_EAX, 2)
>   #define X86_FEATURE_AMX_FP16_ALIAS	KVM_X86_FEATURE(CPUID_1E_1_EAX, 3)
>   #define X86_FEATURE_AMX_FP8		KVM_X86_FEATURE(CPUID_1E_1_EAX, 4)
> -#define X86_FEATURE_AMX_TF32		KVM_X86_FEATURE(CPUID_1E_1_EAX, 6)
>   #define X86_FEATURE_AMX_AVX512		KVM_X86_FEATURE(CPUID_1E_1_EAX, 7)
>   #define X86_FEATURE_AMX_MOVRS		KVM_X86_FEATURE(CPUID_1E_1_EAX, 8)
>   

