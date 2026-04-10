Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C23A1E8C;
	Fri, 10 Apr 2026 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806253; cv=none; b=PYL2USuFshISJa8s9pgGPG2CFVFlq3KgUA68iPrp0r8lQAlgHF6l3FMFq5+h21xFOR84qv7CdAemR4znuZRobcrQ4d3O1vqIUaN5n+JUcEn8o6OD+lAYxJ1kZdddSlZzzxVJCWQCMeH35SHV0p4xGkQ1+idGBFTn6iWhTMWjcbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806253; c=relaxed/simple;
	bh=0lj4b1z4MAkM8HA1oTgCaRteLCdv8SRSr32wvbP198E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BHfnXZynP/0XZ9CBLSap03lq4XNJlP36JRuhOg5n9HZknsOlQeTP95s9XwNlFR347vKvsc+hVG2wzTgr5CYLqDv/QKCrElLqC0CvPmmovc6M5dW49+wa0QkDOt+pSFFa+2OcaMiKE8I1WPl8sIQfSF9anEDdxf0zEP3eN2H+a2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.239])
	by gateway (Coremail) with SMTP id _____8Bx28Ikp9hpW+gjAA--.33671S3;
	Fri, 10 Apr 2026 15:30:44 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
	by front1 (Coremail) with SMTP id qMiowJCxfcIdp9hpYDJqAA--.3805S3;
	Fri, 10 Apr 2026 15:30:41 +0800 (CST)
Subject: Re: [PATCH v10 0/2] LoongArch: KVM: Add DMSINTC support irqchip in
 kernel
To: Huacai Chen <chenhuacai@kernel.org>
Cc: maobibo@loongson.cn, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 kernel@xen0n.name, linux-kernel@vger.kernel.org, lixianglai@loongson.cn
References: <20260409024215.136932-1-gaosong@loongson.cn>
 <CAAhV-H7JcTV9aBChaYnR4irFt8O3C_9cOu_q4Krc6Q1c7Xwquw@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <45b93b94-fceb-c41e-9b3a-c2b3187eecae@loongson.cn>
Date: Fri, 10 Apr 2026 15:31:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7JcTV9aBChaYnR4irFt8O3C_9cOu_q4Krc6Q1c7Xwquw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJCxfcIdp9hpYDJqAA--.3805S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF1fuFy7GrW7CFWDtF4UWrX_yoW5Zw1rpF
	W3u3Z0kr48Jr13ArsF93Wvvr4UAr93Jr12ga4aga47CrsIqF18Xrn5GrZFyF9Fg3yrGF10
	qa4fW34a93WUJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xu
	ctUUUUU==

在 2026/4/9 下午8:39, Huacai Chen 写道:
> Applied with small modifications, thanks.
>
> Now all KVM patches for 7.1 are applied here:
> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-kvm
>
> Please ensure that everything works well.
>
After some basic testing, the functionality is working properly. Compatibility is fine.

Thanks.
Song Gao

> Huacai
>
> On Thu, Apr 9, 2026 at 11:08 AM Song Gao <gaosong@loongson.cn> wrote:
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
>> v10:
>>    *Changed from v8;
>>    *Rebase.
>>
>> v9:
>>   *Correct the incorrect parameter type and remove the function prefix;
>>   *Fix a boundary value check.
>>
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
>>   arch/loongarch/include/asm/kvm_dmsintc.h |  26 ++++
>>   arch/loongarch/include/asm/kvm_host.h    |   3 +
>>   arch/loongarch/include/asm/kvm_pch_pic.h |   4 +-
>>   arch/loongarch/include/uapi/asm/kvm.h    |   4 +
>>   arch/loongarch/kvm/Makefile              |   1 +
>>   arch/loongarch/kvm/intc/dmsintc.c        | 190 +++++++++++++++++++++++
>>   arch/loongarch/kvm/intc/pch_pic.c        |  15 +-
>>   arch/loongarch/kvm/interrupt.c           |   2 +
>>   arch/loongarch/kvm/irqfd.c               |  11 +-
>>   arch/loongarch/kvm/main.c                |   6 +
>>   include/uapi/linux/kvm.h                 |   2 +
>>   11 files changed, 255 insertions(+), 9 deletions(-)
>>   create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
>>   create mode 100644 arch/loongarch/kvm/intc/dmsintc.c
>>
>> --
>> 2.39.3
>>

