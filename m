Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61A33A5431;
	Fri, 28 Aug 2026 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887166; cv=none; b=lF3xYOQ5fnTGnwDX033t8YQV4UGoxYq3OZiGpVKbnldjeTB5jDkys775U4jWp7YXykGShwbWfvq/rjAEIqCtEos9Xnb0FWPjDpEh02XxT1P81fThPnv9uXPT1HM0+8Nr0v6bHEi/4/pOYrlC/H6euRq0EnXmo38Yzs4gzJtP/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887166; c=relaxed/simple;
	bh=nlfd2yJ+A9oMv4LIvY+m2B3z4qQnrnI5OXm6U3jGoBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kim2htX8M3Y7UrA2mqggA48C3Ig02XeeSChxazQpXRz+RYuYA75hlBq60X4komfVtVm0Oivv2c5iBX55IIJ3NrxX8NHszbmJ8UqsCppl725u5E7M3QiUvQ2ptFxHz3D2jbzu8jM17QwFqV80HzmaJxykZ4VlC3MyDJtQh4aCha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LH6+w6vw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LH6+w6vw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787887162; x=1819423162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nlfd2yJ+A9oMv4LIvY+m2B3z4qQnrnI5OXm6U3jGoBQ=;
  b=LH6+w6vw7HYJBHF4RtwGzo41ktkG2kw8KpzlNVFdo7o5rJYtGFpLT0xU
   vDm1t6wwbmkjHGqdSQXUiCS6v4scHbMQuyjRl2mkY5x5QUJiO7e2Yual0
   6HiLDItMIrPPXKCRTp6vQB6/day9bZ8tCCqyQvlRzS0ITGIShjaanFlzU
   RlUm6Xz1lzvF8uLwNkQqIrMYUqz/Wsv0BzAiOLtCPgh+MChjlVuhaXbEG
   YCSv1ETK0v4bqbsz1dqN/U5j4/cx5Bol8BTZjR5mpYXGL6RD/9rPqMnDl
   oe827SiXYj7mRJh1zjQUXu1ykJyGQattY8ItqUHfzpEOSyegtLUoxtg30
   w==;
X-CSE-ConnectionGUID: K6+nx1HQQkOw0Bz61/DyHg==
X-CSE-MsgGUID: KWjeBXMkTVW5p0Dbc+lg+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88517924"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="88517924"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 20:19:19 -0700
X-CSE-ConnectionGUID: BXn9MfMaRa2fhsCjj1d22g==
X-CSE-MsgGUID: I695iusqRR+ly/MF1Rgeaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="268612773"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 20:19:17 -0700
Message-ID: <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
Date: Fri, 28 Aug 2026 11:19:14 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/28/2026 3:33 AM, Edgecombe, Rick P wrote:
> On Thu, 2026-08-27 at 11:18 +0800, Binbin Wu wrote:
>> Hi,
>>
>> The purpose of this patch series is to prevent userspace from enabling
>> host state clobbering features that KVM does not support for TDX.  A host
>> state clobbering feature exposed on a new TDX module/platform can corrupt
>> host state if KVM does not explicitly save and restore the related MSR(s)
>> across host/guest transitions.  If such a feature is blindly exposed to
>> and used by a TD, the host will behave unexpectedly.
>>
>> Except for a few fixed-1 bits required for basic TDX support, host state
>> clobbering features are either directly configurable or gated by TD
>> ATTRIBUTES/XFAM.  So an allowlist covering only the directly configurable
>> CPUID bits, plus the corresponding filtering and validation, is sufficient
>> to serve the purpose while keeping the code footprint small.
>>
>> Open question for Sean/Paolo
>> ============================
>> This revision comes long after Sean confirmed the overall direction on
>> RFC v2 [1], due to internal discussions about a potential backward
>> compatibility issue: a CPUID field can change virtualization type to
>> directly configurable.  The TDX module can maintain backward
>> compatibility in most cases; the problematic case is a single bit that
>> was effectively "1" and non-configurable becoming directly configurable.
>> The only scenario we can envision for that is an x86 feature deprecation.
>>
>> In that case the TDX module has to decide how to handle deprecation,
>> especially with respect to TD migration compatibility.  That
>> pre-existing VMs with the deprecated feature enabled cannot migrate from
>> an old platform to a new one is a problem shared by TDX and VMX, but the
>> TDX module additionally has to decide:
>> - Whether to allow TDs newly created on old platforms to migrate to new
>>   platforms.
>> - Whether to allow TDs created on new platforms to migrate to old
>>   platforms.
>>
>> There are two options:
>> 1. Do not offer the VMM the ability to configure the bit, i.e. simply
>>    report it as zero on platforms that no longer support the feature.
>>    This disallows both migration cases above.
>> 2. Make the bit directly configurable so the VMM can clear it even on
>>    platforms that still support the feature, allowing both migration
>>    cases above.  However, since the bit is not in KVM's allowlist,
>>    userspace would no longer be able to enable it on old platforms after
>>    a TDX module update.
>>
>> Adding all supported CPUID bits to the allowlist, regardless of their
>> virtualization type in the TDX module, would avoid the compatibility
>> issue for option 2, at the cost of a significantly larger series.
> 
> I think we could only do this if no new fixed-1 bits are added. If they were,
> then a future fixes-1 bit could be added then deprecated. An old kernel would
> not know about it.
> 
> But we will not see new fixed-1 bits?

The expectation is that no new fixed-1 bits will be added after the initial TDX
basic support. A new fixed-1 bit means the x86 architecture itself leaves the
TDX module no choice, so the TDX module will not add one unless some very
unusual future architectural change forces it to (and it's hard to see such a
design passing the design review in practice). If that ever does happen, it
would imply a significant architectural change, and we can figure out how to
handle it then.

