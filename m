Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5973F3AE19B;
	Mon, 20 Jul 2026 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784527902; cv=none; b=oI4epxBu5eRCmLK1eQZXqqUTYhFxFPiSIsqHeWlBIp/pX7vqFiLhqikti1fw3nf+UM52kCuUt3e0/v/iYEPRGy7qG72yip4Gwc1H0rpqpqvVE8Q0pKlQJJ/L7dpPEEhU1CWnzqiAfwt0NL18v8Byts7mBrX/IyvbwTmOD8SqaIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784527902; c=relaxed/simple;
	bh=CEmBNjqeUV0F5PsRspBho0WN8S8xA8SWD6OU96fKsa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEoijQe+RSIBpx3pdJ3xanKbMmATrsIvT96kaTLxHy8d1tUTyr8laNllbZC8+eDvmsJxPyntwDad+fDBxD4aZA0ITP3oyFX6ZGiOZmFCXJOVcf/w3wOch376VHwL2f0Rnd4QepFIYNTE0JaS6Xs0QIHJngxB9lBX/1/NJx5HlnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBqdQXbX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBqdQXbX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784527891; x=1816063891;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CEmBNjqeUV0F5PsRspBho0WN8S8xA8SWD6OU96fKsa8=;
  b=jBqdQXbXxPrvwTrh6zmv7UT0IefnFG4j3S8YI35qq1RIuf8TRgivRTqK
   ESGs+c9PT57V8SlDlUq/RgmrRokbaKSK1na8j8Hi2gaBa7doe6uJXsamx
   v04Uqz1RgdJ+Ak6OvlSGN2pM8RjbxKdWhEY7kZNd6a0Hnt4tFKSXUYH3f
   IK9VYcaalvTQ6i/sjv7Z7IuBR4F7uKzmp3ohfkY2oqpoeuLExHx7ZsN7l
   8K2qe0X+TYRXK594s6lThDmdpCF5bZqyplo/bm8dYcMu71KSgAvCCBqQ/
   0ns+v80m6XR3VG5AUPj2YjSqWqqBYvWZsN58mR22q1ItBD8bXbnzaQseG
   g==;
X-CSE-ConnectionGUID: 1kSGtJG+TeOL9l8GUA6BSw==
X-CSE-MsgGUID: f1vAUqnzTkiR5G7wjtb3zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="84086891"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="84086891"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 23:11:24 -0700
X-CSE-ConnectionGUID: e8D6Zv/lQ+WOc/Zi3nu0fw==
X-CSE-MsgGUID: JVbo7JhjRgahpQxzXxgQRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="261651575"
Received: from unknown (HELO [10.238.2.244]) ([10.238.2.244])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 23:11:22 -0700
Message-ID: <c4343410-c5fc-4171-a120-a3786ea38a20@linux.intel.com>
Date: Mon, 20 Jul 2026 14:11:19 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Remove AMX-TF32 enumeration
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 seanjc@google.com, Zhao Liu <zhao1.liu@intel.com>
References: <20260708210118.402005-1-chang.seok.bae@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260708210118.402005-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/2026 5:01 AM, Chang S. Bae wrote:
> AMX-TF32 enumeration was added based on the Intel documentation [1]. The
> recent update removed the feature, indicating that the feature is no
> longer planned for hardware implementation.
> 
> [1] Intel Architecture Instruction Set Extensions and Future Features
> 
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

> ---
> Note: The feature first appeared in the September 2025 revision of the
> document and was removed in the June 2026 revision.

IMHO, the note is informative.
Is it better to move it to the body of the changelog?

> ---
>  arch/x86/kvm/cpuid.c         | 1 -
>  arch/x86/kvm/reverse_cpuid.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 591d2294acd7..759a1c557080 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1082,7 +1082,6 @@ void kvm_initialize_cpu_caps(void)
>  		F(AMX_COMPLEX_ALIAS),
>  		F(AMX_FP16_ALIAS),
>  		F(AMX_FP8),
> -		F(AMX_TF32),
>  		F(AMX_AVX512),
>  		F(AMX_MOVRS),
>  	);
> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
> index 2ad25781cefb..1bb13903c5b2 100644
> --- a/arch/x86/kvm/reverse_cpuid.h
> +++ b/arch/x86/kvm/reverse_cpuid.h
> @@ -56,7 +56,6 @@
>  #define X86_FEATURE_AMX_COMPLEX_ALIAS	KVM_X86_FEATURE(CPUID_1E_1_EAX, 2)
>  #define X86_FEATURE_AMX_FP16_ALIAS	KVM_X86_FEATURE(CPUID_1E_1_EAX, 3)
>  #define X86_FEATURE_AMX_FP8		KVM_X86_FEATURE(CPUID_1E_1_EAX, 4)
> -#define X86_FEATURE_AMX_TF32		KVM_X86_FEATURE(CPUID_1E_1_EAX, 6)
>  #define X86_FEATURE_AMX_AVX512		KVM_X86_FEATURE(CPUID_1E_1_EAX, 7)
>  #define X86_FEATURE_AMX_MOVRS		KVM_X86_FEATURE(CPUID_1E_1_EAX, 8)
>  

