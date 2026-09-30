Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746BC472F7D;
	Wed, 30 Sep 2026 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759038; cv=none; b=oDjjWKdIAlnzVta7EW5AlzbORfN7RX0BNI0WqP+i0LE2lss0R8PqZA7KAVVVJC4VJvH4sf0n2IMdnN7fNx49cBX73etDEKOwLt90N8d+s/jNCJq6YMS7tTUpPegyf7+uvAMUwyC/U+SfYQLRWy9iw1NxT2xLfsVw/btNXUQTnEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759038; c=relaxed/simple;
	bh=VHeSbzs1UinsNwkf4348U8S8hziaR0ZBIVjleEL227Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bcea/5q6Xf81N17DvDxp1jXzR25xbj51h7XuMdYf5ev/SoDANsx9f/jLRZ4PSwqhPplF9QcQSyMSj0bzWbbVGB6gfCTBQISwEcthNm+0tlp06XZTWE7GSFjPw/RR5MpA+6hR1I/JgD2ap5rUrPSMUxV3PPizsJJv4hl2Flk1raI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Bxb9Nt0LxqdkwRAA--.50539S3;
	Wed, 30 Sep 2026 17:03:41 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAx3c5s0LxqWe4mAA--.17039S2;
	Wed, 30 Sep 2026 17:03:40 +0800 (CST)
Subject: Re: [PATCH v2 4/4] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tao Cui <cui.tao@linux.dev>, gaosong@loongson.cn,
 zhaotianrui@loongson.cn, loongarch@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
References: <20260929102821.36112-1-cui.tao@linux.dev>
 <20260929102821.36112-5-cui.tao@linux.dev>
 <CAAhV-H5GNKZSjB_MN2Vi7uhbf1q9nqqvsfwqF+THpkwk3dEhGQ@mail.gmail.com>
 <9a59af62-3e8a-12f5-4e6c-38c1953adb37@loongson.cn>
 <CAAhV-H6cgiMQn=1oct6KHaLADwWQJ7Ow3iT14_Gj5BQxMW22Sg@mail.gmail.com>
 <be33489e-fec4-ba52-45d9-6323b14da593@loongson.cn>
 <CAAhV-H5yXR8vN0NdiHWRTbGOsrqrVxZFd9g9QdaZGhdLR=BA7A@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <3aada818-e1e1-a802-2547-b8e41618df32@loongson.cn>
Date: Wed, 30 Sep 2026 17:05:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5yXR8vN0NdiHWRTbGOsrqrVxZFd9g9QdaZGhdLR=BA7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx3c5s0LxqWe4mAA--.17039S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JrWUKryDJw4rtw47JFyrGrX_yoW7ur17pr
	WUAa98CF4UGr1UGr1Ivwn8XF1xtr4xKw1Fgr1UtFyUCwn0vry5Xr18Jr4DuF1DJw48G3WI
	qF45G34av3WUAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4s2-UUUUU



