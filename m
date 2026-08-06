Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846AE4772BE
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017459; cv=none; b=BjgIiY7W1p3pI+zAc4ocHrOZ17C1tYSy7QwI4QqLTkNBFqoM5E7zZgCzmORspgNhS0fpmTZLxI4GVwBAYrOX4wU0PRo1pjqFU2VRPgyTUxoHE7IHIw7YZYw2TYAWJd/vKHojRFVvYP+dyVC6+eZLdEZPbK2NnRCUXyLakKQGPIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017459; c=relaxed/simple;
	bh=26ZfCEEB41AkZZavPx8xwm6TNkfKfpHiByKlvYp3wQk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PhshQngTD2xuqHLK7zqGkoSo5y9A5WeoDM8YpSiWiEyqV50+AclhYX4tQKcnXmG6UnUQVa568CBM/q+G0iNBiyibG28HvdmL/mIELhnwsyv/BLolspws3Iuz6YUFGLekSDaxi7HZ/50tb/jaBAoT5i5B5XnWJdT1V1dtM9CJVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxvKGtdnRqV_oKAA--.11984S3;
	Thu, 06 Aug 2026 19:57:33 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxDcetdnRqOMAlAA--.6871S2;
	Thu, 06 Aug 2026 19:57:33 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: KVM: Advertise already-supported
 capabilities
To: Tao Cui <cui.tao@linux.dev>, sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260805054549.287648-1-cui.tao@linux.dev>
 <20260805060636.A0FB11F000E9@smtp.kernel.org>
 <b4343223-a221-4cc3-aee2-cb79c556bcb0@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <65365095-7758-96ae-5c7c-32200bd91867@loongson.cn>
Date: Thu, 6 Aug 2026 19:57:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b4343223-a221-4cc3-aee2-cb79c556bcb0@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxDcetdnRqOMAlAA--.6871S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GF47Wry7urWfuF4rGF4xZrc_yoW7WF47pF
	W7CasxCw48KrnFyan2qa4DuFW09r47Gry8Gas0y342v3Z09ryayFW0yrZrZF4DXwn3uw10
	ga9Yq34FvF15AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
	67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
	JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07j1q2_UUUUU=



On 2026/8/5 下午4:28, Tao Cui wrote:
> 
> Hi Bibo,
> 
> The Sashiko automated review of this patch flagged two pre-existing items
> — neither is from this patch. Wanted to get your thoughts,
> 
> 在 2026/8/5 14:06, sashiko-bot@kernel.org 写道:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] The unsafe user-access macros (`unsafe_put_user()` and `unsafe_get_user()`) are used without the required `user_access_begin()` and `user_access_end()` guards, violating the kernel API contract.
> The steal-time code uses unsafe_put_user()/unsafe_get_user() without
>     the usual user_access_begin()/end() around them. On LoongArch it
>     doesn't actually cause any trouble — there's no hardware user-access
>     protection (user_access_begin() just resolves to access_ok()),
>     __put_user is a plain store, and the ghc->hva address is already
>     validated by kvm_gfn_to_hva_cache_init(), so the access_ok() is
>     redundant anyway. So I see it more as a convention inconsistency /
>     style nit than a real bug. I'd be happy to put together a small
>     cleanup wrapping those in user_access_begin()/end() (or switching to
>     kvm_write_guest_cached()). Does that sound like just cleanup to you,
>     and would you want it?
>> - [High] A lockless read-modify-write on the shared VM state `kvm->arch.pv_features` allows userspace to bypass the validation check that requires all vCPUs to share identical PV features.
> The check-then-set on kvm->arch.pv_features in cpucfg_set_attr() is a
>     genuine TOCTOU — again pre-existing, unrelated to this patch. It's not
>     really reachable in practice: 0/3000 with two vCPUs hammering it
>     concurrently, though a debug widening of the window does reproduce it
>     every time (3000/3000). It'd basically need a userspace firing
>     KVM_SET_DEVICE_ATTR with different values on two vCPUs at once. The
>     odds are low, but I do think edge cases like this are still worth
>     fixing — happy to send a separate patch using a mutex or cmpxchg.
Happy to see the patch.

