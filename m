Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC473E1218
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691034; cv=none; b=Fq2yfGq4S6FVNJkI+5d2uCe2UcvQpqjYG2w10Bl0L6EoMkP2WzKafXW1aZiM9PD1zEnwazBEF4eOj7YTHWkQn+Z3a2AOWMSGGSZXwTqf8ouJz78vo7hk/Fwb4de5LP5Rn2in66HAspv3tTu2y5W4h0z2LI1w1enAnrk9WJWARQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691034; c=relaxed/simple;
	bh=3s/eOfHuNeTTwpvxWVr0O920a/lF9voKEPPHw5g5zUU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rj4WaeC90B6cLnR/UHKbzSbez1XP9Y7V9ENFKW8oKw9qfqC3+snhJS5D3Sq8fPt1Gclm+UYyJJLQ8K2kJqH6wrBv/AyESldrr63lMzrqcuzflSJUFHabNFL151IvdwR/MB7zPnzNeRXfbWViCNydvk1NtRmp6sTw9hLRybfxBds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gvHnfXjm; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gvHnfXjm"
Message-ID: <775ddf2f-a7e1-4fd4-b484-01e952c332bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784691020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxQSL7BiLvygHJAsAZ5TxacMFqKXC6qmayAdZzXY9rA=;
	b=gvHnfXjmBHS1KR495ryvC4JFbSIqDXeXZjh0PdSwrrCDzcRIyTuXJ+Yolk4wi0VI9J9jrK
	OgpyX8M6c7znOUc7cMMdH+X8V32P3omSraKH298T44KYl/MAwUPmBX0QxEjZlfwRUkS2HN
	hmYp79t+dj5Ih31HFKhfW7DVQr3nZh8=
Date: Wed, 22 Jul 2026 11:29:56 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, chenhuacai@kernel.org, kernel@xen0n.name,
 kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, cuitao@kylinos.cn
Subject: Re: [PATCH] LoongArch: KVM: Implement KVM_GET/SET_SREGS for bulk CSR
 migration
To: Bibo Mao <maobibo@loongson.cn>, zhaotianrui@loongson.cn
References: <20260721121842.156025-1-cui.tao@linux.dev>
 <63410558-e04d-7cbf-4acb-e85619d22236@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <63410558-e04d-7cbf-4acb-e85619d22236@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/7/22 09:42, Bibo Mao 写道:
