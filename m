Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB22652A2;
	Wed, 17 Jun 2026 02:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781663891; cv=none; b=ADFxJgXfZ9e/LVyZJuknENEitpcOvzKkLKUEePIPHwDliSW3k8pkoTinnh2zZoH6tLvPpexoj+FOseHOCPMHAbZbu+RSfwZUj/BNeM2WfSgWlwDHV717qVVM7x+mtGir6LuxWGHR4k3Fva3Uw83rKkoVVpbtibl5BtnGDX2JUbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781663891; c=relaxed/simple;
	bh=BCedZ8Rz/sbsae+H5+CU0ZsEreiRmGlqG1pWD3F6WcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2IXYsy9mb0+acDEZ4BgEaRrx5lhGyjE1EjSXubB71W79RvxUuyHuVv0poAXBGQM2oVX7P4r3aFA3J/0IlrDX0QtYXr9xuw27T3B6yuPScPkgBBb8VXp4rZ4iYJkr6yBTE092mG3wohHGmfIcuTnL7KpvSf7kSk25wCVnOtus5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkDhKX55; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkDhKX55"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781663889; x=1813199889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BCedZ8Rz/sbsae+H5+CU0ZsEreiRmGlqG1pWD3F6WcI=;
  b=OkDhKX55bAYWryneruz1t9ZxfxMlU6lB6fjqH0TYmYcK/mqcIAbsgBDV
   ai3VG/WYCNpN+DLPcwxBM5hzlH5U0/s2aFnM8djm2TccWx8bQCeOwPACN
   3z62VB2SHV6kB32N/FTRNmu8blZ27g8VaLD1mdy4mZiUaZDWrqy2s6Vye
   swBWFAHChflnGviwXX8Tk6A1X6A/B4CIppev1UnIamwjc5q9KyM000Wx7
   sM6TUnuVzxXgB91cEyikgeiSzhJQZ+iqP/ab2fy/i1aBbd8AnFon6I6LJ
   ZgVqPcrJiEGes53oo/yzRE9OWXeNQVb73OeM109r74fpwX5uqKHr+G3lC
   Q==;
X-CSE-ConnectionGUID: mmFqlQYiScyPHRCkp4+GcQ==
X-CSE-MsgGUID: vPxoqpEDRKmiCq8BwGyy6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82315494"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82315494"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 19:38:04 -0700
X-CSE-ConnectionGUID: Eb653s8HSTyqv1EOEU4eoA==
X-CSE-MsgGUID: bIk3G2dsRWWKXPPFJ45fuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="271657628"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 19:37:54 -0700
Message-ID: <d8a9a574-1c15-4c94-b33d-fa72e1b5096d@intel.com>
Date: Wed, 17 Jun 2026 10:37:50 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 02/22] KVM: selftests: Update
 kvm_init_vm_address_properties() for TDX
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
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-2-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-2-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2026 7:16 AM, Lisa Wang wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Initialize the TDX S-bit and the GPA tag mask in
> kvm_init_vm_address_properties() for TDX VMs, similar to how the C-bit
> is initialized for SEV VMs.
> 
> The TDX S-bit is used to distinguish between shared and private guest
> physical addresses. Its position is determined by the guest physical
> address width, which is either 48 or 52 bits for current TDX
> implementations.
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h | 14 ++++++++++++++
>   tools/testing/selftests/kvm/lib/x86/processor.c        | 12 ++++++++++--
>   2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> new file mode 100644
> index 000000000000..f647e6ca6b34
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTESTS_TDX_TDX_UTIL_H
> +#define SELFTESTS_TDX_TDX_UTIL_H
> +
> +#include <stdbool.h>
> +
> +#include "kvm_util.h"
> +
> +static inline bool is_tdx_vm(struct kvm_vm *vm)
> +{
> +	return vm->type == KVM_X86_TDX_VM;
> +}
> +
> +#endif /* SELFTESTS_TDX_TDX_UTIL_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index b51467d70f6e..b68ad1dc7e02 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -11,6 +11,7 @@
>   #include "smm.h"
>   #include "svm_util.h"
>   #include "sev.h"
> +#include "tdx/tdx_util.h"
>   #include "vmx.h"
>   
>   #ifndef NUM_INTERRUPTS
> @@ -1311,12 +1312,19 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
>   
>   void kvm_init_vm_address_properties(struct kvm_vm *vm)
>   {
> +	u32 gpa_bits = kvm_cpu_property(X86_PROPERTY_GUEST_MAX_PHY_ADDR);
> +
> +	vm->arch.sev_fd = -1;
> +
>   	if (is_sev_vm(vm)) {
>   		vm->arch.sev_fd = open_sev_dev_path_or_exit();
>   		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
>   		vm->gpa_tag_mask = vm->arch.c_bit;
> -	} else {
> -		vm->arch.sev_fd = -1;
> +	} else if (is_tdx_vm(vm)) {
> +		TEST_ASSERT(gpa_bits == 48 || gpa_bits == 52,
> +			    "TDX: bad X86_PROPERTY_GUEST_MAX_PHY_ADDR value: %u", gpa_bits);
> +		vm->arch.s_bit = BIT_ULL(gpa_bits - 1);
> +		vm->gpa_tag_mask = vm->arch.s_bit;
>   	}
>   }
>   
> 

