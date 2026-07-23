Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04304582E2
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807117; cv=none; b=EJHrLtEF60hdtHYx2Y1sT+piHta1owHFK+oML+mhI/+/8tEmmDfFYxOG353ohkYCu68aw2o2BY+OGx8UW0oVm0wgMwyzrRRDZN2q97HvKFuv3G9E+QA1ePfTDW0NI36pwLRKkFO1dZVgLwT5X0anocoDrtxKlr1RQxghE+L63tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807117; c=relaxed/simple;
	bh=8jXbHd4sO/iQSrOaTy8kF5yBMr1eJ9W8RsJ6Bqm4O9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ao/YF/bIVJascSLHI3EWJGcnLOSXlWoJiqG0aOhIMzipYgL4r+4adeKMP9Vn1Vf5Pi5kcX9XFjull6U0zfxzbzMSuuuhGve6y/D6XDo26ZdEf/LeviL9tR/hb3DpfDyZNZkjdDhP2BKBVpxYubwYykgfaJVypIDbSLlaDSTGsZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07439835|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00457515-0.000449034-0.994976;FP=1074476955468378043|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.iTBLTwZ_1784807107;
Received: from 172.19.20.218(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iTBLTwZ_1784807107 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 23 Jul 2026 19:45:08 +0800
Message-ID: <052181bc-372d-4ad1-8636-ed6b59eebbf2@open-hieco.net>
Date: Thu, 23 Jul 2026 19:45:06 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] KVM: nSVM: Track fresh VMCB02 DecodeAssist bytes
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1783999988.git.zhang_wei@open-hieco.net>
 <e07b2a62d7dedf6bcddc16076cf2892e83db977b.1783999988.git.zhang_wei@open-hieco.net>
 <20260714053040.6264F1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <20260714053040.6264F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Both concerns look valid.

I will rework the tracking to preserve the provenance of the VM-Exit
and instruction bytes explicitly in the next version.


Thanks,
Tina


On 7/14/2026 1:30 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] The patch fails to set `vmcb02_insn_bytes_fresh` to `true` when reflecting a host-intercepted Guest Page Fault (`#PF`) to L1, discarding hardware-provided DecodeAssist bytes.
> 
> Pre-existing issues:
> - [High] KVM incorrectly identifies synthesized nested page faults (NPFs) as hardware-generated if they occur during emulation of an original hardware NPF, passing a stale `exit_info_2` (GPA) to L1.
> --
> 
> --- Patch [3]: [PATCH v2 3/8] KVM: nSVM: Track fresh VMCB02 DecodeAssist bytes ---
> commit 1b65a65904c11af4f22d9f6d0ea2c488ec16575d
> Author: Tina Zhang <zhang_wei@open-hieco.net>
> 
> KVM: nSVM: Track fresh VMCB02 DecodeAssist bytes
> 
> Track whether VMCB02 contains DecodeAssist instruction bytes from the
> hardware VM-Exit currently being reflected to L1. Clear the fields before
> each nested run so stale bytes cannot be mistaken for fresh hardware state.
> 
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index b340dc9991adb..70e2ee3af78b2 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -33,13 +33,21 @@
>>   
>>   #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
>>   
>> +static void nested_svm_clear_insn_bytes(struct vmcb *vmcb)
>> +{
>> +	vmcb->control.insn_len = 0;
>> +	memset(vmcb->control.insn_bytes, 0,
>> +	       sizeof(vmcb->control.insn_bytes));
>> +}
>> +
>>   static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
>>   				       struct x86_exception *fault)
>>   {
>>   	struct vcpu_svm *svm = to_svm(vcpu);
>>   	struct vmcb *vmcb = svm->vmcb;
>> +	bool from_hardware = vmcb->control.exit_code == SVM_EXIT_NPF;
>>   
>> -	if (vmcb->control.exit_code != SVM_EXIT_NPF) {
>> +	if (!from_hardware) {
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does evaluating the original
> hardware exit code correctly identify emulator-synthesized nested page faults?
> 
> If an L2 guest accesses an unmapped MMIO region, it causes a hardware NPF.
> L0 intercepts it and starts emulation. If the emulator then performs a guest
> page table walk or instruction fetch which faults in the nested NPT, the
> emulator injects a new NPF to L1 by calling nested_svm_inject_npf_exit().
> 
> Because the VMCB exit code still contains the original hardware NPF exit code,
> this check evaluates to true. This causes KVM to skip updating the faulting
> GPA with the new faulting address, misleading the L1 hypervisor with the
> original MMIO GPA and incorrectly marking stale instruction bytes as fresh.
> 
> [ ... ]
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index 5137416be593d..fa65f6a1a59ba 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -238,6 +238,13 @@ struct svm_nested_state {
>>   	 * on its side.
>>   	 */
>>   	bool force_msr_bitmap_recalc;
>> +
>> +	/*
>> +	 * True if VMCB02's DecodeAssist instruction bytes belong to the hardware
>> +	 * VM-Exit currently being reflected to L1.  KVM-synthesized exits leave
>> +	 * it clear.
>> +	 */
>> +	bool vmcb02_insn_bytes_fresh;
> 
> [Severity: High]
> Does KVM need to set vmcb02_insn_bytes_fresh to true when reflecting a
> host-intercepted Guest Page Fault (#PF) to L1?
> 
> If L0 KVM intercepts a #PF from L2 (e.g., for shadow paging or async PF),
> it processes the fault and later queues it for reflection to L1 if L1 also
> intercepts it. KVM synthesizes the exit via
> nested_svm_inject_exception_vmexit():
> 
> arch/x86/kvm/svm/nested.c:nested_svm_inject_exception_vmexit() {
> 	...
> 	vmcb->control.exit_code = SVM_EXIT_EXCP_BASE + ex->vector;
> 	...
> }
> 
> However, this path fails to set vmcb02_insn_bytes_fresh to true. Since the
> flag defaults to false when entering L2, it remains false, and any
> hardware-provided DecodeAssist bytes for the #PF are discarded. This could
> break instruction decoding and emulation logic in the L1 hypervisor.
> 
>>   };
>>   
>>   struct vcpu_sev_es_state {
> 

