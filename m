Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD83439F84;
	Thu, 23 Jul 2026 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784805480; cv=none; b=LwwZOe6IcTDy1dv8VO5XEVJPjcEMrBIZOSXZvGQj8r/Z9bBMcrEcia7pSfODI3W9GmtX7Jr6rhIYVrhQ72+50eBghzRCeXsNSSYLelBcpHmRdQX8Di2+yYweSSre74dW8/XcAalPXhBWxPiK2XLv5eH9UwI6IdLQKhrCAoYFlYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784805480; c=relaxed/simple;
	bh=eMwvMv4TYvlpim5DdedkNl7Mz25FND2lgW3Pe9X+8C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbwHR8Oz/5F+lmFQQoqB0B3UFfWa9KhfnTtdfrC/a/ltHzyNzr/+VEdOg4bn+dPBTYE8/TQsPYAndNap3AJX1WTLQ607kZi5ffHA1CfJT9jpzGQFkaUQyEkslu3tit6T89fzqQl9Mt0qUTFxDeHm2rqt/FZiHNkLpvAl4gPetIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4gjaq1Y; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4gjaq1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784805475; x=1816341475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eMwvMv4TYvlpim5DdedkNl7Mz25FND2lgW3Pe9X+8C0=;
  b=e4gjaq1YY59kX7VrHNKWLOZLaEwxh6soeVdu93Nhpy2SaKtHNE7U3pV+
   fpelD2qL1BOjznUx8Rs1dF6D4JjA0OwyHhAR5cQmAfpQaUmO+2Yqm4dJX
   VtkidYWod4fpESSmUrTKVT2XovMt3rmPni9tFZ1FHWuWJF3KOkuQ7PmUL
   knTtpMLvk/3hxu/I8vf7sn2A6J/yMz7aNlZD48trvltCTIDWfioA+/EfU
   BBnU+o/GpXPDSXqDsT5gmafczlJq8NQ89aGXQCQpZ5tVoyg5Imm+RLTj6
   knuxfZJ9UlRA+6dHkldiyuN4hJOZOE9NDDuATjW/joHsbPUu6VSkHHFYk
   g==;
X-CSE-ConnectionGUID: eDzaZPF/QbCSAKiEKq5exQ==
X-CSE-MsgGUID: lOCnRD6PThSYqZjucgCLjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="87999522"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="87999522"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 04:17:48 -0700
X-CSE-ConnectionGUID: SkAjmd3YQROqmGhYjclh2Q==
X-CSE-MsgGUID: BjHtMkYTSx6Jd+DHEaU2lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="256581046"
Received: from unknown (HELO [10.238.208.132]) ([10.238.208.132])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 04:17:41 -0700
Message-ID: <7fcb09da-7085-4df1-8a4a-b959a5c7abf8@intel.com>
Date: Thu, 23 Jul 2026 19:17:38 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 08/22] KVM: selftests: Add TDX boot code
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
 <20260722-tdx-selftests-v14-8-15ad654a50db@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-8-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> 
