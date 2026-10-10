Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943941D9663;
	Sat, 10 Oct 2026 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614089; cv=none; b=esuXn90A/44IsJCYt3gxIDS8gvTt3h1tJegzzTrJBn9IBcZiR+nF/MVCvRF7pdPsTckjiASNQtZ7wDMdh3cRBO4+O1baQ0LdmhwpquyoHcCbp996fnBCLDs/+U5voHStBi7bVvFCyV1VuuaK2GZidWDUnl3jQG2a4795zwGaFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614089; c=relaxed/simple;
	bh=zLNWD/PtFSv0VQe12gjFdaXFCOlxUNhURfbgNEAp+Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ck+QHuMc70U+75jVe7Nemq31c5QdvSjKGh9VNm4IOZ53DCd4ZZFGWuuZSpas3TtC1tNBO13NFqX0Qrqhw2Vr3P5zEY54iqUhRJUSshiVJpxTAnp5+2DkYiROpuznSazzZplnWVbdHTp0PdVZqZcZCgql7W1Gjtr67SJTwxlBN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqBzr2Yn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqBzr2Yn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791614087; x=1823150087;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zLNWD/PtFSv0VQe12gjFdaXFCOlxUNhURfbgNEAp+Wk=;
  b=fqBzr2YndbDvnNfsYuJ/fF71DKi19OG9VjIlPq+oTqfymzKlN7dqJnLT
   8LRlyHcbj/ZhKNRiXM9qdlQWtFqMXAsLkCbRTH5ygk4kLz3JhAnJAKdOC
   SyIGIbpic6lrlyvBfQCQJEgi8aY19SccKirSszdZ2gBQ3qvA0P+R7y37N
   nawAwt730ccTaRuNWl0ejeEaxOodCdgKk6HaznL6H60OeRfvBDAPaIIMP
   sCNZd8dFSFAnX0I0MbDdKm71ZOIV6hrrbYJxMm2y+54qm/FJul6vS2maO
   XJI4zeCXOUhR0lMfotLgExTioH8DaHzTdU6tufuzNn2IJQbbb7vy7mh0M
   g==;
X-CSE-ConnectionGUID: 23WaSLDCS9G+4NbM84bJkQ==
X-CSE-MsgGUID: Z3Fp+6QPTumwG6wh43+HlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="286076"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="286076"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 23:34:47 -0700
X-CSE-ConnectionGUID: 6I+Bs4ADTJ290RI154rDTQ==
X-CSE-MsgGUID: k6p8974FQVexM8beLQ7nCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="446582"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 23:34:34 -0700
Message-ID: <7b7a4d05-ecf4-4c71-98b7-96b00272bef1@linux.intel.com>
Date: Sat, 10 Oct 2026 14:34:32 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 20/23] KVM: selftests: Add a helper to issue TDVMCALLs
 from the TDX vm
To: Lisa Wang <wyihan@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-20-7c62a5d8a992@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-20-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> 
> TDX VMs need to notify the host, e.g. ucall. Add tdvmcall() to allow VMs
                                                       ^
The patch actually adds __tdvmcall().

> to issue TDG.VP.VMCALL with a single function call instead of
> open-coding TDVMCALL registers setup at every call site.
> 
> The helper makes standard GHCI TDVMCALLs: the caller passes the GHCI
> sub-function and up to four arguments and returns the TDVMCALL status
> from R10.
> 
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Co-developed-by: Lisa Wang <wyihan@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>

Also one nit below.

Otherwise,
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>


> ---
>  tools/testing/selftests/kvm/Makefile.kvm          |  1 +
>  tools/testing/selftests/kvm/include/x86/tdx/tdx.h |  9 ++++++
>  tools/testing/selftests/kvm/lib/x86/tdx/tdx.S     | 39 +++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 9464168e361a..495de8ef8166 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -34,6 +34,7 @@ LIBKVM_x86 += lib/x86/tdx/tdx_util.c
>  LIBKVM_x86 += lib/x86/ucall.c
>  LIBKVM_x86 += lib/x86/vmx.c
>  LIBKVM_x86 += lib/x86/tdx/td_boot.S
> +LIBKVM_x86 += lib/x86/tdx/tdx.S
>  
>  LIBKVM_arm64 += lib/arm64/gic.c
>  LIBKVM_arm64 += lib/arm64/gic_v3.c
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> new file mode 100644
> index 000000000000..d41a1efc8a63
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_KVM_TDX_TDX_H
> +#define SELFTEST_KVM_TDX_TDX_H
> +
> +#include <linux/types.h>
> +
> +u64 __tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15);
> +
> +#endif /* SELFTEST_KVM_TDX_TDX_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S
> new file mode 100644
> index 000000000000..e3f0f7f2232b
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +.globl __tdvmcall
> +/*
> + * u64 __tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
> + */
> +__tdvmcall:
> +	push %r12
> +	push %r13
> +	push %r14
> +	push %r15
> +
> +	/*
> +	 * Map C ABI fast arguments to TDX GHCI payload registers
> +	 * RDI=fn, RSI=r12, RDX=r13, RCX=r14, R8=r15
> +	 */
> +	mov %rdi, %r11
> +	mov %rsi, %r12
> +	mov %rdx, %r13
> +	mov %rcx, %r14
> +	mov %r8,  %r15
> +
> +	mov $0, %rax		/* TDCALL leaf 0: TDG.VP.VMCALL */
> +	mov $0xFC00, %rcx	/* Expose R10-R15 */
> +	mov $0, %r10		/* Standard GHCI call */

Nit:
xorl is more used then moving 0 to a register.

xorl %eax,  %eax
...
xorl %r10d, %r10d


> +
> +	/* TDCALL instruction */
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
> +
> +.section .note.GNU-stack,"",%progbits
> 

