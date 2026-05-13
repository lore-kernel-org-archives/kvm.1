Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F7436493C;
	Wed, 13 May 2026 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635395; cv=none; b=LTZAj5K6XvVweyvFYt/DX8Ugw4ptJeQorkHMsrzbjVoSszCAvL2/c3tdItyKGf146HHDRH/XRtrrZU6i2AKFGTtL6EoxiUXiPGLu0Q+bZ/uQZ/i93ICIQgSgwyRJf9KvNd5pJyMyYda3D9093I7wOeUwxP+oXuOspdgNdiIWh1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635395; c=relaxed/simple;
	bh=v7pYWV/sVqY+f7alZ/9m+Vq1Jk4Dp+eb8BUdsvSm2io=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Hd8g81BiT4jFVYkUcF9V1dnuiX12OS4nen4JdbAu7F4STELdnHorJBUJbjlavSMLNa/iIKjkdEWF09B+QQtWejlsCHNmPNCieCuoqwC6yzvLhZFKl3j36ulpZht3kyGISS3kApqAAUhcL1bSAU78Lqn07Y294CFi3ca/dLVM8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxNehz0gNqmlcJAA--.22671S3;
	Wed, 13 May 2026 09:22:59 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxysFq0gNqd7aAAA--.45860S3;
	Wed, 13 May 2026 09:22:50 +0800 (CST)
Subject: Re: [PATCH] KVM: selftests: Check guest memfd validity with flags
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Oliver Upton <oupton@kernel.org>,
 Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508015013.4108345-1-maobibo@loongson.cn>
 <agO6oLqQYQG14x6D@google.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <1a5a115e-3bf3-e2bf-475a-b49f5b6e308f@loongson.cn>
Date: Wed, 13 May 2026 09:19:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <agO6oLqQYQG14x6D@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxysFq0gNqd7aAAA--.45860S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw4xtw1kXryfJFWkur47WrX_yoW8Aw4kp3
	y8GFn5Kr1ktF1xZryI9rnFqasY9FZ7Kr1xCw4UCr15uwn3tw1IyF4xKa1YkF93ZrZ3tF13
	ZF97KF93Z3WrJabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
	UUU==



On 2026/5/13 上午7:41, Sean Christopherson wrote:
> On Fri, May 08, 2026, Bibo Mao wrote:
>> The type of guest_memfd in structure kvm_userspace_memory_region2
>> is __u32, it is not correct to assign it with -1 and check whether
>> it is smaller than 0. Here check flags with KVM_MEM_GUEST_MEMFD
>> set.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   tools/testing/selftests/kvm/lib/kvm_util.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index 2a76eca7029d..9d3553f7e6a5 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -817,7 +817,7 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
>>   		kvm_munmap(region->mmap_alias, region->mmap_size);
>>   		close(region->fd);
>>   	}
>> -	if (region->region.guest_memfd >= 0)
>> +	if (region->region.flags & KVM_MEM_GUEST_MEMFD)
> 
> Hmm, it's a bit gross, but this is probably more robust?
> 
> 	if ((int)region->region.guest_memfd < 0)
yes, this is more direct, only that some guys in the community do not 
like type conversion. Both are ok for me.

> 
> E.g. if we somehow end up in a state where KVM_MEM_GUEST_MEMFD is either stale
> or the guest_memfd file was already closed.  I highly doubt either of those things
> will happen, but logically it's the correct fix (the only reason guest_memfd is
> a u32 is being it's part of the kernel's uAPI).
Actually it probably will happen, how about something like this:
-       if (region->region.guest_memfd >= 0)
+       if ((int)region->region.guest_memfd >= 0) {
                 close(region->region.guest_memfd);
+               region->region.guest_memfd = -1;
+       }

Regards
Bibo Mao

