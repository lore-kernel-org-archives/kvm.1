Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F196F1E1E04
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658559; cv=none; b=PlHHky/YFzJFvDsOnPJ2OVAwu9JEvP0a9ZZtKKBfUqVsDfMsmeo41Kais7pf8kTUm1odweScYWinx8fPNw+XSA4vDjvV1FtgAOfCp2d2Vzs6YsWwZeiBgamq2aXm+NELM99iB+V2KsHbXnra4P+oOvUcidwIsbphISTv6EU5CUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658559; c=relaxed/simple;
	bh=9fkEZRYWLYLvSarlD74hRYB4ASUfJIvHt3LdfJ3zYA8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ccw550gj8LbfanETDQa1VJRIOuUOXWpRSK+mXgw7dC5gUrl1xWIPPw1RAHdA8bMEHdbUWVNmIPoBbHQaPyhCQJl7dXZnRH9ebL4SB9cN6yaLzdIGHsYpgecDagPqcB424lHFZblDnCXXmOryBogLUSdX/T6W775njev7Kff9toY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Axvem48zFqN_kUAA--.52979S3;
	Wed, 17 Jun 2026 09:09:12 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBx68Gz8zFq5MWoAA--.56092S3;
	Wed, 17 Jun 2026 09:09:10 +0800 (CST)
Subject: Re: [PATCH v4 2/3] LoongArch: KVM: Implement guest-side PV TLB flush
To: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, loongarch@lists.linux.dev
Cc: kernel@xen0n.name, kvm@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
References: <20260615082154.42144-1-cui.tao@linux.dev>
 <20260615082154.42144-3-cui.tao@linux.dev>
 <0c47ce21-9a4d-4cdc-9bec-ce749e31512e@loongson.cn>
 <1bfa4941-b94b-410a-9b64-c13f2712edf9@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <9ec9d22b-93fd-3dcb-c6b8-19563f1b7c0a@loongson.cn>
Date: Wed, 17 Jun 2026 09:05:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1bfa4941-b94b-410a-9b64-c13f2712edf9@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx68Gz8zFq5MWoAA--.56092S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF18ur4rJr48Ary3ZryfZrc_yoW5WF47pF
	WFg3Z0yFZrWFyIyw1Svr48Jry0yrsxXa15XFn5AFW5Aws8Jw4Iqr4YgFWY9a4kCrn5Xw1F
	qrWFqrZrurWDAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=



On 2026/6/16 下午11:08, Tao Cui wrote:
> 
> Hi Bibo,
> 
> That's really kind of you. I'd really value the chance to work with you.
> 
> 在 2026/6/16 09:14, Bibo Mao 写道:
>>
>>> +            __cpumask_clear_cpu(cpu, flushmask);
>> is it possible that vCPU is running however with KVM_VCPU_PREEMPTED set?
> 
> It shouldn't happen with a correct host: the bit is set on vcpu_put
> (preempt) and cleared on entry through kvm_update_stolen_time(), so a
 From the code, I think it may happen. The clear operation may fail in 
kvm_update_stolen_time(), so vCPU will continue to run in guest mode 
with flag KVM_VCPU_PREEMPTED set .

> running vCPU always has preempted == 0. The guest-side race is closed by
> try_cmpxchg(). If the host clears the byte between the guest's READ_ONCE
> and the cmpxchg, the cmpxchg fails and the CPU stays in the IPI mask, so
> no flush is missed. The only thing that can break the invariant is the
> error path from patch 1, which the conservative handling there closes.
> Point taken though: the design's correctness rests entirely on the host
> honoring this, so I agree the patch-1 fix is necessary rather than
> optional.
> 
>>> +    }
>>> +
>>> +    on_each_cpu_mask(flushmask, func, info, 1);
>> LoongArch VM does not support post interrupt now, IPI with vCPU will trap to hypervisor.
>>
>> There is another PV TLB flush method using hypercall like PV IPI, which will make a request with wait flag such as KVM_REQ_TLB_FLUSH and kick vCPU.
>>
>> With this PV TLB flush method, there is not IPI interrupt in VM, and wait is handled in hypervisor, the negative effect is that it flushes all TLBs.
>>
> This is the point I most want to get right, and you're correct. Since
> LoongArch has no posted interrupts, an IPI to a *running* vCPU still
> traps, so the steal-time path only genuinely helps for preempted/idle
> vCPUs; for running ones it's no better (a little heavier) than a plain
> IPI. The hypercall approach (analogous to our PV IPI) would avoid
> in-guest IPIs entirely, at the cost of a full TLB flush and
> hypervisor-side wait handling.
> 
> Rather than argue from intuition, I'd like to try the hypercall approach
> you suggested and measure the performance improvement against the current
> path. I'll share the results with you once the testing is done, so we
> can decide the direction based on the numbers.
well, that is the best. It is my pleasure to discuss this with you.

Regards
Bibo Mao
> 
>> FYI, another PV TLB flush method in arch/x86/hyperv/mmu.c ...
> 
> Thanks for the pointer. The Hyper-V path is a pure hypercall: the guest
> hands the hypervisor the address space, an address-range list, and the
> target VP set, so the flush stays fine-grained instead of nuking the
> whole TLB. That's a good template if the numbers point us toward a
> hypercall-based design.
> 
> Thanks,
> Tao
> 

