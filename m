Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718E1435EEA;
	Thu, 23 Jul 2026 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801989; cv=none; b=SVH7PyzeHczXnLFXxD1yOw7Hp8oY2xOG5wI3X3r729cpb5C85zW+yWmboynA9Ap9+OOetNJNL+4ri+FZRn6Q/BEOoUbuer5X425LyvQmO8YubYSEjZVWUa+B0Oe2f4QOKEssD76RAjgU78urBf7rmasNlG3Dyn5Sv4v95r7UUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801989; c=relaxed/simple;
	bh=CEcqYpWHXiHeS5g5zOrECeheBpAblVW4Z8EAx0+1+FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhWm5HxI63YAg2LUzBNGpzAKMQD3jglTFME1R6WSAHLY40qOQN+0OyW2YfuEzod2ZtM0TbGp+ngQesX06rd7m4Cj0VvxSNstsEO5c816ZFw5YWrl3Ky5jDpL22x7jsmOsVdpHtA8VbqYJNG8kII+4EIabTVgXAb2jSegdQ2pyrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L844R4s/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L844R4s/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784801986; x=1816337986;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CEcqYpWHXiHeS5g5zOrECeheBpAblVW4Z8EAx0+1+FM=;
  b=L844R4s/bvASBm6gDnhNvZVp2iMv8/7yngzaSOhzO+Ih7FC1jmvkDhWK
   V5Zb/+tXaWtzzuppuZm7h6mcv2MPxAL7XhXk5lt9onpms5nMYDohBTHiW
   vy0YgJkRrlS2M1taNLGFS8sZnZUL+0jkra6bVVFRu2POJ+64CT6nI3cGj
   6IksAcp9AuQYrgX9KKtAcI2xaZculEyWQNQJGsbJTd8nbE5RILXGnb6nz
   zC1fG2pMzaDgpniW87xmAM5demqlNmNMPDURw4Fkl62l2pKP5E1KoaQyk
   9e97ratFutyj/nbNMQGOeIfNh2pFEYQy5+8zGl6Dv+0/InODWlijVpS0G
   g==;
X-CSE-ConnectionGUID: 9Ba7RLjTS9ilgfMKNsFJQA==
X-CSE-MsgGUID: 8lQDWwWrQqaqapaToDv9Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96043190"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="96043190"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 03:19:45 -0700
X-CSE-ConnectionGUID: S4szi9cJSqa05o4k3rbpvQ==
X-CSE-MsgGUID: 4ogazatgQXe1sp80iPmGvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="282885118"
Received: from unknown (HELO [10.238.208.132]) ([10.238.208.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 03:19:38 -0700
Message-ID: <d9fc2591-d47b-47d1-bf43-edc1425800ce@intel.com>
Date: Thu, 23 Jul 2026 18:19:35 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 09/22] KVM: selftests: Expose functions to get default
 sregs values
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-9-15ad654a50db@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-9-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> TDX can't set sregs values directly using KVM_SET_SREGS. Expose the
> default values of certain sregs used by TDX VMs so they can be set
> manually.
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   .../testing/selftests/kvm/include/x86/processor.h  | 35 ++++++++++++++++++++++
>   tools/testing/selftests/kvm/lib/x86/processor.c    | 20 ++++---------
>   2 files changed, 41 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index 76180dfaffea..7e00c9414595 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -29,6 +29,10 @@ extern u64 guest_tsc_khz;
>   #define MAX_NR_CPUID_ENTRIES 100
>   #endif
>   
> +#ifndef NUM_INTERRUPTS
> +#define NUM_INTERRUPTS 256
> +#endif
> +
>   #define NONCANONICAL 0xaaaaaaaaaaaaaaaaull
>   
>   /* Forced emulation prefix, used to invoke the emulator unconditionally. */
> @@ -1564,4 +1568,35 @@ u64 *tdp_get_pte(struct kvm_vm *vm, u64 l2_gpa);
>   
>   bool sys_clocksource_is_based_on_tsc(void);
>   
> +static inline u16 kvm_get_default_idt_limit(void)
> +{
> +	return NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
> +}
> +
> +static inline u16 kvm_get_default_gdt_limit(void)
> +{
> +	return getpagesize() - 1;
> +}
> +
> +static inline u64 kvm_get_default_cr0(void)
> +{
> +	return X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> +}
> +
> +static inline u64 kvm_get_default_cr4(int pgtable_levels)
> +{
> +	u64 cr4 = X86_CR4_PAE | X86_CR4_OSFXSR;
> +
> +	if (kvm_cpu_has(X86_FEATURE_XSAVE))
> +		cr4 |= X86_CR4_OSXSAVE;
> +	if (pgtable_levels == 5)
> +		cr4 |= X86_CR4_LA57;
> +	return cr4;
> +}
> +
> +static inline u64 kvm_get_default_efer(void)
> +{
> +	return EFER_LME | EFER_LMA | EFER_NX;
> +}
> +
>   #endif /* SELFTEST_KVM_PROCESSOR_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 97acc5aaf7b7..ad75e19bb3a2 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -15,10 +15,6 @@
>   #include "tdx/tdx_util.h"
>   #include "vmx.h"
>   
> -#ifndef NUM_INTERRUPTS
> -#define NUM_INTERRUPTS 256
> -#endif
> -
>   gva_t exception_handlers;
>   bool host_cpu_is_amd;
>   bool host_cpu_is_intel;
> @@ -647,17 +643,13 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>   	vcpu_sregs_get(vcpu, &sregs);
>   
>   	sregs.idt.base = vm->arch.idt;
> -	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
> +	sregs.idt.limit = kvm_get_default_idt_limit();
>   	sregs.gdt.base = vm->arch.gdt;
> -	sregs.gdt.limit = getpagesize() - 1;
> -
> -	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> -	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
> -	if (kvm_cpu_has(X86_FEATURE_XSAVE))
> -		sregs.cr4 |= X86_CR4_OSXSAVE;
> -	if (vm->mmu.pgtable_levels == 5)
> -		sregs.cr4 |= X86_CR4_LA57;
> -	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
> +	sregs.gdt.limit = kvm_get_default_gdt_limit();
> +
> +	sregs.cr0 = kvm_get_default_cr0();
> +	sregs.cr4 |= kvm_get_default_cr4(vm->mmu.pgtable_levels);
> +	sregs.efer |= kvm_get_default_efer();
>   
>   	kvm_seg_set_unusable(&sregs.ldt);
>   	kvm_seg_set_kernel_code_64bit(&sregs.cs);
> 

