Received: from mta1.migadu.com (out-131.mta1.migadu.com [95.215.58.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA0341DDE5
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699716; cv=none; b=pi3ylt9g1ySjRcBTGKf7Jp631SrUIFvjgvBzwj9kXUDRUcp27YhLlnwW/jNTjgzUNIN9J7zNA2VyrmQze1Rgf5I4qvfuRGZ9J3LsU5CxNDV6Df/5vfgJvdctWENfuSusc5IIOVts2iaQ31RgK3yuTup14nZen8Gk/3TBap70/L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699716; c=relaxed/simple;
	bh=aKc6Ht70FpFYHMi3v//T6si9m2aQw7blmfmTGQZxG04=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Oj9DaXLrli5wl86zaaKPJSXYMQmekaHnhEozPQuIzZLMmY9tkbbWlYGwBDDWvEfYVASFezJ7IW1ecuE6LD1Kk6g4Q7h9TwErxRt9K6rPwNYbB9Tim//efMBj20PgeL+/bZqc9dGuuDwgNCklRPLthMBg8EzYa7i6xWNRcIKDeZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ks8oAYzH; arc=none smtp.client-ip=95.215.58.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ks8oAYzH"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aKc6Ht70FpFYHMi3v//T6si9m2aQw7blmfmTGQZxG04=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786699712; v=1; x=1787304512;
 b=Ks8oAYzHnx5RvCsRWtQbvI4hceWIX8H70sr8vqSld9LYxWM5+Fy00pEGrqgfDf5KR9z2q/1r
 +Fh/dVqO9jlB4P3k4YSTLJv/8vBzRv+nl4CdWfVaiYs0aqM9Y/UuLfGkGyRDK6DNRVMpVR4qsC8
 tzaAYgMtqkVNWemQG3FRmzZs=
X-Envelope-To: kvm@vger.kernel.org
Received: from [192.168.1.116] (111.162.215.50)
	by smtp.migadu.com with ESMTPS id 3cf49401cfb7d1c4;
	Fri, 14 Aug 2026 09:28:32 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <5e5f26fb-8c8f-4326-bf47-ef25dbd62c01@linux.dev>
Date: Fri, 14 Aug 2026 17:28:25 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, zhaotianrui@loongson.cn, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2] LoongArch: KVM: Fix TOCTOU race on pv_features
To: Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>
References: <20260813232542.2098930-1-cui.tao@linux.dev>
 <d26fdd03-dcfe-8ae0-d925-d121866e566d@loongson.cn>
 <CAAhV-H7b1sjB_-nP_UUN-rgv22YcPoiUAZDVfnDxHMs3cERWCQ@mail.gmail.com>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <CAAhV-H7b1sjB_-nP_UUN-rgv22YcPoiUAZDVfnDxHMs3cERWCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Huacai,

在 2026/8/14 16:24, Huacai Chen 写道:
> Hi, Tao,
> 
> On Fri, Aug 14, 2026 at 9:09 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/8/14 上午7:25, Tao Cui wrote:
>>> From: Tao Cui <cuitao@kylinos.cn>
>>>
>>> The check-then-set on kvm->arch.pv_features in
>>> kvm_loongarch_cpucfg_set_attr() is lockless, so two vCPUs can race
>>> past the validation and set different values.  Add a spinlock to
>>> serialize it.
>>>
>>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>>> ---
>>>
>>> Changes in v2: use a spinlock instead of a cmpxchg loop (Bibo Mao).
>>> Link: https://lore.kernel.org/all/20260810081321.157258-1-cui.tao@linux.dev/
>>>
>>>   arch/loongarch/include/asm/kvm_host.h | 2 ++
>>>   arch/loongarch/kvm/vcpu.c             | 6 +++++-
>>>   arch/loongarch/kvm/vm.c               | 1 +
>>>   3 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
>>> index 23cfbecebbd7..cdbbd90e0584 100644
>>> --- a/arch/loongarch/include/asm/kvm_host.h
>>> +++ b/arch/loongarch/include/asm/kvm_host.h
>>> @@ -128,6 +128,8 @@ struct kvm_arch {
>>>       struct kvm_phyid_map  *phyid_map;
>>>       /* Enabled PV features */
>>>       unsigned long pv_features;
>>> +     /* Serializes pv_features updates */
>>> +     spinlock_t pv_features_lock;
> I think it is better to rename it to pv_setting_lock, and put it near
> phyid_map_lock.
> 
Got it, v3 on the way with the rename and the lock moved.

Thanks,
Tao

> Huacai
> 
>>>       /* Supported KVM features */
>>>       unsigned long kvm_features;
>>>
>>> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
>>> index 20c207d80e31..551ed39b2d1f 100644
>>> --- a/arch/loongarch/kvm/vcpu.c
>>> +++ b/arch/loongarch/kvm/vcpu.c
>>> @@ -1165,10 +1165,14 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
>>>                       return -EINVAL;
>>>
>>>               /* All vCPUs need set the same PV features */
>>> +             spin_lock(&kvm->arch.pv_features_lock);
>>>               if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
>>> -                             && ((kvm->arch.pv_features & valid) != val))
>>> +                             && ((kvm->arch.pv_features & valid) != val)) {
>>> +                     spin_unlock(&kvm->arch.pv_features_lock);
>>>                       return -EINVAL;
>>> +             }
>>>               kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
>>> +             spin_unlock(&kvm->arch.pv_features_lock);
>>>               return 0;
>>>       default:
>>>               return -ENXIO;
>>> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
>>> index 1317c718f896..b984cc54f305 100644
>>> --- a/arch/loongarch/kvm/vm.c
>>> +++ b/arch/loongarch/kvm/vm.c
>>> @@ -76,6 +76,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>>               return -ENOMEM;
>>>       }
>>>       spin_lock_init(&kvm->arch.phyid_map_lock);
>>> +     spin_lock_init(&kvm->arch.pv_features_lock);
>>>
>>>       kvm_init_vmcs(kvm);
>>>       kvm_vm_init_features(kvm);
>>>
>> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>>

