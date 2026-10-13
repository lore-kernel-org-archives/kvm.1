Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC64B55295C
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925622; cv=none; b=axK8WRwm5arkPf/K9DltxHW3if9U1W20Q2RYj4718Fel3vNryCRtb6HIolrcm8IlU/H837pOjuKaQsRwUVuYUBbkyhBC+LRKAgvQjm7E+MpjRD/n0ezlTB1PCBbyJ6ibgbXNhBfSZ0Jdb9dIaE1AGk6a/sJoQ12k4zHXeyMs5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925622; c=relaxed/simple;
	bh=0qEeRvKHfFMFKujpy7sq/LlNpcUeXbYQJpPr7aQU56U=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=QQJ/CmAHeEUqbFPhTOUTkVL9117reEwBMMF4KFL27sedZWlvALUb1hI2ZwoQshCVNw61HotSZJu9gi1ZQYaYN22RKPoAm8NsBGoR2Dr4zniNLUFZ9Xzcxt6jMKUI7gav5IDEItn/Xxpe8d9rWn1mQwWNDbPIVIGX4z3C/p9h9dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9poWutR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9poWutR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375941F000FF;
	Tue, 13 Oct 2026 21:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791925619;
	bh=SQCY8//4gZm0pXjBAr/HgSyFRhsCc/Nv3VCXuTg7DQc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=C9poWutRiET8rgQu/tEGeAmgb26owprc64s9+pS+0HoSedc004vdJ8157hL8c+WnA
	 NzOAzX1GD6tac/n/X4AbmNOHVqpL0iY6h6UB1GPv3gZZG2Ztzgiv107J7xAkcBgdFV
	 s6H6fR/tiI7YEtYbj/QCrnHzDzsqHnoh3EYyN1dmm8dmgTkF4LlEdGnahGFvT1XZSp
	 Ae53oyHjzjwytTbf02ZYa3lGS5zqt9NZk9F+PlzkaH0exKVK+xJEy9mKPhYwGgi1bM
	 p3gNduxiTB61ml48twseHe8/J4nPtrQmCKQgrq+9rDMqQufHfCWVoYIOqO4qqLEbTN
	 Q82w65XXh5VTQ==
Message-ID: <sashiko-outbox-170511@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] KVM: x86/xen: Don't lose the timer event when
 delivery fails transiently
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261013204824.454208-5-dwmw2@infradead.org>
References: <20261013204824.454208-1-dwmw2@infradead.org>
 <20261013204824.454208-5-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 21:06:58 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: x86/xen: infinite vcpu loop when shared_info deactivated
--

commit 51f8b9d346d917ad2de67baf6af85e344406d8e0
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86/xen: Don't lose the timer event when delivery fails transiently

This commit modifies KVM's Xen timer injection to handle transient failures
from kvm_xen_set_evtchn(). If the event channel set fails with -EAGAIN
or -EINVAL, it leaves the timer_pending flag set so the delivery can be
retried on the next entry pass.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -106,13 +106,23 @@ void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcp=
u)
>  {
>  	if (atomic_read(&vcpu->arch.xen.timer_pending) > 0) {
>  		struct kvm_xen_evtchn e;
> +		int rc;
> =20
>  		e.vcpu_id =3D vcpu->vcpu_id;
>  		e.vcpu_idx =3D vcpu->vcpu_idx;
>  		e.port =3D vcpu->arch.xen.timer_virq;
>  		e.priority =3D KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
> =20
> -		kvm_xen_set_evtchn(&e, vcpu->kvm);
> +		rc =3D kvm_xen_set_evtchn(&e, vcpu->kvm);
> +
> +		/*
> +		 * Deliberately leave timer_pending set if the memslot is
> +		 * being updated (-EAGAIN) or the shared_info cache has
> +		 * been deactivated (-EINVAL); delivery is retried on the
> +		 * next entry pass.
> +		 */
> +		if (rc =3D=3D -EAGAIN || rc =3D=3D -EINVAL)
> +			return;

[Severity: High]
Does this early return cause an infinite loop in the vCPU run loop if the
shared_info cache is deactivated by userspace and returns -EINVAL?

When the vCPU attempts to halt, kvm_vcpu_check_block() evaluates
kvm_cpu_has_pending_timer(), which returns true because timer_pending is
still > 0. This aborts the block, immediately returning to vcpu_block().

However, vcpu_block() then checks kvm_arch_vcpu_runnable(), which does not
consider timer_pending, so it evaluates to false. This causes vcpu_block()
to return 1, forcing the vcpu_run() loop to spin indefinitely without
breaking, sleeping, or entering the guest:

virt/kvm/kvm_main.c:kvm_vcpu_check_block() {
    ...
    if (kvm_cpu_has_pending_timer(vcpu))
        goto out;
    ...
}

arch/x86/kvm/x86.c:vcpu_block() {
    ...
    if (!kvm_arch_vcpu_runnable(vcpu))
        return 1;
    ...
}

arch/x86/kvm/x86.c:vcpu_run() {
    for (;;) {
        if (kvm_vcpu_running(vcpu)) {
            r =3D vcpu_enter_guest(vcpu);
        } else {
            r =3D vcpu_block(vcpu);
        }

        if (r <=3D 0)
            break;
        ...
    }
}

With r being 1, the loop unconditionally retries, hits -EINVAL again, and
spins monopolizing the host CPU until the cache is reactivated. Could we
avoid this stall by either dropping the event or handling the sleep abort
differently when shared_info is unavailable?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013204824.4542=
08-1-dwmw2@infradead.org?part=3D4
