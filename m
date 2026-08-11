Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24BA318B9B;
	Tue, 11 Aug 2026 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786429960; cv=none; b=d8dPLQEurrwcUgLLBrpnmBPERBVZSTvPPyG830Hnd+hl5Rv6T+97lqBZgiQHC4L4fM8KF/ft9SXPOAI7c4aVkNG7DPbwB6TX+hjn04weSrzFECLGa8GhghD072L6V/MOyl5IIyKdjZdovsn8KY026IMX+mSgi5NlD+Tr3lffbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786429960; c=relaxed/simple;
	bh=MDeqe2jSiJcmxbD0bbD/r5Z1VSW6NoU5Zo8Ln43j3Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3/Sof4meaS2GRo7FbICtsQoq4V3VQPhq9gKZoqWX3Jbw3TPSp06NVC3czQkSSO9zK4cKetUFeLL/vip6av80VCH9TUn7hoJ5KiMJcTrQihZa9SKckzm1AVt1ukPdKDZipChAw0h6p7nBlEitjug3ZJnVswFLzrTNDWC09KySh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=So0qBxTZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="So0qBxTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786429958; x=1817965958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MDeqe2jSiJcmxbD0bbD/r5Z1VSW6NoU5Zo8Ln43j3Ks=;
  b=So0qBxTZERJzTd264J2NulVdOfLetOxLn8s9c5YhOQ9k01SxV+aQddtd
   Om+vWgXREuLkKjZyjDkc3b2ig3qLMRMV02bLUmFkUkX5K4AuJ4Sg3rzXx
   /M2hFNIOFaMLwvzo0mgU3FktWrrMY8I/hDTi8iQqlY6kWQ2s1k7O2lVTP
   1woZVjyA/J5iTZvQ43bP8rqWodbe/Yl84Fsefvkqggp0vXSUDv3vr0md6
   DQ21PtSe5U8cOANtX1y2Rk2RP3s5gj6KXXUCxTABbKsWKCUAACCxjpLem
   FQXfUILgBFRzhByULq6HdoASqkTWa+dCTm9Gf+L+rNo/BGzy8OLRB3qkh
   g==;
X-CSE-ConnectionGUID: PZcz+DvmTp+547ls6yB8nw==
X-CSE-MsgGUID: Par90D74QUegJkvmBaz+Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="97611429"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="97611429"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 23:32:37 -0700
X-CSE-ConnectionGUID: gOWIzqxqROu0+izp0da+kg==
X-CSE-MsgGUID: dKqF2AB6SHefGa5U1MZEBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="259401913"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 23:32:31 -0700
Message-ID: <2b499ed1-5823-4439-81c3-11ad06957347@linux.intel.com>
Date: Tue, 11 Aug 2026 14:32:29 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 11/22] KVM: selftests: Set up TDX boot parameters
 region
To: Lisa Wang <wyihan@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-11-15ad654a50db@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-11-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Allocate memory for TDX boot parameters and define the utility functions
> necessary to fill this memory with the boot parameters.

The code change looks good to me.

But I think it's better to describe how the parameters are initialized based
on the HVA when VM_MEM_SRC_SHMEM is used alongside KVM_MEM_GUEST_MEMFD.
Same for the patch 10.

> 
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  .../selftests/kvm/include/x86/tdx/tdx_util.h       |  2 +
>  tools/testing/selftests/kvm/lib/x86/processor.c    |  2 +
>  tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 51 ++++++++++++++++++++++
>  3 files changed, 55 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index 642ffa010da3..f5003cbaa106 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -46,5 +46,7 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>  
>  void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
>  void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
> +void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
> +void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
>  
>  #endif /* SELFTESTS_TDX_TDX_UTIL_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index f93953777ca1..748c6041f8bf 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -794,6 +794,8 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
>  	if (is_tdx_vm(vm)) {
>  		tdx_init_vm(vm, 0);
>  		tdx_vm_setup_boot_code_region(vm);
> +		tdx_vm_setup_boot_parameters_region(vm, nr_vcpus);
> +		tdx_vm_load_common_boot_parameters(vm);
>  	}
>  
>  	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index d64d153d19e2..2ce8c297f7ed 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -6,6 +6,7 @@
>  
>  /* Arbitrarily selected to avoid overlaps with anything else */
>  #define TD_BOOT_CODE_SLOT	20
> +#define TD_BOOT_PARAMETERS_SLOT	21
>  
>  #define X86_RESET_VECTOR	0xfffffff0ul
>  #define X86_RESET_VECTOR_SIZE	16
> @@ -49,6 +50,56 @@ void tdx_vm_setup_boot_code_region(struct kvm_vm *vm)
>  	hva[2] = 0xcc;
>  }
>  
> +void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus)
> +{
> +	size_t boot_params_size =
> +		sizeof(struct td_boot_parameters) +
> +		nr_runnable_vcpus * sizeof(struct td_per_vcpu_parameters);
> +	int npages = DIV_ROUND_UP(boot_params_size, PAGE_SIZE);
> +	const u64 gmem_flags = 0;
> +	gpa_t gpa;
> +
> +	vm_mem_add(vm, VM_MEM_SRC_SHMEM, TD_BOOT_PARAMETERS_GPA,
> +		   TD_BOOT_PARAMETERS_SLOT, npages,
> +		   KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);
> +	gpa = vm_phy_pages_alloc(vm, npages, TD_BOOT_PARAMETERS_GPA, TD_BOOT_PARAMETERS_SLOT);
> +	TEST_ASSERT(gpa == TD_BOOT_PARAMETERS_GPA, "Failed vm_phy_pages_alloc\n");
> +
> +	virt_map(vm, TD_BOOT_PARAMETERS_GPA, TD_BOOT_PARAMETERS_GPA, npages);
> +}
> +
> +void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm)
> +{
> +	struct td_boot_parameters *params =
> +		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
> +	u32 cr4;
> +
> +	cr4 = kvm_get_default_cr4(vm->mmu.pgtable_levels);
> +
> +	/* TDX spec 11.6.2: CR4 bit MCE is fixed to 1 */
> +	cr4 |= X86_CR4_MCE;
> +
> +	/* TDX spec 11.6.2: CR4 bit VMXE and SMXE are fixed to 0 */
> +	cr4 &= ~(X86_CR4_VMXE | X86_CR4_SMXE);
> +
> +	/* Set parameters! */
> +	params->cr0 = kvm_get_default_cr0();
> +	TEST_ASSERT(vm->mmu.pgd < (1ULL << 32),
> +		    "PGD must be within 32-bit address space for 32-bit boot code");
> +	params->cr3 = vm->mmu.pgd;
> +	params->cr4 = cr4;
> +	params->idtr.base = vm->arch.idt;
> +	params->idtr.limit = kvm_get_default_idt_limit();
> +	params->gdtr.base = vm->arch.gdt;
> +	params->gdtr.limit = kvm_get_default_gdt_limit();
> +
> +	TEST_ASSERT(params->cr0 != 0, "cr0 should not be 0");
> +	TEST_ASSERT(params->cr3 != 0, "cr3 should not be 0");
> +	TEST_ASSERT(params->cr4 != 0, "cr4 should not be 0");
> +	TEST_ASSERT(params->gdtr.base != 0, "gdt base address should not be 0");
> +	TEST_ASSERT(params->idtr.base != 0, "idt base address should not be 0");
> +}
> +
>  static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
>  {
>  	static struct kvm_tdx_capabilities *tdx_cap;
> 

