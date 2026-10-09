Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA23D0C07;
	Fri,  9 Oct 2026 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532588; cv=none; b=uMFgKxbaOkUOwKZPfFjilERSKZl8m/Izn5sBdf6I9Zkboalzbm9qGFU8rVwTut+fVlO/iVnoUD6fYH3uoj2Ztuy9G3UxlUSMED0vEe7GU3tXV/yd6i6xJ/2qeluEtKRH01XZ8x1MGmtNumj+TksfWNtZT5Nivmc9EZQUAsQdJzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532588; c=relaxed/simple;
	bh=sPWIgIslsKPQhJmnIZvKwIQh5gs4LqMjsZ/nweAkSI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAV7YGgZRmiJM0F772OWZCxd8MQmMnSB+rMkqQqZkT/TPhJiWSiuFKq1/SEfsCvHxqwiY0/wB2jY/NIbunggxSntl/apGu4Kry3MZ49uXZ6GF5hIhpPGkXPH+udfqf78VKahtTHL/t+jSVZxTS4XfQg/CkoaI+BKI3dp6evDKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Po20U1ay; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Po20U1ay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791532586; x=1823068586;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sPWIgIslsKPQhJmnIZvKwIQh5gs4LqMjsZ/nweAkSI8=;
  b=Po20U1ayB/9RrHHp84JRzVRjFhC2wn82nATMQmkYLBTcqFv1XprLC5vI
   OofIsq2ZnmjAf3aOVnxQxxxMqhOBF9n7BHrAvfakhOaLbYsegwNqVmAwO
   l5yMtpxjdKHaOqyVtygfM2NIraOcgC6ixubTHhdBqdWwVKXKAKnf7zIbP
   fobtDhkOMKJ+IhgbBOpkWtt9gWTjjVzbtQ87bFJLYWNKFeF9HxeUtA1pS
   /unoSvltFlw48e5V/+fjqfnZUSEGnz/D+eYSq+XOLD8ssnojuBgWcqnPb
   SK/x0k9g0lvKwGneJtWhVgcLYyAOTALBTWFp2+1q/sdVjC66aOenX37qv
   A==;
X-CSE-ConnectionGUID: xG1CTexaTN2ylXeKnp9MWQ==
X-CSE-MsgGUID: zH/VmiA3TrWPqe1FgVasXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="223679"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="223679"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 00:56:25 -0700
X-CSE-ConnectionGUID: fChR7mKfSvemT8ZXZsNggA==
X-CSE-MsgGUID: +/MVYvWARc+nBmlm4c251w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="199840"
Received: from yizheliu-ivm.ccr.corp.intel.com (HELO [10.238.208.114]) ([10.238.208.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 00:56:18 -0700
Message-ID: <b2143700-da36-418c-af63-0b50b33f080e@intel.com>
Date: Fri, 9 Oct 2026 15:56:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 14/23] KVM: selftests: Expose function to allocate
 vCPU stack
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
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
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-14-7c62a5d8a992@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-14-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Introduce kvm_allocate_vcpu_stack() to allocate a vCPU's stack
> in preparation for TDX to allocate a vCPU's stack and initialize
> its stack pointer.
> 
> TDX VMs' registers are protected state and cannot be initialized
> using the KVM_SET_REGS ioctl() that is used for normal VMs. A TDX
> vCPU's stack address will be a property of the TDX specific boot code
> that initializes the vCPUs' stack pointers at boot.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  .../testing/selftests/kvm/include/x86/processor.h  |  2 ++
>  tools/testing/selftests/kvm/lib/x86/processor.c    | 25 +++++++++++++++++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index 8854ee052d29..1eb380dd216c 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -1212,6 +1212,8 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
>  	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
>  }
>  
> +gva_t kvm_allocate_vcpu_stack(struct kvm_vm *vm);
> +
>  u64 vcpu_get_msr(struct kvm_vcpu *vcpu, u64 msr_index);
>  int _vcpu_set_msr(struct kvm_vcpu *vcpu, u64 msr_index, u64 msr_value);
>  
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index da430d4e7765..4a753fb43007 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -851,12 +851,31 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
>  	vcpu_regs_set(vcpu, &regs);
>  }
>  
> -struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
> +gva_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)

Besides what Sashiko pointed out[1], this patch was just messed up during the
rebase and it even doesn't compile.

[1] https://lore.kernel.org/all/20261002091331.BA23F1F00893@smtp.kernel.org/

>  {
>  	struct kvm_mp_state mp_state;
>  	struct kvm_regs regs;
> +	gva_t stack_gva;
>  	struct kvm_vcpu *vcpu;
>  
> +	stack_gva = __vm_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
> +			       DEFAULT_GUEST_STACK_VADDR_MIN, MEM_REGION_DATA);
> +
> +	stack_gva += DEFAULT_STACK_PGS * getpagesize();
> +
> +	/*
> +	 * Align stack to match calling sequence requirements in section "The
> +	 * Stack Frame" of the System V ABI AMD64 Architecture Processor
> +	 * Supplement, which requires the value (%rsp + 8) to be a multiple of
> +	 * 16 when control is transferred to the function entry point.
> +	 *
> +	 * If this code is ever used to launch a vCPU with 32-bit entry point it
> +	 * may need to subtract 4 bytes instead of 8 bytes.
> +	 */
> +	TEST_ASSERT(IS_ALIGNED(stack_gva, PAGE_SIZE),
> +		    "__vm_alloc() did not provide a page-aligned address");
> +	stack_gva -= 8;
> +
>  	vcpu = __vm_vcpu_add(vm, vcpu_id);
>  	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
>  	vcpu_init_sregs(vm, vcpu);
> @@ -864,8 +883,8 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
>  
>  	/* Setup guest general purpose registers */
>  	vcpu_regs_get(vcpu, &regs);
> -	regs.rflags = regs.rflags | X86_EFLAGS_FIXED;
> -	regs.rsp = vm_alloc_stack(vm, DEFAULT_STACK_PGS);
> +	regs.rflags = regs.rflags | 0x2;
> +	regs.rsp = kvm_allocate_vcpu_stack(vm);
>  	vcpu_regs_set(vcpu, &regs);
>  
>  	/* Setup the MP state */
> 

