Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102514;
	b=xprTDIQCPgm7+29Kkoa/MrsOMW33tqrXHrLc4Sblpe99NNfs4jWlfDLfMRKHGQsiCM3/
	 Hz5HMfuSMCNPHAZuAZY1O8KA3DNV3nP/o11yuUQFvbKX7QxUGpLB66/v83Q3jgbflTGpI
	 2bwUUV0x+230Unx4Z1u55w81Wbd3LXF6Sh/rkAcilu22wc8Ss1chjxFx1m/omtqWTLLCH
	 zgb8oLhnMwl/V8VAMgIDwQk/BlUHLISxpd9y/55vI3Uru9YbVRyA8yCdaGU1PZ6/XzNuW
	 1xFd40sZlvGI81YoAPALtXGdzK7+mh9qPeaK/fJE2irOYu8e1dhJcJXOFD8QfSoeTDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102514;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=PpqCaReoXiYonrOXHNsdcBrA4jEmkFZT2sQJk8Qpqsg=;
	b=fCMY3Qn9EVu3KBXlCnAGZdOonW5ItV/cWJ/eDAi25HUABVIiOWDIDtvidYw4IjfFm75D
	 ndveaCNmMng9amHTfNydfYizM9flpXVWcgIEr4ASnKiKvBySwXlgLYDAuLRWq4wb9/stI
	 ik5GUqGSLfAqt50w2KxuqqdOa+8Q2IwPUsFayFnNgY+HcOWyqx/lwJQlQ4tok4bz3MjyZ
	 GnUQTXk8eryJJ98CYpe+wwKC9suhe3BG4pwW5eh+5IKX0KhhLGMwDX2hct7fUUyIYDOc8
	 t5LLmMFs7ZRhSM6X32KQGAjNw8cUV5iH/6vsdwQ7KU1wqOo3M1CUi3aPkIl8P4pWZOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LgUdjWW2;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0DE60A6F64;
	Tue, 27 Oct 2026 12:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE0DE60A6F64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LgUdjWW2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793102514; x=1824638514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xtt4YsT9ZPy9O6YkSBviTjv1G0dD2klmXmaqyNznP+A=;
  b=LgUdjWW2vB5V0U8dKLRWm3lU1c375riqVU/TsB0YJR6JYt1pkYSzfNNL
   GLgSApxILFVd/6fRWNEzb0Ag9Vnqp2vZA4qclOAvT+WbSsni7e57mxWqy
   FJbfUzOmGeXVEldB9AcEYgbjv+F6nyM4JfmjHIPM5x7NTa+f5rjO/+aTr
   5oJMBWQ/tHKVyN2g33Jht7KFK7+g9jXcpm/BF07y1s8ZCLms0AN1BiMBg
   EEPqhMWz9YFIOUqLaVjZ35drgE//P6YEEkcfeBOrRMZyJ+uYT2bB+2td7
   ToRDaIpZUqk91r3AhsNHorDaIhpFGl+JCQMv6cTAr4M/XG+KAM6iuDKzu
   Q==;
X-CSE-ConnectionGUID: +IsCUtJGS9uaSfX5sna11w==
X-CSE-MsgGUID: cN4l3KA3RMWN79aRNgvlnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1801579"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1801579"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:01:53 -0700
X-CSE-ConnectionGUID: Ntby6jSXQ8GyCEFkcBAcTQ==
X-CSE-MsgGUID: q5ZTIPQWSIWeq8q0z+yU0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6370961"
Received: from unknown (HELO [10.238.0.97]) ([10.238.0.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:01:49 -0700
Message-ID: <741bfe7c-5d21-4c6b-98c0-95b01a2a21f3@intel.com>
Date: Tue, 27 Oct 2026 20:01:46 +0800
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

I think the WARN_ON_ONCE() is very likely to be triggered in the future when
people run old kernel with new TDX modules.

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

