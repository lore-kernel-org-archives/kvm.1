Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44EF1A680C;
	Tue,  2 Jun 2026 04:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375739; cv=none; b=eAqEftX90X43yxkaIRFEKZ7EkpIfYdgK7VMFMXa5CZJ4gRASq99EE0XJBtjAaldWetqq3art9FNQZhN8Ocoddel0gSzaGwemmQWgSiVhuwf8Ey4C94dg+ncpVSs/VLAa64q0aRS9T7Kb5sj7kaoOv/9NR8Xi2Jf411FJRLsfxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375739; c=relaxed/simple;
	bh=KdE1++qvdfYKOTUNCFDoahmM6lKV1lR3RX/VwFrRpWg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VgDerOtX0TKXC8/bed/ABuuYxnwTfjvGxUZxzyaCV/Uto1hxrtYNEt+8eVc7HojYSYMg4oTnhBYFpk3sRlEkucizE2wrACjT1tp5TYm8zqLfMkO8+mPHV+D+tZ0Fuz9Ikuzlcx0j1T1bjnAXgn8gDhAfWyKzMWJ6tGBgGum90TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxhumzYB5qqZsPAA--.43600S3;
	Tue, 02 Jun 2026 12:48:52 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxOMGxYB5q8PCYAA--.13770S3;
	Tue, 02 Jun 2026 12:48:49 +0800 (CST)
Subject: Re: [PATCH v2 0/6] LoongArch: KVM: Set max VM supported FPU type with
 FPU exception
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260330035832.2204720-1-maobibo@loongson.cn>
 <CAAhV-H4Ws3Y89XfSXdGpm3BL5Pr5kTzC0NPdkDm17uy3ZEZJmA@mail.gmail.com>
 <CAAhV-H7UP5TZh5zaqtkAboUt226-vGUBddksYXxafdKOioVngQ@mail.gmail.com>
 <61d0efa7-a15a-be48-3bca-5be5efd99acf@loongson.cn>
 <CAAhV-H4+A0bs07v4B8BTCqbNsG5SLSjjx8sh5Lz23i+R37RAKw@mail.gmail.com>
 <74e8fa9e-90f6-175e-fb98-2e4504d5f15d@loongson.cn>
 <CAAhV-H7WnvO80sQoQLpgnomobkB7Zu5F4rgXxsj5ErymukQ+9A@mail.gmail.com>
 <b1b07f90-3db3-c3ff-2297-f8eaaa3f6faa@loongson.cn>
 <CAAhV-H7+Jk_MoDyVVe5mG8LQMoeJXnK9j4B4Si9NmA--GF1tdg@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <27b6f9ad-367f-d307-0125-cfa1adcf3e11@loongson.cn>
Date: Tue, 2 Jun 2026 12:45:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7+Jk_MoDyVVe5mG8LQMoeJXnK9j4B4Si9NmA--GF1tdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxOMGxYB5q8PCYAA--.13770S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuw17Jw17Jw1rJr1DZF43Arc_yoW7ZF47pr
	W7JF1jyF4DJr1xArnrtw1UWr1Yqr1UJr10qrn8Xr1UJr90vry5Jr18tr1Y9FyUJ34rJr1j
	vrWUtr17XF1UArgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
	JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8TqcUUUUUU==



