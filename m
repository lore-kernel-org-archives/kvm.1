Received: from out198-23.us.a.mail.aliyun.com (out198-23.us.a.mail.aliyun.com [47.90.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD32F3624DB;
	Wed, 30 Sep 2026 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771094; cv=none; b=BjNWHxXn0tdyfWZ76ntdN+7zD2myZrGLQDhkANQDMmBH3id+HBsWoVGY+cuyMpUGqovWmaf3nBEFhgB6LwxEbkEviH/u80ts6LRPSKk+6+bgAYSWHjtMIXVMb/cH4bcGSxVosc7Kgv9O7Ut1CGItn16rX/7vPO8BhBzpmDIS0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771094; c=relaxed/simple;
	bh=oOx89ZkTYto6hTf/g/P9vzE9FciTS9IGNHzImGjKszE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1Xc9rj7RPkAT0azWFAh4vi4BoK6UVh8BkocTe8726weWA5et1X1aoc0Yf65VnI2YyW48tJoSoMNsGfEA0fjCcUNR6TSSFUUPrVD8iI+pmj37HQxRe1RWy3VZyElIG354SvgCm+HQVmqQSbQyaFhut64Ke1r88qeKRvBD4W7gOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07469621|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0552072-0.000323851-0.944469;FP=14945158427218365692|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jSMK3gv_1790771069;
Received: from 192.168.0.110(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jSMK3gv_1790771069 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 30 Sep 2026 20:24:30 +0800
Message-ID: <ec1fb2e5-87c5-443f-9bd6-6983b96f63d7@open-hieco.net>
Date: Wed, 30 Sep 2026 20:24:28 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/8] KVM: nSVM: Fetch DecodeAssist bytes for
 synthesized faults
To: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1790171702.git.zhang_wei@open-hieco.net>
 <b614e927c6c1ce9265cb9a37b296b0b30598da72.1790171702.git.zhang_wei@open-hieco.net>
 <CALMp9eT1qMk7V7=md68LEXvmWH5ecj1YBn-YHoQ-vzJziaP5VA@mail.gmail.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <CALMp9eT1qMk7V7=md68LEXvmWH5ecj1YBn-YHoQ-vzJziaP5VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/24/2026 6:20 AM, Jim Mattson wrote:
> I hadn't anticipated the need for this special-case, and it's more
> intrusive than just returning the number of bytes read.
> 
> I see now that it's complicated to match the behavior of the
> emulator's __do_insn_fetch_bytes(). You could clamp the number of
> bytes to read up-front to deal with the end of the address space, but
> you would still need a second call to handle the wrap.  Something like
> the following (mangled by my MUA):
> 
> static unsigned int __kvm_fetch_guest_virt(struct kvm_vcpu *vcpu, gva_t addr,
>    void *val, unsigned int bytes)
> {
> struct x86_exception exception = {};
> unsigned int bytes_read;
> u64 access = PFERR_FETCH_MASK;
> 
> if (kvm_x86_call(get_cpl)(vcpu) == 3)
> access |= PFERR_USER_MASK;
> 
> kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
>    &exception, &bytes_read);
> return bytes_read;
> }
> 
> unsigned int kvm_fetch_guest_virt(struct kvm_vcpu *vcpu, gva_t addr,
>   void *val, unsigned int bytes)
> {
> unsigned int first, bytes_read;
> bool wraps;
> u64 avail;
> 
> /* An instruction-sized fetch can wrap at most once. */
> if (WARN_ON_ONCE(bytes > X86_MAX_INSTRUCTION_LENGTH))
> return 0;
> 
> if (!is_64_bit_mode(vcpu)) {
> addr = (u32)addr;
> avail = BIT_ULL(32) - addr;
> wraps = true;
> } else if (is_noncanonical_address(addr, vcpu, 0)) {
> return 0;
> } else if (addr < BIT_ULL(63)) {
> avail = BIT_ULL(vcpu_virt_addr_bits(vcpu) - 1) - addr;
> wraps = false;
> } else {
> avail = -addr;
> wraps = true;
> }
> 
> first = min_t(u64, bytes, avail);
> bytes_read = __kvm_fetch_guest_virt(vcpu, addr, val, first);
> 
> if (wraps && bytes_read == first && first < bytes)
> bytes_read += __kvm_fetch_guest_virt(vcpu, 0, val + first,
>      bytes - first);
> 
> return bytes_read;
> }
> 
> I think this solution may be worse than what you have now, but I will
> defer to Sean. Maybe he will have a better idea. (Maybe my suggestion
> to return the number of bytes read was misguided.)
> 
> Reviewed-by: Jim Mattson<jmattson@google.com>
> 
Thanks, Jim, for the suggestion and review.

Hi Sean, what do you think?

Thanks,
Tina
