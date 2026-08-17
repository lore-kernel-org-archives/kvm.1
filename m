Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400643C276E;
	Mon, 17 Aug 2026 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955941; cv=none; b=GfV7XPWckElJ4lGG2zkT8DMsr1rCasRTCpVyt4bkDthDC/RVGGY42IoWd3x5ItJWwrxA/o3EA2edFl/ryQokOXuutpAg+mgfbGrCjwgJWOEb3B+J9UmoglFVVNexw9Pi4DMpX4PlFbIcitg7qgWDWxXDOkx8ZvhOnpXo5+NNESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955941; c=relaxed/simple;
	bh=ROBv2th78MGCFfWabBK1ufzPRFzh9sp/ZCygz4RvuEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlCtjWkDB/PALEiRVK1Jrws4pw6gxAEqhtxEgzD+hjubE6Kq1Z3FeFDEXbeleDXrDcaTeIyH+3KYrD8fecXfl8eumMSHAIeY1cuxKLaLNfttFb5/AYYPWgfSwHxPvysSpb1gSjgr7bppNYgskwRSNUXPAHHdSERlafj0Nw7N1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrS1p6Bl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrS1p6Bl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786955938; x=1818491938;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ROBv2th78MGCFfWabBK1ufzPRFzh9sp/ZCygz4RvuEY=;
  b=JrS1p6Blp9I02lotbWU7h9IDa6WkIDndvOZCCuQckwqCw61rvn9eIU+u
   OO4zF1wgVJfqlDHYF5986VZWq3OuNJ5ZmXYGV739oOjS/rkoxvTZPtClt
   YiUTY35vLrmd8Qk31cFiVXCUNMSRJ+pJoPhPk/bKnSiNXe3HaMLmPsS9W
   N9ndlo7Ute/lqyh8DQB0KQndiAjP5YnwRk196sz+NMQujdPh5BJY3SGYB
   o4/PzdnYIKCxllOCGxHdJcOulDhwO5tJ8lRYaykY+VJVED4n1RzXFT43M
   MvhgriFmkOS5TfCZrlfFnxQgjfQD7pv1EhVBSqTQ9Nr9xABvsB2OGTl3w
   g==;
X-CSE-ConnectionGUID: PlcOG5FuQXiHKE3RrizYtA==
X-CSE-MsgGUID: KzMUfajgRBqq+o1Lu/a18w==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="110209901"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="110209901"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:38:57 -0700
X-CSE-ConnectionGUID: LxLWBrCVSTatPMboJKUI8Q==
X-CSE-MsgGUID: 7660VKgXRfmpDn41i44a9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="266832796"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:38:52 -0700
Message-ID: <6f89fc78-0344-4a7e-bbd8-ac201b8f845a@intel.com>
Date: Mon, 17 Aug 2026 16:38:49 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 21/22] KVM: selftests: Add ucall support for TDX
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
 <20260722-tdx-selftests-v14-21-15ad654a50db@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-21-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Implement TDX ucall using TDCALL-based MMIO to pass the ucall address
> from the VM to the host.
> 
> In standard KVM selftests, ucall uses a PIO instruction as a trigger
> to exit to the host, which then retrieves the ucall address by reading
> the guest's RDI register. This approach is incompatible with TDX
> because the host cannot access guest registers.
> 
> Furthermore, PIO exits only expose 4 bytes of immediate data, which
> is insufficient for a 8-byte ucall address. By using TDCALL-based MMIO,
> the VM can share the full 8-byte address in a single exit without
> refactoring the common ucall framework and other non-x86 architectures.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Co-developed-by: Lisa Wang <wyihan@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>   tools/testing/selftests/kvm/include/x86/ucall.h |  6 -----
>   tools/testing/selftests/kvm/lib/x86/ucall.c     | 33 +++++++++++++++++++++++++
>   2 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/ucall.h b/tools/testing/selftests/kvm/include/x86/ucall.h
> index 0e4950041e3e..7e54ec2c1a45 100644
> --- a/tools/testing/selftests/kvm/include/x86/ucall.h
> +++ b/tools/testing/selftests/kvm/include/x86/ucall.h
> @@ -2,12 +2,6 @@
>   #ifndef SELFTEST_KVM_UCALL_H
>   #define SELFTEST_KVM_UCALL_H
>   
> -#include "kvm_util.h"
> -
>   #define UCALL_EXIT_REASON       KVM_EXIT_IO

This seems to leave the potential issue for future since x86 now 
supports different EXIT_REASON for UCALL.

> -static inline void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
> -{
> -}
> -
>   #endif
> diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
> index e7dd5791959b..7a954b2d0bdd 100644
> --- a/tools/testing/selftests/kvm/lib/x86/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
> @@ -5,11 +5,35 @@
>    * Copyright (C) 2018, Red Hat, Inc.
>    */
>   #include "kvm_util.h"
> +#include "tdx/tdx.h"
> +#include "tdx/tdx_util.h"
>   
>   #define UCALL_PIO_PORT ((u16)0x1000)
>   
> +/* HPET address is guaranteed to be unused for ucall MMIO */
> +#define UCALL_MMIO_GPA 0xfed00000
> +
> +static u8 vm_type;
> +static gpa_t ucall_mmio_gpa;
> +
> +void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
> +{
> +	vm_type = vm->type;
> +	sync_global_to_guest(vm, vm_type);

It works and it looks simple. But we have the architectural approach to 
test if a guest is TD guest, by checking the CPUID 0x21.

Since checking CPUID 0x21 is not complex, and as a bonus it can help 
test if TDX module behaves correctly for CPUID leaf 0x21, I think we 
should switch to use CPUID 0x21 to check if it is TDX VM in guest code?

> +	if (is_tdx_vm(vm)) {
> +		ucall_mmio_gpa = UCALL_MMIO_GPA | vm->arch.s_bit;

So the passed-in @mmio_gpa is not used. Why cannot use the mmio_gpa,

   slot0->region.guest_phys_addr + slot0->region.memory_size

chosen by __vm_create()?

> +		sync_global_to_guest(vm, ucall_mmio_gpa);
> +	}
> +}
> +
>   void ucall_arch_do_ucall(gva_t uc)
>   {
> +	if (vm_type == KVM_X86_TDX_VM) {
> +		tdx_mmio_write(ucall_mmio_gpa, sizeof(gva_t), uc);
> +		return;
> +	}
> +
>   	/*
>   	 * FIXME: Revert this hack (the entire commit that added it) once nVMX
>   	 * preserves L2 GPRs across a nested VM-Exit.  If a ucall from L2, e.g.
> @@ -46,6 +70,15 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
>   {
>   	struct kvm_run *run = vcpu->run;
>   
> +	if (vm_type == KVM_X86_TDX_VM) {
> +		if (run->exit_reason == KVM_EXIT_MMIO &&
> +		    run->mmio.phys_addr == UCALL_MMIO_GPA &&
> +		    run->mmio.len == sizeof(gva_t) &&
> +		    run->mmio.is_write)
> +			return (void *)(*((gva_t *)run->mmio.data));
> +		return NULL;
> +	}
> +
>   	if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
>   		struct kvm_regs regs;
>   
> 

