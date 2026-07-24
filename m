Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34F430E0F2;
	Fri, 24 Jul 2026 01:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856484; cv=none; b=BKlVODpla0a6RZ0v5jTexSWak5P6X+pGIhTv0IcUytQTCBVGQbNlv26RsPWy+0vaaVtt1yyNVUOOmHMnhK09JwWuyp+Phu0hrFt/IzZkTmfrFbPkDjN5jMZDQn7KsOKEd+NMsJmcrlIxiyfR+S/M6bvMkzldBE5zL3g8K+8ifR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856484; c=relaxed/simple;
	bh=qKouplLjOdtzuc16h6lYcEmL1cPt5tO/vvWJ+HuiOEU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UbDxD5MCVwxfjR3j6relZDEjntQAYvq4sDoJVtIMRN3lti+uNFICPvBY19loO24GoD1yD82pw01+TONA5evTy+1q92JENzaf2T/mTe8RE94++USSfKXoiMaJ77cSWwnQCWb9lrSi7x4VYIvtDIH0+sz9rP+ZtU/pXq1yGS8Akvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Cxquugv2Jq9sQGAA--.25329S3;
	Fri, 24 Jul 2026 09:28:00 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxSsScv2JqfvQWAA--.4346S2;
	Fri, 24 Jul 2026 09:27:58 +0800 (CST)
Subject: Re: [PATCH 2/2] KVM: LoongArch: selftests: Add in-kernel MMIO read
 fast path test
To: Zeng Chi <zeng_chi911@163.com>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, kernel@xen0n.name
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, zengchi@kylinos.cn
References: <20260723111605.1630027-1-zeng_chi911@163.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <146b5e27-2ab0-da17-7b98-09235ef4f9c4@loongson.cn>
Date: Fri, 24 Jul 2026 09:27:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260723111605.1630027-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxSsScv2JqfvQWAA--.4346S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF4DWr1rXFyfCFyxur1fXwc_yoWrKrWUpa
	y0vw1akrWxJr17Grn7Gws8ua1fWr4ktF4xZF1fXry5Cr15JasaqF4kKa1kX3W3t3ykXryS
	v3WrWrs093WDJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU



On 2026/7/23 下午7:16, Zeng Chi wrote:
> From: Zeng Chi <zengchi@kylinos.cn>
> 
> Add a test that exercises the in-kernel MMIO read fast path of
> kvm_emu_mmio_read(). The guest performs an MMIO read from an in-kernel
> emulated PCH-PIC, immediately followed by a marker instruction, and the
> test verifies that the marker instruction is executed, i.e. that the PC
> advances by exactly one instruction instead of skipping the instruction
> after the MMIO read.
> 
> The test skips gracefully when the host KVM cannot create a PCH-PIC
> device.
> 
> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
>   tools/testing/selftests/kvm/Makefile.kvm      |  3 +-
>   .../selftests/kvm/loongarch/mmio_read_test.c  | 89 +++++++++++++++++++
>   2 files changed, 91 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/kvm/loongarch/mmio_read_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 6fc34e9bf8e1..4daf90caaabc 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -228,7 +228,8 @@ TEST_GEN_PROGS_riscv += mmu_stress_test
>   TEST_GEN_PROGS_riscv += rseq_test
>   TEST_GEN_PROGS_riscv += steal_time
>   
> -TEST_GEN_PROGS_loongarch = loongarch/pmu_test
> +TEST_GEN_PROGS_loongarch = loongarch/mmio_read_test
> +TEST_GEN_PROGS_loongarch += loongarch/pmu_test
>   TEST_GEN_PROGS_loongarch += arch_timer
>   TEST_GEN_PROGS_loongarch += coalesced_io_test
>   TEST_GEN_PROGS_loongarch += demand_paging_test
> diff --git a/tools/testing/selftests/kvm/loongarch/mmio_read_test.c b/tools/testing/selftests/kvm/loongarch/mmio_read_test.c
> new file mode 100644
> index 000000000000..7f64ca91ca8f
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/loongarch/mmio_read_test.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LoongArch KVM in-kernel MMIO read fast path test
> + *
> + * When an MMIO read hits a device emulated inside KVM (such as the
> + * PCH-PIC), kvm_emu_mmio_read() completes the access without returning
> + * to user space and advances the guest PC by one instruction.
> + *
> + * This test issues such an in-kernel MMIO read immediately followed by
> + * a marker instruction and checks that the marker instruction actually
> + * runs, i.e. that the PC advanced by exactly one instruction (4 bytes)
> + * rather than skipping the instruction after the MMIO read.
> + */
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "test_util.h"
> +#include "loongarch/processor.h"
> +
> +/* Physical base the in-kernel PCH-PIC is mapped at (no memslot backs it) */
> +#define PCH_PIC_BASE		0x10000000UL
> +
> +static void guest_code(void)
> +{
> +	unsigned long marker = 0;
> +	unsigned int val = 0;
> +
> +	/*
> +	 * 'ld.w' faults out as an MMIO read and is emulated in kernel.
> +	 * The following 'addi.d' must execute; it is skipped if the MMIO
> +	 * read fast path advances the PC twice (by 8 instead of 4).
> +	 */
> +	asm volatile(
> +		"ld.w	%[val], %[base], 0\n\t"
> +		"addi.d	%[marker], %[marker], 1\n\t"
> +		: [val] "=&r" (val), [marker] "+&r" (marker)
> +		: [base] "r" (PCH_PIC_BASE)
> +		: "memory");
By my understanding, the kvm selftest is mainly to test function. It 
will be better if it is to verify irq handling with in-kernel PCH-PIC 
irqchip.

Regards
Bibo Mao
> +
> +	GUEST_PRINTF("mmio read val=0x%x, marker=%lu\n", val, marker);
> +	GUEST_ASSERT_EQ(marker, 1);
> +	GUEST_DONE();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	uint64_t addr = PCH_PIC_BASE;
> +	int dev_fd;
> +
> +	vm = vm_create(VM_MODE_P47V47_16K);
> +	vcpu = vm_vcpu_add(vm, 0, guest_code);
> +
> +	/* Create the in-kernel PCH-PIC and map it at PCH_PIC_BASE */
> +	dev_fd = __kvm_create_device(vm, KVM_DEV_TYPE_LOONGARCH_PCHPIC);
> +	if (dev_fd < 0) {
> +		print_skip("PCH-PIC device not supported by host KVM");
> +		kvm_vm_free(vm);
> +		return KSFT_SKIP;
> +	}
> +	kvm_device_attr_set(dev_fd, KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL,
> +			    KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT, &addr);
> +	close(dev_fd);
> +
> +	/* Identity-map the MMIO page so the guest can reach the device */
> +	virt_map(vm, PCH_PIC_BASE, PCH_PIC_BASE, 1);
> +
> +	while (1) {
> +		vcpu_run(vcpu);
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_PRINTF:
> +			pr_info("%s", uc.buffer);
> +			break;
> +		case UCALL_DONE:
> +			goto done;
> +		case UCALL_ABORT:
> +			REPORT_GUEST_ASSERT(uc);
> +			goto done;
> +		default:
> +			TEST_FAIL("Unexpected exit: %s",
> +				  exit_reason_str(vcpu->run->exit_reason));
> +		}
> +	}
> +
> +done:
> +	kvm_vm_free(vm);
> +	return 0;
> +}
> 