> 
>>
>> Given that x86 feature deprecation is expected to be very rare, and that
>> Intel will discuss such cases with the community beforehand, does the
>> approach taken by this series look acceptable?
>>
> 
> In the event a feature bit is turned configurable to support creating TDs that
> can be migrated to new platforms without the feature, then the desired value for
> the bit on the old platform will be 0. Which is what it would end up being set
> as, if the bit was not in the KVM side allow list. So everything will work as
> desired for that use?

Yes, it would work for migration cases.

> 
> But a user on the old platform that didn't care about migration and was using
> the feature, would suddenly lose it after TDX module upgrade that turned the bit
> configurable

Yes. This is exactly the backward compatibility issue for option 2.
Though I am not sure how important it is when losing a feature that is being
deprecated.

> 
> But it isn't a kernel bug, so I'd think to punt on this and let TDX module
> figure out a solution if/when the time comes. Probably various opt-in knobs to
> allow for working around it.

Do you mean on the old platforms, the according TDX module versions add opt-in
knobs to allow the "effective 1 -> directly configurable" change?


> If they are not worried, we don't need to worry and
> bloat the kernel to prepare for it.
> 
>>   If so, the goal for this
>> revision is to collect detailed feedback and, where appropriate,
>> Reviewed-by tags.
>>
>> Expected host state clobbering behavior for TDX
>> ===============================================
>> We also want to call for discussions about the expected host state
>> clobbering behavior for TDX here for future features.
>>
>> For a normal VMX guest, VM entry/exit behavior for a given piece of CPU
>> state is architecturally defined: state is either switched by hardware via
>> VMCS host/guest fields, or left as the guest value on VM exit and managed
>> by KVM in software.
>>
>> For TDs, the host/guest transition goes through TDH.VP.ENTER, and what the
>> TDX module does with a given piece of host state is defined by the TDX
>> module ABI rather than by the x86 architecture.
>>
>> What we would like to align on is the expected baseline behavior of
>> TDH.VP.ENTER for future features.  The proposal is to have TDX simply
>> match VMX behavior, i.e. on return from TDH.VP.ENTER, state that VMX would
>> restore from the VMCS host fields is restored, and state that VMX would
>> leave as the guest value is clobbered.  That keeps a single model for VMM,
>> and means enabling a new feature for TDs requires the same work flow as
>> enabling it for VMX.
> 
> Ideally the TDX save/restore would share code with normal VMs. On the other hand
> if we don't share enter/exit paths sufficiently, we may need to duplicate some
> save/restore in tdx code.

It probably needs some TDX specific handling, since the TDX module clobbers the
MSRs (setting them to either their INIT values or some default values), whereas
in the VMX case the guest values are left.

 Depending on how much of which category we have, it
> could be better for the kernel to have either one.
> 
> And if TDX always saved/restored all state across VP.ENTER, then we don't need
> bit filtering? What are the problems then with exposing everything to userspace
> as we currently do?

One consideration is performance.

- When The TDX module clobbers an MSR, there are 1 RDMSR + 2 WRMSR
  TDX WRMSR to restore guest value
  ---
  TDX RDMSR to save guest value
  TDX WRMSR to set to default value
- When The TDX module save/restore an MSR, there are 2 RDMSR + 2 WRMSR
  TDX RDMSR to save host value
  TDX WRMSR to restore guest value
  ---
  TDX RDMSR to save guest value
  TDX WRMSR to restore host value

In most cases where the TDX module chooses to clobber an MSR rather than restore
the host value, that MSR isn't consumed in ring 0, so the Linux kernel/KVM
simply restores the value before returning to userspace.

That means for most TD entry/exit paths there is one extra MSR read per MSR.

Previously in the PUCK meeting, we proposed that the TDX module preserve host
state by default for any new feature, and provide an interface for the host VMM
to opt in to "don't preserve" as an optimization. That proposal wasn't pursued,
since Sean suggested letting KVM do the CPUID validation for TDX instead.

> 
>>
>> FRED is a useful concrete example.  Under VMX, the FRED host state in
>> IA32_FRED_CONFIG, IA32_FRED_STKLVLS, IA32_FRED_RSP1-3 and
>> IA32_FRED_SSP1-3 is covered by the VMCS host-state area, so the TDX module
>> is expected to restore these MSRs on TDH.VP.ENTER return.  IA32_FRED_RSP0
>> and IA32_PL0_SSP (a.k.a. IA32_FRED_SSP0) are handled by software, so the
>> TDX module is expected to clobber them on TDH.VP.ENTER return.
> 
> And so the ability to have a design like this for the feature depends on CPUID
> bit filtering to be in place, otherwise new modules on old kernels can clobber
> host state unexpectedly. 

Yes.

> Future features that follow this approach will need
> some VMM opt-in to say "VMM is filtering CPUID bit config", so TDX can safely
> expose new clobbering bits. Otherwise, features like FRED will be problems on
> old kernels.

If FRED support lands in KVM for non-TDX VMs before this filtering/invalidation
is in place, adding FRED to the hardcoded denylist would work as a temporary
solution.

But that only holds for a well-behaved userspace VMM. QEMU, for example, only
enables features supported by both KVM and TDX, so if FRED isn't supported in
KVM for non-TDX VMs, QEMU won't enable it for TDX either.

A malicious userspace VMM, however, can set a feature regardless of KVM's
reported CPU capabilities, and could still cause trouble.

> Do we want it? Where would it get plugged in?

So if the approach in this series is taken, I think we still need such an opt-in
interface to tell the TDX module that the VMM is now filtering the CPUID bits so
that the TDX module knows that it's safe to report new host state clobbering
features.


