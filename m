Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035C194AE6;
	Tue,  9 Jun 2026 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995766; cv=none; b=D93Q+pYb+LB2HJZW2LRBaOw6JZ25iE/FJmOs8c6IMURPcrD/l3MAyzrgcXG+aV8ssVUT8QNeBB/gG0qPQZ3LXym6oeV4zSzqfHn4QUR656lOk+vNNdLYN0xLhvhwSSjl3W/pezWeR4BRhK0UyzUMYL1f8RVoQTlfmRRAH6F/oe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995766; c=relaxed/simple;
	bh=WOtz/NbdCJ8NiMOZ+ZkHeWuV0Hv7t2iQYK/ZVFHMVDc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uMH96VXwKnPA6p34XdOnqfQv3PdaMEnPDAG/riQ515+frNys6fsEU94zPQ1G7QhSzj154tCY9AlEOe4kmfS/lmbMkuUCd30WXVsaM+RnG39806i682DZYW+AqCuTJsJfHXjcc3RvM1XxkHh7xsKbQ03gQqZIOdJ4kqr3zYXS2W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Ax_umw1idqAzESAA--.47904S3;
	Tue, 09 Jun 2026 17:02:40 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCx+8Gv1idqCKCgAA--.43514S3;
	Tue, 09 Jun 2026 17:02:39 +0800 (CST)
Subject: Re: [PATCH v2 2/2] KVM: LoongArch: selftests: Add FPU test case
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260609072715.1005923-1-maobibo@loongson.cn>
 <20260609072715.1005923-3-maobibo@loongson.cn>
 <CAAhV-H64=C8iBRHrE=0rohnGxK1WeWUoG9zWrH9MB1kaw6usww@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <efe9f60e-6229-06bc-0dc5-cee9c53a2076@loongson.cn>
Date: Tue, 9 Jun 2026 16:59:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H64=C8iBRHrE=0rohnGxK1WeWUoG9zWrH9MB1kaw6usww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx+8Gv1idqCKCgAA--.43514S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JF4fZw47WrWUWryfJrWxKrX_yoW3Arykp3
	yvk3WqgF48tF17Jw48Zws8ur4fKr18Kr4Igr1SqFWUAr1qkrZ3tF1kKrWvgrn8uws5X3WF
	vF1fJwsI9FyDJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
	67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU8czVUUUUUU==



