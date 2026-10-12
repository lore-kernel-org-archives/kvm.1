Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A137F305
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810308; cv=none; b=Ot98na14yZjbaToi6abOFCdeUr0y4KH7/VfBaH9Iia/q8F+0BkNVJmr06B784RUoOmKz5/6jQEkozm3i7PMu+2lLXbOLy3yOGTpWiZg2A8NaEmG65dA2s6jDxfv/G2xfAh4cYWTCvagCss5JwLAoNFjtFjW+d3/AvlOal1MzNvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810308; c=relaxed/simple;
	bh=ilyNqkF7VzSCHePTlglNLDM4LMxY5NCPOD0J2jbZC/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nX3rrTcT2ZPdgk+ZVb9ivSW8de9wXPeBRokPxPJCdnVTZrjDSTXvtxAGt+XSkE3w5us+s/TpPyoLTnRj1/ZSMgE0Wd1ow5QbPf/JzWbLxBPuhBSXRqkiYewowuUL4GWh0shXwVXeP2CSLMKMOC29BNz5SGQmoyq+m3MUGMX7jD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1rGLP/k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1rGLP/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791810305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GukTXhoXvfiwCR2vZfnu3jtXlC0N7xlwsNAbhpc59GQ=;
	b=F1rGLP/klZwcOL9mAktOeCvsfyqRe8AJlvdF9GKXQIgqjiUF61ZhIfPkgkizzR4QY3K9+P
	4EpvpYPr1JZX3M7rvliT6o1c8AVLTCc4+nNAHKtG3COsNoyPSSfr3BfJyMKhUOA7eGotJG
	Ohzj1A+F84vi0gRqK1zjwFevfHgjg/o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-SCotF9f4O-en39P0RysRcg-1; Mon,
 12 Oct 2026 13:05:02 +0000
X-MC-Unique: SCotF9f4O-en39P0RysRcg-1
X-Mimecast-MFC-AGG-ID: SCotF9f4O-en39P0RysRcg_1791810301
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E27C19560B3;
	Mon, 12 Oct 2026 13:05:01 +0000 (UTC)
Received: from [100.90.56.12] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD4351956086;
	Mon, 12 Oct 2026 13:04:59 +0000 (UTC)
Message-ID: <8b469bdc-fbf9-43e3-9b10-47271d10556e@redhat.com>
Date: Mon, 12 Oct 2026 15:04:57 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] KVM: nVMX: fix nested APICv emulation for windows
 guests
To: Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <20261011001303.723721-1-mlevitsk@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20261011001303.723721-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/11/26 02:13, Maxim Levitsky wrote:
> Fix two problems that were recently discovered that cause nested APICv
> to malfunction on windows with hyperv enabled.
> 
> The first problem is that unlike KVM, windows doesn't set PIR.ON when
> sending posted interrupts. X86 spec actually allows this.
> 
> The second problem is that unlilke KVM, which mostly ignores them,
> windows depends on accurate delivery of the posted notification
> interrupts, and currently it is possible for a posted notification
> to get lost it it arrives at the same time as the nested VM exit.
> 
> V2: to avoid spurious notification in L1, process the posted
> notification in L2, just before VM exit.
> 
> PS: I am not 100% sure if I got the barriers right, plus I am not sure
> about what to do if vmx_complete_nested_posted_interrupt can't write
> to the nested PIR, in this it calls kvm_handle_memory_failure, and
> I don't know 100% its interactions with nested VM exit.

Yeah, the first commit is fine but the barriers are still incomplete 
here.  It seems to me that it really works by chance: we're executing on 
the sending side, where there is no ordering with the setting of 
posted_intr_nv, but in real hardware the check happens during interrupt 
acknowledgement on the receiving side.

However, doing it on the sending side is the key to accelerating nested 
posted interrupts.  We need to check atomically for is_guest_mode and 
posted_intr_nv (which has 257 possible values - "-1" for disabled and 
0..255).  The pattern we are trying to use here is, in pseudocode:

	if (atomic {
		// really an xchg
		pi_active = false;
		pi_pending
	})
		complete nested PI

	--

	if (atomic {
		// really a cmpxchg loop
		pi_pending = true;
		pi_active && vector == posted_intr_nv
	})
		trigger L0's nested PI vector
	else
		set bit in IRR and KVM_REQ_EVENT // deliver to L1

