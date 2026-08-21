Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1833AA1B8
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298466; cv=none; b=ii+WloP25idClp4nMzb9uoDajv8Cyj9eLIohuFVxw4uNibvu5+P5dt2RPagkpeVh8pZDX7eX1D2STzMP4f+gN20FVNvMLWhx3I6dNWGJoyOJQ6gL+HYyNpZGNI+95h56Z1o7mKqMuRCxZEN0S219Cd95PCJyfLAxUS6I3knvgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298466; c=relaxed/simple;
	bh=Zi5R2I5UAYX+fsoUkIVa9NBn8FTTRIoq4MvBsIyG0Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtp8VWIo9EeniqA5+5Ozxqsj1mM6mlTFUeMQWC2F0S8C1OX/q74bQACLZbKNi/05P+SozOlxkedRp5eQ4UEMEaOvKfhwq9Rh8WZhxuOfufcKWXCZzc5MgT0kkBYFNBZeFxf/R4w1WLKgMLGSLy++8FKlNsGmbKWaZ3pyN+0YAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07447188|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0440328-0.00210898-0.953858;FP=16672676638240638714|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033022149254;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.itFL-0t_1787298458;
Received: from 172.18.22.44(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.itFL-0t_1787298458 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 21 Aug 2026 15:47:38 +0800
Message-ID: <b7210521-03a9-47c8-9bb4-997b38a19c4b@open-hieco.net>
Date: Fri, 21 Aug 2026 15:47:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] KVM: nSVM: Propagate hardware DecodeAssist bytes
 to VMCB12
To: Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>
Cc: kvm@vger.kernel.org
References: <cover.1787116250.git.zhang_wei@open-hieco.net>
 <79b5372fbfa85642af81b34f219c30cad45b3728.1787116250.git.zhang_wei@open-hieco.net>
 <20260819061116.7A9FC1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <20260819061116.7A9FC1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/2026 2:11 PM, sashiko-bot@kernel.org wrote:
> 
>> +static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
>> +						struct vmcb *vmcb12,
>> +						const struct vmcb *vmcb02)
>> +{
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +
>> +	nested_svm_clear_insn_bytes(vmcb12);
>> +
>> +	if (!nested_svm_vmexit_supports_insn_bytes(vcpu, vmcb02))
>> +		goto out;
>> +
>> +	if (svm->nested.vmcb02_insn_bytes_fresh)
>> +		nested_svm_copy_insn_bytes(vmcb12, vmcb02);
> 
> [Severity: High]
> If a live migration occurs while KVM has a pending hardware #PF VM-exit
> (where exception_vmexit.pending = true and vmcb02_insn_bytes_fresh = true),
> how does the destination hypervisor know to restore this state?
> 
> It appears svm_get_nested_state() and svm_set_nested_state() aren't updated
> to serialize vmcb02_insn_bytes_fresh or the hardware insn_bytes. Could this
> cause the destination hypervisor to inject a #PF into VMCB12 with an
> insn_len of 0, effectively losing the instruction bytes?
> 
> Additionally, if userspace calls KVM_SET_VCPU_EVENTS to clear a pending
> exception:
> 
> arch/x86/kvm/x86.c:kvm_vcpu_ioctl_x86_set_vcpu_events() {
>      ...
>      vcpu->arch.exception_vmexit.pending = false;
>      ...
> }
> 
> The vmcb02_insn_bytes_fresh flag is not cleared alongside it. Could a
> subsequent emulator-generated #PF then incorrectly copy these stale
> instruction bytes into VMCB12?

Hi Sean and Jim,

Before posting v5, I'd like to get your opinion on how to track the
instruction-byte source for a delayed nested #PF VM-Exit.

A hardware #PF may first be handled by KVM and then queued for 
reflection to L1.  When constructing the nested VM-Exit later, nSVM 
needs to know whether the queued #PF still corresponds to the 
DecodeAssist bytes in VMCB02.  Similarly, an emulator-originated #PF 
needs to retain that provenance so that KVM uses the emulator fetch 
cache only for the exception that actually came from that emulator context.

Keeping this information as independent state in svm_nested_state is 
fragile.  For example, userspace may clear or replace the pending 
exception, leaving the SVM state associated with an event that no longer 
exists.  In v5, I am therefore associating the provenance with the 
queued exception itself.  Userspace-restored exceptions have neither 
hardware nor emulator provenance and use the on-demand fetch fallback.

The part I am unsure about is how this should be represented.  The 
minimal implementation adds:

           bool has_emulator_context;
           bool has_hardware_pf_state;

to struct kvm_queued_exception.  However, these fields are meaningful 
only for vcpu->arch.exception_vmexit, while the same structure is also 
used for the normal vcpu->arch.exception queue.

An alternative would be to introduce a wrapper, for example:

           struct kvm_exception_vmexit {
                   struct kvm_queued_exception exception;
                   bool has_emulator_context;
                   bool has_hardware_pf_state;
           };

This keeps the VM-Exit provenance out of the normal exception structure, 
but requires mechanical change to the generic x86 and VMX references to
exception_vmexit.

Do you have a preference between these approaches, or is there another 
way you would recommend representing this state?


Thanks,
Tina


