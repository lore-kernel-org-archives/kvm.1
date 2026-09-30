Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5C8331202;
	Wed, 30 Sep 2026 02:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735596; cv=none; b=byhFgDoVww2Dph0OWUlblE7dLX7WRJQIppRYR50cahQXsLWM1t+06N9PZFFZwREkw6U+I4ywyY6Vt2LQgfUGRu/nkzWB7MI/ptEFHpsskwnqlOkrlNeiV1XAJbgySXQnd+nKHYr7QaUqUxsb0b+7pNpJ7KnJm3o26Nma2HJAtYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735596; c=relaxed/simple;
	bh=Wei39sd+fhRwm54SeZjfaQaaG4NdrVJfW+9LEJ/KkUc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UBsIta66p4338oXZfWSCE9ou84S5mV/pVoldoelbunaDm2Z3+n5WwNb0qOc0hr0nKt4OK5w+hYVDgHFTloJuSOAEFAPsyMc4VZW9zaSNMp9TmoYl6l5ERteRejBayDSb+tb3sLB0iUBQUDwIZr3bC9Qp04aBIMdzZ1XVD55WBpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxUNHndLxqxDQRAA--.50213S3;
	Wed, 30 Sep 2026 10:33:11 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxNs3mdLxqfNEmAA--.2965S2;
	Wed, 30 Sep 2026 10:33:11 +0800 (CST)
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
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <be33489e-fec4-ba52-45d9-6323b14da593@loongson.cn>
Date: Wed, 30 Sep 2026 10:34:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6cgiMQn=1oct6KHaLADwWQJ7Ow3iT14_Gj5BQxMW22Sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxNs3mdLxqfNEmAA--.2965S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFW7Ww45ZF4xWw13Kw4rZwc_yoW7Jr4xpr
	W8Aa98CF4DWr1xWr1Ivwn8Xr1xtr4xKw1Sgr1UAFyUCwn0vry5XFy8Jrs8u3Z5J3ykGF1I
	qF45G34Sv3WUAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
	JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r4a6rW5MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8CksDUUUUU==



On 2026/9/30 上午10:24, Huacai Chen wrote:
> On Wed, Sep 30, 2026 at 9:53 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/9/29 下午8:43, Huacai Chen wrote:
>>> Hi, Tao,
>>>
>>> On Tue, Sep 29, 2026 at 6:29 PM Tao Cui <cui.tao@linux.dev> wrote:
>>>>
>>>> From: Tao Cui <cuitao@kylinos.cn>
>>>>
>>>> KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT has no guard against repeated
>>>> invocation: every call overwrites pch_pic_base and registers the same
>>>> kvm_io_device on the MMIO bus at the new address, while
>>>> kvm_pch_pic_destroy() unregisters only one bus range.  After a repeated
>>>> init, MMIO to the stale ranges computes its register offset against the
>>>> new base and silently reads 0 / drops writes, and the leftover bus
>>>> entries persist until the VM is destroyed.
>>>>
>>>> Reject repeated initialization with -EEXIST, tracking the state with
>>>> a has_init flag so the check and the MMIO base update are atomic
>>>> under slots_lock.  The base is only committed after a successful bus
>>>> registration, and the real registration error is propagated instead
>>>> of being replaced with -EFAULT.
>>>>
>>>> Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and write functions")
>>>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>>>> ---
>>>>    arch/loongarch/include/asm/kvm_pch_pic.h |  1 +
>>>>    arch/loongarch/kvm/intc/pch_pic.c        | 12 ++++++++++--
>>>>    2 files changed, 11 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch/include/asm/kvm_pch_pic.h
>>>> index 887b0431fd20..679132d840e6 100644
>>>> --- a/arch/loongarch/include/asm/kvm_pch_pic.h
>>>> +++ b/arch/loongarch/include/asm/kvm_pch_pic.h
>>>> @@ -53,6 +53,7 @@ struct loongarch_pch_pic {
>>>>           spinlock_t lock;
>>>>           struct kvm *kvm;
>>>>           struct kvm_io_device device;
>>>> +       bool has_init;
>>>>           union pch_pic_id id;
>>>>           uint64_t mask; /* 1:disable irq, 0:enable irq */
>>>>           uint64_t htmsi_en; /* 1:msi */
>>>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
>>>> index 7a704f18880d..a884a043feef 100644
>>>> --- a/arch/loongarch/kvm/intc/pch_pic.c
>>>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
>>>> @@ -282,16 +282,24 @@ static int kvm_pch_pic_init(struct kvm_device *dev, u64 addr)
>>>>           struct kvm_io_device *device;
>>>>           struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
>>> Why so complicated? The below is enough, no?
>>>
>>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c
>>> b/arch/loongarch/kvm/intc/pch_pic.c
>>> index 2b63b0c2c7ce..7855d78304b7 100644
>>> --- a/arch/loongarch/kvm/intc/pch_pic.c
>>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
>>> @@ -281,6 +281,9 @@ static int kvm_pch_pic_init(struct kvm_device
>>> *dev, u64 addr)
>>>           struct kvm_io_device *device;
>>>           struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
>>>
>>> +       if (s->device->ops)
>>> +               return -EEXIST;
>> This can work, however I think that it is not a good idea to access
>> internal structure field about kvm_io_device. If so, there is no use
>> about API kvm_iodevice_init(), just s->device->ops = &kvm_pch_pic_ops is ok.
> I'm a little not agree. :)
> 
> I think kvm_iodevice_init() is designed to do more work rather than
> just set the ops (though it just set the ops now), otherwise its name
> should be kvm_iodevice_set_ops().
> 
> In addition, even if kvm_iodevice_init() is really a setter, there is
> no getter for the ops, so when we need to access ops, we can only
> open-code it.
if so, you can try to add kvm_iodevice_get_ops API and check the 
response of KVM community.

Regards
Bibo Mao
> 
> 
> Huacai
> 
>>
>> If adding has_init is redundant, maybe we can set s->pch_pic_base with
>> INVALID_GPA in kvm_pch_pic_create() or some other methods. However I
>> think directly accessing kvm_io_device::ops is not a good method, no
>> other architectures do in such way.
>>
>> Regards
>> Bibo Mao
>>> +
>>>           s->pch_pic_base = addr;
>>>           device = &s->device;
>>>           /* init device by pch pic writing and reading ops */
>>>
>>>>
>>>> -       s->pch_pic_base = addr;
>>>>           device = &s->device;
>>>>           /* init device by pch pic writing and reading ops */
>>>>           kvm_iodevice_init(device, &kvm_pch_pic_ops);
>>>>           mutex_lock(&kvm->slots_lock);
>>>> +       if (s->has_init) {
>>>> +               ret = -EEXIST;
>>>> +               goto out;
>>>> +       }
>>>>           /* register pch pic device */
>>>>           ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_SIZE, device);
>>>> +       if (!ret) {
>>>> +               s->pch_pic_base = addr;
>>>> +               s->has_init = true;
>>>> +       }
>>>> +out:
>>>>           mutex_unlock(&kvm->slots_lock);
>>>>
>>>> -       return (ret < 0) ? -EFAULT : 0;
>>>> +       return ret;
>>>>    }
>>>>
>>>>    /* used by user space to get or set pch pic registers */
>>>> --
>>>> 2.43.0
>>>>
>>

