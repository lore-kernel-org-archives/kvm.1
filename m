Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568421;
	b=IlLD8W6Bl60XzNOIYvDfyd+eGpPAugg3NwV9y9y8UCL11454/I06YqhPzVY+Pe+yG6ux
	 00LhCF7jkOYSHDKMhNWouPLlPDbN/afaQjGq4nlPzuVtehxvbbdH8cL/zwXbJiw1j8gJe
	 aY+vd5ZCQ9LyA97o7uIkIGYvN2nuDaPQT1OW73pxGlOGfSWEplaI4oaUv/1+aO9poeWp2
	 8uM8qJCl7fx4lZjXvyw0iEqOPd3SItCRMATeMUy4snQogjc9EiD5V4LpnZnohV36kD8q4
	 zgHCseDE8EW3UaHjVsdcwVMdY2OolO43t/Xb0IBLoR6XVO5WbOVW5pkVRUc6Tm0qBpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568421;
	h=DMARC-Filter:DKIM-Signature:Subject:Mime-Version:Received:From:
	 Content-Language:In-Reply-To:Content-Type:Date:X-Lms-Return-Path:
	 X-Original-From:References:User-Agent:Content-Transfer-Encoding:To:Cc:
	 Message-Id;
	bh=5z3kRYBTZmascmZC3oBJ58Ce4ddSnbuJ0JbdYHj/1JU=;
	b=Wym+3KMvFXAz5A5wjW6sEVvmINMecoYCuxmfMbmWH5mLLQOPjgicMR4y+8KZJTe/3UlW
	 sfK8x5lKQZCb5Ms/0OuFldeXjzc0C0vL/npOShON+sD61XDqzDbUmwS3pHmgsvpS16N3s
	 UE/zFZORaDdNqmZ41mODLYdBNXq+PSOHcSWBQPDhjQv6xG7iK7szwgqFOFfzE777mtk89
	 3qU0yJAYfiKNfALiASqTJG1KyGkhlt6l9no3UPY5xzVQ6JalwTuXZBbzC5/xqKQKIsibv
	 ZE4ghZrPD9QfCw1f4cNYEmC9/B9z9G9syZTvzt0aPKdBFHHgMG6YYT5azFhzY2Otb9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lanxincomputing.com;
	spf=pass smtp.mailfrom=lanxincomputing.com;
	dkim=pass header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=2RJOnBmK;
	arc=none smtp.remote-ip=209.127.231.30
