Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32DC395AEB;
	Thu, 24 Sep 2026 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260431; cv=none; b=Cbzm+8NDnyF2XixKGRNA5r57TlnLHC1ECubu9X+guWvRkC5m8degdU+sT3oW/3WLa58Rl4INOtLvGVYkT70Vnw2PUkTFranIP05nEHumIW4jVZbKC2ahl13cSSc5FfVAk1jriBAftETDN2J6bQQkeAY7zduJ0gX31sxiJ1yXuvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260431; c=relaxed/simple;
	bh=DyxDCEi9+1AJB21eu9ItPvdi6EOS6JTY8Okuas5+SIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6aPcE5hGfDkOnMvzFOOBWNs/Vd8bbuUHjkKsLN4EsrmnjegfFg2BTEk34wLqaAAf92rUmW+tE7Xs4HpCYKdbgqeNDv42fIynbjUl0uf/rHKceDGthotToQYjlo/bCJlz/MWC4lPY224Jeu3211LRStY/4xQbiyF0R+0EbEoDgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVFtuEiI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVFtuEiI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790260429; x=1821796429;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DyxDCEi9+1AJB21eu9ItPvdi6EOS6JTY8Okuas5+SIo=;
  b=BVFtuEiIQHJVWHNt70jdkkYyUrI7YviB4Jqp1s2LeQTLaXCFi0j4jXpE
   jyWd9U0t5uAAW24NZgsdGmU3HgMQ4yDmZfOFWS4B2LeK/K3rbkj99eHsT
   /Qn6IyCp/VDI98u+NiBze8DHihFtHRtgYJqrr50ek8B103NsNSxAlAlC9
   ofQbIQq/c0qPC8lYVvMXsmYW+B6TaUJ/UGA6DmGuhc6ZlYaXmCbktlcJL
   ln/ylnnWbU7vjlXjEWokQ9UVHuPjbLUxogWbnjLjlV1hR0thDxO0b98xH
   xENebb2pr6bvaZ3NIie+gprNpoT/DSg0YJVXAHbJ2pgIRYyudE0AJaHAY
   w==;
X-CSE-ConnectionGUID: 0zQyZNM7QRixDfVU4RCUtw==
X-CSE-MsgGUID: ssP7IiezRXmlXLW7is6fdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101206122"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101206122"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 07:33:48 -0700
X-CSE-ConnectionGUID: OT9dqVleTx+JMEwaxx1mJA==
X-CSE-MsgGUID: jPALc3JzQSeqfhWll2Fedg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="273615642"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 07:33:45 -0700
Message-ID: <de109514-91b8-49a6-bbbe-c1f7f1ee407f@intel.com>
Date: Thu, 24 Sep 2026 22:33:43 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com, dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
 nik.borisov@suse.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 chao.gao@intel.com, tony.lindgren@linux.intel.com, kishen.maloor@intel.com,
 dedekind1@gmail.com
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
 <39047bbc-757d-4131-a25c-5a7743fd591a@intel.com>
 <062f5365-7eb5-4e04-9c84-f5ecd566f019@linux.intel.com>
 <eca53031-fd47-4471-9d05-d73295a0f57e@intel.com>
 <8bcba51e-2a3b-44b8-89cd-aebfd1e50cfd@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <8bcba51e-2a3b-44b8-89cd-aebfd1e50cfd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/2026 7:41 PM, Binbin Wu wrote:
>> After some search, I find that X86_FEATURE_CID (CPUID.0x1:ECX[10]) is related to
>> MSR_IA32_MISC_ENABLE[24], which seems to be a model specific bit.
>>
>> And on SDM, vol3. 14.5.6 L1 Data Cache Context Mode
>>
>>   L1 data cache context mode is a feature of processors based on the Intel
>>   NetBurst microarchitecture that support Intel Hyper-Threading Technology.
>>   When CPUID.01H:ECX[10] =1, the processor supports setting L1 data cache
>>   context mode using the L1 data cache context mode flag (IA32_MISC_ENABLE[bit
>>   24]). Selectable modes are adaptive mode (default) and shared mode.
>>
>> CPUID.0x1:ECX[10] is 0 on SPR and EMR (I didn't check more). It looks this CPUID
>> bit will not show up on any TDX capable CPUs. I think we can report it to TDX
>> architects and just make the bit fixed0 as a spec fix?
> I think we can confirm with the TDX module team. If it will never show up on TDX
> capable CPUs, then this is similar to PREFETCHWT1. 
> 
> But I am not sure we want new fixed-0 bits.

Leave it as current "Configured & Native" is also OK. Since no TDX capable CPU
has this bit as 1, it's effectively a fixed-0 bit.

>> For X86_FEATURE_PBE (CPUID.0x1:EDX[31]), it's related to bit 10 of MSR
>> IA32_MISC_ENABLE. The CPUID is 1 on SPR and EMR. But bit 10 of MSR
>> IA32_MISC_ENABLE is always 0 and setting bit 10 to 1 fails. It seems though
>> CPUID.0x1:EDX[31] is set to 1, but it's not related to bit 10 of MSR
>> IA32_MISC_ENABLE?
> In the ISE (319433-062, table 1-6), it says:
>   PBE:
>   Pending Break Enable. The processor supports the use of the FERR#/PBE# pin
>   when the processor is in the stop-clock state (STPCLK# is asserted) to signal
>   the processor that an interrupt is pending and that the processor should
>   return to normal operation to handle the interrupt. Bit 10 (PBE enable) in the
>   IA32_MISC_ENABLE MSR enables this capability.
> 
> TDX module doesn't allow IA32_MISC_ENABLE[10] to be 1 is since it's reserved
> TDCS.TD_CTLS.REDUCE_VE is set, so my understanding was the CPUID bit should be 0. 
> 
> It seems bit 10 is phased out in IA32_MISC_ENABLE on modern processors like SPR
> and EMR, since the bit 10 is reserved in "IA-32 Architectural MSRs" table. But
> somehow, CPUID still reports PBE as supported.

yeah. arch/x86/include/asm/msr-index.h divides the bits of MSR IA32_MISC_ENABLE
into two groups: architectural and model-specific. Bit 10 falls into model-specific.

Maybe we can ask internally why CPUID still reports 1.

> I don't know why the CPUID is disconnected with the MSR.
> But this bit is present on the host, I think we can add it to the allowlist.

I have opposite opinion. Since 1) this feature is related to hardware processor
PIN, 2) KVM never advertise it to normal VMs, and 3) no usage in kernel for this
feature. I think no TD relies on it and don't allow it should be OK.

