Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407BF2874E6
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 03:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782358514; cv=none; b=iWxm/9OjaFuY8FX6IamYvt7RQm/6FyXqiYpsYL1jfvcMY2BYKIYTcW3nNPvuRWPJotKCK+N68cp82eCWPfDtNgCwnwk66R07aMrAd/7lVHt37K/k9Z+zosA8W923QfkrqX79O/pF4ID5Sk6F4C+Yj/tiSK8x9rIWRC3J+D0IK+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782358514; c=relaxed/simple;
	bh=KQ1z6dhX65vvpq1IUogmoTamXwPe2OWqKazi2T+a5fM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NlB1GJOctGCb3L+L7gNCmIpULIN2iVUxAiXmRccjP7tgXwC2qgT5puZ/MPKxCv8ucyaEXxEZAlogLS1O3PngTj3AjqyGsIKqdPwh9iSI80UEiJgj3jZKRLQ/o32m5UFpULY7u+hNkKJfm2iulM7fvgEtKtfMMqFaKNtphw7QSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxFensoTxqka8XAA--.55153S3;
	Thu, 25 Jun 2026 11:35:08 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxzsLqoTxqh1ayAA--.10733S3;
	Thu, 25 Jun 2026 11:35:07 +0800 (CST)
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
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <6f837e00-e606-ddaa-b22b-dd30348a18fb@loongson.cn>
Date: Thu, 25 Jun 2026 11:31:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <404180d0-c734-4465-8752-f43279730692@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzsLqoTxqh1ayAA--.10733S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw48KF15ZFyfAFWkWrWUWrX_yoW8tr48pa
	y5Kas0kF4kuFyIyr4jkr18JrWjvry7KFs8XF1IkrykA398W3yS9rZrurWFvF9ruF1Fgw10
	9rWUXry5uF1UA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4s2-UUUUU



On 2026/6/25 上午10:27, Tao Cui wrote:
> 
> Hi Bibo,
> 
> 在 2026/6/17 09:05, Bibo Mao 写道:
>>
>>> Rather than argue from intuition, I'd like to try the hypercall approach
>>> you suggested and measure the performance improvement against the current
>>> path. I'll share the results with you once the testing is done, so we
>>> can decide the direction based on the numbers.
>> well, that is the best. It is my pleasure to discuss this with you.
>>
> 
> A quick update on the testing. I put both the hypercall and the
> steal-time variants through two benchmarks on an 8-core host with a
> 4:1 overcommitted guest (32 vCPUs), and wanted to share where things
> stand.
> 
> The two workloads:
>   - ebizzy (all threads busy, mm-flush heavy)
>   - tlb_bench in sleep-idle mode (1 flusher + 31 sleeping idle threads,
>     so the idle vCPUs get preempted)
> 
> ebizzy (records/s, higher is better), 32 vCPUs:
>    no-PV       ~103,737
>    hypercall   ~105,779
>    steal-time  ~105,872
>    -> all within noise (±2%); no measurable difference.
Hi Tao,

what is ebizzy command? ebizzy -m or ebizzy -M.

could you try command on host and one VM without over-committed at 
first, and then two VMs and three VMs?

Here is result on my 3C5000 Dual-way machines with 32 cores and two numa 
nodes:
                 ./ebizzy -m          ./ebizzy -M
host             8633                 158898
VM(32 vCPUs)     6610                 133153
VM/host          76%                  83%

Regards
Bibo Mao

> 
> tlb_bench sleep-idle (ns/flush, lower is better), 1 flusher + 31 idle:
>    no-PV       ~166,536
>    steal-time  ~149,553
>    hypercall    ~88,686
> 
> ebizzy's workload is mostly threads staying busy with alloc/copy/free,
> which drives remote TLB flushes against running vCPUs — that may not be
> the path this feature is meant to optimize, so the flat result there
> probably says more about the workload mismatch than about the feature
> itself. I need to take another look at whether the benchmark actually
> exercises the cases PV TLB flush targets before reading too much into
> the numbers, including the tlb_bench figure above.
> 
> So I'd hold off on any conclusion for now. Next I'll re-examine the
> test setup / pick a workload that better matches the feature, and keep
> you posted once I have something more representative.
> 
> Best,
> Tao
> 

