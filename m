Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45737F72D;
	Sat, 10 Oct 2026 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791597912; cv=none; b=elp0QFQbrYMCzymsnt0+JsI1VIKhI5FdVYNdnmw4LUC2YtUDLXF0/3RMccysAxWcTRmaLY3h6q8HOzk2clTEYMlkjxYt4oT7oDFc7w2GjaAnOuz4TaUB+5CF0YkHZV3rGRgeZJhgG4Br2TbxCKvyvBWIwI6PduA+ih2FWlHR4Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791597912; c=relaxed/simple;
	bh=9I23wXfeNydjEbABcHCnbMQ5LG3hAZhYYOwXKTc4oGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xd2Sqs3pRag0Zirk5JYckUN/nB82RhpHtRIu54sxhmt6uNfRQS6zMFATI8NQWQdCoVXYz2ygGtO2dyfqP+eVSe24vhU8sEQeNllVWvg9aNPaUq+moSs/uXW3Njv5VC47dhwnBujQuEn3anwvclPqSvvobQFwvLct3GE+NQy93WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVTnBAUR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVTnBAUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791597911; x=1823133911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9I23wXfeNydjEbABcHCnbMQ5LG3hAZhYYOwXKTc4oGM=;
  b=MVTnBAURyAAbJ/5NSM+bknYtKvxxexqE2o4/7oCX+jL3rV5k3tg8rWcj
   +74NY9fWCJzB+7E0pDYAxc1jWjlDjnFmXncrkgxe56lEkjb0v6NGhaxtZ
   1EF4X3XcqRYfWcfF6ypluPYV4sgbxIykn+drjKJg3SAt8PXMCIlNwtiZS
   WQw5whRMDqiiHV5vk08X6GLdw0G9CLIugJqx27cLIerFqef5hxPFRmyrN
   +L1TyqG4dssNM7Ah4AaRV46HvBWPRt43VlHuYOM5giJ/+otkc0w+AJu0S
   vsNiQcbhAsMJ87uw7RYfMp/Hza6G//5dZ8/pfToPNMKJ7EXN+BPQfqMSk
   g==;
X-CSE-ConnectionGUID: HDyOqIwpR1mYwJNGE9b0HQ==
X-CSE-MsgGUID: Q9g2N/rWRmm5M8h51X1c3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="509849"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="509849"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 19:05:11 -0700
X-CSE-ConnectionGUID: QQqejKl6SZC1Yv3uZ6HNuQ==
X-CSE-MsgGUID: 3H1uBa4QR4uqaY5lBts9Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="412298"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 19:05:05 -0700
Message-ID: <dc3ff4f6-0017-45ce-96c4-1e40d91cbfc4@linux.intel.com>
Date: Sat, 10 Oct 2026 10:05:02 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 03/23] KVM: selftests: Initialize the TDX VM
To: Lisa Wang <wyihan@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Chao Gao <chao.gao@intel.com>,
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
 Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-3-7c62a5d8a992@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-3-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Add tdx_init_vm() to handle the mandatory VM-level initialization
> sequence required for Intel TDX.
> 
> For TDX, the VM's CPUID configuration must be "sealed" during
> KVM_TDX_INIT_VM before any vCPUs are created. This is necessary because
> the TDX module does not allow the host to create and initialize any
> vCPUs before the VM's CPUID configuration is accepted and sealed into
> the TDCS.
> 
> Additionally, to satisfy the strict requirements of the TDH.MNG.INIT
> SEAMCALL, the helper masks the host-supported CPUID
                                     ^                                
KVM-supported is more accurate

