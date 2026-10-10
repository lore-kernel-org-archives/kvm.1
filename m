Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D20225403;
	Sat, 10 Oct 2026 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791598645; cv=none; b=b8RsFWhhFmDM+QM0lY7OEjmk3OcQeMMT5nhOOIio/9UjNgwUsn2DZWewY98O8YcsdPFTgPXbBe0l9N9eGzmLunfEsRsBAzP4dzPLydAQNXG+bYY7dX4871khIuIcAh0pGgGHWdyG/T2TiK4CvnYFrMNnUwDAKoKhQbezqnl0RzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791598645; c=relaxed/simple;
	bh=Hhqf2rxMuYAykiBd6rvceywTER/CWyE67mbalSq1aiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahNKU7SK2JZ4V+nTP+02OYugaT0Euh+cj0gOqBfmu2YXnLv2KQRGnfAgR175uK0nXO8pe7z//KCwgsvfGfxI5kE9kA1zPUC3TIrwwyF1C5lyuIXw5lz+/K6atvZB4p6GniO2DZ7YhxRYzgJ4StzhiMWT6ldKgUWspT75OTH61JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; dkim=pass (2048-bit key) header.d=bosc.ac.cn header.i=@bosc.ac.cn header.b=cgvOnQ2G; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bosc.ac.cn header.i=@bosc.ac.cn header.b="cgvOnQ2G"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bosc.ac.cn; s=default;
	t=1791598637; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tAaSWg+FiIF+mfiCv0Bf3xGBh5UNq3lj4Ud/0h90OOk=;
	b=cgvOnQ2GSLWn00BJDIDu0Y6cp4olm6tZgWQvwoi/ftSsXiGw/0fPwLitHtUkvMUPQp4E0OTAih7r4UYdJXQO/QMs31f7zMMoYi8b6NWMwHZigjlXDEa4jkGSdDsh7Pe6r0qmGHuAA9xk2wi/26JceJJCllOGLNwphAL1l9W7g+3Pk84Z64NqFxGTtIjKQscYH7GVTZQv3zEvI0Qxyzt1BDyq9MBr/DcqTfB5btLjmoSq09OMhJIF79tGZcX0JzHF9G1o8yMrcU1muKv+dPMn0BwhZQxoOeSAsURaK6xGOTWW0gGcQqeChcbIRx4JfTZWid2kLkpEbPLRGEFpEz7LSg==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436626|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0123358-5.81746e-05-0.987606;FP=13689178294156477665|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=guoyaxing@bosc.ac.cn;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.jY-HNee_1791598315;
