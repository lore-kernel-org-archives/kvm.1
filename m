Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390723D4108;
	Fri,  9 Oct 2026 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534207; cv=none; b=dhkOHBg9YoIlYM0oOqPpTx+dLIWwvj1fVq3t0SLhBbwzic3MyFt8nPIMFyIqhA4pInNpTTjCgkR6ndlHVgdypNJt8UxHI6N8BQv4PTznWI3oCpDkIlHo7GbAB5sgQdgM9LNRPYOq80x6AO+x4ts7ydqM29fOL1eY5oYV4ncx9IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534207; c=relaxed/simple;
	bh=5D3XaR1PEUXeG8lJ2wu/SZ+C5knT6CSp0uwVvehwoO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDCcrvLZGSwjyXOfgi5dvuxT5c7W28RXvG/Us3c3uFlLj0uGiS3Hmgky+JfqJA9XkH3IMvVK1awG+Tr9TKf3tWRHOoB3aGSRdFLVB97BrMsBRQL4o5r8h0GJFpamu0+p8KjADya4+0qV/uexz2a4Wolv3KsItVpUpi5qySOkcpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUSdG6i4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUSdG6i4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791534204; x=1823070204;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5D3XaR1PEUXeG8lJ2wu/SZ+C5knT6CSp0uwVvehwoO4=;
  b=fUSdG6i4lW+rRrEj4JVWa4+/tYYJVCNoIRmI8zOoAMCqILBc9ebxSBEl
   8FP9STeZowdtP+/U14LVm3hBG9/wjuwNymN6KxWq9KId1zrAULUtfOykL
   l6dJ6P+J4os0wRcI/Q7kVapoIZ8OfAvwFz+Phb5DlOnF7hDs7JarGARNG
   d3TW4OcEAFcA4KMucPsa6ySQAEEmbK7d6pll6SRh9vn/Z8XJLKN7mUrPl
   5hoLpSpR9Vs2QyTXaZbeJvKzEsA2BWaeKIwB8WHqO4cVJcLgUD/QYT6Al
   RUp7DlZi6j2q2MSZqWepWeVCDzwurmmzixVHBaFJe4iZlgnpYajw4bG7v
   Q==;
X-CSE-ConnectionGUID: qj+R+aQdRVKE0+ISJIwrMQ==
X-CSE-MsgGUID: 7WlbTK8eRYm1HEjsN567kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="226499"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="226499"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 01:23:24 -0700
X-CSE-ConnectionGUID: l/dPVwoiRFCwQbVUcvH5Nw==
X-CSE-MsgGUID: Qjx7M2lPS5SLHH6U2Il+VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="348380"
Received: from yizheliu-ivm.ccr.corp.intel.com (HELO [10.238.208.114]) ([10.238.208.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 01:23:15 -0700
Message-ID: <d410fef4-237d-4d3b-839a-3eff3912c550@intel.com>
Date: Fri, 9 Oct 2026 16:23:12 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 20/23] KVM: selftests: Add a helper to issue TDVMCALLs
 from the TDX vm
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
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
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-20-7c62a5d8a992@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-20-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> 
> TDX VMs need to notify the host, e.g. ucall. Add tdvmcall() to allow VMs
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

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

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

