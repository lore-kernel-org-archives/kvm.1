Received: from mta1.migadu.com (out-233.mta1.migadu.com [95.215.58.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B2443ABE
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137681; cv=none; b=ZXHPVeKGmLxe5iX+QWfXaPElVy4vXAMplQbGAvBla317HVbPJJZaHMAp5ZAS9GEqA6PhkTFYRyjDF2F1DDzwmr/8PjEv+DGwvRW4LJoAhx16qubOp8eqFVKkmIZOVGCviMVrqxS1zeYtY9NSOSBfARYY4A8PoPYlN9nDvWmjoyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137681; c=relaxed/simple;
	bh=njluWDIpoeZU4jBqpL6b8E6MdLPNtMq8KoaKPgk7RPQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R/NxR/xKYQVMXAZo8Ze1NFYzZpd4IwbXvwsJQ03YiYi+zO+JwxEQCeV5V4//RsF5MU7TYdjrDIvKLNa5w5lIkZqQRW395EItFGzAzbStHywRceRAVreci2lNgczvvpAN6Y8MELE0wLs2hdaMsptBncM681sYCrDAQ5vv0ZgPvIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TbH9DvlD; arc=none smtp.client-ip=95.215.58.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TbH9DvlD"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=njluWDIpoeZU4jBqpL6b8E6MdLPNtMq8KoaKPgk7RPQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792137675; v=1; x=1792742475;
 b=TbH9DvlDHtSqQReohc9BoD3r3Vt+dzXKeIvrT+7ItBCHsd26PzAKnacRmq5qwuU+UiFV+yko
 A+D5PpjZRZ/CLJrO3+vYs1p4NeNSGrAIim3sVXGG9kMKpVx400bQAM0uRn9Jp94rZyy8PdjqiVV
 m4xGJR6v3YKsQhH276mKPMbA=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5b0e9e4f0d93aed3;
	Fri, 16 Oct 2026 08:01:15 +0000
X-Mizu-Trace-ID: 5b0e9e4f0d93aed3
X-Migadu-Flow: FLOW_OUT
Message-ID: <3747972d-0133-4542-a314-40ff1c688937@linux.dev>
Date: Fri, 16 Oct 2026 16:01:06 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, loongarch@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v4 3/3] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
To: Bibo Mao <maobibo@loongson.cn>, chenhuacai@kernel.org,
 zhaotianrui@loongson.cn
References: <20261015234638.1077815-1-cui.tao@linux.dev>
 <20261015234638.1077815-4-cui.tao@linux.dev>
 <bd455df4-49e8-c80c-a5cc-b0feabeb3262@loongson.cn>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <bd455df4-49e8-c80c-a5cc-b0feabeb3262@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi，Bibo

在 2026/10/16 9:31, Bibo Mao 写道:
> 
> 
> On 2026/10/16 上午7:46, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT has no guard against repeated
>> invocation: every call overwrites pch_pic_base and registers the same
>> kvm_io_device on the MMIO bus at the new address, while
>> kvm_pch_pic_destroy() unregisters only one bus range.  After a repeated
>> init, MMIO to the stale ranges computes its register offset against the
>> new base and silently reads 0 / drops writes, and the leftover bus
>> entries persist until the VM is destroyed.
>>
>> Reject repeated initialization with -EEXIST, using the initialized
>> state of the kvm_io_device as the indicator.  The check, the MMIO base
>> update and the bus registration are serialized by slots_lock, and the
>> real registration error is propagated instead of being replaced with
>> -EFAULT.
>>
>> Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and write functions")
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>   arch/loongarch/kvm/intc/pch_pic.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
>> index 51e4a6a39dc0..a4c35ed704be 100644
>> --- a/arch/loongarch/kvm/intc/pch_pic.c
>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
>> @@ -281,16 +281,21 @@ static int kvm_pch_pic_init(struct kvm_device *dev, u64 addr)
>>       struct kvm_io_device *device;
>>       struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
>>   -    s->pch_pic_base = addr;
>>       device = &s->device;
>> +    mutex_lock(&kvm->slots_lock);
>> +    if (s->device.ops) {
>> +        ret = -EEXIST;
>> +        goto out;
>> +    }
>> +    s->pch_pic_base = addr;
>>       /* init device by pch pic writing and reading ops */
>>       kvm_iodevice_init(device, &kvm_pch_pic_ops);
>> -    mutex_lock(&kvm->slots_lock);
>>       /* register pch pic device */
>>       ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_SIZE, device);
>> +out:
>>       mutex_unlock(&kvm->slots_lock);
> one small nit, what to do if there is failure with kvm_io_bus_register_dev()?  clear s->pch_pic_base and  s->device.ops?
> 

I missed this.  You're right. On the failure path I should undo the
state set before kvm_io_bus_register_dev(). I'll fix that in the next
revision.

Thanks，
Tao

> Regards
> Bibo Mao
>>   -    return (ret < 0) ? -EFAULT : 0;
>> +    return ret;
>>   }
>>     /* used by user space to get or set pch pic registers */
>>
> 

