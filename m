Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFBB3126B9;
	Thu, 19 Mar 2026 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906067; cv=none; b=I6L0DKxP+5udR7b3y5rFbuXIaYdE9jNrSYph8Y7LNTpdDGCwHcDmk8C04GS5vRT7PeAKYe/J30tL9pFWASfocKjwQ4mCs1PPvu1iazQrwHYD/HoBW7a7R7keZD15/I+IA8kFs3HI4lUnyxhOnHvEv2+3SFrsQ/WcXRupE0UrKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906067; c=relaxed/simple;
	bh=YAdgkJT5EhYWgef8Gj2bqOw2vGrbvl/WEYj6Kfqe13g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7VoEwKoqObou5QAeB8JPN5oK5Pc8MyJVsNqkNPvEOp3oUuxGy96RO2UNkDYl1vZ6gjpwuURIFWZScVrDqZHCgyps0fP8jBE3ECw6fMqw34eCO/hVrj9SYyOwHpdYe7ATB2BAVAMa8Lwr3Ezu2eqV6hZb/sYtZEFydMTjq4Sk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijJtX6w9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijJtX6w9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773906066; x=1805442066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YAdgkJT5EhYWgef8Gj2bqOw2vGrbvl/WEYj6Kfqe13g=;
  b=ijJtX6w99iEyShbnQiVhFYkhzfR0oVpJjD+uDk25fu44r+E79AvtsKTC
   XQkzgvTlwlm09LOHSkXCQXVdA0MDwnt4+LWKML76YpbZk+FcmLTgpVFlT
   80TYXvQ2/kkLSTI6xDdDrJb8o6JUnqd7Miu3DMZGjrr2bYbh/bsgnFZSk
   EEmqlwSlWCwduOxvFV0AIV8ZwhDhudbPRvvrWNixjLBKKCN6M+iTHNU8+
   LFEzk4KsB8frWd9jF9cJdnVhcUXAZrP/ewsVnK8xh1GL3IIIe1yc6BTHd
   12YFTGWlVXXn5jhyFKJIlSuXkAZe38jPWQDYMvQmm4V6VSHWa36jKGhHm
   g==;
X-CSE-ConnectionGUID: iQ2k8ooyQWmi2CcCFUrI1w==
X-CSE-MsgGUID: XFwAqqrbQQ+s9F8z+0f+Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74668954"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74668954"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 00:41:05 -0700
X-CSE-ConnectionGUID: VE5wNEgSS4+fmaeigvdCZA==
X-CSE-MsgGUID: 8y7lzHeWQw+01QCs6seuSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227830118"
Received: from unknown (HELO [10.238.1.83]) ([10.238.1.83])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 00:41:02 -0700
Message-ID: <ee8d7ea3-0ece-43cf-ab07-6954df4c01ad@linux.intel.com>
Date: Thu, 19 Mar 2026 15:40:59 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
To: Dave Hansen <dave.hansen@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dmytro Maluka <dmaluka@chromium.org>, kvm@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:X86 TRUST DOMAIN EXTENSIONS (TDX)" <linux-coco@lists.linux.dev>
References: <20260318190111.1041924-1-dmaluka@chromium.org>
 <94b06319-2be8-4f01-87d1-8989ae1ca85d@intel.com>
 <cb99e44c-8bc9-4bab-b485-9f63a4d0b262@linux.intel.com>
 <93358559-5ed1-4574-8951-24d7ea9354e4@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <93358559-5ed1-4574-8951-24d7ea9354e4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/2026 9:48 AM, Dave Hansen wrote:
> On 3/18/26 18:14, Binbin Wu wrote:
>> The bug doesn't cause problems for TDs because:
>> - These x2apic MSRs (TASKPRI, PROCPRI, EOI, ISRx, TMRx, IRRx) are virtualized by CPU,
>>   when a TD accesses these MSRs, it doesn't cause #VE, thus no TDVMCALL from the TD to
>>   request the emulation of these MSRs.
>> - The bug make the "false" range of APIC MSRs smaller, so it doesn't impact the result
>>   for the rest of the APIC MSRs.
> 
> Could we fix this up so that the code that's there is actually usable
> and testable, please?
> 

tdx_has_emulated_msr() is used by KVM to decide whether to emulate a MSR access from the
TDVMCALL or just return the error code.

During an off-list discussion, Rick noted that #VE reduction could change the behavior of
accessing an MSR (e.g., from #VE to #GP or to be virtualized by the TDX module) without
KVM knowing.Because KVM lacks the full context to perfectly decide if an MSR should be
emulated, the question was raised: Can we just delete tdx_has_emulated_msr() entirely?

However, these native type x2apic MSRs are a special case. Since the TDX module owns the
APICv page, KVM cannot emulate these MSRs. If we remove tdx_has_emulated_msr(), a guest
directly issuing TDVMCALLs for these native type x2apic MSRs will trigger a silent failure,
even though this is the guest's fault.

It comes down to a tradeoff. Should we prioritize code simplicity by dropping the function,
or keep it to explicitly catch this misbehaving guest corner case?


BTW, besides the bug described by this patch, according to the latest published TDX module
ABI table, MSR IA32_X2APIC_SELF_IPI is native type, but not included in the list.
There are some MSRs, which are reserved for xAPIC MSR, not included in the list, but they
can be covered by the KVM common code.
