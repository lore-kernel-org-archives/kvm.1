Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65759367F51;
	Wed, 15 Apr 2026 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252609; cv=none; b=JfZj5RVoqUuoI5DFCQqnJA0sHBM+V4bVBbC4moG4B05QJn4L/3YS7qeRpbZkb0Fd7VZaMFLaVqNhaggo8Oov2Ixc4IPP0xs10KdxsLS+CO3cHpfCu1qACFi2Hubf2r6vsBTc32+xxL79H4inEpp0Y5ghuBPDn6sbvLof2GfFzNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252609; c=relaxed/simple;
	bh=SHbLV4o2bms70SFEMNyzHlJqt/x7sG95A1eoY9qoSzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5VR1O+annBzvJZX2FLIkK8Vd4aur5lWffBuZ4EgBcLk3SudGS2q9AKc3T8GU0pYJc1hIE+uMvfvyZ9xY+4RmaWClktEUqXXFSDE2Vf6Ad5SHG6NJSH7gZA9hFGzWlCERoB/1tvc9Mx4DPtg/EutXlEaudNVZWrCwrPqrCnsRIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VIWkkw9N; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VIWkkw9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776252607; x=1807788607;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SHbLV4o2bms70SFEMNyzHlJqt/x7sG95A1eoY9qoSzE=;
  b=VIWkkw9NpD1scyMGGPm7HkWIMbLLUdugrFRw1ytleXTbnkmKDhW6eP3H
   7nhRqxWYbK0foBTpYSkE9KdjyEXZq0kGNaz9jBnahG/r7CT0yzx+++k8p
   GtnkfgrjWOtLcOfG8sx0dubnVKJ49JMBMLmOkqfe5sK0mOk3nXRp1mJWp
   S3e+gS/k91G7J8SWxy7uFbSLB73fr8/eJ14NUFTv7f+NUvninhLDwennB
   rUojmuyzRzu9xQegCWpO85aWM10+XFYyXi47f8v9yaO7jU5EeTZXLhTcd
   zAmKTdJTSFQM9WohuSrGTtCJwtqY9Xuc8poJzZsv2YQZgVeHKBv0KpPeQ
   g==;
X-CSE-ConnectionGUID: nSwNCz+ITaqO8kFXzG0fGA==
X-CSE-MsgGUID: Fr9s1c1RSSWp85crzpg43w==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="64770849"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="64770849"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 04:30:07 -0700
X-CSE-ConnectionGUID: /aC0R6AySzGkP7+DLsrVYw==
X-CSE-MsgGUID: HrKM+OTXSk2Jahqmrvo58g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="268393029"
Received: from unknown (HELO [10.239.158.42]) ([10.239.158.42])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 04:30:05 -0700
Message-ID: <c40b5057-4df5-44ba-93c9-5c46696de765@intel.com>
Date: Wed, 15 Apr 2026 19:29:31 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
To: Sean Christopherson <seanjc@google.com>
Cc: Kai Huang <kai.huang@intel.com>, Chang Seok Bae
 <chang.seok.bae@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
 <kas@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>
References: <20260409224236.2021562-1-seanjc@google.com>
 <20260409224236.2021562-6-seanjc@google.com>
 <e6e82905e6b9b1637ccb640097e67d21793f5895.camel@intel.com>
 <ad0DrDUsUKTMfrDW@google.com>
 <d6f05e5fa781ccb465d27a4fb1c7c1ac1e9e95ff.camel@intel.com>
 <95a931f8-42cc-4834-953c-30c9167bfdc1@intel.com>
 <ad5JeT7UuiQI9Tqo@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ad5JeT7UuiQI9Tqo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/2026 10:04 PM, Sean Christopherson wrote:
