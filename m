Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762936728F
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610387; cv=none; b=F4VDgn/Pjzwns0pMnr62GLJablxOn4nYwatMXXOQ/eKHZ6iaB2dozotPi8wQhmkZMKt1U9T6Msq3I4oGZaMYE8WNh9o/OzSXtE4Nr3IKHJlImTo2O4x0trGiCiHyxcd78xx4eXfjqeV/y60tNB8X/6ikEMS2r/npIHIkrA8+5L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610387; c=relaxed/simple;
	bh=Qsi02siLXY2xD7L3Q/ZH6zuzGk1H0uP3f8Hi9fePKQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJUjYmP58pkE4SdUQN4Hi8UA4NEuPfLj3SxFZwoQSTv6I/G5EdvL5X2Buf7bCGTmQ/OS2lLoRZK+RWDPAnXc6WKbZVFj2k3WQZ4jsfjr+qOGUAdhQgGKG3YAwCqiIBNXHJFCCIsbeAbEmnP8UFg8ASQaSKhh0NPzbSYm/Byiixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436524|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00519877-0.000484684-0.994317;FP=894385746466251946|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.ilCFYUc_1786610374;
Received: from 172.18.22.44(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ilCFYUc_1786610374 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 13 Aug 2026 16:39:34 +0800
Message-ID: <ed2d7189-5fac-4e99-9d37-69d25d663209@open-hieco.net>
Date: Thu, 13 Aug 2026 16:39:34 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] KVM: nSVM: Track hardware-provided instruction
 bytes
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1785411877.git.zhang_wei@open-hieco.net>
 <0d1e1110881aada32e474c74105f3d4cc5ba991e.1785411877.git.zhang_wei@open-hieco.net>
 <20260730123403.96BA11F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <20260730123403.96BA11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/2026 8:34 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The patch clears instruction bytes only on nested VMRUN, causing stale DecodeAssist data from L0-handled exits to be falsely flagged as fresh during subsequent intercepts.
> - [High] Hardware-provided DecodeAssist data and the fresh flag are lost across live migration for a pending nested #PF.
> --
> 
> --- Patch [3]: [PATCH v3 3/9] KVM: nSVM: Track hardware-provided instruction bytes ---
> commit e944fdb4c1650228b5e210eab6c8b6fe2761112a
> Author: Tina Zhang <zhang_wei@open-hieco.net>
> 
> KVM: nSVM: Track hardware-provided instruction bytes
>      
> DecodeAssists provides instruction bytes for nested page faults and
> intercepted page faults caused by data accesses.  When reflecting such an
> exit to L1, KVM needs to distinguish bytes produced by the current hardware
> VM-Exit from stale VMCB02 state.
> 
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index b63234a2feb8d..6e2ceb700567c 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
> 
> [ ... ]
> 
>> @@ -1953,14 +1953,20 @@ static void svm_set_dr7(struct kvm_vcpu *vcpu, unsigned long value)
>>   static int pf_interception(struct kvm_vcpu *vcpu)
>>   {
>>   	struct vcpu_svm *svm = to_svm(vcpu);
>> -
>>   	u64 fault_address = svm->vmcb->control.exit_info_2;
>>   	u64 error_code = svm->vmcb->control.exit_info_1;
>> +	int r;
>> +
>> +	r = kvm_handle_page_fault(vcpu, error_code, fault_address,
>> +				  static_cpu_has(X86_FEATURE_DECODEASSISTS) ?
>> +				  svm->vmcb->control.insn_bytes : NULL,
>> +				  svm->vmcb->control.insn_len);
>>   
>> -	return kvm_handle_page_fault(vcpu, error_code, fault_address,
>> -			static_cpu_has(X86_FEATURE_DECODEASSISTS) ?
>> -			svm->vmcb->control.insn_bytes : NULL,
>> -			svm->vmcb->control.insn_len);
>> +	if (is_guest_mode(vcpu) && vcpu->arch.exception_vmexit.pending &&
>> +	    vcpu->arch.exception_vmexit.vector == PF_VECTOR)
>> +		svm->nested.vmcb02_insn_bytes_fresh = true;
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: High]
> Does this unconditionally mark the instruction bytes as fresh for any PF_VECTOR,
> including instruction fetches where DecodeAssist is inactive?
> 
> If so, could this result in stale bytes from a previous hardware VM-Exit
> being incorrectly synthesized to the L1 hypervisor?

The fresh flag is not sufficient by itself to copy VMCB02 instruction
bytes.  Patch 4/9 also requires the current trusted VMCB02 exit to be a
data #PF or #NPF.  Instruction-fetch faults and unrelated exits, such as
MSR exits, therefore leave VMCB12's instruction-byte state cleared.

> 
>> +
>> +	return r;
>>   }
> 
> [ ... ]
> 
>> @@ -3725,7 +3731,7 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>>   		vmexit = nested_svm_exit_special(svm);
>>   
>>   		if (vmexit == NESTED_EXIT_CONTINUE)
>> -			vmexit = nested_svm_exit_handled(svm);
>> +			vmexit = nested_svm_exit_handled(svm, true);
>                                                                ^^^^
> 
> [Severity: High]
> By passing true here for all NESTED_EXIT_CONTINUE VM-exits, does this
> incorrectly flag stale bytes as fresh for exits where DecodeAssist is
> not active?
> 
> For example, if L2 causes a data #PF handled by L0 (which writes insn_bytes)
> and is resumed without clearing the instruction bytes, and then L2 causes a
> different exit intercepted by L1 (like an MSR intercept), will this pass the
> stale instruction bytes to L1 as fresh?

No. The true argument to nested_svm_exit_handled() is consumed only when 
the current hardware exit is reflected to L1, and the flag is cleared 
while constructing VMCB12. Exits handled by L0 do not retain the flag.

> 
>>   
>>   		if (vmexit == NESTED_EXIT_DONE)
>>   			return 1;
> 
> [ ... ]
> 
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index a327bf751ecd5..96d2471a03c8c 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -242,6 +242,12 @@ struct svm_nested_state {
>>   	 * on its side.
>>   	 */
>>   	bool force_msr_bitmap_recalc;
>> +
>> +	/*
>> +	 * True if VMCB02 contains DecodeAssist instruction bytes from the
>> +	 * hardware VM-Exit currently being reflected to L1.
>> +	 */
>> +	bool vmcb02_insn_bytes_fresh;
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: High]
> Will this tracking state be lost across live migration?
> 
> Since it appears this flag is added to the nested state structure but omitted
> from KVM_GET_NESTED_STATE serialization, if a migration occurs while a nested
> exit is pending, won't the target host fail to receive the instruction bytes
> and potentially cause emulation failure in L1?

The flag is intentionally not migrated.  It describes hardware state
produced by a VM-Exit on the current host, which is no longer valid on
the destination.  A migrated pending #PF is restored without hardware
provenance and uses the on-demand instruction-fetch fallback added later
in the series.  Restoring the flag alone would incorrectly mark the
destination's VMCB02 contents as fresh.

Thanks,
Tina

> 
>>   };
> 

