Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D845EEA8
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782438073; cv=none; b=Zeh3TWsWY/LUhePJKsTRDS4LBflsK1awuhHboASnEg+yL4GsPJvNIDo7yGsG7M9rI3hDf+TyAj60AXnqmRl1e2Fi/xRZDtp9sZxJzsKZO0AkM8LA08c1wMQnowhEOjx2bG2IsAD2aBDszEnjiXtaAXBlbQOASILsMxPaFZ9si4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782438073; c=relaxed/simple;
	bh=4owh06YWaGdMPZY6bHVAjd9s7p9VmyS+7c0UVSwrId8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=a07ufNYd01k32kWsNjKaAWDV3N1mtMbPsiYaaB2a27qXUAauzmqmwRdbB29xdarSF/eM+2urrI45cyrILohufMbUmcBhNTV9GFbNReTZQ1UZ9WQnOoY+p+7nEypv5mKBzTEouDIebgtXU21nhl+uh9F8ubMx9U/KEaXfVMb54OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Dx8eqs2D1q7isYAA--.62512S3;
	Fri, 26 Jun 2026 09:41:00 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxPMKg2D1qlGGzAA--.10990S3;
	Fri, 26 Jun 2026 09:40:48 +0800 (CST)
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
 <835a9c5c-2f66-293b-d093-fc59bac26a01@loongson.cn>
 <416dfbf8-f765-442e-b6de-6fc0fe1a4b5f@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <a7e7a17c-fdaa-b168-2a7b-d4cd4018b662@loongson.cn>
Date: Fri, 26 Jun 2026 09:37:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <416dfbf8-f765-442e-b6de-6fc0fe1a4b5f@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPMKg2D1qlGGzAA--.10990S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww4ktrWDJw15Xr17uFyUJwc_yoW3JFWxpr
	W8JFy5trWDCry8Ar1Utr1UXryjyr1UJ3W5Xr1jyFy8Jwn8tr12qryUWr1j9F1DWr4rJr1U
	tr18JrWfZr1UJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5xhLUUUUU=



On 2026/6/25 下午8:51, Tao Cui wrote:
> 
> 
> 在 2026/6/25 15:36, Bibo Mao 写道:
>>
>>
>> On 2026/6/25 下午3:15, Tao Cui wrote:
>>>
>>>
>>> 在 2026/6/25 14:11, Bibo Mao 写道:
>>>>
>>>>
>>>> On 2026/6/25 上午11:31, Bibo Mao wrote:
>>>>>
>>>>>
>>>>> On 2026/6/25 上午10:27, Tao Cui wrote:
>>>>>>
>>>>>> Hi Bibo,
>>>>>>
>>>>>> 在 2026/6/17 09:05, Bibo Mao 写道:
>>>>>>>
>>>>>>>> Rather than argue from intuition, I'd like to try the hypercall approach
>>>>>>>> you suggested and measure the performance improvement against the current
>>>>>>>> path. I'll share the results with you once the testing is done, so we
>>>>>>>> can decide the direction based on the numbers.
>>>>>>> well, that is the best. It is my pleasure to discuss this with you.
>>>>>>>
>>>>>>
>>>>>> A quick update on the testing. I put both the hypercall and the
>>>>>> steal-time variants through two benchmarks on an 8-core host with a
>>>>>> 4:1 overcommitted guest (32 vCPUs), and wanted to share where things
>>>>>> stand.
>>>>>>
>>>>>> The two workloads:
>>>>>>     - ebizzy (all threads busy, mm-flush heavy)
>>>>>>     - tlb_bench in sleep-idle mode (1 flusher + 31 sleeping idle threads,
>>>>>>       so the idle vCPUs get preempted)
>>>>>>
>>>>>> ebizzy (records/s, higher is better), 32 vCPUs:
>>>>>>      no-PV       ~103,737
>>>>>>      hypercall   ~105,779
>>>>>>      steal-time  ~105,872
>>>>>>      -> all within noise (±2%); no measurable difference.
>>>>> Hi Tao,
>>>>>
>>>>> what is ebizzy command? ebizzy -m or ebizzy -M.
>>>>>
>>>>> could you try command on host and one VM without over-committed at first, and then two VMs and three VMs?
>>>>>
>>>>> Here is result on my 3C5000 Dual-way machines with 32 cores and two numa nodes:
>>>>>                    ./ebizzy -m          ./ebizzy -M
>>>>> host             8633                 158898
>>>>> VM(32 vCPUs)     6610                 133153
>>>>> VM/host          76%                  83%
>>>>>
>>>> just ./ebizzy -M is enough, it seems that CPU number is one key factor.
>>>>
>>>
>>> Sorry for the delay — it turned out my ebizzy command was wrong. I had
>>> been running `ebizzy -t <vcpus> -S 10`, which is neither -m nor -M, so
>>> neither mmap mode was active and the workload wasn't really stressing
>>> the TLB-flush path. Thanks for catching it.
>>>
>>> I re-ran with -m and -M on host and a single VM (8-core LoongArch
>>> KVM host, 8 vCPU guest, 1:1, no overcommit).
>>>
>>>                    ebizzy -m        ebizzy -M
>>> host             ~20,000          ~55,000
>>> VM (8 vCPU,1:1)  ~17,000          ~53,000
>>> VM/host          ~86%             ~97%
>>>
>>> The -m ratio (86%) is close to your 76%.
>> On my 3C5000 Dual-way machine, VM has the same CPU/memory topology with physical machine, the kernel is mainline without any patch.
>>                            ./ebizzy -M
>> Host (32 pCPUs)           158898
>> One VM(32 vCPUs)          133153                 83% of host
>> Two VMs(32 vCPUs each)    9083 + 9630 = 18713    11% of host
>>
>> It seems that with ebizzy benchmark, there is big difference if vCPU is preempted. Even if vCPU is not preempted, the performance is only 83% of host on my 3C5000 Dual-way machine.
> 
> After fixing the ebizzy command, I
> have multi-VM overcommit results for both approaches.
> 
> Setup: 8-core LoongArch (single-socket, single NUMA), KVM,
> linux-next-20260623, 8 vCPU per VM. All VMs run ebizzy -M
> simultaneously, 3 runs each. The PV-off baseline uses a guest kernel
> with CONFIG_PARAVIRT=y but without the PV TLB flush patches, so
> PV IPI and steal-time are active in all three columns.
> 
> ebizzy -M, total records/s across all VMs:
> 
>                PV-off      steal-time   hypercall
>    1:1 (1VM)   53,600      53,800       53,900
>    2:1 (2VM)    2,600      42,600       45,300
>    3:1 (3VM)    2,800      44,700       46,000
> 
> At 1:1 there is no difference — no vCPU gets preempted. Under
 From the previous result, the score on host is 55,000, with 1:1 mode 
