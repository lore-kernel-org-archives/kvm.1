Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6530FCA45;
	Wed,  8 Apr 2026 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610240; cv=none; b=L7gEpR+sLVV3nrGK/oV/prwFTidfmQ7lKsw0RA3gCyGLWeuGYO5X2wejYQthJHU8JvHe/Jof2t51bVrH6go6ok6PPx5nn5gaN9hlvmFgD1N0ef2YUnX2+C4VrdNlWhOdceEFq27qAVEsq8j5qTVi6olxemGTrGhhwoZ6bxC4QS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610240; c=relaxed/simple;
	bh=8NqEU9FkcBMXQ+qXJMOdmsRa9zcwZrjIfNvP+Qkd/Dg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eJTgtiKR1nbLhBIHUoUGEKGUzxYFbH7+yUYpos6+5UaKdf5n95v9qlxmF1bngSShVm4HCI9MSDi+/528fou2pFvZY8Xs3FZ5H/Z2atkyH8ARNwKCVNKEwfYLzEmnR3oDb2OvYg72yFtXxpuiCQO4Y2LRcJTgTYF+js9OOrkWfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Cx48B5qdVpM_kiAA--.38032S3;
	Wed, 08 Apr 2026 09:03:53 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxquB4qdVp8_9nAA--.1286S3;
	Wed, 08 Apr 2026 09:03:53 +0800 (CST)
Subject: Re: [PATCH v2 0/6] LoongArch: KVM: Set max VM supported FPU type with
 FPU exception
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260330035832.2204720-1-maobibo@loongson.cn>
 <CAAhV-H4Ws3Y89XfSXdGpm3BL5Pr5kTzC0NPdkDm17uy3ZEZJmA@mail.gmail.com>
 <CAAhV-H7UP5TZh5zaqtkAboUt226-vGUBddksYXxafdKOioVngQ@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <61d0efa7-a15a-be48-3bca-5be5efd99acf@loongson.cn>
Date: Wed, 8 Apr 2026 09:01:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7UP5TZh5zaqtkAboUt226-vGUBddksYXxafdKOioVngQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxquB4qdVp8_9nAA--.1286S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFWfAFyxZFykCw4DGr43twc_yoW5Aw4xpF
	ZxC3WSkFs5Jr1xur92g3W5WF1Ygr1xXry0g3sIgr4jvr90vryrXr4rtFZY9FyUA3s5tFy0
	vF40yF97A3WUA3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUU
	UUU==



On 2026/4/7 下午8:41, Huacai Chen wrote:
> On Mon, Mar 30, 2026 at 6:00 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>>
>> Hi, Bibo,
>>
>>
>> On Mon, Mar 30, 2026 at 11:58 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>
>>> With FPU save and restore flow, the cost is the same with different
>>> FPU width 8/16/32 bytes, whatever from CPU cycle and cache line impaction.
>>>
>>> Here is to enable FPU with max VM supported type, for example if
>>> VM supports LASX instrction, enable FPU with LASX type even with FPU
>>> exeception. So it can avoid possible LSX/LASX exception in future.
>>>
>>> With context switch microbench which may touch FPU and LASX, there is 9%
>>> improvement when halt_poll_ns is disabled. The command is
>>> "./context --test=pipe" and source code located at:
>>>    https://github.com/bibo-mao/context_switch/blob/main/context.c
>>>
>>> Original     Wih patch      improvement
>>> 75232        82440          9%
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>> v1 ... v2:
>>>    1. Enable FPU with max VM supported FPU type, rather than max used type.
>>>    2. Add new request bit KVM_REQ_LBT_LOAD for LBT restore
>>>    3. Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
>>>    3. Remove aux_ldtype and KVM_LARCH_LSX/KVM_LARCH_LSX
>>>    4. Remove middle FPU state handling in kvm_own_lsx() and kvm_own_lasx(),
>>>       directly enable LSX or LASX from FPU none state.
>>> ---
>>> Bibo Mao (6):
>>>    LoongArch: KVM: Add separate KVM_REQ_LBT_LOAD request bit
>>>    LoongArch: KVM: Enable FPU with max VM supported FPU type
>>>    LoongArch: KVM: Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
>> Patch-1 add KVM_REQ_LBT_LOAD, then KVM_REQ_AUX_LOAD is only for FPU,
>> so I think Patch-3 should be squashed into Patch-1.
>>
>>>    LoongArch: KVM: Remove some middle FPU states
>>>    LoongArch: KVM: Use vm_guest_has_fpu API in kvm_lose_fpu()
>>>    LoongArch: KVM: Remove KVM_LARCH_LASX and KVM_LARCH_LSX
>> Patch-5 remove the consumer side of KVM_LARCH_LASX / KVM_LARCH_LSX and
>> Patch-6 remove the provider side of KVM_LARCH_LASX / KVM_LARCH_LSX, so
>> I think Patch-6 should be squashed into Patch-5, too.
> And could you please test the power consumption where there are many
> VMs that only use FPU rather than LSX/LASX? As far as I know, the
Hi Huacai,

Thanks for reviewing this patch
Could you help me to test the power consumption with this patch?
> power consumption of LASX is significantly more than FPU, which is a
Could the describe the detail scenery wheree LASX instruction is 
frequently used by application or LASX  EUEN enabled?

Regards
Bibo Mao
> little similar to AVX512 (Linus said it is a power virus).
> 
> Huacai
> 
>>
>>
>> Huacai
>>
>>>
>>>   arch/loongarch/include/asm/kvm_host.h |  6 +--
>>>   arch/loongarch/kvm/exit.c             | 21 +++-----
>>>   arch/loongarch/kvm/vcpu.c             | 78 ++++++++-------------------
>>>   3 files changed, 30 insertions(+), 75 deletions(-)
>>>
>>>
>>> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
>>> --
>>> 2.39.3
>>>
>>>