> (kvm_get_supported_cpuid()) against the "directly configurable"bits
> reported by KVM_TDX_CAPABILITIES.
> 
> Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm           |   1 +
>  .../testing/selftests/kvm/include/x86/processor.h  |   2 +
>  .../selftests/kvm/include/x86/tdx/tdx_util.h       |  37 +++++++
>  tools/testing/selftests/kvm/lib/x86/processor.c    |  21 +++-
>  tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 121 +++++++++++++++++++++
>  5 files changed, 178 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 239bc61ea384..8f514008daa2 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -28,6 +28,7 @@ LIBKVM_x86 += lib/x86/pmu.c
>  LIBKVM_x86 += lib/x86/processor.c
>  LIBKVM_x86 += lib/x86/sev.c
>  LIBKVM_x86 += lib/x86/svm.c
> +LIBKVM_x86 += lib/x86/tdx/tdx_util.c
>  LIBKVM_x86 += lib/x86/ucall.c
>  LIBKVM_x86 += lib/x86/vmx.c
>  
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index ed50007e3504..08b7b194f213 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -1024,6 +1024,8 @@ static inline void vcpu_xcrs_set(struct kvm_vcpu *vcpu, struct kvm_xcrs *xcrs)
>  	vcpu_ioctl(vcpu, KVM_SET_XCRS, xcrs);
>  }
>  
> +const struct kvm_cpuid_entry2 *__get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
> +						 u32 function, u32 index);
>  const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
>  					       u32 function, u32 index);
>  const struct kvm_cpuid2 *kvm_get_supported_cpuid(void);
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index f647e6ca6b34..571f7ce4b8fe 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -11,4 +11,41 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>  	return vm->type == KVM_X86_TDX_VM;
>  }
>  
> +/*
> + * TDX ioctls
> + * Use underscores to avoid collisions with struct member names.
> + */
> +#define __tdx_vm_ioctl(vm, cmd, _flags, arg, hw_err)			\
> +({									\
> +	u64 *__hw_err = (hw_err);					\
> +	int r;								\
> +									\
> +	union {								\
> +		struct kvm_tdx_cmd c;					\
> +		unsigned long raw;					\
> +	} tdx_cmd = { .c = {						\
> +		.id = (cmd),						\
> +		.flags = (u32)(_flags),					\
> +		.data = (u64)(arg),					\
> +	} };								\
> +									\
> +	r = __vm_ioctl(vm, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
> +	if (__hw_err)							\
> +		*__hw_err = tdx_cmd.c.hw_error;				\
> +	r;								\
> +})
> +
> +#define tdx_vm_ioctl(vm, cmd, flags, arg)				\
> +({									\
> +	u64 hw_error;							\
> +	int ret = __tdx_vm_ioctl(vm, cmd, flags, arg, &hw_error);	\
> +									\
> +	TEST_ASSERT(!ret,						\
> +		    "%s failed, rc: %d errno: %i (%s) hw_error: 0x%llx",\
> +		    #cmd, ret, errno, strerror(errno),			\
> +		    (unsigned long long)hw_error);			\

hw_error is already u64, why cast it to unsigned long long?
TDX cases can only be done in x86-64, just use 0x%lx for u64? 

> +})
> +
> +void tdx_init_vm(struct kvm_vm *vm);
> +
>  #endif /* SELFTESTS_TDX_TDX_UTIL_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 24395a8e654a..b87ba7d8538b 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -829,6 +829,9 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
>  		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
>  	}
>  
> +	if (is_tdx_vm(vm))
> +		tdx_init_vm(vm);
> +
>  	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
>  	TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ did not provide a valid TSC frequency.");
>  	guest_tsc_khz = r;
> @@ -1347,8 +1350,8 @@ void kvm_init_vm_address_properties(struct kvm_vm *vm)
>  	}
>  }
>  
> -const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
> -					       u32 function, u32 index)
> +const struct kvm_cpuid_entry2 *__get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
> +						 u32 function, u32 index)
>  {
>  	int i;
>  
> @@ -1358,11 +1361,21 @@ const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
>  			return &cpuid->entries[i];
>  	}
>  
> -	TEST_FAIL("CPUID function 0x%x index 0x%x not found ", function, index);
> -
>  	return NULL;
>  }
>  
> +const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
> +					       u32 function, u32 index)
> +{
> +	const struct kvm_cpuid_entry2 *entry;
> +
> +	entry = __get_cpuid_entry(cpuid, function, index);
> +	if (!entry)
> +		TEST_FAIL("CPUID function 0x%x index 0x%x not found ", function, index);
> +
> +	return entry;
> +}
> +
>  #define X86_HYPERCALL(inputs...)					\
>  ({									\
>  	u64 r;							\
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> new file mode 100644
> index 000000000000..3a8900ff2540
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "processor.h"
> +#include "tdx/tdx_util.h"
> +
> +static const struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
> +{
> +	static struct kvm_tdx_capabilities *tdx_cap;
> +	int nr_cpuid_configs = 4;
> +	int rc = -1;
> +	int i;
> +
> +	if (tdx_cap)
> +		return tdx_cap;
> +
> +	do {
> +		nr_cpuid_configs *= 2;
> +
> +		tdx_cap = realloc(tdx_cap, sizeof(*tdx_cap) +
> +					   (sizeof(struct kvm_cpuid_entry2) * nr_cpuid_configs));
> +		TEST_ASSERT(tdx_cap,
> +			    "Could not allocate memory for tdx capability nr_cpuid_configs %d\n",

Nit: Trailing newline in the message could be dropped.


> +			    nr_cpuid_configs);
> +
> +		tdx_cap->cpuid.nent = nr_cpuid_configs;
> +		rc = __tdx_vm_ioctl(vm, KVM_TDX_CAPABILITIES, 0, tdx_cap, NULL);
> +	} while (rc < 0 && errno == E2BIG);
> +
> +	TEST_ASSERT(rc == 0, "KVM_TDX_CAPABILITIES failed: %d %d",
> +		    rc, errno);
> +
> +	pr_debug("tdx_cap: supported_attrs: 0x%016llx\n"
> +		 "tdx_cap: supported_xfam 0x%016llx\n",
> +		 tdx_cap->supported_attrs, tdx_cap->supported_xfam);
> +
> +	for (i = 0; i < tdx_cap->cpuid.nent; i++) {
> +		const struct kvm_cpuid_entry2 *config = &tdx_cap->cpuid.entries[i];
> +
> +		pr_debug("cpuid config[%d]: leaf 0x%x sub_leaf 0x%x eax 0x%08x ebx 0x%08x ecx 0x%08x edx 0x%08x\n",
> +			 i, config->function, config->index,
> +			 config->eax, config->ebx, config->ecx, config->edx);
> +	}
> +
> +	return tdx_cap;
> +}
> +
> +/*
> + * Filter CPUID based on TDX supported capabilities
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   cpuid_data - CPUID fields to filter
> + *
> + * Output Args: None

cpuid_data should be Input/Output Arg?

I am not sure Input Args / Output Args / Return needed though.
It seems the selftests code in kvm/x86 doesn't use this format.

> + *
> + * Return: None
> + *
> + * For each CPUID leaf, filter out unsupported bits based on the capabilities
> + * reported by the TDX module

KVM filters directly configurable features that it doesn't support.
The capabilities reported are not the original version reported by the TDX module.

the TDX module -> KVM ?

> + */
> +static void tdx_filter_cpuid(struct kvm_vm *vm,
> +			     struct kvm_cpuid2 *cpuid_data)
> +{
> +	const struct kvm_tdx_capabilities *tdx_cap;
> +	const struct kvm_cpuid_entry2 *config;
> +	struct kvm_cpuid_entry2 *e;
> +	int i;
> +
> +	tdx_cap = tdx_read_capabilities(vm);
> +
> +	i = 0;
> +	while (i < cpuid_data->nent) {
> +		e = cpuid_data->entries + i;
> +		config = __get_cpuid_entry(&tdx_cap->cpuid, e->function, e->index);
> +
> +		if (!config) {
> +			int left = cpuid_data->nent - i - 1;
> +
> +			if (left > 0)
> +				memmove(cpuid_data->entries + i,
> +					cpuid_data->entries + i + 1,
> +					sizeof(*cpuid_data->entries) * left);
> +			cpuid_data->nent--;
> +			continue;
> +		}
> +
> +		e->eax &= config->eax;
> +		e->ebx &= config->ebx;
> +		e->ecx &= config->ecx;
> +		e->edx &= config->edx;
> +
> +		i++;
> +	}
> +}
> +
> +void tdx_init_vm(struct kvm_vm *vm)
> +{
> +	struct kvm_tdx_init_vm *init_vm;
> +	const struct kvm_cpuid2 *tmp;
> +	struct kvm_cpuid2 *cpuid;
> +
> +	tmp = kvm_get_supported_cpuid();
> +
> +	cpuid = allocate_kvm_cpuid2(tmp->nent);
> +	memcpy(cpuid, tmp, kvm_cpuid2_size(tmp->nent));
> +	tdx_filter_cpuid(vm, cpuid);
> +
> +	init_vm = calloc(1, sizeof(*init_vm) +
> +			 sizeof(init_vm->cpuid.entries[0]) * cpuid->nent);
> +	TEST_ASSERT(init_vm, "init_vm allocation failed");
> +
> +	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
> +	free(cpuid);
> +
> +	init_vm->attributes = 0;
> +	init_vm->xfam = 0;

May be some comments for setting attributes and xfam to 0.
Especially why the test doesn't need SEPT_VE_DISABLE?


> +
> +	tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
> +
> +	free(init_vm);
> +}
> 

