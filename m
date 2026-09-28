Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349646DFF6;
	Mon, 28 Sep 2026 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582899; cv=none; b=kcbjwYN5IcBWCJHuodrixBb/gGvzKfgA6yKsveh1EG/WuZ1j/DJpj7xXVTkPGXHbMLTsKvjGy5kidP1U4TWyecxtmkgKDI9ODjRtjFBVNpDleVEZ9Sfvh7QEaIj3Xb+rGv0JHL+oWFYtZg+X7JjYlZaRZdfPC9qb7ZjgKGJkhcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582899; c=relaxed/simple;
	bh=knCo66pq3uGlZSrqn7aePJZV901fruCov4FSZnFKgAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lV8WkwVRMTPfFrhgf0FMLwPO/UM7sIibgfUmPzYOePk76c+Pyaxjn5KlpBa2y3DnXYFfcY07TYWxOOMyfgkWSRPhGVW2UNDvv/IZWW9kCqM/9We3dfybB7AuAqq6zfuXvSuydHcBXOQ71gEvLdOaoQUoxcNj5n3cPw+FOyfOfWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnrrKCPc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnrrKCPc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790582897; x=1822118897;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=knCo66pq3uGlZSrqn7aePJZV901fruCov4FSZnFKgAE=;
  b=LnrrKCPc89qlYwcGjapW4ODSLRDlMvsj0DBPI2B4ttY0b5DWymHVQVRN
   4lfecmCK1jZhJFIfJtiURnkclcA9kQzFaa3bgvWL/CGaddLVqNtqFQbEu
   Km6DlvOJEToBwP1kpzGoZHyEjHh5HsDcEzQugfhS+UPbikldbCyqkkUu+
   /eOwCgooHfAM5hn27F2ZNnpAyB3QOBfBSwqkfOLl0hwDYM4pfndb6v6OV
   FaJx5NOpjC1R6BLlfqjdwSC7+0bNTL0KWdWHaP/KHyAUju2tf1V8Hr3gJ
   RCrWLpniwdp/EgGp7/GH08WOLUIVTIPKUpoofP8BO420TBlbk+kLPokVl
   A==;
X-CSE-ConnectionGUID: IMKJKJWPTcm8BSJ0KxFktw==
X-CSE-MsgGUID: wDjhSVI6SBOr6QRRbmczCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90143057"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90143057"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:08:17 -0700
X-CSE-ConnectionGUID: 7YvYDC2USCWPT91n1w2vtA==
X-CSE-MsgGUID: ESnXNjWhRQ2HVQ6pp+wZig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="301265112"
Received: from unknown (HELO [10.238.1.46]) ([10.238.1.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:08:13 -0700
Message-ID: <c612e6cd-ca84-4c37-af72-9c13eeb1f3ce@linux.intel.com>
Date: Mon, 28 Sep 2026 16:08:11 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Xiaoyao Li <xiaoyao.li@intel.com>
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
 <de109514-91b8-49a6-bbbe-c1f7f1ee407f@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <de109514-91b8-49a6-bbbe-c1f7f1ee407f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/2026 10:33 PM, Xiaoyao Li wrote:
> On 9/24/2026 7:41 PM, Binbin Wu wrote:
[...]
>>> For X86_FEATURE_PBE (CPUID.0x1:EDX[31]), it's related to bit 10 of MSR
>>> IA32_MISC_ENABLE. The CPUID is 1 on SPR and EMR. But bit 10 of MSR
>>> IA32_MISC_ENABLE is always 0 and setting bit 10 to 1 fails. It seems though
>>> CPUID.0x1:EDX[31] is set to 1, but it's not related to bit 10 of MSR
>>> IA32_MISC_ENABLE?
>> In the ISE (319433-062, table 1-6), it says:
>>   PBE:
>>   Pending Break Enable. The processor supports the use of the FERR#/PBE# pin
>>   when the processor is in the stop-clock state (STPCLK# is asserted) to signal
>>   the processor that an interrupt is pending and that the processor should
>>   return to normal operation to handle the interrupt. Bit 10 (PBE enable) in the
>>   IA32_MISC_ENABLE MSR enables this capability.
>>
>> TDX module doesn't allow IA32_MISC_ENABLE[10] to be 1 is since it's reserved
>> TDCS.TD_CTLS.REDUCE_VE is set, so my understanding was the CPUID bit should be 0. 
>>
>> It seems bit 10 is phased out in IA32_MISC_ENABLE on modern processors like SPR
>> and EMR, since the bit 10 is reserved in "IA-32 Architectural MSRs" table. But
>> somehow, CPUID still reports PBE as supported.
> 
> yeah. arch/x86/include/asm/msr-index.h divides the bits of MSR IA32_MISC_ENABLE
> into two groups: architectural and model-specific. Bit 10 falls into model-specific.
> 
> Maybe we can ask internally why CPUID still reports 1.
> 
>> I don't know why the CPUID is disconnected with the MSR.
>> But this bit is present on the host, I think we can add it to the allowlist.
> 
> I have opposite opinion. Since 1) this feature is related to hardware processor
> PIN, 2) KVM never advertise it to normal VMs, and 3) no usage in kernel for this
> feature. I think no TD relies on it and don't allow it should be OK.

My consideration was maybe some userspace could set this bit.

But userspace is expected to consult KVM_TDX_CAPABILITIES for the configurable
bits before invoking KVM_TDX_INIT_VM, regardless of this patch series, there is
no risk to break userspace, except for CORE_CAPABILITIES, which is the only special
case as it was defined as fixed-1.

I think there is no need to add XTPR to the allow list either.
