Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7094236196E;
	Wed, 12 Aug 2026 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516138; cv=none; b=Db2wygHwbgRrOV0x743fkoPBP3S9qJDWbJzIv+kYWmzeQEd1KjxiVir/lUF4ADZrFHyyLY4YflnU8GD6NdKohjaUuoAjlSbW9F4pfQjxRcUF+p/ABvyeajUeCwEXpuQs/Gut3kwZu0/x9t8T7T1oQNmYurD6/33IzSe0ejuvhMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516138; c=relaxed/simple;
	bh=T8kakElG4snEzW77dQPkOzDc0BqkZCRH6iBBJQsn9s0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MbrtZ9xbBjKWHcB0oQdVM2IUiQZimF0ZZf8p1LrrKOiWFIAhefiUywG2WGy5FZxcfov+U72YIGGaqfN+AenAiBVEBF8kB+zzqsDXGHK3m4C68UvAvZ56bQJaBgVlg5r9irRhWMDg7WyXbIJ2+aoRIsRv0ydLkaNZMmUpSLbCe5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxdvClEnxq7XMAAA--.1491S3;
	Wed, 12 Aug 2026 14:28:53 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxmM2jEnxqoLEBAA--.10116S2;
	Wed, 12 Aug 2026 14:28:52 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Fix TOCTOU race on pv_features
To: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn
Cc: chenhuacai@kernel.org, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
References: <20260810081321.157258-1-cui.tao@linux.dev>
 <da1badea-d9ef-45f4-b2ec-f3152b12c4ac@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <60496d81-7382-a49d-27a0-b21e07d905f7@loongson.cn>
Date: Wed, 12 Aug 2026 14:28:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <da1badea-d9ef-45f4-b2ec-f3152b12c4ac@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxmM2jEnxqoLEBAA--.10116S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw43trykWFW7JFWUKr4DGFX_yoW5Zr48pF
	ZrCr98urs5Gr1xA3sIqw4fW3y5Ars7Gr4YqFnrta4jyFn8CryYqrW0y39xuFn8t34vg3WI
	vFW0ka9rurn0y3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==



On 2026/8/10 下午4:17, Tao Cui wrote:
> 
> Hi Bibo,
> 在 2026/8/10 16:13, Tao Cui 写道:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> kvm_loongarch_cpucfg_set_attr() validates and writes the VM-wide
>> pv_features with a lockless check-then-set, so two vCPUs racing it can
>> both pass the "all-vCPUs-must-match" check and install divergent values.
>> Make the check-then-set atomic with a cmpxchg loop; the UPDATED bit
>> already packs the configured state into the same word.
>>
> 
> I just sent a small patch for the pv_features TOCTOU we discussed. It
> turns the check-then-set into a cmpxchg loop on the existing UPDATED
> bit, so there's no new field or lock.
> 
> While working on it I also looked at two other options and wanted to
> mention them here.
> 
> One was a spinlock around the check-then-set. It works, but it needs a
> new kvm_arch member just for this, which didn't seem worth it given the
> UPDATED bit already keeps the value and flag in a single word.
> 
> The other is to move pv_features per-vCPU (vcpu->arch). That removes the
> shared state altogether: no lock, no latch, no cross-vCPU check, and the
> VMM just keeps the vCPUs in sync. It's the cleaner design, but a larger
> change, since QEMU would need a matching change too. Today QEMU pushes
> pv_features behind a process-wide `static int once` (only the first
> vCPU), which relies on the per-VM storage. This is the per-CPU direction
> you mentioned earlier [1]; if you're still planning to do it I'm happy to
> hold off, otherwise I can put together the kernel + QEMU side.
> 
> All three were built and tested locally with a vCPU-attribute test (the
> spinlock also came up clean under KCSAN).
> 
> Thanks,
> Tao
> 
> [1] https://lore.kernel.org/all/9696e097-7399-96b2-e0ae-bbb0d2f8c0d7@loongson.cn/
> 
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>   arch/loongarch/kvm/vcpu.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
>> index 20c207d80e31..55030c37cf06 100644
>> --- a/arch/loongarch/kvm/vcpu.c
>> +++ b/arch/loongarch/kvm/vcpu.c
>> @@ -1164,12 +1164,18 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
>>   		if (val & ~valid)
>>   			return -EINVAL;
>>   
>> -		/* All vCPUs need set the same PV features */
>> -		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
>> -				&& ((kvm->arch.pv_features & valid) != val))
>> -			return -EINVAL;
>> -		kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
>> -		return 0;
>> +		/* Atomically install val; the cmpxchg serializes concurrent setters. */
>> +		for (;;) {
>> +			unsigned long old, new;
>> +
>> +			old = READ_ONCE(kvm->arch.pv_features);
>> +			if ((old & LOONGARCH_PV_FEAT_UPDATED) &&
>> +			    ((old & valid) != val))
>> +				return -EINVAL;
>> +			new = val | LOONGARCH_PV_FEAT_UPDATED;
>> +			if (cmpxchg(&kvm->arch.pv_features, old, new) == old)
>> +				return 0;
>> +		}
The for loop sentence is a little strange, can we use spinlock method 
rather than atomic cmpxchg method? It is not performance sensitive here.

Regards
Bibo Mao
>>   	default:
>>   		return -ENXIO;
>>   	}

