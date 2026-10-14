Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734943303E
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016446; cv=none; b=R8VHMAaBJ3B33rF7vFKuSSWEFthhpbIP8R0fhTQLadzfjUXMSsH1a6X+WuAE/ZuSq3IDOE9vQRPRfPuflg+1vOo4Px3XihzVPsOboYvTilU5njCbg1lIKx/UMCW3YhUZrSEtVB4RaJ56jeA/k8jGFRzN2YX5+yX0UyOWUySwirI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016446; c=relaxed/simple;
	bh=Tb6m1dGhVznj+lEOtmWHRLe0oT39aIbMlBY2iWKuwMA=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=cLaC2kmWXNhMkyOBGChPgmN3qShmpWWihaO+BYKw8cUwVaQKZ1FhGcQEvWdvF7swmcfOQ3p7v5I6lH1MLHfsGQQsPqcBPtY+sobE0u6mAwvcaszqTmpIRkTEhCLj2RYwpCK35gghsIi0WjGWC8DDvnGQupGeX4kJFyWHd2Oryms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL+GS0Rx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL+GS0Rx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9941F000C4;
	Wed, 14 Oct 2026 22:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792016444;
	bh=UYXSzX2ITMb/gUSaD0w0PhLe6rV2G9xaceslPXYQSCg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RL+GS0RxjkLVJrMydiDSmRL8lz/Fr3cSRSV4X8VS90Cm7dnVe6r6Bl/Z5fvoqcZUF
	 XU0Zig+/DRscv1l94z/RoOoKEgRLq0yUMxt1TT/SJeUFo6ch1dLTkR9kUkLUMhjxVI
	 N7TPqOEVjN5vilEzoHIuf9/kZ0g57+nawFUwNRy2eyW142/HRGAfcLQf5dbPd9CUHV
	 5jPt8HrNaZOEEm+USl2z4tl7NtoSnS1tAMkihEuokpGG5tbomp+G6Ob7OK6bUiW6Bf
	 nMdmwhhh2cMbePmvhql4QWBkP8WFsaX/+GHTmjqPJCy7GROn+VnIQGIExuLrisf8JM
	 gI5eBV0vBlf1w==
Message-ID: <sashiko-outbox-171965@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] KVM: x86/xen: Retry event channel delivery
 which races a memslot update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261014220508.518772-7-dwmw2@infradead.org>
References: <20261014220508.518772-1-dwmw2@infradead.org>
 <20261014220508.518772-7-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 22:20:44 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: host DoS via userspace-reachable WARN_ON_ONCE in kvm_xen_set_=
evtchn
- [Medium] kvm: xen: guest #GP on hypercall page WRMSR racing with memslot =
update
--

commit 1bad660e92709c34e97084491648f1684e74aada
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86/xen: Retry event channel delivery which races a memslot update

Event channel delivery now returns -EAGAIN when it races a memslot
update. It always failed; now the failure is distinguishable, and
instead of dropping the event each caller reacts according to its
context.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260920215341.5ECE91F000FF@smtp.kernel=
.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM

> Event channel delivery now returns -EAGAIN when it races a memslot
> update. It always failed; now the failure is distinguishable, and
> instead of dropping the event each caller reacts according to its
> context:

[Severity: Medium]
Will this newly distinguishable -EAGAIN error cause a guest #GP on hypercall
page WRMSR racing with a memslot update?

In arch/x86/kvm/xen.c:kvm_xen_write_hypercall_page(), the guest executes
WRMSR to set up the Xen hypercall page, which runs under the vCPU's
kvm->srcu read lock. If the guest's 32/64-bit mode changed, it attempts to
re-initialize the shared_info page:

	if (kvm->arch.xen.long_mode !=3D lm) {
		kvm->arch.xen.long_mode =3D lm;

		/*
		 * Re-initialize shared_info to put the wallclock in the
		 * correct place.
		 */
		if (kvm->arch.xen.shinfo_cache.active &&
		    kvm_xen_shared_info_init(kvm, false))
			r =3D 1;
	}

Because wait=3Dfalse is explicitly passed to avoid deadlocking srcu,
kvm_xen_shared_info_init returns -EAGAIN if it races with a concurrent
host memslot update.

kvm_xen_write_hypercall_page treats any non-zero return (including the
newly distinguishable -EAGAIN transient error) as a failure by setting
r =3D 1 and returning it. kvm_set_msr_common receives this 1 and incorrectly
injects a #GP into the guest, crashing the guest purely due to a transient
host-side memslot update.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index f1be9022bc6fe..a88f571e8682b 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c

[ ... ]

> @@ -2076,7 +2088,7 @@ static int evtchn_set_fn(struct kvm_kernel_irq_rout=
ing_entry *e, struct kvm *kvm
>  	if (!level)
>  		return -EINVAL;
> =20
> -	return kvm_xen_set_evtchn(&e->xen_evtchn, kvm);
> +	return kvm_xen_set_evtchn(&e->xen_evtchn, kvm, true);
>  }

[Severity: High]
Does this expose a host denial of service to unprivileged userspace threads?

An unprivileged userspace process can create a KVM VM and set up an IRQ
routing entry for a Xen event channel using KVM_SET_GSI_ROUTING. The process
then forks, passing the VM file descriptor to the child process, which now
runs with a different mm (current->mm !=3D kvm->mm).

The child process can issue a KVM_IRQ_LINE ioctl on the VM fd, which invokes
evtchn_set_fn() and subsequently kvm_xen_set_evtchn().

In kvm_xen_set_evtchn():

	if (current->mm !=3D kvm->mm) {
		/*
		 * If not on a thread which already belongs to this KVM,
		 * we'd better be in the irqfd workqueue.
		 */
		if (WARN_ON_ONCE(current->mm))
			return -EINVAL;

Because current->mm !=3D kvm->mm and the child process is a userspace thread
(current->mm !=3D NULL), the WARN_ON_ONCE(current->mm) condition evaluates =
to
true. On systems configured with panic_on_warn, this allows an unprivileged
user to crash the host kernel.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014220508.5187=
72-1-dwmw2@infradead.org?part=3D6
