Received: from mta1.migadu.com (out-167.mta1.migadu.com [95.215.58.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFB352C3F
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730950; cv=none; b=A4z9dLCqsIY2UAVoHpB4kotgAG9uUd5PCcCi2LFkAyoCJ3x/4+wofnGKeYRbSCIlbk1NmjoRqM2iFss4HywmjHgI0yI32L1n7L/Y8tQ/Z0KtKhUZnWAkPPqtT/T2LUQfTwkNPgMkQAasYn6BQPIyvpm9ry91RJ6azzFWseZDXEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730950; c=relaxed/simple;
	bh=MjBqNXabdTSQMnOlFplCvkQG9RMUvzzDZbfRQnX+FJY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fXJHpKbS7WiOE1Dj7U36jFZqohBYTvHjao43Kzl6hjErkjmdY5PjCjEv2ZPLPcnmOyxzc7ajU5ptY4Flt76aB/eOCMgEfJIraquT74vap14kniphZK7okL4xsgWxR8UjQTRvDpmmUwwFCnyqCRubNd7U3QqlRDL7YVsbyd2o7yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qPPm8kZm; arc=none smtp.client-ip=95.215.58.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qPPm8kZm"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MjBqNXabdTSQMnOlFplCvkQG9RMUvzzDZbfRQnX+FJY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790730945; v=1; x=1791335745;
 b=qPPm8kZmDBRZ4jlRRqZ/IX9G7j61KrlyYA9/9t1pCjEfPT4RdQd6BQAEp1orIHth8Bg1+xaP
 vB8IrEa8XxQ9xxNrM9eIkwD88BWL7rrM2b2DNg13Mx/DcQUzTMMM8s+HHcqVYMEntUC5AwUGN1o
 pCAuLmD8xqVTnnlW0AcibKjM=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0370f189e27ae97e;
	Wed, 30 Sep 2026 01:15:45 +0000
X-Mizu-Trace-ID: 0370f189e27ae97e
X-Migadu-Flow: FLOW_OUT
Message-ID: <0c8125ab-9c66-42e2-87dc-208956bd4d9d@linux.dev>
Date: Wed, 30 Sep 2026 09:15:38 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, maobibo@loongson.cn, gaosong@loongson.cn,
 zhaotianrui@loongson.cn, loongarch@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2 4/4] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
To: Huacai Chen <chenhuacai@kernel.org>
References: <20260929102821.36112-1-cui.tao@linux.dev>
 <20260929102821.36112-5-cui.tao@linux.dev>
 <CAAhV-H5GNKZSjB_MN2Vi7uhbf1q9nqqvsfwqF+THpkwk3dEhGQ@mail.gmail.com>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <CAAhV-H5GNKZSjB_MN2Vi7uhbf1q9nqqvsfwqF+THpkwk3dEhGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Huacai.

在 2026/9/29 20:43, Huacai Chen 写道:
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
>>  arch/loongarch/include/asm/kvm_pch_pic.h |  1 +
>>  arch/loongarch/kvm/intc/pch_pic.c        | 12 ++++++++++--
>>  2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch/include/asm/kvm_pch_pic.h
>> index 887b0431fd20..679132d840e6 100644
>> --- a/arch/loongarch/include/asm/kvm_pch_pic.h
>> +++ b/arch/loongarch/include/asm/kvm_pch_pic.h
>> @@ -53,6 +53,7 @@ struct loongarch_pch_pic {
>>         spinlock_t lock;
>>         struct kvm *kvm;
>>         struct kvm_io_device device;
>> +       bool has_init;
>>         union pch_pic_id id;
>>         uint64_t mask; /* 1:disable irq, 0:enable irq */
>>         uint64_t htmsi_en; /* 1:msi */
>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
>> index 7a704f18880d..a884a043feef 100644
>> --- a/arch/loongarch/kvm/intc/pch_pic.c
>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
>> @@ -282,16 +282,24 @@ static int kvm_pch_pic_init(struct kvm_device *dev, u64 addr)
>>         struct kvm_io_device *device;
>>         struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
> Why so complicated? The below is enough, no?
> 
Thanks for the suggestion.

I agree that a separate has_init flag can be unnecessary here. v3 uses
s->device.ops to track whether the device has already been initialized.

The other changes are kept: pch_pic_base is updated only after
successful bus registration, and the original registration error is
returned instead of -EFAULT.

Thanks,
Tao

> diff --git a/arch/loongarch/kvm/intc/pch_pic.c
> b/arch/loongarch/kvm/intc/pch_pic.c
> index 2b63b0c2c7ce..7855d78304b7 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -281,6 +281,9 @@ static int kvm_pch_pic_init(struct kvm_device
> *dev, u64 addr)
>         struct kvm_io_device *device;
>         struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
> 
> +       if (s->device->ops)
> +               return -EEXIST;
> +
>         s->pch_pic_base = addr;
>         device = &s->device;
>         /* init device by pch pic writing and reading ops */
> 
>>
>> -       s->pch_pic_base = addr;
>>         device = &s->device;
>>         /* init device by pch pic writing and reading ops */
>>         kvm_iodevice_init(device, &kvm_pch_pic_ops);
>>         mutex_lock(&kvm->slots_lock);
>> +       if (s->has_init) {
>> +               ret = -EEXIST;
>> +               goto out;
>> +       }
>>         /* register pch pic device */
>>         ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_SIZE, device);
>> +       if (!ret) {
>> +               s->pch_pic_base = addr;
>> +               s->has_init = true;
>> +       }
>> +out:
>>         mutex_unlock(&kvm->slots_lock);
>>
>> -       return (ret < 0) ? -EFAULT : 0;
>> +       return ret;
>>  }
>>
>>  /* used by user space to get or set pch pic registers */
>> --
>> 2.43.0
>>

