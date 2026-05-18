Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED542F8EBB;
	Mon, 18 May 2026 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779070804; cv=none; b=GovE3i2gnxxOAKmV3Dshd9CHsZxVuLZYYKtHWqiCBZnhollmbFbaLhyNz/0LxPOpIuAw3cJ5zZkG/Uj0M1MGIJ1WT1KM48PQFHQYGN916rUqbdmNu2jpTt6/zKT+G9rDIR4CGi/xW8egjtQ6iyAOMkg+KYuSNehJvXw69OlDe3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779070804; c=relaxed/simple;
	bh=lmm0Bw+0PJHp7u9T77Pnlf2PlaDDU0n/tVAzR5QksoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wg3leksge0bLd9yro35yE+vehePvZtGY7FfPXX9TdxkL7US143seNKXUWUvWeigy7YFQ8DDrJeaI1638yggyDQ+W5vm3iLrpfUZDozYT8Cjv4R1vtXRR3ulaCPew2zbQQVwRpkRDgm046YKiFDrM4Fqs5cvW1NXT9ApwePMCEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kiB69d9H; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kiB69d9H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779070801; x=1810606801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lmm0Bw+0PJHp7u9T77Pnlf2PlaDDU0n/tVAzR5QksoM=;
  b=kiB69d9Hlxp590Ed4eqtAz5s0IZd+rXBvWzpNGLlJW9EmN2uE1hyADay
   JI0ZDk01n1nOFeiOX2x0vzmYgJhUkEniKCJz/nfAzJDNLZ4WHX03mOGcS
   ZXPp6eMuLKNTw+I/JbJv4Zd34aB3Bofh86qPnqAHerKClaZHpht0w133o
   bP4z8j+7EnwSkQ2tgFnfETKMUeovNIMtEhnwcObIn/WMmHs3RaxUHzpdT
   zbDa4Z726AzBGbZS+r6a5fWdOZK1JteT7aSK6d7DsJ8kk/wQ32+rqYcgb
   mAkmhmsVWY2IIwxExsYtWimfDSQQekGcMSIm4AeHfvqmgXR4TxOpwnDMT
   Q==;
X-CSE-ConnectionGUID: oqWtb0sjRjSPgWMAvQefPg==
X-CSE-MsgGUID: CzazY6JCRsaTGwcsdVRrFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79950182"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79950182"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 19:20:00 -0700
X-CSE-ConnectionGUID: 2crD5fm4Rl2x0zzJgqkOeg==
X-CSE-MsgGUID: ZYhJsHOETueP/erDGi7fvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="243584884"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 19:19:57 -0700
Message-ID: <52fdc61a-60e8-4547-8ff7-f249b4d667b9@linux.intel.com>
Date: Mon, 18 May 2026 10:19:54 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] KVM: x86/xen: Don't truncate RAX when handling
 hypercall from protected guest
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
 <20260514215355.1648463-4-seanjc@google.com>
 <27ba35fd-5563-4bbd-8f95-2285b50efa7a@linux.intel.com>
 <agcXr2FP4C3I_jbQ@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <agcXr2FP4C3I_jbQ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2026 8:55 PM, Sean Christopherson wrote:
> On Fri, May 15, 2026, Binbin Wu wrote:
>>
>>
>> On 5/15/2026 5:53 AM, Sean Christopherson wrote:
>>> Don't truncate RAX when handling a Xen hypercall for a guest with protected
>>> state, as KVM's ABI is to assume the guest is in 64-bit for such cases
>>> (the guest leaving garbage in 63:32 after a transition to 32-bit mode is
>>> far less likely than 63:32 being necessary to complete the hypercall).
>>>
>>> Fixes: b5aead0064f3 ("KVM: x86: Assume a 64-bit hypercall for guests with protected state")
>>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>
>> The patch looks good to me, but one question below.
>>
>>> ---
>>>  arch/x86/kvm/xen.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
>>> index 6d9be74bb673..895095dc684e 100644
>>> --- a/arch/x86/kvm/xen.c
>>> +++ b/arch/x86/kvm/xen.c
>>> @@ -1678,15 +1678,14 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
>>>  	bool handled = false;
>>>  	u8 cpl;
>>>  
>>> -	input = (u64)kvm_register_read(vcpu, VCPU_REGS_RAX);
>>> -
>>>  	/* Hyper-V hypercalls get bit 31 set in EAX */
>>> -	if ((input & 0x80000000) &&
>>> +	if ((kvm_rax_read(vcpu) & 0x80000000) &&
>>>  	    kvm_hv_hypercall_enabled(vcpu))
>>>  		return kvm_hv_hypercall(vcpu);
>>>  
>>>  	longmode = is_64_bit_hypercall(vcpu);
>>
>> Is the variable name misleading?
> 
> It most definitely is.  However, @longmode is passed around quite a few locations
> in xen.c, and so I don't want to opportunistically fix this one variable.  Though
> I'm definitely not opposed to a separate patch to rename them all to is_64bit or
> something.

OK, I can do it.

> 
>> If the vcpu is in compatible mode (when guest state is not protected),
>> it's in long mode, but the code goes to !longmode path.
>>
>>>  	if (!longmode) {
>>> +		input = (u32)kvm_rax_read(vcpu);
>>>  		params[0] = (u32)kvm_rbx_read(vcpu);
>>>  		params[1] = (u32)kvm_rcx_read(vcpu);
>>>  		params[2] = (u32)kvm_rdx_read(vcpu);
>>> @@ -1696,6 +1695,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
>>>  	}
>>>  	else {
>>>  #ifdef CONFIG_X86_64
>>> +		input = (u64)kvm_rax_read(vcpu);
>>>  		params[0] = (u64)kvm_rdi_read(vcpu);
>>>  		params[1] = (u64)kvm_rsi_read(vcpu);
>>>  		params[2] = (u64)kvm_rdx_read(vcpu);
>>
> 

