Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B98359A9B;
	Fri, 20 Mar 2026 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991632; cv=none; b=qIga487At44LN4/gSue7fuUShkpJRKmAiK2UUB94AbkHA4fKBAl4hlJjIKb/InI+vGcCfFwanE+bFJwn3c9CTPdv8JibXvur3g57ADKiHd/Qjqfowhn78PnRxeLIp3XS78lbURvYBUBrb1we61VesC9usKgJs2kt7/buXsnL8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991632; c=relaxed/simple;
	bh=KS4TgO7e6P7nO4E/WVl5mY8q++S6VMLWvBNQMvDzdX0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R2mKm9iStI+0mYC3tK1PcvYIp1/kZc1N9yz84YQt9AwSfOZe8sx7Bv5/MnWajNDiu8IjnwYdz27uAYk+uTyMFtGmotuKEDYU8wWSDct/vZWhRgOVi6LymOf1bA6yawhCZ//9zzoRk51OIK4HNVCgeKEHM0FmstcCbW08yR1LB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.239])
	by gateway (Coremail) with SMTP id _____8AxjsPM9rxp5fYcAA--.18542S3;
	Fri, 20 Mar 2026 15:27:08 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
	by front1 (Coremail) with SMTP id qMiowJCxfcLL9rxpIT1ZAA--.37348S3;
	Fri, 20 Mar 2026 15:27:07 +0800 (CST)
Subject: Re: [PATCH v7 1/2] LoongArch: KVM: Add DMSINTC device support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: maobibo@loongson.cn, lixianglai@loongson.cn, loongarch@lists.linux.dev,
 kernel@xen0n.name, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260311085059.1040263-1-gaosong@loongson.cn>
 <20260311085059.1040263-2-gaosong@loongson.cn>
 <CAAhV-H4WZj3LmghXxXY1hNUjEmihx1fjggOZLNRRDS5PN2s0kg@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <43459637-6aba-c31d-5840-ee4675712e0a@loongson.cn>
Date: Fri, 20 Mar 2026 15:28:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4WZj3LmghXxXY1hNUjEmihx1fjggOZLNRRDS5PN2s0kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJCxfcLL9rxpIT1ZAA--.37348S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JFyDJr4xAw1UGw1rCr18tFc_yoWDJFWDpa
	47AFs8Gr48WryxCrn2qas8ur17Zr4fKr129FyjgFyUCrnFvry8Ary8Kr9ruF9xXa18Gr10
	vFyag3WY9a1Ut3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
	VUUUUUU==

Hi Huacai,

Thank you for your review and the insightful question.


