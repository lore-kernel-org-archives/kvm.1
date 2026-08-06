Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087081684BE;
	Thu,  6 Aug 2026 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020032; cv=none; b=dntggOrqr9ubn2fE8Qv3F3NwxB6DjlxC/iUxdcXcJZaHofr0J0NYqvGLwbvahGcMZzQpZw7fAlznp4UyMk48ONFk3sZixAotxEpml1OqnPmzE0jLyMDJd3GBqhShGQ0TB0JI/b04K9vUjvzyxD9BWutn3EHIrTJgbKPT79Y5YHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020032; c=relaxed/simple;
	bh=hKGbHzL6m8jeaAlYdIUYcedz6c5dSDlr39SyGcXb5WQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XaUb/FxukUnltzOLKlTu6mkbLJ6LaqYwZt20lTCZsF9PXtEQwhc+BP7RC++GxdO0madbhxg/i4ooFNGP1psmZQM25yDFVvgq12InpanYXpxFOfZerFISyH+fAcIDkCp1Ow1QMJvBo4KwVApdvDrDlIAtDaFHEP++wEF88LnlCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxVeisgHRqw_wKAA--.12141S3;
	Thu, 06 Aug 2026 20:40:12 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxSsSrgHRqZsolAA--.21300S2;
	Thu, 06 Aug 2026 20:40:11 +0800 (CST)
Subject: Re: [PATCH v2 1/5] LoongArch: KVM: Add vmid support for stage2 MMU
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
 Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>,
 kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260806020739.2149268-1-maobibo@loongson.cn>
 <20260806020739.2149268-2-maobibo@loongson.cn>
 <CAAhV-H6TLMaD9iv4eksPB+=VjjyR_YXVyzdx8ou9LF0mSYz_4g@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <3cf9972c-7927-8858-2137-88aed820c9fd@loongson.cn>
Date: Thu, 6 Aug 2026 20:39:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6TLMaD9iv4eksPB+=VjjyR_YXVyzdx8ou9LF0mSYz_4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxSsSrgHRqZsolAA--.21300S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF43GF4fWFyxWF1DJF1rXwc_yoWruFWkpF
	9rAF4kWr48Wr1kAa4qqw1kWr4DX3ykKw1Sga1ayFyrAr12qr18JFykCryDWFy5Jw4rAF4I
	vF95Ka9FvF4Dt3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU466zUUUUU



