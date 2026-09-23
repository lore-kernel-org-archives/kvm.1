Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C291A9F85;
	Wed, 23 Sep 2026 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123295; cv=none; b=lVC14wEGW6ZX3AlRCjQA09pkSGc2j7dMDskafXvVgTnAWfxvAcRTWvCWApnSoLmKK+J2rwIrt2dxbTt24a7Su0lZmAGz9DpX6JmQlEIbVBcfr0qA+cRA4C+VrUXAE6XI7uGS+uDVgv6vo9tMq/zROFqGcf8dMLsviot1rwO/Wl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123295; c=relaxed/simple;
	bh=VaJKW+0Lel/ioTsk74Ie7TY3LGQ1dBZXZQ4cSarsurE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMRgXDUri6drh5V6Mii6TmBcelAob2UJ7AWYy45iqEhBFRo9e3e9dCjAuDurm+9jZKNYBscbTxPaQbUKoJHSAtMRIvXNh0WrdF2m4M5qONFS0QNYlJStgDVvMEUO6nqc7COlpTPNVgAp9FC+coaWUTw9iWpqoQ07hLxTYz07/bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hU72jtip; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hU72jtip"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790123293; x=1821659293;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VaJKW+0Lel/ioTsk74Ie7TY3LGQ1dBZXZQ4cSarsurE=;
  b=hU72jtipa60ykide7JM85vcJlexPLw6hLJjKZl8ILoFwa535jGD793mL
   xfMJTqGPxMk28AyWKk/0fVCZm9VqTKZATVS0/0DmhsLsEMiOzfmENqTGI
   1eUOEhdJxMl7Zd54N2CgwAG9RCOEBmJdUsBmgYzXhPypcuMB2NRNSdqMX
   Sq3dL+PxhpqwFvR+0fKHfBkJ7V417n6rCvRaZQLXc9ms7l7yjmPwrgfrB
   yWS+mIT4kJsAAa5hH/AZwAxac4wH8rmsxy1xfSYBh86ksJGhgP3AW1TtN
   dUvm3eN8NGPqfoCIIs+fZKD8c/S4MO0zOPiNchW0ToHQMwx6vHBFB5OxN
   g==;
X-CSE-ConnectionGUID: QZD6QLbiTwefbBgYcuuNXg==
X-CSE-MsgGUID: O31fXBx3Rle339hskgmmOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101363795"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="101363795"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:28:12 -0700
X-CSE-ConnectionGUID: wNKBc32vQAyJR4LSZ7FEKg==
X-CSE-MsgGUID: y5zJAeLIT/m5KlqZA+0p7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="299623106"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:28:08 -0700
Message-ID: <4c553712-d2b3-44d5-9c09-ba51a5f3729e@linux.intel.com>
Date: Wed, 23 Sep 2026 08:28:02 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] KVM: TDX: Filter configurable CPUID bits
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "Maloor, Kishen" <kishen.maloor@intel.com>,
 "dedekind1@gmail.com" <dedekind1@gmail.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-4-binbin.wu@linux.intel.com>
 <d6bf5183b74b6c6f595001ee753405ea94a6042d.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <d6bf5183b74b6c6f595001ee753405ea94a6042d.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/23/2026 8:16 AM, Edgecombe, Rick P wrote:
> On Thu, 2026-09-17 at 15:25 +0800, Binbin Wu wrote:
>> Filter the directly configurable CPUID bits reported through
>> KVM_TDX_CAPABILITIES against KVM's TDX allowlist, and drop the hardcoded
>> denylist based filtering.
>>
>> The TDX module reports directly configurable CPUID bits that it supports
>> for a TD, but KVM must not expose bits that it doesn't support, as blindly
>> exposing a host state clobbering feature can lead to host state corruption.
>> The existing denylist, which clears only TSX and WAITPKG, is not fail-safe.
>>
>> Add tdx_get_cpuid_cfg_mask() to get the mask of directly configurable bits
>> allowed by KVM for a given CPUID register, covering both feature bits,
>> which come from tdx_cpu_cfg_caps[], and non-feature bits, which are
>> enumerated at runtime.  Apply the mask to every CPUID entry reported
>> through KVM_TDX_CAPABILITIES.
>>
>> With the allowlist in place, newly introduced TDX directly configurable
>> CPUID bits stay hidden from userspace until KVM explicitly opts in.
>>
>> Note, filtering KVM_TDX_CAPABILITIES intentionally stops advertising the
>> directly configurable bits that aren't in the allowlist, as the
>> corresponding features are unsupported or cannot be properly virtualized.
> 
> I think we need to more loudly call out that this is an ABI change and we expect
> it not to impact other VMMs because...

OK, will do this for this patch and patch 4.

Thanks!

> 
>>
>> Update the documentation to reflect the ABI change.
>>

[...]

>> +#define TDX_CPUID_ALL_ALLOWED_MASK	GENMASK_U32(31, 0)
>> +
>> +static u32 tdx_get_cpuid_cfg_non_feature_mask(u32 function, u32 index, int reg)
>> +{
>> +	/*
>> +	 * For a leaf/subleaf/register that will never be repurposed to hold
>> +	 * feature bits, it's safe to return TDX_CPUID_ALL_ALLOWED_MASK, i.e.
>> +	 * leave the TDX module's CPUID config mask intact.
>> +	 */
>> +	switch (function) {
>> +	case 1:
>> +		if (reg == CPUID_EAX || reg == CPUID_EBX)
>> +			return TDX_CPUID_ALL_ALLOWED_MASK;
>> +		return 0;
>> +	case 4:
>> +	case 0x18:
>> +	case 0x1f:
>> +		return TDX_CPUID_ALL_ALLOWED_MASK;
>> +	case 0x24:
>> +		if (index == 0 && reg == CPUID_EBX)
>> +			return GENMASK_U32(7, 0);
>> +		return 0;
>> +	case 0x80000008:
>> +		if (reg == CPUID_EAX)
>> +			return TDX_CPUID_ALL_ALLOWED_MASK;
> 
> There are reserved bits in some of these. Are these "no feature bit" assumptions
> checked somehow?

Xiaoyao mentioned it in v3 too.

Sean suggested in v2 that "Realistically, CPUID.0x1.E{A,B}X are never going to be
repurposed to hold feature bits, and so generating a mask of allowed bits adds
unnecessary cognitive load and maintenance.  Ditto for CPUID 0x4, 0x18, and 0x1F."
https://lore.kernel.org/kvm/aj1fi_0SBxMK5WOB@google.com/

If we really have concerns, I can change it to exclude reserved bits in the next
version.
