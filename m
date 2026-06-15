Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6670D25228D;
	Mon, 15 Jun 2026 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509970; cv=none; b=o7meJAD/6v5TGnH/4G3jJFH//VeERwVjssdKvQi8T1fjitDsjGUFWhVcIuVzNxyNrTSGxiTvL81RNG2sQ14S31+I/MVK7imCCgDAE6YY7zGCSt36wHFWiCqsS5aL//WHEKGmobNKfKsr/OZAvNnpERfqnXDkMSK1aElTMln61gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509970; c=relaxed/simple;
	bh=F8nN3sxYQDd6gPRptt15AumfI2Tvt0cnqcG+lzmZKb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LC3Ny2zbYUr6e6y34G36svOLxG3V25CbJpWRC0f5rizifBHCadu87CKHy4ZKn3nIlhC6awk2Dyi4cyNg4LXY/Qdl4bGxuxYLiWMMnsHFZe2LqqFrc6+ooLqT9u9EPqVZXWeRuH6fOrsmacI+vKse1t/QRwbPDIdMTli4s/oVHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqFVb82+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqFVb82+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781509970; x=1813045970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F8nN3sxYQDd6gPRptt15AumfI2Tvt0cnqcG+lzmZKb8=;
  b=mqFVb82+Iq/yeDUAYN/f1DoySm49QgZp/EopzjJro8lTNh2h4OuB7Txm
   m78h3eG+MuciVQD6kynj7F5tnwzie6QVtXyTx4OoJulSD0YgCAbKzAMLw
   dSNwYfpVGMLuiDVtaLZDv8Hid1p+w89AXnfCgi3oFNz8qjaBWKLq9aq8m
   nOYX6MKRNsPDZWYRX7O6bu6CJJuPU/rT0Z1XK4zRI7xgjcUObQ1tKYtWA
   dUCFRK20QMJtROTHaRGyPn75BDy6owYQ1UW7bZz/ybiMRblzBOdaxyEAf
   Et3lrqacJqWolg8OHkbwfYftEh+ngM7OlNfIbblfdfKuR77tI3zTdJwP0
   g==;
X-CSE-ConnectionGUID: SnXexs02QeqZLAXN0AzD8w==
X-CSE-MsgGUID: Pm8wns4wSQeCiZ4HPLWmUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="99663502"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="99663502"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 00:52:49 -0700
X-CSE-ConnectionGUID: yApaGOBpQDSS38kbtoX/5g==
X-CSE-MsgGUID: p39SgkR8RdmcnkHETF/ipw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="243040871"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 00:52:47 -0700
Message-ID: <8b682d38-cf5c-4f9f-bc76-6c8ad167da43@linux.intel.com>
Date: Mon, 15 Jun 2026 15:52:44 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/30] KVM: x86/hyperv: Eliminate an unnecessary
 include of x86.h in hyperv.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-11-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-11-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Drop an mostly unused include of x86.h from hyperv.h, and instead pull in
        ^
        a> regs.h, which is need for at least is_guest_mode().  This eliminates the
                    ^
                   needed> last include of x86.h from a common x86 header, i.e. solidifies that x86.h
> is the top of the pyramid.
> 
> Add a missing x86.h include in cpuid.c to avoid build breakage.
> 
> No functional change intended.
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/cpuid.c  | 1 +
>  arch/x86/kvm/hyperv.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 591d2294acd7..2698fa42cd97 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -28,6 +28,7 @@
>  #include "trace.h"
>  #include "pmu.h"
>  #include "xen.h"
> +#include "x86.h"
>  
>  /*
>   * Unlike "struct cpuinfo_x86.x86_capability", kvm_cpu_caps doesn't need to be
> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index 65e89ed65349..1c8f7aaab063 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -22,7 +22,8 @@
>  #define __ARCH_X86_KVM_HYPERV_H__
>  
>  #include <linux/kvm_host.h>
> -#include "x86.h"
> +
> +#include "regs.h"
>  
>  #ifdef CONFIG_KVM_HYPERV
>  

