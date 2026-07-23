Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980C43BDB7;
	Thu, 23 Jul 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802865; cv=none; b=G1p0aIzQ4U8W9Uio8yHYw9Jl2ur90NyOiq2/erUsIAvMzqTKkCKRC/QSrdnik8Qx6FLjhs+/Tm9ZFBlU6EmVtiLVlLZXqAL0YslHpnZ/Uc3hy31mbETmOFWCxyIMMq1Eizy69zMIeqBpVIuCaQfnToJdns1AgYc+JQqx/7oIkes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802865; c=relaxed/simple;
	bh=RMA4tV9p0V/8Gxal5K9/hem0Nn5mK4vvXB0MihGP3Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJo2PBtd9SCspfo6xPXeZi7sNMcfbHrA+a3faXsM4ehViBDELeH4qNSgDnHaxMDvi5vey0ZgSkailfYbcNvgwwPQlyqbfxH3DnGWLFAUPRy/37nsgTbHnxJjTAUb1sTZUyovX2aNcBrN757t8vYbuo7RYQXgGO/PJwdP+VaTwUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E23Jb6ZY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E23Jb6ZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784802863; x=1816338863;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RMA4tV9p0V/8Gxal5K9/hem0Nn5mK4vvXB0MihGP3Nc=;
  b=E23Jb6ZYn9hCs/JveUG56ihwP7sNjig/DYk15XkNd74qZ7ztOAzzrT0S
   Rhs1lppAufGaaRb4+DboIJ5Ou/ZTQbcRJ645BJYPFMTvikMML6hWEFH6y
   Zj/le7bardHnJ/NY4sRbWRRQCyyfg9r8Y4PdjvyCvdh2MfvIovwW3qYov
   2E/ZL0pTideML4dowfncXR0QPEDR3+z4zR+7HhZGaNVoGGEpdkA0KFvix
   YObZL/GLt8TSl+OO+nlnedMkqcAjoXzR3+UzxaFz6t+DXo6fcpfm0abTk
   4sNvDARodBFKU0TXpgHfMGZe4w/uqBrH5tHG/jSaIm2dzCmgdrTXoDy85
   Q==;
X-CSE-ConnectionGUID: y/qFAhTwQ06L2yFmcafV8w==
X-CSE-MsgGUID: EP3shEpJShuWp7wlPxZ9ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="95809801"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="95809801"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 03:34:23 -0700
X-CSE-ConnectionGUID: JbyboA1uShmP3vD0rSR6Sg==
X-CSE-MsgGUID: vwjRAvsvQKq/mdszpXrimg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="263344516"
Received: from unknown (HELO [10.238.208.132]) ([10.238.208.132])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 03:34:17 -0700
Message-ID: <992e7da9-15da-4ee2-9954-63ea74ca44e8@intel.com>
Date: Thu, 23 Jul 2026 18:34:14 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 11/22] KVM: selftests: Set up TDX boot parameters
 region
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
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
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-11-15ad654a50db@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-11-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Allocate memory for TDX boot parameters and define the utility functions
> necessary to fill this memory with the boot parameters.
> 
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

2 nits below. I think you can keep the code as-is unless maintainers ask 
you to change.

> ---
>   .../selftests/kvm/include/x86/tdx/tdx_util.h       |  2 +
>   tools/testing/selftests/kvm/lib/x86/processor.c    |  2 +
>   tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 51 ++++++++++++++++++++++
>   3 files changed, 55 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index 642ffa010da3..f5003cbaa106 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -46,5 +46,7 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>   
>   void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
>   void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
> +void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
> +void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
>   
>   #endif /* SELFTESTS_TDX_TDX_UTIL_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index f93953777ca1..748c6041f8bf 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -794,6 +794,8 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
>   	if (is_tdx_vm(vm)) {
>   		tdx_init_vm(vm, 0);
>   		tdx_vm_setup_boot_code_region(vm);
> +		tdx_vm_setup_boot_parameters_region(vm, nr_vcpus);
> +		tdx_vm_load_common_boot_parameters(vm);
>   	}
>   
>   	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index d64d153d19e2..2ce8c297f7ed 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -6,6 +6,7 @@
>   
>   /* Arbitrarily selected to avoid overlaps with anything else */
>   #define TD_BOOT_CODE_SLOT	20
> +#define TD_BOOT_PARAMETERS_SLOT	21
>   
>   #define X86_RESET_VECTOR	0xfffffff0ul
>   #define X86_RESET_VECTOR_SIZE	16
> @@ -49,6 +50,56 @@ void tdx_vm_setup_boot_code_region(struct kvm_vm *vm)
>   	hva[2] = 0xcc;
>   }
>   
> +void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus)
> +{
> +	size_t boot_params_size =
> +		sizeof(struct td_boot_parameters) +
> +		nr_runnable_vcpus * sizeof(struct td_per_vcpu_parameters);

Nit: I'm not sure if the style is acceptable to selftest or not. From 
KVM coding style, it's not common.

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

Nit: I think it's OK to make it just one line.

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
>   static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
>   {
>   	static struct kvm_tdx_capabilities *tdx_cap;
> 

