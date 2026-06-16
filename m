Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AC52EBB99
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572696; cv=none; b=S9xMQqC+miK4yqg2UWvgGzYR8SuzsKckvP3lMaE46SbdErzCCId2OAmIEVjlUGkc3nzsAsh2oTZgBovFDy2fUbdJGqXSbq/mmYfhz8TWwRKBaI148nJgjFzflRi8EOlX9gNXM6HLdsCOnu9JfQKeN6xSeqJs9qz9/wIJB/sG2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572696; c=relaxed/simple;
	bh=wVkc9rfRoAyXKQgtVQBc8jEXX/D2KqwMgxU0sWGxHjg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=d6k5WJ1DjZV586Sy2NNRlDll6Lcs8xSp5PZdaMPwf3emct31tjhW91CfR2m7QMJoXKtlwEV5v8cL3duktcY15dQiw1IIab10EBA80ptXYqCQS5ZbTNRrkWsx7tGPdQuo2Jtwho1IU8tF9ThZz2YgRbZ/B9IjTnGWzZuGLukTFa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxT+pTpDBqKZcUAA--.53203S3;
	Tue, 16 Jun 2026 09:18:11 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBx68FPpDBq+qenAA--.53869S3;
	Tue, 16 Jun 2026 09:18:09 +0800 (CST)
Subject: Re: [PATCH v4 2/3] LoongArch: KVM: Implement guest-side PV TLB flush
To: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, loongarch@lists.linux.dev
Cc: kernel@xen0n.name, kvm@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
References: <20260615082154.42144-1-cui.tao@linux.dev>
 <20260615082154.42144-3-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <0c47ce21-9a4d-4cdc-9bec-ce749e31512e@loongson.cn>
Date: Tue, 16 Jun 2026 09:14:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260615082154.42144-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx68FPpDBq+qenAA--.53869S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XFy7Gw1UGry5ur1ktr17CFX_yoWfXw1kpr
	yUCwsYga1rWr97A343Z3yjkr15Zw4DK3WIva13uFWFyFnrXFyUKr93GrykZa4kWa95GF4F
	gFyrArsFgFyUt3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU



