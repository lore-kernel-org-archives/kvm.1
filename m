Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009951;
	b=vPWVeRjOjzFzB1906SZUwozOqPcKAnfI/n2KAxWAXAcDjWJjviMPTFTad5qQUnANWNVx
	 4snEajpCcCHvRVfviwSljNDBdiXOzRzS2q/A5BrVN51tC4+sOVAusRYwKAVaknLZREhvK
	 +57VplwFs8vvgDCMf8BX0rhqGqSGrpVMPeWdxxT6MxR/i/AdfXP2k2t7wnz1EZd8yVMFJ
	 qe1bHnkDVvfIfZE+ctgC13fr8TG9aoNmOGZZsGHPHUxggr9pzAvhtZk/LJqgRtp3SrY0d
	 zggo/e+OrqrXaxelMZLolz/U7DZODvFD+XKNv29azM7wy6TQIE/yXlLTkNdTC6yUOlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009951;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gWMbbaDrS+Z/q+gwFvCBoA1YPyMIW2ku9Du6CHyXUeI=;
	b=P9F2GV4a1lRTsRO8pRSCUK0KmVtxHtnDPn++BPD5cI887lLUG4AvnpjlUpmNNQKudg/E
	 JFdl0K/6HnytX9G16F7CcvH/pxJH518sFdHvzDU7EwZF30a+2EQ3oZTyaAIqQ9bSMhHgk
	 xGtl9JMhD5iwNc0tDTGq5Jfy16+Ov0UAFQVnWnQNWnvYf4wNYXsuV4stsNJa/lCof8V+c
	 6ck3FGosIa+Wy1IHf2wpCT1/d37QAtonW7gYT32PJpayJq5agl2tTIr131JckIj12wb5P
	 HVZcTedmVYqrYba+EB5ktOx3hLqUZ/r5bLs2eP2fkf+yQpHrwvnDKQRiF7wvfh1qZFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=bosc.ac.cn;
	spf=pass smtp.mailfrom=bosc.ac.cn;
	dkim=pass header.d=bosc.ac.cn header.i=@bosc.ac.cn header.a=rsa-sha256 header.s=default header.b=ikSnAHKO;
	arc=none smtp.remote-ip=115.124.28.1
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBDF606A31A;
	Mon, 26 Oct 2026 10:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DBDF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bosc.ac.cn header.i=@bosc.ac.cn header.a=rsa-sha256 header.s=default header.b=ikSnAHKO
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bosc.ac.cn; s=default;
	t=1793009940; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gWMbbaDrS+Z/q+gwFvCBoA1YPyMIW2ku9Du6CHyXUeI=;
	b=ikSnAHKOe8YlKxnigq32VxQ1YMuTdwZPF0dTwON5iwyYcLcXAipdc3jPuw8RimWX7cfiU/mXbxYEQopebdV0/1CprF2zMzv/nEiuHcNTI1IttYPdbDfdBfcPwGQhNNyKHtMosDLUW6bpvEe5eYWoZIlTplJSjbxwQ/Q1xJr+umfM3dZQS7rfruC1eGOjic83ikluo1cVIqVjSEeXX8rebo1m1WVVJflL2QUTZi6i9oX7bR4xFRYseZCVbG8ovXMWmlmycX15fIaV/Cgu17+uXAvQLMmaAZ0TPjG39tql9CKEXapiBjJaxDs2dTqeF2m6G/U316pBa4xTAxbe2AOfTA==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07438087|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0770432-0.0476673-0.875289;FP=3292197540223116792|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=guoyaxing@bosc.ac.cn;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.jpxnHJ3_1793009937;
