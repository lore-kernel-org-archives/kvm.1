Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427876;
	b=d77lSDdHehN7PYovv/pZ+UhNAwiaZHcX71EUlqu6hozcQoDzIa/6AaSad0Rt+SXKDQjZ
	 8VNwI6FIgwr/NUwokLnoBkQ8XCL+N7ufU8XDpRFHHY6x0b29UX5RDs67kvaQsJqGp7uCY
	 fycrsKpiYIg1vdkTZS5scwPFVImZfTpe5k3Ivoqg8DsAYRzFdyGBJwN77UGgKKgS2j+Ba
	 2DHKKUprLdvuj3P2rX+GDI3woU6H+b59piM80Q/kRyJYUO6LACAO4KXdvbLJ5pC4aN3fi
	 DxW3OVpBivCqAFCNs8xtBWySR/+IYnczD+vegTlCtzXtxAIZ7NXVh/4rfXvx0bRSyEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427876;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d7xaX7hCY1972zWgjm6APbbD9KvdqNbRAR3p/8Ax3PU=;
	b=Iy0apff4N/jU6FN+Ll07R3RPrf7pFQNqGU5V/KNjqUyu8x+NVpAsjHAaqL23fiKUiMZO
	 P/Htb3/UWa0NqwElsF6o5/5lpACbAe5518FQpXfQlpgRktTc7y/VPGwUQiHIDRVGHfQ3R
	 Gou1pSJAi1joCekf+bKJMXtOq0vmt03Psj1gW6qQ6huw954pQmIckF/q9TZv2lELqc7Qo
	 SJUEx/03azx0aFCyxudn11MNZ9BsMwC/NdJJoTZs+ANiZWISI2Rolcob9sI8utPHwnUde
	 Um/PdyzoHDNAZ43mbNmXDXCuGoka/D4NXVa64cWFF9Q1LOaNpPNg6RqwpBWKUJ9yfNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEeWfLA7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77483606A31E
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEeWfLA7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36E71F000C5;
	Mon, 19 Oct 2026 16:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427876;
	bh=d7xaX7hCY1972zWgjm6APbbD9KvdqNbRAR3p/8Ax3PU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QEeWfLA7oX6Bpn8t9ldetUBnFoXn0hwzoBrtx9Hehs3f0c2h83jrru+7fYCk6vqXb
	 +QCsXAL6GFDxl0plmY6qO1ot7wnoKpsiFayN63KeacLHOyJKqAQaQRZGtY80MuTSgQ
	 VYQNq/9WyOnsNqeQLMyclDyvV+U406uwSMTGhZ7NZKHTcV3/z0eOlr8VodSx/7vAAD
	 pBW6X15J0fgpiSNIOSp8gLa+j59yn0n7fVUe6lL6bT3Ddv37rf0a3IFaIuFlPhy3AT
	 /acrQkn6yJ0mDgrLNZ0c1uUK1fPW2jfJQvVqE95t21iZ051ix4XWXYXRMVB8eAkdPZ
	 awWR++yObyUhg==
Message-ID: <sashiko-outbox-177923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/12] KVM: x86/xen: Retry event channel delivery
 which races a memslot update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261019162445.37219-7-dwmw2@infradead.org>
References: <20261019162445.37219-1-dwmw2@infradead.org>
 <20261019162445.37219-7-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:37:55 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM: x86/xen: 3-way deadlock via wait=3Dtrue in evtchn_set_fn() fr=
om PIT worker
--

commit deb1cf394d02a7487c9bd0713d5fed7a4be72540
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86/xen: Retry event channel delivery which races a memslot update

This commit updates Xen event channel delivery callers to handle -EAGAIN
when delivery races with a memslot update, either waiting for the update
to complete or retrying depending on the execution context.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 8a9d6963fc05a..c0b9ac674255d 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c

[ ... ]

> @@ -2153,7 +2165,7 @@ static int evtchn_set_fn(struct kvm_kernel_irq_rout=
ing_entry *e, struct kvm *kvm
>  	if (!level)
>  		return -EINVAL;
> =20
> -	return kvm_xen_set_evtchn(&e->xen_evtchn, kvm);
> +	return kvm_xen_set_evtchn(&e->xen_evtchn, kvm, true);
>  }

[Severity: High]
Can passing wait=3Dtrue unconditionally in evtchn_set_fn() cause a 3-way
deadlock when GSI 0 is routed to KVM_IRQ_ROUTING_XEN_EVTCHN and the
in-kernel PIT is active?

evtchn_set_fn() is the .set callback invoked by kvm_set_irq(). In addition
to the irqfd workqueue, pit_do_work() in arch/x86/kvm/i8254.c runs on the
pit->worker kthread and fires GSI 0:

arch/x86/kvm/i8254.c:pit_do_work() {
    ...
    kvm_set_irq(kvm, KVM_PIT_IRQ_SOURCE_ID, 0, 1, false);
    kvm_set_irq(kvm, KVM_PIT_IRQ_SOURCE_ID, 0, 0, false);
    ...
}

Because pit->worker is a kthread with current->mm =3D=3D NULL,
kvm_xen_set_evtchn() borrows kvm->mm via kthread_use_mm() and calls
kvm_gpc_refresh(gpc, PAGE_SIZE, true).

If a memslot move or deletion is concurrently updating the memslot backing
shinfo_cache, kvm_invalidate_memslot() -> kvm_swap_active_memslots() marks
the slot KVM_MEMSLOT_INVALID and blocks in
synchronize_srcu_expedited(&kvm->srcu).

If a vCPU thread inside vcpu_run()'s kvm->srcu read section concurrently
emulates a guest PIO write to PIT ports 0x40-0x43, pit_ioport_write() ->
pit_load_count() calls create_pit_timer() or destroy_pit_timer(), both of
which flush pit->expired while holding kvm->srcu:

arch/x86/kvm/i8254.c:create_pit_timer() {
    ...
    hrtimer_cancel(&ps->timer);
    kthread_flush_work(&pit->expired);
    ...
}

At that point:
1. The memslot update thread waits for the vCPU thread to exit its
   kvm->srcu read section.
2. The vCPU thread holds kvm->srcu and waits in
   kthread_flush_work(&pit->expired) for pit_do_work() to finish.
3. pit_do_work() loops in kvm_gpc_refresh(..., wait=3Dtrue) on -EAGAIN
   waiting for the memslot update to finish, and because pit->worker is a
   kthread, fatal_signal_pending(current) never triggers.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019162445.3721=
9-1-dwmw2@infradead.org?part=3D6
