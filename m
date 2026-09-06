Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9CF2AE8D;
	Sun,  6 Sep 2026 05:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788672830; cv=none; b=CouSVY6EwbKdRh/2+YusLBM8AXnoVNjrsz/pf7tyQZqO5EqoWnYS+ujOO1Mv0nm/3PdbIKBPNqF0lEwBrM7qIyPrGIzJdy5w9JtbZTT2Vewabz3CxBqeYhXPx9B3FIfQpoq6zv8d3ZwHDljMh1QGmPwk85uakFMRJg2T9ap/AQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788672830; c=relaxed/simple;
	bh=2J4wQKKxlO+dq75nnPw587K136N72yT4/Dfycc3xYcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIK3e9w1MzJyuIvkei2Lk9cFNJcAYtpLKfbynFJ2bZFgF/IwwsVqTZIkxe6jzmIWQTUN2UEA413KtkjN5/2L1/Chgr9hvIDuNpLvBGSw3Zllz5aVTs8xIH0xsTozsJm0PsFwba9t6IoBYvnpR2mYSZ7DiZFoioTB/Y9pmHMUQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743662|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0101103-0.00204923-0.987841;FP=18042175575523805177|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.j6nnJ-v_1788672821;
Received: from 192.168.1.4(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.j6nnJ-v_1788672821 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 06 Sep 2026 13:33:42 +0800
Message-ID: <98f04f68-f5af-49d6-850d-81db77500d63@open-hieco.net>
Date: Sun, 6 Sep 2026 13:33:40 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] KVM: nSVM: Use emulator bytes for synthesized
 nested #NPF
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260824123954.315112-1-zhang_wei@open-hieco.net>
 <20260824123954.315112-6-zhang_wei@open-hieco.net>
 <CALMp9eQFtNihRpkxDTs05UnfLgYJOHR7AsTLWi9FGjpNDq_kBA@mail.gmail.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <CALMp9eQFtNihRpkxDTs05UnfLgYJOHR7AsTLWi9FGjpNDq_kBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/5/2026 8:17 AM, Jim Mattson wrote:
> On Mon, Aug 24, 2026 at 5:40 AM Tina Zhang <zhang_wei@open-hieco.net> wrote:
>> +
>> +static void nested_svm_prepare_synthesized_insn_bytes(struct kvm_vcpu *vcpu)
>> +{
>> +       struct vcpu_svm *svm = to_svm(vcpu);
>> +       struct nested_svm_insn_bytes *synthesized =
>> +               &svm->nested.synthesized_insn_bytes;
>> +       struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
>> +
>> +       static_assert(sizeof(synthesized->insn_bytes) >=
>> +                     sizeof(ctxt->fetch.data));
>> +
>> +       nested_svm_clear_synthesized_insn_bytes(svm);
>> +
>> +       if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
>> +               return;
>> +
>> +       if (!ctxt || ctxt->eip != kvm_rip_read(vcpu) ||
>> +           ctxt->fetch.end < ctxt->fetch.data ||
>> +           ctxt->fetch.end > ctxt->fetch.data + sizeof(ctxt->fetch.data))
>> +               return;
> 
> Peeking into emulator internals violates encapsulation. Rather than
> performing arithmetic on fetch.data and fetch.end, the emulator should
> provide a function for accessing the fetch cache.

Agreed. I will add an emulator helper for this.

> 
>> +       synthesized->insn_len = ctxt->fetch.end - ctxt->fetch.data;
>> +       memcpy(synthesized->insn_bytes, ctxt->fetch.data,
>> +              synthesized->insn_len);
>> +       synthesized->prepared = true;
>> +}
>> +
>>   static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
>>                                                  struct vmcb *vmcb12,
>>                                                  const struct vmcb *vmcb02)
>>   {
>>          struct vcpu_svm *svm = to_svm(vcpu);
>> +       struct nested_svm_insn_bytes *synthesized =
>> +               &svm->nested.synthesized_insn_bytes;
>>
>>          nested_svm_clear_insn_bytes(vmcb12);
>>
>> @@ -93,11 +127,20 @@ static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
>>              !nested_svm_vmexit_has_insn_bytes(vmcb02))
>>                  goto out;
>>
>> -       if (svm->nested.vmcb02_insn_bytes_fresh)
>> +       if (svm->nested.vmcb02_insn_bytes_fresh) {
>>                  nested_svm_copy_insn_bytes(vmcb12, vmcb02);
>> +               goto out;
>> +       }
>> +
>> +       if (synthesized->prepared) {
>> +               vmcb12->control.insn_len = synthesized->insn_len;
>> +               memcpy(vmcb12->control.insn_bytes, synthesized->insn_bytes,
>> +                      vmcb12->control.insn_len);
> 
> These instruction bytes may be short. Although this is fixed in the
> next commit, introducing a bug in one patch and fixing it in the next
> is bad practice.

DecodeAssists is advertised to L1 only later in the series, so this path 
is not normally active at this point.  That said, I agree that each
patch should be self-contained and provide complete behavior.

I will reorder and split the changes.

>>   struct svm_nested_state {
>>          struct kvm_vmcb_info vmcb02;
>>          u64 hsave_msr;
>> @@ -245,6 +251,12 @@ struct svm_nested_state {
>>
>>          /* True if VMCB02 has instruction bytes from the current hardware exit. */
>>          bool vmcb02_insn_bytes_fresh;
>> +
>> +       /*
>> +        * Cached instruction bytes for the current synthesized nested #NPF.
>> +        * Valid until the corresponding nested VM-Exit is constructed.
>> +        */
>> +       struct nested_svm_insn_bytes synthesized_insn_bytes;
>>   };
> 
> I think the implementatiom would be much cleaner if you wrote the
> synthesized instruction bytes directly to the vmcb02, rather than
> going through this staging buffer.
Sounds good. I'll remove the staging buffer and write the synthesized 
instruction bytes directly to VMCB02 in the next version.


Thanks,
Tina
