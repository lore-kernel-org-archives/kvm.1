Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149499;
	b=eHAoeiWuCmezn5BvMrwapEAgs4HMgCb5r7pRKXmbdwrfmuPYdtGoJqVasgyXg+eHli3e
	 kLRzSpeReUO7YsT/ADFjOjEPuA2GhX53i1j2fBG3pYpz2XjzLpkJz1laJOpmGsl56FKmH
	 HzjvoVuk1i8E4mF1idVDqEGYDqz4LYkiVfOQNHXYYOamGEhBqgjlmqbZjTZ1UJk8CQwP1
	 IhO7r/1vee+17GICyyyoVes/8wS/T2DFCLaoPLCLrZg0uA13orhCSFu2gZf0biL3sZCfs
	 FNvw9IbKkK3sYzHZG/HnfIylp6VU85ezaTjP6vItwizRDV+Vp+hIdtzY9J6MQlUZNhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149499;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gnxyWoJRaWnBFdh5Sr2fSS/O75CM6cD5zJkwRhPWR04=;
	b=pkAyfLiYwcdQkSMnk0K+W6qL54HLnpRCWgMrHiKdBTIX1pHsDo7gJm498JDjn8lgLsWi
	 CcoJmAT52saCQxEroKwZm8wfKSPB3JyNyNqh9mGNNpoDr/GL3wiUdRXHOs5RpOmtbej6x
	 UvgM3KZWbZoNV0egr5loa7a0OFvexg0V4XFuhDrOLKx1YxMcOWZdI0x0S9JhqS2ZH6H9l
	 aHT8Hn7RPtx3LECaqnrbPq2dHnIx+OKwwrUnFTZeGtPEn4Vxkq9MarXJghezWS6PYdqm/
	 fcZJX0zr7S0C40Zf8HPXvjCmD/cgqeTjQ5GXQkVTLjSBc/rGbF2u7xb5CCIh8474zDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NVpFoUoi;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606C606A31D;
	Wed, 28 Oct 2026 01:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8606C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NVpFoUoi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793149498; x=1824685498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PfZrfS3VYK1nRH4spTy2EIWQdtsIKK+JHj6nS0jQdAA=;
  b=NVpFoUoi9otrHQuEIhLhZXj2hKxYBrix39+6XZbo84wPKwrjHD6oInBW
   JMEbWd8bMI2H+EyKy9il0mcrbb9goGo5/lAXZETG2RR5WHVwLDuU4TV0t
   b86NxpdUYlvFFsImBLojCDUex1hUrIq6o/bcn+UGNRHAMdMiCz2H7mV8T
   gFn/5VENaDKjI/UbupftUoiVdOfyMr/iyKoRDrUmAQWZ2vRmvzfhxHKu7
   gK4abPVUsOyeu0jIBXTaxak8DIhIWDaO0yRVxpsjM8dHs2pP6rjItZoXX
   QTBgt0mEusHnEB0ofiCSn5aYNmqadmjpEJCZcEFKbT9SM3MEHcsi8p+Am
   g==;
X-CSE-ConnectionGUID: bv921Tg7RuCA+9819fOssQ==
X-CSE-MsgGUID: Yq5gpLxmQG6U+vzWeiQc0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1876135"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1876135"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 18:04:57 -0700
X-CSE-ConnectionGUID: BxfuiwfITPuR/xsB/Xhnww==
X-CSE-MsgGUID: BO3L9sRfSkKLHwWO8G2hjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4647546"
Received: from unknown (HELO [10.238.0.97]) ([10.238.0.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 18:04:53 -0700
Message-ID: <0eb46481-c948-486f-871f-bfdb104598e2@intel.com>
Date: Wed, 28 Oct 2026 09:04:50 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: TDX: Set SIGNIFCANT_INDEX flag as appropriate
 when filling CPUID entries
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 Binbin Wu <binbin.wu@linux.intel.com>, Changyuan Lyu
 <changyuanl@google.com>, Sashiko <sashiko-bot@kernel.org>
References: <20261022210134.612848-1-seanjc@google.com>
 <20261022210134.612848-3-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261022210134.612848-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/2026 5:01 AM, Sean Christopherson wrote:
> From: Changyuan Lyu <changyuanl@google.com>
> 
> Set the KVM_CPUID_FLAG_SIGNIFCANT_INDEX flag in the kvm_cpuid_entry2
> structures returned by KVM_TDX_CAPABILITIES if the CPUID is indexed,
> otherwise KVM could confuse userspace and induce a configuration error.
> This also ensures consistency with the CPUID entries returned by
> KVM_GET_SUPPORTED_CPUID.
> 
> WARN if KVM and the TDX Module don't align on which functions have
> significant indices, e.g. to help ensure the kernel is updated when the
> TDX Module learns about new CPUID leaves, and vice versa.
> 
> Opportunistically add a comment to call out that zeroing the index when it
> isn't significant is ABI that userspace relies on, e.g. QEMU looks for '0'
> instead of checking KVM_CPUID_FLAG_SIGNIFCANT_INDEX.
> 
> Fixes: 61bb28279623 ("KVM: TDX: Get system-wide info about TDX module on initialization")
> Cc: stable@vger.kernel.org
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> [sean: keep the WARN, don't key off KVM_TDX_CPUID_NO_SUBLEAF, add comment]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>  arch/x86/kvm/vmx/tdx.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 271c2f94b8dd..37d088f6f7a8 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -2,6 +2,7 @@
>  #include <linux/cleanup.h>
>  #include <linux/cpu.h>
>  #include <asm/cpufeature.h>
> +#include <asm/cpuid/api.h>
>  #include <asm/fpu/xcr.h>
>  #include <linux/misc_cgroup.h>
>  #include <linux/mmu_context.h>
> @@ -163,12 +164,23 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
>  
>  	entry->function = (u32)td_conf->cpuid_config_leaves[idx];
>  	entry->index = td_conf->cpuid_config_leaves[idx] >> 32;
> +	entry->flags = 0;
>  	entry->eax = (u32)td_conf->cpuid_config_values[idx][0];
>  	entry->ebx = td_conf->cpuid_config_values[idx][0] >> 32;
>  	entry->ecx = (u32)td_conf->cpuid_config_values[idx][1];
>  	entry->edx = td_conf->cpuid_config_values[idx][1] >> 32;
>  
> -	if (entry->index == KVM_TDX_CPUID_NO_SUBLEAF)
> +	WARN_ON_ONCE(cpuid_function_is_indexed(entry->function) !=
> +		     (entry->index != KVM_TDX_CPUID_NO_SUBLEAF));
> +
> +	/*
> +	 * Explicitly zero the index when it's not significant, even though it
> +	 * _should_ be meaningless.  Userspace relies on the index being zero
> +	 * (the ABI was inherited from KVM_GET_SUPPORTED_CPUID).
> +	 */
> +	if (cpuid_function_is_indexed(entry->function))
> +		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> +	else
>  		entry->index = 0;
>  
>  	/*

