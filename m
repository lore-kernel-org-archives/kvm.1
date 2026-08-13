Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239023955CF;
	Thu, 13 Aug 2026 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610099; cv=none; b=tJHmfsDNQFEkWbKr0/LVt/r830MigZkOhShyQLXjqElQaHSuYuEfKAI3B29IRyDWRHS0W5u06wnkNIAQZnPhN16RBC6RuD7ifLEPfimk8gDbiJHYHT+EOizHqM0Gsjfd0mlnjkYuF/i2A8DsaaCy2POy/Lw0yDDNhvxr02XEqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610099; c=relaxed/simple;
	bh=P213fFKwryqVvzJ19nn3nrhWgesO88vQtC2xd8VnYzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8fpYRWGa9jU+wwsJ9NvwxDO7tNsa1nkVQfgD0RwLmFbC0zT9IdWX9eC3QOTOekGOcedy33CoLePD198S2NLIbCsn4+AST1mCQf9ASHta5lGhSgfcgk9a0iLb0T00wF7b62+Yfy6Y98QgtMRdis2KFt4TOiyNk7FPVEF1meN7Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xjr1oSTI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xjr1oSTI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786610098; x=1818146098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P213fFKwryqVvzJ19nn3nrhWgesO88vQtC2xd8VnYzs=;
  b=Xjr1oSTIg3DGtRCv2/f1VzA4A4iZ3ef3muDPZIskDKULsqNSAd3Szrky
   BDTGK3bXyOzUtVTSobC2fMJd6uMM8FOIP34wX14Wv9FOleY3vtQRj4ytf
   LrLRUuutaDIGs804MIzD9z5TiTXa/TeenfWg/RBeHZZTNv4Kij4SDF6oU
   yjI4VgW8It+GiIL3Q4eDUqU5lZCOHDdWaOE+Eod5NKcj5CDhT3LtHrJt0
   KDRaLzYBB+1UXSYAklIMbqrRt8XRty/7dnI0M+yyom04jYv+ZCXw9aqIj
   Sj1jecec2mUWE4n4L1uHG9a1cxiH3cjPF5isqKzLzl2Nl8XeU5v8B6jBc
   w==;
X-CSE-ConnectionGUID: YGeXuNaURbem7aBqdCgHpg==
X-CSE-MsgGUID: bRFtoA1ZSJWAjygPd9uhjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87303376"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="87303376"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:34:51 -0700
X-CSE-ConnectionGUID: rAO9zl/GS7K22XcaRbqhcg==
X-CSE-MsgGUID: dwl5pXEaQHKvbnAosnphGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="264460669"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:34:48 -0700
Message-ID: <d8bfdff4-f380-4a29-b0da-366ffca4dbd3@intel.com>
Date: Thu, 13 Aug 2026 16:34:42 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kas@kernel.org" <kas@kernel.org>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-3-xiaoyao.li@intel.com>
 <5dfed336a46329ba39922dcb3a8723116dae9ae4.camel@intel.com>
 <6bb1328d-e995-4ad7-9744-3ab01d2ae591@intel.com>
 <an0M-LwrKxLrNC9H@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <an0M-LwrKxLrNC9H@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/2026 8:16 AM, Sean Christopherson wrote:
> On Tue, Aug 11, 2026, Xiaoyao Li wrote:
>> On 8/11/2026 8:38 AM, Edgecombe, Rick P wrote:
>>> On Mon, 2026-08-10 at 19:21 +0800, Xiaoyao Li wrote:
>>>> ---
>>>>    arch/x86/kvm/vmx/tdx.c | 35 ++++++++++++++++++++++-------------
>>>>    1 file changed, 22 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>>>> index 7338ac0af693..a89885d550c9 100644
>>>> --- a/arch/x86/kvm/vmx/tdx.c
>>>> +++ b/arch/x86/kvm/vmx/tdx.c
>>>> @@ -921,10 +921,10 @@ static __always_inline u32 tdcall_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
>>>>    	return EXIT_REASON_TDCALL;
>>>>    }
>>>> -static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
>>>> +static __always_inline union vmx_exit_reason tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
>>>>    {
>>>>    	struct vcpu_tdx *tdx = to_tdx(vcpu);
>>>> -	u32 exit_reason;
>>>> +	union vmx_exit_reason exit_reason;
>>>>    	switch (tdx->vp_enter_ret & TDX_SEAMCALL_STATUS_MASK) {
>>>>    	case TDX_SUCCESS:
>>>> @@ -934,23 +934,33 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
>>>>    	case TDX_NON_RECOVERABLE_TD_WRONG_APIC_MODE:
>>>>    		break;
>>>>    	default:
>>>> -		return -1u;
>>>> +		/*
>>>> +		 * Synthesize an invalid bogus Exit Reason, as the TDX-Module
>>>
>>> I think this blurb came from Sean, but can we standardize on "TDX module"? The
>>> code currently uses "TDX module" and "TDX-module" and "TDX-module" used much
>>> less. I also don't see why it needs the "-".
> 
> FWIW, I like TDX-Module to clearly identify it as _the_ TDX-Module, versus a
> potential TDX module provided the kernel, i.e. a tdx.ko module.

# git grep "TDX-Module" | wc -l
13

# git grep "TDX module" | wc -l
162

#git grep "TDX-Module" | grep kvm | wc -l
9

#git grep "TDX module" | grep kvm | wc -l
42

There are 13 "TDX-Module" vs 162 "TDX module" in the kernel, and
9 "TDX-Module" vs 42 "TDX module" in KVM files. Given this, I changed to 
use "TDX module"