the virtualization efficiency is 97%, it is hard to improve actually. On 
my 3C5000 Dual-way machine, the virtualization efficiency is 83%, I 
think it can improve even with 1:1 mode.

Also the paper at https://dl.acm.org/doi/pdf/10.1145/2892242.2892245 
proves it with 1:1 mode.
> overcommit, without PV TLB flush the throughput drops to ~3-5% of
> the single-VM case, because every remote TLB flush sends IPIs to
> preempted vCPUs. With either PV TLB flush variant, preempted vCPUs
> are skipped, and total throughput stays at ~85-90% of single-VM
> (bounded by physical cores).
> 
> Hypercall is consistently 3-6% above steal-time in the overcommit
> cases. A possible reason is that the hypercall hands the entire
> target set to the host in one call, while steal-time still IPIs the
> running vCPUs and only defers the preempted ones.
> 
> On our 8-core machine the collapse is more severe than on your
> 3C5000 (~5% vs 11% of host at 2 VMs), likely due to the smaller
> core count and single-NUMA topology.
yeap, with more CPUs the benefit is more high. I think that this kind of 
patch had better be tested on server platform if there is such hardware 
by hand after all KVM is used in server platform in most time. I will 
test the patch in later.

Regards
Bibo Mao
> 
> Thanks,
> Tao
> 
>>
>> Regards
>> Bibo Mao
>>>
>>> I then tried multi-VM overcommit (2 and 3 VMs, all running ebizzy -M
>>> simultaneously). The initial result showed a large gap between the
>>> PV-TLB-flush kernel and the baseline under overcommit. Both kernels
>>> have CONFIG_PARAVIRT enabled (PV IPI and steal-time are active in
>>> both), so PV TLB flush should be the main differentiator — but since
>>> they are two separate kernel images rather than a clean on/off toggle,
>>> there may be some noise from other differences. I'm now re-running
>>> with a QEMU CPU property (kvm-pv-tlb-flush on/off) on the same kernel
>>> to isolate the effect cleanly.
>>>
>>> I'll share the verified numbers once I have them.
>>>
>>> Thanks,
>>> Tao
>>>
>>>>> Regards
>>>>> Bibo Mao
>>>>>
>>>>>>
>>>>>> tlb_bench sleep-idle (ns/flush, lower is better), 1 flusher + 31 idle:
>>>>>>      no-PV       ~166,536
>>>>>>      steal-time  ~149,553
>>>>>>      hypercall    ~88,686
>>>>>>
>>>>>> ebizzy's workload is mostly threads staying busy with alloc/copy/free,
>>>>>> which drives remote TLB flushes against running vCPUs — that may not be
>>>>>> the path this feature is meant to optimize, so the flat result there
>>>>>> probably says more about the workload mismatch than about the feature
>>>>>> itself. I need to take another look at whether the benchmark actually
>>>>>> exercises the cases PV TLB flush targets before reading too much into
>>>>>> the numbers, including the tlb_bench figure above.
>>>>>>
>>>>>> So I'd hold off on any conclusion for now. Next I'll re-examine the
>>>>>> test setup / pick a workload that better matches the feature, and keep
>>>>>> you posted once I have something more representative.
>>>>>>
>>>>>> Best,
>>>>>> Tao
>>>>>>
>>>>
>>

