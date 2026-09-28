Received: from mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098D32E121
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587752; cv=none; b=PhL52alVfWRadKkeAN4fJf6YgGMjqIgEFPPOIKdjkWkIVJ0rL2XpQUegl13U4oFARWMzvays6B8iN5771BYIG9Js+ZZnbzWXMQN/QI0+nWVTpDypLaYH/6YM9pNeEoxDcIng10f986SYjnRtB/wGyvFfkXo9B0Oh9zF7g9ylOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587752; c=relaxed/simple;
	bh=61K6+vmzqsUZVtZu4pTLUg1VKRDC6b+cTmykUL3l5d8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lYpWHLwSB07lqWyvH/8sgYPVTm/qx7HHNIMIV0IFRMoXjKdOuKqoA8x0sAmWdjhJ3+zu9F4W0P/t/Qib3TQ4KlSrlm3I0sObZ7tm8oadEB+PYe9WnPIvjsiS7EkHsEcwHVW5qF4AOXLO8pkiUvZXiw28NjPKThl387pn2p3IF74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xwVqgK8U; arc=none smtp.client-ip=91.218.175.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xwVqgK8U"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=61K6+vmzqsUZVtZu4pTLUg1VKRDC6b+cTmykUL3l5d8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790587747; v=1; x=1791192547;
 b=xwVqgK8U91ZzHgZWU/Q7l1FVAdEKFpwCy9YG0fr6tiXatYGIcL8aiIHLFJUYsdXdDh+Hekwu
 mmsQaLcG9/ZPczALPMntsM0ivUIEeUAzmkaj9utKzn5L9hV2NfqnC58PaQldU8+B6Ymqtyuy4ru
 mfOQ12G5OwRub5JVMNwsbrr0=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6b386df4d52f3baf;
	Mon, 28 Sep 2026 09:29:07 +0000
X-Mizu-Trace-ID: 6b386df4d52f3baf
X-Migadu-Flow: FLOW_OUT
Message-ID: <272a796e-3d2b-4766-9e68-28d9092073a1@linux.dev>
Date: Mon, 28 Sep 2026 17:28:58 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, loongarch@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 4/6] LoongArch: KVM: Rebase steal time counter in vcpu
 context
To: Bibo Mao <maobibo@loongson.cn>, gaosong@loongson.cn,
 zhaotianrui@loongson.cn
References: <20260927075240.3007947-1-cui.tao@linux.dev>
 <20260927075240.3007947-5-cui.tao@linux.dev>
 <789eaa76-50a1-61bf-0419-0f45beb45a92@loongson.cn>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <789eaa76-50a1-61bf-0419-0f45beb45a92@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/28 15:23, Bibo Mao 写道:
> 
> 
> On 2026/9/27 下午3:52, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> KVM_SET_DEVICE_ATTR(PVTIME GPA) initializes st.last_steal from the
>> ioctl thread's run_delay, but kvm_update_stolen_time() accumulates the
>> vcpu thread's run_delay; the first delta can be negative and wraps in
> I think that ioctl thread is the vCPU thread itself in KVM mode, there will be many potential problems when one thread set registers of vCPU while vCPU is running.
> 

You're right. I assumed KVM_SET_DEVICE_ATTR() could be issued
from a thread different from the vCPU thread. Looking at the expected
userspace flow again, the pvtime GPA is registered by the guest kernel
via hypercall (which runs in vCPU context), or set by the vCPU thread
itself before entering KVM_RUN. In both cases `last_steal` and the
subsequent steal updates use the same task's `run_delay`, so the
negative delta I described cannot occur.

I'll drop this patch as well.