On 2026/8/6 下午8:20, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Thu, Aug 6, 2026 at 10:14 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> LoongArch KVM hypervisor supports two-level MMU, vpid index is used
>> for stage1 MMU and vmid index is used for stage2 MMU.
>>
>> On 3A5000, vmid must be the same with vpid. On 3A6000 platform vmid
>> may separate from vpid. If vCPU migrate to different physical CPUs,
>> vpid need change however vmid can keep unchanged, so that TLB entries
>> for stage2 MMU is valid still. Also vmid index of the whole VM machine
>> is the same on one physical CPU, all vCPUs on the VM can share the
>> same vmid index on one physical CPU.
>>
>> Here hw vmid index is added and it keeps the same with hw vpid still.
> HW VPID means GSTAT.GID, HW VMID means GTLBC.TGID, right? It is useful
> to describe it in the commit message.
yes, it is right.
Will add this description in the commit message.
> 
> 
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/kvm_host.h | 3 +++
>>   arch/loongarch/kernel/asm-offsets.c   | 1 +
>>   arch/loongarch/kvm/main.c             | 1 +
>>   arch/loongarch/kvm/switch.S           | 5 ++---
>>   arch/loongarch/kvm/tlb.c              | 5 ++++-
>>   5 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
>> index 23cfbecebbd7..78f97dea124d 100644
>> --- a/arch/loongarch/include/asm/kvm_host.h
>> +++ b/arch/loongarch/include/asm/kvm_host.h
>> @@ -232,6 +232,9 @@ struct kvm_vcpu_arch {
>>          /* Cache for pages needed inside spinlock regions */
>>          struct kvm_mmu_memory_cache mmu_page_cache;
>>
>> +       /* hw vmid info for guest VM */
>> +       unsigned long hw_vmid;
> Since this is only used to write GCNTC.TGID, simply rename it to tgid
> can eliminate confusion.
ok, tgid sounds good to me.
> 
>> +
>>          /* vcpu's vpid */
>>          u64 vpid;
>>          gpa_t flush_gpa;
>> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
>> index 1b861cbc5e10..065ced1f3c1f 100644
>> --- a/arch/loongarch/kernel/asm-offsets.c
>> +++ b/arch/loongarch/kernel/asm-offsets.c
>> @@ -300,6 +300,7 @@ static void __used output_kvm_defines(void)
>>          OFFSET(KVM_ARCH_HSP, kvm_vcpu_arch, host_sp);
>>          OFFSET(KVM_ARCH_HTP, kvm_vcpu_arch, host_tp);
>>          OFFSET(KVM_ARCH_HPGD, kvm_vcpu_arch, host_pgd);
>> +       OFFSET(KVM_ARCH_VMID, kvm_vcpu_arch, hw_vmid);
>>          OFFSET(KVM_ARCH_KVMPGD, kvm_vcpu_arch, kvm_pgd);
>>          OFFSET(KVM_ARCH_HANDLE_EXIT, kvm_vcpu_arch, handle_exit);
>>          OFFSET(KVM_ARCH_HEENTRY, kvm_vcpu_arch, host_eentry);
>> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
>> index 3e1005526f4b..401c84f38e8c 100644
>> --- a/arch/loongarch/kvm/main.c
>> +++ b/arch/loongarch/kvm/main.c
>> @@ -223,6 +223,7 @@ static void kvm_update_vpid(struct kvm_vcpu *vcpu, int cpu)
>>
>>          context->vpid_cache = vpid;
>>          vcpu->arch.vpid = vpid;
>> +       vcpu->arch.hw_vmid = vcpu->arch.vpid & vpid_mask;
> Merge Patch#1 and Patch#2, then we can avoid adding this line and then
> remove it immediately.
will merge Patch#1 and Patch#2 in next version.

Regards
Bibo Mao
> 
> 
>>   }
>>
>>   void kvm_check_vpid(struct kvm_vcpu *vcpu)
>> diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/switch.S
>> index 936e4ae3e408..af972394fd55 100644
>> --- a/arch/loongarch/kvm/switch.S
>> +++ b/arch/loongarch/kvm/switch.S
>> @@ -66,9 +66,8 @@
>>          ld.d    t0, a2, KVM_ARCH_KVMPGD
>>          csrwr   t0, LOONGARCH_CSR_PGDL
>>
>> -       /* Mix GID and RID */
>> -       csrrd           t1, LOONGARCH_CSR_GSTAT
>> -       bstrpick.w      t1, t1, CSR_GSTAT_GID_SHIFT_END, CSR_GSTAT_GID_SHIFT
>> +       /* Set VMID for gpa --> hpa mapping */
>> +       ld.d            t1, a2, KVM_ARCH_VMID
>>          csrrd           t0, LOONGARCH_CSR_GTLBC
>>          bstrins.w       t0, t1, CSR_GTLBC_TGID_SHIFT_END, CSR_GTLBC_TGID_SHIFT
>>          csrwr           t0, LOONGARCH_CSR_GTLBC
>> diff --git a/arch/loongarch/kvm/tlb.c b/arch/loongarch/kvm/tlb.c
>> index ebdbe9264e9c..b25847aab968 100644
>> --- a/arch/loongarch/kvm/tlb.c
>> +++ b/arch/loongarch/kvm/tlb.c
>> @@ -23,7 +23,10 @@ void kvm_flush_tlb_all(void)
>>
>>   void kvm_flush_tlb_gpa(struct kvm_vcpu *vcpu, unsigned long gpa)
>>   {
>> +       unsigned int vmid;
>> +
>>          lockdep_assert_irqs_disabled();
>>          gpa &= (PAGE_MASK << 1);
>> -       invtlb(INVTLB_GID_ADDR, read_csr_gstat() & CSR_GSTAT_GID, gpa);
>> +       vmid = (vcpu->arch.hw_vmid << CSR_GSTAT_GID_SHIFT) & CSR_GSTAT_GID;
>> +       invtlb(INVTLB_GID_ADDR, vmid, gpa);
>>   }
>> --
>> 2.39.3
>>

