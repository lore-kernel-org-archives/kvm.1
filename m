Received: from mta0.migadu.com (out-250.mta0.migadu.com [91.218.175.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA32EDD78
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 05:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954654; cv=none; b=KQ5liTMgnKX8MesOBiXSHLd3rJpcDF4gdrly3fhtV4t20Ub8jL5KT1OeoU3PUrQpVNbsfXmVIa3pQ/gGu3DjitBsVvghkYZIUiMJBftfdIODHnZaWbjemJhlq6Srw/GOcxOu6qcTuBOyFbOmpSosp1Zp5oqkv7nK6KjB4zx1R8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954654; c=relaxed/simple;
	bh=RtuI7Dj4/PXHxX8N0ZDL2kdIdG3sQ4Wlhpl0DMBjxlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVyiQmzIJUGYP0XUjhoeWcv3Gtvbcf2/AnVjI6uJ9Ce2pX+1+DQO4C5Ur5DqAvV+TDe+/At9ODgyPxfQJ7gdpysUjZA+aWLWcRQL2WU7rQM6VvR5/xzxZ4i6c+1oe9/HDvkERXnaEWdLk6n9JvBRYXHKq53+9ny+8hcHa/+7C4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GFVLLvhT; arc=none smtp.client-ip=91.218.175.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GFVLLvhT"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RtuI7Dj4/PXHxX8N0ZDL2kdIdG3sQ4Wlhpl0DMBjxlU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791954648; v=1; x=1792559448;
 b=GFVLLvhTXlRLPtYUpXhx8WhVXbYVShZRm73Wq3td5qywqB6HWFXiSG0pIeNgFVvOWkn2qzv9
 u04aZdtSvjAGSvZKxUfM/fpTrJ+tkzXWR0zHa8s80fygMpZ66RPrQlQ5v2ySfEGTaT+i9xr4mbL
 VmGBZdWe7xaomkEea9lFiPUc=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2e0bdaf4ec1a1ef7;
	Wed, 14 Oct 2026 05:10:48 +0000
X-Mizu-Trace-ID: 2e0bdaf4ec1a1ef7
X-Migadu-Flow: FLOW_OUT
Message-ID: <d01c6c89-69db-4ed1-b520-52b61d83da02@linux.dev>
Date: Wed, 14 Oct 2026 13:10:38 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
To: Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>
Cc: gaosong@loongson.cn, zhaotianrui@loongson.cn, loongarch@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
References: <20260929102821.36112-1-cui.tao@linux.dev>
 <20260929102821.36112-5-cui.tao@linux.dev>
 <CAAhV-H5GNKZSjB_MN2Vi7uhbf1q9nqqvsfwqF+THpkwk3dEhGQ@mail.gmail.com>
 <9a59af62-3e8a-12f5-4e6c-38c1953adb37@loongson.cn>
 <CAAhV-H6cgiMQn=1oct6KHaLADwWQJ7Ow3iT14_Gj5BQxMW22Sg@mail.gmail.com>
 <be33489e-fec4-ba52-45d9-6323b14da593@loongson.cn>
 <CAAhV-H5yXR8vN0NdiHWRTbGOsrqrVxZFd9g9QdaZGhdLR=BA7A@mail.gmail.com>
 <3aada818-e1e1-a802-2547-b8e41618df32@loongson.cn>
 <CAAhV-H4YrpPmQw=qsp1GqdD5tyG6k+-tBe4g1Y-HO5kgEyu4dA@mail.gmail.com>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <CAAhV-H4YrpPmQw=qsp1GqdD5tyG6k+-tBe4g1Y-HO5kgEyu4dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Huacai

在 2026/10/12 14:37, Huacai Chen 写道:
> On Wed, Sep 30, 2026 at 5:03 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/9/30 下午4:52, Huacai Chen wrote:
>>> On Wed, Sep 30, 2026 at 10:33 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>>
>>>>
>>>> On 2026/9/30 上午10:24, Huacai Chen wrote:
>>>>> On Wed, Sep 30, 2026 at 9:53 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2026/9/29 下午8:43, Huacai Chen wrote:
>>>>>>> Hi, Tao,
>>>>>>>
>>>>>>> On Tue, Sep 29, 2026 at 6:29 PM Tao Cui <cui.tao@linux.dev> wrote:
>>>>>>>>
>>>>>>>> From: Tao Cui <cuitao@kylinos.cn>
>>>>>>>>
>>>>>>>> KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT has no guard against repeated
>>>>>>>> invocation: every call overwrites pch_pic_base and registers the same
>>>>>>>> kvm_io_device on the MMIO bus at the new address, while
>>>>>>>> kvm_pch_pic_destroy() unregisters only one bus range.  After a repeated
>>>>>>>> init, MMIO to the stale ranges computes its register offset against the
>>>>>>>> new base and silently reads 0 / drops writes, and the leftover bus
>>>>>>>> entries persist until the VM is destroyed.
>>>>>>>>
>>>>>>>> Reject repeated initialization with -EEXIST, tracking the state with
>>>>>>>> a has_init flag so the check and the MMIO base update are atomic
>>>>>>>> under slots_lock.  The base is only committed after a successful bus
>>>>>>>> registration, and the real registration error is propagated instead
>>>>>>>> of being replaced with -EFAULT.
>>>>>>>>
>>>>>>>> Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and write functions")
>>>>>>>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>>>>>>>> ---
>>>>>>>>     arch/loongarch/include/asm/kvm_pch_pic.h |  1 +
>>>>>>>>     arch/loongarch/kvm/intc/pch_pic.c        | 12 ++++++++++--
>>>>>>>>     2 files changed, 11 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch/include/asm/kvm_pch_pic.h
>>>>>>>> index 887b0431fd20..679132d840e6 100644
>>>>>>>> --- a/arch/loongarch/include/asm/kvm_pch_pic.h
>>>>>>>> +++ b/arch/loongarch/include/asm/kvm_pch_pic.h
>>>>>>>> @@ -53,6 +53,7 @@ struct loongarch_pch_pic {
>>>>>>>>            spinlock_t lock;
>>>>>>>>            struct kvm *kvm;
>>>>>>>>            struct kvm_io_device device;
>>>>>>>> +       bool has_init;
>>>>>>>>            union pch_pic_id id;
>>>>>>>>            uint64_t mask; /* 1:disable irq, 0:enable irq */
>>>>>>>>            uint64_t htmsi_en; /* 1:msi */
>>>>>>>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
>>>>>>>> index 7a704f18880d..a884a043feef 100644
>>>>>>>> --- a/arch/loongarch/kvm/intc/pch_pic.c
>>>>>>>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
>>>>>>>> @@ -282,16 +282,24 @@ static int kvm_pch_pic_init(struct kvm_device *dev, u64 addr)
>>>>>>>>            struct kvm_io_device *device;
>>>>>>>>            struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
>>>>>>> Why so complicated? The below is enough, no?
>>>>>>>
>>>>>>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c
>>>>>>> b/arch/loongarch/kvm/intc/pch_pic.c
>>>>>>> index 2b63b0c2c7ce..7855d78304b7 100644
>>>>>>> --- a/arch/loongarch/kvm/intc/pch_pic.c
>>>>>>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
>>>>>>> @@ -281,6 +281,9 @@ static int kvm_pch_pic_init(struct kvm_device
>>>>>>> *dev, u64 addr)
>>>>>>>            struct kvm_io_device *device;
>>>>>>>            struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
>>>>>>>
>>>>>>> +       if (s->device->ops)
>>>>>>> +               return -EEXIST;
>>>>>> This can work, however I think that it is not a good idea to access
>>>>>> internal structure field about kvm_io_device. If so, there is no use
>>>>>> about API kvm_iodevice_init(), just s->device->ops = &kvm_pch_pic_ops is ok.
>>>>> I'm a little not agree. :)
>>>>>
>>>>> I think kvm_iodevice_init() is designed to do more work rather than
>>>>> just set the ops (though it just set the ops now), otherwise its name
>>>>> should be kvm_iodevice_set_ops().
>>>>>
>>>>> In addition, even if kvm_iodevice_init() is really a setter, there is
>>>>> no getter for the ops, so when we need to access ops, we can only
>>>>> open-code it.
>>>> if so, you can try to add kvm_iodevice_get_ops API and check the
>>>> response of KVM community.
>>> There is not a setter, so I don't think a getter is necessary.
>> why setter is necessary, getter is not necessary.
>>>
>>> Moreover, you said "no other architectures directly access ops", but
>>> in fact, __vgic_doorbell_to_its() from arch/arm64/kvm/vgic/vgic-its.c
>>> directly accesses ops.
>> If it is used by others, I have no objection any more. But for me I
>> never write such code.
> OK, Tao, please update your code, drop the 2nd patch and simplify the
> 4th one. Thanks.
> 

I'll send v3 shortly.  It drops the dmsintc single-load patch, and the
CTRL_INIT patch now checks s->device.ops for repeated initialization
instead of the separate has_init flag.  pch_pic_base is still updated
only after successful bus registration, and the original registration
error is returned instead of -EFAULT.

Thanks for the review.
Tao

> Huacai
> 
>>
>>>
>>>
>>> Huacai
>>>
>>>>
>>>> Regards
>>>> Bibo Mao
>>>>>
>>>>>
>>>>> Huacai
>>>>>
>>>>>>
>>>>>> If adding has_init is redundant, maybe we can set s->pch_pic_base with
>>>>>> INVALID_GPA in kvm_pch_pic_create() or some other methods. However I
>>>>>> think directly accessing kvm_io_device::ops is not a good method, no
>>>>>> other architectures do in such way.
>>>>>>
>>>>>> Regards
>>>>>> Bibo Mao
>>>>>>> +
>>>>>>>            s->pch_pic_base = addr;
>>>>>>>            device = &s->device;
>>>>>>>            /* init device by pch pic writing and reading ops */
>>>>>>>
>>>>>>>>
>>>>>>>> -       s->pch_pic_base = addr;
>>>>>>>>            device = &s->device;
>>>>>>>>            /* init device by pch pic writing and reading ops */
>>>>>>>>            kvm_iodevice_init(device, &kvm_pch_pic_ops);
>>>>>>>>            mutex_lock(&kvm->slots_lock);
>>>>>>>> +       if (s->has_init) {
>>>>>>>> +               ret = -EEXIST;
>>>>>>>> +               goto out;
>>>>>>>> +       }
>>>>>>>>            /* register pch pic device */
>>>>>>>>            ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_SIZE, device);
>>>>>>>> +       if (!ret) {
>>>>>>>> +               s->pch_pic_base = addr;
>>>>>>>> +               s->has_init = true;
>>>>>>>> +       }
>>>>>>>> +out:
>>>>>>>>            mutex_unlock(&kvm->slots_lock);
>>>>>>>>
>>>>>>>> -       return (ret < 0) ? -EFAULT : 0;
>>>>>>>> +       return ret;
>>>>>>>>     }
>>>>>>>>
>>>>>>>>     /* used by user space to get or set pch pic registers */
>>>>>>>> --
>>>>>>>> 2.43.0
>>>>>>>>
>>>>>>
>>>>
>>>>
>>

