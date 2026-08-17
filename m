Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEE03BA235;
	Mon, 17 Aug 2026 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957002; cv=none; b=iiuRTWpb02J7RGYX3IwZnRhcGVAiJsKaGQldf9cbH8fu+pabwKLYbnGHElxWg337pZb5tINQ2CQQbntHQIHtYUgA1Pa6+AWro60pQ/RvCm1MNME09mLmQDg64FHQJB8SJJfRKDMFYP+smrUmOPktWjPzd9eC9jPsATO/XGQtOtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957002; c=relaxed/simple;
	bh=Oyf77Pklv8oD9GCGBZn6XD0f7eaFIvJwFs0ZGTdzefU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mrjd+CcYoDweSXI3GXiLj6T4FZl/TUm6wCgC6DSG6+Nc2/Iq+JeitLLTtTYkW7gLACrqocgXd4vgZNtzH1nfAtH3OdHQerprnl1pvPkF4pJlwqFd0WzRRK7bLzZOMrHRY94BtcQF+swrRMUuRJNRWwxFLz3e1/L5r7ZtjhEkjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fIXrev89; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fIXrev89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786957000; x=1818493000;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oyf77Pklv8oD9GCGBZn6XD0f7eaFIvJwFs0ZGTdzefU=;
  b=fIXrev89xPVSJ1GVgyeGSDUCSepZM2e6cUO7YxKTL1fOgTateCy7Uyv8
   vMsQ+e+XuRwonlenpH+zXBrOwI43KKAA32AHfp7B03lTYPmGGrVU0SH2/
   Z2szUTF6SE2jan8jM5nYmxc/El9SAofgg43fcyl69ytpaQA82fM1BNVMv
   OzHR6mMafy/YJSQr9xVULI0vPLGBRdCvqYtEwm6/daIz+bs9zJEzWDDVN
   rRUZZStM0KWntc56QqY2czl6B5WrqUKwrRoQc2N5g+RfixIX+idZIu9PT
   fBlp3u1pal1vPhhaLAC+UtXAVfdrf0MIkdvdJZfk0zrbwWplmgNQ6Ex4r
   w==;
X-CSE-ConnectionGUID: OBMBfwV4TtaXFzB1iVfSiA==
X-CSE-MsgGUID: +J1QafBcQ/2UljCSh3zO0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87493700"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87493700"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:56:39 -0700
X-CSE-ConnectionGUID: rDrpkQz2T622V7o1lPhTzg==
X-CSE-MsgGUID: rGIHdk20Q2WuAUiujGUutg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="266835637"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:56:33 -0700
Message-ID: <37947172-c6e1-43e9-8cac-770f3f6fcb62@intel.com>
Date: Mon, 17 Aug 2026 16:56:30 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 20/22] KVM: selftests: Implement MMIO WRITE for the
 TDX VM
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
 <20260722-tdx-selftests-v14-20-15ad654a50db@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-20-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> 
> Implement the tdx_mmio_write() to allow TDX VMs to request MMIO
> emulation.
> 
> Follow the Intel Guest-Hypervisor Communication Interface (GHCI) spec
> to the minimum extent that a spec-abiding TDX module will pass the
> request to KVM. 

I don't get what it wants to say with this.

> Skip implementing the #VE handler as described in the
> GHCI spec to reduce selftests dependency.
> 
> To perform emulated I/O, VMs use the TDG.VP.VMCALL instruction to

To perform emulated MMIO?

> request MMIO.
> 
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Co-developed-by: Lisa Wang <wyihan@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>   tools/testing/selftests/kvm/Makefile.kvm          |  1 +
>   tools/testing/selftests/kvm/include/x86/tdx/tdx.h | 17 +++++++++++
>   tools/testing/selftests/kvm/lib/x86/tdx/tdx.S     | 37 +++++++++++++++++++++++
>   3 files changed, 55 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 645d9aac61db..28b33ed8c2e6 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -33,6 +33,7 @@ LIBKVM_x86 += lib/x86/tdx/tdx_util.c
>   LIBKVM_x86 += lib/x86/ucall.c
>   LIBKVM_x86 += lib/x86/vmx.c
>   LIBKVM_x86 += lib/x86/tdx/td_boot.S
> +LIBKVM_x86 += lib/x86/tdx/tdx.S
>   
>   LIBKVM_arm64 += lib/arm64/gic.c
>   LIBKVM_arm64 += lib/arm64/gic_v3.c
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> new file mode 100644
> index 000000000000..6355a30bb47f
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_KVM_TDX_TDX_H
> +#define SELFTEST_KVM_TDX_TDX_H
> +
> +#include <linux/types.h>
> +
> +#define TDG_VP_VMCALL_VE_REQUEST_MMIO    48

I know it is the name in GHCI spec. But MMIO doesn't have to be invoked 
by #VE. I think we can directly call it

TDG_VP_VMCALL_MMIO

> +#define TDVMCALL_MMIO_WRITE		  1

So we are defining TDG_VP_VMCALL_* and TDVMCALL_*. We'd better to make 
it consistent.


> +u64 __tdcall(u64 leaf, u64 r12, u64 r13, u64 r14, u64 r15);
> +
> +static inline u64 tdx_mmio_write(u64 address, u32 size, u64 data_in)
> +{
> +	return __tdcall(TDG_VP_VMCALL_VE_REQUEST_MMIO, size,
> +			TDVMCALL_MMIO_WRITE, address, data_in);
> +}
> +#endif /* SELFTEST_KVM_TDX_TDX_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S
> new file mode 100644
> index 000000000000..dff48a3624a1
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +.globl __tdcall
> +/*
> + * u64 __tdcall(u64 leaf, u64 r12, u64 r13, u64 r14, u64 r15)

this funtion is specific to TDG.VP.VMCALL. Please just name it 
tdg_vp_vmcall()

> + */
> +__tdcall:
> +	push %r12
> +	push %r13
> +	push %r14
> +	push %r15
> +
> +	/* Map C ABI fast arguments to TDX GHCI payload registers */
> +	/* RDI=leaf, RSI=r12, RDX=r13, RCX=r14, R8=r15 */

/*
  *
  */

for multiple-line comments?

> +	mov %rdi, %r11
> +	mov %rsi, %r12
> +	mov %rdx, %r13
> +	mov %rcx, %r14
> +	mov %r8,  %r15
> +
> +	/* TDCALL boilerplate */

it's not TDCALL boilerplate but TDG.VP.VMCALL since below rax is 
hardcoded to 0.

> +	mov $0, %rax
> +	mov $0xFC00, %rcx	/* Expose R10-R15 */
> +	mov $0, %r10
> +
> +	/* tdcall instruction */
> +	.byte 0x66, 0x0f, 0x01, 0xcc
> +
> +	/* Extract status */
> +	mov %r10, %rax
> +
> +	pop %r15
> +	pop %r14
> +	pop %r13
> +	pop %r12
> +	ret
> 