On 2026/6/9 下午4:40, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Tue, Jun 9, 2026 at 3:27 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Add FPU test case and verify FPU register get and set APIs, the
>> FPU width supports 64/128/256 bits.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>>   .../kvm/include/loongarch/processor.h         |   8 +
>>   .../selftests/kvm/loongarch/fpu_test.c        | 145 ++++++++++++++++++
>>   3 files changed, 154 insertions(+)
>>   create mode 100644 tools/testing/selftests/kvm/loongarch/fpu_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
>> index 9118a5a51b89..7d11592b3759 100644
>> --- a/tools/testing/selftests/kvm/Makefile.kvm
>> +++ b/tools/testing/selftests/kvm/Makefile.kvm
>> @@ -224,6 +224,7 @@ TEST_GEN_PROGS_riscv += rseq_test
>>   TEST_GEN_PROGS_riscv += steal_time
>>
>>   TEST_GEN_PROGS_loongarch = loongarch/pmu_test
>> +TEST_GEN_PROGS_loongarch += loongarch/fpu_test
>>   TEST_GEN_PROGS_loongarch += arch_timer
>>   TEST_GEN_PROGS_loongarch += coalesced_io_test
>>   TEST_GEN_PROGS_loongarch += demand_paging_test
>> diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/tools/testing/selftests/kvm/include/loongarch/processor.h
>> index 2324e311180f..981ae7078354 100644
>> --- a/tools/testing/selftests/kvm/include/loongarch/processor.h
>> +++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
>> @@ -82,6 +82,14 @@
>>   #define  PLV_MASK                      0x3
>>   #define LOONGARCH_CSR_PRMD             0x1
>>   #define LOONGARCH_CSR_EUEN             0x2
>> +#define  CSR_EUEN_LBTEN_SHIFT          3
>> +#define  CSR_EUEN_LBTEN                        BIT_ULL(CSR_EUEN_LBTEN_SHIFT)
>> +#define  CSR_EUEN_LASXEN_SHIFT         2
>> +#define  CSR_EUEN_LASXEN               BIT_ULL(CSR_EUEN_LASXEN_SHIFT)
>> +#define  CSR_EUEN_LSXEN_SHIFT          1
>> +#define  CSR_EUEN_LSXEN                        BIT_ULL(CSR_EUEN_LSXEN_SHIFT)
>> +#define  CSR_EUEN_FPEN_SHIFT           0
>> +#define  CSR_EUEN_FPEN                 BIT_ULL(CSR_EUEN_FPEN_SHIFT)
>>   #define LOONGARCH_CSR_ECFG             0x4
>>   #define  ECFGB_PMU                     10
>>   #define  ECFGF_PMU                     (BIT_ULL(ECFGB_PMU))
>> diff --git a/tools/testing/selftests/kvm/loongarch/fpu_test.c b/tools/testing/selftests/kvm/loongarch/fpu_test.c
>> new file mode 100644
>> index 000000000000..5bccce9db5d0
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/loongarch/fpu_test.c
>> @@ -0,0 +1,145 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <stdio.h>
>> +#include <string.h>
>> +#include "kvm_util.h"
>> +#include "processor.h"
>> +#include "loongarch/processor.h"
>> +
>> +struct kvm_fpureg __aligned(64) vector = {{1, 2, 3, 4 }};
>> +
>> +static void guest_code(void)
>> +{
>> +       unsigned long val;
>> +       struct kvm_fpureg *fp = &vector;
>> +
>> +       val = csr_read(LOONGARCH_CSR_EUEN);
>> +       val |= CSR_EUEN_FPEN | CSR_EUEN_LSXEN | CSR_EUEN_LASXEN;
>> +       csr_write(val, LOONGARCH_CSR_EUEN);
>> +
>> +       __asm__ __volatile__("fld.d $f0, %0, 0\n" : : "r"(fp) : "$f0");
>> +       GUEST_SYNC(0);
>> +
>> +       __asm__ __volatile__("vld $vr0, %0, 0\n" : : "r"(fp) : "$vr0");
>> +       GUEST_SYNC(1);
>> +
>> +       __asm__ __volatile__("xvld $xr0, %0, 0\n" : : "r"(fp) : "$xr0");
>> +       GUEST_SYNC(2);
>> +
>> +       __asm__ __volatile__("fst.d $f0, %0, 0\n" : : "r"(fp) : "memory");
>> +       GUEST_SYNC(3);
>> +
>> +       __asm__ __volatile__("vst $vr0, %0, 0\n" : : "r"(fp) : "memory");
>> +       GUEST_SYNC(4);
>> +
>> +       __asm__ __volatile__("xvst $xr0, %0, 0\n" : : "r"(fp) : "memory");
>> +       GUEST_SYNC(5);
>> +
>> +       GUEST_DONE();
>> +}
>> +
>> +static void run_vcpu(struct kvm_vcpu *vcpu)
>> +{
>> +       struct ucall uc;
>> +       int cont;
>> +
>> +       cont = 1;
>> +       while (cont) {
>> +               vcpu_run(vcpu);
>> +
>> +               switch (get_ucall(vcpu, &uc)) {
>> +               case UCALL_PRINTF:
>> +                       printf("%s", (const char *)uc.buffer);
>> +                       break;
>> +               case UCALL_DONE:
>> +                       printf("FPU test PASSED\n");
>> +                       fallthrough;
>> +               case UCALL_SYNC:
>> +                       cont = 0;
>> +                       break;
>> +               case UCALL_ABORT:
>> +                       REPORT_GUEST_ASSERT(uc);
>> +               default:
>> +                       TEST_ASSERT(false, "Unexpected exit: %s",
>> +                               exit_reason_str(vcpu->run->exit_reason));
>> +               }
>> +       }
>> +}
>> +
>> +static bool __vm_has_feature(struct kvm_vm *vm, int feature)
>> +{
>> +       int ret;
>> +
>> +       ret = __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL, feature);
>> +       return !ret;
>> +}
>> +
>> +
>> +int main(void)
>> +{
>> +       struct kvm_vcpu *vcpu;
>> +       struct kvm_vm *vm;
>> +       struct kvm_fpu fpu;
>> +       struct kvm_fpureg *fp = &vector;
>> +
>> +       vm = vm_create_with_one_vcpu(&vcpu, guest_code);
>> +       __TEST_REQUIRE(__vm_has_feature(vm, KVM_LOONGARCH_VM_FEAT_LSX),
>> +                       "LSX not available, skipping test\n");
>> +       __TEST_REQUIRE(__vm_has_feature(vm, KVM_LOONGARCH_VM_FEAT_LASX),
>> +                       "LASX not available, skipping test\n");
> Directly use __kvm_has_device_attr() as the first patch, or use
> __vm_has_feature() in the first patch?
do you mean something like this?
        ret = __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL, 
KVM_LOONGARCH_VM_FEAT_LSX);
        __TEST_REQUIRE(!ret, "LSX not available, skipping test\n");
        ret = __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL, 
