Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E61C2FF669;
	Thu,  9 Apr 2026 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698316; cv=none; b=VD0nmGa2PW2DJG92b/Re8XkKd4wXBox78RtY5j5W4V8uDwUmn7hNVqKfbzvmHdLBnRhi9/YF5+rQJKfNpQCZg+vLwMiS8dqdnhMUPV+wUMl/jPD1QjXmHb6QHbx9C3y9z+hZtdBoE8H2t67g0BWdBIVF46duWFPC7pTKik6eyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698316; c=relaxed/simple;
	bh=UgT2PBRqcyg8lzKcJVb70st1Pmbe2Vl/Rym9Mm4vEac=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QV5zuKTvUMjvwhpqwZUuQxuk8bF4aWn9kQ51VsHfASrYIBuFtW0e4YkobdJJ17vTa8kf+6TQ1ywT5uXhL2j09SW3dV4Ql+zpt+QzGWzcE+mCuDQiqr4CD/m98YCChJ9F10D44REOeZTgOPMzYtEVGTCOnb/h1M688l73xzxv5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.239])
	by gateway (Coremail) with SMTP id _____8Axz6t8AddpNWQjAA--.39320S3;
	Thu, 09 Apr 2026 09:31:41 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
	by front1 (Coremail) with SMTP id qMiowJDxD8N3AddpAAxpAA--.3801S3;
	Thu, 09 Apr 2026 09:31:38 +0800 (CST)
Subject: Re: [PATCH v9 0/2] LoongArch: KVM: Add DMSINTC support irqchip in
 kernel
To: Huacai Chen <chenhuacai@kernel.org>
Cc: maobibo@loongson.cn, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 kernel@xen0n.name, linux-kernel@vger.kernel.org, lixianglai@loongson.cn
References: <20260402124237.4174550-1-gaosong@loongson.cn>
 <CAAhV-H7K8ayLGFMhPwp8uqr3JHdpL1dWOvo2zuVj_3fB2CWPeA@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <0f0f10e6-11bf-9052-b541-4061d46fa046@loongson.cn>
Date: Thu, 9 Apr 2026 09:32:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7K8ayLGFMhPwp8uqr3JHdpL1dWOvo2zuVj_3fB2CWPeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDxD8N3AddpAAxpAA--.3801S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXFy5WF17Ary3Ary8WFWfJFc_yoW5Cr4xpa
	y3u3Z0kr48Gr13ArsI93Wqgr45Arn3Jr1IgasIga47CrsxZr18Xrn5Gr9FyF9rWayrGF1I
	qw1fW34Y93WUJagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9N3UU
	UUU==

Hi, Huacai.

在 2026/4/7 下午8:34, Huacai Chen 写道:
> Hi, Song,
>
> On Thu, Apr 2, 2026 at 9:08 PM Song Gao <gaosong@loongson.cn> wrote:
>> Hi,
>>
>> This series  implements the DMSINTC in-kernel irqchip device,
>> enables irqfd to deliver MSI to DMSINTC, and supports injecting MSI interrupts
>> to the target vCPU.
>> applied this series.  use netperf test.
>> VM with one CPU and start netserver, host run netperf.
>> disable dmsintc
>> taskset 0x2f  netperf -H 192.168.122.204 -t UDP_RR  -l 36000
>> Local /Remote
>> Socket Size   Request  Resp.   Elapsed  Trans.
>> Send   Recv   Size     Size    Time     Rate
>> bytes  Bytes  bytes    bytes   secs.    per sec
>>
>> 212992 212992 1        1       36000.00   27107.36
>>
>> enable dmsintc
>> Local /Remote
>> Socket Size   Request  Resp.   Elapsed  Trans.
>> Send   Recv   Size     Size    Time     Rate
>> bytes  Bytes  bytes    bytes   secs.    per sec
>>
>> 212992 212992 1        1       36000.00   28831.14  (+6.3%)
>>
>> v9:
>>   *Correct the incorrect parameter type and remove the function prefix;
>>   *Fix a boundary value check.
> It seems your V9 is changed from V7 rather than V8, why?
>
> Huacai

I'm sorry, it was my mistake—V7 and V8 look so similar.
I'll correct is as soon as possible.

Thanks.
Song Gao

>> v8:
>>    *Move dmsintc_inject_irq(),dmsintc_deliver_msi_to_vcpu()and
>> dmsintc_set_msi_irq to dmsintc.c.
>>    *Rebase.
>>
>> v7:
>>    *Rebase;
>>    *Fix a typo error;
>>    *Drop an extra space;
>>    *Move some code from patch2 to patch1.
>>    *Rename loongarch_dmsintc_inject_irq() to dmsintc_inject_irq() and move
>> it to interrupt.c;
>>    *Rename kvm_loongarch_deliver_msi_to_vcpu() to
>> dmsintc_deliver_msi_to_vcpu() and move it to irqfd.c;
>>    *Drop loongarch_set_msi() and dispatch the dmsintc/eiointc
>> paths in pch_msi_set_irq().
>>
>> v6:
>>    Fix kvm_device leak in kvm_dmsintc_destroy().
>>
>> v5:
>>    Combine patch2 and patch3
>>    Add check msgint feature when register DMSINT device.
>>
>> V4: Rebase and R-b;
>>     replace DINTC to DMSINTC.
>>
>> V3: Fix kvm_arch_set_irq_inatomic() missing dmsintc set msi.(patch3)
>>
>> V2:
>> https://patchew.org/linux/20251128091125.2720148-1-gaosong@loongson.cn/
>>
>> Thanks.
>> Song Gao
>>
>>
>> Song Gao (2):
>>    LoongArch: KVM: Add DMSINTC device support
>>    LoongArch: KVM: Add dmsintc inject msi to the dest vcpu
>>
>>   arch/loongarch/include/asm/kvm_dmsintc.h |  23 +++++
>>   arch/loongarch/include/asm/kvm_host.h    |   3 +
>>   arch/loongarch/include/asm/kvm_pch_pic.h |   4 +-
>>   arch/loongarch/include/uapi/asm/kvm.h    |   4 +
>>   arch/loongarch/kvm/Makefile              |   1 +
>>   arch/loongarch/kvm/intc/dmsintc.c        | 117 +++++++++++++++++++++++
>>   arch/loongarch/kvm/intc/pch_pic.c        |  15 ++-
>>   arch/loongarch/kvm/interrupt.c           |  37 +++++++
>>   arch/loongarch/kvm/irqfd.c               |  48 ++++++++--
>>   arch/loongarch/kvm/main.c                |   6 ++
>>   include/uapi/linux/kvm.h                 |   2 +
>>   11 files changed, 251 insertions(+), 9 deletions(-)
>>   create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
>>   create mode 100644 arch/loongarch/kvm/intc/dmsintc.c
>>
>> --
>> 2.39.3
>>

