Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF30C383980;
	Sat,  5 Sep 2026 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616992; cv=none; b=V338JUJYAmLGwrZ+99J9xP7gzbxPhs5oO/3OLO1Q1H/KYR0nRxr+RGKGq3+ZcI7rp58SWOvN+NfzIdR5AqYP1RPee/qXUv2enKt8qHWKnMMqYj3KmBwXetarzXFC+fC7TysMRBCF6QkpCW1QERcej+teCitev+ua947N1WsZUns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616992; c=relaxed/simple;
	bh=cynATu6H8LPAyOX7rSQ7vzYVC4beIv65DY7wS3H1ifY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umeXGJMC67RC7ig+H2NcOVB4LD6K4+/ml8mL3mK9FNhHPrLj4KYpPv1zaZmiVNJ2w/o9W/VdOM89YQXutDougTT8SfJmGw7YoZYiew0+DrlCB08Udww82ayAzf9NHPe/FFsxDKIj+L3sH4FSnLsB6+/bRy1CvVSTe9LYHs9/BuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07438851|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00467713-0.00028342-0.995039;FP=11412257327081435002|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.j6PS1ef_1788616970;
Received: from 192.168.1.4(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.j6PS1ef_1788616970 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 05 Sep 2026 22:02:51 +0800
Message-ID: <aeb97d5c-d4aa-4b5c-aeae-dcc6aacfdf1b@open-hieco.net>
Date: Sat, 5 Sep 2026 22:02:50 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] KVM: nSVM: Track fresh hardware DecodeAssist bytes
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260824123954.315112-1-zhang_wei@open-hieco.net>
 <20260824123954.315112-4-zhang_wei@open-hieco.net>
 <CALMp9eTUv+4v3jT7w3T8XoQmoSwkEjx6LHr39oJ9k8QNiQnyUA@mail.gmail.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <CALMp9eTUv+4v3jT7w3T8XoQmoSwkEjx6LHr39oJ9k8QNiQnyUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/5/2026 7:42 AM, Jim Mattson wrote:
> On Mon, Aug 24, 2026 at 5:40 AM Tina Zhang <zhang_wei@open-hieco.net> wrote:
>>
>> VMCB02 instruction bytes are valid only for the hardware VM-Exit that
>> populated them.  Track whether VMCB02 contains instruction bytes for the
>> data #PF or #NPF currently being reflected to L1 so that stale bytes are
>> not copied to VMCB12.
>>
>> Clear the VMCB02 instruction-byte fields and freshness state before each
>> nested run.  Mark the bytes as fresh only when a data #PF or #NPF came
> 
> By "nested run," do you mean "emulated VMRUN"? IIUC, that's when the
> bytes and freshness are cleared.

Yes, I meant when KVM prepares VMCB02 after emulating L1's VMRUN. The 
same helper is also used when restoring nested state. I'll reword the 
commit message to make that clear.


>> +static void nested_svm_clear_insn_bytes(struct vmcb *vmcb)
>> +{
>> +       vmcb->control.insn_len = 0;
>> +       memset(vmcb->control.insn_bytes, 0,
>> +              sizeof(vmcb->control.insn_bytes));
>> +}
> 
> Is it necessary to clear the bytes? The APM says, "All other
> intercepts clear bits 7:0 in this field to zero (to indicate an
> invalid condition); implementations may leave the other bytes
> untouched."
> 
> Are you concerned about leaking bytes from unreflected VM-exits handled by L0?

No, clearing the entire byte array isn't necessary.  VMCB02 is private 
to L0, and insn_len determines whether the bytes are valid and how many
bytes may be copied to VMCB12.  Setting insn_len to zero is sufficient
and matches the behavior allowed by the APM. I'll drop the memset().


>> -int nested_svm_exit_handled(struct vcpu_svm *svm)
>> +int nested_svm_exit_handled(struct vcpu_svm *svm, bool from_hardware)
> 
> I don't think 'from_hardware' is necessary. The two callsites where
> from_hardware is false are for opcode exits, and will be ruled out by
> the check for nested_svm_vmexit_has_insn_bytes(svm->vmcb). If you drop
> this extra parameter, there will be less churn.

Agreed. Both non-hardware callsites set an opcode exit code before 
calling nested_svm_exit_handled(), so nested_svm_vmexit_has_insn_bytes() 
will reject them.  I'll drop the from_hardware parameter from 
nested_svm_exit_handled() and restore its callers.

Thanks,
Tina

