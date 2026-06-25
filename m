Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D1735DA5B
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373185; cv=none; b=mUwWIil+31xlPj9Lsmm+uyuChIqyvwALBtCP803BXRrqFBf8YjRYJMtOpy8ROYdLREa7q1Lh4W5NN/XGAdpEpWOmEqCSQCokmYMhx0qg7/FYfGYnpRu1bzknq9qm0HEYQc81rhigLZEC5V3k+axZVYzR+jPdyatqc+Z2QUpnEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373185; c=relaxed/simple;
	bh=bqTY0fISFtqYliZy1/HPXNZDnB57doqBGryZGOXqapE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Izz5tlH8yP3D9G2Wk0wMowFN/jQOE0MpFMEl96L/2bFMd1VDzjyuQfjJOKErCyXp2cb4Wq99ukSMQDH4sQNGI/j5Sxqugloko2qnXKwlpyL1hTHTjWJ5gHPg40v4uuiNT/cjmn80AL6KoGCvTDKIVB7rxGGKgOXCfg22ECFnSlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Axvek72zxq+cAXAA--.59235S3;
	Thu, 25 Jun 2026 15:39:39 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxLMI42zxqkouyAA--.10518S3;
	Thu, 25 Jun 2026 15:39:38 +0800 (CST)
Subject: Re: [PATCH v4 2/3] LoongArch: KVM: Implement guest-side PV TLB flush
To: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, loongarch@lists.linux.dev
Cc: kernel@xen0n.name, kvm@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
References: <20260615082154.42144-1-cui.tao@linux.dev>
 <20260615082154.42144-3-cui.tao@linux.dev>
 <0c47ce21-9a4d-4cdc-9bec-ce749e31512e@loongson.cn>
 <1bfa4941-b94b-410a-9b64-c13f2712edf9@linux.dev>
 <9ec9d22b-93fd-3dcb-c6b8-19563f1b7c0a@loongson.cn>
 <404180d0-c734-4465-8752-f43279730692@linux.dev>
 <6f837e00-e606-ddaa-b22b-dd30348a18fb@loongson.cn>
 <084d7bec-592c-31b5-aa44-099bff87af9a@loongson.cn>
 <013459e1-f817-42b5-a0fd-20b38d9b6140@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <835a9c5c-2f66-293b-d093-fc59bac26a01@loongson.cn>
Date: Thu, 25 Jun 2026 15:36:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <013459e1-f817-42b5-a0fd-20b38d9b6140@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxLMI42zxqkouyAA--.10518S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF4kAry7Xry5Gr15GrW7trc_yoWrtr1kpr
	Z5tFy5tFWDCr1fAr4j9r1UXrWjyr17J3W5Xr10yFy8J390yrySgrW7Wr109FyDGr4rJr18
	KryUJrWfZr1UAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4s2-UUUUU



