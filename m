Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE89389115;
	Thu, 16 Jul 2026 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784182149; cv=none; b=F6tbG2y9ECkTb0NKcg/WyC3LsjkdQzU9NpP58C3gC/KD0rndmWCdqLrWzuVX9is2rbKmcf840VL6pZDyXllP/Q8Wuknms8xzkS8fRzhqTqYCYf3CrTBZG++b9RAWFRF+FaN7UYlz2jSAlBCGjBV1ybAU1WlYEapctOzidWaPDnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784182149; c=relaxed/simple;
	bh=8Dc13cT8C0WD7lesMjkVxHLB2QK+UUaqpnJ0Z36bBoQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ETUp+1pY2QJbmeuHgFR0ZA5yuR2pwPhszFlkFW2ovnAPKHqmR4eI0/yyQFW+RS9GrZzTiXdkLy4/afKwly+3667hAOLrK4N53neILrSBQE9uePApiZMvKRiXpLF0/EHALNSEDIS7JuZx1El+f2bWqYveoSPcPHlbUywHsZZel24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Axx+p6dVhqvxYEAA--.16451S3;
	Thu, 16 Jul 2026 14:08:58 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxq8R5dVhq3qsOAA--.19013S2;
	Thu, 16 Jul 2026 14:08:57 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Allow to set pv_feature until vCPU run
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Tao Cui <cui.tao@linux.dev>,
 kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260716013823.3259816-1-maobibo@loongson.cn>
 <CAAhV-H4RUWDWHRZ5FJ388e0ZcMD5VS=rPThY3kYNR+WY917i5w@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <66e63cac-7768-b33c-132e-fa0a76336e1d@loongson.cn>
Date: Thu, 16 Jul 2026 14:08:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4RUWDWHRZ5FJ388e0ZcMD5VS=rPThY3kYNR+WY917i5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxq8R5dVhq3qsOAA--.19013S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF4kCw1rWr1fuFWkZFykCrX_yoW5Xw4kpF
	92kF4DWrWrKr12k3ZFqwn09r90vr4kKr12ga4jqayFyFn09r98Wr4kKrWDZFn8JwsY93WI
	gF1rtw15uFn0yacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
	UUUUU



On 2026/7/16 下午12:27, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Thu, Jul 16, 2026 at 9:45 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Now pv_feature can be set only once, there is problem with VM migration.
>> Where it is set when vCPU is created and after migration, here it is
>> allow to set for many times, until vCPU starts to run.
>>
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
>>   #define KVM_LARCH_SWCSR_LATEST (0x1 << 3)
>>   #define KVM_LARCH_HWCSR_USABLE (0x1 << 4)
>>
>> -#define LOONGARCH_PV_FEAT_UPDATED      BIT_ULL(63)
>>   #define LOONGARCH_PV_FEAT_MASK         (BIT(KVM_FEATURE_IPI) |         \
>>                                           BIT(KVM_FEATURE_PREEMPT) |     \
>>                                           BIT(KVM_FEATURE_STEAL_TIME) |  \
>> @@ -250,6 +249,9 @@ struct kvm_vcpu_arch {
>>          /* cpucfg */
>>          u32 cpucfg[KVM_MAX_CPUCFG_REGS];
>>
>> +       /* VCPU ran at least once */
>> +       bool ran_atleast_once;
> So long a name? Maybe has_run is enough?
well, will use has_run for short.

Regards
Bibo Mao
> 
> Huacai
>> +
>>          /* paravirt steal time */
>>          struct {
>>                  u64 guest_addr;
>> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
>> index 20c207d80e31..ce6a1b06d50d 100644
>> --- a/arch/loongarch/kvm/vcpu.c
>> +++ b/arch/loongarch/kvm/vcpu.c
>> @@ -1164,11 +1164,14 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
>>                  if (val & ~valid)
>>                          return -EINVAL;
>>
>> -               /* All vCPUs need set the same PV features */
>> -               if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
>> -                               && ((kvm->arch.pv_features & valid) != val))
>> +               if ((kvm->arch.pv_features & valid) == val)
>> +                       return 0;
>> +
>> +               if (vcpu->arch.ran_atleast_once)
>>                          return -EINVAL;
>> -               kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
>> +
>> +               /* All vCPUs need set the same PV features */
>> +               kvm->arch.pv_features = val;
>>                  return 0;
>>          default:
>>                  return -ENXIO;
>> @@ -1851,6 +1854,10 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>          int r = -EINTR;
>>          struct kvm_run *run = vcpu->run;
>>
>> +       /* Mark this VCPU ran at least once */
>> +       if (!vcpu->arch.ran_atleast_once)
>> +               vcpu->arch.ran_atleast_once = true;
>> +
>>          if (vcpu->mmio_needed) {
>>                  if (!vcpu->mmio_is_write)
>>                          kvm_complete_mmio_read(vcpu, run);
>>
>> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
>> --
>> 2.39.3
>>

