Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF34D306756
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 05:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785907143; cv=none; b=KfAIlK2nM3BcmlUQ3LbzajLN9LPKQh2YMhr9Rm2TQZrpCpT2+8un8zyBiERJyK6WDWV34ogOzsi0VTf6scL1e1p7X/uL4EYUW9y4WNjzsRLnkuJ9B/4WDA4l/XxGQZyExa9qtROlmervJcQ1Os1ZGIfubxIh2b4PMR6CHu9L+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785907143; c=relaxed/simple;
	bh=PcDBnefaEdDxA8vP4W6/rjsnqlkfA97pC9iCNbNi31Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xh+j6RbeK6UoQJZNG9ej+xvk2ybOfBQhLF+jaujr2n3AFKhd7yvoUuGiVU1gUHHRP6SkZAEnn2eadmY5tYMZrgyrrHRmSnPoch6Ym00wzud0PUPUqABRCnyeH5cSFohH7GgL8ziA0cWYSrKqxenJYEs17mx7u6LsUHrLxHFErDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ka/2qWXo; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ka/2qWXo"
Message-ID: <2823cc0d-28ef-400f-8bfd-630ba42b6a1f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785907139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIrogOR+8g7xIWc+bjs18umStIjGg7noWLPQtxKjHug=;
	b=Ka/2qWXowox57vvR+3HzIT7KMRnZ6ErN370lCMhMbUWYXzz5NNtKOwCcyO/2BzvUKXy3+D
	j2xKy3tV97TYufIAmAzxJHAm003JnjIXiIVnq/4m+VvVmBYv6ebHI3LJ7QnFI0lzMMLL2r
	OJctcUXhtwoema3u89mwBrfMc6S34ic=
Date: Wed, 5 Aug 2026 13:18:53 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, chenhuacai@kernel.org, kernel@xen0n.name,
 kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: KVM: Advertise already-supported capabilities
To: Bibo Mao <maobibo@loongson.cn>, zhaotianrui@loongson.cn
References: <20260804082604.178092-1-cui.tao@linux.dev>
 <5bbfd376-d3e2-e62a-f07d-9a4ee0635780@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <5bbfd376-d3e2-e62a-f07d-9a4ee0635780@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


Hi Bibo,
在 2026/8/5 10:36, Bibo Mao 写道:
> On 2026/8/4 下午4:26, Tao Cui wrote:
>> Several LoongArch KVM features are fully implemented but were never
>> reported through their standard KVM_CHECK_EXTENSION probes, so userspace
>> cannot discover them and either ignores them or takes a slower path.
>> Advertise the ones that already work:
>>
>>    - KVM_CAP_STEAL_TIME: steal time is fully implemented (host-side
>>      record plus guest paravirt), gated on kvm_pvtime_supported().
>>
>>    - KVM_CAP_IRQFD_RESAMPLE: the resampler is generic code backed by the
>>      in-kernel irqchip; advertise it so userspace can use irqfd with
>>      resample for level-triggered interrupts.
>>
>>    - KVM_CAP_VM_GPA_BITS: the guest physical address width is already
>>      computed as BIT(cpu_vabits), so return cpu_vabits directly.
>>
>>    - KVM_CAP_VCPU_ATTRIBUTES: per-vCPU device-attribute ioctls are
>>      implemented (CPUCFG, PVTIME control); advertise the discovery cap.
>>
>> This adds no new functionality; it only makes existing features
>> discoverable via the standard probe.
>>

Thanks for the careful review — you are right on both points.

I must admit I was a bit hasty here. I only verified that the probes
returned nonzero on a 3A6000 and didn't dig into what the capabilities
actually guarantee or who consumes them. The return values looked fine,
so the details you raised slipped through.

>> Signed-off-by: Tao Cui <cui.tao@linux.dev>
>> ---
>>   arch/loongarch/kvm/vm.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
>> index 1317c718f896..d7dd08d9be5b 100644
>> --- a/arch/loongarch/kvm/vm.c
>> +++ b/arch/loongarch/kvm/vm.c
>> @@ -120,8 +120,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>       case KVM_CAP_READONLY_MEM:
>>       case KVM_CAP_IMMEDIATE_EXIT:
>>       case KVM_CAP_IOEVENTFD:
>> +    case KVM_CAP_IRQFD_RESAMPLE:
> By my understanding, KVM_CAP_IRQFD_RESAMPLE is used for VFIO intx irqline interrupt injection, is that true? now IOMMU and VFIO is not supported on LoongArch.
> 
You're right. The real consumer is VFIO INTx level-interrupt passthrough,
and without IOMMU/VFIO there is no current LoongArch userspace that
would use irqfd + resample. I'll drop it for now and revisit it together
with VFIO/IOMMU support.
>>       case KVM_CAP_MP_STATE:
>>       case KVM_CAP_SET_GUEST_DEBUG:
>> +    case KVM_CAP_VCPU_ATTRIBUTES:
> this is ok.
>>           r = 1;
>>           break;
>>       case KVM_CAP_NR_VCPUS:
>> @@ -136,6 +138,12 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>       case KVM_CAP_NR_MEMSLOTS:
>>           r = KVM_USER_MEM_SLOTS;
>>           break;
>> +    case KVM_CAP_STEAL_TIME:
>> +        r = kvm_pvtime_supported();
>> +        break;
> this is ok.
> 
>> +    case KVM_CAP_VM_GPA_BITS:
>> +        r = cpu_vabits;
> Feature KVM_CAP_VM_GPA_BITS is also to control max supported GPA bit of VM, only only max supported PA bit on host. For example max PA bit is 48 on host, it is ok to set GPA bit with 40 or 48, only if it is smaller than one on host.
> If my understanding is correct, it is not supported on LoongArch now.
> 
Agreed, and thanks for catching this. I overlooked that the capability is
paired with a setter — on riscv, cap->args[0] lets userspace choose the
VM GPA width by selecting the stage-2 pgd levels. LoongArch's GPA width
is fixed at BIT(cpu_vabits) and that configurability is not implemented,
so advertising the cap would be misleading. Dropped.

v2 advertises only KVM_CAP_STEAL_TIME and KVM_CAP_VCPU_ATTRIBUTES (both
sanity-checked on 3A6000: they go 0 -> 1).

Thanks,
Tao
> Regards
> Bibo Mao
>> +        break;
>>       default:
>>           r = 0;
>>           break;
>>
> 

