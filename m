Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263873C98AE;
	Tue,  9 Jun 2026 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987536; cv=none; b=eOa7R1oMxPjKgkYXYt6CxHgUCo4WBBK159h0KcMmo5R4ciCaCVVtccrd7KBhG13hezkMVpy1CQP70s3ypCJdw4xpGElqmuWAwyIJhXGtJry3/MRCx0wZpnwExVOqdPuydV256mL/82tuFimZlqycagtp3x0gRUu8drA5mzqQTJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987536; c=relaxed/simple;
	bh=mReAix0LSYK6FclEHavg7EVgJC59/qq0PQ1n3G0Dor0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2Nf8EeQr12KH0o9pUNTQuYcv/LHTxIqwywu5+dk6QK9Io2HDRK1Pif46F5E/BAae0k6YHs9c/yZnbCcao+7d7E0ctcEeU4Dcr/fzTYJAUBR9mZ2nR8XDlo/XztEPUuWN734+Z/HFoIgzkESvIRdXkBWm0wWsVkTkgkFZTca+OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLi5PomX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLi5PomX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780987535; x=1812523535;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mReAix0LSYK6FclEHavg7EVgJC59/qq0PQ1n3G0Dor0=;
  b=NLi5PomX6ZX3q3i7xLN28t4S8x298PJpgGsOevudHd3gekInAyFYCWHt
   wI/3WbGrUqrJ+njeVRzbwsUPIwe5fQETV7SApY8kfMhrDcC7GlrGu6LFd
   E4B/edLtYSrkDRLKmcBPNC+LrZaqfIVSq1L4mlMEAcEU+HNDptJDvrVWk
   wojfr58ZWjNA+oetMUb2HqveaNC9CpT5hPxhJPLqNtKKhYa+pJzKsnjXq
   9/nBx8mi20vlb4hbcwXK0YjXFxQRkWoaBMo461Rut4u82DaKJYQJjswKa
   xHLWOEUvP0T41sJhJND4abawzUNurTdxn42S4XCZpqJdH1Ecf9/4RgfKF
   w==;
X-CSE-ConnectionGUID: K8dc8MmrTHSqJtzXVlb1Bg==
X-CSE-MsgGUID: UAf0fOa6RKOuN63DrmpSMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="107175923"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="107175923"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 23:45:34 -0700
X-CSE-ConnectionGUID: qJtNBrs8QnqhS9ujN+hdAA==
X-CSE-MsgGUID: w5/whA3kSkGPcZA6dTvr9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245623860"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 23:45:28 -0700
Message-ID: <051df51b-cbf0-48d2-8d34-9392783afe2d@linux.intel.com>
Date: Tue, 9 Jun 2026 14:45:25 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 20/22] KVM: selftests: Implement MMIO WRITE for the
 TDX VM
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
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-20-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-20-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/2026 7:17 AM, Lisa Wang wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> 
> Implement the tdx_mmio_write() to allow TDX VMs to request MMIO
> emulation.
> 
> Follow the Intel Guest-Hypervisor Communication Interface (GHCI) spec
> to the minimum extent that a spec-abiding TDX module will pass the
> request to KVM. Skip implementing the #VE handler as described in the
> GHCI spec so selftests will not take a dependency on having a working
                                                                       ^
Something was cut off?

> 
> To perform emulated I/O, VMs use the TDG.VP.VMCALL instruction to
> request MMIO.
> 
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Co-developed-by: Lisa Wang <wyihan@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm          |  1 +
>  tools/testing/selftests/kvm/include/x86/tdx/tdx.h | 16 ++++++++++++
>  tools/testing/selftests/kvm/lib/x86/tdx/tdx.c     | 30 +++++++++++++++++++++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index a651a876c522..489324cecf83 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -33,6 +33,7 @@ LIBKVM_x86 += lib/x86/ucall.c
>  LIBKVM_x86 += lib/x86/vmx.c
>  LIBKVM_x86 += lib/x86/tdx/tdx_util.c
>  LIBKVM_x86 += lib/x86/tdx/td_boot.S
> +LIBKVM_x86 += lib/x86/tdx/tdx.c
>  
>  LIBKVM_arm64 += lib/arm64/gic.c
>  LIBKVM_arm64 += lib/arm64/gic_v3.c
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> new file mode 100644
> index 000000000000..810ca7423c84
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTESTS_TDX_TDX_H
> +#define SELFTESTS_TDX_TDX_H

Nit:
The headers in tools/testing/selftests/kvm use SELFTEST_KVM_XXX.

> +
> +#include <linux/types.h>
> +
> +enum mmio_size {
> +	MMIO_SIZE_1B = 1,
> +	MMIO_SIZE_2B = 2,
> +	MMIO_SIZE_4B = 4,
> +	MMIO_SIZE_8B = 8
> +};
> +
> +u64 tdx_mmio_write(u64 address, enum mmio_size size, u64 data_in);
> +
> +#endif // SELFTESTS_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> new file mode 100644
> index 000000000000..f19be79fe11f
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "tdx/tdx.h"
> +
> +#define TDG_VP_VMCALL 0
> +#define TDG_VP_VMCALL_VE_REQUEST_MMIO    48
> +#define TDVMCALL_MMIO_WRITE		  1
> +#define TDVMCALL_EXPOSE_REGS_MASK    0xFC00
> +
> +u64 tdx_mmio_write(u64 address, enum mmio_size size, u64 data_in)
> +{
> +	register u64 r10_reg asm("r10") = TDG_VP_VMCALL;

I think this should just be 0 instead of TDG_VP_VMCALL, although
TDG_VP_VMCALL is also 0.
Per GHCI spec about R10:
 : Set to 0 indicates that TDG.VP.VMCALL leaf used in R11 is defined
 : in this specification.
 : All other values 0x1 to 0xFFFFFFFFFFFFFFFF indicate TDG.VP.VMCALL
 : is vendor-specific (both R10 and R11).


> +	register u64 r11_reg asm("r11") = TDG_VP_VMCALL_VE_REQUEST_MMIO;
> +	register u64 r12_reg asm("r12") = size;
> +	register u64 r13_reg asm("r13") = TDVMCALL_MMIO_WRITE;
> +	register u64 r14_reg asm("r14") = address;
> +	register u64 r15_reg asm("r15") = data_in;
> +	register u64 rax_reg asm("rax") = TDG_VP_VMCALL;
> +	register u64 rcx_reg asm("rcx") = TDVMCALL_EXPOSE_REGS_MASK;
> +
> +	asm volatile(
> +	 ".byte 0x66,0x0f,0x01,0xcc" /* tdcall */
> +	 : "+r" (r10_reg), "+r" (r11_reg)
> +	 : "r" (r12_reg), "r" (r13_reg), "r" (r14_reg), "r" (r15_reg),
> +	   "r" (rax_reg), "r" (rcx_reg)
> +	 : "cc", "memory"
> +	);
> +
> +	return r10_reg;
> +}
> 

