Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566CD393DDC;
	Sat, 10 Oct 2026 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623187; cv=none; b=QzGIpZEzVVTsKyZBL8RAg1tEpSXLTiBOyZkjm0QesI3fFP39XfwqNjUH/vBccQS/kvtFuGNbUYHseS908WfO8f4YR/k93hYDdnv+aVnWOkLthjN+iKgdEGosj5TMn+hZr1vfPyWY5nV5FhN3zlpNpmJ055cmNFCwy44a9CQcvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623187; c=relaxed/simple;
	bh=UndC/vaosX6fHPd2Scd8755MUHDd4YPnUJLCeXlgqDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBnrfZ1/6uhWy7YCDevxtRoEJQs+BK1rWT9zi9hGjFOESGtXoCJawjnE/x0crvePxrxKaq8XlD6eQ9x+Mw5zM+X/bqXnC7+ClMdmHC1PcVMQqk/TjXU61ORe4AKOed0LG0QuP3O8a/NO0EnofHoOY67/LPUJ8MeJOCRhSqMOyYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; dkim=pass (2048-bit key) header.d=bosc.ac.cn header.i=@bosc.ac.cn header.b=We2aQj3/; arc=none smtp.client-ip=115.124.28.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bosc.ac.cn header.i=@bosc.ac.cn header.b="We2aQj3/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bosc.ac.cn; s=default;
	t=1791623171; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wxxXMTczOSthhfI8IdjPXyfAQmCz410GEUXaf/zEEuk=;
	b=We2aQj3/7Xj/PwFedtP0SvY2qVRhX92t6mt7whGtn1bL8qcZIzpJpwm/AiB8HkHGJfs4mda0iG7rYjwyzTZXqiDhlIfNRf0MB3yvQ4J2EeJQGTX6BPG2GLKahnxnPZ5gok7sn1JcPUyx7rlRhjnfE9DFi2euspJiAYxWDrwGJAFOgMT8t7NwgYcdq3N9j1miWCs8F0k8Nn9kxoNSwtE1+yTk5WNj8nN5PqS3OeI2TNXjc7np0ezhtUUW5AlD5sZ7rrsGRF5hAidsxBVHiuA81qsefORzuqtvnPS7uW7DLAyAY37RFniJ08ODsgxLZfjZhHhqZPGWxe9WjFu96ouKbA==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436261|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0104415-4.7053e-05-0.989511;FP=3889345505002079714|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=guoyaxing@bosc.ac.cn;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.jYNGZgs_1791623169;
