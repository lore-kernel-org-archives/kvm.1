Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82711C3F31;
	Tue, 23 Jun 2026 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179996; cv=none; b=f6ki2oy8RZ9mfDFUUXiF/zmPD6PCuseVIToiQWH6jX4LkyO0f8vybBwMq44pX/AOaVZp4EPMWuV3IavDvkztPQXNvv77w6rXcIoCvGufEdg+zXCziaocf1+4UbTMf00F1HruoHOY708gP0litf5zSfHNe3iiF/CscfTphMgIF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179996; c=relaxed/simple;
	bh=y8r7p0aS42aPKj2cF+3PhRwu0lZj2g44SnufwIbftTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1t8huQ8zsFwXR3Jmo8rijDrVmliziO2HFNWblvoRxG4sGMawnpXMhAlTzE4DVed1IMxQiMwt0VTQ4cAtL5oDkMwfb76RQEUv5RTV9o0uRKtWyni233yDcJZU5NL2ypymKWfaOs8MtXInty4yoh3bA2+HOHGmNzVI2sy6rjnl9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJKCQgUg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJKCQgUg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782179996; x=1813715996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y8r7p0aS42aPKj2cF+3PhRwu0lZj2g44SnufwIbftTU=;
  b=CJKCQgUgKDZX/XTiGASRLbHEFq148Npmo5TDv8/nT3Di+EPO1ZVPV6rJ
   mOGU3Qo0wap6kARME9HHMVVo66vaWG8O+SfWJQybkCyJiUHo5Ty1FwqQb
   /JitArMcDvPmSSJDwYtu/x2jyI9kK1WpeiL9qS3ws0UBBFC1S1IRVqz2k
   V/tlk8YEOKjH3TTsA1db7K1+6gXVJIzLLsNAxFxqKwNsVAT2fPPQeAHFP
   P8EOMVAbKWXlZtILESay1vgw167ObYgd1hfqmLeXaGifAHpphadRMSM21
   PSa9R3/TjbRzNmPVKZ9ahGWghcLYhsTAryNm7va6dHNt6eol5RQJCC82X
   A==;
X-CSE-ConnectionGUID: 38qUYbefRa6inmScDTacSw==
X-CSE-MsgGUID: WrFZZcm8Sj2je62OvZJCGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82687631"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82687631"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 18:59:55 -0700
X-CSE-ConnectionGUID: kOVtgx2ZTwaWXu+0vapFSQ==
X-CSE-MsgGUID: hAzyAjTCQhS3Gq4ocdIzKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="251316609"
Received: from unknown (HELO [10.239.158.46]) ([10.239.158.46])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 18:59:46 -0700
Message-ID: <1b332812-f3f4-41d3-936b-829f2f9f7968@intel.com>
Date: Tue, 23 Jun 2026 09:59:44 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 08/22] KVM: selftests: Add TDX boot code
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
 <20260521-tdx-selftests-v13-v13-8-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-8-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2026 7:16 AM, Lisa Wang wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> 
> Add code to boot a TDX test VM. Since TDX registers are inaccessible to
> KVM, the boot code loads the relevant values from memory into the
> registers before jumping to the guest code.
> 

<snip>

> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> index af4474dee387..e5d54a20ed72 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> @@ -66,4 +66,9 @@ struct td_boot_parameters {
>   	struct td_per_vcpu_parameters per_vcpu[];
>   };
>   
> +void td_boot(void);
> +void td_boot_code_end(void);
> +
> +#define TD_BOOT_CODE_SIZE (td_boot_code_end - td_boot)
> +
>   #endif /* SELFTEST_TDX_TD_BOOT_H */
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
> new file mode 100644
> index 000000000000..10b4b527595c
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_TDX_TD_BOOT_ASM_H
> +#define SELFTEST_TDX_TD_BOOT_ASM_H
> +
> +/*
> + * GPA where TD boot parameters will be loaded.
> + *
> + * TD_BOOT_PARAMETERS_GPA is arbitrarily chosen to
> + *
> + * + be within the 4GB address space
> + * + provide enough contiguous memory for the struct td_boot_parameters such
> + *   that there is one struct td_per_vcpu_parameters for KVM_MAX_VCPUS
> + */
> +#define TD_BOOT_PARAMETERS_GPA 0xffff0000

Why not just put it into tdx_boot.h where it also gets referenced?

And even just define it in patch 06.

> +#endif  // SELFTEST_TDX_TD_BOOT_ASM_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
> new file mode 100644
> index 000000000000..7aa33caa9a78
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include "tdx/td_boot_asm.h"
> +#include "tdx/td_boot_offsets.h"
> +#include "processor_asm.h"
> +
> +.code32
> +
> +.globl td_boot
> +td_boot:
> +	/* In this procedure, edi is used as a temporary register. */
> +	cli
> +
> +	/* Paging is off. */

It's weird to put such a comment here. Put it together with the comment 
above cli?

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

