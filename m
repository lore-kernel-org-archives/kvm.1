Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7C743F4C2;
	Fri, 16 Oct 2026 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792188926; cv=none; b=HUdweB1OD7AXZQuJHTmAkHKsfkXyqP+Nw+RzRSRG4pNl72R1tlVTiHgAqfGtJwzKJuNcdJAnG1E4kT9m0/AktmnEf+Uq9yXGXsPNf+p1kKxT0Uxp892cHP4hAIttcwkxXU96WwhXjkaSOzVI1KG7I4FbMuWhMcJ7M30Z3aX/keQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792188926; c=relaxed/simple;
	bh=XBH2zFV2qQau7y1HpoVnAZ2uTtVV3oXXugaCb0ICBys=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NJOOib57A13Ym0JqkT8Hosxt5UNKpSbc+a4KrMSmaJxscsKwiiO9U7ZOTSkMb4sDegEa7jDazh6XFe+Y6q0NSQbNcJGMwg5ZStIfCDUrJCX3b9s8wUbddDSgE7yXJhgdLtS9uoumr0sgF5eXM1q+sgn2kL7wptRdRBBWmO2urLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b77k7pW/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b77k7pW/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792188922; x=1823724922;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=XBH2zFV2qQau7y1HpoVnAZ2uTtVV3oXXugaCb0ICBys=;
  b=b77k7pW/vfkynvl9nw5jJtY8fWZneaSmEaR5IRJA3lfIWZRaiOxMRqu1
   gDXe9NMJntQO1Xh4uWUX6y7/kQfhQQmWwSU2VWI17BnkQflY6FZAbfrsA
   LuCXR05xyueW7p40w3SAnsyBunhZC4aEDkAEZlwHKd7vCAqWPgUpoYPWo
   /2No/fO+PBneE6UiiPtW7VRChejcalPp+ghG+e/dtkN98IuHQsaXAP2Wm
   qB8ICO4VzLctOYC6IVeKQuVhiIV6QzKF37xA4FjVMomvt5tC+PDvk+8js
   mIf9R1JPqIYFcKImq+nEgc093S12YPrbIIhzlKtXLV/6LXdQDg5q4q389
   w==;
X-CSE-ConnectionGUID: 9NzNUjUNTFutAw34u0mLWg==
X-CSE-MsgGUID: xyyJvPQGSOGKUnBh5rNSDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="879222"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="879222"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 15:15:21 -0700
X-CSE-ConnectionGUID: 0bWT7Z2dRoanaf4fnPq3kw==
X-CSE-MsgGUID: +oW3YqkZQ0WOa0osJsLyCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="3881636"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 15:15:17 -0700
Message-ID: <e1553e03-7ca8-4507-b608-d9d663759c1f@linux.intel.com>
Date: Sat, 17 Oct 2026 06:15:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v5 1/5] KVM: TDX: Check unsupported CPUID bits against the
 TDX module's subleaf
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
 nik.borisov@suse.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, tony.lindgren@linux.intel.com,
 kishen.maloor@intel.com, dedekind1@gmail.com, adrian.hunter@intel.com
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-2-binbin.wu@linux.intel.com>
 <atJB7kDzKsvzrMau@google.com>
Content-Language: en-US
In-Reply-To: <atJB7kDzKsvzrMau@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/2026 11:25 PM, Sean Christopherson wrote:
> On Fri, Oct 16, 2026, Binbin Wu wrote:
>> Don't reject the mismatch outright, as the ABI allows userspace to provide
>> an arbitrary index when KVM_CPUID_FLAG_SIGNIFCANT_INDEX is cleared.  It's
>> userspace's responsibility to provide the intended entries; KVM only needs
>> to ensure that the values it validates are the values it applies.
>>
>> Fixes: 6d415778f106 ("KVM: TDX: Disable support for TSX and WAITPKG")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://lore.kernel.org/kvm/20260604024927.E22311F00893@smtp.kernel.org
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>> ---
>> v5:
>> - Split out from "KVM: TDX: Validate userspace CPUID input for
>>   KVM_TDX_INIT_VM" as a standalone fix.  Sashiko reported the issue
>>   against the TDX CPUID validation patch, but it also applies to the
>>   existing code, so split it out to allow backporting to stable
>>   independently of the rest of the series.
>> - Check the userspace values against the subleaf reported by the TDX
>>   module instead of rejecting the request when there is a mismatch.
>>
>>   A simpler alternative would be to require a zero index when
>>   KVM_CPUID_FLAG_SIGNIFCANT_INDEX is cleared, but that would be an ABI
>>   change.
> 
> The even simpler change is to reject the incoming CPUID if userspace doesn't set
> KVM_CPUID_FLAG_SIGNIFCANT_INDEX as expected.  Yes, that's an ABI change.  No, we
> don't care.  The rule isn't "never change the ABI", it's "don't break userspace",
> and there's basically zero chance a TDX guest can function properly if userspace
> doesn't set KVM_CPUID_FLAG_SIGNIFCANT_INDEX as appropriate.
> 
> diff --git arch/x86/kvm/vmx/tdx.c arch/x86/kvm/vmx/tdx.c
> index 75a86d64892a..7e0d81066420 100644
> --- arch/x86/kvm/vmx/tdx.c
> +++ arch/x86/kvm/vmx/tdx.c
> @@ -151,8 +151,12 @@ static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
>                 clear_waitpkg(entry);
>  }
>  
> -static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
> +static bool tdx_is_unsupported_cpuid_entry(const struct kvm_cpuid_entry2 *entry)
>  {
> +       if (cpuid_function_is_indexed(entry->function) !=
> +           !!(entry->flags & KVM_CPUID_FLAG_SIGNIFCANT_INDEX))
> +               return true;
> +
>         return has_tsx(entry) || has_waitpkg(entry);
>  }
>  
> @@ -2386,7 +2390,7 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
>                 if (!entry)
>                         continue;
>  
> -               if (tdx_unsupported_cpuid(entry))
> +               if (tdx_is_unsupported_cpuid_entry(entry))
>                         return -EINVAL;
>  
>                 copy_cnt++;
> 
> Can you test the attached patches?  If they boot TDX with QEMU, I'll go ahead
> and post.

Patch 3 "KVM: TDX: Don't zero non-significant CPUID entry indices" breaks QEMU.

QEMU uses zero as index for cpuid entries when index is not significant.
And in QEMU, the lookup function doesn't consult the flags at all.

struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
                                          uint32_t function,
                                          uint32_t index)
{
    int i;
    for (i = 0; i < cpuid->nent; ++i) {
        if (cpuid->entries[i].function == function &&
            cpuid->entries[i].index == index) {
            return &cpuid->entries[i];
        }
    }
    /* not found: */
    return NULL;
}

If KVM doesn't zero the index for the non-significant, QEMU cannot find
any entry for non-significant entries returned by KVM_TDX_CAPABILITIES.

And 0x80000008 is used to pass GPAW, and KVM_TDX_INIT_VM fails when QEMU
doesn't pass it.

After dropping patch 3, QEMU can boot TD.
Also our internal TDX CI cases passed.