On 2026/6/25 下午3:15, Tao Cui wrote:
> 
> 
> 在 2026/6/25 14:11, Bibo Mao 写道:
>>
>>
>> On 2026/6/25 上午11:31, Bibo Mao wrote:
>>>
>>>
>>> On 2026/6/25 上午10:27, Tao Cui wrote:
>>>>
>>>> Hi Bibo,
>>>>
>>>> 在 2026/6/17 09:05, Bibo Mao 写道:
>>>>>
>>>>>> Rather than argue from intuition, I'd like to try the hypercall approach
>>>>>> you suggested and measure the performance improvement against the current
>>>>>> path. I'll share the results with you once the testing is done, so we
>>>>>> can decide the direction based on the numbers.
>>>>> well, that is the best. It is my pleasure to discuss this with you.
>>>>>
>>>>
>>>> A quick update on the testing. I put both the hypercall and the
>>>> steal-time variants through two benchmarks on an 8-core host with a
>>>> 4:1 overcommitted guest (32 vCPUs), and wanted to share where things
>>>> stand.
>>>>
>>>> The two workloads:
>>>>    - ebizzy (all threads busy, mm-flush heavy)
>>>>    - tlb_bench in sleep-idle mode (1 flusher + 31 sleeping idle threads,
>>>>      so the idle vCPUs get preempted)
>>>>
>>>> ebizzy (records/s, higher is better), 32 vCPUs:
>>>>     no-PV       ~103,737
>>>>     hypercall   ~105,779
>>>>     steal-time  ~105,872
>>>>     -> all within noise (±2%); no measurable difference.
>>> Hi Tao,
>>>
>>> what is ebizzy command? ebizzy -m or ebizzy -M.
>>>
>>> could you try command on host and one VM without over-committed at first, and then two VMs and three VMs?
>>>
>>> Here is result on my 3C5000 Dual-way machines with 32 cores and two numa nodes:
>>>                   ./ebizzy -m          ./ebizzy -M
>>> host             8633                 158898
>>> VM(32 vCPUs)     6610                 133153
>>> VM/host          76%                  83%
>>>
>> just ./ebizzy -M is enough, it seems that CPU number is one key factor.
>>
> 
> Sorry for the delay — it turned out my ebizzy command was wrong. I had
> been running `ebizzy -t <vcpus> -S 10`, which is neither -m nor -M, so
> neither mmap mode was active and the workload wasn't really stressing
> the TLB-flush path. Thanks for catching it.
> 
> I re-ran with -m and -M on host and a single VM (8-core LoongArch
> KVM host, 8 vCPU guest, 1:1, no overcommit).
> 
>                   ebizzy -m        ebizzy -M
> host             ~20,000          ~55,000
> VM (8 vCPU,1:1)  ~17,000          ~53,000
> VM/host          ~86%             ~97%
> 
> The -m ratio (86%) is close to your 76%.
On my 3C5000 Dual-way machine, VM has the same CPU/memory topology with 
physical machine, the kernel is mainline without any patch.
                           ./ebizzy -M
Host (32 pCPUs)           158898
One VM(32 vCPUs)          133153                 83% of host
Two VMs(32 vCPUs each)    9083 + 9630 = 18713    11% of host

It seems that with ebizzy benchmark, there is big difference if vCPU is 
preempted. Even if vCPU is not preempted, the performance is only 83% of 
host on my 3C5000 Dual-way machine.

Regards
Bibo Mao
> 
> I then tried multi-VM overcommit (2 and 3 VMs, all running ebizzy -M
> simultaneously). The initial result showed a large gap between the
> PV-TLB-flush kernel and the baseline under overcommit. Both kernels
> have CONFIG_PARAVIRT enabled (PV IPI and steal-time are active in
> both), so PV TLB flush should be the main differentiator — but since
> they are two separate kernel images rather than a clean on/off toggle,
> there may be some noise from other differences. I'm now re-running
> with a QEMU CPU property (kvm-pv-tlb-flush on/off) on the same kernel
> to isolate the effect cleanly.
> 
> I'll share the verified numbers once I have them.
> 
> Thanks,
> Tao
> 
>>> Regards
>>> Bibo Mao
>>>
>>>>
>>>> tlb_bench sleep-idle (ns/flush, lower is better), 1 flusher + 31 idle:
>>>>     no-PV       ~166,536
>>>>     steal-time  ~149,553
>>>>     hypercall    ~88,686
>>>>
>>>> ebizzy's workload is mostly threads staying busy with alloc/copy/free,
>>>> which drives remote TLB flushes against running vCPUs — that may not be
>>>> the path this feature is meant to optimize, so the flat result there
>>>> probably says more about the workload mismatch than about the feature
>>>> itself. I need to take another look at whether the benchmark actually
>>>> exercises the cases PV TLB flush targets before reading too much into
>>>> the numbers, including the tlb_bench figure above.
>>>>
>>>> So I'd hold off on any conclusion for now. Next I'll re-examine the
>>>> test setup / pick a workload that better matches the feature, and keep
>>>> you posted once I have something more representative.
>>>>
>>>> Best,
>>>> Tao
>>>>
>>

