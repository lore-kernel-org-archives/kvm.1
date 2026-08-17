Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A93BBFDD;
	Mon, 17 Aug 2026 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957494; cv=none; b=Rs6pC2I2JWKZ9amIwGiWN99R3U6mTerXw1lb98lcbfxlHP9Xe46CdYB6qd71bHhCIVbip5QfSLBYYpYQjZjiXQXgnHz3L6S0LBEKwulnNGXzC92/OrDmhV/FlgWX9C2Wwqdk7yzFeNjtRp7qULbzEdKh5+KEdg5PM9vyiUB+XFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957494; c=relaxed/simple;
	bh=grRcmryCx5B9VaG+tqH836/UCsBGAYQCLcV7qNzOAE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dr4RAhHCf00dLeGIm+zuKMKNBA5zsa8VeWvS8xwFE/IzKwLM8summ+Dj5tHp93Nic93rVREGcnDTD65mcuapnNBriTfUevm5EmAGaqu5q6PedPNsTjYcBPlVpfz5VX5ZYpSBJDp7kR8/GMeVF00idqECmT2oMObxQgfa0ni1pYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBO9cj3k; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBO9cj3k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786957492; x=1818493492;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=grRcmryCx5B9VaG+tqH836/UCsBGAYQCLcV7qNzOAE0=;
  b=QBO9cj3kRmWRRCq89gOc7ZbE0S8lUbrM+F/FVtx3Hp8fmBKtFeWKgx4U
   /uO+WCrgM/1Jon35lyd+t1JvNPBK29agZWeK6n/4Z02/o5Rl1t4nI45A2
   UwgKJJqaAj75+fYL6hKHIecKsGwTHF1j0whrcZga0kHVEfKCwtIywcYj/
   1nSukg5UYKiUIbsz/Boom3mVWm1dEvt3wPjfzw3CsoATW1SUg0cQdzvuv
   RHco5qXpbvqJFKglfBx3Fdb3z+915TUcOE/4nay1IgFAQrxJ92k6Ega3H
   cpLgb22dwr/eiWtmBJYIMICYIbd5DNi12ZUU1zd18QJCmfQkxDymupB4J
   g==;
X-CSE-ConnectionGUID: aMsBVEr1Tnek4L15aHUW5g==
X-CSE-MsgGUID: b+loEf/DS2C5slTrOv/U6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87494399"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87494399"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 02:04:51 -0700
X-CSE-ConnectionGUID: ty8M4ZQjQYWHVPnpjcPnug==
X-CSE-MsgGUID: 1nq4hi9VQYiov4qtqrFYwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="266836771"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 02:04:44 -0700
Message-ID: <178eb739-6bf5-4048-b4d9-276f9dc56cc2@intel.com>
Date: Mon, 17 Aug 2026 17:04:41 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 22/22] KVM: selftests: Add TDX lifecycle test
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
 <20260722-tdx-selftests-v14-22-15ad654a50db@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-22-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Adding a test to verify TDX lifecycle by creating a simple TDX VM.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   tools/testing/selftests/kvm/Makefile.kvm           |  1 +
>   .../testing/selftests/kvm/include/x86/processor.h  |  1 +
>   .../selftests/kvm/include/x86/tdx/tdx_util.h       |  5 ++++
>   tools/testing/selftests/kvm/x86/tdx_vm_test.c      | 33 ++++++++++++++++++++++
>   4 files changed, 40 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 28b33ed8c2e6..3561f9284e6f 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -167,6 +167,7 @@ TEST_GEN_PROGS_x86 += rseq_test
>   TEST_GEN_PROGS_x86 += steal_time
>   TEST_GEN_PROGS_x86 += system_counter_offset_test
>   TEST_GEN_PROGS_x86 += pre_fault_memory_test
> +TEST_GEN_PROGS_x86 += x86/tdx_vm_test
>   
>   # Compiled outputs used by test targets
>   TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index ff3219edab44..fa112a1c1c84 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -372,6 +372,7 @@ static inline unsigned int x86_model(unsigned int eax)
>   #define VM_SHAPE_SEV		VM_TYPE(KVM_X86_SEV_VM)
>   #define VM_SHAPE_SEV_ES		VM_TYPE(KVM_X86_SEV_ES_VM)
>   #define VM_SHAPE_SNP		VM_TYPE(KVM_X86_SNP_VM)
> +#define VM_SHAPE_TDX		VM_TYPE(KVM_X86_TDX_VM)
>   
>   #define PHYSICAL_PAGE_MASK      GENMASK_ULL(51, 12)
>   
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index 35f0b2b7ac40..9a882644a48d 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -11,6 +11,11 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>   	return vm->type == KVM_X86_TDX_VM;
>   }
>   
> +static inline bool is_tdx_supported(void)
> +{
> +	return !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_TDX_VM));
> +}
> +
>   /*
>    * TDX ioctls
>    * Use underscores to avoid collisions with struct member names.
> diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> new file mode 100644
> index 000000000000..7cdcaf33b585
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "processor.h"
> +#include "kvm_util.h"
> +#include "tdx/tdx_util.h"
> +#include "ucall_common.h"
> +#include "kselftest_harness.h"
> +
> +static void guest_code_lifecycle(void)
> +{
> +	GUEST_DONE();
> +}
> +
> +TEST(verify_td_lifecycle)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +
> +	vm = vm_create_shape_with_one_vcpu(VM_SHAPE_TDX, &vcpu,
> +					   guest_code_lifecycle);
> +
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_DONE);
> +
> +	kvm_vm_free(vm);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	TEST_REQUIRE(is_tdx_supported());
> +	return test_harness_run(argc, argv);
> +}
> 

