Received: from out198-16.us.a.mail.aliyun.com (out198-16.us.a.mail.aliyun.com [47.90.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD804F4049;
	Tue, 13 Oct 2026 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893356; cv=none; b=GRKzFt+RP51eF1PuwieLBnbsRcEpxU2kKGOuRF7Opio30w+kNxbzBi6uHQvkmAv5OFsc9q0WChsRfyBgxQB70VIMFByHdj9gkS4ZRr4Aqsd0USe1bawU+xT90PUSxQPvUc2j2lGSrWgyUKz6yH4XNpZJ9UlahEGRT3ufK8hGEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893356; c=relaxed/simple;
	bh=ROiKLXqDYhrdx/iTvQZsMK9a+5YuHdYtfWEAENxEokA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DPjkcZsjBbBWPDYLIxZytv5Win4Vo7O+So6xlrzmU9UFjnn9szR+6gcWbnE82m/p20R3c/6SYcoGoXpa5CcSJXXBllPNmfsVA5asIio5oHK2pvKblS/n4mTpF8tR7nAXnZYoucYj0grxlbLhOObJqClq3XKkTvKI+ELAyIk92Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07450271|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0451682-0.000236139-0.954596;FP=14656963097697938684|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jbYjB7F_1791892389;
Received: from 192.168.0.103(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jbYjB7F_1791892389 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 19:53:10 +0800
Message-ID: <d0d23c2b-493a-40f2-839e-45d8e1d9d833@open-hieco.net>
Date: Tue, 13 Oct 2026 19:53:07 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/8] KVM: nSVM: Fetch DecodeAssist bytes for
 synthesized faults
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1790171702.git.zhang_wei@open-hieco.net>
 <b614e927c6c1ce9265cb9a37b296b0b30598da72.1790171702.git.zhang_wei@open-hieco.net>
 <CALMp9eT1qMk7V7=md68LEXvmWH5ecj1YBn-YHoQ-vzJziaP5VA@mail.gmail.com>
 <ec1fb2e5-87c5-443f-9bd6-6983b96f63d7@open-hieco.net>
Content-Language: en-US
In-Reply-To: <ec1fb2e5-87c5-443f-9bd6-6983b96f63d7@open-hieco.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sean,

Just a gentle ping on this. I'd appreciate your thoughts when you have a 
chance.

Thanks,
Tina

On 9/30/2026 8:24 PM, Tina Zhang wrote:
> 
> 
> On 9/24/2026 6:20 AM, Jim Mattson wrote:
>> I hadn't anticipated the need for this special-case, and it's more
>> intrusive than just returning the number of bytes read.
>>
>> I see now that it's complicated to match the behavior of the
>> emulator's __do_insn_fetch_bytes(). You could clamp the number of
>> bytes to read up-front to deal with the end of the address space, but
>> you would still need a second call to handle the wrap.  Something like
>> the following (mangled by my MUA):
>>
>> static unsigned int __kvm_fetch_guest_virt(struct kvm_vcpu *vcpu, 
>> gva_t addr,
>>    void *val, unsigned int bytes)
>> {
>> struct x86_exception exception = {};
>> unsigned int bytes_read;
>> u64 access = PFERR_FETCH_MASK;
>>
>> if (kvm_x86_call(get_cpl)(vcpu) == 3)
>> access |= PFERR_USER_MASK;
>>
>> kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
>>    &exception, &bytes_read);
>> return bytes_read;
>> }
>>
>> unsigned int kvm_fetch_guest_virt(struct kvm_vcpu *vcpu, gva_t addr,
>>   void *val, unsigned int bytes)
>> {
>> unsigned int first, bytes_read;
>> bool wraps;
>> u64 avail;
>>
>> /* An instruction-sized fetch can wrap at most once. */
>> if (WARN_ON_ONCE(bytes > X86_MAX_INSTRUCTION_LENGTH))
>> return 0;
>>
>> if (!is_64_bit_mode(vcpu)) {
>> addr = (u32)addr;
>> avail = BIT_ULL(32) - addr;
>> wraps = true;
>> } else if (is_noncanonical_address(addr, vcpu, 0)) {
>> return 0;
>> } else if (addr < BIT_ULL(63)) {
>> avail = BIT_ULL(vcpu_virt_addr_bits(vcpu) - 1) - addr;
>> wraps = false;
>> } else {
>> avail = -addr;
>> wraps = true;
>> }
>>
>> first = min_t(u64, bytes, avail);
>> bytes_read = __kvm_fetch_guest_virt(vcpu, addr, val, first);
>>
>> if (wraps && bytes_read == first && first < bytes)
>> bytes_read += __kvm_fetch_guest_virt(vcpu, 0, val + first,
>>      bytes - first);
>>
>> return bytes_read;
>> }
>>
>> I think this solution may be worse than what you have now, but I will
>> defer to Sean. Maybe he will have a better idea. (Maybe my suggestion
>> to return the number of bytes read was misguided.)
>>
>> Reviewed-by: Jim Mattson<jmattson@google.com>
>>
> Thanks, Jim, for the suggestion and review.
> 
> Hi Sean, what do you think?
> 
> Thanks,
> Tina

