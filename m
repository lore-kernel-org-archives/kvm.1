Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E122D2488;
	Wed, 17 Jun 2026 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781666522; cv=none; b=KNm36se7lEZ3/BoZ2GFzN2j7XxIL/PeXlCoxDQsYqcpXOxy+C5QsNT3Fyk/b92ruN6sbcEXheP+ulwYKuyWXVB92xW+kF9IFwfmli4k3PnqLXH+tXgUfyyRm5tfLQ5Mt3UqvddECExgsARKwMsdkKQJCsNVew6GqT8PJ9ZzB/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781666522; c=relaxed/simple;
	bh=6HpxdSonD14MUq86QFuFcHCrJli+014DzQjASDo8anA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaXDINIeKicLZ/xZ00B6RQrzqz15GgNi8x056r8BMFnAsmqIv9wsdnO34Pi7YcdPGxW5JioT3anPL5wg+pc98ZoMCeZxQMOWX2/kK6fcp4skuF0FVMZ7zXWz00Ul3k8LUpDi9UYMvqD8ml0hSeJYt2ERv894NeQ8uo4L3f6fOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBp5efAq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBp5efAq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781666521; x=1813202521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6HpxdSonD14MUq86QFuFcHCrJli+014DzQjASDo8anA=;
  b=JBp5efAqTyN0lbYYWVfBnld7VRpBrA0ZT1nAT9UtmCMVvTE5y99QQqPw
   5NeQuWbJ7F5cApUnn/aYKLpvG2cfACzWhQJIhgXpVIa9Mx4R49FYeo7wV
   FUEiWLCOJttnIIagtlCaAJpd2Vu3lc9SXlV1crbbeQbYHFPaoTVsxUJPm
   riy6zm4akOT/d1J83JoqJ1A19PbN8bzLduWJi8OFDx01jOWVVtFepMu6a
   3aBIEY4p+YEvogB6bmpZUkIMvkg3uLxGWlbI2UsIyNDutYQ5Bk1CYKSns
   Ea/00XAmsXlkfEpUq44L9Po7ajTOaxdPUZCtjwoJVK/MmMyJbtTXlChH4
   Q==;
X-CSE-ConnectionGUID: cY55M1osSYGn+fypGwlRMw==
X-CSE-MsgGUID: vbQCA1noQAOg3lH0p3XfLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93937538"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93937538"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 20:22:00 -0700
X-CSE-ConnectionGUID: xidktX55RqWZASGKUWF32Q==
X-CSE-MsgGUID: xZBIA6wJSB2UaDzMKqPTAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="252906870"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 20:21:52 -0700
Message-ID: <d27cce6a-da0b-46dc-96b3-5f2f699907eb@intel.com>
Date: Wed, 17 Jun 2026 11:21:49 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 03/22] KVM: selftests: Initialize the TDX VM
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
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-3-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-3-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2026 7:16 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Add tdx_init_vm() to handle the mandatory VM-level initialization
> sequence required for Intel TDX.
> 
> For TDX, the guest's CPUID configuration must be "sealed" during
> KVM_TDX_INIT_VM before any vCPUs are created. This is necessary because
> the TDX hardware directly virtualizes CPUID and includes the
> configuration in the guest's initial security measurement.
> 
> The helper calculates the required CPUID values by filtering the host-
> supported bits (kvm_get_supported_cpuid) against the "directly
> configurable" bits reported by KVM_TDX_CAPABILITIES, ensuring
> compliance with the strict requirements of the TDH.MNG.INIT SEAMCALL.
> 
> Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>   .../selftests/kvm/include/x86/tdx/tdx_util.h       |  30 +++++
>   tools/testing/selftests/kvm/lib/x86/processor.c    |   3 +
>   tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 137 +++++++++++++++++++++
>   3 files changed, 170 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index f647e6ca6b34..48d4bd36c35b 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -11,4 +11,34 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>   	return vm->type == KVM_X86_TDX_VM;
>   }
>   
> +/*
> + * TDX ioctls
> + * Use underscores to avoid collisions with struct member names.
> + */
> +#define __tdx_vm_ioctl(vm, cmd, _flags, arg)				\
> +({									\
> +	int r;								\
> +									\
> +	union {								\
> +		struct kvm_tdx_cmd c;					\
> +		unsigned long raw;					\
> +	} tdx_cmd = { .c = {						\
> +		.id = (cmd),						\
> +		.flags = (u32)(_flags),				\
> +		.data = (u64)(arg),				\
> +	} };								\
> +									\
> +	r = __vm_ioctl(vm, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
> +	r ?: tdx_cmd.c.hw_error;					\
> +})

It looks __tdx_vm_ioctl() can be implemented as the static inline function.

Given all the existing xxx_ioctl() are implmeneted as MACRO, I'm OK with it.

> +
> +#define tdx_vm_ioctl(vm, cmd, flags, arg)				\
> +({									\
> +	int ret = __tdx_vm_ioctl(vm, cmd, flags, arg);			\
> +									\
> +	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, vm);		\
> +})
> +
> +void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
> +
>   #endif /* SELFTESTS_TDX_TDX_UTIL_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index b68ad1dc7e02..8d06e7186df1 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -802,6 +802,9 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
>   		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
>   	}
>   
> +	if (is_tdx_vm(vm))
> +		tdx_init_vm(vm, 0);
> +
>   	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
>   	TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ did not provide a valid TSC frequency.");
>   	guest_tsc_khz = r;
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> new file mode 100644
> index 000000000000..868ff62e22f2
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "tdx/tdx_util.h"
> +
> +static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
> +{
> +	struct kvm_tdx_capabilities *tdx_cap = NULL;
> +	int nr_cpuid_configs = 4;
> +	int rc = -1;
> +	int i;
> +
> +	do {
> +		nr_cpuid_configs *= 2;
> +
> +		tdx_cap = realloc(tdx_cap, sizeof(*tdx_cap) +
> +					   sizeof(tdx_cap->cpuid) +

No need to add sizeof(tdx_cap->cpuid). It's included by sizeof(*tdx_cap)

> +					   (sizeof(struct kvm_cpuid_entry2) * nr_cpuid_configs));
> +		TEST_ASSERT(tdx_cap,
> +			    "Could not allocate memory for tdx capability nr_cpuid_configs %d\n",
> +			    nr_cpuid_configs);
> +
> +		tdx_cap->cpuid.nent = nr_cpuid_configs;
> +		rc = __tdx_vm_ioctl(vm, KVM_TDX_CAPABILITIES, 0, tdx_cap);
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

The debug info will be printed everytime the function is called, which 
is unnecessary.

Ideally, the kvm_tdx_capabilities can be cached like what is done for 
kvm_supported_cpuid.

> +	return tdx_cap;
> +}
> +
> +static struct kvm_cpuid_entry2 *tdx_find_cpuid_config(struct kvm_tdx_capabilities *cap,
> +						      u32 leaf, u32 sub_leaf)
> +{
> +	struct kvm_cpuid_entry2 *config;
> +	u32 i;
> +
> +	for (i = 0; i < cap->cpuid.nent; i++) {
> +		config = &cap->cpuid.entries[i];
> +
> +		if (config->function == leaf && config->index == sub_leaf)
> +			return config;
> +	}
> +
> +	return NULL;
> +}

No need to introduce a new fucntin. We can use get_cpuid_entry().

