Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164B13C5523
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 03:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776914709; cv=none; b=oxkaQyDBsX5pxurw2+U6j259bQvp3jvtzQ/Q/v9GOdk61xJ8SEmvOZJ7neAwX0ymCEj0Q/4GUph5I7QYxXVWrjCtP18BvzVdUxEqs2EvXwJRfk0NZ/M3ixAZm/z54f3PBdgSKlHpqyJLguDsuXbamYQpsERRH1sZe/gXehqikb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776914709; c=relaxed/simple;
	bh=VJrh50Vqlq6jzIAB2wEiOTc9dRH+O21t+fdUH8m43zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDncqDBdg+tlfxyewrxd33yzVEZkYXCslu1cIar8BcdxVaFWik7lk1YvGDBPYMyBdsn3wMFdI0+g4upjisnNR6WHUG5iAAX3q3hyeTiNEQXl379DhukUhWZI7qgJJ83GV1Da/BpQwCfnpAFPw/bt/noORGWzrCR/foUDh9H+K8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bSwhVnDV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSwhVnDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776914708; x=1808450708;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VJrh50Vqlq6jzIAB2wEiOTc9dRH+O21t+fdUH8m43zU=;
  b=bSwhVnDVFboxzktTLkQ0bd2UvqKAe1MS6E1n+bm1cwRtkwPBHwH66m34
   kUL/kCk+7YYwo53xYeLMC1Cxx7WTjEHsGLy+VS17B8qw5o8NG6fszKVAW
   JVtlQneEsL13CDf9eXIuoVk1y/y0YPg2JBsekV9ZYp1f9flhmuhBLbW1G
   PrfmLuwub0IMqoGOCWmP43Ijnmzv3/2sKFrSQ/1vWFiGmAx4p2kahSCpF
   Je+FaXBSPB32g6RtZs497bWyKMwkVedHiVCbSRe4bxRJYWnj5en9tLiLM
   QzcNwELQf1AEqJ/Kz5Uz9vfRQjphSrE6XUB+FVSkoL9SaaEdqU+vejn+f
   Q==;
X-CSE-ConnectionGUID: VOPTyKBqSjyaqKXJK4DE2A==
X-CSE-MsgGUID: m9Gi2FD7TyGGfoUWx9vpeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77579624"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="77579624"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 20:25:07 -0700
X-CSE-ConnectionGUID: IeGmfRsmRfWHoq3FeRxPtA==
X-CSE-MsgGUID: tR+z/KIrQq2l3F9LjibfMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="262923669"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 20:25:06 -0700
Message-ID: <1cb860cf-f34d-42bd-85cd-b6ad4b46abbc@linux.intel.com>
Date: Thu, 23 Apr 2026 11:25:03 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 27/27] KVM: TDX: Replace hardcoded CPUID filtering
 with the allowed mask
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-28-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260417073610.3246316-28-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Below are responses to issues reported by sashiko. [1]

[1] https://sashiko.dev/#/patchset/20260417073610.3246316-1-binbin.wu%40linux.intel.com?part=27
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index a996e7f761ed4..2b980335b6675 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
[ ... ]
>  static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
>  {
> -	if (has_tsx(entry))
> -		clear_tsx(entry);
> +	u32 *reg = &entry->eax;
>  
> -	if (has_waitpkg(entry))
> -		clear_waitpkg(entry);
> +	for (int i = CPUID_EAX; i <= CPUID_EDX; i++)
> +		reg[i] &= kvm_cpuid_get_allowed_mask(entry->function, entry->index,
> +						     i, CPUID_OL_TDX);
>  }
Issue #1:
"Does this out-of-bounds memory access trigger undefined behavior?
Since entry->eax is a scalar member of struct kvm_cpuid_entry2, not
an array, accessing reg[i] for indices 1 through 3 goes past the bounds
of the eax object. Compilers with bounds-checking instrumentation like
UBSAN might detect this as a bounds violation and trigger a runtime trap.
Could we use an established helper like cpuid_get_reg_unsafe() or simply
unroll the loop to explicitly access the distinct struct members?"

Yes, will unroll the loop.

>  static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
>  {
> -	return has_tsx(entry) || has_waitpkg(entry);
> +	const u32 *reg = &entry->eax;
> +
> +	for (int i = CPUID_EAX; i <= CPUID_EDX; i++) {
> +		if (reg[i] & ~kvm_cpuid_get_allowed_mask(entry->function, entry->index,
> +							 i, CPUID_OL_TDX))
> +			return true;
> +	}
> +
> +	return false;
>  }
Issue #2:
"Does this pointer arithmetic on entry->eax also trigger the same bounds
violation as above?"

Same as above.