Received: from 172.28.100.209(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.jY-HNee_1791598315 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 10 Oct 2026 10:11:56 +0800
Message-ID: <285419e5-c4fc-4c75-a765-436165bdc8b9@bosc.ac.cn>
Date: Sat, 10 Oct 2026 10:11:49 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: KVM: Flush VS-stage TLB before reusing a host CPU
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, majiuyue@bosc.ac.cn, anzoso@outlook.com
References: <20260817102447.40259-1-guoyaxing@bosc.ac.cn>
 <CAAhSdy2qwdHE7SB2gRK3_PQ6m_bMSfWpvcuSG-31W2yd3-UTKg@mail.gmail.com>
From: guoyaxing <guoyaxing@bosc.ac.cn>
In-Reply-To: <CAAhSdy2qwdHE7SB2gRK3_PQ6m_bMSfWpvcuSG-31W2yd3-UTKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/10 02:51, Anup Patel 写道:
> On Mon, Aug 17, 2026 at 12:25 PM Yaxing Guo <guoyaxing@bosc.ac.cn> wrote:
>>
>> Guest Linux uses mm_cpumask to decide whether an sfence.vma needs to be
>> local or remote. Under KVM that mask tracks guest CPUs, not the host CPUs
>> that previously backed a vCPU.
>>
>> This can miss stale VS-stage TLB entries when a vCPU migrates across host
>> CPUs. For example:
>>
>>    - vcpu0 runs on host CPU1 and fills a VS-stage TLB entry.
>>    - vcpu0 migrates to host CPU0.
>>    - the guest updates the mapping on vcpu0 and issues a local sfence.vma.
>>    - later, the guest task runs on vcpu1 while vcpu1 is backed by host CPU1.
> 
> When the vcpu0 is brought back to host CPU1, the kvm_riscv_local_tlb_sanitize()
> will ensure TLB entries associated with Guest/VM are nuked.
> 
> By default, kvm_riscv_local_hfence_gvma_vmid_all() will only do HFENCE.GVMA
> for the associated VMID because most RISC-V H-extension implemenation will
> tag VS-stage TLB entries with VMID and HFENCE.GVMA must remove both
> G-stage and VS-stage TLB entries for given VMID.
> 
> If your HW does not tag VS-stage TLB enteries with VMID then it buggy
> / inefficient
> so you have to set kvm_riscv_vsstage_tlb_no_gpa in
> kvm_riscv_setup_vendor_features()
> as work-around.
> 
> NACK to this patch from myside.
> 
> Regards,
> Anup
> 
Hi Anup,
   Thanks for the review and clarification.

   Regarding “When the vcpu0 is brought back to host CPU1”: the failure 
we hit is not caused by vcpu0 being brought back onto host CPU1. In our 
case, after vcpu0 has already migrated away, neither vCPU migrates 
again. The guest process is later scheduled inside the multi-vCPU guest 
onto vcpu1, which is still running on host CPU1. So the stale TLB is 
re-hit without any further KVM vCPU migration, and 
kvm_riscv_local_tlb_sanitize() is not involved on that path.

   My commit message was a bit too terse on this point. The concrete 
sequence we observed was described earlier in the RFC discussion:

  
https://lore.kernel.org/kvm/0d15b098-b8f7-4080-9f33-e8c49c2331e1@bosc.ac.cn/

   In short, the issue is: because vcpu0 migrated away, cpu1 still has 
stale TLB entries while cpu0 has the new mapping. After that, neither 
vcpu migrated again, but the process was scheduled from vcpu0 to vcpu1 
(which is on cpu1), causing it to hit the stale TLB. Consider the 
following scenario:

   1. vcpu0 and vcpu1 are both running on cpu1. At this point, vcpu0 is 
on cpu1, and a process on it reads a page, which gets cached in the TLB 
(let's call this the "stale TLB entry").

   2. vcpu0 migrates to cpu0, and then the process (on vcpu0, now on 
cpu0) does a CoW (copy-on-write) and establishes a new mapping.

   3. Neither vcpu0 nor vcpu1 migrates again. At this point, the process 
gets scheduled inside the VM onto vcpu1 (which is on cpu1), reads the 
same page, and hits the stale TLB entry.

   So this is an intra-guest scheduling case onto a vCPU that stayed on 
the original host CPU, rather than a “vcpu0 returns to host CPU1” case.

   Thanks,
   Yaxing

>>
>> Host CPU1 did not observe the guest-local sfence.vma, and KVM can enter
>> vcpu1 with a stale VS-stage translation left behind by vcpu0.
>>
>> The reported failure was seen on a XiangShan RISC-V system. A bash task
>> ran on vcpu0 while vcpu0 was backed by host CPU1, and a read-only page was
>> prefetched into CPU1's VS-stage TLB. vcpu0 later migrated to host CPU0,
>> where the guest triggered COW, updated the mapping, and issued only a local
>> sfence.vma. The stale VS-stage entry on CPU1 survived. When the same guest
>> task later ran on another vCPU backed by host CPU1, it hit the stale
>> translation. The page contained a GOT pointer, and using the stale data led
>> to a NULL dereference and a userspace segmentation fault.
>>
>> The existing local TLB sanitize path flushes G-stage entries when a vCPU
>> migrates, and flushes VS-stage entries only for implementations selected by
>> the Andes-specific kvm_riscv_vsstage_tlb_no_gpa static key. That handles a
>> split two-stage TLB implementation where HFENCE.GVMA does not invalidate
>> VS-stage entries, but it does not cover the generic guest-local sfence.vma
>> case above.
>>
>> Track, per VM and per host CPU, the last vCPU that entered the guest on
>> that CPU. Before guest entry, flush the current CPU's VS-stage context for
>> the VM if either the current vCPU migrated since its last exit, or this
>> host CPU is switching from another vCPU of the same VM. Keep the existing
>> HFENCE.GVMA behavior tied to vCPU migration.
>>
>> This also subsumes the Andes split-TLB workaround. That workaround was
>> needed because the migration sanitize path previously relied on
>> HFENCE.GVMA alone for most implementations, and only issued HFENCE.VVMA
>> when kvm_riscv_vsstage_tlb_no_gpa was set. The new sanitize path always
>> issues HFENCE.VVMA when reusing a host CPU for a VM context that may have
>> missed a guest-local sfence.vma, so it no longer depends on HFENCE.GVMA
>> invalidating VS-stage entries. The implementation-specific static key and
>> setup hook are therefore no longer needed.
>>
>> Reported-by: Zhizun Wang <anzoso@outlook.com>
>> Reviewed-by: Jiuyue Ma <majiuyue@bosc.ac.cn>
>> Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
>> ---
>>   arch/riscv/include/asm/kvm_host.h |  6 +++---
>>   arch/riscv/kvm/main.c             | 15 ---------------
>>   arch/riscv/kvm/tlb.c              | 31 +++++++++++++++++++++++--------
>>   arch/riscv/kvm/vm.c               | 16 ++++++++++++++++
>>   4 files changed, 42 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
>> index 24585304c..396ac6209 100644
>> --- a/arch/riscv/include/asm/kvm_host.h
>> +++ b/arch/riscv/include/asm/kvm_host.h
>> @@ -91,6 +91,9 @@ struct kvm_arch {
>>          /* G-stage vmid */
>>          struct kvm_vmid vmid;
>>
>> +       /* Last VCPU that ran on each physical CPU */
>> +       int __percpu *last_vcpu_ran;
>> +
>>          /* G-stage page table */
>>          pgd_t *pgd;
>>          phys_addr_t pgd_phys;
>> @@ -330,7 +333,4 @@ bool kvm_riscv_vcpu_stopped(struct kvm_vcpu *vcpu);
>>
>>   void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
>>
>> -/* Flags representing implementation specific details */
>> -DECLARE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
>> -
>>   #endif /* __RISCV_KVM_HOST_H__ */
>> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
>> index 0f3fe3986..b1bbc0835 100644
>> --- a/arch/riscv/kvm/main.c
>> +++ b/arch/riscv/kvm/main.c
>> @@ -10,23 +10,10 @@
>>   #include <linux/err.h>
>>   #include <linux/module.h>
>>   #include <linux/kvm_host.h>
>> -#include <asm/cpufeature.h>
>>   #include <asm/kvm_mmu.h>
>>   #include <asm/kvm_nacl.h>
>>   #include <asm/sbi.h>
>>
>> -DEFINE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
>> -
>> -static void kvm_riscv_setup_vendor_features(void)
>> -{
>> -       /* Andes AX66: split two-stage TLBs */
>> -       if (riscv_cached_mvendorid(0) == ANDES_VENDOR_ID &&
>> -           (riscv_cached_marchid(0) & 0xFFFF) == 0x8A66) {
>> -               static_branch_enable(&kvm_riscv_vsstage_tlb_no_gpa);
>> -               kvm_info("VS-stage TLB does not cache guest physical address and VMID\n");
>> -       }
>> -}
>> -
>>   long kvm_arch_dev_ioctl(struct file *filp,
>>                          unsigned int ioctl, unsigned long arg)
>>   {
>> @@ -172,8 +159,6 @@ static int __init riscv_kvm_init(void)
>>                  kvm_info("AIA available with %d guest external interrupts\n",
>>                           kvm_riscv_aia_nr_hgei);
>>
>> -       kvm_riscv_setup_vendor_features();
>> -
>>          kvm_register_perf_callbacks();
>>
>>          rc = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
>> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
>> index ff1aeac4e..1541d059a 100644
>> --- a/arch/riscv/kvm/tlb.c
>> +++ b/arch/riscv/kvm/tlb.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/errno.h>
>>   #include <linux/err.h>
>>   #include <linux/module.h>
>> +#include <linux/percpu.h>
>>   #include <linux/smp.h>
>>   #include <linux/kvm_host.h>
>>   #include <asm/cacheflush.h>
>> @@ -160,12 +161,19 @@ void kvm_riscv_local_hfence_vvma_all(unsigned long vmid)
>>
>>   void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
>>   {
>> +       bool vcpu_migrated;
>> +       bool vcpu_switched;
>>          unsigned long vmid;
>> +       int *last_ran;
>>
>> -       if (!kvm_riscv_gstage_vmid_bits() ||
>> -           vcpu->arch.last_exit_cpu == vcpu->cpu)
>> +       last_ran = this_cpu_ptr(vcpu->kvm->arch.last_vcpu_ran);
>> +       vcpu_migrated = (vcpu->arch.last_exit_cpu != vcpu->cpu);
>> +       vcpu_switched = (*last_ran != vcpu->vcpu_idx);
>> +       if (!vcpu_migrated && !vcpu_switched)
>>                  return;
>>
>> +       vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
>> +
>>          /*
>>           * On RISC-V platforms with hardware VMID support, we share same
>>           * VMID for all VCPUs of a particular Guest/VM. This means we might
>> @@ -176,16 +184,23 @@ void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
>>           * To cleanup stale TLB entries, we simply flush all G-stage TLB
>>           * entries by VMID whenever underlying Host CPU changes for a VCPU.
>>           */
>> -
>> -       vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
>> -       kvm_riscv_local_hfence_gvma_vmid_all(vmid);
>> +       if (vcpu_migrated && kvm_riscv_gstage_vmid_bits())
>> +               kvm_riscv_local_hfence_gvma_vmid_all(vmid);
>>
>>          /*
>> -        * Flush VS-stage TLB entries for implementation where VS-stage
>> -        * TLB does not cahce guest physical address and VMID.
>> +        * Guest-local sfence.vma only invalidates VS-stage translations on
>> +        * the Host CPU currently backing the VCPU. If a VCPU migrates, or
>> +        * if this Host CPU switches between VCPUs of the same VM, stale
>> +        * VS-stage entries can be left behind on a Host CPU that missed a
>> +        * guest-local flush. Flush the current CPU's VS-stage context before
>> +        * entering the guest.
>>           */
>> -       if (static_branch_unlikely(&kvm_riscv_vsstage_tlb_no_gpa))
>> +       if (kvm_riscv_nacl_available())
>> +               nacl_hfence_vvma_all(nacl_shmem(), vmid);
>> +       else
>>                  kvm_riscv_local_hfence_vvma_all(vmid);
>> +
>> +       *last_ran = vcpu->vcpu_idx;
>>   }
>>
>>   void kvm_riscv_fence_i_process(struct kvm_vcpu *vcpu)
>> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
>> index 13c63ae1a..2907218a1 100644
>> --- a/arch/riscv/kvm/vm.c
>> +++ b/arch/riscv/kvm/vm.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/errno.h>
>>   #include <linux/err.h>
>>   #include <linux/module.h>
>> +#include <linux/percpu.h>
>>   #include <linux/uaccess.h>
>>   #include <linux/kvm_host.h>
>>   #include <asm/kvm_mmu.h>
>> @@ -30,7 +31,9 @@ const struct kvm_stats_header kvm_vm_stats_header = {
>>
>>   int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>   {
>> +       int *last_ran;
>>          int r;
>> +       int cpu;
>>
>>          r = kvm_riscv_mmu_alloc_pgd(kvm);
>>          if (r)
>> @@ -42,6 +45,17 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>                  return r;
>>          }
>>
>> +       kvm->arch.last_vcpu_ran = alloc_percpu(int);
>> +       if (!kvm->arch.last_vcpu_ran) {
>> +               kvm_riscv_mmu_free_pgd(kvm);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               last_ran = per_cpu_ptr(kvm->arch.last_vcpu_ran, cpu);
>> +               *last_ran = -1;
>> +       }
>> +
>>          kvm_riscv_aia_init_vm(kvm);
>>
>>          kvm_riscv_guest_timer_init(kvm);
>> @@ -54,6 +68,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>>          kvm_destroy_vcpus(kvm);
>>
>>          kvm_riscv_aia_destroy_vm(kvm);
>> +
>> +       free_percpu(kvm->arch.last_vcpu_ran);
>>   }
>>
>>   int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,
>> --
>> 2.43.0
>>

