Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059BB14ABE;
	Sun,  6 Sep 2026 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788662736; cv=none; b=W9D73S9jq2VLs57TCftQqfcP8lVNN/s37HkrXCBayHZDds2Q0xPH+7SbHkZH94/jVPVRlNIH7Vl4L5MOjW8JV7/l986WtR4Thak3ZcIvvFyvyvebCA0XeOznfhcVZZOxWsQgo71Kqk+/nwczCi5IsGlr+SzbhMaAvP51ogt8ba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788662736; c=relaxed/simple;
	bh=MtSQk/okHkcSdRva2nRzbLImT99Tt4JP/UbLq2pgdos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0hpYIfM5JYKf8/mI3MXnOCtQjVhgz8JqT8pLtBrPmuaWGfs1dTnLl8rWyF8AlrU6d+X2+ZGAUOCVOUSnDDoIVZxYDz+d6PBFB3X/fqpn+QnYOkoTX8NmLt0KdYB8J3BGea1iTzsozSaBD3HwgkcRSCa9wqdYPrgRHEs8JyWR8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07916929|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00797682-0.00203275-0.98999;FP=12673810057201397720|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.j6fQ5R4_1788662710;
Received: from 192.168.1.4(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.j6fQ5R4_1788662710 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 06 Sep 2026 10:45:11 +0800
Message-ID: <669bffc9-ad08-491b-a55c-86889f4e3f11@open-hieco.net>
Date: Sun, 6 Sep 2026 10:45:08 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] KVM: nSVM: Propagate hardware DecodeAssist bytes
 to VMCB12
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260824123954.315112-1-zhang_wei@open-hieco.net>
 <20260824123954.315112-5-zhang_wei@open-hieco.net>
 <CALMp9eR=TNUqfbNCFkxmg=O_Obcj11Tu9jAmX6Pe60qvvNx-2g@mail.gmail.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <CALMp9eR=TNUqfbNCFkxmg=O_Obcj11Tu9jAmX6Pe60qvvNx-2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/5/2026 7:58 AM, Jim Mattson wrote:
> On Mon, Aug 24, 2026 at 5:40 AM Tina Zhang <zhang_wei@open-hieco.net> wrote:
>>
>> +static void nested_svm_copy_insn_bytes(struct vmcb *to,
>> +                                      const struct vmcb *from)
>> +{
>> +       u8 insn_len = from->control.insn_len;
>> +
>> +       nested_svm_clear_insn_bytes(to);
> 
> It's not obvious to me that this clearing is necessary (except in the
> case of the early return below). The APM does not say what happens to
> the remaining bytes if there is a short read.

You're right.  I had interpreted the APM as requiring the entire Guest 
Instruction Bytes field to be cleared when rebuilding the state, but 
that was too broad.  For a short read, the remaining bytes are not 
defined and do not need to be cleared.  Thanks for correcting my 
understanding.


>> +static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
>> +                                               struct vmcb *vmcb12,
>> +                                               const struct vmcb *vmcb02)
>> +{
>> +       struct vcpu_svm *svm = to_svm(vcpu);
>> +
>> +       nested_svm_clear_insn_bytes(vmcb12);
> 
> Clearing here is premature. If L1 does not have
> X86_FEATURE_DECODEASSISTS, the "Guest Instruction Bytes" fields of
> vmcs12 should not be touched.

Agreed.

> 
> Moreover, as I pointed out earlier, if L1 has
> X86_FEATURE_DECODEASSISTS, and the VM-exit doesn't have instruction
> bytes, you onlyhave to clear bits 7:0.

Yes. I'll update it in the next version.


Thanks,
Tina

