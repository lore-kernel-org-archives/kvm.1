Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12C2620DE;
	Mon, 17 Aug 2026 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949244; cv=none; b=bEnwA+dNGAPtzYIrq876GKRN2F+yeiIYQyfuOEolqaWGRM4nESUCcSC1plDeN/lecRrYHH8Ey0zFzmbwLsoJJxgu1MgMS2YyxUELekxTzkg36Grx9oiHhfkttkROQHG4r0fkmr7nxnM83d574o3t2acVSRkRUh9SnXjklc1ne+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949244; c=relaxed/simple;
	bh=rBAt5JSF8N4gutaSGQQffiI9UN1FrxqHbJoLm3BcSRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/Msv9vQveXKnnvCq5paCp+QLXbeywpE+wlzXxFWgR10+Fnp9YVwrSfDXOYZbxJsNpJjYfbsdWAdzXVMKoaWsQTI2INLi0Xf9MBlKJfg4C7gjVVTor8uyp6+c1cvJiWFce4UICdPPG2y36ddkoXZPxiu5gjZGag5BH4xa5mlfWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bwvvhwrb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bwvvhwrb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786949242; x=1818485242;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rBAt5JSF8N4gutaSGQQffiI9UN1FrxqHbJoLm3BcSRM=;
  b=BwvvhwrbR+NaqTZms9+s3Kx+bUOukkt+LfLw3uXLvq8OifrhjpD0Ce9b
   Yavf5SVOzlmYIzJuxJp0k5RlQk/BRVXLuNdXJDNTC99Xh3EkXkixACEzC
   amsI8o2Ey6cPOlFGM9nbdlwm/65B7IK5swZMCju/6Z39b0/KzDsJkTBAN
   bY6/MFOvZ5ZOe5KyOu4+OeG8Fm5g9+X1CwKQD3fmGVyL1uB2iZ3nD3Pgw
   p7eUlwJlpVpuTT4anLw1JCa73YnLZiYDryzXpLhP1fClSEoq3D9GFVzi4
   4Ureo+XekEuYlRPvXdeuERer3yzQdlwNdoY4j7WBdaplvIW2wUoHuyShS
   Q==;
X-CSE-ConnectionGUID: iGdbxk7PS/mr2J6EMbUD8Q==
X-CSE-MsgGUID: JobiXEubQoKDDNaaeQVivQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="91095439"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="91095439"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 23:47:21 -0700
X-CSE-ConnectionGUID: nH80rfgWSAuDqcgW6t+70w==
X-CSE-MsgGUID: B0HsR4VgQoeru5UkUVXaGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="261548300"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 23:47:13 -0700
Message-ID: <befe73e1-3287-440e-90de-6c62f6c19d47@intel.com>
Date: Mon, 17 Aug 2026 14:47:10 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 18/22] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
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
 <20260722-tdx-selftests-v14-18-15ad654a50db@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-18-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> TDX protected memory needs to be measured and encrypted before it can be
> used by the guest. Traverse the VM's memory regions and initialize all
> the protected ranges by calling KVM_TDX_INIT_MEM_REGION.
> 
> Once all the memory is initialized, the VM can be finalized by calling
> KVM_TDX_FINALIZE_VM.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Co-developed-by: Lisa Wang <wyihan@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>   .../selftests/kvm/include/x86/tdx/tdx_util.h       |  2 +
>   tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 63 ++++++++++++++++++++++
>   2 files changed, 65 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index 307e2c0bc9c9..35f0b2b7ac40 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -72,4 +72,6 @@ void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
>   void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
>   void tdx_vcpu_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
>   
> +void tdx_vm_finalize(struct kvm_vm *vm);
> +
>   #endif /* SELFTESTS_TDX_TDX_UTIL_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index be63d8652a02..831b0e5160df 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -1,5 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   
> +#include <linux/align.h>
> +
>   #include "processor.h"
>   #include "tdx/td_boot.h"
>   #include "tdx/tdx_util.h"
> @@ -251,3 +253,64 @@ void tdx_init_vm(struct kvm_vm *vm, u64 attributes)
>   
>   	free(init_vm);
>   }
> +
> +static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
> +				u64 gpa, u64 size)
> +{
> +	u32 flags = KVM_TDX_MEASURE_MEMORY_REGION;
> +	struct kvm_tdx_init_mem_region mem_region = {
> +		.source_addr = (u64)source_pages,
> +		.gpa = gpa,
> +		.nr_pages = size / PAGE_SIZE,
> +	};
> +	struct kvm_vcpu *vcpu;
> +
> +	vcpu = list_first_entry_or_null(&vm->vcpus, struct kvm_vcpu, list);
> +
> +	TEST_ASSERT(size && IS_ALIGNED(size, PAGE_SIZE),
> +		"Cannot add partial pages to the guest memory.\n");
> +	TEST_ASSERT(IS_ALIGNED((u64)source_pages, PAGE_SIZE),
> +		"Source memory buffer is not page aligned\n");
> +	tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_MEM_REGION, flags, &mem_region);
> +}
> +
> +static void tdx_load_private_memory(struct kvm_vm *vm)
> +{
> +	struct userspace_mem_region *region;
> +	int ctr;
> +
> +	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
> +		const struct sparsebit *protected_pages = region->protected_phy_pages;
> +		const gpa_t gpa_base = region->region.guest_phys_addr;
> +		const u64 hva_base = region->region.userspace_addr;
> +		const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
> +		void *source_pages = NULL;
> +		sparsebit_idx_t i, j;
> +
> +		if (!sparsebit_any_set(protected_pages))

sparebit_any_set() doens't check if the input is NULL. So we need to 
check it here.

> +			continue;
> +
> +		TEST_ASSERT(region->region.guest_memfd != -1,
> +			    "TD private memory must be backed by guest_memfd");
> +
> +		sparsebit_for_each_set_range(protected_pages, i, j) {
> +			const u64 size_to_load = (j - i + 1) * vm->page_size;
> +			const u64 offset =
> +				(i - lowest_page_in_region) * vm->page_size;
> +			const u64 hva = hva_base + offset;
> +			const u64 gpa = gpa_base + offset;
> +
> +			if (!kvm_has_gmem_attributes)
> +				source_pages = (void *)hva;
> +

> +			vm_mem_set_private(vm, gpa, size_to_load);

So vm_mem_set_private() has to be called at this late stage when run 
with in-place gmem. But for non in-place gmem, we can actually call 
vm_mem_set_private() in __vm_phy_pages_alloc().

Calling vm_mem_set_private() here instead of in __vm_phy_pages_alloc() 
looks like a trick to me. That is, we cannot set the page as private 
when allocating a guest physical page as protected because if doing so, 
we cannot write the initial content to it.

This is the topic about how to implement the infras for in-place gmem, 
not the issue of this series. Let me go read the selftest patches of 
gmem in-place series and we can discuss there.

> +			tdx_init_mem_region(vm, source_pages, gpa, size_to_load);
> +		}
> +	}
> +}
> +
> +void tdx_vm_finalize(struct kvm_vm *vm)
> +{
> +	tdx_load_private_memory(vm);
> +	tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
> +}
> 

