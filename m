Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DEA3D6CD6;
	Sat, 10 Oct 2026 03:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604497; cv=none; b=Z7X3ugzzt33BeQwamzOCm9bRCNWoo43M2E8HmLJOs9ulY7bRUd1Qm8QOv+aMNIMij24AadYdrFrgUD0YoRM3zvnkEVZbRlT3KnSUGeulQobXs7+LnH3/Q4JNTkPForODhcvCVPuT7YvgJHijHObRUKeS+FBq1tsDxcCoH6zzFrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604497; c=relaxed/simple;
	bh=vao8T0ntCrZ65nxL5fkeRY2wkDgW73C1nkNvuLDdxXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXnTk3iCWc/d4hxHkwTCYsNir12YDs29yzEuY2p9y2kkVTmGz+A7hPE/iGhcY8J2Em6E+iSd8kP9/9/qpUmG9pr01L05gidPV8Uq4AmlJCMfDIVqbKdV2nibbK8eP4jI5XMWgYTGq+4gmakZ/fbUeXnbF8GzMwhCEsYFY+8bb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8nWeZRv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8nWeZRv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791604491; x=1823140491;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vao8T0ntCrZ65nxL5fkeRY2wkDgW73C1nkNvuLDdxXo=;
  b=g8nWeZRvealF1YHbmmouskzWmSNaAUbgb2dx2aY/+FnFlbcpwRF+oLJc
   ai1HG4cPALenPk51WXQey3vlXaQKb9z9UEzQhaOR3w+DzizmGnl1VsFoq
   wLpvV8CTPyThHwazPM6CUm0e2KUNJBw458kSqTQHhHW2bnI9Q9W98NL6i
   NdmAA8JjrfctMdZRNHMxTQhM/LMUtgEyJih16BJHOEmPFCftmJrAA+Fhl
   7mfYXQpRaGnGON4nHgImsfQKHvSiOXfbQmYiQQD28WEG/nMmfyPg+F7R2
   koHsnUeS+8oP3ySz1DnHarXnjH4JoKvV+/n/V+Kc+90ouiaG8mrS++MUR
   w==;
X-CSE-ConnectionGUID: YIrtv94KTrS9g3EnIUInpQ==
X-CSE-MsgGUID: Vj18sfGnQFGWsxrxNP4k1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="407433"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="407433"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 20:54:51 -0700
X-CSE-ConnectionGUID: GLD/bdgAS4WSKp88uBXzDw==
X-CSE-MsgGUID: K+HpcyrdQ8i8dSSlCWQEGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2288765"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 20:54:45 -0700
Message-ID: <932ec219-5951-489b-bda9-1f6e9a605a9b@linux.intel.com>
Date: Sat, 10 Oct 2026 11:54:42 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 14/23] KVM: selftests: Expose function to allocate
 vCPU stack
To: Xiaoyao Li <xiaoyao.li@intel.com>, Lisa Wang <wyihan@google.com>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org,
 Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng
 <ackerleytng@google.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-14-7c62a5d8a992@google.com>
 <b2143700-da36-418c-af63-0b50b33f080e@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <b2143700-da36-418c-af63-0b50b33f080e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/2026 3:56 PM, Xiaoyao Li wrote:
> On 10/2/2026 3:37 AM, Lisa Wang wrote:
>> From: Sagi Shahar <sagis@google.com>
>>
>> Introduce kvm_allocate_vcpu_stack() to allocate a vCPU's stack
>> in preparation for TDX to allocate a vCPU's stack and initialize
>> its stack pointer.
>>
>> TDX VMs' registers are protected state and cannot be initialized
>> using the KVM_SET_REGS ioctl() that is used for normal VMs. A TDX
>> vCPU's stack address will be a property of the TDX specific boot code
>> that initializes the vCPUs' stack pointers at boot.
>>
>> Signed-off-by: Sagi Shahar <sagis@google.com>
>> Signed-off-by: Lisa Wang <wyihan@google.com>
>> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>  .../testing/selftests/kvm/include/x86/processor.h  |  2 ++
>>  tools/testing/selftests/kvm/lib/x86/processor.c    | 25 +++++++++++++++++++---
>>  2 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
>> index 8854ee052d29..1eb380dd216c 100644
>> --- a/tools/testing/selftests/kvm/include/x86/processor.h
>> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
>> @@ -1212,6 +1212,8 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
>>  	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
>>  }
>>  
>> +gva_t kvm_allocate_vcpu_stack(struct kvm_vm *vm);
>> +
>>  u64 vcpu_get_msr(struct kvm_vcpu *vcpu, u64 msr_index);
>>  int _vcpu_set_msr(struct kvm_vcpu *vcpu, u64 msr_index, u64 msr_value);
>>  
>> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
>> index da430d4e7765..4a753fb43007 100644
>> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
>> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
>> @@ -851,12 +851,31 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
>>  	vcpu_regs_set(vcpu, &regs);
>>  }
>>  
>> -struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
>> +gva_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
> 
> Besides what Sashiko pointed out[1], this patch was just messed up during the
> rebase and it even doesn't compile.


Yes.

And since the upstream code already has vm_alloc_stack(), which basically does
the same thing.

I think this patch can be dropped. 

> 
> [1] https://lore.kernel.org/all/20261002091331.BA23F1F00893@smtp.kernel.org/
> 
>>  {
>>  	struct kvm_mp_state mp_state;
>>  	struct kvm_regs regs;
>> +	gva_t stack_gva;
>>  	struct kvm_vcpu *vcpu;
>>  
>> +	stack_gva = __vm_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
>> +			       DEFAULT_GUEST_STACK_VADDR_MIN, MEM_REGION_DATA);
>> +
>> +	stack_gva += DEFAULT_STACK_PGS * getpagesize();
>> +
>> +	/*
>> +	 * Align stack to match calling sequence requirements in section "The
>> +	 * Stack Frame" of the System V ABI AMD64 Architecture Processor
>> +	 * Supplement, which requires the value (%rsp + 8) to be a multiple of
>> +	 * 16 when control is transferred to the function entry point.
>> +	 *
>> +	 * If this code is ever used to launch a vCPU with 32-bit entry point it
>> +	 * may need to subtract 4 bytes instead of 8 bytes.
>> +	 */
>> +	TEST_ASSERT(IS_ALIGNED(stack_gva, PAGE_SIZE),
>> +		    "__vm_alloc() did not provide a page-aligned address");
>> +	stack_gva -= 8;
>> +
>>  	vcpu = __vm_vcpu_add(vm, vcpu_id);
>>  	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
>>  	vcpu_init_sregs(vm, vcpu);
>> @@ -864,8 +883,8 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
>>  
>>  	/* Setup guest general purpose registers */
>>  	vcpu_regs_get(vcpu, &regs);
>> -	regs.rflags = regs.rflags | X86_EFLAGS_FIXED;
>> -	regs.rsp = vm_alloc_stack(vm, DEFAULT_STACK_PGS);
>> +	regs.rflags = regs.rflags | 0x2;
>> +	regs.rsp = kvm_allocate_vcpu_stack(vm);
>>  	vcpu_regs_set(vcpu, &regs);
>>  
>>  	/* Setup the MP state */
>>
> 

