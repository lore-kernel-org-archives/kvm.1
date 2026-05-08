Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A003815ED;
	Fri,  8 May 2026 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227074; cv=none; b=kvSs0ossclMX9g9gB7Iz8QkpBiEfI2II64BaA3XsN9h8HBUiz62qkGHwdBSl371nBlrz7R5zCVqlKhBz3HP/N5Bng76GCnDorZp6ArXJ060TTSMtEKeIVCNXwS/hpc0RuQYuSyfpjOUBLHkJUdtN8t6hG0YELPjfRNrzY43niTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227074; c=relaxed/simple;
	bh=Ra6iTdzW+x5/Jh8IurVuQFA4PvWjZD4iqYGsXewW52Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UlyLaEVkCKIO2yel/yTPg8r8WH3kx1quvQ68q6MocxoXK11/FRoGlJhvniltC+juOysaHE1p+UcrzT2ffvuBNPu2Dc0ObWe5U8ZhdnF4hBodi0sf5/x93/ef17Lezbd3JjwjZ1ux9CdEHq7jiwJydC3xWd4kWAfK1234My0ogWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xITxDAGh; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xITxDAGh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LFN5x5Ph+s7wPmuDZH46j3nsp+1HzK7RmBeeYkZkyks=;
	b=xITxDAGh+rUnt+DrqHW305jkMoIZ2jxTDmBnTMN0DQ5PVFuROaXMRPSfXGsDxdrFMIoWDsZdo
	1hpNCLVIZ100T237YULco8Rqlmw2kQlpG2em9reOpI8nLTfkrmEwAeO/oJn0YEsMJASUmlGjWPG
	2zGIsv/9R1+fAnY5NM9rcdo=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gBh9Z3tXFzKm97;
	Fri,  8 May 2026 15:50:10 +0800 (CST)
Received: from dggpemr200006.china.huawei.com (unknown [7.185.36.167])
	by mail.maildlp.com (Postfix) with ESMTPS id EC55D40539;
	Fri,  8 May 2026 15:57:46 +0800 (CST)
Received: from [10.67.110.145] (10.67.110.145) by
 dggpemr200006.china.huawei.com (7.185.36.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 May 2026 15:57:46 +0800
Message-ID: <41da263a-ca8e-4041-8214-b6b9f80edebb@huawei.com>
Date: Fri, 8 May 2026 15:57:45 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT] USE_AFTER_FREE in complete_emulated_mmio found by
 KASAN/Syzkaller fuzz test (v5.10.0)
To: Sean Christopherson <seanjc@google.com>, Zhangjiaji
	<zhangjiaji1@huawei.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Wangqinxiao (Tom)" <wangqinxiao@huawei.com>,
	zhangyashu <zhangyashu2@h-partners.com>, "wangyanan (Y)"
	<wangyanan55@huawei.com>, zouyipeng <zouyipeng@huawei.com>,
	<wangyanan55@huawei.com>
References: <67a2f20537354628bcb835586a7c6255@huawei.com>
 <aYuC87rMLlBYIZRc@google.com> <aZYneb7Dvuu-HQsP@google.com>
Content-Language: en-US
From: Xinyu Zheng <zhengxinyu6@huawei.com>
In-Reply-To: <aZYneb7Dvuu-HQsP@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemr200006.china.huawei.com (7.185.36.167)