> On Tue, Apr 14, 2026, Xiaoyao Li wrote:
>> On 4/14/2026 7:03 AM, Huang, Kai wrote:
>>>> Because VMX and SVM make all GRPs available immediately, except
>>>> for RSP, KVM ignores avail/dirty for GPRs.  I.e. "fixing" TDX will just shift the
>>>> "bugs" elsewhere.
>>> Just want to understand:
>>>
>>> I thought the fix could be we simply remove the wrong GPRs from the list.
>>> Not sure how fixing TDX will shift bugs elsewhere?
>>
>> I'm curious too.
> 
> What I'm saying is that, _if_ there are bugs where KVM uses a register that isn't
> available, then modifying TDX's list won't actually fix anything (without more
> changes), it will just change which code is technically buggy (hence all the quotes
> above).
> 
>>>> More importantly, because the TDX-Module*requires* RCX (the GPR that holds the
>>>> mask of registers to expose to the VMM) to be hidden on TDVMCALL, KVM*can't*
>>>> do any kind of meaningful "available" tracking.
>>>>
>>> Hmm I think RCX conveys the shared GPRs and VMM can read.  Per "Table 5.323:
>>> TDH.VP.ENTER Output Operands Format #5 Definition: On TDCALL(TDG.VP.VMCALL)
>>> Following a TD Entry":
>>>
>>>     RCX   ...
>>> 	Bit(s) Name         Description
>>>
>>> 	31:0   PARAMS_MASK  Value as passed into TDCALL(TDG.VP.VMCALL) by
>>> 			    the guest TD: indicates which part of the guest
>>> 			    TD GPR and XMM state is passed as-is to the
>>> VMM
>>> 			    and back. For details, see the description of
>>> 			    TDG.VP.VMCALL in 5.5.26.
>>>
>>> I think the problem is, as said previously, currently KVM TDX code uses
>>> KVM's existing infrastructure to emulate MSR, KVM hypercall etc,  but
>>> TDVMCALL has a different ABI, thus there's a mismatch here.
>>
>> I once had patch for it internally.
>>
>> It adds back the available check for GPRs when accessing instead of assuming
>> they are always available. For normal VMX and SVM, all the GPRs are still
>> always available. But for TDX, only EXIT_INFO_1 and EXIT_INFO_2 are always
>> marked available, while others need to be explicitly set case by case.
>>
>> The good thing is it makes TDX safer that KVM won't consume invalid data
>> silently for TDX. But it adds additional overhead of checking the
>> unnecessary register availability for VMX and SVM case.
>>
>> -----------------------------&<-------------------------------------
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Date: Tue, 11 Mar 2025 07:13:29 -0400
>> Subject: [PATCH] KVM: x86: Add available check for GPRs
>>
>> Since commit de3cd117ed2f ("KVM: x86: Omit caching logic for
>> always-available GPRs"), KVM doesn't check the availability of GPRs
>> except RSP and RIP when accessing them, because they are always
>> available.
>>
>> However, it's not true when it comes to TDX. The GPRs are not available
>> after TD vcpu exits actually.
> 
>> And it relies on KVM manually sets the
>> GPRs value when needed, e.g.
>>
>>   - setting rax, rbx, rcx, rdx, rsi, for hypercall emulation in
>>     tdx_emulate_tdvmall();
>>
>>   - setting rax, rcx and rdx before MSR write emulation;
>>
>> Add the available check of GPRs read, and WARN_ON_ONCE() when unavailable.
>> It can help capture the cases of undesired GPRs consumption by TDX.
> 
> Sorry, but NAK.  I am strongly against adding any code to the GPR accessors/mutators
> just for TDX.  It's a _lot_ of code.  From commit de3cd117ed2f ("KVM: x86: Omit
> caching logic for always-available GPRs"):
> 
>      E.g. on x86_64, kvm_emulate_cpuid() is reduced from 342 to 182 bytes and
>      kvm_emulate_hypercall() from 1362 to 1143, with the total size of KVM
>      dropping by ~1000 bytes.  With CONFIG_RETPOLINE=y, the numbers are even
>      more pronounced, e.g.: 353->182, 1418->1172 and well over 2000 bytes.

yeah. I had the same feeling that bring up the reduced overhead is not 
acceptable.

> Note that updating only the "available" masks is wrong, as TDX needs to marshall
> written registers back to their correct location.

In what case it needs to marshall written registers back? Can you elaborate?

> In the end, the available/dirty tracking isn't about hardening against bugs, it's
> about deferring expensive VMREAD and VMWRITE (and guest memory) operations until
> action is required.
> 
> We could bury sanity checks behind a Kconfig of some kind, but I genuinely don't
> see much value in doing so.  These emulation flows are very static (all register
> usage is hardcoded), and so it's very much a "get it right once" sort of thing,
> i.e. the odds of a runtime check finding a bug after initial development are
> basically zero.

The initial purpose of writing the code was to find if any case/path in 
KVM that consumes the GPRs for TDX unexpectedly. Not only for the 
hypercall/MSR emulation paths. There are lots of paths in KVM consuming 
the GPRs. It's difficult to aduit every path to ensure either a) it 
won't be reachable by TDX or b) KVM syncs the valid data to the GPRs 
before accessed by TDX.

> An alternative for TDX would be to avoid bouncing through GPRs in the first place,
> e.g. by reworking __kvm_emulate_rdmsr() to not access any registers.  But I'm
> probably opposed to even that, because I doubt the end result would be an overall
> net positive for KVM.  We'd end up with duplicate code, harder to read common
> code (because of the new abstractions), and likely without meaningfully moving
> the needle in terms of finding/preventing bugs.  KVM still needs to get operands
> to/from the right parameters, though only difference is that for TDX, the parameters
> would be very "direct".

