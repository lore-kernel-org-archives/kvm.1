Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A8B38DC68
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163518; cv=none; b=AhgkA8Y2NPrqRU60bc5FdGVyzV0KQuFsnY4dm81lgasAdPH4szToHv4zqOtFW3fCeBQftbaAeQYG0xvnIv5ex8SrT0i2ySR87cgx9PLrV3DtN3LgMNxPp8onArvNlHCdCoRQZNrXTFALfYzFt85r4A3IF87S1Z+yIF+cExiymRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163518; c=relaxed/simple;
	bh=gv1sJzOZ1isVWd8Pgd3Ox0+eJUKTUyBcaBHy7w/W/c8=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=M2FUMXsgbeWoyaRVZ5tc684XrG9ZpNk2iGPiJCdMrxLJt4FivT7Y2MxSWtbp2dFbflQbdDouvLv6jt8NPDcPYYiFQFt4MXGg53YqXhhvE75/bLefh5PZAWm+lYrdAElNYuQGQFelW06LJCnbCHk7fsQCccvX+Y728iNmxBXNaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSb+3x+E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSb+3x+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2E31F000C4;
	Fri, 16 Oct 2026 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792163517;
	bh=fM61Rr+G9NmLcfUJc+skPO78rduTQZ22ztlq3uQMjYY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NSb+3x+Eu+9yjnNfhLEJnhKh5yRLLL+a6NH4Dqo4tiseHZZODUu+B6YGgTpyctyjN
	 3WESlR+HafmpU/05Fu/ki/mZ+DvBKIncGRFFDHbAlZlUawdRDwPCipXOyWEq/t6qcy
	 HHQflp34tXjqyq2ODtFXw1V7Glg0sBd7wctiCBQOBvb7Ey24v3zjKEMvscPWq3xnfx
	 4yJTGdV4O4rthHnRTlQrUlyDPfbTJeCZycePAXtQ4AqaEAX5zipd5vWTRh8fdKlcG3
	 6X4coaBZsyHQHOS36rZXOb22SKarsJgYX+F6UFO7eGBnJyroOQWB/D8ngeiuIAiSVZ
	 lP0kAOKuJ8mPQ==
Message-ID: <sashiko-outbox-174536@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/11] KVM: x86/xen: Retry event channel delivery
 which races a memslot update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261016145646.579369-6-dwmw2@infradead.org>
References: <20261016145646.579369-1-dwmw2@infradead.org>
 <20261016145646.579369-6-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 15:11:56 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm/xen: guest hang due to lost/delayed timer interrupt on memslot=
 update
--

commit 8954ef8936e60acd6079cac417ec4cbf08881487
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86/xen: Retry event channel delivery which races a memslot update

This commit modifies event channel delivery to return -EAGAIN when racing
with a memslot update, allowing callers to handle the retry according to
their context.

Closes: https://lore.kernel.org/all/20260920215341.5ECE91F000FF@smtp.kernel=
.org

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 0ef646cf3990b..6b7532b0e26ab 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
[ ... ]
> @@ -135,7 +136,7 @@ void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
>  		e.port =3D vcpu->arch.xen.timer_virq;
>  		e.priority =3D KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
> =20
> -		rc =3D kvm_xen_set_evtchn(&e, vcpu->kvm);
> +		rc =3D kvm_xen_set_evtchn(&e, vcpu->kvm, false);
> =20
>  		/*
>  		 * Leave timer_pending set if the memslot is being updated
>  		 * (-EAGAIN); delivery is retried on the next entry pass.
>  		 */
>  		if (rc =3D=3D -EAGAIN)
>  			return;

[Severity: High]
Does this early return fail to set a KVM request to abort guest entry?

When kvm_xen_set_evtchn() returns -EAGAIN due to a memslot update race,
returning here leaves timer_pending > 0 but KVM's entry path
(vcpu_enter_guest) will see no pending requests or injectable interrupts.

Because the host hrtimer has already expired and will not restart, could th=
is
cause the vCPU to enter the guest without the timer interrupt and run
indefinitely until an unrelated VM-exit occurs?

For context, this caller is at the end of the vcpu_run() loop:

arch/x86/kvm/x86.c:vcpu_run() {
    ...
    if (kvm_cpu_has_pending_timer(vcpu))
        kvm_inject_pending_timer_irqs(vcpu);
    ...
}

If injection fails here without setting a request like
kvm_make_request(KVM_REQ_EVENT, vcpu), won't the next loop iteration call
vcpu_enter_guest() and enter the guest without scheduling an immediate retr=
y?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016145646.5793=
69-1-dwmw2@infradead.org?part=3D5