Received: from 172.28.100.209(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.jpxnHJ3_1793009937 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 18:18:58 +0800
Message-ID: <8dfb9c5b-cc02-4340-8f6c-61265f711d5a@bosc.ac.cn>
Date: Mon, 26 Oct 2026 18:18:57 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: KVM: Flush VS-stage TLB before reusing a host CPU
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, majiuyue@bosc.ac.cn, anzoso@outlook.com,
 xiangwencheng@lanxincomputing.com
References: <20260817102447.40259-1-guoyaxing@bosc.ac.cn>
 <CAAhSdy2qwdHE7SB2gRK3_PQ6m_bMSfWpvcuSG-31W2yd3-UTKg@mail.gmail.com>
 <285419e5-c4fc-4c75-a765-436165bdc8b9@bosc.ac.cn>
 <CAAhSdy1Q7a+54qn0xNBQBd1eV2ve+Nzqz9uRsWrGSmTn35z8=A@mail.gmail.com>
 <c050c85c-482a-4351-b627-ac074f7f7952@bosc.ac.cn>
 <CAAhSdy3XDEGfFJJnHfx2Q0w+dG4FombF3Lj5O_V4wBpkyAYTNg@mail.gmail.com>
From: guoyaxing <guoyaxing@bosc.ac.cn>
In-Reply-To: <CAAhSdy3XDEGfFJJnHfx2Q0w+dG4FombF3Lj5O_V4wBpkyAYTNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/24 23:49, Anup Patel 写道:
> On Sat, Oct 10, 2026 at 2:36 PM guoyaxing <guoyaxing@bosc.ac.cn> wrote:
>>
>>
>>
>> 在 2026/10/10 15:50, Anup Patel 写道:
>>> On Sat, Oct 10, 2026 at 4:12 AM guoyaxing <guoyaxing@bosc.ac.cn> wrote:
>>>>
>>>>
>>>>
>>>> 在 2026/10/10 02:51, Anup Patel 写道:
>>>>> On Mon, Aug 17, 2026 at 12:25 PM Yaxing Guo <guoyaxing@bosc.ac.cn> wrote:
>>>>>>
>>>>>> Guest Linux uses mm_cpumask to decide whether an sfence.vma needs to be
>>>>>> local or remote. Under KVM that mask tracks guest CPUs, not the host CPUs
>>>>>> that previously backed a vCPU.
>>>>>>
>>>>>> This can miss stale VS-stage TLB entries when a vCPU migrates across host
>>>>>> CPUs. For example:
>>>>>>
>>>>>>      - vcpu0 runs on host CPU1 and fills a VS-stage TLB entry.
>>>>>>      - vcpu0 migrates to host CPU0.
>>>>>>      - the guest updates the mapping on vcpu0 and issues a local sfence.vma.
>>>>>>      - later, the guest task runs on vcpu1 while vcpu1 is backed by host CPU1.
>>>>>
>>>>> When the vcpu0 is brought back to host CPU1, the kvm_riscv_local_tlb_sanitize()
>>>>> will ensure TLB entries associated with Guest/VM are nuked.
>>>>>
>>>>> By default, kvm_riscv_local_hfence_gvma_vmid_all() will only do HFENCE.GVMA
>>>>> for the associated VMID because most RISC-V H-extension implemenation will
>>>>> tag VS-stage TLB entries with VMID and HFENCE.GVMA must remove both
>>>>> G-stage and VS-stage TLB entries for given VMID.
>>>>>
>>>>> If your HW does not tag VS-stage TLB enteries with VMID then it buggy
>>>>> / inefficient
>>>>> so you have to set kvm_riscv_vsstage_tlb_no_gpa in
>>>>> kvm_riscv_setup_vendor_features()
>>>>> as work-around.
>>>>>
>>>>> NACK to this patch from myside.
>>>>>
>>>>> Regards,
>>>>> Anup
>>>>>
>>>> Hi Anup,
>>>>      Thanks for the review and clarification.
>>>>
>>>>      Regarding “When the vcpu0 is brought back to host CPU1”: the failure
>>>> we hit is not caused by vcpu0 being brought back onto host CPU1. In our
>>>> case, after vcpu0 has already migrated away, neither vCPU migrates
>>>> again. The guest process is later scheduled inside the multi-vCPU guest
>>>> onto vcpu1, which is still running on host CPU1. So the stale TLB is
>>>> re-hit without any further KVM vCPU migration, and
>>>> kvm_riscv_local_tlb_sanitize() is not involved on that path.
>>>>
>>>>      My commit message was a bit too terse on this point. The concrete
>>>> sequence we observed was described earlier in the RFC discussion:
>>>>
>>>>
>>>> https://lore.kernel.org/kvm/0d15b098-b8f7-4080-9f33-e8c49c2331e1@bosc.ac.cn/
>>>>
>>>>      In short, the issue is: because vcpu0 migrated away, cpu1 still has
>>>> stale TLB entries while cpu0 has the new mapping. After that, neither
>>>> vcpu migrated again, but the process was scheduled from vcpu0 to vcpu1
>>>> (which is on cpu1), causing it to hit the stale TLB. Consider the
>>>> following scenario:
>>>>
>>>>      1. vcpu0 and vcpu1 are both running on cpu1. At this point, vcpu0 is
>>>> on cpu1, and a process on it reads a page, which gets cached in the TLB
>>>> (let's call this the "stale TLB entry").
>>>>
>>>>      2. vcpu0 migrates to cpu0, and then the process (on vcpu0, now on
>>>> cpu0) does a CoW (copy-on-write) and establishes a new mapping.
>>>>
>>>>      3. Neither vcpu0 nor vcpu1 migrates again. At this point, the process
>>>> gets scheduled inside the VM onto vcpu1 (which is on cpu1), reads the
>>>> same page, and hits the stale TLB entry.
>>>
>>> This cannot happen because in step#2 when mapping was updated the
>>> Guest OS will do TLB flush for all its VCPUs which means vcpu1 on cpu0
>>> will also receive TLB flush and the stale TLB will be removed. This means
>>> when process is moved back to vcpu1 on cpu0, HW will fetch updated
>>> PTE and new TLB entry will be populated.
>>>
>>
>> Hi Anup,
>>
>> Thanks for the follow-up. I may be missing something, so I wanted to
>> double-check this against the guest TLB shootdown path.
>>
>> If I follow the Linux guest CoW path correctly, when the mapping is
>> updated in step#2 it goes through:
>>
>>     wp_page_copy()
>>       -> ptep_clear_flush()
>>         -> flush_tlb_page()
>>           -> __flush_tlb_range(mm, mm_cpumask(mm), ...)
>>
>> So the remote SFENCE.VMA appears to be targeted only at CPUs in
>> mm_cpumask(mm), rather than at all VCPUs of the guest. mm_cpumask is
>> updated in switch_mm()/set_mm() for guest CPUs that have actually run
>> that mm.
>>
>> In our case, before the CoW the process had only ever run on vcpu0. From
>> the guest's point of view it did not migrate: the host migration of
>> vcpu0 from cpu1 to cpu0 is not visible to guest Linux, which only sees
>> vCPUs. So at CoW time mm_cpumask still contains only vcpu0 (or at least
>> does not contain vcpu1), and __flush_tlb_range() would not IPI vcpu1.
>> The local SFENCE on vcpu0 would only cover host cpu0, where vcpu0 is
>> currently running. The stale VS-stage TLB entry left on host cpu1 from
>> when vcpu0 previously ran there would then remain.
>>
>> Later, still without any further vCPU migration, the process is
>> scheduled inside the guest onto vcpu1, which remains on host cpu1, and
>> can hit that stale entry.
>>
>> This also seems more likely when the ASID allocator is enabled, because
>> set_mm_asid() does not always local_flush_tlb_all() on switch_mm(). So
>> even the first time the process lands on vcpu1, a stale ASID-tagged
>> entry on host cpu1 may still be present.
>>
>> In other words, I am not sure this case is covered by a full guest TLB
>> flush to all VCPUs on the mapping update. Guest shootdown looks
>> mm_cpumask-based, and host pCPU migration of a vCPU does not by itself
>> add other vCPUs that never ran the mm into that mask.
> 
> This makes sense now considering ASID allocator in Guest Linux is global
> and not local. In any case, KVM RISC-V must not assume that the Guest OS
> has local ASID allocator hence the kvm_riscv_local_tlb_sanitize() must also
> santize TLB for other VCPUs of the same Guest which can potentially run
> on the previous host CPU where current VCPU ran.
> 
> Having said the above, there are multiple issues with the current patch:
> 1) The kvm_riscv_local_hfence_gvma_vmid_all() is sufficient for most
> implementations to sanitize both G-stage and VS-stage TLB entries
> because both G-stage and VS-stage TLB entries are generally tagged
> with VMID. The kvm_riscv_vsstage_tlb_no_gpa work-around is for
> implmentations which do not tag VS-stage TLB entries with VMID
> and this patch remove this work-around.
> 2) The other VCPUs on the previous host CPU may be already running
> and may still hit stale TLB entry before kvm_riscv_local_tlb_sanitize()
> gets a chance to sanitize TLB on previous host CPU.
> 3) The per-CPU pointer in struct kvm_arch is racy because we
> may have two VCPUs on same host CPU which are migrated to
> other host CPUs. Instead, it is much simpler to have an atomic
> cpumask in each VCPU where any part of KVM can mark a host
> CPU in the cpumask of the VCPU to force TLB sanitization whenever
> the VCPU runs on that particular host CPU.
> 
> How about the following change ?
> 
> diff --git a/arch/riscv/include/asm/kvm_host.h
> b/arch/riscv/include/asm/kvm_host.h
> index a30600579231..c975eee7240c 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -9,6 +9,7 @@
>   #ifndef __RISCV_KVM_HOST_H__
>   #define __RISCV_KVM_HOST_H__
> 
> +#include <linux/cpumask.h>
>   #include <linux/types.h>
>   #include <linux/kvm.h>
>   #include <linux/kvm_types.h>
> @@ -184,6 +185,9 @@ struct kvm_vcpu_arch {
>       /* ISA feature bits (similar to MISA) */
>       DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
> 
> +    /* Sanitize TLB host CPU mask */
> +    cpumask_t tlb_sanitize_mask;
> +
>       /* Vendor, Arch, and Implementation details */
>       unsigned long mvendorid;
>       unsigned long marchid;
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index 2ae34632cdcb..b1387a00c8b0 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -207,11 +207,31 @@ void kvm_riscv_local_hfence_vvma_all(unsigned long vmid)
> 
>   void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
>   {
> -    unsigned long vmid;
> +    struct kvm_vcpu *tvcpu;
> +    unsigned long i, vmid;
> 
> -    if (!kvm_riscv_gstage_vmid_bits() ||
> -        vcpu->arch.last_exit_cpu == vcpu->cpu)
> -        return;
> +    if (!cpumask_test_cpu(vcpu->cpu, &vcpu->arch.tlb_sanitize_mask)) {
> +        if (!kvm_riscv_gstage_vmid_bits() ||
> +            vcpu->arch.last_exit_cpu == vcpu->cpu)
> +            return;
> +    }
> +
> +    /*
> +     * The VCPU might have left stale TLBs on the previous host CPU so
> +     * mark previous host CPU in the tlb_sanitize_mask of other VCPUs.
> +     */
> +    if (vcpu->arch.last_exit_cpu > -1 && vcpu->arch.last_exit_cpu !=
> vcpu->cpu) {
> +        kvm_for_each_vcpu(i, tvcpu, vcpu->kvm) {
> +            if (tvcpu == vcpu)
> +                continue;
> +            cpumask_set_cpu(vcpu->arch.last_exit_cpu,
> +                    &tvcpu->arch.tlb_sanitize_mask);
> +            kvm_vcpu_kick(tvcpu);
> +        }
> +    }
> +
> +    /* Clear current host CPU from the tlb_sanitize_mask */
> +    cpumask_clear_cpu(vcpu->cpu, &vcpu->arch.tlb_sanitize_mask);
> 
>       /*
>        * On RISC-V platforms with hardware VMID support, we share same
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index dd786f758eb7..c00dc0b191dc 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -107,6 +107,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu
> *vcpu, bool kvm_sbi_reset)
> 
>       vcpu->arch.last_exit_cpu = -1;
> 
> +    cpumask_clear(&vcpu->arch.tlb_sanitize_mask);
> +
>       kvm_riscv_vcpu_context_reset(vcpu, kvm_sbi_reset);
> 
>       kvm_riscv_vcpu_fp_reset(vcpu);
> 
> Regards,
> Anup

Hi Anup,

Thanks for the explanation and for suggesting the per-vCPU sanitization
mask. Building on your proposal, I would like to suggest two changes:

1. Separate the invalidation strategy for vCPU migration and a mask hit.

    Keep HFENCE.GVMA for vCPU migration, identified by
    last_exit_cpu != vcpu->cpu, when hardware VMIDs are available. Use
    HFENCE.VVMA when the current host CPU is marked in tlb_sanitize_mask.
    A mask hit caused by another vCPU of the same VM running on this CPU
    requires VS-stage sanitization; it does not by itself require G-stage
    invalidation.

    For example, if vCPU0 and vCPU1 both last ran on CPU0, switching from
    vCPU1 back to vCPU0 only needs the mask-triggered VVMA. This avoids
    requesting G-stage invalidation when the shared G-stage mappings have
    not changed. If both migration and a mask hit occur, both fences run.

2. Move mask updates to kvm_arch_vcpu_put().

    Mark the outgoing host CPU in the masks of the other vCPUs of the
    same VM when a vCPU is put. This also covers a switch between vCPUs
    on one host CPU without either vCPU migrating. Marking only when
    migration is detected in kvm_riscv_local_tlb_sanitize() would miss
    that case.

    The marking now happens on the outgoing CPU before another vCPU can
    enter guest mode there. The migration-time marking and kicks are
    therefore removed. The trade-off is an O(nr_vcpus) walk on each
    qualifying put().

    How about the following change ?

diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 2ac3c0a20fce..ae8a40b3429c 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -160,32 +160,15 @@

  void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
  {
-	struct kvm_vcpu *tvcpu;
-	unsigned long i, vmid;
-
-	if (!cpumask_test_cpu(vcpu->cpu, &vcpu->arch.tlb_sanitize_mask)) {
-		if (!kvm_riscv_gstage_vmid_bits() ||
-		    vcpu->arch.last_exit_cpu == vcpu->cpu)
-			return;
-	}
-
-	/*
-	 * The VCPU might have left stale TLBs on the previous host CPU so
-	 * mark previous host CPU in the tlb_sanitize_mask of other VCPUs.
-	 */
-	if (vcpu->arch.last_exit_cpu > -1 &&
-	    vcpu->arch.last_exit_cpu != vcpu->cpu) {
-		kvm_for_each_vcpu(i, tvcpu, vcpu->kvm) {
-			if (tvcpu == vcpu)
-				continue;
-			cpumask_set_cpu(vcpu->arch.last_exit_cpu,
-					&tvcpu->arch.tlb_sanitize_mask);
-			kvm_vcpu_kick(tvcpu);
-		}
-	}
-
-	/* Clear current host CPU from the tlb_sanitize_mask */
-	cpumask_clear_cpu(vcpu->cpu, &vcpu->arch.tlb_sanitize_mask);
+	unsigned long vmid;
+	bool vcpu_migrated, sanitize_vsstage;
+
+	vcpu_migrated = vcpu->arch.last_exit_cpu != vcpu->cpu;
+	sanitize_vsstage = cpumask_test_and_clear_cpu(vcpu->cpu,
+						&vcpu->arch.tlb_sanitize_mask);
+	if (!sanitize_vsstage &&
+	    (!kvm_riscv_gstage_vmid_bits() || !vcpu_migrated))
+		return;

  	/*
  	 * On RISC-V platforms with hardware VMID support, we share same
@@ -199,13 +182,16 @@
  	 */

  	vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
-	kvm_riscv_local_hfence_gvma_vmid_all(vmid);
+	if (vcpu_migrated && kvm_riscv_gstage_vmid_bits())
+		kvm_riscv_local_hfence_gvma_vmid_all(vmid);

  	/*
-	 * Flush VS-stage TLB entries for implementation where VS-stage
-	 * TLB does not cahce guest physical address and VMID.
+	 * Flush VS-stage entries marked when another VCPU left this CPU, or when
+	 * required by the split-TLB vendor workaround on this VCPU's migration.
  	 */
-	if (static_branch_unlikely(&kvm_riscv_vsstage_tlb_no_gpa))
+	    if (sanitize_vsstage ||
+	        (vcpu_migrated &&
+	        static_branch_unlikely(&kvm_riscv_vsstage_tlb_no_gpa)))
  		    kvm_riscv_local_hfence_vvma_all(vmid);
  }

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index f2e52f3b0786..6209c66b24e1 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -644,8 +644,18 @@

  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
  {
+	struct kvm_vcpu *tvcpu;
+	unsigned long i;
+	int cpu = vcpu->cpu;
  	void *nsh;
  	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
+
+	if (cpu >= 0 && vcpu->arch.last_exit_cpu == cpu) {
+		kvm_for_each_vcpu(i, tvcpu, vcpu->kvm) {
+			if (tvcpu != vcpu)
+				cpumask_set_cpu(cpu, &tvcpu->arch.tlb_sanitize_mask);
+		}
+	}

  	vcpu->cpu = -1;

    Would these changes make sense to you, or is there anythingI might 
be overlooking?


Regards,
Yaxing