It is design problem to set pv_features per-VM, there is concurrent 
access issue and it can only be set for one time.

Regards
Bibo Mao
> 
> Neither of these affects v2 itself, so I'd leave it as-is.
> 
> Thanks,
> Tao
>> --
>>
>> --- Patch [1]: [PATCH v2] LoongArch: KVM: Advertise already-supported capabilities ---
>> commit 91e3758510b96f271c2589373d1340c246fab45a
>> Author: Tao Cui <cui.tao@linux.dev>
>>
>> LoongArch: KVM: Advertise already-supported capabilities
>>      
>> This commit advertises KVM_CAP_STEAL_TIME and KVM_CAP_VCPU_ATTRIBUTES on
>> LoongArch, making existing features discoverable to userspace.
>>
>>> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
>>> index 1317c718f896a..0a51931d6f6e0 100644
>>> --- a/arch/loongarch/kvm/vm.c
>>> +++ b/arch/loongarch/kvm/vm.c
>>> @@ -122,6 +122,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>>   	case KVM_CAP_IOEVENTFD:
>>>   	case KVM_CAP_MP_STATE:
>>>   	case KVM_CAP_SET_GUEST_DEBUG:
>>> +	case KVM_CAP_VCPU_ATTRIBUTES:
>>
>> [Severity: High]
>> This is a pre-existing issue, but does advertising KVM_CAP_VCPU_ATTRIBUTES
>> expose a data race in kvm_loongarch_cpucfg_set_attr()?
>>
>> Looking at arch/loongarch/kvm/vcpu.c, there is a lockless read-modify-write
>> sequence on the shared VM state:
>>
>> arch/loongarch/kvm/vcpu.c:kvm_loongarch_cpucfg_set_attr() {
>> ...
>> 	/* All vCPUs need set the same PV features */
>> 	if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
>> 			&& ((kvm->arch.pv_features & valid) != val))
>> 		return -EINVAL;
>> 	kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
>> ...
>> }
>>
>> If multiple threads concurrently call KVM_SET_DEVICE_ATTR on different vCPUs,
>> can they bypass this validation check by both reading before either writes,
>> resulting in divergent configurations being silently applied globally instead
>> of returning -EINVAL?
>>
>>>   		r = 1;
>>>   		break;
>>>   	case KVM_CAP_NR_VCPUS:
>>
>> [ ... ]
>>
>>> @@ -136,6 +137,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>>   	case KVM_CAP_NR_MEMSLOTS:
>>>   		r = KVM_USER_MEM_SLOTS;
>>>   		break;
>>> +	case KVM_CAP_STEAL_TIME:
>>
>> [Severity: High]
>> This isn't a bug introduced by this patch, but does advertising
>> KVM_CAP_STEAL_TIME expose an issue with unsafe memory accesses?
>>
>> In arch/loongarch/kvm/vcpu.c, unsafe_put_user() is used without the required
>> user_access_begin() and user_access_end() guards:
>>
>> arch/loongarch/kvm/vcpu.c:kvm_update_stolen_time() {
>> ...
>> 	unsafe_put_user(0, &st->preempted, out);
>> ...
>> }
>>
>> And similarly in kvm_vcpu_set_pv_preempted():
>>
>> arch/loongarch/kvm/vcpu.c:kvm_vcpu_set_pv_preempted() {
>> ...
>> 	unsafe_put_user(KVM_VCPU_PREEMPTED, &st->preempted, out);
>> ...
>> }
>>
>> Since omitting user_access_begin() skips the access_ok() check at the access
>> site, could this cause a kernel fault if hardware-enforced user access
>> protections are introduced?
>>
>>> +		r = kvm_pvtime_supported();
>>> +		break;
>>>   	default:
>>>   		r = 0;
>>>   		break;
>>