On 2026/9/30 下午4:52, Huacai Chen wrote:
> On Wed, Sep 30, 2026 at 10:33 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/9/30 上午10:24, Huacai Chen wrote:
>>> On Wed, Sep 30, 2026 at 9:53 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>>
>>>>
>>>> On 2026/9/29 下午8:43, Huacai Chen wrote:
>>>>> Hi, Tao,
>>>>>
>>>>> On Tue, Sep 29, 2026 at 6:29 PM Tao Cui <cui.tao@linux.dev> wrote:
>>>>>>
>>>>>> From: Tao Cui <cuitao@kylinos.cn>
>>>>>>
>>>>>> KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT has no guard against repeated
>>>>>> invocation: every call overwrites pch_pic_base and registers the same
>>>>>> kvm_io_device on the MMIO bus at the new address, while
>>>>>> kvm_pch_pic_destroy() unregisters only one bus range.  After a repeated
>>>>>> init, MMIO to the stale ranges computes its register offset against the
>>>>>> new base and silently reads 0 / drops writes, and the leftover bus
>>>>>> entries persist until the VM is destroyed.
>>>>>>
>>>>>> Reject repeated initialization with -EEXIST, tracking the state with
>>>>>> a has_init flag so the check and the MMIO base update are atomic
>>>>>> under slots_lock.  The base is only committed after a successful bus
>>>>>> registration, and the real registration error is propagated instead
>>>>>> of being replaced with -EFAULT.
>>>>>>
>>>>>> Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and write functions")
>>>>>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>>>>>> ---
>>>>>>     arch/loongarch/include/asm/kvm_pch_pic.h |  1 +
>>>>>>     arch/loongarch/kvm/intc/pch_pic.c        | 12 ++++++++++--
>>>>>>     2 files changed, 11 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch/include/asm/kvm_pch_pic.h
>>>>>> index 887b0431fd20..679132d840e6 100644
>>>>>> --- a/arch/loongarch/include/asm/kvm_pch_pic.h
>>>>>> +++ b/arch/loongarch/include/asm/kvm_pch_pic.h
>>>>>> @@ -53,6 +53,7 @@ struct loongarch_pch_pic {
>>>>>>            spinlock_t lock;
>>>>>>            struct kvm *kvm;
>>>>>>            struct kvm_io_device device;
>>>>>> +       bool has_init;
>>>>>>            union pch_pic_id id;
>>>>>>            uint64_t mask; /* 1:disable irq, 0:enable irq */
>>>>>>            uint64_t htmsi_en; /* 1:msi */
>>>>>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
>>>>>> index 7a704f18880d..a884a043feef 100644
>>>>>> --- a/arch/loongarch/kvm/intc/pch_pic.c
>>>>>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
>>>>>> @@ -282,16 +282,24 @@ static int kvm_pch_pic_init(struct kvm_device *dev, u64 addr)
>>>>>>            struct kvm_io_device *device;
>>>>>>            struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
>>>>> Why so complicated? The below is enough, no?
>>>>>
>>>>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c
>>>>> b/arch/loongarch/kvm/intc/pch_pic.c
>>>>> index 2b63b0c2c7ce..7855d78304b7 100644
>>>>> --- a/arch/loongarch/kvm/intc/pch_pic.c
>>>>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
>>>>> @@ -281,6 +281,9 @@ static int kvm_pch_pic_init(struct kvm_device
>>>>> *dev, u64 addr)
>>>>>            struct kvm_io_device *device;
>>>>>            struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
>>>>>
>>>>> +       if (s->device->ops)
>>>>> +               return -EEXIST;
>>>> This can work, however I think that it is not a good idea to access
>>>> internal structure field about kvm_io_device. If so, there is no use
>>>> about API kvm_iodevice_init(), just s->device->ops = &kvm_pch_pic_ops is ok.
>>> I'm a little not agree. :)
>>>
>>> I think kvm_iodevice_init() is designed to do more work rather than
>>> just set the ops (though it just set the ops now), otherwise its name
>>> should be kvm_iodevice_set_ops().
>>>
>>> In addition, even if kvm_iodevice_init() is really a setter, there is
>>> no getter for the ops, so when we need to access ops, we can only
>>> open-code it.
>> if so, you can try to add kvm_iodevice_get_ops API and check the
>> response of KVM community.
> There is not a setter, so I don't think a getter is necessary.
why setter is necessary, getter is not necessary.
> 
> Moreover, you said "no other architectures directly access ops", but
> in fact, __vgic_doorbell_to_its() from arch/arm64/kvm/vgic/vgic-its.c
> directly accesses ops.
If it is used by others, I have no objection any more. But for me I 
never write such code.

> 
> 
> Huacai
> 
>>
>> Regards
>> Bibo Mao
>>>
>>>
>>> Huacai
>>>
>>>>
>>>> If adding has_init is redundant, maybe we can set s->pch_pic_base with
>>>> INVALID_GPA in kvm_pch_pic_create() or some other methods. However I
>>>> think directly accessing kvm_io_device::ops is not a good method, no
>>>> other architectures do in such way.
>>>>
>>>> Regards
>>>> Bibo Mao
>>>>> +
>>>>>            s->pch_pic_base = addr;
>>>>>            device = &s->device;
>>>>>            /* init device by pch pic writing and reading ops */
>>>>>
>>>>>>
>>>>>> -       s->pch_pic_base = addr;
>>>>>>            device = &s->device;
>>>>>>            /* init device by pch pic writing and reading ops */
>>>>>>            kvm_iodevice_init(device, &kvm_pch_pic_ops);
>>>>>>            mutex_lock(&kvm->slots_lock);
>>>>>> +       if (s->has_init) {
>>>>>> +               ret = -EEXIST;
>>>>>> +               goto out;
>>>>>> +       }
>>>>>>            /* register pch pic device */
>>>>>>            ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_SIZE, device);
>>>>>> +       if (!ret) {
>>>>>> +               s->pch_pic_base = addr;
>>>>>> +               s->has_init = true;
>>>>>> +       }
>>>>>> +out:
>>>>>>            mutex_unlock(&kvm->slots_lock);
>>>>>>
>>>>>> -       return (ret < 0) ? -EFAULT : 0;
>>>>>> +       return ret;
>>>>>>     }
>>>>>>
>>>>>>     /* used by user space to get or set pch pic registers */
>>>>>> --
>>>>>> 2.43.0
>>>>>>
>>>>
>>
>>

