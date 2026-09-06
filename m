Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADD225B0BB;
	Sun,  6 Sep 2026 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788676855; cv=none; b=Ma1bLU96YWPAXo619JC5rlg/LKx0rJ8mKMSmy2UwUBR8ocAhmgBvixXirjCfcRntCvo9qBWV+Zdt6/Rvf1Jccc14vFqjAZoG9Stqkr6nQPklrrI+hGSKcTwznYaVEWOd75tJzVlN1QkUVTgBx53leni63SVB46eD1ywz0eQ8v+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788676855; c=relaxed/simple;
	bh=Snb5/FaN46hD/PM5DHcgM7tt4eYUGrFqrqcAS0Y4TCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f884UBjp8i3HjgWSbUW9KJTsc5GP3t9pDxcfL9u+K+0zQ5EkvRq/R1dyRGZWb6aEGUk5Trg9LCmP4r5qscPkEMNMsqFZjEF5gvL4QYz89x0TyKARZ5iB8FZ3Xsqu2RV9uE0ZyFk+Zbu3ZHNrYd0rnWKlGzX/S5ulPGRurjUuOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07460938|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0828489-0.0034155-0.913736;FP=16963791342999162875|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.j6lysWb_1788676841;
Received: from 192.168.1.4(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.j6lysWb_1788676841 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 06 Sep 2026 14:40:42 +0800
Message-ID: <f187e4d1-9d31-4e54-a75b-b724ed5d0e9a@open-hieco.net>
Date: Sun, 6 Sep 2026 14:40:39 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] KVM: nSVM: Fetch missing DecodeAssist bytes for
 synthesized #NPF/#PF
To: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260824123954.315112-1-zhang_wei@open-hieco.net>
 <20260824123954.315112-7-zhang_wei@open-hieco.net>
 <CALMp9eSoLMx6DLH=Ve5_r7y=0EOmxjZgJWE_fLM_CAYxOvJdkA@mail.gmail.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <CALMp9eSoLMx6DLH=Ve5_r7y=0EOmxjZgJWE_fLM_CAYxOvJdkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/5/2026 8:39 AM, Jim Mattson wrote:
> On Mon, Aug 24, 2026 at 5:40 AM Tina Zhang <zhang_wei@open-hieco.net> wrote:
>>
>> For a synthesized #NPF, the emulator fetch cache is not guaranteed to
>> contain the full architected 15-byte DecodeAssist window, e.g. it may
>> contain only the bytes needed to decode the instruction.
>>
>> Keep preparation of synthesized state limited to capturing a matching
>> emulator fetch cache for #NPF.  When constructing VMCB12, copy those bytes
>> and fetch any missing tail through L2 guest page tables.  If no emulator
>> bytes are available, fetch the full window from L2 RIP, including for a
>> queued or synthesized #PF VM-Exit.  Stop at a translation fault, read
>> failure, non-canonical address, or CS limit overrun.
>>
>> For a non-64-bit L2, truncate each incremented linear address to 32 bits
>> so that a fetch whose CS.base makes it cross the 4GB boundary wraps as
>> required.
>>
>> Do not perform tail or fallback reads for SEV guests.  KVM cannot read
>> plaintext instruction bytes from encrypted guest memory, and the existing
>> SEV emulation path treats missing hardware DecodeAssist bytes as
>> unavailable instead of decoding guest memory.  For nested SEV, report only
>> matching emulator bytes already captured for a synthesized #NPF,
>> potentially a zero instruction-byte count.
>>
>> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
>> ---
>>   arch/x86/kvm/svm/nested.c | 58 ++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index 635ff20cc431..c677ad5df8d6 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -87,6 +87,54 @@ static void nested_svm_clear_synthesized_insn_bytes(struct vcpu_svm *svm)
>>          svm->nested.synthesized_insn_bytes.insn_len = 0;
>>   }
>>
>> +static u8 nested_svm_fetch_insn_bytes(struct kvm_vcpu *vcpu, u8 *bytes,
>> +                                     u8 count, u8 max_bytes)
>> +{
>> +       struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
>> +       u64 access = PFERR_FETCH_MASK;
>> +       gva_t rip = kvm_get_linear_rip(vcpu);
>> +       struct x86_exception e;
>> +
>> +       if (kvm_x86_call(get_cpl)(vcpu) == 3)
>> +               access |= PFERR_USER_MASK;
>> +
>> +       if (!is_64_bit_mode(vcpu)) {
>> +               u32 eip = kvm_rip_read(vcpu);
>> +               u32 limit = to_svm(vcpu)->vmcb->save.cs.limit;
>> +
>> +               if (eip > limit)
>> +                       return 0;
>> +               max_bytes = min_t(u64, max_bytes, (u64)limit - eip + 1);
>> +       }
>> +
>> +       count = min(count, max_bytes);
> 
> Ugh. Pasting together two partial reads performed at different times
> is egregious. This function should read all 15 bytes in one go. That
> pretty much renders the emulator's fetch cache useless, except when it
> contains the necessary 15 bytes.

This patch was based on the discussion from the first version of this
series[1].  My understanding from that exchange was that preserving the
bytes used by the emulator and fetching the missing tail later was the
intended approach, as it retains the bytes actually used to decode the 
instruction.

Did I misunderstand the conclusion of that discussion?  If the 
preference is now to avoid combining reads performed at different times, 
I can change the next version to use the emulator fetch cache only when 
it contains the full 15-byte window, and otherwise fetch all 15 bytes in 
one operation.

[1] 
https://lore.kernel.org/kvm/20260629125205.52394-1-zhang_wei@open-hieco.net/T/#m3fa3f64ddd3284b312d3ddb44fd30a2e26708037


Thanks,
Tina
