Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246741;
	b=3zzEn7SumWiuJFE6LNdt8Ln/2p6MzZsoQo1odwgJ483nRWrdDeF5RTJ469GW/K7EP2EA
	 8L6LnPBYo2xmx5QBxVV9rNpA5SUCsNstT3adH30R1CrvG4+7lI8O6jtj2wQgkA2OMlexC
	 memx1DX5WeTo8eu8L9rrHR59T/fZ9kK+C/sFyKifmAmBM+/FwUMLO+PaAFQ4e7rl4oHhC
	 qwsIIeNQw9hsILUg9kibICO5KbVIvG72Nux9aUb+wOva/LY/zs6sEAzQisR6b2nFlxN2Y
	 mnSK3YLAzNyVo2GP39Ap24Byl22sJgGmoJzOkH2zwrOqgXmHBk9prcn5zzVwts/cR9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246741;
	h=DMARC-Filter:DKIM-Signature:Date:Message-Id:Subject:Mime-Version:
	 Content-Language:References:Content-Type:Content-Transfer-Encoding:To:
	 From:User-Agent:In-Reply-To:Cc:Received:X-Lms-Return-Path:
	 X-Original-From;
	bh=of5wDV3zwnZMfBn47sFHMyptb9HWLvJPm1MdsBWIy34=;
	b=lDyZ0qHwN+UCvKetWhW1lwI92KwoZcmkXNdWLk6t9nhLDS54Dq3BfG2ajDMuz7CnKESF
	 SNG6syNiAD/N//Jh5igDbEyiEOUu89GMZs8pyjdD7fuS6Gdr4PHL9tPYhStcaoP3Z2SxP
	 zthSuXUBagyXcli8P2rw0lGxxZrJXrGHhXzf9n6BYK5JXSCFPtyXrYBMZ86si8oz9CBU/
	 Kgd7xjEfU2T948poLfPjytECIS2vXTwzIem7sglt1lm7RrjIJD+ZqUcRD4LHtFRFvu/Fs
	 glCkH+m3koGkgpUBgc6AbMSZG5Jj2vf7L1UorwdcZP9UNUTO90g12EYhDi6bVSUUsvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lanxincomputing.com;
	spf=pass smtp.mailfrom=lanxincomputing.com;
	dkim=pass header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=DZvC8UJp;
	arc=none smtp.remote-ip=209.127.231.28
