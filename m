Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12437C0FC;
	Mon, 29 Jun 2026 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782702129; cv=none; b=MM4P6df1d5a6VJ+BUT8qZhvbLjkYtqRwqKRYvGVYmxHztMe1bX+YvV38B3VMBDSO3gunu1Y9OPO7JhCHjDW9Q6YmlO6wt5kFKQKxw789z8sN5VxvhVx6v4wOksnuNvSbovXGSK4kJx2NCGzSdjo0tZgA6D9t8yw8TvlyxduiSWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782702129; c=relaxed/simple;
	bh=BtkTdha5vBV89VC6VXNFTv3riFQusPJYfhOrwJbCXw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eh0aodRWDh+4xxc3CHupyYvC3as1vC5v2tlynwDArBwrp+PYhH1WZhH2+xJ8yMFYYBbcJvSd2+/zv6fyCZ4SLJor7RPTxC3Ah1rrn5MpV+h6YgWhTlW1ltgzD8YiENR/cGoWlB0YXn5F70IFsiVnRgj9j82uOrJyfjbwTUFYajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtdG0VFN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtdG0VFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782702128; x=1814238128;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BtkTdha5vBV89VC6VXNFTv3riFQusPJYfhOrwJbCXw8=;
  b=OtdG0VFN04HtuSw/cQMAhrcmf6S5XrNcjoAEQ810czuoiCXpjvJUzI81
   r+xpLmhVZbYtiv1eHt3S9rgGcDUryBDLcCvZ1egfJ8gJXTa6tO7WW+iMn
   jq6lGmS0q/MrmLHO12sqfpGwsuXMuiigwxbC2qe9hxe3Pn/2GhpkOpPQY
   5q2Zcpsp2FirVZEiymiCxWwsk7iz8ox17KLbr506u/2o4MFlMViUyXJMi
   +Gxkd1JZariTOFGcIjYmPswrv9dn4z7dMCIHe/GBgfBR6kM4i02dVExQq
   fyNe4rFpxSTYPGa/UsU871vrSHrnR2Vcm8ikB97xHtRblOxaJPKksvvlr
   Q==;
X-CSE-ConnectionGUID: SO+CB7Q/Rve+5vYTJdrnEg==
X-CSE-MsgGUID: 7svc0FjwR0+lUQjsnJ7pIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="87076812"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="87076812"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 20:02:05 -0700
X-CSE-ConnectionGUID: NsM6NkekS4Cbm4Kwxde9iQ==
X-CSE-MsgGUID: ZIl0/a7WQZe32RoW25T4aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="251965568"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.241.120]) ([10.124.241.120])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 20:02:03 -0700
Message-ID: <e6515066-3768-459d-8ae4-82c0243556a1@linux.intel.com>
Date: Mon, 29 Jun 2026 11:02:00 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/4] KVM: x86: TDX: Track supported configurable
 CPUID bits
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 rick.p.edgecombe@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com,
 kai.huang@intel.com
References: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
 <20260604023314.3907511-2-binbin.wu@linux.intel.com>
 <aj1fi_0SBxMK5WOB@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <aj1fi_0SBxMK5WOB@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/2026 1:04 AM, Sean Christopherson wrote:
> On Thu, Jun 04, 2026, Binbin Wu wrote:
>> ---
>>  arch/x86/kvm/vmx/tdx.c | 174 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 174 insertions(+)
>>
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index ffe9d0db58c5..e0567088ebf5 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
>> @@ -52,6 +52,178 @@
>>  	__TDX_BUG_ON(__err, #__fn, __kvm, ", " #a1 " 0x%llx, " #a2 ", 0x%llx, " #a3 " 0x%llx", \
>>  		     a1, a2, a3)
>>  
>> +#define TDX_CPUID_IGNORE_INDEX	BIT(0)
>> +struct tdx_supported_cpuid_reg {
>> +	u32 function;
>> +	u32 index;
>> +	u8 flags;
>> +	u8 reg;
>> +	u32 mask;
>> +};
>> +
>> +/*
>> + * Multi-bit fields are statically initialized, feature bits are initialized
>> + * in tdx_initialize_cpu_cfg_caps().
>> + */
>> +static struct tdx_supported_cpuid_reg tdx_kvm_supported_cpuid[] __ro_after_init = {
>> +	{ 0x1, 0, 0, CPUID_EAX, GENMASK_U32(27, 16) | GENMASK_U32(13, 0) },
>> +	{ 0x1, 0, 0, CPUID_EBX, GENMASK_U32(23, 16) },
>> +	{ 0x1, 0, 0, CPUID_ECX, 0 },
>> +	{ 0x1, 0, 0, CPUID_EDX, 0 },
>> +	{ 0x4, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EAX, ~GENMASK_U32(13, 10) },
>> +	{ 0x4, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EBX, GENMASK_U32(31, 12) },
>> +	{ 0x4, 0, TDX_CPUID_IGNORE_INDEX, CPUID_ECX, GENMASK_U32(31, 0) },
>> +	{ 0x4, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EDX, GENMASK_U32(2, 0) },
>> +	{ 0x7, 0, 0, CPUID_EBX, 0 },
>> +	{ 0x7, 0, 0, CPUID_ECX, 0 },
>> +	{ 0x7, 0, 0, CPUID_EDX, 0 },
>> +	{ 0x7, 1, 0, CPUID_EAX, 0 },
>> +	{ 0x7, 1, 0, CPUID_EDX, 0 },
>> +	{ 0x7, 2, 0, CPUID_EDX, 0 },
>> +	{ 0x18, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EDX, GENMASK_U32(25, 14) },
>> +	{ 0x1E, 1, 0, CPUID_EAX, 0 },
>> +	{ 0x1F, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EAX, GENMASK_U32(4, 0) },
>> +	{ 0x1F, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EBX, GENMASK_U32(15, 0) },
>> +	{ 0x1F, 0, TDX_CPUID_IGNORE_INDEX, CPUID_ECX, GENMASK_U32(15, 0) },
>> +	/* See comments in td_init_cpuid_entry2() for CPUID 0x80000008 EAX[23:16]. */
>> +	{ 0x80000008, 0, 0, CPUID_EAX, GENMASK_U32(23, 16) | GENMASK_U32(7, 0) },
>> +	{ 0x80000008, 0, 0, CPUID_EBX, 0 },
> 
> For non-feature bits, I think I would rather handle them entirely at runtime via
> switch statement(s).  Realistically, CPUID.0x1.E{A,B}X are never going to be
> repurposed to hold feature bits, and so generating a mask of allowed bits adds
> unnecessary cognitive load and maintenance.  Ditto for CPUID 0x4, 0x18, and 0x1F.

Yes, it's a bit over-engineered with the matter of fact that these are never going
to hold feature bit.

> 
> CPUID.0x1E is a bit different because it's kinda sorta a feature?  That one is
> probably worth restricting, but again that's easy to do in a case-statement.

Only CPUID.0x1E.EAX has TDX directly configurable bits currently, no special
handling needed for the rest of CPUID.0x1E.

> 
> Then for the feature bits, there should be no need to define a separate structure,
> just do "u32 kvm_tdx_cpu_caps[NR_KVM_CPU_CAPS]".  Then KVM can even further
> restrict that array with kvm_cpu_caps (though it might take some creativity to
> deal with things like MWAIT).  Because generally speaking, KVM shouldn't allow
> features that KVM doesn't support for non-TDX VMs.
> 

OK, will go this direction in the next version.
Thanks for the suggestions.