On 2026/6/15 下午4:21, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Add the guest-side implementation of PV TLB flush for LoongArch KVM
> guests, complementing the host-side support added in the previous commit.
> 
> When running as a KVM guest, remote TLB flushes are optimized by
> avoiding IPIs to preempted vCPUs:
> 
> - kvm_flush_tlb_mask() checks each target vCPU's steal-time
>    preempted flag. If a vCPU is preempted, it atomically sets
>    KVM_VCPU_FLUSH_TLB in the shared preempted byte via cmpxchg
>    and removes that CPU from the IPI mask.
> - Only non-preempted vCPUs receive IPIs via on_each_cpu_mask().
> - When the host schedules a deferred-flush vCPU back in, it
>    invalidates the VPID and flushes the TLB automatically.
> 
> All six SMP TLB flush functions (flush_tlb_all, flush_tlb_mm,
> flush_tlb_range, flush_tlb_kernel_range, flush_tlb_page,
> flush_tlb_one) are updated to use the PV path when the static
> key pv_tlb_flush_key is enabled.
> 
> The feature is gated by KVM_FEATURE_PV_TLB_FLUSH and requires
> KVM_FEATURE_STEAL_TIME (for the shared memory page). Per-CPU
> cpumask buffers are allocated via arch_initcall.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   arch/loongarch/include/asm/kvm_para.h |  8 ++++
>   arch/loongarch/include/asm/paravirt.h | 21 ++++++++++
>   arch/loongarch/kernel/paravirt.c      | 60 +++++++++++++++++++++++++++
>   arch/loongarch/kernel/smp.c           | 30 +++++++++++---
>   4 files changed, 113 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/include/asm/kvm_para.h
> index 28e3fa3b4c0e..7956aeff2436 100644
> --- a/arch/loongarch/include/asm/kvm_para.h
> +++ b/arch/loongarch/include/asm/kvm_para.h
> @@ -187,4 +187,12 @@ static inline bool kvm_check_and_clear_guest_paused(void)
>   	return false;
>   }
>   
> +static inline bool kvm_pv_tlb_flush_supported(void)
> +{
> +	unsigned int feat = kvm_arch_para_features();
> +
> +	return (feat & (1U << KVM_FEATURE_PV_TLB_FLUSH)) &&
> +	       (feat & (1U << KVM_FEATURE_STEAL_TIME));
> +}
> +
>   #endif /* _ASM_LOONGARCH_KVM_PARA_H */
> diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarch/include/asm/paravirt.h
> index acae1c5e5f88..6ce62b555a5d 100644
> --- a/arch/loongarch/include/asm/paravirt.h
> +++ b/arch/loongarch/include/asm/paravirt.h
> @@ -5,15 +5,26 @@
>   #ifdef CONFIG_PARAVIRT
>   
>   #include <linux/jump_label.h>
> +#include <linux/cpumask.h>
> +#include <linux/smp.h>
>   
>   DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
>   DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
> +DECLARE_STATIC_KEY_FALSE(pv_tlb_flush_key);
>   DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
>   
>   int __init pv_ipi_init(void);
>   int __init pv_time_init(void);
>   int __init pv_spinlock_init(void);
>   
> +void kvm_flush_tlb_mask(const struct cpumask *cpumask,
> +			smp_call_func_t func, void *info);
> +
> +static inline bool pv_tlb_flush_enabled(void)
> +{
> +	return static_branch_unlikely(&pv_tlb_flush_key);
> +}
> +
>   #else
>   
>   static inline int pv_ipi_init(void)
> @@ -31,5 +42,15 @@ static inline int pv_spinlock_init(void)
>   	return 0;
>   }
>   
> +static inline bool pv_tlb_flush_enabled(void)
> +{
> +	return false;
> +}
> +
> +static inline void kvm_flush_tlb_mask(const struct cpumask *cpumask,
> +				       smp_call_func_t func, void *info)
> +{
> +}
> +
>   #endif // CONFIG_PARAVIRT
>   #endif
> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
> index 10821cce554c..eab84c9b94f6 100644
> --- a/arch/loongarch/kernel/paravirt.c
> +++ b/arch/loongarch/kernel/paravirt.c
> @@ -12,7 +12,9 @@
>   static int has_steal_clock;
>   DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
>   DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
> +DEFINE_STATIC_KEY_FALSE(pv_tlb_flush_key);
>   DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
> +static DEFINE_PER_CPU(cpumask_var_t, __pv_cpu_mask);
>   
>   static bool steal_acc = true;
>   
> @@ -208,6 +210,64 @@ int __init pv_ipi_init(void)
>   	return 0;
>   }
>   
> +#ifdef CONFIG_SMP
> +void kvm_flush_tlb_mask(const struct cpumask *cpumask,
> +			       smp_call_func_t func, void *info)
> +{
> +	int cpu;
> +	struct kvm_steal_time *src;
> +	struct cpumask *flushmask;
> +
> +	preempt_disable();
> +	flushmask = this_cpu_cpumask_var_ptr(__pv_cpu_mask);
> +	cpumask_copy(flushmask, cpumask);
> +
> +	/*
> +	 * We have to call flush only on online vCPUs. And
> +	 * queue flush_on_enter for pre-empted vCPUs
> +	 */
> +	for_each_cpu(cpu, flushmask) {
> +		u32 *ptr, old, new;
> +
> +		src = &per_cpu(steal_time, cpu);
> +		ptr = (u32 *)&src->preempted;
> +		old = READ_ONCE(*ptr);
> +		if (!((u8)old & KVM_VCPU_PREEMPTED))
> +			continue;
> +
> +		new = old | KVM_VCPU_FLUSH_TLB;
> +		if (try_cmpxchg(ptr, &old, new))
> +			__cpumask_clear_cpu(cpu, flushmask);
is it possible that vCPU is running however with KVM_VCPU_PREEMPTED set?
> +	}
> +
> +	on_each_cpu_mask(flushmask, func, info, 1);
LoongArch VM does not support post interrupt now, IPI with vCPU will 
trap to hypervisor.

There is another PV TLB flush method using hypercall like PV IPI, which 
will make a request with wait flag such as KVM_REQ_TLB_FLUSH and kick vCPU.

With this PV TLB flush method, there is not IPI interrupt in VM, and 
wait is handled in hypervisor, the negative effect is that it flushes 
all TLBs.

Regards
Bibo Mao
> +	preempt_enable();
> +}
> +
> +static int __init pv_tlb_flush_init(void)
> +{
> +	int cpu;
> +
> +	if (!kvm_pv_tlb_flush_supported())
> +		return 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (!zalloc_cpumask_var_node(per_cpu_ptr(&__pv_cpu_mask, cpu),
> +					    GFP_KERNEL, cpu_to_node(cpu))) {
> +			while (--cpu >= 0)
> +				free_cpumask_var(*per_cpu_ptr(&__pv_cpu_mask, cpu));
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	static_branch_enable(&pv_tlb_flush_key);
> +	pr_info("KVM setup pv remote TLB flush\n");
> +
> +	return 0;
> +}
> +arch_initcall(pv_tlb_flush_init);
> +#endif
> +
>   static int pv_enable_steal_time(void)
>   {
>   	int cpu = smp_processor_id();
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index 50922610758b..bb3451b057ed 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -727,7 +727,10 @@ static void flush_tlb_all_ipi(void *info)
>   
>   void flush_tlb_all(void)
>   {
> -	on_each_cpu(flush_tlb_all_ipi, NULL, 1);
> +	if (pv_tlb_flush_enabled())
> +		kvm_flush_tlb_mask(cpu_online_mask, flush_tlb_all_ipi, NULL);
> +	else
> +		on_each_cpu(flush_tlb_all_ipi, NULL, 1);
>   }
>   
>   static void flush_tlb_mm_ipi(void *mm)
> @@ -743,7 +746,10 @@ void flush_tlb_mm(struct mm_struct *mm)
>   	preempt_disable();
>   
>   	if ((atomic_read(&mm->mm_users) != 1) || (current->mm != mm)) {
> -		on_each_cpu_mask(mm_cpumask(mm), flush_tlb_mm_ipi, mm, 1);
> +		if (pv_tlb_flush_enabled())
> +			kvm_flush_tlb_mask(mm_cpumask(mm), flush_tlb_mm_ipi, mm);
> +		else
> +			on_each_cpu_mask(mm_cpumask(mm), flush_tlb_mm_ipi, mm, 1);
>   	} else {
>   		unsigned int cpu;
>   
> @@ -782,7 +788,10 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned l
>   			.addr2 = end,
>   		};
>   
> -		on_each_cpu_mask(mm_cpumask(mm), flush_tlb_range_ipi, &fd, 1);
> +		if (pv_tlb_flush_enabled())
> +			kvm_flush_tlb_mask(mm_cpumask(mm), flush_tlb_range_ipi, &fd);
> +		else
> +			on_each_cpu_mask(mm_cpumask(mm), flush_tlb_range_ipi, &fd, 1);
>   	} else {
>   		unsigned int cpu;
>   
> @@ -809,7 +818,10 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>   		.addr2 = end,
>   	};
>   
> -	on_each_cpu(flush_tlb_kernel_range_ipi, &fd, 1);
> +	if (pv_tlb_flush_enabled())
> +		kvm_flush_tlb_mask(cpu_online_mask, flush_tlb_kernel_range_ipi, &fd);
> +	else
> +		on_each_cpu(flush_tlb_kernel_range_ipi, &fd, 1);
>   }
>   
>   static void flush_tlb_page_ipi(void *info)
> @@ -828,7 +840,10 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
>   			.addr1 = page,
>   		};
>   
> -		on_each_cpu_mask(mm_cpumask(vma->vm_mm), flush_tlb_page_ipi, &fd, 1);
> +		if (pv_tlb_flush_enabled())
> +			kvm_flush_tlb_mask(mm_cpumask(vma->vm_mm), flush_tlb_page_ipi, &fd);
> +		else
> +			on_each_cpu_mask(mm_cpumask(vma->vm_mm), flush_tlb_page_ipi, &fd, 1);
>   	} else {
>   		unsigned int cpu;
>   
> @@ -851,6 +866,9 @@ static void flush_tlb_one_ipi(void *info)
>   
>   void flush_tlb_one(unsigned long vaddr)
>   {
> -	on_each_cpu(flush_tlb_one_ipi, (void *)vaddr, 1);
> +	if (pv_tlb_flush_enabled())
> +		kvm_flush_tlb_mask(cpu_online_mask, flush_tlb_one_ipi, (void *)vaddr);
> +	else
> +		on_each_cpu(flush_tlb_one_ipi, (void *)vaddr, 1);
>   }
>   EXPORT_SYMBOL(flush_tlb_one);
> 