Received: from va-2-28.ptr.blmpb.com (va-2-28.ptr.blmpb.com [209.127.231.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A633B606A31A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 04:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A633B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=DZvC8UJp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1793246733;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=of5wDV3zwnZMfBn47sFHMyptb9HWLvJPm1MdsBWIy34=;
 b=DZvC8UJp55cNc+AsqR0J/ANVE84SYlqCJXKEfY37p7YjLsPGQDJBEvbR0Q6etMZr7t0DVH
 G8INE7JANAPKuJYeWn49fKMXN/CYrQSK5RQIF3YVzxgpVXIeRKwXjs4T3jSCYc9ybPjRb7
 dMrCeDOIYCiCHG1RxsaiF42kCKHT4y+Y+YoHZtFAnT5YK7dzwhJ2OjasTd1jUpXAr7qBXf
 UwZkc5um65dOmaPSeq79HYIZk4DqweB9R1n0u2o6KY6mn4OyPt30de+gNLw4bCRsaxkvYw
 Ky/L3Exx/L8Wat8g9Izwhe/XKRqZyF10+fG96y02VMSC/AwYRol0HXrFfoR3PQ==
Date: Thu, 29 Oct 2026 12:05:28 +0800
Message-Id: <504d1c51-857b-4f42-ad66-bea00ab9a03f@lanxincomputing.com>
Subject: Re: [PATCH] RISC-V: KVM: Flush VS-stage TLB before reusing a host CPU
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Language: en-US
References: <20260817102447.40259-1-guoyaxing@bosc.ac.cn> <CAAhSdy2qwdHE7SB2gRK3_PQ6m_bMSfWpvcuSG-31W2yd3-UTKg@mail.gmail.com> <285419e5-c4fc-4c75-a765-436165bdc8b9@bosc.ac.cn> <CAAhSdy1Q7a+54qn0xNBQBd1eV2ve+Nzqz9uRsWrGSmTn35z8=A@mail.gmail.com> <c050c85c-482a-4351-b627-ac074f7f7952@bosc.ac.cn> <CAAhSdy3XDEGfFJJnHfx2Q0w+dG4FombF3Lj5O_V4wBpkyAYTNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "Anup Patel" <anup@brainfault.org>, "guoyaxing" <guoyaxing@bosc.ac.cn>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <CAAhSdy3XDEGfFJJnHfx2Q0w+dG4FombF3Lj5O_V4wBpkyAYTNg@mail.gmail.com>
Cc: "Atish Patra" <atish.patra@linux.dev>, "Paul Walmsley" <pjw@kernel.org>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	<kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<majiuyue@bosc.ac.cn>, <anzoso@outlook.com>, 
	"BillXiang" <xiangwencheng@lanxincomputing.com>
Received: from [127.0.0.1] ([123.120.5.129]) by smtp.feishu.cn with ESMTPS; Thu, 29 Oct 2026 12:05:30 +0800
X-Lms-Return-Path: <lba+26ae2c60b+3b3495+vger.kernel.org+xiangwencheng@lanxincomputing.com>
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>

On 10/24/2026 11:49 PM, Anup Patel wrote:
> On Sat, Oct 10, 2026 at 2:36=E2=80=AFPM guoyaxing <guoyaxing@bosc.ac.cn> =
wrote:
>>
>>
>>
>> =E5=9C=A8 2026/10/10 15:50, Anup Patel =E5=86=99=E9=81=93:
>>> On Sat, Oct 10, 2026 at 4:12=E2=80=AFAM guoyaxing <guoyaxing@bosc.ac.cn=
> wrote:
>>>>
>>>>
>>>>
>>>> =E5=9C=A8 2026/10/10 02:51, Anup Patel =E5=86=99=E9=81=93:
>>>>> On Mon, Aug 17, 2026 at 12:25=E2=80=AFPM Yaxing Guo <guoyaxing@bosc.a=
c.cn> wrote:
>>>>>>
>>>>>> Guest Linux uses mm_cpumask to decide whether an sfence.vma needs to=
 be
>>>>>> local or remote. Under KVM that mask tracks guest CPUs, not the host=
 CPUs
>>>>>> that previously backed a vCPU.
>>>>>>
>>>>>> This can miss stale VS-stage TLB entries when a vCPU migrates across=
 host
>>>>>> CPUs. For example:
>>>>>>
>>>>>>      - vcpu0 runs on host CPU1 and fills a VS-stage TLB entry.
>>>>>>      - vcpu0 migrates to host CPU0.
>>>>>>      - the guest updates the mapping on vcpu0 and issues a local sfe=
nce.vma.
>>>>>>      - later, the guest task runs on vcpu1 while vcpu1 is backed by =
host CPU1.
>>>>>
>>>>> When the vcpu0 is brought back to host CPU1, the kvm_riscv_local_tlb_=
sanitize()
>>>>> will ensure TLB entries associated with Guest/VM are nuked.
>>>>>
>>>>> By default, kvm_riscv_local_hfence_gvma_vmid_all() will only do HFENC=
E.GVMA
>>>>> for the associated VMID because most RISC-V H-extension implemenation=
 will
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
>>>>      Regarding =E2=80=9CWhen the vcpu0 is brought back to host CPU1=E2=
=80=9D: the failure
>>>> we hit is not caused by vcpu0 being brought back onto host CPU1. In ou=
r
>>>> case, after vcpu0 has already migrated away, neither vCPU migrates
>>>> again. The guest process is later scheduled inside the multi-vCPU gues=
t
>>>> onto vcpu1, which is still running on host CPU1. So the stale TLB is
>>>> re-hit without any further KVM vCPU migration, and
>>>> kvm_riscv_local_tlb_sanitize() is not involved on that path.
>>>>
>>>>      My commit message was a bit too terse on this point. The concrete
>>>> sequence we observed was described earlier in the RFC discussion:
>>>>
>>>>
>>>> https://lore.kernel.org/kvm/0d15b098-b8f7-4080-9f33-e8c49c2331e1@bosc.=
ac.cn/
>>>>
>>>>      In short, the issue is: because vcpu0 migrated away, cpu1 still h=
as
>>>> stale TLB entries while cpu0 has the new mapping. After that, neither
>>>> vcpu migrated again, but the process was scheduled from vcpu0 to vcpu1
>>>> (which is on cpu1), causing it to hit the stale TLB. Consider the
>>>> following scenario:
>>>>
>>>>      1. vcpu0 and vcpu1 are both running on cpu1. At this point, vcpu0=
 is
>>>> on cpu1, and a process on it reads a page, which gets cached in the TL=
B
>>>> (let's call this the "stale TLB entry").
>>>>
>>>>      2. vcpu0 migrates to cpu0, and then the process (on vcpu0, now on
>>>> cpu0) does a CoW (copy-on-write) and establishes a new mapping.
>>>>
>>>>      3. Neither vcpu0 nor vcpu1 migrates again. At this point, the pro=
cess
>>>> gets scheduled inside the VM onto vcpu1 (which is on cpu1), reads the
>>>> same page, and hits the stale TLB entry.
>>>
>>> This cannot happen because in step#2 when mapping was updated the
>>> Guest OS will do TLB flush for all its VCPUs which means vcpu1 on cpu0
>>> will also receive TLB flush and the stale TLB will be removed. This mea=
ns
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

Hi Anup,

I have a few more questions about the issues and changes you raised.

>=20
> This makes sense now considering ASID allocator in Guest Linux is global
> and not local. In any case, KVM RISC-V must not assume that the Guest OS
> has local ASID allocator hence the kvm_riscv_local_tlb_sanitize() must al=
so
> santize TLB for other VCPUs of the same Guest which can potentially run
> on the previous host CPU where current VCPU ran.
>=20
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

First, the migrated vCPU have run on the previous host CPU before the=20
other vCPUs do, and kvm_riscv_local_tlb_sanitize() will have been called=20
before the other vCPUs run on that previous host CPU. Therefore, with=20
vcpu_switched in Yaxing's original patch, no stale TLB entries remain.

> 3) The per-CPU pointer in struct kvm_arch is racy because we
> may have two VCPUs on same host CPU which are migrated to

Seconed, kvm_riscv_local_tlb_sanitize() is called under=20
preempt_disabled() in kvm_arch_vcpu_ioctl_run, so it is not racy between=20
two vCPUs.

> other host CPUs. Instead, it is much simpler to have an atomic
> cpumask in each VCPU where any part of KVM can mark a host
> CPU in the cpumask of the VCPU to force TLB sanitization whenever
> the VCPU runs on that particular host CPU.
>=20
> How about the following change ?
>=20
> diff --git a/arch/riscv/include/asm/kvm_host.h
> b/arch/riscv/include/asm/kvm_host.h
> index a30600579231..c975eee7240c 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -9,6 +9,7 @@
>   #ifndef __RISCV_KVM_HOST_H__
>   #define __RISCV_KVM_HOST_H__
>=20
> +#include <linux/cpumask.h>
>   #include <linux/types.h>
>   #include <linux/kvm.h>
>   #include <linux/kvm_types.h>
> @@ -184,6 +185,9 @@ struct kvm_vcpu_arch {
>       /* ISA feature bits (similar to MISA) */
>       DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
>=20
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
> @@ -207,11 +207,31 @@ void kvm_riscv_local_hfence_vvma_all(unsigned long =
vmid)
>=20
>   void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
>   {
> -    unsigned long vmid;
> +    struct kvm_vcpu *tvcpu;
> +    unsigned long i, vmid;
>=20
> -    if (!kvm_riscv_gstage_vmid_bits() ||
> -        vcpu->arch.last_exit_cpu =3D=3D vcpu->cpu)
> -        return;
> +    if (!cpumask_test_cpu(vcpu->cpu, &vcpu->arch.tlb_sanitize_mask)) {
> +        if (!kvm_riscv_gstage_vmid_bits() ||
> +            vcpu->arch.last_exit_cpu =3D=3D vcpu->cpu)
> +            return;
> +    }
> +
> +    /*
> +     * The VCPU might have left stale TLBs on the previous host CPU so
> +     * mark previous host CPU in the tlb_sanitize_mask of other VCPUs.
> +     */
> +    if (vcpu->arch.last_exit_cpu > -1 && vcpu->arch.last_exit_cpu !=3D
> vcpu->cpu) {
> +        kvm_for_each_vcpu(i, tvcpu, vcpu->kvm) {
> +            if (tvcpu =3D=3D vcpu)
> +                continue;
> +            cpumask_set_cpu(vcpu->arch.last_exit_cpu,
> +                    &tvcpu->arch.tlb_sanitize_mask);
> +            kvm_vcpu_kick(tvcpu);

Last, vcpu_kick is an asynchronous operation, so there is still a chance=20
that the other vCPUs will hit stale TLB entries.

Please let me know what you think. Thanks in advance!

Regards,
Bill


> +        }
> +    }
> +
> +    /* Clear current host CPU from the tlb_sanitize_mask */
> +    cpumask_clear_cpu(vcpu->cpu, &vcpu->arch.tlb_sanitize_mask);
>=20
>       /*_kick
>        * On RISC-V platforms with hardware VMID support, we share same
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index dd786f758eb7..c00dc0b191dc 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -107,6 +107,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu
> *vcpu, bool kvm_sbi_reset)
>=20
>       vcpu->arch.last_exit_cpu =3D -1;
>=20
> +    cpumask_clear(&vcpu->arch.tlb_sanitize_mask);
> +
>       kvm_riscv_vcpu_context_reset(vcpu, kvm_sbi_reset);
>=20
>       kvm_riscv_vcpu_fp_reset(vcpu);
>=20
> Regards,
> Anup
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