Received: from va-2-30.ptr.blmpb.com (va-2-30.ptr.blmpb.com [209.127.231.30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19131606A31C
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 11:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19131606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=2RJOnBmK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1794568414;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=5z3kRYBTZmascmZC3oBJ58Ce4ddSnbuJ0JbdYHj/1JU=;
 b=2RJOnBmKuMtUQ3+7IjG6Woaz9wyDDKqGAWaPEXWgDpQ6L0ZMktXmmcskyvJgoPA1s8ySnU
 XOGqIVBBbQzYPgnjEtbRYedF7VAboqEbExRMDAyiy2wfZHspHWHcn6iofRahw+d6UdPeGS
 I8PP/wrNOGlTgaEKF7GuVQWQXftQJYychqFFQivbPyXwjIEu1EsU2md39CVBs8DZKgKK0y
 qkxnp+itHCmfHcS16ymXylwInrux69aSf5sOCcvlyQVDdlKE9ECuZqndzOKu+6cAGzu1Df
 nkn0/avjcVxiIoZckUUsXepzV4VNTUhzQkYJGkEmjYLEzzD4CvbfkMZUGiOspg==
Subject: Re: [PATCH v4] RISC-V: KVM: Serialize and atomize the IMSIC's TOPEI read-and-clear operation
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Received: from [127.0.0.1] ([123.120.5.129]) by smtp.feishu.cn with ESMTPS; Fri, 13 Nov 2026 19:13:31 +0800
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-212624@kernel.org>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 19:13:29 +0800
X-Lms-Return-Path: <lba+26af6f0dc+28a652+vger.kernel.org+xiangwencheng@lanxincomputing.com>
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
References: <20261113101358.3007601-1-xiangwencheng@lanxincomputing.com> <sashiko-outbox-212624@kernel.org>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: 7bit
To: "Anup Patel" <anup@brainfault.org>
Cc: <xb@ultrarisc.com>, <atish.patra@linux.dev>, <pjw@kernel.org>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<pbonzini@redhat.com>, <graf@amazon.com>, 
	<kvm-riscv@lists.infradead.org>, <kvm@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Message-Id: <44886809-744d-4e4d-9a55-45e2fcc6dd08@lanxincomputing.com>

On 11/13/2026 6:34 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] RISC-V: KVM: stale topei passed to
>    __imsic_swfile_extirq_update()
> - [High] RISC-V: KVM: imsic->swfile dereferenced before !imsic check in
>    inject
> - [Low] RISC-V: KVM: missing Fixes trailer on IMSIC TOPEI serialization
>    fix
> --
> 
> commit 322bd38f6016b31c1cdf5b875effdce4436f4b2f
> Author: BillXiang <xiangwencheng@lanxincomputing.com>
> 
>> RISC-V: KVM: Serialize and atomize the IMSIC's TOPEI read-and-clear operation
>>
>> The TOPEI read-and-clear must be atomic with respect to
>> interrupt injection (set_bit in EIP). Otherwise an
>> interrupt injected between the topei read and the
>> clear_bit could be silently dropped.
>>
>> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> 
> [Severity: Low]
> Since this fixes a race in the IMSIC software file TOPEI handling, should
> it include:
> 
>    Fixes: db8b7e97d613 ("RISC-V: KVM: Add in-kernel virtualization of AIA IMSIC")
> 
>> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
>> index 302938972aa0e..f4cc1691e0478 100644
>> --- a/arch/riscv/kvm/aia_imsic.c
>> +++ b/arch/riscv/kvm/aia_imsic.c
>> @@ -526,26 +526,25 @@ static void imsic_vsfile_cleanup(struct imsic *imsic)
>>   		kvm_riscv_aia_free_hgei(old_vsfile_cpu, old_vsfile_hgei);
>>   }
>>   
>> -static void imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
>> +static void __imsic_swfile_extirq_update(struct kvm_vcpu *vcpu, u32 topei)
>>   {
>>   	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
>>   	struct imsic_mrif *mrif = imsic->swfile;
>> -	unsigned long flags;
>> -
>> -	/*
>> -	 * The critical section is necessary during external interrupt
>> -	 * updates to avoid the risk of losing interrupts due to potential
>> -	 * interruptions between reading topei and updating pending status.
>> -	 */
>> -
>> -	raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
>>   
>> -	if (imsic_mrif_atomic_read(mrif, &mrif->eidelivery) &&
>> -	    imsic_mrif_topei(mrif, imsic->nr_eix, imsic->nr_msis))
>> +	if (imsic_mrif_atomic_read(mrif, &mrif->eidelivery) && topei)
>>   		kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_VS_EXT);
>>   	else
>>   		kvm_riscv_vcpu_unset_interrupt(vcpu, IRQ_VS_EXT);
>> +}
>> +
>> +static void imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
>> +{
>> +	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
>> +	struct imsic_mrif *mrif = imsic->swfile;
>> +	unsigned long flags;
>>   
>> +	raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
>> +	__imsic_swfile_extirq_update(vcpu, imsic_mrif_topei(mrif, imsic->nr_eix, imsic->nr_msis));
>>   	raw_spin_unlock_irqrestore(&imsic->swfile_extirq_lock, flags);
>>   }
>>   
>> @@ -830,12 +829,15 @@ int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *vcpu, unsigned long isel,
>>   	struct imsic_mrif_eix *eix;
>>   	int r, rc = KVM_INSN_CONTINUE_NEXT_SEPC;
>>   	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
>> +	unsigned long flags;
>>   
>>   	/* If IMSIC vCPU state not initialized then forward to user space */
>>   	if (!imsic)
>>   		return KVM_INSN_EXIT_TO_USER_SPACE;
>>   
>>   	if (isel == KVM_RISCV_AIA_IMSIC_TOPEI) {
>> +		raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
>> +
>>   		/* Read pending and enabled interrupt with highest priority */
>>   		topei = imsic_mrif_topei(imsic->swfile, imsic->nr_eix,
>>   					 imsic->nr_msis);
>> @@ -852,16 +854,20 @@ int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *vcpu, unsigned long isel,
>>   					  eix->eip);
>>   			}
>>   		}
>> +		if (wr_mask)
>> +			__imsic_swfile_extirq_update(vcpu, topei);
> 
> [Severity: High]
> Does this pass the pre-clear interrupt ID in topei to
> __imsic_swfile_extirq_update() instead of re-reading imsic_mrif_topei()
> after clear_bit()?
> 
> When a guest claims the last pending interrupt in imsic->swfile via a
> TOPEI write, topei still holds the non-zero ID that was just cleared from
> eix->eip.  __imsic_swfile_extirq_update() then calls
> kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_VS_EXT) instead of unsetting
> IRQ_VS_EXT, leaving IRQ_VS_EXT asserted and causing spurious guest
> external interrupt traps.
> 
> [ ... ]
> 
>> @@ -959,6 +965,7 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
>>   	unsigned long flags;
>>   	struct imsic_mrif_eix *eix;
>>   	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
>> +	struct imsic_mrif *mrif = imsic->swfile;
>>   
>>   	/* We only emulate one IMSIC MMIO page for each Guest VCPU */
>>   	if (!imsic || !iid || guest_index ||
> 
> [Severity: High]
> Does imsic->swfile dereference a NULL imsic pointer before the !imsic
> check below?  If a vCPU is created after aia_init(), its imsic_state is
> NULL and injecting an MSI to that vCPU will crash the host kernel instead
> of returning -ENODEV.
> 

Ignore this version.

Regards,
Bill
