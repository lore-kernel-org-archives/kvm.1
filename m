Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C614419EED3
	for <kvm@vger.kernel.org>; Sat, 22 Aug 2026 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787362280; cv=none; b=dZ+fWIMXIMejeAnFnihZjIV1bbebsWm2I6XDGev5MBGRD9U21kR9TXhW/+S45oxVciv/rUkLIoVRtTNxlA8PH6Ferkkuufwe2L5IKCQJv1aSU1a3wPuDLH85gZelOA5ozOs/7+XFZWgJOiBBS69TizVtcEk9xNMmJskagFYMTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787362280; c=relaxed/simple;
	bh=vYPlDcMr5d2zpso1mXpdyR/xos1XLoiM8akov+R0LGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jg9iXCgVETw9gD/29sg335qMryDzKkBK/EKaN5T+1P0W4gf1hDsd/X2ZFZQyo1aPv6mRLAQQh+pvqiqW23nY5uR7fcGnaEHanFeJsOGmKXaHM26O9FwLJgp27/a5l18XZC7lJdWm5zuXOTSBXKCYEdTw9/SMEUD5UHBqlu/xy70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08151136|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.420044-0.0159197-0.564036;FP=14298356050519762662|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.itzFfVq_1787362271;
Received: from 192.168.1.4(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.itzFfVq_1787362271 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 22 Aug 2026 09:31:12 +0800
Message-ID: <c0fa6713-f428-466a-a847-905c6c079e0a@open-hieco.net>
Date: Sat, 22 Aug 2026 09:31:11 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] KVM: nSVM: Propagate hardware DecodeAssist bytes
 to VMCB12
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
References: <cover.1787116250.git.zhang_wei@open-hieco.net>
 <79b5372fbfa85642af81b34f219c30cad45b3728.1787116250.git.zhang_wei@open-hieco.net>
 <20260819061116.7A9FC1F00A3A@smtp.kernel.org>
 <b7210521-03a9-47c8-9bb4-997b38a19c4b@open-hieco.net>
 <CALMp9eQYD8BABDY5tAvYAVmYB0D5SPRZLmH4q4qV-kqNPby2Xg@mail.gmail.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <CALMp9eQYD8BABDY5tAvYAVmYB0D5SPRZLmH4q4qV-kqNPby2Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/22/2026 1:15 AM, Jim Mattson wrote:
> On Fri, Aug 21, 2026 at 12:47 AM Tina Zhang <zhang_wei@open-hieco.net> wrote:
>>
>> Hi Sean and Jim,
>>
>> Before posting v5, I'd like to get your opinion on how to track the
>> instruction-byte source for a delayed nested #PF VM-Exit.
>>
>> A hardware #PF may first be handled by KVM and then queued for
>> reflection to L1.  When constructing the nested VM-Exit later, nSVM
>> needs to know whether the queued #PF still corresponds to the
>> DecodeAssist bytes in VMCB02.  Similarly, an emulator-originated #PF
>> needs to retain that provenance so that KVM uses the emulator fetch
>> cache only for the exception that actually came from that emulator context.
>>
>> Keeping this information as independent state in svm_nested_state is
>> fragile.  For example, userspace may clear or replace the pending
>> exception, leaving the SVM state associated with an event that no longer
>> exists.  In v5, I am therefore associating the provenance with the
>> queued exception itself.  Userspace-restored exceptions have neither
>> hardware nor emulator provenance and use the on-demand fetch fallback.
>>
>> The part I am unsure about is how this should be represented.  The
>> minimal implementation adds:
>>
>>             bool has_emulator_context;
>>             bool has_hardware_pf_state;
>>
>> to struct kvm_queued_exception.  However, these fields are meaningful
>> only for vcpu->arch.exception_vmexit, while the same structure is also
>> used for the normal vcpu->arch.exception queue.
>>
>> An alternative would be to introduce a wrapper, for example:
>>
>>             struct kvm_exception_vmexit {
>>                     struct kvm_queued_exception exception;
>>                     bool has_emulator_context;
>>                     bool has_hardware_pf_state;
>>             };
>>
>> This keeps the VM-Exit provenance out of the normal exception structure,
>> but requires mechanical change to the generic x86 and VMX references to
>> exception_vmexit.
>>
>> Do you have a preference between these approaches, or is there another
>> way you would recommend representing this state?
> 
> Honestly, I would not even try to optimize #PF VM-exits. KVM only
> intercepts #PF when TDP is disabled. Since SVM-capable CPUs have
> always supported TDP, that's a bizarre configuration. I suspect it's
> equally bizarre for any other L1 hypervisor.
> 
> Can we just read the instruction bytes (using our slow fallback) when
> we synthesize a #PF VM-exit from L2 to L1?

Yes, that makes sense. I explored optimizing the #PF VM-Exit path, but 
the additional state tracking and complexity don't appear justified by 
the limited benefit. Given that this path is relevant mainly when TDP is 
disabled, the optimization also doesn't seem worth the ongoing 
maintenance cost.

I'll use the slow fallback to read the instruction bytes when KVM
synthesizes a #PF VM-Exit from L2 to L1, and drop the extra provenance
tracking.

Thanks,
Tina