> 
> 
> On 2026/7/21 下午8:18, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> KVM_GET/SET_SREGS has so far returned -ENOIOCTLCMD with an empty
>> struct kvm_sregs, so migrating a vCPU's CSR state takes one
>> KVM_GET/SET_ONE_REG ioctl per register -- thousands of syscalls for a
>> large VM.
>>
>> Define struct kvm_sregs as a flat array of 0x184 entries (the core CSR
>> range 0x0-0x183, up to DMWIN3) and implement the two ioctls:
>>
>> - get_sregs does a single vcpu_load/put, which also pulls pending
>>    interrupts into ESTAT, avoiding the per-register load/put side-effect
>>    that made ONE_REG snapshots of ESTAT order-sensitive.
>> - set_sregs writes all CSRs via _kvm_setcsr in one pass, propagates
>>    _kvm_setcsr errors, and clears KVM_LARCH_HWCSR_USABLE up front so a
>>    mid-loop failure still forces the next vcpu_load() to reload from SW,
>>    matching KVM_SET_ONE_REG.
>>
>> CSRs above 0x183 (debug, breakpoint, PMU) stay on KVM_GET/SET_ONE_REG.
>> struct kvm_sregs was empty, so enlarging it -- and the _IOWR-derived
>> ioctl number -- breaks no userspace; userspace built against the updated
>> UAPI header can adopt the bulk ioctl.
>>
>> On a Loongson 3A6000, snapshotting one vCPU's core CSR range drops from
>> 388 KVM_GET_ONE_REG calls (~2 ms) to a single KVM_GET_SREGS ioctl
>> (~5 us).
> Great, I think getting register with bulk method is good.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>   arch/loongarch/include/uapi/asm/kvm.h |  3 ++
>>   arch/loongarch/kvm/vcpu.c             | 43 +++++++++++++++++++++++++--
>>   2 files changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/include/uapi/asm/kvm.h
>> index cd0b5c11ca9c..dc091f29963d 100644
>> --- a/arch/loongarch/include/uapi/asm/kvm.h
>> +++ b/arch/loongarch/include/uapi/asm/kvm.h
>> @@ -124,7 +124,10 @@ struct kvm_sync_regs {
>>   };
>>     /* dummy definition */
>> +#define KVM_LOONGARCH_NR_SREGS    0x184
>> +
>>   struct kvm_sregs {
>> +    __u64 csr[KVM_LOONGARCH_NR_SREGS];
> 
Thanks for the review.
> I think that get/set registers one by one is not so better. There are two possible potential problems with this method:
>   1. With hard-code size 0x184, there may be compatible issue, in future there may be CSR register with index larger than 0x184

On the fixed 0x184: agreed, that's a real ABI trap. I'll switch to the
index+data form you suggested, like KVM_GET_MSRS:

    struct kvm_loongarch_csr_entry { __u32 index; __u32 reserved; __u64 data; };
    struct kvm_loongarch_csrs { __u32 ncsrs; __u32 pad;
                                struct kvm_loongarch_csr_entry entries[]; };

One ioctl, same perf win, and new CSRs just add an index -- no ABI change.

>   2. There may be order dependency with CSR get or set, such timer,interrupt, or feature ctrl registers. Only that there is SW CSR shadow CSR register in KVM, so dependency relation disappears with this method.

On ordering: the SW CSR shadow already absorbs it -- get reads
kvm_read_sw_gcsr(), set writes _kvm_setcsr(), both on the SW copy, so
order within one ioctl doesn't matter. get also folds pending IRQs into
ESTAT via a single vcpu_load/put + kvm_deliver_intr(), and set clears
KVM_LARCH_HWCSR_USABLE up front, matching KVM_SET_ONE_REG.

> 
> In generic, I think KVM_GET_MSRS/KVM_SET_MSRS is a better method, VMM needs know the index and dependency at first, this API can be changed as generic and not relative with detailed architecture.
> 

A generic bulk-reg ioctl is the cleaner long-term direction, but I'd
land the LoongArch-specific one first and revisit generic later.

v2 coming. Thanks again.

Thanks,
Tao
> When we submit KVM to community in the beginning, this method was used, however the community suggests that new API KVM_GET_ONE_REG/KVM_SET_ONE_REG is added, it should be used. Maybe mixed of KVM_GET_BULK_REGS/KVM_GET_ONE_REG can be used :)
> 
> There is piece of UAPI with KVM_GET_MSRS/KVM_SET_MSRS.
> struct kvm_msr_entry {
>         __u32 index;
>         __u32 reserved;
>         __u64 data;
> };
> 
> /* for KVM_GET_MSRS and KVM_SET_MSRS */
> struct kvm_msrs {
>         __u32 nmsrs; /* number of msrs in entries */
>         __u32 pad;
> 
>         __DECLARE_FLEX_ARRAY(struct kvm_msr_entry, entries);
> };
> 
> Regards
> Bibo Mao
>>   };
>>     struct kvm_iocsr_entry {
>> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
>> index 20c207d80e31..0890b68efa2a 100644
>> --- a/arch/loongarch/kvm/vcpu.c
>> +++ b/arch/loongarch/kvm/vcpu.c
>> @@ -1001,12 +1001,51 @@ static int kvm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>>     int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
>>   {
>> -    return -ENOIOCTLCMD;
>> +    int i;
>> +    unsigned long estat, gintc;
>> +    struct loongarch_csrs *csr = vcpu->arch.csr;
>> +
>> +    /*
>> +     * Pull pending interrupts into ESTAT with a single vcpu_load/put so
>> +     * the ESTAT value read below matches the current interrupt state.
>> +     * This also avoids the per-register load/put side-effect that makes
>> +     * the ONE_REG path's ESTAT snapshot order-sensitive.  The SW CSR
>> +     * reads run under vcpu->mutex, which serialises this ioctl.
>> +     */
>> +    preempt_disable();
>> +    vcpu_load(vcpu);
>> +    kvm_deliver_intr(vcpu);
>> +    vcpu->arch.aux_inuse &= ~KVM_LARCH_SWCSR_LATEST;
>> +    vcpu_put(vcpu);
>> +    preempt_enable();
>> +
>> +    for (i = 0; i < KVM_LOONGARCH_NR_SREGS; i++) {
>> +        if (i == LOONGARCH_CSR_ESTAT) {
>> +            gintc = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC) & KVM_GINTC_IRQ_MASK;
>> +            estat = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT) & ~KVM_ESTAT_EXTI_MASK;
>> +            sregs->csr[i] = estat | (gintc << VIP_DELTA);
>> +        } else {
>> +            sregs->csr[i] = kvm_read_sw_gcsr(csr, i); > +        }
>> +    }
>> +
>> +    return 0;
>>   }
>>     int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
>>   {
>> -    return -ENOIOCTLCMD;
>> +    int i, ret;
>> +
>> +    /* Clear first so a failing _kvm_setcsr still forces a HW reload. */
>> +    vcpu->arch.aux_inuse &= ~KVM_LARCH_HWCSR_USABLE;
>> +
>> +    for (i = 0; i < KVM_LOONGARCH_NR_SREGS; i++) {
>> +        ret = _kvm_setcsr(vcpu, i, sregs->csr[i]);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    return 0;
>>   }
>>     int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>>
> 

