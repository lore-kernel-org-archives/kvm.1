Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A63D23BD06;
	Sat, 10 Oct 2026 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791616822; cv=none; b=YTfEaV7svNVlYZR3kUDuLRPtFfo3yWhXCe2jLcnobmyMgmCdqhqaqChBMOkJdMHPybJkx2fvB3c3GhNHU7j7LW/p1TkpnFrD3F4dsnaS1Mfv5RDqnJb02gD9QRLhzmGl0W/uww3oGKXPec7OlBBNM3SJ1kioXZOu/uUlsxbCORY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791616822; c=relaxed/simple;
	bh=SxZahj2M0pkILz+8LQ66ut8KQqmDtMw1YA4+sXd3cRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDlj6pvsywC7l43trUHthuvPkpmwCXk0BdbF2T5vTTMjfrXADpReho60hFg9sdptblIL9nik0TJJ1za10xPY73zNlsq33h6DVB2hKE4lUpo/rGXy/pf+ol66hI2xDZg00j0ulp6dxdXbPX6/5XZ8TqRq7oFLwLZGi03R+4h+ZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sc1N6Wch; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sc1N6Wch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791616819; x=1823152819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SxZahj2M0pkILz+8LQ66ut8KQqmDtMw1YA4+sXd3cRA=;
  b=Sc1N6WchdYZOtyAaOAeJwbA74I9N5yy/Y4L13jflN4VEIzoUS/v+meqr
   PKfOrQHxRTEtZnWccdWoXtw4TDEfEomlVKDEU9xtn6oupdk0NMomm5F7l
   z/71158gIxq4Y0WgJa59DeKepKHok7boht+gOWF+jzw1Sg12Ob05w/ghk
   rqtufLodjDmf97kF0L1fZUG4c1MLHYt3FqLQZ28ik1VndYinIT6U8TFRZ
   acEDeGgLbk+SBakABmcn2Z0IQJybI2ue5YGl9UYXxdUyl+x5O6z6IrLh2
   hObOi63PmpPqzcxX/3d01iNZuAEKOe/Xn/Mds7KH2iRnTxfBCS/n9HEvT
   w==;
X-CSE-ConnectionGUID: nQCThWgoQn6O8+eDPlZ3XQ==
X-CSE-MsgGUID: 9gIN8NN0RGGS6ahbKzrteA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="310013"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="310013"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 00:20:19 -0700
X-CSE-ConnectionGUID: kSgZJGy7R/KW+R6dNA8sMQ==
X-CSE-MsgGUID: oEunnaLkR2iQtAsvJmKL1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="468770"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 00:20:14 -0700
Message-ID: <7ad0011c-6f8a-4a76-aaec-f73b76bbc517@linux.intel.com>
Date: Sat, 10 Oct 2026 15:20:10 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 22/23] KVM: selftests: Add support for TDX ucalls, via
 TDVMCALL_REPORT_FATAL_ERROR
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
 <20261001-tdx-selftests-v15-22-7c62a5d8a992@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-22-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/2/2026 3:37 AM, Lisa Wang wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Add support for doing ucalls on TDX by abusing TDVMCALL_REPORT_FATAL_ERROR
> to pass the address of the payload to the host.  The "fatal error" TDVMCALL
> is perfectly suited for passing information to host userspace, is both the
                                                                  ^
                                                                 as

> TDX Module and KVM allow the guest to pass (almost) all registers to the
> host, i.e. provide enough of a data payload to make a collision with a real
> fatal error practically impossible.
> 
> TDX can't use port I/O, as the TDX ABI doesn't allow the guest to share
> arbitrary register state with the host on a port I/O exit, and the port I/O
> data payload is limited to 4 bytes, i.e. would potentially truncate the
> ucall address.
> 
> Alternatively, TDX could use MMIO, but using a magic emulated MMIO address
> is fragile (see the TODO in __vm_create()), especially for TDX since TDX
> doesn't support read-only memslots, i.e. doesn't have line of sight towards
> addressing the TODO.  E.g. TDX could hardcode the address to something that
> is all but guaranteed to be unused on x86, e.g. the I/O APIC base address
> or the HPET address, but that doesn't truly address the fragility concerns,
> and it's ugly because ucall_arch_init() would completely ignore the passed
> in @mmio_gpa despite obviously utilizing emulated MMIO.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Also one nit below.

otherwise,
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  tools/testing/selftests/kvm/include/x86/tdx/tdx.h |  7 ++++++
>  tools/testing/selftests/kvm/lib/x86/ucall.c       | 27 ++++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> index d41a1efc8a63..9982aaaba885 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> @@ -4,6 +4,13 @@
>  
>  #include <linux/types.h>
>  
> +/* TDX hypercall Leaf IDs */
> +#define TDVMCALL_GET_TD_VM_CALL_INFO		0x10000
> +#define TDVMCALL_MAP_GPA			0x10001
> +#define TDVMCALL_GET_QUOTE			0x10002
> +#define TDVMCALL_REPORT_FATAL_ERROR		0x10003
> +#define TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT	0x10004
> +
>  u64 __tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15);
>  
>  #endif /* SELFTEST_KVM_TDX_TDX_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
> index c003df3c7b8a..c1cd32d68464 100644
> --- a/tools/testing/selftests/kvm/lib/x86/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
> @@ -5,8 +5,28 @@
>   * Copyright (C) 2018, Red Hat, Inc.
>   */
>  #include "kvm_util.h"
> +#include "tdx/tdx.h"
> +#include "tdx/tdx_util.h"
>  
> -#define UCALL_PIO_PORT ((u16)0x1000)
> +#define UCALL_PIO_PORT		((u16)0x1000)
> +#define UCALL_TDX_MAGIC		0xabacadabaULL
> +
> +static void ucall_tdx_do_ucall(gva_t uc)
> +{
> +	__tdvmcall(TDVMCALL_REPORT_FATAL_ERROR, UCALL_TDX_MAGIC, uc, 0, 0);
> +}
> +
> +static void *ucall_tdx_get_ucall(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_run *run = vcpu->run;
> +
> +	if (run->exit_reason == KVM_EXIT_SYSTEM_EVENT &&
> +	    run->system_event.type == KVM_SYSTEM_EVENT_TDX_FATAL &&
> +	    run->system_event.data[12] == UCALL_TDX_MAGIC)
> +		return (void *)(run->system_event.data[13]);

Nit:
It's more readable to have comment for data[12] and data[13] to
indicate they are the R12 and R13 passed.

> +
> +	return NULL;
> +}
>  
>  static void ucall_x86_do_ucall(gva_t uc)
>  {
> @@ -37,6 +57,11 @@ static struct {
>  
>  void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
>  {
> +	if (is_tdx_vm(vm)) {
> +		ucall_x86_ops.do_ucall = ucall_tdx_do_ucall;
> +		ucall_x86_ops.get_ucall = ucall_tdx_get_ucall;
> +	}
> +
>  	sync_global_to_guest(vm, ucall_x86_ops);
>  }
>  
> 