Thanks,
Tao> Regards
> Bibo Mao
>> u64, so the guest reads a steal time close to 2^64.
>>
>> Drop the initialization from the attr path and lazily rebase the
>> counter on the first steal update, which runs in vcpu context like the
>> hypercall path.  Re-registering a GPA clears the rebase sentinel first
>> and publishes the address with a write barrier; the reader side loads
>> the address and sentinel with READ_ONCE and a read barrier so a
>> concurrent re-registration is not observed half-applied.
>>
>> Fixes: b4ba157044ea ("LoongArch: KVM: Add PV steal time support in host side")
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>   arch/loongarch/kvm/vcpu.c | 25 +++++++++++++++++--------
>>   1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
>> index 8e028be3f0a9..d931a5a802f6 100644
>> --- a/arch/loongarch/kvm/vcpu.c
>> +++ b/arch/loongarch/kvm/vcpu.c
>> @@ -154,12 +154,13 @@ static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
>>       u32 version;
>>       u64 steal;
>>       gpa_t gpa;
>> +    u64 last_steal;
>>       struct kvm_memslots *slots;
>>       struct kvm_steal_time __user *st;
>>       struct gfn_to_hva_cache *ghc;
>>         ghc = &vcpu->arch.st.cache;
>> -    gpa = vcpu->arch.st.guest_addr;
>> +    gpa = READ_ONCE(vcpu->arch.st.guest_addr);
>>       if (!(gpa & KVM_STEAL_PHYS_VALID))
>>           return;
>>   @@ -187,8 +188,14 @@ static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
>>       smp_wmb();
>>         unsafe_get_user(steal, &st->steal, out);
>> -    steal += current->sched_info.run_delay - vcpu->arch.st.last_steal;
>> -    vcpu->arch.st.last_steal = current->sched_info.run_delay;
>> +    /* acquire pairs with the smp_wmb in the attr path */
>> +    smp_rmb();
>> +    last_steal = READ_ONCE(vcpu->arch.st.last_steal);
>> +    if (!last_steal)
>> +        /* first update in vcpu context: rebase the counter */
>> +        last_steal = current->sched_info.run_delay;
>> +    steal += current->sched_info.run_delay - last_steal;
>> +    WRITE_ONCE(vcpu->arch.st.last_steal, current->sched_info.run_delay);
>>       unsafe_put_user(steal, &st->steal, out);
>>         smp_wmb();
>> @@ -1122,7 +1129,7 @@ static int kvm_loongarch_pvtime_get_attr(struct kvm_vcpu *vcpu,
>>               || attr->attr != KVM_LOONGARCH_VCPU_PVTIME_GPA)
>>           return -ENXIO;
>>   -    gpa = vcpu->arch.st.guest_addr;
>> +    gpa = READ_ONCE(vcpu->arch.st.guest_addr);
>>       if (put_user(gpa, user))
>>           return -EFAULT;
>>   @@ -1197,7 +1204,7 @@ static int kvm_loongarch_pvtime_set_attr(struct kvm_vcpu *vcpu,
>>           return -EINVAL;
>>         if (!(gpa & KVM_STEAL_PHYS_VALID)) {
>> -        vcpu->arch.st.guest_addr = gpa;
>> +        WRITE_ONCE(vcpu->arch.st.guest_addr, gpa);
>>           return 0;
>>       }
>>   @@ -1208,8 +1215,10 @@ static int kvm_loongarch_pvtime_set_attr(struct kvm_vcpu *vcpu,
>>       srcu_read_unlock(&kvm->srcu, idx);
>>         if (!ret) {
>> -        vcpu->arch.st.guest_addr = gpa;
>> -        vcpu->arch.st.last_steal = current->sched_info.run_delay;
>> +        WRITE_ONCE(vcpu->arch.st.last_steal, 0);
>> +        /* publish the new address only after clearing the rebase sentinel */
>> +        smp_wmb();
>> +        WRITE_ONCE(vcpu->arch.st.guest_addr, gpa);
>>           kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
>>       }
>>   @@ -1800,7 +1809,7 @@ static void kvm_vcpu_set_pv_preempted(struct kvm_vcpu *vcpu)
>>       struct kvm_memslots *slots;
>>       struct kvm_steal_time __user *st;
>>   -    gpa = vcpu->arch.st.guest_addr;
>> +    gpa = READ_ONCE(vcpu->arch.st.guest_addr);
>>       if (!(gpa & KVM_STEAL_PHYS_VALID))
>>           return;
>>  
> 

