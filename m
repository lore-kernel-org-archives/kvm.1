Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272D334EF04
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611344; cv=none; b=YElz4NmbwKmjAvZVmLLcOZrcbjtQtEMXxhffqVboucX8DJej8klynHaUks8nEyCmXUdItZqjs8HKOKeGP4wHwfynadP4GIYJhFteWqJeKl/Mnw9VlyBoIWshlOH6t2BUoDH2khM57tApG8dGt2shekCGcFn3HjmTYMxfMLTh8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611344; c=relaxed/simple;
	bh=rGH4QNRzvvtaYg2m5ypZ7wRJdhkVYjUGq6arrKPEt70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2bldnOJGR5HPzVmBucZ7ogxXwjWpvl9F6Fg2ieMmnYp5VTvLu7G6eZP6RJYOljYgEUUHzPCloZCJJ8FiFoiSYcHX9InaiTUNXWMqJqou/XAFWR0Lu4FVp6AnPsbEz3jIbWWq7FmKbP64MCYlmIACy1NJYX/rNK2IPhU2yV0g6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09450802|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0628005-0.00236258-0.934837;FP=16889375159082665970|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.il9KI8t_1786611331;
Received: from 172.18.22.44(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.il9KI8t_1786611331 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 13 Aug 2026 16:55:31 +0800
Message-ID: <e1c54a6b-6d90-4239-adab-6813cfc6dec9@open-hieco.net>
Date: Thu, 13 Aug 2026 16:55:31 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] KVM: nSVM: Fetch missing DecodeAssist bytes for
 synthesized #NPF/#PF
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1785411877.git.zhang_wei@open-hieco.net>
 <9dae4bd5ad241b72193b38cfe8857c968c47a4b7.1785411877.git.zhang_wei@open-hieco.net>
 <20260730123135.B3FB21F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <20260730123135.B3FB21F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/2026 8:31 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Already-prepared instruction bytes are discarded if the instruction pointer exceeds the CS limit (or due to residual upper bits in 16-bit mode).
> --
> 
> --- Patch [7]: [PATCH v3 7/9] KVM: nSVM: Fetch missing DecodeAssist bytes for synthesized #NPF/#PF ---
> commit 96d13188ab4298d9414e0345853cc8950d39abb9
> Author: Tina Zhang <zhang_wei@open-hieco.net>
> 
> KVM: nSVM: Fetch missing DecodeAssist bytes for synthesized #NPF/#PF
> 
> This commit limits the preparation of synthesized state to matching the
> emulator fetch cache and fetches any missing tail bytes through L2 guest
> page tables. If the emulator cache is empty, it attempts to fetch the full
> window from the L2 RIP, avoiding fetches for SEV guests.
> 
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index cfb686c29bb47..cf2b6bb8126ff 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
> 
> [ ... ]
> 
>> +static u8 nested_svm_fetch_insn_bytes(struct kvm_vcpu *vcpu, u8 *bytes,
>> +				      u8 count, u8 max_bytes)
>> +{
>> +	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
>> +	u64 access = PFERR_FETCH_MASK;
>> +	gva_t rip = kvm_get_linear_rip(vcpu);
>> +	struct x86_exception e;
>> +
>> +	if (kvm_x86_call(get_cpl)(vcpu) == 3)
>> +		access |= PFERR_USER_MASK;
>> +
>> +	if (!is_64_bit_mode(vcpu)) {
>> +		u32 eip = kvm_rip_read(vcpu);
>> +		u32 limit = to_svm(vcpu)->vmcb->save.cs.limit;
>> +
>> +		if (eip > limit)
>> +			return 0;
> 
> [Severity: Medium]
> Should this return count instead of 0?
> 
> If an L2 guest in 16-bit or 32-bit mode causes a nested page fault where
> eip > limit evaluates to true (for example, in 16-bit mode if kvm_rip_read()
> retains residual upper 16-bits), returning 0 here causes the caller to
> overwrite vmcb12->control.insn_len with 0.
> 
> This would inadvertently discard any already-prepared valid instruction bytes
> that were passed in via the count parameter, forcing the L1 hypervisor to
> manually read the instruction from L2 memory and defeating the DecodeAssist
> optimization.

Returning zero is intentional. If the starting EIP is already beyond
the CS limit, no instruction byte is architecturally fetchable from
CS:EIP, and the APM specifies an instruction length of zero in that
case.

A matching emulator fetch cache should not normally contain bytes for
this condition. The emulator fetch path uses __linearize() with
X86EMUL_F_FETCH and checks the same CS limit before populating its cache.

Also, a 16-bit code segment does not imply that EIP should be
unconditionally truncated to 16 bits here. KVM's emulator checks the
full non-64-bit EIP against the segment limit, which is consistent with
this code.

Thanks,
Tina

> 
>> +		max_bytes = min_t(u64, max_bytes, (u64)limit - eip + 1);
>> +	}
>> +
>> +	count = min(count, max_bytes);
>> +
>> +	while (count < max_bytes) {
> 
> [ ... ]
> 