(In reality, pi_pending need not be set unless pi_active is true. If 
pi_active is false, no PI is made pending because the PI vector will be 
delivered to L1).

This means the current code is missing two bits:

- pi_hw_delivered (now covered albeit incorrectly by is_guest_mode) and 
pi_pending must be accessed atomically;

- in the current code all this is enclosed in a check for the *remote* 
posted_intr_nv which is completely wrong, because there's no way to make 
those reads not racy.

This means adding a cmpxchg-based state machine that includes 
pi_hw_delivered, pi_pending, and the vector; which in turn means 
promoting guest_mode from being just a bit (HF_GUEST_MASK) to an int:

#define KVM_NESTED_PI_VECTOR_MASK	0xFF
#define KVM_NESTED_IN_GUEST		BIT(8)
#define KVM_NESTED_PI_ACTIVE		BIT(9)
#define KVM_NESTED_PI_PENDING		BIT(10)

void enter_guest_mode(struct kvm_vcpu *vcpu);
int leave_guest_mode(struct kvm_vcpu *vcpu);
/* not vmx specific anymore, move to irq.c (!) */
int kvm_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
					int vector);



On vmentry you can publish the state as soon as you've committed to not 
fail:

	/* which does
	 *   atomic_set(&arch.nested_guest_state, KVM_NESTED_IN_GUEST);
	 */
	enter_guest_mode(vcpu);

	...

	if (from_vmentry) {
		...
		/* and another copy of this in
		 * vmx_get_nested_state_pages(), called if
		 * nested_get_vmcs12_pages() succeeds, so maybe this
		 * must be a separate function */
		if (nested_cpu_has_posted_intr(vmcs12))
			atomic_or(
			   KVM_NESTED_PI_ACTIVE |
			   (vmcs12->posted_intr_nv &
			    KVM_NESTED_PI_VECTOR_MASK),
			   &vcpu->arch.nested_guest_state);
	} else {
		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
	}

	vmx_complete_nested_posted_interrupt();

On nested vmexit:

	/*
	 * clear PI_ACTIVE to block nested posted interrupt delivery,
	 * and take one last opportunity to read KVM_NESTED_PI_PENDING.
	 *
	 * leave_guest_mode does
	 *	atomic_xchg(&vcpu->arch.nested_guest_state, 0);
	 */
	old = leave_guest_mode(vcpu);
	__vmx_complete_nested_posted_interrupt(vcpu, old);

	/*
	 * only one read is enough - after it, the sender vCPU is
	 * guaranteed to not see PI_ACTIVE after the cmpxchg() loop,
	 * making it fall back to delivery via LAPIC
	 */

And __vmx_complete_nested_posted_interrupt checks and clears 
KVM_NESTED_PI_PENDING:

	/* write other bits of state before reading pi_pending */
	if (!(old & KVM_NESTED_PI_PENDING))
		return 0;

	if (!vmx->nested.pi_desc)
		goto mmio_needed;

	atomic_andnot(KVM_NESTED_PI_PENDING,
		      &vcpu->arch.nested_guest_state);

vmx_complete_nested_posted_interrupt is a simple wrapper for the __ version:

	/* write other bits of state before reading pi_pending */
	smp_mb();
	return __vmx_complete_nested_posted_interrupt(vcpu,
		atomic_read(&vcpu->arch.nested_guest_state));


And to deliver:

for (;;) {
	old = atomic_read(&vcpu->arch.nested_guest_state);
	if ((old & (KVM_NESTED_PI_ACTIVE | KVM_NESTED_PI_VECTOR_MASK))
	     != (KVM_NESTED_PI_ACTIVE | vector))
		return -1;

	WARN_ON_ONCE(!(old & KVM_NESTED_IN_GUEST));
	if (atomic_try_cmpxchg(&vcpu->arch.nested_guest_state, &old,
			       old | KVM_NESTED_PI_PENDING))
		break;
}

kvm_make_request(KVM_REQ_EVENT, vcpu);
smp_mb__after_atomic();
kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_NESTED_VECTOR);


Paolo

