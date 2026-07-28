Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F696311C2D
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252822; cv=none; b=SlJaGof1+kxZWpY1kadJVDCBdnnrbDzzqQsnBNQB9h399k2dF/tn9r9QodJpsenzw0/WOUEqP3x38E4elXWfVzl7XbNXy/WBrInJdyjYGTGDRin0Eja5dFUPZCQFBRGt+psYd0BNux2cF4SuvJk87RDR5aKhINKHUvu+wcBtXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252822; c=relaxed/simple;
	bh=YuBTtINjR4jpnq2hKlU2JptssXWFADJS3Oya7sYVQDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFaIA6LwsW6YgX0NNgYNU9uLg/NyR8MGH4HLjZsXOZ1lRbvRqr6M38faju4FlLndlL2ZLjWiJtqssbGMwHOP1WDWpMciciJx/jKVNSjFMsj+XhjCHzk3GaduwGj9Mi4BLlLODW+g2D1WvlWLeY6wHuIR/7gOVMUL+DJmQY7fitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDjpxILp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDjpxILp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785252819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cryWGARQWgvDH8w4Iru00RCVGi/QlZW6kZxJHz1JXWU=;
	b=YDjpxILpzNvLaz1M30v1xzjPN1e4TsMKzG18kuLL60+GaVSbNRsbIXyPJJnRNXMUBfKIkf
	L9pmv0XQpi7G9A5UhwQk6N2sGn5FZ3Mw3Ep97MJSBOizynD/yz0+vqM2YfmORHXL1LRIJl
	DSJtPnCV94WQHDW9K4OfP820qPQmWUo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-o_NNZKpZPpef7RsEd3ki3A-1; Tue,
 28 Jul 2026 11:33:32 -0400
X-MC-Unique: o_NNZKpZPpef7RsEd3ki3A-1
X-Mimecast-MFC-AGG-ID: o_NNZKpZPpef7RsEd3ki3A_1785252809
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0FC41955DDE;
	Tue, 28 Jul 2026 15:33:24 +0000 (UTC)
Received: from [10.44.32.140] (unknown [10.44.32.140])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9954B1800480;
	Tue, 28 Jul 2026 15:33:22 +0000 (UTC)
Message-ID: <1800dfd2-5d55-4244-a69f-c7e16868b238@redhat.com>
Date: Tue, 28 Jul 2026 17:33:19 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KVM: x86: Cancel delayed I/O APIC EOI handling before
 destroying vCPUs
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 zdi-disclosures@trendmicro.com, Zhong Wang
 <wangzhong.c0ss4ck@bytedance.com>,
 Xuanqing Shi <shixuanqing.11@bytedance.com>,
 Weiming Shi <bestswngs@gmail.com>
