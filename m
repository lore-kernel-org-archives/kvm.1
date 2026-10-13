Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C216C3B14C8
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791926240; cv=none; b=b6p4WeVd4sBfuwji8ZGYOKRqS1fs2SK2Lbe1PlH/IfR7drKgY26A6TQwDQBaFK+vPxna1D7ebn+EvyQ42DQWyeVbqFEF+cXVHN0nWkqVbQgoI3PRcB15TvLetpRz9abzTScPyICLRTpG8bdJYZ2xgNRRlrSe9kBk7YRAuWeZhqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791926240; c=relaxed/simple;
	bh=fj1Z4CXVGYSwv7BH0jbGVaak4qCmJcW6RmH7IZjn6hs=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=DmzT63SuBr2XSiPlkq7YtugdxwZlmQ3xCSD1m9lfnpe/sOoeauOSX3wuLLRB2m0Zc8yJJRzXsEIJ8ccav9aux3UDXN4NiyH9GILGg9/b58Kjsx+1FMlSRIpsNsc7GJwJC3QwzFFfnWx6pycqQSmJ3/wmq6vVEXRSysLE2APMMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4alb/xe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4alb/xe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0A01F000FF;
	Tue, 13 Oct 2026 21:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791926239;
	bh=/fiTJlqE2gzYtdUjwlx5D7gHuqwfe6AtSkt50mpaMjg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=E4alb/xealB7iWzlHNKys2WQ99XTBJzG1lmWOp0lBFw1geZHlkUuBwLIISL8XdLJj
	 KRv8SBu6TcuFEsYlec4K6Up9g2Dp67v4qGUBo474LdsDeXD8MQ7ADfinVsQ6zZhCDQ
	 axdo+T+N3FGOpSnGz6iKTsbe5qW95bYI3+doR+LkEA9BN651mIwCR4yOe8Yki3VkDJ
	 N7r3PXVABDS3vnCJGMiybqEe7qDO6eDXAXj/mtqjuwg21Bc/FbkInFPs6gP0eLHBRX
	 jg7RUCSv+KFUmbCDdfrA1cex1aVZRCdUgZjSZ2jzkOkByh+0TJ0G0OBXoYwZAYD/y6
	 wDTnBHBC2LFMw==
Message-ID: <sashiko-outbox-170525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] KVM: x86/xen: Retry event channel delivery which
 races a memslot update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261013204824.454208-6-dwmw2@infradead.org>
References: <20261013204824.454208-1-dwmw2@infradead.org>
 <20261013204824.454208-6-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 21:17:18 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: infinite loop in vcpu_run due to Xen timer delivery failure
- [High] kvm: ABBA deadlock between xen_lock and kvm->srcu in KVM_XEN_HVM_S=
ET_ATTR
--

commit b27b9db29f6c5d0bc3a62af7e5baefbb8e0f7c51
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86/xen: Retry event channel delivery which races a memslot update

Event channel delivery now returns -EAGAIN when it races a memslot
update. It always failed; now the failure is distinguishable, and
instead of dropping the event each caller reacts according to its
context.

Closes: https://lore.kernel.org/all/20260920215341.5ECE91F000FF@smtp.kernel=
.org

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index aea6572163d0c..ad7708be6c049 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -113,7 +114,7 @@ void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
>  		e.port =3D vcpu->arch.xen.timer_virq;
>  		e.priority =3D KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
> =20
> -		rc =3D kvm_xen_set_evtchn(&e, vcpu->kvm);
> +		rc =3D kvm_xen_set_evtchn(&e, vcpu->kvm, wait);
> =20
>  		/*
>  		 * Deliberately leave timer_pending set if the memslot is

[Severity: High]
Does this code cause an infinite loop in vcpu_run() due to the Xen timer
delivery failure?

If rc is -EAGAIN or -EINVAL, timer_pending remains set. A set
timer_pending causes block attempts to instantly abort:

virt/kvm/kvm_main.c:kvm_vcpu_check_block() {
    ...
	if (kvm_cpu_has_pending_timer(vcpu))
		goto out;
	if (signal_pending(current))
		goto out;
    ...
}

Because the block is aborted and kvm_vcpu_has_events() evaluates to false
(as it does not check timer_pending), the vCPU's mp_state remains halted.

This forces vcpu_run() into an infinite retry loop on the host core
without entering the guest:

arch/x86/kvm/x86.c:vcpu_run() {
    ...
		if (kvm_vcpu_running(vcpu)) {
			r =3D vcpu_enter_guest(vcpu);
		} else {
			r =3D vcpu_block(vcpu);
		}

		if (r <=3D 0)
			break;

		kvm_clear_request(KVM_REQ_UNBLOCK, vcpu);
		...
		if (kvm_cpu_has_pending_timer(vcpu))
			kvm_inject_pending_timer_irqs(vcpu);
    ...
}

[ ... ]

> @@ -2020,16 +2036,13 @@ static int kvm_xen_set_evtchn(struct kvm_xen_evtc=
hn *xe, struct kvm *kvm)
>  	 */
>  	do {
>  		struct gfn_to_pfn_cache *gpc =3D &kvm->arch.xen.shinfo_cache;
> -		int idx;
> =20
>  		rc =3D kvm_xen_set_evtchn_fast(xe, kvm);
>  		if (rc !=3D -EWOULDBLOCK)
>  			break;
> =20
> -		idx =3D srcu_read_lock(&kvm->srcu);
> -		rc =3D kvm_gpc_refresh(gpc, PAGE_SIZE, false);
> -		srcu_read_unlock(&kvm->srcu, idx);
> -	} while(!rc);
> +		rc =3D kvm_gpc_refresh(gpc, PAGE_SIZE, wait);
> +	} while (!rc);
> =20
>  	if (mm_borrowed)
>  		kthread_unuse_mm(kvm->mm);

[Severity: High]
Can this cause a deadlock between xen_lock and kvm->srcu?

The SET_ATTR ioctl for LONG_MODE acquires xen_lock and calls
kvm_xen_shared_info_init() with wait=3Dtrue:

arch/x86/kvm/xen.c:kvm_xen_hvm_set_attr() {
    mutex_lock(&kvm->arch.xen.xen_lock);
    ...
    r =3D kvm->arch.xen.shinfo_cache.active ?
        kvm_xen_shared_info_init(kvm, true) : 0;
    mutex_unlock(&kvm->arch.xen.xen_lock);
}

This causes it to sleep waiting for memslot updates while holding
xen_lock.

Meanwhile, a vCPU running in guest mode (holding kvm->srcu read lock)
can block trying to acquire xen_lock in kvm_xen_write_hypercall_page():

arch/x86/kvm/xen.c:kvm_xen_write_hypercall_page() {
    mutex_lock(&kvm->arch.xen.xen_lock);
}

This prevents synchronize_srcu() in the memslot update from completing,
resulting in an ABBA deadlock.

The SHARED_INFO case similarly acquires xen_lock and explicitly loops in
kvm_gpc_activate() and kvm_gpc_refresh() with wait=3Dtrue while holding
the lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013204824.4542=
08-1-dwmw2@infradead.org?part=3D5
