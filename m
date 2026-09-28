Received: from mta0.migadu.com (out-72.mta0.migadu.com [91.218.175.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935AA48FF6E
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587934; cv=none; b=HJRw05UPvoDbwLrGCPgZS0xCwqc1VhGCGLjBOzr/YkG6xwoe9++vf8sPCK2xezVwtLZqIOvPlEa57jERh6RLrLVoaOd35ZU1vZf01GvCkh6FOvAGs92zfPusKKIxhD/WsxZ66kxWeX1XZ6Cu8M7kX0OVV2RMUVrGFnTClvpzGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587934; c=relaxed/simple;
	bh=/bSK2lubDnXPJRJMBandZLUxr2bVf/nnBoaIn65kMWE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AY5CDfNl/cPdodXQ6kjXocKLI6aWXRJ+4rjKpMCPyVFXvabVhV2dmvez1FqdpF27y4LRdTigClReH2khL/F3rq7EK+dDTIioHtn1ezo37NwLkup3DHvj4Vbiz3SFnoJQMseMm12gJ3rd7GKg794W5jFatX+rWfwUUzsoXxq62ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D9EE97Ud; arc=none smtp.client-ip=91.218.175.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D9EE97Ud"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/bSK2lubDnXPJRJMBandZLUxr2bVf/nnBoaIn65kMWE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790587929; v=1; x=1791192729;
 b=D9EE97UdixMUET/nixv4jdFGpn4lsz2vp6DJHF7I9olzEJvLDeX0XhZ1rTflBKupJ68p+2ay
 j/Ux1HrX8vhlZ9pXvMhqEMQd/x35HBYHzbJYuZbgUbJMZuXZReKliRoUqwKkDwy8DCO1nr3JFRF
 b2LpAzYyJ3nmxJqpjdKQw320=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a440adeeebd7c28e;
	Mon, 28 Sep 2026 09:32:09 +0000
X-Mizu-Trace-ID: a440adeeebd7c28e
X-Migadu-Flow: FLOW_OUT
Message-ID: <feee55e3-6425-4a00-9622-b809ec4f5021@linux.dev>
Date: Mon, 28 Sep 2026 17:31:59 +0800
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
Subject: Re: [PATCH 6/6] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
To: Bibo Mao <maobibo@loongson.cn>, gaosong@loongson.cn,
 zhaotianrui@loongson.cn
References: <20260927075240.3007947-1-cui.tao@linux.dev>
 <20260927075240.3007947-7-cui.tao@linux.dev>
 <d3a560db-f4f2-6cfe-6742-ca5de9f5719c@loongson.cn>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <d3a560db-f4f2-6cfe-6742-ca5de9f5719c@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/28 16:01, Bibo Mao 写道:
> 
> 
> On 2026/9/27 下午3:52, Tao Cui wrote:
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
>> Reject a repeated init with -EBUSY, a null address with -EINVAL, and
>> only set pch_pic_base after the bus registration succeeds so a failed
>> init does not leave the device half-initialized.  The registration
>> error is propagated instead of being replaced with -EFAULT.
>>
>> Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and write functions")
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>   arch/loongarch/kvm/intc/pch_pic.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
>> index 136211f154d4..2baf9ecf0c8a 100644
>> --- a/arch/loongarch/kvm/intc/pch_pic.c
>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
>> @@ -285,7 +285,10 @@ static int kvm_pch_pic_init(struct kvm_device *dev, u64 addr)
>>       struct kvm_io_device *device;
>>       struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
>>   -    s->pch_pic_base = addr;
>> +    if (!addr)
>> +        return -EINVAL;
> To detect repeated init, I think it will be better add a BOOL type variable such ready/has_init for this. In theory device with physical address 0 is possible.
> 
Thanks for the review.

Good point. Using `pch_pic_base == 0` as the initialization state mixes the device state with the configured address, a separate boolean is clearer.

>> +    if (s->pch_pic_base)
>> +        return -EBUSY;
> -EEXIST or 0 if it is created already?
> 

I also agree that `-EEXIST` is a better fit than `-EBUSY` for repeated initialization. I'll update the patch accordingly.

Thanks,
Tao> Regards
> Bibo Mao
>>       device = &s->device;
>>       /* init device by pch pic writing and reading ops */
>>       kvm_iodevice_init(device, &kvm_pch_pic_ops);
>> @@ -293,8 +296,11 @@ static int kvm_pch_pic_init(struct kvm_device *dev, u64 addr)
>>       /* register pch pic device */
>>       ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_SIZE, device);
>>       mutex_unlock(&kvm->slots_lock);
>> +    if (ret < 0)
>> +        return ret;
>>   -    return (ret < 0) ? -EFAULT : 0;
>> +    s->pch_pic_base = addr;
>> +    return 0;
>>   }
>>     /* used by user space to get or set pch pic registers */
>>
> 