Received: from 172.28.100.209(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.jYNGZgs_1791623169 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 10 Oct 2026 17:06:10 +0800
Message-ID: <c050c85c-482a-4351-b627-ac074f7f7952@bosc.ac.cn>
Date: Sat, 10 Oct 2026 17:06:09 +0800
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
 <285419e5-c4fc-4c75-a765-436165bdc8b9@bosc.ac.cn>
 <CAAhSdy1Q7a+54qn0xNBQBd1eV2ve+Nzqz9uRsWrGSmTn35z8=A@mail.gmail.com>
From: guoyaxing <guoyaxing@bosc.ac.cn>
In-Reply-To: <CAAhSdy1Q7a+54qn0xNBQBd1eV2ve+Nzqz9uRsWrGSmTn35z8=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/10 15:50, Anup Patel 写道:
> On Sat, Oct 10, 2026 at 4:12 AM guoyaxing <guoyaxing@bosc.ac.cn> wrote:
>>
>>
>>
>> 在 2026/10/10 02:51, Anup Patel 写道:
>>> On Mon, Aug 17, 2026 at 12:25 PM Yaxing Guo <guoyaxing@bosc.ac.cn> wrote:
>>>>
>>>> Guest Linux uses mm_cpumask to decide whether an sfence.vma needs to be
>>>> local or remote. Under KVM that mask tracks guest CPUs, not the host CPUs
>>>> that previously backed a vCPU.
>>>>
>>>> This can miss stale VS-stage TLB entries when a vCPU migrates across host
>>>> CPUs. For example:
>>>>
>>>>     - vcpu0 runs on host CPU1 and fills a VS-stage TLB entry.
>>>>     - vcpu0 migrates to host CPU0.
>>>>     - the guest updates the mapping on vcpu0 and issues a local sfence.vma.
>>>>     - later, the guest task runs on vcpu1 while vcpu1 is backed by host CPU1.
>>>
>>> When the vcpu0 is brought back to host CPU1, the kvm_riscv_local_tlb_sanitize()
>>> will ensure TLB entries associated with Guest/VM are nuked.
>>>
>>> By default, kvm_riscv_local_hfence_gvma_vmid_all() will only do HFENCE.GVMA
>>> for the associated VMID because most RISC-V H-extension implemenation will
>>> tag VS-stage TLB entries with VMID and HFENCE.GVMA must remove both
>>> G-stage and VS-stage TLB entries for given VMID.
>>>
>>> If your HW does not tag VS-stage TLB enteries with VMID then it buggy
>>> / inefficient
>>> so you have to set kvm_riscv_vsstage_tlb_no_gpa in
>>> kvm_riscv_setup_vendor_features()
>>> as work-around.
>>>
>>> NACK to this patch from myside.
>>>
>>> Regards,
>>> Anup
>>>
>> Hi Anup,
>>     Thanks for the review and clarification.
>>
>>     Regarding “When the vcpu0 is brought back to host CPU1”: the failure
>> we hit is not caused by vcpu0 being brought back onto host CPU1. In our
>> case, after vcpu0 has already migrated away, neither vCPU migrates
>> again. The guest process is later scheduled inside the multi-vCPU guest
>> onto vcpu1, which is still running on host CPU1. So the stale TLB is
>> re-hit without any further KVM vCPU migration, and
>> kvm_riscv_local_tlb_sanitize() is not involved on that path.
>>
>>     My commit message was a bit too terse on this point. The concrete
>> sequence we observed was described earlier in the RFC discussion:
>>
>>
>> https://lore.kernel.org/kvm/0d15b098-b8f7-4080-9f33-e8c49c2331e1@bosc.ac.cn/
>>
>>     In short, the issue is: because vcpu0 migrated away, cpu1 still has
>> stale TLB entries while cpu0 has the new mapping. After that, neither
>> vcpu migrated again, but the process was scheduled from vcpu0 to vcpu1
>> (which is on cpu1), causing it to hit the stale TLB. Consider the
>> following scenario:
>>
>>     1. vcpu0 and vcpu1 are both running on cpu1. At this point, vcpu0 is
>> on cpu1, and a process on it reads a page, which gets cached in the TLB
>> (let's call this the "stale TLB entry").
>>
>>     2. vcpu0 migrates to cpu0, and then the process (on vcpu0, now on
>> cpu0) does a CoW (copy-on-write) and establishes a new mapping.
>>
>>     3. Neither vcpu0 nor vcpu1 migrates again. At this point, the process
>> gets scheduled inside the VM onto vcpu1 (which is on cpu1), reads the
>> same page, and hits the stale TLB entry.
> 
> This cannot happen because in step#2 when mapping was updated the
> Guest OS will do TLB flush for all its VCPUs which means vcpu1 on cpu0
> will also receive TLB flush and the stale TLB will be removed. This means
> when process is moved back to vcpu1 on cpu0, HW will fetch updated
> PTE and new TLB entry will be populated.
> 

Hi Anup,

Thanks for the follow-up. I may be missing something, so I wanted to 
double-check this against the guest TLB shootdown path.

If I follow the Linux guest CoW path correctly, when the mapping is 
updated in step#2 it goes through:

   wp_page_copy()
     -> ptep_clear_flush()
       -> flush_tlb_page()
         -> __flush_tlb_range(mm, mm_cpumask(mm), ...)

So the remote SFENCE.VMA appears to be targeted only at CPUs in 
mm_cpumask(mm), rather than at all VCPUs of the guest. mm_cpumask is 
updated in switch_mm()/set_mm() for guest CPUs that have actually run 
that mm.

In our case, before the CoW the process had only ever run on vcpu0. From 
the guest's point of view it did not migrate: the host migration of 
vcpu0 from cpu1 to cpu0 is not visible to guest Linux, which only sees 
vCPUs. So at CoW time mm_cpumask still contains only vcpu0 (or at least 
does not contain vcpu1), and __flush_tlb_range() would not IPI vcpu1. 
The local SFENCE on vcpu0 would only cover host cpu0, where vcpu0 is 
currently running. The stale VS-stage TLB entry left on host cpu1 from 
when vcpu0 previously ran there would then remain.

Later, still without any further vCPU migration, the process is 
scheduled inside the guest onto vcpu1, which remains on host cpu1, and 
can hit that stale entry.

This also seems more likely when the ASID allocator is enabled, because
set_mm_asid() does not always local_flush_tlb_all() on switch_mm(). So 
even the first time the process lands on vcpu1, a stale ASID-tagged 
entry on host cpu1 may still be present.

In other words, I am not sure this case is covered by a full guest TLB 
flush to all VCPUs on the mapping update. Guest shootdown looks 
mm_cpumask-based, and host pCPU migration of a vCPU does not by itself 
add other vCPUs that never ran the mm into that mask.

The earlier RFC note has a bit more detail on the flow we observed:
https://lore.kernel.org/kvm/0d15b098-b8f7-4080-9f33-e8c49c2331e1@bosc.ac.cn/

Please let me know if I misunderstood the intended invalidation path here.

Thanks,
Yaxing

>>
>>     So this is an intra-guest scheduling case onto a vCPU that stayed on
>> the original host CPU, rather than a “vcpu0 returns to host CPU1” case.
> 
> My NACK still holds.
> 
> Regards,
> Anup
> 
>>
>>     Thanks,
>>     Yaxing
>>
>>>>
>>>> Host CPU1 did not observe the guest-local sfence.vma, and KVM can enter
>>>> vcpu1 with a stale VS-stage translation left behind by vcpu0.
>>>>
>>>> The reported failure was seen on a XiangShan RISC-V system. A bash task
>>>> ran on vcpu0 while vcpu0 was backed by host CPU1, and a read-only page was
>>>> prefetched into CPU1's VS-stage TLB. vcpu0 later migrated to host CPU0,
>>>> where the guest triggered COW, updated the mapping, and issued only a local
>>>> sfence.vma. The stale VS-stage entry on CPU1 survived. When the same guest
>>>> task later ran on another vCPU backed by host CPU1, it hit the stale
>>>> translation. The page contained a GOT pointer, and using the stale data led
>>>> to a NULL dereference and a userspace segmentation fault.
>>>>
>>>> The existing local TLB sanitize path flushes G-stage entries when a vCPU
>>>> migrates, and flushes VS-stage entries only for implementations selected by
>>>> the Andes-specific kvm_riscv_vsstage_tlb_no_gpa static key. That handles a
>>>> split two-stage TLB implementation where HFENCE.GVMA does not invalidate
>>>> VS-stage entries, but it does not cover the generic guest-local sfence.vma
>>>> case above.
>>>>
>>>> Track, per VM and per host CPU, the last vCPU that entered the guest on
>>>> that CPU. Before guest entry, flush the current CPU's VS-stage context for
>>>> the VM if either the current vCPU migrated since its last exit, or this
>>>> host CPU is switching from another vCPU of the same VM. Keep the existing
>>>> HFENCE.GVMA behavior tied to vCPU migration.
>>>>
>>>> This also subsumes the Andes split-TLB workaround. That workaround was
>>>> needed because the migration sanitize path previously relied on
>>>> HFENCE.GVMA alone for most implementations, and only issued HFENCE.VVMA
>>>> when kvm_riscv_vsstage_tlb_no_gpa was set. The new sanitize path always
>>>> issues HFENCE.VVMA when reusing a host CPU for a VM context that may have
>>>> missed a guest-local sfence.vma, so it no longer depends on HFENCE.GVMA
>>>> invalidating VS-stage entries. The implementation-specific static key and
>>>> setup hook are therefore no longer needed.
>>>>
>>>> Reported-by: Zhizun Wang <anzoso@outlook.com>
>>>> Reviewed-by: Jiuyue Ma <majiuyue@bosc.ac.cn>
>>>> Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
>>>> ---
>>>>    arch/riscv/include/asm/kvm_host.h |  6 +++---
>>>>    arch/riscv/kvm/main.c             | 15 ---------------
>>>>    arch/riscv/kvm/tlb.c              | 31 +++++++++++++++++++++++--------
>>>>    arch/riscv/kvm/vm.c               | 16 ++++++++++++++++
>>>>    4 files changed, 42 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
>>>> index 24585304c..396ac6209 100644
>>>> --- a/arch/riscv/include/asm/kvm_host.h
>>>> +++ b/arch/riscv/include/asm/kvm_host.h
>>>> @@ -91,6 +91,9 @@ struct kvm_arch {
>>>>           /* G-stage vmid */
>>>>           struct kvm_vmid vmid;
>>>>
>>>> +       /* Last VCPU that ran on each physical CPU */
>>>> +       int __percpu *last_vcpu_ran;
>>>> +
>>>>           /* G-stage page table */
>>>>           pgd_t *pgd;
>>>>           phys_addr_t pgd_phys;
>>>> @@ -330,7 +333,4 @@ bool kvm_riscv_vcpu_stopped(struct kvm_vcpu *vcpu);
>>>>
>>>>    void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
>>>>
>>>> -/* Flags representing implementation specific details */
>>>> -DECLARE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
>>>> -
>>>>    #endif /* __RISCV_KVM_HOST_H__ */
>>>> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
>>>> index 0f3fe3986..b1bbc0835 100644
>>>> --- a/arch/riscv/kvm/main.c
>>>> +++ b/arch/riscv/kvm/main.c
>>>> @@ -10,23 +10,10 @@
>>>>    #include <linux/err.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/kvm_host.h>
>>>> -#include <asm/cpufeature.h>
>>>>    #include <asm/kvm_mmu.h>
>>>>    #include <asm/kvm_nacl.h>
>>>>    #include <asm/sbi.h>
>>>>
>>>> -DEFINE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
>>>> -
>>>> -static void kvm_riscv_setup_vendor_features(void)
>>>> -{
>>>> -       /* Andes AX66: split two-stage TLBs */
>>>> -       if (riscv_cached_mvendorid(0) == ANDES_VENDOR_ID &&
>>>> -           (riscv_cached_marchid(0) & 0xFFFF) == 0x8A66) {
>>>> -               static_branch_enable(&kvm_riscv_vsstage_tlb_no_gpa);
>>>> -               kvm_info("VS-stage TLB does not cache guest physical address and VMID\n");
>>>> -       }
>>>> -}
>>>> -
>>>>    long kvm_arch_dev_ioctl(struct file *filp,
>>>>                           unsigned int ioctl, unsigned long arg)
>>>>    {
>>>> @@ -172,8 +159,6 @@ static int __init riscv_kvm_init(void)
>>>>                   kvm_info("AIA available with %d guest external interrupts\n",
>>>>                            kvm_riscv_aia_nr_hgei);
>>>>
>>>> -       kvm_riscv_setup_vendor_features();
>>>> -
>>>>           kvm_register_perf_callbacks();
>>>>
>>>>           rc = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
>>>> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
>>>> index ff1aeac4e..1541d059a 100644
>>>> --- a/arch/riscv/kvm/tlb.c
>>>> +++ b/arch/riscv/kvm/tlb.c
>>>> @@ -8,6 +8,7 @@
>>>>    #include <linux/errno.h>
>>>>    #include <linux/err.h>
>>>>    #include <linux/module.h>
>>>> +#include <linux/percpu.h>
>>>>    #include <linux/smp.h>
>>>>    #include <linux/kvm_host.h>
>>>>    #include <asm/cacheflush.h>
>>>> @@ -160,12 +161,19 @@ void kvm_riscv_local_hfence_vvma_all(unsigned long vmid)
>>>>
>>>>    void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
>>>>    {
>>>> +       bool vcpu_migrated;
>>>> +       bool vcpu_switched;
>>>>           unsigned long vmid;
>>>> +       int *last_ran;
>>>>
>>>> -       if (!kvm_riscv_gstage_vmid_bits() ||
>>>> -           vcpu->arch.last_exit_cpu == vcpu->cpu)
>>>> +       last_ran = this_cpu_ptr(vcpu->kvm->arch.last_vcpu_ran);
>>>> +       vcpu_migrated = (vcpu->arch.last_exit_cpu != vcpu->cpu);
>>>> +       vcpu_switched = (*last_ran != vcpu->vcpu_idx);
>>>> +       if (!vcpu_migrated && !vcpu_switched)
>>>>                   return;
>>>>
>>>> +       vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
>>>> +
>>>>           /*
>>>>            * On RISC-V platforms with hardware VMID support, we share same
>>>>            * VMID for all VCPUs of a particular Guest/VM. This means we might
>>>> @@ -176,16 +184,23 @@ void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
>>>>            * To cleanup stale TLB entries, we simply flush all G-stage TLB
>>>>            * entries by VMID whenever underlying Host CPU changes for a VCPU.
>>>>            */
>>>> -
>>>> -       vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
>>>> -       kvm_riscv_local_hfence_gvma_vmid_all(vmid);
>>>> +       if (vcpu_migrated && kvm_riscv_gstage_vmid_bits())
>>>> +               kvm_riscv_local_hfence_gvma_vmid_all(vmid);
>>>>
>>>>           /*
>>>> -        * Flush VS-stage TLB entries for implementation where VS-stage
>>>> -        * TLB does not cahce guest physical address and VMID.
>>>> +        * Guest-local sfence.vma only invalidates VS-stage translations on
>>>> +        * the Host CPU currently backing the VCPU. If a VCPU migrates, or
>>>> +        * if this Host CPU switches between VCPUs of the same VM, stale
>>>> +        * VS-stage entries can be left behind on a Host CPU that missed a
>>>> +        * guest-local flush. Flush the current CPU's VS-stage context before
>>>> +        * entering the guest.
>>>>            */
>>>> -       if (static_branch_unlikely(&kvm_riscv_vsstage_tlb_no_gpa))
>>>> +       if (kvm_riscv_nacl_available())
>>>> +               nacl_hfence_vvma_all(nacl_shmem(), vmid);
>>>> +       else
>>>>                   kvm_riscv_local_hfence_vvma_all(vmid);
>>>> +
>>>> +       *last_ran = vcpu->vcpu_idx;
>>>>    }
>>>>
>>>>    void kvm_riscv_fence_i_process(struct kvm_vcpu *vcpu)
>>>> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
>>>> index 13c63ae1a..2907218a1 100644
>>>> --- a/arch/riscv/kvm/vm.c
>>>> +++ b/arch/riscv/kvm/vm.c
>>>> @@ -9,6 +9,7 @@
>>>>    #include <linux/errno.h>
>>>>    #include <linux/err.h>
>>>>    #include <linux/module.h>
>>>> +#include <linux/percpu.h>
>>>>    #include <linux/uaccess.h>
>>>>    #include <linux/kvm_host.h>
>>>>    #include <asm/kvm_mmu.h>
>>>> @@ -30,7 +31,9 @@ const struct kvm_stats_header kvm_vm_stats_header = {
>>>>
>>>>    int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>>>    {
>>>> +       int *last_ran;
>>>>           int r;
>>>> +       int cpu;
>>>>
>>>>           r = kvm_riscv_mmu_alloc_pgd(kvm);
>>>>           if (r)
>>>> @@ -42,6 +45,17 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>>>                   return r;
>>>>           }
>>>>
>>>> +       kvm->arch.last_vcpu_ran = alloc_percpu(int);
>>>> +       if (!kvm->arch.last_vcpu_ran) {
>>>> +               kvm_riscv_mmu_free_pgd(kvm);
>>>> +               return -ENOMEM;
>>>> +       }
>>>> +
>>>> +       for_each_possible_cpu(cpu) {
>>>> +               last_ran = per_cpu_ptr(kvm->arch.last_vcpu_ran, cpu);
>>>> +               *last_ran = -1;
>>>> +       }
>>>> +
>>>>           kvm_riscv_aia_init_vm(kvm);
>>>>
>>>>           kvm_riscv_guest_timer_init(kvm);
>>>> @@ -54,6 +68,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>>>>           kvm_destroy_vcpus(kvm);
>>>>
>>>>           kvm_riscv_aia_destroy_vm(kvm);
>>>> +
>>>> +       free_percpu(kvm->arch.last_vcpu_ran);
>>>>    }
>>>>
>>>>    int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,
>>>> --
>>>> 2.43.0
>>>>
>>