On 2/19/2026 4:56 AM, Sean Christopherson wrote:
> On Tue, Feb 10, 2026, Sean Christopherson wrote:
>> On Tue, Feb 10, 2026, Zhangjiaji wrote:
>>>> I think there's a not-completely-awful solution buried in this gigantic cesspool.
>>>> The only time KVM uses on-stack variables is for qword or smaller accesses, i.e.
>>>> 8 bytes in size or less.  For larger fragments, e.g. AVX to/from MMIO, the target
>>>> value will always be an operand in the emulator context.  And so rather than
>>>> disallow stack variables, for "small" fragments, we can rework the handling to
>>>> copy the value to/from each fragment on-demand instead of stashing a pointer to
>>>> the value.
>>>
>>> Since we can store the frag->val in struct kvm_mmio_fragment,
>>> why not just point frag->data to it? This Way we can save a lot code about
>>> (frag->data == NULL).
>>
>> It's not quite that simple, because we need to handle reads as well.
>>
>>> Though this patch will block any read-into-stack calls, we can add a special path
>>> in function emulator_read_write handling feasible read-into-stack calls -- the
>>> target is released just after emulator_read_write returns.
>>>
>>> ---
>>>   arch/x86/kvm/x86.c       | 9 ++++++++-
>>>   include/linux/kvm_host.h | 3 ++-
>>>   2 files changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index 72d37c8930ad..12d53d441a39 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -8197,7 +8197,14 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
>>>   	WARN_ON(vcpu->mmio_nr_fragments >= KVM_MAX_MMIO_FRAGMENTS);
>>>   	frag = &vcpu->mmio_fragments[vcpu->mmio_nr_fragments++];
>>>   	frag->gpa = gpa;
>>> -	frag->data = val;
>>> +	if (bytes > 8u || ! write) {
>>> +		if (WARN_ON_ONCE(object_is_on_stack(val)))
>>
>> This is user-triggerable, e.g. em_popa(), em_pop_sreg(), emulate_iret_real(),
>> em_ret_near_imm(), em_ret_far(), and em_ret().
> 
> *sigh*
> 
> And I was wrong.  I finally sat down to write some comments for all of this, and
> realized that reads _never_ pass an on-stack @val to emulator_read_write_onepage(),
> because read_emulated() always buffers reads through ctxt->mem_read.
> 
> So not only is my fancy, complex code unnecessary, it's actively broken.  If a
> read splits a page boundary, and the first page is NOT emulated MMIO, trying to
> fulfill the read on-demand falls apart because the @val points at the start of
> the operand (technically its cache "entry").  I'm sure that's a solvable problem,
> but I don't see any point in manufacturing a problem in the first place.
> 
> I need to write a changelog, but as Yashu suggested, the fix can more simply be:
> 
> --
> From: Sean Christopherson <seanjc@google.com>
> Date: Tue, 10 Feb 2026 09:45:37 -0800
> Subject: [PATCH 01/14] KVM: x86: Use scratch field in MMIO fragment to hold
>   small write values
> 
> Fixes: f78146b0f923 ("KVM: Fix page-crossing MMIO")
> Suggested-by: Yashu Zhang <zhangjiaji1@huawei.com>
> Reported-by: Yashu Zhang <zhangjiaji1@huawei.com>
> Closes: https://lore.kernel.org/all/369eaaa2b3c1425c85e8477066391bc7@huawei.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/x86.c       | 14 +++++++++++++-
>   include/linux/kvm_host.h |  3 ++-
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index db3f393192d9..ff3a6f86973f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8226,7 +8226,13 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
>   	WARN_ON(vcpu->mmio_nr_fragments >= KVM_MAX_MMIO_FRAGMENTS);
>   	frag = &vcpu->mmio_fragments[vcpu->mmio_nr_fragments++];
>   	frag->gpa = gpa;
> -	frag->data = val;
> +	if (write && bytes <= 8u) {
> +		frag->val = 0;
> +		frag->data = &frag->val;
> +		memcpy(&frag->val, val, bytes);
> +	} else {
> +		frag->data = val;
> +	}
>   	frag->len = bytes;
>   	return X86EMUL_CONTINUE;
>   }
> @@ -8241,6 +8247,9 @@ static int emulator_read_write(struct x86_emulate_ctxt *ctxt,
>   	gpa_t gpa;
>   	int rc;
>   
> +	if (WARN_ON_ONCE((bytes > 8u || !ops->write) && object_is_on_stack(val)))
> +		return X86EMUL_UNHANDLEABLE;
> +
>   	if (ops->read_write_prepare &&
>   		  ops->read_write_prepare(vcpu, val, bytes))
>   		return X86EMUL_CONTINUE;
> @@ -11847,6 +11856,9 @@ static int complete_emulated_mmio(struct kvm_vcpu *vcpu)
>   		frag++;
>   		vcpu->mmio_cur_fragment++;
>   	} else {
> +		if (WARN_ON_ONCE(frag->data == &frag->val))
> +			return -EIO;
> +
>   		/* Go forward to the next mmio piece. */
>   		frag->data += len;
>   		frag->gpa += len;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 2c7d76262898..0bb2a34fb93d 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -320,7 +320,8 @@ static inline bool kvm_vcpu_can_poll(ktime_t cur, ktime_t stop)
>   struct kvm_mmio_fragment {
>   	gpa_t gpa;
>   	void *data;
> -	unsigned len;
> +	u64 val;

Hi, Jiayi and Sean,

Since I met a KABI consistence break problem from this change, I am 
finding a way to avoid add including kvm_mmio_fragment.val.

Can I try to directly malloc a 8 size buffer for kvm_mmio_fragment.data 
instead of using kvm_mmio_fragment.val, and free this buffer in 
complete_emulated_mmio when all fragments is been copied?

Thanks!

> +	unsigned int len;
>   };
>   
>   struct kvm_vcpu {
> 
> base-commit: 183bb0ce8c77b0fd1fb25874112bc8751a461e49
> --

-- 
Xinyu