KVM_LOONGARCH_VM_FEAT_LASX);
        __TEST_REQUIRE(!ret, "LASX not available, skipping test\n");

I am ok with both.
> 
> BTW, I don't think the __ prefix is necessary.
There seem no unified rules with kvm selftest cases, I have no idea 
about this actually. There are __kvm_has_device_attr/__TEST_REQUIRE 
public APIs and real usages.

Regards
Bibo Mao
> 
> Huacai
> 
>> +
>> +       run_vcpu(vcpu);
>> +       vcpu_fpu_get(vcpu, &fpu);
>> +       TEST_ASSERT(!memcmp(fpu.fpr, fp, 8), "Wanted 0x%llx from f0, got 0x%llx",
>> +                       fp->val64[0], fpu.fpr[0].val64[0]);
>> +
>> +       run_vcpu(vcpu);
>> +       vcpu_fpu_get(vcpu, &fpu);
>> +       TEST_ASSERT(!memcmp(fpu.fpr, fp, 16), "Wanted 0x%llx %llx from vr0, got 0x%llx %llx",
>> +                       fp->val64[0], fp->val64[1],
>> +                       fpu.fpr[0].val64[0], fpu.fpr[0].val64[1]);
>> +
>> +       run_vcpu(vcpu);
>> +       vcpu_fpu_get(vcpu, &fpu);
>> +       TEST_ASSERT(!memcmp(fpu.fpr, fp, 32),
>> +                       "Wanted 0x%llx %llx %llx %llx from xr0, got 0x%llx %llx %llx %llx",
>> +                       fp->val64[0], fp->val64[1], fp->val64[2], fp->val64[3],
>> +                       fpu.fpr[0].val64[0], fpu.fpr[0].val64[1],
>> +                       fpu.fpr[0].val64[2], fpu.fpr[0].val64[3]);
>> +
>> +       fpu.fpr[0].val64[0] += random();
>> +       vcpu_fpu_set(vcpu, &fpu);
>> +       run_vcpu(vcpu);
>> +       vcpu_fpu_get(vcpu, &fpu);
>> +       sync_global_from_guest(vm, *fp);
>> +       TEST_ASSERT(!memcmp(fpu.fpr, fp, 8), "Wanted 0x%llx from f0, got 0x%llx",
>> +                       fp->val64[0], fpu.fpr[0].val64[0]);
>> +
>> +       fpu.fpr[0].val64[0] += random();
>> +       fpu.fpr[0].val64[1] += random();
>> +       vcpu_fpu_set(vcpu, &fpu);
>> +       run_vcpu(vcpu);
>> +       vcpu_fpu_get(vcpu, &fpu);
>> +       sync_global_from_guest(vm, *fp);
>> +       TEST_ASSERT(!memcmp(fpu.fpr, fp, 16), "Wanted 0x%llx %llx from vr0, got 0x%llx %llx",
>> +                       fp->val64[0], fp->val64[1],
>> +                       fpu.fpr[0].val64[0], fpu.fpr[0].val64[1]);
>> +
>> +       fpu.fpr[0].val64[0] += random();
>> +       fpu.fpr[0].val64[1] += random();
>> +       fpu.fpr[0].val64[2] += random();
>> +       fpu.fpr[0].val64[3] += random();
>> +       vcpu_fpu_set(vcpu, &fpu);
>> +       run_vcpu(vcpu);
>> +       vcpu_fpu_get(vcpu, &fpu);
>> +       sync_global_from_guest(vm, *fp);
>> +       TEST_ASSERT(!memcmp(fpu.fpr, fp, 32),
>> +                       "Wanted 0x%llx %llx %llx %llx from xr0, got 0x%llx %llx %llx %llx",
>> +                       fp->val64[0], fp->val64[1], fp->val64[2], fp->val64[3],
>> +                       fpu.fpr[0].val64[0], fpu.fpr[0].val64[1],
>> +                       fpu.fpr[0].val64[2], fpu.fpr[0].val64[3]);
>> +
>> +       run_vcpu(vcpu);
>> +       kvm_vm_free(vm);
>> +       return 0;
>> +}
>> --
>> 2.39.3
>>