On 2026/6/2 下午12:38, Huacai Chen wrote:
> On Tue, Jun 2, 2026 at 9:23 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/6/1 下午9:52, Huacai Chen wrote:
>>> On Thu, Apr 9, 2026 at 8:14 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>>
>>>>
>>>> On 2026/4/8 下午3:47, Huacai Chen wrote:
>>>>> On Wed, Apr 8, 2026 at 9:04 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2026/4/7 下午8:41, Huacai Chen wrote:
>>>>>>> On Mon, Mar 30, 2026 at 6:00 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>>>>>>>>
>>>>>>>> Hi, Bibo,
>>>>>>>>
>>>>>>>>
>>>>>>>> On Mon, Mar 30, 2026 at 11:58 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>>>>
>>>>>>>>> With FPU save and restore flow, the cost is the same with different
>>>>>>>>> FPU width 8/16/32 bytes, whatever from CPU cycle and cache line impaction.
>>>>>>>>>
>>>>>>>>> Here is to enable FPU with max VM supported type, for example if
>>>>>>>>> VM supports LASX instrction, enable FPU with LASX type even with FPU
>>>>>>>>> exeception. So it can avoid possible LSX/LASX exception in future.
>>>>>>>>>
>>>>>>>>> With context switch microbench which may touch FPU and LASX, there is 9%
>>>>>>>>> improvement when halt_poll_ns is disabled. The command is
>>>>>>>>> "./context --test=pipe" and source code located at:
>>>>>>>>>       https://github.com/bibo-mao/context_switch/blob/main/context.c
>>>>>>>>>
>>>>>>>>> Original     Wih patch      improvement
>>>>>>>>> 75232        82440          9%
>>>>>>>>>
>>>>>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>>>>>> ---
>>>>>>>>> v1 ... v2:
>>>>>>>>>       1. Enable FPU with max VM supported FPU type, rather than max used type.
>>>>>>>>>       2. Add new request bit KVM_REQ_LBT_LOAD for LBT restore
>>>>>>>>>       3. Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
>>>>>>>>>       3. Remove aux_ldtype and KVM_LARCH_LSX/KVM_LARCH_LSX
>>>>>>>>>       4. Remove middle FPU state handling in kvm_own_lsx() and kvm_own_lasx(),
>>>>>>>>>          directly enable LSX or LASX from FPU none state.
>>>>>>>>> ---
>>>>>>>>> Bibo Mao (6):
>>>>>>>>>       LoongArch: KVM: Add separate KVM_REQ_LBT_LOAD request bit
>>>>>>>>>       LoongArch: KVM: Enable FPU with max VM supported FPU type
>>>>>>>>>       LoongArch: KVM: Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
>>>>>>>> Patch-1 add KVM_REQ_LBT_LOAD, then KVM_REQ_AUX_LOAD is only for FPU,
>>>>>>>> so I think Patch-3 should be squashed into Patch-1.
>>>>>>>>
>>>>>>>>>       LoongArch: KVM: Remove some middle FPU states
>>>>>>>>>       LoongArch: KVM: Use vm_guest_has_fpu API in kvm_lose_fpu()
>>>>>>>>>       LoongArch: KVM: Remove KVM_LARCH_LASX and KVM_LARCH_LSX
>>>>>>>> Patch-5 remove the consumer side of KVM_LARCH_LASX / KVM_LARCH_LSX and
>>>>>>>> Patch-6 remove the provider side of KVM_LARCH_LASX / KVM_LARCH_LSX, so
>>>>>>>> I think Patch-6 should be squashed into Patch-5, too.
>>>>>>> And could you please test the power consumption where there are many
>>>>>>> VMs that only use FPU rather than LSX/LASX? As far as I know, the
>>>>>> Hi Huacai,
>>>>>>
>>>>>> Thanks for reviewing this patch
>>>>>> Could you help me to test the power consumption with this patch?
>>>>>>> power consumption of LASX is significantly more than FPU, which is a
>>>>>> Could the describe the detail scenery wheree LASX instruction is
>>>>>> frequently used by application or LASX  EUEN enabled?
>>>>> The purpose is to evaluate power consumption before and after this series.
>>>>>
>>>>> So we can run 10 VMs (suppose there are 4 cores), and there is a
>>>>> workload run in every VM, the workload only uses FPU, no LSX and LASX.
>>>>> Before this series, KVM only save/restore FPU context; after this
>>>>> series, KVM will save/restore LASX context.
>>>> In theory there should be such test, only that it requires special Power
>>>> Management team and testbed. Even if there is such team, maybe they care
>>>> power consumption about DDR and screen, do not want do such experiments
>>>> for this patch.
>>>>
>>>> If someone is volunteer to do this, I do not object, also I want to get
>>>> the result. Just from my guess, there should be no much difference since
>>>> FPU context switch is much smaller than the whole workload, else the
>>>> workload is just FPU context switch.
>>> Any updates?
>> It deeps on Power Management exports.
>>
>> By cyclictest/fpubench test on 3C6000, the context switch cost is 3us,
>> the fpu save cost is 7.6ns and 7.8ns with fpu restore. FPU switch cost
>> is about 0.25% of the whole context switch. I do not why power
>> consumption is important factor here.
> I'm talking about this:
> https://lore.kernel.org/loongarch/b1b07f90-3db3-c3ff-2297-f8eaaa3f6faa@loongson.cn/T/#m6da21ae2f4abfba362a2cd189cb4d8d09e33a6d7
will do in this way.

Regards
Bibo Mao
> 
> Huacai
> 
>>
>> Regards
>> Bibo Mao
>>>
>>>
>>> Huacai
>>>>
>>>> Regards
>>>> Bibo Mao
>>>>
>>>>>
>>>>> If the power consumptions are similar, then this series is perfect.
>>>>>
>>>>> Huacai
>>>>>
>>>>>>
>>>>>> Regards
>>>>>> Bibo Mao
>>>>>>> little similar to AVX512 (Linus said it is a power virus).
>>>>>>>
>>>>>>> Huacai
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Huacai
>>>>>>>>
>>>>>>>>>
>>>>>>>>>      arch/loongarch/include/asm/kvm_host.h |  6 +--
>>>>>>>>>      arch/loongarch/kvm/exit.c             | 21 +++-----
>>>>>>>>>      arch/loongarch/kvm/vcpu.c             | 78 ++++++++-------------------
>>>>>>>>>      3 files changed, 30 insertions(+), 75 deletions(-)
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
>>>>>>>>> --
>>>>>>>>> 2.39.3
>>>>>>>>>
>>>>>>>>>
>>>>>>
>>>>>>
>>>>
>>>>
>>

