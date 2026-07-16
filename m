Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F135326B74A;
	Thu, 16 Jul 2026 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784182394; cv=none; b=BhtVL7KN0hc8jDcoFFJQczG6qNv5H/8Ty9McZ+FuhZCqALJaoH01WlUgGYSQUj83GQZwHrnIA2HCmx+7+fCgbO89HzCKfAcqldGr5RMP1MKQ9+MLXXuR/K8E4ydr70JXgNvVejSfb9n5AcYPbU+ZFxV8q0AfV/jxmNwzV/hkCrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784182394; c=relaxed/simple;
	bh=AcyjCjvCo/y2fmJcjmq9UO+DvKCgBnbhjRtUlJPxiEw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tjPXY5Kg7j8DWi7kk8L5eQJrbZJOg4KaE9e8RTr3UeJ2RLTu5Ny+PA/RboHurL2cwharndqME1WSqx6WGSB5QOr5enbieiBW1fkPUzBEQ+du3bJ69465nXEbJ4Bid1DZRr5EI9Qi1E+at8h4g+b2aqhyPVEPh0aVZSWkUpEK+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxOOt2dlhq9hYEAA--.16481S3;
	Thu, 16 Jul 2026 14:13:10 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxPsd0dlhq6qwOAA--.7879S2;
	Thu, 16 Jul 2026 14:13:10 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Allow to set pv_feature until vCPU run
To: Tao Cui <cui.tao@linux.dev>, Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260716013823.3259816-1-maobibo@loongson.cn>
 <6ea8e8dd-b65f-4ada-8376-54f207d95b3d@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <9696e097-7399-96b2-e0ae-bbb0d2f8c0d7@loongson.cn>
Date: Thu, 16 Jul 2026 14:12:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6ea8e8dd-b65f-4ada-8376-54f207d95b3d@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPsd0dlhq6qwOAA--.7879S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFyktw47Aw15Wr4UKryDArc_yoW5Kw1Upa
	s2krykWrZ5Kr12k3Wqqrn8uw1Yvr4kGr42qa45C348AF1q9ry5Cr1vkFZrZF98JwsY93WI
	gF1rt345uFn0vacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5iSdUUUUU=



On 2026/7/16 下午12:46, Tao Cui wrote:
> 
> 
> 在 2026/7/16 09:38, Bibo Mao 写道:
>> Now pv_feature can be set only once, there is problem with VM migration.
>> Where it is set when vCPU is created and after migration, here it is
>> allow to set for many times, until vCPU starts to run.
>>
> Hi Bibo,
> 
> The Sashiko AI review raised two concerns on this patch that I think
> are valid:
> 
> 1. Since ran_atleast_once is per-vCPU but pv_features is VM-wide,
>     userspace could run vCPU 0 and then use vCPU 1 (whose
>     ran_atleast_once is still false) to change pv_features while
>     vCPU 0 is executing.
> 
> 2. Without the old LOONGARCH_PV_FEAT_UPDATED latch, setting different
>     PV features on different un-run vCPUs silently overwrites
>     pv_features instead of returning -EINVAL.
> 
> Both stem from using a per-vCPU flag to protect VM-wide state.
> Would a VM-level bool in kvm_arch (e.g. pv_features_configured),
> set on first SET_ATTR or first RUN of any vCPU, work?  It would
> not be migrated since it is not exposed via any ioctl.
Now pv_features is per VM, will set it as per CPU to avoid access 
contention in next version. Consistent checking should with per CPU 
pv_features will be done in VMM, rather than KVM, similar with per CPU 
cpucfg feature.

Regards
Bibo Mao
> 
> Thanks,
> Tao
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/kvm_host.h |  4 +++-
>>   arch/loongarch/kvm/vcpu.c             | 15 +++++++++++----
>>   2 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
>> index 23cfbecebbd7..af376fc44c44 100644
>> --- a/arch/loongarch/include/asm/kvm_host.h
>> +++ b/arch/loongarch/include/asm/kvm_host.h
>> @@ -163,7 +163,6 @@ enum emulation_result {
>>   #define KVM_LARCH_SWCSR_LATEST	(0x1 << 3)
>>   #define KVM_LARCH_HWCSR_USABLE	(0x1 << 4)
>>   
>> -#define LOONGARCH_PV_FEAT_UPDATED	BIT_ULL(63)
>>   #define LOONGARCH_PV_FEAT_MASK		(BIT(KVM_FEATURE_IPI) |		\
>>   					 BIT(KVM_FEATURE_PREEMPT) |	\
>>   					 BIT(KVM_FEATURE_STEAL_TIME) |	\
>> @@ -250,6 +249,9 @@ struct kvm_vcpu_arch {
>>   	/* cpucfg */
>>   	u32 cpucfg[KVM_MAX_CPUCFG_REGS];
>>   
>> +	/* VCPU ran at least once */
>> +	bool ran_atleast_once;
>> +
>>   	/* paravirt steal time */
>>   	struct {
>>   		u64 guest_addr;
>> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
>> index 20c207d80e31..ce6a1b06d50d 100644
>> --- a/arch/loongarch/kvm/vcpu.c
>> +++ b/arch/loongarch/kvm/vcpu.c
>> @@ -1164,11 +1164,14 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
>>   		if (val & ~valid)
>>   			return -EINVAL;
>>   
>> -		/* All vCPUs need set the same PV features */
>> -		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
>> -				&& ((kvm->arch.pv_features & valid) != val))
>> +		if ((kvm->arch.pv_features & valid) == val)
>> +			return 0;
>> +
>> +		if (vcpu->arch.ran_atleast_once)
>>   			return -EINVAL;
>> -		kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
>> +
>> +		/* All vCPUs need set the same PV features */
>> +		kvm->arch.pv_features = val;
>>   		return 0;
>>   	default:
>>   		return -ENXIO;
>> @@ -1851,6 +1854,10 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>   	int r = -EINTR;
>>   	struct kvm_run *run = vcpu->run;
>>   
>> +	/* Mark this VCPU ran at least once */
>> +	if (!vcpu->arch.ran_atleast_once)
>> +		vcpu->arch.ran_atleast_once = true;
>> +
>>   	if (vcpu->mmio_needed) {
>>   		if (!vcpu->mmio_is_write)
>>   			kvm_complete_mmio_read(vcpu, run);
>>
>> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> 

