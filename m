Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B57355F22;
	Tue, 23 Jun 2026 01:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179290; cv=none; b=jmo9DfIX/96xAmbRbnz8F0Ko42V41FCdaEuQp153kzbX5+xmVKQjvFKeLB9nwLI221uhdUNL/+QiyvmLHSCqMHst6+89Dez4x1KOxAczPSKuMkvRbtHUjTyTtX3Sp47qqqE5mrFoWHCNDhig/1RZ7vh8V0e+n35kuA4O6jSilWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179290; c=relaxed/simple;
	bh=129JLx+Hb/TTse/Q2k3rY5VfWGwc5Gi58NO7weTNhRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDJq8r1KFrujzw0DwJjvnJp5zSNpBCaOlvUNJ2H8Al8tympi1XbexFgVPpSObCG9mVrUGmaUn4hY7plaT7nlasMWKhikA07Q7ol6AZ1stObHo4yqf2oJNGWSlvw6YZR6MguwxCwQf8Fz9tACF/Qcs1N9lqFA4YfMuaXNce8sqtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/kJzncc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/kJzncc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782179289; x=1813715289;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=129JLx+Hb/TTse/Q2k3rY5VfWGwc5Gi58NO7weTNhRY=;
  b=f/kJzncc6E1tuo6h1b0psNpEQI7V1a7ou42XhRdhbb3N961TiuXTxreU
   70PCEBLaLQEsxu5tsrtJX6zR8FTWjqqe5GYjsXLH9rk19W+C10RaC8Ea0
   Xg2LpIHZ4hVTbfQSKBl/b3rmVSFkVW6qgIw3JBrqdWYhdf0fyOyBmWKyH
   bc2hDfN5STOkylUuA9Kq/eSFkSP6BtmI3IM+EyHbPRslW+Y3LqWjDGYsx
   lemwcQUBkeOS7ZqmiDkGTQbvBau03ghwi34uRpyPB/XOvuuPShXD90yf+
   riJvtajkO25x8Q1PNeZTmRvKGUlQvEfbXbM+RednWK0LwduX6j0JlaHAJ
   w==;
X-CSE-ConnectionGUID: H2UZZ8fXTW6pzOLxbBYeNw==
X-CSE-MsgGUID: FBmowLgGSFS2V8xyYa7nhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="108459148"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="108459148"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 18:48:08 -0700
X-CSE-ConnectionGUID: nrayaJ2LTYqUyt9KxTvqBA==
X-CSE-MsgGUID: HUEJ7vNpSHGMEZH1mU7usw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="273073956"
Received: from unknown (HELO [10.239.158.46]) ([10.239.158.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 18:48:02 -0700
Message-ID: <46372f61-cd94-49db-b806-74d1c5ace38b@intel.com>
Date: Tue, 23 Jun 2026 09:47:58 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/22] KVM: selftests: Expose segment definitions to
 assembly files
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
 <20260521-tdx-selftests-v13-v13-5-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-5-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2026 7:16 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Move kernel segment definitions to a separate file which can be included
> from assembly files.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   tools/testing/selftests/kvm/include/x86/processor_asm.h | 12 ++++++++++++
>   tools/testing/selftests/kvm/lib/x86/processor.c         |  5 +----
>   2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/processor_asm.h b/tools/testing/selftests/kvm/include/x86/processor_asm.h
> new file mode 100644
> index 000000000000..713b6bc0aeb7
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/processor_asm.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Used for storing defines used by both c and assembly code.
> + */
> +#ifndef SELFTEST_KVM_PROCESSOR_ASM_H
> +#define SELFTEST_KVM_PROCESSOR_ASM_H
> +
> +#define KERNEL_CS	0x8
> +#define KERNEL_DS	0x10
> +#define KERNEL_TSS	0x18
> +
> +#endif  /* SELFTEST_KVM_PROCESSOR_ASM_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 8d06e7186df1..62abfe27fe3a 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -8,6 +8,7 @@
>   #include "kvm_util.h"
>   #include "pmu.h"
>   #include "processor.h"
> +#include "processor_asm.h"
>   #include "smm.h"
>   #include "svm_util.h"
>   #include "sev.h"
> @@ -18,10 +19,6 @@
>   #define NUM_INTERRUPTS 256
>   #endif
>   
> -#define KERNEL_CS	0x8
> -#define KERNEL_DS	0x10
> -#define KERNEL_TSS	0x18
> -
>   gva_t exception_handlers;
>   bool host_cpu_is_amd;
>   bool host_cpu_is_intel;
> 