在 2026/3/19 下午8:48, Huacai Chen 写道:
> Hi, Song,
>
> On Wed, Mar 11, 2026 at 5:16 PM Song Gao <gaosong@loongson.cn> wrote:
>> Add device model for DMSINTC interrupt controller, implement basic
>> create/destroy/set_attr interfaces, and register device model to kvm
>> device table.
>>
>> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/kvm_dmsintc.h |  21 ++++
>>   arch/loongarch/include/asm/kvm_host.h    |   3 +
>>   arch/loongarch/include/uapi/asm/kvm.h    |   4 +
>>   arch/loongarch/kvm/Makefile              |   1 +
>>   arch/loongarch/kvm/intc/dmsintc.c        | 117 +++++++++++++++++++++++
>>   arch/loongarch/kvm/main.c                |   6 ++
>>   include/uapi/linux/kvm.h                 |   2 +
>>   7 files changed, 154 insertions(+)
>>   create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
>>   create mode 100644 arch/loongarch/kvm/intc/dmsintc.c
>>
>> diff --git a/arch/loongarch/include/asm/kvm_dmsintc.h b/arch/loongarch/include/asm/kvm_dmsintc.h
>> new file mode 100644
>> index 000000000000..b04b89dd2a35
>> --- /dev/null
>> +++ b/arch/loongarch/include/asm/kvm_dmsintc.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2025 Loongson Technology Corporation Limited
>> + */
>> +
>> +#ifndef __ASM_KVM_DMSINTC_H
>> +#define __ASM_KVM_DMSINTC_H
>> +
>> +
>> +struct loongarch_dmsintc {
>> +       struct kvm *kvm;
>> +       uint64_t msg_addr_base;
>> +       uint64_t msg_addr_size;
>> +};
>> +
>> +struct dmsintc_state {
>> +       atomic64_t  vector_map[4];
>> +};
>> +
>> +int kvm_loongarch_register_dmsintc_device(void);
>> +#endif
>> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
>> index 19eb5e5c3984..6a8d72cf8e4e 100644
>> --- a/arch/loongarch/include/asm/kvm_host.h
>> +++ b/arch/loongarch/include/asm/kvm_host.h
>> @@ -22,6 +22,7 @@
>>   #include <asm/kvm_ipi.h>
>>   #include <asm/kvm_eiointc.h>
>>   #include <asm/kvm_pch_pic.h>
>> +#include <asm/kvm_dmsintc.h>
>>   #include <asm/loongarch.h>
>>
>>   #define __KVM_HAVE_ARCH_INTC_INITIALIZED
>> @@ -135,6 +136,7 @@ struct kvm_arch {
>>          struct loongarch_ipi *ipi;
>>          struct loongarch_eiointc *eiointc;
>>          struct loongarch_pch_pic *pch_pic;
>> +       struct loongarch_dmsintc *dmsintc;
>>   };
>>
>>   #define CSR_MAX_NUMS           0x800
>> @@ -247,6 +249,7 @@ struct kvm_vcpu_arch {
>>          struct kvm_mp_state mp_state;
>>          /* ipi state */
>>          struct ipi_state ipi_state;
>> +       struct dmsintc_state dmsintc_state;
>>          /* cpucfg */
>>          u32 cpucfg[KVM_MAX_CPUCFG_REGS];
>>
>> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/include/uapi/asm/kvm.h
>> index 419647aacdf3..c39b8ac7a90a 100644
>> --- a/arch/loongarch/include/uapi/asm/kvm.h
>> +++ b/arch/loongarch/include/uapi/asm/kvm.h
>> @@ -155,4 +155,8 @@ struct kvm_iocsr_entry {
>>   #define KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL             0x40000006
>>   #define KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT            0
>>
>> +#define KVM_DEV_LOONGARCH_DMSINTC_CTRL                 0x40000007
>> +#define KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_BASE                0x0
>> +#define KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_SIZE                0x1
>> +
>>   #endif /* __UAPI_ASM_LOONGARCH_KVM_H */
>> diff --git a/arch/loongarch/kvm/Makefile b/arch/loongarch/kvm/Makefile
>> index cb41d9265662..6e184e24443c 100644
>> --- a/arch/loongarch/kvm/Makefile
>> +++ b/arch/loongarch/kvm/Makefile
>> @@ -19,6 +19,7 @@ kvm-y += vm.o
>>   kvm-y += intc/ipi.o
>>   kvm-y += intc/eiointc.o
>>   kvm-y += intc/pch_pic.o
>> +kvm-y += intc/dmsintc.o
>>   kvm-y += irqfd.o
>>
>>   CFLAGS_exit.o  += $(call cc-disable-warning, override-init)
>> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
>> new file mode 100644
>> index 000000000000..1bb61e55d061
>> --- /dev/null
>> +++ b/arch/loongarch/kvm/intc/dmsintc.c
>> @@ -0,0 +1,117 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2025 Loongson Technology Corporation Limited
>> + */
>> +
>> +#include <linux/kvm_host.h>
>> +#include <asm/kvm_dmsintc.h>
>> +#include <asm/kvm_vcpu.h>
>> +
>> +static int kvm_dmsintc_ctrl_access(struct kvm_device *dev,
>> +                               struct kvm_device_attr *attr,
>> +                               bool is_write)
>> +{
>> +       int addr = attr->attr;
>> +       void __user *data;
>> +       struct loongarch_dmsintc *s = dev->kvm->arch.dmsintc;
>> +       u64 tmp;
>> +       u32 cpu_bit;
>> +
>> +       data = (void __user *)attr->addr;
>> +       switch (addr) {
>> +       case KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_BASE:
>> +               if (is_write) {
>> +                       if (copy_from_user(&tmp, data, sizeof(s->msg_addr_base)))
>> +                               return -EFAULT;
>> +                       if (s->msg_addr_base) {
>> +                               /* Duplicate setting are not allowed. */
>> +                               return -EFAULT;
>> +                       }
>> +                       if ((tmp & (BIT(AVEC_CPU_SHIFT) - 1)) == 0)
>> +                               s->msg_addr_base = tmp;
>> +                       else
>> +                               return  -EFAULT;
>> +                       s->msg_addr_base = tmp;
>> +                       cpu_bit = find_first_bit((unsigned long *)&(s->msg_addr_base), 64)
>> +                                               - AVEC_CPU_SHIFT;
>> +                       cpu_bit = min(cpu_bit, AVEC_CPU_BIT);
>> +                       s->cpu_mask = GENMASK(cpu_bit - 1, 0) & AVEC_CPU_MASK;
>> +               }
>> +               break;
>> +       case KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_SIZE:
>> +               if (is_write) {
>> +                       if (copy_from_user(&tmp, data, sizeof(s->msg_addr_size)))
>> +                               return -EFAULT;
>> +                       if (s->msg_addr_size) {
>> +                               /*Duplicate setting are not allowed. */
>> +                               return -EFAULT;
>> +                       }
>> +                       s->msg_addr_size = tmp;
>> +               }
>> +               break;
>> +       default:
>> +               kvm_err("%s: unknown dmsintc register, addr = %d\n", __func__, addr);
>> +               return -ENXIO;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int kvm_dmsintc_set_attr(struct kvm_device *dev,
>> +                       struct kvm_device_attr *attr)
>> +{
>> +       switch (attr->group) {
>> +       case KVM_DEV_LOONGARCH_DMSINTC_CTRL:
>> +               return kvm_dmsintc_ctrl_access(dev, attr, true);
>> +       default:
>> +               kvm_err("%s: unknown group (%d)\n", __func__, attr->group);
>> +               return -EINVAL;
>> +       }
>> +}
>> +
>> +static int kvm_dmsintc_create(struct kvm_device *dev, u32 type)
>> +{
>> +       struct kvm *kvm;
>> +       struct loongarch_dmsintc *s;
>> +
>> +       if (!dev) {
>> +               kvm_err("%s: kvm_device ptr is invalid!\n", __func__);
>> +               return -EINVAL;
>> +       }
>> +
>> +       kvm = dev->kvm;
>> +       if (kvm->arch.dmsintc) {
>> +               kvm_err("%s: LoongArch DMSINTC has already been created!\n", __func__);
>> +               return -EINVAL;
>> +       }
>> +
>> +       s = kzalloc(sizeof(struct loongarch_dmsintc), GFP_KERNEL);
>> +       if (!s)
>> +               return -ENOMEM;
>> +
>> +       s->kvm = kvm;
>> +       kvm->arch.dmsintc = s;
>> +       return 0;
>> +}
>> +
>> +static void kvm_dmsintc_destroy(struct kvm_device *dev)
>> +{
>> +
>> +       if (!dev || !dev->kvm || !dev->kvm->arch.dmsintc)
>> +               return;
>> +
>> +       kfree(dev->kvm->arch.dmsintc);
>> +       kfree(dev);
>> +}
>> +
>> +static struct kvm_device_ops kvm_dmsintc_dev_ops = {
>> +       .name = "kvm-loongarch-dmsintc",
>> +       .create = kvm_dmsintc_create,
>> +       .destroy = kvm_dmsintc_destroy,
>> +       .set_attr = kvm_dmsintc_set_attr,
>> +};
>> +
>> +int kvm_loongarch_register_dmsintc_device(void)
>> +{
>> +       return kvm_register_device_ops(&kvm_dmsintc_dev_ops, KVM_DEV_TYPE_LOONGARCH_DMSINTC);
>> +}
>> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
>> index 2c593ac7892f..713771a93d90 100644
>> --- a/arch/loongarch/kvm/main.c
>> +++ b/arch/loongarch/kvm/main.c
>> @@ -416,6 +416,12 @@ static int kvm_loongarch_env_init(void)
>>
>>          /* Register LoongArch PCH-PIC interrupt controller interface. */
>>          ret = kvm_loongarch_register_pch_pic_device();
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Register LoongArch DMSINTC interrupt contrroller interface */
>> +       if (cpu_has_msgint)
> I still have some questions here. If we always create dmsintc when
> cpu_has_msgint, then kvm_guest_has_msgint() is completely useless.
> Because there will be no guest without dmsintc while the host has
> dmsintc.
>   

I'd like to clarify two points:

1. Registration vs. Instantiation:
In kvm_loongarch_env_init(), the call to kvm_loongarch_register_dmsintc_device()
(guarded by cpu_has_msgint) only registers the dmsintc device type with KVM.
This makes the device type available for userspace to create instances via KVM_CREATE_DEVICE.
It does not automatically instantiate the device for every VM. The actual creation of
a dmsintc device for a specific VM is explicitly controlled by userspace (e.g., QEMU).
Therefore, a VM may or may not have dmsintc depending on userspace configuration,
even on hosts that support MSGINT.

2.Purpose of kvm_guest_has_msgint():
This function is intended to reflect the userspace configuration for the guest,
i.e., whether the guest VM has MSGINT enabled.

With this in mind, the registration condition does not force every guest to have dmsintc,
and kvm_guest_has_msgint() remains meaningful as long as it queries per-VM state.

Please let me know if you have further concerns or suggestions.

Thanks.
Song Gao

>
> Huacai
>
>> +               ret = kvm_loongarch_register_dmsintc_device();
>>
>>          return ret;
>>   }
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 65500f5db379..f2aa9d6ad7d3 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1220,6 +1220,8 @@ enum kvm_device_type {
>>   #define KVM_DEV_TYPE_LOONGARCH_EIOINTC KVM_DEV_TYPE_LOONGARCH_EIOINTC
>>          KVM_DEV_TYPE_LOONGARCH_PCHPIC,
>>   #define KVM_DEV_TYPE_LOONGARCH_PCHPIC  KVM_DEV_TYPE_LOONGARCH_PCHPIC
>> +       KVM_DEV_TYPE_LOONGARCH_DMSINTC,
>> +#define KVM_DEV_TYPE_LOONGARCH_DMSINTC   KVM_DEV_TYPE_LOONGARCH_DMSINTC
>>
>>          KVM_DEV_TYPE_MAX,
>>
>> --
>> 2.39.3
>>