> Add code to boot a TDX test VM. Since TDX registers are inaccessible to
> KVM, the boot code loads the relevant values from memory into the
> registers before jumping to the guest code.
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   tools/testing/selftests/kvm/Makefile.kvm           |  1 +
>   .../selftests/kvm/include/x86/tdx/td_boot.h        | 22 ++++++--
>   tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S  | 61 ++++++++++++++++++++++
>   3 files changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 397afebbb34b..645d9aac61db 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -32,6 +32,7 @@ LIBKVM_x86 += lib/x86/svm.c
>   LIBKVM_x86 += lib/x86/tdx/tdx_util.c
>   LIBKVM_x86 += lib/x86/ucall.c
>   LIBKVM_x86 += lib/x86/vmx.c
> +LIBKVM_x86 += lib/x86/tdx/td_boot.S
>   
>   LIBKVM_arm64 += lib/arm64/gic.c
>   LIBKVM_arm64 += lib/arm64/gic_v3.c
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> index bf2282931d49..89cf6c3485be 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> @@ -2,9 +2,6 @@
>   #ifndef SELFTEST_TDX_TD_BOOT_H
>   #define SELFTEST_TDX_TD_BOOT_H
>   
> -#include <linux/compiler.h>
> -#include <linux/types.h>
> -
>   /*
>    * Layout for boot section (not to scale)
>    *
> @@ -24,7 +21,19 @@
>    * |                           |
>    * |                           |
>    * |___________________________|____ 0x0_ffff_0000: TD_BOOT_PARAMETERS_GPA
> + *
> + * TD_BOOT_PARAMETERS_GPA is arbitrarily chosen to
> + *
> + * + be within the 4GB address space
> + * + provide enough contiguous memory for the struct td_boot_parameters such
> + *   that there is one struct td_per_vcpu_parameters for KVM_MAX_VCPUS
>    */
> +#define TD_BOOT_PARAMETERS_GPA 0xffff0000
> +
> +#if !defined(__ASSEMBLY__) && !defined(__ASSEMBLER__)
> +
> +#include <linux/compiler.h>
> +#include <linux/types.h>
>   
>   /*
>    * The exact memory layout for LGDT or LIDT instructions.
> @@ -63,4 +72,11 @@ struct td_boot_parameters {
>   	struct td_per_vcpu_parameters per_vcpu[];
>   };
>   
> +void td_boot(void);
> +void td_boot_code_end(void);
> +
> +#define TD_BOOT_CODE_SIZE (td_boot_code_end - td_boot)
> +
> +#endif /* !defined(__ASSEMBLY__) && !defined(__ASSEMBLER__) */
> +
>   #endif /* SELFTEST_TDX_TD_BOOT_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
> new file mode 100644
> index 000000000000..bca9a4c3d8f8
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include "tdx/td_boot.h"
> +#include "tdx/td_boot_offsets.h"
> +#include "processor_asm.h"
> +
> +.code32
> +
> +.globl td_boot
> +td_boot:
> +	/*
> +	 * In this procedure, edi is used as a temporary register.
> +	 * Paging is turned off.
> +	 */
> +	cli
> +
> +	movl $TD_BOOT_PARAMETERS_GPA, %ebx
> +
> +	/*
> +	 * Find the address of struct td_per_vcpu_parameters for this
> +	 * vCPU based on esi (TDX spec: initialized with vCPU id). Put
> +	 * struct address into register for indirect addressing.
> +	 */
> +	movl $SIZEOF_TD_PER_VCPU_PARAMETERS, %eax
> +	mul %esi
> +	leal TD_BOOT_PARAMETERS_PER_VCPU(%ebx), %edi
> +	addl %edi, %eax
> +
> +	/* Setup stack. */
> +	movl TD_PER_VCPU_PARAMETERS_ESP_GVA(%eax), %esp
> +
> +	/* Setup GDT. */
> +	leal TD_BOOT_PARAMETERS_GDT(%ebx), %edi
> +	lgdt (%edi)
> +
> +	/* Setup IDT. */
> +	leal TD_BOOT_PARAMETERS_IDT(%ebx), %edi
> +	lidt (%edi)
> +
> +	/*
> +	 * Set up control registers (There are no instructions to mov from
> +	 * memory to control registers, hence use edi as a scratch register).
> +	 */
> +	movl TD_BOOT_PARAMETERS_CR4(%ebx), %edi
> +	movl %edi, %cr4
> +	movl TD_BOOT_PARAMETERS_CR3(%ebx), %edi
> +	movl %edi, %cr3
> +	movl TD_BOOT_PARAMETERS_CR0(%ebx), %edi
> +	movl %edi, %cr0
> +
> +	/* Switching to 64bit mode after ljmp and then jump to guest code */
> +	ljmp $(KERNEL_CS),$1f
> +1:
> +	jmp *TD_PER_VCPU_PARAMETERS_GUEST_CODE(%eax)
> +
> +/* Leave marker so size of td_boot code can be computed. */
> +.globl td_boot_code_end
> +td_boot_code_end:
> +
> +/* Disable executable stack. */
> +.section .note.GNU-stack,"",%progbits
> 

