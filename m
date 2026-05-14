Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C3E3112BA;
	Thu, 14 May 2026 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722407; cv=none; b=QQKr3icxP+IAFdM2yW5/Dsub1rOMaNs35QhlZJ+ZH/0UZlcEzIsmL7IB26zXeFEWbcF4dl/Jcmp6U/qJPfZhnjC4oNxmU8PQAgsMm6PVn1/r63gj9AZCZI73T2JSxLZXzWnxE9LqQZOX9OFmZFWILQUpXbgF/DlZl7u2UEawjzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722407; c=relaxed/simple;
	bh=5MuHVS0G0jXfbbdH04Q8bGHi04K5BJqqoepzfa7JuJw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f4amt0e9OFsA5qScuacMwfTu4YKLn5Rh7Ay5gTD6DVMJjulj8AmC6+NJCRTa+kMI9Xy1az2j05mxeZszE2OqWQ8MpcltYreV8awpS3bQm/A5jfAUtkA/h3HWy/Ss18UNfQIraoq0jJpWlze2fp7zq9dSYnITvCtcYRIlW8N5vtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxRelTJgVqSLIJAA--.23313S3;
	Thu, 14 May 2026 09:33:07 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxSeBPJgVqXN+BAA--.50183S3;
	Thu, 14 May 2026 09:33:05 +0800 (CST)
Subject: Re: [PATCH] KVM: selftests: Check guest memfd validity with flags
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Oliver Upton <oupton@kernel.org>,
 Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
References: <20260508015013.4108345-1-maobibo@loongson.cn>
 <agO6oLqQYQG14x6D@google.com>
 <1a5a115e-3bf3-e2bf-475a-b49f5b6e308f@loongson.cn>
 <agSCDrazxEvStSuI@google.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <5864dfa6-f2b4-427b-bd59-45edfd2c1de8@loongson.cn>
Date: Thu, 14 May 2026 09:30:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <agSCDrazxEvStSuI@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxSeBPJgVqXN+BAA--.50183S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZFyxuFWxGFW8AFW5tr1fAFc_yoWruFWxpa
	ykG3Z0gF4Utr1xXryIywn2vasYvrsxKry8C34UG345W3Z3tr1ftr48KayYkF95ZrZ2qF1a
	vFn7K3ZrZa1rtwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
	UUU==



On 2026/5/13 下午9:52, Sean Christopherson wrote:
> +Ackerley and Fuad
> 
> On Wed, May 13, 2026, Bibo Mao wrote:
>> On 2026/5/13 上午7:41, Sean Christopherson wrote:
>>> On Fri, May 08, 2026, Bibo Mao wrote:
>>>> The type of guest_memfd in structure kvm_userspace_memory_region2
>>>> is __u32, it is not correct to assign it with -1 and check whether
>>>> it is smaller than 0. Here check flags with KVM_MEM_GUEST_MEMFD
>>>> set.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>    tools/testing/selftests/kvm/lib/kvm_util.c | 4 +---
>>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>>>> index 2a76eca7029d..9d3553f7e6a5 100644
>>>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>>>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>>>> @@ -817,7 +817,7 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
>>>>    		kvm_munmap(region->mmap_alias, region->mmap_size);
>>>>    		close(region->fd);
>>>>    	}
>>>> -	if (region->region.guest_memfd >= 0)
>>>> +	if (region->region.flags & KVM_MEM_GUEST_MEMFD)
>>>
>>> Hmm, it's a bit gross, but this is probably more robust?
>>>
>>> 	if ((int)region->region.guest_memfd < 0)
>> yes, this is more direct, only that some guys in the community do not like
>> type conversion. Both are ok for me.
>>
>>>
>>> E.g. if we somehow end up in a state where KVM_MEM_GUEST_MEMFD is either stale
>>> or the guest_memfd file was already closed.  I highly doubt either of those things
>>> will happen, but logically it's the correct fix (the only reason guest_memfd is
>>> a u32 is being it's part of the kernel's uAPI).
>> Actually it probably will happen, how about something like this:
>> -       if (region->region.guest_memfd >= 0)
>> +       if ((int)region->region.guest_memfd >= 0) {
> 
> LOL, doh.  Yeah, that's what I meant.
> 
>>                  close(region->region.guest_memfd);
>> +               region->region.guest_memfd = -1;
> 
> It's funny how these sorts of things seem to come in bunches.  Can you hold off
> on this specific change, and just send a v2 for the fix?  Invalidating guest_memfd
> isn't at all necessary here, because region itself is freed shortly thereafter.
> 
> But, Ackerley and Fuad want give kvm_vm_release() the same treatment[*], at which
> point there's no good reason not to be paranoid.  I want to do that in a dedicated
> patch though, and harden "everything" in one shot.  I'll send something like the
> below.
> 
> [*] https://lore.kernel.org/all/20260511113759.610924-3-tabba@google.com
yes, it is better as a whole. Waiting for it.

Regards
Bibo Mao
> 
> diff --git tools/testing/selftests/kvm/lib/kvm_util.c tools/testing/selftests/kvm/lib/kvm_util.c
> index 2a76eca7029d..2476167252a1 100644
> --- tools/testing/selftests/kvm/lib/kvm_util.c
> +++ tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -737,6 +737,12 @@ userspace_mem_region_find(struct kvm_vm *vm, u64 start, u64 end)
>          return NULL;
>   }
>   
> +static void kvm_free_fd(int *fd)
> +{
> +       kvm_close(*fd);
> +       *fd = -1;
> +}
> +
>   static void kvm_stats_release(struct kvm_binary_stats *stats)
>   {
>          if (stats->fd < 0)
> @@ -747,8 +753,7 @@ static void kvm_stats_release(struct kvm_binary_stats *stats)
>                  stats->desc = NULL;
>          }
>   
> -       kvm_close(stats->fd);
> -       stats->fd = -1;
> +       kvm_free_fd(&stats->fd);
>   }
>   
>   __weak void vcpu_arch_free(struct kvm_vcpu *vcpu)
> @@ -777,7 +782,7 @@ static void vm_vcpu_rm(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>   
>          kvm_munmap(vcpu->run, vcpu_mmap_sz());
>   
> -       kvm_close(vcpu->fd);
> +       kvm_free_fd(&vcpu->fd);
>          kvm_stats_release(&vcpu->stats);
>   
>          list_del(&vcpu->list);
> @@ -793,8 +798,8 @@ void kvm_vm_release(struct kvm_vm *vmp)
>          list_for_each_entry_safe(vcpu, tmp, &vmp->vcpus, list)
>                  vm_vcpu_rm(vmp, vcpu);
>   
> -       kvm_close(vmp->fd);
> -       kvm_close(vmp->kvm_fd);
> +       kvm_free_fd(&vmp->fd);
> +       kvm_free_fd(&vmp->kvm_fd);
>   
>          /* Free cached stats metadata and close FD */
>          kvm_stats_release(&vmp->stats);
> @@ -815,10 +820,10 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
>          if (region->fd >= 0) {
>                  /* There's an extra map when using shared memory. */
>                  kvm_munmap(region->mmap_alias, region->mmap_size);
> -               close(region->fd);
> +               kvm_free_fd(&region->fd);
>          }
>          if (region->region.guest_memfd >= 0)
> -               close(region->region.guest_memfd);
> +               kvm_free_fd((int *)&region->region.guest_memfd);
>   
>          free(region);
>   }
> 

