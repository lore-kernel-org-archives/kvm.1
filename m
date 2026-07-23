Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9FC40B113;
	Thu, 23 Jul 2026 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796264; cv=none; b=W1mmgjGkvbRmSN/HLGp5H7XvZgYN+yZeZ+oT3fF8vWcXbXizwFjG/cBLUfSBG5IZW8p5fynb1jdQoZ6isrqjX2XLXRP0fni1kWhu/ESwrqz/XLtFhiI/7h2nk2ncjARK6Go67AtvKUEccUvvTUoekTE96ZRXC6lrclePZsy84SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796264; c=relaxed/simple;
	bh=ri2R10jI/KZqksjq56uANWgNDteZi/WxIAXPivMhEeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/k6LVjFxEM4tMxK4DVHgikv6G0wSkXT65bJdeSbQMHYNlLy71ldvgXkIAKQGI2x9F/CygOJRoBdLXo4q8LtydyMT7+9yuPIqLMFZMyvOFOicDTITr/9AVuqfxxjO+VgxjQxPToeAvlVmwn6I6NP4CuFgOWHtPLRFwaQDsScrf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqF1NydE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqF1NydE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784796258; x=1816332258;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ri2R10jI/KZqksjq56uANWgNDteZi/WxIAXPivMhEeI=;
  b=bqF1NydE1t5kC70yizFhy8nKB3NcsGn/gnsijrh3V10TqJhc+ZzRMFd1
   B+Z/PUhraonbvAzWh5cl9/p85g0+A1G0Nq6Y2iH3Xxyd49cuy+wXkp0S3
   OKb4kpsoLd6GLfWQ8nBc+9x+iVrKxPOmqTage9DqQP5KenRelfaOkqkFv
   umk6TevZ0kEL4cL9ylZDX4aybf97bvPs1wBegr5Jrq2TynaiPtciurt6N
   NJtP06zJYLBU5oPpZB1pra5JQ8vJMdDgp5eCHU4YRVMvrCiKId87dLeXN
   6zV3JGLbwJkR+XtA+l7doI7UDgrevMJSW6cuHQM0WoUjSuFaeQgX6C8w1
   g==;
X-CSE-ConnectionGUID: 89MgtCn3R6SKkHcMsJZ+Iw==
X-CSE-MsgGUID: YhZC8bG8TrmOUoEMLnCMJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85206205"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="85206205"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 01:44:16 -0700
X-CSE-ConnectionGUID: Fgaspw/+Sm6TCmIKzFvJuA==
X-CSE-MsgGUID: G+r80SPPRl+y3k/WeL64WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="253996784"
Received: from unknown (HELO [10.238.208.132]) ([10.238.208.132])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 01:44:10 -0700
Message-ID: <c8b7a800-58ed-4ef7-91bd-31da77763717@intel.com>
Date: Thu, 23 Jul 2026 16:44:08 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/22] KVM: selftests: Initialize the TDX VM
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Kiryl Shutsemau <kas@kernel.org>,
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
 <20260722-tdx-selftests-v14-3-15ad654a50db@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-3-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
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

<snip>

> +/*
> + * TDX ioctls
> + * Use underscores to avoid collisions with struct member names.
> + */
> +#define __tdx_vm_ioctl(vm, cmd, _flags, arg)				\

sev uses the name __vm_sev_ioctl, I think we need to keep them consistent.

> +({									\
> +	u64 r;								\
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
> +	r ?: tdx_cmd.c.hw_error;					\

I know it takes the same handling from __vm_sev_ioctl(). But I think the 
handling for hw_error is not correct, at least for TDX (I didn't check 
for SEV).

the hw_error is the additional info, to tell the SEAMCALL return code, 
when the IOCTL fails. KVM requires hw_error to be in the input, and KVM 
puts the SEAMCALL return code into hw_error when the IOCTL fails due to 
SEAMCALL failure. That means, when r == 0, the hw_error is always 0.

I think we need to provide hw_error along with r to the caller so that 
caller can print them together.

> +})
> +
> +#define tdx_vm_ioctl(vm, cmd, flags, arg)				\
> +({									\
> +	u64 ret = __tdx_vm_ioctl(vm, cmd, flags, arg);			\
> +									\
> +	if (ret) {							\
> +		TEST_ASSERT(!ret,					\
> +			    "%s failed, rc: 0x%llx errno: %i (%s)",	\
> +			    #cmd, (unsigned long long)ret,		\
> +			    errno, strerror(errno));			\

The if() looks silly. Why add it? And why change it from 
__TEST_ASSERT_VM_VCPU_IOCTL() in the v13?

Considering the suggestion of hw_error above, I think we need to 
introduce the TEST_ASSERT_TDX_VM_VCPU_IOCTL() which accepts additional 
hw_error?

<snip>
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> new file mode 100644
> index 000000000000..e1ffb67a106c
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "processor.h"
> +#include "tdx/tdx_util.h"
> +
> +static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)

make it const, is better.

<snip>

> +
> +void tdx_init_vm(struct kvm_vm *vm, u64 attributes)
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
> +	init_vm->attributes = attributes;

Besides CPUID, it only allows attributes to be configure but leave XFAM 
as 0. I think the changelog needs to explain why we need to configure 
attributes.

The rest of the patch looks good to me.

> +
> +	tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
> +
> +	free(init_vm);
> +}
> 

