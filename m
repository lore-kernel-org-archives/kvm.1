Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CEC47DFB6;
	Tue,  1 Sep 2026 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255522; cv=none; b=FIfATejc2oxYOhMvEPE2mIeSwiE6QpNZlvC8bl6v6it+OoibF/Fxuoborxz8ptDozgLKJmDDa8aypNo3jdx9vA3BeXWIw1viOj3PXUIdq8SnJEN1GODxHo7UZWfHnE/WBsG/aWe9on1BdNtj0ksUoYFthd07qNI091ivLftjSMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255522; c=relaxed/simple;
	bh=yxDdX6efIfGHLg1bCp0pwnuH07ggexJUPIg/6btAl4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VViEtFvVD2HBXtuWh6EdyN+TVOnm7Oka0WVkOvQ4TLzJHj0GmFk3RsQlVJw9zMJd/TgRp4woFsupGTxgNURoBLRSA15l272jNw5POnbfuiE6WuozuSmKEL+HxL7rOtodrVnzeAaKu9Cv3iqffPADnRezDN1S1+p6GD9tssL8is0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvzz6cuv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvzz6cuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788255514; x=1819791514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yxDdX6efIfGHLg1bCp0pwnuH07ggexJUPIg/6btAl4E=;
  b=dvzz6cuv86UCqrj3Tg9G8Ch6pijmKgrvTByKqeYVnvtn/lvaPjX8riD3
   1xxfKR3+f/+22y+fQqCXOF2iXTsY9jR7BjwUMmyFJWtcc3lmdse/7Dbtd
   haXA9nd29I1KqBF37VrkJ1eKICmqw0EEn7wncmZErvqZncBVhtFUX+qI7
   KElRVib5W4Hgtl71fJma4xzv6J7uRtsSDFkO385snBptWVkFD+iPsAJc1
   itrcVg3h/FKn+XHaUQU8XVfgazBbZk0sC9tv0/7PJJfD7nk9lfmWY5J0k
   m/FGwQ5qgrXoqNbMeRhGvAKBk0WY3wayLf3jqN6U2hH4gGhn/74gArIEa
   Q==;
X-CSE-ConnectionGUID: 4BOlKxKmQN2Kwdy2cwi9Ew==
X-CSE-MsgGUID: f8VjmXH2SpiE+algefC+VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="76230003"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="76230003"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:38:28 -0700
X-CSE-ConnectionGUID: Fle5pydCQOGU/aSb+7og0A==
X-CSE-MsgGUID: ooh34RPCTcixrabhtQpAEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="292556542"
Received: from unknown (HELO [10.238.208.122]) ([10.238.208.122])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:38:25 -0700
Message-ID: <6f8f2c59-3336-4ed8-837f-57cb706ece30@intel.com>
Date: Tue, 1 Sep 2026 17:38:22 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
To: Binbin Wu <binbin.wu@linux.intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "andrew.cooper3@citrix.com"
 <andrew.cooper3@citrix.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
 <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/28/2026 11:19 AM, Binbin Wu wrote:
> On 8/28/2026 3:33 AM, Edgecombe, Rick P wrote:
>> On Thu, 2026-08-27 at 11:18 +0800, Binbin Wu wrote:

<snip>

>>> Expected host state clobbering behavior for TDX
>>> ===============================================
>>> We also want to call for discussions about the expected host state
>>> clobbering behavior for TDX here for future features.
>>>
>>> For a normal VMX guest, VM entry/exit behavior for a given piece of CPU
>>> state is architecturally defined: state is either switched by hardware via
>>> VMCS host/guest fields, or left as the guest value on VM exit and managed
>>> by KVM in software.
>>>
>>> For TDs, the host/guest transition goes through TDH.VP.ENTER, and what the
>>> TDX module does with a given piece of host state is defined by the TDX
>>> module ABI rather than by the x86 architecture.
>>>
>>> What we would like to align on is the expected baseline behavior of
>>> TDH.VP.ENTER for future features.  The proposal is to have TDX simply
>>> match VMX behavior, i.e. on return from TDH.VP.ENTER, state that VMX would
>>> restore from the VMCS host fields is restored, and state that VMX would
>>> leave as the guest value is clobbered.  That keeps a single model for VMM,
>>> and means enabling a new feature for TDs requires the same work flow as
>>> enabling it for VMX.
>>
>> Ideally the TDX save/restore would share code with normal VMs. On the other hand
>> if we don't share enter/exit paths sufficiently, we may need to duplicate some
>> save/restore in tdx code.

(Copy the FRED example here for reference)

 >>>
 >>> FRED is a useful concrete example.  Under VMX, the FRED host state in
 >>> IA32_FRED_CONFIG, IA32_FRED_STKLVLS, IA32_FRED_RSP1-3 and
 >>> IA32_FRED_SSP1-3 is covered by the VMCS host-state area, so the TDX 
module
 >>> is expected to restore these MSRs on TDH.VP.ENTER return. 
IA32_FRED_RSP0
 >>> and IA32_PL0_SSP (a.k.a. IA32_FRED_SSP0) are handled by software, 
so the
 >>> TDX module is expected to clobber them on TDH.VP.ENTER return.

What I get, is not matching VMX behavior but matching the behavior KVM 
will perform for VMX. They are based on the assumption that KVM will 
always enable the save/restore VMCS fields for a new feature. But I 
don't think we can guarantee it.

To me, "have TDX simply match VMX behavior" means:

1. if the VMX unconditionally save/restore a state, then TDX will do so.

2. if there are vm-entry/vm-exit load/save VMCS fields for a state, then 
provide the equivalent per-TD configurable interfaces which matches the 
VMCS fields.

> It probably needs some TDX specific handling, since the TDX module clobbers the
> MSRs (setting them to either their INIT values or some default values), whereas
> in the VMX case the guest values are left.
> 
>> Depending on how much of which category we have, it
>> could be better for the kernel to have either one.
>>
>> And if TDX always saved/restored all state across VP.ENTER, then we don't need
>> bit filtering? What are the problems then with exposing everything to userspace
>> as we currently do?

IMO, allowing userspace to expose/enable a new feature to a guest 
without KVM first evaluating it is always dangerous. It's not just about 
the state clobbering. We can know the implication for a new feature.

For example, a feature consumes global per-socket resources. Allowing 
guest to use the feature might slowdown the host.

Another example is a feature is used to catch bad behaviors, and in this 
case host would like to enforce the feature being forced on for the 
guest instead of allowing the guest to use (disable) the feature freely.
