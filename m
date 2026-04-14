Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1793E63AD
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182825; cv=none; b=pF1AkXnsP5/bEHSG7ZkRBiRnqMEiCzEX8M6Gd+WuzUXCyI8dwXYvtMwrSuaW5dfXc+g7Rdj+k5p6oStpCnwcy9Vs21RRSCnHs9Cd8YOM70slHjwoSC90bbyzV33PkKflmu/gTpZLXWD3yIfoaJqNPK6OSwqzFqEVWjGf3JNpHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182825; c=relaxed/simple;
	bh=lEQK7JWYV4WicYmNZU2oREZDVMl7GM6283KVoRfLyJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2DNBGVoyT0ZT8KsvsT9OCGCf+9lJKW9rJwGhy1K1pwoUUsn7ByJDH4K21kPtOPpNDMn5KblOiDL85w5XZnTCEj0SqPbuOwdEqTQeHnGpgrpI48Cn0iffQTiJhi8/jDuWzOaBg2k1TPuxdaAgscP3D8aigG9zwYLln/7G5FT/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XtQgltgD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtQgltgD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776182823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uK7gbMpl8AIqPCO4mRMWf6l0t7YnH/JZl4dGQhVD03M=;
	b=XtQgltgDDAZULUDFHfb/plBJq2CcHUKuVdJwHp6etx+YINRcj5VRIz8letduv9bxy4XjBq
	7U6izAin484/MFaZsBxLXZ/ZrkMqSnS15kOQ3iarbiJSYjuHDkXbLQ+cKkjZ6qETJpcGj+
	XdDmZsh1PEwCPOhmpSWLcsWljk6Ta4w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-DNZyHChtOES9cj6LRiUoxA-1; Tue,
 14 Apr 2026 12:07:01 -0400
X-MC-Unique: DNZyHChtOES9cj6LRiUoxA-1
X-Mimecast-MFC-AGG-ID: DNZyHChtOES9cj6LRiUoxA_1776182819
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0983B1801323;
	Tue, 14 Apr 2026 16:06:59 +0000 (UTC)
Received: from [10.32.181.49] (unknown [10.32.181.49])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A1EC195608E;
	Tue, 14 Apr 2026 16:06:56 +0000 (UTC)
Message-ID: <cb458ee1-e0c7-43e2-83a0-9effd9a723af@redhat.com>
Date: Tue, 14 Apr 2026 18:06:54 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: Drop kvm_vcpu.ready to squash race where "ready" can
 get stuck "true"
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhanghao <zhanghao1@kylinos.cn>, Wanpeng Li <kernellwp@gmail.com>
References: <20260409213333.1995382-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260409213333.1995382-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 4/9/26 23:33, Sean Christopherson wrote:
> +static inline bool kvm_vcpu_is_runnable_and_scheduled_out(struct kvm_vcpu *vcpu)
> +{
> +	return READ_ONCE(vcpu->preempted) ||
> +	       (READ_ONCE(vcpu->scheduled_out) &&
> +		READ_ONCE(vcpu->wants_to_run) &&

wants_to_run doesn't seem important here, because blocking will never be 
set outside KVM_RUN (unlike scheduled_out which can be set within any 
vcpu_load/vcpu_put pair, if you're unlucky enough).

> +		READ_ONCE(vcpu->stat.generic.blocking) &&
> +		!kvm_vcpu_is_blocking(vcpu));

If you get here you have done the finish_rcuwait() in kvm_vcpu_block(), 
meaning that you've been already scheduled in, haven't you?  So, you 
would need something like this:

static inline bool kvm_vcpu_is_runnable_and_scheduled_out(struct 
kvm_vcpu *vcpu)
{
	if (READ_ONCE(vcpu->preempted))
		return true;

	if (!READ_ONCE(vcpu->scheduled_out))
		return false;
	if (!READ_ONCE(vcpu->stat.generic.blocking))
		return false;
	return rcuwait_was_woken(kvm_arch_vcpu_get_wait(vcpu));
}

// in rcuwait.h
static inline bool rcuwait_was_woken(struct rcuwait *w)
{
	guard(rcu)();
	struct task_struct *t = rcu_access_pointer(w->task);
	return t && !task_is_runnable(t);
}

Paolo

> +}
> +
>   #ifdef __KVM_HAVE_ARCH_INTC_INITIALIZED
>   /*
>    * returns true if the virtual interrupt controller is initialized and
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 9faf70ccae7a..9f71e32daac5 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -455,7 +455,6 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
>   	kvm_vcpu_set_in_spin_loop(vcpu, false);
>   	kvm_vcpu_set_dy_eligible(vcpu, false);
>   	vcpu->preempted = false;
> -	vcpu->ready = false;
>   	preempt_notifier_init(&vcpu->preempt_notifier, &kvm_preempt_ops);
>   	vcpu->last_used_slot = NULL;
>   
> @@ -3803,7 +3802,6 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_halt);
>   bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
>   {
>   	if (__kvm_vcpu_wake_up(vcpu)) {
> -		WRITE_ONCE(vcpu->ready, true);
>   		++vcpu->stat.generic.halt_wakeup;
>   		return true;
>   	}
> @@ -4008,7 +4006,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
>   			continue;
>   
>   		vcpu = xa_load(&kvm->vcpu_array, idx);
> -		if (!READ_ONCE(vcpu->ready))
> +		if (!kvm_vcpu_is_runnable_and_scheduled_out(vcpu))
>   			continue;
>   		if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
>   			continue;
> @@ -6393,7 +6391,6 @@ static void kvm_sched_in(struct preempt_notifier *pn, int cpu)
>   	struct kvm_vcpu *vcpu = preempt_notifier_to_vcpu(pn);
>   
>   	WRITE_ONCE(vcpu->preempted, false);
> -	WRITE_ONCE(vcpu->ready, false);
>   
>   	__this_cpu_write(kvm_running_vcpu, vcpu);
>   	kvm_arch_vcpu_load(vcpu, cpu);
> @@ -6408,10 +6405,9 @@ static void kvm_sched_out(struct preempt_notifier *pn,
>   
>   	WRITE_ONCE(vcpu->scheduled_out, true);
>   
> -	if (task_is_runnable(current) && vcpu->wants_to_run) {
> +	if (task_is_runnable(current) && vcpu->wants_to_run)
>   		WRITE_ONCE(vcpu->preempted, true);
> -		WRITE_ONCE(vcpu->ready, true);
> -	}
> +
>   	kvm_arch_vcpu_put(vcpu);
>   	__this_cpu_write(kvm_running_vcpu, NULL);
>   }
> 
> base-commit: b89df297a47e641581ee67793592e5c6ae0428f4

