Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD383403ED;
	Wed, 30 Sep 2026 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733209; cv=none; b=Vwgmno4SoISnjC1P3oDFDDPOG6+ouV44oKCnyhlc2u0DNP5VVXs9fI4t5y94FfR95fYvkFvuWwv9PLPBi/sZlpdXBZIOYXN2kHAf5YNs5ckWm41gIlaNACq/7BB0rKx7z1lSy/iRdVApOPkawFYKTh5vo1xJ2orRyHghw08oIYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733209; c=relaxed/simple;
	bh=koW4b9jDjIZuMUVrLX0YUFeqVCFYzvJwCX+kO8a92Ho=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CzEQC4LR+NdxlPL3Jvudncs6JihHkb0qFFr2PMww4G83l5YtjUtgQQY6TIUxPr4OiT2aSgSvf73xY+16L0hqL1N0vKkugFcx6xyQlE05pXVAiZONfjGzjT9rOdLNnzPHgjwo5TuR+xW1mWqCCShPbbg4eFT6ibKAsSqYReiE1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxPNKUa7xq1DERAA--.50488S3;
	Wed, 30 Sep 2026 09:53:24 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxPs+Ra7xqg84mAA--.16151S2;
	Wed, 30 Sep 2026 09:53:23 +0800 (CST)
Subject: Re: [PATCH v2 4/4] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
To: Huacai Chen <chenhuacai@kernel.org>, Tao Cui <cui.tao@linux.dev>
Cc: gaosong@loongson.cn, zhaotianrui@loongson.cn, loongarch@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
References: <20260929102821.36112-1-cui.tao@linux.dev>
 <20260929102821.36112-5-cui.tao@linux.dev>
 <CAAhV-H5GNKZSjB_MN2Vi7uhbf1q9nqqvsfwqF+THpkwk3dEhGQ@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <9a59af62-3e8a-12f5-4e6c-38c1953adb37@loongson.cn>
Date: Wed, 30 Sep 2026 09:54:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5GNKZSjB_MN2Vi7uhbf1q9nqqvsfwqF+THpkwk3dEhGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPs+Ra7xqg84mAA--.16151S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1DXry8tFyDJF1xtw48Zrc_yoWrWr15pF
	W8Aas8CFW8Wr1xWFs2vw1kXr1xZr4I9w1SgF1UAFWjkwn0vryYqFy8Jrs8ZF98J3yrCF1I
	qF43G34Yv3WjyabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU



On 2026/9/29 下午8:43, Huacai Chen wrote:
> Hi, Tao,
> 
> On Tue, Sep 29, 2026 at 6:29 PM Tao Cui <cui.tao@linux.dev> wrote:
>>
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT has no guard against repeated
>> invocation: every call overwrites pch_pic_base and registers the same
>> kvm_io_device on the MMIO bus at the new address, while
>> kvm_pch_pic_destroy() unregisters only one bus range.  After a repeated
>> init, MMIO to the stale ranges computes its register offset against the
>> new base and silently reads 0 / drops writes, and the leftover bus
>> entries persist until the VM is destroyed.
>>
>> Reject repeated initialization with -EEXIST, tracking the state with
>> a has_init flag so the check and the MMIO base update are atomic
>> under slots_lock.  The base is only committed after a successful bus
>> registration, and the real registration error is propagated instead
>> of being replaced with -EFAULT.
>>
>> Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and write functions")
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>   arch/loongarch/include/asm/kvm_pch_pic.h |  1 +
>>   arch/loongarch/kvm/intc/pch_pic.c        | 12 ++++++++++--
>>   2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch/include/asm/kvm_pch_pic.h
>> index 887b0431fd20..679132d840e6 100644
>> --- a/arch/loongarch/include/asm/kvm_pch_pic.h
>> +++ b/arch/loongarch/include/asm/kvm_pch_pic.h
>> @@ -53,6 +53,7 @@ struct loongarch_pch_pic {
>>          spinlock_t lock;
>>          struct kvm *kvm;
>>          struct kvm_io_device device;
>> +       bool has_init;
>>          union pch_pic_id id;
>>          uint64_t mask; /* 1:disable irq, 0:enable irq */
>>          uint64_t htmsi_en; /* 1:msi */
>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
>> index 7a704f18880d..a884a043feef 100644
>> --- a/arch/loongarch/kvm/intc/pch_pic.c
>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
>> @@ -282,16 +282,24 @@ static int kvm_pch_pic_init(struct kvm_device *dev, u64 addr)
>>          struct kvm_io_device *device;
>>          struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
> Why so complicated? The below is enough, no?
> 
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c
> b/arch/loongarch/kvm/intc/pch_pic.c
> index 2b63b0c2c7ce..7855d78304b7 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -281,6 +281,9 @@ static int kvm_pch_pic_init(struct kvm_device
> *dev, u64 addr)
>          struct kvm_io_device *device;
>          struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
> 
> +       if (s->device->ops)
> +               return -EEXIST;
This can work, however I think that it is not a good idea to access 
internal structure field about kvm_io_device. If so, there is no use 
about API kvm_iodevice_init(), just s->device->ops = &kvm_pch_pic_ops is ok.

If adding has_init is redundant, maybe we can set s->pch_pic_base with 
INVALID_GPA in kvm_pch_pic_create() or some other methods. However I 
think directly accessing kvm_io_device::ops is not a good method, no 
other architectures do in such way.

Regards
Bibo Mao
> +
>          s->pch_pic_base = addr;
>          device = &s->device;
>          /* init device by pch pic writing and reading ops */
> 
>>
>> -       s->pch_pic_base = addr;
>>          device = &s->device;
>>          /* init device by pch pic writing and reading ops */
>>          kvm_iodevice_init(device, &kvm_pch_pic_ops);
>>          mutex_lock(&kvm->slots_lock);
>> +       if (s->has_init) {
>> +               ret = -EEXIST;
>> +               goto out;
>> +       }
>>          /* register pch pic device */
>>          ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_SIZE, device);
>> +       if (!ret) {
>> +               s->pch_pic_base = addr;
>> +               s->has_init = true;
>> +       }
>> +out:
>>          mutex_unlock(&kvm->slots_lock);
>>
>> -       return (ret < 0) ? -EFAULT : 0;
>> +       return ret;
>>   }
>>
>>   /* used by user space to get or set pch pic registers */
>> --
>> 2.43.0
>>