References: <20260727171718.543491-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260727171718.543491-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 7/27/26 19:17, Sean Christopherson wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> Cancel (and flush) the I/O APIC's delayed EOI handling work during the
> "pre VM destroy" phase, before vCPUs are destroyed, as processing the EOI
> broadcast will inject another IRQ if the line is asserted, i.e. will try
> to deliver an IRQ to the target vCPU(s).  Canceling the work after vCPUs
> are destroyed leads to UAF if the delayed work is processed after vCPUs are
> destroyed.
> 
>    BUG: KASAN: slab-use-after-free in __kvm_irq_delivery_to_apic_fast+0x9bf/0xa20 arch/x86/kvm/lapic.c:1250
>    Read of size 8 at addr ffff8880499abea0 by task kworker/1:2/1218
> 
>    CPU: 1 UID: 0 PID: 1218 Comm: kworker/1:2 Not tainted 7.1.0-rc7 #5 PREEMPT(lazy)
>    Hardware name: QEMU Ubuntu 25.10 PC v2 (i440FX + PIIX, + 10.1 machine, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>    Workqueue: events kvm_ioapic_eoi_inject_work
>    Call Trace:
>     <TASK>
>     __dump_stack lib/dump_stack.c:94
>     dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>     print_address_description mm/kasan/report.c:378
>     print_report+0x139/0x4ad mm/kasan/report.c:482
>     kasan_report+0xe4/0x1d0 mm/kasan/report.c:595
>     __kvm_irq_delivery_to_apic_fast+0x9bf/0xa20 arch/x86/kvm/lapic.c:1250
>     __kvm_irq_delivery_to_apic+0xd8/0xbf0 arch/x86/kvm/lapic.c:1345
>     kvm_irq_delivery_to_apic arch/x86/kvm/lapic.h:129
>     ioapic_service+0x308/0x590 arch/x86/kvm/ioapic.c:492
>     kvm_ioapic_eoi_inject_work+0x13c/0x190 arch/x86/kvm/ioapic.c:532
>     process_one_work+0xa59/0x19a0 kernel/workqueue.c:3314
>     process_scheduled_works kernel/workqueue.c:3397
>     worker_thread+0x5eb/0xe50 kernel/workqueue.c:3478
>     kthread+0x370/0x450 kernel/kthread.c:436
>     ret_from_fork+0x72b/0xd30 arch/x86/kernel/process.c:158
>     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>     </TASK>
> 
> Note, the VM is unreachable once kvm_destroy_vm() starts, and scheduling
> new work via kvm_ioapic_send_eoi() can only be done via KVM_RUN, i.e.
> requires a live vCPU.
> 
> Alternatively, KVM could simply destroy the I/O APIC during the "pre" phase
> of VM destruction, but that gets more than a bit sketchy as KVM expects the
> I/O APIC to exist if ioapic_in_kernel() is true, and nested virtualization
> in particular has a bad habit of touching VM-scope state during vCPU
> destruction.  E.g. attempting to free the PIC during the pre phase would
> lead to a NULL pointer dereference in kvm_cpu_has_extint(), and it's not
> hard to imagine the I/O APIC having a similar flaw.
> 
> Fixes: 17bcd7144263 ("KVM: x86: Free vCPUs before freeing VM state")
> Reported-by: <zdi-disclosures@trendmicro.com>
> Reported-by: Zhong Wang <wangzhong.c0ss4ck@bytedance.com>
> Reported-by: Xuanqing Shi <shixuanqing.11@bytedance.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Queued, thanks.

Paolo

> ---
> 
> v3:
>   - Go back to v1, sans the helper (x86.c already has an #ifdef). [Sean, syzbot]
>   - Expand the block comment to call out the the PIC and I/O APIC must not be
>     destroyed/free. [Kai]
> 
> v2:
>   - https://lore.kernel.org/all/20260706180025.2735341-3-bestswngs@gmail.com
>   - Per Kai's suggestion, instead of adding a kvm_ioapic_pre_destroy()
>     helper that only cancels the eoi_inject work, move
>     kvm_pic_destroy()/kvm_ioapic_destroy() as a whole into
>     kvm_arch_pre_destroy_vm().  This also fixes the stale
>     kvm_io_bus_unregister_dev() Kai pointed out.
> 
> v1: https://lore.kernel.org/all/20260705050443.1331662-1-bestswngs@gmail.com
> 
>   arch/x86/kvm/x86.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0626e835e9eb..2b8474812303 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9939,9 +9939,15 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
>   	 * iterating over vCPUs in a different task while vCPUs are being freed
>   	 * is unsafe, i.e. will lead to use-after-free.  The PIT also needs to
>   	 * be stopped before IRQ routing is freed.
> +	 *
> +	 * Do NOT free the in-kernel PIC or I/O APIC here (but as above, make
> +	 * sure to flush any background work), as KVM expects interrupt routing
> +	 * structures to be valid until vCPUs are destroyed.
>   	 */
>   #ifdef CONFIG_KVM_IOAPIC
>   	kvm_free_pit(kvm);
> +	if (kvm->arch.vioapic)
> +		cancel_delayed_work_sync(&kvm->arch.vioapic->eoi_inject);
>   #endif
>   
>   	kvm_mmu_pre_destroy_vm(kvm);
> 
> base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370

