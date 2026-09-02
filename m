Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C8844781A;
	Wed,  2 Sep 2026 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344992; cv=none; b=loM6lv7hK/rSHDl1LF/z20dM4cawL+xEKrbXxQjMHDVqLUMTgOnsMiHTZKZu9KSvcx0VD7PHDXTbzBQc7WPf9mS9J/PPOu1MqJCIQ/+29H8PcI5B6l4Y7FT6aLVOnEGJSAI0ZxAb5CcT6cLT12p4xYnxMm2lnFU+szEyhjGdPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344992; c=relaxed/simple;
	bh=RkBEgx826TjsnXp4ElKnnCKUH6q4YHX/zaCTbrx7odA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7YDtfS/M46//eUJ/mbfSDzqyGrb4aG2a2pi+4eg2D4WyAwhjGFBhc52n3TZNtXh61BXFFFsYunK7SRNDsojmIjT58oXrUnNCC3PgUpnWgAjkkXqLhNGz5vG3QqXlZe1XVulPr5WyTrDHifz8IdhcvCbEv8WkEIElqfDfiXdafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8dcg+cq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8dcg+cq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788344989; x=1819880989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RkBEgx826TjsnXp4ElKnnCKUH6q4YHX/zaCTbrx7odA=;
  b=i8dcg+cqnnr5pOpElrzHYP1cP6JNbf/xV2+1FQ6pBUabbc02VyctFTeo
   Fsz6DQLKg26tKU4XCTpjszpX8Mwwce4QGEnPpb9IapK7jIfRpTb3+LKMb
   tKj3JJExEv0hlnAnED78zt/725Y+5xVIdfhCtwVK2YNR/C5UrAWM75JAE
   WD7dra2s6cu0ADwnetyHBS4momo2CvQBI43vBZdLzi477m0gWfdQ/1jtx
   qjaXLIQAExdVjeCPj34XWfajtakgzBQn+m7dyKmNcrAe1qE8lWoiwEHyG
   k9GxGGrSNHOtutGGYj1p3qWIx03dPskw2y+jP5vxCZkXENiNHiUsoEWON
   w==;
X-CSE-ConnectionGUID: QKLuHEy0S9GmUWFnpJeIKg==
X-CSE-MsgGUID: CZ1MmVh5ROCScykovtvA6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="100312959"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="100312959"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 03:29:45 -0700
X-CSE-ConnectionGUID: NunEWvN0Tu+oV6jU1PsR8w==
X-CSE-MsgGUID: 0mHIaR69QDe4HYExzAk2yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="273545155"
Received: from unknown (HELO [10.238.208.122]) ([10.238.208.122])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 03:29:43 -0700
Message-ID: <91c9e314-6b92-4f90-a2df-ed21104f84bc@intel.com>
Date: Wed, 2 Sep 2026 18:29:40 +0800
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Cc: "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
 <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
 "Gao, Chao" <chao.gao@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
 <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
 <6f8f2c59-3336-4ed8-837f-57cb706ece30@intel.com>
 <69c42183261acb4150961cabf6318b92765b6562.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <69c42183261acb4150961cabf6318b92765b6562.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/2/2026 1:41 AM, Edgecombe, Rick P wrote:
> On Tue, 2026-09-01 at 17:38 +0800, Xiaoyao Li wrote:
>>>> Ideally the TDX save/restore would share code with normal VMs. On the
>>>> other hand if we don't share enter/exit paths sufficiently, we may need to
>>>> duplicate some save/restore in tdx code.
>>
>> (Copy the FRED example here for reference)
>>
>>   >>>
>>   >>> FRED is a useful concrete example.  Under VMX, the FRED host state in
>>   >>> IA32_FRED_CONFIG, IA32_FRED_STKLVLS, IA32_FRED_RSP1-3 and
>>   >>> IA32_FRED_SSP1-3 is covered by the VMCS host-state area, so the TDX
>> module
>>   >>> is expected to restore these MSRs on TDH.VP.ENTER return.
>> IA32_FRED_RSP0
>>   >>> and IA32_PL0_SSP (a.k.a. IA32_FRED_SSP0) are handled by software,
>> so the
>>   >>> TDX module is expected to clobber them on TDH.VP.ENTER return.
>>
>> What I get, is not matching VMX behavior but matching the behavior KVM
>> will perform for VMX. They are based on the assumption that KVM will
>> always enable the save/restore VMCS fields for a new feature. But I
>> don't think we can guarantee it.
>>
>> To me, "have TDX simply match VMX behavior" means:
>>
>> 1. if the VMX unconditionally save/restore a state, then TDX will do so.
>>
>> 2. if there are vm-entry/vm-exit load/save VMCS fields for a state, then
>> provide the equivalent per-TD configurable interfaces which matches the
>> VMCS fields.
> 
> What do you mean by this? Expose a TDX module interface to configure the clobber
> behavior for each feature with load/save configuration? That was similar to what
> we originally discussed, before pivoting to this solution.

yeah. This is what I meant. I was trying to show my literal 
understanding on "The proposal is to have TDX simply match VMX 
behavior". i.e., I don't think "have TDX simply match VMX behavior" is a 
good name/summary for what Binbin has proposed.

> I was thinking if you configured a feature (for example shadow stack), it would
> automatically set the VMCS save/restore settings associated with that feature.
> (VM_EXIT_LOAD_CET_STATE/VM_ENTRY_LOAD_CET_STATE)
> 
> This won't necessarily match KVM's behavior, because it could decide to not use
> the features. But we can probably get close with a simple rule that can make
> sense for all the VMMs.

So the proposal is making TDX behave as if the relevant VMCS save/load 
controls (if any) are set around TDH.VP.ENTER.

In fact, what matters for host vmm is just the VM_EXIT_LOAD_XXX control. 
So the proposal becomes "If there is VM_EXIT_LOAD_XXX control for a 
state, TDX needs to restore the host state after TDH.VP.ENTER. If no 
such contorl, TDX sets the state to INIT state after TDH.VP.ENTER".

It's a fancy idea. And it provides a clear rule of how TDX handles 
states of a feature so that host VMM developers don't need to read the 
TDX module API to figure out what's the value of a state after TDH.VP.ENTER.

It's helpful for host VMM developers, though I'm not sure on TDX module 
developers.

> If later we want a host clobber interface on top of the bit filtering, in order
> to minimize TDX special handling, we can probably add it later for features we
> care about. I'd think we don't need it right now.

