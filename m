Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn [202.108.3.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F829D26B
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097312; cv=none; b=NPGsrq2c0nOLLDsaAwowFsrLRwnjtlhFLPSlviCass6L2Ts9XDINIOiHoGlqVORtvXAx+owvEp1ZR/ZHTwV9qNARjwYZV1k5Bhz2e89lmwdALunggtl9IC2zFzsX+k/Az5Mx1FnwL0TLlx39jKLj4oALfvMUMoS9pOl8he5NoQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097312; c=relaxed/simple;
	bh=Rl+W9skjklZSKAy2nJnxKCrdbEChQn6otMV1lFgvbck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJ1ckhvyPjnIPPjGulw92vaw+7/kzDycuAcMPgiuH3x4C77jOTlGyv4J00GDRZ6N75o8ctvE+FAZIrNml0b1Cj01pWKDQDXDIxm07+eGjfHGY4Yz7LsVvuCv8xBkd0V3bWsHNN57QpQvfvedCJx4tHKo1phDBI8Gg/wA89+Kj/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=U2ismIyY; arc=none smtp.client-ip=202.108.3.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="U2ismIyY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1780097309;
	bh=n5sSodDIv/OV6YYRYNNj3koRSJ2lm8111tQ+HkU1Mo4=;
	h=From:Subject:Date:Message-ID;
	b=U2ismIyYzqhfC0n40BsN+57Tr5MTAvAybk0zVB7tlA4pBK6P24CjOW6oMif+Mrui/
	 qeb6trfae022GIV8UPVaJbtA939PflNtcyuOTi3eM7wEYFNUjqenFeFRcXrx05Y8QI
	 aykzXOG/2dznvhSymppjvbGZToUHbcE9R6KhH+1A=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 6A1A211500007336; Fri, 30 May 2026 07:28:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8669136685212
X-SMAIL-UIID: 6002447360684DBD866C4BDAC9C55CD2-20260530-072823-1
From: Hillf Danton <hdanton@sina.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun@kernel.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	Carsten Stollmaier <stollmc@amazon.com>
Subject: Re: [PATCH v2 02/20] KVM: x86/xen: Use read_trylock() for GPC locks in hardirq/atomic paths
Date: Sat, 30 May 2026 07:28:06 +0800
Message-ID: <20260529232812.1254-1-hdanton@sina.com>
In-Reply-To: <20260529165114.748639-3-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 29 May 2026 09:50:56 -0700 Sean Christopherson wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> kvm_xen_set_evtchn_fast() is called from hardirq context (timer
> callback, kvm_arch_set_irq_inatomic()). On PREEMPT_RT, rwlock_t is a
> sleeping lock, so read_lock_irqsave() cannot be used in this context.
> 
> Switch to read_trylock() and return -EWOULDBLOCK on contention, which is
> the designed fallback — there is always a slow path for the case where
> the GPC is invalid and needs to be refreshed.
> 
> Reported-by: syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=208f7f3e5f59c11aeb90
> Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/xen.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 91fd3673c09a..9bdb8e3cad58 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -697,6 +697,7 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
>  int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
>  {
>  	struct gfn_to_pfn_cache *gpc = &v->arch.xen.vcpu_info_cache;
> +	bool atomic = in_atomic() || !task_is_running(current);
>  	unsigned long flags;
>  	u8 rc = 0;
>  
> @@ -713,7 +714,15 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
>  	BUILD_BUG_ON(sizeof(rc) !=
>  		     sizeof_field(struct compat_vcpu_info, evtchn_upcall_pending));
>  
> -	read_lock_irqsave(&gpc->lock, flags);
> +	if (atomic) {
> +		local_irq_save(flags);
> +		if (!read_trylock(&gpc->lock)) {
> +			local_irq_restore(flags);
> +			return 1;
> +		}
> +	} else {
> +		read_lock_irqsave(&gpc->lock, flags);
> +	}
>  	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
>  		read_unlock_irqrestore(&gpc->lock, flags);
>  
I suspect this works given

static __always_inline void read_unlock_irqrestore(rwlock_t *rwlock,
						   unsigned long flags)
	__releases_shared(rwlock)
{
	rt_read_unlock(rwlock);
}
